Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E97E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDMH-0002AR-GO; Fri, 10 Jan 2025 06:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWDMD-0002A9-6C
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:39:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tWDM8-00078s-Bh
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:39:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216281bc30fso37636835ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736509150; x=1737113950;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EbgrizLzjOcEQNDptHPaENQR9HqwUNCIE3mVqEUD3g=;
 b=G+guQNnm7WdABE3PHgiXf7bjjuJwrocruMUAPtz9wUGhkUyA7YJqKpIXjLMVOy8FZW
 fM9trB+OKLIrOHBDBQYnH5LJkOj2KixYTRTFrzkoLLDt0bt06TzVXzb9Bf3TVCUuMQeS
 wdS3uRGMn7k/xjbCO6a5E85f6rEBj7OxTj+uUnIxwfr5kdAzkjVT+jn/fpR4oAFSYEEG
 yUqAbhOhUxK+khxC+CWF8HhWFNdIL/K/AooMnv/z3aqh829FbqyorlUWBXUKHjfnC/6+
 tAuqprCqHck1ss13tQFjRMQEt3Qpj/GWFVHl0TutUhRgHIxXRiW8SgiGzWzHvFkG9kDg
 1Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736509150; x=1737113950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5EbgrizLzjOcEQNDptHPaENQR9HqwUNCIE3mVqEUD3g=;
 b=hN/j2KJV/avUYH+mukWwKBuszWTLwWfHje/9r7/hGlMZYmkCRxi0LEMmLaEG7pHKs0
 xH4/QAUbm5lH5ZXqatLQWNLoNFWa5n3pFjMku0BpBO1ykqc4kbtI0HoYRFjbspfbtJZi
 8ifEVmEysto9TM+eYj1dMudZLC7j/dkO5SzAF4uveRMX4GVjeWpnjQ+3Y7JEwAyVaM3+
 pj2I5sBJmYMQ0Zb/NO2QX62aSC/CEoitM7V8XHLfZfWjkdLx6/RipVAWry9upcVyWNY4
 WpRUPREbodvHO/FxEc6me1M4VyMQgw81E2hr4b0R26+7u7ZIYKi8BnS68JnimhWRXOvR
 yTAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkHqcwiiV1/sQynKyD0j/l6hVIbXkSrCZ3v4kvivtcy9ppxDvDqM5Jzf34gWjXY7hBGAM4ExU+B5gV@nongnu.org
X-Gm-Message-State: AOJu0YyXidTonJPAyyycpf5Q12vjqkVSgMlxqAXFT4bZSOwbj95FHdKg
 wI2i1Sr5ZD/yEcG2SkTI4dveqZUiePBmdUU3n1jCHFOen5oSkuY2IluTGi+SETs=
X-Gm-Gg: ASbGnctjObyfPZiFOveAwuf22GjhrddjxlweuMyHYYd98myfe3vfsbGZQmTCnT95GAQ
 tqxvYtVjre+Hb2NsH19HHHQ51knYqoU+ymkLNOc8MP7aeUl4b/2W0F8nQ11KY71nwlEbmwELmt4
 U3Ruq+JnA6Y+8RTJRrgWMp2bQs2KOgu0hGO1Tf1pn5vNQzIkE2JAdGWDhEcM6z0uIXaeYTbwwnF
 688jfCGvpMs8lbzdZIchrSHOE3Fj147ko0lCgP7gBWFAzaEgRUBgJMiUR2Ih3m7eeA=
X-Google-Smtp-Source: AGHT+IHCgtnfum3QvAG5goxnpjNhbSBwrNKkM39SbAyamCecYBC0N/pJLtUEMju/r2BTkrM+hEXz3w==
X-Received: by 2002:a05:6a21:9217:b0:1e1:d26:6657 with SMTP id
 adf61e73a8af0-1e88d3069a3mr16207767637.42.1736509150086; 
 Fri, 10 Jan 2025 03:39:10 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31d5047ee1sm2720840a12.56.2025.01.10.03.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 03:39:09 -0800 (PST)
Message-ID: <da9113c4-f82e-437a-a985-75bc403c2321@daynix.com>
Date: Fri, 10 Jan 2025 20:39:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] virtio: Convert feature properties to OnOffAuto
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com> <Z4EDLXYf79H02LLS@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4EDLXYf79H02LLS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

On 2025/01/10 20:23, Daniel P. Berrangé wrote:
> On Wed, Jan 08, 2025 at 03:17:53PM +0900, Akihiko Odaki wrote:
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
> 
> This change is addressing two distinct problems at the same time.
> 
> The first (big) problem is that permitted host features, and user
> requested features are both stored in the same field. This is
> logically solved by separating the fields to 'host_features' and
> 'requested_features'.
> 
> To maintain the ability to have automagic disablement of unavailable
> features out of the box, however, requires more than just a single
> bitmask for the requested features.
> 
> There are two approaches to this
> 
>   * Separate the tracking of "has value" from "value", with
>     "not set" implicitly representing "auto". ie two bitmask fields

This approach has its own problem described in the following thread:
https://lore.kernel.org/all/d4f53c8b-4267-4386-bfa6-40ee2b1bbb49@daynix.com/

> 
>   * Switch from bool to a tri-state, with the new default
>     value being "auto". ie an araray of enums
> 
> The second approach there requires user visible input parsing
> changes as proposed in the previous patch.
> 
> The ability to explicitly set "auto" on input is only required
> if the built-in default value could ever NOT be "auto".

Specifically I want the "rss" property of virtio-net be "false" by 
default as it is useful specifically for Windows.

> 
> If we can assume the built-in default is *always* auto, then
> the user can request 'auto' by simply not setting the parameter.
> 
> I'm not especially convinced that we need an explicit "auto"
> here, and a variant of DEFINE_PROP_BIT64 could work that let
> us track 'has value" from "value" would be sufficient.
> 
> If we do want an explicit value, then IMHO we need a better
> solution than hacking OnOffAuto to secretly parse bools
> without this being represented in the QAPI schema.
> 
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>>   hw/core/machine.c          |  4 +++-
>>   hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>>   hw/virtio/virtio.c         |  4 +++-
>>   4 files changed, 39 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 638691028050..b854c2cb1d04 100644
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
>> index c949af97668d..bff26b95dd74 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -36,7 +36,9 @@
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "audio/audio.h"
>>   
>> -GlobalProperty hw_compat_9_2[] = {};
>> +GlobalProperty hw_compat_9_2[] = {
>> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
>> +};
>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>>   
>>   GlobalProperty hw_compat_9_1[] = {
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index 896feb37a1ca..75d433b252d5 100644
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
>> index 85110bce3744..83f803fc703d 100644
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
>> 2.47.1
>>
> 
> With regards,
> Daniel


