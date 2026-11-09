Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89E606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ibr.cs.tu-bs.de header.i=@ibr.cs.tu-bs.de header.a=rsa-sha256 header.s=key2 header.b=zph1vgZ1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1T-0003hC-TP; Mon, 09 Nov 2026 15:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gollenstede@ibr.cs.tu-bs.de>)
 id 1xQRir-00032I-Mk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:55:53 -0500
Received: from mail.ibr.cs.tu-bs.de ([134.169.34.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gollenstede@ibr.cs.tu-bs.de>)
 id 1xQRip-0004cM-UN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 10:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ibr.cs.tu-bs.de;
 s=key2; t=1794239750;
 bh=7wp3v31tJCTSjX65gDazYU7h48T6JQWedELv7Gw+uBY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zph1vgZ1NGmhjslYHvScHs69mZ58iINVHylXz5G2diqXoCQ3xiNzxxgIHStj+TmsZ
 tAMr5UzUR6Y5qfCHAhV0rgezg79nN2cfvKFozgzlaEzo1jqJNELtuLD6RsHica2hzt
 IQIi7aSh7Q14QP7qV+h9DHopAZUEkkMeQpyoLeGw=
X-Virus-Scanned: Debian amavisd-new at ibr.cs.tu-bs.de
Received: from work (unknown [IPv6:2001:638:602:d023:bb5a:b7cc:7fd8:120f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: gollenst)
 by mail.ibr.cs.tu-bs.de (Postfix) with ESMTPSA id C52127CBF18F;
 Mon,  9 Nov 2026 16:55:50 +0100 (CET)
From: Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
Subject: [PATCH 1/2] 9pfs/local: allow exporting traversable but non-readable
 directories
Date: Mon,  9 Nov 2026 16:55:02 +0100
Message-ID: <20261109155503.2530430-2-gollenstede@ibr.cs.tu-bs.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109155503.2530430-1-gollenstede@ibr.cs.tu-bs.de>
References: <20261109155503.2530430-1-gollenstede@ibr.cs.tu-bs.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.169.34.14;
 envelope-from=gollenstede@ibr.cs.tu-bs.de; helo=mail.ibr.cs.tu-bs.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:03 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Exporting directories via 9p that are not readable (`r`) by the current user failed for no reason other than requesting read permissions when opening directories.
Since the resulting directory file descriptors are only to operate on child files, passing `O_PATH` (or rather `O_PATH_9P_UTIL`) to the open calls fixes this.

AI-used-for: root-cause analysis (Claude Opus 5.5)
Signed-off-by: Niklas Gollenstede <gollenstede@ibr.cs.tu-bs.de>
---
 hw/9pfs/9p-local.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index ee592b62f8..3bebebea04 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -97,7 +97,8 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,

 int local_opendir_nofollow(FsContext *fs_ctx, const char *path)
 {
-    return local_open_nofollow(fs_ctx, path, O_DIRECTORY | O_RDONLY, 0);
+    return local_open_nofollow(fs_ctx, path,
+                               O_DIRECTORY | O_RDONLY | O_PATH_9P_UTIL, 0);
 }

 static void renameat_preserve_errno(int odirfd, const char *opath, int ndirfd,
@@ -526,7 +527,7 @@ static int local_opendir(FsContext *ctx,
     int dirfd;
     DIR *stream;

-    dirfd = local_opendir_nofollow(ctx, fs_path->data);
+    dirfd = local_open_nofollow(ctx, fs_path->data, O_DIRECTORY | O_RDONLY, 0);
     if (dirfd == -1) {
         return -1;
     }
@@ -1207,7 +1208,7 @@ static int local_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
 {
     int fd, ret;

-    fd = local_open_nofollow(s, fs_path->data, O_RDONLY, 0);
+    fd = local_open_nofollow(s, fs_path->data, O_RDONLY | O_PATH_9P_UTIL, 0);
     if (fd == -1) {
         return -1;
     }
@@ -1471,7 +1472,7 @@ static int local_init(FsContext *ctx, Error **errp)
 {
     LocalData *data = g_malloc(sizeof(*data));

-    data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY);
+    data->mountfd = open(ctx->fs_root, O_DIRECTORY | O_RDONLY | O_PATH_9P_UTIL);
     if (data->mountfd == -1) {
         error_setg_file_open(errp, errno, ctx->fs_root);
         goto err;
--
2.54.0


