Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55794CA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 03:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umlPf-0004ce-70; Thu, 14 Aug 2025 23:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPd-0004br-6L; Thu, 14 Aug 2025 23:47:29 -0400
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1umlPb-0002z0-Ez; Thu, 14 Aug 2025 23:47:28 -0400
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-70ba7aa136fso965616d6.1; 
 Thu, 14 Aug 2025 20:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755229646; x=1755834446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ia9C9yonrsv1CWsKxEfiaqEx+tiY2731HEt0MKh0uDo=;
 b=QgmkUxx8ZRrs4Eee20WJtPPIyxU+E7+JSsvEmzt5scxtdscQ+U//QnrnM1UZ3mKTp5
 aGCR40OQL/M2LZvPNaUeyAaLjvPj65a0brSEPoUhwILp1LA+JDujP3vI6tKidiKg2qPH
 i9ovDEJiEcV3yYho9s+wz3mODb7McDLNbKiidSd2wC3UrabsziAoVRfZ54iM3MHlrbiV
 OWiWHkCLZzFv/cTtGkeYcpxUiousscRv1zqYsV92VpMi9c1XeDWykXIHzNs0f9vCUzUQ
 Xes5IBKbW+37NHc9qZw4r75Wppy1gea+7OSvna4JnASsRpHLARkUGt/RPpslq9fddi8C
 HZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755229646; x=1755834446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia9C9yonrsv1CWsKxEfiaqEx+tiY2731HEt0MKh0uDo=;
 b=MikCU/dHXqUKG0NN341jjFN9c+9W35H8Dfd+yReCvfx+JluIGQMLmRtJODq2czyiiH
 WVq9D/5fbt31pBXjPEnLsPv85qo/hCV4BVJQfbbAY+UqDWHyES9fjuL1Daikf0bD5srO
 8mFBDY0Oh7760+DtF9ANdeEB+wFdJ5yY8WfiQbUSmEyYmezV19aYGvTLRVULQoYqdmmy
 6fu2tmNPd6OhtlvkgF8PV4C1cQFN6Vliq1a+0eDVBKyPiDdJsjnCaHQSph0eAZH2jfx1
 OrM4deTG5sABJC+HTL+8Tz2Zo8tsa/P7w140saijPN6mDwO33m7h1h02gXRrS4jzTWM9
 BbAA==
X-Gm-Message-State: AOJu0YwXY2tSv2o1WpgnMyIFuimMz05GvEigFatRtprn4xzs2/SvlXfq
 l1vdLN58PwQQj55vNrBiN8tfv7tqhU76LTIhiCd3bZ8kI7BW5bi+k49PaOx0Hw==
X-Gm-Gg: ASbGncvhzTSlyyt4PKTLXkIM7szaXI6VZK0MJZdsjeIwvhJhR7kROyOTHZp0zb1nIm0
 bU5utn3oi3ms0Gt3x97Qz6yc7hOi0OY2JDFb64iEoZRVufmIrwJhBb+gSaaxwIGG9DGB8yfY2uU
 gGvgaX8yG8Pf7DXkyyXdBCkU3Vyo4YSzMXIyknP4JqT1c8jalDvGJyN8bML1pGxozdTGsOZ2hjP
 LQU2urxd7GrsSjC0EQrsAwksOr/GUr769PWYv466/aSotc4n2nHDtufuzxWyBUYTADQH16VvsGB
 csFeI0FOKi+uqI6IATRjs5UM1br9qgIs/uYM1nfuN93J8c9qeC2RrvFKckPX9C3Lf4/GxUMw7VC
 ujKsIJi0vAI9NRZJKXsYaOIhADtHUUQ+zJ/AGRNaVmjGqvAvtpc8YNDcZPX3QewAaHa8Rcy/jUM
 UdXLHSDGLMoJ3t
X-Google-Smtp-Source: AGHT+IF2dpYCbzCzdJ8Ro3pzur9GdWHwrlDrzKRtzbXOpNuowpPvd787NAUeQrSXRu7GVyikbXZUPg==
X-Received: by 2002:a05:6214:ca3:b0:70b:a2b7:21cb with SMTP id
 6a1803df08f44-70ba7a5e86amr4359916d6.9.1755229645544; 
 Thu, 14 Aug 2025 20:47:25 -0700 (PDT)
Received: from zzzhi.uwaterloo.ca
 (wn-campus-nat-129-97-124-101.dynamic.uwaterloo.ca. [129.97.124.101])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba906706esm1402346d6.17.2025.08.14.20.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 20:47:25 -0700 (PDT)
From: Zhi Song <hibriansong@gmail.com>
X-Google-Original-From: Zhi Song <hizhisong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 3/3] fuse: Safe termination for FUSE-uring
Date: Thu, 14 Aug 2025 23:46:19 -0400
Message-ID: <20250815034619.51980-4-hizhisong@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815034619.51980-1-hizhisong@gmail.com>
References: <20250815034619.51980-1-hizhisong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=hibriansong@gmail.com; helo=mail-qv1-xf32.google.com
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

From: Brian Song <hibriansong@gmail.com>

When the user sends a termination signal, storage-export-daemon stops
the export, exits the main loop (main_loop_wait), and begins cleaning
up associated resources. At this point, some SQEs submitted via FUSE_IO
_URING_CMD_COMMIT_AND_FETCH may still be pending in the kernel, waiting
for incoming FUSE requests, which can trigger CQE handlers in user
space.

Currently, there is no way to manually cancel these pending CQEs in the
kernel. As a result, after export termination, the related data
structures might be deleted before the pending CQEs return, causing the
CQE handler to be invoked after it has been freed, which may lead to a
segfault.

As a workaround, when submitting an SQE to the kernel, we increment the
block reference (blk_exp_ref) to prevent the CQE handler from being
deleted during export termination. Once the CQE is received, we
decrement the reference (blk_exp_unref).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 block/export/fuse.c | 52 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 7540f8f5a3..ddd83c50e2 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -298,6 +298,8 @@ static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
     /* Going to process requests */
     fuse_inc_in_flight(exp);

+    /* A ring entry returned */
+    blk_exp_unref(&exp->common);

     fuse_uring_co_process_request(ent);

@@ -323,6 +325,9 @@ static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
             err != -ENOTCONN) {
             fuse_export_halt(exp);
         }
+
+        /* A ring entry returned */
+        blk_exp_unref(&exp->common);
     } else {
         co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqes, ent);
         qemu_coroutine_enter(co);
@@ -370,6 +375,8 @@ static void fuse_uring_submit_register(void *opaque)
     FuseQueue *q = opaque;
     FuseExport *exp = q->exp;

+    /* Commit and fetch a ring entry */
+    blk_exp_ref(&exp->common);

     aio_add_sqe(fuse_uring_prep_sqe_register, q, &(q->ent.fuse_cqe_handler));
 }
@@ -762,6 +769,17 @@ static void read_from_fuse_fd(void *opaque)
     qemu_coroutine_enter(co);
 }

+#ifdef CONFIG_LINUX_IO_URING
+static void fuse_export_delete_uring(FuseExport *exp)
+{
+    exp->is_uring = false;
+
+    for (size_t qid = 0; qid < exp->num_queues; qid++) {
+        g_free(exp->queues[qid].ent.op_payload);
+    }
+}
+#endif
+
 static void fuse_export_shutdown(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
@@ -777,11 +795,6 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
          */
         g_hash_table_remove(exports, exp->mountpoint);
     }
-}
-
-static void fuse_export_delete(BlockExport *blk_exp)
-{
-    FuseExport *exp = container_of(blk_exp, FuseExport, common);

     for (int i = 0; i < exp->num_queues; i++) {
         FuseQueue *q = &exp->queues[i];
@@ -790,11 +803,7 @@ static void fuse_export_delete(BlockExport *blk_exp)
         if (i > 0 && q->fuse_fd >= 0) {
             close(q->fuse_fd);
         }
-        if (q->spillover_buf) {
-            qemu_vfree(q->spillover_buf);
-        }
     }
-    g_free(exp->queues);

     if (exp->fuse_session) {
         if (exp->mounted) {
@@ -803,8 +812,29 @@ static void fuse_export_delete(BlockExport *blk_exp)

         fuse_session_destroy(exp->fuse_session);
     }
+}
+
+static void fuse_export_delete(BlockExport *blk_exp)
+{
+    FuseExport *exp = container_of(blk_exp, FuseExport, common);
+
+    for (int i = 0; i < exp->num_queues; i++) {
+        FuseQueue *q = &exp->queues[i];
+
+        if (q->spillover_buf) {
+            qemu_vfree(q->spillover_buf);
+        }
+    }

     g_free(exp->mountpoint);
+
+#ifdef CONFIG_LINUX_IO_URING
+    if (exp->is_uring) {
+        fuse_export_delete_uring(exp);
+    }
+#endif
+
+    g_free(exp->queues);
 }

 /**
@@ -1755,8 +1785,8 @@ fuse_uring_send_response(FuseRingEnt *ent, uint32_t req_id, ssize_t ret,
     /* out_header->len = ret > 0 ? ret : 0; */
     ent_in_out->payload_sz = ret > 0 ? ret : 0;

-
-    qemu_vfree(spillover_buf);
+    /* Commit and fetch a ring entry */
+    blk_exp_ref(&exp->common);
     aio_add_sqe(fuse_uring_prep_sqe_commit, ent,
                     &ent->fuse_cqe_handler);
 }
--
2.45.2


