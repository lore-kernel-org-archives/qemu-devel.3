Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AAAC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwa-0006HP-AP; Sat, 10 May 2025 04:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwY-0006H2-K1
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:26 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwW-0005e4-MX
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:26 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-309fac646adso3871119a91.1
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867143; x=1747471943;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sHD+2pGYZBM1saUJBRZKECLnePiyCMT+xoiE17eX2xk=;
 b=A1f4kiDbHmbbsN2e1pS3Jt73KdsRm0iSllj65JNfI9hvZyY7TfIFySgZVWEXn5cl/R
 6sB1Mq1om3Sf6Qa0daYvUbId3NoPCPHum3XlY68bBnsA+P0eA08yQ4eryJL10Hq+NbRP
 tiLL2HstYq7v9BZyeMvdegXws1jcK5CTXTbEvlYJPCqvrDBPOcFygqwbU1IoiY7O84KN
 gr9ZZV8Hfmm70G/me11E+iDyx9HUGtZuICRDGddDsQXH6+aeHXpjZUqELEm0RjIMLB7a
 JeqinoIi6EUOqDlAqAsLudEnI4Vuqq6bmryT/hpfp+3cli6iaQmB8wDQCegsatdwiTqv
 hpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867143; x=1747471943;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHD+2pGYZBM1saUJBRZKECLnePiyCMT+xoiE17eX2xk=;
 b=CABoMMzqiBFz8r0J/j5Vm7A+yjU/o9a3kra3juNiaIT3USG36e6ykA1VEuNHrJhr0s
 agasRZhpJ0Ob0SEn4zX/9sLd0ucu05vujQwD0gEQG5OHHsvb2j1CUJ7SRUsc8DGB0Ktp
 PfA71Pbrr2ix6uRyc9jy4YXRSLbcjFEeB8f5Eg+snnkhgCpEsnquL5kSxxHQTef9lFam
 yesL161QwlJxuDF3KGuZvf4EULbkNeBm9EESoqHS5qRV4RHbjaeEVzT+qxW10VKmp5RG
 fa8Is2dtKkLaeW0KT0kzoq2zkqOIppTcpXQ2RilI4Y9t56YyBEkkcXr07obRXn8llOAt
 ZiKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3Eeon0rs97eXprAd/ET4Pf7ANVfbewq4cvhwB1yxKBses1QGvAcu8iwcgSuaedU2+iiAiXvir96NN@nongnu.org
X-Gm-Message-State: AOJu0YylvSrg2sSx0KEhcT/CPLAE4k2b3XXEz8bKWoeKnhlg6MqwsBr1
 HTZNtAql+q8Ebmwdiabi5zSgjYwkJBk2IyYvtJ1apGoxNgY8H3flkxzbojRAUXQmR1Dv9VKAZ68
 u
X-Gm-Gg: ASbGncv/vIdy2ss2Bv1RB7IhWpBoDHQ9WyB9yvI0ETumY9EvhzJcOr7MoBisRNFDyes
 qjsq0RvIFgeNs8l2q9+Mk5nMRO9JrlFgNqB6kj3rK8rj7rXS0cDkzSHfbwFOGKd1Bq/1QZbI/ZC
 8fzClBYGJ8kvNoa4bpAiLnfj9yEL4xaOyhMzZKnscCqLrjVM4ZLJAtS98jj5Hd8UgG32bShbcDv
 LWfo9hMviGHVPuGvCQuFvbt4cOUr6D4XZVy97LA4xH2WcoyE15Bijl93BHF1iGM5yzd7JMHp7Cn
 4tHRmjljpLShar8NeB/kO9yBQqWgM7q0Zr3I6rFx5/8JDgT75EMMq0k=
X-Google-Smtp-Source: AGHT+IEIu1rjkDn91ZllPRATT8rB2zg2T9P0tllb5cZy8RWK2jijthoUZyNqCq+GxZpXWsqHC2XUCQ==
X-Received: by 2002:a17:902:da83:b0:22e:4b74:5f68 with SMTP id
 d9443c01a7336-22e84790b02mr169304895ad.19.1746867143013; 
 Sat, 10 May 2025 01:52:23 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc7741e48sm29550275ad.87.2025.05.10.01.52.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:51 +0900
Subject: [PATCH v2 6/9] migration: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-6-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
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
 migration/migration.c | 29 +++++++++++++----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84d8..11dba5f4da77 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -342,11 +342,11 @@ struct MigrationState {
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
@@ -379,7 +379,7 @@ struct MigrationState {
     QemuSemaphore wait_unplug_sem;
 
     /* Migration is paused due to pause-before-switchover */
-    QemuSemaphore pause_sem;
+    QemuEvent pause_event;
 
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef91..053c23c58d82 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1630,7 +1630,7 @@ void migration_cancel(void)
         }
         /* If the migration is paused, kick it out of the pause */
         if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
-            qemu_sem_post(&s->pause_sem);
+            qemu_event_set(&s->pause_event);
         }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
@@ -2342,7 +2342,7 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
                    MigrationStatus_str(s->state));
         return;
     }
-    qemu_sem_post(&s->pause_sem);
+    qemu_event_set(&s->pause_event);
 }
 
 int migration_rp_wait(MigrationState *s)
@@ -2550,7 +2550,7 @@ static void *source_return_path_thread(void *opaque)
         case MIG_RP_MSG_PONG:
             tmp32 = ldl_be_p(buf);
             trace_source_return_path_thread_pong(tmp32);
-            qemu_sem_post(&ms->rp_state.rp_pong_acks);
+            qemu_event_set(&ms->rp_state.rp_pong_acks);
             break;
 
         case MIG_RP_MSG_REQ_PAGES:
@@ -2693,7 +2693,7 @@ static inline void
 migration_wait_main_channel(MigrationState *ms)
 {
     /* Wait until one PONG message received */
-    qemu_sem_wait(&ms->rp_state.rp_pong_acks);
+    qemu_event_wait(&ms->rp_state.rp_pong_acks);
 }
 
 /*
@@ -2911,21 +2911,18 @@ static bool migration_switchover_prepare(MigrationState *s)
         return true;
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
 
     /* Update [POSTCOPY_]ACTIVE to PRE_SWITCHOVER */
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_PRE_SWITCHOVER);
     bql_unlock();
 
-    qemu_sem_wait(&s->pause_sem);
+    qemu_event_wait(&s->pause_event);
 
     bql_lock();
     /*
@@ -4057,10 +4054,10 @@ static void migration_instance_finalize(Object *obj)
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
@@ -4072,14 +4069,14 @@ static void migration_instance_init(Object *obj)
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
2.49.0


