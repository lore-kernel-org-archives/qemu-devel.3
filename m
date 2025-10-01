Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D63CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4158-0004Lk-Fp; Wed, 01 Oct 2025 13:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4150-0004BB-Cv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414A-0001Hz-Q0
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so53249f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341389; x=1759946189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUtiRAnaxKSP60r/7sUloA0VCWrW5xNC9QAgYTiLe7A=;
 b=oN92jdeBT/WhBqcZmieCO0B55/l14XTsug2VMKJVsSPoLnDjqClS58dzt+WB9aXNZG
 E5dbhY5J5AjSe3tsrMMM7/pRo4L0/mxOh1RvTZjacSrXlyB8PKXfnMcNbM4DM4hPWhu9
 IJMJcWUE6qFIVPgKuvL/kinBbTLeqJ9rvX68Ujt60JfLIIyIG1FpcAFvX5PGMAkzO8Yf
 ata2XMCwUggJhXoaqfxrDs0hB6pvsI3aM279ugdhEpNgnKAWdOHQXOP7j0jZaff2SEl3
 3WjnDgipXldyCJCFK0TvmAKn6/g+GVMe2Zpp3VOGoUM50hlGWwe+T83Osw7IlgN8T4Iz
 JhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341389; x=1759946189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUtiRAnaxKSP60r/7sUloA0VCWrW5xNC9QAgYTiLe7A=;
 b=EVk5KkbRlncOvFDIfdIypCTucdiPBgUN+ouvE1zTwwxgacWMkS3qm0/vL8RoA1+XPe
 h4QBGhKsSqkx88+jhduuQSLjf4epVgElP53XZjT609EMPJW3jFZUM0zPBU20elG8ROeO
 FtL7Vsf3u05CEXwzBH314odurnXwZAaspql+odO6pQMMxgRJlsdc37AQ/VazjexXLJs0
 NedyycUFT7PaSp0dMhaUAmv1Crdiq0hdPOF+UahFWssgeek5VwjmoVGyO8Wj83qFZyxU
 CfRKKPIllTiQojFy7MLgx4phLRGUX0JbEeJLQjVIQgkIu7HgMCIzSxXXIgiPww1F2bJY
 +mrg==
X-Gm-Message-State: AOJu0YybCanAuhWN7qE9FzrzC+EVGaD+LdvyX+GRMJ2F+RhgTRSF6EXN
 J97ZrFc8HAsHl3xsMCOyW2wOAcMspzYoyNRlXDW7kbR50gYZ2afl3Lsm2iKHBWM6NclzczbBPAx
 wGjKVnjXtnQ==
X-Gm-Gg: ASbGncs88vxmm/q1tPXHMRHx7g44Koz6Txt7E3MXTtc5i8U6iTvrzz6U21Ug/8VMTTg
 GH/bXdKwY2TIgZKr1rYc1o52Peh52xYelMFC2P4mHurHl1VjWOq8XxXxCWtX6+gd1ZIV3t8jUDU
 twvTCk9q5qYESvxr6TAY3C8bEolLyw0PzRdJOzFgNKhBDPrRvYBg2MBTeGMjSlnN2nUJy1tI8Av
 Ouy2XHMjbUoMgS4YGjGdb6PtcIHHF5AsBwxRtS4SI9NuMpA0VWUVc2vnhyQj1kwin0kR9SQ4GPI
 5TCF96rzqcqxConaYOEsGiaiWuCsg0TBeKppA38rRdidJwpKtVa9Dpt/TYUZhYiJkQGjsb50sVG
 YikDTAdzQX/RQ5/SOaMZJzSAsx4aMUKEna0n9KcB2yJd/pbYy/qtX+rXlj3UDxQ0xLr3DOjVahk
 /t8Coo8r2PrWFKIJgfLlEckATVqA==
X-Google-Smtp-Source: AGHT+IF0ungF9viXC6MKUWoQtqH2uObDCFonrlzlTjU4n+Y3xL+pmh4m+aKa0XRbNR5Tcqmh1HV/fg==
X-Received: by 2002:a5d:588b:0:b0:3e7:610b:85f6 with SMTP id
 ffacd0b85a97d-42557824eecmr3638647f8f.39.1759341388635; 
 Wed, 01 Oct 2025 10:56:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a265f6sm48392605e9.20.2025.10.01.10.56.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:56:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 18/18] system/physmem: Extract API out of
 'system/ram_addr.h' header
Date: Wed,  1 Oct 2025 19:54:47 +0200
Message-ID: <20251001175448.18933-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Very few files use the Physical Memory API. Declare its
methods in their own header: "system/physmem.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                 |  1 +
 include/system/physmem.h    | 54 +++++++++++++++++++++++++++++++++++++
 include/system/ram_addr.h   | 40 ---------------------------
 accel/kvm/kvm-all.c         |  2 +-
 accel/tcg/cputlb.c          |  1 +
 hw/vfio/container-legacy.c  |  2 +-
 hw/vfio/container.c         |  1 +
 hw/vfio/listener.c          |  1 -
 migration/ram.c             |  1 +
 system/memory.c             |  1 +
 system/physmem.c            |  1 +
 target/arm/tcg/mte_helper.c |  2 +-
 12 files changed, 63 insertions(+), 44 deletions(-)
 create mode 100644 include/system/physmem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 406cef88f0c..9632eb7b440 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3213,6 +3213,7 @@ S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
+F: include/system/physmem.h
 F: include/system/ram_addr.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
diff --git a/include/system/physmem.h b/include/system/physmem.h
new file mode 100644
index 00000000000..879f6eae38b
--- /dev/null
+++ b/include/system/physmem.h
@@ -0,0 +1,54 @@
+/*
+ * QEMU physical memory interfaces (target independent).
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_SYSTEM_PHYSMEM_H
+#define QEMU_SYSTEM_PHYSMEM_H
+
+#include "exec/hwaddr.h"
+#include "exec/ramlist.h"
+
+#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
+#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
+
+bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
+
+bool physical_memory_is_clean(ram_addr_t addr);
+
+uint8_t physical_memory_range_includes_clean(ram_addr_t start,
+                                             ram_addr_t length,
+                                             uint8_t mask);
+
+void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
+
+void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
+                                     uint8_t mask);
+
+/*
+ * Contrary to physical_memory_sync_dirty_bitmap() this function returns
+ * the number of dirty pages in @bitmap passed as argument. On the other hand,
+ * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * weren't set in the global migration bitmap.
+ */
+uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+                                            ram_addr_t start,
+                                            ram_addr_t pages);
+
+void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
+
+bool physical_memory_test_and_clear_dirty(ram_addr_t start,
+                                          ram_addr_t length,
+                                          unsigned client);
+
+DirtyBitmapSnapshot *
+physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
+                                         hwaddr length, unsigned client);
+
+bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+                                        ram_addr_t start,
+                                        ram_addr_t length);
+
+#endif
diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 3894a84fb9c..683485980ce 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,7 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "exec/ramlist.h"
 #include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "exec/hwaddr.h"
@@ -133,43 +132,4 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
     qemu_ram_msync(block, 0, block->used_length);
 }
 
-#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
-#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
-
-bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
-
-bool physical_memory_is_clean(ram_addr_t addr);
-
-uint8_t physical_memory_range_includes_clean(ram_addr_t start,
-                                                 ram_addr_t length,
-                                                 uint8_t mask);
-
-void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
-
-void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
-                                         uint8_t mask);
-
-/*
- * Contrary to physical_memory_sync_dirty_bitmap() this function returns
- * the number of dirty pages in @bitmap passed as argument. On the other hand,
- * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
- * weren't set in the global migration bitmap.
- */
-uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
-                                                ram_addr_t start,
-                                                ram_addr_t pages);
-
-void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
-
-bool physical_memory_test_and_clear_dirty(ram_addr_t start,
-                                              ram_addr_t length,
-                                              unsigned client);
-
-DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
-    (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
-
-bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
-                                            ram_addr_t start,
-                                            ram_addr_t length);
-
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a7ece7db964..58802f7c3cc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -32,13 +32,13 @@
 #include "system/runstate.h"
 #include "system/cpus.h"
 #include "system/accel-blocker.h"
+#include "system/physmem.h"
 #include "system/ramblock.h"
 #include "accel/accel-ops.h"
 #include "qemu/bswap.h"
 #include "exec/tswap.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
-#include "system/ram_addr.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a721235dea6..7214d41cb5d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -25,6 +25,7 @@
 #include "accel/tcg/probe.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
+#include "system/physmem.h"
 #include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/cputlb.h"
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index eb9911eaeaf..755a407f3e7 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -25,7 +25,7 @@
 #include "hw/vfio/vfio-device.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "system/ram_addr.h"
+#include "system/physmem.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "system/reset.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3fb19a1c8ad..9ddec300e35 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -20,6 +20,7 @@
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio/vfio-device.h" /* vfio_device_reset_handler */
+#include "system/physmem.h"
 #include "system/reset.h"
 #include "vfio-helpers.h"
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index b5cefc9395c..c6bb58f5209 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -30,7 +30,6 @@
 #include "hw/vfio/pci.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "system/ram_addr.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/migration/ram.c b/migration/ram.c
index d09591c0600..12122dda685 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -53,6 +53,7 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 #include "system/cpu-throttle.h"
+#include "system/physmem.h"
 #include "system/ramblock.h"
 #include "savevm.h"
 #include "qemu/iov.h"
diff --git a/system/memory.c b/system/memory.c
index dd045da60c0..80656c69568 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -25,6 +25,7 @@
 #include "qemu/target-info.h"
 #include "qom/object.h"
 #include "trace.h"
+#include "system/physmem.h"
 #include "system/ram_addr.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
diff --git a/system/physmem.c b/system/physmem.c
index 1a075da2bdd..ec3d8027e86 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -43,6 +43,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "system/qtest.h"
+#include "system/physmem.h"
 #include "system/ramblock.h"
 #include "qemu/timer.h"
 #include "qemu/config-file.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 077ff4b2b2c..b96c953f809 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -27,7 +27,7 @@
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
 #else
-#include "system/ram_addr.h"
+#include "system/physmem.h"
 #endif
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
-- 
2.51.0


