Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EFCE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaT6-0001qc-SR; Fri, 20 Dec 2024 05:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaSx-0001nM-Oq; Fri, 20 Dec 2024 05:42:45 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaSw-0005CO-5K; Fri, 20 Dec 2024 05:42:43 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso1146473a12.0; 
 Fri, 20 Dec 2024 02:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691360; x=1735296160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XupcwXC4o3WF/HULC2+F2cneFMCliOmRf8I9otsFFoY=;
 b=Ynu1bUmlM2Rtrzp7v9pUsjTpReyS6Dg9Jc8nHfU/2r+nz6rNKKTReJOcp+tXfVp+CO
 A2HnpyKuf1sTZOLXDd2QySH1PBoH/YEPW2MEmurZjYorcYHH0mSQbmROvDqVwaTRCGuc
 k/pYgBWW8T/XwB3gC0cq0P0lVPhRDQVrjNkJsxG/9RUNjpzPrsnWgBGPCC4XRyQb/Eat
 UE4hFs076h4Upl5gZGevRZlT+8tFOSK42AjoC8fUveyAmeyhJs8AyB9GlEeB7dveM9cU
 ZcQJsNy2kTdEhvqZB1Fi35OKAnRH8AuPPJmdebFViI1Nw0DMEYd84gl7pVNkWY5l0Yim
 YGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691360; x=1735296160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XupcwXC4o3WF/HULC2+F2cneFMCliOmRf8I9otsFFoY=;
 b=Z6B5ZLDxuFckeybKmCwNWgHjZdZuPAS5vMxcn/syXinuL66lci8GSIM92h7gTL0Gs9
 uuv4/te/Nix1mQHiM39+clSIsm9jyFA1uxqpKY8375Sg3ELELxRXlSt2wMyion9dgVHw
 8KqwHsgXErsxFIE7WFD1yPXA2a5ZJqLWNGaBAcu9U5fTvLsWD4i1z1H/ORVjJN++MTaW
 MTeyr0Hh3LMSnaA5B2baQsnduGHHqwDQojDU79ObYveh98JJv+9TT36SctuJoZOpd+w9
 6w4wWW4vIAMy2htXKOcyV3C3pmjyTWVnak9x+enRHWnevxIii/1wafl2VtcUwzU4PD/b
 tSnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU66/7USo7gPJmtnj5toDkWLOubmuXADI6M/5x9SVzNJX4OgcH3dsdPWsxffVBuBvicX20kFwDXACAy@nongnu.org
X-Gm-Message-State: AOJu0YyzapgNBekOJkMRP6wJEmZNBi7MpOxJfZJ70GgJb56La2T0rnuo
 5vTTWrap3RhUPzQJquuX682UZCy1khL7UqsBLFG2De1NWubsTutBHzd2RA==
X-Gm-Gg: ASbGnct1CdgAD475rEpIqDETZFDyBSIyF2DDQxoPkWrBWFAVwpdmwMGhOFHqo2CnrjK
 thLF5FG6oNQyXh/xTgisyWL6k1gOdEXSBDee4UmcxyiorFt8DJIxsGDAFspDjS7UKmEN8oeoHIB
 2w42UxDp6AskUhjXqxny7dBh4iQPeAlVFTgmxqR6ycWB9IC8CJlTBSdC/DCgPLLRhbAiECCUB3m
 3yyuVxUz+ShXtvAgUTyWSSspy4nSMrO+UQlO4/XXBP723SZzi4Sxm4PVIb0okuk/6wJ70TVnibN
 diebb3G0jQ==
X-Google-Smtp-Source: AGHT+IHJhPOBTvl9hvqnAZAZ22ZbgfEzsYzSOUpu2MkVulCan7laK8qWWrQZ8Uj1EucTtG726jT1rw==
X-Received: by 2002:a17:90b:524b:b0:2ee:c457:bf83 with SMTP id
 98e67ed59e1d1-2f452e38c6cmr3862965a91.19.1734691360038; 
 Fri, 20 Dec 2024 02:42:40 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:42:39 -0800 (PST)
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
Subject: [PATCH 01/17] replay: Fix migration use of clock for statistics
Date: Fri, 20 Dec 2024 20:42:03 +1000
Message-ID: <20241220104220.2007786-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
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

Migration reads CLOCK_HOST when not holding the replay_mutex, which
asserts when recording a trace. These are not guest visible so should
be CLOCK_REALTIME like other statistics in MigrationState, which do
not require the replay_mutex.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/migration.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c8..2eb9e50a263 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3433,7 +3433,7 @@ static void *migration_thread(void *opaque)
 {
     MigrationState *s = opaque;
     MigrationThread *thread = NULL;
-    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     MigThrError thr_error;
     bool urgent = false;
     Error *local_err = NULL;
@@ -3504,7 +3504,7 @@ static void *migration_thread(void *opaque)
         goto out;
     }
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
@@ -3584,7 +3584,7 @@ static void *bg_migration_thread(void *opaque)
 
     migration_rate_set(RATE_LIMIT_DISABLED);
 
-    setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     /*
      * We want to save vmstate for the moment when migration has been
      * initiated but also we want to save RAM content while VM is running.
@@ -3629,7 +3629,7 @@ static void *bg_migration_thread(void *opaque)
         goto fail_setup;
     }
 
-    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
+    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
 
     trace_migration_thread_setup_complete();
 
-- 
2.45.2


