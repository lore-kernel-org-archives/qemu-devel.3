Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245AAC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7koV-000737-7s; Wed, 23 Apr 2025 20:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kn7-0005es-1T
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:20 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmz-0004Wg-3z
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso365419b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455803; x=1746060603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NBZn3i6oWCdtplZB4PrRd/eK1p4Gk3cW81nmsPJsCg=;
 b=dr3wX1gVocwd5ee9764p7TBdLZfjNd8QHL+3Otdyc0kwzcWyJamLVVofuBdBdHBy7Q
 8VA6QKzrLni8Pf3fyyzK3kPKHTkqNyvIDM6lYc1WTeXqTdvWVdKsqn5u7pCuZYckErkg
 reHxC8ZLPPWvQuHpdw1bM0g19tsTAv7uKDvQJSEdHz89W7mUvno/UHqByM5aetPsuKkX
 aJQ+qCV39VKuHvpQuYdosVHi4hOBX51GMTSRX7sOyEU+2MYBOEJCAcE9/h1/aOFiCQIa
 FCbuBmAylypr1uuOlS+pOam0SFIcXesSK0RyCoRoHlo6LkcOkNYe+IBgRZdok1C66H76
 bo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455803; x=1746060603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NBZn3i6oWCdtplZB4PrRd/eK1p4Gk3cW81nmsPJsCg=;
 b=hE7yNNYifOTtUE2s4VQ3MbFqdsL/DrhQ6/d5t/eRtOO/SwZl596bkHQAtz3pnEjXUD
 fsDzByDTh2ylk1R65Uv94GaRu83/QmWZEvp3HcByRO36dLMmReHzAPpWHN/o1gSjWVI8
 A2qgYeIMB+Wj5XJk5rK+aZN/5wQz4GWIdNwbDCVyMHs+DNL2TlSizqw6VeDzY7ojD/7e
 bN9Nujle17lSKzX0z4maHIMZSesdIuuVlcpLsBeVc0t/7sdTBZlCTLVtKRxLn4Sc/vg9
 zLvjFRGZC6af6U8UGhIVLcLccGCy354IyI9ZXgVNBX27Dwdm4PzeJs8LhivJAHfx3hbE
 N/cw==
X-Gm-Message-State: AOJu0YwP8VmioSaUpRpR6UYPb9cNhubrhtWzCr/3ucbQ38B9QfGCcl9z
 1BJCPO1NHM/2bVJF7H/tC38+co5iBsn1TmnnB66hdxk3zCsm2iYMPdLyjPCj/49XGmYdHcHshdq
 c
X-Gm-Gg: ASbGncuAkPsT21eM5c9FzuOGucPqMvG74nEzZblqq5bJVaL/MHmSpW73c0ZW/Qr6X3w
 EkDGH8GVALDNL5y7qABfxd5+hRAPKM8G4V1goG0o/+H09rGbWnT9lF7nP4TtihmsVcqkUSta35J
 fvLns9ZuThiss+F6wDJfR+6uO5/yPdFisDK3lnHiiMx6tPrexBwEKtYeh8j5BP4Ne9VD/i3zfC4
 6TopZQZ6fGB+RqHeiB3OnKZVEx5D3VGU+muVB/Wcu1G8RPJcUxVO6F42oXnxEgL+9RR3rreXjkl
 BcXwUtr/DA9AbShtR5gAPkXBH3jUknVMxw11oquhfvGy8GeaM4T5kqG8DYEhWmI6J8zAST8i2X0
 =
X-Google-Smtp-Source: AGHT+IH3kKA/YsodYw9JGvPNrPIkl2JRaVnjIEzZ7px49gIbj6DhXfzsIRkX5k8lGR2OiG2ukx4vNQ==
X-Received: by 2002:a05:6a00:80d:b0:736:34ff:be7 with SMTP id
 d2e1a72fcca58-73e24acafe4mr923782b3a.15.1745455803502; 
 Wed, 23 Apr 2025 17:50:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 038/148] include/system: Move exec/ramblock.h to
 system/ramblock.h
Date: Wed, 23 Apr 2025 17:47:43 -0700
Message-ID: <20250424004934.598783-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index b1ac3ff7d2..ba885010c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3122,7 +3122,7 @@ F: include/system/ioport.h
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


