Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A26E7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaTl-0004A9-Tr; Fri, 20 Dec 2024 05:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTk-0003xQ-1M; Fri, 20 Dec 2024 05:43:32 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTi-0005Ii-G7; Fri, 20 Dec 2024 05:43:31 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so1258535a91.3; 
 Fri, 20 Dec 2024 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691408; x=1735296208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBfCSDwU8LQFcTcaCgA2fhYXCIcXyYzKBDWtkVyojeU=;
 b=UMjBvM5hrgaMu+hIgdIxaka0q+cLJrV/RVky8EF5veGyIfV4xeyixVhibYUY+TENPs
 nitOjK9Lbu2gJvWZsKGSmIQxgnMnLtfvrMrO9bAw3UYG1iV79KlgVheTmGVIPLUJLdyn
 s6SVDecocF0sHW9LDcS1X1ETglJPtGHn/xspihx4NlGg1ZsmZTA3TiAbm3gDkAudMJLf
 0RhGyQy/CGgdhNNF23CEdpoIqIXu1b4uDtIOMwwCUvNixiz4cWytQb1zW0O6CghPU5Qm
 jYwGIbHJUb68yh3ZMQPdtzlJ36IzIIuUcwxOcF9jIdMCDIoKwuBcqgK84hp3Y6JMVpTN
 Ycwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691408; x=1735296208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBfCSDwU8LQFcTcaCgA2fhYXCIcXyYzKBDWtkVyojeU=;
 b=Ny7LQbjLr/Ith9sL4tdyW6ZbZBNHtLNBytuemEG1tvoRJ/L5qi/4AMZYziYDRBhKyG
 Hri0gtW3Bg5WS1ZdVfsUlYb3BTLixXsei7Y7yOqIjTN4O/2MVApvoGfSn5XeycTwGRvc
 KoUFnGbnruQ0P9fnnh+OjiUT8n3spZuZEMm6BCAzuNtZoqBHdywBm4izW84OmgSnveV5
 1irZtCMIltzCDhc5xGSoFZpshbRH8HzjnmR29um4UgS5xdkdxJwIEWHhqRR/A0eegqiB
 yd6zEA1sgyoWPtpP531oiD4uVFOS+Z9FOcmOFGvdEE31Q+Jyl0rk8y+F2YIlGBmHGoOt
 tpnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyPbQSDlFK2a5DPrTgIlOnKhDwS5hRuVu3aVe7H7rnii096Q1P3s1FjajrLSI+PgRxAAQQbdrm2gs+@nongnu.org
X-Gm-Message-State: AOJu0Yw5j7Klhu99sqcgytxr+PTyUhQBMgHLCIJFr6KXzbYbDVt7S8U4
 drgUUrU+e1D8OHD6GnFM1FhGlJdaZZlPG/RrzWr3klGnnueqddam50bG8Q==
X-Gm-Gg: ASbGncs/Xll0IFrk3UUiVPBUspo+V1O5RXu+utjfFLaIdfby0YS4pXwULZTWjXtTWKX
 WEOgMEINldXhSXGYNZJ79FS88DEngMBtA3LmBl2eDiMF+tSV645Kn9avzXdn2p9lGYGHdOEzuHM
 ZUrshGbvDNkYr5cw9z/tLyGxG2blfxVPdHDEChQn0qHzsbO0wxb3AuzjQoTEle9IHih7M4h5nIX
 YXoLd9vYNBf0zsHrlM8UxUgfhttcVRhwNyXlaYS2By+v8gKWDACKP2z23H7OOBdCeODo2BxG6Zp
 BM/pCWxApw==
X-Google-Smtp-Source: AGHT+IElEt/zuUs5W64t2CXQPKauNpjjfBqCIxRvI+xKK5wXhQOGNM88/BRn+nIaRajHENsjTcXH6Q==
X-Received: by 2002:a17:90b:538e:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2f452eed77emr3868617a91.33.1734691408238; 
 Fri, 20 Dec 2024 02:43:28 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:27 -0800 (PST)
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
Subject: [PATCH 07/17] async/coroutine: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:09 +1000
Message-ID: <20241220104220.2007786-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

Convert qemu_bh_schedule() to qemu_bh_schedule_event() and
aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(), which can
specify the clock type, making it compatible with record-replay.

Coroutine scheduling does not affect target machine state, so it should
use QEMU_CLOCK_REALTIME so it is not recorded and replayed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 job.c                              | 3 ++-
 util/async.c                       | 2 +-
 scripts/block-coroutine-wrapper.py | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/job.c b/job.c
index 660ce22c56b..45e9d9fc096 100644
--- a/job.c
+++ b/job.c
@@ -1109,7 +1109,8 @@ static void coroutine_fn job_co_entry(void *opaque)
         job->deferred_to_main_loop = true;
         job->busy = true;
     }
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), job_exit, job);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(), job_exit, job,
+                                  QEMU_CLOCK_REALTIME);
 }
 
 void job_start(Job *job)
diff --git a/util/async.c b/util/async.c
index b88083ecbe7..6ac994effec 100644
--- a/util/async.c
+++ b/util/async.c
@@ -683,7 +683,7 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co)
 
     QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
                               co, co_scheduled_next);
-    qemu_bh_schedule(ctx->co_schedule_bh);
+    qemu_bh_schedule_event(ctx->co_schedule_bh, QEMU_CLOCK_REALTIME);
 
     aio_context_unref(ctx);
 }
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index dbbde99e39e..c111c322487 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -292,7 +292,8 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
     }};
     assert(qemu_in_coroutine());
 
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), {name}_bh, &s);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(), {name}_bh, &s,
+                                  QEMU_CLOCK_REALTIME);
     qemu_coroutine_yield();
 
     {func.ret}
-- 
2.45.2


