Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BD3C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd02-0001yX-GS; Tue, 04 Mar 2025 19:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd01-0001yH-08
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:37 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpczz-0007R8-5a
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:36 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso66759665e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135953; x=1741740753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lk9TI+rSZkzKv7Njal1Wbs7A5Y+36v2tj7kLtziVEzo=;
 b=ipNReLJRXOHXo+sPkQyGh2PL2R5IRoL8f9X+40CuLYGSMVZ8sGcpAzscO3OlB3lyxZ
 6gH9naTiheXA4UariubfBippcI2RbfVY/Hk1b2SB7rJmJPAnzfsG8xrXRPUjHUXY6QKf
 JiIbq7/qWy06hPRRfnmf5frQrBhIFoyB9hFU6WaAh3uLuwPtoUcL+fVfrpbBuR6rwhQQ
 fbvppcBlyECVEiIMphAc60pCbACb5HJQTZplfWAwSD+7PsKQalubTEJziNSJqKv/C5V3
 O8fjL81Y2KR2dASpy3es8oM0BXzhVenGmzB4P4oEU14FxJ618c804jeAikzc9UZhO1fR
 k5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135953; x=1741740753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lk9TI+rSZkzKv7Njal1Wbs7A5Y+36v2tj7kLtziVEzo=;
 b=IWKt6Myqkkdh5yOhDbBGz1XUP9slqNeypBvjN2XqChTAib+FIil97LYAETKKiiaxzn
 iwDRkoPdcXTutT3M1P6ThFc+zooW50MRKxXkFMmYBCvKbtJ43QYUIvkUi7avRwRXzneQ
 RnRYGo8n4jN9XzgTulVTorNNY1M+qZEnXVHhkH5JpY+pWsGabKg41olVwFsSFln3F3dc
 hs6UbKzPEv5pnoEzqotwuQKDJePU1FfLUZD3ky+Wm3ENQnStVB0ATVqWKL5ttzci9/cD
 LoiFOutfSTkb9prx0oKTFT+SlY4rVRtskaXGItHx06vrHnEFXocLskokzKi6jUFUsUrV
 O18w==
X-Gm-Message-State: AOJu0YyM41Cxy/iumxVkHpscy3fGf4fG1wGK0H394YPgkLtN57dA1u66
 DfiZV0+HV3Z4a+GjTg+ccPVxceM78zsP9q6NrD3r4vdjfmmN+cugfFvA7gFf8SbIDCVPgqsXHcy
 YNGc=
X-Gm-Gg: ASbGncv4+pQccMKCRfVsqKc5Ucs+dNQ1D7niFWmvV5aNf08Q7917NgdHcxgkS03qLVD
 Mf6WQAUylVOFrXJp47Nnal4+CB1Diz6QhB1AjnbRDrJ+WWqubkJFGJ2pw/EsESmHVBCywKEL11q
 gYa76MvHj2v/YME07nR5rB9KyO/m9L2cvCQslpCgvVYE0//QBg1nRBYlPVqcwN4OUN4bBRmMAry
 hkCgMuH0ocFYTiAdTYFMVMXX/5aNi1peRO7j5KHZ11JOuq4jnzPuaqnlC0zfDdo/XSpv/LNNpVQ
 y7nqDED9VCywINmVWgEZb8hwj/sTrFveVg+icv3hUGzo30ls4LhNKvbB/sN7wqPZm8Qie/0Wod6
 Cx0s0M+uMYFjc/fPuCFY=
X-Google-Smtp-Source: AGHT+IEAp+T7jbKyE/IL9MPtQR2WZJ7USejrJCM9Stl3cHW7orNQM9hsROUx2jxG6xIf/nWUxgL1wA==
X-Received: by 2002:a05:600c:5493:b0:439:9106:c09 with SMTP id
 5b1f17b1804b1-43bd29d0497mr5548175e9.26.1741135953104; 
 Tue, 04 Mar 2025 16:52:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bcc13b23asm21499725e9.1.2025.03.04.16.52.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 01/11] system: Extract target-specific globals to their
 own compilation unit
Date: Wed,  5 Mar 2025 01:52:15 +0100
Message-ID: <20250305005225.95051-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

We shouldn't use target specific globals for machine properties.
These ones could be desugarized, as explained in [*]. While
certainly doable, not trivial nor my priority for now. Just move
them to a different file to clarify they are *globals*, like the
generic globals residing in system/globals.c.

[*] https://lore.kernel.org/qemu-devel/e514d6db-781d-4afe-b057-9046c70044dc@redhat.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/arch_init.c      | 14 --------------
 system/globals-target.c | 24 ++++++++++++++++++++++++
 system/meson.build      |  1 +
 3 files changed, 25 insertions(+), 14 deletions(-)
 create mode 100644 system/globals-target.c

diff --git a/system/arch_init.c b/system/arch_init.c
index d2c32f84887..ea0842b7410 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -25,20 +25,6 @@
 #include "qemu/module.h"
 #include "system/arch_init.h"
 
-#ifdef TARGET_SPARC
-int graphic_width = 1024;
-int graphic_height = 768;
-int graphic_depth = 8;
-#elif defined(TARGET_M68K)
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 8;
-#else
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 32;
-#endif
-
 const uint32_t arch_type = QEMU_ARCH;
 
 void qemu_init_arch_modules(void)
diff --git a/system/globals-target.c b/system/globals-target.c
new file mode 100644
index 00000000000..989720591e7
--- /dev/null
+++ b/system/globals-target.c
@@ -0,0 +1,24 @@
+/*
+ * Global variables that should not exist (target specific)
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+
+#ifdef TARGET_SPARC
+int graphic_width = 1024;
+int graphic_height = 768;
+int graphic_depth = 8;
+#elif defined(TARGET_M68K)
+int graphic_width = 800;
+int graphic_height = 600;
+int graphic_depth = 8;
+#else
+int graphic_width = 800;
+int graphic_height = 600;
+int graphic_depth = 32;
+#endif
diff --git a/system/meson.build b/system/meson.build
index 4952f4b2c7d..181195410fb 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,7 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
   'ioport.c',
+  'globals-target.c',
   'memory.c',
   'physmem.c',
   'watchpoint.c',
-- 
2.47.1


