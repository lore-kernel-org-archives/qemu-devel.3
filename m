Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072B9C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnY0b-0001td-7Q; Thu, 27 Feb 2025 02:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnY0Z-0001sx-5N
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:08:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tnY0W-0008B3-UK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 02:08:34 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2233622fdffso10735165ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 23:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1740640111; x=1741244911;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JPhvSqB2an/d3tIKddzpnAQaWFJPCV+QPsn2CKu3hnY=;
 b=1fgwtPLWnNHglV/7mVNNWU9gxjaQ7UUSQCkf3oJDa3MS1qsQAvtftb3hbxgR0oTlTN
 zKMaX6k/joAfo+oem40ut9yEPtplARV2yZeIcYJzXEgX812Mh5X50C33Bz0mVuaxINID
 sNXlhzwzplTb9oHk8KwcKhyDD0U4GvjlkocADyc+Z+5Gom3r41Grd6uUGK+9K/r4v7K2
 6oXWaQcCP5KFNTVva2Siv42SnDHtc6YN5IZ0ZE4pTxc1AVWuUhbz4YVPlBOlmhnQcS6y
 EBVIYhxynkahjQFMdNc+8pZOzd2kQZey2oMNfmTKAgTYzp9myAtIAl27DHCV4qwkZa60
 n8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740640111; x=1741244911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JPhvSqB2an/d3tIKddzpnAQaWFJPCV+QPsn2CKu3hnY=;
 b=G6+wBt9MGIMbB8ifREGeUNqvKPdunCU81iTdnCAxXHLkMckdnp3HLYf2F/m8PphOrC
 zp0ejDjzdLdZZdwC7qMBqXGwljiQmq+lYyjnr5ZKfsiutPd/rNuR8XiMdL9Q37ZG+iLZ
 6RmI6Ud+obTqsvOIAGs5upJwn9UgXEXRTgAjtEaXWxpmpWS5J/nbHcZ4b1HrrDPH6vV6
 PitfhuZRmwfeInI6Z7aC0wGe7sYsCkHRGl+obr8i/9TkM9pIEaM4f4g6POB7+Hug+4Q5
 x/QUjZtR0x1ePixm9Nl73jdRRojFwTiAZAhCJvNt9hMpJB08hEqnEyVUMWULPs2gKheV
 x93g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+qT3zFkVaZDu8XCg6W3v+pIfyB8KCPqGtn16x54Y7JC+dFmiNfFOffTcAUOfTPfCA+eicmdwG9C1/@nongnu.org
X-Gm-Message-State: AOJu0Yy6iE29b173XZ19lG//bA1lytBz9MzyCIJOQtIKtxyumtBIBNjc
 8lf2tMpSufwiwGnjGG89Cqfk4mYifTPCxWtBk4TRYlM6GFF9nYh2PGKp8sIKzQo=
X-Gm-Gg: ASbGncvKlBhqkCejSNH9hbQY8CV0mAh80Cy+qUOhj+gecnpo61e3CU2VhVmoekq1FJb
 Gulz8G5oHfkwLN2rbq4fdJwEsO93hqL/9gzfd6K0gqbQepeHvjlPzK/jlZhHq0AwLSWcKdR4VJN
 KvTyMfnTuknvnhbQKyNjcbbD7u2lh5lYwGNrsF97lnlGKa8w011jBvxhg2pInrK6mRMTx0zo2b7
 66jiKztqfecGeF9tT9aUWTz6eTWCERVhiqKIz77kRm4ZIX4/WupmW1Umms9GWtdVtlHWdMzaIuh
 1VBVdNbxsNWGG0lS3knuOXLkroORhZlcYl2CE2c=
X-Google-Smtp-Source: AGHT+IG2oufwW0bwXfiVWS+2gsl8QRlC9SyLTv6KNyxye8TQ7seNcC1wZx6rjoPfkSIm7rXz0br0Aw==
X-Received: by 2002:a05:6a20:7f91:b0:1ee:ace8:8194 with SMTP id
 adf61e73a8af0-1f0fc24b467mr18343343637.22.1740640111366; 
 Wed, 26 Feb 2025 23:08:31 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7ddf245asm678774a12.5.2025.02.26.23.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 23:08:30 -0800 (PST)
Message-ID: <7253855c-c54a-475f-9747-66b7e5df98e6@daynix.com>
Date: Thu, 27 Feb 2025 16:08:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] virtio: Convert feature properties to OnOffAuto
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
References: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
 <20250208-virtio-v5-4-4376cb218c0f@daynix.com>
 <20250220104248-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250220104248-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/02/21 0:46, Michael S. Tsirkin wrote:
> On Sat, Feb 08, 2025 at 04:51:10PM +0900, Akihiko Odaki wrote:
>> Some features are not always available with vhost. Legacy features are
>> not available with vp_vdpa in particular. virtio devices used to disable
>> them when not available even if the corresponding properties were
>> explicitly set to "on".
>>
>> QEMU already has OnOffAuto type, which includes the "auto" value to let
>> it automatically decide the effective value. Convert feature properties
>> to OnOffAuto and set them "auto" by default to utilize it. This allows
>> QEMU to report an error if they are set "on" and the corresponding
>> features are not available.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
>> ---
>>   include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>>   hw/core/machine.c          |  1 +
>>   hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>>   hw/virtio/virtio.c         |  4 +++-
>>   4 files changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 638691028050d2599592d8c7e95c75ac3913fbdd..b854c2cb1d04da0a35165289c28f87e8cb869df6 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -113,7 +113,8 @@ struct VirtIODevice
>>       uint16_t queue_sel;
>>       /**
>>        * These fields represent a set of VirtIO features at various
>> -     * levels of the stack. @host_features indicates the complete
>> +     * levels of the stack. @requested_features indicates the feature
>> +     * set the user requested. @host_features indicates the complete
>>        * feature set the VirtIO device can offer to the driver.
>>        * @guest_features indicates which features the VirtIO driver has
>>        * selected by writing to the feature register. Finally
>> @@ -121,6 +122,7 @@ struct VirtIODevice
>>        * backend (e.g. vhost) and could potentially be a subset of the
>>        * total feature set offered by QEMU.
>>        */
>> +    OnOffAutoBit64 requested_features;
>>       uint64_t host_features;
>>       uint64_t guest_features;
>>       uint64_t backend_features;
>> @@ -149,6 +151,7 @@ struct VirtIODevice
>>       bool started;
>>       bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
>>       bool disable_legacy_check;
>> +    bool force_features_auto;
>>       bool vhost_started;
>>       VMChangeStateEntry *vmstate;
>>       char *bus_name;
>> @@ -376,22 +379,23 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
>>   typedef struct VirtIORNGConf VirtIORNGConf;
>>   
>>   #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
>> -    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
>> -                      VIRTIO_RING_F_INDIRECT_DESC, true), \
>> -    DEFINE_PROP_BIT64("event_idx", _state, _field,        \
>> -                      VIRTIO_RING_F_EVENT_IDX, true),     \
>> -    DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
>> -                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
>> -    DEFINE_PROP_BIT64("any_layout", _state, _field, \
>> -                      VIRTIO_F_ANY_LAYOUT, true), \
>> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
>> -                      VIRTIO_F_IOMMU_PLATFORM, false), \
>> -    DEFINE_PROP_BIT64("packed", _state, _field, \
>> -                      VIRTIO_F_RING_PACKED, false), \
>> -    DEFINE_PROP_BIT64("queue_reset", _state, _field, \
>> -                      VIRTIO_F_RING_RESET, true), \
>> -    DEFINE_PROP_BIT64("in_order", _state, _field, \
>> -                      VIRTIO_F_IN_ORDER, false)
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("indirect_desc", _state, _field, \
>> +                                  VIRTIO_RING_F_INDIRECT_DESC, \
>> +                                  ON_OFF_AUTO_AUTO), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("event_idx", _state, _field, \
>> +                                  VIRTIO_RING_F_EVENT_IDX, ON_OFF_AUTO_AUTO), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("notify_on_empty", _state, _field, \
>> +                                  VIRTIO_F_NOTIFY_ON_EMPTY, ON_OFF_AUTO_AUTO), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("any_layout", _state, _field, \
>> +                                  VIRTIO_F_ANY_LAYOUT, ON_OFF_AUTO_AUTO), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("iommu_platform", _state, _field, \
>> +                                  VIRTIO_F_IOMMU_PLATFORM, ON_OFF_AUTO_OFF), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("packed", _state, _field, \
>> +                                  VIRTIO_F_RING_PACKED, ON_OFF_AUTO_OFF), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("queue_reset", _state, _field, \
>> +                                  VIRTIO_F_RING_RESET, ON_OFF_AUTO_AUTO), \
>> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("in_order", _state, _field, \
>> +                                  VIRTIO_F_IN_ORDER, ON_OFF_AUTO_OFF)
>>   
>>   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>>   bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index c23b39949649054ac59d2a9b497f34e1b7bd8d6c..0de04baa61735ff02f797f778c626ef690625ce3 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -38,6 +38,7 @@
>>   
>>   GlobalProperty hw_compat_9_2[] = {
>>       {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
>> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
>>   };
>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>>   
> 
> Confused why this is on.
> If set, this breaks existing setups if they run a configuration vhost
> does not support, does it not?
> And in particular, aren't some of these features exposed through
> libvirt?

This property enforces the existing behavior, which is to disable 
unsupported features even if they are explicitly set to "on". It 
introduces no breaking change.

> 
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index 896feb37a1caa805543e971c150d3673675b9a6b..75d433b252d5337d91616a2847b3dc12e811c2da 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -50,6 +50,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>>       bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>>       bool vdev_has_iommu;
>>       Error *local_err = NULL;
>> +    uint64_t features;
>>   
>>       DPRINTF("%s: plug device.\n", qbus->name);
>>   
>> @@ -63,13 +64,22 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>>   
>>       /* Get the features of the plugged device. */
>>       assert(vdc->get_features != NULL);
>> -    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
>> -                                            &local_err);
>> +    features = vdev->host_features | vdev->requested_features.auto_bits |
>> +               vdev->requested_features.on_bits;
>> +    features = vdc->get_features(vdev, features, &local_err);
>>       if (local_err) {
>>           error_propagate(errp, local_err);
>>           return;
>>       }
>>   
>> +    if (!vdev->force_features_auto &&
>> +        (features & vdev->requested_features.on_bits) != vdev->requested_features.on_bits) {
>> +        error_setg(errp, "A requested feature is not supported by the device");
>> +        return;
>> +    }
>> +
>> +    vdev->host_features = features;
>> +
>>       if (klass->device_plugged != NULL) {
>>           klass->device_plugged(qbus->parent, &local_err);
>>       }
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce37443bb46c4159761af112d0dba466b4..83f803fc703da6257608e21476305c8e9c6a8b07 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Object *obj)
>>   }
>>   
>>   static const Property virtio_properties[] = {
>> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>>       DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>>       DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
>>       DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>>                        disable_legacy_check, false),
>> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
>> +                     force_features_auto, false),
>>   };
>>   
>>   static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
>>
>> -- 
>> 2.48.1
> 


