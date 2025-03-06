Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C51C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTw-00028i-U1; Thu, 06 Mar 2025 10:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDT8-0000Aq-8X
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDT4-0006LF-80
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:04 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so5466915e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276140; x=1741880940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XYt4cBWZWrjpH5G+9fvDDbmKK0hy/czETSnD+S9rJr4=;
 b=Ca0M/kKkeLzrls6vp2wLqW4n3b+8FQeLRdqclujhKthUREtwXJPht2888QYSQJFGi2
 uFKJ3BkvVyB/55h8OjXqdRvVuI0U3ycMaqGQJt2i6aZGu/ejt734zF4OPbsPAgWtEbtL
 XIGPhciqNqD2zw60AfvaTqFl/+yTNE+DlhwN08dlP1cW/0o2yB6yDjgw5MnkY1opjCur
 GDGaSBKKKWAfYkjl0dsYhvG1HMFBoV6k9oKls5TxGxq99b8i3zcWgacZoAEG9jwa1BA8
 s81II3I9rl69HxGpaKAP1wrRNoHEZeNnE93Pf4lGgN7n+rpJzNm2G4SVS1Hz1EiXix/t
 +qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276140; x=1741880940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYt4cBWZWrjpH5G+9fvDDbmKK0hy/czETSnD+S9rJr4=;
 b=IdVk/6Rztk3DTzX6hMNhPwV1amJGnr4TzIMqfaq/X/4ZaMmMyNoKF362eWgxO69U0e
 Evy+ZCKW4Hjn1g8YJOoLEzHFcfmL+FMNIFx5Tvdr16OQLL9MscinJ7Mrvg2G1JM6cl5M
 rh2BawowN+py2njDxPS5Hld5DW3npFtxlfBOSYT2HVlLY/2j0KKbo0i307cwrlhk9mtv
 l/5ElWnXL0QTHQKEe9SOPmKdbGL5pxLJRZbxXlH9FFc6F8HP+Mq0tMja+7pAIqSGio90
 9hIFSQhwDonAGAKhZHpX52ybVJ9gYzzut8oTi8I2pxYcgNGfg2/n2STaTceG19kpIGGT
 AxeQ==
X-Gm-Message-State: AOJu0YzgC38Y1F/tRFGMivjZBx/bwWcGTeDXFSXa72Z1YBB+18Kk75zL
 NIkoDfUxO9gZuvrbL23unAQ2fwM0ylwUzCA07/mgx6xW4+6KOI7F9/Xi6+jsA4NAVWZMpXYAC/5
 tRSI=
X-Gm-Gg: ASbGncuZwYSym9pNV0NlUkwRrzfFwAlGH64qGcPJo6tJhpLWuGK7aypihalbG+6npfK
 FjGt6ar7k//OMxk/3/WCaGubrMyFG1IaM7bUlYPU9KVALDW92n4ymobUogsyQlLN5TTnH82gpes
 2tI09ESLOjewIg6+LBvMLwC2VLpEPI0DPLom+El9FCQv14ZElxHQxxicXD9XsoA1x22rSI+FgYt
 Und+NuJRsj8GdWyFHXkki3ncQArBsnKxXF4mMnvaTeV+49jzfhgr8NWNIq1ga3yFYMAKOmQ7jFd
 zpAosicnQxnHA4RgdOAUxt8YDfKCBLj+EgC1oO/cW3eujy6AE/vpjvaoW9F4bz+uksvJnBCi6Pd
 tvJUzvtrMJMUxa6GBOio=
X-Google-Smtp-Source: AGHT+IHt0w7Tk84c88eITifZQAU1g5sin1l85vPtlZBuJKpt/6P1xNtmJ9XZohoxLhLz7zFlMTUQWQ==
X-Received: by 2002:a5d:6d82:0:b0:390:e889:d1d7 with SMTP id
 ffacd0b85a97d-3911f73fd02mr6315894f8f.13.1741276139730; 
 Thu, 06 Mar 2025 07:48:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9d6sm23236255e9.26.2025.03.06.07.48.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/54] accel/tcg: Move cpu_memory_rw_debug() user
 implementation to user-exec.c
Date: Thu,  6 Mar 2025 16:47:00 +0100
Message-ID: <20250306154737.70886-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

cpu_memory_rw_debug() system implementation is defined in
system/physmem.c. Move the user one to accel/tcg/user-exec.c
to simplify cpu-target.c maintenance.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250217130610.18313-6-philmd@linaro.org>
---
 accel/tcg/user-exec.c | 80 ++++++++++++++++++++++++++++++++++++++
 cpu-target.c          | 90 +------------------------------------------
 2 files changed, 82 insertions(+), 88 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 9d53c9440ea..2322181b151 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
+#include "exec/vaddr.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
@@ -971,6 +972,85 @@ static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
     return ret;
 }
 
+/* physical memory access (slow version, mainly for debug) */
+int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
+                        void *ptr, size_t len, bool is_write)
+{
+    int flags;
+    vaddr l, page;
+    uint8_t *buf = ptr;
+    ssize_t written;
+    int ret = -1;
+    int fd = -1;
+
+    mmap_lock();
+
+    while (len > 0) {
+        page = addr & TARGET_PAGE_MASK;
+        l = (page + TARGET_PAGE_SIZE) - addr;
+        if (l > len) {
+            l = len;
+        }
+        flags = page_get_flags(page);
+        if (!(flags & PAGE_VALID)) {
+            goto out_close;
+        }
+        if (is_write) {
+            if (flags & PAGE_WRITE) {
+                memcpy(g2h(cpu, addr), buf, l);
+            } else {
+                /* Bypass the host page protection using ptrace. */
+                if (fd == -1) {
+                    fd = open("/proc/self/mem", O_WRONLY);
+                    if (fd == -1) {
+                        goto out;
+                    }
+                }
+                /*
+                 * If there is a TranslationBlock and we weren't bypassing the
+                 * host page protection, the memcpy() above would SEGV,
+                 * ultimately leading to page_unprotect(). So invalidate the
+                 * translations manually. Both invalidation and pwrite() must
+                 * be under mmap_lock() in order to prevent the creation of
+                 * another TranslationBlock in between.
+                 */
+                tb_invalidate_phys_range(addr, addr + l - 1);
+                written = pwrite(fd, buf, l,
+                                 (off_t)(uintptr_t)g2h_untagged(addr));
+                if (written != l) {
+                    goto out_close;
+                }
+            }
+        } else if (flags & PAGE_READ) {
+            memcpy(buf, g2h(cpu, addr), l);
+        } else {
+            /* Bypass the host page protection using ptrace. */
+            if (fd == -1) {
+                fd = open("/proc/self/mem", O_RDONLY);
+                if (fd == -1) {
+                    goto out;
+                }
+            }
+            if (pread(fd, buf, l,
+                      (off_t)(uintptr_t)g2h_untagged(addr)) != l) {
+                goto out_close;
+            }
+        }
+        len -= l;
+        buf += l;
+        addr += l;
+    }
+    ret = 0;
+out_close:
+    if (fd != -1) {
+        close(fd);
+    }
+out:
+    mmap_unlock();
+
+    return ret;
+}
+
 #include "ldst_atomicity.c.inc"
 
 static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
diff --git a/cpu-target.c b/cpu-target.c
index 3892ce12229..83688f1d508 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,18 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-
-#include "exec/target_page.h"
-#include "exec/page-protection.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "migration/vmstate.h"
-#ifdef CONFIG_USER_ONLY
-#include "qemu.h"
-#include "user/page-protection.h"
-#else
+#ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
@@ -43,11 +37,11 @@
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/tb-flush.h"
-#include "exec/translation-block.h"
 #include "exec/log.h"
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
+#include "hw/core/cpu.h"
 
 #ifndef CONFIG_USER_ONLY
 static int cpu_common_post_load(void *opaque, int version_id)
@@ -367,86 +361,6 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     abort();
 }
 
-/* physical memory access (slow version, mainly for debug) */
-#if defined(CONFIG_USER_ONLY)
-int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                        void *ptr, size_t len, bool is_write)
-{
-    int flags;
-    vaddr l, page;
-    uint8_t *buf = ptr;
-    ssize_t written;
-    int ret = -1;
-    int fd = -1;
-
-    mmap_lock();
-
-    while (len > 0) {
-        page = addr & TARGET_PAGE_MASK;
-        l = (page + TARGET_PAGE_SIZE) - addr;
-        if (l > len)
-            l = len;
-        flags = page_get_flags(page);
-        if (!(flags & PAGE_VALID)) {
-            goto out_close;
-        }
-        if (is_write) {
-            if (flags & PAGE_WRITE) {
-                memcpy(g2h(cpu, addr), buf, l);
-            } else {
-                /* Bypass the host page protection using ptrace. */
-                if (fd == -1) {
-                    fd = open("/proc/self/mem", O_WRONLY);
-                    if (fd == -1) {
-                        goto out;
-                    }
-                }
-                /*
-                 * If there is a TranslationBlock and we weren't bypassing the
-                 * host page protection, the memcpy() above would SEGV,
-                 * ultimately leading to page_unprotect(). So invalidate the
-                 * translations manually. Both invalidation and pwrite() must
-                 * be under mmap_lock() in order to prevent the creation of
-                 * another TranslationBlock in between.
-                 */
-                tb_invalidate_phys_range(addr, addr + l - 1);
-                written = pwrite(fd, buf, l,
-                                 (off_t)(uintptr_t)g2h_untagged(addr));
-                if (written != l) {
-                    goto out_close;
-                }
-            }
-        } else if (flags & PAGE_READ) {
-            memcpy(buf, g2h(cpu, addr), l);
-        } else {
-            /* Bypass the host page protection using ptrace. */
-            if (fd == -1) {
-                fd = open("/proc/self/mem", O_RDONLY);
-                if (fd == -1) {
-                    goto out;
-                }
-            }
-            if (pread(fd, buf, l,
-                      (off_t)(uintptr_t)g2h_untagged(addr)) != l) {
-                goto out_close;
-            }
-        }
-        len -= l;
-        buf += l;
-        addr += l;
-    }
-    ret = 0;
-out_close:
-    if (fd != -1) {
-        close(fd);
-    }
-out:
-    mmap_unlock();
-
-    return ret;
-}
-#endif
-
 bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
-- 
2.47.1


