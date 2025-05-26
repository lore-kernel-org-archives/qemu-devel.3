Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEBFC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPb-00074Z-R8; Mon, 26 May 2025 01:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPN-00073X-7f
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:57 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPL-0001zP-4X
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:56 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e033a3a07so13502275ad.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237393; x=1748842193;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dr5YmlBt9mn7VaBQhTTUFs3rHk8A9DyBMWMlV/sn2BA=;
 b=pMtVqXdA0YIx1RBVI04msUfZuZ3mxqQXsL0PgUnqx2v9iQOa3Ji6ysCPZy/PkAdGZ4
 XUHfZrHewynrO7yuYtM3NQ47coGhdbJIOwMYHaESJxrtcdYw+EY67guhvnhiyLjHwac5
 +94Zlk5m5dvKRv2tboFRDMdJtf0jCZUklPfU9HYR98PrPIGY3u1amHUaDXINp9d0FKZa
 UvK16cKi/nkSR2aXfpCAZ3PGailxxSvFta769lBDqW9Qoz3YQqM2gKxr1QwMV/VqCfHK
 qKWNU7EiNasOrt8blmEeS66vDgiRM+ex5L9nMI50KirS6P/UN+2HkF7OXZ9AOdkRLEKU
 dhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237393; x=1748842193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dr5YmlBt9mn7VaBQhTTUFs3rHk8A9DyBMWMlV/sn2BA=;
 b=Pb/m8lxRZXiD4aLsbDXLCKDsNx+LNt7mOcMZDo5fZGgZOoBqbYBW291rxrytucaM+b
 +093HS/8HgLeo432NW+yy+8AMxQo8xSzmYqQ+hQkq6Dxc5OKFQd1reFXv1NHk2gjOByU
 nW/bIS+e6Rv33H9G5w+UkSOP6ScKI/He8swHYhhf3VrWoLzX8nCTNBPRSgfFHTsdaBhF
 dmrl9XR5LljAuVo/gMDDnS6okC6v5EOZbrcQcWSYyaNfv6fveM3yqtJGkQOPIIQcGr+o
 LE1aD1zcNWCAOiKzGeof2IKgFIudS8grfMbANIskp1SwqapuTy0aC3Oi/WkjuYPtRHMC
 g+EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgMmRtk0KOfEuzkM0K8L4CVxUkgGTtMGMbl2Nl32NOPY/nZEHbwQm5TcwYbupWNvdX1gsZ08Kc+X3c@nongnu.org
X-Gm-Message-State: AOJu0YzCj+WIlpSgs/7xhx5HbMM9DI7nrwH+7zbn7xhFgmMbnirhDawS
 l/l/+qBt67Aoc1lmOCV5DztOMbOxH9pnD5or8S6ZNX7oRc56W3in8KYZwAquChx0GqVK5WoHuPG
 tWWpt
X-Gm-Gg: ASbGnct6SiRXO70+053hiVrnmPv+lVt2BDWppEzB2u7ToNnLSbVZUar9JBwoFIclrLE
 Mh50kp95hOnBHXkfDDhR5nPPU2L2AaygXvDENc8VRHIdF5jCzFOgF4INhyZIMrG5/kHnFu4L50y
 V9C1TPks/bhqb99kGxacg6TDTuS1trqhj9RqtTZb/xe0ImRjcCpri7IboCTwvVMD8mmG/Sbg20A
 H9lBgTIaJjWBO8kmPen+nddGvuRP03XBl1cJb4BkalUj8joJtVVf6Zz0PNPDTmhWn1AOOT4IUsW
 pF3AN9pdIZ8H2rEekuhQ/HiYdvw5MM0vkSL4OgZNM0a0lg0Bm9V8
X-Google-Smtp-Source: AGHT+IHSBQDnt8h48OlOv7oXZF0Rg9lIlYacOqnRWwrpGpslWc6dqH/g2sIhvMaY0+VV3wf7E9l7Fw==
X-Received: by 2002:a17:903:26c9:b0:231:d0c4:e806 with SMTP id
 d9443c01a7336-23414fd3bb5mr91711225ad.32.1748237393322; 
 Sun, 25 May 2025 22:29:53 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2344fbd44aesm14493965ad.249.2025.05.25.22.29.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:18 +0900
Subject: [PATCH v4 08/11] migration: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-8-5b784cc8e1de@daynix.com>
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

pause_event can utilize qemu_event_reset() to discard events.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/migration.h |  2 +-
 migration/migration.c | 21 +++++++++------------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index d53f7cad84d8..21aa6a3c8fee 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -379,7 +379,7 @@ struct MigrationState {
     QemuSemaphore wait_unplug_sem;
 
     /* Migration is paused due to pause-before-switchover */
-    QemuSemaphore pause_sem;
+    QemuEvent pause_event;
 
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef91..4098870bce33 100644
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
@@ -4057,7 +4054,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
     qemu_sem_destroy(&ms->rate_limit_sem);
-    qemu_sem_destroy(&ms->pause_sem);
+    qemu_event_destroy(&ms->pause_event);
     qemu_sem_destroy(&ms->postcopy_pause_sem);
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
@@ -4072,7 +4069,7 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
-    qemu_sem_init(&ms->pause_sem, 0);
+    qemu_event_init(&ms->pause_event, false);
     qemu_mutex_init(&ms->error_mutex);
 
     migrate_params_init(&ms->parameters);

-- 
2.49.0


