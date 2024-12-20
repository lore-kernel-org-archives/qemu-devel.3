Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C90E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaTW-00031Z-Iu; Fri, 20 Dec 2024 05:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTV-0002yJ-56; Fri, 20 Dec 2024 05:43:17 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTT-0005GK-J5; Fri, 20 Dec 2024 05:43:16 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166360285dso16684995ad.1; 
 Fri, 20 Dec 2024 02:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691393; x=1735296193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqqVPjhisoejpakdnzFLtY2uBOq7jpbxi6SFzwY7o/A=;
 b=RKrV9DC83Z+Iy/E+BcMtbaBdGlikH3kXd7bri9ZZiZe3ZBHMUexCveMBCgbg3JixcD
 qviP6OrG8rylXzejYqQeDNd76ZP1qfVmsamBzZkkoIzpMxbZ3/l4hzObQgN3lSdfs8zN
 Pw+5OIwWhzKPEChYcvl8qFiJxxTreBICU9E0DvlnhOnEkLyblU+FtUtEOVORGg8He0XT
 wnsvwZVGGf9ESbjs8xnfkMeIUExUWQ94fGSKB/Ojq6KpGtDw8jdqYKugwFyne0ms1uHD
 K8D7IV8v97MQn8lcXbOBIZgToy/EbVEMuNZIzgs16z/L7pcxiYZiib1QvbHcqlpaPfKw
 3b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691393; x=1735296193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqqVPjhisoejpakdnzFLtY2uBOq7jpbxi6SFzwY7o/A=;
 b=HB7mAtbVNqDVY/fEYUjWpoq8KrdJffh8f2EwM4lSxccxmr6OOYwBS7CsiI0ddlDjcV
 9YAVqUo37Rnvn/MHH1C9yh2tvNSrPxKkg9t6yqPnY91E+KQPp9X4N3GIqmkoZYVw+iSc
 HI8GNyxdfWRS4/5L8RBiEYC/awTYQvOHvV8ExUQvbRBwi0E9cssSdDShrLDbiSEfOngu
 7Xj+sKKDOrw2ABdIuswb26lFrUPKx/mGg6g02oE54qOXHy/V1YKoub7otF0pDTrsTHBA
 5lMLP1wc1t1sup+XgbnigMiwsUl5ERKlivT6bFJpsF7wm9cTArdrWIWTsMRDP+025kWt
 oDww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6gDdPW3TRdw1aJVjtyw8WmK74eD8uz2y97TzCLaWt+KzLivUKmvmwNP22NJFa4BA3CSW2khQM3oh9@nongnu.org
X-Gm-Message-State: AOJu0Yzlng8/Zs2xZwlb76/IkfFv8FcAJHA0WsU/m/4z3Loha36/Ds62
 AFVlivDELeMiAHRGlJ71ENmtVhkDMSyPIXD+HRwJ1bpOiZ10ifDWHiY0ig==
X-Gm-Gg: ASbGncvg9T/FICPazUFBVJnnpy2Ax3ckOQPPrwP82r9idqajmJdMvw5/hVDyKHgTcU8
 IIdLcBJbSQ8687d8cKjjHTbCrrS5y5Uu1uOVOkf4fwxHjelowBombkTBtFlypN8iptdCUcIbEAk
 Us8Sh0PrmPzvu0c0wBDlLqsxdUzpsmgdFs5EhUH1/CKMYw/tUl4gjtrS6NouVe6C8bC6cviw3TV
 T5MMglDY1s9LB/+i6PP7m0z4E6+NcV/BfVr/djypNvR1T6YeO8N37OhUDE8KFqjDnM8pw/JRna3
 hA0zsulSxw==
X-Google-Smtp-Source: AGHT+IHvuPhQtfGfPl/FhyQDI1QhJnqg8A5k80OSOsRQ16uzRV3BdG9q3NEZiOVj5aYsiS4WJs3rEg==
X-Received: by 2002:a17:90b:5184:b0:2ee:d824:b594 with SMTP id
 98e67ed59e1d1-2f452eeb56cmr3146804a91.31.1734691392777; 
 Fri, 20 Dec 2024 02:43:12 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:12 -0800 (PST)
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
Subject: [PATCH 05/17] util/thread-pool: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:07 +1000
Message-ID: <20241220104220.2007786-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Convert qemu_bh_schedule() to qemu_bh_schedule_event(), which can
specify the clock type, making it compatible with record-replay.

The thread pool management does not affect target machine state,
so it should use QEMU_CLOCK_REALTIME so it is not recorded and
replayed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 util/thread-pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index 27eb777e855..010eb4ad9a6 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -115,7 +115,7 @@ static void *worker_thread(void *opaque)
         smp_wmb();
         req->state = THREAD_DONE;
 
-        qemu_bh_schedule(pool->completion_bh);
+        qemu_bh_schedule_event(pool->completion_bh, QEMU_CLOCK_REALTIME);
         qemu_mutex_lock(&pool->lock);
     }
 
@@ -167,7 +167,7 @@ static void spawn_thread(ThreadPool *pool)
      * inherit the correct affinity instead of the vcpu affinity.
      */
     if (!pool->pending_threads) {
-        qemu_bh_schedule(pool->new_thread_bh);
+        qemu_bh_schedule_event(pool->new_thread_bh, QEMU_CLOCK_REALTIME);
     }
 }
 
@@ -195,7 +195,7 @@ restart:
             /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
              * wait for another request that completed at the same time.
              */
-            qemu_bh_schedule(pool->completion_bh);
+            qemu_bh_schedule_event(pool->completion_bh, QEMU_CLOCK_REALTIME);
 
             elem->common.cb(elem->common.opaque, elem->ret);
 
@@ -225,7 +225,7 @@ static void thread_pool_cancel(BlockAIOCB *acb)
     QEMU_LOCK_GUARD(&pool->lock);
     if (elem->state == THREAD_QUEUED) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
-        qemu_bh_schedule(pool->completion_bh);
+        qemu_bh_schedule_event(pool->completion_bh, QEMU_CLOCK_REALTIME);
 
         elem->state = THREAD_DONE;
         elem->ret = -ECANCELED;
-- 
2.45.2


