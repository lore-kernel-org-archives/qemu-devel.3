Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41436C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6tL-0007vi-AI; Thu, 23 Jan 2025 18:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tI-0007iZ-An
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tF-0004NQ-Ty
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:40 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso15535045e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675936; x=1738280736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhTovaxYyVYo/iAlHiQi1CfSH3sOOBet2z8bCBrBkk0=;
 b=Hjt4jNn+psy8P4dRHPP+fR7ghVxt2Nx4X0R56bTI/CeOVwPyeWFQDg/d+BSdzJBmBZ
 VXX/nmIdzwJ080KkyEtQpk1lp7XKBs5oKYB3qjoo1zIDQby8cvtFXhhOnyJMYixMpTgS
 3t6oeGcVDM2i7hP0oLfmzpfE0+FzXbMFKBsQMtIsjqHm8fIyMDX39Ybh4blrHm5tHYct
 ylGZikG/Xl3zurRWDX91WnmFdBmN5UYqoM4Ymf47WX0ujJYScmCc/hVNAc7A5IeuKmbc
 TqVe18wDkgR08L7qpePWpJSvbF8qlcjf4FVIj1XIhRm49SDuy/a7ne6btbu2yD18jyYa
 iCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675936; x=1738280736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhTovaxYyVYo/iAlHiQi1CfSH3sOOBet2z8bCBrBkk0=;
 b=vxRd9E7VN+4vrlqmUnbfTvQm5eep7gk06r4t/ZQRoRNexJ47I5vFOisSu2wcCjwRA1
 MyA73drihJYyyX2LHSMfiyx/qS3BMqDoUNpHdiiWcqy8p95QO7A2JWWlIUnbZEdyaKAL
 DVAOCOoUGNkXZ9mhsPxrgbpwDFCZfDq2EWwfeaJjpXE0tnKIAmB4pMM6YU3avmofKTel
 FNd0GwlHLpI/5hgHSeBCqOlaGU8ehdOivx2Hryp/7ZE/J+gPcHLyHgN0ct9SZ+9CVtGN
 25OjRFkWkEM4NhYyZ0PXi/ufS9zlJWj4GCLNDe9P/ZTJhlzdUSwdhfcpkul/MHBXF3tv
 S71g==
X-Gm-Message-State: AOJu0YxC8LtpmBSeeMpWtLf7u7tA2jWTqmC6FX/jtqFgY+azxmR7MEoh
 3pE3wQmSuK/cPDli5j3J3iKqYMF3MP98YraUVMPU5Zma+ZEfpoEJ11j+LkDybgtT8bDaf9w6WSu
 IlNA=
X-Gm-Gg: ASbGnctVI+9LAMEv0v0ZhUoir5GJgeolK1ayaj/PKmo2XlnyVuLv448r2V9jgxmskE2
 hYytxKi5v6fCB+aBeWiPJwqKPoqh+lomG1gb1aca7TCtS47vKq22gffyUvsk3hKlkvDPQW1EnJ9
 fgL0dNdigfWM4CjIMyZtNH+CzXkkP1cDvzT6+YxRQ1H8D+tX8VtPF/+BPYj++aT62yRpnDgfBD2
 2dYwHPWMjgO14TiO0kmI3ZNpn2z00IyXcwR28AOTMAp6ujIrmR/qbtvYx893/02yb7GqboFhtDB
 diRc1PVdos4vNLWl5Il3cgeEfWzaVXJPM9o4eBQq5tPl5Z5eI3kSAUeZCO0f/O1lpw==
X-Google-Smtp-Source: AGHT+IE1g5Lka6yaX7yxmvTjxCMF9sNPmOLsz1lyorKlxhPYpXBg1FExyYB9qYVhhui8O2rA+ot5eQ==
X-Received: by 2002:a05:600c:3b0a:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-438913ca93cmr282415605e9.11.1737675935797; 
 Thu, 23 Jan 2025 15:45:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507d60sm6676495e9.18.2025.01.23.15.45.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 14/20] accel/tcg: Move cpu_memory_rw_debug() user
 implementation to user-exec.c
Date: Fri, 24 Jan 2025 00:44:08 +0100
Message-ID: <20250123234415.59850-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

cpu_memory_rw_debug() system implementation is defined in
system/physmem.c. Move the user one to accel/tcg/user-exec.c
to simplify cpu-target.c maintenance.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec.c |  92 +++++++++++++++++++++++++++++++++++++
 cpu-target.c          | 102 +-----------------------------------------
 2 files changed, 94 insertions(+), 100 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index c4454100ad7..e7e99a46087 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,6 +19,8 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
+#include "exec/vaddr.h"
+#include "exec/tswap.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
@@ -35,6 +37,7 @@
 #include "internal-common.h"
 #include "internal-target.h"
 #include "tb-internal.h"
+#include "qemu.h"
 
 __thread uintptr_t helper_retaddr;
 
@@ -969,6 +972,95 @@ static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
     return ret;
 }
 
+/* physical memory access (slow version, mainly for debug) */
+int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
+                        void *ptr, size_t len, bool is_write)
+{
+    int flags;
+    vaddr l, page;
+    void * p;
+    uint8_t *buf = ptr;
+    ssize_t written;
+    int ret = -1;
+    int fd = -1;
+
+    while (len > 0) {
+        page = addr & TARGET_PAGE_MASK;
+        l = (page + TARGET_PAGE_SIZE) - addr;
+        if (l > len)
+            l = len;
+        flags = page_get_flags(page);
+        if (!(flags & PAGE_VALID)) {
+            goto out_close;
+        }
+        if (is_write) {
+            if (flags & PAGE_WRITE) {
+                /* XXX: this code should not depend on lock_user */
+                p = lock_user(VERIFY_WRITE, addr, l, 0);
+                if (!p) {
+                    goto out_close;
+                }
+                memcpy(p, buf, l);
+                unlock_user(p, addr, l);
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
+                mmap_lock();
+                tb_invalidate_phys_range(addr, addr + l - 1);
+                written = pwrite(fd, buf, l,
+                                 (off_t)(uintptr_t)g2h_untagged(addr));
+                mmap_unlock();
+                if (written != l) {
+                    goto out_close;
+                }
+            }
+        } else if (flags & PAGE_READ) {
+            /* XXX: this code should not depend on lock_user */
+            p = lock_user(VERIFY_READ, addr, l, 1);
+            if (!p) {
+                goto out_close;
+            }
+            memcpy(buf, p, l);
+            unlock_user(p, addr, 0);
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
+    return ret;
+}
+
 #include "ldst_atomicity.c.inc"
 
 static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
diff --git a/cpu-target.c b/cpu-target.c
index 20933bde7d4..6d8b7825746 100644
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
@@ -38,16 +32,15 @@
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/tcg.h"
-#include "exec/tswap.h"
 #include "exec/replay-core.h"
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
@@ -367,97 +360,6 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
     abort();
 }
 
-/* physical memory access (slow version, mainly for debug) */
-#if defined(CONFIG_USER_ONLY)
-int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                        void *ptr, size_t len, bool is_write)
-{
-    int flags;
-    vaddr l, page;
-    void * p;
-    uint8_t *buf = ptr;
-    ssize_t written;
-    int ret = -1;
-    int fd = -1;
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
-                /* XXX: this code should not depend on lock_user */
-                p = lock_user(VERIFY_WRITE, addr, l, 0);
-                if (!p) {
-                    goto out_close;
-                }
-                memcpy(p, buf, l);
-                unlock_user(p, addr, l);
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
-                mmap_lock();
-                tb_invalidate_phys_range(addr, addr + l - 1);
-                written = pwrite(fd, buf, l,
-                                 (off_t)(uintptr_t)g2h_untagged(addr));
-                mmap_unlock();
-                if (written != l) {
-                    goto out_close;
-                }
-            }
-        } else if (flags & PAGE_READ) {
-            /* XXX: this code should not depend on lock_user */
-            p = lock_user(VERIFY_READ, addr, l, 1);
-            if (!p) {
-                goto out_close;
-            }
-            memcpy(buf, p, l);
-            unlock_user(p, addr, 0);
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
-    return ret;
-}
-#endif
-
 bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
-- 
2.47.1


