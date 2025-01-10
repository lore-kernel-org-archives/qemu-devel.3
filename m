Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AB6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWGzr-00050f-6l; Fri, 10 Jan 2025 10:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWGzn-0004yK-OJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:32:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWGzl-0006NW-1L
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:32:23 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso21790955e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736523139; x=1737127939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CisKhuxBdio+Oc2+SDw+KF15xBdQ4U91OOxEXicXNN8=;
 b=gk/PS4LrrzpPMCUniUhhBa1Q8OmVfXSXMyTBpy6ZBiDlMJzxIXhMN1ekHT8ReAc1RE
 mZROqN2nL9XfGa9vV8GFL90VsqVkCPnh8W4G8mizlq4RFCeJnQrfpf349xtMADBx+ZCW
 ztpzeOPlF9Wvxo+xvsTtRkjSLWP25s4Ihz750f4h+HUzGxoDUquYKhqZ7YahZtxDIUmw
 1jtQedTx86lJ6gD/Wh/9FUYtFb6hiyVzO/7YMUMm/MqzAhOQ4ogCcW117U2nPTmjqwe5
 CKdLAi7F8Iqu/n+2Ca93OokFexvzYBvOkv7P1aNAsYzMwehv7wwGVaikpJ2MRABpLWz3
 aseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736523139; x=1737127939;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CisKhuxBdio+Oc2+SDw+KF15xBdQ4U91OOxEXicXNN8=;
 b=jRZZV8nUfXDuk0deqwPAzKOuNQTZDeH4x2QPa4yczFR5cOYRuUZJiI/hZJiMGMPIIg
 NA4qR7qH8WiDFzbiyOw5il1V04L0ihyp9tLpZkf4B/QFADDS7tCF5ZY+1YFrdkK8m/V1
 As6ZfO/EEtM5eU8EvQZDnBWt+0n8rI+2+tpnc6QdrTrRkJl26fGInQ4WtJ8vplJXfKz3
 smZDzG4Y0PC6Q6NeWnb/mf+3dJltGRHDrogyPsFMW6Vf9ZeArpGkf7ptqeudpKzP3HDo
 PZqctnD/rr4ubQemVSCbjiK5GqTkYRT9J9f97Hmeuf2apx2rU3V3znSjG/FSMGkLD/wf
 ISGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBYsrD40WhTrjuMQ5+9OTrYpp/qODSpE1BHe4MyH25oIo9L/Yb5XjukijmKhtyw4yCMRFWIJdCyYpp@nongnu.org
X-Gm-Message-State: AOJu0Yz7c9SBbJLIK0DhMIClgA+uzjH8QzemN+zV9tN+yzwfUp9cMdTL
 GOXJGCqaZWvIJmKOxj/TK9XYL9lyoBrT325zza3ScAH0bSDkEkNHH/H7aO/VuEM=
X-Gm-Gg: ASbGncsR0IiU0NNswf319pPzdD/Pl/NSFXCD0CRXm119NWKqGc1faBpMMOob09P2801
 8bfujZX/kY2LamBXsuV9nyK5ByMyb0Xsar9br+29KX47ZZgMJlHMi0sQgyUJ2DGJH1yFmORwYVk
 wybEUXR6MmeLCmQekwU8vSIwWejA7G3iHBRRRf9WG9i1eN1yLvFGR5YcouxKd91QN/L2JD9/gM7
 4mw3t/xg1K5gw9WF/oja/rtRIRlkSbIhUTzVpjXJ6Vd+t7hCZWLsPk=
X-Google-Smtp-Source: AGHT+IFJjbcYxcyAl3T1dxz4ra60pOYmcyCvmPIZBoT6wcp+7jMMr3mj5IWCXwCLVtlw1fH7UkONcA==
X-Received: by 2002:a05:600c:1c88:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-436e271d10fmr92579675e9.27.1736523139012; 
 Fri, 10 Jan 2025 07:32:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0bb7sm88847965e9.16.2025.01.10.07.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 07:32:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 514445F8C8;
 Fri, 10 Jan 2025 15:32:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] target/arm: Move minor arithmetic helpers out of
 helper.c
In-Reply-To: <20250110131211.2546314-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 10 Jan 2025 13:12:11 +0000")
References: <20250110131211.2546314-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 10 Jan 2025 15:32:17 +0000
Message-ID: <877c724rcu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> helper.c includes some small TCG helper functions used for mostly
> arithmetic instructions.  These are TCG only and there's no need for
> them to be in the large and unwieldy helper.c.  Move them out to
> their own source file in the tcg/ subdirectory, together with the
> op_addsub.h multiply-included template header that they use.
>
> Since we are moving op_addsub.h, we take the opportunity to
> give it a name which matches our convention for files which
> are not true header files but which are #included from other
> C files: op_addsub.c.inc.
>
> (Ironically, this means that helper.c no longer contains
> any TCG helper function definitions at all.)

What's left? It mostly looks like cpreg related stuff. I guess it could
become cpreg.c?

>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
> v1->v2: rename op_addsub.h to op_addsub.c.inc.
> ---
>  target/arm/helper.c                           | 285 -----------------
>  target/arm/tcg/arith_helper.c                 | 296 ++++++++++++++++++
>  .../arm/{op_addsub.h =3D> tcg/op_addsub.c.inc}  |   0
>  target/arm/tcg/meson.build                    |   1 +
>  4 files changed, 297 insertions(+), 285 deletions(-)
>  create mode 100644 target/arm/tcg/arith_helper.c
>  rename target/arm/{op_addsub.h =3D> tcg/op_addsub.c.inc} (100%)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 5b595f951b4..63997678513 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -17,11 +17,9 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/timer.h"
>  #include "qemu/bitops.h"
> -#include "qemu/crc32c.h"
>  #include "qemu/qemu-print.h"
>  #include "exec/exec-all.h"
>  #include "exec/translation-block.h"
> -#include <zlib.h> /* for crc32 */
>  #include "hw/irq.h"
>  #include "system/cpu-timers.h"
>  #include "system/kvm.h"
> @@ -10984,289 +10982,6 @@ ARMVAParameters aa64_va_parameters(CPUARMState =
*env, uint64_t va,
>      };
>  }
>=20=20
> -/*
> - * Note that signed overflow is undefined in C.  The following routines =
are
> - * careful to use unsigned types where modulo arithmetic is required.
> - * Failure to do so _will_ break on newer gcc.
> - */
> -
> -/* Signed saturating arithmetic.  */
> -
> -/* Perform 16-bit signed saturating addition.  */
> -static inline uint16_t add16_sat(uint16_t a, uint16_t b)
> -{
> -    uint16_t res;
> -
> -    res =3D a + b;
> -    if (((res ^ a) & 0x8000) && !((a ^ b) & 0x8000)) {
> -        if (a & 0x8000) {
> -            res =3D 0x8000;
> -        } else {
> -            res =3D 0x7fff;
> -        }
> -    }
> -    return res;
> -}
> -
> -/* Perform 8-bit signed saturating addition.  */
> -static inline uint8_t add8_sat(uint8_t a, uint8_t b)
> -{
> -    uint8_t res;
> -
> -    res =3D a + b;
> -    if (((res ^ a) & 0x80) && !((a ^ b) & 0x80)) {
> -        if (a & 0x80) {
> -            res =3D 0x80;
> -        } else {
> -            res =3D 0x7f;
> -        }
> -    }
> -    return res;
> -}
> -
> -/* Perform 16-bit signed saturating subtraction.  */
> -static inline uint16_t sub16_sat(uint16_t a, uint16_t b)
> -{
> -    uint16_t res;
> -
> -    res =3D a - b;
> -    if (((res ^ a) & 0x8000) && ((a ^ b) & 0x8000)) {
> -        if (a & 0x8000) {
> -            res =3D 0x8000;
> -        } else {
> -            res =3D 0x7fff;
> -        }
> -    }
> -    return res;
> -}
> -
> -/* Perform 8-bit signed saturating subtraction.  */
> -static inline uint8_t sub8_sat(uint8_t a, uint8_t b)
> -{
> -    uint8_t res;
> -
> -    res =3D a - b;
> -    if (((res ^ a) & 0x80) && ((a ^ b) & 0x80)) {
> -        if (a & 0x80) {
> -            res =3D 0x80;
> -        } else {
> -            res =3D 0x7f;
> -        }
> -    }
> -    return res;
> -}
> -
> -#define ADD16(a, b, n) RESULT(add16_sat(a, b), n, 16);
> -#define SUB16(a, b, n) RESULT(sub16_sat(a, b), n, 16);
> -#define ADD8(a, b, n)  RESULT(add8_sat(a, b), n, 8);
> -#define SUB8(a, b, n)  RESULT(sub8_sat(a, b), n, 8);
> -#define PFX q
> -
> -#include "op_addsub.h"
> -
> -/* Unsigned saturating arithmetic.  */
> -static inline uint16_t add16_usat(uint16_t a, uint16_t b)
> -{
> -    uint16_t res;
> -    res =3D a + b;
> -    if (res < a) {
> -        res =3D 0xffff;
> -    }
> -    return res;
> -}
> -
> -static inline uint16_t sub16_usat(uint16_t a, uint16_t b)
> -{
> -    if (a > b) {
> -        return a - b;
> -    } else {
> -        return 0;
> -    }
> -}
> -
> -static inline uint8_t add8_usat(uint8_t a, uint8_t b)
> -{
> -    uint8_t res;
> -    res =3D a + b;
> -    if (res < a) {
> -        res =3D 0xff;
> -    }
> -    return res;
> -}
> -
> -static inline uint8_t sub8_usat(uint8_t a, uint8_t b)
> -{
> -    if (a > b) {
> -        return a - b;
> -    } else {
> -        return 0;
> -    }
> -}
> -
> -#define ADD16(a, b, n) RESULT(add16_usat(a, b), n, 16);
> -#define SUB16(a, b, n) RESULT(sub16_usat(a, b), n, 16);
> -#define ADD8(a, b, n)  RESULT(add8_usat(a, b), n, 8);
> -#define SUB8(a, b, n)  RESULT(sub8_usat(a, b), n, 8);
> -#define PFX uq
> -
> -#include "op_addsub.h"
> -
> -/* Signed modulo arithmetic.  */
> -#define SARITH16(a, b, n, op) do { \
> -    int32_t sum; \
> -    sum =3D (int32_t)(int16_t)(a) op (int32_t)(int16_t)(b); \
> -    RESULT(sum, n, 16); \
> -    if (sum >=3D 0) \
> -        ge |=3D 3 << (n * 2); \
> -    } while (0)
> -
> -#define SARITH8(a, b, n, op) do { \
> -    int32_t sum; \
> -    sum =3D (int32_t)(int8_t)(a) op (int32_t)(int8_t)(b); \
> -    RESULT(sum, n, 8); \
> -    if (sum >=3D 0) \
> -        ge |=3D 1 << n; \
> -    } while (0)
> -
> -
> -#define ADD16(a, b, n) SARITH16(a, b, n, +)
> -#define SUB16(a, b, n) SARITH16(a, b, n, -)
> -#define ADD8(a, b, n)  SARITH8(a, b, n, +)
> -#define SUB8(a, b, n)  SARITH8(a, b, n, -)
> -#define PFX s
> -#define ARITH_GE
> -
> -#include "op_addsub.h"
> -
> -/* Unsigned modulo arithmetic.  */
> -#define ADD16(a, b, n) do { \
> -    uint32_t sum; \
> -    sum =3D (uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b); \
> -    RESULT(sum, n, 16); \
> -    if ((sum >> 16) =3D=3D 1) \
> -        ge |=3D 3 << (n * 2); \
> -    } while (0)
> -
> -#define ADD8(a, b, n) do { \
> -    uint32_t sum; \
> -    sum =3D (uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b); \
> -    RESULT(sum, n, 8); \
> -    if ((sum >> 8) =3D=3D 1) \
> -        ge |=3D 1 << n; \
> -    } while (0)
> -
> -#define SUB16(a, b, n) do { \
> -    uint32_t sum; \
> -    sum =3D (uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b); \
> -    RESULT(sum, n, 16); \
> -    if ((sum >> 16) =3D=3D 0) \
> -        ge |=3D 3 << (n * 2); \
> -    } while (0)
> -
> -#define SUB8(a, b, n) do { \
> -    uint32_t sum; \
> -    sum =3D (uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b); \
> -    RESULT(sum, n, 8); \
> -    if ((sum >> 8) =3D=3D 0) \
> -        ge |=3D 1 << n; \
> -    } while (0)
> -
> -#define PFX u
> -#define ARITH_GE
> -
> -#include "op_addsub.h"
> -
> -/* Halved signed arithmetic.  */
> -#define ADD16(a, b, n) \
> -  RESULT(((int32_t)(int16_t)(a) + (int32_t)(int16_t)(b)) >> 1, n, 16)
> -#define SUB16(a, b, n) \
> -  RESULT(((int32_t)(int16_t)(a) - (int32_t)(int16_t)(b)) >> 1, n, 16)
> -#define ADD8(a, b, n) \
> -  RESULT(((int32_t)(int8_t)(a) + (int32_t)(int8_t)(b)) >> 1, n, 8)
> -#define SUB8(a, b, n) \
> -  RESULT(((int32_t)(int8_t)(a) - (int32_t)(int8_t)(b)) >> 1, n, 8)
> -#define PFX sh
> -
> -#include "op_addsub.h"
> -
> -/* Halved unsigned arithmetic.  */
> -#define ADD16(a, b, n) \
> -  RESULT(((uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b)) >> 1, n, 16)
> -#define SUB16(a, b, n) \
> -  RESULT(((uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b)) >> 1, n, 16)
> -#define ADD8(a, b, n) \
> -  RESULT(((uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b)) >> 1, n, 8)
> -#define SUB8(a, b, n) \
> -  RESULT(((uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b)) >> 1, n, 8)
> -#define PFX uh
> -
> -#include "op_addsub.h"
> -
> -static inline uint8_t do_usad(uint8_t a, uint8_t b)
> -{
> -    if (a > b) {
> -        return a - b;
> -    } else {
> -        return b - a;
> -    }
> -}
> -
> -/* Unsigned sum of absolute byte differences.  */
> -uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
> -{
> -    uint32_t sum;
> -    sum =3D do_usad(a, b);
> -    sum +=3D do_usad(a >> 8, b >> 8);
> -    sum +=3D do_usad(a >> 16, b >> 16);
> -    sum +=3D do_usad(a >> 24, b >> 24);
> -    return sum;
> -}
> -
> -/* For ARMv6 SEL instruction.  */
> -uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
> -{
> -    uint32_t mask;
> -
> -    mask =3D 0;
> -    if (flags & 1) {
> -        mask |=3D 0xff;
> -    }
> -    if (flags & 2) {
> -        mask |=3D 0xff00;
> -    }
> -    if (flags & 4) {
> -        mask |=3D 0xff0000;
> -    }
> -    if (flags & 8) {
> -        mask |=3D 0xff000000;
> -    }
> -    return (a & mask) | (b & ~mask);
> -}
> -
> -/*
> - * CRC helpers.
> - * The upper bytes of val (above the number specified by 'bytes') must h=
ave
> - * been zeroed out by the caller.
> - */
> -uint32_t HELPER(crc32)(uint32_t acc, uint32_t val, uint32_t bytes)
> -{
> -    uint8_t buf[4];
> -
> -    stl_le_p(buf, val);
> -
> -    /* zlib crc32 converts the accumulator and output to one's complemen=
t.  */
> -    return crc32(acc ^ 0xffffffff, buf, bytes) ^ 0xffffffff;
> -}
> -
> -uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
> -{
> -    uint8_t buf[4];
> -
> -    stl_le_p(buf, val);
> -
> -    /* Linux crc32c converts the output to one's complement.  */
> -    return crc32c(acc, buf, bytes) ^ 0xffffffff;
> -}
>=20=20
>  /*
>   * Return the exception level to which FP-disabled exceptions should
> diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
> new file mode 100644
> index 00000000000..9a555c7966c
> --- /dev/null
> +++ b/target/arm/tcg/arith_helper.c
> @@ -0,0 +1,296 @@
> +/*
> + * ARM generic helpers for various arithmetical operations.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +#include "qemu/crc32c.h"
> +#include <zlib.h> /* for crc32 */
> +
> +/*
> + * Note that signed overflow is undefined in C.  The following routines =
are
> + * careful to use unsigned types where modulo arithmetic is required.
> + * Failure to do so _will_ break on newer gcc.
> + */
> +
> +/* Signed saturating arithmetic.  */
> +
> +/* Perform 16-bit signed saturating addition.  */
> +static inline uint16_t add16_sat(uint16_t a, uint16_t b)
> +{
> +    uint16_t res;
> +
> +    res =3D a + b;
> +    if (((res ^ a) & 0x8000) && !((a ^ b) & 0x8000)) {
> +        if (a & 0x8000) {
> +            res =3D 0x8000;
> +        } else {
> +            res =3D 0x7fff;
> +        }
> +    }
> +    return res;
> +}
> +
> +/* Perform 8-bit signed saturating addition.  */
> +static inline uint8_t add8_sat(uint8_t a, uint8_t b)
> +{
> +    uint8_t res;
> +
> +    res =3D a + b;
> +    if (((res ^ a) & 0x80) && !((a ^ b) & 0x80)) {
> +        if (a & 0x80) {
> +            res =3D 0x80;
> +        } else {
> +            res =3D 0x7f;
> +        }
> +    }
> +    return res;
> +}
> +
> +/* Perform 16-bit signed saturating subtraction.  */
> +static inline uint16_t sub16_sat(uint16_t a, uint16_t b)
> +{
> +    uint16_t res;
> +
> +    res =3D a - b;
> +    if (((res ^ a) & 0x8000) && ((a ^ b) & 0x8000)) {
> +        if (a & 0x8000) {
> +            res =3D 0x8000;
> +        } else {
> +            res =3D 0x7fff;
> +        }
> +    }
> +    return res;
> +}
> +
> +/* Perform 8-bit signed saturating subtraction.  */
> +static inline uint8_t sub8_sat(uint8_t a, uint8_t b)
> +{
> +    uint8_t res;
> +
> +    res =3D a - b;
> +    if (((res ^ a) & 0x80) && ((a ^ b) & 0x80)) {
> +        if (a & 0x80) {
> +            res =3D 0x80;
> +        } else {
> +            res =3D 0x7f;
> +        }
> +    }
> +    return res;
> +}
> +
> +#define ADD16(a, b, n) RESULT(add16_sat(a, b), n, 16);
> +#define SUB16(a, b, n) RESULT(sub16_sat(a, b), n, 16);
> +#define ADD8(a, b, n)  RESULT(add8_sat(a, b), n, 8);
> +#define SUB8(a, b, n)  RESULT(sub8_sat(a, b), n, 8);
> +#define PFX q
> +
> +#include "op_addsub.c.inc"
> +
> +/* Unsigned saturating arithmetic.  */
> +static inline uint16_t add16_usat(uint16_t a, uint16_t b)
> +{
> +    uint16_t res;
> +    res =3D a + b;
> +    if (res < a) {
> +        res =3D 0xffff;
> +    }
> +    return res;
> +}
> +
> +static inline uint16_t sub16_usat(uint16_t a, uint16_t b)
> +{
> +    if (a > b) {
> +        return a - b;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static inline uint8_t add8_usat(uint8_t a, uint8_t b)
> +{
> +    uint8_t res;
> +    res =3D a + b;
> +    if (res < a) {
> +        res =3D 0xff;
> +    }
> +    return res;
> +}
> +
> +static inline uint8_t sub8_usat(uint8_t a, uint8_t b)
> +{
> +    if (a > b) {
> +        return a - b;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +#define ADD16(a, b, n) RESULT(add16_usat(a, b), n, 16);
> +#define SUB16(a, b, n) RESULT(sub16_usat(a, b), n, 16);
> +#define ADD8(a, b, n)  RESULT(add8_usat(a, b), n, 8);
> +#define SUB8(a, b, n)  RESULT(sub8_usat(a, b), n, 8);
> +#define PFX uq
> +
> +#include "op_addsub.c.inc"
> +
> +/* Signed modulo arithmetic.  */
> +#define SARITH16(a, b, n, op) do { \
> +    int32_t sum; \
> +    sum =3D (int32_t)(int16_t)(a) op (int32_t)(int16_t)(b); \
> +    RESULT(sum, n, 16); \
> +    if (sum >=3D 0) \
> +        ge |=3D 3 << (n * 2); \
> +    } while (0)
> +
> +#define SARITH8(a, b, n, op) do { \
> +    int32_t sum; \
> +    sum =3D (int32_t)(int8_t)(a) op (int32_t)(int8_t)(b); \
> +    RESULT(sum, n, 8); \
> +    if (sum >=3D 0) \
> +        ge |=3D 1 << n; \
> +    } while (0)
> +
> +
> +#define ADD16(a, b, n) SARITH16(a, b, n, +)
> +#define SUB16(a, b, n) SARITH16(a, b, n, -)
> +#define ADD8(a, b, n)  SARITH8(a, b, n, +)
> +#define SUB8(a, b, n)  SARITH8(a, b, n, -)
> +#define PFX s
> +#define ARITH_GE
> +
> +#include "op_addsub.c.inc"
> +
> +/* Unsigned modulo arithmetic.  */
> +#define ADD16(a, b, n) do { \
> +    uint32_t sum; \
> +    sum =3D (uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b); \
> +    RESULT(sum, n, 16); \
> +    if ((sum >> 16) =3D=3D 1) \
> +        ge |=3D 3 << (n * 2); \
> +    } while (0)
> +
> +#define ADD8(a, b, n) do { \
> +    uint32_t sum; \
> +    sum =3D (uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b); \
> +    RESULT(sum, n, 8); \
> +    if ((sum >> 8) =3D=3D 1) \
> +        ge |=3D 1 << n; \
> +    } while (0)
> +
> +#define SUB16(a, b, n) do { \
> +    uint32_t sum; \
> +    sum =3D (uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b); \
> +    RESULT(sum, n, 16); \
> +    if ((sum >> 16) =3D=3D 0) \
> +        ge |=3D 3 << (n * 2); \
> +    } while (0)
> +
> +#define SUB8(a, b, n) do { \
> +    uint32_t sum; \
> +    sum =3D (uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b); \
> +    RESULT(sum, n, 8); \
> +    if ((sum >> 8) =3D=3D 0) \
> +        ge |=3D 1 << n; \
> +    } while (0)
> +
> +#define PFX u
> +#define ARITH_GE
> +
> +#include "op_addsub.c.inc"
> +
> +/* Halved signed arithmetic.  */
> +#define ADD16(a, b, n) \
> +  RESULT(((int32_t)(int16_t)(a) + (int32_t)(int16_t)(b)) >> 1, n, 16)
> +#define SUB16(a, b, n) \
> +  RESULT(((int32_t)(int16_t)(a) - (int32_t)(int16_t)(b)) >> 1, n, 16)
> +#define ADD8(a, b, n) \
> +  RESULT(((int32_t)(int8_t)(a) + (int32_t)(int8_t)(b)) >> 1, n, 8)
> +#define SUB8(a, b, n) \
> +  RESULT(((int32_t)(int8_t)(a) - (int32_t)(int8_t)(b)) >> 1, n, 8)
> +#define PFX sh
> +
> +#include "op_addsub.c.inc"
> +
> +/* Halved unsigned arithmetic.  */
> +#define ADD16(a, b, n) \
> +  RESULT(((uint32_t)(uint16_t)(a) + (uint32_t)(uint16_t)(b)) >> 1, n, 16)
> +#define SUB16(a, b, n) \
> +  RESULT(((uint32_t)(uint16_t)(a) - (uint32_t)(uint16_t)(b)) >> 1, n, 16)
> +#define ADD8(a, b, n) \
> +  RESULT(((uint32_t)(uint8_t)(a) + (uint32_t)(uint8_t)(b)) >> 1, n, 8)
> +#define SUB8(a, b, n) \
> +  RESULT(((uint32_t)(uint8_t)(a) - (uint32_t)(uint8_t)(b)) >> 1, n, 8)
> +#define PFX uh
> +
> +#include "op_addsub.c.inc"
> +
> +static inline uint8_t do_usad(uint8_t a, uint8_t b)
> +{
> +    if (a > b) {
> +        return a - b;
> +    } else {
> +        return b - a;
> +    }
> +}
> +
> +/* Unsigned sum of absolute byte differences.  */
> +uint32_t HELPER(usad8)(uint32_t a, uint32_t b)
> +{
> +    uint32_t sum;
> +    sum =3D do_usad(a, b);
> +    sum +=3D do_usad(a >> 8, b >> 8);
> +    sum +=3D do_usad(a >> 16, b >> 16);
> +    sum +=3D do_usad(a >> 24, b >> 24);
> +    return sum;
> +}
> +
> +/* For ARMv6 SEL instruction.  */
> +uint32_t HELPER(sel_flags)(uint32_t flags, uint32_t a, uint32_t b)
> +{
> +    uint32_t mask;
> +
> +    mask =3D 0;
> +    if (flags & 1) {
> +        mask |=3D 0xff;
> +    }
> +    if (flags & 2) {
> +        mask |=3D 0xff00;
> +    }
> +    if (flags & 4) {
> +        mask |=3D 0xff0000;
> +    }
> +    if (flags & 8) {
> +        mask |=3D 0xff000000;
> +    }
> +    return (a & mask) | (b & ~mask);
> +}
> +
> +/*
> + * CRC helpers.
> + * The upper bytes of val (above the number specified by 'bytes') must h=
ave
> + * been zeroed out by the caller.
> + */
> +uint32_t HELPER(crc32)(uint32_t acc, uint32_t val, uint32_t bytes)
> +{
> +    uint8_t buf[4];
> +
> +    stl_le_p(buf, val);
> +
> +    /* zlib crc32 converts the accumulator and output to one's complemen=
t.  */
> +    return crc32(acc ^ 0xffffffff, buf, bytes) ^ 0xffffffff;
> +}
> +
> +uint32_t HELPER(crc32c)(uint32_t acc, uint32_t val, uint32_t bytes)
> +{
> +    uint8_t buf[4];
> +
> +    stl_le_p(buf, val);
> +
> +    /* Linux crc32c converts the output to one's complement.  */
> +    return crc32c(acc, buf, bytes) ^ 0xffffffff;
> +}
> diff --git a/target/arm/op_addsub.h b/target/arm/tcg/op_addsub.c.inc
> similarity index 100%
> rename from target/arm/op_addsub.h
> rename to target/arm/tcg/op_addsub.c.inc
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 09238989c5a..1f9077c372c 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -40,6 +40,7 @@ arm_ss.add(files(
>    'tlb_helper.c',
>    'vec_helper.c',
>    'tlb-insns.c',
> +  'arith_helper.c',
>  ))
>=20=20
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

