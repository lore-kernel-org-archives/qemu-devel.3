Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C8AC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6O-00037S-LE; Thu, 29 May 2025 01:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5y-00030o-SS
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5x-0003Ci-5O
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso279068b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497584; x=1749102384;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGMllNp11Bzuz5gkfMDJ/VK+KdieqBQO5cT9kGzga8M=;
 b=xp7K0wtuLoiUBVglce1BvmXNdZfiHxHyEHgZ4Whw+e84LiOZfl5WibgxFW2/bEyPoH
 En/LsjgX+B21G4iGazvBTCnt7A8KGhQOV3Kgom24fkmCIc3TvtdbD07+O5IdMXPRejnA
 5d8gjLy5+nSVbCqH1JACDGzqO3L/X+3sXxhunRg0OcYZtZRk7OSOvQ9p90DUa/s4vwzx
 g0n3rd6TTXRbz+ZHID/f/N7C9TPRUzLV0Rzsl3j8Sx1c6cwELkbvnt3L8Sww9MLBBEaL
 Ee6Tl79ATpeRLK+fUjDFLjDVWqv+qa/9DGjvbI9vOXlQ5pMkaZQkAB+Oi8JpU+UFOzxq
 p5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497584; x=1749102384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGMllNp11Bzuz5gkfMDJ/VK+KdieqBQO5cT9kGzga8M=;
 b=p5tREhCGJA4RjuHuvad93Q8064WmV+BprE/O0wuMRgdXLItFUAqMe0XY4ZdZ5rMeqV
 jnREjNpx0a7RvJ14b2pd9yO96z4j/U3C2NqqPSTYWt1xKUM0ZoIQHpVljribgptpK8Iy
 s8OHk7spJQrEUOBg3582eQme91dcxC4+1HrNaygsnz1yMUrz9TNdvR2CnI/KQ+URWUa+
 8a1+N6NZH0V2CYq971+FOJ1RodjU7/2WWOoNHaKJgwgeK455DSFpCiAnvTs8FMULftcP
 dIf1Nl0xwgIwvNhRY+quav/RYl+nK7zLr9mmzxwz3IKQLBDMBX2lf7HsxvA6EdlCClDB
 EkpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWrFuQTJOq2HN7L276YNiYX965viVoW5RmGtt3eVlvJ1VvPd0gxO0mFIta/YEbXeXBijMb/aQxEKWZ@nongnu.org
X-Gm-Message-State: AOJu0YyL6eMyTu5ZKVlyBzW9g7w6A9lZjv6OYM/GuvR4yuXhpOBQdzRb
 b73pBj2PLG8/XjgxXH87bS5SrukJRiS+2P7LJ1Buk8PK+6D34Gfbmmppnxv3Q+KYID4=
X-Gm-Gg: ASbGnctSlM8LFRWoRpmQD42Eb84vIeF+dQTQQhzusSNtY1TzhLNUAe4pZaFfgIQ1dhg
 loEx88sXbEDePpwVnvdx8b6mcy3ik1ZC1cpV3C/M9qTYOWefCSBxSXvJgeQF3HiFVo5bOvqYhWR
 loGUDNV3kH8uOepkeRZ3cDERxJzGHUSWTJTix7IQm+92tKzoGmj+GdbBHlkDqwJLdN+Fm6BxyB6
 upnb+zT/HRC1ODb/w11FV9hnmKFJiFYjjv9pfAXAzgn96UwballAKHw7pxec1vyqXAhfjXHzrqI
 PDjg1b7SsW2AeDcKzZRTTYTaWC4L1xsue0J2TIV33yNvpQIGIDnO7qL+iqpYfvk=
X-Google-Smtp-Source: AGHT+IFPuA/G8lHqHLXe6+LqzjLsfhKkBa6Rgvc0RJd4f4ToAPYDCTa+zQtCsdw6hFGyE6R74EoPgw==
X-Received: by 2002:a05:6a20:734c:b0:1ee:dcd3:80d7 with SMTP id
 adf61e73a8af0-21a9caef890mr8965126637.0.1748497583869; 
 Wed, 28 May 2025 22:46:23 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747afeabb13sm571096b3a.62.2025.05.28.22.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:57 +0900
Subject: [PATCH v5 08/13] migration/colo: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-event-v5-8-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


