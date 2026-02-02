Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6B0E7316D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu3L-0006LB-6f; Mon, 02 Feb 2026 08:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vmu3I-0006L2-CU
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vmu3G-0002WL-H1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770039192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9lzqRpZKvA00BNS2glGCZMpcD+iI3QD96P9Vh2kIJrk=;
 b=OTmzPyQa4g8miS17G8Z06joY3XvlxLPIwOhn1yv431y+TiC7HFxdGhSOvR3IiWUQD+4SZX
 HkjgHQXjQaqFvYACIP8Fyl9OUKqbaf/RWFLfK73tEUGhwjXduSB8Q/Q/Ep/zcoaRValUv/
 O17K1dLbSa0vyU1zG+ReGuIO1STijw4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-kpIIYknqPlChpMGC1rHIow-1; Mon, 02 Feb 2026 08:33:11 -0500
X-MC-Unique: kpIIYknqPlChpMGC1rHIow-1
X-Mimecast-MFC-AGG-ID: kpIIYknqPlChpMGC1rHIow_1770039190
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-431054c09e3so3793556f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770039189; x=1770643989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9lzqRpZKvA00BNS2glGCZMpcD+iI3QD96P9Vh2kIJrk=;
 b=e3IVjqdCdo8YofHHp5Xt+weqSKRgrExeyqjuLqEDEApiXbMiBmY0Kg5AomAux5xhqi
 VAEjPJdXM0/WnYYj5gW+j2j+DcYoI8U+CE4Ct0Orf46NjxQoNykoE0wcgDYGyHG4Yy1M
 iXdW0TLHBJVYiMazxj2e5F0Aly8mVx1k4wZk9AGwo52Z6he7kGtKK7ZS6cr4GndU7+HK
 tr2C2inbzZVQgjjxalKLhrwsrg0qCnmshd/Fa22gFBEnPQsiHcircMjhpakOarMw5qx+
 imaSLEk3bfajvcTfEmrWa3x24ZqheQMm1djbx+uQCgwtLkVukmQvGX3eK1fdC4+6QPF5
 //Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039189; x=1770643989;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lzqRpZKvA00BNS2glGCZMpcD+iI3QD96P9Vh2kIJrk=;
 b=Ex+KhADf+R9WQKbWNdph+LY3F7hXPjUh/EclU0c/LjqcF8vcRQKMOdWH5dPv6KvWm8
 AVNNsy3H0lZT2T382YUYEGhJky5jYdaab6g0oxu34MYfpb9SGYiQ2LXvPLKk1KKEcixp
 Cp4BrZe228hZgFDShRrwQQUFjRzxu+otiWcpzOLLBbXj3eTs4RPt0MeCbmEQdaPH/7L+
 zcftUHnPC8+8IlBLZvuk7VWINzzj33UAHDt5jEIw/5iNGPv4DnbuC+NNIV0IoqjycIpd
 sRScSYO8ftRFmRytSTzN5egaKcPxDmbRKtQK6T64lTOpf6z8kvSRGKgsIfjWSKpIi+Ia
 7hHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOCLmLSIZ/zGrP7AVqfZmchgNW1yuojbSAFf6Q8Xyz+PjuDWkcmQJyXHYccKtjAVCQhZli6ZYFe1zh@nongnu.org
X-Gm-Message-State: AOJu0Yw8YviAULFAIGOVionnFd5nNVBhTNBrha4ZIhZYVmPGlAyiER07
 IL/jPZiO9fNBafLCTAtbmj71vBQADnM4DfNwZ0SZKRMhKDTLytZGgQq1lyVDVmuUxvhSX1Fm79x
 n2iQA27RFLLHtme6mQ7i9XuSHrye3oNcdjB2WWyETaYEjarPuREk394YRZsXW8Z4t
X-Gm-Gg: AZuq6aI/6EBAY3XTb/q6Gzeq61Fr+fzP+ABn9hcl8RICrEUyM7V/10Qo2/gvmdYZuOZ
 WHMHT+9pWvkX5acBSVoK/aQDel2CPDqQYJt3dluvkB5MFB0ulK7WUP6a2CgB5HEgju0vZHR16zL
 SPOONNYhrZQloTAOCVaP7YJNA8UwY2vgFrtX+S+VCaEVscJs1iwc8+QnyjiDcPf1g1IXK32iPMT
 mVlDqFKyMCA6sGoITPMtGP47hp6psArSK2mZ8AtUcB5yT6w5gDRw+NW0QwpN7YslUUW5mOcNQR6
 poiYwGfuLrIsVt9WkPB7PxuAqnEO7eDGe8BkkYMtTjRwX/56GqatCx58qelM45OHOoUevCqHVJ5
 6oMQfEg83pZaPNf31C4A/MFPWY4rkOl2rV6+ZqgvtjypY6PnI
X-Received: by 2002:a05:600c:1549:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-482db49333fmr137498965e9.34.1770039189436; 
 Mon, 02 Feb 2026 05:33:09 -0800 (PST)
X-Received: by 2002:a05:600c:1549:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-482db49333fmr137498535e9.34.1770039188969; 
 Mon, 02 Feb 2026 05:33:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb59asm438674585e9.7.2026.02.02.05.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 05:33:08 -0800 (PST)
Message-ID: <0c48a2d5-776a-4cd7-a1ee-3cfc32dde931@redhat.com>
Date: Mon, 2 Feb 2026 14:33:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260201122348.28478-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260201122348.28478-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

Hello Avihai,

On 2/1/26 13:23, Avihai Horon wrote:
> The VFIO_MIGRATION event notifies users when a VFIO device transitions
> to a new state.
> 
> One use case for this event is to prevent timeouts for RDMA connections
> to the migrated device. In this case, an external management application
> (not libvirt) consumes the events and disables the RDMA timeout
> mechanism when receiving the event for PRE_COPY_P2P state, which
> indicates that the device is non-responsive.
> 
> This is essential because RDMA connections typically have very low
> timeouts (tens of milliseconds), which can be far below migration
> downtime.
> 
> However, under heavy resource utilization, the device transition to
> PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
> VFIO_MIGRATION event is currently sent only after the transition
> completes, it arrives too late, after RDMA connections have already
> timed out.
> 
> To address this, send an additional "prepare" event immediately before
> initiating the PRE_COPY_P2P transition. This guarantees timely event
> delivery regardless of how long the actual state transition takes.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
> Changes from v1 (https://lore.kernel.org/qemu-devel/20260128105159.10282-1-avihaih@nvidia.com/):
> * Removed VFIO_MIGRATION_PREPARE event and instead added a new
>    PREPARE_PRE_COPY_P2P state which is sent before PRE_COPY_P2P
>    transition
> * Added details to commit message
> ---
>   qapi/vfio.json      | 13 +++++++++++--
>   hw/vfio/migration.c | 20 +++++++++++++-------
>   2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index a1a9c5b673..2de87dc215 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -11,7 +11,13 @@
>   ##
>   # @QapiVfioMigrationState:
>   #
> -# An enumeration of the VFIO device migration states.
> +# An enumeration of the VFIO device migration states.  In addition to
> +# the regular states, there are prepare states (with 'prepare' prefix)
> +# which indicate that the device is just about to transition to the
> +# corresponding state.  Note that seeing a prepare state for state X
> +# doesn't guarantee that the next state will be X, as the state
> +# transition can fail and the device may transition to a different
> +# state instead.
>   #
>   # @stop: The device is stopped.
>   #
> @@ -32,11 +38,14 @@
>   #     tracking its internal state and its internal state is available
>   #     for reading.
>   #
> +# @prepare-pre-copy-p2p: The device is just about to move to

Could you please rename to "pre-copy-p2p-prepare" ?

Peter, Fabiano,

Any preferences in the naming ? I would like to avoid
"pre-pre-copy-p2p" but it is what this event looks like.


> +#     pre-copy-p2p state.  (since 11.0)
> +#
>   # Since: 9.1
>   ##
>   { 'enum': 'QapiVfioMigrationState',
>     'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> -            'pre-copy', 'pre-copy-p2p' ] }
> +            'pre-copy', 'pre-copy-p2p', 'prepare-pre-copy-p2p' ] }
>   
>   ##
>   # @VFIO_MIGRATION:
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b4695030c7..3b215eb4ff 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>   }
>   
>   static QapiVfioMigrationState
> -mig_state_to_qapi_state(enum vfio_device_mig_state state)
> +mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prep)
>   {
>       switch (state) {
>       case VFIO_DEVICE_STATE_STOP:
> @@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
>       case VFIO_DEVICE_STATE_PRE_COPY:
>           return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>       case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> -        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
> +        return prep ? QAPI_VFIO_MIGRATION_STATE_PREPARE_PRE_COPY_P2P :
> +                      QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>       default:
>           g_assert_not_reached();
>       }
>   }
>   
> -static void vfio_migration_send_event(VFIODevice *vbasedev)
> +static void vfio_migration_send_event(VFIODevice *vbasedev,
> +                                      enum vfio_device_mig_state state,
> +                                      bool prep) 

prep -> prepare

>   {
> -    VFIOMigration *migration = vbasedev->migration;
>       DeviceState *dev = vbasedev->dev;
>       g_autofree char *qom_path = NULL;
>       Object *obj;
> @@ -106,8 +108,8 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
>       g_assert(obj);
>       qom_path = object_get_canonical_path(obj);
>   
> -    qapi_event_send_vfio_migration(
> -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> +    qapi_event_send_vfio_migration(dev->id, qom_path,
> +                                   mig_state_to_qapi_state(state, prep));
>   }
>   
>   static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> @@ -119,7 +121,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>                                             mig_state_to_str(state));
>   
>       migration->device_state = state;
> -    vfio_migration_send_event(vbasedev);
> +    vfio_migration_send_event(vbasedev, state, false);
>   }
>   
>   int vfio_migration_set_state(VFIODevice *vbasedev,
> @@ -146,6 +148,10 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>           return 0;
>       }
>

A short comment (extracted from the commit log) here would be good.

    
> +    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
> +        vfio_migration_send_event(vbasedev, new_state, true);

Please be explicit :
            vfio_migration_send_event(vbasedev, VFIO_DEVICE_STATE_PRE_COPY_P2P, true);

Thanks,

C.


> +    }
> +
>       feature->argsz = sizeof(buf);
>       feature->flags =
>           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;


