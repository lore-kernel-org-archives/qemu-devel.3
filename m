Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED5E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqD5-0008WE-My; Thu, 09 Jan 2025 05:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqD3-0008VZ-NE
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:56:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVqD1-0008Kk-Ts
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:56:17 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e27c75f4so563071f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736420174; x=1737024974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X0zaaqz+HMs+2kzPCv/+GoYdD8KNAf/Ner0/Pr4VVyo=;
 b=iws0if7iC6lFz+/VMSTLnl2iRLADh1cd9WDbKzHIPrSEPRo2EiThWGw2bI5sPzj2dN
 HyYnMzVYGv0oAE0/5ht8NM+n2EdHI1mX4J/1FZ3aEJ7G7D3c/fmMRzADj9YVwCPNj5LQ
 QHyZN6YTbMBTBNE75RkzDTJHpVSNR8tMc19wXG4N4yg6EpPdOe8B2IOv5+nE0ZCy8a4I
 Mx/TA29ArYO4K0NezWE5RXR77t2gYXgGhyuUkMm2T5EnGZBKc540zNvbhOQkewiYbvbQ
 5zTSVv1Q8Kv2hUwZZua189HtRX11wXZqQ93LBTgopobqg7oBTOTgPlvC5EX+4pAkYktx
 GKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420174; x=1737024974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X0zaaqz+HMs+2kzPCv/+GoYdD8KNAf/Ner0/Pr4VVyo=;
 b=NcAKhkjUsnTzNVT7TJcgyOoC65tsPBtZOpVQ7w+yLiuy09a8jXYtNsVTWN4bsr+WsF
 KNSdnY5Ml0PU+4mWUn7hdw90iJPwLAyGuJs0myTLRmd05m5rbfsxv/+hK9NqjP8CsWfe
 BRXp4dtGV7yuD9X/qqUkv0O5p52gGXDL254zQ0PHwfHmYZr5+UInOCkNyD7wE+HmsCGJ
 3GOhfHYmKDgRm76DcXk4It3s/x9+6xjoPKCKUifEQmA6/gV5Qj7a6BepzVp7FqpGS6fL
 IS/6KflzFI3HUb35ajudDrb7LDc0gCi0jKw/FCl0lJzEhK2FjJ7IGFJxgeukOWXPX3zy
 SHAw==
X-Gm-Message-State: AOJu0Yz2GCHPQH6DUJioCroh/Bk4JgHG8Ud0UfdYPBT1oZx/ZYplM4Ji
 RJIWlyZYh6kxheThzuZhi7lEnOqyJY3qcinesj4spXF43P1Y4WMcafeBmc1WfQY=
X-Gm-Gg: ASbGnctfmMZsrTvAAsPEpPE368w80em0nbqZWrCY8AtDlOXfsRtSD8HMrLIsUuOaJzg
 3EGa31gSJYwAciDhyQMtHSy9NR23nXFswVbF73yBr4dtKz4qwjODDdBYY7rdZfklh1DNmDQeyTQ
 ylISFC2E5zXzCYI4GyiiRdIL+dzYOn4Q0cRhmYCfHyK1WX9zYxAXD0m514MRXo7hX8odC1vOpo2
 zXTvoiEJFl+0R5tVJgGZuuTZAgr+o1rkcwXVARzWBpnmOoxs3fM4Ty67wXwcqNp1oqp1ei5MhvG
 3K8HDZSTGwMvioDuFWj//5Do
X-Google-Smtp-Source: AGHT+IHawUG1H8XFuyWYJxIr3Ab6HzuoiuJPK40bDBrqHiBtCa+hhLByoZYWWzDV3axPjZ5nxvdnWg==
X-Received: by 2002:a05:6000:2a2:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38a89066f45mr4874258f8f.38.1736420174226; 
 Thu, 09 Jan 2025 02:56:14 -0800 (PST)
Received: from [192.168.69.102] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e36asm1468551f8f.5.2025.01.09.02.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 02:56:13 -0800 (PST)
Message-ID: <ab58d4f7-6c73-4cf0-846c-ff20e3f5b481@linaro.org>
Date: Thu, 9 Jan 2025 11:56:12 +0100
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
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 8/1/25 07:17, Akihiko Odaki wrote:
> Some features are not always available with vhost. Legacy features are
> not available with vp_vdpa in particular. virtio devices used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
> 
> QEMU already has OnOffAuto type, which includes the "auto" value to let
> it automatically decide the effective value. Convert feature properties
> to OnOffAuto and set them "auto" by default to utilize it. This allows
> QEMU to report an error if they are set "on" and the corresponding
> features are not available.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>   hw/core/machine.c          |  4 +++-
>   hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>   hw/virtio/virtio.c         |  4 +++-
>   4 files changed, 39 insertions(+), 21 deletions(-)


> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c949af97668d..bff26b95dd74 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,9 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "audio/audio.h"
>   
> -GlobalProperty hw_compat_9_2[] = {};
> +GlobalProperty hw_compat_9_2[] = {
> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
> +};
>   const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);


> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..83f803fc703d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Object *obj)
>   }
>   
>   static const Property virtio_properties[] = {
> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>       DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>       DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
>       DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>                        disable_legacy_check, false),
> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
> +                     force_features_auto, false),

This doesn't seem an experiment, so can we not use the 'x-' prefix?

>   };

