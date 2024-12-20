Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F42AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUO-0006YP-Sj; Fri, 20 Dec 2024 05:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUG-0006LZ-4T; Fri, 20 Dec 2024 05:44:05 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUD-0005Ps-OO; Fri, 20 Dec 2024 05:44:03 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso1311894a12.0; 
 Fri, 20 Dec 2024 02:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691439; x=1735296239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov1yKiOsdPvfFrptmu7MR0EFv3xHuopr7cPf6vnnWy4=;
 b=XYPrpGPUyyYURBoU8tDhf/cCaVy4vDaEV50QJnhYCW3QuBt4zqpYkaYBlXE8ELsbX6
 2SlLWFFhpwOB/tc/eZ9ZPFFTIZB20d7mC0LeggmNqZR/ZTR+/l5mhiXf7L3U2RmK6ir7
 YRn3mjhTbnabjbBf9sg0SUwwHrsTJqlF171WHwBwANi/4S7/LHtQt+WHYEXQU2V8GqKw
 TMUnRyPcTYvK52EVaea9rp07OIFHmfbTXJSECzT2wn/hFoKFA7GnA14hrSPpBerVuSV1
 Wr3HE5simThAC5EadVw+/n8O0meAR3GBGnRDVOupRANeDlniPCOEJiBk3xnHgtyE9dyd
 Zsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691439; x=1735296239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov1yKiOsdPvfFrptmu7MR0EFv3xHuopr7cPf6vnnWy4=;
 b=R8Yv/Uw9VYMPH5/Ct8xW3lY+Mz9Omnc7QQfYP8FLteTS/41Mv4tCF7HmtjIyN6jSqh
 Cr9mYXWtjufqlgRb6duTgFbrdu4SNETgPKPT1qUNsxooOah68SgEm0eHAdoNs3I3+W5K
 9Tkl/r5BDwumKLqe/8KSTjBQHIrfHyQexbSoV4VxQr3uEwLcmgYDNcz+/MA8htAV3V/G
 0iFxRwoWpT1cNvD2pKpSzHW0sKzbLmTLbNpG7FZsQf8cEYEl7lH7HmZYTw9JLtF+ofWq
 uro2q2L1Q9dJTzQwvyz0U1G2sQ5At1gXqZxdO2blboG16Xv38CZYoo2Bw07cxJPCd0Re
 qNKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVli86TQNnkMOZfd6ZC53C2E8k0zcchQKBfTH0sP/XEI9p+I6LYhtGA1LQy9fFZxYrQfNyZjzkzqSl@nongnu.org
X-Gm-Message-State: AOJu0Yz4Y4kgjUWakMs/mROjUAyTRj2lI5fG/uh+rjrKLiCDn9E5gBQe
 N7YtRGkOJTmOVPHeHPQGNfP6zRGTILRcA5P/rOjfB+DPruSD/C9BcocHVw==
X-Gm-Gg: ASbGncvmPiqD5vUCbdsXVnV0IWsHK4gZeudsaQDA5cio+3UP+3A6U0tYmKibiS5j2dm
 4C3F3r1xz5pV/QsGMVWF38qkibwBleENbz98wRQtM87nzCa7FmnmuJHN9eSvKrAeUGa97DG31Bt
 DAewRHRcsLNJtMaMlWnd7W4dsim5OvynC//anfOYt+l3qfo9vjgTR2bGkze4EeLV0KvrdFelEaM
 Iwyn/nntPRf/90UOBwW1tUnREyREcvLvdz5X2N7aX4LfpoVmAS+0w93TbrJFvrXcd55CiAIs8Vf
 B0cyhJcl0Q==
X-Google-Smtp-Source: AGHT+IFvRyMq8CdIVQg0yGz2vSHPh1Q6JBHCFzvh0AcDChmEcYMn2r5HtpVkz+aKO0r/TzoPfaqpOw==
X-Received: by 2002:a17:90b:3cc6:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2f452eed7e1mr3872323a91.33.1734691439408; 
 Fri, 20 Dec 2024 02:43:59 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:58 -0800 (PST)
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
Subject: [PATCH 11/17] block: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:13 +1000
Message-ID: <20241220104220.2007786-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

unreferencing a bdrv does not affect target machine state, so it should
use QEMU_CLOCK_REALTIME so it is not recorded and replayed. blkreplay
has cases at startup where the device is used before the event code is
set up, so it needs special handling to avoid creating bh replay events.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/block/aio.h    |  9 +++++++++
 block.c                |  4 +++-
 block/blkreplay.c      | 10 +++++++++-
 replay/replay-events.c |  7 ++-----
 util/async.c           |  5 +++++
 5 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index bc323b0d936..26859bd0b93 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -405,6 +405,15 @@ int aio_bh_poll(AioContext *ctx);
  */
 void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type);
 
+/**
+ * qemu_bh_schedule_event_noreplay: Schedule a bottom half avoiding replay.
+ *
+ * This function is not to be used outside record-replay code.
+ *
+ * @bh: The bottom half to be scheduled.
+ */
+void qemu_bh_schedule_event_noreplay(QEMUBH *bh);
+
 /**
  * qemu_bh_schedule: Schedule a bottom half.
  *
diff --git a/block.c b/block.c
index 7d90007cae8..77e6c6b3c7e 100644
--- a/block.c
+++ b/block.c
@@ -7144,7 +7144,9 @@ void bdrv_schedule_unref(BlockDriverState *bs)
     if (!bs) {
         return;
     }
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), bdrv_schedule_unref_bh, bs);
+    aio_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                  bdrv_schedule_unref_bh, bs,
+                                  QEMU_CLOCK_REALTIME);
 }
 
 struct BdrvOpBlocker {
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 792d980aa9d..c6b9d91062e 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -67,7 +67,15 @@ static void block_request_create(uint64_t reqid, BlockDriverState *bs,
         .co = co,
         .bh = aio_bh_new(bdrv_get_aio_context(bs), blkreplay_bh_cb, req),
     };
-    replay_block_event(req->bh, reqid);
+    if (replay_events_enabled()) {
+        replay_block_event(req->bh, reqid);
+    } else {
+        /*
+         * block can be used before replay is initialized. Work around
+         * that here.
+         */
+        qemu_bh_schedule_event_noreplay(req->bh);
+    }
 }
 
 static int coroutine_fn GRAPH_RDLOCK
diff --git a/replay/replay-events.c b/replay/replay-events.c
index d4b095b2097..6a7c27cac1e 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -154,11 +154,8 @@ void replay_add_input_sync_event(void)
 
 void replay_block_event(QEMUBH *bh, uint64_t id)
 {
-    if (events_enabled) {
-        replay_add_event(REPLAY_ASYNC_EVENT_BLOCK, bh, NULL, id);
-    } else {
-        qemu_bh_schedule(bh);
-    }
+    g_assert(events_enabled);
+    replay_add_event(REPLAY_ASYNC_EVENT_BLOCK, bh, NULL, id);
 }
 
 static void replay_save_event(Event *event)
diff --git a/util/async.c b/util/async.c
index 6ac994effec..5d2c76dec08 100644
--- a/util/async.c
+++ b/util/async.c
@@ -261,6 +261,11 @@ void qemu_bh_schedule_event(QEMUBH *bh, QEMUClockType clock_type)
     }
 }
 
+void qemu_bh_schedule_event_noreplay(QEMUBH *bh)
+{
+    aio_bh_enqueue(bh, BH_SCHEDULED);
+}
+
 void qemu_bh_schedule_idle(QEMUBH *bh)
 {
     aio_bh_enqueue(bh, BH_SCHEDULED | BH_IDLE);
-- 
2.45.2


