Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84271E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqTW-00068v-G6; Thu, 09 Jan 2025 06:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqTQ-00068X-R0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:13:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqTP-0003ED-3U
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:13:12 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so6254695e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736421189; x=1737025989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eK37jaFLz8GvFBxLuBGQeby3QcG/VZgIu86cNaSfMkM=;
 b=jx6DO/obwQxLJGDU/5BrVOloi/Mf+stTBVPwFd/HVGTgDeBlgCskZGIxvhLH/TCIlZ
 esoC8vUbAROGnAyjnkvUNMk6jigYKa7mNKPVo7PIyg19Anj5Hr4RfsOTn8u2Q+hEjeRh
 v+o8bnPmytgVN5vupgsTbPBl7eZt5zhmIXGv1cU/eCaNtUvEWdqsc44sMo2RI0+MvVpR
 wQXhf4NZPRhChNJz4MfOJjSAyEXo+at82kWleepG9DJSaPTXFwIqlXV7jdGpkmV369BM
 fsWdM4yfg0NjORGkMjtXnE6ulZQ3MGkAIc2/W4eGdobx4jU4ZPKEjJA4+w4+E9uLAE83
 8vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736421189; x=1737025989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eK37jaFLz8GvFBxLuBGQeby3QcG/VZgIu86cNaSfMkM=;
 b=D0svjb/0j6nM4FXditykkeiE4UOXjW7cSe2sU3s/b1ZfhbTKqw6CqfKbt2qCupkFTX
 7qGZctHFH53cBGpARN/1ysbWDHficZV2KW+5uGnvPDzXY68XYfovMz2Zt50Fg5/JsHVJ
 BgpP3VXifVr5fU+ZayZ2ZJNbEzvsJVcRLAOb6a9Y5b3oP4NyEMW+EbLPzHcSG8CU+2X9
 gM4NpAEBrNLB+d0TbE78mDTu2qapHh9pg+CR1k9eNJ3dCP1jXah52M5mpXx+m5bDgGxg
 yXMYcuTFE9Plq8dl2t7L6/XxmDDqSttzfJ5viqQTJja0tyRVnJlUYUCrgurvmY+zgja/
 R0vw==
X-Gm-Message-State: AOJu0YxxgOB7VyOGVe0UCJYbGjanY8e36LLUlVrPbs43jwIJM0E/QRiC
 3Sj6BlP6Cx4mMur1/SAgwfs47w3d51jqQbneHMUDBPyeR0sPQToke0Do0TdlNY8=
X-Gm-Gg: ASbGncue5ra5AQlcs/6FfcuevMCUqgSG/aXlIV5IfXp9p8kDgV/wRNABid7joYzIiuq
 ayHm9FMiNz/OG9uNoaJksAWxgSNdgWpN/uwFVN1pzGV2DHNMQ2c9wRayk0JATtN+bj1YE02TUS7
 ydmJP7y0DRSSNPesjClEzy5YqB7ZJuQHkIQp0N/FQiouAOXhqi3RJACL0oXx5qgKvYsAsvmxjyz
 Iha7aTb9d6sjvMc56etcbb2gP+5pHHN8NPhlyCEL9agYfKcHVDck6wj4wvogN93jB5k8PPo0iNH
 hjTIIx0g/yQolP9NU9Vn3jHV
X-Google-Smtp-Source: AGHT+IGG6GnJh/iKfHcF2AaG0/gRzypOHMrip4+ZG/yl13wf0xi1mMPPxjT9HCeasyL+ymjnHlN34g==
X-Received: by 2002:a05:600c:5117:b0:431:60ec:7a96 with SMTP id
 5b1f17b1804b1-436e26ddc53mr47234745e9.25.1736421189491; 
 Thu, 09 Jan 2025 03:13:09 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89df1sm51108205e9.27.2025.01.09.03.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:13:08 -0800 (PST)
Message-ID: <8bc4699d-c7fc-4ac5-946c-093061f217a5@linaro.org>
Date: Thu, 9 Jan 2025 12:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] virtio: Convert feature properties to OnOffAuto
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang
 <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
 <ab58d4f7-6c73-4cf0-846c-ff20e3f5b481@linaro.org>
 <e340ea4b-3d8d-4b08-a1af-6514fab838a2@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e340ea4b-3d8d-4b08-a1af-6514fab838a2@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/1/25 12:08, Akihiko Odaki wrote:
> On 2025/01/09 19:56, Philippe Mathieu-Daudé wrote:
>> On 8/1/25 07:17, Akihiko Odaki wrote:
>>> Some features are not always available with vhost. Legacy features are
>>> not available with vp_vdpa in particular. virtio devices used to disable
>>> them when not available even if the corresponding properties were
>>> explicitly set to "on".
>>>
>>> QEMU already has OnOffAuto type, which includes the "auto" value to let
>>> it automatically decide the effective value. Convert feature properties
>>> to OnOffAuto and set them "auto" by default to utilize it. This allows
>>> QEMU to report an error if they are set "on" and the corresponding
>>> features are not available.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>>>   hw/core/machine.c          |  4 +++-
>>>   hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>>>   hw/virtio/virtio.c         |  4 +++-
>>>   4 files changed, 39 insertions(+), 21 deletions(-)
>>
>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index c949af97668d..bff26b95dd74 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -36,7 +36,9 @@
>>>   #include "hw/virtio/virtio-iommu.h"
>>>   #include "audio/audio.h"
>>> -GlobalProperty hw_compat_9_2[] = {};
>>> +GlobalProperty hw_compat_9_2[] = {
>>> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
>>> +};
>>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>>
>>
>>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> index 85110bce3744..83f803fc703d 100644
>>> --- a/hw/virtio/virtio.c
>>> +++ b/hw/virtio/virtio.c
>>> @@ -4013,11 +4013,13 @@ static void 
>>> virtio_device_instance_finalize(Object *obj)
>>>   }
>>>   static const Property virtio_properties[] = {
>>> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>>> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>>>       DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>>>       DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, 
>>> use_disabled_flag, true),
>>>       DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>>>                        disable_legacy_check, false),
>>> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
>>> +                     force_features_auto, false),
>>
>> This doesn't seem an experiment, so can we not use the 'x-' prefix?
> 
> I put x- prefix because it is only intended to be used for compatibility 
> purpose and users will not be interested in this.

I guess that's OK then.

