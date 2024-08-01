Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496EEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 08:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZQiF-0003BP-HM; Thu, 01 Aug 2024 03:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZQiE-00035Y-1V
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:59:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZQiB-000678-Tw
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:59:01 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc47abc040so45162475ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722499138; x=1723103938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAAECdtbSk5fdUDNbIHhRihYh/Jpb523HvXDAZ9nrWw=;
 b=GDRqKjn3PMIAdIGybPjtU6oIsee6t59ROEbAsUklY86bDNJPY8PZ00GK+uYaeZIAAB
 ogaSlDbfgvNIkyeLcGgjCmFR6FAD9Ki+/lsGMa80XwQx7nmv8uBkY4dSSB0TC9t2Z32i
 Cy8t3PrcWwRBa5NygyUpgzGSjYZH0as9y+3Ozwi2EpF1FuDuQ/U7yPq/KDtHPObqktw+
 1orKN79U+CoWsgLQRhiz+9sko6G7yxYYLmsa3WpP8lnQApSjj59kfxqQc109g46wCORb
 igL5YMjcJ0aW4s8LMV+TeNlPgFRkTve3TkFIdY+6T4vM2Et9qHi9oUYvtv9yPv/7qkFO
 UqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722499138; x=1723103938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAAECdtbSk5fdUDNbIHhRihYh/Jpb523HvXDAZ9nrWw=;
 b=k2+Xk8YaHlGM0zyvIodev9Ultj6c/fpjyci4aXW2NuW5D4spdCwuqIiBYN9Che8foH
 zw2rQjSOIrHMLA8vRFJa9yQEPkcOCZV1LO5dQGGzHgw/GDAHgtC4JyIF19wxHclxNbC+
 ZJRxEX7mcWjxex+godQs/GuovOJohQVTpq4sF1HefVq8dw4P9ZCHqz/bCU5yfd3X0DlX
 U6pGXMcO+tgaoYnP8BI7hDIDjKT0ji0PMxzWuOfP2wT//69CIzgoOKScPVixcN54eufC
 pvSHv9XHedBSEAoC4bQf8z0lnzIzk2yCXjBi/FWYJSV44Fu/KF2/0PMLL8+Ige8Ar14D
 TpDA==
X-Gm-Message-State: AOJu0YyGMYwZy/T5eof4jNyDPgQeQi0QzbJf5DKnWz6/wGioLZ49MfrI
 gIOmD/7jNX7CxiEg48fkdisLGlWjJ4ptjT6QH57K2NwCbx4S1ZeSLayFGA6rzf9CabOTNBO+tQN
 1XeYkzw==
X-Google-Smtp-Source: AGHT+IGsr36IOpqYaCXN2JUcn51KSb4nPwLO6GtOq1gP17DWM72JyJY6ALgh8CnGjuSa/72WVwwKfA==
X-Received: by 2002:a17:903:1245:b0:1fd:6c83:3394 with SMTP id
 d9443c01a7336-1ff4ce70235mr24610185ad.7.1722499138033; 
 Thu, 01 Aug 2024 00:58:58 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee148dsm132195755ad.144.2024.08.01.00.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 00:58:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 2/2] target/i386: Fix carry flag for BLSI
Date: Thu,  1 Aug 2024 17:58:45 +1000
Message-ID: <20240801075845.573075-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801075845.573075-1-richard.henderson@linaro.org>
References: <20240801075845.573075-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

BLSI has inverted semantics for C as compared to the other two
BMI1 instructions, BLSMSK and BLSR.  Introduce CC_OP_BLSI* for
this purpose.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2175
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index e62ffa2858..fb0d01b356 100644
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
index 016dce8146..3e867135dd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1299,7 +1299,7 @@ static void gen_BLSI(DisasContext *s, X86DecodedInsn *decode)
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


