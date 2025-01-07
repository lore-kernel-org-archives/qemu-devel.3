Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EF3E77199
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XB-0000Kz-H1; Tue, 07 Jan 2025 03:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Ww-0000HZ-Cs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:39 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wu-0002w7-2j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:37 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2161eb95317so228132205ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236895; x=1736841695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYwpPjUswasVxQ+478Fd9keUw6A/plWLqaOi+0i6wO0=;
 b=KR8xzjpawdrLTrBuriXYhu35Mb3ufQGADtlALovF1MoCzEdxCPdjOcehrXQGCJvCWm
 zIhWztt516QR7zXR30OA5x9Hi7rdnN1FiA0+nOFVd3qr84pxdBl/N7LZLFydj6FJZ6tB
 kdnDA0Du/VXgH9DKeRL/SH0DheqeggAp4EWMXTVqGzkSv7dZdTIxHZBOxwHOY/dFlaP6
 JqVRgcwn02rZWwIUo+ZWA6oDTE40/FPRYd+WyZKIOYjdhf5XGAd/GXhdXN26s0ptbN8O
 Wv2i7is9h6E3PmRgHBDMT6OkSM4QcFzalYfhfh4wvQNjyqRrm+ORA8G+VDlA9zeCL+Ow
 wcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236895; x=1736841695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYwpPjUswasVxQ+478Fd9keUw6A/plWLqaOi+0i6wO0=;
 b=sZA/B6f5ewS5TNGQLZ6hQjd+KktIae3dGBmWoaQoMIHp73HfS/UEZbWj+uqDPxj3c0
 TXv4jn18ER677RBTCLIiPbI82mnqeIos/aglNw1pbCbloXLvJA2ahghQ5QkP4TUNADGz
 DHtCmxJj6ck838rtAD2acd5RexAp8xH/jJfuPur1ZGeFYP0EfeW6i40Pqlym7wjhinyb
 qIObsw3V6iO6byncuszWd5BmPJqFNZgU2yAW/RV+fuBsllKusrU+Hu+6nElDEHB+W2A9
 gUh8l5jWv3rU6hP/XGca6JmlVu6rU8DA1hXe7m9E1NQw6SsIlHq/GsXzQLXUVBr1vY6m
 BjLA==
X-Gm-Message-State: AOJu0YxJfsy/0b3c/FM+4bzvCJxEDp8wDcVOLVl7A2tHDW9LEEptaBy3
 sDWDazIDi8ReHVfxhufmnoUHfP/kNcfF8Xnhep0PMmuDLS/nZDCpJyHc+4GauFaKsWPs22jnQZS
 o
X-Gm-Gg: ASbGncvKsWzHZUpPshfW9BdaUqkDBSFtobqNJWaUFYn4PIr5d6dEtYibfjaopagyJiT
 24GTaBlmuGzZN4cQ0l/fwNksGTvo/8XAwmMxxyWeVXvXLJ7/lZFtkiXbGEn8LIJdtNUeDRGcbCM
 DcfPXdwaKvMvhVW2X8n8alri9OEr2u6H2XQw3DSqHU+Aq/dhb9bko8nv6kwdMHsFOvUUrPBGziq
 b+sxTay+dzccBe2c/vqGzheKPw6rzNVw824V2wwkBlSZNF1kL0IGZShCUTlCMiz6ZCagZjENgRP
 DsBhH7alxyZb/DMUtg==
X-Google-Smtp-Source: AGHT+IH+5Fuioh0hHVzwGZ511QnwEv+jb1dsuYh8uRoPuEaV8VYSUkpaxNI/3/5eYPXIRQts6u2e2A==
X-Received: by 2002:a17:902:f652:b0:216:28c4:61c6 with SMTP id
 d9443c01a7336-219e6ebcab2mr885886725ad.34.1736236894591; 
 Tue, 07 Jan 2025 00:01:34 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 19/81] tcg: Split out tcg-target-mo.h
Date: Tue,  7 Jan 2025 00:00:10 -0800
Message-ID: <20250107080112.1175095-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


