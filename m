Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F7E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfi5-00015V-Eu; Fri, 20 Dec 2024 11:18:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfha-0008Le-8k
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfhX-00087L-MQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:18:10 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43626213fffso20164715e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711486; x=1735316286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5h+2t6tRak+PoPHVTpLkq7YrZqUBOmTApFHKynbqjo=;
 b=R2PdHlAVvSBnX5SlKKCIevHCo/k2ma0BNjGGkl1DK/FjIgH/2D7ApJXW6UmTiALyaN
 NmQNYRAShld0HOhLFOUrZQEA0mx7zTy7fO+pe3FKoD5BFJiN2WvtX/DrS0C+PcSAS4uO
 I+/eli7qbiFanX1Flxa4YvrMiV8lpNbNM2EUSEy2W7L5CZO3hEXA5ngDy9sJmIXsF2Z8
 sD4tmpm0VJUrYqh1IWwfxlXSK7HeuDF1BsoXeSIguhNyMrk9sxk5FLJSTS7l/NaTvjzN
 EUPWFGxUjNZk6TkA3abLvNm0a6w3JDVZUUQGkXtvJtE1e9pVVCrEL2rZzK31VOmRoYct
 uvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711486; x=1735316286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5h+2t6tRak+PoPHVTpLkq7YrZqUBOmTApFHKynbqjo=;
 b=gg4tLbmcd5VWyGS/O57rlWpsZOtmQ7TckexkgKB6Vd72I7xwOwmp1s/3nIVBcKA9kg
 6d8oYXxY+rhMhUtkXHdf5U+mvTqTKj945MpQ6mkntsDyxN+BhngZtFjtUnTMswC3GdmY
 W8ZG1oPs4ASLl6r4c3ztIY4ln1wmcw0fuy/HGoNP3WS0XtqvOBFjW+Y7KnJShPnBM7WS
 YBNMgmBCfK+f0zJaEWusew6KCTtljC9SAZkTcptmT4dYe20etNxywlhVtz0foo9QSohl
 nTmmGqNveSarpdqiSUP+4tcmXYeLPFh1oRkUrdBCUQT7Fppc8ZjtEpd6LIo0ul1pMJKv
 jVEQ==
X-Gm-Message-State: AOJu0Yx4QNDNZaro0WsH0Btzmu2KTrhvTGIxNMhefcw03Ng/47xmPso3
 sJeXt+5WfNWvuzBVvX6ojt5gasVZGuqtwDjDBybc13QsTbohi7hE0YieeYIKLgLkLn/eR8ES9eL
 V
X-Gm-Gg: ASbGncuSv5ZSmvobUkS8x0RX80ECj0S/bLKvpmHQM0+A9csvfXiMaBEuVu1H4Q9CJi6
 eDJk2kHf/7KDtyexgLBwzB8BpMwlOOWdN3NqF319TnCe3dLaG7PyGWv8Fdr52T64P8jGq/Zs0sA
 n5r3SSAP6hpjYX0qkEi9fLdHw9TIndO8s3cmThuNFNiSIiht3gfncEfHj/Ao/kBB2I59QBTYmVp
 rOSCUmwB64CH2bnecONOUQyBs6CqiQhBHfIviN+E4PfqrKdUsolXpS9dnPR1C3lYA8pEHbSh0E=
X-Google-Smtp-Source: AGHT+IHy3ktCARuwJ8UN0/ryRBhRGpAzY3ej2EbBi2AvMWOOhQc2hEVasCz1bDsa9KEW0pnabQStjQ==
X-Received: by 2002:a05:600c:4f89:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-4365fc09731mr63430275e9.16.1734711485931; 
 Fri, 20 Dec 2024 08:18:05 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm4474187f8f.77.2024.12.20.08.18.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:18:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/59] accel/tcg: Move 'exec/translate-all.h' -> 'tb-internal.h'
Date: Fri, 20 Dec 2024 17:15:20 +0100
Message-ID: <20241220161551.89317-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
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

"exec/translate-all.h" is only useful to TCG accelerator,
so move it to accel/tcg/, after renaming it 'tb-internal.h'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-9-philmd@linaro.org>
---
 accel/tcg/internal-target.h  |  2 +-
 accel/tcg/tb-internal.h      | 14 ++++++++++++++
 include/exec/translate-all.h | 28 ----------------------------
 accel/tcg/cputlb.c           |  2 +-
 accel/tcg/tb-maint.c         |  2 +-
 accel/tcg/translate-all.c    |  2 +-
 accel/tcg/user-exec.c        |  1 +
 accel/tcg/watchpoint.c       |  2 +-
 8 files changed, 20 insertions(+), 33 deletions(-)
 create mode 100644 accel/tcg/tb-internal.h
 delete mode 100644 include/exec/translate-all.h

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index a03c05315a4..6f4ec0bd424 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -10,7 +10,7 @@
 #define ACCEL_TCG_INTERNAL_TARGET_H
 
 #include "exec/exec-all.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 
 /*
  * Access to the various translations structures need to be serialised
diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
new file mode 100644
index 00000000000..8313f90fd71
--- /dev/null
+++ b/accel/tcg/tb-internal.h
@@ -0,0 +1,14 @@
+/*
+ * TranslationBlock internal declarations (target specific)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
+#define ACCEL_TCG_TB_INTERNAL_TARGET_H
+
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
+
+#endif
diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
deleted file mode 100644
index 039668ff8ac..00000000000
--- a/include/exec/translate-all.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  Translated block handling
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef TRANSLATE_ALL_H
-#define TRANSLATE_ALL_H
-
-#include "exec/exec-all.h"
-
-
-/* translate-all.c */
-void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
-
-#endif /* TRANSLATE_ALL_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 080cbcb34d0..337801feede 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -37,7 +37,7 @@
 #include "exec/helper-proto-common.h"
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 #include "trace.h"
 #include "tb-hash.h"
 #include "internal-common.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 97d2e39ec0d..bdf5a0b7d58 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -25,7 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/tb-flush.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "tb-hash.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d586ac9bb1d..bad3fce0ffb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -45,7 +45,7 @@
 
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
 #include "qemu/bitmap.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 636932303bb..815a39503f3 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -33,6 +33,7 @@
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#include "tb-internal.h"
 
 __thread uintptr_t helper_retaddr;
 
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 8923301b8b8..e24baead562 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -21,8 +21,8 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
-#include "exec/translate-all.h"
 #include "exec/page-protection.h"
+#include "tb-internal.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
-- 
2.47.1


