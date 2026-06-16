Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4BFCD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDw-0005la-Gj; Tue, 16 Jun 2026 17:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDh-0005cA-Hh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:20 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDe-0007RK-7E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:17 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36b900f350fso4604389a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644873; x=1782249673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+w29pBdvePuWArkwWUCG6+v0rXkNsTxmP/wU5IcILQ=;
 b=Qf+GJ4tyHHoYszLBgZcNxyNkER8CM5mZQzf/YVNPYUq9fZYbHnHKgEtlFGVj6oOeBf
 a9+g69fh4D2+wwJcLbmt9lDrcwPUlif9GNqkIL4FmeGWwgA7jqCdyBpTSXJdpVXwqiAL
 qKJfKLqjEWfXr/jKi8hUiF1bfWACG/sp5Z7vTAQnSa/YiqJh2MKAHL5H9AE0HoGfDCx3
 26ILNpwZpdgJXZlqxuqNIkQRTJmdDgbJJyPNSY4X1PUGRlTUkt7JT9/dn6jcoqH6GOjZ
 7NL360PfsdmXyuxraIVBZZIAk11Cz43X/CN6B1bhhR4mYXUKt2oD9OLAMIY8UELXOIuc
 JEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644873; x=1782249673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R+w29pBdvePuWArkwWUCG6+v0rXkNsTxmP/wU5IcILQ=;
 b=NRQPCMnljQ5HRHKFXFSz1naRVf+QixhQwckAmXd4P8mKFaHm5P08gwLPyRv+ZAKiY3
 4rqTTUkCO4kj0es+YVh0VDiNGUs8CDkj7uMZKmGyP0UQCDe+OgtMxVnXTJqAso53NQ69
 lTiGctTRCSOFaOGgISkOL6wkij08CK7GWw1g7FQqHQri0sbXNKtz/0l6LAvZ1ah5xe1g
 8wNcSfjZHMCY2DjVH2BiKIo5CE20NjDDQW4SsdCcuJbJOwjG0iYEE7BIbbmQIlkm73A3
 BwvXpH2GN/qEjGlx66bEeoCaS7PehLoK3YGknEBJxGI9Ba6QOha7SkR/km1BHVBRKdLk
 yisw==
X-Gm-Message-State: AOJu0YyXGL47SjnzhIRxim3PXORaC0erQhWj3FQci58FSD8JEU1yX3ed
 9+xrcr733fkyQvVLcDVv8F+GJNU2NR2i88ee+bAuT0hhaC48YGsGTJlOjwvfZ6bYerkod4S2W5b
 gRFiX
X-Gm-Gg: Acq92OFPtCP8DL09Y9ARU08oXzRkTg6yyhvMBDZXQ4Fm/IDYG91hKjWXtz2Jp+gRhwc
 jbX0t7qD6UZoZUcyKUTrM5+UQf4TaVtK7bYg5BVAhbbmYtjGY1OeeXb6sOmRXBdEX6H31dkQci8
 Tkryi3/nHVm9vB93exh4gQj8IzQe6pqQttyBY8RfoHNvSsoiqf7M4LjvPf5JbXM04G/Xu3IjQiK
 T5iw4FHC9AJW1Ji1FhuUhm75ZjsngqiM4pcsT0KBvz529uuGRevqVQAeJr1+qthGea8u1hsetCR
 1LSPkls9mAIKJhhr6W4s1x/5xsQp8xCxmguwGWv1Xz0mV33/bO/s+hSiKs+GChZSP4fbee6E5DF
 ze2BGqt9hwe5a0II5JDm9soPpvuIVijDN7keldjagHYwCqgrgCpVJcXfpx7CIy/KbSdlP0ODrhd
 8f62vJuHfHapmbbWB88j36lwsieTbw8oczucqivEfKf7frGPxE9DmveWHf2Y+s
X-Received: by 2002:a17:90b:4a51:b0:36b:b3f4:d578 with SMTP id
 98e67ed59e1d1-37c936ffd4amr1130500a91.15.1781644872521; 
 Tue, 16 Jun 2026 14:21:12 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 11/13] common-user: Move probe_guest_base from linux-user
Date: Tue, 16 Jun 2026 14:20:52 -0700
Message-ID: <20260616212055.334466-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Prepare to share probe_guest_base with bsd-user.

Create a linux_probe_guest_base wrapper with the portions
of probe_guest_base that are linux specific: managing the
commpage for various targets.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/probe-guest-base.h |  37 ++++
 linux-user/user-internals.h     |  10 +-
 common-user/probe-guest-base.c  | 343 ++++++++++++++++++++++++++++++++
 linux-user/elfload.c            | 337 +------------------------------
 linux-user/flatload.c           |   2 +-
 common-user/meson.build         |   1 +
 6 files changed, 392 insertions(+), 338 deletions(-)
 create mode 100644 include/user/probe-guest-base.h
 create mode 100644 common-user/probe-guest-base.c

diff --git a/include/user/probe-guest-base.h b/include/user/probe-guest-base.h
new file mode 100644
index 0000000000..d7492ef46c
--- /dev/null
+++ b/include/user/probe-guest-base.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef USER_PROBE_GUEST_BASE_H
+#define USER_PROBE_GUEST_BASE_H
+
+#ifndef CONFIG_USER_ONLY
+#error Cannot include this header from system emulation
+#endif
+
+#include "exec/vaddr.h"
+
+typedef struct PGBRange {
+    vaddr lo;
+    vaddr hi;
+} PGBRange;
+
+/**
+ * probe_guest_base:
+ * @image_name: the executable being loaded
+ * @image_range: the fixed addresses within the executable
+ *
+ * Creates the initial guest address space in the host memory space.
+ *
+ * If @image_range is NULL, then no address in the executable is fixed,
+ * i.e. it is fully relocatable.
+ *
+ * This function will not return if a valid value for guest_base
+ * cannot be chosen.  On return, the executable loader can expect
+ *
+ *    target_mmap(i->lo, i->hi - i->lo + 1, ...)
+ *
+ * to succeed.
+ */
+void probe_guest_base(const char *image_name, const PGBRange *image_range,
+                      const PGBRange *commpage_range);
+
+#endif
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 74d8eaabbe..e7fbddd0e6 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
+#include "user/probe-guest-base.h"
 
 extern char *exec_path;
 extern char real_exec_path[PATH_MAX];
@@ -74,13 +75,8 @@ void clone_fork_end(bool child);
 void fork_start(void);
 void fork_end(pid_t pid);
 
-typedef struct PGBRange {
-    vaddr lo;
-    vaddr hi;
-} PGBRange;
-
 /**
- * probe_guest_base:
+ * linux_probe_guest_base:
  * @image_name: the executable being loaded
  * @image_range: the fixed addresses within the executable
  *
@@ -96,7 +92,7 @@ typedef struct PGBRange {
  *
  * to succeed.
  */
-void probe_guest_base(const char *image_name, const PGBRange *image_range);
+void linux_probe_guest_base(const char *image_name, const PGBRange *image_range);
 
 /* syscall.c */
 int host_to_target_waitstatus(int status);
diff --git a/common-user/probe-guest-base.c b/common-user/probe-guest-base.c
new file mode 100644
index 0000000000..77722fe63f
--- /dev/null
+++ b/common-user/probe-guest-base.c
@@ -0,0 +1,343 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "qemu/target-info.h"
+#include "qemu/log.h"
+#include "user/guest-base.h"
+#include "user/mmap-min-addr.h"
+#include "user/guest-host.h"
+#include "user/probe-guest-base.h"
+#include "user/selfmap.h"
+#include "exec/target_page.h"
+#include <sys/shm.h>
+
+/* Linux and FreeBSD use different flags to express NOREPLACE. */
+#ifdef __FreeBSD__
+#define MAP_FIXED_NOREPLACE  (MAP_FIXED | MAP_EXCL)
+#endif
+
+/**
+ * pgb_try_mmap:
+ * @addr: host start address
+ * @addr_last: host last address
+ * @keep: do not unmap the probe region
+ *
+ * Return 1 if [@addr, @addr_last] is not mapped in the host,
+ * return 0 if it is not available to map, and -1 on mmap error.
+ * If @keep, the region is left mapped on success, otherwise unmapped.
+ */
+static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)
+{
+    size_t size = addr_last - addr + 1;
+    void *p = mmap((void *)addr, size, PROT_NONE,
+                   MAP_ANONYMOUS | MAP_PRIVATE |
+                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
+    int ret;
+
+    if (p == MAP_FAILED) {
+        return errno == EEXIST ? 0 : -1;
+    }
+    ret = p == (void *)addr;
+    if (!keep || !ret) {
+        munmap(p, size);
+    }
+    return ret;
+}
+
+/**
+ * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)
+ * @addr: host address
+ * @addr_last: host last address
+ * @brk: host brk
+ *
+ * Like pgb_try_mmap, but additionally reserve some memory following brk.
+ */
+static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,
+                                 uintptr_t brk, bool keep)
+{
+    uintptr_t brk_last = brk + 16 * MiB - 1;
+
+    /* Do not map anything close to the host brk. */
+    if (addr <= brk_last && brk <= addr_last) {
+        return 0;
+    }
+    return pgb_try_mmap(addr, addr_last, keep);
+}
+
+/**
+ * pgb_try_mmap_set:
+ * @ga: set of guest addrs
+ * @base: guest_base
+ * @brk: host brk
+ *
+ * Return true if all @ga can be mapped by the host at @base.
+ * On success, retain the mapping at index 0 for reserved_va.
+ */
+
+typedef struct PGBAddrs {
+    PGBRange bounds[3];
+    int nbounds;
+} PGBAddrs;
+
+static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
+{
+    for (int i = ga->nbounds - 1; i >= 0; --i) {
+        if (pgb_try_mmap_skip_brk(ga->bounds[i].lo + base,
+                                  ga->bounds[i].hi + base,
+                                  brk, i == 0 && reserved_va) <= 0) {
+            return false;
+        }
+    }
+    return true;
+}
+
+/**
+ * pgb_addr_set:
+ * @ga: output set of guest addrs
+ * @image_range: fixed guest image addresses
+ * @identity: create for identity mapping
+ *
+ * Fill in @ga with the image, COMMPAGE and NULL page.
+ */
+static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
+                         const PGBRange *commpage_range, bool try_identity)
+{
+    int n;
+
+    /*
+     * With a low commpage, or a guest mapped very low,
+     * we may not be able to use the identity map.
+     */
+    if (try_identity) {
+        if (commpage_range && commpage_range->lo < mmap_min_addr) {
+            return false;
+        }
+        if (image_range && image_range->lo < mmap_min_addr) {
+            return false;
+        }
+    }
+
+    memset(ga, 0, sizeof(*ga));
+    n = 0;
+
+    if (reserved_va) {
+        ga->bounds[n].lo = try_identity ? mmap_min_addr : 0;
+        ga->bounds[n].hi = reserved_va;
+        n++;
+        /* Low COMMPAGE and NULL handled by reserving from 0. */
+    } else {
+        /* Add any low COMMPAGE or NULL page. */
+        if (!try_identity || (commpage_range && commpage_range->lo == 0)) {
+            ga->bounds[n].lo = 0;
+            ga->bounds[n].hi = TARGET_PAGE_SIZE - 1;
+            n++;
+        }
+
+        /* Add the guest image for ET_EXEC. */
+        if (image_range) {
+            ga->bounds[n++] = *image_range;
+        }
+    }
+
+    /* Add any high COMMPAGE not covered by reserved_va. */
+    if (commpage_range && reserved_va < commpage_range->hi) {
+        ga->bounds[n].lo = commpage_range->lo & qemu_real_host_page_mask();
+        ga->bounds[n].hi = commpage_range->hi;
+        n++;
+    }
+
+    ga->nbounds = n;
+    return true;
+}
+
+static void pgb_fail_in_use(const char *image_name)
+{
+    error_report("%s: requires virtual address space that is in use "
+                 "(omit the -B option or choose a different value)",
+                 image_name);
+    exit(EXIT_FAILURE);
+}
+
+static void pgb_fixed(const char *image_name, const PGBRange *image_range,
+                      const PGBRange *commpage_range, uintptr_t align)
+{
+    PGBAddrs ga;
+    uintptr_t brk = (uintptr_t)sbrk(0);
+
+    if (!QEMU_IS_ALIGNED(guest_base, align)) {
+        fprintf(stderr, "Requested guest base %p does not satisfy "
+                "host minimum alignment (0x%" PRIxPTR ")\n",
+                (void *)guest_base, align);
+        exit(EXIT_FAILURE);
+    }
+
+    if (!pgb_addr_set(&ga, image_range, commpage_range, !guest_base)
+        || !pgb_try_mmap_set(&ga, guest_base, brk)) {
+        pgb_fail_in_use(image_name);
+    }
+}
+
+/**
+ * pgb_find_fallback:
+ *
+ * This is a fallback method for finding holes in the host address space
+ * if we don't have the benefit of being able to access /proc/self/map.
+ * It can potentially take a very long time as we can only dumbly iterate
+ * up the host address space seeing if the allocation would work.
+ */
+static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,
+                                   uintptr_t brk)
+{
+    /* TODO: come up with a better estimate of how much to skip. */
+    uintptr_t skip = sizeof(uintptr_t) == 4 ? MiB : GiB;
+
+    for (uintptr_t base = skip; ; base += skip) {
+        base = ROUND_UP(base, align);
+        if (pgb_try_mmap_set(ga, base, brk)) {
+            return base;
+        }
+        if (base >= -skip) {
+            return -1;
+        }
+    }
+}
+
+static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
+                               IntervalTreeRoot *root)
+{
+    for (int i = ga->nbounds - 1; i >= 0; --i) {
+        uintptr_t s = base + ga->bounds[i].lo;
+        uintptr_t l = base + ga->bounds[i].hi;
+        IntervalTreeNode *n;
+
+        if (l < s) {
+            /* Wraparound. Skip to advance S to mmap_min_addr. */
+            return mmap_min_addr - s;
+        }
+
+        n = interval_tree_iter_first(root, s, l);
+        if (n != NULL) {
+            /* Conflict.  Skip to advance S to LAST + 1. */
+            return n->last - s + 1;
+        }
+    }
+    return 0;  /* success */
+}
+
+static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
+                                uintptr_t align, uintptr_t brk)
+{
+    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
+    uintptr_t base, skip;
+
+    while (true) {
+        base = ROUND_UP(last, align);
+        if (base < last) {
+            return -1;
+        }
+
+        skip = pgb_try_itree(ga, base, root);
+        if (skip == 0) {
+            break;
+        }
+
+        last = base + skip;
+        if (last < base) {
+            return -1;
+        }
+    }
+
+    /*
+     * We've chosen 'base' based on holes in the interval tree,
+     * but we don't yet know if it is a valid host address.
+     * Because it is the first matching hole, if the host addresses
+     * are invalid we know there are no further matches.
+     */
+    return pgb_try_mmap_set(ga, base, brk) ? base : -1;
+}
+
+static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
+                        const PGBRange *commpage_range, uintptr_t align)
+{
+    IntervalTreeRoot *root;
+    uintptr_t brk, ret;
+    PGBAddrs ga;
+
+    /* Try the identity map first. */
+    if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
+        brk = (uintptr_t)sbrk(0);
+        if (pgb_try_mmap_set(&ga, 0, brk)) {
+            guest_base = 0;
+            return;
+        }
+    }
+
+    /*
+     * Rebuild the address set for non-identity map.
+     * This differs in the mapping of the guest NULL page.
+     */
+    pgb_addr_set(&ga, image_range, commpage_range, false);
+
+    root = read_self_maps();
+
+    /* Read brk after we've read the maps, which will malloc. */
+    brk = (uintptr_t)sbrk(0);
+
+    if (!root) {
+        ret = pgb_find_fallback(&ga, align, brk);
+    } else {
+        /*
+         * Reserve the area close to the host brk.
+         * This will be freed with the rest of the tree.
+         */
+        IntervalTreeNode *b = g_new0(IntervalTreeNode, 1);
+        b->start = brk;
+        b->last = brk + 16 * MiB - 1;
+        interval_tree_insert(b, root);
+
+        ret = pgb_find_itree(&ga, root, align, brk);
+        free_self_maps(root);
+    }
+
+    if (ret == -1) {
+        int w = target_long_bits() / 4;
+
+        error_report("%s: Unable to find a guest_base to satisfy all "
+                     "guest address mapping requirements", image_name);
+
+        for (int i = 0; i < ga.nbounds; ++i) {
+            error_printf("  %0*" VADDR_PRIx "-%0*" VADDR_PRIx "\n",
+                         w, ga.bounds[i].lo,
+                         w, ga.bounds[i].hi);
+        }
+        exit(EXIT_FAILURE);
+    }
+    guest_base = ret;
+}
+
+void probe_guest_base(const char *image_name, const PGBRange *image_range,
+                      const PGBRange *commpage_range)
+{
+    /* In order to use host shmat, we must be able to honor SHMLBA.  */
+    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
+
+    /* Sanity check the guest binary. */
+    if (reserved_va && image_range && image_range->hi > reserved_va) {
+        error_report("%s: requires more than reserved virtual "
+                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
+                     image_name, image_range->hi, reserved_va);
+        exit(EXIT_FAILURE);
+    }
+
+    if (have_guest_base) {
+        pgb_fixed(image_name, image_range, commpage_range, align);
+    } else {
+        pgb_dynamic(image_name, image_range, commpage_range, align);
+    }
+
+    assert(QEMU_IS_ALIGNED(guest_base, align));
+    qemu_log_mask(CPU_LOG_PAGE, "Locating guest address space "
+                  "@ 0x%" PRIx64 "\n", (uint64_t)guest_base);
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ee2df35aa8..b95eea6991 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4,7 +4,6 @@
 
 #include <sys/prctl.h>
 #include <sys/resource.h>
-#include <sys/shm.h>
 
 #include "qemu.h"
 #include "user/tswap-target.h"
@@ -13,8 +12,6 @@
 #include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
 #include "exec/tswap.h"
-#include "user/guest-base.h"
-#include "user/mmap-min-addr.h"
 #include "user-internals.h"
 #include "signal-common.h"
 #include "loader.h"
@@ -25,7 +22,6 @@
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
-#include "user/selfmap.h"
 #include "qemu/lockable.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -758,310 +754,8 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     return sp;
 }
 
-#if !defined(COMMPAGE) && !defined(HAVE_GUEST_COMMPAGE)
-bool init_guest_commpage(void) { return true; }
-#endif
-
-/**
- * pgb_try_mmap:
- * @addr: host start address
- * @addr_last: host last address
- * @keep: do not unmap the probe region
- *
- * Return 1 if [@addr, @addr_last] is not mapped in the host,
- * return 0 if it is not available to map, and -1 on mmap error.
- * If @keep, the region is left mapped on success, otherwise unmapped.
- */
-static int pgb_try_mmap(uintptr_t addr, uintptr_t addr_last, bool keep)
-{
-    size_t size = addr_last - addr + 1;
-    void *p = mmap((void *)addr, size, PROT_NONE,
-                   MAP_ANONYMOUS | MAP_PRIVATE |
-                   MAP_NORESERVE | MAP_FIXED_NOREPLACE, -1, 0);
-    int ret;
-
-    if (p == MAP_FAILED) {
-        return errno == EEXIST ? 0 : -1;
-    }
-    ret = p == (void *)addr;
-    if (!keep || !ret) {
-        munmap(p, size);
-    }
-    return ret;
-}
-
-/**
- * pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t size, uintptr_t brk)
- * @addr: host address
- * @addr_last: host last address
- * @brk: host brk
- *
- * Like pgb_try_mmap, but additionally reserve some memory following brk.
- */
-static int pgb_try_mmap_skip_brk(uintptr_t addr, uintptr_t addr_last,
-                                 uintptr_t brk, bool keep)
-{
-    uintptr_t brk_last = brk + 16 * MiB - 1;
-
-    /* Do not map anything close to the host brk. */
-    if (addr <= brk_last && brk <= addr_last) {
-        return 0;
-    }
-    return pgb_try_mmap(addr, addr_last, keep);
-}
-
-/**
- * pgb_try_mmap_set:
- * @ga: set of guest addrs
- * @base: guest_base
- * @brk: host brk
- *
- * Return true if all @ga can be mapped by the host at @base.
- * On success, retain the mapping at index 0 for reserved_va.
- */
-
-typedef struct PGBAddrs {
-    PGBRange bounds[3];
-    int nbounds;
-} PGBAddrs;
-
-static bool pgb_try_mmap_set(const PGBAddrs *ga, uintptr_t base, uintptr_t brk)
-{
-    for (int i = ga->nbounds - 1; i >= 0; --i) {
-        if (pgb_try_mmap_skip_brk(ga->bounds[i].lo + base,
-                                  ga->bounds[i].hi + base,
-                                  brk, i == 0 && reserved_va) <= 0) {
-            return false;
-        }
-    }
-    return true;
-}
-
-/**
- * pgb_addr_set:
- * @ga: output set of guest addrs
- * @image_range: fixed guest image addresses
- * @identity: create for identity mapping
- *
- * Fill in @ga with the image, COMMPAGE and NULL page.
- */
-static bool pgb_addr_set(PGBAddrs *ga, const PGBRange *image_range,
-                         const PGBRange *commpage_range, bool try_identity)
-{
-    int n;
-
-    /*
-     * With a low commpage, or a guest mapped very low,
-     * we may not be able to use the identity map.
-     */
-    if (try_identity) {
-        if (commpage_range && commpage_range->lo < mmap_min_addr) {
-            return false;
-        }
-        if (image_range && image_range->lo < mmap_min_addr) {
-            return false;
-        }
-    }
-
-    memset(ga, 0, sizeof(*ga));
-    n = 0;
-
-    if (reserved_va) {
-        ga->bounds[n].lo = try_identity ? mmap_min_addr : 0;
-        ga->bounds[n].hi = reserved_va;
-        n++;
-        /* Low COMMPAGE and NULL handled by reserving from 0. */
-    } else {
-        /* Add any low COMMPAGE or NULL page. */
-        if (!try_identity || (commpage_range && commpage_range->lo == 0)) {
-            ga->bounds[n].lo = 0;
-            ga->bounds[n].hi = TARGET_PAGE_SIZE - 1;
-            n++;
-        }
-
-        /* Add the guest image for ET_EXEC. */
-        if (image_range) {
-            ga->bounds[n++] = *image_range;
-        }
-    }
-
-    /* Add any high COMMPAGE not covered by reserved_va. */
-    if (commpage_range && reserved_va < commpage_range->hi) {
-        ga->bounds[n].lo = commpage_range->lo & qemu_real_host_page_mask();
-        ga->bounds[n].hi = commpage_range->hi;
-        n++;
-    }
-
-    ga->nbounds = n;
-    return true;
-}
-
-static void pgb_fail_in_use(const char *image_name)
-{
-    error_report("%s: requires virtual address space that is in use "
-                 "(omit the -B option or choose a different value)",
-                 image_name);
-    exit(EXIT_FAILURE);
-}
-
-static void pgb_fixed(const char *image_name, const PGBRange *image_range,
-                      const PGBRange *commpage_range, uintptr_t align)
-{
-    PGBAddrs ga;
-    uintptr_t brk = (uintptr_t)sbrk(0);
-
-    if (!QEMU_IS_ALIGNED(guest_base, align)) {
-        fprintf(stderr, "Requested guest base %p does not satisfy "
-                "host minimum alignment (0x%" PRIxPTR ")\n",
-                (void *)guest_base, align);
-        exit(EXIT_FAILURE);
-    }
-
-    if (!pgb_addr_set(&ga, image_range, commpage_range, !guest_base)
-        || !pgb_try_mmap_set(&ga, guest_base, brk)) {
-        pgb_fail_in_use(image_name);
-    }
-}
-
-/**
- * pgb_find_fallback:
- *
- * This is a fallback method for finding holes in the host address space
- * if we don't have the benefit of being able to access /proc/self/map.
- * It can potentially take a very long time as we can only dumbly iterate
- * up the host address space seeing if the allocation would work.
- */
-static uintptr_t pgb_find_fallback(const PGBAddrs *ga, uintptr_t align,
-                                   uintptr_t brk)
-{
-    /* TODO: come up with a better estimate of how much to skip. */
-    uintptr_t skip = sizeof(uintptr_t) == 4 ? MiB : GiB;
-
-    for (uintptr_t base = skip; ; base += skip) {
-        base = ROUND_UP(base, align);
-        if (pgb_try_mmap_set(ga, base, brk)) {
-            return base;
-        }
-        if (base >= -skip) {
-            return -1;
-        }
-    }
-}
-
-static uintptr_t pgb_try_itree(const PGBAddrs *ga, uintptr_t base,
-                               IntervalTreeRoot *root)
-{
-    for (int i = ga->nbounds - 1; i >= 0; --i) {
-        uintptr_t s = base + ga->bounds[i].lo;
-        uintptr_t l = base + ga->bounds[i].hi;
-        IntervalTreeNode *n;
-
-        if (l < s) {
-            /* Wraparound. Skip to advance S to mmap_min_addr. */
-            return mmap_min_addr - s;
-        }
-
-        n = interval_tree_iter_first(root, s, l);
-        if (n != NULL) {
-            /* Conflict.  Skip to advance S to LAST + 1. */
-            return n->last - s + 1;
-        }
-    }
-    return 0;  /* success */
-}
-
-static uintptr_t pgb_find_itree(const PGBAddrs *ga, IntervalTreeRoot *root,
-                                uintptr_t align, uintptr_t brk)
-{
-    uintptr_t last = sizeof(uintptr_t) == 4 ? MiB : GiB;
-    uintptr_t base, skip;
-
-    while (true) {
-        base = ROUND_UP(last, align);
-        if (base < last) {
-            return -1;
-        }
-
-        skip = pgb_try_itree(ga, base, root);
-        if (skip == 0) {
-            break;
-        }
-
-        last = base + skip;
-        if (last < base) {
-            return -1;
-        }
-    }
-
-    /*
-     * We've chosen 'base' based on holes in the interval tree,
-     * but we don't yet know if it is a valid host address.
-     * Because it is the first matching hole, if the host addresses
-     * are invalid we know there are no further matches.
-     */
-    return pgb_try_mmap_set(ga, base, brk) ? base : -1;
-}
-
-static void pgb_dynamic(const char *image_name, const PGBRange *image_range,
-                        const PGBRange *commpage_range, uintptr_t align)
-{
-    IntervalTreeRoot *root;
-    uintptr_t brk, ret;
-    PGBAddrs ga;
-
-    /* Try the identity map first. */
-    if (pgb_addr_set(&ga, image_range, commpage_range, true)) {
-        brk = (uintptr_t)sbrk(0);
-        if (pgb_try_mmap_set(&ga, 0, brk)) {
-            guest_base = 0;
-            return;
-        }
-    }
-
-    /*
-     * Rebuild the address set for non-identity map.
-     * This differs in the mapping of the guest NULL page.
-     */
-    pgb_addr_set(&ga, image_range, commpage_range, false);
-
-    root = read_self_maps();
-
-    /* Read brk after we've read the maps, which will malloc. */
-    brk = (uintptr_t)sbrk(0);
-
-    if (!root) {
-        ret = pgb_find_fallback(&ga, align, brk);
-    } else {
-        /*
-         * Reserve the area close to the host brk.
-         * This will be freed with the rest of the tree.
-         */
-        IntervalTreeNode *b = g_new0(IntervalTreeNode, 1);
-        b->start = brk;
-        b->last = brk + 16 * MiB - 1;
-        interval_tree_insert(b, root);
-
-        ret = pgb_find_itree(&ga, root, align, brk);
-        free_self_maps(root);
-    }
-
-    if (ret == -1) {
-        int w = TARGET_LONG_BITS / 4;
-
-        error_report("%s: Unable to find a guest_base to satisfy all "
-                     "guest address mapping requirements", image_name);
-
-        for (int i = 0; i < ga.nbounds; ++i) {
-            error_printf("  %0*" VADDR_PRIx "-%0*" VADDR_PRIx "\n",
-                         w, ga.bounds[i].lo,
-                         w, ga.bounds[i].hi);
-        }
-        exit(EXIT_FAILURE);
-    }
-    guest_base = ret;
-}
-
-void probe_guest_base(const char *image_name, const PGBRange *image_range)
+void linux_probe_guest_base(const char *image_name,
+                            const PGBRange *image_range)
 {
 #ifdef COMMPAGE
     const PGBRange * const commpage_range = &(PGBRange){
@@ -1071,32 +765,15 @@ void probe_guest_base(const char *image_name, const PGBRange *image_range)
     const PGBRange * const commpage_range = NULL;
 #endif
 
-    /* In order to use host shmat, we must be able to honor SHMLBA.  */
-    uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
-
-    /* Sanity check the guest binary. */
-    if (reserved_va && image_range && image_range->hi > reserved_va) {
-        error_report("%s: requires more than reserved virtual "
-                     "address space (0x%" VADDR_PRIx " > 0x%lx)",
-                     image_name, image_range->hi, reserved_va);
-        exit(EXIT_FAILURE);
-    }
-
-    if (have_guest_base) {
-        pgb_fixed(image_name, image_range, commpage_range, align);
-    } else {
-        pgb_dynamic(image_name, image_range, commpage_range, align);
-    }
+    probe_guest_base(image_name, image_range, commpage_range);
 
     /* Reserve and initialize the commpage. */
+#if defined(COMMPAGE) || defined(HAVE_GUEST_COMMPAGE)
     if (!init_guest_commpage()) {
         /* We have already probed for the commpage being free. */
         g_assert_not_reached();
     }
-
-    assert(QEMU_IS_ALIGNED(guest_base, align));
-    qemu_log_mask(CPU_LOG_PAGE, "Locating guest address space "
-                  "@ 0x%" PRIx64 "\n", (uint64_t)guest_base);
+#endif
 }
 
 enum {
@@ -1345,10 +1022,10 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Make sure that the low address does not conflict with
              * MMAP_MIN_ADDR or the QEMU application itself.
              */
-            probe_guest_base(image_name, &range);
+            linux_probe_guest_base(image_name, &range);
         } else {
             /* The binary is dynamic; we still need to select guest_base. */
-            probe_guest_base(image_name, NULL);
+            linux_probe_guest_base(image_name, NULL);
 
             /*
              * Avoid collision with the loader by providing a different
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 45d69040c6..a551f083a4 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -261,7 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     /*
      * Allocate the address space.
      */
-    probe_guest_base(bprm->filename, NULL);
+    linux_probe_guest_base(bprm->filename, NULL);
 
     /*
      * there are a couple of cases here,  the separate code/data
diff --git a/common-user/meson.build b/common-user/meson.build
index 5e041de55e..2d4ffe07d3 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -6,6 +6,7 @@ common_user_inc += include_directories('host/' / host_arch)
 
 user_ss.add(files(
   'mmap-min-addr.c',
+  'probe-guest-base.c',
   'safe-syscall.S',
   'safe-syscall-error.c',
   'selfmap.c',
-- 
2.43.0


