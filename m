Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A653EE57D1
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqir-0007bZ-68; Wed, 31 Dec 2025 02:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqip-0007Vr-E2
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:19 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqin-0001B6-2h
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:19 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so9107206b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166456; x=1767771256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2PnYPaVgv2a3r54rqJcVWPwTLSu9JeG2yAlY2Q9p00=;
 b=TF7qkIDMCkA0QTd9MHx+iSblFcB2e6S6rGiIlNmF7PHU2V9mFAMPaDsq1iKPC2UJWr
 tKg2tUlhaP7NEPCz08lRvG+P4zvD2CMZNCs5hvyq8ZcpfPDFJI6f7vsQSqX1L+2GzJ6/
 4izB2BuK/51O/oNPxok2fgBcFzRuld1BboVf+nSDLCHXt5VEgowJKy7eMAe8SzUgdWUv
 DdguxNdUwPIAX4CWo+CVozAchmpYe1vWgJjj5F0S+/D09Wx3T/KLj/8w+UCobQiIclgZ
 zoIeG/7P9qjG6jG7Xtewa/PlBTis8zRbR9qlwtDfES7dYYr9UNlt4POAHWde3NlMFLG7
 vitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166456; x=1767771256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y2PnYPaVgv2a3r54rqJcVWPwTLSu9JeG2yAlY2Q9p00=;
 b=CU5j/ShBCvIpqbDN6fDqitr6UM3Sff04GunJ3GtPVZSuztRMM1apj7rAmDQTa9G0rB
 9W/eqCcLdElkOgB4fMovWPJB0TPRU+Pqpis2EJXziCDlx3YgO1HJf2szMWdA5Fjqqdrd
 407xkFXbLw8svD8HYFYsAVFkxjfbQqDwSZZwU0wr/6PBGvQ1r31c2tWaiwJmmUgi+Dw9
 r7lrTlVZQ9wL9fE1KsiknFQEmVEQKUbV0JfT51F+TgTIaHVg0Fw0BB1Fo5vGHc7rxn9e
 1ISaN7LOoy6IT69aaGUzG2X0DZhmhsU+c9SSCyyYULNKdQfM7u/i+55nMKIbPYR+ARJs
 xMsA==
X-Gm-Message-State: AOJu0YxhiAhfgPwznap31P38Di3CgDGIuFF7Cs4kvXJgeWaHydPetBJK
 nYKbOmZQOfSAswDZ7p1E0Plya3GEv2XqLSKIA7CNf+2YEIMshby2yow4nsyj9Ko7KUuRA4aHlAG
 9VnUu
X-Gm-Gg: AY/fxX6//gUKXnG22SPGfFO8nRgVH7V/E5R2iYRm6eot/6vQzd7Y3DcAb4wKQwfOY8T
 EP21HYzJup55KSKNEycleGqj74d3uLO8Qnu9SGVnTD8OChK/XSAn9BL+wKPHAwyDYfatEq8AH5O
 nWs/Cs5ElzXCH3KZd8OYZGy0T3b+Y/sbItlExwa+urR3U/Og9leQ5J0oqHb69zB1USI1W1Re9e4
 jX1WpmANn1D977XD1M3zopu9P1o0RP3EcSKqxRwnjmzKMJQcnsNPvz9DL1iIwFtYVUoMrFa/4hR
 TY36PIJ56lCnSviAE6fwEcDhI3GqhtYpLCPjMS+hRkb1Y1Lw+3MINc4JUIaRAaJnD597D12l8WE
 KMk1w44/lIrqYiv2R9EGUCYFTFrBMaYLfiVHDubC7FsjAYfqBOzfyf3aGOUjDTHyl19Rmrejill
 vqXjDhclqJG2CiV7VqkPmDyb8tvxgTczh8vCfHBCQx07Zt3MpM6JFWNYyL3TAa8LTk
X-Google-Smtp-Source: AGHT+IG1zw879eV3BZT6wwOppd1KaTa9TNPlq5AXWmRT5G2wTOh/MF/6s/t1RWVHWBLRo7wrooA0Hg==
X-Received: by 2002:a05:6a00:1ca2:b0:7f6:6011:b106 with SMTP id
 d2e1a72fcca58-7ff648e611emr32135633b3a.19.1767166455469; 
 Tue, 30 Dec 2025 23:34:15 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:15 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/11] include: qemu/coroutine.h -> qemu/qemu-coroutine.h
Date: Tue, 30 Dec 2025 23:33:56 -0800
Message-ID: <20251231073401.2097765-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

This header conflicts with C++ coroutine header.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 block/parallels.h                              | 2 +-
 block/qcow2.h                                  | 2 +-
 fsdev/qemu-fsdev-throttle.h                    | 2 +-
 hw/9pfs/9p.h                                   | 2 +-
 include/block/block-global-state.h             | 2 +-
 include/block/block-hmp-cmds.h                 | 2 +-
 include/block/block-io.h                       | 2 +-
 include/block/reqlist.h                        | 2 +-
 include/block/throttle-groups.h                | 2 +-
 include/qemu/coroutine_int.h                   | 2 +-
 include/qemu/job.h                             | 2 +-
 include/qemu/{coroutine.h => qemu-coroutine.h} | 0
 migration/migration.h                          | 2 +-
 ui/console-priv.h                              | 2 +-
 block.c                                        | 2 +-
 block/block-copy.c                             | 2 +-
 block/io_uring.c                               | 2 +-
 block/linux-aio.c                              | 2 +-
 block/mirror.c                                 | 2 +-
 block/progress_meter.c                         | 2 +-
 block/vdi.c                                    | 2 +-
 chardev/char.c                                 | 2 +-
 hw/9pfs/coth.c                                 | 2 +-
 hw/block/virtio-blk.c                          | 2 +-
 migration/rdma.c                               | 2 +-
 nbd/client-connection.c                        | 2 +-
 net/colo-compare.c                             | 2 +-
 qapi/qmp-dispatch.c                            | 2 +-
 tests/unit/test-aio-multithread.c              | 2 +-
 ui/console.c                                   | 2 +-
 ui/ui-qmp-cmds.c                               | 2 +-
 util/qemu-co-shared-resource.c                 | 2 +-
 util/qemu-co-timeout.c                         | 2 +-
 util/qemu-coroutine-io.c                       | 2 +-
 util/thread-pool.c                             | 2 +-
 35 files changed, 34 insertions(+), 34 deletions(-)
 rename include/qemu/{coroutine.h => qemu-coroutine.h} (100%)

diff --git a/block/parallels.h b/block/parallels.h
index 423b2ad7271..7836b68d491 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -31,7 +31,7 @@
 */
 #ifndef BLOCK_PARALLELS_H
 #define BLOCK_PARALLELS_H
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 #define HEADS_NUMBER 16
 #define SEC_IN_CYL 32
diff --git a/block/qcow2.h b/block/qcow2.h
index 96db7c51ec2..f139d64659f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -26,7 +26,7 @@
 #define BLOCK_QCOW2_H
 
 #include "crypto/block.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/units.h"
 #include "block/block_int.h"
 
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index a1dc0307903..6e54991deba 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -15,7 +15,7 @@
 #ifndef QEMU_FSDEV_THROTTLE_H
 #define QEMU_FSDEV_THROTTLE_H
 
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/throttle.h"
 
 typedef struct FsThrottle {
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 65cc45e344f..d380d8bec62 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -7,7 +7,7 @@
 #include "fsdev/file-op-9p.h"
 #include "fsdev/9p-iov-marshal.h"
 #include "qemu/thread.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/qht.h"
 
 enum {
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index ed89999f0fb..70c6c91d275 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -27,7 +27,7 @@
 #include "qemu/aiocb.h"
 #include "block/graph-lock.h"
 #include "block/block-common.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/transactions.h"
 
 /*
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7efa..72d0e8bdc37 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -15,7 +15,7 @@
 #ifndef BLOCK_BLOCK_HMP_CMDS_H
 #define BLOCK_BLOCK_HMP_CMDS_H
 
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 void hmp_drive_add(Monitor *mon, const QDict *qdict);
 
diff --git a/include/block/block-io.h b/include/block/block-io.h
index d34d846bb2a..cd33872c26f 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -28,7 +28,7 @@
 #include "qemu/aio-wait.h"
 #include "block/block-common.h"
 #include "block/graph-lock.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/iov.h"
 
 /*
diff --git a/include/block/reqlist.h b/include/block/reqlist.h
index 5253497bae3..25b9329a0cd 100644
--- a/include/block/reqlist.h
+++ b/include/block/reqlist.h
@@ -15,7 +15,7 @@
 #ifndef REQLIST_H
 #define REQLIST_H
 
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 /*
  * The API is not thread-safe and shouldn't be. The struct is public to be part
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 2355e8d9de6..f88160d0c5a 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -25,7 +25,7 @@
 #ifndef THROTTLE_GROUPS_H
 #define THROTTLE_GROUPS_H
 
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/throttle.h"
 #include "qom/object.h"
 
diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index 1da148552f7..a2985bb6e11 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -26,7 +26,7 @@
 #define QEMU_COROUTINE_INT_H
 
 #include "qemu/queue.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 #ifdef CONFIG_SAFESTACK
 /* Pointer to the unsafe stack, defined by the compiler */
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 0e40e8b4570..04ba53ac3b6 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -30,7 +30,7 @@
 #include "qemu/aiocb.h"
 #include "qemu/queue.h"
 #include "qemu/progress_meter.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/aio.h"
 #include "block/graph-lock.h"
 
diff --git a/include/qemu/coroutine.h b/include/qemu/qemu-coroutine.h
similarity index 100%
rename from include/qemu/coroutine.h
rename to include/qemu/qemu-coroutine.h
diff --git a/migration/migration.h b/migration/migration.h
index ccc4e536a57..ad3aad5b1a8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -20,7 +20,7 @@
 #include "qapi/qapi-types-migration.h"
 #include "qobject/json-writer.h"
 #include "qemu/thread.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "io/channel.h"
 #include "io/channel-buffer.h"
 #include "net/announce.h"
diff --git a/ui/console-priv.h b/ui/console-priv.h
index 43ceb8122f1..320ae93af18 100644
--- a/ui/console-priv.h
+++ b/ui/console-priv.h
@@ -6,7 +6,7 @@
 #define CONSOLE_PRIV_H
 
 #include "ui/console.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/timer.h"
 
 #include "vgafont.h"
diff --git a/block.c b/block.c
index 48a17f393c5..d9b3dfa23fa 100644
--- a/block.c
+++ b/block.c
@@ -45,7 +45,7 @@
 #include "system/block-backend.h"
 #include "qemu/notify.h"
 #include "qemu/option.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "block/qapi.h"
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
diff --git a/block/block-copy.c b/block/block-copy.c
index 1826c2e1c7b..c800946efbb 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -23,7 +23,7 @@
 #include "system/block-backend.h"
 #include "qemu/units.h"
 #include "qemu/co-shared-resource.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/ratelimit.h"
 #include "block/aio_task.h"
 #include "qemu/error-report.h"
diff --git a/block/io_uring.c b/block/io_uring.c
index cb131d3b8b5..940c1ca53b3 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -13,7 +13,7 @@
 #include "qemu/aio.h"
 #include "block/block.h"
 #include "block/raw-aio.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "system/block-backend.h"
 #include "trace.h"
 
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 53c3e9af8ae..53831b17695 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -13,7 +13,7 @@
 #include "block/block.h"
 #include "block/raw-aio.h"
 #include "qemu/event_notifier.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "system/block-backend.h"
diff --git a/block/mirror.c b/block/mirror.c
index b344182c747..8de0a8dfc89 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/range.h"
 #include "trace.h"
 #include "block/blockjob_int.h"
diff --git a/block/progress_meter.c b/block/progress_meter.c
index 31a170a2cd6..6ad9be5f83f 100644
--- a/block/progress_meter.c
+++ b/block/progress_meter.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/progress_meter.h"
 
 void progress_init(ProgressMeter *pm)
diff --git a/block/vdi.c b/block/vdi.c
index 87b874a7ef5..b42314e08ad 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -63,7 +63,7 @@
 #include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/cutils.h"
 #include "qemu/uuid.h"
 #include "qemu/memalign.h"
diff --git a/chardev/char.c b/chardev/char.c
index 3e432195a5a..7ff440d884e 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -38,7 +38,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/id.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/yank.h"
 
 #include "chardev-internal.h"
diff --git a/hw/9pfs/coth.c b/hw/9pfs/coth.c
index 598f46add99..eda52fe28f1 100644
--- a/hw/9pfs/coth.c
+++ b/hw/9pfs/coth.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "block/thread-pool.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/main-loop.h"
 #include "coth.h"
 
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ddf0e9ee53e..07be8a3b387 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -36,7 +36,7 @@
 #include "hw/virtio/iothread-vq-mapping.h"
 #include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-blk-common.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 static void virtio_blk_ioeventfd_attach(VirtIOBlock *s);
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 337b4158899..589048c6978 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -29,7 +29,7 @@
 #include "qemu/rcu.h"
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "system/memory.h"
 #include <sys/socket.h>
 #include <netdb.h>
diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 79ea97e4cc1..22247b16c34 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -29,7 +29,7 @@
 
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/clone-visitor.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 #include "nbd/nbd-internal.h"
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index c356419d6a8..4d308e777c8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -31,7 +31,7 @@
 #include "util.h"
 
 #include "qemu/aio-wait.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 
 #define TYPE_COLO_COMPARE "colo-compare"
 typedef struct CompareState CompareState;
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 9bb1e6a9f4a..9df35654f27 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -22,7 +22,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qobject/qbool.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/main-loop.h"
 
 Visitor *qobject_input_visitor_new_qmp(QObject *obj)
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 9179cdc6a32..a6923a7f572 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/aio.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
 #include "iothread.h"
diff --git a/ui/console.c b/ui/console.c
index f445db11389..7556256ef04 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/visitor.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index 74fa6c6ec5a..3be35797343 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -19,7 +19,7 @@
 #include "monitor/qmp-helpers.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "ui/console.h"
diff --git a/util/qemu-co-shared-resource.c b/util/qemu-co-shared-resource.c
index 752eb5a1c5f..52ce4414bfe 100644
--- a/util/qemu-co-shared-resource.c
+++ b/util/qemu-co-shared-resource.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/co-shared-resource.h"
 
 struct SharedResource {
diff --git a/util/qemu-co-timeout.c b/util/qemu-co-timeout.c
index 6774440b287..edc533ff7cf 100644
--- a/util/qemu-co-timeout.c
+++ b/util/qemu-co-timeout.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/aio.h"
 
 typedef struct QemuCoTimeoutState {
diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
index 364f4d5abf5..2d88458fadd 100644
--- a/util/qemu-coroutine-io.c
+++ b/util/qemu-coroutine-io.c
@@ -24,7 +24,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/sockets.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
 
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 8f8cb38d5ce..d85b0b04293 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -19,7 +19,7 @@
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
-#include "qemu/coroutine.h"
+#include "qemu/qemu-coroutine.h"
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
-- 
2.47.3


