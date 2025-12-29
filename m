Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE19E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 09:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va9N4-00061d-DV; Mon, 29 Dec 2025 04:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1va9MM-0005v5-5O
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 04:16:16 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1va9MK-0002n3-2U
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 04:16:13 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2a0d5c365ceso117095825ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766999770; x=1767604570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALaxBRQCngSyICSV81qF52Dsm+2gGN4WQnq5D4Ur3SE=;
 b=Gd7JFXdK4BDdp6ntP9QbV9xsqrhr3NQI6ZuZHuQXM95SMdn0rHzFWToQvcG32E/lzW
 rFyNbEVpbjTjGMf7NIHTipGOWAJscIlWDwNi1LM/MAU3Xud8t/NUaoTo8+ff1hpaHvJo
 DKDi6pFVbDSXgjctHylxWHKV0xiemXkIFO1PZQIm3wUapzwcr7Soj+Sgo41gojDg8C26
 lvNjmD1Y1qX7VjUqRycdtsVtEZtQHLvg9ljseLV+FF8o88UpbG1SWgJhXMZL6K29IFQu
 osSQj2bB5QAjoHVKb95LHC9o6vXFkHJ76n+iu+vzjPgyIKT9ec/8thut4Je5dBXnNrf+
 4btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766999770; x=1767604570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ALaxBRQCngSyICSV81qF52Dsm+2gGN4WQnq5D4Ur3SE=;
 b=GoGlCSJ4QUjJSEasPIB+9ogQZeBPM1LNPq/r+sV2RAqB2RFc3HsvoBVUOH/0BxPOei
 /mP2978vV8egZgv+MUw/FR7Nj0VqN1eto6mldJflUCaTOiFgfchCSBx61rBDcLEVqCR2
 cI2LPuJKEg1e5FB7dq5dHfEn3qSVNGNHgiK8XxX3yFhS9kYD+byT+pSiRGDSa2QagJnM
 HhL0GWBEg6hdLJjcmG78JlWYYsTrqkkon5i6QCcTeXlmoGC30q9062r3qlhbVNlnk0G9
 kso98RtxjU22HfW7v44a+TqDyKkf/7eUfd847C98/Gqh8yg2OCv5jUIy5bSzwXimVyz8
 ORUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN4/s4fs2gIvgWg7cl+k5q0pud2trVSlVowRhYN6xiEKa+dWRV/s7NwPmOIIU/RMYuUsLXCzqv9GPC@nongnu.org
X-Gm-Message-State: AOJu0YwKz2/q6I0ZzomWe+Lp/SSYRM1TaWNCMfD9cUd3v09Jh1oNzWGw
 6MV2idYV98Bk/qFuhzmRNbFNUQygfMg9yawfTKRvrH9rXnIpFwSx6t5+
X-Gm-Gg: AY/fxX7AcwFI2gyZYDMq5cAgQSLotB9FzgUjVZjYW3046fy/h6wdC7Y4KvJF5aQXGQW
 EoM2CvA7a1k4VuA4jFqtTU8aqq/cXvKKze25113Kf1AkkhlUrhiKyI6fCAgCrNMnpNAkFMESJVm
 kEO+zY54OVku86tUA/XqmK/cml0EVrj0l5b1bxCQMX6DlE3f2SnUAl6lPou4Ak9JsWT3DuKbeBq
 2Bw4hGYIpI5agvC7V3iEn6/caJQ8BbkBJNcI4JGfeaVGgIkUjeYyIHr3e940g1m7P/brnAe6NDF
 Fe0sc1GkbrrQSLUM8SPAYVa0eBfD/GHqSAmnLIR9rob2KGAsm6qnGCaFZLgs0TlLfshwj4ArdGN
 pJT8n2uWUqiN5NRdS2a2/LXRgVzITi0wFDTnWCUCh9oFayqs40ZMKDPqqNJyhwamdgMRjApTwAc
 i9DQR1aFYVmWQ6hhUCXexM+8pEVc0b32IUFEXipA==
X-Google-Smtp-Source: AGHT+IF9XLQaqPU7zRh4fpim12349E2+/VZVufiWotN2fsd8QZUEeRClmqjb5GWYpLTd89XE6ZomIQ==
X-Received: by 2002:a17:902:f60c:b0:295:888e:9fff with SMTP id
 d9443c01a7336-2a2f221fa6emr288852685ad.20.1766999769546; 
 Mon, 29 Dec 2025 01:16:09 -0800 (PST)
Received: from [127.0.0.1] ([218.81.29.112]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm265015665ad.78.2025.12.29.01.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Dec 2025 01:16:09 -0800 (PST)
Message-ID: <0d095eb1-e150-45c2-a6c0-9a2f64f40c3b@gmail.com>
Date: Mon, 29 Dec 2025 17:16:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/risc-v: Fix clobbering of TCG_REG_TMP0 (t6) in
 vector code generation
To: zengzhijin@linux.spacemit.com, qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, qemu-devel@nongnu.org
References: <5D809A625CAA1DCC+20251229084747.1428-1-zengzhijin@linux.spacemit.com>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <5D809A625CAA1DCC+20251229084747.1428-1-zengzhijin@linux.spacemit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



On 12/29/2025 4:47 PM, zengzhijin@linux.spacemit.com wrote:
> From: Zhijin Zeng <zengzhijin@linux.spacemit.com>
> 
> The RISC-V target currently uses register t6 as the destination for vsetvli and
> vsetvl instructions to capture the resulting vector length (vl).
> 
> However, in the tcg_out_dupm_vec function, t6 is also used as a temporary
> register. Since tcg_out_dup_vec may emit a vsetvli or vsetvl instruction
> internally, the value previously written to t6 (e.g., by an earlier ld in
> the same translation block) can be unintentionally overwritten.
> 
> This patch reserves the t3 register to be used as the destination for vsetvli
> and vsetvl instructions.
> 
> Signed-off-by: Zhijin Zeng <zengzhijin@linux.spacemit.com>
> ---
>  tcg/riscv/tcg-target.c.inc | 10 +++++++---
>  tcg/riscv/tcg-target.h     |  1 +
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 31b9f7d87a..359021aa76 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -3022,10 +3022,12 @@ static void probe_frac_lmul_1(TCGType type, MemOp vsew)
>          p->vset_insn = encode_vseti(OPC_VSETIVLI, TCG_REG_ZERO, avl, vtype);
>      } else if (lmul_eq_avl) {
>          /* rd != 0 and rs1 == 0 uses vlmax */
> -        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP0, TCG_REG_ZERO, vtype);
> +        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_TMP3, TCG_REG_ZERO,
> +                                   vtype);
>      } else {
> -        p->movi_insn = encode_i(OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, avl);
> -        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP0, vtype);
> +        p->movi_insn = encode_i(OPC_ADDI, TCG_REG_TMP3, TCG_REG_ZERO, avl);
> +        p->vset_insn = encode_vset(OPC_VSETVLI, TCG_REG_ZERO, TCG_REG_TMP3,
> +                                   vtype);
>      }
>  }
>  
> @@ -3070,6 +3072,8 @@ static void tcg_target_init(TCGContext *s)
>      tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
>  
>      if (cpuinfo & CPUINFO_ZVE64X) {
> +        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP3);
> +
>          switch (riscv_lg2_vlenb) {
>          case TCG_TYPE_V64:
>              tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
> index 6dc77d944b..0f2dced8e2 100644
> --- a/tcg/riscv/tcg-target.h
> +++ b/tcg/riscv/tcg-target.h
> @@ -55,6 +55,7 @@ typedef enum {
>      TCG_REG_TMP0       = TCG_REG_T6,
>      TCG_REG_TMP1       = TCG_REG_T5,
>      TCG_REG_TMP2       = TCG_REG_T4,
> +    TCG_REG_TMP3       = TCG_REG_T3,
>  } TCGReg;
>  
>  #define TCG_REG_ZERO  TCG_REG_ZERO

LGTM. :)

Thanks,
Chao

