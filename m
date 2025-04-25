Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB9C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3u-00046b-6L; Fri, 25 Apr 2025 11:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3B-0002Vn-KG
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L39-0004Ge-Pm
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:13 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so21201565e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595190; x=1746199990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=um1U7VZovIFSphiSpmsIW+FJvR3FqN2d19kIPb19NrA=;
 b=qX50dJilHUh8nlUBTmUQ7VFR/Gso+ok80UyoN1X9cWUuZPxn6I7VGjkDQR5IseiclL
 vhmcYeUL9cWWEnsT3qsTBREdK+QEML//QS4azVMWXFYjUCm049Sw3DD45fsfQ5mwWeBj
 Q/gcnwVOeA1MEm7zXwjfAPpB78JESXKxkia4/2nxD0GHdILRkKe7VFDEbaEjNX1ZcnQB
 QMBKTvfeaA6u4aZuXCUpOvc6Zl4ejyiSDcjw4oiMTnBRgrKskOE7LdYwhO4FrH8OgAnz
 F1j0fWYs7tBYwTys1c5Wxtpy0jbyQ1BvHOVjM3KqfoBXkMyVRrv02mOg/2h6ew7XycZF
 i79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595190; x=1746199990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=um1U7VZovIFSphiSpmsIW+FJvR3FqN2d19kIPb19NrA=;
 b=EOx4OdMEbN1tAdy6o/juRKjFXMV6oh3UnJrsQmL1/7n1WpUVG0DXjfVegvHiwnWyIc
 9nNF6pXbMaE4y+ghn7W8IZhP+MOyQVsraDGWXrjdOJw5w8yyOc3nmmX/BAEZ8pvQc1ow
 cMcJY9Grc2vDB3J5/wISiKtVYdnJoYfGLb2LGcgV/YBWaLSaGkSffmK0QYtr+pqRXKYe
 QOdlcOpFAglnC2Xcbj8ZVwT/bU0xgIN2pY5IS0N5yvE/WQx7xw3i+Lyz7g8cpGO6dcXM
 VlDjft9vSzd48qYREupUyTtTgHj80brsoBeBdjZ0qKpz+fCzwPyhPd96tgxde7kITke/
 X1+Q==
X-Gm-Message-State: AOJu0Ywuok27DVLzDLfuqrpccCzMvOKy7P+V2+y2YVmD4z+9GUQOzaHA
 0MWKP973XJ+uB5VmM86bkCRd3TFeYpOMEpRXxcNtd/CXx5NA5iNXmdZK6cw7h2PfIr6UnI8e9WL
 U
X-Gm-Gg: ASbGnct9k05PKtaPM/CM09WL32oPIophojAJUXhZdy9jHMqH2WPvN2f5tPm3yWr0EQJ
 tC7VTf3FHIx6Z+aU2ubCD/s7gu8qcCsXdA9SoL6NkVt/w9LViLT6H9TIGwiSr7323A9HiuOHGqF
 HcrB0sfAyuAk81DoWlwxZPMsAT61M53UwdAEplGq6XdIz8ZYtpfFZwfA57x4I060OZHbw0bv/zf
 f12FFpS8GlB3guqfxzjZJUrBkjgr/zh5qvfiCazkFxYuMZGa+6TiZm0fJd0MkSTlDYgOfzgGvZX
 UhmH0e/zMpG4xKbIy5JduHecAA+HZdxgl/A2VG1IHsWac4zf2l0qz/qY6RTmNPOIl1tA2/7hbde
 nRBq99Qm/2BDy6cI=
X-Google-Smtp-Source: AGHT+IFdGFnICaMAp2Be97vJq4ET9ZKFGDOcDtEAMVJ+yBIHUYs5NRFKHk3Qzn2aCGR93xd5QPO1Lw==
X-Received: by 2002:a05:600c:34ce:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-440a66b0803mr22777335e9.32.1745595189857; 
 Fri, 25 Apr 2025 08:33:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca56d5sm2699304f8f.32.2025.04.25.08.33.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 54/58] accel: Implement accel_init_ops_interfaces() for both
 system/user mode
Date: Fri, 25 Apr 2025 17:28:38 +0200
Message-ID: <20250425152843.69638-55-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

We want to build more common code, moving objects from meson's
specific_ss[] set to common_ss[]. Since the CONFIG_USER_ONLY
definitions isn't applied on the common_ss[] set, it is simpler
to add an empty accel_init_ops_interfaces() stub on user emulation,
removing any CONFIG_USER_ONLY use in accel-target.c.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250417165430.58213-5-philmd@linaro.org>
---
 MAINTAINERS                                |  2 +-
 accel/{accel-system.h => accel-internal.h} |  8 ++++----
 accel/accel-system.c                       |  4 ++--
 accel/accel-target.c                       | 10 ++--------
 accel/accel-user.c                         |  6 ++++++
 5 files changed, 15 insertions(+), 15 deletions(-)
 rename accel/{accel-system.h => accel-internal.h} (56%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28b1e9ba443..07711cfd381 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -500,7 +500,7 @@ F: include/qemu/target-info*.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
 F: include/accel/accel-cpu-target.h
-F: accel/accel-*.c
+F: accel/accel-*.?
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
diff --git a/accel/accel-system.h b/accel/accel-internal.h
similarity index 56%
rename from accel/accel-system.h
rename to accel/accel-internal.h
index 2d37c73c97b..03426aa21ee 100644
--- a/accel/accel-system.h
+++ b/accel/accel-internal.h
@@ -1,5 +1,5 @@
 /*
- * QEMU System Emulation accel internal functions
+ * QEMU accel internal functions
  *
  * Copyright 2021 SUSE LLC
  *
@@ -7,9 +7,9 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_SYSTEM_H
-#define ACCEL_SYSTEM_H
+#ifndef ACCEL_INTERNAL_H
+#define ACCEL_INTERNAL_H
 
-void accel_system_init_ops_interfaces(AccelClass *ac);
+void accel_init_ops_interfaces(AccelClass *ac);
 
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 5df49fbe831..a0f562ae9ff 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -29,7 +29,7 @@
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
-#include "accel-system.h"
+#include "accel-internal.h"
 
 int accel_init_machine(AccelState *accel, MachineState *ms)
 {
@@ -63,7 +63,7 @@ void accel_setup_post(MachineState *ms)
 }
 
 /* initialize the arch-independent accel operation interfaces */
-void accel_system_init_ops_interfaces(AccelClass *ac)
+void accel_init_ops_interfaces(AccelClass *ac)
 {
     const char *ac_name;
     char *ops_name;
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 08d4e450bde..7f3bbf31a8b 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -29,10 +29,7 @@
 
 #include "cpu.h"
 #include "accel/accel-cpu-target.h"
-
-#ifndef CONFIG_USER_ONLY
-#include "accel-system.h"
-#endif /* !CONFIG_USER_ONLY */
+#include "accel-internal.h"
 
 static const TypeInfo accel_type = {
     .name = TYPE_ACCEL,
@@ -106,10 +103,7 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
 
 void accel_init_interfaces(AccelClass *ac)
 {
-#ifndef CONFIG_USER_ONLY
-    accel_system_init_ops_interfaces(ac);
-#endif /* !CONFIG_USER_ONLY */
-
+    accel_init_ops_interfaces(ac);
     accel_init_cpu_interfaces(ac);
 }
 
diff --git a/accel/accel-user.c b/accel/accel-user.c
index 22b6a1a1a89..7d192306a65 100644
--- a/accel/accel-user.c
+++ b/accel/accel-user.c
@@ -9,6 +9,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "accel-internal.h"
+
+void accel_init_ops_interfaces(AccelClass *ac)
+{
+    /* nothing */
+}
 
 AccelState *current_accel(void)
 {
-- 
2.47.1


