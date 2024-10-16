Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ECAD206AC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 07:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0yu3-0003Yy-K1; Wed, 16 Oct 2024 03:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yu0-0003YR-L9
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t0yty-0000gr-4R
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 03:57:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c767a9c50so51092195ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 00:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1729065420; x=1729670220;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abHFdh3eAZs73oUQ82v+IFsHjPXHr9LPOZxCIH0Luwo=;
 b=ze5QdY02Fd6YQAWVtZboXAeZa8Hr3XaHTffIGHHLi8n93b31+SZ28EeCdE7B8DxbvZ
 pCCFBNCMKxD/sZ4ypQ1QcFWREXqcPDF6kWOaF/DUMD9ZS1sq/64YSwdm74f2e2UbfuFV
 EB0GBjcWG9Ng0atoSsb7J2OqP0cKXyPPr08AlJxqruhLqEMzIT9sCoFMA+eSpQmMFbVv
 y4XjnqGCWmd/cAVtW/OvTtFMRvBLfz3xHnsfb5UfMK6gQVEP3cj1TWJcRQ+XyasswlVz
 0HIfWqcqQVZ9pS5fje+iHX2FA9wfLW3NnACEmWyfOOS5Z3GfbivNA5xs+SFZ9UlRjOVn
 r+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729065420; x=1729670220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=abHFdh3eAZs73oUQ82v+IFsHjPXHr9LPOZxCIH0Luwo=;
 b=LGmn6AKcE+yKCGKX5AYupH1GnfuPYLsaMwaYBDgnbPpJCXQCRaZyQV/6mvsadkgd4i
 DzTWIplO+uXMPSm47IsE897PkkFLQ835fh+VoZzHZpyMu5+m4/ox9a/ebWk6Ag5jn4yZ
 9inTPkFSfSXu4+FKHZESR0q9uN2umRq9NBvQH7bsyyDHNjkRj99XvnHXGM87P+6HvZ2a
 jFXN9ULem81fmFFsLvBGE6kLGDGdgTy0/YmIT6aFMRYp0VFoXUEcRhXRwG6WnzTA0KPi
 S8yhg0H1n43PUTT+p1g89HqNCQmlhM0xgyDlosaHCu/ziKoQWwLWKvowsHsKtylSjmP7
 rM5w==
X-Gm-Message-State: AOJu0Yy68oxRRvErwisoR3zEmWhDp5to2umB+MWEGIXQugsimslWRjCM
 1lbZ0OXO2hHJ748b5J5v0ZlbKMFBWAhK5K0L30G/57y4O80CSNd1bfcMSlO2UrU5ekOU0NN17Oi
 bAz8n3A==
X-Google-Smtp-Source: AGHT+IFjVDG9pkIIlJHppr5eog06xHnTaqHgriOd2DYviD4o5nXTGJEwbnjhDUmTMmb4jXEShVxpCw==
X-Received: by 2002:a17:902:fb04:b0:20c:9d9e:9049 with SMTP id
 d9443c01a7336-20cbb1a9196mr166211245ad.22.1729065419608; 
 Wed, 16 Oct 2024 00:56:59 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([85.208.104.155])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dd1sm23608365ad.43.2024.10.16.00.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 00:56:59 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v3 1/4] migration: Move cpu-throttole.c from system to
 migration
Date: Wed, 16 Oct 2024 15:56:42 +0800
Message-Id: <e41bdd8dde51403a25b817ec49e860f9b515b793.1729064919.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1729064919.git.yong.huang@smartx.com>
References: <cover.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

Move cpu-throttle.c from system to migration since it's
only used for migration; this makes us avoid exporting the
util functions and variables in misc.h but export them in
migration.h when implementing the background ramblock dirty
sync feature in the upcoming commits.

Additionally, make the two modifications below:

1. Delay the timer registering of CPU throttle until
   migration starts since it is only used in migration.

2. Stop CPU throttle if auto converge capability is
   enabled since it only happens with auto converge.

3. Remove the unused header file reference in
   accel/tcg/icount-common.c.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 accel/tcg/icount-common.c                    |  1 -
 {system => migration}/cpu-throttle.c         |  2 +-
 {include/sysemu => migration}/cpu-throttle.h |  0
 migration/meson.build                        |  1 +
 migration/migration.c                        | 11 +++++++++--
 migration/ram.c                              |  2 +-
 migration/trace-events                       |  3 +++
 system/cpu-timers.c                          |  3 ---
 system/meson.build                           |  1 -
 system/trace-events                          |  3 ---
 10 files changed, 15 insertions(+), 12 deletions(-)
 rename {system => migration}/cpu-throttle.c (99%)
 rename {include/sysemu => migration}/cpu-throttle.h (100%)

diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 8d3d3a7e9d..30bf8500dc 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -36,7 +36,6 @@
 #include "sysemu/runstate.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
 
 /*
diff --git a/system/cpu-throttle.c b/migration/cpu-throttle.c
similarity index 99%
rename from system/cpu-throttle.c
rename to migration/cpu-throttle.c
index 7632dc6143..fa47ee2e21 100644
--- a/system/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -27,7 +27,7 @@
 #include "hw/core/cpu.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
-#include "sysemu/cpu-throttle.h"
+#include "cpu-throttle.h"
 #include "trace.h"
 
 /* vcpu throttling controls */
diff --git a/include/sysemu/cpu-throttle.h b/migration/cpu-throttle.h
similarity index 100%
rename from include/sysemu/cpu-throttle.h
rename to migration/cpu-throttle.h
diff --git a/migration/meson.build b/migration/meson.build
index 66d3de86f0..d53cf3417a 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -13,6 +13,7 @@ system_ss.add(files(
   'block-dirty-bitmap.c',
   'channel.c',
   'channel-block.c',
+  'cpu-throttle.c',
   'dirtyrate.c',
   'exec.c',
   'fd.c',
diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..7e71184257 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,7 +24,7 @@
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "sysemu/cpu-throttle.h"
+#include "cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
 #include "migration/global_state.h"
@@ -3289,7 +3289,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 static void migration_iteration_finish(MigrationState *s)
 {
     /* If we enabled cpu throttling for auto-converge, turn it off. */
-    cpu_throttle_stop();
+    if (migrate_auto_converge()) {
+        cpu_throttle_stop();
+    }
 
     bql_lock();
     switch (s->state) {
@@ -3508,6 +3510,11 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_colo_enable(s->to_dst_file);
     }
 
+    if (migrate_auto_converge()) {
+        /* Start cpu throttle timers */
+        cpu_throttle_init();
+    }
+
     bql_lock();
     ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
diff --git a/migration/ram.c b/migration/ram.c
index 326ce7eb79..54d352b152 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -52,7 +52,7 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "sysemu/cpu-throttle.h"
+#include "cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
 #include "multifd.h"
diff --git a/migration/trace-events b/migration/trace-events
index c65902f042..9a19599804 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -378,3 +378,6 @@ migration_block_progression(unsigned percent) "Completed %u%%"
 # page_cache.c
 migration_pagecache_init(int64_t max_num_items) "Setting cache buckets to %" PRId64
 migration_pagecache_insert(void) "Error allocating page"
+
+# cpu-throttle.c
+cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 0b31c9a1b6..856e502e34 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -35,7 +35,6 @@
 #include "sysemu/runstate.h"
 #include "hw/core/cpu.h"
 #include "sysemu/cpu-timers.h"
-#include "sysemu/cpu-throttle.h"
 #include "sysemu/cpu-timers-internal.h"
 
 /* clock and ticks */
@@ -272,6 +271,4 @@ void cpu_timers_init(void)
     seqlock_init(&timers_state.vm_clock_seqlock);
     qemu_spin_init(&timers_state.vm_clock_lock);
     vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
-
-    cpu_throttle_init();
 }
diff --git a/system/meson.build b/system/meson.build
index a296270cb0..4952f4b2c7 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -10,7 +10,6 @@ system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
-  'cpu-throttle.c',
   'cpu-timers.c',
   'datadir.c',
   'dirtylimit.c',
diff --git a/system/trace-events b/system/trace-events
index 074d001e90..2ed1d59b1f 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -44,6 +44,3 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
-
-# cpu-throttle.c
-cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
-- 
2.27.0


