Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602FCCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeO-00085D-TA; Tue, 28 Oct 2025 12:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeB-00082T-G0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme6-0003Xf-8Z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xWepIFUxkv0l/eNVnDUu6hPjEIOeUyCJAp9pfFkwuz4=;
 b=C+3j76I0UVoakuNqfSu6cRFOSEttgRtTNFzMP+jwouuN5wmqOnkyjfKxfuzj/1/W8qJnyq
 MXAmHszr8JzGt+uTPHCFFVXRewXJfFcr0epfJbMQqmymGJi6s6FPV6CpbkCQfwemRKUznO
 yoIKwwRQRmMF28tuUB6ljHFp+5Vw7zA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-dUQLGb1hM0OrlGsWxuL0ug-1; Tue, 28 Oct 2025 12:34:02 -0400
X-MC-Unique: dUQLGb1hM0OrlGsWxuL0ug-1
X-Mimecast-MFC-AGG-ID: dUQLGb1hM0OrlGsWxuL0ug_1761669241
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-426ce339084so5873964f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669241; x=1762274041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xWepIFUxkv0l/eNVnDUu6hPjEIOeUyCJAp9pfFkwuz4=;
 b=k/UjRNPEXrvriYddjsSiwVBq245BsdmNZwhSMQjltYdSldQ7zJN5rF03c1KilCZ+q1
 C1JEwbQJvjDeZyN1zgT2NhdzhYwPTWqr/wQSVQc1QfH56oHhaYsp/Kkexgibd2ZVoOVR
 vthuDBIWwul1uj6sxT0jyZo2id/qvZYm2Y3e9iLdAS/O4z/hMpL1gvyrisyfhMCzxmPl
 +v+Y8LN0X1jpHxPabFl+nVGjjhnqg5knweh6Tc3Svd+tY+TlttWG30Anzu3nvmN3vGsa
 ucJoQ+lR0eXQtA3TeK9xulpFZbf5TqNVlNpim+w9m+xnuwv4NNVvw3QbJM7YvIPt2zHl
 ztmw==
X-Gm-Message-State: AOJu0Yx7tduX1M61X17qzT/yKQAFhQlmCgojH4MouLDxKrejxwBxsx8b
 jfDLmX4LcnCodVcbmGTAajyjIgm8jboxTnrG5ss3VQbqPEPpBnUKV9GJGC6I7bYjNI5m5EuCa9o
 DHC2afztkIdcGOeCD8Mz42f0YMu1lrB70xWWAUsfq9FqAVFA1HpxdKO4Q
X-Gm-Gg: ASbGncvkS3LODO4rD9gRq9hdzq12mNTWv3p2IeaBPQq2xn/b6I72ZspoeN4ddQNgdt0
 kbpXgj5JdulYDTg/NAoH83Z2GwvzwvupBvakeUTh1JIva3O0AiVDdhb7Op6nAIQAEw+XdYuKYgT
 ghvjXtnwyr5YqFmEFLMSK+lhPTXONRuCqVPF7oQF+3B2CvxQ3Ono18hXuP3hzGduBxzi32332qA
 Hc+e+KEhQj9ByCyVTRuDuFYJj2oxB5zVecZIBroX8TN5T4vmtLDapxkF+CVZHC+zE3ir7TIm1sH
 utYjNfHZ9aT5nrHTKQY5GGcUY1eBwWsoYkQrREaJ5KEjA0vncViQnrPFoi4SxJBiToSHFHiY3Qf
 GK3QWLi3u3VtYJDlgDVskycV6OhuMVK3AiDQanntzdGQqO2W4PD40Yc6XhA==
X-Received: by 2002:a05:6000:2303:b0:427:8fe:435f with SMTP id
 ffacd0b85a97d-429a7e96d76mr3624229f8f.57.1761669241074; 
 Tue, 28 Oct 2025 09:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2P6ULcQLL83cnpmkwsziXSisvEEEBUyPGQtbIVoYiNiFnfWmA4b2yaG334qLpXdEDURwrsA==
X-Received: by 2002:a05:6000:2303:b0:427:8fe:435f with SMTP id
 ffacd0b85a97d-429a7e96d76mr3624192f8f.57.1761669240665; 
 Tue, 28 Oct 2025 09:34:00 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718489d96sm25054745e9.0.2025.10.28.09.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:33:59 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 04/16] =?UTF-8?q?nfs:=20Run=20co=20BH=20CB=20in=20the=20co?=
 =?UTF-8?q?routine=E2=80=99s=20AioContext?=
Date: Tue, 28 Oct 2025 17:33:30 +0100
Message-ID: <20251028163343.116249-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Like in “rbd: Run co BH CB in the coroutine’s AioContext”, drop the
completion flag, yield exactly once, and run the BH in the coroutine’s
AioContext.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (!task.complete)` loops.)

Like in “iscsi: Run co BH CB in the coroutine’s AioContext”, this makes
nfs_co_generic_bh_cb() trivial, and we could just run aio_co_wake()
directly from nfs_co_generic_cb().  Like in iscsi, we don’t do that, so
as to keep the replay_bh_schedule_oneshot_event(), but we should at
least run the BH in the coroutine’s context to remove further BH
indirection.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nfs.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 0a7d38db09..4667d49416 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -69,7 +69,6 @@ typedef struct NFSClient {
 typedef struct NFSRPC {
     BlockDriverState *bs;
     int ret;
-    int complete;
     QEMUIOVector *iov;
     struct stat *st;
     Coroutine *co;
@@ -233,8 +232,6 @@ static void coroutine_fn nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
 static void nfs_co_generic_bh_cb(void *opaque)
 {
     NFSRPC *task = opaque;
-
-    task->complete = 1;
     aio_co_wake(task->co);
 }
 
@@ -256,7 +253,7 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
+    replay_bh_schedule_oneshot_event(qemu_coroutine_get_aio_context(task->co),
                                      nfs_co_generic_bh_cb, task);
 }
 
@@ -278,9 +275,7 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     if (task.ret < 0) {
         return task.ret;
@@ -328,9 +323,7 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     if (my_buffer) {
         g_free(buf);
@@ -358,9 +351,7 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     return task.ret;
 }
@@ -723,7 +714,7 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
+    replay_bh_schedule_oneshot_event(qemu_coroutine_get_aio_context(task->co),
                                      nfs_co_generic_bh_cb, task);
 }
 
@@ -748,9 +739,7 @@ static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
-- 
2.51.0


