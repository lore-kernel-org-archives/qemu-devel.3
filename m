Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1588C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZ0-0001qx-13; Tue, 18 Mar 2025 17:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY2-0001IQ-1u
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXy-0000mQ-3X
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223fd89d036so123812635ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333545; x=1742938345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGIsJ49PlQz0cO++UliO79dMkBrOAt4xODayzQ//uqA=;
 b=ljFzHrQXYlNh1481KTWkSjDoSbdhGHGRkPn8Hku/mLcHGF2JMlYZ+z/YPFlaZh/9Dl
 2YAg8rjZmUSLoMz1oA5JVlSw2gq12aLEjlr0L/nlWsUdEEqHDRoOdGkZkGiNNn0pi6Ef
 t2XVlBv2LCfGGaKUEwIyOpkqqvW3iL08Ti/liLY/JTvmCuin72qWkobS/qalSXPgTemw
 0bX578swp9pYkHnada5nlqyn3pmRqOhWFPhX3TaA4ztC5mEhSNKZd72aUwlh3Tw918lO
 AHmu8kixQ66IMAPNmHNo88IJUDBwDiGDFVEzywrDkKiZSDny0u3QFgM21q+BzQSgzpvQ
 qHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333545; x=1742938345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGIsJ49PlQz0cO++UliO79dMkBrOAt4xODayzQ//uqA=;
 b=H2vMn2ci0Sl2EGvZL0zAZsnrxbQh/RETzw6c1eyJaSaLvRFK2DHK4S3P9SGE2IGLZH
 tNNEOvWR2ReRTOAa8m0ZU5z53VVhkO7HKhqWfgFKThcHCuWc3KrDTPfs5L6aHUG939+j
 9F9ZBYtbPCFqVW21r9q8rd1HC1DnbXLdx0o6Kui/dqVlJPqACH3RrYWNmuYwUg8MHvYQ
 Q643otr5vQRXKGraCyj5dOnd8NS4Q0jDciiVcArdXpk4Jalr39/LlSvRxx9a+DbgkuJB
 vENgNE9ql87L/1OmdZ8JkerGkQqtF9lsBvSaieMc9AovGoV8WYAUsZuCoZvOhZuDQgns
 HNIA==
X-Gm-Message-State: AOJu0YwzetksgeVT8S9wUPXgt3QGDh21Q567Bqvcr5kXtLzGaSfpYh3Y
 +AfCQCbEsY0wnzE9de5cespYymP12vTz5rR9DQTH6alY9/3v6zTkzeHYuWzJokoNFtKiWpnIMBC
 R
X-Gm-Gg: ASbGnctmjcRByu8BZc20a6ZE3PRscGLei0RLaym7mHzSPrLlOFICOGhUq408LFNsagD
 fCmtOcUDiGSCd8r3YgJGOiuOKc0F6Njm+TIanMEXFTaKCtGca9rFwMT88EUVO0y8ZHfv7N+mvqg
 4nJsdhSM1vtWoy+uv4r4aYVIim9yPo1yKcKKWyhGnSQ9iuOZIjilBjmvFHQwJAr+FoV5reFBfY/
 AYqRfpV7gtHTuaBUUJPBcj3czjOCMDvpPkUKtPF56SHwVP9ntOoCC6vL3gBIFvGxFEeoTgm1Dvf
 ldNEi5OO+2kDf5W/Gymq0gu7xWNpSEt0XIWHeLL2ZxNSZb6CR093ScuEEo7EPPpAu6s5GE0roGB
 K
X-Google-Smtp-Source: AGHT+IFWUuJSqm5j/4nXXs0FpLCg5YF++jVafSje9b07oejV6dcyo/4EBjeD8ra2W5nQN7q0A/YAZA==
X-Received: by 2002:a05:6a21:6e49:b0:1f5:75a9:5255 with SMTP id
 adf61e73a8af0-1fbed40cbe6mr281728637.39.1742333544594; 
 Tue, 18 Mar 2025 14:32:24 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 19/42] include/system: Move exec/ram_addr.h to
 system/ram_addr.h
Date: Tue, 18 Mar 2025 14:31:44 -0700
Message-ID: <20250318213209.2579218-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Convert the existing includes with sed.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{exec => system}/ram_addr.h | 7 +++----
 accel/kvm/kvm-all.c                 | 2 +-
 accel/tcg/cputlb.c                  | 2 +-
 accel/tcg/translate-all.c           | 2 +-
 hw/ppc/spapr.c                      | 2 +-
 hw/ppc/spapr_caps.c                 | 2 +-
 hw/ppc/spapr_pci.c                  | 2 +-
 hw/remote/memory.c                  | 2 +-
 hw/remote/proxy-memory-listener.c   | 2 +-
 hw/s390x/s390-stattrib-kvm.c        | 2 +-
 hw/s390x/s390-stattrib.c            | 2 +-
 hw/s390x/s390-virtio-ccw.c          | 2 +-
 hw/vfio/common.c                    | 3 +--
 hw/vfio/container.c                 | 2 +-
 hw/vfio/spapr.c                     | 2 +-
 hw/virtio/virtio-mem.c              | 2 +-
 migration/ram.c                     | 2 +-
 system/memory.c                     | 2 +-
 system/physmem.c                    | 2 +-
 target/arm/tcg/mte_helper.c         | 2 +-
 target/ppc/kvm.c                    | 2 +-
 target/s390x/kvm/kvm.c              | 2 +-
 MAINTAINERS                         | 2 +-
 23 files changed, 25 insertions(+), 27 deletions(-)
 rename include/{exec => system}/ram_addr.h (99%)

diff --git a/include/exec/ram_addr.h b/include/system/ram_addr.h
similarity index 99%
rename from include/exec/ram_addr.h
rename to include/system/ram_addr.h
index 8677761af5..3b81c3091f 100644
--- a/include/exec/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -16,10 +16,9 @@
  * The functions declared here will be removed soon.
  */
 
-#ifndef RAM_ADDR_H
-#define RAM_ADDR_H
+#ifndef SYSTEM_RAM_ADDR_H
+#define SYSTEM_RAM_ADDR_H
 
-#ifndef CONFIG_USER_ONLY
 #include "system/xen.h"
 #include "system/tcg.h"
 #include "exec/cputlb.h"
@@ -559,5 +558,5 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
 
     return num_dirty;
 }
-#endif
+
 #endif
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0d47bb0d9b..0723a3933b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -34,7 +34,7 @@
 #include "system/accel-blocker.h"
 #include "qemu/bswap.h"
 #include "system/memory.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
 #include "trace.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6f0ea9067b..134e523cab 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -27,7 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
 #include "exec/vaddr.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 16e5043597..167535bcb1 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -40,7 +40,7 @@
 #endif
 #endif
 #else
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #endif
 
 #include "exec/cputlb.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a415e51d07..7ae7122093 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -77,7 +77,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost-scsi-common.h"
 
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "system/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 815c94ed2f..f2f5722d8a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "system/hw_accel.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e0a9d50edc..384269b831 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -34,7 +34,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include <libfdt.h>
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/hw/remote/memory.c b/hw/remote/memory.c
index 6d60da91e0..00193a552f 100644
--- a/hw/remote/memory.c
+++ b/hw/remote/memory.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/remote/memory.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "qapi/error.h"
 
 static void remote_sysmem_reset(void)
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index ce7f5b9bfb..30ac74961d 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -12,7 +12,7 @@
 #include "qemu/range.h"
 #include "system/memory.h"
 #include "exec/cpu-common.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/remote/mpqemu-link.h"
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 2a8e31718b..f5695b0e53 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -16,7 +16,7 @@
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/memory_mapping.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index be07c28c6e..d95b58a8a8 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -16,7 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "cpu.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 75b32182eb..81e570905e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "system/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/s390x/sclp.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 98832af88d..bae0633c3d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -29,8 +29,7 @@
 #include "hw/vfio/pci.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "exec/ram_addr.h"
-#include "exec/target_page.h"
+#include "system/ram_addr.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2e993c7e73..812d5edbcf 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -25,7 +25,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "system/reset.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c9a7dd8d68..66a2d2bb0d 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -17,7 +17,7 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 5f57eccbb6..c7968ee0c6 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -24,7 +24,7 @@
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f1..6295f675df 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -48,7 +48,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
diff --git a/system/memory.c b/system/memory.c
index a4185ea353..6a5d853071 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -26,7 +26,7 @@
 #include "trace.h"
 
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
diff --git a/system/physmem.c b/system/physmem.c
index 2850e14780..765d195cb0 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -67,7 +67,7 @@
 #include "system/replay.h"
 
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 
 #include "qemu/pmem.h"
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 5d6d8a17ae..80164a8050 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -27,7 +27,7 @@
 #include "user/cpu_loop.h"
 #include "user/page-protection.h"
 #else
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #endif
 #include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 992356cb75..8b12b8e7d2 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -41,7 +41,7 @@
 #include "trace.h"
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "system/hostmem.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4d56e653dd..b9f1422197 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -41,7 +41,7 @@
 #include "system/runstate.h"
 #include "system/device_tree.h"
 #include "gdbstub/enums.h"
-#include "exec/ram_addr.h"
+#include "system/ram_addr.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 9a702ff636..3e1af7e1b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3107,7 +3107,7 @@ S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
-F: include/exec/ram_addr.h
+F: include/system/ram_addr.h
 F: include/exec/ramblock.h
 F: include/system/memory_mapping.h
 F: system/dma-helpers.c
-- 
2.43.0


