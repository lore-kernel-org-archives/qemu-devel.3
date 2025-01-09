Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA3BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 11:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqOd-0004if-Ao; Thu, 09 Jan 2025 06:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVqOb-0004iS-Rb
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:08:14 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVqOZ-0002gV-Rs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 06:08:13 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so1067876a91.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736420890; x=1737025690;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qrZ34Yt+E9yeUIj956uMzWETJkcLW+RsxmJW/rJJr4I=;
 b=E19vL0nEvQlmaPLLy8Ix3b3TthQI21ar1wJ/V6JZPm6byp3AZ7JlMEoSUQs8L7EOpp
 2f2EtLi8bo/aTF3tbA6lvpZeJwO0ulaBLaK+FG+wRgzDlEx6hRSLwGKbAH77SKqx6KhO
 OcnfwjfLxt5bHe5UHLmwZiw3kiou418JqGcnxLLYNgZL3yRkb2W6dG22iyTf1Eo4eKkd
 2heZmHedt1d6CpBCAlTn+TEkP3eu3K6YlXNTRBJe7OLmTgnjwHwq0CIBnxtad3/876pG
 CIjjGWaecNhpktBO4ehx+p6DnO/PdvPwEYqEBxQp7YoDGZcsmX5REWjwuh8JR+/V8OJa
 ib0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420890; x=1737025690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrZ34Yt+E9yeUIj956uMzWETJkcLW+RsxmJW/rJJr4I=;
 b=EgZv5Ua1YqXH6NHAP6i39EfiUyb/ajF9eAaqJrSc6gxLao8nK1BArZycxTXGWDK/+i
 cTEy38Lgx3/vqKkc9g9XTpIHY50YoqqjNqkzKdljhwVGTiOgo6E3zwNU6EF9uTlCyO/y
 IOvRs6p5es0qOWAOvQmQzw8cJAKwpM54QhKoEDSALB5lWGz7R6YS5Vlp13uEwVe5ZnlV
 h225ugHONszxj9id4ObWyOLGQl/t7loikETQ2GXXbq8f5nfw8cppJtPtTKvP3vz2q7rZ
 1JmeIu4ro84ZEUEPzWxI8YxbAHz6MWd1+sMvlnvtAH4o8Osl+FBqzDjVqKXMulcYLX/o
 es1g==
X-Gm-Message-State: AOJu0YyA68e5da22ZQeFt/cm69INq98qarFmDUAhTxj+armuv+hmJFe/
 fByAYioxlssnoYkqIU/vifjk15HYzReWa3SuBW0bPquFpA89JJDiwyQh+VRSYIY=
X-Gm-Gg: ASbGnctJsCBiatjPVuRjwIQo/BBqBYGAQ6Z6PEwN5XPMMxaw3iYCvmXnTg0BRU627wj
 zgFwOE02IJILrRMOUpolbDd2vIXh+vj5mBGcvTSaqmJ1Imtf4S+HO6AM9YWvHkZ7FyCfGoGF96w
 IilsWnfLjTaYMvIonTsPCBMZwnLfvT99ATJAmv8pVLgnan7CfTxENPKLw08ksdw4i7k0j8AB8QF
 c+ptGUvxh75dRWrd8AUi+zAs3//WjjJfSRgGzxtoG/GUEGFOzZC3RVUOmK5K7nsbYI=
X-Google-Smtp-Source: AGHT+IHm6pbGlPasUfC2a+YpodYF8x0eh1k7Uz8zjqlev4csoLTuzBhGq2X2Ppt0F8IPWf1b79eRaA==
X-Received: by 2002:a17:90b:3a0c:b0:2ee:accf:9685 with SMTP id
 98e67ed59e1d1-2f548ea4c98mr8939825a91.4.1736420889707; 
 Thu, 09 Jan 2025 03:08:09 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca02397sm344569625ad.238.2025.01.09.03.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 03:08:09 -0800 (PST)
Message-ID: <e340ea4b-3d8d-4b08-a1af-6514fab838a2@daynix.com>
Date: Thu, 9 Jan 2025 20:08:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] virtio: Convert feature properties to OnOffAuto
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>,
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ab58d4f7-6c73-4cf0-846c-ff20e3f5b481@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
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

On 2025/01/09 19:56, Philippe Mathieu-Daudé wrote:
> On 8/1/25 07:17, Akihiko Odaki wrote:
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
>> ---
>>   include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>>   hw/core/machine.c          |  4 +++-
>>   hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>>   hw/virtio/virtio.c         |  4 +++-
>>   4 files changed, 39 insertions(+), 21 deletions(-)
> 
> 
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index c949af97668d..bff26b95dd74 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -36,7 +36,9 @@
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "audio/audio.h"
>> -GlobalProperty hw_compat_9_2[] = {};
>> +GlobalProperty hw_compat_9_2[] = {
>> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
>> +};
>>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
> 
> 
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 85110bce3744..83f803fc703d 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -4013,11 +4013,13 @@ static void 
>> virtio_device_instance_finalize(Object *obj)
>>   }
>>   static const Property virtio_properties[] = {
>> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
>> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>>       DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>>       DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, 
>> use_disabled_flag, true),
>>       DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>>                        disable_legacy_check, false),
>> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
>> +                     force_features_auto, false),
> 
> This doesn't seem an experiment, so can we not use the 'x-' prefix?

I put x- prefix because it is only intended to be used for compatibility 
purpose and users will not be interested in this.

