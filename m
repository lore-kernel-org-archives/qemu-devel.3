Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D334CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbk-0004kl-Hg; Mon, 22 Sep 2025 14:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbg-0004ie-Iu
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lba-00046J-Px
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:48 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso4374479b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566979; x=1759171779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qYsKVv/0Yzl1Fc8tjOv531eP5nXOOQ3pSGhOVd0kDg=;
 b=pZrdmiMIkso0FIjmqoLxRAQQCcsThnrj3LpMZcX8YMecJoDk/MyeNWT2f3joHf+blC
 opA4g1Xw7oV15En5I190ddpA01lHfHsoveF2Wg0QqOoQjh2+4UtM/Fxcu2hpNBi3Iqx8
 I3nh7HXfGl1H2WMBbDedNTcB301Ne/kuIgILJQjsVaPRFoGn1FJXG3rqp47h7If5+DnH
 4XZteZ8UzHiyluCT/iYPW69lfVJCpeE1rMyW8wrfaqnPclNhsG1QL7JDcF+YhJL1Yjai
 WexAslM5nizOGNLcyaFoocxwJiKTcA7hZASHra0KqmM6OT9Fs7FrV9K1wU51Hy3AYROx
 /H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566979; x=1759171779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qYsKVv/0Yzl1Fc8tjOv531eP5nXOOQ3pSGhOVd0kDg=;
 b=VAP3Gyh7DnluNMhrYtYhHgG7VdHmcUjo8Q2OSLrtG1vG1AmHN0hnFO3qcAz6sftDXL
 yCIy2rQT2Nw8xPyGqn6u7NVFoe/EF94sBvaeiQPKcSyBMgIzolOlzC4gl3c+ZMDKbk06
 lAkBz1D0Qzq03kj5ZOhCtYAobxNhndBGLMsob+RMpIUGvOS9PvHN5nhiRHV1rygEnJGR
 A1rid67+8EXT6wl/rx3LyeHrxlQdSKgTptj4EhLD5qoMXq4edBS5VshUH190dQsmPZLY
 UNLOp8hgNBikQckbrBwC+SlytrTBgWCMgmu6KbJNlXZEPft76thGiUhLhclaGPfcz3hA
 5NUQ==
X-Gm-Message-State: AOJu0YzS7/hn1xf2t/Jf4F5LGOf0QAkk04QVLJKKIDszCq/CVZMF9jJU
 XP7Njk7R1jI8fPiFTBxSaxbVefko4s04bwXnhp73EYczPnzQ9zHlcdCI3Wqx/lEyq43s/3I+nW6
 SqsjL
X-Gm-Gg: ASbGncsynieaApOPQ9Hq3dgbg2PldNSOLlz9RAnqyJ/9WgGMww7qGh4wb/56UNLKhqM
 oSkbobXtsDFNZDG9fH7UpympDOOlyNPQu/AAWSvLKJAMWhwCjbXSHz7e0+9a1rLJ4833NGqTk2M
 ZYVlYCseHC5gf588+eGteMeswC99cwsjB14Pxhs6wv0GSTPPMWkCRZ0GQaU3Epd5scwWAwq6kzQ
 O3DAU3WUJft4okKOB2T9w/4Zi3PeEfaA6h1kYK4zT/KPb2SbLL1HcKpUxk2B+tReTVHsfX37jz4
 D46ZjpnZwINL2/r9Mejkqy/d7Adb4S/LC3mWNZwJqYCk3ficMRa0EDakIKj2Hw4iXipvrcZ+CE+
 9XzDhUw5vqBxWmdWQXG1wDUeHp/kc
X-Google-Smtp-Source: AGHT+IGUOwMwENYtjwI4BovoztmW5nJb5378E6zXA1gZpZM4cCkZ6p0m0eKdHfsWz+x+zCboEQRO+g==
X-Received: by 2002:a05:6a20:3ca7:b0:252:9bf:ad80 with SMTP id
 adf61e73a8af0-2cff12bbe5fmr115904637.54.1758566978885; 
 Mon, 22 Sep 2025 11:49:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 10/76] target/arm: Expand syndrome parameter to
 raise_exception*
Date: Mon, 22 Sep 2025 11:48:18 -0700
Message-ID: <20250922184924.2754205-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Prepare for raising exceptions with 64-bit syndromes.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 6 +++---
 target/arm/tcg-stubs.c     | 2 +-
 target/arm/tcg/op_helper.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index aa41054af0..0ebcf566ec 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -304,14 +304,14 @@ FIELD(CNTHCTL, CNTPMASK, 19, 1)
  * and never returns because we will longjump back up to the CPU main loop.
  */
 G_NORETURN void raise_exception(CPUARMState *env, uint32_t excp,
-                                uint32_t syndrome, uint32_t target_el);
+                                uint64_t syndrome, uint32_t target_el);
 
 /*
  * Similarly, but also use unwinding to restore cpu state.
  */
 G_NORETURN void raise_exception_ra(CPUARMState *env, uint32_t excp,
-                                      uint32_t syndrome, uint32_t target_el,
-                                      uintptr_t ra);
+                                   uint64_t syndrome, uint32_t target_el,
+                                   uintptr_t ra);
 
 /*
  * For AArch64, map a given EL to an index in the banked_spsr array.
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index aac99b2672..aeeede8066 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -16,7 +16,7 @@ void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
     g_assert_not_reached();
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     g_assert_not_reached();
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 5373e0e998..dd3700dc6f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -46,7 +46,7 @@ int exception_target_el(CPUARMState *env)
 }
 
 void raise_exception(CPUARMState *env, uint32_t excp,
-                     uint32_t syndrome, uint32_t target_el)
+                     uint64_t syndrome, uint32_t target_el)
 {
     CPUState *cs = env_cpu(env);
 
@@ -70,7 +70,7 @@ void raise_exception(CPUARMState *env, uint32_t excp,
     cpu_loop_exit(cs);
 }
 
-void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
+void raise_exception_ra(CPUARMState *env, uint32_t excp, uint64_t syndrome,
                         uint32_t target_el, uintptr_t ra)
 {
     CPUState *cs = env_cpu(env);
-- 
2.43.0


