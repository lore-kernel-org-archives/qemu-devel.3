Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D60C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqB-0005ry-E2; Mon, 22 Jul 2024 07:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqA-0005nA-8k
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq8-0002UL-It
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:26 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a3458bf7cfso3059203a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646263; x=1722251063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oQdAPnxXqSmkLw/KIFULqM8OBF8epxnQmZ+s02z5ZE=;
 b=EQAF3nMVMkBnW1elX7paO3PoRncp7/gdKC6yxWMA+i4QRDxVL1tG7syYPdZ6/E9CfL
 4NrqKfHZe9+MLGVfbN3JGIWzDzLHzLMpzKIKCSsHGjD+iitC5wYyUg2bxr4j0jsW7iCl
 f8i/7zLLAg0yZKucW2926MrwZaL8EZfPQDvV3esFRjh86g8mWVHAaGKmM+QC+A/wJIT1
 +8iI5i9kTuB9709vqnWS0g4TTIFbHfZdemewuBwd7PJ8YZrKas7yLyhL7dIV1Co8UfG2
 A54n3W/DcVQL2ddJ0SFxDkKXbmR8Men5IcMngirq9x2GHb1ad4Z0Ff/8aJW8FgNWMVW5
 H/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646263; x=1722251063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oQdAPnxXqSmkLw/KIFULqM8OBF8epxnQmZ+s02z5ZE=;
 b=T/VHZVwLPCyix4xz52jcDjmyNogw3g4m6aAIx2ylnbIoj5rbRWxLPchimOOsGLsZ8m
 Q45zUh0EUBRPPlQZVHZWPuzTqpnxKTxmbfXkI2RV02bW8/h1pF8hk4ERQxt/xEk+aWT5
 swAoAkFxQbN+5g9DIfwpgsPtrohlnKTDIkIndNfIl7j7dkmVAKI+pCSuvRfeiVQyAtg6
 ciQEMnRZOH3fbP7ae3d8AlGwQugDyKJgVGs5NHVoeajDK4kwXoyYNNXEIhPx3/zLIesX
 EdRqRmOaFiMCGc9tcAkedYjy4OQEs+z0o0KmuoVnsEym4t0s4YUSDuI9WTrpR3Fvv3FG
 zfnw==
X-Gm-Message-State: AOJu0YyQxEwAYAytNb3dPVlkTImRQL+PL18KPhnVxwtQExpWwASe8ZNm
 3QQmcl3CkXwXSjyZivFi64oTguCFHJ2wra/8CSCVYZzagPm//+ZSOgD8ChGGZUY=
X-Google-Smtp-Source: AGHT+IG9+rricyA1vZVnwzwa33roI2P/3RkQ1EF6+Jq3xT5FOM9u2EoMSkWLS/nihIIdGKIPPbpNTw==
X-Received: by 2002:a05:6402:1d4c:b0:5a3:e652:d59 with SMTP id
 4fb4d7f45d1cf-5a4761b3f06mr4502987a12.0.1721646262557; 
 Mon, 22 Jul 2024 04:04:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c3f0673sm5907642a12.61.2024.07.22.04.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71FE3620ED;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 09/16] target/m68k: Add semihosting stub
Date: Mon, 22 Jul 2024 12:04:06 +0100
Message-Id: <20240722110413.118418-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since the SEMIHOSTING feature is optional, we need
a stub to link when it is disabled.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-10-alex.bennee@linaro.org>

diff --git a/target/m68k/semihosting-stub.c b/target/m68k/semihosting-stub.c
new file mode 100644
index 0000000000..d6a5965e29
--- /dev/null
+++ b/target/m68k/semihosting-stub.c
@@ -0,0 +1,15 @@
+/*
+ *  m68k/ColdFire semihosting stub
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+void do_m68k_semihosting(CPUM68KState *env, int nr)
+{
+    g_assert_not_reached();
+}
diff --git a/target/m68k/meson.build b/target/m68k/meson.build
index 8d3f9ce288..4d213daaf6 100644
--- a/target/m68k/meson.build
+++ b/target/m68k/meson.build
@@ -11,9 +11,12 @@ m68k_ss.add(files(
 
 m68k_system_ss = ss.source_set()
 m68k_system_ss.add(files(
-  'm68k-semi.c',
   'monitor.c'
 ))
+m68k_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
+  if_true: files('m68k-semi.c'),
+  if_false: files('semihosting-stub.c')
+)
 
 target_arch += {'m68k': m68k_ss}
 target_system_arch += {'m68k': m68k_system_ss}
-- 
2.39.2


