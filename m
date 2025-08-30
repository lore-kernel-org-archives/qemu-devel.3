Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B6DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNqS-0001Ll-FM; Sat, 30 Aug 2025 11:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg5-0003bQ-DG; Fri, 29 Aug 2025 22:50:53 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1usBg3-00087l-6Y; Fri, 29 Aug 2025 22:50:53 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7f6d8fcd106so376235185a.2; 
 Fri, 29 Aug 2025 19:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756522250; x=1757127050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0/rMuj5BJq38ST18amwRehThVkEDs8BGEyd5stjYDo=;
 b=GQyHS0CKJGLxTbZz3wBB7eZEcHdicVnkDm0BNhjEcQCZlQB4MycWbhe6a6FPRq0YZg
 xCFtIdy89y0zy9KAyA/+3JcTQ/y4UcMUlKQdT7ZcHWCZOffS3vdNRsWdrbL3bFRpTz6A
 yXtJ8YGTHLDlySLq2+ti3euV2mKS287+j0IYQJ8wLfzTFXlW8yIDjKHMaXB+BLBr7kzn
 Luu0/juJPw96jm7bHEm0CSB1xhqMhS4s4Y5IaaDY6nbNUbv4BQgcc0uSHFe1r7RDEwr5
 IKbWJNJlcLMo2SyDQDLiLDvs3q8smKE+u6IawNkHLByug+tLK0nCSy7D849aoUIa0RLt
 nosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756522250; x=1757127050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0/rMuj5BJq38ST18amwRehThVkEDs8BGEyd5stjYDo=;
 b=ob7tfXKGsgtjN1hsF1zL2XsMTX7eAfvVjrRTrJa6g7FNXefl24W70ptiPdlz0R8iZB
 hH2Y3op5/Pe4yGrVA7PJC7TNxlvvbI8xA9W1S3T19WQf/g3nMLQMZXES/jwjCo+KSjtP
 +uoU78TRH7ES1tq8SLMWynmoL+nWmQcAhiA0r6NfyCI3VjJPuGUTzkOhfKWmURQk+XIw
 Dps2hNC5Euvbn05vMj5/4rjxV83vjONbidBBjLbrqaFRdRfrGwCTxz3EYOmfi/K4rfKt
 B+tMco3aA4vJ65cQi9l0Kd7vJoZp+6fCoE0umCmCbY7VSXgJ+sqvw/JLW/tyIEFaap7r
 QIXw==
X-Gm-Message-State: AOJu0YwSdB6Zj2ovPrIDLHezKTzvuKXmlDy7f8Iiy4/XW2YLoCF3ksFa
 8CpkSbRnZXmG8WsA6oJ5ooZS+hAhdZiEuya8y0SkxUtu0rOg8Rq/8hcfmYbfKQ==
X-Gm-Gg: ASbGnctaoztnbm+XHPUjrgyjshORmxa9E0M8SJy03LafA1azG1B0NMbtMtfpUrfE3KE
 QxprbiZ3+PIxHP4nW2xdVq5yCl9dTW56GbepR5z7hrFJeTVdy66qe7kUJTYdi4KAEhMGGI6JP0R
 ysnw2W69AUemvBUlYE3+djbsXailL45+OgrFhUe8H0elR/uZXWlY/Dutzl2DZulBPOSkEVIia+o
 jYvy2pMqe9rVMRjkegEJ3pcsZqqgLvOYa5GTSQHEiMxYo8AyqULEp7t4ubQwX2pEXxIZDVF/9eM
 VejVMUkoC0loX4E97RM5lp1u8Igq0FP0/qvaqITUsEORy7ILKMerYzcJFHSb1FH+5UkYQ8aKiCo
 hDHp2OkC90gKexagjC2/+LBOY4yAThaudIWBAp8D/xBlcJA/06Fu1OTJcT+IgTeznPrHmT2hSGK
 PEHs27R5SZvO+cAsilYv3KMgE4mf0=
X-Google-Smtp-Source: AGHT+IH18oXSzBFKJ4Xk5tXPZGMM9o2LuvSrmp5tf/Cp7Okqf1nNmkA+1nQBGVyxlav+H4uferfSXg==
X-Received: by 2002:a05:620a:4403:b0:7ea:458:e6e2 with SMTP id
 af79cd13be357-7ff2cbd87f0mr76635585a.77.1756522249642; 
 Fri, 29 Aug 2025 19:50:49 -0700 (PDT)
Received: from localhost.localdomain
 (wn-campus-nat-129-97-124-90.dynamic.uwaterloo.ca. [129.97.124.90])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0eacf1b4sm299457085a.21.2025.08.29.19.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 19:50:49 -0700 (PDT)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hibriansong@gmail.com, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 3/4] export/fuse: Safe termination for FUSE-uring
Date: Fri, 29 Aug 2025 22:50:24 -0400
Message-ID: <20250830025025.3610-4-hibriansong@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250830025025.3610-1-hibriansong@gmail.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=hibriansong@gmail.com; helo=mail-qk1-x736.google.com
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
 block/export/fuse.c | 75 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 07f74fc8ec..ab2eb895ad 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -39,6 +39,7 @@
 
 #include "standard-headers/linux/fuse.h"
 #include <sys/ioctl.h>
+#include <sys/sysinfo.h>
 
 #if defined(CONFIG_FALLOCATE_ZERO_RANGE)
 #include <linux/falloc.h>
@@ -321,6 +322,8 @@ static void coroutine_fn co_fuse_uring_queue_handle_cqes(void *opaque)
     fuse_inc_in_flight(exp);
 
     /* A ring entry returned */
+    blk_exp_unref(&exp->common);
+
     fuse_uring_co_process_request(ent);
 
     /* Finished processing requests */
@@ -345,6 +348,9 @@ static void fuse_uring_cqe_handler(CqeHandler *cqe_handler)
             err != -ENOTCONN) {
             fuse_export_halt(exp);
         }
+
+        /* A ring entry returned */
+        blk_exp_unref(&exp->common);
     } else {
         co = qemu_coroutine_create(co_fuse_uring_queue_handle_cqes, ent);
         qemu_coroutine_enter(co);
@@ -392,6 +398,8 @@ static void fuse_uring_submit_register(void *opaque)
     FuseRingEnt *ent = opaque;
     FuseExport *exp = ent->rq->q->exp;
 
+    /* Commit and fetch a ring entry */
+    blk_exp_ref(&exp->common);
 
     aio_add_sqe(fuse_uring_prep_sqe_register, ent, &(ent->fuse_cqe_handler));
 }
@@ -886,6 +894,38 @@ static void read_from_fuse_fd(void *opaque)
     qemu_coroutine_enter(co);
 }
 
+#ifdef CONFIG_LINUX_IO_URING
+static void fuse_ring_queue_manager_destroy(FuseRingQueueManager *manager)
+{
+    if (!manager) {
+        return;
+    }
+
+    for (int i = 0; i < manager->num_ring_queues; i++) {
+        FuseRingQueue *rq = &manager->ring_queues[i];
+
+        for (int j = 0; j < FUSE_DEFAULT_RING_QUEUE_DEPTH; j++) {
+            g_free(rq->ent[j].op_payload);
+        }
+        g_free(rq->ent);
+    }
+
+    g_free(manager->ring_queues);
+    g_free(manager);
+}
+
+static void fuse_export_delete_uring(FuseExport *exp)
+{
+    exp->is_uring = false;
+
+    /* Clean up ring queue manager */
+    if (exp->ring_queue_manager) {
+        fuse_ring_queue_manager_destroy(exp->ring_queue_manager);
+        exp->ring_queue_manager = NULL;
+    }
+}
+#endif
+
 static void fuse_export_shutdown(BlockExport *blk_exp)
 {
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
@@ -901,24 +941,15 @@ static void fuse_export_shutdown(BlockExport *blk_exp)
          */
         g_hash_table_remove(exports, exp->mountpoint);
     }
-}
-
-static void fuse_export_delete(BlockExport *blk_exp)
-{
-    FuseExport *exp = container_of(blk_exp, FuseExport, common);
 
-    for (int i = 0; i < exp->num_queues; i++) {
+    for (size_t i = 0; i < exp->num_queues; i++) {
         FuseQueue *q = &exp->queues[i];
 
         /* Queue 0's FD belongs to the FUSE session */
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
@@ -927,8 +958,29 @@ static void fuse_export_delete(BlockExport *blk_exp)
 
         fuse_session_destroy(exp->fuse_session);
     }
+}
+
+static void fuse_export_delete(BlockExport *blk_exp)
+{
+    FuseExport *exp = container_of(blk_exp, FuseExport, common);
+
+    for (size_t i = 0; i < exp->num_queues; i++) {
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
@@ -1917,6 +1969,9 @@ fuse_uring_send_response(FuseRingEnt *ent, uint32_t req_id, ssize_t ret,
     out_header->unique = req_id;
     /* out_header->len = ret > 0 ? ret : 0; */
     ent_in_out->payload_sz = ret > 0 ? ret : 0;
+
+    /* Commit and fetch a ring entry */
+    blk_exp_ref(&exp->common);
     aio_add_sqe(fuse_uring_prep_sqe_commit, ent,
                     &ent->fuse_cqe_handler);
 }
-- 
2.45.2


