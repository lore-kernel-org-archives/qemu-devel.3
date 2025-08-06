Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F741C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 10:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujbWi-0002Pl-9R; Wed, 06 Aug 2025 06:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujbRw-00074C-8l
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 06:32:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujbRt-0005U7-9Y
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 06:32:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so1735815e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754476363; x=1755081163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oq97atyfe17sFbv+TGi9c5SZ9An6vPWxEggaVaOLTNY=;
 b=BZZAcp23YxmrhMHne76UTOg67oD34p9+oIOfjwaLJOKOMpjqsy/QRB6lSjb8nGCMp7
 1AvhlFUEKmOZI+iafBG86/hx/25KISXE2WVs5QO1BQKWNOFh4YO27JqCOpg/BS3CEi08
 8X1axXYh5831dWe3/4dlYp76TB5gxUvYXl/7R6C0lZLyf0x7Aw2p58ouCGnmBE40GHGS
 4iAf8zWdZJ9Xg0o4OEu9ZQG1Wj8+IUjRh4l9WwUWtduBMnSD9ABZfitZxbNppXoNOmQe
 dOqfvtqgYoafUoeGAdqQ3LKT265ooI3Hg5m3LxWs5gwJvmrwFeRwnyqPSA9M2zHraWbw
 MyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754476363; x=1755081163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oq97atyfe17sFbv+TGi9c5SZ9An6vPWxEggaVaOLTNY=;
 b=jAaj6QNU80whD8BQzcZzLdM4b0v13N+5ua4yGu1nFKai8VFbfowjdnVoAe6t4yOxPY
 iPjQQ/+83PMV3moFz5HhY8la7Z83fJEF7S+eeIau35Cev48DXknd0oyuOiA2efq1va6R
 QOnPsYFcbWzbdrdSdyU9LyNxaEJvkTFERBDxk/hSms//wyxO222vdSSTr7szsrqGsFst
 cQZEibb5oIQpj15Xj8GY8c34hBIuf4pVoK03XblIUWXimC8qWu4EVTABXftNnaBnqaAk
 jeYBv0FImb145wgFkgtq7yw49+l/r5D1pyqk93z230sYh1U3iKPxvqKePDlf2UEN1ymq
 FEHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaXdoWJhmLt3dPjxxjrO6TmE031O4Jacb9SpFDb576jNQqpUT7LjkKIC3fut9YTt2JgfhGc9/q5+pu@nongnu.org
X-Gm-Message-State: AOJu0YxGKythP/mWB/V1hzdjRvtXudIGkKawFETR874qx0nSfieTQlnx
 8mAt4PMCqLwDlm3/C4Lu68HtGVrxiFtNto3M2DNhM83Gy6DoWGlgkKlqsV7+gc3/2zM=
X-Gm-Gg: ASbGncuUul5hO5vQWxBcWKaNGOqOxnlsWsXzrAsgGEbK6vNKhn0zlu5TGr1kNkqXc+Z
 4aWyqV9I+/DYAQU0GTV6QmZ599cP2695lEkiufC33Dlkk3dkwLhhecnbIvydk6AVJKcCD7++gwm
 YofpGPmFG2XmfnzNb5PEjZA2NR8cXuRLwZ5uVB5Edkoy6p8lUCpMJankFloTGkBNrCA7T7WJJuS
 pIeQ+3bOgthLLlHUOJFrzObkU3D87xWXsEilKntRLcUgWurAfsnpQtF1SolOsN3ZLm9p2CxRQ5U
 tO4Ji5h2Js+JskXA1pSfKDQNDtgGfX4gubZg/w00rFqSgPWxfVab507fjTPD+aNIPiO9TcRKv7c
 MQIayZvXcWt6VCDhkAfQ+ywfhPcGwPNCH5KtKmDIwANRb7YCvscJqxIlpJQNrgC7Mjw==
X-Google-Smtp-Source: AGHT+IHpG72cixa3eZVOvVGmGyThvrLNXesJDdOZeWVVlNxC54s1FK4c12lR8BrtMJrzANgqhTaO6A==
X-Received: by 2002:a05:600c:1554:b0:459:4441:1c07 with SMTP id
 5b1f17b1804b1-459e745cf68mr16902525e9.20.1754476363024; 
 Wed, 06 Aug 2025 03:32:43 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5868fd7sm46814795e9.18.2025.08.06.03.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 03:32:42 -0700 (PDT)
Message-ID: <2a3bc971-828a-4e56-bba9-cc3dbc152b0e@linaro.org>
Date: Wed, 6 Aug 2025 12:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/13] hw/intc: Add hvf vGIC interrupt controller
 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov
 <imammedo@redhat.com>, qemu-arm@nongnu.org, Alexander Graf
 <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20250728134114.77545-1-mohamed@unpredictable.fr>
 <20250728134114.77545-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728134114.77545-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/7/25 15:41, Mohamed Mediouni wrote:
> This opens up the door to nested virtualisation support.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv3_hvf.c | 722 ++++++++++++++++++++++++++++++++++++++++
>   hw/intc/meson.build     |   1 +
>   2 files changed, 723 insertions(+)
>   create mode 100644 hw/intc/arm_gicv3_hvf.c


> +static void hvf_gicv3_put_cpu(CPUState *cpu_state, run_on_cpu_data arg)
> +{
> +    uint32_t reg;
> +    uint64_t reg64;
> +    int i, num_pri_bits;
> +
> +    /* Redistributor state */
> +    GICv3CPUState *c = arg.host_ptr;
> +    hv_vcpu_t vcpu = c->cpu->accel->fd;
> +
> +    reg = c->gicr_waker;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
> +
> +    reg = c->gicr_igroupr0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_IGROUPR0, reg);
> +
> +    reg = ~0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICENABLER0, reg);
> +    reg = c->gicr_ienabler0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISENABLER0, reg);
> +
> +    /* Restore config before pending so we treat level/edge correctly */
> +    reg = half_shuffle32(c->edge_trigger >> 16) << 1;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICFGR1, reg);
> +
> +    reg = ~0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICPENDR0, reg);
> +    reg = c->gicr_ipendr0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISPENDR0, reg);
> +
> +    reg = ~0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ICACTIVER0, reg);
> +    reg = c->gicr_iactiver0;
> +    hv_gic_set_redistributor_reg(vcpu, HV_GIC_REDISTRIBUTOR_REG_GICR_ISACTIVER0, reg);
> +
> +    for (i = 0; i < GIC_INTERNAL; i += 4) {
> +        reg = c->gicr_ipriorityr[i] |
> +            (c->gicr_ipriorityr[i + 1] << 8) |
> +            (c->gicr_ipriorityr[i + 2] << 16) |
> +            (c->gicr_ipriorityr[i + 3] << 24);
> +        hv_gic_set_redistributor_reg(vcpu,
> +            HV_GIC_REDISTRIBUTOR_REG_GICR_IPRIORITYR0 + i, reg);
> +    }
> +
> +    /* CPU interface state */
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_SRE_EL1, c->icc_sre_el1);
> +
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_CTLR_EL1,
> +                    c->icc_ctlr_el1[GICV3_NS]);
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN0_EL1,
> +                    c->icc_igrpen[GICV3_G0]);
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_IGRPEN1_EL1,
> +                    c->icc_igrpen[GICV3_G1NS]);
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_PMR_EL1, c->icc_pmr_el1);
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_BPR0_EL1, c->icc_bpr[GICV3_G0]);
> +    hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_BPR1_EL1, c->icc_bpr[GICV3_G1NS]);
> +
> +    num_pri_bits = ((c->icc_ctlr_el1[GICV3_NS] &
> +                    ICC_CTLR_EL1_PRIBITS_MASK) >>
> +                    ICC_CTLR_EL1_PRIBITS_SHIFT) + 1;
> +
> +    switch (num_pri_bits) {
> +    case 7:
> +           reg64 = c->icc_apr[GICV3_G0][3];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 3, reg64);
> +        reg64 = c->icc_apr[GICV3_G0][2];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 2, reg64);
> +        /* fall through */
> +    case 6:
> +        reg64 = c->icc_apr[GICV3_G0][1];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1 + 1, reg64);
> +        /* fall through */
> +    default:
> +        reg64 = c->icc_apr[GICV3_G0][0];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP0R0_EL1, reg64);
> +    }
> +
> +    switch (num_pri_bits) {
> +    case 7:
> +        reg64 = c->icc_apr[GICV3_G1NS][3];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 3, reg64);
> +        reg64 = c->icc_apr[GICV3_G1NS][2];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 2, reg64);
> +        /* fall through */
> +    case 6:
> +        reg64 = c->icc_apr[GICV3_G1NS][1];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1 + 1, reg64);
> +        /* fall through */
> +    default:
> +        reg64 = c->icc_apr[GICV3_G1NS][0];
> +        hv_gic_set_icc_reg(vcpu, HV_GIC_ICC_REG_AP1R0_EL1, reg64);
> +    }
> +
> +    if (!hvf_arm_el2_enabled()) {

This method is added in the next patch.

> +        return;
> +    }
> +
> +    hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_VMCR_EL2, c->ich_vmcr_el2);
> +    hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_HCR_EL2, c->ich_hcr_el2);
> +
> +    for (int i = 0; i < GICV3_LR_MAX; i++) {
> +        hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_LR0_EL2, c->ich_lr_el2[i]);
> +    }
> +
> +    num_pri_bits = c->vpribits;
> +
> +    switch (num_pri_bits) {
> +    case 7:
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 3,
> +                         c->ich_apr[GICV3_G0][3]);
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 2,
> +                         c->ich_apr[GICV3_G0][2]);
> +      /* fall through */
> +    case 6:
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2 + 1,
> +                         c->ich_apr[GICV3_G0][1]);
> +      /* fall through */
> +    default:
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP0R0_EL2,
> +                         c->ich_apr[GICV3_G0][0]);
> +    }
> +
> +    switch (num_pri_bits) {
> +    case 7:
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 3,
> +                         c->ich_apr[GICV3_G1NS][3]);
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 2,
> +                         c->ich_apr[GICV3_G1NS][2]);
> +      /* fall through */
> +    case 6:
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2 + 1,
> +                         c->ich_apr[GICV3_G1NS][1]);
> +      /* fall through */
> +    default:
> +      hv_gic_set_ich_reg(vcpu, HV_GIC_ICH_REG_AP1R0_EL2,
> +                         c->ich_apr[GICV3_G1NS][0]);
> +    }
> +}


