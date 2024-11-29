Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDB2D6EC13
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH1xL-0001Yc-DX; Fri, 29 Nov 2024 09:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1xI-0001YJ-If
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tH1xG-0000id-Vl
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732890404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n50Px5WLhRcstZFvyRTciSNMkj+aKtv7q4TgvxJgntY=;
 b=dDEgSZMQuhMpX9rIUHl9zl1/2BHVaV1s0CnV8AjsOWjO6VBc/VqudOwOKjJSIeclGNdVPj
 fOorg8XKGsel/l3PODRb6dWxdipCqpUUOPRJOfnkAKltPtXsFAowpUV+NF27f7wdvTo4Is
 B3uLmCZw6Enkv/IFbkFm7im3qLBhnw0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-Zc2XXGK8N-mVo9EawzoVbg-1; Fri, 29 Nov 2024 09:26:42 -0500
X-MC-Unique: Zc2XXGK8N-mVo9EawzoVbg-1
X-Mimecast-MFC-AGG-ID: Zc2XXGK8N-mVo9EawzoVbg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a0bf9914so14088585e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 06:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732890401; x=1733495201;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n50Px5WLhRcstZFvyRTciSNMkj+aKtv7q4TgvxJgntY=;
 b=YjPcJpEiwFlo7XBlCBHK8JOxU0IVEtJZ4PHSE5sEXjjrkeIpj7DzCP40aHN2EzDYbw
 wg1xW4/pjeRM4eA+nffUwOztsBtn/mi+rIiGapFJNT8pHG+t6v8ZdwYSCxAwXirPJ37J
 Th/yzDOe3ObqXoOysRVae3tIxyJeq0YXA2f6IvCZboBIxELJvQLR0pwQZH4Oe1IdyyWC
 vzPHXveJa7LpRWeexH9XEGQ1XgTpQJlXKaTRzygw/dykuCFFexeH1U6wrti0xHzq2OFc
 DH8pWW3ZcmwoH1n4jpz8QxPPqIO5TkSurZGE8Dlwes5Fu2oNoimXr2AXlEaZs8ywcQvE
 JANg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGHR2m1za/GMNhfBxcWASkyFwzI+sI/DY9XUEoPOH92pLMDUkjZM+biUgCvoO4IMutJl96U/GRcY/0@nongnu.org
X-Gm-Message-State: AOJu0YyGYySN85sqjYhhTwH1zxwYnauahzSKlK+mpSOkEHP/RzW0Kk67
 lze7KEmcBQIuopGFmYIYiMbpCiPEdd1WD++z7KcbgrDjfQD5x7+cmkLP6TeZGPByDb53mQ12A6j
 A7jlgN/E3ruKPczEEsoZHkZvVdUeFjF9WPnzXYiJ7I8TGRrK3eRoq
X-Gm-Gg: ASbGncsA2AC3wMPhS+TUaNxRVVSkN7wZRWKrbj9autwPVj7zkmLoWgu7qTnpWo7JXnS
 3FEIH2PF7gyffGbGr/ErK51qHXzd9qo6gV0F4J7H/NIz2JGCHPCfjWREvSxZ0H36AuMr40deOd6
 TmevAq/tILxjAoW6Xuf8TyRDDAWeVozNQajgonO3vpje4Fsb4VSMlpeOaG0C3aKyaa+d+etMrcv
 kDBVG9mpQS/1CY/gv04WgAgtV384J9cu0Cv8u3uV/Q3e0BrHmOSB331SjKJELltLBqkbsfIcssf
 1UgPZQDghFAq
X-Received: by 2002:a05:600c:4fc3:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-434a9dbe916mr111647745e9.9.1732890400764; 
 Fri, 29 Nov 2024 06:26:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7yo5CnadwCsEbzKR7d2YqTI9KJNoGuYaWTA7J4dgQdK8srsMay/SqrcIK/xc0WCfrU+QZrA==
X-Received: by 2002:a05:600c:4fc3:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-434a9dbe916mr111647435e9.9.1732890400387; 
 Fri, 29 Nov 2024 06:26:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7691b0sm85885155e9.17.2024.11.29.06.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 06:26:39 -0800 (PST)
Message-ID: <4db93e93-4c2d-4fb0-9ef1-374c469bbfc9@redhat.com>
Date: Fri, 29 Nov 2024 15:26:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/24] vfio/migration: Add
 load_device_config_state_start trace event
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <9c6f1db39fd6e8e12cfb8946cd4d2a39ad77564c.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9c6f1db39fd6e8e12cfb8946cd4d2a39ad77564c.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/24 20:20, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> And rename existing load_device_config_state trace event to
> load_device_config_state_end for consistency since it is triggered at the
> end of loading of the VFIO device config state.
> 
> This way both the start and end points of particular device config
> loading operation (a long, BQL-serialized operation) are known.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


I think we should add more trace events regarding the new threads
this series is adding. At all level :

   hw/vfio/trace-events
   migration/trace-events
   util/trace-events


Some time ago, Peter proposed a series adding an "info migrationthreads"
hmp command [*]. I found it useful for dev/debug. I wonder about its
status.

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

[*] migration: query-migrationthreads enhancements and cleanups
     https://lore.kernel.org/all/20240930195837.825728-1-peterx@redhat.com/


> ---
>   hw/vfio/migration.c  | 4 +++-
>   hw/vfio/trace-events | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 9e2657073012..4b2b06b45195 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -285,6 +285,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>       VFIODevice *vbasedev = opaque;
>       uint64_t data;
>   
> +    trace_vfio_load_device_config_state_start(vbasedev->name);
> +
>       if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
>           int ret;
>   
> @@ -303,7 +305,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>           return -EINVAL;
>       }
>   
> -    trace_vfio_load_device_config_state(vbasedev->name);
> +    trace_vfio_load_device_config_state_end(vbasedev->name);
>       return qemu_file_get_error(f);
>   }
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index cab1cf1de0a2..1bebe9877d88 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -149,7 +149,8 @@ vfio_display_edid_write_error(void) ""
>   
>   # migration.c
>   vfio_load_cleanup(const char *name) " (%s)"
> -vfio_load_device_config_state(const char *name) " (%s)"
> +vfio_load_device_config_state_start(const char *name) " (%s)"
> +vfio_load_device_config_state_end(const char *name) " (%s)"
>   vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
>   vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size %"PRIu64" ret %d"
>   vfio_migration_realize(const char *name) " (%s)"
> 


