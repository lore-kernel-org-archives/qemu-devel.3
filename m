Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF31E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbp-0007YO-7w; Thu, 02 Jan 2025 13:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbJ-0006yj-Nj
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbE-00059I-NT
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:16 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so166193685ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841231; x=1736446031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5fgY/wpf89uxcs3c2w7+nA29sSBt8VZYq6xlodEGkMM=;
 b=RilWJ5NAoeZffCzcNM2g8S8TDWOAwY33ypKj8NwF2USu2Zv3b6Rv7n9C70tnh3Zzzv
 Tfi551cfbgkQ/9tC6+hgk6QPiXjTgBGS46LU7hV29bf7tDb7sOQqrdWmSF3xu6GpZ7Bj
 mx4Oa7Gtu96RgSwJPdSlV/R/x2NCIgDTqPUQDEg9iGQ0+d7qvQAmzHZ8fsi65hy4BLLV
 ojG9bAvSsEauk7CgZxI0z48yHQYba2dybTs7LhsBKNtFGJatNtlPm7Mns7ChkJ/V8Fg7
 yPh9q5gzC6sPnlC+dQhxRK57mCK9LRnE8u+VsKS2MzOWZZ5gxCgy0APIJb/ldNRjGKgo
 q2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841231; x=1736446031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fgY/wpf89uxcs3c2w7+nA29sSBt8VZYq6xlodEGkMM=;
 b=wwClWIaHgOyW7is5eg223iz+9/nhx4iesD6XGsxRSqDzc8skK2W0KxAWe76QIB99MK
 NCZT2VRttv2WH0j0eUK84O+/MEp1KXnoV1SPfeCtwj7Fgk6EemuJmuDIklKwSUVYuCAK
 8DH9qhiOcpY+L2sNkcfM1CNEh8RuwoC4zPj7uehvT7YZlNuvXh0CDypNyyxUdg626fL5
 CNHG/93t/C0Z2rwU0GxJ3V0TPkEV/AHYNqYmqvIB3xDhh0f+Fn/c2L/hUe6lZ6xphUav
 DYiVJLk6w/AkJ7tO/nft0Xp6F8etM7mE6GcpYPQgqVqb2R/uuhBx3M0sHSaowAmOVXL6
 r/GA==
X-Gm-Message-State: AOJu0Yy/JjrWx6XbgETh9rnIGU5b/rLJVP3IWLlWqihc3+av8tQOC+Ke
 6o9TjmudEnHMTR++Qv+k5KcEY7nEewIKv4a0Olak5zCzYPo9wud6uG/uox3TowHIlu5XE83uAHL
 x
X-Gm-Gg: ASbGncv+wXHz5+fJkkabDewAO0Llpj5o5Q1tjHxhwfrIL6Ovhu7vWlj16h32rnprJAM
 9bpfFivXJXZlNAdC9USVWFqOkQMAJzvmx/46BgZbOH0Rub2oZG1RdxO+BczP+3Rr8+idxM711G2
 0iOE83UGZdV/S2jAAYKnKSTE0LY7VKoX17psJSNwiFVEzUHlvz3hUSIiw+vClZSkj5586KuYhEN
 AjCVfx8jEGcWjPCF/Y5hkh5wVt6yFv8WBfu/ro1BvnPlMQwxY11ho6ymwfLfw==
X-Google-Smtp-Source: AGHT+IGin3D67myQ6xnT6zLzMJPz2bdPuQvtYlDe900/7WCI+G2HlA+6hLsSMKJsbbw1KGOXzLkZfA==
X-Received: by 2002:a05:6a20:3d89:b0:1e1:ad7:3282 with SMTP id
 adf61e73a8af0-1e5e1e26e2emr69198389637.7.1735841231250; 
 Thu, 02 Jan 2025 10:07:11 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/73] tcg: Split out tcg-target-mo.h
Date: Thu,  2 Jan 2025 10:06:00 -0800
Message-ID: <20250102180654.1420056-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 accel/tcg/internal-target.h     |  1 +
 tcg/aarch64/tcg-target-mo.h     | 12 ++++++++++++
 tcg/aarch64/tcg-target.h        |  2 --
 tcg/arm/tcg-target-mo.h         | 13 +++++++++++++
 tcg/arm/tcg-target.h            |  2 --
 tcg/i386/tcg-target-mo.h        | 19 +++++++++++++++++++
 tcg/i386/tcg-target.h           | 11 -----------
 tcg/loongarch64/tcg-target-mo.h | 12 ++++++++++++
 tcg/loongarch64/tcg-target.h    |  2 --
 tcg/mips/tcg-target-mo.h        | 13 +++++++++++++
 tcg/mips/tcg-target.h           |  2 --
 tcg/ppc/tcg-target-mo.h         | 12 ++++++++++++
 tcg/ppc/tcg-target.h            |  2 --
 tcg/riscv/tcg-target-mo.h       | 12 ++++++++++++
 tcg/riscv/tcg-target.h          |  2 --
 tcg/s390x/tcg-target-mo.h       | 12 ++++++++++++
 tcg/s390x/tcg-target.h          |  2 --
 tcg/sparc64/tcg-target-mo.h     | 12 ++++++++++++
 tcg/sparc64/tcg-target.h        |  2 --
 tcg/tci/tcg-target-mo.h         | 17 +++++++++++++++++
 tcg/tci/tcg-target.h            |  5 -----
 tcg/tcg-op-ldst.c               |  1 +
 22 files changed, 136 insertions(+), 32 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-mo.h
 create mode 100644 tcg/arm/tcg-target-mo.h
 create mode 100644 tcg/i386/tcg-target-mo.h
 create mode 100644 tcg/loongarch64/tcg-target-mo.h
 create mode 100644 tcg/mips/tcg-target-mo.h
 create mode 100644 tcg/ppc/tcg-target-mo.h
 create mode 100644 tcg/riscv/tcg-target-mo.h
 create mode 100644 tcg/s390x/tcg-target-mo.h
 create mode 100644 tcg/sparc64/tcg-target-mo.h
 create mode 100644 tcg/tci/tcg-target-mo.h

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index a664be02cc..2cdf11c905 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -12,6 +12,7 @@
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
+#include "tcg-target-mo.h"
 
 /*
  * Access to the various translations structures need to be serialised
diff --git a/tcg/aarch64/tcg-target-mo.h b/tcg/aarch64/tcg-target-mo.h
new file mode 100644
index 0000000000..e8e8923014
--- /dev/null
+++ b/tcg/aarch64/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2013 Huawei Technologies Duesseldorf GmbH
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 1ef8b2e300..0dd6e1f069 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -47,6 +47,4 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 64
 
-#define TCG_TARGET_DEFAULT_MO (0)
-
 #endif /* AARCH64_TCG_TARGET_H */
diff --git a/tcg/arm/tcg-target-mo.h b/tcg/arm/tcg-target-mo.h
new file mode 100644
index 0000000000..12542dfd1c
--- /dev/null
+++ b/tcg/arm/tcg-target-mo.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2008 Fabrice Bellard
+ * Copyright (c) 2008 Andrzej Zaborowski
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 21563e00f9..4f9f877121 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -70,6 +70,4 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 32
 
-#define TCG_TARGET_DEFAULT_MO (0)
-
 #endif
diff --git a/tcg/i386/tcg-target-mo.h b/tcg/i386/tcg-target-mo.h
new file mode 100644
index 0000000000..7567dc7248
--- /dev/null
+++ b/tcg/i386/tcg-target-mo.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+/*
+ * This defines the natural memory order supported by this architecture
+ * before guarantees made by various barrier instructions.
+ *
+ * The x86 has a pretty strong memory ordering which only really
+ * allows for some stores to be re-ordered after loads.
+ */
+#define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
+#endif
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index e6d7fd526e..3cbdfbca52 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -88,15 +88,4 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
-/* This defines the natural memory order supported by this
- * architecture before guarantees made by various barrier
- * instructions.
- *
- * The x86 has a pretty strong memory ordering which only really
- * allows for some stores to be re-ordered after loads.
- */
-#include "tcg/tcg-mo.h"
-
-#define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/tcg/loongarch64/tcg-target-mo.h b/tcg/loongarch64/tcg-target-mo.h
new file mode 100644
index 0000000000..d35506957f
--- /dev/null
+++ b/tcg/loongarch64/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2021 WANG Xuerui <git@xen0n.name>
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 0432a4ebbd..8533284631 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -85,6 +85,4 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
-#define TCG_TARGET_DEFAULT_MO (0)
-
 #endif /* LOONGARCH_TCG_TARGET_H */
diff --git a/tcg/mips/tcg-target-mo.h b/tcg/mips/tcg-target-mo.h
new file mode 100644
index 0000000000..50cefc222d
--- /dev/null
+++ b/tcg/mips/tcg-target-mo.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2008-2009 Arnaud Patard <arnaud.patard@rtp-net.org>
+ * Copyright (c) 2009 Aurelien Jarno <aurelien@aurel32.net>
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 210044ca12..3090acc4f5 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -70,6 +70,4 @@ typedef enum {
     TCG_AREG0 = TCG_REG_S8,
 } TCGReg;
 
-#define TCG_TARGET_DEFAULT_MO           0
-
 #endif
diff --git a/tcg/ppc/tcg-target-mo.h b/tcg/ppc/tcg-target-mo.h
new file mode 100644
index 0000000000..98bfe03b7a
--- /dev/null
+++ b/tcg/ppc/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 0bc13d7363..5607634e99 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -53,6 +53,4 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-#define TCG_TARGET_DEFAULT_MO (0)
-
 #endif
diff --git a/tcg/riscv/tcg-target-mo.h b/tcg/riscv/tcg-target-mo.h
new file mode 100644
index 0000000000..691b5d0da8
--- /dev/null
+++ b/tcg/riscv/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2018 SiFive, Inc
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 4c40662402..db5f3d8b72 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -57,6 +57,4 @@ typedef enum {
     TCG_REG_TMP2       = TCG_REG_T4,
 } TCGReg;
 
-#define TCG_TARGET_DEFAULT_MO (0)
-
 #endif
diff --git a/tcg/s390x/tcg-target-mo.h b/tcg/s390x/tcg-target-mo.h
new file mode 100644
index 0000000000..962295ed51
--- /dev/null
+++ b/tcg/s390x/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2009 Ulrich Hecht <uli@suse.de>
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
+#endif
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index f790b77075..0ef5a6d3dd 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -51,6 +51,4 @@ typedef enum TCGReg {
 
 #define TCG_TARGET_NB_REGS 64
 
-#define TCG_TARGET_DEFAULT_MO (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/tcg/sparc64/tcg-target-mo.h b/tcg/sparc64/tcg-target-mo.h
new file mode 100644
index 0000000000..98bfe03b7a
--- /dev/null
+++ b/tcg/sparc64/tcg-target-mo.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 5ecca5586b..f7d75d5806 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -66,6 +66,4 @@ typedef enum {
 
 #define TCG_AREG0 TCG_REG_I0
 
-#define TCG_TARGET_DEFAULT_MO (0)
-
 #endif
diff --git a/tcg/tci/tcg-target-mo.h b/tcg/tci/tcg-target-mo.h
new file mode 100644
index 0000000000..779872e39a
--- /dev/null
+++ b/tcg/tci/tcg-target-mo.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+/*
+ * We could notice __i386__ or __s390x__ and reduce the barriers depending
+ * on the host.  But if you want performance, you use the normal backend.
+ * We prefer consistency across hosts on this.
+ */
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index fea92f7848..a9ca493d20 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -74,9 +74,4 @@ typedef enum {
 #define HAVE_TCG_QEMU_TB_EXEC
 #define TCG_TARGET_NEED_POOL_LABELS
 
-/* We could notice __i386__ or __s390x__ and reduce the barriers depending
-   on the host.  But if you want performance, you use the normal backend.
-   We prefer consistency across hosts on this.  */
-#define TCG_TARGET_DEFAULT_MO  (0)
-
 #endif /* TCG_TARGET_H */
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index ec3ef4dcb4..77271e0193 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -31,6 +31,7 @@
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
 #include "tcg-has.h"
+#include "tcg-target-mo.h"
 
 static void check_max_alignment(unsigned a_bits)
 {
-- 
2.43.0


