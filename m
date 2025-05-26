Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB169C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPj-0007CP-Pi; Mon, 26 May 2025 01:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPR-00074C-RP
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:30:03 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPP-000201-RW
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:30:01 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af523f4511fso1337519a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237398; x=1748842198;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y56cHzHZWlV77Wo3JGLP7D1wbcZaYNSJhjNY7y/xjyk=;
 b=sNl2fY2sYTebBEkr6Ii5r5aWAk3Jz6udeORoCRQkmmaY+yaWt0JVAQVmJ146CXSgKB
 xK6V+C2h43n353htT9c/4GP4LS8kMzecgP3ZoJOLCS/OzL3ifMcMPA0RJvc5Wc/wGM4X
 OC0g+Jve6dntpATMlgP+mP8s0nTSlvJAj+LkdfFHZjCFyZVuynzNwAy4mavOcP5cKNh5
 J0QO7cnBf6NYhaSF8xE4axMT9BIrMFokDFB+Bux4LBQ44PAk5GKT9JvaOEKcVDqxCpL1
 3vXHX/HYF6PLcZu4qx5a9CZ92GFjfKqkqoXCn89VQhIbgxR3XliioEk5M0cFNvYGuNLG
 cLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237398; x=1748842198;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y56cHzHZWlV77Wo3JGLP7D1wbcZaYNSJhjNY7y/xjyk=;
 b=E/WXykFjYxhj/DSQhxh/ZBxELhhJsklB76ka6EgRbBeEIgHNZ2QE2tmYyFSRCevRw1
 9syGxQhrfhQPtqjcY9tiKV5GEDTCt7UCY7J8lChIRgjHGErsKuFtuwb+2dTzslyRF8t8
 Fx6Qo93anhGhmlasHXQWWc7JIjpXMIBlpJgpUAgIRGuYXnyj8wtRBrzwschqEQxF+ta/
 ex74dyQjV78UJ+CvnDRbGKXM8t53RPAdLbiRpcD2DzmfnVzv4GrT+zVrE4WCNnnURNfN
 KlP4WQoeR+Ga+9jrFcCOiiucKNBu2cfsmC8JHXebtNqpCkcBtzhAPJi7E/ppoZmzXw9l
 qKkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVne3sDweTKieoSo+HA2jnqWkUBMoHN4fKHFZ/y9WM29DhMWSRcNJD1XgkAuwgtHX1t0PKX3Mw4cSmQ@nongnu.org
X-Gm-Message-State: AOJu0YxthtKjnN2Gegdk+NpZGylP4bFr4LHh9c1UZXfH8/QTkgjSSczU
 oCP8R4os+X/UfLOrjAXAT1pU9J4VNau2ftdrEPkGVJVOIRahTxPPez7Ng9wJNIMVSaw1l7AYeJb
 QxgIX
X-Gm-Gg: ASbGncsGrH4UP0yNFiDCnjCkNdawygFmhxzc3JQcCf3rvsJC998qpfzdXr1V/iDc3eD
 UEyLNPveQRXgXv4Dp0mBUbJLtsdtE28NE8c4kRYMwdmyJ1dFerIFw8mnCDVrW1HSyV7wPMkjRlE
 LlOwm7ykkwHPJwd5kkhQYCO5H3CN2pwFFa+AFEGRGHGeCX/jKSmShokAhFqp96c4/UpxrFWIIXu
 Yt7SacsW1BNJwUsKD2fiXDkCBGqEAiMeqq/T/ICr3wR/Jz3o2vKr9YmvO6p6MyZwTY4igE6bYs0
 Y50KVEGrla8rN1zsmsSI2wD0ZTzPMeWHhAPOI4JYqGmci/0Os+Pi
X-Google-Smtp-Source: AGHT+IHDJjlrQBldMt9ASthhJIK+Jb5llLpjxAHKZxE+OsbwDSgqUuRVtQXVbkHAeWBFDZmeyd6nxA==
X-Received: by 2002:a17:90b:390a:b0:2ff:58e1:2bb1 with SMTP id
 98e67ed59e1d1-3111203488dmr10246656a91.32.1748237398035; 
 Sun, 25 May 2025 22:29:58 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-310cec3f320sm6925739a91.9.2025.05.25.22.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:19 +0900
Subject: [PATCH v4 09/11] migration/colo: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-9-5b784cc8e1de@daynix.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.h |  6 +++---
 migration/colo.c      | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 21aa6a3c8fee..aaec471c00f8 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -186,7 +186,7 @@ struct MigrationIncomingState {
 
     /* The coroutine we should enter (back) after failover */
     Coroutine *colo_incoming_co;
-    QemuSemaphore colo_incoming_sem;
+    QemuEvent colo_incoming_event;
 
     /* Optional load threads pool and its thread exit request flag */
     ThreadPool *load_threads;
@@ -381,8 +381,8 @@ struct MigrationState {
     /* Migration is paused due to pause-before-switchover */
     QemuEvent pause_event;
 
-    /* The semaphore is used to notify COLO thread that failover is finished */
-    QemuSemaphore colo_exit_sem;
+    /* The event is used to notify COLO thread that failover is finished */
+    QemuEvent colo_exit_event;
 
     /* The event is used to notify COLO thread to do checkpoint */
     QemuEvent colo_checkpoint_event;
diff --git a/migration/colo.c b/migration/colo.c
index c976b3ff344d..e0f713c837f5 100644
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
@@ -620,8 +620,8 @@ out:
     }
 
     /* Hope this not to be too long to wait here */
-    qemu_sem_wait(&s->colo_exit_sem);
-    qemu_sem_destroy(&s->colo_exit_sem);
+    qemu_event_wait(&s->colo_exit_event);
+    qemu_event_destroy(&s->colo_exit_event);
 
     /*
      * It is safe to unregister notifier after failover finished.
@@ -651,7 +651,7 @@ void migrate_start_colo_process(MigrationState *s)
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify_timer, NULL);
 
-    qemu_sem_init(&s->colo_exit_sem, 0);
+    qemu_event_init(&s->colo_exit_event, false);
     colo_process_checkpoint(s);
     bql_lock();
 }
@@ -808,11 +808,11 @@ void colo_shutdown(void)
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
@@ -827,7 +827,7 @@ static void *colo_process_incoming_thread(void *opaque)
     Error *local_err = NULL;
 
     rcu_register_thread();
-    qemu_sem_init(&mis->colo_incoming_sem, 0);
+    qemu_event_init(&mis->colo_incoming_event, false);
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
@@ -923,8 +923,8 @@ out:
     }
 
     /* Hope this not to be too long to loop here */
-    qemu_sem_wait(&mis->colo_incoming_sem);
-    qemu_sem_destroy(&mis->colo_incoming_sem);
+    qemu_event_wait(&mis->colo_incoming_event);
+    qemu_event_destroy(&mis->colo_incoming_event);
 
     rcu_unregister_thread();
     return NULL;

-- 
2.49.0


