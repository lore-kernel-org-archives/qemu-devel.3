Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A4BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s95-0003p2-O4; Wed, 01 Oct 2025 04:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s8r-0002kH-6V
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7q-0006h9-W8
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e501a9034so21623485e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759307025; x=1759911825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UO9Z4GKWaIosFTRHzbHFaFZFTr7IEOVGgy8hYFFsW+g=;
 b=DEcF/j/eFGqxwPhlTAy7l7Yln1LyIAbHJOGAFgs6M435YFKg/R1egrEQcN7uqBxWP/
 TQcEA3o3UtzFG0nKcDrV1ZSjxEZ/ixqtywIQy8eriJRnsCmVEJIuea/1zNvSgW8AlJQt
 QBUzGkofB/ummQnWHsHFSVoV69M/2zo+kU/DN2HEJyKyLQEg3JSClgZ+yXce6BN3ZYaP
 Rb9e3bF1NLouhlV+jGROxtcZ/H4vBD6FXj0gms7HmUckGDQ+qorfjPBl1y4IZYktpm++
 9LAOqdLeX96Qn0fJendjPp2zsIiduKToUf5aiqFn1+i6HXyXf0sniWXPPszCK64ps+Ez
 Ajrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759307025; x=1759911825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UO9Z4GKWaIosFTRHzbHFaFZFTr7IEOVGgy8hYFFsW+g=;
 b=Q/raFHZBW+nIvoF1c9qKo9HTT33wuHmePvbZpV14JVRhpvKeQ5Z2ZC74SQBoU6yqJY
 +x8U7guNUg5WjPHP5NoPEDHZPtm4Z9S43R2GjNIDBNQHhRjTpvQ0cBIfnedUbOlePTI1
 AiSPbJBCWxJw9BeGYve2Ajty52sskSbKYt9KLh9tdWrCDwZVaIp5zAoYgo9HRRqz3bi+
 NJK9lmSv5DFatO6Wuwd73I5LmGL0unReGoPPlihLVakZIBxOeGXDV96y2IaeTunfscs2
 d4+vXnmBoAZPjJTy+AIe2v3/vCvHNYnT+gYA1Vxjr9vrY72brqrBy6pum1ZST93IM7OS
 Sctg==
X-Gm-Message-State: AOJu0Yz5x3v2fG9FTlx+PPIM/dtOUPRNZDzwnmnrrem7VOLxeSnvhVNe
 YFirk6lX3h9CN38r3D+e3GAjWGWKvQg5bVWoY5EySYiBlLE6jwqFzu9N6Fq1TZHhynwOiRF4Uos
 aHJw+/jeAWQ==
X-Gm-Gg: ASbGncuZyAdlQEyd+lwr6vYWUaJLeNx9/X0c3B/PbPkuYpOKGhD0yAy4IM6Lh+KzeNR
 WN+a+Wt5jSygQi3o4va9MiM5/DiaasIxD9t2q/xzcCNUic6zDJo4rejhq/0VwPXSUU3uYCuIS3z
 iZ3+sLWU0bw2Oh+vuuhCek19HNXRsOJxha8AsOMqOxaEDbjZ6SoSnowKWCliELnPb3rFeenyhAy
 TSuX7mp5iVNCbadaugKgZHEXWRqSemFDIvHtN/+NU7Q+wdsoBIFH4hrtS4ncglf1YjLHNVwUdRC
 oLAXhMMyfDffzRCubtvD7vqjaDf5e4rtHh2GEhW6RMUhgl3fdGHKkFjqmxVkjI/w6SIgmADcXIb
 EZGPlFnvQ9in7F4CxgYc5+4S/pdSFeoK+LHtLvF3DgmB5XPvU7uwU97racV7rFD0lQd0EKVCr0F
 Pe0ZLUBp6IyxzPM804sPeA3Vkrhc9s77s=
X-Google-Smtp-Source: AGHT+IFtxY40tW31NbHANJrw8uPERV9eGTJ6/FDL0Ox5O64nmtRj5TVEThXt88q9V8X5bv6p5WBmeg==
X-Received: by 2002:a05:600c:6216:b0:46e:44bf:210 with SMTP id
 5b1f17b1804b1-46e61267be4mr20282665e9.22.1759307025338; 
 Wed, 01 Oct 2025 01:23:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc7d3780asm26055291f8f.52.2025.10.01.01.23.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:23:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 25/25] system/physmem: Extract API out of 'system/ram_addr.h'
 header
Date: Wed,  1 Oct 2025 10:21:25 +0200
Message-ID: <20251001082127.65741-26-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
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

Very few files use the Physical Memory API. Declare its
methods in their own header: "system/physmem.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                 |  1 +
 include/system/physmem.h    | 56 +++++++++++++++++++++++++++++++++++++
 include/system/ram_addr.h   | 42 ----------------------------
 accel/kvm/kvm-all.c         |  2 +-
 accel/tcg/cputlb.c          |  1 +
 hw/vfio/container-legacy.c  |  2 +-
 hw/vfio/container.c         |  1 +
 hw/vfio/listener.c          |  1 -
 migration/ram.c             |  1 +
 system/memory.c             |  1 +
 system/physmem.c            |  1 +
 target/arm/tcg/mte_helper.c |  2 +-
 12 files changed, 65 insertions(+), 46 deletions(-)
 create mode 100644 include/system/physmem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d134a85e66..866b43434c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3206,6 +3206,7 @@ S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
+F: include/system/physmem.h
 F: include/system/ram_addr.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
diff --git a/include/system/physmem.h b/include/system/physmem.h
new file mode 100644
index 00000000000..7ae266729d2
--- /dev/null
+++ b/include/system/physmem.h
@@ -0,0 +1,56 @@
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
+uint8_t physical_memory_range_includes_clean(ram_addr_t addr,
+                                             ram_addr_t length,
+                                             uint8_t mask);
+
+void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
+
+void physical_memory_set_dirty_range(ram_addr_t addr, ram_addr_t length,
+                                     uint8_t mask);
+
+#if !defined(_WIN32)
+/*
+ * Contrary to physical_memory_sync_dirty_bitmap() this function returns
+ * the number of dirty pages in @bitmap passed as argument. On the other hand,
+ * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * weren't set in the global migration bitmap.
+ */
+uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+                                            ram_addr_t start,
+                                            ram_addr_t pages);
+#endif /* not _WIN32 */
+
+void physical_memory_dirty_bits_cleared(ram_addr_t addr, ram_addr_t length);
+
+bool physical_memory_test_and_clear_dirty(ram_addr_t addr,
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
index 015f943603b..683485980ce 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -19,7 +19,6 @@
 #ifndef SYSTEM_RAM_ADDR_H
 #define SYSTEM_RAM_ADDR_H
 
-#include "exec/ramlist.h"
 #include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "exec/hwaddr.h"
@@ -133,45 +132,4 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
     qemu_ram_msync(block, 0, block->used_length);
 }
 
-#define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
-#define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
-
-bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
-
-bool physical_memory_is_clean(ram_addr_t addr);
-
-uint8_t physical_memory_range_includes_clean(ram_addr_t addr,
-                                                 ram_addr_t length,
-                                                 uint8_t mask);
-
-void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
-
-void physical_memory_set_dirty_range(ram_addr_t addr, ram_addr_t length,
-                                         uint8_t mask);
-
-#if !defined(_WIN32)
-/*
- * Contrary to physical_memory_sync_dirty_bitmap() this function returns
- * the number of dirty pages in @bitmap passed as argument. On the other hand,
- * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
- * weren't set in the global migration bitmap.
- */
-uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
-                                                ram_addr_t start,
-                                                ram_addr_t pages);
-#endif /* not _WIN32 */
-
-void physical_memory_dirty_bits_cleared(ram_addr_t addr, ram_addr_t length);
-
-bool physical_memory_test_and_clear_dirty(ram_addr_t addr,
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
index 1f5dd023a0a..8e1ec7ab1af 100644
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
index db745f2a028..21b8c78fa91 100644
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
index 784c2810964..b245cd14d43 100644
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


