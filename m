Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBB8EE0AE0
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 14:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voiv2-0003S1-6A; Sat, 07 Feb 2026 09:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <22296f2db9f17f9954f85de9e99b09498936eb51@kylie.crudebyte.com>)
 id 1voiuz-0003Rd-AG
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 09:04:14 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <22296f2db9f17f9954f85de9e99b09498936eb51@kylie.crudebyte.com>)
 id 1voiux-0005jY-LD
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 09:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=kz874Y4LL8BIAsP3NfhIr4ERHLswagX7zKXSQF9iv3w=; b=P8tvR
 TBF5tTyGiG6uxOboCrruo8cH4pP1g8Qx+3x+DEFfIyZ3N7Ai+J9ikt4wodMl6FXqn+tI9q4RkYhJW
 Fx+RYg/B9riMCcrEycVRBudu7OLB6TSuu96l0H+Ay6p5wpELp6uuyxQIFPsVMxxgIxD8IbO17cYcA
 tyUHakrQL3+7TSRVZZJbHt7H3GSPqNfePFtOkTUr7iNmLu+gH/QZlN+17BfMkmBpj8WG4N/TkEsym
 +BLVEW5vQiSruZv7iGALc9W/c+d3cgkGMxBoM6jPEc7729IgSRkEOE897HExINDk6hNmtU4YlsrAK
 QmzFB7JzlU9TLdXxyq/fRtMuaw5BeeQQ2ge4BGh6jB/jWXmmYaK7xb4fUoYkRCiS5fYCABOoHcXdd
 E86o/V0uBLh6yB2mDa1xqzwiwfdjcv/4RE8yxOcBq63tKKs8il1TXgY3iJQsuOFTu5+yosybHuzn6
 i88xkrcIKd/j3l/7hTjtoN2t60G9eYziYttPty7pmSrV4s8Nn9hBfs55XLq0usbbS9cCg9eXhzFI+
 2SALsS2WvHepq0XZldD7gaFGx7LsNE0qrpZ2JR23nFXWuwkhn7gx8QZIgNEjroEyq26s7IFdtqUnC
 3PMmyaMXoeoIevxmtQd4iPb/vTzhWJqvDqV0DWhIWzsVyPREiwH5S6R05QlKjM=;
Message-ID: <22296f2db9f17f9954f85de9e99b09498936eb51.1770470220.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1770470220.git.qemu_oss@crudebyte.com>
References: <cover.1770470220.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 07 Feb 2026 14:17:00 +0100
Subject: [PULL 1/1] 9pfs: local: read native symlinks when
 security-model=mapped
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=22296f2db9f17f9954f85de9e99b09498936eb51@kylie.crudebyte.com;
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

From: Andrey Erokhin <language.lawyer@gmail.com>

Directories attached using virtfs with security-model=mapped
may contain native symlinks

This can happen e.g. when booting from a rootfs directory tree
(usually with a writable overlay set up on the host side)

Currently, when security-model=mapped[-xattr|-file],
QEMU assumes that host-side "symlinks" are in the mapped format,
i.e. are regular files storing the linked path,
so it tries to open with O_NOFOLLOW
and fails with ELOOP on native symlinks

This patch introduces a fallback for such cases:
reuse security-model=[none|passthrough] else if branch logic
where readlink will be called for the path basename

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/173
Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Link: https://lore.kernel.org/qemu-devel/3c35955d-a57e-4203-81c5-395146e23f83@gmail.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index c3745f2839..24cb1da90a 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -469,12 +469,16 @@ static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
 
         fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
         if (fd == -1) {
+            if (errno == ELOOP) {
+                goto native_symlink;
+            }
             return -1;
         }
         tsize = RETRY_ON_EINTR(read(fd, (void *)buf, bufsz));
         close_preserve_errno(fd);
     } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
                (fs_ctx->export_flags & V9FS_SM_NONE)) {
+    native_symlink:;
         char *dirpath = g_path_get_dirname(fs_path->data);
         char *name = g_path_get_basename(fs_path->data);
         int dirfd;
-- 
2.47.3


