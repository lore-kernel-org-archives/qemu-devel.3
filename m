Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF12D3569F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 11:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl3L1-0006NQ-Ue; Wed, 28 Jan 2026 06:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vl3L0-0006MZ-Bv
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 06:03:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vl3Ky-0003QS-5W
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 06:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769598230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VofH40UF5j4GbsK7AoLsUeNMpV7P9n0lC5WdVUOJ1KQ=;
 b=h8AQ5ZZuYZYKXETlI01jUvqaWfe/z96uGLkWA/MtTZvuDdF4oaOWSkPwqLhlhOzrHCgWxU
 au5AY0vND/7Uu6TJXB3spFztWxBUfzPqxRCuVFQvP/L/h9oA3s5GxHzzLOKPWWRK5OTLyH
 fATYk/Vzsmy+ptlOlyPzhumJuNV79u4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-rZtX2g3qNvmocFqJYry4kg-1; Wed, 28 Jan 2026 06:03:49 -0500
X-MC-Unique: rZtX2g3qNvmocFqJYry4kg-1
X-Mimecast-MFC-AGG-ID: rZtX2g3qNvmocFqJYry4kg_1769598228
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48070c21420so2536035e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769598228; x=1770203028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VofH40UF5j4GbsK7AoLsUeNMpV7P9n0lC5WdVUOJ1KQ=;
 b=mhMJw1w1nmBgeOc/uzVrxW3KdKYONC0HgBXIdK0ArGBMy46TtEQ1cOJHJi5XAHZj/3
 LARj2jrrOZei1JF7nT47jDOP5KWjFWxryLP15syP4/ckmxKqSie2YSWS91ZrBuj+jWqz
 qwm1X+uPTTnb256H4aRDxjVvGKV8hjgYXDGbObAYDRSj6LUAQNE9bqZyLVy0Z2n277kV
 +dnigEJAZF/Zz031VMXIUDpti+83r6SLVLTbBgFuLEUiH3vmFjUoJMj4jpxubYMfSUHV
 chMzleabpk1KbRXAQRgwT/uBIYv7vJ29qq5VN7R4qqQg8TQKnHAIEa79+mQkmp2N5kOO
 2x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769598228; x=1770203028;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VofH40UF5j4GbsK7AoLsUeNMpV7P9n0lC5WdVUOJ1KQ=;
 b=MxyLteY+644dZJYTKo0p4iXe409F++5Z5Ri6hKfYX8E+IkCDM10cF7HkkKn9sE5P1q
 Yi9idSWwZAo/ghWPnbZem/nrKbxkuVgnIVUkCjANC4s6+Vukb9urp9NAVRVUXvHxnP/e
 tUzf/XajVjaMQS/h0D+Om6VoS/KL4yi8mIDTytlqkljMj7pe5ZgYF+Jm9jeXXYWrqSXj
 06R8z7kpK+tW280cuQsNeWNcv2qSdUOjJ7ynszkH0ZtGDAYYmA409lI621dgVzR8gbF1
 QEgAl3P0LxJ8YNaSMmYHcbyJCrFN5b/O3x976N1/QkTs1kFC9Vtm0H3gG/kN1EgK4bbW
 xyrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI2oa4nFmOhoB715Oj6IsdO6vQ9qvVUB57ahLMfGPZIRMDe/w0MGAuUaazZk8f0lqcKN3+V+LJrbHd@nongnu.org
X-Gm-Message-State: AOJu0YziNI/u+oNCruAowOGx2vLfP5+aiSBEpD/MTWv5tEFBPoYd11uB
 PwbxPXkfCc/p+LrVu/hXksMoe5Gij2C3lECtEEgFDZVFAxdmp2M7tHmF3o7HstRaaEmVzO7/8xO
 SdIG+MpDU3nRFwV9FjWsI7CeO35KOUyiAwzwFsPf8LfN467tuSc3aoZgs
X-Gm-Gg: AZuq6aKqUiJ4D3pCgucFoEk6S3V2xSqsDpb9V8DafKHRyUM4VJMHrcL8nUCgyEmckif
 50DXcL3D9Suli4xWwjEY+XTNuuRuKNtc+LmoX+ImRSl99+Stotg2hlYopeZ4qW8VUnlPMOAxdJm
 kUigUWHQOumnI/8grGD7+db8GOMm02cg1NYayW+UBY7vUL5A/VcWNnv78LNwXdf2ZrUb7am2MVI
 RBEyTt9bgxjcc5a2jlB5A6SiZo82dxHT4UIHgYcnKBDZKi8ZrVnGPkj9A00g0XHKluUu1/OYvw1
 f0EJV2gFXS0lWDg4HffCqtkyRTZRRMqmQGD0uaZ1+O0oDQsEzQAh0w+3Vjg1m+5+BZlyTAMRIiv
 dnPv9ciPF3gkOxbMYcCCSaP410n7FWqxCVTGD08PONLOTnIR3
X-Received: by 2002:a05:600c:34c8:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-48069e928e5mr62225155e9.13.1769598227991; 
 Wed, 28 Jan 2026 03:03:47 -0800 (PST)
X-Received: by 2002:a05:600c:34c8:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-48069e928e5mr62224765e9.13.1769598227560; 
 Wed, 28 Jan 2026 03:03:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806e2e5ffcsm3949245e9.18.2026.01.28.03.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 03:03:47 -0800 (PST)
Message-ID: <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com>
Date: Wed, 28 Jan 2026 12:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, 'Peter Xu' <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260128105159.10282-1-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260128105159.10282-1-avihaih@nvidia.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

+Peter, + Fabiano

On 1/28/26 11:51, Avihai Horon wrote:
> Currently, VFIO device migration event is sent after the device state
> transition has been completed. However, it may be useful to additionally
> send a "prepare" event before the state transition, to notify users that
> it's about to happen.
> 
> For example, in some cases with heavy resource utilization, stopping the
> VFIO device may take a long time. In time-sensitive scenarios, the
> management application that consumes the event may be notified about the
> state transition too late.
> 
> To overcome this issue, send an additional "prepare" migration event
> before the device state transition.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
>   hw/vfio/migration.c | 18 +++++++++++++-----
>   2 files changed, 46 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/vfio.json b/qapi/vfio.json
> index a1a9c5b673..de41211f1d 100644
> --- a/qapi/vfio.json
> +++ b/qapi/vfio.json
> @@ -66,3 +66,36 @@
>         'qom-path': 'str',
>         'device-state': 'QapiVfioMigrationState'
>     } }
> +
> +##
> +# @VFIO_MIGRATION_PREPARE:
> +#
> +# This event is emitted when a VFIO device migration state is about to
> +# be changed.  Note that even if this event is received for state X,
> +# the VFIO device may transition to a different state if the original
> +# state transition to X failed.
> +#
> +# @device-id: The device's id, if it has one.
> +#
> +# @qom-path: The device's QOM path.
> +#
> +# @device-state: The new device migration state that is about to be
> +#     changed.
> +#
> +# Since: 11.0
> +#
> +# .. qmp-example::
> +#
> +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
> +#          "event": "VFIO_MIGRATION_PREPARE",
> +#          "data": {
> +#              "device-id": "vfio_dev1",
> +#              "qom-path": "/machine/peripheral/vfio_dev1",
> +#              "device-state": "stop" } }
> +##
> +{ 'event': 'VFIO_MIGRATION_PREPARE',
> +  'data': {
> +      'device-id': 'str',
> +      'qom-path': 'str',
> +      'device-state': 'QapiVfioMigrationState'
> +  } }
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b4695030c7..9f887c148f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -90,9 +90,11 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
>       }
>   }
>   
> -static void vfio_migration_send_event(VFIODevice *vbasedev)
> +static void vfio_migration_send_event(VFIODevice *vbasedev,
> +                                      enum vfio_device_mig_state state,
> +                                      bool prep)
>   {
> -    VFIOMigration *migration = vbasedev->migration;
> +    QapiVfioMigrationState qapi_state;
>       DeviceState *dev = vbasedev->dev;
>       g_autofree char *qom_path = NULL;
>       Object *obj;
> @@ -105,9 +107,13 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
>       obj = vbasedev->ops->vfio_get_object(vbasedev);
>       g_assert(obj);
>       qom_path = object_get_canonical_path(obj);
> +    qapi_state = mig_state_to_qapi_state(state);
>   
> -    qapi_event_send_vfio_migration(
> -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
> +    if (prep) {
> +        qapi_event_send_vfio_migration_prepare(dev->id, qom_path, qapi_state);
> +    } else {
> +        qapi_event_send_vfio_migration(dev->id, qom_path, qapi_state);
> +    }
>   }
>   
>   static void vfio_migration_set_device_state(VFIODevice *vbasedev,
> @@ -119,7 +125,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>                                             mig_state_to_str(state));
>   
>       migration->device_state = state;
> -    vfio_migration_send_event(vbasedev);
> +    vfio_migration_send_event(vbasedev, state, false);
>   }
>   
>   int vfio_migration_set_state(VFIODevice *vbasedev,
> @@ -146,6 +152,8 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>           return 0;
>       }
>   
> +    vfio_migration_send_event(vbasedev, new_state, true);
> +
>       feature->argsz = sizeof(buf);
>       feature->flags =
>           VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;


