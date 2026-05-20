Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49796CD4F5B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 02:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPWSt-0001t5-E5; Tue, 19 May 2026 22:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPWSr-0001sp-2f
 for qemu-devel@nongnu.org; Tue, 19 May 2026 22:15:17 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPWSo-0004pj-ND
 for qemu-devel@nongnu.org; Tue, 19 May 2026 22:15:16 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-303dbfbec77so4123356eec.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 19:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779243313; x=1779848113; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4FruWjUR4VHf1LiwA3/aOkn5yZWpRxKPaeZzQVApbdo=;
 b=L4mHGdwcAq1tLdqDM3w2RUhM0cML/ngqCP8tCtH6li5ZNWcuejVQueQKqZF/h7zD8s
 l6YlP8pMI4rs2AOr+muvJrMfIuVGfm4XvZSaBSCRYU9jQ6qM0eabpQ9DognQXkyXJPQ2
 HRUWXSFhFRHGyOgI4kKG8ZN0f5456C33FrjjvUaNvwgJlENa2stss1UPKR4C7vXnygrj
 7/LEJauz9qx/ckj+dAsq0Ec7SWZHkvxRj+aheZweS5x0d5Tgg9K8YelZv8LsTziUDXO/
 7pCZ26fXLpKZk97utl3emkHm2wO0wT7jtySIjgwpRslH93yx3QLdZRtO8G2xoi8gdRdk
 kvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779243313; x=1779848113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FruWjUR4VHf1LiwA3/aOkn5yZWpRxKPaeZzQVApbdo=;
 b=OAu1JWMQmPSovJANgvGYg19k0Bp7cRA2zhMDsDwCWH7C/Q5JCfTyEZMWU4vnVvs/s9
 glGX2gws9lfVQMiBo4kgQij3dnPEoSflweWov0Qx9Zbf2WsxComCQRCcjKLqdPhbgcJc
 zqzrZ0unJYhDe9PFhYTKPhI7ki7/dXNUUiRegzOCKz+xYZeoa8Qfopf/giG5+B77SS0f
 RXlzQBrbYwBHV+AMozZbizO2eZHB/MUZ4wQV2H7cs40VEmXn/Kxnkb+TrK2cXTuhMXrX
 yDsGeGqpSXna3+IPs1SQf5+z7UbQiC4LXJFfdebvEJ35Sj9KBBsedbaa4p2h2qYYxkdm
 FYsg==
X-Gm-Message-State: AOJu0YxFNraW8Ti9Y8qX8wpaRta+O8NQ3SWokG49NePwpgQHwJsL+DUo
 mlFgj2Nbk5bZ+4a7d/SOdeW8noKgZ8sgVz4icNV11CyUbsNPGKSDI+Sw
X-Gm-Gg: Acq92OEESmru6BPetWShcdFTNEg2ZtPcEyfzUxegle51IPPDW2euVmAZsQIACZGfh6U
 Zkiox2dEvb0d5bwsgnU8dWyI3AFs8YzL4jEeHvIE1EjKI9bauoDKb3ksAFBZinAFDuAqf0DkKIq
 ZWxYNukULsX120M1/oVyKwcngIRjeiBjJbbEhKFwJJjT8Xikc0azqr4kakoSaIfOC6TqGC3bFXA
 Jj3AxdRe4n4INEspljelimZL1kDXRKOwuRUi/wKeXPfS/na7J+40GfXuV4HHH3o2VPblT1oew5b
 gVY0sJMp86vIGbMmqs3khzcal9FmtBpssBOJnEu1C6Ofem2h/AgFfUTsK5M05kps9J26Geq83fo
 +rjSi8/fpDb6pWvCivgedB1j/nUfCbx/wxRUMYRZ+icP4S5GZucUWOQrnWx2bkq9wHopkyZvfg1
 Zj7PzaWt9E2rAK+8y4TxHtSDXNoZy6JHKiDD7fBrjFxO6sNJgaHNDefaZNNVU=
X-Received: by 2002:a05:7300:3212:b0:2ba:a2fb:403f with SMTP id
 5a478bee46e88-30398618b93mr9357844eec.21.1779243312966; 
 Tue, 19 May 2026 19:15:12 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302947e917dsm17433077eec.12.2026.05.19.19.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 19:15:12 -0700 (PDT)
Date: Wed, 20 May 2026 10:15:10 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH] disas/riscv.c: add 'cbo' insns to disassembler
Message-ID: <ag0ZHdyMycEXi2GD@ChaodeMacBook-Pro.local>
References: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
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

On Tue, May 19, 2026 at 05:47:14PM +0800, Daniel Henrique Barboza wrote:
> We forgot to add 'cbo' insns to disas/riscv.c.  The result is that the
> disassembler recognizes all of them as 'lq', an insn that happens to
> share the same opcode space.
> 
> While we're at it reorder cbo_* entries in insn32.decode using opcode
> order instead of insn name.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3480
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  disas/riscv.c              | 29 ++++++++++++++++++++++++++++-
>  target/riscv/insn32.decode |  2 +-
>  2 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d416a4d6b3..36609efdf5 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -985,6 +985,10 @@ typedef enum {
>      rv_op_ssamoswap_d = 953,
>      rv_op_c_sspush = 954,
>      rv_op_c_sspopchk = 955,
> +    rv_op_cbo_inval = 956,
> +    rv_op_cbo_clean = 957,
> +    rv_op_cbo_flush = 958,
> +    rv_op_cbo_zero = 959,
>  } rv_op;
>  
>  /* register names */
> @@ -2255,6 +2259,10 @@ const rv_opcode_data rvi_opcode_data[] = {
>        rv_op_sspush, 0 },
>      { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
>        rv_op_sspopchk, 0 },
> +   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
>  };
>  
>  /* CSR names */
> @@ -2876,7 +2884,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
>              switch ((inst >> 12) & 0b111) {
>              case 0: op = rv_op_fence; break;
>              case 1: op = rv_op_fence_i; break;
> -            case 2: op = rv_op_lq; break;
> +            case 2:
> +               /*
> +                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> +                * with 'cbo' insns.  Check the next 5 bits to select
> +                * what we want:
> +                *
> +                * cbo_inval  0000000 00000 ..... 010 00000 0001111
> +                * cbo_clean  0000000 00001 ..... 010 00000 0001111
> +                * cbo_flush  0000000 00010 ..... 010 00000 0001111
> +                * cbo_zero   0000000 00100 ..... 010 00000 0001111
> +                *
> +                * Anything that doesn't match these will default to 'lq'.
> +                */
> +               switch ((inst >> 17) & 0b11111) {
> +               case 0: op = rv_op_cbo_inval; break;
> +               case 1: op = rv_op_cbo_clean; break;
> +               case 2: op = rv_op_cbo_flush; break;
> +               case 4: op = rv_op_cbo_zero; break;
> +               default: op = rv_op_lq; break;
> +               }
>              }
>              break;
>          case 4:
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..21272fdb50 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -207,9 +207,9 @@ ldu      ............   ..... 111 ..... 0000011 @i
>  {
>    [
>      # *** RV32 Zicbom Standard Extension ***
> +    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
>      cbo_clean  0000000 00001 ..... 010 00000 0001111 @sfence_vm
>      cbo_flush  0000000 00010 ..... 010 00000 0001111 @sfence_vm
> -    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
>  
>      # *** RV32 Zicboz Standard Extension ***
>      cbo_zero   0000000 00100 ..... 010 00000 0001111 @sfence_vm
> -- 
> 2.43.0
> 

