Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AC6C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 07:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqoXc-0001P7-6e; Sat, 08 Mar 2025 02:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXY-0001OC-CK
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:24:08 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqoXV-0008Ky-4d
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 02:24:07 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390e702d481so1328114f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 23:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741418643; x=1742023443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4eoVoXXRJyhwukYmalfs9jSQF5Wz6XN2stlsLIjFEk=;
 b=kn749YMUmwz3jGsx/x4pU+nfNzlrnZYvtz6WcHwuIjuef69DOOFF5k3UomkM2umEYE
 IASK3iSeA8lDfjT7JI24PE4fFyMonV0niFD98z50Av8sh16zGzXI+9lHIDagHSaxlbS2
 NHJOv4fykr+B5J/qhKKgLufMqG4oGRZwZmKzTROKNLksVGBcMozQnFpuk+x0IfBhkRH1
 gV8JGV6+Ln4Pb0QUAjSOoCi/WGSVUYZSGvy0pG+37sxegg5ybxdCQRsqbD7QTBXUvw2E
 B5xOctjY0tK+KjF77KcFbZsyC7wnJwDrtTU1u2xca7gJWuNPHNv7Dd8fP48y1DA9aD3p
 +WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741418643; x=1742023443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K4eoVoXXRJyhwukYmalfs9jSQF5Wz6XN2stlsLIjFEk=;
 b=mScnazM2nTnMNM/vGji6DWdYwweh42sHeV2aeqaBiA4DxoihzLluEgD3CndPKz5pOg
 AEq1+9oE2PpuKA0L4A8K53qGFhly0E8C0QYj6QWoCmqQ/0/+uwJF37PGznOSXwasrh0r
 znJ6FOmcC2YqlaNHL6h+HV61Sm2S70+TfLx2gSN7/iR6+Q5uPDwjslIZBNdRI1MoaWkt
 FCl2ZmcOusMcRp4unAI3+LqhI6gHUKzkGXTB09KHJPTjHCoBPNY7QdgaBZn+owFExwIZ
 MIF5mKWXaS+xZgfepjepNVEGleIZP38WEug2s3eykCLJ3pZm4dEotrC3q7LWmsqHDbV5
 urYQ==
X-Gm-Message-State: AOJu0YxVomhAPoLYQkjmXQ4AkR5hPDi5RmDVnpvXq0BogZJzfgx1VL1t
 kmzOmiO44pRgZCaVCeLg9n6q6Gj0eDH+C3w8wmp2y+8LaxdOO89sKBzEuIC61xVTW/ycss0tZhf
 SoSM=
X-Gm-Gg: ASbGnctd+5isuCju1ymNmfrnLCwHXd7dfE5iSEQr9faOLYz7ZX1ie/PjdM1EEPssr3R
 bMoLGs95fQ/FT2+5HJrp88iadqAMdO/QqEPUCjMpr/qTwaVOETZ2nYidgjTr1+rh1FaoaLF0Lfa
 qmXb2G0wW24vPHstkTkCnA+hPJwI0cyKBgKqk4I/K5aLkWAX60yv9ZiZ3/VRrec+TVkyE59EB9K
 0LQqkFCE0Egc62icLbysYong6UpU+6dslbJ9+DjCUYNWgY9i8yzYORLlE4zGS8NySzulOcYcvlr
 oSxYJVEiisAf0Za2Ad/OgeDZBWqApAxXMRcUWOmmOPJP06sI8RwIM5uEo0BITw+C9kP9sjFdVoz
 4XFq8jOs8sBF1D4pxO8g=
X-Google-Smtp-Source: AGHT+IHLp5hfPcTFuvnwAk5yEyONU+xMrGN1vZuaVEMPHrM6c2BDT/dT/lj9ttpQKUVn5ka8dwYumw==
X-Received: by 2002:a5d:59a8:0:b0:390:f55b:ba94 with SMTP id
 ffacd0b85a97d-39132d31f55mr3956175f8f.13.1741418642739; 
 Fri, 07 Mar 2025 23:24:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7aefsm7793583f8f.20.2025.03.07.23.24.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 23:24:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 16/18] accel/tcg: Split out getpc.h
Date: Sat,  8 Mar 2025 08:23:47 +0100
Message-ID: <20250308072348.65723-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308072348.65723-1-philmd@linaro.org>
References: <20250308072348.65723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Split out GETPC to a target-independent header.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/getpc.h | 24 ++++++++++++++++++++++++
 include/exec/exec-all.h   | 11 ++---------
 accel/tcg/tcg-runtime.c   |  1 +
 3 files changed, 27 insertions(+), 9 deletions(-)
 create mode 100644 include/accel/tcg/getpc.h

diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
new file mode 100644
index 00000000000..4bb5f7b15cd
--- /dev/null
+++ b/include/accel/tcg/getpc.h
@@ -0,0 +1,24 @@
+/*
+ * Get host pc for helper unwinding.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_GETPC_H
+#define ACCEL_TCG_GETPC_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+/* GETPC is the true target of the return instruction that we'll execute.  */
+#if defined(CONFIG_TCG_INTERPRETER)
+extern __thread uintptr_t tci_tb_ptr;
+# define GETPC() tci_tb_ptr
+#else
+# define GETPC() \
+    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
+#endif
+
+#endif /* HELPER_GETPC_H */
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2ac98e56c41..ce303de8486 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -29,6 +29,8 @@
 
 #if defined(CONFIG_TCG)
 
+#include "accel/tcg/getpc.h"
+
 /**
  * probe_access:
  * @env: CPUArchState
@@ -177,15 +179,6 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
-/* GETPC is the true target of the return instruction that we'll execute.  */
-#if defined(CONFIG_TCG_INTERPRETER)
-extern __thread uintptr_t tci_tb_ptr;
-# define GETPC() tci_tb_ptr
-#else
-# define GETPC() \
-    ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
-#endif
-
 #if !defined(CONFIG_USER_ONLY)
 
 /**
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 9fa539ad3d7..3d4651b4012 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -30,6 +30,7 @@
 #include "disas/disas.h"
 #include "exec/log.h"
 #include "tcg/tcg.h"
+#include "accel/tcg/getpc.h"
 
 #define HELPER_H  "accel/tcg/tcg-runtime.h"
 #include "exec/helper-info.c.inc"
-- 
2.47.1


