Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654C5CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf2J-0004th-Ni; Wed, 20 May 2026 07:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf26-0004GA-KX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:24:14 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf24-00033r-Dm
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:24:14 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5a8891f0c51so5235048e87.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276250; x=1779881050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAgABb3WbZBwd41kZWx+VPPlojVWLT9Z5g89nEPZKWo=;
 b=ikAiShawsHbUxTx4hK0p6sCGGcFHMBo8xgi5bupr0FvPKkJHhzbhSSmjm2zq5Qbsqk
 WfJHHipJg9u8e0yVPLVqZoGIkIh5Br7MmLr/rbiZBXNHXHX4PnpN92HgCE8L7q8goUU/
 FYi25KQWaffBlePD/2gvGk4hQ+mdsWLHw4N6+adcJnZUwIBHWD1d5HdvMdA5xcxCG1LJ
 hO+ZLqdbg1VpJJFoD/n8wBSqRzU7JKWsG7YeTyYQN35bl1/i6PvYR50/vEEpRMZOydll
 KNKsQ2bxsaynOjLBT50fMSDPNqkIsXnP5NCH0IQyD3Jq8Sk1ImWZxaQB2j3/KFLf6VZj
 SePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276250; x=1779881050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CAgABb3WbZBwd41kZWx+VPPlojVWLT9Z5g89nEPZKWo=;
 b=HV1OPqGPWQD9HSek8z9AQ+dY563Ix0VHgDkrciBzaDrRTRSePRNNtzPqH441JbtG8z
 cuCpInRdsm8tabt2NHdeZ/Xi/Bsh1P9tKIrfzDLtu43/Y1HW475EujD/WiaFmBUvX6wx
 +XbgzRbNp0GagcpKbLAquaBpVGYd5p8lf2zbbGsuOsSI/e3APXGhZqPclKawr03zNFVu
 Cj+Hrgo6JYndRVINpIWMjbWDWEYxoDJQGygHZdmAoBW4UJ+0bL17qZi66g0TkS4TpkUd
 YVu9QwqT1kCzoD/XB0ppOR5P5kSleeQTeIWa9VOcccfRURyjKzobhOivRs+PZ1wrVUal
 IQPA==
X-Gm-Message-State: AOJu0YzdMlxH6+7OkpK2mRxvf652hGrDkbiSPq+CvSDzkVzqf6sVe4tU
 FV6vq+txTmUb8hDX3+0iVPNfc1MAAtMg8GHPLY5uoSBp9p0BlKIx7HPl5BBlw2FMB8/k1qi3RRY
 BhEmamrQ=
X-Gm-Gg: Acq92OGAqm2FZGzZsJGiUypfFdP0eO4GVg+5XNhrAQx4p1wfHy4jDRxpVBl/hHYI2GX
 /pBl3Wk+XrDXAWG+zzVPhwv4e5CgDWc9b9t3B5DL1p0v1Lmd/hJ+S7wIfoJ6bfUeIQ3v9asb7aT
 rGc33B/BYOIcZrzVuav/wiA3p/SZDLrA9uqTGscEUKKEN+jbRKnfdzbI500cnuZ9Yy9k5c6rypj
 ex5UsWajzA4AINg0R9OYpMFqC9PQwsyt6xssFzf+WMyflAD9J1dLXvLXe3lLkcDDe6kTHfddwMm
 lYXJz4u0XbaMVD91qghppG3B+VN6JLRA5N0Ku8vuaSUNffuC84VFCu/U6anvhGbAOprn5Lz1Bz0
 wooW6qrQd1lLB64j23Hqpmv8VukQOh2xB+xYS66FrdoxQEk/P9hKjT2esLPTG/+3TZ08ww1Aobp
 7pE5qySgT5dofmNTiNCorroQyj3YwbejGR2ftvLN39/L8PwGnkWpxLJPb5ERQQ1OOp3KvLWXPVh
 o4kPvg52Hmj69uO
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id
 5b1f17b1804b1-48fe60ecb9cmr340776045e9.10.1779272327943; 
 Wed, 20 May 2026 03:18:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm380066565e9.4.2026.05.20.03.18.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:18:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 05/24] tests/tcg/mips: add Octeon instruction smoke test
Date: Wed, 20 May 2026 12:17:46 +0200
Message-ID: <20260520101807.9971-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon instruction paths.

Run the test with -cpu Octeon68XX and share the source between the
mips64 and mips64el target directories.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |  2 +-
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 13 ++++++++++++
 tests/tcg/mips64/Makefile.target              | 20 +++++++++++++++++++
 tests/tcg/mips64el/Makefile.target            |  8 ++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/mips/user/isa/octeon/octeon-insns.c
 create mode 100644 tests/tcg/mips64/Makefile.target
 create mode 100644 tests/tcg/mips64el/Makefile.target

diff --git a/MAINTAINERS b/MAINTAINERS
index b75f3222f2f..d9e3ab03cb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -310,7 +310,7 @@ S: Odd Fixes
 F: target/mips/
 F: disas/*mips.c
 F: docs/system/cpu-models-mips.rst.inc
-F: tests/tcg/mips/
+F: tests/tcg/mips*/
 
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
new file mode 100644
index 00000000000..aef23fb9465
--- /dev/null
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -0,0 +1,13 @@
+/*
+ * Test Octeon-specific user-mode instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 00000000000..042855844a8
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,20 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
+
+# Set search path for all sources
+VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+$(MIPS64_TESTS): CFLAGS+=-mabi=64
+
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 00000000000..dbc5f8dc5fe
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 little-endian - included from tests/tcg/Makefile.target
+#
+
+include $(SRC_PATH)/tests/tcg/mips64/Makefile.target
-- 
2.53.0


