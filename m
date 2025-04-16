Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2535C369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58Fr-0005aN-0b; Wed, 16 Apr 2025 15:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Fo-0005Xz-LF
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:17:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u58Fm-0006IU-As
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:17:00 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227c7e57da2so430695ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744831017; x=1745435817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bSDMpqVMz2pC78AsZlPi4+ppf6y6DFSmMzXLvcf8poM=;
 b=IxW5eItH6QtlyZG/9dASVulOEW+23mL6flNINBF67hqL7cYXI6jHatyAH+tnc7MFrh
 HFG24M/gwj+Paw59ceFLUT7KPafPdLQs/nj2pUY1Cc+wZlY8WRhlRbccbvdhwYq1aBXT
 4+SvSDJkC9aEenC/f8MbkzDHD/XvfIoKIu+3KBLOKUegylRRf4YBGInr3pxQb5gzJV6a
 W2mqjfnXqGVqvO/XVWJtVjyvlD2Kxf+4Q2yy1FkFHDJSdqWRfGSAwTkUSGH57RFWVI48
 mE4ZbxMiOS/bncBHvJIo+Uf5UR5q5GsZpBAPCLEkoe/gt66aWqkPeJPFsSs9/r9m5eEY
 XGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744831017; x=1745435817;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bSDMpqVMz2pC78AsZlPi4+ppf6y6DFSmMzXLvcf8poM=;
 b=fP3aR3B3Ao1rM9u2F63aV/F69lUddsx+PUqHwAmpfpjIUfpzMH9Efw5q2Qana6hdGq
 0+AjTXDLH8CtSpA/df+HYZag6wfHwVFQkmEbBE1w0GWNQIJ+rnTZo5A0PoavHdDkvEPI
 WYfurgng3PGj9uIdjk/UX+7862CniOsTfLmSSev6VsoHx87wGBmCQkZyb1O6vgLB5NKY
 0/0ExwPSKFldz4Ke67hEWLJs8C3DFZSGK0y3CEclK1tvw1W0pA8Z9SEQFJozZB5dQ+wS
 NTcI6Cw9X6u80cY5duEyeAjUS9E6GP2AFnkASP7vl8t5ApFb3msiQdKuk9dvDcdGG/5T
 hpPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJzeqlHuiaQ5drIYx6lAh3nz2rtCNnNp1kBEOEswf2ws17uPG1dX4P83fZ+DiOe8F8uAti29P9wluF@nongnu.org
X-Gm-Message-State: AOJu0Yxw8kSYw/CAq9F1sCRIbgsqpQkrkx7X1GqaCdEbkxmOSgx5dmfg
 nL+ooedC+oKjhZgKfilUdmIvuKRIj0oxDSP902btFuKlZg2IC1mHR++Ch++3EPwoFMphw8lvyAf
 M
X-Gm-Gg: ASbGncugB6drDvRelGgBLu5XcV1LBIbEkVAgwzJRgQiV+u3f3YFHATeQlV/w2Ya6zD+
 LwtN0vKVf1G+XM6oNULt8spVCJwyNGsX/jC3P4dKGg64vsQCmziw3j9a9jYJzMQd+MJA7f0C5AL
 8AGcrkveDknzDDBhSCldQ59Dt/EmNR/J46mxikEp0kEZmzobvKwdJEGy0aGCsqMO4wvl3gRtWM8
 FMvslu/vQzZOF+s6rtG2Ua9fFhK8Vg5BtJMCndKW8+Q0W1TwcGG6R7uaKt0G4xLAfGH/sm+WdO+
 NcZKjbsP8Qppe45AT2L24cGmDh7cw3pzHteuPHatbiW5vSvTe/ibhQ==
X-Google-Smtp-Source: AGHT+IFr2rGGQLt6h3vS8PknrZr4vs/sf3+QwrWehzKfxOsu3iUNgRFPMGnjX6yW6QL5zNFa5QBI0g==
X-Received: by 2002:a17:902:ce82:b0:225:ac99:ae08 with SMTP id
 d9443c01a7336-22c358c684fmr51447625ad.5.1744831016782; 
 Wed, 16 Apr 2025 12:16:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33f1cecdsm18158425ad.57.2025.04.16.12.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:16:56 -0700 (PDT)
Message-ID: <90110fd8-4ba6-4fa4-b937-e972635b79e5@linaro.org>
Date: Wed, 16 Apr 2025 12:16:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 141/163] tcg/s390x: Implement add/sub carry opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-142-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250415192515.232910-142-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/15/25 12:24, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target-con-set.h |   2 +
>   tcg/s390x/tcg-target.c.inc     | 103 ++++++++++++++++++++++++++++-----
>   2 files changed, 92 insertions(+), 13 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
> index f5d3878070..0a991f6d5d 100644
> --- a/tcg/s390x/tcg-target-con-set.h
> +++ b/tcg/s390x/tcg-target-con-set.h
> @@ -22,6 +22,7 @@ C_O1_I1(r, r)
>   C_O1_I1(v, r)
>   C_O1_I1(v, v)
>   C_O1_I1(v, vr)
> +C_O1_I2(r, 0, r)
>   C_O1_I2(r, 0, ri)
>   C_O1_I2(r, 0, rI)
>   C_O1_I2(r, 0, rJ)
> @@ -32,6 +33,7 @@ C_O1_I2(r, r, rI)
>   C_O1_I2(r, r, rJ)
>   C_O1_I2(r, r, rK)
>   C_O1_I2(r, r, rNKR)
> +C_O1_I2(r, r, rUV)
>   C_O1_I2(r, rZ, r)
>   C_O1_I2(v, v, r)
>   C_O1_I2(v, v, v)
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 9b28083945..2b31ea1c3e 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -173,6 +173,8 @@ typedef enum S390Opcode {
>       RRE_SLBGR   = 0xb989,
>       RRE_XGR     = 0xb982,
>   
> +    RRFa_ALRK   = 0xb9fa,
> +    RRFa_ALGRK  = 0xb9ea,
>       RRFa_MGRK   = 0xb9ec,
>       RRFa_MSRKC  = 0xb9fd,
>       RRFa_MSGRKC = 0xb9ed,
> @@ -2259,21 +2261,60 @@ static const TCGOutOpBinary outop_add = {
>       .out_rri = tgen_addi,
>   };
>   
> +static void tgen_addco_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        tcg_out_insn(s, RRFa, ALGRK, a0, a1, a2);
> +    } else if (a0 == a1) {
> +        tcg_out_insn(s, RR, ALR, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RRFa, ALRK, a0, a1, a2);
> +    }
> +}
> +
> +static void tgen_addco_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_mov(s, type, a0, a1);
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_insn(s, RIL, ALFI, a0, a2);
> +    } else if (a2 >= 0) {
> +        tcg_out_insn(s, RIL, ALGFI, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RIL, SLGFI, a0, -a2);
> +    }
> +}
> +
>   static const TCGOutOpBinary outop_addco = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rUV),
> +    .out_rrr = tgen_addco_rrr,
> +    .out_rri = tgen_addco_rri,
> +};
> +
> +static void tgen_addcio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_insn(s, RRE, ALCR, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RRE, ALCGR, a0, a2);
> +    }
> +}
> +
> +static const TCGOutOpBinary outop_addcio = {
> +    .base.static_constraint = C_O1_I2(r, 0, r),
> +    .out_rrr = tgen_addcio,
>   };
>   
>   static const TCGOutOpAddSubCarry outop_addci = {
> -    .base.static_constraint = C_NotImplemented,
> -};
> -
> -static const TCGOutOpBinary outop_addcio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, 0, r),
> +    .out_rrr = tgen_addcio,
>   };
>   
>   static void tcg_out_set_carry(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_insn(s, RR, SLR, TCG_REG_R0, TCG_REG_R0); /* cc = 2 */
>   }
>   
>   static void tgen_and(TCGContext *s, TCGType type,
> @@ -2794,21 +2835,57 @@ static const TCGOutOpSubtract outop_sub = {
>       .out_rrr = tgen_sub,
>   };
>   
> +static void tgen_subbo_rrr(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type != TCG_TYPE_I32) {
> +        tcg_out_insn(s, RRFa, SLGRK, a0, a1, a2);
> +    } else if (a0 == a1) {
> +        tcg_out_insn(s, RR, SLR, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RRFa, SLRK, a0, a1, a2);
> +    }
> +}
> +
> +static void tgen_subbo_rri(TCGContext *s, TCGType type,
> +                           TCGReg a0, TCGReg a1, tcg_target_long a2)
> +{
> +    tcg_out_mov(s, type, a0, a1);
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_insn(s, RIL, SLFI, a0, a2);
> +    } else if (a2 >= 0) {
> +        tcg_out_insn(s, RIL, SLGFI, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RIL, ALGFI, a0, -a2);
> +    }
> +}
> +
>   static const TCGOutOpAddSubCarry outop_subbo = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, r, rUV),
> +    .out_rrr = tgen_subbo_rrr,
> +    .out_rri = tgen_subbo_rri,
>   };
>   
> -static const TCGOutOpAddSubCarry outop_subbi = {
> -    .base.static_constraint = C_NotImplemented,
> -};
> +static void tgen_subbio(TCGContext *s, TCGType type,
> +                        TCGReg a0, TCGReg a1, TCGReg a2)
> +{
> +    if (type == TCG_TYPE_I32) {
> +        tcg_out_insn(s, RRE, SLBR, a0, a2);
> +    } else {
> +        tcg_out_insn(s, RRE, SLBGR, a0, a2);
> +    }
> +}
>   
>   static const TCGOutOpAddSubCarry outop_subbio = {
> -    .base.static_constraint = C_NotImplemented,
> +    .base.static_constraint = C_O1_I2(r, 0, r),
> +    .out_rrr = tgen_subbio,
>   };
>   
> +#define outop_subbi  outop_subbio
> +
>   static void tcg_out_set_borrow(TCGContext *s)
>   {
> -    g_assert_not_reached();
> +    tcg_out_insn(s, RR, CLR, TCG_REG_R0, TCG_REG_R0); /* cc = 0 */
>   }
>   
>   static void tgen_xor(TCGContext *s, TCGType type,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


