Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C817FE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSE-0000Nc-SD; Wed, 11 Dec 2024 11:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSB-0000Lm-Nt
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSA-0007kg-93
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so11081045e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934044; x=1734538844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PQNG0n9NXp4YCePXcFiDn3lq3sTBy07a0OMkjgz62Dg=;
 b=RV4aXd6oVb0WVa0Ty7yxIusirNNcLOQuvXWR6rWBILzelVvJB+MLkdLjnwNpBB9KKi
 bPyo6bbFDREzlOJBFdMjXuG94Q6ePrEpMd52x7zbN0XkhoNlt84SCDkzU7LwqHXs4LBK
 io3f+9WsraXUwVFWmbiVIYODLDuTK6y5QQPNmtKSC8tNyi/IKeAvP46tXY48X3zv7Srq
 r2uonUD6EjBHPOBrYN3pMJcavoU1g+cNKPFwCEIxVyrf6BHYvgHRvkRMreHYQ9ek71R0
 j0rc2jns5VewDaTNipfr4+GLtPy6OONuKn8EGecGfOAgPMCUASafBHOJ/MhLvwa/6L4w
 TP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934044; x=1734538844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQNG0n9NXp4YCePXcFiDn3lq3sTBy07a0OMkjgz62Dg=;
 b=afMqszqWQ4bLMrzZphbrrUex40/gjzvcHxG9vt3CwDqldhHvcMny/Ogb+VO8IaUpqb
 6FNLvrc78JdCfgS43+p68VXxvL+Hyqfpalke66mIShZCZ+JUvYVfR2EX7wRymF7ZWhjD
 gPQ1tt9t6QtiWQCsqSOuKci+qD28zslMfRWg+Y2CZ8dtxRp8VI4hPqUot8yPY/dxNdBV
 wgzjVGlcFJHbtk0fvER9DXV9Uvnysgq/gxa7v36k1+sqzubry8NP2bTLDXNhUJapnofH
 Kzalbpu80eu/vBnXBAeZOMp60gbD+lwMb15U/Ik6meHO4beDKNgIuuVwC4L4Y//72ftW
 Wgug==
X-Gm-Message-State: AOJu0Yzbmiz3CHgQWL+1MNu0WkEqjsLPkx5T892tYZF8IsAwwK9y/jrn
 0c1nGZrwZ0W//jvzCJzlVFrdD6cDFfWvxpOgUJZ5gn547KvhVDE1ytgFXv6mNutxDw+x9fI+/hQ
 V
X-Gm-Gg: ASbGncvNnmH2roH9/mllPn09pjoayxZWrSzLkzlbwOvI0Wji0Hb4hMVwYgXvRGRZ3JO
 i0HBEbIdVA3o+tT0bRGmyYX7RZx4K9VNuU3FVDiCxgNDC5YWSztgixCDGRFdjSX6RJ3pH8Hoh5E
 rvexpTmhrdfTnAKiyL9D5Ri/pulGooA5lsAJAR8tkcKBLkLNjsR4ffpH1KSQol/EgMqCwQTjvi5
 dL1hKUdxvpzyL4ZznSmMILN7Iym7vvzA3BnNzFtsxW3sVi3Xn0ivwyuSfxz
X-Google-Smtp-Source: AGHT+IEdIQiUrZIYja9QH+zoTtxMLbB4W1ont84ve0ojlABOwwVHlYTPaK3yLtRHgnhDKSmSglTzaQ==
X-Received: by 2002:a05:600c:5122:b0:42c:c401:6d8b with SMTP id
 5b1f17b1804b1-4361c38d8edmr26397295e9.7.1733934044326; 
 Wed, 11 Dec 2024 08:20:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/72] target/m68k: Don't pass NULL float_status to
 floatx80_default_nan()
Date: Wed, 11 Dec 2024 16:19:24 +0000
Message-Id: <20241211162004.2795499-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Currently m68k_cpu_reset_hold() calls floatx80_default_nan(NULL)
to get the NaN bit pattern to reset the FPU registers. This
works because it happens that our implementation of
floatx80_default_nan() doesn't actually look at the float_status
pointer except for TARGET_MIPS. However, this isn't guaranteed,
and to be able to remove the ifdef in floatx80_default_nan()
we're going to need a real float_status here.

Rearrange m68k_cpu_reset_hold() so that we initialize env->fp_status
earlier, and thus can pass it to floatx80_default_nan().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-28-peter.maydell@linaro.org
---
 target/m68k/cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5fe335558aa..13b76e22488 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -76,7 +76,7 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(obj);
     CPUM68KState *env = cpu_env(cs);
-    floatx80 nan = floatx80_default_nan(NULL);
+    floatx80 nan;
     int i;
 
     if (mcc->parent_phases.hold) {
@@ -89,10 +89,6 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
 #else
     cpu_m68k_set_sr(env, SR_S | SR_I);
 #endif
-    for (i = 0; i < 8; i++) {
-        env->fregs[i].d = nan;
-    }
-    cpu_m68k_set_fpcr(env, 0);
     /*
      * M68000 FAMILY PROGRAMMER'S REFERENCE MANUAL
      * 3.4 FLOATING-POINT INSTRUCTION DETAILS
@@ -109,6 +105,12 @@ static void m68k_cpu_reset_hold(Object *obj, ResetType type)
      * preceding paragraph for nonsignaling NaNs.
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
+
+    nan = floatx80_default_nan(&env->fp_status);
+    for (i = 0; i < 8; i++) {
+        env->fregs[i].d = nan;
+    }
+    cpu_m68k_set_fpcr(env, 0);
     env->fpsr = 0;
 
     /* TODO: We should set PC from the interrupt vector.  */
-- 
2.34.1


