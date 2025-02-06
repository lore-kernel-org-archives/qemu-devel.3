Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED982C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg53o-0008Lp-Ai; Thu, 06 Feb 2025 11:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a2f17bd40b3d302f6c1ddf0da75d2343966e0a3f@kylie.crudebyte.com>)
 id 1tg53i-0008Kd-PZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:49:00 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a2f17bd40b3d302f6c1ddf0da75d2343966e0a3f@kylie.crudebyte.com>)
 id 1tg53g-0006EH-1x
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=wWlmiOVMENnEwZf9iPw+EDJPnbEjYuKXLevRQyibxQ0=; b=rm3I3
 bSkLFm07bvsTn5bzQKHxM9HosyNqpMYfJYybwxfYlFoo9P/A15ugQzl9Bski3UdDopG65IORNtEGZ
 n5kArh0tOAC5gAWpgiDzjwyH4+4oMH+YFmQntxEALa5dhW/a1ZOa+XUxzuA4murFdvX+UYf5WXHAD
 hJ+rVmSUY3mfQgvGjNCFs1KTr4o6/zepi8oTXCRqNpV9crSnPV5B8cCKCPb58LtU32eK5lwEAdoAd
 eMelZeJyhndMhkSKkkc3l4RA60sjSsKse704jHkk1NhCekvAGg5m3+0KK7G6FmlGS5fJ8ZpoCjMpC
 CGvY8Nlkd4MxmfpW4TqC7Rfi6IqPq3Mo64L/lILAdlZwqS724vQna9BnVHZ9PeQ6zv7+UXiQXX/K2
 m4T1BeohJYij5a0qae6p/wCaQc5vsOdW79NhYpWgeqK4NTk2cmvYKkh70EMikhrXKoQ28+23ClsTL
 s48a7iePWc3ltsf5ru63eUPT2ybeIj/wMe/p/6XvNsmwGkEXYAdIVWZ9/t7s5xtw+1f+mbUHkeqZv
 JHG61ambBY+y/uR02A66K1dbBU1ap9zIkyJgY4NbUERHZ+kTirt7fMCSk5Vhp7YxOezR2GU+vqq+6
 BcVrnXfmwWmo1oC+PdfEm5f7mD5as1jA4SxMcAhYWD++UUUxEiLm1F9gJ27ktQ=;
Message-Id: <a2f17bd40b3d302f6c1ddf0da75d2343966e0a3f.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 2/7] 9pfs: make multidevs=remap default
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a2f17bd40b3d302f6c1ddf0da75d2343966e0a3f@kylie.crudebyte.com;
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

1a6ed33cc5 introduced option multidevs=remap|forbid|warn and made
"warn" the default option.

As it turned out though, e.g. by several reports in conjunction with
following 9p client issue:

https://github.com/torvalds/linux/commit/850925a8133c73c4a2453c360b2c3beb3bab67c9

Many people are just ignoring this warning, or even do not notice the
warning at all. Therefore make multidevs=remap the new default option to
prevent people to run into such kind of severe misbehaviours in the first
place.

From performance PoV the runtime overhead of multidevs=remap is
neglectable with few or even just only one device being shared with the
same 9p export, expected to be constant Theta(1). The inode numbers
emitted to guest also just loose one bit (since 6b6aa8285d) for the 1st
device being shared.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <09cc84e5561f66b6a8cf49b3532c6c78a6acc806.1734876877.git.qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c |  3 +++
 qemu-options.hx    | 49 +++++++++++++++++++++++++---------------------
 2 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 1b1f3b9ec8..928523afcc 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1538,6 +1538,9 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
                               "[remap|forbid|warn]\n");
             return -1;
         }
+    } else {
+        fse->export_flags &= ~V9FS_FORBID_MULTIDEVS;
+        fse->export_flags |= V9FS_REMAP_INODES;
     }
 
     if (!path) {
diff --git a/qemu-options.hx b/qemu-options.hx
index ec0090dfe2..1b26ad53bd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1951,32 +1951,37 @@ SRST
         Specifies the tag name to be used by the guest to mount this
         export point.
 
-    ``multidevs=multidevs``
-        Specifies how to deal with multiple devices being shared with a
-        9p export. Supported behaviours are either "remap", "forbid" or
-        "warn". The latter is the default behaviour on which virtfs 9p
-        expects only one device to be shared with the same export, and
-        if more than one device is shared and accessed via the same 9p
-        export then only a warning message is logged (once) by qemu on
-        host side. In order to avoid file ID collisions on guest you
-        should either create a separate virtfs export for each device to
-        be shared with guests (recommended way) or you might use "remap"
-        instead which allows you to share multiple devices with only one
-        export instead, which is achieved by remapping the original
-        inode numbers from host to guest in a way that would prevent
-        such collisions. Remapping inodes in such use cases is required
+    ``multidevs=remap|forbid|warn``
+        Specifies how to deal with multiple devices being shared with
+        the same 9p export in order to avoid file ID collisions on guest.
+        Supported behaviours are either "remap" (default), "forbid" or
+        "warn".
+
+        ``remap`` : assumes the possibility that more than one device is
+        shared with the same 9p export. Therefore inode numbers from host
+        are remapped for guest in a way that would prevent file ID
+        collisions on guest. Remapping inodes in such cases is required
         because the original device IDs from host are never passed and
         exposed on guest. Instead all files of an export shared with
-        virtfs always share the same device id on guest. So two files
+        virtfs always share the same device ID on guest. So two files
         with identical inode numbers but from actually different devices
         on host would otherwise cause a file ID collision and hence
-        potential misbehaviours on guest. "forbid" on the other hand
-        assumes like "warn" that only one device is shared by the same
-        export, however it will not only log a warning message but also
-        deny access to additional devices on guest. Note though that
-        "forbid" does currently not block all possible file access
-        operations (e.g. readdir() would still return entries from other
-        devices).
+        potential severe misbehaviours on guest.
+
+        ``warn`` : virtfs 9p expects only one device to be shared with
+        the same export. If however more than one device is shared and
+        accessed via the same 9p export then only a warning message is
+        logged (once) by qemu on host side. No further action is performed
+        in this case that would prevent file ID collisions on guest. This
+        could thus lead to severe misbehaviours in this case like wrong
+        files being accessed and data corruption on the exported tree.
+
+        ``forbid`` : assumes like "warn" that only one device is shared
+        by the same 9p export, however it will not only log a warning
+        message but also deny access to additional devices on guest. Note
+        though that "forbid" does currently not block all possible file
+        access operations (e.g. readdir() would still return entries from
+        other devices).
 ERST
 
 DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
-- 
2.30.2


