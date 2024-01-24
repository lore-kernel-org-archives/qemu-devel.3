Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D45C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaK8-0003OO-6z; Wed, 24 Jan 2024 05:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJk-0003GJ-Ik
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:14 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSaJh-0003pa-2F
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:17:12 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50f1c524010so5839871e87.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 02:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706091427; x=1706696227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHl/AtYG7is0KFUXE16Nv2to1GnXQQp2fEWClGXzUg0=;
 b=kd937uMxTjOVfqtJKOjiL5NmagA0shvH8906ZoZfdzRuuICqvKtlV94VIY0XXr5n+p
 YNyLCcjvsaoWkCALdjPrA/UxxAd6HILa5NLPeRlPLcuL3R+ZlITCx6OTPBgBtGXQ4/h6
 MrbbK2X3iEyUHJA/ytOfp84EdZiZEVF5m1CSfdXQYPM9H3jB7lGNX/Gkkb0ZlN7dShQh
 kqRuyRhTGHBe/De5U57FXgubCSJtIuOeUdsAikjCcKslp9oE9T5n6MkMp9Of3jvI/NYp
 hbTfZVOO8JWd5ePEioH1tP1tD5ywq4Q0bEdRb8fUDFmxjE05yehK/9ggPx1adFLvWysR
 sqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706091427; x=1706696227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHl/AtYG7is0KFUXE16Nv2to1GnXQQp2fEWClGXzUg0=;
 b=kVgaWEKw4vZVSnI+YiBhjohO0gH8YDtO7ynXS5b77GgrWchUb79cnU5NIGrmPJqLIF
 D2HSTdTDlq5Pc3r5N3aBpS4ju2hpQk55F4Dz4uwSTMx9ip1tkXRKYdx0z5dR+pVrxfgf
 8xpTol2i53El3IldOMDdRqdrLwkq+09qZEw02bnDrQsX127KIrQoMwFIaO9xzmRpoADX
 qpsAfsHkwDcnHVM1c4UpDh5gmUPa1A3cP3zF8I4YxcTBKTQAS+aSbg+PoP3RnpQFaaLy
 PSW04MlBAr9X8YSmAyu4/B01C1ZZlYeFnvIkYHogrsYMy1azdPfERuty3yoRqrIHGj8B
 uYQg==
X-Gm-Message-State: AOJu0Yzz8GjFmNyqR1cYM/JVG0pKbukIgzFbY8cog1kPRXwE8nStLasl
 71imj5q187nlD6fdZt36Z2mS1VOcwhLJ8fCxxwtqkHD2GxMnWq8K4sH9ZiKL6V8=
X-Google-Smtp-Source: AGHT+IHcaI9f0VCMx3KUF7ype2ngx8znRoz2FootGivNktqk80lS8Eg81b6JHz7qws4W3+Gm2giwdQ==
X-Received: by 2002:ac2:5d2e:0:b0:50f:1c9a:13f4 with SMTP id
 i14-20020ac25d2e000000b0050f1c9a13f4mr1566570lfb.52.1706091427590; 
 Wed, 24 Jan 2024 02:17:07 -0800 (PST)
Received: from m1x-phil.lan (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 g17-20020a170906c19100b00a2b1a20e662sm15185422ejz.34.2024.01.24.02.17.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 02:17:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] accel/tcg: Un-inline icount_exit_request() for clarity
Date: Wed, 24 Jan 2024 11:16:34 +0100
Message-ID: <20240124101639.30056-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240124101639.30056-1-philmd@linaro.org>
References: <20240124101639.30056-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Convert packed logic to dumb icount_exit_request() helper.
No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6b3f66930e..d61b285d5e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -791,6 +791,17 @@ static inline bool need_replay_interrupt(int interrupt_request)
 }
 #endif /* !CONFIG_USER_ONLY */
 
+static inline bool icount_exit_request(CPUState *cpu)
+{
+    if (!icount_enabled()) {
+        return false;
+    }
+    if (cpu->cflags_next_tb != -1 && !(cpu->cflags_next_tb & CF_USE_ICOUNT)) {
+        return false;
+    }
+    return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+}
+
 static inline bool cpu_handle_interrupt(CPUState *cpu,
                                         TranslationBlock **last_tb)
 {
@@ -896,10 +907,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     }
 
     /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(qatomic_read(&cpu->exit_request))
-        || (icount_enabled()
-            && (cpu->cflags_next_tb == -1 || cpu->cflags_next_tb & CF_USE_ICOUNT)
-            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0)) {
+    if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
-- 
2.41.0


