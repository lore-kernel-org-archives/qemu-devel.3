Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC18C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr278-0003Ly-6F; Sat, 08 Mar 2025 16:53:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr276-0003LE-1x
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:44 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr274-0000y4-HS
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:43 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso17848885e9.0
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470821; x=1742075621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aDELaWcH8onO5ZCoyKehfG8N5YiojTrTBD0BN28Mrdw=;
 b=uPmpxX3h/1LJX9yjLeHzFrhEAIch4XnXVEW3QMcKq8GPJaxp0MmdW3kEDAtGEKjVjZ
 wSRvnlr1UHP92imriJfZ7Zs/sIX2WOw1LUiaMiIL/YSXzXgrgSpH/fjf/x5A3SWRVIHX
 YBCSfXqYzfxXaTiiJb2Rr56/3doj8amFa3brCF0gYg7PfN2unQF+uAdhBuwm2osZRKsd
 ubvJTMaSQctFpH3b5j+kM9E80K3BFgHmbEMlFmD9lNoJgg+I0/PpFaEZ3rg8svzbqWl8
 GY/WYTvVL4xE6rJeisheL7HoqnfP5BnNNU3p9NobVWIDApu8V6i+uq9DKuhPTC0BVHqb
 FPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470821; x=1742075621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aDELaWcH8onO5ZCoyKehfG8N5YiojTrTBD0BN28Mrdw=;
 b=eVtRDQ6eaYNfpWI9JF7gDDb7QpuM3VMxk5cK5dqpzsJMizNcYIOfbva/Si3kyCUZrA
 sk7DQxd9x1l/UEAiHHu56lMq0BfEzGUdnUmhwGPlwnlYY0nw+nMuRxv7cpWXVDnfGEot
 nfolTkrdjsCPvS6n1h5Cg89ghklUpYhqfKIPJg/05Yl+CICgaklN+lldTNzQNGxGLXat
 Wh7fF2us9C9giCYVk9T0XosSzFwAj6ponQTQJQ9RVxO6yWmzKNojTQl4cNtl/1zZF17x
 3RiRfKxJqRR7xi4KYBgjWOtYj8M0aLNCG4UM1Ar8Y1dfIPp9uJ0URgYDndLdWwf9EjA3
 ybxw==
X-Gm-Message-State: AOJu0YxeWzqWVK+FoGqhpIJo1MZFjFDbuqtYZ7oEtYjxmFmTydrPKTns
 RKKFwJTQ/wT+rkTu+1HK8p1QkCAOj8g1CM9bTnIX3Mo/EMgl/COpPLDWyIWrnyk=
X-Gm-Gg: ASbGncuunOJ3r7MpdAGzkkvg/N/7jnwK5A2kYv03RqhvTocmpsanHBKIxrOzA36+lH3
 HTeoeAGKvH9k80d5it0+1QwG+F892LIJH95Dv1eef2B6jj6E63oo7hqkPZ2OjZFw5oGed4+OVSI
 YfH1heE6si938T6LWtgjxLGMpJ3tIFMvy8jyxyDbO3Q2U4qIp079A5uoXCEd/ddCzfTo5Kxm53Z
 H3aBbEqrSckdU+Lold25cGyjMMUzN6na8f+gnR8RFWtubQ5BwsmyS7aHNPnzHPnJZ7ZN7mgpkqt
 0/aI0j/wj3Xzg7tMS1f2JzLQRg8jyzNObAdoWZ+K+Qf+dIw=
X-Google-Smtp-Source: AGHT+IHhM1MQeRc3LrbQe4KWHWDmWeGlEKP/XxxIRUjTcGQ+evfdJgy6gQIJrdGU9Bosg9fqEbFYGw==
X-Received: by 2002:a05:600c:5112:b0:43b:daa3:33df with SMTP id
 5b1f17b1804b1-43c68702810mr59128835e9.30.1741470820909; 
 Sat, 08 Mar 2025 13:53:40 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfcdasm9756081f8f.23.2025.03.08.13.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 675B860DA5;
 Sat,  8 Mar 2025 21:53:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 29/31] plugins/api: build only once
Date: Sat,  8 Mar 2025 21:53:24 +0000
Message-Id: <20250308215326.2907828-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Now all the softmmu/user-mode stuff has been split out we can build
this compilation unit only once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-30-alex.bennee@linaro.org>

diff --git a/plugins/api.c b/plugins/api.c
index 832bf6ee5e..604ce06802 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -46,17 +46,6 @@
 #include "exec/translator.h"
 #include "disas/disas.h"
 #include "plugin.h"
-#ifndef CONFIG_USER_ONLY
-#include "qapi/error.h"
-#include "migration/blocker.h"
-#include "qemu/plugin-memory.h"
-#include "hw/boards.h"
-#else
-#include "qemu.h"
-#ifdef CONFIG_LINUX
-#include "loader.h"
-#endif
-#endif
 
 /* Uninstall and Reset handlers */
 
diff --git a/plugins/meson.build b/plugins/meson.build
index 942b59e904..d27220d5ff 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -61,9 +61,8 @@ endif
 user_ss.add(files('user.c', 'api-user.c'))
 system_ss.add(files('system.c', 'api-system.c'))
 
-common_ss.add(files('loader.c'))
+common_ss.add(files('loader.c', 'api.c'))
 
 specific_ss.add(files(
   'core.c',
-  'api.c',
 ))
-- 
2.39.5


