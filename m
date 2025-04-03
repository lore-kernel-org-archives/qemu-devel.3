Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2936C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKq-0002G4-5I; Thu, 03 Apr 2025 19:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKf-00022V-7p
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKd-0000mI-5z
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso9311075e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724245; x=1744329045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2uao2k1sdjL3VI7mV563IZyOj/L1mksZ9hBUjnLJkk=;
 b=Je9PHBBdCAEYDCzIc8DYowlwhTwJ6+mWiJn46EMlkaKXZTs88Mz3WpJemOdbCd5Z7V
 YyaqW7t2C7UpuZKT0M9GfqoW+xXy4K5dHWcgLtGXW0RKEziDLSp9VTprYOqfg86ADkHx
 gaH3ifWgL1i7aOU6szMIU+X4m4oCKB65zRp/UBJC35o4zrkwnt+uSZWAYdOmAvvkxx+e
 0OsV5we/0sdd8aH/5AzTYAnsVrv/U58GLuLncQLEeeob+SCUP2Fv8rHRCPK4S69VpYcM
 0ZI+SukLvztznm0+Z+lE5Ow0vN1A7bipErEG55H4VJFZOyJh2/HvjqJ/yXnEweYMdLlb
 1p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724245; x=1744329045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2uao2k1sdjL3VI7mV563IZyOj/L1mksZ9hBUjnLJkk=;
 b=BXdS6g4ZUInqCFKKRmbUU3FMtMk/W+rTp66qauQtPV15zHpuHpEEUeRZNZaMGYomNn
 Tf75XE7MqfHIu21UQ5BOdaSYeq3CEVXHuKijoqNXyWfOazChF5iQish0NR+q5Fvt5AbO
 ENHwu++fykVQNE9JyanxU7ZMLlXaczLFv3x2MJMKh4krKGuznST+ndKYqFhNJuDtybQB
 JSMMuv5enVrF+UtjBHDav2ScQ2iyH34zLFMfVLJ3Sw9HahoPsuFxkOPyc8x4gbvc7MnK
 +wju7VTaK3FZz0O80TRLxpWFnd24CaI+dNK4TPEXsLlI0WqGZhFnTuhzDpcqDVzIntTJ
 C1Xg==
X-Gm-Message-State: AOJu0Yygn5K5Nj+0qUQqENvhE3m9BoVysQE9XWqy87QAS8RUgU9omiHp
 wBPiaq16Bp1zsylyTzY6Vf4OQheLsWIgidLpLTDGpYRHTeHVkaFcKwAlzMoCp/9hqUHdPc7ehGl
 b
X-Gm-Gg: ASbGncvndywcYvaio1YZbQo88pReNu5BWZMsEH4d46WJ3ZqCnPc9KEHlIxoRhl032lx
 gmLiaIO4xCTKYQmxU+XuCQeo+c1NzIR0cvnhYauNcf+SGFloqS3vCbBBTTFnOJ/YzJ3B5Wz4Hby
 A45RQ8t6qnn+TGWWuezwqrYR6AycsOKYcCSLbTAQ4LWQLQdLTMs3EiwqAAadNnyJmvG5bXTT+I9
 swUaTo+pil6wuxABZKKqEOkO0qMFbiTp+/K2K4tezox7rcfsC71Vl8gL6S2ttXdWkpwVZ1f6Ejc
 d0pBKqBj48KK3bWiqlcXqxcLYK5gwAP6d1JQTcmZcBwX2LRb7WyNmSwOVVGr5q6VIcihgCiNIr6
 Um32Eug2UF6BAMHBn4oA=
X-Google-Smtp-Source: AGHT+IHK6IPgNBuL5/cUvbP4Jx404h21BJEIDiIxhGxIzsLcoiwaOSdvJD0YgJb/BkH9ZPXjT/dl8Q==
X-Received: by 2002:a5d:584c:0:b0:391:10c5:d1a9 with SMTP id
 ffacd0b85a97d-39cb35a99e3mr787759f8f.31.1743724245150; 
 Thu, 03 Apr 2025 16:50:45 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec3429f67sm31959885e9.7.2025.04.03.16.50.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 14/19] accel: Implement
 accel_init_ops_interfaces() for both system/user mode
Date: Fri,  4 Apr 2025 01:49:09 +0200
Message-ID: <20250403234914.9154-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/{accel-system.h => accel-internal.h} |  8 ++++----
 accel/accel-system.c                       |  4 ++--
 accel/accel-target.c                       | 10 ++--------
 accel/accel-user.c                         |  6 ++++++
 4 files changed, 14 insertions(+), 14 deletions(-)
 rename accel/{accel-system.h => accel-internal.h} (56%)

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
index 9e9e70be876..6fa5c3ef04e 100644
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


