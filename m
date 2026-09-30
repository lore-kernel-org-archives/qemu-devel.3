Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFA9CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoQ4-0004Si-RL; Wed, 30 Sep 2026 03:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1xBoQ1-0004Rh-Tz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:07:58 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1xBoQ0-0007o2-4f
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:07:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2caced6038eso9995805ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790752074; cv=none;
 d=google.com; s=arc-20260327;
 b=HOjAJVpLen9R3hxu+TAs37rka2IcW0HDe1Nwa/Ro9XeejIXYznZ0b83phbTLtZ3HrU
 KSnhD+Om2AQ3eeWqLJXo9BASBNKu3YMMjjjwtBNtrzH7iMvKQqC3+0uFIz2IiobhzDm1
 MOJkEYZsFIl1noxOzCt1diChgF/yJql0yLsPln6i93xH/PdRwE2sne+A9K5YeY6kpJSN
 vDAPzHtq4HpNLgD+vfz242UZQq/Visip3uVnRsJOlD5exLrUgsF+E7Xl8tGJLLBKB7kf
 /ObjeavjiIcGhwJ0sT7Byof6Q6vk++cG4qI21HAllzRWm7Vtr2oWzRwP8YyxMxDNSeAz
 CKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ukO4CFAglzrAB8cj2AtxF/LB6a6g0sWqPUGZ9/MwH7U=;
 fh=8ik9FFMGHL0a2axiY+q6nxkXql+LJ2KzvU2UfxPrZlE=;
 b=PJVRO6wMwcU4KSksHn1imW5DDmvOig8UG207ZEgxD1UsL3fSsu5on49CdwahWLdX5+
 rLPks8IxI+1psKDIhkc9v/jeXgJCfTI5fUcsOV9AnW6Ib9Nbh4XrNQCk8IsVOMVAtFU/
 OAhoSpohMqUTuP1j4AceRB8dyV4K56FoY7qc2o4anK4rNwFupJ7QljOBbxFOzr1Zjjft
 EQDOgzpkAxP8h1KS6xoZF/4G9w+FQPClUfUnJ/Znkj+uuojS2KRuqWA+N0RiJHRfRYJz
 7A3W1+3FfGVfeg/ej2dYoMzWhv9YZoI9vJZh+DlbaWCYfGTl1HgD3F70KqSDwfDagSF3
 8aoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1790752074; x=1791356874; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ukO4CFAglzrAB8cj2AtxF/LB6a6g0sWqPUGZ9/MwH7U=;
 b=ZeA/+g1EGNirPbLX8ATMtFIgGSpe1c+fES6WfQk/MEEUmHC+/7W496iirWru0EzFJB
 gB5DONBZX0Q30CDqC2ZcxPvFPEEIoszu/rX65jt2FLW6VFXR+rkv9gBjsGqsPAJj8hSb
 +T9tk5lT9MTkpQyVytrxQey/+WzjGeHF8Mdsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752074; x=1791356874;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ukO4CFAglzrAB8cj2AtxF/LB6a6g0sWqPUGZ9/MwH7U=;
 b=nUXXyZ8++70ahlJkKv7cFD4QAkuZfhVQyMoh9Xrxp+Ew5REiimkhu+LxoIi6JzK/em
 vP0i/xB4Sf3K/3M3jbHbu2XOiUfeYkJhdTeEt0xUZ0u6skAzOgQVQulsqu5Qs+s5sSJd
 2xoG/+lAGcnvAdhlgmVF+YrHGknHPjvGNCMLJUc5LzHzojtB6GKY9odkTdIYlSLrkgkY
 h6jyEWqX+ALpT6IoWYxJ9rQmnucKe0eCzt7lICtMzLutHQwOiwsQE2z0SKFGrGD+8tW9
 CL2CmBCRCFc/+8QQblfGH7xXNxef5SKwFN6WBR9/fG1L6a5XfkBKCfI0a08QDxipB4Oo
 ly4A==
X-Gm-Message-State: AFq9FYK+pWSqrm0IymVBBDTzQhDBv+zytkGQNoQltH4TG0Xy+Q2rJ8Ia
 m+mBELxg4zfHILCvMAweP/EHna+2fCrABYEF8emu33qfF+yl2xydbDrmIHKkFKfKdaWzM1KU6fr
 KWB9GdBAY/uO2gNP2UvEDpLzP1YT0Oio=
X-Gm-Gg: AYBFou1Ou9a89wCtsE8h1mB0ssBH+0kUJ7e1m8S2sLEZ07LnFtUvVM39b3YxkWkwfEZ
 pmzTXpl3rpHiXFPL6dy3i9yCx13k3EJnxSQ5y+BnN9Iz1F90j4LxcLsOxHJgU46R+LsNMSDIWoR
 u913H+trgy5MGlg/3iTpq8TbMts4antz4onle4Uf8qGNp1jz4B5GgoiB4NMWB+tgkda9JgDOi3b
 PeUx4eL+L02M4kYaZK45Nwf4muNg769sS32ZyAJvLjtJOwwTMILdS9L3IIxpRkRdaj77IW46mMT
 b5TI9riz4w0HdMQPhgAn2BR3Rg1H8JYts2XQ5B88pur8GBGsfYl507WSPukPxccBkeqjtl3CQ6P
 IplUpq8wMcyuCNFltDm9K8i/1xatmu4Rblw4qfNvRxyXLINgCLTQu5XuUchr0+Rx8wfsnj6QX92
 my7RzmnuIM9LU7TyKHAhdsOfx/k28N0Af6KC10LQ==
X-Received: by 2002:a17:903:384d:b0:2d7:1cbd:9ceb with SMTP id
 d9443c01a7336-2e2e4b30efcmr3613865ad.12.1790752074534; Wed, 30 Sep 2026
 00:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-atlantis_prcm-v3-0-8bf20795a381@oss.tenstorrent.com>
 <20260904-atlantis_prcm-v3-3-8bf20795a381@oss.tenstorrent.com>
In-Reply-To: <20260904-atlantis_prcm-v3-3-8bf20795a381@oss.tenstorrent.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Sep 2026 16:37:41 +0930
X-Gm-Features: AclHuK9chH5waVJqh_hz7nXatLen0x7bQ7ExXdRTsbxvPF7s54vTRXxSQjWdGKc
Message-ID: <CACPK8Xdyg7ZsXzDTAGz6u2wSDPRSsW8mE5yu3+ze_X-Zqiju7g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hw/riscv/tt-atlantis: Update UART and I2C to use
 clk from PRCM
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

On Sat, 5 Sept 2026 at 00:18, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> @@ -265,7 +265,8 @@ static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
>  }
>
>  static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
> -                            int irqchip_phandle)
> +                            int irqchip_phandle, uint32_t clk_parent_phandle,
> +                            uint32_t clk_phandle)
>  {
>      g_autofree char *name = g_strdup_printf("/soc/serial@%"HWADDR_PRIX,
>                                              mem->base);
> @@ -275,7 +276,8 @@ static void create_fdt_uart(void *fdt, const MemMapEntry *mem, int irq,
>      qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
>      qemu_fdt_setprop_cell(fdt, name, "reg-shift", 2);
>      qemu_fdt_setprop_cell(fdt, name, "reg-io-width", 4);
> -    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 3686400);

The downside of this is we no longer boot with a Linux build that
lacks the PRCM driver, like the old build that is used for functional
testing in the tree.

I suggest we keep clock-frequency along side the clocks node. New
kernels with the PRCM driver use the clock phandle and calculate the
clock. Old kernels keep booting.

The other option is to drop this patch entirely for now, and revisit
later. I'd prefer keeping clock-frequency along side.

> +    qemu_fdt_setprop_cells(fdt, name, "clocks", clk_parent_phandle,
> +                           clk_phandle);
>      qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
>      qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);

> @@ -314,8 +318,8 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
>      qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem->size);
>      qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle);
>      qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
> -    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
> -    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);

This should stay, it's the bus frequency.


  clock-frequency:
    description: Desired I2C bus clock frequency in Hz
    enum: [100000, 400000, 1000000, 3400000]
    default: 400000

(or we omit it, and default to 400kHz. Your call).

> +    qemu_fdt_setprop_cells(fdt, name, "clocks", clk_parent_phandle,
> +                           clk_phandle);

This looks good.

>      qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
>      qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
>  }

