Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A7E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKCL-00074Q-RG; Wed, 25 Dec 2024 00:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCL-00074I-6H
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCJ-0008Pl-Gi
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:44 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2166022c5caso53717465ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105482; x=1735710282;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I2zxAtTii6E1s8gPn0imFrR7S0+oZT+AgctpC/QrvNY=;
 b=f7piiHsSuHOeAtzTtz8UU7CuIUKRfAlR7fCWy2eUU03u81G5wxW3BU6Bqjs7jPaUbi
 bC+Uk4LjO6pp9V/7iMN9a1I/d8yukgHWevth3jmFQQwSYCcVObyf3WzxESo8IT41oBGd
 DjIX5aIvzZqleNEDfx0IU7qFIEguZCKLIVbNFThcQ3swfKmke+YT2h4cgK6ONegk76dV
 7If/u+TjxXzMmgKVnTKrMa5webvXggjF7CrH+rCGmqz9JuIJwcLNRks06dQucWQM6VJi
 tU1tGkK1y7F/VMoiMj6LYJx2dJxbXPQYIBTAfZOYhltoQyE/6sdFBzLnv+r9q1DAB4HU
 iNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105482; x=1735710282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2zxAtTii6E1s8gPn0imFrR7S0+oZT+AgctpC/QrvNY=;
 b=Bny1W6q1q1JPG+sLHu2AlBsfOFb3S30rm8TLylnRtD9ojhig8Lh469dlHmy4RXicCk
 XFsoBgMnHCCBaec83x3mFANaLl8We8g8eYDgh0NarEZQvUA39w5K4LvfeG6FnmK8PA0s
 QGzwCSjFkro3Zl0XkSk/CXe6Sry62LT8GW+aSn2ExzOqPceirkeQZvMcyMQz4FMlNSBo
 FxQpbLqKdxXO4JhfOjltLNhlWo0pPZkzZU9MjKkKHou/IMg8QCH0d3z28/nb5AvUxA0Z
 62SSflRsJxITXD8qsnRY2xnZ6WgXCxadQdeSVENaavzs50aGIrzKJJw9vNPAvLBWMD5W
 A7mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuPdDbOy8/eHeOJJMjGGOkrZjvxUSveB2UnKg4njO5lZcnGsKtpay92kLhtg63xHIggnO87xGV2uZn@nongnu.org
X-Gm-Message-State: AOJu0Yx6qRwrXK4zSvGIL+ONFI56868CF0rt9tmLJTazFHsnQanOc63v
 +muJAaUzRaX/w4GueRf13PbotmbozLH5GlZMtN8WXqkWLUI+RvkXB1nkSmrk/xw=
X-Gm-Gg: ASbGncuMOVA0vHwalnfZb6422J0SI40vt2fO+TRYXwmJwR//NZfnO8eniLoF+5Sdzja
 hzvCqzje1RoU5fwsPhD8WUx4af6H/mqoNqP2h4Lag++KI3nFYatP0NzlVTrq+9rgO/rBrbmEdec
 9gXz3MbrIxUQJlWLDsnOKQT6KIcD4OUimLAtpYkGo7af9soyfadiremrWJZfN5mBsIm/QwYHo6O
 3qkF7ZlOxvlx18YYfyY2kwrLHDehooFNxVy4Oxjcz9eyzM7atyNmCdd453S
X-Google-Smtp-Source: AGHT+IFMDWkKJ7l87KHA8cPNVTPzxOu2iDtFqcCdXahboFCjjNvWnMCxoebG85Ghxztx7R40H33bbw==
X-Received: by 2002:a05:6a21:2d05:b0:1cf:27bf:8e03 with SMTP id
 adf61e73a8af0-1e5e049456fmr28026644637.26.1735105481879; 
 Tue, 24 Dec 2024 21:44:41 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad90b2dcsm10580519b3a.171.2024.12.24.21.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:18 +0900
Subject: [PATCH 6/8] migration: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-6-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

rp_pong_acks tells if it has ever received one pong. QemuEvent is
better suited for this usage because it represents a boolean rather
than integer and will not decrement with the wait operation.

pause_event can utilize qemu_event_reset() to discard events.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/migration.h |  6 +++---
 migration/migration.c | 33 +++++++++++++++------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 0956e9274b2c..3eda64d7d241 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -337,11 +337,11 @@ struct MigrationState {
          */
         QemuSemaphore rp_sem;
         /*
-         * We post to this when we got one PONG from dest. So far it's an
+         * We set this when we got one PONG from dest. So far it's an
          * easy way to know the main channel has successfully established
          * on dest QEMU.
          */
-        QemuSemaphore rp_pong_acks;
+        QemuEvent rp_pong_acks;
     } rp_state;
 
     double mbps;
@@ -377,7 +377,7 @@ struct MigrationState {
     QemuSemaphore wait_unplug_sem;
 
     /* Migration is paused due to pause-before-switchover */
-    QemuSemaphore pause_sem;
+    QemuEvent pause_event;
 
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c85..bbce6f80e8f0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1522,7 +1522,7 @@ static void migrate_fd_cancel(MigrationState *s)
         }
         /* If the migration is paused, kick it out of the pause */
         if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
-            qemu_sem_post(&s->pause_sem);
+            qemu_event_set(&s->pause_event);
         }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
@@ -2135,7 +2135,7 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
                    MigrationStatus_str(s->state));
         return;
     }
-    qemu_sem_post(&s->pause_sem);
+    qemu_event_set(&s->pause_event);
 }
 
 int migration_rp_wait(MigrationState *s)
@@ -2343,7 +2343,7 @@ static void *source_return_path_thread(void *opaque)
         case MIG_RP_MSG_PONG:
             tmp32 = ldl_be_p(buf);
             trace_source_return_path_thread_pong(tmp32);
-            qemu_sem_post(&ms->rp_state.rp_pong_acks);
+            qemu_event_set(&ms->rp_state.rp_pong_acks);
             break;
 
         case MIG_RP_MSG_REQ_PAGES:
@@ -2486,7 +2486,7 @@ static inline void
 migration_wait_main_channel(MigrationState *ms)
 {
     /* Wait until one PONG message received */
-    qemu_sem_wait(&ms->rp_state.rp_pong_acks);
+    qemu_event_wait(&ms->rp_state.rp_pong_acks);
 }
 
 /*
@@ -2686,27 +2686,24 @@ static int migration_maybe_pause(MigrationState *s,
         return 0;
     }
 
-    /* Since leaving this state is not atomic with posting the semaphore
+    /*
+     * Since leaving this state is not atomic with setting the event
      * it's possible that someone could have issued multiple migrate_continue
-     * and the semaphore is incorrectly positive at this point;
-     * the docs say it's undefined to reinit a semaphore that's already
-     * init'd, so use timedwait to eat up any existing posts.
+     * and the event is incorrectly set at this point so reset it.
      */
-    while (qemu_sem_timedwait(&s->pause_sem, 1) == 0) {
-        /* This block intentionally left blank */
-    }
+    qemu_event_reset(&s->pause_event);
 
     /*
      * If the migration is cancelled when it is in the completion phase,
      * the migration state is set to MIGRATION_STATUS_CANCELLING.
-     * So we don't need to wait a semaphore, otherwise we would always
-     * wait for the 'pause_sem' semaphore.
+     * So we don't need to wait an event, otherwise we would always
+     * wait for the 'pause_event' event.
      */
     if (s->state != MIGRATION_STATUS_CANCELLING) {
         bql_unlock();
         migrate_set_state(&s->state, *current_active_state,
                           MIGRATION_STATUS_PRE_SWITCHOVER);
-        qemu_sem_wait(&s->pause_sem);
+        qemu_event_wait(&s->pause_event);
         migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
                           new_state);
         *current_active_state = new_state;
@@ -3833,10 +3830,10 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
-    qemu_sem_destroy(&ms->pause_sem);
+    qemu_event_destroy(&ms->pause_event);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
-    qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
+    qemu_event_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
     error_free(ms->error);
 }
@@ -3848,14 +3845,14 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-    qemu_sem_init(&ms->pause_sem, 0);
+    qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
     migrate_params_init(&ms->parameters);
 
     qemu_sem_init(&ms->postcopy_pause_sem, 0);
     qemu_sem_init(&ms->rp_state.rp_sem, 0);
-    qemu_sem_init(&ms->rp_state.rp_pong_acks, 0);
+    qemu_event_init(&ms->rp_state.rp_pong_acks, false);
     qemu_sem_init(&ms->rate_limit_sem, 0);
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);

-- 
2.47.1


