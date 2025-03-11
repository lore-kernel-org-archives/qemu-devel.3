Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C6BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3P5-00013J-I3; Tue, 11 Mar 2025 13:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P3-000134-BI
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:29 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P1-0004uZ-8N
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:29 -0400
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-hTCYDrg_M-q1fR5lVmnd-g-1; Tue,
 11 Mar 2025 13:28:19 -0400
X-MC-Unique: hTCYDrg_M-q1fR5lVmnd-g-1
X-Mimecast-MFC-AGG-ID: hTCYDrg_M-q1fR5lVmnd-g_1741714098
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FF86180035E; Tue, 11 Mar 2025 17:28:18 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A585B1955BCB; Tue, 11 Mar 2025 17:28:15 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 1/6] 9pfs: local : Introduce local_fid_fd() helper
Date: Tue, 11 Mar 2025 18:28:04 +0100
Message-ID: <20250311172809.250913-2-groug@kaod.org>
In-Reply-To: <20250311172809.250913-1-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Factor out duplicated code to a single helper. More users to come.

Signed-off-by: Greg Kurz <groug@kaod.org>

v2: - simplified local_fid_fd()
---
 hw/9pfs/9p-local.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 928523afcc6c..99b9560a528b 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -766,16 +766,19 @@ out:
     return err;
 }
 
-static int local_fstat(FsContext *fs_ctx, int fid_type,
-                       V9fsFidOpenState *fs, struct stat *stbuf)
+static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
 {
-    int err, fd;
-
     if (fid_type == P9_FID_DIR) {
-        fd = dirfd(fs->dir.stream);
+        return dirfd(fs->dir.stream);
     } else {
-        fd = fs->fd;
+        return fs->fd;
     }
+}
+
+static int local_fstat(FsContext *fs_ctx, int fid_type,
+                       V9fsFidOpenState *fs, struct stat *stbuf)
+{
+    int err, fd = local_fid_fd(fid_type, fs);
 
     err = fstat(fd, stbuf);
     if (err) {
@@ -1167,13 +1170,7 @@ out:
 static int local_fsync(FsContext *ctx, int fid_type,
                        V9fsFidOpenState *fs, int datasync)
 {
-    int fd;
-
-    if (fid_type == P9_FID_DIR) {
-        fd = dirfd(fs->dir.stream);
-    } else {
-        fd = fs->fd;
-    }
+    int fd = local_fid_fd(fid_type, fs);
 
     if (datasync) {
         return qemu_fdatasync(fd);
-- 
2.48.1


