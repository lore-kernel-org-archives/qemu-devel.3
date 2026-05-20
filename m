Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D7DCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkeD-00049T-Sc; Wed, 20 May 2026 13:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeC-000499-2y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeA-0003XE-7K
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:23:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso4643633f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297832; x=1779902632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAL34/RRHyFc4Y9KYQeJGuf0H2THlwX/TfXdoppM+D0=;
 b=y6k2MFeb4bU8d3xYveS6ugtwyQd7zz0N+KV+nVwFiK84WtxjS1ljBMP8uVjSNeIdxc
 QBtJMz/pG0DjLga+IrmPG1SVzxYZ9zQ9XM8e/ILWpIurQ5QZnSDVo6Acr12dzdXTpZmF
 8GhZsLPNh6Sl8OQfLBCXAWZp0Fjk7UyLhH6daSODo3T9dKSSQNwTVf4v49Jp8P8okk51
 XJ0zONwoFB/ydVOgSE3u6apv15DB9xtihqRkBTHr1glwVKONkrmlmYBPtF5O4EIUpu2r
 VpIm7hblTig/MDiEiuc4gxkl5ww6+DDo6lmXdVZlDxPbBWdtBVed35Uuv6PQfB3uWWJy
 p1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297832; x=1779902632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WAL34/RRHyFc4Y9KYQeJGuf0H2THlwX/TfXdoppM+D0=;
 b=MaBpSQhqoDHhU6EGKZQ3KjGWry7JpUh1mupF5oPq+haompXH7Ar7scxdqs0Eo8lDLN
 j5oF3UuPHzLgEenavdhwLoCPjqPuHiHbrmvitEqN7F/y4/DuKH3dlsbx9pL/CngmKiZi
 pFsRAAwGQjA/oFHCw+yKSoviqqFDYF6mVZvXkJrvg3A9C2rlCsr5hTvMwkvmdot1U4Me
 eGZt42kBduJfNLJ6d3qE8HRvBMJAySHD7YoSvbQFblm6uChu+EB79W2Z3oSg935VQ6ec
 deogtXLq54uf3OMB3pSc+8BEDeoKCOedZ618M/KX7JrBnilCsWyW8InG3Irl0HzPl/OJ
 f2hg==
X-Gm-Message-State: AOJu0YwYlel/B1iaG7QxqIPrTIurY7JzIShmfEXDGvxHv+zuwYmwClTl
 ipqA+bLCjh+9D3oY/l1Vg2CAy4I0HxHV7aXMnnLKF9z58PFkuByxfuwlyuGgZ0tRzncSaQqmvFo
 A2Qj0c1s=
X-Gm-Gg: Acq92OGKYuKlGzoOu9XfKmQuBlnZ1itp7dBgwrIGhGJRHzNnLAEn4g2LrXL3v9d4gTA
 4V/Lcp1TMuIYmLlZSXeU4W40fVGBkmo8q6YyJe8EwE9HJK2+UQJUSbDrKODdk9EAMhDJtdf6ugq
 CUMBYKEwo8IvBfN+Xe0FbDABiGB92I0/163Dzcd1O1ABriJxsjY/2VJprN7/mzgLrn6oAhjzvqS
 y5bwc3ZbJLSvaP0KGcDX6uxDfDUtU80qGlpMWDvRut9M0jQ98bVL7oUGX5QwkWiQrLGriBQRN8G
 ZsVDXMfMwMsGFiy8hmLM1fmTopjFy35yERw7f0Bz674TKTyWQ8sbZgijNNANYdb7TwIWx92Ozz1
 S75s+A4G+nWXsTJeH+EsREK53Q1Km7Xtr1VucjVW66bqcvmk2wX2AmY3+qmqNbVnGg4ERFFdFPa
 7xPrDtLZMCPAcmmKQGwqxycUH7hpgdIUrUhE2zNRmaw6XvNGgMppFA6jIp521gv0SKAAl2eG2A
X-Received: by 2002:a05:6000:2485:b0:43f:dfb6:78e1 with SMTP id
 ffacd0b85a97d-45e5c3629femr40835901f8f.8.1779297832218; 
 Wed, 20 May 2026 10:23:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13b4sm55964638f8f.28.2026.05.20.10.23.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 05/24] tests/tcg/mips: add Octeon instruction smoke test
Date: Wed, 20 May 2026 19:22:53 +0200
Message-ID: <20260520172313.23777-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


