Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8E3C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWOw-00045O-TG; Mon, 26 Feb 2024 03:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNt-0002wS-Ht
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:54 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWNs-0005mi-0O
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:49 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so5383085ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936245; x=1709541045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylQ7cG8ZxhS/Ow0dss1QvZgVNdYukV9TtCfdFWWomLA=;
 b=YtwKnT6nXEobL5QTWxW1dawYekO6IVJyPVvKLacs50beClLHp89BdaD9sPMts+ZZDu
 qBu0uXNuUc4R8U0hPEo7NfrVvG/cYojrzKYTlYb6z42YjR8XX1PXHfLV30nUbsq7yCZF
 2P0vUUDJVZUsPX8Xb9V+wFrhcf8LDBcr+1wmCEw7UaN1AHDoESv3d65NkYaUhBXe3q+8
 SWM8kOFb7Kzi9MaGwlAdbiC60R1ScFXFvSHrPKJmW7ZGr+qkqWrEKJfOoky0+i6nLHKI
 QXjilexBQ/eb64MQJ9eKW5XHuGm57ZWkHELOVkTBtzo8T51uwWFqTt1vC8S/QCFZd2wF
 618A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936245; x=1709541045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylQ7cG8ZxhS/Ow0dss1QvZgVNdYukV9TtCfdFWWomLA=;
 b=s5PRz6ylr+3EBqAa6lLN0x0DCZoZZKBH6puRZJ1qGlxmPyfsd2iJ+PRb3S8xc9LhlR
 8h77HVdS7wbL8me7Wk+qYKgEC+GYO+Y684driTj8irJcyGK0kEuSOOokzvWu48r3oAzz
 y0IyOpbr50guSAuQqIck2BWxscSae9jjkRy0B+BIxm9hNnCRpBDOHw04rsCCjhhPObLm
 c/Ct7CspevlABdilhGzvEzyvdT7DYB5mNr5w54W/H28zTqaPsDoTx7/RZiulJmWcQA2O
 eAVkcIorWNnP4w2XtKNR7U9YifeDU1PqJa79JxsNipkiQFAHP0cCbAEYyW6Tke+o2VtZ
 e9Cg==
X-Gm-Message-State: AOJu0YxISoMIgM5ETPjyrSIutkAtpZKhpNV4x2gyBPwAOxoDkpIxdy5v
 akbjIECFE7f+wgfpOlTq4yFzJpgkVMtanP4I5C40cM8tJpJjmxvZKUDt2Ahv
X-Google-Smtp-Source: AGHT+IFTF1HJu+wK4KicZHqGLPJMzGv5rfFpMc0AqsSCpU+xbQjGsC9IQSF3QuytmK2riLP8YnQ8cg==
X-Received: by 2002:a17:903:24c:b0:1da:190c:3481 with SMTP id
 j12-20020a170903024c00b001da190c3481mr8726448plh.34.1708936245385; 
 Mon, 26 Feb 2024 00:30:45 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:30:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 8/9] replay: Fix migration replay_mutex locking
Date: Mon, 26 Feb 2024 18:29:44 +1000
Message-ID: <20240226082945.1452499-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240226082945.1452499-1-npiggin@gmail.com>
References: <20240226082945.1452499-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Migration causes a number of events that need to go in the replay
trace, such as vm state transitions. The replay_mutex lock needs to
be held for these.

The simplest approach seems to be just take it up-front when taking
the bql.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/migration.h |  2 --
 migration/migration.c | 11 ++++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index f2c8b8f286..0621479a4e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -543,6 +543,4 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);
 
-int migration_stop_vm(RunState state);
-
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 2e794db75c..80a5ce17d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -24,6 +24,7 @@
 #include "socket.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/replay.h"
 #include "sysemu/cpu-throttle.h"
 #include "rdma.h"
 #include "ram.h"
@@ -162,7 +163,7 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
     return (a > b) - (a < b);
 }
 
-int migration_stop_vm(RunState state)
+static int migration_stop_vm(RunState state)
 {
     int ret = vm_stop_force_state(state);
 
@@ -2433,6 +2434,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
 
     trace_postcopy_start();
+    replay_mutex_lock();
     bql_lock();
     trace_postcopy_start_set_run();
 
@@ -2542,6 +2544,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     migration_downtime_end(ms);
 
     bql_unlock();
+    replay_mutex_unlock();
 
     if (migrate_postcopy_ram()) {
         /*
@@ -2583,6 +2586,7 @@ fail:
         }
     }
     bql_unlock();
+    replay_mutex_unlock();
     return -1;
 }
 
@@ -2634,6 +2638,7 @@ static int migration_completion_precopy(MigrationState *s,
 {
     int ret;
 
+    replay_mutex_lock();
     bql_lock();
     migration_downtime_start(s);
 
@@ -2662,6 +2667,7 @@ static int migration_completion_precopy(MigrationState *s,
                                              s->block_inactive);
 out_unlock:
     bql_unlock();
+    replay_mutex_unlock();
     return ret;
 }
 
@@ -3485,6 +3491,7 @@ static void *bg_migration_thread(void *opaque)
     trace_migration_thread_setup_complete();
     migration_downtime_start(s);
 
+    replay_mutex_lock();
     bql_lock();
 
     s->vm_old_state = runstate_get();
@@ -3522,6 +3529,7 @@ static void *bg_migration_thread(void *opaque)
      */
     migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
+    replay_mutex_unlock();
 
     while (migration_is_active(s)) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
@@ -3551,6 +3559,7 @@ fail:
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                 MIGRATION_STATUS_FAILED);
         bql_unlock();
+        replay_mutex_unlock();
     }
 
     bg_migration_iteration_finish(s);
-- 
2.42.0


