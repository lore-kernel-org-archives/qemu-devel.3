Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2764E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKCP-000792-Ir; Wed, 25 Dec 2024 00:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCO-000789-Be
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:48 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCM-0008Qx-OA
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:48 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21631789fcdso49506365ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105485; x=1735710285;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9kcEUHiyxDZGRPQsNHM9e2ujEEZ3RNUAoqhQJShkCqI=;
 b=hnhH8vvMwvebcYwCDh/r3pgGaj7/DS1JKnvzx9DjgAXtsl9lyovaj3TfA2RsjGWCTk
 rD9FR7zHAJrTu90n8ZAFRkJs4ifJFE0dLWNFpHdFj0JOvt2ru7Ry6c8QEeApHq8dETUt
 aX6NVxDN9wY9yM8x8pVwtBYLCSaBsgPEMhp2g5VepJ87Gt3AogJluOQhqhszxkchVlkn
 4i2XIhlltioVSsuS15mlp3KzMRKiCPFJeUc9lTLm7xTxSMi6YNxDiZ074lsh806E45uA
 YX3MFXOy8gKTr4PpqpKmqXu65VRMBmOICt5x/w+1OOxhWSBeRgKKNWuFOQV2xXr6uX6M
 cc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105485; x=1735710285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kcEUHiyxDZGRPQsNHM9e2ujEEZ3RNUAoqhQJShkCqI=;
 b=fL4PhhsF7vdxmGJOOOE5eZIyDAtuxNDeuuSvmj6n2qTPgUlHaw8Ikw7jvQ6WjKSsyx
 b1sUc3obqlnsYUO0g2c3qROmdvr0uphquIYDhfUIORjotUZYnG+iwt/8HNOTorErPYHv
 tivv7Oh8Up/IqmwC/UUuGiKeNMtSYNnq3f/ocn4gMJ8WfjWJ5BH6Z7Trx//Hx3Wj5WIM
 YRMEXj/E1WV2PwWJHb32InN9/hwp0IAqlksYmUCNBq1cro4wT6W3GDD8QWdIWlVDD9z2
 oLExvyccw/SDJ63yboVuAJ+ZCaW8nbqEQIPNac1lOQTj4qll28n55YOWMdJQJJgXXx9s
 QumA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmS0YIH80+Pv+lek0HXAUK4XgxymX9Y8mO0O/6K5s0eNgcfZaVTOue+7+KP2lnbAP9ifttPOW6xodb@nongnu.org
X-Gm-Message-State: AOJu0YxBJSXIOlD5BlXQhrp0kGzX+IAD48JW+0qGAC8U/gPA56f2hBN6
 fhx8/s4kx27fUKWfgc0ChCaCTGUWXi6OIHXKSy4Pw2py8hifJsIwtVndM4T/Y9k=
X-Gm-Gg: ASbGnctG9qZXEBGAwm5yCknZKjfWMY1vTwdFEijU6U8hcj/l+bl6IsqtmggmfIyCser
 S64Uk1mfE96OHPDrR/MzKxllrxnw6rgI01fP6kI1GElbCKtK0WoQbYSa0eL3unI6Q0do23Q3zk5
 J0guFqSDfjIn+v0fHjGc3j7s/Uh36aCpkiib2Tj3Xkv40Lkp6XRx2Rnkc/66BPepM+9xBohSOIB
 DyQTALS67mh+qM/iU6VdOciN4MU7V8sHDWTuxNjpFv1CmNhwRjtxNrOJYLj
X-Google-Smtp-Source: AGHT+IGwJbLuuCVHrBOvwuWs2ZWuZkhYybR5dwh9IuZpEJQkVdRqpXUw0YED3Rt/o2NdOITzXBahOA==
X-Received: by 2002:a05:6a21:78aa:b0:1e4:745c:4965 with SMTP id
 adf61e73a8af0-1e5e1e26dc3mr27818779637.8.1735105485491; 
 Tue, 24 Dec 2024 21:44:45 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72afb89fedesm1197240b3a.84.2024.12.24.21.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:19 +0900
Subject: [PATCH 7/8] migration/colo: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-7-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

colo_exit_sem and colo_incoming_sem represent one-shot events so they
can be converted into QemuEvent, which is more lightweight.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/migration.h |  6 +++---
 migration/colo.c      | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 3eda64d7d241..14032e347ece 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -185,7 +185,7 @@ struct MigrationIncomingState {
 
     /* The coroutine we should enter (back) after failover */
     Coroutine *colo_incoming_co;
-    QemuSemaphore colo_incoming_sem;
+    QemuEvent colo_incoming_event;
 
     /*
      * PostcopyBlocktimeContext to keep information for postcopy
@@ -379,8 +379,8 @@ struct MigrationState {
     /* Migration is paused due to pause-before-switchover */
     QemuEvent pause_event;
 
-    /* The semaphore is used to notify COLO thread that failover is finished */
-    QemuSemaphore colo_exit_sem;
+    /* The event is used to notify COLO thread that failover is finished */
+    QemuEvent colo_exit_event;
 
     /* The event is used to notify COLO thread to do checkpoint */
     QemuEvent colo_checkpoint_event;
diff --git a/migration/colo.c b/migration/colo.c
index 9590f281d0f1..7e29c93aa4df 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -146,7 +146,7 @@ static void secondary_vm_do_failover(void)
         return;
     }
     /* Notify COLO incoming thread that failover work is finished */
-    qemu_sem_post(&mis->colo_incoming_sem);
+    qemu_event_set(&mis->colo_incoming_event);
 
     /* For Secondary VM, jump to incoming co */
     if (mis->colo_incoming_co) {
@@ -195,7 +195,7 @@ static void primary_vm_do_failover(void)
     }
 
     /* Notify COLO thread that failover work is finished */
-    qemu_sem_post(&s->colo_exit_sem);
+    qemu_event_set(&s->colo_exit_event);
 }
 
 COLOMode get_colo_mode(void)
@@ -617,8 +617,8 @@ out:
     }
 
     /* Hope this not to be too long to wait here */
-    qemu_sem_wait(&s->colo_exit_sem);
-    qemu_sem_destroy(&s->colo_exit_sem);
+    qemu_event_wait(&s->colo_exit_event);
+    qemu_event_destroy(&s->colo_exit_event);
 
     /*
      * It is safe to unregister notifier after failover finished.
@@ -648,7 +648,7 @@ void migrate_start_colo_process(MigrationState *s)
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify_timer, NULL);
 
-    qemu_sem_init(&s->colo_exit_sem, 0);
+    qemu_event_init(&s->colo_exit_event, false);
     colo_process_checkpoint(s);
     bql_lock();
 }
@@ -805,11 +805,11 @@ void colo_shutdown(void)
     case COLO_MODE_PRIMARY:
         s = migrate_get_current();
         qemu_event_set(&s->colo_checkpoint_event);
-        qemu_sem_post(&s->colo_exit_sem);
+        qemu_event_set(&s->colo_exit_event);
         break;
     case COLO_MODE_SECONDARY:
         mis = migration_incoming_get_current();
-        qemu_sem_post(&mis->colo_incoming_sem);
+        qemu_event_set(&mis->colo_incoming_event);
         break;
     default:
         break;
@@ -824,7 +824,7 @@ static void *colo_process_incoming_thread(void *opaque)
     Error *local_err = NULL;
 
     rcu_register_thread();
-    qemu_sem_init(&mis->colo_incoming_sem, 0);
+    qemu_event_init(&mis->colo_incoming_event, false);
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
@@ -920,8 +920,8 @@ out:
     }
 
     /* Hope this not to be too long to loop here */
-    qemu_sem_wait(&mis->colo_incoming_sem);
-    qemu_sem_destroy(&mis->colo_incoming_sem);
+    qemu_event_wait(&mis->colo_incoming_event);
+    qemu_event_destroy(&mis->colo_incoming_event);
 
     rcu_unregister_thread();
     return NULL;

-- 
2.47.1


