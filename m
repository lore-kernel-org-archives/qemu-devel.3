Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37639C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzT5G-0004Kb-IG; Thu, 27 Aug 2026 01:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzT5A-0004JZ-9S
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:55:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzT58-000700-AW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:55:23 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso718882a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787810121; cv=none;
 d=google.com; s=arc-20260327;
 b=q8u4vc9P5cyjAjadTF/5kP9nuc1ffLskw6VZVL+BLfNeF46M4V1saElM+ALG3vPwMq
 d0n3G5OZ8oclxFgJ6XPWRiWf1Tnd+Bf4LxDapzmXN+Wt47h92cUZFOIjl57bV43iikcg
 MeEnpR1mi2lkHERtCSCyp1SPKpZX+0oo/GI3azyCmEpEQMTn7C5Fa6swOktYAsvtsSy6
 vLDIFs2B9ZTCFO/uxJKouNSCrxHheflK/PZmb2Bl/hfnSW0LWYcyYrWIdF089GhWv/9e
 S2Gn1OjmYq1DQR1QuzoYocHpzfHt8yL6CTFuNkw0KQLVk6eMI4NsshrOo9nmCglOy8ms
 +rQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hNDdHdJQii9xS9RObhFAPMFYRZPxzrhOTdKefGyffYc=;
 fh=Per2Qv/4GGtpnoasDFXjOSn0I4kYI1g5zM44b59yZOQ=;
 b=NQzUR/2sqklfLZ/VtsFgqe1KuzIyTgqvB2o1FLsK2HfV0E6KvTP5iBb5SV8r6f8lko
 czKLirt0eqLbsHldd/iWIldJp5s1xgH4Yj5gf6vxapSHLWAVB4kM0+9UwpXzxlyy09Tp
 Kfj1gCFSQqOE437KJutt8A4PCs1fSXzhS8lcnJSnkofdaKmnQeKZf64QL42xxMK7ZbSY
 MAuPhDNsoeC9Y0dn+IsJ74Ko31ViIzPRMnlNsTKb+EegOq5e2AX9w8A7i0NTw9LNuFry
 KRre4SBMYFLkJ935YOh2Nd6xQBmwvVC/2+QWGfE6H2xDJORHK4RYHSBo2gOpDLxYPYVA
 LCeA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1787810121; x=1788414921; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hNDdHdJQii9xS9RObhFAPMFYRZPxzrhOTdKefGyffYc=;
 b=EmDlIJDp+046Gs1lb4w1e/9i2qscbO/9aRsXzmpKSz0+Kym9yYrjJV2Rdo4jHOl9SY
 5TRHE106273nYpvQcTPk6y6JlwG6+LcRx4LpZVKxU/S4VBPewo9rB5vtou0TKe1zfpOu
 G5N8t111ASzvP4dY4rr2fPOLIqChs6sSEUbUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787810121; x=1788414921;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hNDdHdJQii9xS9RObhFAPMFYRZPxzrhOTdKefGyffYc=;
 b=UHyRux9HnAdIdqy5FwXyZkw/uegRHgQJjR/atjLxOHBC01gwOhdVoWn2YkkXGZbI+l
 rV5aSfBlKxxHhiroPBfhfXTHwbt4f3k7B0+QSXuNJ7x4jkUB8++228dUkJsi8OaL6qrk
 JYIWzbssj3jFjlaTIcs8LLcEF6i1J/EkHN5m7Olpi/usGz3B2qQLIOMhgHX7jet8/pcy
 XUz/So5XJmEZKWRD8AiSB5fd3P3fe6kY9C9FUwJp8vfhuRhuG2lwTTA2D9svEGeHFXik
 q2ViVPEZVc6kzKTj2JrbwS6dKhkHrxG/FRTx2j7KhQhkP9/xl+zgkVVY8GSEVYY4wtdb
 6zWw==
X-Gm-Message-State: AFuF++lLDO/O4e6eodoh8+J6Yp4EyJqNr7fey/UT3SomJyCs7+mnWR7S
 oemDA5dzHmipIeaDHgnNqbCgK4ch3lxclHAh8F9Da5jIn8Yj00XJObte/8h6oYKZmyj6ZFPxqhj
 yXgS8pJaIYYnlY3wi/Mf2pckbLNUexsQ=
X-Gm-Gg: AR+sD12X31VY7Jfc5sozyYjevI6PtkwcVf0UudAZh9pDHTzI/dUtZb2JMeyy/4TU0rI
 tbhUIRPZkKD51myy0Gzxy2gd/gc9L3PArlDGSOyi3kEyfASbaF4ejztevvDzfs/X4pO6GKZ/FQw
 STKR0p1xHLexcfiG/IV+T84EfqbRcbIZ+j8E7TAX97VrZpSQRLFbjwXHy4cIsb+LFiOzu6+DCY6
 kN/FS6JfFgGobbh1slijRagWYUWzLbB0/r2oxM82F5gdQntgLZzHPpRGMqfT0lUEe1H31c4PA0Y
 DYr/Vrjn50hVOnn7vEMGDLEyK8JZ2Ktc86J+Clc+l/7SywfVEf0zwJgbla9cXhx8Ysw5AKJN/YN
 XjyPJrhydoY1UqGvVxJbkJF+O/oulvuKAL7HUBU7uD1bqTg2J0qYOl0gizocdxAAFV/HhFk7Qjb
 NE+tq96SvqS+bQQtmU
X-Received: by 2002:a05:6a21:4c06:b0:3b4:661d:8405 with SMTP id
 adf61e73a8af0-3d0f46c1e5cmr5905492637.4.1787810120898; Wed, 26 Aug 2026
 22:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
 <20260826214643.122728-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260826214643.122728-5-daniel.barboza@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 27 Aug 2026 15:25:06 +0930
X-Gm-Features: AcwNN1WU192jk-8SGck7g7Sk1u3NuCe_T416qjRd25zUPw8o5L2Lj_K7R7c79Jo
Message-ID: <CACPK8Xfizz2EBxq+iyTCRxUCEek-vXaMeCuN1nJACVeSky_g-g@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] hw/riscv/fdt-common,
 virt.c: add riscv_create_fdt_riscv_iommu_sys()
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 27 Aug 2026 at 07:16, Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>  void *riscv_create_board_device_tree(const char *model, const char *compatible,
>                                       int *fdt_size)
> @@ -348,3 +350,41 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *phandle,
>      qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
>      g_free(name);
>  }
> +
> +void riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
> +                                      uint32_t irq_chip,
> +                                      uint32_t msi_phandle,
> +                                      uint32_t *iommu_sys_phandle,
> +                                      uint32_t iommu_sys_irq)
> +{
> +    const char comp[] = "riscv,iommu";
> +    uint32_t iommu_phandle;
> +    g_autofree char *iommu_node = NULL;
> +    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
> +        iommu_sys_irq + RISCV_IOMMU_INTR_CQ,
> +        iommu_sys_irq + RISCV_IOMMU_INTR_FQ,
> +        iommu_sys_irq + RISCV_IOMMU_INTR_PM,
> +        iommu_sys_irq + RISCV_IOMMU_INTR_PQ,
> +    };

Any reason to pack them into an array? Seems like they could be part
of the qemu_fdt_setprop_cells call:

qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
        iommu_sys_irq + RISCV_IOMMU_INTR_CQ, FDT_IRQ_TYPE_EDGE_LOW,
        iommu_sys_irq + RISCV_IOMMU_INTR_FQ, FDT_IRQ_TYPE_EDGE_LOW,
        iommu_sys_irq + RISCV_IOMMU_INTR_PM, FDT_IRQ_TYPE_EDGE_LOW,
        iommu_sys_irq + RISCV_IOMMU_INTR_PQ, FDT_IRQ_TYPE_EDGE_LOW);

> +
> +    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
> +    iommu_phandle = qemu_fdt_alloc_phandle(fdt);

Ohh, that's neat. Any reason we don't use this for all of phandle
allocation needs?

We should be consistent, so switch this one to the pattern used by the
rest of the file, or (preferably, IMO) switch them all over.

> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
> +
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
> +        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
> +
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
> +
> +    *iommu_sys_phandle = iommu_phandle;

Could we just return it? Or have it passed in, so we don't need to return it?

