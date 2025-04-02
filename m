Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DE9C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Ih-0004CI-Qq; Wed, 02 Apr 2025 17:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IU-00043G-JE
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05IT-0007RB-0E
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394a823036so1723955e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743628011; x=1744232811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gOju/HCqmiQibMAguvPjUMQA11xiHQKEggTkQ0J7aUU=;
 b=xbCz/QaNm7O9JiSbeIRTrBqe6Jo8iFNwpUiHMMdWLuwBIOVVmjb/nPMhWOrmNC3mRl
 FMiT/9Fp80EtDZ3ZL6aQDZakf8Irn4DbcDxqdUPhJCDvI0UV/YtWmY2o03n8AEhqrN2F
 /Qf+H/8AAluGp0OYBu/LmoWGXzgLoBFN6rl/NUqn7xHdVPN3YtUynNB7wtYXDoADqos2
 KD9kzKUEUAPJNnWhVDL0sk2F6dfeSSU2MkQcSuQNuwCiJJGV+SbvjjuUDZrUiz8nG2M4
 HPPCPsCFtR5MFxCA27HFKM2aHeABN1uvyJA3WppnOqVGvavAPLQlUT41p0ZK58X0ntB+
 TQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743628011; x=1744232811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOju/HCqmiQibMAguvPjUMQA11xiHQKEggTkQ0J7aUU=;
 b=Jgpzb3sqohLyYsHsIkjTQE+/mP/ne4B5iaiUdUwmlUQBdIGAn3WZAl3IuKXyLjBlps
 XD7YjOv15IUyZWGKMUoMYmf4fcjnxeAUJJ3ZiHmtIKLThS7HlkMgQhd7cufiFIRtS8pb
 lnMldE1hMj8VQYoKe3WGwsATBQuxdIWVMOZTOpgLDqV3b4o+q0eDBew+8HXhsxTtD4ym
 9atae7jx4ylIn4Jtz4ovtqZuQVMb2aApTri5rib6aB0f4qQmNW9F6HohZZe1++6kHPue
 YR8AfDYNNHjcwdFm8ZQoWwEBAOnJ/+9Iityi4IZIBhFM0oeF+MYlg9Q4ZJVv4CW0K7DJ
 gFDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnkyDlVSxitoZgJqPPOkUse5S/jxqAHDq/EGvpmK+0owCcC/gXsCcgRjREgFGYdq2HkrTBlsxIsqid@nongnu.org
X-Gm-Message-State: AOJu0YwdGykg+02E0Qv2b6zl+vYZT8uIGVFsh7VzqGT7BZfX8Bqm6C0L
 tFNBBxbPax04CIQDCt559dG+8OuIZujRfbkDCyjN9LL3TuoIBttvkKp95N/yRkcDSX+/jy2gK8J
 b
X-Gm-Gg: ASbGnct65o4Vk1oVebH0pn8w05lK2UJVEtN9GYlKIDr/2xLQ2IjW/ih4+F9iAXJezSl
 aR350OMZAvyl/nN517EAe5QrVMS+PUb2VlDd8X91U1vm1NPtJh8mDCXcq3X4/8Dm03CopSAFoDF
 F2noaubMpXqawZUogger4k/RM5SOu0Xm+G41+NPAu/TZ0F8cobpq+7z6FtiXk5djZXn9rYcMjmL
 pmCD8VqOc9y2oHx7P3JxXndP+9Z9H3Vl5hKzwHFRPQ7/WDWJuU7fNOz8Yg/TB/Fn7GMt5hZgWdz
 zNbSEmeKI7KThBpY0CTIbv/fsYy2dB1Gte95IAErat3/f3IcUCxGPxL4FcoH1gB2GvsMiD+1dh6
 24IiSQjmBsXI8OFufTgw=
X-Google-Smtp-Source: AGHT+IE073HXb6XQNKIJCeGdl52frCAo+iDpCKf36A55ZJZlTrvp1+FGbVwKANmzXDzGWadz/3svWA==
X-Received: by 2002:a05:600c:1f0e:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43eb5c29e54mr43642205e9.15.1743628011232; 
 Wed, 02 Apr 2025 14:06:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb60eb012sm32038365e9.27.2025.04.02.14.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:06:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 41/43] tcg: Factor mttcg_init() out
Date: Wed,  2 Apr 2025 23:03:26 +0200
Message-ID: <20250402210328.52897-42-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
index ae3a137e87f..df0453c9add 100644
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
@@ -122,6 +101,33 @@ static int tcg_init_machine(MachineState *ms)
                     "you may get unexpected results");
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


