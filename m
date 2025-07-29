Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A84AC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugubp-0005lG-Mz; Tue, 29 Jul 2025 20:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIq-0004Sz-7X
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:16 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguIo-0004b9-Cm
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-74b52bf417cso4195798b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833853; x=1754438653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=74W6I+DW9RALQfP3tJ1mmyAVQC90YHEc9/WQM5fQ+dA=;
 b=zy/iBn81z0o11Fw2BL1reASFe5KmpwVW1GSxuImIvlTtphNy9pwDjV0oediko2NpnI
 998xf1T2alcyeam4IIJbYLnpE8fd/iGo1QRraN+Uj0gm3/LdbGCkd5l8M9JRC+J0gOzg
 lgWHX/CjWqB8zgdi/WYUNFRq6olPWMi2j82gYktWPrM9JRVoTrOp82o9FHKIxrf5bjUe
 yzbSZVOwpzym8FyPCgG9voxb1SzxREfkvcJd5K7UaFa74NnAhJM43LN3/7Qx1a/csp1W
 Yu+tLnkS3WjHGooV9fx65qg8cC6RXUHS3gPdRp+Oa3xoerlrRNFw2KHgL0SqGgNDr+KH
 6A4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833853; x=1754438653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=74W6I+DW9RALQfP3tJ1mmyAVQC90YHEc9/WQM5fQ+dA=;
 b=C2ULiYNvU6AF8Gk/uUv4Vy6cA2kLkZWLG+R+TVTygP/0txFW3TaHaW2sQ8G7hYXUW7
 j57rCSQQtB+ygFLk3nePhJYmeVpd0bRCviI5uXTnrWovZVW1rBsw3DMTq5kH4h1hU/lc
 inYzc10M/LuIqGS4KwQEYaQB5cvgWXAVk3eFr8RUo/e87GuJ8KjazEZM3z+gD2Vudrp8
 iHa9Yxrqyhq0uNo12ENu7mkGclLGrRKQpNcPqzrfFgPHY11BOU/kRCpPoYZO8OSS+y3r
 LBk/t67mPqm8vYOs8AIM+SRGzGTRhEb8PpNu//UkZaNRhUkmHFVKGCDifydsFrXaP3vm
 EZtQ==
X-Gm-Message-State: AOJu0YwDEB3lF1iUK4hFPuCgnqF4T6Wym08kFla5uwUPH3NQhigvPFXg
 wLEaoGvrQOQYePqx8oyMFwxQUflYJXfXF+PK+GPii+EIPFw1rQ2L+L/RiADaPGh7H4Pi0c4sOeK
 DxUwD
X-Gm-Gg: ASbGnct97Q+5A4ijzd8Wxuog0BqFeGsDdpZlJj5Oe2x0zHVsHbIGBtF2DGcxW6PK+rQ
 fRIouKfZBMC5WS2TkwVQoVaLDvlkXrJrm+aGVVkWLJbL9YJq31sb+0d7iVEjdw6oL32kmUjJeYI
 DuhR7E4gYZe0JnLkHpCTjC5vVlPWfZyHzO1J46hBY8eSedvUAVsWCRXBRqk68qHQZmfHy2dh7Gg
 GGxw3PRCy7kdt1ns5UfEAvqaZefpiEucvWd7z0cZ+JbFv1yQTvkgA1Mym3gNgXbG2c+0s7GJqKt
 VUI+QXX3piwjJo3EmaBe150kEdmJsaVOSouLBhDo8TyQjM6IVbFLAFiisSSOURnW0meFojemuxP
 16s3JPKdX1ckaua5WXphfxdR4PH4XwNjBwEfkMcCcGoEZsxDDMBcsCRlHrQRJhLr4Zc0fo9xFW5
 gem1FWZ84hVA==
X-Google-Smtp-Source: AGHT+IFQY0GYusfmDurFk6QY1OodAdr0gDws5J6isyyWpCiXsREX32Z57Y/kB6q8P9UMJt4D7ttNnw==
X-Received: by 2002:a05:6a00:b8d:b0:742:4545:2d2b with SMTP id
 d2e1a72fcca58-76ab092f88amr2081807b3a.3.1753833851479; 
 Tue, 29 Jul 2025 17:04:11 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/89] linux-user/aarch64: Split out target_coredump.c.inc
Date: Tue, 29 Jul 2025 13:59:17 -1000
Message-ID: <20250730000003.599084-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c                     | 16 +---------------
 linux-user/aarch64/target_coredump.c.inc | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 linux-user/aarch64/target_coredump.c.inc

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b35f35b2a6..57bb011e63 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -304,21 +304,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define ELF_NREG    34
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUARMState *env)
-{
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(env->xregs[i]);
-    }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(pstate_read((CPUARMState *)env));
-}
-
+#include "target_coredump.c.inc"
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE       4096
 
diff --git a/linux-user/aarch64/target_coredump.c.inc b/linux-user/aarch64/target_coredump.c.inc
new file mode 100644
index 0000000000..9b653aa12f
--- /dev/null
+++ b/linux-user/aarch64/target_coredump.c.inc
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define ELF_NREG    34
+typedef target_elf_greg_t target_elf_gregset_t[ELF_NREG];
+
+static void elf_core_copy_regs(target_elf_gregset_t *regs,
+                               const CPUARMState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        (*regs)[i] = tswapreg(env->xregs[i]);
+    }
+    (*regs)[32] = tswapreg(env->pc);
+    (*regs)[33] = tswapreg(pstate_read((CPUARMState *)env));
+}
-- 
2.43.0


