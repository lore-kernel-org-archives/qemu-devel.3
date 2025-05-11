Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C88C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzsL-0002Ft-4j; Sun, 11 May 2025 02:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsK-0002Fl-7r
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:24 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsI-0003xr-D2
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:23 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30c47918d84so1973551a91.3
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943760; x=1747548560;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+CWIIiX3AaFzlSwGIwDouhtsC/hNwkjMU2nYYnMRMQ=;
 b=GPMRoUJPCQIfoWkKHCmW+o46WPOwfkbk1hg80GG4spqrbNNbdoGDL1//MZZcY++L1l
 XqUso+Nqrfafb0sLTZg5bWHepELAb1NjNTq+TIrQV9A2tQRxi3RNaHEa00XbhsDUIIqR
 dZa8immgI49k9N57uaF456eDdBz1UvL/7q6KmCaSFSiSmOHf6RauZBf3Krhsn/k0Heql
 fychpO6GZFEkGXtL+DcmRC53vgmehSXSGSK+Em19gdep6MoJnQaOGGvtdS9HomvLGO8s
 dhv9a1Zxclg6nt1rBXiVAgK5exXMarB65Efq+J1R9x6Xroh86cwl85jH8ssniyE9DyQr
 0bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943760; x=1747548560;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+CWIIiX3AaFzlSwGIwDouhtsC/hNwkjMU2nYYnMRMQ=;
 b=Jc1YEz1ae2Bo6y84724EFujc4EqsIbLLT+h3LZp7D0/UiXa8J1oVZzX1/tR8LfMPJm
 O+xRghhViIKthO4+DeCEZ4Ofo8yeT9pBAqYyUgzkLiKOuXfZt9JY4IXvG8OdZ2EXTDWN
 YRdIJu3y6tg4BOjQESZPbZyz2y390nCF6TVnm/iuHWlZUyXylmtKjTvd8xL+h8HwaxPO
 alDYM+TN5yb83b2cD8U/hTbw7bMih5ZQLSk890OODstiNLtSver7rWk4UmI2gl53xJTo
 hZ/xux+w9mUXw0R0tt3Iq2V2RTuHD/3HfAb6Kqi/9/0QG3A9+N1yPFClrg1gU+/5rh7q
 a4ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqG3ROKAR5DEzxNZgABSIjwNi/AN41xz4PQoe7DpAIQwWrEVCybMSaNJhNFUYX8W7FGE3gaWevp9y4@nongnu.org
X-Gm-Message-State: AOJu0Ywbe8JskU7/Q1x7j+MBWNwRJOnWUHCPT/kxob4gi4UUOmkbAJW0
 KgTUMPqYFjbt7G7MUXE+OjVwFFT/hhXAtOzk2a2MvroPxGl+Qo2zY4d4uL+vIXw=
X-Gm-Gg: ASbGncsoabhwEOJWwMmfb22pAaOa1luKOc9/1Owz2EW9Xl2hVg9t1aRpMeSaD04neDI
 aTVbOj/q772DlpBwFLrVJni4NDibn9/zL5uF1uP7QHMPwQNrs6WmILmQ52w4s3HFghosvd1tnQp
 Dh5x+8COoqTMrudVEn6AcQYy8UKZYyctnWboSzDwZUfhnH9o9cB9MOSwobJmsqj+HnT/D4C5Wph
 wsK8uINQGK0DZyBAYt0szCB7YowCo2U/uUiSlpd5DM0ytcqWO+rHHD5kxg/nk1HXafAns5HEOqN
 +YH6iosvFd5p0+D+t5+le5JwKAlbsBNM7f8IhOQZfl43UWzHeWWj11c=
X-Google-Smtp-Source: AGHT+IF9me/4K9/JPE1nqK8IuOo+BPJKkWaZeC3sbcpmOq4AlIy3/O86X2RNtHch/97NDiUUjf6wGQ==
X-Received: by 2002:a17:90b:4acb:b0:2ee:f677:aa14 with SMTP id
 98e67ed59e1d1-30c3cefb8f0mr14611394a91.13.1746943760499; 
 Sat, 10 May 2025 23:09:20 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30c39df09dbsm4360974a91.26.2025.05.10.23.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:25 +0900
Subject: [PATCH v3 08/10] migration/colo: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-8-f7f69247d303@daynix.com>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
In-Reply-To: <20250511-event-v3-0-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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


