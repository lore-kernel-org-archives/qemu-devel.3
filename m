Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D6ACAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4y-0003Av-MM; Tue, 16 Sep 2025 14:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4b-00037i-Vr
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4Y-0001bx-1a
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45f2313dd86so39834135e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045992; x=1758650792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eVUYoZqnYMK4s3Lt2y/CTWDewwQXx/+g/NEEF8AEsyA=;
 b=PaS39M0Pl/5GoA+xvTdGuSmGeH8OAqo8z78E10Hq3tnzP6nLm1rzrTIzml+nYvI4gf
 azAz/W8o9h/COODoA+O8LoA71pcJ4Zvj/w/uo7xW52s9i95ljpCppi1scC/hikwIUuHh
 H1kcmHp0tZvXDmdNiZO+y1MoYeZk2mup+QF8xq2sRkB2NGrZDaxMpdN1BXpNYKCFtI4u
 arZC6koui0nKQ4UGyWlJyo9gWGL5FU2itSj0TdxMAaGAQd1e9L26oq3dPXmO1Bb39+27
 EgEJgx7ARQDxZ9ozrZQ0r0Ky+dmPsTyUnC+2bbZSVuFoWhdXBri7jjuWXXR7JRrpNfx9
 ROXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045992; x=1758650792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVUYoZqnYMK4s3Lt2y/CTWDewwQXx/+g/NEEF8AEsyA=;
 b=kMnYvQUS8NTu2+8D31T6rdWAecmklVsEOEvxmkX3kmSTboI5fDfcCLJvNPKK42w6Y0
 zwVnB5KXbuRlhNsCNQhdW2Dyu17CwwNGA35lrwO4TojOVSeswllyZEzVS0Tb6Z1Sw8ql
 rrczyuFVbUdQTLRimEROxX+GjjEd13kbKq4JhmmMfFQI8yInv0s962yMSWUANFj5wOQK
 fHSwYshxoZ87UB37n++d9rXYGIRfMh2gu4hAgVVX3hwTtLPly4cxdXUlsL+FCiLYG7P8
 MKPVKiCmYqWD8qMPfihPVjliwicpKKD47YwPXjS4qANDf9yvWj9GpvsNpPCqxhsVUA7P
 7BLQ==
X-Gm-Message-State: AOJu0Yxt3nWDbn64fzlLfIlHJEoQvfhmBJziWIvKi5oXu1UPYRJBrjKR
 aspG3oGdo9XhE4PocyD7Qf5kR1Jhtn/5oClgvX3CUNm9F3w2/lsy5AeQR2m7bTfD7Q2LkTyPT1D
 VoY/i
X-Gm-Gg: ASbGncuOLFyVzi3vaouHwb06eLeE6WCXzVtK4wJ4R8kgHaJnCxemqTzbijz2PFXvYn5
 GUcsUVp+JzDnWWn16d9uWqc+te9/6ZFjzZcOuRlwbhWu6jekjihIG+mG3ZGspPzL0BgQ1tvxPpI
 QYmEzex6NbYAhekpkQyu+sV1BQnBF7TRi/zt5CpjE0JHG0ZkRiaqO9TrognqdUUYrD8QYLzxmtM
 tjOJVxA93S5ObmTfU3KxZCkCGO+MOpbjadcF/SiUcKaY12iNYh7iY4ApKpeIY816TmMFeK29y9n
 /6NpHL5Upp1UXuQeoUlqHr0lblc1qca/O3zJESCF1kVskPJMaWnlT2f5/VtQ6EN0eXXHX4rXRFR
 C14bNmwCetBi2YhkC7MnDdw5yN1k1VfTu2d74Mzc=
X-Google-Smtp-Source: AGHT+IEm5tQF3XVhcT5fvdK5uyFCjJ3t17R8d6oAGCwbypg2zhUz4EYHsdjtJmeL24tFn2EA/mq1Bg==
X-Received: by 2002:a05:600c:3106:b0:45b:8543:c8c9 with SMTP id
 5b1f17b1804b1-45f215641e8mr143311405e9.34.1758045991922; 
 Tue, 16 Sep 2025 11:06:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/36] target/arm: Remove iwmmxt helper functions
Date: Tue, 16 Sep 2025 19:05:51 +0100
Message-ID: <20250916180611.1481266-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Remove the iwmmxt helper functions which are no longer called now
that we have removed the associated translate.c handling.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250828140422.3271703-4-peter.maydell@linaro.org
---
 target/arm/tcg/helper.h        |  95 -----
 target/arm/tcg/iwmmxt_helper.c | 672 ---------------------------------
 target/arm/tcg/meson.build     |   2 -
 3 files changed, 769 deletions(-)
 delete mode 100644 target/arm/tcg/iwmmxt_helper.c

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 4da32db9021..4636d1bc039 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -444,101 +444,6 @@ DEF_HELPER_3(neon_acgt_f32, i32, i32, i32, fpst)
 DEF_HELPER_3(neon_acge_f64, i64, i64, i64, fpst)
 DEF_HELPER_3(neon_acgt_f64, i64, i64, i64, fpst)
 
-/* iwmmxt_helper.c */
-DEF_HELPER_2(iwmmxt_maddsq, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_madduq, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_sadb, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_sadw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mulslw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mulshw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_mululw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_muluhw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_macsw, i64, i64, i64)
-DEF_HELPER_2(iwmmxt_macuw, i64, i64, i64)
-DEF_HELPER_1(iwmmxt_setpsr_nz, i32, i64)
-
-#define DEF_IWMMXT_HELPER_SIZE_ENV(name) \
-DEF_HELPER_3(iwmmxt_##name##b, i64, env, i64, i64) \
-DEF_HELPER_3(iwmmxt_##name##w, i64, env, i64, i64) \
-DEF_HELPER_3(iwmmxt_##name##l, i64, env, i64, i64) \
-
-DEF_IWMMXT_HELPER_SIZE_ENV(unpackl)
-DEF_IWMMXT_HELPER_SIZE_ENV(unpackh)
-
-DEF_HELPER_2(iwmmxt_unpacklub, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackluw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklul, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhub, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhuw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhul, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsb, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpacklsl, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsb, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsw, i64, env, i64)
-DEF_HELPER_2(iwmmxt_unpackhsl, i64, env, i64)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpeq)
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpgtu)
-DEF_IWMMXT_HELPER_SIZE_ENV(cmpgts)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(mins)
-DEF_IWMMXT_HELPER_SIZE_ENV(minu)
-DEF_IWMMXT_HELPER_SIZE_ENV(maxs)
-DEF_IWMMXT_HELPER_SIZE_ENV(maxu)
-
-DEF_IWMMXT_HELPER_SIZE_ENV(subn)
-DEF_IWMMXT_HELPER_SIZE_ENV(addn)
-DEF_IWMMXT_HELPER_SIZE_ENV(subu)
-DEF_IWMMXT_HELPER_SIZE_ENV(addu)
-DEF_IWMMXT_HELPER_SIZE_ENV(subs)
-DEF_IWMMXT_HELPER_SIZE_ENV(adds)
-
-DEF_HELPER_3(iwmmxt_avgb0, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgb1, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgw0, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_avgw1, i64, env, i64, i64)
-
-DEF_HELPER_3(iwmmxt_align, i64, i64, i64, i32)
-DEF_HELPER_4(iwmmxt_insr, i64, i64, i32, i32, i32)
-
-DEF_HELPER_1(iwmmxt_bcstb, i64, i32)
-DEF_HELPER_1(iwmmxt_bcstw, i64, i32)
-DEF_HELPER_1(iwmmxt_bcstl, i64, i32)
-
-DEF_HELPER_1(iwmmxt_addcb, i64, i64)
-DEF_HELPER_1(iwmmxt_addcw, i64, i64)
-DEF_HELPER_1(iwmmxt_addcl, i64, i64)
-
-DEF_HELPER_1(iwmmxt_msbb, i32, i64)
-DEF_HELPER_1(iwmmxt_msbw, i32, i64)
-DEF_HELPER_1(iwmmxt_msbl, i32, i64)
-
-DEF_HELPER_3(iwmmxt_srlw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_srll, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_srlq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sllw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_slll, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sllq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sraw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sral, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_sraq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorw, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorl, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_rorq, i64, env, i64, i32)
-DEF_HELPER_3(iwmmxt_shufh, i64, env, i64, i32)
-
-DEF_HELPER_3(iwmmxt_packuw, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packul, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packuq, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsw, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsl, i64, env, i64, i64)
-DEF_HELPER_3(iwmmxt_packsq, i64, env, i64, i64)
-
-DEF_HELPER_3(iwmmxt_muladdsl, i64, i64, i32, i32)
-DEF_HELPER_3(iwmmxt_muladdsw, i64, i64, i32, i32)
-DEF_HELPER_3(iwmmxt_muladdswl, i64, i64, i32, i32)
-
 DEF_HELPER_FLAGS_2(neon_unzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_unzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qunzip8, TCG_CALL_NO_RWG, void, ptr, ptr)
diff --git a/target/arm/tcg/iwmmxt_helper.c b/target/arm/tcg/iwmmxt_helper.c
deleted file mode 100644
index ba054b6b4db..00000000000
--- a/target/arm/tcg/iwmmxt_helper.c
+++ /dev/null
@@ -1,672 +0,0 @@
-/*
- * iwMMXt micro operations for XScale.
- *
- * Copyright (c) 2007 OpenedHand, Ltd.
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- * Copyright (c) 2008 CodeSourcery
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-
-#include "cpu.h"
-
-#define HELPER_H "tcg/helper.h"
-#include "exec/helper-proto.h.inc"
-
-/* iwMMXt macros extracted from GNU gdb.  */
-
-/* Set the SIMD wCASF flags for 8, 16, 32 or 64-bit operations.  */
-#define SIMD8_SET(v, n, b)      ((v != 0) << ((((b) + 1) * 4) + (n)))
-#define SIMD16_SET(v, n, h)     ((v != 0) << ((((h) + 1) * 8) + (n)))
-#define SIMD32_SET(v, n, w)     ((v != 0) << ((((w) + 1) * 16) + (n)))
-#define SIMD64_SET(v, n)        ((v != 0) << (32 + (n)))
-/* Flags to pass as "n" above.  */
-#define SIMD_NBIT       -1
-#define SIMD_ZBIT       -2
-#define SIMD_CBIT       -3
-#define SIMD_VBIT       -4
-/* Various status bit macros.  */
-#define NBIT8(x)        ((x) & 0x80)
-#define NBIT16(x)       ((x) & 0x8000)
-#define NBIT32(x)       ((x) & 0x80000000)
-#define NBIT64(x)       ((x) & 0x8000000000000000ULL)
-#define ZBIT8(x)        (((x) & 0xff) == 0)
-#define ZBIT16(x)       (((x) & 0xffff) == 0)
-#define ZBIT32(x)       (((x) & 0xffffffff) == 0)
-#define ZBIT64(x)       (x == 0)
-/* Sign extension macros.  */
-#define EXTEND8H(a)     ((uint16_t) (int8_t) (a))
-#define EXTEND8(a)      ((uint32_t) (int8_t) (a))
-#define EXTEND16(a)     ((uint32_t) (int16_t) (a))
-#define EXTEND16S(a)    ((int32_t) (int16_t) (a))
-#define EXTEND32(a)     ((uint64_t) (int32_t) (a))
-
-uint64_t HELPER(iwmmxt_maddsq)(uint64_t a, uint64_t b)
-{
-    a = ((
-            EXTEND16S((a >> 0) & 0xffff) * EXTEND16S((b >> 0) & 0xffff) +
-            EXTEND16S((a >> 16) & 0xffff) * EXTEND16S((b >> 16) & 0xffff)
-        ) & 0xffffffff) | ((uint64_t) (
-            EXTEND16S((a >> 32) & 0xffff) * EXTEND16S((b >> 32) & 0xffff) +
-            EXTEND16S((a >> 48) & 0xffff) * EXTEND16S((b >> 48) & 0xffff)
-        ) << 32);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_madduq)(uint64_t a, uint64_t b)
-{
-    a = ((
-            ((a >> 0) & 0xffff) * ((b >> 0) & 0xffff) +
-            ((a >> 16) & 0xffff) * ((b >> 16) & 0xffff)
-        ) & 0xffffffff) | ((
-            ((a >> 32) & 0xffff) * ((b >> 32) & 0xffff) +
-            ((a >> 48) & 0xffff) * ((b >> 48) & 0xffff)
-        ) << 32);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_sadb)(uint64_t a, uint64_t b)
-{
-#define abs(x) (((x) >= 0) ? x : -x)
-#define SADB(SHR) abs((int) ((a >> SHR) & 0xff) - (int) ((b >> SHR) & 0xff))
-    return
-        SADB(0) + SADB(8) + SADB(16) + SADB(24) +
-        SADB(32) + SADB(40) + SADB(48) + SADB(56);
-#undef SADB
-}
-
-uint64_t HELPER(iwmmxt_sadw)(uint64_t a, uint64_t b)
-{
-#define SADW(SHR) \
-    abs((int) ((a >> SHR) & 0xffff) - (int) ((b >> SHR) & 0xffff))
-    return SADW(0) + SADW(16) + SADW(32) + SADW(48);
-#undef SADW
-}
-
-uint64_t HELPER(iwmmxt_mulslw)(uint64_t a, uint64_t b)
-{
-#define MULS(SHR) ((uint64_t) ((( \
-        EXTEND16S((a >> SHR) & 0xffff) * EXTEND16S((b >> SHR) & 0xffff) \
-    ) >> 0) & 0xffff) << SHR)
-    return MULS(0) | MULS(16) | MULS(32) | MULS(48);
-#undef MULS
-}
-
-uint64_t HELPER(iwmmxt_mulshw)(uint64_t a, uint64_t b)
-{
-#define MULS(SHR) ((uint64_t) ((( \
-        EXTEND16S((a >> SHR) & 0xffff) * EXTEND16S((b >> SHR) & 0xffff) \
-    ) >> 16) & 0xffff) << SHR)
-    return MULS(0) | MULS(16) | MULS(32) | MULS(48);
-#undef MULS
-}
-
-uint64_t HELPER(iwmmxt_mululw)(uint64_t a, uint64_t b)
-{
-#define MULU(SHR) ((uint64_t) ((( \
-        ((a >> SHR) & 0xffff) * ((b >> SHR) & 0xffff) \
-    ) >> 0) & 0xffff) << SHR)
-    return MULU(0) | MULU(16) | MULU(32) | MULU(48);
-#undef MULU
-}
-
-uint64_t HELPER(iwmmxt_muluhw)(uint64_t a, uint64_t b)
-{
-#define MULU(SHR) ((uint64_t) ((( \
-        ((a >> SHR) & 0xffff) * ((b >> SHR) & 0xffff) \
-    ) >> 16) & 0xffff) << SHR)
-    return MULU(0) | MULU(16) | MULU(32) | MULU(48);
-#undef MULU
-}
-
-uint64_t HELPER(iwmmxt_macsw)(uint64_t a, uint64_t b)
-{
-#define MACS(SHR) ( \
-        EXTEND16((a >> SHR) & 0xffff) * EXTEND16S((b >> SHR) & 0xffff))
-    return (int64_t) (MACS(0) + MACS(16) + MACS(32) + MACS(48));
-#undef MACS
-}
-
-uint64_t HELPER(iwmmxt_macuw)(uint64_t a, uint64_t b)
-{
-#define MACU(SHR) ( \
-        (uint32_t) ((a >> SHR) & 0xffff) * \
-        (uint32_t) ((b >> SHR) & 0xffff))
-    return MACU(0) + MACU(16) + MACU(32) + MACU(48);
-#undef MACU
-}
-
-#define NZBIT8(x, i) \
-    SIMD8_SET(NBIT8((x) & 0xff), SIMD_NBIT, i) | \
-    SIMD8_SET(ZBIT8((x) & 0xff), SIMD_ZBIT, i)
-#define NZBIT16(x, i) \
-    SIMD16_SET(NBIT16((x) & 0xffff), SIMD_NBIT, i) | \
-    SIMD16_SET(ZBIT16((x) & 0xffff), SIMD_ZBIT, i)
-#define NZBIT32(x, i) \
-    SIMD32_SET(NBIT32((x) & 0xffffffff), SIMD_NBIT, i) | \
-    SIMD32_SET(ZBIT32((x) & 0xffffffff), SIMD_ZBIT, i)
-#define NZBIT64(x) \
-    SIMD64_SET(NBIT64(x), SIMD_NBIT) | \
-    SIMD64_SET(ZBIT64(x), SIMD_ZBIT)
-#define IWMMXT_OP_UNPACK(S, SH0, SH1, SH2, SH3)                         \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, b)))(CPUARMState *env, \
-                                                 uint64_t a, uint64_t b) \
-{                                                               \
-    a =                                                                 \
-        (((a >> SH0) & 0xff) << 0) | (((b >> SH0) & 0xff) << 8) |       \
-        (((a >> SH1) & 0xff) << 16) | (((b >> SH1) & 0xff) << 24) |     \
-        (((a >> SH2) & 0xff) << 32) | (((b >> SH2) & 0xff) << 40) |     \
-        (((a >> SH3) & 0xff) << 48) | (((b >> SH3) & 0xff) << 56);      \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |                         \
-        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |               \
-        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |               \
-        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);                \
-    return a;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, w)))(CPUARMState *env, \
-                                        uint64_t a, uint64_t b) \
-{                                                               \
-    a =                                                                 \
-        (((a >> SH0) & 0xffff) << 0) |                          \
-        (((b >> SH0) & 0xffff) << 16) |                                 \
-        (((a >> SH2) & 0xffff) << 32) |                                 \
-        (((b >> SH2) & 0xffff) << 48);                          \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 16, 1) |                \
-        NZBIT8(a >> 32, 2) | NZBIT8(a >> 48, 3);                \
-    return a;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, l)))(CPUARMState *env, \
-                                        uint64_t a, uint64_t b) \
-{                                                               \
-    a =                                                                 \
-        (((a >> SH0) & 0xffffffff) << 0) |                      \
-        (((b >> SH0) & 0xffffffff) << 32);                      \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);               \
-    return a;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, ub)))(CPUARMState *env, \
-                                                  uint64_t x)   \
-{                                                               \
-    x =                                                                 \
-        (((x >> SH0) & 0xff) << 0) |                            \
-        (((x >> SH1) & 0xff) << 16) |                           \
-        (((x >> SH2) & 0xff) << 32) |                           \
-        (((x >> SH3) & 0xff) << 48);                            \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |              \
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);              \
-    return x;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, uw)))(CPUARMState *env, \
-                                                  uint64_t x)   \
-{                                                               \
-    x =                                                                 \
-        (((x >> SH0) & 0xffff) << 0) |                          \
-        (((x >> SH2) & 0xffff) << 32);                          \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);               \
-    return x;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, ul)))(CPUARMState *env, \
-                                                  uint64_t x)   \
-{                                                               \
-    x = (((x >> SH0) & 0xffffffff) << 0);                       \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x >> 0);      \
-    return x;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, sb)))(CPUARMState *env, \
-                                                  uint64_t x)   \
-{                                                               \
-    x =                                                                 \
-        ((uint64_t) EXTEND8H((x >> SH0) & 0xff) << 0) |                 \
-        ((uint64_t) EXTEND8H((x >> SH1) & 0xff) << 16) |        \
-        ((uint64_t) EXTEND8H((x >> SH2) & 0xff) << 32) |        \
-        ((uint64_t) EXTEND8H((x >> SH3) & 0xff) << 48);                 \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |              \
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);              \
-    return x;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, sw)))(CPUARMState *env, \
-                                                  uint64_t x)   \
-{                                                               \
-    x =                                                                 \
-        ((uint64_t) EXTEND16((x >> SH0) & 0xffff) << 0) |       \
-        ((uint64_t) EXTEND16((x >> SH2) & 0xffff) << 32);       \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);               \
-    return x;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_unpack, glue(S, sl)))(CPUARMState *env, \
-                                                  uint64_t x)   \
-{                                                               \
-    x = EXTEND32((x >> SH0) & 0xffffffff);                      \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x >> 0);      \
-    return x;                                                   \
-}
-IWMMXT_OP_UNPACK(l, 0, 8, 16, 24)
-IWMMXT_OP_UNPACK(h, 32, 40, 48, 56)
-
-#define IWMMXT_OP_CMP(SUFF, Tb, Tw, Tl, O)                      \
-uint64_t HELPER(glue(iwmmxt_, glue(SUFF, b)))(CPUARMState *env,    \
-                                        uint64_t a, uint64_t b) \
-{                                                               \
-    a =                                                                 \
-        CMP(0, Tb, O, 0xff) | CMP(8, Tb, O, 0xff) |             \
-        CMP(16, Tb, O, 0xff) | CMP(24, Tb, O, 0xff) |           \
-        CMP(32, Tb, O, 0xff) | CMP(40, Tb, O, 0xff) |           \
-        CMP(48, Tb, O, 0xff) | CMP(56, Tb, O, 0xff);            \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |                         \
-        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |               \
-        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |               \
-        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);                \
-    return a;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_, glue(SUFF, w)))(CPUARMState *env,    \
-                                        uint64_t a, uint64_t b) \
-{                                                               \
-    a = CMP(0, Tw, O, 0xffff) | CMP(16, Tw, O, 0xffff) |        \
-        CMP(32, Tw, O, 0xffff) | CMP(48, Tw, O, 0xffff);        \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT16(a >> 0, 0) | NZBIT16(a >> 16, 1) |              \
-        NZBIT16(a >> 32, 2) | NZBIT16(a >> 48, 3);              \
-    return a;                                                   \
-}                                                               \
-uint64_t HELPER(glue(iwmmxt_, glue(SUFF, l)))(CPUARMState *env,    \
-                                        uint64_t a, uint64_t b) \
-{                                                               \
-    a = CMP(0, Tl, O, 0xffffffff) |                             \
-        CMP(32, Tl, O, 0xffffffff);                             \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                       \
-        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);               \
-    return a;                                                   \
-}
-#define CMP(SHR, TYPE, OPER, MASK) ((((TYPE) ((a >> SHR) & MASK) OPER \
-            (TYPE) ((b >> SHR) & MASK)) ? (uint64_t) MASK : 0) << SHR)
-IWMMXT_OP_CMP(cmpeq, uint8_t, uint16_t, uint32_t, ==)
-IWMMXT_OP_CMP(cmpgts, int8_t, int16_t, int32_t, >)
-IWMMXT_OP_CMP(cmpgtu, uint8_t, uint16_t, uint32_t, >)
-#undef CMP
-#define CMP(SHR, TYPE, OPER, MASK) ((((TYPE) ((a >> SHR) & MASK) OPER \
-            (TYPE) ((b >> SHR) & MASK)) ? a : b) & ((uint64_t) MASK << SHR))
-IWMMXT_OP_CMP(mins, int8_t, int16_t, int32_t, <)
-IWMMXT_OP_CMP(minu, uint8_t, uint16_t, uint32_t, <)
-IWMMXT_OP_CMP(maxs, int8_t, int16_t, int32_t, >)
-IWMMXT_OP_CMP(maxu, uint8_t, uint16_t, uint32_t, >)
-#undef CMP
-#define CMP(SHR, TYPE, OPER, MASK) ((uint64_t) (((TYPE) ((a >> SHR) & MASK) \
-            OPER (TYPE) ((b >> SHR) & MASK)) & MASK) << SHR)
-IWMMXT_OP_CMP(subn, uint8_t, uint16_t, uint32_t, -)
-IWMMXT_OP_CMP(addn, uint8_t, uint16_t, uint32_t, +)
-#undef CMP
-/* TODO Signed- and Unsigned-Saturation */
-#define CMP(SHR, TYPE, OPER, MASK) ((uint64_t) (((TYPE) ((a >> SHR) & MASK) \
-            OPER (TYPE) ((b >> SHR) & MASK)) & MASK) << SHR)
-IWMMXT_OP_CMP(subu, uint8_t, uint16_t, uint32_t, -)
-IWMMXT_OP_CMP(addu, uint8_t, uint16_t, uint32_t, +)
-IWMMXT_OP_CMP(subs, int8_t, int16_t, int32_t, -)
-IWMMXT_OP_CMP(adds, int8_t, int16_t, int32_t, +)
-#undef CMP
-#undef IWMMXT_OP_CMP
-
-#define AVGB(SHR) ((( \
-        ((a >> SHR) & 0xff) + ((b >> SHR) & 0xff) + round) >> 1) << SHR)
-#define IWMMXT_OP_AVGB(r)                                                 \
-uint64_t HELPER(iwmmxt_avgb##r)(CPUARMState *env, uint64_t a, uint64_t b)    \
-{                                                                         \
-    const int round = r;                                                  \
-    a = AVGB(0) | AVGB(8) | AVGB(16) | AVGB(24) |                         \
-        AVGB(32) | AVGB(40) | AVGB(48) | AVGB(56);                        \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                                 \
-        SIMD8_SET(ZBIT8((a >> 0) & 0xff), SIMD_ZBIT, 0) |                 \
-        SIMD8_SET(ZBIT8((a >> 8) & 0xff), SIMD_ZBIT, 1) |                 \
-        SIMD8_SET(ZBIT8((a >> 16) & 0xff), SIMD_ZBIT, 2) |                \
-        SIMD8_SET(ZBIT8((a >> 24) & 0xff), SIMD_ZBIT, 3) |                \
-        SIMD8_SET(ZBIT8((a >> 32) & 0xff), SIMD_ZBIT, 4) |                \
-        SIMD8_SET(ZBIT8((a >> 40) & 0xff), SIMD_ZBIT, 5) |                \
-        SIMD8_SET(ZBIT8((a >> 48) & 0xff), SIMD_ZBIT, 6) |                \
-        SIMD8_SET(ZBIT8((a >> 56) & 0xff), SIMD_ZBIT, 7);                 \
-    return a;                                                             \
-}
-IWMMXT_OP_AVGB(0)
-IWMMXT_OP_AVGB(1)
-#undef IWMMXT_OP_AVGB
-#undef AVGB
-
-#define AVGW(SHR) ((( \
-        ((a >> SHR) & 0xffff) + ((b >> SHR) & 0xffff) + round) >> 1) << SHR)
-#define IWMMXT_OP_AVGW(r)                                               \
-uint64_t HELPER(iwmmxt_avgw##r)(CPUARMState *env, uint64_t a, uint64_t b)  \
-{                                                                       \
-    const int round = r;                                                \
-    a = AVGW(0) | AVGW(16) | AVGW(32) | AVGW(48);                       \
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =                               \
-        SIMD16_SET(ZBIT16((a >> 0) & 0xffff), SIMD_ZBIT, 0) |           \
-        SIMD16_SET(ZBIT16((a >> 16) & 0xffff), SIMD_ZBIT, 1) |          \
-        SIMD16_SET(ZBIT16((a >> 32) & 0xffff), SIMD_ZBIT, 2) |          \
-        SIMD16_SET(ZBIT16((a >> 48) & 0xffff), SIMD_ZBIT, 3);           \
-    return a;                                                           \
-}
-IWMMXT_OP_AVGW(0)
-IWMMXT_OP_AVGW(1)
-#undef IWMMXT_OP_AVGW
-#undef AVGW
-
-uint64_t HELPER(iwmmxt_align)(uint64_t a, uint64_t b, uint32_t n)
-{
-    a >>= n << 3;
-    a |= b << (64 - (n << 3));
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_insr)(uint64_t x, uint32_t a, uint32_t b, uint32_t n)
-{
-    x &= ~((uint64_t) b << n);
-    x |= (uint64_t) (a & b) << n;
-    return x;
-}
-
-uint32_t HELPER(iwmmxt_setpsr_nz)(uint64_t x)
-{
-    return SIMD64_SET((x == 0), SIMD_ZBIT) |
-           SIMD64_SET((x & (1ULL << 63)), SIMD_NBIT);
-}
-
-uint64_t HELPER(iwmmxt_bcstb)(uint32_t arg)
-{
-    arg &= 0xff;
-    return
-        ((uint64_t) arg << 0 ) | ((uint64_t) arg << 8 ) |
-        ((uint64_t) arg << 16) | ((uint64_t) arg << 24) |
-        ((uint64_t) arg << 32) | ((uint64_t) arg << 40) |
-        ((uint64_t) arg << 48) | ((uint64_t) arg << 56);
-}
-
-uint64_t HELPER(iwmmxt_bcstw)(uint32_t arg)
-{
-    arg &= 0xffff;
-    return
-        ((uint64_t) arg << 0 ) | ((uint64_t) arg << 16) |
-        ((uint64_t) arg << 32) | ((uint64_t) arg << 48);
-}
-
-uint64_t HELPER(iwmmxt_bcstl)(uint32_t arg)
-{
-    return arg | ((uint64_t) arg << 32);
-}
-
-uint64_t HELPER(iwmmxt_addcb)(uint64_t x)
-{
-    return
-        ((x >> 0) & 0xff) + ((x >> 8) & 0xff) +
-        ((x >> 16) & 0xff) + ((x >> 24) & 0xff) +
-        ((x >> 32) & 0xff) + ((x >> 40) & 0xff) +
-        ((x >> 48) & 0xff) + ((x >> 56) & 0xff);
-}
-
-uint64_t HELPER(iwmmxt_addcw)(uint64_t x)
-{
-    return
-        ((x >> 0) & 0xffff) + ((x >> 16) & 0xffff) +
-        ((x >> 32) & 0xffff) + ((x >> 48) & 0xffff);
-}
-
-uint64_t HELPER(iwmmxt_addcl)(uint64_t x)
-{
-    return (x & 0xffffffff) + (x >> 32);
-}
-
-uint32_t HELPER(iwmmxt_msbb)(uint64_t x)
-{
-    return
-        ((x >> 7) & 0x01) | ((x >> 14) & 0x02) |
-        ((x >> 21) & 0x04) | ((x >> 28) & 0x08) |
-        ((x >> 35) & 0x10) | ((x >> 42) & 0x20) |
-        ((x >> 49) & 0x40) | ((x >> 56) & 0x80);
-}
-
-uint32_t HELPER(iwmmxt_msbw)(uint64_t x)
-{
-    return
-        ((x >> 15) & 0x01) | ((x >> 30) & 0x02) |
-        ((x >> 45) & 0x04) | ((x >> 52) & 0x08);
-}
-
-uint32_t HELPER(iwmmxt_msbl)(uint64_t x)
-{
-    return ((x >> 31) & 0x01) | ((x >> 62) & 0x02);
-}
-
-/* FIXME: Split wCASF setting into a separate op to avoid env use.  */
-uint64_t HELPER(iwmmxt_srlw)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = (((x & (0xffffll << 0)) >> n) & (0xffffll << 0)) |
-        (((x & (0xffffll << 16)) >> n) & (0xffffll << 16)) |
-        (((x & (0xffffll << 32)) >> n) & (0xffffll << 32)) |
-        (((x & (0xffffll << 48)) >> n) & (0xffffll << 48));
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_srll)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = ((x & (0xffffffffll << 0)) >> n) |
-        ((x >> n) & (0xffffffffll << 32));
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_srlq)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x >>= n;
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_sllw)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = (((x & (0xffffll << 0)) << n) & (0xffffll << 0)) |
-        (((x & (0xffffll << 16)) << n) & (0xffffll << 16)) |
-        (((x & (0xffffll << 32)) << n) & (0xffffll << 32)) |
-        (((x & (0xffffll << 48)) << n) & (0xffffll << 48));
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_slll)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = ((x << n) & (0xffffffffll << 0)) |
-        ((x & (0xffffffffll << 32)) << n);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_sllq)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x <<= n;
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_sraw)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = ((uint64_t) ((EXTEND16(x >> 0) >> n) & 0xffff) << 0) |
-        ((uint64_t) ((EXTEND16(x >> 16) >> n) & 0xffff) << 16) |
-        ((uint64_t) ((EXTEND16(x >> 32) >> n) & 0xffff) << 32) |
-        ((uint64_t) ((EXTEND16(x >> 48) >> n) & 0xffff) << 48);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_sral)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = (((EXTEND32(x >> 0) >> n) & 0xffffffff) << 0) |
-        (((EXTEND32(x >> 32) >> n) & 0xffffffff) << 32);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_sraq)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = (int64_t) x >> n;
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_rorw)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = ((((x & (0xffffll << 0)) >> n) |
-          ((x & (0xffffll << 0)) << (16 - n))) & (0xffffll << 0)) |
-        ((((x & (0xffffll << 16)) >> n) |
-          ((x & (0xffffll << 16)) << (16 - n))) & (0xffffll << 16)) |
-        ((((x & (0xffffll << 32)) >> n) |
-          ((x & (0xffffll << 32)) << (16 - n))) & (0xffffll << 32)) |
-        ((((x & (0xffffll << 48)) >> n) |
-          ((x & (0xffffll << 48)) << (16 - n))) & (0xffffll << 48));
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_rorl)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = ((x & (0xffffffffll << 0)) >> n) |
-        ((x >> n) & (0xffffffffll << 32)) |
-        ((x << (32 - n)) & (0xffffffffll << 0)) |
-        ((x & (0xffffffffll << 32)) << (32 - n));
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT32(x >> 0, 0) | NZBIT32(x >> 32, 1);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_rorq)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = ror64(x, n);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] = NZBIT64(x);
-    return x;
-}
-
-uint64_t HELPER(iwmmxt_shufh)(CPUARMState *env, uint64_t x, uint32_t n)
-{
-    x = (((x >> ((n << 4) & 0x30)) & 0xffff) << 0) |
-        (((x >> ((n << 2) & 0x30)) & 0xffff) << 16) |
-        (((x >> ((n << 0) & 0x30)) & 0xffff) << 32) |
-        (((x >> ((n >> 2) & 0x30)) & 0xffff) << 48);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(x >> 0, 0) | NZBIT16(x >> 16, 1) |
-        NZBIT16(x >> 32, 2) | NZBIT16(x >> 48, 3);
-    return x;
-}
-
-/* TODO: Unsigned-Saturation */
-uint64_t HELPER(iwmmxt_packuw)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    a = (((a >> 0) & 0xff) << 0) | (((a >> 16) & 0xff) << 8) |
-        (((a >> 32) & 0xff) << 16) | (((a >> 48) & 0xff) << 24) |
-        (((b >> 0) & 0xff) << 32) | (((b >> 16) & 0xff) << 40) |
-        (((b >> 32) & 0xff) << 48) | (((b >> 48) & 0xff) << 56);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |
-        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |
-        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |
-        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_packul)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    a = (((a >> 0) & 0xffff) << 0) | (((a >> 32) & 0xffff) << 16) |
-        (((b >> 0) & 0xffff) << 32) | (((b >> 32) & 0xffff) << 48);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(a >> 0, 0) | NZBIT16(a >> 16, 1) |
-        NZBIT16(a >> 32, 2) | NZBIT16(a >> 48, 3);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_packuq)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    a = (a & 0xffffffff) | ((b & 0xffffffff) << 32);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);
-    return a;
-}
-
-/* TODO: Signed-Saturation */
-uint64_t HELPER(iwmmxt_packsw)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    a = (((a >> 0) & 0xff) << 0) | (((a >> 16) & 0xff) << 8) |
-        (((a >> 32) & 0xff) << 16) | (((a >> 48) & 0xff) << 24) |
-        (((b >> 0) & 0xff) << 32) | (((b >> 16) & 0xff) << 40) |
-        (((b >> 32) & 0xff) << 48) | (((b >> 48) & 0xff) << 56);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT8(a >> 0, 0) | NZBIT8(a >> 8, 1) |
-        NZBIT8(a >> 16, 2) | NZBIT8(a >> 24, 3) |
-        NZBIT8(a >> 32, 4) | NZBIT8(a >> 40, 5) |
-        NZBIT8(a >> 48, 6) | NZBIT8(a >> 56, 7);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_packsl)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    a = (((a >> 0) & 0xffff) << 0) | (((a >> 32) & 0xffff) << 16) |
-        (((b >> 0) & 0xffff) << 32) | (((b >> 32) & 0xffff) << 48);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT16(a >> 0, 0) | NZBIT16(a >> 16, 1) |
-        NZBIT16(a >> 32, 2) | NZBIT16(a >> 48, 3);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_packsq)(CPUARMState *env, uint64_t a, uint64_t b)
-{
-    a = (a & 0xffffffff) | ((b & 0xffffffff) << 32);
-    env->iwmmxt.cregs[ARM_IWMMXT_wCASF] =
-        NZBIT32(a >> 0, 0) | NZBIT32(a >> 32, 1);
-    return a;
-}
-
-uint64_t HELPER(iwmmxt_muladdsl)(uint64_t c, uint32_t a, uint32_t b)
-{
-    return c + ((int32_t) EXTEND32(a) * (int32_t) EXTEND32(b));
-}
-
-uint64_t HELPER(iwmmxt_muladdsw)(uint64_t c, uint32_t a, uint32_t b)
-{
-    c += EXTEND32(EXTEND16S((a >> 0) & 0xffff) *
-                  EXTEND16S((b >> 0) & 0xffff));
-    c += EXTEND32(EXTEND16S((a >> 16) & 0xffff) *
-                  EXTEND16S((b >> 16) & 0xffff));
-    return c;
-}
-
-uint64_t HELPER(iwmmxt_muladdswl)(uint64_t c, uint32_t a, uint32_t b)
-{
-    return c + (EXTEND32(EXTEND16S(a & 0xffff) *
-                         EXTEND16S(b & 0xffff)));
-}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 895facdc30b..1b115656c46 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -66,7 +66,6 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'cpregs-at.c',
   'hflags.c',
-  'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -74,7 +73,6 @@ arm_common_system_ss.add(files(
 ))
 arm_user_ss.add(files(
   'hflags.c',
-  'iwmmxt_helper.c',
   'neon_helper.c',
   'tlb_helper.c',
   'vfp_helper.c',
-- 
2.43.0


