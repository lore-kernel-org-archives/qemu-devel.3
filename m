Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1265CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 07:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPb05-0003XS-Uq; Wed, 20 May 2026 03:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPazz-0003X1-6Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:05:47 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPazx-00079k-LS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:05:46 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so4432119eec.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779260743; x=1779865543; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5M/7rEoEioCyGSMNYYRkEnU0I26NIhrLFVRv1qHyqMg=;
 b=dyVJdgoVKxshBywM+s1Km/Cha4wUJ0EDTceFeV3WxF88w9ev5uROuUbIpgxA1g9XY7
 wVH520YPtoaO7a+FkN3DXvOVRLuGRdImplB5Gi3kxg0Na9JTyEITXDCzS0UpsiRdCjrL
 q3XHFx+NQ8X7geMmwP0+nA9AQbjRsyKCdrMDDzFaLAZA7uHi+In8aQu3WVEo7PzN3sy1
 nfY6YK7fu6i8AOUgSIdU+YSBhwivAtCib6YXPLRi78l4/CpmTGdZbHpHEI0rAYi3t1oZ
 FDrFGQhNPYPTRzh98UARmkEwvCcFHlQvxkIX61db8soC7ozko75Oy44E93pqVKFSPkFK
 6n/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779260743; x=1779865543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5M/7rEoEioCyGSMNYYRkEnU0I26NIhrLFVRv1qHyqMg=;
 b=JWWoRcpAJdVbrA8Sbt5mybd7hgkyr/MY0uqLMuqAnPVB2PeXx31BtoOwzlevcjIUoJ
 zDQl5SaecUd+ElSWyZkYe5dDnKEZW1+OYkCGROucOLK6VwrCPwS9zfPIbMhAEsHwnTqL
 H+Oz8xH9mdTvPFsJ+kXO5nqR2AvoSQtiM7gAlTtmc0fKW85LErZiP+JlXqHe7CH4NnMv
 THv/c3q+Tneo5iyNpVZ8KVGWefTzjsvs9+9jcWQyfhEiiqlm5fZnDEfyIIYZt2vuyyV6
 g6nT3Gvchb9Gm6ct1UN+e/D+0rj1YBCcN9Bk3sAZ2fApyALIK1DevOY5Z9/8mwdn0bn5
 pBsg==
X-Gm-Message-State: AOJu0YwchbMcYk0FNdVKwgx2YjU8rlpCQQYhcFM+4U7Y1ZHXBnCkRJR9
 XWbh2rewQjQPyz3gCCZVs8qZygwgsunNRSPoKNss759Jj72V9LUGtKy6
X-Gm-Gg: Acq92OHsvuVu6UyvwY05RNMSCcvQTYhpjtUnAZJ3zfFrn1YxXpAdHffD8bfsVS3SI9T
 SIfg+CPBJGIQCMgVBvcDrZe1FNT4sgW2GG1xzRw7qXVn46ZnB8vTS7wbyh+1Zy6IJCmO7tvUR/+
 rtVQu6bpdgPOqN5tRoquAC96NR3ZYuUaHWjeV68HEsJ+X6A49ldzWQh80jbEQv5nZOl3xX2ju8q
 xaGAFZCDty47ksguazncqGUCclD829JWprtVdc+PJagGv1pqSY3cGKX0ljTwVSWmPhCkJrnlkCj
 UH812r+7gKuTr35NxIJbAC8suFLgpCyf6gFHPp88CX/z3jaWkdKK/PhfSQhWtNvsQB2/GDRWBX/
 XdIwcRu9dJypXJ8yiA4JGjsReaoWdtLsuEVgLh7E5Oaem4XSaByFS5gBE8qHF6eGXMCurJJ9YIW
 DIIwStkFMSfHX/8V5Cx7NiqWNtBCSXKpgaJgCQ/QqsvUfsxKkM//NFzPn9dKY=
X-Received: by 2002:a05:7300:d4cf:b0:2ed:e14:7f58 with SMTP id
 5a478bee46e88-303986c50f6mr10828129eec.34.1779260743333; 
 Wed, 20 May 2026 00:05:43 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30290c4a699sm18420223eec.0.2026.05.20.00.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:05:42 -0700 (PDT)
Date: Wed, 20 May 2026 15:05:40 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Subject: Re: [PATCH v5 1/2] target/riscv: Align pmp size to pmp-granularity
Message-ID: <ag1dOFzbKDqL0rUv@ChaodeMacBook-Pro.local>
References: <20260520063606.36600-1-jay.chang@sifive.com>
 <20260520063606.36600-2-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520063606.36600-2-jay.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, May 20, 2026 at 02:36:05PM +0800, Jay Chang wrote:
> When configuring pmpcfg (TOR, NA4, or NAPOT) and pmpaddr, if the
> value is smaller than the PMP granularity, it needs to be aligned
> to the PMP granularity.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  target/riscv/pmp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index a71091a316..8adf7c9719 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -179,11 +179,12 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t pmp_index, uint8_t val)
>              }
>              /*
>               * When granularity g >= 1 (i.e., granularity > 4 bytes),
> -             * the NA4 (Naturally Aligned 4-byte) mode is not selectable
> +             * the NA4 (Naturally Aligned 4-byte) mode is not selectable.
> +             * In this case, an NA4 setting is reinterpreted as a NAPOT mode.
>               */
>              if ((riscv_cpu_cfg(env)->pmp_granularity >
>                  MIN_RISCV_PMP_GRANULARITY) && (a_field == PMP_AMATCH_NA4)) {
> -                    return false;
> +                    val |= PMP_AMATCH;
>              }
>              env->pmp_state.pmp[pmp_index].cfg_reg = val;
>              pmp_update_rule_addr(env, pmp_index);
> @@ -263,6 +264,11 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>          break;
>  
>      case PMP_AMATCH_NAPOT:
> +        /* Bits [g-2:0] need to be all one to align pmp granularity */
> +        if (g >= 2) {
> +            this_addr = deposit64(this_addr, 0, g - 1, -1ULL);
> +        }
> +
>          pmp_decode_napot(this_addr, &sa, &ea);
>          break;
>  
> -- 
> 2.48.1
> 

