Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D55ECD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLJnq-0005KC-Iw; Fri, 08 May 2026 07:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLJnn-0005Jl-39
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wLJnl-0004fm-BP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778241328;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WsxtBHLSHqKqyisDPYE5u0LkoD80jxKDWGsBFVoBR38=;
 b=MXZfVNcZNYzIItAn5bVnjCa4HOGMimRffhbbXqai4TDRLxrq7nG7a8cx/v4khTiDxFG911
 +Jgf7llPIJY0T+mfWoWPOBtan0EOM8CLV5eApY7NzacLPI5JMsofMnD+ksW6z/gofS1uP9
 IqIpR72IieCxHM2x0pUWWzjBxTR19MM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668--iBEc0bcPHeROTMCt89-xQ-1; Fri, 08 May 2026 07:55:27 -0400
X-MC-Unique: -iBEc0bcPHeROTMCt89-xQ-1
X-Mimecast-MFC-AGG-ID: -iBEc0bcPHeROTMCt89-xQ_1778241326
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488d3eec9bcso13257435e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 04:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778241326; x=1778846126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsxtBHLSHqKqyisDPYE5u0LkoD80jxKDWGsBFVoBR38=;
 b=UZF5901j++M9MUuFNF+rfMfSPKDZQ6HeCLR4dP0/ZIOpe6jVwEYJZjrn1pWeCWiuid
 jBwpjuefiZ1mphgTlpmI9CTZ1jUakZx5Xr6pHIkLpxFShTvrv/NJ345zw3TTTwcSYSAZ
 R35inTBNsYMqYcbzd2DOu8luHqkh2yo9S8tfn3fQFFZ7zMaxcLeLH9VwK1/qG7SYUINE
 0NDMQ3CDt+DY36Jo18TERb7E5wtNYFO358STL6kCqjKqzxLYF8+pV7gbTeCijWNUHyds
 PZF/CfHUDeTJfOJYIcRtemr+5OlvZmPfaBVvop/fn1d1KWt4cOx9adYUHYSzb9lX/lDK
 6Bnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d+sPoejcmm6N16kaRRaJTouezfyYCiNcRSJyJXxKXZkM6eg1wgw5ydjpe6dDvdOzN+Cwai1IlHyp1@nongnu.org
X-Gm-Message-State: AOJu0Yx9bIOArkPTVluwVui/boev9+YnjnKUfLCu2BhqE6AfZC9gnQCJ
 ncnLUOWude9jr+5iih7A/iq5rkj/5kul4Hvfmv31+Wc/DF4IYAJiyh1fGi/KOVQ23xc+HZr7lR5
 97SGQQEzZ8g0eKFAPmv3yMmgRFNZ7xhS+gHM7Z9w4YE6mXVwjJXmR84pF
X-Gm-Gg: AeBDieu4R5+8Z/KsaFsRjIQ7ZhkPkMOj50b1yl5Jm1D4w7dwK2QG5pDTENLsWSyWyTp
 raavCp/xpYcp8VYVkoU6zaAGEwu/eWJsOWA8iWHDJoqZfO5nFnzNA8L93LlumuzM+sWKrI1I06I
 Tvn7M61TkY3vN951K9VJPxiAAVusTkgq5/M5BSqspFHFnijFgLD/8fhD6SBU/1/JMj2OsCo9mC0
 cdAmviMyrIm59HXIz+yh3ULfxLnf8W203Z0znITQ1EwXn07Bpwwx+zB4dUPE/7ZVP5ffmm7AbAy
 RZKoai8RQM+R3rDosz3/g7SNedsILD8ro2ZSjVtRV/r5Q8dpwAR6cpEI1YLzR08bHo9eheHcBxh
 zOFxifQdUvxqGHQncrQW6umalSyW415LdW+D5JlRhE/A77UPc/LNZIsJDzyHYDelzsvuplw==
X-Received: by 2002:a05:600c:3ba8:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48e52bd5035mr219722285e9.14.1778241325935; 
 Fri, 08 May 2026 04:55:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba8:b0:48a:7676:30bc with SMTP id
 5b1f17b1804b1-48e52bd5035mr219721695e9.14.1778241325445; 
 Fri, 08 May 2026 04:55:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68eb85d7sm32743005e9.7.2026.05.08.04.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 04:55:24 -0700 (PDT)
Message-ID: <c258d8b4-6086-4292-9d66-e34e0a060bee@redhat.com>
Date: Fri, 8 May 2026 13:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
 <20260422204335.23116-7-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260422204335.23116-7-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nathan,

On 4/22/26 10:43 PM, Nathan Chen wrote:
> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
> to match the host IOMMU properties when accel=on.
>
> If accel=off and these property values are set to auto, the default
> property values defined in smmuv3_init_id_regs() for OAS and RIL will
> remain unchanged, while SSIDSIZE and ATS values will remain initialized
> at 0.
>
> Introduce a new compat for the changed defaults.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3.c   | 14 +++++++-------
>  hw/core/machine.c |  8 ++++++++
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 39a6f72938..e8ca6be34a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -2135,11 +2135,11 @@ static const Property smmuv3_properties[] = {
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
The previous suggestions I gave wrt AUTO mode only held for accel mode.
So maybe we should put the consolidated info in qemu-options.hx and not in 

object_class_property_set_description. In this latter we shall only list valid value default.

Here I would add a comment reemphasizing that AUTO values for non accel
is ON/OFF/44/0

Thanks

Eric
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> -                              SSID_SIZE_MODE_0),
> +                              SSID_SIZE_MODE_AUTO),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2167,7 +2167,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "configured in nested mode for vfio-pci dev assignment");
>      object_class_property_set_description(klass, "ril",
>          "Enable/disable range invalidation support (for accel=on). "
> -        "Valid values are on, off, and auto. Defaults to on. "
> +        "Valid values are on, off, and auto. Defaults to auto. "
>          "Please enable if host platform supports RIL, and disable if "
>          "host platform does not support RIL.");
>      object_class_property_set_description(klass, "ats",
> @@ -2176,10 +2176,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "Please ensure host platform supports ATS before enabling.");
>      object_class_property_set_description(klass, "oas",
>          "Set Output Address Size in bits (for accel=on). "
> -        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
> +        "Valid values are 44, 48, and auto. Defaults to auto.");
>      object_class_property_set_description(klass, "ssidsize",
>          "Set number of bits used to represent SubstreamIDs (SSIDs). "
> -        "Valid values are 0-20 and auto. Defaults to 0. "
> +        "Valid values are 0-20 and auto. Defaults to auto. "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "A value of 0 disables SubstreamID support. A value greater "
>          "than 0 is required to enable PASID support.");
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0aa77a57e9..a668bb2ec3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -37,6 +37,14 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
> +#include "hw/arm/smmuv3.h"
> +
> +GlobalProperty hw_compat_11_0[] = {
> +    { TYPE_ARM_SMMUV3, "ats", "off" },
> +    { TYPE_ARM_SMMUV3, "ril", "on" },
> +    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
> +    { TYPE_ARM_SMMUV3, "oas", "44" },
> +};
>  
>  GlobalProperty hw_compat_10_2[] = {
>      { "scsi-block", "migrate-pr", "off" },


