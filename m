Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A96E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaTv-00050S-9t; Fri, 20 Dec 2024 05:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTt-0004rR-Dl; Fri, 20 Dec 2024 05:43:41 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTr-0005JZ-DD; Fri, 20 Dec 2024 05:43:40 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21631789fcdso19257085ad.1; 
 Fri, 20 Dec 2024 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691416; x=1735296216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0IjIoEMmcVCUPTQhUBxK0EywoWT0wIO+ygbxxKxmGc=;
 b=hRR6U6IU0OWyro6znan63w+vdzBXCXf+KL1UjZH5eVBcgfXzki326vjdcXb0cSgiXz
 pqgttHzIlbm551FYT/pAJr3TN8NY+ZlkIpCrPi2izh3gX/Tiv+OU7bIQZcvH87eGVgoI
 MXIBvMs5Q1qo1m2OwpwMwOpv/odj9NTU+gdmi/d/RYXyRHKMKtxnBQzhb2OPXyXB+T3G
 PfnGyNzpEVS1kbXyiPBOQPtzvfFapUG6MuTtLCmaoH53msuWtznoNIwVwcTftHRT16CU
 t6fUgb008Vly9+nz3VjZ2cFpKVUtMfj+UWGVk0XWzq+Q7ySe+wYdW/ho4iCtTQdYtdWm
 ZMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691416; x=1735296216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0IjIoEMmcVCUPTQhUBxK0EywoWT0wIO+ygbxxKxmGc=;
 b=E+OsD/22ezu5sV57EZPqrlF0WKzym62Vv7hyVpFIl2mwtLYBJIzYK2/dVnAzKbCv7k
 cKRfGJGigUv4a9OcENAP9rqsuCAv0UhcwU2dRvKocFCwi8HZCbycepWOLPbOJIyBJJQ+
 QkKtOOlD9HjpG9F3KFk4VCqnIws2NrcCvb6mFgCgDX/QpLMzATYGgZZaw6XesPdxp4KB
 vTS1xr8Igq61wmtaqABf9CBaM/lhgYK0y+CtNNXIT9Y1j0JElsjzbszVXGgOZObLbj6D
 WMhfU3wN0a/ZlzfAr5ix4wNaHGUo6T9+QU4YZi0nLL1gbhr79kQSW2OD9iig8ar8o/Ad
 WL6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd+5mxN+FPOFQe9e352rrvKgZ+MD7VmV8Ht42+sYrDd5QQaotLhvciWq+ySc1yNP/r94F0EzC5gw+1@nongnu.org
X-Gm-Message-State: AOJu0Yyii3OGM46dAZN0QQMAAG/NxJvKL40SdH/Ix0LsCC7CYawETwcd
 cUEaLt59IfEDFnJNKnokEWhmQmhBpxLONlUucbXZrvu597rkVSD6cOzRBA==
X-Gm-Gg: ASbGnctWpsL+uT6jT3pyttHd9OCfEgeLsSHd4lX6kNNIkhNM2+Hlbus3vtXna0rcfU0
 7WD1wWikIhYKgg2RcARrq24e4BO+fmclxha6m+F2nC8Vy93OrDvepwfxDFgW4faDuy9l/W/w6R8
 aqzhL5YpDpBVAmsbBYMBa2pqDinrYyKkytlWq4dVUaj6phw8ktOFfL5CW5f8oMVkG5Hw1BTovgD
 eDt5QeVIcv3KC2Bp8xOT2nLZ777XjJA2BMJmyVrCSrSnt6jnwFlx+eoB7/CONAG95fmJh9oT+XY
 17db/nZVhQ==
X-Google-Smtp-Source: AGHT+IGZOnLDRB9f6nVuNkvmDrIyRKLfWegwsQxJ6Eg03DBqPaPtAt2ggEKMnmkHLsY0oLSOoOVptw==
X-Received: by 2002:a17:90b:524d:b0:2ee:9229:e4bd with SMTP id
 98e67ed59e1d1-2f4536030d8mr3458864a91.2.1734691415974; 
 Fri, 20 Dec 2024 02:43:35 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:35 -0800 (PST)
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
Subject: [PATCH 08/17] migration: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:10 +1000
Message-ID: <20241220104220.2007786-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Convert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),
which can specify the clock type, making it compatible with
record-replay.

Snapsohtting does not affect target machine state, so it should use
QEMU_CLOCK_REALTIME so it is not recorded and replayed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/savevm.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 98821c81207..8477f116c79 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3441,8 +3441,9 @@ static int coroutine_fn snapshot_save_job_run(Job *job, Error **errp)
     SnapshotJob *s = container_of(job, SnapshotJob, common);
     s->errp = errp;
     s->co = qemu_coroutine_self();
-    aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                            snapshot_save_job_bh, job);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                  snapshot_save_job_bh, job,
+                                  QEMU_CLOCK_REALTIME);
     qemu_coroutine_yield();
     return s->ret ? 0 : -1;
 }
@@ -3452,8 +3453,9 @@ static int coroutine_fn snapshot_load_job_run(Job *job, Error **errp)
     SnapshotJob *s = container_of(job, SnapshotJob, common);
     s->errp = errp;
     s->co = qemu_coroutine_self();
-    aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                            snapshot_load_job_bh, job);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                  snapshot_load_job_bh, job,
+                                  QEMU_CLOCK_REALTIME);
     qemu_coroutine_yield();
     return s->ret ? 0 : -1;
 }
@@ -3463,8 +3465,9 @@ static int coroutine_fn snapshot_delete_job_run(Job *job, Error **errp)
     SnapshotJob *s = container_of(job, SnapshotJob, common);
     s->errp = errp;
     s->co = qemu_coroutine_self();
-    aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                            snapshot_delete_job_bh, job);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                  snapshot_delete_job_bh, job,
+                                  QEMU_CLOCK_REALTIME);
     qemu_coroutine_yield();
     return s->ret ? 0 : -1;
 }
-- 
2.45.2


