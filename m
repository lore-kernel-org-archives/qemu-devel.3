Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F6AC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16AK-0001kt-9d; Sat, 05 Apr 2025 12:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16AI-0001Zj-3Z
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16AG-0005JV-98
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso19472405e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869674; x=1744474474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLiC832/142ITmF1Yvgl6ilLfBOuUrOH271pHrSjNR0=;
 b=cOWh/9oi5gi2lP38S1D3WEpwbY5U12S6BXxfQ3YOetfScTr2kaELFUSKajYJdZarJl
 D64JPUhSL06cloWA3zhdXcMc4ab5LAD4aSZq9RPrtWMED3MR/Gv/kAjH/IzLoNwrGLw3
 WGnFAsa5Mf1xYz9OxT5fp6kX4MTx8yleR9T/I2n31DOryismsOHPQoDyq9k4Lwy40Otn
 98gG8YrIaqIzL0E+k7ysOUMBUFIqA5W+VpKMqR5WRPeZWhIwzN9zx9c5DBHEOhzL4LMN
 uZi6WW57pLDSjyurSGlsSHC2lriQXGlRK7rU21qOYn0pIZJ0MMe/bZABfbG1Z0En9azW
 GLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869674; x=1744474474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLiC832/142ITmF1Yvgl6ilLfBOuUrOH271pHrSjNR0=;
 b=uHQtd8kO7vhGFuBfV3KAi5ATItGOFdotUqr5IH47SDEnuKOF5WNflR8pONL85IfTZG
 IauNBknPZkiwIk9+gYWmWtjKdvyUhf7t5NuIpuUe03jaPWu7SFJ7Q0Jas02oQ2CIldUv
 rugmyVh0lnitsK2Uh4sQiUWCvHKumaiVp+yOX/nyB2qHSFN81nfTK6xMPKVbFI6Xd9da
 1lpIlnB4zI9ne0rlcV9SYEYyRR5EpvbiX8s7OuCthSfPCy5CnybmRL03fA8hk3rGt6HV
 Kw9hzUCQdGXLXaW4oZA7BNgukE9AnlHkAFu7GaJKd61Az63OXoBrUBWJ3R/zBXEY4Iy5
 9qUw==
X-Gm-Message-State: AOJu0YwS6U9IMXP86aGNG5dW3uEJar6aSAQCwQFxEKNEXvEDWXLDK+Ct
 ND3sn+dP8lq0pLC1vlyxdk9rY2AQP7Q/0T1aETF4ExzdEFSR/A6a8ivFoEIKEGe3EOOWKJRAqgV
 Y
X-Gm-Gg: ASbGnctdIkRyg8FtxwL6V2O7N2NAnbe+Ssds5ZMXAFRnpd1XEn8Rd4hT3WbTkxpv9Qa
 guVmgRRwS+VQkSBRd8lrTS+B+1Cs5ItVi5xukzfcCLs85VAGQ+1GiFLaGKxJzpMx+lIS9TYpsg9
 fepecLsNQavJR+XL1uTVtjcug/iyptRLym6CB64hsCPMI+a/MRFkx53uyqqEBPpkAdzGkdEUd0c
 OGUh78qYmPBhbql837wqU/USF4KNFZJHmIxeKQJJRU9gE/3ZpbvLtDMQ0k5pfWlaKnbC5QMV+1x
 HxNZHzL+XVDl/oLlz6M1NaNqPFtbdSbVLGhzfZyVueqipAHDTQK9IKJjEay4vGn60irIREp8/0b
 efmUUnM+bf2qW6tN5usZvcZpx
X-Google-Smtp-Source: AGHT+IGv1hVLSo1FtU1K8nbpF3tdnfp2mS5Q5F4nxhanYeUUPMoudAEgDwXRfuQ6eDdZeAdA6Cp3gw==
X-Received: by 2002:a05:600c:6b71:b0:43b:baf7:76e4 with SMTP id
 5b1f17b1804b1-43ebee73fb1mr89629385e9.1.1743869674377; 
 Sat, 05 Apr 2025 09:14:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1794efesm80953835e9.28.2025.04.05.09.14.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 15/16] tcg: Factor mttcg_init() out
Date: Sat,  5 Apr 2025 18:13:19 +0200
Message-ID: <20250405161320.76854-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


