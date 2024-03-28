Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82397C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpr9s-00071s-MZ; Thu, 28 Mar 2024 10:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpr9r-00071a-W6
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:55:12 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpr9p-000755-G8
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:55:11 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56c0d1bddc1so1257924a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711637707; x=1712242507; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uoX910Z6hg0RstS8SMFU3Ch1UUOwdBuEYj1I/OsSdqA=;
 b=co2htj+/IJ2GZDlNOYx6wQ9qcHPHIIvQ8/oWEe9/AtBxDgTas4mnHAjdij4AvIL66w
 yw22RI6NOWeSngUr2fCcjxlAs4q7+dI3v/z7qDZxo+e0Kgoe1F170Hp31rB6vBtDkHoC
 2Y51knPQzZ6Wj1bLKuqC13wYs6GJA+LpKl2fiG7FJK/wckGgqgzyW84e7bNb6njFBjAW
 iTJEcecFbCeCK+LXrHruTulf7wEluRcY2I6v+6Gfq8WGSW7l1j/E5Ht7+UrsU6o2zZl7
 RJJLYwxCYpiYnlU6jdKH/7R4qqjlHM1HF3wySYgHCkREU54iZQHUYXRBxlJcce7SgqUD
 5OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711637707; x=1712242507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uoX910Z6hg0RstS8SMFU3Ch1UUOwdBuEYj1I/OsSdqA=;
 b=ScbGrtJIEwDqXZHVlOfOsTscPNZmfV2BV6WjMMiSIW3I+vBd3r+uOu76hM8hKvTM26
 55/qNbt69wwCr9C9X6EyKRH0U5I1g3gZfS+KuaoqBDs5X5KKrObc7fMoZWjCBsitDZMd
 yhDaUDoxKk3xIhCxF+HckMOH9kmwwFGfZ1CMdbxo27VopqCCTlFZmbEOYk44QwPcighG
 ocPEyyVONwvyCA0WGrrhSxfQBxeQtO8Ft8hMchqLKqFRRA5hhwhwvKQylYgATFDre1pL
 gXMifZWtFCiZQu6/s5gXQ6zzcLHsqR/Ovd8IVdzCn3ZNtLFlEWZ9p+Idc4xTR229bdmX
 Kv4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5U3D51ldCFhyD79NmQdMjkzR3eoR3/4FMoow1dcttjkNlT0vZxK01YfwXiZQFY7x02xqlv9V5K6vqyNZfdSkA/BAGuN8=
X-Gm-Message-State: AOJu0Yxu1BhvwVKxWrNz4CgFeET4RL7rIGT3Y17SaaqgqfE2jw45CFBn
 7G01CtOMhAhDSIRsZxSlalnthBo3fOpicYQ8dcvRRkPAKlv3d1yF32rcPY5r00UrsuhXhypd18F
 pwwmr/EJo0md5oD5aQVhoqoAZp7k1OZPPu91P6g==
X-Google-Smtp-Source: AGHT+IERNecHxlCrBizKrJy/SOswhGb+HYZTEe09s62ljKz7rs7Ahz0y/Cy/ZDkYwi3XWvYZgdBhoz53lW8Xbztblxs=
X-Received: by 2002:a50:c34d:0:b0:567:a318:ac0b with SMTP id
 q13-20020a50c34d000000b00567a318ac0bmr2453429edb.16.1711637707263; Thu, 28
 Mar 2024 07:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-15-ruanjinjie@huawei.com>
In-Reply-To: <20240325084854.3010562-15-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 14:54:56 +0000
Message-ID: <CAFEAcA9go1xe+UOBjH64nsRx-n6Tz3sp71qjb0Je=9r8nHBbuA@mail.gmail.com>
Subject: Re: [PATCH v10 14/23] hw/intc/arm_gicv3: Add irq non-maskable property
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> A SPI, PPI or SGI interrupt can have non-maskable property. So maintain
> non-maskable property in PendingIrq and GICR/GICD. Since add new device
> state, it also needs to be migrated, so also save NMI info in
> vmstate_gicv3_cpu and vmstate_gicv3.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v10:
> - superprio -> nmi, gicr_isuperprio -> gicr_inmir0.
> - Save NMI state in vmstate_gicv3_cpu and vmstate_gicv3.
> - Update the commit message.
> v3:
> - Place this ahead of implement GICR_INMIR.
> - Add Acked-by.
> ---
>  hw/intc/arm_gicv3_common.c         | 44 ++++++++++++++++++++++++++++++
>  include/hw/intc/arm_gicv3_common.h |  4 +++
>  2 files changed, 48 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 2d2cea6858..be76ae0be6 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -164,6 +164,24 @@ const VMStateDescription vmstate_gicv3_gicv4 = {
>      }
>  };
>
> +static bool nmi_needed(void *opaque)
> +{
> +    GICv3CPUState *cs = opaque;
> +
> +    return cs->gic->nmi_support != 0;

nmi_support is already a bool, so you can
       return cs->gic_nmi_support;


> +}
> +
> +static const VMStateDescription vmstate_gicv3_cpu_nmi = {
> +    .name = "arm_gicv3_cpu/nmi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = nmi_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(gicr_inmir0, GICv3CPUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3_cpu = {
>      .name = "arm_gicv3_cpu",
>      .version_id = 1,
> @@ -197,6 +215,10 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>          &vmstate_gicv3_cpu_sre_el1,
>          &vmstate_gicv3_gicv4,
>          NULL
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_gicv3_cpu_nmi,
> +        NULL

You add your subsection to the existing .subsections[] list.
Otherwise this field initializer overwrites the previous one.

>      }
>  };
>
> @@ -238,6 +260,24 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
>      }
>  };
>
> +static bool needed_nmi(void *opaque)
> +{
> +    GICv3State *cs = opaque;
> +
> +    return cs->nmi_support != 0;
> +}

You already have nmi_needed() above, so you can use it
as the .needed function for both vmstate struct definitions.

> +
> +const VMStateDescription vmstate_gicv3_gicd_nmi = {
> +    .name = "arm_gicv3/gicd_nmi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = needed_nmi,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(nmi, GICv3State, GICV3_BMP_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_gicv3 = {
>      .name = "arm_gicv3",
>      .version_id = 1,
> @@ -267,6 +307,10 @@ static const VMStateDescription vmstate_gicv3 = {
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gicv3_gicd_no_migration_shift_bug,
>          NULL
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_gicv3_gicd_nmi,
> +        NULL

Similarly here this must be added to the existing list.

>      }
>  };
>
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 4358c5319c..88533749eb 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -146,6 +146,7 @@ typedef struct {
>      int irq;
>      uint8_t prio;
>      int grp;
> +    bool nmi;
>  } PendingIrq;
>
>  struct GICv3CPUState {
> @@ -172,6 +173,7 @@ struct GICv3CPUState {
>      uint32_t gicr_ienabler0;
>      uint32_t gicr_ipendr0;
>      uint32_t gicr_iactiver0;
> +    uint32_t gicr_inmir0;
>      uint32_t edge_trigger; /* ICFGR0 and ICFGR1 even bits */
>      uint32_t gicr_igrpmodr0;
>      uint32_t gicr_nsacr;
> @@ -275,6 +277,7 @@ struct GICv3State {
>      GIC_DECLARE_BITMAP(active);       /* GICD_ISACTIVER */
>      GIC_DECLARE_BITMAP(level);        /* Current level */
>      GIC_DECLARE_BITMAP(edge_trigger); /* GICD_ICFGR even bits */
> +    GIC_DECLARE_BITMAP(nmi);          /* GICD_INMIR */
>      uint8_t gicd_ipriority[GICV3_MAXIRQ];
>      uint64_t gicd_irouter[GICV3_MAXIRQ];
>      /* Cached information: pointer to the cpu i/f for the CPUs specified
> @@ -314,6 +317,7 @@ GICV3_BITMAP_ACCESSORS(pending)
>  GICV3_BITMAP_ACCESSORS(active)
>  GICV3_BITMAP_ACCESSORS(level)
>  GICV3_BITMAP_ACCESSORS(edge_trigger)
> +GICV3_BITMAP_ACCESSORS(nmi)
>
>  #define TYPE_ARM_GICV3_COMMON "arm-gicv3-common"
>  typedef struct ARMGICv3CommonClass ARMGICv3CommonClass;
> --
> 2.34.1

thanks
-- PMM

