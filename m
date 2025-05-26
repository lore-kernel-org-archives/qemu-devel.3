Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF91C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPl-0007FH-QY; Mon, 26 May 2025 01:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPc-00076N-0z
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:30:13 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQPW-00021a-5G
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:30:07 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso1919940b3a.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237404; x=1748842204;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMU5RXGBbkZhXJ9lXd+1Fr6sB8OdX216UKmxJPnd6lo=;
 b=fQUMqTu8eb/nlY9+NQlyWEuAqvlltwWrjQDUf3rmxmrZ3MZZZs3YroGvxYTFPyQBqb
 183KFIyQCxtNYcfkaUadSZE8vv9PBzx80num2+lUptMYbLjBh8zst9MCAf36+X0NDat2
 JJkveB4zdCa0C5uPTrToBJXGAie8OePLMiN2mgO57+uMiav458K7Fi3I20TXR+cmDK/C
 He6s2Bj9hC2nbXftw85dFdHxYDLxp+SQEMXEAv0DMDtEsX8XCEezVWqZ+ZgaUwXRu2lS
 Z7FmfreUoszarSlEcLyl0WgCiVloVLN5FrIAVpbP4zUJKuEKGYMJCVrfngMdrJv/LIHh
 rDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237404; x=1748842204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMU5RXGBbkZhXJ9lXd+1Fr6sB8OdX216UKmxJPnd6lo=;
 b=F7Bzbg1Kcz18eyOYL/wXwY95e0z4OpEomCApGkS29G6RoCqNmEYcRU+O1GxWhdBZTI
 9cznNSmfmSUAOnOvLzVya51P9C8jEXjSFDFWXMsb701Q2stk+V/Mm3m3KpTi38n3GyUF
 i5hzNn2/wGKR1wEuXcOSUGyCSJmWgPRoKHz9rMGpmf7hTXxweKwHC5FK1pcb2GHi2BK3
 cDrtnFt3TF+Qbt9nPsplH18qvsYb25s31if15AAA6P/I4sOBP7dw3uGhPEd9bOLfzjws
 +Tog/IIeqUc2TKqlDq/Mi+nSfUMSzE+dinR0TJD1/B2jlmUKZGNu8LyFW0K7HgesTnTk
 MpgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4qXAPxpHuFLilsVSxvNWVe6keTpWRGBcimb9QpXiqOvKnpSxFys1oa5uQUyMyHv/uQ1YNLFs2SqOw@nongnu.org
X-Gm-Message-State: AOJu0YxZ6VAk4THPNFsR8ZXquW8RyZzt4WHkEZ7Hr9p6teMlsUW4zxyC
 c1o9f+NSHEaQX+TT3ds227fQKYarEUwi+pzJ2dZLmgEUj+UqIV+IkZ2gye7kGjHefSB/gOc3y+l
 zwX6G
X-Gm-Gg: ASbGncvPo1TKJUWdw7tuVaKq4Fp/2uNRdB2N5VwQGfokdZnBroVrLpQlocYtPqLyDMf
 21PTb9CRv+1Mz50+IWAotqB2NrAzWTUl4cyn5PlqpP0WacqPpFp4xIuxDYpKyB3jRgXVvXJUCHR
 Zg5OYT27GUOE2r/e/NSyBM7VA3G7GnWLrNoA/4l/LznYNVpSpkje2VuKyGfQX6i5gI7q1fVstzF
 TZKl4L2w0EQ8Wlt2fi6pRL/XEfp8r3d7ZW6KYyyb5Gm6Wn6ZJV0GVhFsvDIN+G1QSwo/kYKSHDM
 OgG41xrRr7FoKLd2GXlb3ucTzcWcUoC+M3sALQKwQV6KIwkGGeIWnLtNnkDoQt8=
X-Google-Smtp-Source: AGHT+IF/Wgl3eKMvYPj+QZ1PydCvAXCCXs4C5WqZ5o689BC6724+uth80ICzdwwcbZourzgjUcZ5Sw==
X-Received: by 2002:a05:6a00:3a1e:b0:736:43d6:f008 with SMTP id
 d2e1a72fcca58-745fdf77ab7mr12173469b3a.12.1748237402664; 
 Sun, 25 May 2025 22:30:02 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742a985faf3sm16295007b3a.125.2025.05.25.22.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:30:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:20 +0900
Subject: [PATCH v4 10/11] migration/postcopy: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-10-5b784cc8e1de@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

thread_sync_sem is an one-shot event so it can be converted into
QemuEvent, which is more lightweight.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.h    |  4 ++--
 migration/postcopy-ram.c | 10 +++++-----
 migration/savevm.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index aaec471c00f8..739289de9342 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -98,9 +98,9 @@ struct MigrationIncomingState {
     void (*transport_cleanup)(void *data);
     /*
      * Used to sync thread creations.  Note that we can't create threads in
-     * parallel with this sem.
+     * parallel with this event.
      */
-    QemuSemaphore  thread_sync_sem;
+    QemuEvent  thread_sync_event;
     /*
      * Free at the start of the main state load, set as the main thread finishes
      * loading state.
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 995614b38c9d..75fd310fb2b0 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -90,10 +90,10 @@ void postcopy_thread_create(MigrationIncomingState *mis,
                             QemuThread *thread, const char *name,
                             void *(*fn)(void *), int joinable)
 {
-    qemu_sem_init(&mis->thread_sync_sem, 0);
+    qemu_event_init(&mis->thread_sync_event, false);
     qemu_thread_create(thread, name, fn, mis, joinable);
-    qemu_sem_wait(&mis->thread_sync_sem);
-    qemu_sem_destroy(&mis->thread_sync_sem);
+    qemu_event_wait(&mis->thread_sync_event);
+    qemu_event_destroy(&mis->thread_sync_event);
 }
 
 /* Postcopy needs to detect accesses to pages that haven't yet been copied
@@ -964,7 +964,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
     mis->last_rb = NULL; /* last RAMBlock we sent part of */
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
 
     struct pollfd *pfd;
     size_t pfd_len = 2 + mis->postcopy_remote_fds->len;
@@ -1716,7 +1716,7 @@ void *postcopy_preempt_thread(void *opaque)
 
     rcu_register_thread();
 
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
 
     /*
      * The preempt channel is established in asynchronous way.  Wait
diff --git a/migration/savevm.c b/migration/savevm.c
index 006514c3e301..52105dd2f10b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2078,7 +2078,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
     rcu_register_thread();

-- 
2.49.0


