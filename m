Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE4AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 02:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgb32-0000oE-SK; Tue, 20 Aug 2024 22:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb30-0000it-Rz
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:06 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgb2y-0006Dz-Pw
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 22:26:06 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db19caec60so3891745b6e.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724207163; x=1724811963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzQq+okHryK0atM5VhMyw1ZWBZUUJZorcvwNEKWon4U=;
 b=yNxWZUbhGeas6gyHp9lmNoqadOLSd0jXjoQd+Qp9yN0jRXgEau80K6Sxikrq4yEpRJ
 IIooa1Lxa3ytceqDu8cxxCfzI5YziO2nuIYKqHmSFO6NK+wW9wq7cwnAoY1yaxfpDfFd
 0qbrvLac7HrTyDNz4DKhUQbgF+Z7ALtuiJrfbI1mrh+dUuX/7vhHWJs3971RkPzJcwqj
 9ILUHdleqMbAhu0/2gSjt8G4djKi3CKdmSO+2RPqvLexaC/lqCvo40zZBzPT4GEShvec
 x4E8KaB82q4QLrs4iOJUI64qW5fKsQqTkmMh4K4CffBbfgaunVpTBV5h39ul6FZVYMAO
 kG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724207163; x=1724811963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MzQq+okHryK0atM5VhMyw1ZWBZUUJZorcvwNEKWon4U=;
 b=wJ1tAaWWk3150KMV2ms0Xmy2xIcZasyGK8hEPTtOIA8Fmk+u8WEiwmdtv5MocvyvfL
 O/PwPc3vwTDtdxeSS9BCqAkZTX65fUIjBVYE/mEatggxX1w9NoxfThXom3Bf5+qprELk
 H4AwhkHoHsqPvxBKQ7pBdwaA1mL+pdPHZf/nLXXhSOznCSmmf/kEk5NfKnFZqsc617qa
 U5iqeEYtuwGgML488Af0CUN6JwwOPRNTbjhB9We7lgtkcYtQ2fPJan+rG8a+m7sjKE2P
 CxUljoHluOlwEk7tWgQjO6GCMMNyoKwK3xQNF63hpqJvZe9uqEhhQuMKFKtWSvbLuv9n
 as7Q==
X-Gm-Message-State: AOJu0YzfgkIPmXhu1mW6SEV5vlXVA1zrIjhTrtnC+YxrfDJFjMZ8T5hz
 mcn2tg+SL8spi/LVk8L+Pu4iK1TdepuxaYy+nwraagi8DLQiWekuuM1dg0gWzNNa7JVs+Ujb2IY
 7ZtE=
X-Google-Smtp-Source: AGHT+IEhf6mfNsGUhGyQG356To4ct+NPhJHgeeBstI8HsvX1KGLMn27A02ToUTILb3vxqG8tznFAfw==
X-Received: by 2002:a05:6808:1491:b0:3d9:2def:21b4 with SMTP id
 5614622812f47-3de19526360mr1667062b6e.14.1724207163495; 
 Tue, 20 Aug 2024 19:26:03 -0700 (PDT)
Received: from stoup.. ([203.56.140.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af1888esm9210774b3a.149.2024.08.20.19.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 19:26:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/5] target/i386: Fix carry flag for BLSI
Date: Wed, 21 Aug 2024 12:25:47 +1000
Message-ID: <20240821022548.421745-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821022548.421745-1-richard.henderson@linaro.org>
References: <20240821022548.421745-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BLSI has inverted semantics for C as compared to the other two
BMI1 instructions, BLSMSK and BLSR.  Introduce CC_OP_BLSI* for
this purpose.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2175
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240801075845.573075-3-richard.henderson@linaro.org>
---
 target/i386/cpu.h                        |  5 +++++
 target/i386/tcg/cc_helper.c              | 18 ++++++++++++++++++
 target/i386/tcg/translate.c              |  5 +++++
 tests/tcg/x86_64/test-2175.c             | 24 ++++++++++++++++++++++++
 target/i386/tcg/cc_helper_template.h.inc | 18 ++++++++++++++++++
 target/i386/tcg/emit.c.inc               |  2 +-
 tests/tcg/x86_64/Makefile.target         |  1 +
 7 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/x86_64/test-2175.c

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c6cc035df3..14edd57a37 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1339,6 +1339,11 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
+    CC_OP_BLSIB, /* Z,S via CC_DST, C = SRC!=0; O=0; P,A undefined */
+    CC_OP_BLSIW,
+    CC_OP_BLSIL,
+    CC_OP_BLSIQ,
+
     /*
      * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
      * is used or implemented, because the translation needs
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index 301ed95406..dbddaa2fcb 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -186,6 +186,13 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_BMILGL:
         return compute_all_bmilgl(dst, src1);
 
+    case CC_OP_BLSIB:
+        return compute_all_blsib(dst, src1);
+    case CC_OP_BLSIW:
+        return compute_all_blsiw(dst, src1);
+    case CC_OP_BLSIL:
+        return compute_all_blsil(dst, src1);
+
     case CC_OP_ADCX:
         return compute_all_adcx(dst, src1, src2);
     case CC_OP_ADOX:
@@ -216,6 +223,8 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
         return compute_all_sarq(dst, src1);
     case CC_OP_BMILGQ:
         return compute_all_bmilgq(dst, src1);
+    case CC_OP_BLSIQ:
+        return compute_all_blsiq(dst, src1);
 #endif
     }
 }
@@ -308,6 +317,13 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
     case CC_OP_BMILGL:
         return compute_c_bmilgl(dst, src1);
 
+    case CC_OP_BLSIB:
+        return compute_c_blsib(dst, src1);
+    case CC_OP_BLSIW:
+        return compute_c_blsiw(dst, src1);
+    case CC_OP_BLSIL:
+        return compute_c_blsil(dst, src1);
+
 #ifdef TARGET_X86_64
     case CC_OP_ADDQ:
         return compute_c_addq(dst, src1);
@@ -321,6 +337,8 @@ target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
         return compute_c_shlq(dst, src1);
     case CC_OP_BMILGQ:
         return compute_c_bmilgq(dst, src1);
+    case CC_OP_BLSIQ:
+        return compute_c_blsiq(dst, src1);
 #endif
     }
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 4af282e626..98f5fe61ed 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -304,6 +304,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_SHLB ... CC_OP_SHLQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_SARB ... CC_OP_SARQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_BMILGB ... CC_OP_BMILGQ] = USES_CC_DST | USES_CC_SRC,
+    [CC_OP_BLSIB ... CC_OP_BLSIQ] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADCX] = USES_CC_DST | USES_CC_SRC,
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
@@ -922,6 +923,10 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         size = s->cc_op - CC_OP_BMILGB;
         return gen_prepare_val_nz(cpu_cc_src, size, true);
 
+    case CC_OP_BLSIB ... CC_OP_BLSIQ:
+        size = s->cc_op - CC_OP_BLSIB;
+        return gen_prepare_val_nz(cpu_cc_src, size, false);
+
     case CC_OP_ADCX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_dst,
diff --git a/tests/tcg/x86_64/test-2175.c b/tests/tcg/x86_64/test-2175.c
new file mode 100644
index 0000000000..aafd037bce
--- /dev/null
+++ b/tests/tcg/x86_64/test-2175.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/2185 */
+
+#include <assert.h>
+
+int test_setc(unsigned int x, unsigned int y)
+{
+    asm("blsi %1, %0; setc %b0" : "+r"(x) : "r"(y));
+    return (unsigned char)x;
+}
+
+int test_pushf(unsigned int x, unsigned int y)
+{
+    asm("blsi %1, %0; pushf; pop %q0" : "+r"(x) : "r"(y));
+    return x & 1;
+}
+
+int main()
+{
+    assert(test_setc(1, 0xedbf530a));
+    assert(test_pushf(1, 0xedbf530a));
+    return 0;
+}
+
diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index bb611feb04..c5425e57cf 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -235,6 +235,24 @@ static int glue(compute_c_bmilg, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
     return src1 == 0;
 }
 
+static int glue(compute_all_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+{
+    int cf, pf, af, zf, sf, of;
+
+    cf = (src1 != 0);
+    pf = 0; /* undefined */
+    af = 0; /* undefined */
+    zf = (dst == 0) * CC_Z;
+    sf = lshift(dst, 8 - DATA_BITS) & CC_S;
+    of = 0;
+    return cf | pf | af | zf | sf | of;
+}
+
+static int glue(compute_c_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
+{
+    return src1 != 0;
+}
+
 #undef DATA_BITS
 #undef SIGN_MASK
 #undef DATA_TYPE
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 22a06897fb..9b50419918 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1304,7 +1304,7 @@ static void gen_BLSI(DisasContext *s, X86DecodedInsn *decode)
     /* input in T1, which is ready for prepare_update2_cc  */
     tcg_gen_neg_tl(s->T0, s->T1);
     tcg_gen_and_tl(s->T0, s->T0, s->T1);
-    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
+    prepare_update2_cc(decode, s, CC_OP_BLSIB + ot);
 }
 
 static void gen_BLSMSK(DisasContext *s, X86DecodedInsn *decode)
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index eda9bd7396..783ab5b21a 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -16,6 +16,7 @@ X86_64_TESTS += noexec
 X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
 X86_64_TESTS += test-1648
+X86_64_TESTS += test-2175
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
-- 
2.43.0


