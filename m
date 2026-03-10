Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347F8FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvX-0003jD-1m; Tue, 10 Mar 2026 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvM-0003SA-Td
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzvL-0000y0-8M
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=580OLnu98MzO5i32Lhtd2MCPaiQqex91cw2Qk/SXWUA=;
 b=hUbgDa15H6CTJg8eFmk5v+V2+lnMj6GuWlRALB9FfHXQmyXIGOmMce3OdphiTePD+nXqkv
 oI2IGhvnwmhbMHHiSJtj3Shhn7GKGcbYGO6uPeAfnvnEo84469gh8DlT19Vjd8kgvTGtfj
 FgLnVkBgF09N/nVoacQky/DZLJSIe3c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625--gb67MDpM1SwFimbAfFx1Q-1; Tue,
 10 Mar 2026 12:27:07 -0400
X-MC-Unique: -gb67MDpM1SwFimbAfFx1Q-1
X-Mimecast-MFC-AGG-ID: -gb67MDpM1SwFimbAfFx1Q_1773160026
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938491800625; Tue, 10 Mar 2026 16:27:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B5C419560A6; Tue, 10 Mar 2026 16:27:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 22/28] fuse: Make shared export state atomic
Date: Tue, 10 Mar 2026 17:26:16 +0100
Message-ID: <20260310162622.333137-23-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The next commit is going to allow multi-threaded access to a FUSE
export.  In order to allow safe concurrent SETATTR operations that
can modify the shared st_mode, st_uid, and st_gid, make any access to
those fields atomic operations.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-23-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 1c794118393..fe1b6ad5ffc 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -156,6 +156,7 @@ typedef struct FuseExport {
     /* Whether allow_other was used as a mount option or not */
     bool allow_other;
 
+    /* All atomic */
     mode_t st_mode;
     uid_t st_uid;
     gid_t st_gid;
@@ -266,6 +267,7 @@ static int fuse_export_create(BlockExport *blk_exp,
     ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
+    uint32_t st_mode;
     int ret;
 
     assert(blk_exp_args->type == BLOCK_EXPORT_TYPE_FUSE);
@@ -334,12 +336,13 @@ static int fuse_export_create(BlockExport *blk_exp,
         args->allow_other = FUSE_EXPORT_ALLOW_OTHER_AUTO;
     }
 
-    exp->st_mode = S_IFREG | S_IRUSR;
+    st_mode = S_IFREG | S_IRUSR;
     if (exp->writable) {
-        exp->st_mode |= S_IWUSR;
+        st_mode |= S_IWUSR;
     }
-    exp->st_uid = getuid();
-    exp->st_gid = getgid();
+    qatomic_set(&exp->st_mode, st_mode);
+    qatomic_set(&exp->st_uid, getuid());
+    qatomic_set(&exp->st_gid, getgid());
 
     if (args->allow_other == FUSE_EXPORT_ALLOW_OTHER_AUTO) {
         /* Try allow_other == true first, ignore errors */
@@ -817,10 +820,10 @@ fuse_co_getattr(FuseExport *exp, struct fuse_attr_out *out)
         .attr_valid = 1,
         .attr = {
             .ino        = 1,
-            .mode       = exp->st_mode,
+            .mode       = qatomic_read(&exp->st_mode),
             .nlink      = 1,
-            .uid        = exp->st_uid,
-            .gid        = exp->st_gid,
+            .uid        = qatomic_read(&exp->st_uid),
+            .gid        = qatomic_read(&exp->st_gid),
             .size       = length,
             .blksize    = blk_bs(exp->common.blk)->bl.request_alignment,
             .blocks     = allocated_blocks,
@@ -903,15 +906,15 @@ fuse_co_setattr(FuseExport *exp, struct fuse_attr_out *out, uint32_t to_set,
 
     if (to_set & FATTR_MODE) {
         /* Ignore FUSE-supplied file type, only change the mode */
-        exp->st_mode = (mode & 07777) | S_IFREG;
+        qatomic_set(&exp->st_mode, (mode & 07777) | S_IFREG);
     }
 
     if (to_set & FATTR_UID) {
-        exp->st_uid = uid;
+        qatomic_set(&exp->st_uid, uid);
     }
 
     if (to_set & FATTR_GID) {
-        exp->st_gid = gid;
+        qatomic_set(&exp->st_gid, gid);
     }
 
     return fuse_co_getattr(exp, out);
-- 
2.53.0


