Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1082ECA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyUf-0004IN-2y; Mon, 01 Sep 2025 02:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyUZ-0004HK-Tw
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:58:18 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1usyUT-0005HA-Ay
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:58:15 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b0411b83aafso195258466b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709886; x=1757314686; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nrZUvNz3wyn0r28ZlqlQ+puf9UDHXob/klxDLv3YUK0=;
 b=FttNtpMsvb1GcS+OukPokYNCjvdPpqfm4ZXEJib3YFlsOWNTwK6PcDTPKstUiS3v7q
 McYJQoXZ6pBd1j6cDnnXkdGA35JGNhY+6an3MrZdrbRdc7NS4c33/51qPmwm+JOXgkPP
 nAvNwoR0aNXmHcibvdDoUspIMBE20DjV8uGf4TQLZnZA5TJRuszBSkFSTFCKJx4bpFmR
 L1vMQPYIVwsF5CQOxIVewND8Bs6/NsFqYV8ytNNY5ps9H0FQ3Pp4S4ruKIM3dEHTnr/z
 guPYAwOs3U4Z3XHb03Ct+7jhPz5jMTb7BQ4g4j+q1B9ta2ilOJjErmJO1k4o0IPjB7Gg
 gPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709886; x=1757314686;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrZUvNz3wyn0r28ZlqlQ+puf9UDHXob/klxDLv3YUK0=;
 b=hA6dSkMHRExgZjePw8gpj+pKcnEsSqH6odK/I7syCN/K4b/Cp2xxLYuAJfhTY06P3g
 X8JKbCZyva+ADhyoHkkB1cXCBYyXmmSFwGWbvKm6TSWSEEZY5U2kT7LIEWub0gbeUf5B
 Ve/1nY0Y35vFyCokBCYTJbIV1VJ/ib+f033MYinEuUc71td37gVjXeSuPEfiXAUE6Usl
 yPS58Uii0TTTKeo9rDuoStas1OYfodceHFOVTlic8G6FkSQI61Odg4KilEw3ruOZncXa
 VBZgWb7TKDqZSxc7dN0N2ps8d25noAfb/aWxUaDJYqcxMyN0LuH/RUGsweQiuH/PYHfN
 6qZg==
X-Gm-Message-State: AOJu0YxcJUmupjLcfS2NgJSYxbvn83CT5gTmTQcmEgh4mIbuXlkPX3+N
 DULmdd+fqHyM4F5HO6T2qUoFBHNmN7XPXCTIiC56h1cgUaqQjpTyQwvS/Iz1nLqgZkTFhBRHJ1/
 jFzs0
X-Gm-Gg: ASbGncvS8+9rtWGg8ufRh7M1+6U4Z0/0atHgmJ8XMeb7Qclf0XC9SVelT1fV/w9rYnH
 s3PnEwnkjTgDcRX48Bj+0QDmo5qkL9ALjqnaQcoyt4wPzOM5F+V6lr51s1IKvskP4xxfFNRTpxS
 zJQGO/godqw/euVGmOjW4llkGCwQ4dJADpfr9Ddng2whzjetYhmBwYyrDns5qdgnM6DBn3S5Zib
 6jvNrPwFZVi6s8NMg65PhY7WhDe1FP3PQCZEpY+7qVllyZjIQYuyk7by/M8RCmP1ikhYlamOxrb
 NUg8btUB7WwU1I9E2ZeQFks6iyLPzff5fZ2vap5RzleKSkNmdaQXrloqbz4jekOrTaq5hvmWL5Y
 JNJ+ral9s9R0wOxYiM+RskRLjW3y8tOLAdb/VHdTBkD6jdpRlJl094jkdU22cl57tmuWiRYi3
X-Google-Smtp-Source: AGHT+IFOYzFf7n3cN07DAHJ2pDRUflP64QWDMnUdf4WTGCIqlGXhhEyPR3pOakD+f4VDM/y4HGRAXw==
X-Received: by 2002:a17:906:7308:b0:afe:c027:cfdb with SMTP id
 a640c23a62f3a-b01d8a6adddmr689763166b.17.1756709885915; 
 Sun, 31 Aug 2025 23:58:05 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0410138d0asm392516466b.53.2025.08.31.23.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 23:58:05 -0700 (PDT)
Date: Mon, 01 Sep 2025 09:56:31 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 39/61] target/arm: Update ARMCPRegInfo for 128-bit sysregs
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-44-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-44-richard.henderson@linaro.org>
Message-ID: <t1we0s.2yp21lsjxl157@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
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

On Wed, 27 Aug 2025 04:04, Richard Henderson <richard.henderson@linaro.org> wrote:
>Add ARM_CP_128BIT for type and functions describing 128-bit access.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/cpregs.h | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
>index 9818be4429..90f14dbb18 100644
>--- a/target/arm/cpregs.h
>+++ b/target/arm/cpregs.h
>@@ -136,6 +136,8 @@ enum {
>      * identically to the normal one, other than FGT trapping handling.)
>      */
>     ARM_CP_ADD_TLBI_NXS          = 1 << 21,
>+    /* Flag: For ARM_CP_STATE_AA64, sysreg is 128-bit. */
>+    ARM_CP_128BIT                = 1 << 22,
> };
> 
> /*
>@@ -178,6 +180,10 @@ enum {
> #define CP_REG_AA32_NS_SHIFT     29
> #define CP_REG_AA32_NS_MASK      (1 << CP_REG_AA32_NS_SHIFT)
> 
>+/* Distinguish 64-bit and 128-bit views of AArch64 system registers. */
>+#define CP_REG_AA64_128BIT_SHIFT 30
>+#define CP_REG_AA64_128BIT_MASK  (1 << CP_REG_AA64_128BIT_SHIFT)
>+
> /* Distinguish 32-bit and 64-bit views of AArch32 system registers. */
> #define CP_REG_AA32_64BIT_SHIFT  15
> #define CP_REG_AA32_64BIT_MASK   (1 << CP_REG_AA32_64BIT_SHIFT)
>@@ -849,6 +855,9 @@ typedef struct ARMCPRegInfo ARMCPRegInfo;
> typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *ri);
> typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *ri,
>                        uint64_t value);
>+typedef Int128 CPRead128Fn(CPUARMState *env, const ARMCPRegInfo *opaque);
>+typedef void CPWrite128Fn(CPUARMState *env, const ARMCPRegInfo *opaque,
>+                          Int128 value);
> /* Access permission check functions for coprocessor registers. */
> typedef CPAccessResult CPAccessFn(CPUARMState *env,
>                                   const ARMCPRegInfo *ri,
>@@ -992,6 +1001,13 @@ struct ARMCPRegInfo {
>      * fieldoffset is 0 then no reset will be done.
>      */
>     CPResetFn *resetfn;
>+
>+    /* For ARM_CP_128BIT, when accessed via MRRS/MSRR. */
>+    CPAccessFn *access128fn;
>+    CPRead128Fn *read128fn;
>+    CPWrite128Fn *write128fn;
>+    CPRead128Fn *raw_read128fn;
>+    CPWrite128Fn *raw_write128fn;
> };
> 
> void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
>@@ -1061,6 +1077,9 @@ void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
>  */
> static inline MemOp cpreg_field_type(const ARMCPRegInfo *ri)
> {
>+    if (ri->type & ARM_CP_128BIT) {
>+        return MO_128;
>+    }
>     return (ri->state == ARM_CP_STATE_AA64 || (ri->type & ARM_CP_64BIT)
>             ? MO_64 : MO_32);
> }
>-- 
>2.43.0
>
>

