Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939CBC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFDF-0003we-Dj; Mon, 18 Mar 2024 11:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFD7-0003ZH-Fo
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:40 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCv-0007uM-Jz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:47:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6cadfffdbso4041896b3a.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776844; x=1711381644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=578ntQv2qmhtgvuXKuqTSL+k7p3UtnyDqAqXSEUYZKM=;
 b=cayVnvlVbFAQMAOoQVk0InKQgRMaM4qcXiTvXBWXYAHJcn11Wd7RXngYYAu2S5UyKw
 e+dy2T2f8IULdYJ/bh1BhJ5bmekqfCTX32VljrvD8Pd3yWG9spn/NHztGiKbdNod3jo4
 uMIaknkoOpQUBLo6GJmoz86Reun3sTSgFGqJzK/Pv2EgWPSglAtXFU2Q9VxH7CxIPzBC
 SOeb175JDPUfctGjklOX9lF9GyrEn+DsbU5kNAxjwpu2ZnqmM4TxTCZ+KcyKH5fDi6hl
 wfFM10cwuIkTiXJBqR9w3wrYByrjRMI8tgRN37qHdcHXKrNUOQQSTGX8wMir3v+zTgtt
 BB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776844; x=1711381644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=578ntQv2qmhtgvuXKuqTSL+k7p3UtnyDqAqXSEUYZKM=;
 b=NQjgentf22rLfeeuR/o1xwenHgpexy/F+S631PhoRvLX0yAYLTJnPeY6pNrw8hoMgu
 /jC0Jx/yzNJXy+FsAc9G5UazzmgiaQH204TaLPiHS9qqbzKEKK4J3iHu76gpVurp09kY
 m+rTxEP6AbGvCiMoLVIf3/rR9AM+ZyRVBXkwsfj5ehElPWmPQ5DBnqSaQ4OuYFqVUPEM
 QSNsqJnPU/weiLtgc0VCIYkpmloPBkyGlzRZOnc2g+/Sq657XPT1l5dtctzLILnohUo/
 e49SKHyO9BgM6OIyOVjkiVTn+bqjtowNbbrT8V89jKy+soHVxoEmMx5gFxR60duSnld9
 EK+g==
X-Gm-Message-State: AOJu0YxjZbLT5K5IKr5OnqnGRAWHrB4A2b63x3YVwythrubOdE9RMVJm
 eMQW8MTAUC8d+DTawKDJ1zijEaaOmOI0g4imS2C7oPHJ7Ho5XzCM+ElOYPJL0FQ=
X-Google-Smtp-Source: AGHT+IEIayBF74eVN5Y3h/ZpXSkUNp1ZHlDFti99gVMmUCqc0UIXHAYGOaTvjzrjKODF8hjYcTIAIw==
X-Received: by 2002:a05:6a20:3942:b0:1a3:463e:af40 with SMTP id
 r2-20020a056a20394200b001a3463eaf40mr11404335pzg.24.1710776844020; 
 Mon, 18 Mar 2024 08:47:24 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:47:23 -0700 (PDT)
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
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 09/24] replay: Fix migration replay_mutex locking
Date: Tue, 19 Mar 2024 01:46:06 +1000
Message-ID: <20240318154621.2361161-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240318154621.2361161-1-npiggin@gmail.com>
References: <20240318154621.2361161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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
 migration/migration.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 2c286ccf63..c7f376ae34 100644
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
@@ -2533,6 +2534,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
 
     trace_postcopy_start();
+    replay_mutex_lock();
     bql_lock();
     trace_postcopy_start_set_run();
 
@@ -2638,6 +2640,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     migration_downtime_end(ms);
 
     bql_unlock();
+    replay_mutex_unlock();
 
     if (migrate_postcopy_ram()) {
         /*
@@ -2679,6 +2682,7 @@ fail:
     }
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
+    replay_mutex_unlock();
     return -1;
 }
 
@@ -2730,6 +2734,7 @@ static int migration_completion_precopy(MigrationState *s,
 {
     int ret;
 
+    replay_mutex_lock();
     bql_lock();
 
     if (!migrate_mode_is_cpr(s)) {
@@ -2755,6 +2760,7 @@ static int migration_completion_precopy(MigrationState *s,
                                              s->block_inactive);
 out_unlock:
     bql_unlock();
+    replay_mutex_unlock();
     return ret;
 }
 
@@ -3592,6 +3598,7 @@ static void *bg_migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
+    replay_mutex_lock();
     bql_lock();
 
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
@@ -3625,6 +3632,7 @@ static void *bg_migration_thread(void *opaque)
      */
     migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
+    replay_mutex_unlock();
 
     while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
@@ -3654,6 +3662,7 @@ fail:
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                 MIGRATION_STATUS_FAILED);
         bql_unlock();
+        replay_mutex_unlock();
     }
 
     bg_migration_iteration_finish(s);
-- 
2.42.0


