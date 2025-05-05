Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F41C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsWl-0002jg-M5; Mon, 05 May 2025 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e@kylie.crudebyte.com>)
 id 1uBsWk-0002iy-2c
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e@kylie.crudebyte.com>)
 id 1uBsWi-0005Ei-FZ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=I9J7ICrc3UB3XRzyZc1GoptV6oz460tI1yHeYDw7OSo=; b=HWrKz
 mqIP4fuwxvpbv6JDPO+ZjUI8uar4xzYVON3JjOIEIFvYCw8VMhCnSCGONPC5J8oqXL1p0yaIq0Wtg
 ZdbkTw5BeiO/SAdUieaAK4nObdREAPhkGqe0RuHiPgtqO/UpRAXcWC2GWqvPmZ6nGJTZEc83PFuTQ
 dnE5YgRSOh3LiBOtgFPQo11FaYERz78PbMr8Gb3xXkHrSaWPzZhRaleL7apF6hnUOTsYqlOuOyoZF
 adwgsQp2KJ55ff4bf1a+JyvWyNjnn51nI3czBJ+8ljWgI3oq4wuIDHx0/6uMnYg6qU7iY8kZkexMx
 Kkrn+lE6Qcz6mth8CIOrvNvu+tzuulhtNp1Fo8Q9EEWZubA7STIwvTz5PAyyAEV+QdFCCuB/PStZP
 xZYeSSVLmmh2BSoj2gN8Z/Y6DXwMip2mqSwUxu2GvKUobwCip1/SccZLoOak04QqN0Uu0/KdUPwVy
 ciNhJFZaKxjerXHhNGhPTbQRxXcNSshiTe3D+Q7o9drY+BREeLdNwrmrw8EF3rA8WDIWSjfbZFjs9
 otwbrVAHaE0FslY86Bzn5oA+QE2HtgQjisglw8XoTMNyHs+44ViRkC0P9dRXu/GCsJNpmgEoWHpom
 LDJMkqixtLfTs9Tmzuooj8tsknCLFglX51s5GrSGniaq3OrgvPEWHIwgmOQ788=;
Message-Id: <4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 3/9] 9pfs: local : Introduce local_fid_fd() helper
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4f82ce8cd94f2601fb2b2e4cfe0cf5b44131817e@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Greg Kurz <groug@kaod.org>

Factor out duplicated code to a single helper. More users to come.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20250312152933.383967-2-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 928523afcc..99b9560a52 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -766,16 +766,19 @@ out:
     return err;
 }
 
+static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
+{
+    if (fid_type == P9_FID_DIR) {
+        return dirfd(fs->dir.stream);
+    } else {
+        return fs->fd;
+    }
+}
+
 static int local_fstat(FsContext *fs_ctx, int fid_type,
                        V9fsFidOpenState *fs, struct stat *stbuf)
 {
-    int err, fd;
-
-    if (fid_type == P9_FID_DIR) {
-        fd = dirfd(fs->dir.stream);
-    } else {
-        fd = fs->fd;
-    }
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
2.30.2


