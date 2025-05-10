Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC3FC3ABCC
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwf-0006Hl-0H; Sat, 10 May 2025 04:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwd-0006Hc-EL
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwb-0005eG-Ic
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e7e5bce38so32523345ad.1
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867148; x=1747471948;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+CWIIiX3AaFzlSwGIwDouhtsC/hNwkjMU2nYYnMRMQ=;
 b=2puR8EYPZ0SrPyN3ZiyTSJvHyyLIPyzPkgAlH5HA0ZMQyX70a95VdF90nIjCBhtFAl
 IN069JlvC236yhFhULbibgEL7sFW2C1A2a7Opjb41yVnX+3VlpJgzrXdWJoiGY7gtD/z
 kbmw2uUDjGOBDD2WXN3po5TZfhEuNJjSjsjAUsONRcSAO3ARGwR5bQ/tBqVn60E+XaP6
 akVm6H452yr/4z7M4Wvt+E3GlWRj1MMXwH+La20WK29+1gflZjdCnYar6Iy0AfKNKGkI
 PlgxR66Lm+oO1OZPsbXKnB0Ns7PxkAaxSSqIpEMoybF3W3/0Vk/GkjKZSDOB9/RyHSUD
 87ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867148; x=1747471948;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+CWIIiX3AaFzlSwGIwDouhtsC/hNwkjMU2nYYnMRMQ=;
 b=lBpZI/YlEr5VMZfExE8vjsgjk6rDeZ9VC2G5YVq1uQ3veABBu8hfnlX2v0+FLjpteO
 7rwWaWPVvCx8irkds+WOeZ3megtIH5et73FrS5O6w7Y0e672Vqeu15mIcPbwivB/vdnt
 Oh/lXfPP3Km299KKenY8ZV2BeCJvfP2Urysmp8DFg+q36Cop1n7sis+Nb8fKpwSJXmYf
 cP5tOLy0PEpDdk8id4pepF5CZ8W8c5+DY2MbzzzlAqieVCWkoeirxyV+ao0ho8XKW0TE
 ss7kmYGDN/gPAtCsXf2tLJyERlR0sXVbxDAUeyxNu+2N7OAUN1DvnehiNuuNkRlnm+8w
 wdLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZvUOst+zvLBRUPlBSQjsmi7Tw19ukUD6sAopaAJscPonozg9U+hBsw6V8WluQw7/dM/Nb/HAl0NSz@nongnu.org
X-Gm-Message-State: AOJu0Yx21IW62FPzAwo5Jy/agKIgSgsUqL30kVwlq7oZBYBG0b4J2tIy
 QGBTxHPsXoPF8QQ/CDHY1LWv48Np13kqUQKRmmKw46yPo7UFRQL1tRgPzhsSx6uTPQ6/y/cJDcq
 U
X-Gm-Gg: ASbGncuYMwODe+jBV0sRFCk7J9tip2I0dcKLQ62Uu95wDdT9bwi7t73l8sf/gOfy1B7
 yZDcRlLgsleo0iW3PGuWlJ8ERzoT9mWYPlR7KKh1P0A/eIjneF1eRc37t6ADBe3bx5r1EWLaIoe
 zwujvJLR4UOg5wKGn5vvL7BwPU0uO7Xwp3Y8ip/AgSmWeuyNqhZE4sCLwQjzzgy6ErdaHh0TclB
 eFQ9PmDG0OEXebK/MESxTinvrsJkm5ey8D3/VCUdzvFTXX8fvfG6PH9dVKB4YOkRsVIF3uKEFtI
 mJq0iz+vlTxvUtjkOFFFmtRn1rLaGoH84vle664ZEeeD4pdmAIOxqF4=
X-Google-Smtp-Source: AGHT+IHXc1kMF743qDXu9vAxxilBjgILjX4E7XvZHM7SXGGfC9rpoK6EPvxHFeLdAHgyR3gbzmzTfA==
X-Received: by 2002:a17:902:ced0:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-22fc8b339a8mr107114645ad.22.1746867147924; 
 Sat, 10 May 2025 01:52:27 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc828b42dsm29198135ad.188.2025.05.10.01.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:52 +0900
Subject: [PATCH v2 7/9] migration/colo: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-7-7953177ce1b8@daynix.com>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
In-Reply-To: <20250510-event-v2-0-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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
index 11dba5f4da77..eec49bf3f893 100644
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


