Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21108C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 21:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYX9B-0004zQ-7E; Thu, 16 Jan 2025 16:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYX95-0004sk-Mx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:11:20 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYX90-0000L2-TF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 16:11:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so9280625e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 13:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737061873; x=1737666673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=riQwqZqP5uF4miHPd92Yzxz/RhaQeGYtAFPJeIdVM9c=;
 b=NciWtJMTfgs+Z60GmyCAsPb9Mu9GB/d2k6n38n5qhjrl11TsIELskOoeiCyLcHvXrj
 NS2ZSunfPhbALPvQDRnS6fBuVEOZxQL8IxsU8edOEqTIVM7pSkBiCPvHM4ojaHbklYul
 6usxyp/xSWIJtzQUHjNDCLAoetaN2vwvzL8ZWE9XzC9917Zf0ab+e5ZceYhu6Uq8MmV+
 lRVkLVIM1z5sR3eYdvuK7TXJ0rwYOdn19PIr6QMhd+1LhvR/7HFiv5lWguo3x4yTZ3aS
 aT/wJ63cUc+5ICcN256o7V6CD3CJydksLd+wFzmme/rBKS4MyaA+/abFWRNlKh7l7ax9
 ImKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737061873; x=1737666673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=riQwqZqP5uF4miHPd92Yzxz/RhaQeGYtAFPJeIdVM9c=;
 b=d0RF9Gax55f9PScvwNq/R9OB0wIz1dMiGJs2Sl9Q8uLtc7viEqypzLkTtjKvnq5vYs
 l6CyJlJ15nQ0UphFISbfGqusCXGamZAcRd0dsvDJE1mmyKPNxNtvZhd+efXJX+jiQmd8
 tgVMbCZiG6CaW7q0Q9R+xkbUTuTzRU9JBqRM7knA/Jkl4spYap4DTV0vOfuRDb5udldR
 olw6f8oGKpyKc6ggyE65RDIMMCLgLEWOMykUur2PLGpj8z08ERnirr6TV+eyVprUVk97
 Q4sXtuqfttPl2ga80iu3fw87L3aduMIZ7nIiIJOlq2RHZXdVzggrtiuvafXjqJt0AGnq
 6jNQ==
X-Gm-Message-State: AOJu0YxZj+y03XKZONtpD7S2Q59A1RY6yydBGWhrSsOeOVClDinJX0kH
 1GtFKOcikROwc85UcPcTIIS8SvlKgiaA2RW/2nz6NjNgadPvZHeL5335RCAqPbAf4+P2fckZUCx
 Cpa8=
X-Gm-Gg: ASbGnctLuDCRw5f5XurgCnAzduXYLSWCxcr1BkQUm/8JIJD2sDnZB6JRsXalE7SKdyI
 PuBRdzkFQUkx26N7GKYT2phzruJmA+4banF1B/sq6MHhA+v32elmc9ObGo0AlnQnAZTS6oXsf8N
 aSKQsLBSXbQ44MrhLePBvIQts+K7y3DrD7uo2nPnS/wg9eZ9CyYxTdzDJlviThJk40Rj6LExWbT
 gMrluIMwfNwEqDxNXk5wYarxkhxIfb+9idHnD/JJmJN9My+UuwKBhQ7LXr5sI7fmpTA70cHntth
 HaZByePDJ3qXs9EhAv+RddlxoUU3M6k=
X-Google-Smtp-Source: AGHT+IFFjSU501lFpKCUxmSBAzRRdnUlqKvPjwJeAH/KuZa8a44n6Vx5QXNUc6p2kIEtmS70Po6Z4g==
X-Received: by 2002:a05:600c:3c94:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-43891439f04mr1546435e9.21.1737061873011; 
 Thu, 16 Jan 2025 13:11:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904621cdsm10751505e9.27.2025.01.16.13.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 13:11:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Hanna Reitz <hreitz@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] qemu/compiler: Absorb 'clang-tsa.h'
Date: Thu, 16 Jan 2025 22:11:11 +0100
Message-ID: <20250116211111.53961-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

We already have "qemu/compiler.h" for compiler-specific arrangements,
automatically included by "qemu/osdep.h" for each source file. No
need to explicitly include a header for a Clang particularity,
let the common "qemu/compiler.h" deal with that by having it
include "qemu/clang-tsa.h" (renamed as qemu/clang-tsa.h.inc).
Add a check to not include "qemu/clang-tsa.h.inc" directly,
remove previous "qemu/clang-tsa.h" inclusions.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h                               | 1 -
 include/block/block_int-common.h              | 1 -
 include/block/graph-lock.h                    | 2 --
 include/exec/page-protection.h                | 2 --
 include/qemu/compiler.h                       | 2 ++
 include/qemu/thread.h                         | 1 -
 include/qemu/{clang-tsa.h => clang-tsa.h.inc} | 8 ++++++--
 block/create.c                                | 1 -
 tests/unit/test-bdrv-drain.c                  | 1 -
 tests/unit/test-block-iothread.c              | 1 -
 util/qemu-thread-posix.c                      | 1 -
 11 files changed, 8 insertions(+), 13 deletions(-)
 rename include/qemu/{clang-tsa.h => clang-tsa.h.inc} (97%)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3eaa14f3f56..4e97c796318 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -40,7 +40,6 @@ extern char **environ;
 #include "target.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
-#include "qemu/clang-tsa.h"
 #include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index bb91a0f62fa..ebb4e56a503 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -28,7 +28,6 @@
 #include "block/block-common.h"
 #include "block/block-global-state.h"
 #include "block/snapshot.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "qemu/stats64.h"
diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index dc8d9491843..2c26c721081 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -20,8 +20,6 @@
 #ifndef GRAPH_LOCK_H
 #define GRAPH_LOCK_H
 
-#include "qemu/clang-tsa.h"
-
 /**
  * Graph Lock API
  * This API provides a rwlock used to protect block layer
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index bae3355f62c..3e0a8a03331 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -40,8 +40,6 @@
 
 #ifdef CONFIG_USER_ONLY
 
-#include "qemu/clang-tsa.h"
-
 void TSA_NO_TSA mmap_lock(void);
 void TSA_NO_TSA mmap_unlock(void);
 bool have_mmap_lock(void);
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb41..6dfd8da14d9 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -7,6 +7,8 @@
 #ifndef COMPILER_H
 #define COMPILER_H
 
+#include "qemu/clang-tsa.h.inc"
+
 #define HOST_BIG_ENDIAN (__BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
 
 /* HOST_LONG_BITS is the size of a native pointer in bits. */
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 7eba27a7049..6f800aad31a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -3,7 +3,6 @@
 
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
-#include "qemu/clang-tsa.h"
 
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
diff --git a/include/qemu/clang-tsa.h b/include/qemu/clang-tsa.h.inc
similarity index 97%
rename from include/qemu/clang-tsa.h
rename to include/qemu/clang-tsa.h.inc
index ba06fb8c924..1273c39f9c5 100644
--- a/include/qemu/clang-tsa.h
+++ b/include/qemu/clang-tsa.h.inc
@@ -1,5 +1,5 @@
-#ifndef CLANG_TSA_H
-#define CLANG_TSA_H
+#ifndef CLANG_TSA_H_INC
+#define CLANG_TSA_H_INC
 
 /*
  * Copyright 2018 Jarkko Hietaniemi <jhi@iki.fi>
@@ -24,6 +24,10 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#ifndef COMPILER_H
+#error Cannot include this header directly
+#endif
+
 /* http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
  * TSA is available since clang 3.6-ish.
diff --git a/block/create.c b/block/create.c
index 72abafb4c12..6b23a216753 100644
--- a/block/create.c
+++ b/block/create.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-block-core.h"
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 98ad89b390c..7410e6f3528 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -28,7 +28,6 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
-#include "qemu/clang-tsa.h"
 #include "iothread.h"
 
 static QemuEvent done_event;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 1de04a8a13d..26a6c051758 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -29,7 +29,6 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 6fff4162ac6..b2e26e21205 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -17,7 +17,6 @@
 #include "qemu-thread-common.h"
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
-#include "qemu/clang-tsa.h"
 
 #ifdef CONFIG_PTHREAD_SET_NAME_NP
 #include <pthread_np.h>
-- 
2.47.1


