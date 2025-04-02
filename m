Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB079C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Ys-0007jh-C8; Wed, 02 Apr 2025 17:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yn-0007gW-DB
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yk-00047r-OC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso177859f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629020; x=1744233820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bkCr362ZjamcjiYyXQYAVlRzEd6wzep8CllaznGqzgQ=;
 b=SFOHWnhhm5zfPW2EUZeXYn3qEAF+inwXm26ZmGi8jPosLx4MElKaKASRJTk4ns/s5Y
 j3dBe30CFiv+YEl2dfjy7pGRdpUfWcZbfusR7LLffVEidUknL4EL1J+Y3yEr5xA73mty
 VuR5bo63jeTX+eU5lB0gYFKanZ1DZHceFAgLQL08Eh2oqAfMr3O4BR3lR5eDp/X5UJhH
 QROIjhJaEKJQiaojEzAaSy1VAVA5fTpyPnAiaT5CoEBmwUuPMW7gXCsSgNydpnnYhjcH
 XZ7hTPrldOKiaNxq5x96pkJTtxR7FcL3Xnew3fyDFkPV186saw5lvrtE4jF1KonwQa1l
 n+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629020; x=1744233820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkCr362ZjamcjiYyXQYAVlRzEd6wzep8CllaznGqzgQ=;
 b=VdWaPuKovAhDM76xkJAP4xxkNPYBQROqhQvfiFd2B45ZDTzvrZ1WbD8zDpSuMFOFU4
 h1fpbBm7w5Xha5k8PjmjAnANNY/PDvnH65WLbfKXOV3znSUZJNvf23XGqeuMq728oZzK
 xEtH4+rUlSbmU3YVPeBGaIJnJeZQpxNwCZdERTlzfMmHK36lIbT+pnITVo0DzNVYjzrp
 WHdoBKBnpFP+lUC1LauDhELaBaRNCDIiBoL+pfpl9FevmojLVKOeLW3ZieuPTYhxNRh/
 0H2X6HHuXovL2H2rY63oyJpIO8pYlA4rwX1YqwIIDjtPR27z896rQ2oLnGmgU0z4i2nD
 18cA==
X-Gm-Message-State: AOJu0Ywz4gqOeE4TJ6ZjNWHAQrEwCODbQvXZPq0lMn3rPzphPkP5WlNl
 luEw4+6ajUXMhMpf4Pzkf43E/MtoVGDJrdpqZWIcj3Us1xMKLZGFJvh8FNVBzT+lnFJEgpoVkvl
 x
X-Gm-Gg: ASbGncuZheR306RmWTxAFnS3NOwegb18D9VWfR6DkAFLDmKF7A2ZWcFPTjnZ6YVFd/Q
 FZEPYQ4ylc0d9garx1yEtzkZPMS1s9aMl3biQJEglHe7x+kn4TNYvbtceIr+82mu7BxIx+fXIet
 skoM+qKT4r1px4pp2SeUgzcN75q1Gzz7AOp7T6EgjstHF9mg1GRxeV+T6PQT5Bg9o75KiA9HExy
 9b7fQzNM826nl3f/UtVkG/7lMWXF4UQtfhQZpiEIm5OTC1kz61kLG6w7QoZAlyN4gf5pwyAVBov
 gmYCIOPVVe/vjCOuU2+X1J8DugYYzU7pp8JsPrKnvfMrfXaOm9gUxQFg6UNH1+6KspbUY2AG84e
 xvDy1usGqFxjvEml+UBO3ZLZRjLD07A==
X-Google-Smtp-Source: AGHT+IGQI2qMU9x7uJ6xNQwVMN2FpHkhRkZ27Ewpm1PK4RfQUgNPsgd1yydBPfzWZ7Vu/bBjv/3abA==
X-Received: by 2002:a05:6000:1449:b0:390:e48a:3869 with SMTP id
 ffacd0b85a97d-39c29737d42mr3796057f8f.11.1743629020586; 
 Wed, 02 Apr 2025 14:23:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec256e727sm280355e9.29.2025.04.02.14.23.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:23:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v2 41/43] tcg: Factor mttcg_init() out
Date: Wed,  2 Apr 2025 23:23:17 +0200
Message-ID: <20250402212319.58349-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402212319.58349-1-philmd@linaro.org>
References: <20250402212319.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Keep MTTCG initialization code out of tcg_init_machine().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 50 +++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 15d4e9232ae..267830658ca 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -69,29 +69,8 @@ bool qemu_tcg_mttcg_enabled(void)
     return mttcg_enabled;
 }
 
-#endif /* !CONFIG_USER_ONLY */
-
-static void tcg_accel_instance_init(Object *obj)
+static void mttcg_init(TCGState *s)
 {
-    TCGState *s = TCG_STATE(obj);
-
-    /* If debugging enabled, default "auto on", otherwise off. */
-#if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
-    s->splitwx_enabled = -1;
-#else
-    s->splitwx_enabled = 0;
-#endif
-}
-
-bool one_insn_per_tb;
-
-static int tcg_init_machine(MachineState *ms)
-{
-    TCGState *s = TCG_STATE(current_accel());
-#ifdef CONFIG_USER_ONLY
-    unsigned max_cpus = 1;
-#else
-    unsigned max_cpus = ms->smp.max_cpus;
 #ifdef TARGET_SUPPORTS_MTTCG
     bool mttcg_supported = true;
 #else
@@ -118,6 +97,33 @@ static int tcg_init_machine(MachineState *ms)
         }
     }
     mttcg_enabled = s->mttcg_enabled;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
+static void tcg_accel_instance_init(Object *obj)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    /* If debugging enabled, default "auto on", otherwise off. */
+#if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
+    s->splitwx_enabled = -1;
+#else
+    s->splitwx_enabled = 0;
+#endif
+}
+
+bool one_insn_per_tb;
+
+static int tcg_init_machine(MachineState *ms)
+{
+    TCGState *s = TCG_STATE(current_accel());
+#ifdef CONFIG_USER_ONLY
+    unsigned max_cpus = 1;
+#else
+    unsigned max_cpus = ms->smp.max_cpus;
+
+    mttcg_init(s);
 #endif
 
     tcg_allowed = true;
-- 
2.47.1


