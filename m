Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2611DC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 06:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv9HP-0004P8-L8; Thu, 20 Mar 2025 02:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9HN-0004OC-Hv
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:21:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tv9HJ-0007Qz-3Y
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 02:21:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22548a28d0cso8694255ad.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 23:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742451675; x=1743056475;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2nNZxDTDESGfSLyL353XFE0BeY1oeJ3+DukZFk8chPQ=;
 b=ZF7Sq1uvS57fky3ydJz7jkFJV377B4UIEbH005Uo3ou0K7/s6QG0RNsfX8MKHQUH2h
 FBAnhxAwmPWT3SlookcWXmlO6Jzi9xjvzSNxhDg1tNVY/pP9Ohk/ZsWsF82o5+XZS419
 9F7CqWt2JLdn7gu4EBvWH8NCIcZRWpLEQyZzVabc0g58tkqbzAoNQoj9d7khEMQ0vM9T
 aUff8wtg5Q/C+YjoccJWP1rudcAjCjwEzkE5I3cfn7uSfWZNcUSAmgVIv51aZVwYr57o
 t81zz/M1uuah3UH0OS5mJ0Hh7zgOH7ilk2NTJkfq52sjGIfA4eQojrMLshp4jcT8mT+d
 vR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742451675; x=1743056475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2nNZxDTDESGfSLyL353XFE0BeY1oeJ3+DukZFk8chPQ=;
 b=ZG1znALR5gutc1W4a4L4rQSWunxFk+J9ctbygtK7qcQp0WRBI51/qnAb35FYk4RySJ
 dpPQrq2ntOrc4ewCVWszvc2hel+obRENF3TmCWhYl+3Sf//Bq6SGjnrumm44luzdRdRY
 ybp+PSbtDPaedCV84MrtXLTDq4Qq3Ip2sbwgkBmsjVEszBbIpeSnVZYrlRJ05G6Fcsn2
 8PwDbX22Z4ntTVLV3t9j1ZqO8M8JpsHW5glFghs8evM0yvniNwtLq5zbfzzsNQ6ZFpXO
 IB8k5ehWa3g+ShRqjLofiwcj6w8cfgCHmBIC7vufD9I6VOl1j0egU9eEk1JVOVs2ZlZV
 IHkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFl/YS0J+gT+uivhEr0BCXQ7mfaiIUPx6hWoZBfSX6uOaE8htxn4UGV/oU50HnE1IgnCCJX+vorTJb@nongnu.org
X-Gm-Message-State: AOJu0Yx2I/qWXOZGgs98JBawHuoy2AWM1OqXRCrZP0dLjZBSePq9cRCj
 G7ct40BT8CFYGCjODazCFVGrsnda4ipO2bhfkQOsbRWQ7gnybg/vHt8P/7mhaAA=
X-Gm-Gg: ASbGnctHSUmb0RWLbhP0ZqKgYe/ge6Q8aUh5uuRRdZJGcqBr80J9kJTeK0CpetjyiC4
 LSeW1LAn2G2i7e4iwKp5n0zrZvV+jOAhRWGc+z8HLMofh3dRjot7r0XSso6oj9mTz8pm7bkEFmX
 A+RIm+lTyijI1Y+bRB3BsZOtQM6c+K6/kMJ1W5zI8ibyriZBvZlWMhuoedh9PNvJxB1qDM3FvT0
 RnG7Z+a7P51ShIkXgajf8kbHS0JIfO8xuGkWJ76x9Yz+U2WMC9+Ol2vOvE97qM0/axT36uLyCZH
 6JdaHsu2ZrNIIGpqeUJNer7rK+kKMCzg3pUVvijnwUC9/EZvVSgHG/r9Xg==
X-Google-Smtp-Source: AGHT+IH/smRTpReLHOEHZvgsu+gEofJJqbRkx/KIaxyEPBUoQYUD7oEq36t/WdWPIWd243UYcObvgw==
X-Received: by 2002:a05:6a21:789c:b0:1f5:7280:1cf7 with SMTP id
 adf61e73a8af0-1fd11800f26mr3574987637.16.1742451675449; 
 Wed, 19 Mar 2025 23:21:15 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167d764sm13298961b3a.98.2025.03.19.23.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 23:21:14 -0700 (PDT)
Message-ID: <552d5c6f-61ae-43e5-90e5-c94639b40b71@daynix.com>
Date: Thu, 20 Mar 2025 15:21:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] target/arm: convert 32 bit gdbstub to new helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-4-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250319182255.3096731-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/20 3:22, Alex Bennée wrote:
> For some of the helpers we need a temporary variable to copy from
> although we could add some helpers to return pointers into env in
> those cases if we wanted to.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/gdbstub.c | 57 ++++++++++++++++++++++++++++----------------
>   1 file changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 30068c2262..14d931b0bf 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -20,7 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/gdbstub.h"
> -#include "gdbstub/helpers.h"
> +#include "gdbstub/registers.h"
>   #include "gdbstub/commands.h"
>   #include "system/tcg.h"
>   #include "internals.h"
> @@ -33,12 +33,16 @@ typedef struct RegisterSysregFeatureParam {
>       int n;
>   } RegisterSysregFeatureParam;
>   
> -/* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
> -   whatever the target description contains.  Due to a historical mishap
> -   the FPA registers appear in between core integer regs and the CPSR.
> -   We hack round this by giving the FPA regs zero size when talking to a
> -   newer gdb.  */
> -
> +/*
> + * Old gdb always expect FPA registers. Newer (xml-aware) gdb only
> + * expect whatever the target description contains. Due to a
> + * historical mishap the FPA registers appear in between core integer
> + * regs and the CPSR. We hack round this by giving the FPA regs zero
> + * size when talking to a newer gdb.
> + *
> + * While gdb cares about the memory endianess of the target all
> + * registers are passed in little-endian mode.
> + */
>   int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
>       ARMCPU *cpu = ARM_CPU(cs);
> @@ -46,15 +50,17 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   
>       if (n < 16) {
>           /* Core integer register.  */
> -        return gdb_get_reg32(mem_buf, env->regs[n]);
> +        return gdb_get_register_value(MO_TEUL, mem_buf, (uint8_t *) &env->regs[n]);

Having a whitespace between the cast and the later expression is unusual 
though checkpatch.pl doesn't complain.

>       }
>       if (n == 25) {
>           /* CPSR, or XPSR for M-profile */
> +        uint32_t reg;
>           if (arm_feature(env, ARM_FEATURE_M)) {
> -            return gdb_get_reg32(mem_buf, xpsr_read(env));
> +            reg = xpsr_read(env);
>           } else {
> -            return gdb_get_reg32(mem_buf, cpsr_read(env));
> +            reg = cpsr_read(env);
>           }
> +        return gdb_get_register_value(MO_TEUL, mem_buf, (uint8_t *) &reg);
>       }
>       /* Unknown register.  */
>       return 0;
> @@ -115,19 +121,22 @@ static int vfp_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
>   
>       /* VFP data registers are always little-endian.  */
>       if (reg < nregs) {
> -        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
> +        return gdb_get_register_value(MO_TEUQ, buf,
> +                                      (uint8_t *) aa32_vfp_dreg(env, reg));
>       }
>       if (arm_feature(env, ARM_FEATURE_NEON)) {
>           /* Aliases for Q regs.  */
>           nregs += 16;
>           if (reg < nregs) {
>               uint64_t *q = aa32_vfp_qreg(env, reg - 32);
> -            return gdb_get_reg128(buf, q[0], q[1]);
> +            return gdb_get_register_value(MO_TEUO, buf, (uint8_t *) q);
>           }
>       }
>       switch (reg - nregs) {
> +        uint32_t fpcr;
>       case 0:
> -        return gdb_get_reg32(buf, vfp_get_fpscr(env));
> +        fpcr = vfp_get_fpscr(env);
> +        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpcr);
>       }
>       return 0;
>   }
> @@ -166,9 +175,11 @@ static int vfp_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
>   
>       switch (reg) {
>       case 0:
> -        return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]);
> +        return gdb_get_register_value(MO_TEUL, buf,
> +                                      (uint8_t *) &env->vfp.xregs[ARM_VFP_FPSID]);
>       case 1:
> -        return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]);
> +        return gdb_get_register_value(MO_TEUL, buf,
> +                                      (uint8_t *) &env->vfp.xregs[ARM_VFP_FPEXC]);
>       }
>       return 0;
>   }
> @@ -196,7 +207,8 @@ static int mve_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
>   
>       switch (reg) {
>       case 0:
> -        return gdb_get_reg32(buf, env->v7m.vpr);
> +        return gdb_get_register_value(MO_TEUL, buf,
> +                                      (uint8_t *) &env->v7m.vpr);
>       default:
>           return 0;
>       }
> @@ -236,9 +248,11 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
>       ri = get_arm_cp_reginfo(cpu->cp_regs, key);
>       if (ri) {
>           if (cpreg_field_is_64bit(ri)) {
> -            return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
> +            uint64_t cpreg = read_raw_cp_reg(env, ri);
> +            return gdb_get_register_value(MO_TEUQ, buf, (uint8_t *) &cpreg);
>           } else {
> -            return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
> +            uint32_t cpreg = (uint32_t) read_raw_cp_reg(env, ri);
> +            return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &cpreg);
>           }
>       }
>       return 0;
> @@ -375,12 +389,12 @@ static uint32_t *m_sysreg_ptr(CPUARMState *env, MProfileSysreg reg, bool sec)
>   static int m_sysreg_get(CPUARMState *env, GByteArray *buf,
>                           MProfileSysreg reg, bool secure)
>   {
> -    uint32_t *ptr = m_sysreg_ptr(env, reg, secure);
> +    uint8_t *ptr = (uint8_t *) m_sysreg_ptr(env, reg, secure);
>   
>       if (ptr == NULL) {
>           return 0;
>       }
> -    return gdb_get_reg32(buf, *ptr);
> +    return gdb_get_register_value(MO_TEUL, buf, ptr);
>   }
>   
>   static int arm_gdb_get_m_systemreg(CPUState *cs, GByteArray *buf, int reg)
> @@ -393,7 +407,8 @@ static int arm_gdb_get_m_systemreg(CPUState *cs, GByteArray *buf, int reg)
>        * banked and non-banked bits.
>        */
>       if (reg == M_SYSREG_CONTROL) {
> -        return gdb_get_reg32(buf, arm_v7m_mrs_control(env, env->v7m.secure));
> +        uint32_t reg32 = arm_v7m_mrs_control(env, env->v7m.secure);
> +        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &reg32);
>       }
>       return m_sysreg_get(env, buf, reg, env->v7m.secure);
>   }


