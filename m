Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86275D1BDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80bu-0006J8-S2; Mon, 04 Nov 2024 12:11:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t80bt-0006If-66
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:11:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t80bo-0006hO-95
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730740279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mG8EiK4ByrMrDfgjuOlC/DYs8eMlf3af/HcyT7GITAg=;
 b=dR7cjbhHXjg+Cr8THHeOaIg8u9ozwKG5H+1ZAraxgBQHd+wMPVbARmg2GR+R5uKxWWXMWe
 wElH6nU0GG1KF87+VlYnv7fCls9m6hBJK4cN4C1xaWLKa17SSOYmFFQs572QvY09Tu54RZ
 c/j7MpcAugGIWXwuDgTWxlhuW1NBD+M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-vJzRE7TCOMWJ8yHNC5h5tw-1; Mon, 04 Nov 2024 12:11:17 -0500
X-MC-Unique: vJzRE7TCOMWJ8yHNC5h5tw-1
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-718091cd51eso2254147a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740277; x=1731345077;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mG8EiK4ByrMrDfgjuOlC/DYs8eMlf3af/HcyT7GITAg=;
 b=GHx5XXy1JnJyj7c9UYGMSjW1UPoTYI1oQzH0O2172CZHkDFSi8z369LacoV7GNg8nO
 /SXP9uflaRVUl8v6gs7N+Wl5+Podohyase+vbUg28JVyKeoOWaWoMMOcFP6MQW1pb29O
 yaz83d7SFJaS121jPQjwYoGOou/eh6ioNt3u1uQi0chiP90mtEZYUDu80U9bjtc3oI8X
 QRvWx6dg+Yp2J4OkF4fpghIP6NcJKGgfbpeTPDBxVSEdx79qIKansOI8cjN4ihp5KZod
 FnMiEzxQBpcfp1/aKwYeqnms5VVXzaqnBeuv/AnYbajkcDpNkrbFikOdgki+0/Uil/l+
 +pSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnaK2RdXiTUb7h6Xja4kdWUQjVrUbUuskrLPUDGIg3xy1AWn3c7PfIA6V8DjZrAbCQdBvY4aBI0LmS@nongnu.org
X-Gm-Message-State: AOJu0YwxKEgAFDLNrnpMfj+HN2j3RMN/22iNz8XW4/wxJtWpOJCQYXfU
 KSj/MiqxTBawhtAlAb149o0ZkngfdFpp2gqe9y5AQq0NxcHIJX3SRoCNTJV3HdHiKOc8vSzqgXQ
 MtCQWWDsJp5wFO8dFNlqnD5XrQxoYywUsjUcjglNplCYiyTK9YGT6
X-Received: by 2002:a05:6830:3152:b0:718:12aa:f7b5 with SMTP id
 46e09a7af769-719ca1989famr12216968a34.12.1730740277006; 
 Mon, 04 Nov 2024 09:11:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA4XOp/QesY1BZ4g2hb4fMSH+XBMm8IA+6DpeAly9fSPwLF1QquzfQE86jEN2JFWXU6BLMGg==
X-Received: by 2002:a05:6830:3152:b0:718:12aa:f7b5 with SMTP id
 46e09a7af769-719ca1989famr12216920a34.12.1730740276481; 
 Mon, 04 Nov 2024 09:11:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:ecac:5b28:cd98:868a?
 ([2a01:e0a:280:24f0:ecac:5b28:cd98:868a])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ec704e93fbsm1866788eaf.18.2024.11.04.09.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 09:11:16 -0800 (PST)
Message-ID: <01c3cab0-75f2-4e36-b39f-00afea6058a9@redhat.com>
Date: Mon, 4 Nov 2024 18:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <8fbb9cc40d9db570eff0a02e49104835014a5a4d.1730731549.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8fbb9cc40d9db570eff0a02e49104835014a5a4d.1730731549.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Maciej,

On 11/4/24 15:58, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This way both the start and end points of migrating a particular VFIO
> device are known.
> 
> Add also a vfio_precopy_empty_hit trace event so it is known when
> there's no more data to send for that device.

Would you mind splitting the patch in 2, one patch for each event flag
added ?

> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
> 
> This is just the lone remaining functionality-affecting patch from this
> series of 4 trivial patches for QEMU 9.2:
> https://lore.kernel.org/qemu-devel/cover.1730203967.git.maciej.szmigiero@oracle.com/
> Two other such patches were already queued and the fourth one is only
> an annotation in a code comment block.
> 
> Changes from the v1 that was posted as a part of the above series:
> * Move the vfio_save_iterate_empty_hit trace event to vfio_save_block(),
> trigger it on ENOMSG errno and rename it to vfio_precopy_empty_hit.
> 
> * Re-arm the above trace event if we see another data read so not only
> the first "data present" -> "data not present" edge is logged.
> 
>   hw/vfio/migration.c           | 17 +++++++++++++++++
>   hw/vfio/trace-events          |  3 +++
>   include/hw/vfio/vfio-common.h |  3 +++
>   3 files changed, 23 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 992dc3b10257..e7b81f99e595 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -370,6 +370,10 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>            * please refer to the Linux kernel VFIO uAPI.
>            */
>           if (errno == ENOMSG) {
> +            if (!migration->precopy_empty_hit) {
> +                trace_vfio_precopy_empty_hit(migration->vbasedev->name);


There is a kind of implicit rule that is to keep the name of the
routine in the trace event. This is true for this file at least.
In this regard, could you please rename the event to :

	vfio_save_block_precopy_empty_hit
or
	vfio_save_block_precopy_empty

as you wish.

> +                migration->precopy_empty_hit = true;
> +            }
>               return 0;
>           }
>   
> @@ -379,6 +383,9 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>           return 0;
>       }
>   
> +    /* Non-empty read -> re-arm the trace event */
> +    migration->precopy_empty_hit = false;
> +
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>       qemu_put_be64(f, data_size);
>       qemu_put_buffer(f, migration->data_buffer, data_size);
> @@ -472,6 +479,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>           return -ENOMEM;
>       }
>   
> +    migration->save_iterate_started = false;
> +    migration->precopy_empty_hit = false;
> +
>       if (vfio_precopy_supported(vbasedev)) {
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
> @@ -602,6 +612,11 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>   
> +    if (!migration->save_iterate_started) {
> +        trace_vfio_save_iterate_started(vbasedev->name);
> +        migration->save_iterate_started = true;
> +    }
> +
>       data_size = vfio_save_block(f, migration);
>       if (data_size < 0) {
>           return data_size;
> @@ -630,6 +645,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>   
> +    trace_vfio_save_complete_precopy_started(vbasedev->name);
> +
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>                                      VFIO_DEVICE_STATE_STOP, &local_err);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 29789e8d276d..d5277cb7697a 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -156,11 +156,14 @@ vfio_migration_realize(const char *name) " (%s)"
>   vfio_migration_set_device_state(const char *name, const char *state) " (%s) state %s"
>   vfio_migration_set_state(const char *name, const char *new_state, const char *recover_state) " (%s) new state %s, recover state %s"
>   vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
> +vfio_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
> +vfio_save_complete_precopy_started(const char *name) " (%s)"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> +vfio_save_iterate_started(const char *name) " (%s)"
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
>   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fed499b199f0..0410111e9868 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,6 +73,9 @@ typedef struct VFIOMigration {
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
>       bool initial_data_sent;
> +
> +    bool save_iterate_started;
> +    bool precopy_empty_hit;

Additionally, I would add an 'event_' prefix to give some indication
of what these new attributes are.

Also, how about replacing 'started' with 'start' ? That's fine if you
prefer start.

Tomorrow is soft-freeze, let's get these changes in for QEMU 9.2.

Thanks,

C.



