Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06546C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Sjr-0001wV-FD; Wed, 23 Sep 2026 15:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Sjp-0001wJ-FT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:34:41 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Sjn-0007Kr-Mo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:34:41 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 41be03b00d2f7-cc50d1b048eso887989a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192078; x=1790796878; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hEgSGzK6cjPLrC55T/iVzxgRppVKvyJHNQ/RF1g6mAY=;
 b=D4a2Cb8GwGXjq3MnGnqKDP4rdhBrQepm0MzgtqgytrGy3uNfWKrqX48Sn4WJ4mOvbm
 nXfE5xjhm+AL/ytyg/j1gTirEN/CL9tidvOM8mrASPlHS+5gJ9lxbl+3kuVOKvPOKVxl
 vMLhEIz+icJb783LiRyZRC3cYzBkRtg4dLhkXNqDAARdrrqhNzh18xlphexkzQDJIclX
 LdHhFHvLbuRYwEC8NL5Uax2vV9XGutJnaFs61YRCNmnfUQGrodVHHGyg0uHvBz3nl22v
 neCfvkrufYyZ9cuFh0FMdUZbK/x6c0xBetiOqel+pkvl69yNMAw1NoJQXiw73iqiHcqk
 U0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192078; x=1790796878;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hEgSGzK6cjPLrC55T/iVzxgRppVKvyJHNQ/RF1g6mAY=;
 b=npKOiPviisKYDkVizRliksX65JWmaS86hbe4kDpyMzNc5Vqbr7hNfxkQB4ixNRcl3E
 Y2D474eH7We4gKHbP1ICyhbP2J9xU8x6VwSE22HC1NRoxVmG0tExx864qPRGj6rjAWLc
 POO9RVUref84E8Q9fLRv9JZXrT3Nxu7OYYCLELfhMeuhnirYJHtuhsmGyWaKJHcWrLfj
 vLAurYodDjQQqVob9suQdqKDfEobwZJOIHzDezkM1mbx7EauFE1tk7AsoHpbShYAsMTZ
 8FskKb3PCpEZkiYs6URFXirCVQ1W9VnL+E3uOKd4qDx2x1v7f86UJfZllWGJUfiiNMzn
 fXlw==
X-Forwarded-Encrypted: i=1;
 AKwUvByGd9KfQpgIMxgiUD9uihJQJc8p3NkalM939evESbhWC27keUyy4ViWVkFjpRezIxX0PBKAZ7uHN7pZ@nongnu.org
X-Gm-Message-State: AFuF++lRRICydiM3NKb+I85I/CHAPSjtjGlu26DL9W/z/Wlw9Ze6e0KJ
 fONOQ5fzutQ6+dKQm6w3k3MBvV3F7qWaSbDTzYNiNFEn6BATmekJLsKTQCljjIuPRtM=
X-Gm-Gg: AYBFou1K9AMKOSdwdtIQWgudkq2B54zPHsP5m7xOsmjb9vNPoY9r4MGQ5yrhzPUiGal
 ZYCIoW2YJfJkgh9lQ/2tEXvakQr5bIKNcc0Ip/rOkXZnpsVAXZM1CEsdcF5n+ZFrcac7Sfwhx1P
 BUjB4MvXY5u/fVRcu/VBvMWDKs5VnGlmoJt39NWHKo6Xr0vuMh77GNaIAU42TGq3ikjDXf95rJb
 lunL4SlCZ3qV1U9xykJfVQAaEzhqlY/83A0FhkxPb3FK8jV7B3s83tt6+vt5T7SwW0jQpKa8WHU
 9eQbsi1XO7zJ3TBSgwEl75S+79A4BMewNCMfHJCsCJJ95ztJtb03JzPF34JrujajwJhmDgi3Pea
 BfdSLKowEq+W7aac49nVrK2skTu8fwM+naGtaOqy99/Ur9z1xy0D3b4d0XOqemtAKCTuNnb+WvQ
 yAs3e2TIDzbOlAa1vJaAWDFsPuU+kX6Q6Pwv70p/6ByDBO48+nDJDc0yyO1D0WOdMHUTkLwfTDb
 qDla0D8ZrL+piA8Op4Pahy+QLftqOleYPTWPvlp
X-Received: by 2002:a05:6a21:ed0e:b0:3dd:5831:ef58 with SMTP id
 adf61e73a8af0-3de0e7f9e2bmr193070637.15.1790192077530; 
 Wed, 23 Sep 2026 12:34:37 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f3ba8b6sm1580821a12.5.2026.09.23.12.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:34:37 -0700 (PDT)
Message-ID: <081f23de-f665-4659-bb64-b6efba9024b2@linaro.org>
Date: Wed, 23 Sep 2026 12:34:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] target/i386/tcg: generalize zero- and sign-extension
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> Allow applying sign and zero extension to T1 load and T0 writeback.
> T1 load is useful for some cases where the tables are hacked to
> put the sign extended operand in T0; T0 writeback is used for APX ZU
> instructions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     | 15 +++++++++++----
>   target/i386/tcg/decode-new.c.inc | 21 +++++++++++----------
>   target/i386/tcg/emit.c.inc       | 16 ++++++++++------
>   3 files changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
> index 25f7d2215ee..a3702b00614 100644
> --- a/target/i386/tcg/decode-new.h
> +++ b/target/i386/tcg/decode-new.h
> @@ -148,6 +148,12 @@ typedef enum X86OpUnit {
>       X86_OP_MMX,     /* address in either s->ptrX or s->A0 depending on has_ea */
>   } X86OpUnit;
>   
> +typedef enum X86OpExt {
> +    X86_EXT_None,
> +    X86_EXT_Signed,
> +    X86_EXT_Unsigned,
> +} X86OpExt;
> +
>   typedef enum X86InsnCheck {
>       /* Illegal or exclusive to 64-bit mode */
>       X86_CHECK_i64 = 1,
> @@ -226,10 +232,6 @@ typedef enum X86InsnSpecial {
>        */
>       X86_SPECIAL_MMX,
>   
> -    /* When loaded into s->T0, register operand 1 is zero/sign extended.  */
> -    X86_SPECIAL_SExtT0,
> -    X86_SPECIAL_ZExtT0,
> -
>       /* Memory operand size of MOV from segment register is MO_16 */
>       X86_SPECIAL_Op0_Mw,
>   } X86InsnSpecial;
> @@ -300,6 +302,10 @@ struct X86OpEntry {
>       X86OpSize    s3:8;
>   
>       X86InsnSpecial special:8;
> +    unsigned     ext0:2;
> +    unsigned     ext1:2;
> +    unsigned     ext2:2;

Use the enum.  With that,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I did wonder about using a bool here, and

> +    unsigned     :2;
>       X86CPUIDFeature cpuid:8;
>       unsigned     vex_class:8;
>       X86VEXSpecial vex_special:8;
> @@ -314,6 +320,7 @@ typedef struct X86DecodedOp {
>       int8_t n;
>       MemOp ot;     /* For b/c/d/p/s/q/v/w/y/z */
>       X86OpUnit unit;
> +    X86OpExt ext;

... MemOp sign here ...

> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index c83ab809408..54dc23ca624 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -266,23 +266,21 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
>   #endif
>       case X86_OP_INT:
>           if (op->has_ea) {
> -            if (v == s->T0 && decode->e.special == X86_SPECIAL_SExtT0) {
> +            if (op->ext == X86_EXT_Signed) {
>                   gen_op_ld_v(s, op->ot | MO_SIGN, v, s->A0);
>               } else {
>                   gen_op_ld_v(s, op->ot, v, s->A0);
>               }

... so that the uses here become e.g.

     gen_op_ld_v(s, op->ot | op->sign, v, s->A0);

> @@ -347,6 +345,12 @@ static void gen_writeback(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv
>       case X86_OP_INT:
>           if (op->has_ea) {
>               gen_op_st_v(s, op->ot, v, s->A0);
> +        } else if (op->ot < MO_TL && op->ext != X86_EXT_None) {
> +            if (op->ext == X86_EXT_Signed) {
> +                tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot | MO_SIGN);
> +            } else {
> +                tcg_gen_ext_tl(cpu_regs[op->n], v, op->ot);
> +            }
... but I can't see how to fit this new case into that scheme easily.


r~

