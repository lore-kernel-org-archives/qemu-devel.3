Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190CECDE014
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 06:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJnRF-0004Xo-6G; Fri, 14 Nov 2025 01:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vJnR7-0004WZ-DE
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 01:37:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vJnR5-0006g0-9H
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 01:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763102249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kOgkd4ED2n9/O4szBXbI+STkadMAJeeiX+MvL5j7KXA=;
 b=ROrCeDZJiuJfOoA6gj5WDRaRv9Jt9vDFcA15ZpetNcGiFXnCvv1w3BKVcY5IDdtlQZ6LU/
 A8puYdysQNmsHi1u2KHkee+6bhq2T7d2uESyivOql0nRu/wDDyEQOlHTfggo8GGW3Swlb3
 7xefpCytJ5HY6nXpcWC/wLGLbYeij2A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-l24F0RxGPia3820oUcWZsA-1; Fri, 14 Nov 2025 01:37:27 -0500
X-MC-Unique: l24F0RxGPia3820oUcWZsA-1
X-Mimecast-MFC-AGG-ID: l24F0RxGPia3820oUcWZsA_1763102246
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so775261f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 22:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763102246; x=1763707046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kOgkd4ED2n9/O4szBXbI+STkadMAJeeiX+MvL5j7KXA=;
 b=e9K9yJJC/91Ek+vRmXSoR0ciSLed0Bfs5Dbk/SVQAi6oR0+GAvl6dWYBzk6/h/c4xz
 +JC/59Oa9MehB8j0qutWn3R0WeDh3K+Y3V4KEkxsLKVdYJwQTlZUZiprt9YS2tu3bmb8
 4xUDTH4ZAKYK+wZ/WROU3r9FMIhDmcqPWJa9pwnbULLtcBEwI2Q2f2imXg2Xy221d6G+
 vq9Ow0jNgzPkGMBbrZnvjiQ/Lm+Q/qTV+V3a1ATdqBWx4ICkRICrLVnuHck/ykWg53bI
 rlOLLucvKZ67u1upEX5MOsMasqddvryjhTIEl2+ZIfGcRVCmfXufftyWr01eGMFAxd9n
 OhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763102246; x=1763707046;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOgkd4ED2n9/O4szBXbI+STkadMAJeeiX+MvL5j7KXA=;
 b=vJq61SczFZTaa+TOoFurhIY/b43DAHs3u2CQFxRU/1vHGAwHvlt36bD2CD8rh+aDqn
 8Kie9Xiab/Pj0c/VixytUlbmn8HVTEEy4QTgAQPTjFM2KJB1Tf7i5nYdS8geplUqdtrN
 sPiiccyg9T8fIpn+LyhYZ6jHckI2yc6qpwTsOn2K4QESNWNHP1BCQn223dwtt0uHmhCr
 QvoI5UCAgoaags/pBiU5fLKMI3nF81UkubOSPT368skDZWGdWvtNGjeQ9K2bwm8ulz4E
 Q5fWBqrhA2w0TF2BjwWh0j1aP8riTlXX2cZ3HI4G29nwJas3a01waRiZVPn7iXjxQAKG
 fqwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3Bmads3KOqoqno3uR1S1L1mzovM0H5b9NSEj6zhz/OkiRoTHBPtarw382kBiR0Dahp17C2ISLhPmw@nongnu.org
X-Gm-Message-State: AOJu0YxfTQTqUNFR1PmLDAHz6OhGOAsgzLXhzI/o+9Ju7l3H+v+4ckiN
 bwNK8/ON8YITgl3aKy7qFPjUBDtIvTE3mu4HTS1tpzzeVmU9BmmgKy+ZnlTUu8kPVwIB9dyS+0n
 qKnNje6MFvycvtLSjBuG/MXgD3JYYFCdvtudEQguzwMnWkpFETI8hpEui
X-Gm-Gg: ASbGncv4CqjXT5K9Z85srSo+XEDcvtRp25TYJa0VUS+uGcPnW3A6DlAepzgYYJ59l7L
 /PVL3FaGzwzO0fNFxmvosF34iYOp/Q5W5HrMy234fTFNNvIrwNWys9ErmcD0TzeFvsMAjxpmpt1
 twO+kwRvvG7uqRFi9worttf7vz3vQwxqvZ5zW4D15yswkH0jvKq7fQFtAmNhWvbusPasIe7TOeI
 cFkDSrVPidcWYWuAs2hpHIPZLFU5xXSaUkR34UWh3I1ZI5A2PAK6lCawhiXg8ggZK0ySkSL5fhE
 Ju83ZqhCIO1sqNRo6E8xkb3apAx7ksBU4+8DE3Cc6PC6tGcB1yFQCVERx7JT7knDgMR/IIn/8pN
 2bzVjVg3u9DtiU4JC2R0sj6zSMjH+DiI+fL0GCQ==
X-Received: by 2002:a5d:5885:0:b0:42b:3bc4:16c9 with SMTP id
 ffacd0b85a97d-42b59373ee4mr1444252f8f.51.1763102246357; 
 Thu, 13 Nov 2025 22:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZIn/4aOrohDZZ+jnJQjBdwmtJk6myvePpDcT2ReMBE+fYRQ72cTJxSXYN2VEdZWxVjQypeQ==
X-Received: by 2002:a5d:5885:0:b0:42b:3bc4:16c9 with SMTP id
 ffacd0b85a97d-42b59373ee4mr1444233f8f.51.1763102245896; 
 Thu, 13 Nov 2025 22:37:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e845bdsm7814490f8f.12.2025.11.13.22.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 22:37:25 -0800 (PST)
Message-ID: <71f97da4-315e-457e-8ac9-c48d04fb4772@redhat.com>
Date: Fri, 14 Nov 2025 07:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: set correct list pointer when removing notifier
To: Matthew Rosato <mjrosato@linux.ibm.com>, peterx@redhat.com
Cc: farosas@suse.de, steven.sistare@oracle.com, alex@shazbot.org,
 qemu-devel@nongnu.org
References: <20251113213545.513453-1-mjrosato@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251113213545.513453-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/13/25 22:35, Matthew Rosato wrote:
> In migration_remove_notifier(), g_slist_remove() will search for and
> potentially remove an entry from the specified list.  The return value
> should be used to update the potentially-changed head pointer of the
> list that was just searched (migration_state_notifiers[mode]) instead
> of the migration blockers list.
> 
> Fixes: dc79c7d5e1 ("migration: multi-mode notifier")
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   migration/migration.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c2daab6bdd..9e787749b2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1693,7 +1693,7 @@ void migration_remove_notifier(NotifierWithReturn *notify)
>   {
>       if (notify->notify) {
>           for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> -            migration_blockers[mode] =
> +            migration_state_notifiers[mode] =
>                   g_slist_remove(migration_state_notifiers[mode], notify);
>           }
>           notify->notify = NULL;


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



