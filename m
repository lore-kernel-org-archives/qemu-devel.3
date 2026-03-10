Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43201FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvS-0003Wa-Lv; Tue, 10 Mar 2026 12:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvC-0003Nk-Fw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvB-0000vX-4M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhdlKPgh17Z3o9lLJY65BTZtmBO2Ej1Xu+1oTHM+Z/4=;
 b=gPZcYYB/BYN0BqBjbqYJF2r0ovaMq4sVRsILmpp+Tg6isG1ICtcL0SA54WMppkyuQz6t1u
 BwSZYYkb4L5/L8a3Llr3IenBfsLPpLOIPwUVOcSMNaXxrCp4wJfvEz9rKR0RKRSAqNd+LC
 Pc3FkIRAyDlE5BGRizfa9eoTOOd80Ao=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-gRkn4m2FNGCUZcVOotNsPg-1; Tue,
 10 Mar 2026 12:26:57 -0400
X-MC-Unique: gRkn4m2FNGCUZcVOotNsPg-1
X-Mimecast-MFC-AGG-ID: gRkn4m2FNGCUZcVOotNsPg_1773160016
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5097A18002DD; Tue, 10 Mar 2026 16:26:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B3A419560A6; Tue, 10 Mar 2026 16:26:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/28] fuse: Drop permission changes in fuse_do_truncate
Date: Tue, 10 Mar 2026 17:26:10 +0100
Message-ID: <20260310162622.333137-17-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hanna Czenczek <hreitz@redhat.com>

This function is always called with writable == true.  This makes
add_resize_perm always false, and thus we can drop the quite ugly
permission-changing code.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-17-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index af0a8de17b1..b7a710c29f8 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -503,44 +503,14 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
 static int fuse_do_truncate(const FuseExport *exp, int64_t size,
                             bool req_zero_write, PreallocMode prealloc)
 {
-    uint64_t blk_perm, blk_shared_perm;
     BdrvRequestFlags truncate_flags = 0;
-    bool add_resize_perm;
-    int ret, ret_check;
-
-    /* Growable and writable exports have a permanent RESIZE permission */
-    add_resize_perm = !exp->growable && !exp->writable;
 
     if (req_zero_write) {
         truncate_flags |= BDRV_REQ_ZERO_WRITE;
     }
 
-    if (add_resize_perm) {
-        if (!qemu_in_main_thread()) {
-            /* Changing permissions like below only works in the main thread */
-            return -EPERM;
-        }
-
-        blk_get_perm(exp->common.blk, &blk_perm, &blk_shared_perm);
-
-        ret = blk_set_perm(exp->common.blk, blk_perm | BLK_PERM_RESIZE,
-                           blk_shared_perm, NULL);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
-    ret = blk_truncate(exp->common.blk, size, true, prealloc,
-                       truncate_flags, NULL);
-
-    if (add_resize_perm) {
-        /* Must succeed, because we are only giving up the RESIZE permission */
-        ret_check = blk_set_perm(exp->common.blk, blk_perm,
-                                 blk_shared_perm, &error_abort);
-        assert(ret_check == 0);
-    }
-
-    return ret;
+    return blk_truncate(exp->common.blk, size, true, prealloc,
+                        truncate_flags, NULL);
 }
 
 /**
-- 
2.53.0


