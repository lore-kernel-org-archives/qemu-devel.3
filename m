Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AC7E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaTI-00020s-Ro; Fri, 20 Dec 2024 05:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaT6-0001s3-JJ; Fri, 20 Dec 2024 05:42:52 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaT4-0005Cp-5H; Fri, 20 Dec 2024 05:42:51 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2161eb94cceso11761945ad.2; 
 Fri, 20 Dec 2024 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691368; x=1735296168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYauowC6m1dSqSOOvIXZEtWuC27GaY5hc1iCZUJ/IDY=;
 b=H30Fdw7dF6wscp97B8ckdyV/pR2uvnEhVarRxbUUD/jrxPWyT5OD0yYrbjiNj2KymO
 oXMbjnI6sa7GdUsrx0cdwkDO+oXIn2OqRxc9jOI/tuAZ4gBIvg4cfrKA04yyJf1QIzD5
 KdrChpf7vVj40X+Xd4Y7nJvIiJ8qLzufbb7bn7+KR1p19C4NzVmhzYnO08/rw6yOLxwV
 x/7gi8fq1ozAv33fsrnyaUFtSrBl0snTHOVEqOkjRhcql5jSuPg4Qq5fl+4UoEHZzcKX
 vNGQ/i7qUnJ/4dQTAqe24g1HcZ9zq2Tgw6fUM8rbMOF5bX/uQsA0It+8qOLEEL9Nr6SF
 4cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691368; x=1735296168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYauowC6m1dSqSOOvIXZEtWuC27GaY5hc1iCZUJ/IDY=;
 b=DJ+l+buaVjNQBpe7DXnrJ2ouuHhgAq5rk8W+VMe4MEwKSDB/ZN5CbwA6ThO6SfZHdQ
 i7n3jnJbvV2tIcoTM+CwACx8UddntKl7iqqtmGXPmrvR3BizDErPap7CLK5K/SopZ6Gt
 B67WOS0djGvmnGkig4Mibq13uU5axJCweo/7AJYopz16gY7RPNA3LJx1AuE9REJy1npF
 2d6aRwPByMG9DjbTPDPJh6Dyy0jYFttUF5P6vKZIEIX784+YNqKHVXmeSfPquH1DVOq8
 wJaqxRteb/hRcrV+A6S8IN1oh+ZNI2P7g/hXQ1I7KSMc19j8pLGD/uhGZ3mHb3S+v9rX
 tQ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdAGYFpEYg0KexkJfYYtq7SqNk7wfhBG7hUWmQkg/GSHq6hwMtIq7EVq8zIr9whCXuPk8SXIdxjvcm@nongnu.org
X-Gm-Message-State: AOJu0Yyd3WN38Z2q0EvD7A48/XA4eDS4V8GQflVBPEaWxB5VOerbDGJC
 1Hi8QKuj8gF+vCRFb5p9tEv0e0xY+XG5uHFtzjP46IOCAQUs8PDqSU3qtw==
X-Gm-Gg: ASbGncuxzVzNdqK9KQnkelLlS86udb+N1fwgUDHghb0LAv2c5qnlTwaP5OquW9OlxQg
 C5lzDO1UmOP7cLcQQH/D1KZNIPMUce2YZ5YQrIJRRVIXaTU13D602fIFEkPTWTBm6aF9GJuU8+C
 qmZjPNLCnrBYngiMwLaF4BN/hMKQr8tVmqL0rqTlawFtYaYaBFlNgoqPZ92S1Pq71vIYeEKJnjX
 oADUwSBUG9GprQ4vsDD6P+hy374Ot44kKPOdr9LXsaS7AKGvqy2aByTvNSak7UDNfeSR/7jzUMH
 RwifB7wYow==
X-Google-Smtp-Source: AGHT+IG1LubnhyxHCMdczXSH/fXeerTfPXvXsmGZLINQD0+k2LGCX5KTQV6fRZoo9KcSXow1AgaTQw==
X-Received: by 2002:a17:90a:c2c8:b0:2ee:ead6:6213 with SMTP id
 98e67ed59e1d1-2f452e4c536mr3868057a91.19.1734691368253; 
 Fri, 20 Dec 2024 02:42:48 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:42:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 02/17] replay: Fix migration replay_mutex locking
Date: Fri, 20 Dec 2024 20:42:04 +1000
Message-ID: <20241220104220.2007786-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
index 2eb9e50a263..277fca954c1 100644
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
@@ -2518,6 +2519,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     }
 
     trace_postcopy_start();
+    replay_mutex_lock();
     bql_lock();
     trace_postcopy_start_set_run();
 
@@ -2629,6 +2631,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     migration_downtime_end(ms);
 
     bql_unlock();
+    replay_mutex_unlock();
 
     if (migrate_postcopy_ram()) {
         /*
@@ -2670,6 +2673,7 @@ fail:
     }
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
+    replay_mutex_unlock();
     return -1;
 }
 
@@ -2721,6 +2725,7 @@ static int migration_completion_precopy(MigrationState *s,
 {
     int ret;
 
+    replay_mutex_lock();
     bql_lock();
 
     if (!migrate_mode_is_cpr(s)) {
@@ -2746,6 +2751,7 @@ static int migration_completion_precopy(MigrationState *s,
                                              s->block_inactive);
 out_unlock:
     bql_unlock();
+    replay_mutex_unlock();
     return ret;
 }
 
@@ -3633,6 +3639,7 @@ static void *bg_migration_thread(void *opaque)
 
     trace_migration_thread_setup_complete();
 
+    replay_mutex_lock();
     bql_lock();
 
     if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
@@ -3666,6 +3673,7 @@ static void *bg_migration_thread(void *opaque)
      */
     migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
+    replay_mutex_unlock();
 
     while (migration_is_active()) {
         MigIterateState iter_state = bg_migration_iteration_run(s);
@@ -3695,6 +3703,7 @@ fail:
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                 MIGRATION_STATUS_FAILED);
         bql_unlock();
+        replay_mutex_unlock();
     }
 
 fail_setup:
-- 
2.45.2


