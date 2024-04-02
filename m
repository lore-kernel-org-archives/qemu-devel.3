Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A9BCD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 01:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrStn-0002nX-Le; Mon, 01 Apr 2024 21:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrStj-0002nA-E9
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 21:25:11 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rrSth-0001gu-Nd
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 21:25:11 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-221816e3ab9so2495591fac.2
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712021108; x=1712625908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fMQPVwvUw4sUP1QvoGPvpZ1QZdDecCQvtpJyk55QLw0=;
 b=k7CARvOyweFuFsqgaM2kpnV+kuX0hW0wiLfhRryrBPNkFp7yLvjc3sSvcJ6KKidW+f
 4GrGtwtghBe7R7PuVpBzjYPOYa/paK1DMhAs0aUAHD2LUi41qH+6HIy/mS3T9jiaAhpL
 0wL2fB25Q9+HKBksFumZ0ghRvjV25+Bhmn+5hwjjpJ/Y1uJT08N3LOzt8Noy43pry/WF
 OHh5T+Ti93jhwERkUo8R07tbcRt/6cLfnKKXdmg9j4y57GCFIFK6TaKHiAWyrShSQ0GM
 9+DBEvQK8HK7xlv2hU11P4OCOuPT7OJsgbTxQ1rxAhENZLmXkFxDjOvIPsLaT9xFbU6P
 d9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712021108; x=1712625908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fMQPVwvUw4sUP1QvoGPvpZ1QZdDecCQvtpJyk55QLw0=;
 b=rB6q8p7X5KBOHlq+yfvO4NaRwz7Yey2ns9tUNN089oX4/fQke8araDrKlnw/qXwezX
 AQqhNalIlGcBG9jhLPbN9hwce/RGLWpg7R5gQ99L68M9nG/gIoyVe8rkntNgCcMEXM2O
 C8zr+srLKeFgpLe8QU8VBu2vAX2OsVHkV9+dIucvVzGqyUbHbnhToei+u1RGielScBtD
 8KeBeVTXqX3sJs040JefEkPg41KOk+sR1MktO7NQKyuu2peh7pMbogVEhZEl/HHXV8eW
 IHc7VqUg07NLw8TmVld0jYbE2AhXQBpmgQygDKsSVIg0IgqFa9VOpUJ0pBicdYUQYo0Q
 ZJ/Q==
X-Gm-Message-State: AOJu0YwzVHS77mmTsHEAZ11emarXpMAknybv8CGLxruDp2VRkznBkudh
 UJW7Au1fAyR3+gjgQUMfVeCGQs0eoZi0XW9mSxmm08pVredDip0+Numa1WHA7kMEcdZ/z6CAj+p
 D
X-Google-Smtp-Source: AGHT+IFBjJmUnxztVJxtFbEQ2DNLR2wCs0c8uFf8jAfPYwcpmWxv5h5LdmHtN6MpNWkxZr7FhmWCGw==
X-Received: by 2002:a05:6870:2309:b0:221:9227:e006 with SMTP id
 w9-20020a056870230900b002219227e006mr12856168oao.47.1712021107979; 
 Mon, 01 Apr 2024 18:25:07 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 k7-20020aa790c7000000b006ea916eac02sm8539501pfk.42.2024.04.01.18.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 18:25:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH] target/hppa: Fix IIAOQ, IIASQ for pa2.0
Date: Mon,  1 Apr 2024 15:25:04 -1000
Message-Id: <20240402012504.177097-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Reported-by: Sven Schnelle <svens@stackframe.org>
Fixes: b10700d826c ("target/hppa: Update IIAOQ, IIASQ for pa2.0")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Sven, I looked again through IIAOQ documentation and it does seem
like some of the bits are wrong, both on interrupt delivery and RFI.


r~

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


