Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73991C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqG-0006CE-D1; Mon, 22 Jul 2024 07:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqE-00063T-AV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:30 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq9-0002US-9Y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:30 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2c109eabso12794611fa.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646263; x=1722251063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtiOJDs8/QqWg6V+YgjT6LO0f8xyqBg9VO+Gwatl+Ss=;
 b=Q5qWm8VJV5ntHRH4uFNWNG8NPCBeMX1bpE2GSjcsfo7yfMD9TnQaDowXdgsc/eIeRh
 c0YAteVDW1+pjT4hjgHvL1ErOyykjy/AGx5Wy4undKzhvY55/NyHebw69F4q/wnbU39z
 G3reI7F0XXQGbJx9Pj/SNZmnCRGeIWPyyuvLrma/cs9tk63vxyOeHMzpREKLb+YlcJ1m
 rfizdZB1npsN2PPjTRAONZgpoBXl4IFan6tpkJnTUGyNbjUBM8X52BVWYp9nQUwf4sCD
 eRZ44ZpViH52VSG9eDxpdbOPEbGrqghRnA3yu17waxqONoyvaLO10iOkn5/3IZVoN6Lv
 JHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646263; x=1722251063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtiOJDs8/QqWg6V+YgjT6LO0f8xyqBg9VO+Gwatl+Ss=;
 b=shAoqyO9qGg5u3PgRPoVjNfLvMC7VEYZQ2d1sSALIR+o974MVyAIrDC7C3vcQa/KpI
 VstiSWbTAhOC7C3CUQ65Yhnw+w32ksDtNxSr4zIr25mlj4hq0mnmmr67Gk2JX+YrJifw
 OHyYQYQUgVFj0W/wXj/lPuOC3EeGjxjiRFX1r8GATR6CRC0uzPw/SQh3vA3bwVlGOfxy
 Ad5WErL+aheAwSw0F00mRDp2+pW1N38gEAiG02f5K8dh7o6L0gMZnl+TmCHh8xGDxKRw
 wBng0Q4uExzV0LNtT9VOoTyLOu9j8w0kslBxgMCn8mkCwr5iqah4TtjydYdysunNhihW
 qGgQ==
X-Gm-Message-State: AOJu0YyDxW2qA8zpAOPb2zCQdTKlWvhn7Z47tftlO94nNqaTINNo2g4Y
 xEUnYglVvwfiD7zwmVswGfXIPPC/aElLXg4fyJTBTLg5G0P4+hcj6jR6Y9HhMYuBio//mMeXbSJ
 2
X-Google-Smtp-Source: AGHT+IGu7kmJy4457ttRk244CWe2zyQ7LB19FF/VVHSo2hM+vAlAKwByajXRM117jOC0XqI4S6uEhQ==
X-Received: by 2002:a2e:7401:0:b0:2ef:2f37:345b with SMTP id
 38308e7fff4ca-2ef2f37352fmr18755391fa.30.1721646262962; 
 Mon, 22 Jul 2024 04:04:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30a5ccf09sm5960051a12.10.2024.07.22.04.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B289620F2;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PULL 10/16] target/mips: Add semihosting stub
Date: Mon, 22 Jul 2024 12:04:07 +0100
Message-Id: <20240722110413.118418-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since the SEMIHOSTING feature is optional, we need
a stub to link when it is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-11-alex.bennee@linaro.org>

diff --git a/target/mips/tcg/sysemu/semihosting-stub.c b/target/mips/tcg/sysemu/semihosting-stub.c
new file mode 100644
index 0000000000..7ae27d746f
--- /dev/null
+++ b/target/mips/tcg/sysemu/semihosting-stub.c
@@ -0,0 +1,15 @@
+/*
+ *  MIPS semihosting stub
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "internal.h"
+
+void mips_semihosting(CPUMIPSState *env)
+{
+    g_assert_not_reached();
+}
diff --git a/target/mips/tcg/sysemu/meson.build b/target/mips/tcg/sysemu/meson.build
index ec665a4b1e..911341ac37 100644
--- a/target/mips/tcg/sysemu/meson.build
+++ b/target/mips/tcg/sysemu/meson.build
@@ -1,10 +1,12 @@
 mips_system_ss.add(files(
   'cp0_helper.c',
-  'mips-semi.c',
   'special_helper.c',
   'tlb_helper.c',
 ))
-
+mips_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
+  if_true: files('mips-semi.c'),
+  if_false: files('semihosting-stub.c')
+)
 mips_system_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'lcsr_helper.c',
 ))
-- 
2.39.2


