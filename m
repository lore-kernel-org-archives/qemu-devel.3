Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31614D637D5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 01:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBOTZ-0004iB-5O; Wed, 13 Nov 2024 20:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOTG-00039o-Mk
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:30 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBOTC-00035S-O7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 20:16:30 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-382171e1a83so137267f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 17:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731546985; x=1732151785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/i7abgIX+3ynadFwtVOHIgRvjRLqB047FgJOUkSoXwQ=;
 b=fMp5Q3OUwLpYyOYouxgBoZr673RHgWhi3VwT1HcYemLC+aCGHz2G0czLr6D9Yjwhye
 GhcsQGttm8NANIXVKCBF1vVB4ImCO+7D0ihYmgFYhdv0IU/GMHj+OHh1dcH0sXiMOwrY
 JMO185I3zDHj7YOfAXusSyB+zkqp42qsKEboWBteSguXQm5V5TODhWSoHMJcsUAkYb1X
 TYjyhUIK/miJAnwwl0m0q+z9i+Bhax9FMjUdXOBKh43HnroeVB3epKjGadFLOCvRv00V
 RCeg9ywd0A91VvWjayd9y6kzgU2MpdfYaLcndIdKAIZVnqEFG1Vxqmg3Y7TmG54xZH/c
 iP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731546985; x=1732151785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/i7abgIX+3ynadFwtVOHIgRvjRLqB047FgJOUkSoXwQ=;
 b=hSiFz1DcB6cFjqe/6Sl+oGs2nC/IQ/5KBO5XEyoujtT644DEY73jY3E8G46kasfyIb
 aDyXktjO15fBesShal0Qyq++rM/8el+XLCzNjBeNWcyyzooGGmryZfQvQQ+FmDYYcCIV
 ExqHgySYOgShp5UxGbsA56NTZFAHPuSljYIyOxh789wHCpSWtwQ0Y6G/GtCoqhsWlzNd
 nlaba4YeuPZ4ZV6fAie7cKQ9JPXKdMM0f0NOg/nQgvYlNp8+W7JK55gkKoMOG/sjcDTh
 lw+IwIWC17qVMXu+q12+8l5t7yFkBs7pGDeNC0L0ASq3/v6fLVZmsExbXOvcHc29o9Uk
 XJ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqhPjS9uDX+H6dVGhHNJVQ47YkOZHwcr9PUHAuQXeEH7jX6SX6VPwNr032rrPKJfz25fffq/nSxH9j@nongnu.org
X-Gm-Message-State: AOJu0YzGYXsK0vOf+jm/+wmciKh0O3Upq+cey8HJ4COPGO7/YeUESZ9z
 6ATZDcldxwqmgSwBGlhnIS7m88V6W4X2H+hFWGqHNh9MPch9jkV3HyyOPxaRQ+M=
X-Google-Smtp-Source: AGHT+IFCBCAt12OLqgLDDZHzh68q86+ysDJJZpWlHumLNgL12t17vmSl5EE0M1zOwpQgowR0MbnrnA==
X-Received: by 2002:a05:6000:2a3:b0:371:6fc7:d45d with SMTP id
 ffacd0b85a97d-38213ff978fmr981104f8f.2.1731546984697; 
 Wed, 13 Nov 2024 17:16:24 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda137dbsm19426371f8f.110.2024.11.13.17.16.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Nov 2024 17:16:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 24/24] exec: Move 'ram_addr.h' header under sysemu/ namespace
Date: Thu, 14 Nov 2024 02:13:09 +0100
Message-ID: <20241114011310.3615-25-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114011310.3615-1-philmd@linaro.org>
References: <20241114011310.3615-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

"ram_addr.h" contains declarations specific to system emulation,
move it under the sysemu/ directory to clarify the API namespace.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                         | 2 +-
 include/exec/cpu-common.h           | 2 +-
 include/exec/memory.h               | 2 +-
 include/exec/translation-block.h    | 2 +-
 include/sysemu/physmem-target.h     | 2 +-
 include/{exec => sysemu}/ram_addr.h | 0
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
 hw/vfio/common.c                    | 2 +-
 hw/vfio/container.c                 | 2 +-
 hw/vfio/iommufd.c                   | 2 +-
 hw/vfio/migration.c                 | 2 +-
 hw/vfio/spapr.c                     | 2 +-
 hw/virtio/virtio-mem.c              | 2 +-
 migration/ram.c                     | 2 +-
 plugins/api.c                       | 2 +-
 system/memory.c                     | 2 +-
 system/physmem.c                    | 2 +-
 target/arm/tcg/mte_helper.c         | 2 +-
 target/ppc/kvm.c                    | 2 +-
 target/s390x/kvm/kvm.c              | 2 +-
 30 files changed, 29 insertions(+), 29 deletions(-)
 rename include/{exec => sysemu}/ram_addr.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0027e56fa5..f303f73534 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3024,10 +3024,10 @@ S: Supported
 F: include/exec/ioport.h
 F: include/exec/memop.h
 F: include/exec/memory.h
-F: include/exec/ram_addr.h
 F: include/exec/ramblock.h
 F: include/sysemu/memory_mapping.h
 F: include/sysemu/physmem-target.h
+F: include/sysemu/ram_addr.h
 F: system/dma-helpers.c
 F: system/ioport.c
 F: system/memory.c
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b790202c56..27f047b13b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -54,7 +54,7 @@ enum device_endian {
 #define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
 #endif
 
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 
 /**
  * cpu_address_space_init:
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 58faa3eb08..b2e2d4590a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -28,7 +28,7 @@
 #include "qemu/notify.h"
 #include "qom/object.h"
 #include "qemu/rcu.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 9c4757882c..b72fcbbb18 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -8,7 +8,7 @@
 #define EXEC_TRANSLATION_BLOCK_H
 
 #include "qemu/thread.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "exec/vaddr.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu/interval-tree.h"
diff --git a/include/sysemu/physmem-target.h b/include/sysemu/physmem-target.h
index b30c42da60..32efaf80b6 100644
--- a/include/sysemu/physmem-target.h
+++ b/include/sysemu/physmem-target.h
@@ -23,7 +23,7 @@
 #include "sysemu/xen.h"
 #include "sysemu/tcg.h"
 #include "exec/cputlb.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
 #include "qemu/rcu.h"
diff --git a/include/exec/ram_addr.h b/include/sysemu/ram_addr.h
similarity index 100%
rename from include/exec/ram_addr.h
rename to include/sysemu/ram_addr.h
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a80547006b..1ec73400a7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -34,7 +34,7 @@
 #include "sysemu/accel-blocker.h"
 #include "qemu/bswap.h"
 #include "exec/memory.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qemu/event_notifier.h"
 #include "qemu/main-loop.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d4b381641c..46f35ddd59 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -27,7 +27,7 @@
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 48015be829..6d165fded6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -40,7 +40,7 @@
 #endif
 #endif
 #else
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #endif
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a9833530c7..ac9ab5986a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -74,7 +74,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost-scsi-common.h"
 
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/usb.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 5eef7475c1..1d9ad3d6fc 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index a91fea1304..f6b2cb7396 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -34,7 +34,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include <libfdt.h>
 #include "trace.h"
diff --git a/hw/remote/memory.c b/hw/remote/memory.c
index 0af2a2f3fe..23df49099a 100644
--- a/hw/remote/memory.c
+++ b/hw/remote/memory.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/remote/memory.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qapi/error.h"
 
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index 3948751ed7..0baf145016 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -12,7 +12,7 @@
 #include "qemu/range.h"
 #include "exec/memory.h"
 #include "exec/cpu-common.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index b495d81296..48fd8e56cc 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -15,7 +15,7 @@
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "kvm/kvm_s390x.h"
 #include "qapi/error.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index fe7945e856..5bad70ae5c 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -16,7 +16,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5b6fe1a18a..823a45cdec 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "exec/confidential-guest-support.h"
 #include "hw/boards.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2e7a02cd4b..01aae36194 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -29,7 +29,7 @@
 #include "hw/vfio/pci.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index f0bc9e8c2b..fe2254962b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -25,7 +25,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 120c82f3de..0b539cd55a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,7 +25,7 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index f5698eeae0..a057034e2a 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-vfio.h"
 #include "exec/ramlist.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "pci.h"
 #include "trace.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 980147338a..7b4159948f 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -19,7 +19,7 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index dae94dbbde..1cccec24c3 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -24,7 +24,7 @@
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
diff --git a/migration/ram.c b/migration/ram.c
index 82c44e8213..5da14601c1 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -48,7 +48,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
diff --git a/plugins/api.c b/plugins/api.c
index 77b55cff74..24bf31804f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -49,7 +49,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "qapi/error.h"
 #include "migration/blocker.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
diff --git a/system/memory.c b/system/memory.c
index 7eae1bbda7..281f3c94e1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -26,7 +26,7 @@
 #include "trace.h"
 
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
diff --git a/system/physmem.c b/system/physmem.c
index 26cfb84454..d856c77d8b 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -66,7 +66,7 @@
 #include "sysemu/replay.h"
 
 #include "exec/memory-internal.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 
 #include "qemu/pmem.h"
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 0950a1c6f1..c401a0981c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -24,7 +24,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #ifndef CONFIG_USER_ONLY
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #endif
 #include "exec/cpu_ldst.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f764931426..f9dc722f3f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -41,7 +41,7 @@
 #include "trace.h"
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "sysemu/hostmem.h"
 #include "qemu/cutils.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index c8045d873c..7dd4e403aa 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -41,7 +41,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/device_tree.h"
 #include "gdbstub/enums.h"
-#include "exec/ram_addr.h"
+#include "sysemu/ram_addr.h"
 #include "sysemu/physmem-target.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
-- 
2.45.2


