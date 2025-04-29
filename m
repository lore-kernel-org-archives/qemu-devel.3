Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76527C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n9h-0004ER-FB; Tue, 29 Apr 2025 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n9R-0004Ca-Az
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:45:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n9P-0000kd-AH
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:45:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c14016868so6272761f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745941537; x=1746546337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=np9xqL918gw2Ubbb/06D9MCBoIwQQnlrKQUY8EH6ues=;
 b=JU2YKuM+NKMoqG6fvWnm2Cw0IxypUjsNsMfNlq1BE2c6Oiw5f2zVNh8Cel84cx86fn
 sZbhLsUF4wzsPURzN6AGWpy+sZXGo9xcy8/rIa2PjetinYhXuopEXfZmwA1v4aLdSiq8
 fBIWnQm6e/6pCMpYw4Pyybjh6H6/QIF+9rK/Upc1DpQe4/ODssyOrkETGcJyWKItcdLY
 IviD40pAEqMiK0Z3CtQAUdvo2DrhKp76VqbIxx8oFGThij35JK1bLV/9DKN4XXP8SYGh
 XXOL91Qq6p19+tCTIg6365LoATWFnyyqPU7JB+AdwEv0h+HJxnVlqvJ0Fv7V1Ujw8RG5
 VKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941537; x=1746546337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=np9xqL918gw2Ubbb/06D9MCBoIwQQnlrKQUY8EH6ues=;
 b=Ed7dZz+4FOgpnM+2zWla5g3Qg2ixgSOtZcOdX1QhUsR5DnDA+OB6IW/Rt+yKWifn87
 MGW7UFyMMR8M//oj0iHDOsjDsEXB9GN47ji53Y7owCCBnWiUHAsCpVC/uuhRqCFXau20
 UakVqfDXFje+ew1qYfx1/8jL3aNdkOGTkyUEccKsXoSzIZnU3sYS28NQ+8ZHa4sQ8hIa
 ZjcvfenPU5AojYhT5McV54M3RVK+QH9z5TGFg+rC13AZ2r29fGqNoGUiXeMhU95i1SCi
 BIC8vIR1MFk39UbOpuHlV+zG6js3chI2TllAOpVqn8ff1Noz3Aixzmiphc48SxNkrmzT
 s38Q==
X-Gm-Message-State: AOJu0YwSw5rHy69urfZ1QaSsS/sBWFoUqjfhG2hgwnSWSLckpTgE3bn0
 cxZfTjKA8jFYByAPa1ysRmF44XzWsVnw4DIkJgk52UDaGv5xzngQUB3F48KuwLC1tbXgG7mvC2m
 8
X-Gm-Gg: ASbGncsbFRxajb/gZHWGvVpyaYcuUDZMVwJy++7qThv8x9jIkNYX6ThFk0PplqrBQ0o
 PCEYlkPkRlVBR3LY9iw8Hh8pSkkTcV0QZr1rcJmEHPDFRAOj6XXVJLx5P3SZ+41udjPbnkmHdDY
 PexJ5zhUXDvoJvUTCPIzN1RwCetQQVYtAWYC0jd0EOO3nj+T3DFWrE8bthWCnQIy/eDKCIir7t/
 rc3pgJvhYLRYFSiksz9tWlZtCaP/rk2HPAUjwFksg7QL/VXHtoqD/at/aEuqCwxlBEcIfKehPLI
 ufp0+IzM3mHfC5J+YTLOoeuNeKWK+bercpKV0staiO+mhPbR/uH8BTAb+wycPjDT/493Sx+v6AU
 HyIpVEVAYn7/UDg==
X-Google-Smtp-Source: AGHT+IEykHNYIT1InuXWhHaD4M0JtKo/cPRpCCR+QWkBG9QQlRsB1TBHBryBFAU1qvOz7Rtx9GUgfg==
X-Received: by 2002:a05:6000:dd2:b0:39c:142a:ed6c with SMTP id
 ffacd0b85a97d-3a08949d877mr3492048f8f.40.1745941536969; 
 Tue, 29 Apr 2025 08:45:36 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e4684csm14227934f8f.76.2025.04.29.08.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 08:45:35 -0700 (PDT)
Message-ID: <3c2c4f90-92a2-41e0-b6c8-71c058ffab7f@linaro.org>
Date: Tue, 29 Apr 2025 17:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 03/13] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
 <20250116145944.38028-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116145944.38028-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/1/25 15:59, Philippe Mathieu-Daudé wrote:
> The VirtMachineClass::disallow_affinity_adjustment
> field was only used by virt-2.6 machine, which got
> removed. Remove it and simplify virt_cpu_mp_affinity().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/arm/virt.h |  1 -
>   hw/arm/virt.c         | 30 +++++++++++++++---------------
>   2 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 27c5bb585cb..5d3b25509ff 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -117,7 +117,6 @@ typedef enum VirtGICType {
>   
>   struct VirtMachineClass {
>       MachineClass parent;
> -    bool disallow_affinity_adjustment;
>       bool no_its;
>       bool no_tcg_its;
>       bool claim_edge_triggered_timers;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0080577e1a9..53f4a96e517 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1759,24 +1759,24 @@ void virt_machine_done(Notifier *notifier, void *data)
>   
>   static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
>   {
> -    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
> +    uint8_t clustersz;
>       VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>   
> -    if (!vmc->disallow_affinity_adjustment) {
> -        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> -         * GIC's target-list limitations. 32-bit KVM hosts currently
> -         * always create clusters of 4 CPUs, but that is expected to
> -         * change when they gain support for gicv3. When KVM is enabled
> -         * it will override the changes we make here, therefore our
> -         * purposes are to make TCG consistent (with 64-bit KVM hosts)
> -         * and to improve SGI efficiency.
> -         */
> -        if (vms->gic_version == VIRT_GIC_VERSION_2) {
> -            clustersz = GIC_TARGETLIST_BITS;
> -        } else {
> -            clustersz = GICV3_TARGETLIST_BITS;
> -        }
> +    /*
> +     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
> +     * GIC's target-list limitations. 32-bit KVM hosts currently
> +     * always create clusters of 4 CPUs, but that is expected to
> +     * change when they gain support for gicv3. When KVM is enabled
> +     * it will override the changes we make here, therefore our
> +     * purposes are to make TCG consistent (with 64-bit KVM hosts)
> +     * and to improve SGI efficiency.
> +     */
> +    if (vms->gic_version == VIRT_GIC_VERSION_2) {
> +        clustersz = GIC_TARGETLIST_BITS;
> +    } else {
> +        clustersz = GICV3_TARGETLIST_BITS;
>       }
> +
>       return arm_build_mp_affinity(idx, clustersz);
>   }
>   

Missing:

-- >8 --
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f4e5a93f0c5..9a6cd085a37 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1766,3 +1766,2 @@ static uint64_t 
virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
      uint8_t clustersz;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
---

