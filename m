Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C84FE7718B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 16:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTNhl-0001Tp-A0; Thu, 02 Jan 2025 11:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTNhH-0001PW-0H
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:05:21 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTNhE-0007hn-B5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:05:18 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283dedso114649015e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735833913; x=1736438713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PiUug7+4DxBb4pdRj/4Nl+w548jCnQIvB94kNaUutoY=;
 b=cB0rOEHOy4BK9f7qkfvXSVFWpGYaOGjilWBYx6iOcucn1ZQbTOSJvYglaItvtJ6rLJ
 pHWVfcTzSQV7RsPsV7hcXpnWpLmAbpHicIwnE/irJmCS5YznVeC6OwHEI+I0tiEm5YdC
 PqmxQv35Y29zLMOVaPqD0Aqzd2H6oOCfIA+kivFZ34wtk6y8+8mUTTSydNrydvyLJHAw
 n5Z6XLDA7fNgaQDyoqZj7uAU/DQUL7ANmZ5WylWM97gOrloIgcAUwPZjje9jtPBWI7mL
 cJWE2EecH0SPAtNwyqvVUwufSWLsQ5oWpxuLr1aco2tDusOsPJKoOOyefM1NjBjNZAZz
 05Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735833913; x=1736438713;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PiUug7+4DxBb4pdRj/4Nl+w548jCnQIvB94kNaUutoY=;
 b=Y5misR/ug/1FSfSwNqN9jBLV/47p0DgIEs/3bl3P6KRGJDWsr2H6SpWQVcH2koswZ2
 DMZHyXjkWMBvqNUoy8CDkOGiMMsxSIaVKTFeAOaVL7X5SLosRMWyxozpAFXrFOomSJCn
 IOhZhEpELBRhWfLSw4dfCsRP17/VisFa87ss9O8RJUZEY+Z1oAuNMdAJC6LvoC2vlY9P
 pAOOecydHPDrrktH9cXXeONvzb27jo0jzXT3V3RePVwWsgoe80PKRBzVpRGNvINwy11I
 vgzQUplgOfrQckkZAXHlL5rI9MThhSBF2zdVa8AqW0S4huQHgFSCKoli1JkXaV+xPaL0
 MURw==
X-Gm-Message-State: AOJu0Yw3vPfwE2WwuUzwb3RtN97k5AlcmLU8UOuLUUZ4r6odQXSbZq/M
 qq4+qUv6QkU3eBpdw11jE3uzrhSj8YT8xRqssBQ9RHVXFXSEP/lVW+ls5On6bae1YEG8QBKhP/+
 QmkPFLQ==
X-Gm-Gg: ASbGncsixmY9jDnX3XWv65unQZqk1clRlaZVauO6ol9dPSx9Dn/NxZ8wnEampbgezHn
 gcCr7gKyjR89+l+0uWm++sDxCjYoNLAG3G2Y/i+tkyJ3wJwpHceCGF06c4uAGRjlKUTERwdlwLB
 Z6+GM8xXgYtVGJFvrube+ymyWI3n+23LvQ+5TdqIqvFJ4NJZjjrLhiDNFYxhxoBFj/1D8VWYpEM
 yuJUnuu63FrMKraBIY79zKfpmg2bFva/FWECPEEvbUVww3/Qs+yHD/itNzxpf/BDc1CsgK0+g+9
 ZifkTDhfQ5sSAQhiV13q6tyQDQWFOCE=
X-Google-Smtp-Source: AGHT+IEDrpBjhuHk7vjn+GbtnxTgRx3zhNgCzxzKnUjWtLS57lurCPZsIhhQShgu6pTmTIFYRAN0SQ==
X-Received: by 2002:a5d:64cf:0:b0:382:3c7b:9ae with SMTP id
 ffacd0b85a97d-38a221f6746mr41758718f8f.16.1735833912737; 
 Thu, 02 Jan 2025 08:05:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364b053e91sm518395495e9.1.2025.01.02.08.05.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 08:05:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Cleber Rosa <crosa@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, mzamazal@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] licenses: Remove SPDX tags not being license identifier for
 Linaro
Date: Thu,  2 Jan 2025 17:05:10 +0100
Message-ID: <20250102160510.61894-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Per [*]:

  "we're only interested in adopting SPDX for recording the
  licensing info, [not] any other SPDX metadata."

Replace the 'SPDX-FileCopyrightText' and 'SPDX-FileContributor'
tags added by Linaro by 'Copyright (c)' and 'Authors' words
respectively.

[*] https://lore.kernel.org/qemu-devel/20241007154548.1144961-4-berrange@redhat.com/

Inspired-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/vcpu-state.h                           | 9 +++++++--
 include/hw/misc/ivshmem-flat.h                   | 5 +++--
 hw/misc/ivshmem-flat.c                           | 5 +++--
 target/m68k/semihosting-stub.c                   | 7 +++++--
 target/mips/tcg/system/semihosting-stub.c        | 5 +++--
 tests/qtest/libqos/virtio-scmi.c                 | 2 +-
 scripts/qom-cast-macro-clean-cocci-gen.py        | 7 +++++--
 tests/functional/test_aarch64_sbsaref.py         | 8 +++++---
 tests/functional/test_aarch64_sbsaref_alpine.py  | 8 +++++---
 tests/functional/test_aarch64_sbsaref_freebsd.py | 8 +++++---
 10 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index e407d914dfd..2e3464b5eef 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -1,6 +1,11 @@
 /*
- * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
- * SPDX-FileCopyrightText: 2023 Linaro Ltd.
+ * TaskState helpers for QEMU
+ *
+ * Copyright (c) 2023 Linaro Ltd.
+ *
+ * Authors:
+ *   Philippe Mathieu-Daudé
+ *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef ACCEL_TCG_VCPU_STATE_H
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index 97ca0ddce61..0c2b0157812 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -1,9 +1,10 @@
 /*
  * Inter-VM Shared Memory Flat Device
  *
- * SPDX-FileCopyrightText: 2023 Linaro Ltd.
- * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
  * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2023 Linaro Ltd.
+ * Authors:
+ *   Gustavo Romero
  *
  */
 
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 33fc9425d20..40309a8ff38 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -1,9 +1,10 @@
 /*
  * Inter-VM Shared Memory Flat Device
  *
- * SPDX-FileCopyrightText: 2023 Linaro Ltd.
- * SPDX-FileContributor: Gustavo Romero <gustavo.romero@linaro.org>
  * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2023 Linaro Ltd.
+ * Authors:
+ *   Gustavo Romero
  *
  */
 
diff --git a/target/m68k/semihosting-stub.c b/target/m68k/semihosting-stub.c
index d6a5965e29c..dbe669cc5f6 100644
--- a/target/m68k/semihosting-stub.c
+++ b/target/m68k/semihosting-stub.c
@@ -1,8 +1,11 @@
 /*
  *  m68k/ColdFire semihosting stub
  *
- * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
- * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors:
+ *   Philippe Mathieu-Daudé
+ *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
diff --git a/target/mips/tcg/system/semihosting-stub.c b/target/mips/tcg/system/semihosting-stub.c
index 7ae27d746f8..bb1f7aae624 100644
--- a/target/mips/tcg/system/semihosting-stub.c
+++ b/target/mips/tcg/system/semihosting-stub.c
@@ -1,9 +1,10 @@
 /*
  *  MIPS semihosting stub
  *
- * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
- * SPDX-FileCopyrightText: 2024 Linaro Ltd.
  * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2024 Linaro Ltd.
+ * Authors:
+ *   Philippe Mathieu-Daudé
  */
 
 #include "qemu/osdep.h"
diff --git a/tests/qtest/libqos/virtio-scmi.c b/tests/qtest/libqos/virtio-scmi.c
index ce8f4d5c06e..6b5bd4db42f 100644
--- a/tests/qtest/libqos/virtio-scmi.c
+++ b/tests/qtest/libqos/virtio-scmi.c
@@ -1,7 +1,7 @@
 /*
  * virtio-scmi nodes for testing
  *
- * SPDX-FileCopyrightText: Linaro Ltd
+ * Copyright (c) Linaro Ltd.
  * SPDX-FileCopyrightText: Red Hat, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
diff --git a/scripts/qom-cast-macro-clean-cocci-gen.py b/scripts/qom-cast-macro-clean-cocci-gen.py
index 2fa8438a146..5aa51d0c18e 100644
--- a/scripts/qom-cast-macro-clean-cocci-gen.py
+++ b/scripts/qom-cast-macro-clean-cocci-gen.py
@@ -13,8 +13,11 @@
 #           --in-place \
 #           --dir .
 #
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileCopyrightText: 2023 Linaro Ltd.
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import re
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/test_aarch64_sbsaref.py
index 99cfb6f29a4..e6a55aecfac 100755
--- a/tests/functional/test_aarch64_sbsaref.py
+++ b/tests/functional/test_aarch64_sbsaref.py
@@ -2,9 +2,11 @@
 #
 # Functional test that boots a kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+# Copyright (c) 2023-2024 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#   Marcin Juszkiewicz
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/test_aarch64_sbsaref_alpine.py
index 6dbc90f30ee..9faf066d183 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/test_aarch64_sbsaref_alpine.py
@@ -2,9 +2,11 @@
 #
 # Functional test that boots a kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+# Copyright (c) 2023-2024 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#   Marcin Juszkiewicz
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/test_aarch64_sbsaref_freebsd.py
index 77ba2ba1daf..8dcb4991c31 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/test_aarch64_sbsaref_freebsd.py
@@ -2,9 +2,11 @@
 #
 # Functional test that boots a kernel and checks the console
 #
-# SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
-# SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
-# SPDX-FileContributor: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
+# Copyright (c) 2023-2024 Linaro Ltd.
+#
+# Authors:
+#   Philippe Mathieu-Daudé
+#   Marcin Juszkiewicz
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-- 
2.47.1


