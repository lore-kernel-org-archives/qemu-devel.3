Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1DCC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 17:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtt7x-0001zj-7J; Mon, 08 Apr 2024 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7t-0001wk-9w
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtt7r-0003d2-Lf
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 13:49:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a2da57ab3aso2672014a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712598585; x=1713203385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6xA9uOxQL6GHFyuuAVL91EMcYGjdhkuoxzjyRnEesc=;
 b=ARUX9p6+UIvXtrvSSWi6rfUg1qr7yEk2tkiATpEVy5oAQAEFRY6Vxrm+RCPF41dbYS
 hh4wQIqrUHCCx6N7aKs99K4DnKABAQ2cxULBXGNM6xXcwjcxPVcfd6wllDuDf87dnmeC
 vVAi5ZVBIlb2UwPIyDAoXOira/Dj0ekHGFwuVAQfHzdFphprH5DH0rAaNQzvrHHXnjqF
 HVqeIAtKNMvh3L5O2ezj7L/eZdr1/lDgMjS5Xwb3Kj/5bEEYtTBY+bfwiJbMfftUn6rk
 6zao6E9EC9o3Dk4wCWaLD6pEBkFMhE4NvYD8wiL27Dv7PKG68+cVC0ifJOVpzuqJTy3R
 Z4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712598585; x=1713203385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6xA9uOxQL6GHFyuuAVL91EMcYGjdhkuoxzjyRnEesc=;
 b=mnn6JOh7CV97OtMcmOlBRBdsU0JhVMrtiJpXxWxSzoYzvBGW5Xefcay3iWmw/TfEhZ
 MVMaJjU/0QkskNoOBc3oDBftWU6HHeEzUVyp4Q1DC89TMYpEB5l8Tihn30SdogDKIUsR
 8nHj+YPMAqQemMh0bmIwXW53jayfIEsb8jBT/oDEO5O2w6qwMLnS7tkEqTmc0K2mRrp8
 20lAObIueARIkiw3U1j/vwawPQsW5yCl8gRGFyLFfC/99Do+/IPsJioHb5Yx79vwxC4W
 l7Il/oVrNQfBJyCFoIij3tj1zPEPicC9qW372QLP8MkE6SeO+y714QPnod+RuwaqStnO
 wm8A==
X-Gm-Message-State: AOJu0YwEhoG5sDRQ052T2i+aYF402EV0J1XgqNoGjdJk4RV3AXerEqyG
 rAnizE+tXB9U4q1yjXvKRnBmFZw/5OcgSWLkQxYjptRxonZurqdNPIpR+S9JnAL5kHt5Zuk93Pt
 z
X-Google-Smtp-Source: AGHT+IH6f3ZuQwr8n6UcOXlDn7nuNUfSChMox+x4Ni59ik6keXWC2XLMWzGIXqkhS7acZoHyWKjLeA==
X-Received: by 2002:a17:90a:e992:b0:2a2:437:18ec with SMTP id
 v18-20020a17090ae99200b002a2043718ecmr6230010pjy.46.1712598585027; 
 Mon, 08 Apr 2024 10:49:45 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 ga15-20020a17090b038f00b0029c3bac0aa8sm8658432pjb.4.2024.04.08.10.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 10:49:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 09/35] target/hppa: Fix IIAOQ, IIASQ for pa2.0
Date: Mon,  8 Apr 2024 07:49:03 -1000
Message-Id: <20240408174929.862917-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408174929.862917-1-richard.henderson@linaro.org>
References: <20240408174929.862917-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

The contents of IIAOQ depend on PSW_W.
Follow the text in "Interruption Instruction Address Queues",
pages 2-13 through 2-15.

Tested-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
Reported-by: Sven Schnelle <svens@stackframe.org>
Fixes: b10700d826c ("target/hppa: Update IIAOQ, IIASQ for pa2.0")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 20 +++++++++++---------
 target/hppa/sys_helper.c | 18 +++++++++---------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 90437a92cd..a667ee380d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -107,14 +107,10 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
     /* step 3 */
     /*
-     * For pa1.x, IIASQ is simply a copy of IASQ.
-     * For pa2.0, IIASQ is the top bits of the virtual address,
-     *            or zero if translation is disabled.
+     * IIASQ is the top bits of the virtual address, or zero if translation
+     * is disabled -- with PSW_W == 0, this will reduce to the space.
      */
-    if (!hppa_is_pa20(env)) {
-        env->cr[CR_IIASQ] = env->iasq_f >> 32;
-        env->cr_back[0] = env->iasq_b >> 32;
-    } else if (old_psw & PSW_C) {
+    if (old_psw & PSW_C) {
         env->cr[CR_IIASQ] =
             hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
         env->cr_back[0] =
@@ -123,8 +119,14 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         env->cr[CR_IIASQ] = 0;
         env->cr_back[0] = 0;
     }
-    env->cr[CR_IIAOQ] = env->iaoq_f;
-    env->cr_back[1] = env->iaoq_b;
+    /* IIAOQ is the full offset for wide mode, or 32 bits for narrow mode. */
+    if (old_psw & PSW_W) {
+        env->cr[CR_IIAOQ] = env->iaoq_f;
+        env->cr_back[1] = env->iaoq_b;
+    } else {
+        env->cr[CR_IIAOQ] = (uint32_t)env->iaoq_f;
+        env->cr_back[1] = (uint32_t)env->iaoq_b;
+    }
 
     if (old_psw & PSW_Q) {
         /* step 5 */
diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
index 208e51c086..22d6c89964 100644
--- a/target/hppa/sys_helper.c
+++ b/target/hppa/sys_helper.c
@@ -78,21 +78,21 @@ target_ulong HELPER(swap_system_mask)(CPUHPPAState *env, target_ulong nsm)
 
 void HELPER(rfi)(CPUHPPAState *env)
 {
-    env->iasq_f = (uint64_t)env->cr[CR_IIASQ] << 32;
-    env->iasq_b = (uint64_t)env->cr_back[0] << 32;
-    env->iaoq_f = env->cr[CR_IIAOQ];
-    env->iaoq_b = env->cr_back[1];
+    uint64_t mask;
+
+    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
 
     /*
      * For pa2.0, IIASQ is the top bits of the virtual address.
      * To recreate the space identifier, remove the offset bits.
+     * For pa1.x, the mask reduces to no change to space.
      */
-    if (hppa_is_pa20(env)) {
-        env->iasq_f &= ~env->iaoq_f;
-        env->iasq_b &= ~env->iaoq_b;
-    }
+    mask = gva_offset_mask(env->psw);
 
-    cpu_hppa_put_psw(env, env->cr[CR_IPSW]);
+    env->iaoq_f = env->cr[CR_IIAOQ];
+    env->iaoq_b = env->cr_back[1];
+    env->iasq_f = (env->cr[CR_IIASQ] << 32) & ~(env->iaoq_f & mask);
+    env->iasq_b = (env->cr_back[0] << 32) & ~(env->iaoq_b & mask);
 }
 
 static void getshadowregs(CPUHPPAState *env)
-- 
2.34.1


