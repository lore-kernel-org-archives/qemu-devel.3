Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8720C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLoU-0004iN-9M; Tue, 18 Aug 2026 11:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLoS-0004hv-DZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:33:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLoQ-0000zs-R9
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787067194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cu81btROC+enlNAFhqB95EUDWsj7/CcXnv/8xnZplsE=;
 b=AIKg19/od0zCp0B/LRASlRkPVHkmY8wOCBzdDvy8wZx9j3nuPhF4dUYAZwvmj6r6rJdDsF
 LDGbTnfaKZw7AQpgdV/D7xTW9wMN7WS+cPLmyNCSTrCicOy3BRZ8ooEjjA5fkam9o6MQjF
 z4UtLXZ+dE3wa0IGijvKccQ24pGobEg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-VKHvghhxN-2f9Z_tAxPN6w-1; Tue, 18 Aug 2026 11:33:12 -0400
X-MC-Unique: VKHvghhxN-2f9Z_tAxPN6w-1
X-Mimecast-MFC-AGG-ID: VKHvghhxN-2f9Z_tAxPN6w_1787067191
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso37023485e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787067191; x=1787671991; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cu81btROC+enlNAFhqB95EUDWsj7/CcXnv/8xnZplsE=;
 b=sNMOZZd1jdtDed8sPdfduIfxgGbp8QDke3GenpsSCUt925xlhupDclVQbqbFQQsso1
 hdSpBwCMGkTqlLTNlsLuUDCrmo9RM/qsb9rbo/UhrASDewsrUqKCQbuaXV+w7I0S5JMy
 HaRRlmshvwjZTlC3fDZXzvaBkjOECuH+aOuInjqZxSYVqJ4Ofx8A6khY5M62PWWk89/c
 RywkyRL6T29U8RJm71aYAN4GqJMkOCZ8zsYGfX2rviRxlEbsBFSsqxTF3UtTGkZ7BK7e
 erk1enGk7h5/VLOc3NbDgmScWNvUgbQiVSUQDyRDsLFgA/TJDS+JwEMiRB4CabPrV0DC
 dlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787067191; x=1787671991;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cu81btROC+enlNAFhqB95EUDWsj7/CcXnv/8xnZplsE=;
 b=kW1YtONoPl+9oEdmOpsUVWUqYGpwpTFh6y8i0z+1lWzMGj5WBnzZ0zOfnSZ1NmpLUz
 uGPcZPrVzSXe78aTxFUtTEXfoAvjrMkR+F4B2Yyf7EFUIaLT9l7XJ8F4lXyDHltkai4k
 nGC7FfRbxgjDwjIMftglXTf87l4+IbH3TiZjl17Pi9K7aZAKi8l4bWuROKLtbOR71l0r
 BTK8Eh0fW9nwFGQ1XwUO4SScBQydN5OSfcu/ll9Rg004MjgTQc41N9B5kBprVCQJmjdl
 qU9eYPawN+2oEcCl4VJrzusOJU9ApSgDNrgkdqot8vMmpflbeVOryCe/VELhzoUksCf2
 F9Pw==
X-Gm-Message-State: AOJu0Yxi3KufEO8joG+WdfVt9OampxevLoowes1RwLenghbfrBfor/4J
 Jv3InAIUJeOVRrL8Vr/ijX6+kE/ERaIHmb6GxMqNj4cb1P+Cnud7DixW2E+SLdhogJ8yCrYF9/p
 KqLxhSbosbTkCbTS7F/z/RKEqA5SiAAOZIsWwGMLGjFEcYWcWDuEAOcz4
X-Gm-Gg: AR+sD12adcrld2kOLExuTQqsf5HplNyVnF61Lh/0hhCW6h2aQlc0YulLg6NmWoPPkGn
 g8xOXt+4oDn2oPJd6l2kIAirVkYQJ5xFwparu68t1gaGRM3VIoqMnqisivJvIRN7jCredKd1nSN
 1njkNpRDgolPUc/n9QWZIhEbeA4fBeS8Z5qvl08Ci5q0qtKlABGUNf2zhP2Qk6HSNL6nwRE/dNm
 GwD+qRGU/rUDBxJrU5SfdRJr2HVNa/fVgeWQrWrg2F5gNt89y/Hdk068J5N2rH7ruxarASZ0hB7
 p4N99PvKlpIRvhA8eRwO8uC+Pb6231zsRIKVpUJFAEz8dB98u9yNq8Urhv10fdnI/BidmrtflDT
 tSigAzudxIYCuEi+25E58WT2XGVn4WKyT6mGRMulN9mWAKuDnc5OU
X-Received: by 2002:a05:600c:8b6b:b0:499:8f9f:e9ee with SMTP id
 5b1f17b1804b1-4998f9febbdmr485066675e9.7.1787067191128; 
 Tue, 18 Aug 2026 08:33:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:499:8f9f:e9ee with SMTP id
 5b1f17b1804b1-4998f9febbdmr485061085e9.7.1787067189283; 
 Tue, 18 Aug 2026 08:33:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it.
 [82.53.135.154]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998777caebsm357455665e9.0.2026.08.18.08.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:33:08 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:33:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, bchaney@akamai.com, 
 mark.kanda@oracle.com, den@openvz.org, mail@maciej.szmigiero.name
Subject: Re: [PATCH v3 0/7] migration/cpr: support vhost-vsock devices
Message-ID: <aoR62LTt0K7oWNb7@sgarzare-redhat>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <ee6fc8e2-dffd-4a93-8501-7894c593b760@maciej.szmigiero.name>
 <f335aadd-1157-4a57-bd8c-18bd6b76582c@virtuozzo.com>
 <dadd79c2-89c7-405a-b2c9-7973c3fe62d1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <dadd79c2-89c7-405a-b2c9-7973c3fe62d1@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 18, 2026 at 02:02:10PM +0300, Andrey Drobyshev wrote:
>On 8/11/26 5:12 PM, Andrey Drobyshev wrote:
>> On 6/30/26 9:35 PM, Maciej S. Szmigiero wrote:
>>> On 26.06.2026 18:46, Andrey Drobyshev wrote:
>>>> v2 -> v3:
>>>>
>>>> Re-design device ownership hand-off (suggested by Dongli).  Do not rely
>>>> on SETUP migration notifiers, as this approach forces us to reorder
>>>> generic migration code (see v2 discussion).  Instead:
>>>>
>>>>    * .pre_save() releases ownership on the source (RESET_OWNER) once VM
>>>>      is stopped;
>>>>    * .realize() is adjusted to defer device ownership acquisition for an
>>>>      incoming CPR;
>>>>    * .post_load() actually claims the device (VHOST_SET_OWNER);
>>>>    * FAILED migration event callback re-aquires the ownership on the
>>>>      source after re_save released it.
>>>>
>>>> v2: https://lore.kernel.org/qemu-devel/57c9c9b3-d758-489b-95b8-d16c258b9b0c@virtuozzo.com
>>>>
>>>> Andrey Drobyshev (7):
>>>>    vhost: add vhost_reset_owner op
>>>>    vhost-vsock: don't reset connections during CPR
>>>>    vhost-vsock: fix FD leak in realize()
>>>>    vhost-vsock: preserve vhost FD during CPR
>>>>    vhost: factor out vhost_dev_init_backend()
>>>>    vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>>>    vhost-vsock: hand off device ownership across CPR
>>>>
>>> These patches look okay CPR-wise, so:
>>> Acked-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com> # for CPR
>>>
>>> But the vsock parts still need review by their maintainers/reviewers.
>>>
>>> Thanks,
>>> Maciej
>>>
>>
>> FYI the kernel counterpart series adding VHOST_RESET_OWNER ioctl to
>> vsock ended up in Michael's vhost tree ([1], commits
>> 6236e765f16d^..c7bfb8815d83).
>>
>> Therefore - friendly ping for this series.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
>>
>> Andrey
>
>Another friendly ping
>

Sorry for the long time on my side, and thanks for pings :-)

I left some comments, but overall LGTM.
I'm not a CPR/migration expert, so my comments are more related to 
vhost/vsock.

Thanks,
Stefano


