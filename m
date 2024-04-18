Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EB9C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXRP-0004Ma-BZ; Thu, 18 Apr 2024 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPn-0000RQ-8g
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:25 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPl-0007cD-Ap
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso125156766b.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468439; x=1714073239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koVgyajCEgUVl/LMvNKONPGr1ZhJ2eug5WfoAqRNjUs=;
 b=zqKavEvUwmpktzeC+ZkyMOS6iqmafM6qsXVAEzNYS8OxOXD0h7Li/SUtH2QlGSV42v
 gtGr1aErMgYhJG8t6ttnlJYHRlT5s6csBUSDJvKUUgKwztK9bgxfoht0Jo8n566f9xw5
 WJCPSisaHKLFFhBiVCqkCZGHBtCeSRgWZo/nc6Va/Nx+1SGtZ3etaTNi0SHVMgrMNSd5
 jZTvmsADsT/EuGy7blU6vJQ1I46vFsxOrstT972mzuA6rwqIh7SOEPKHLLGWIo1TYQ6o
 /W9EqRv6gjsOqagQZSxouEan0y/1CtFQ/QmvNJhe7Oz7fTIPkMAVefFne69uufMQ5WuQ
 XPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468439; x=1714073239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koVgyajCEgUVl/LMvNKONPGr1ZhJ2eug5WfoAqRNjUs=;
 b=KrDZl11Lzdq6Kcy4g4p5NpVVE11McaWcxMo+sSqb1Rgh3ZynCVn7apahSwH/F8Anal
 eRjsWjlQuKr6eB7uqIYakKc/Mj87BacPKQz2d+69tvi4GQDWwju7il2UWSfmnLPMpP4x
 ILJIeig1ojS/h3XkJ1k4yCqEXg7wa2MDwJ60kl5WAXdOI8xyMax2FZrBAZ1ZFZakXSOT
 CtlNQlW2sHksUwHrjCQyutqdcuL+eemvbpYo24SBvHzlg+Sdi+OA6OkIY8zreS8tUHRz
 ae3LMgAnToMfkx9qs8IkS3TtLFHrGZIcfOtKMUUw5C+rrcmhuqRu8XeX4DmYKLqp9cjX
 bhUw==
X-Gm-Message-State: AOJu0YyseKuP//XSVJRCk9DGCQrw8bd5GstV++uslcggRF7CgZLoxVvw
 h45V2Z7GQeypX0OlDSCFxJAazcXT4GG2oH07lUnxbFV1vB1VzDH0hyzfsehxpFk97U1epqFGJSo
 a
X-Google-Smtp-Source: AGHT+IGUKx1BaAucoqEBkcKvR0ggaq6VcW3+/vbLpdXj+U90uCMnnNyN02Af7LhJb66dZ9m1Y8QZCA==
X-Received: by 2002:a17:906:6013:b0:a52:ec:a87d with SMTP id
 o19-20020a170906601300b00a5200eca87dmr48021ejj.74.1713468439142; 
 Thu, 18 Apr 2024 12:27:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a170906119600b00a51a9d87570sm1269573eja.17.2024.04.18.12.27.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:27:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/24] exec: Move GUEST_ADDR_MAX definition to 'cpu_ldst.h'
Date: Thu, 18 Apr 2024 21:25:15 +0200
Message-ID: <20240418192525.97451-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

GUEST_ADDR_MAX is only used in accel/tcg/user-exec.c
and "exec/cpu_ldst.h". Move it from "exec/cpu-all.h"
to "exec/cpu_ldst.h" so we can avoid including
"exec/cpu-all.h" in accel/tcg/user-exec.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-all.h  | 34 +---------------------------------
 include/exec/cpu_ldst.h | 30 ++++++++++++++++++++++++++++++
 accel/tcg/cpu-exec.c    |  1 -
 3 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e75ec13cd0..554b937ddb 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -63,39 +63,7 @@
 
 /* MMU memory access macros */
 
-#if defined(CONFIG_USER_ONLY)
-#include "exec/user/abitypes.h"
-
-/*
- * If non-zero, the guest virtual address space is a contiguous subset
- * of the host virtual address space, i.e. '-R reserved_va' is in effect
- * either from the command-line or by default.  The value is the last
- * byte of the guest address space e.g. UINT32_MAX.
- *
- * If zero, the host and guest virtual address spaces are intermingled.
- */
-extern unsigned long reserved_va;
-
-/*
- * Limit the guest addresses as best we can.
- *
- * When not using -R reserved_va, we cannot really limit the guest
- * to less address space than the host.  For 32-bit guests, this
- * acts as a sanity check that we're not giving the guest an address
- * that it cannot even represent.  For 64-bit guests... the address
- * might not be what the real kernel would give, but it is at least
- * representable in the guest.
- *
- * TODO: Improve address allocation to avoid this problem, and to
- * avoid setting bits at the top of guest addresses that might need
- * to be used for tags.
- */
-#define GUEST_ADDR_MAX_                                                 \
-    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
-     UINT32_MAX : ~0ul)
-#define GUEST_ADDR_MAX    (reserved_va ? : GUEST_ADDR_MAX_)
-
-#else
+#if !defined(CONFIG_USER_ONLY)
 
 #include "exec/hwaddr.h"
 
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 6d47d3114a..07649a01c1 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -73,8 +73,38 @@
 
 #if defined(CONFIG_USER_ONLY)
 
+#include "user/abitypes.h"
 #include "user/guest-base.h"
 
+/*
+ * If non-zero, the guest virtual address space is a contiguous subset
+ * of the host virtual address space, i.e. '-R reserved_va' is in effect
+ * either from the command-line or by default.  The value is the last
+ * byte of the guest address space e.g. UINT32_MAX.
+ *
+ * If zero, the host and guest virtual address spaces are intermingled.
+ */
+extern unsigned long reserved_va;
+
+/*
+ * Limit the guest addresses as best we can.
+ *
+ * When not using -R reserved_va, we cannot really limit the guest
+ * to less address space than the host.  For 32-bit guests, this
+ * acts as a sanity check that we're not giving the guest an address
+ * that it cannot even represent.  For 64-bit guests... the address
+ * might not be what the real kernel would give, but it is at least
+ * representable in the guest.
+ *
+ * TODO: Improve address allocation to avoid this problem, and to
+ * avoid setting bits at the top of guest addresses that might need
+ * to be used for tags.
+ */
+#define GUEST_ADDR_MAX_                                                 \
+    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
+     UINT32_MAX : ~0ul)
+#define GUEST_ADDR_MAX    (reserved_va ? : GUEST_ADDR_MAX_)
+
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
 {
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..7bfd558027 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -31,7 +31,6 @@
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
-#include "exec/cpu-all.h"
 #include "sysemu/cpu-timers.h"
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
-- 
2.41.0


