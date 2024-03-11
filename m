Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C042C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeP-0002Xy-2g; Mon, 11 Mar 2024 13:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeN-0002Xe-JK
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeL-0007MR-IS
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e617b39877so3316088b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178880; x=1710783680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMEZpjRyPRfKkDXLG/bfNm8VyDDx9klR1nHqEDUL4Y4=;
 b=NoG47XadnOeegq3RUZtOGPpnxz2ibQKaDIjj6ngl1xiocb/mfzTmWrC77WdUxyuo7b
 5l+FBtckOf2s5pbKDI3TIMhO5yB5whBwANCIvwh31Ygxoe8jWIgzSdlr4v6LTYc1W8Gh
 PXyhupP+EDUm4xy80c8nEc6vF8pSNSogUkfPbmKPFl5e0U+yYom/GH/RLbIpDC8j6Fwj
 U5KGd+QwIssgZL3DbSTfKzLi5cIQSDvWc9mN9WRHnZ5qJK1o2ZRr1XSSKVjxRslFwmPM
 nM5hZdGd/hXFAaPtndCPcjVvHupFMSFFFfhR+W5c0h+hi/cegBjy5yAeNkVHKrJ2QKAc
 ZmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178880; x=1710783680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMEZpjRyPRfKkDXLG/bfNm8VyDDx9klR1nHqEDUL4Y4=;
 b=WYovVl/VEjb2kUSKvci4Xt+9dvALeDrMHR3/CPFWAYB4fb1d+JROJPx93EK7gxEVOf
 5jc06R9mpjUNtdaTMNbVNqf82qmSVk6iIdPKEwp1RUy5shRIpif4zvcROxHtuIva7IQL
 OcLejSlcfaps+LGwTJupeYkqLAhReKFnOVWTBP3lQLTZkVx6UXxmrOaRBXXxwzcHNu9v
 1HEROQ5IVCr/P5md6/ud1CUUcML2U1/1iwD06p/b/bnpn1PihiWmADiYVTtI3869I67m
 7z3JYtBbHA9jZOeeMOHmLlBXCksAC/BTJDYeNQc07tyQ6t4xFRUIeEVqtyrK7v1dj3GL
 xJJg==
X-Gm-Message-State: AOJu0YzOMsqi0SJQliphQnZ6HpH2DFRD6nQ7c4wskJuEio8I0AYsrqOE
 pIgLvH/Sch52xlUyApSFhd0aOJsaycuSHahAbMGW9qCC0qjKwJy4oW4zcy3GDSk=
X-Google-Smtp-Source: AGHT+IFSbzNsqPBt7WGMkK6pNoGKFww4ClleaAgRSG4GH7Y42cpjHhdZ9x236KQgswFfYshqns8Feg==
X-Received: by 2002:a05:6a21:33a1:b0:1a1:6c6c:97d with SMTP id
 yy33-20020a056a2133a100b001a16c6c097dmr5344619pzb.57.1710178879905; 
 Mon, 11 Mar 2024 10:41:19 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:19 -0700 (PDT)
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
Subject: [PATCH v4 08/24] replay: Fix migration replay_mutex locking
Date: Tue, 12 Mar 2024 03:40:10 +1000
Message-ID: <20240311174026.2177152-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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
index 86093b34bf..7a24f94425 100644
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
@@ -2525,6 +2526,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
 
     trace_postcopy_start();
+    replay_mutex_lock();
     bql_lock();
     trace_postcopy_start_set_run();
 
@@ -2630,6 +2632,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     migration_downtime_end(ms);
 
     bql_unlock();
+    replay_mutex_unlock();
 
     if (migrate_postcopy_ram()) {
         /*
@@ -2671,6 +2674,7 @@ fail:
     }
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
+    replay_mutex_unlock();
     return -1;
 }
 
@@ -2722,6 +2726,7 @@ static int migration_completion_precopy(MigrationState *s,
 {
     int ret;
 
+    replay_mutex_lock();
     bql_lock();
 
     if (!migrate_mode_is_cpr(s)) {
@@ -2747,6 +2752,7 @@ static int migration_completion_precopy(MigrationState *s,
                                              s->block_inactive);
 out_unlock:
     bql_unlock();
+    replay_mutex_unlock();
     return ret;
 }
 
@@ -3573,6 +3579,7 @@ static void *bg_migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
+    replay_mutex_lock();
     bql_lock();
 
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
@@ -3606,6 +3613,7 @@ static void *bg_migration_thread(void *opaque)
      */
     migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
+    replay_mutex_unlock();
 
     while (migration_is_active(s)) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
@@ -3635,6 +3643,7 @@ fail:
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                 MIGRATION_STATUS_FAILED);
         bql_unlock();
+        replay_mutex_unlock();
     }
 
     bg_migration_iteration_finish(s);
-- 
2.42.0


