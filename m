Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFF1CA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 03:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGSyQ-00008c-4f; Mon, 12 Oct 2026 23:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xGSyH-00007r-IS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:14:33 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xGSyF-0003VN-RP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 23:14:33 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8ae8607e8afso15686827b3.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791861270; x=1792466070; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6sU5VMmStegCn9Y0sx6fXu7t/rJE2at+L69jLeCSZk=;
 b=Rv4rTF0bgNFyIBB6i4sR85/Un++VSrduAsN5w/jkohQFT6c97d1TirIcr5HMugw4L6
 DWbwyGGC7iCdKMTaTnVz4/mdLbSmEgrjNXnQpXMDKiuF6c6SSE1B8A9Ch2UoQphepz0E
 nIxTPqgHFvex+on46tyZO2pNtlqAzjrZ4P7YypKEQyvRLHTkw0Q5YCTy0DIAsR6WZXXF
 OonBdk35JwOK/JkqnIkiDSvom9Cu0xTUOUU19EXPkW3NJfn2frwxvH65XbW2r5iyGlTA
 QxzEPXmXWrOII4rEjX5ru4z/IMw7LN+3g7zBvDf6A+ku/622hxHlrDj5fNyrBwwS/+Ah
 gFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791861270; x=1792466070;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6sU5VMmStegCn9Y0sx6fXu7t/rJE2at+L69jLeCSZk=;
 b=eCwDPdt5qlxknx1jZv815w1eOmI1IBFEPlFuhxhssixOQOhdMkjQbiupdLxFosY6W/
 ghiXe4DOQvs7FukWdlGY5Rpd5SOCf9J0GWPd/M9r8aoqLwzKEeKz7mdyVhsEQzmRaV+2
 HCvIxS6EWlGN8T0yxoouS8EWv6nnPt7hcno1atw3SVMwBAeTVkxaPNeXIT4PRlH/Pnr3
 KlLZqRC3Ie74hc1Gs0rRrkn5MCh2EY5qpGbsjy8ARP5Krcr67mczkVbWqprotvViWPH5
 cMUlivz6bUEeh8u/k7hKY+E0SdGtUZa+1m/7IZYf8kNFJs5r2nv5Aq6vh+F2ijIU/E7O
 wTGA==
X-Gm-Message-State: AFq9FYLvZ6IwFc8qilLzP5JyDpUWZuqKQ0RnKA39mM/csdTukta4D+WP
 H6RMkM/SJqGrjvbxCeztggRxjmgqreUmqXG8GvGIhTK9Fxi2Yr0r9lysvJX5xg==
X-Gm-Gg: AYBFou3B2bBGBAn8/uoVMtp2bR1I84FzB7Ixw83qqEcX8I+8dfrdklfLcchXM/SPfCO
 gweTniMo1BAfOAbyiCtlT5I2KBk4r6f26Z4sWmqJnBhA87jUKfOgrnrzzORWZDWY1jyjTetqjf3
 dCmeCmK6BLxBuiE45Jj8jYXdWR+rPUTzydLOCziMn3fIDyfp5kKY5y8ZvD25d4PCDKxcQYqGJ/Z
 GGgiIjR7HAoPf9Lh/7H9BMd0TZmMCysezV6ZT7bifMJBOfBGlO6kqbP+YATt08q6tO4cw7JLJ/x
 CGsEHPo6XCvyqQJmd+LA6QvVbENHUW/ZGonN8Zb595BPVOnuIPnOucKY9m43l745z0pZ5elP85r
 DokK3qHhWncxtgcnGuNgHAMWO9/F2Z2BV6t8Zd2bZreVchhC++vkFx5YhKF71oQOBHgNho+tnC2
 4vkmOEG6R6pI6t9ccfjOljmOulhTJEMDYkloZW5GM4oALm0VYnzHjO2SU8dmMpbpmFA1zmT0sMF
 tvdPQlDI+LpAD9d/VDe+1d80X/c1KsKd8ZJbzjAt3a1HO+5Pemlm6N2Eg==
X-Received: by 2002:a05:690c:7013:b0:8a1:eaa2:36d7 with SMTP id
 00721157ae682-8b07ed8e053mr41237497b3.18.1791861270512; 
 Mon, 12 Oct 2026 20:14:30 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07f1b8a9fsm39405637b3.9.2026.10.12.20.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 20:14:27 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 12 Oct 2026 23:14:23 -0400
Subject: [PATCH 2/2] target/alpha: Determine tininess from the delivered result
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-alpha-fpcr-status-s-v1-2-bc7efa6d5609@gmail.com>
References: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
In-Reply-To: <20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5844; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Wzu3aZjeh21N3ckQzpTOPYiQMS1npQA3bMwKXRT7deU=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLOLuKd0/h45ite1eLXwlL/GPgFDjmbxku8sZU8anOEQ
 fFt4bbrHR9ZGMS4GGaKKbLErVdkmdW2Y6nPaelfMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 IZChYxQPkdNj0MgsLi5NLdJNKyhyyMsvSSzJzM8r1ssvSM0rSC/QS8tMK8nIyC8qTgUaoZeXWmL
 q6uhmZGhgYuloYeZk4Whq4uzsZOjk5ujo7OpkZGluYuBs6WjiamnOwMUpAHON3QxGhr6sFW/WRE
 6fuPeDw8q54nd95B9uDb7rLqqfWHpb+JSI03lGho2rfPx83beeU/xysoch5j6/cX/uvPzf+1y23
 FvnceDxNU4A
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Alpha raises underflow only if the result it delivers is tiny.
softfloat implements IEEE 754 tininess after rounding, which rounds as
if the exponent range were unbounded.  The two disagree about a result
that rounds up to the smallest normal:

  0x4p-1024 / 0x1.0000000000001p+0 in FE_UPWARD = 0x4p-1024

The binade below DBL_MIN has a finer spacing than the denormals, so
with an unbounded exponent the quotient rounds to a value below
DBL_MIN and softfloat raises underflow.  Alpha does not.  glibc marks
math/test-float32x-float64-div as XFAIL on Alpha because of this
(glibc commit a32db99a38), and under qemu that test unexpectedly
passes.

Every result that is tiny by Alpha's rule is also tiny by the IEEE
one, so there is no need for another tininess mode in softfloat.  Drop
underflow in the S and T format add, sub, mul, div and cvtts helpers
when the delivered result is normal.

An insn with a denormal operand is different.  Unless DNZ is set it
traps for software completion and the kernel computes the result, and
the kernel's emulation raises underflow in the same situation:

  0x3.ffffffffffffcp-1024 / 0x1.fffffffffffffp-1 in FE_UPWARD
    = 0x4p-1024, FPCR_UNF set

That result is tiny whether tininess is detected before rounding, as
math-emu does, or after rounding, as softfloat does.  linux-user
computes these results in the helper instead of trapping, so keep
softfloat's underflow when float_flag_input_denormal_used is set.  In
system mode gen_ieee_input raises the trap before the helper runs.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 target/alpha/fpu_helper.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 643ce641e8..d902cdd9dc 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -55,6 +55,24 @@ static uint32_t soft_to_fpcr_exc(CPUAlphaState *env)
     return ret;
 }
 
+/*
+ * Alpha raises no underflow when the delivered result is normal.
+ * softfloat does when that result was rounded up to the smallest
+ * normal, so drop it, except when a denormal operand means the kernel
+ * computed the result.
+ */
+static uint32_t soft_to_fpcr_exc_tiny(CPUAlphaState *env, bool normal)
+{
+    bool swc = get_float_exception_flags(&FP_STATUS)
+               & float_flag_input_denormal_used;
+    uint32_t ret = soft_to_fpcr_exc(env);
+
+    if (unlikely(ret & FPCR_UNF) && normal && !swc) {
+        ret &= ~FPCR_UNF;
+    }
+    return ret;
+}
+
 static void fp_exc_raise1(CPUAlphaState *env, uintptr_t retaddr,
                           uint32_t exc, uint32_t regno, uint32_t hw_exc)
 {
@@ -227,7 +245,7 @@ uint64_t helper_adds(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -239,7 +257,7 @@ uint64_t helper_subs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -251,7 +269,7 @@ uint64_t helper_muls(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -263,7 +281,7 @@ uint64_t helper_alpha_divs(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = s_to_float32(a);
     fb = s_to_float32(b);
     fr = float32_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }
@@ -304,7 +322,7 @@ uint64_t helper_addt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_add(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -316,7 +334,7 @@ uint64_t helper_subt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_sub(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -328,7 +346,7 @@ uint64_t helper_mult(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_mul(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -340,7 +358,7 @@ uint64_t helper_divt(CPUAlphaState *env, uint64_t a, uint64_t b)
     fa = t_to_float64(a);
     fb = t_to_float64(b);
     fr = float64_div(fa, fb, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float64_is_normal(fr));
 
     return float64_to_t(fr);
 }
@@ -429,7 +447,7 @@ uint64_t helper_cvtts(CPUAlphaState *env, uint64_t a)
 
     fa = t_to_float64(a);
     fr = float64_to_float32(fa, &FP_STATUS);
-    env->error_code = soft_to_fpcr_exc(env);
+    env->error_code = soft_to_fpcr_exc_tiny(env, float32_is_normal(fr));
 
     return float32_to_s(fr);
 }

-- 
2.55.0


