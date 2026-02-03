Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD80E87849
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJZg-0004Nj-HZ; Tue, 03 Feb 2026 11:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnJZf-0004MQ-JT
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnJZd-0000Ne-Mt
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770137300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tku+XPo6LN/8plNHEFrB6uiAj55u66I0MKsXJH7XCls=;
 b=fXW+gQ9QDKQaH5UgUh+GgOEth8VV+O3/ZblLA+myD7YJArypRBis1WTnWJ2pbF0563ES6G
 dittsNlPspkLCVA16Sp6ClxMSbTg+L/6AZQdE5U3+8LeS5Psn35a4J+ZQbkD/l2T6rLij/
 iOcYBZjzAkZgHqBc5wextJcryQAAla4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-kudCWh_LO5KVJxyUbpyWsg-1; Tue, 03 Feb 2026 11:48:18 -0500
X-MC-Unique: kudCWh_LO5KVJxyUbpyWsg-1
X-Mimecast-MFC-AGG-ID: kudCWh_LO5KVJxyUbpyWsg_1770137294
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so62693805e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 08:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770137294; x=1770742094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Tku+XPo6LN/8plNHEFrB6uiAj55u66I0MKsXJH7XCls=;
 b=qDyboqcPQEB+zFF3dz3VQUZjNXOf6fnBjA0dGbo25Iu4b3vLV9TuLFjijOg30SE9Nu
 arcYcWInpp4KpdKEC4yZVXM2z1fz2b9Muo8ALtVp7Yxno0VmD+9oCuf3JMS6Tn/EnVkw
 LqGPr1ztF7OB9Ju5Z9cu47F5YnHhBYH0NspDF801+pOd487fxvdzbymV8IxVkC7kh+aa
 9T8MZ2IhGHH6T1THpPpNoiemmQiZ2sSNoowDoFLNR9u0segKeC008U/fKMshh9KE6NkU
 4VUOBtA7qFfP4ow1lp0njhWsrumoPq9XVZUl/9MJ2ISHwCinbOulQKi1UV8YSNvNTRQh
 zGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770137294; x=1770742094;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tku+XPo6LN/8plNHEFrB6uiAj55u66I0MKsXJH7XCls=;
 b=F9vkD2zYoKZVjREuQ4NqRWumuaQXUYldsDMD6HVdxR2AMkcoz3lFCWhI8PSISdtFzN
 PTP3l2fexrOjDgsv8eS5nygSEBKNcwakuCmx+g8clcfGwBN0PDq2nczVLdrZf22gZhjw
 fe03v/xandIdQeaSrA8MwwaI/uaRNYVMplzEEQbbFCcuQXtxNax8ahvq1w1BtU908RuE
 bj1Qt/B75DD12Up4L7Qk5sLUOjXkXRrswvolWGNcTGbGoV8D7ckLEDzmYL2Q6ZnsNZv8
 BuyLLuGXeZKg9SYYYlXx4ly/8fEiPvQtUuuUlDXeiaKd9hSDDeBaiCq0FZ3DEm73NWNy
 Ysfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPFhMr0gUGzh2lDK5x9gca5nDL+WPUm4OkkjP5cmFL7quhZkh1YFa+Rw233oDKuKhOwmgI+9+xwNjZ@nongnu.org
X-Gm-Message-State: AOJu0YztNQMe/X7q+3Rzoce9Qy+2z2JXvggdUpq0A6r4Q7Lt/xL/UZY2
 C509YerN/KhiXPS+LTzS0Vji0LipDCdi7tco9FpFriRfDl3tDEt/EBYOKWehM5Ol/NHsRRgTCfo
 nSKNgg0bTs4Cyahzp6FwpM1l/ncH3HbuDO7QxejYvQNo+IPNCEE8vyynFPfj3ZZ9v
X-Gm-Gg: AZuq6aL4zKjTDsz6r2xTItv+ZqT/tSEw+18H7DEIDLduRnM674Q48N2IeAA8f6BTCSO
 /s1HKmGTmyTDqlq7vwi2MPgiTDs1I9O33kkBxeWk7PSkbNT5N/+SBLOUR0BALvbE6TgD6SgaZ7b
 qcLFHWRE0xTdqcCKbJlf9+P0DyXCHVxRMER+hasJEMt6DRpruNeC48wtTX86fKBm+LIr6tS+kBH
 /uc/+B+vkRQkRyYkO6NvZGZbLzVsAW7burt4nNsW8oy0TFrDwusylSqwbkbeh41Myzdifsfm5G4
 S74d2waZ+87O0LXmuPEZIBWeeBmd+dmHrhiQDdrsWSw5+c7z45c8WXO/U8oYl1S/5J9x9HW3ZrK
 D9tpZqAxBpk1tWCyYBKpt3e9Nsz9mNjDpCTgBUrcz5hOuaw3z
X-Received: by 2002:a05:600c:5491:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-4830e922970mr3745165e9.7.1770137292980; 
 Tue, 03 Feb 2026 08:48:12 -0800 (PST)
X-Received: by 2002:a05:600c:5491:b0:477:6d96:b3e5 with SMTP id
 5b1f17b1804b1-4830e922970mr3744685e9.7.1770137292514; 
 Tue, 03 Feb 2026 08:48:12 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511cc93sm85818405e9.2.2026.02.03.08.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 08:48:11 -0800 (PST)
Message-ID: <24ea8ccb-d904-49e4-bd27-5378aac4a56a@redhat.com>
Date: Tue, 3 Feb 2026 17:48:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260202173406.13979-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260202173406.13979-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/2/26 18:34, Avihai Horon wrote:
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
> Changes from v2 (https://lore.kernel.org/qemu-devel/20260201122348.28478-1-avihaih@nvidia.com/):
> * Renamed prepare-pre-copy-p2p to pre-copy-p2p-prepare
> * Renamed prep parameter to prepare in mig_state_to_qapi_state() and
>    vfio_migration_send_event()
> * Added short explanatory comment before sending the prepare event in
>    vfio_migration_set_state()
> * Explicitly used VFIO_DEVICE_STATE_PRE_COPY_P2P as parameter for
>    vfio_migration_send_event()
> 
> Changes from v1 (https://lore.kernel.org/qemu-devel/20260128105159.10282-1-avihaih@nvidia.com/):
> * Removed VFIO_MIGRATION_PREPARE event and instead added a new
>    PREPARE_PRE_COPY_P2P state which is sent before PRE_COPY_P2P
>    transition
> * Added details to commit message
> ---
>   qapi/vfio.json      | 13 +++++++++++--
>   hw/vfio/migration.c | 26 +++++++++++++++++++-------
>   2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index a1a9c5b673..17b6046871 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -11,7 +11,13 @@
>   ##
>   # @QapiVfioMigrationState:


(I had forgotten about the vfio-pci "migration-events" property)


Peter, Fabiano,

Do you think it would be interesting to send VFIO migration events
by default ?

Thanks,

C.


>   #
> -# An enumeration of the VFIO device migration states.
> +# An enumeration of the VFIO device migration states.  In addition to
> +# the regular states, there are prepare states (with 'prepare' suffix)
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
> +# @pre-copy-p2p-prepare: The device is just about to move to
> +#     pre-copy-p2p state.  (since 11.0)
> +#
>   # Since: 9.1
>   ##
>   { 'enum': 'QapiVfioMigrationState',
>     'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
> -            'pre-copy', 'pre-copy-p2p' ] }
> +            'pre-copy', 'pre-copy-p2p', 'pre-copy-p2p-prepare' ] }
>   
>   ##
>   # @VFIO_MIGRATION:
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b4695030c7..4bd8e24699 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>   }
>   
>   static QapiVfioMigrationState
> -mig_state_to_qapi_state(enum vfio_device_mig_state state)
> +mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prepare)
>   {
>       switch (state) {
>       case VFIO_DEVICE_STATE_STOP:
> @@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
>       case VFIO_DEVICE_STATE_PRE_COPY:
>           return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>       case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> -        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
> +        return prepare ? QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P_PREPARE :
> +                         QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>       default:
>           g_assert_not_reached();
>       }
>   }
>   
> -static void vfio_migration_send_event(VFIODevice *vbasedev)
> +static void vfio_migration_send_event(VFIODevice *vbasedev,
> +                                      enum vfio_device_mig_state state,
> +                                      bool prepare)
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
> +                                   mig_state_to_qapi_state(state, prepare));
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
> @@ -146,6 +148,16 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>           return 0;
>       }
>   
> +    /*
> +     * Send a prepare event before initiating the PRE_COPY_P2P transition to
> +     * ensure timely event delivery regardless of how long the state transition
> +     * takes.
> +     */
> +    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
> +        vfio_migration_send_event(vbasedev, VFIO_DEVICE_STATE_PRE_COPY_P2P,
> +                                  true);
> +    }
> +
>       feature->argsz = sizeof(buf);
>       feature->flags =
>           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;


