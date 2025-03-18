Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF394C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZZ-0003MN-6d; Tue, 18 Mar 2025 17:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY2-0001IW-5i
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXy-0000mV-Na
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso56597555ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333545; x=1742938345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kraIMO+aYH2Sb+qY0LYmwD3RFZQ9KCHdPpg+Pm0WQ1w=;
 b=g/AEN38+VuaFcWMQk1+Yf+SbUCZyJY+xuWCoNg8ef12k2Mg7BMRauFNRcSjcvC/nop
 EDTdjpwK+/XnWn3dzEqy5yjWK+Zt2ATh5apqF21PSNWsVqJzJKuGVwuNjawiYZV6+cSE
 soYuDb4SjUPtBjXWXR9VfqWKSfwoEB3llA01s2LWvMGsP7AJ+jZP4kdS3Dq7juhauVTF
 E2e349y09TxYt4dYSzCIvtM0j69s620NKfZMLIeELSwrGAT1anmqrLRpe4xZMxRAHmGL
 KEMP4zRBwK827U+aKeaku1gL9tbErvNAFZkP1vWnyysp/B2VFFv9D+bZqGJYsrw9OU7w
 0UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333545; x=1742938345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kraIMO+aYH2Sb+qY0LYmwD3RFZQ9KCHdPpg+Pm0WQ1w=;
 b=gNZcFcg32MkyHfyXCR6bnnH9q3FLfIVnsV2B1uOtlq5W4hyVkZfCvRrQ10+at6yigj
 XLeBoZF71rRpN3gLCeiskr+84F4FyngaFFDQV6id65IC4VjekyKWm0wcOoJ+DtA9VDUr
 Re+rKDPzeX3n4ycOUsRT0ibaY5nEXoj9aZTgUX87jghYTPOoJJ/axTgP4pD88oZlR0vq
 BsXXyluvKLB0wP6btN6DcSHMF5LeoUOdrCmu7wZgu2cu74OSMiHncgVa8UBI7CQ+2OQ4
 tyvGox+FdQGBB+zRNuzYKuETCQGcu1Fufnnf/J3gQlBjxMrjM+/MJdENxXYF9iIIs41b
 2QUw==
X-Gm-Message-State: AOJu0YzhrQM6ZvDN8fXGjFovRsUbufeT6nEdvJKYiveEI2HSEQuZ7Zsa
 oiT7aTZil8BLIarJ2zFaXoA9QtmWdVJ5InHMMU4FdtVrXKTODbATaIt8Ge2WNQHLSIOcPQv5ecU
 z
X-Gm-Gg: ASbGncslZnoyKrMa3SWtl623IRGtmVzWGmocfdjhUuw25DTc/Nc2ZeHNzFvr1772uJZ
 PQ3JauJt9sFj3RHhl30A728MoOWYYEQyTM8hvoHA8tvfr91/8FQmcjZ7y8FGbNQBr2UoU9gRROW
 OP/BVaUb87b+0QUUtuhxLvumsrFa5iHXWGv+DIVhrP97OdtzazwZwOMVyuSRNTchzUXRsErC0qf
 RVv2HvhUWKEfZVvqXGNMPWQ1RypYn3d9uQf/8dPxJrreAjZ1ChWpOZIoeN3Bqsqsz6SRyYjl3Mo
 FWjOxIXKdQav3qs5T0fyTgnoS8uVNsXqhJp94E4aRu7CIQOMNJytcW94hpyQH19XSezhgb6BGxi
 G
X-Google-Smtp-Source: AGHT+IE/kLhqIA+Z5YTVCnytQPk0zZTjeg4S8orLOAS7GV+71O/zDl9WpnKF/oTYNr3hTzK8EtzzwA==
X-Received: by 2002:a05:6a20:244d:b0:1f3:41d5:6608 with SMTP id
 adf61e73a8af0-1fbece41eb8mr259547637.26.1742333545247; 
 Tue, 18 Mar 2025 14:32:25 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 20/42] include/system: Move exec/ramblock.h to
 system/ramblock.h
Date: Tue, 18 Mar 2025 14:31:45 -0700
Message-ID: <20250318213209.2579218-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 include/system/ram_addr.h           | 2 +-
 include/{exec => system}/ramblock.h | 9 ++++-----
 hw/display/virtio-gpu-udmabuf.c     | 2 +-
 hw/hyperv/hv-balloon.c              | 2 +-
 hw/virtio/vhost-user.c              | 2 +-
 migration/dirtyrate.c               | 2 +-
 migration/file.c                    | 2 +-
 migration/multifd-nocomp.c          | 2 +-
 migration/multifd-qatzip.c          | 2 +-
 migration/multifd-qpl.c             | 2 +-
 migration/multifd-uadk.c            | 2 +-
 migration/multifd-zero-page.c       | 2 +-
 migration/multifd-zlib.c            | 2 +-
 migration/multifd-zstd.c            | 2 +-
 migration/multifd.c                 | 2 +-
 migration/postcopy-ram.c            | 2 +-
 tests/qtest/fuzz/generic_fuzz.c     | 2 +-
 MAINTAINERS                         | 2 +-
 18 files changed, 21 insertions(+), 22 deletions(-)
 rename include/{exec => system}/ramblock.h (96%)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 3b81c3091f..b4e4425acb 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -23,7 +23,7 @@
 #include "system/tcg.h"
 #include "exec/cputlb.h"
 #include "exec/ramlist.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "exec/exec-all.h"
 #include "system/memory.h"
 #include "exec/target_page.h"
diff --git a/include/exec/ramblock.h b/include/system/ramblock.h
similarity index 96%
rename from include/exec/ramblock.h
rename to include/system/ramblock.h
index 64484cd821..d8a116ba99 100644
--- a/include/exec/ramblock.h
+++ b/include/system/ramblock.h
@@ -16,11 +16,10 @@
  * The functions declared here will be removed soon.
  */
 
-#ifndef QEMU_EXEC_RAMBLOCK_H
-#define QEMU_EXEC_RAMBLOCK_H
+#ifndef SYSTEM_RAMBLOCK_H
+#define SYSTEM_RAMBLOCK_H
 
-#ifndef CONFIG_USER_ONLY
-#include "cpu-common.h"
+#include "exec/cpu-common.h"
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
 
@@ -91,5 +90,5 @@ struct RAMBlock {
      */
     ram_addr_t postcopy_length;
 };
-#endif
+
 #endif
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index 85ca23cb32..0510577475 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -19,7 +19,7 @@
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "trace.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "system/hostmem.h"
 #include <sys/ioctl.h>
 #include <linux/memfd.h>
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 0b1da723c8..acabff2c4a 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -12,7 +12,7 @@
 
 #include "system/address-spaces.h"
 #include "exec/cpu-common.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "hw/boards.h"
 #include "hw/hyperv/dynmem-proto.h"
 #include "hw/hyperv/hv-balloon.h"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 267b612587..48561d3c74 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -28,7 +28,7 @@
 #include "system/cryptodev.h"
 #include "migration/postcopy-ram.h"
 #include "trace.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 
 #include <sys/ioctl.h>
 #include <sys/socket.h>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 09caf92f87..986624c79a 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "hw/core/cpu.h"
 #include "qapi/error.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/main-loop.h"
diff --git a/migration/file.c b/migration/file.c
index 7f11e26f5c..bb8031e3c7 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index ffe75256c9..94f248e8a2 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "file.h"
 #include "migration-stats.h"
diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index 6a0e989fae..7419e5dc0d 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-types-migration.h"
diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 88e2344af2..52902eb00c 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-migration.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "multifd.h"
 #include "qpl/qpl.h"
 
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 6895c1f65a..fd7cd9b5e8 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "migration.h"
 #include "multifd.h"
 #include "options.h"
diff --git a/migration/multifd-zero-page.c b/migration/multifd-zero-page.c
index f1e988a959..dbc1184921 100644
--- a/migration/multifd-zero-page.c
+++ b/migration/multifd-zero-page.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "multifd.h"
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 8cf8a26bb4..8820b2a787 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include <zlib.h>
 #include "qemu/rcu.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
 #include "migration.h"
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index abed140855..3c2dcf76b0 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include <zstd.h>
 #include "qemu/rcu.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "qapi/error.h"
 #include "migration.h"
diff --git a/migration/multifd.c b/migration/multifd.c
index dfb5189f0e..86c83e43c0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -16,7 +16,7 @@
 #include "qemu/rcu.h"
 #include "exec/target_page.h"
 #include "system/system.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "file.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 5d3edfcfec..995614b38c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -31,7 +31,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/boards.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "socket.h"
 #include "yank_functions.h"
 #include "tls.h"
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 239be9372d..507de74806 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -21,7 +21,7 @@
 #include "fuzz.h"
 #include "string.h"
 #include "system/memory.h"
-#include "exec/ramblock.h"
+#include "system/ramblock.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 3e1af7e1b2..18a5381afd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3108,7 +3108,7 @@ F: include/system/ioport.h
 F: include/exec/memop.h
 F: include/system/memory.h
 F: include/system/ram_addr.h
-F: include/exec/ramblock.h
+F: include/system/ramblock.h
 F: include/system/memory_mapping.h
 F: system/dma-helpers.c
 F: system/ioport.c
-- 
2.43.0


