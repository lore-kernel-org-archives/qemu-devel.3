Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9FAF3C241
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZyC-0008Mq-RN; Mon, 09 Mar 2026 08:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZy9-0008MO-At
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:44:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzZy7-0003uR-Ew
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:44:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852f73d0a3so15326925e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773060257; x=1773665057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CmSUmdev+kEXuv1ysvKMfcwmLFTcMgNpOkOVIiGBGks=;
 b=UAHIt7iX7j68YJ+am5b17IzU0+O+dDPnTdoD5+iqDIJSzVE1CDcdaoUHxjN6D+tH3i
 NSn4fYguOAJ96h2wPGToa4RxDH99vW1VOz2LFesyG3N9yUwJN0tzsHQiceWOY93eXwq4
 G6diauX5TpWZc7umu+FAWAipL5/PV+fzhRBWLG4fAGaSWQzoirPwIhaS3VocE6I+9aOY
 /H+jrEkVuZ/k1zUsu/8KV0Ctr1RIYFbAYN5skqc67s4V+V0HTA9U+QZGchRjatzFEK1Z
 QtBOoCH3ECLYpzRM06AOCifBo9h7gS7amRbwLKQwfcBmxTvz2XflxHbUNAfRXvQFzSEG
 krjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773060257; x=1773665057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CmSUmdev+kEXuv1ysvKMfcwmLFTcMgNpOkOVIiGBGks=;
 b=Y5AQgsiYbdVC2qEhJO7BiQfXgrQfClqe+kXpJIarCdHqwmB3MtznLWZicSeNL0vLr6
 jQPeNVNPcns+R/rfl+1ZtFIDJHNaRBykJqHVjsxYKMiRes3J0HcAh2iHGEIi2H8sStJv
 64HdfW2QglmI3VzJR+p0kaLJqOqMD3NY0+H2he2iKDglxtIOIsiV1nyUZrY59IPoDbaP
 ElxUzNsF0jmgqo/6CwzX7A+/8WnC5pQf+dKsHIUd1PwAlyUI6/s4Q/poy77yXlv/gGTd
 jsKu6GX/VTOdpp2lwRphDOvjvUSJcx1t6naw45bU5lm8E7qpOIFu7t4tD/WECDShSFA6
 Gqxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy0WgmfklRaDNumgtMvpacry48W674JvReMqfZWjgVK39TF0Bn0asFn1OR7B/J/JFzoRzOQv29miIS@nongnu.org
X-Gm-Message-State: AOJu0YzMApz0uKWdTfINUckI7yJSPZUmdyfNrNBRX4FzBaGd7C4fMhDU
 chPyG5s6/K/ziL8fItZIwObHCYeHbBUCrA4sfv6U54eZlxlS0nAis9HRU4h79/dLBBA=
X-Gm-Gg: ATEYQzwTA7CQfnSIgHZuEsm2vDedvJde69328/BjiznpsKFb16Ynt/knAiesizhfCCy
 1hFFqM/SJzAJM8nYkWsm3R71FEGtsiHbcHaXPm32QYhgPthRGXk3t1RVkkyN0nLdB0vMqJi9Pi1
 Y4lXC5wAipFKjSCFclGeW0mHWDAKo1sej4NsUYBFDfVbUwDAv3V3i4lA149jCDW655T6gwghxtg
 o23ybKukETc5xLHIr7FC7Qxm8C0UYI4KOw5t9fRUQ4gKqP4pko7He/B3FjMsrdHW8zlz3VxHZ0E
 Rqe/55nNhZ94YWBtEyxmHM0VqvDFKABFdXPUeoKpdcqpC0Vi3A/42ggS1KtqYYTfGWwP9Q2Wz1I
 zckBr6/65LB4jZ1XDISeKjgH9Px6RAgXF0ULE3ii/iQjGDRNYMQDrclhdE3P8pxwDzpIB4xQigS
 MLrFkyHZzwSgmP/sBf3PS1SG+gn8WwR1aWipMHvlmZL/oiB/CYuoPO0Kg+wST8wiv6tA==
X-Received: by 2002:a05:600c:1e85:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-4852691c657mr185454085e9.6.1773060257286; 
 Mon, 09 Mar 2026 05:44:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853ffd6fe1sm18854655e9.7.2026.03.09.05.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:44:16 -0700 (PDT)
Message-ID: <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
Date: Mon, 9 Mar 2026 13:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, berrange@redhat.com, clg@redhat.com, 
 nathanc@nvidia.com, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260309092027.404489-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi,

On 9/3/26 10:20, Zhenzhong Duan wrote:
> We had 'x-scalable-mode' for more than 5 years and 'x-flts' for more than 1
> year, it's fine to remove 'x-' now.
> 
> This is a prerequisite to enable intel_iommu's scalable mode and first stage
> translation support in libvirt.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   docs/devel/vfio-iommufd.rst    | 10 +++++-----
>   hw/i386/intel_iommu.c          |  8 ++++----
>   hw/i386/intel_iommu_accel.c    |  4 ++--
>   tests/qtest/intel-iommu-test.c |  2 +-
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
> index 78bcdffac7..5755532443 100644
> --- a/docs/devel/vfio-iommufd.rst
> +++ b/docs/devel/vfio-iommufd.rst
> @@ -153,22 +153,22 @@ RAM discarding for mdev.
>   ``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
>   devices are always mdev and RAM discarding is force enabled.
>   
> -Usage with intel_iommu featuring x-flts=on
> +Usage with intel_iommu featuring flts=on
>   ------------------------------------------
>   
>   Only IOMMUFD backed VFIO device is supported when intel_iommu is configured
> -with x-flts=on, for legacy container backed VFIO device, below error shows:
> +with flts=on, for legacy container backed VFIO device, below error shows:
>   
>   .. code-block:: none
>   
> -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when x-flts=on
> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0: vfio 0000:02:00.0: Failed to set vIOMMU: Need IOMMUFD backend when flts=on
>   
>   VFIO device under PCI bridge is unsupported, use PCIE bridge if necessary,
>   otherwise below error shows:
>   
>   .. code-block:: none
>   
> -    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when x-flts=on
> +    qemu-system-x86_64: -device vfio-pci,host=0000:02:00.0,bus=bridge1,iommufd=iommufd0: vfio 0000:02:00.0: Failed to set vIOMMU: Host device downstream to a PCI bridge is unsupported when flts=on
>   
>   If host IOMMU has ERRATA_772415_SPR17, running guest with "intel_iommu=on,sm_off"
>   is unsupported, kexec or reboot guest from "intel_iommu=on,sm_on" to
> @@ -177,4 +177,4 @@ below if it's not needed by guest:
>   
>   .. code-block:: bash
>   
> -    -device intel-iommu,x-scalable-mode=off
> +    -device intel-iommu,scalable-mode=off
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d24ba989bf..001847ad37 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4200,8 +4200,8 @@ static const Property vtd_properties[] = {
>       DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
>                         VTD_HOST_ADDRESS_WIDTH),
>       DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> -    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> -    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),

IMHO safer would be to officially deprecate these in
docs/about/deprecated.rst and keeping them aliased until deprecation
period expires. Other changes LGTM.

> +    DEFINE_PROP_BOOL("scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
> +    DEFINE_PROP_BOOL("flts", IntelIOMMUState, fsts, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),


