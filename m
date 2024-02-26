Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC5DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeHo-0005ZJ-6g; Mon, 26 Feb 2024 11:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHl-0005XN-7C
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:01 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHX-0007aO-4T
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=kV26etjdgrTttBHqNO1xlpqvRXHOfMKajDrhdh/+Zqo=; b=ijy1WUQl4gy5
 15u8ifI9ORKKzhR+7noCc41HWvc7WQUipIoFtoNkaDQp+ck3KFKT8Y/UayQkaluF+CEi07yvtnrLG
 upOA3l81RBtlj7/5vjjvi/s+rGUj53ZOTco4EQI3Dhl1kGup0mnlWev94HtwdK7W4+zTu6QDGNzZD
 fkbf/vNu+axs+c/csFxD8ZcElFHR8j7iC+XSUfYTqdFJksPixOsIZQT3gUpBq+q3ZQyM3U1yb8oEz
 JKgTk2VmuwpHPZ0PQiHZecL30T0OoPB5nw2m62mOVCmXVk7QX4Yb4E7DrivpYa9OuNy89RhPZus9M
 dMZXwiO7YalqOFj+i9DyBg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1reeG3-001AD7-02;
 Mon, 26 Feb 2024 17:56:34 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 1/7] qga/commands-posix: return fsinfo values directly as
 reported by statvfs
Date: Mon, 26 Feb 2024 18:56:36 +0200
Message-Id: <20240226165642.807350-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo:
used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail).
These calculations might be obscure for the end user and require one to
actually get into QGA source to understand how they're obtained. Let's
just report the values f_blocks, f_bfree, f_bavail (in bytes) from
statvfs() as they are, letting the user decide how to process them further.

Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 16 +++++++---------
 qga/qapi-schema.json | 11 +++++++----
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 26008db497..752ef509d0 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1554,8 +1554,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
 {
     GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
-    struct statvfs buf;
-    unsigned long used, nonroot_total, fr_size;
+    struct statvfs st;
     char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
 
@@ -1563,15 +1562,14 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
-    if (statvfs(fs->mountpoint, &buf) == 0) {
-        fr_size = buf.f_frsize;
-        used = buf.f_blocks - buf.f_bfree;
-        nonroot_total = used + buf.f_bavail;
-        fs->used_bytes = used * fr_size;
-        fs->total_bytes = nonroot_total * fr_size;
+    if (statvfs(fs->mountpoint, &st) == 0) {
+        fs->total_bytes = st.f_blocks * st.f_frsize;
+        fs->free_bytes = st.f_bfree * st.f_frsize;
+        fs->avail_bytes = st.f_bavail * st.f_frsize;
 
         fs->has_total_bytes = true;
-        fs->has_used_bytes = true;
+        fs->has_free_bytes = true;
+        fs->has_avail_bytes = true;
     }
 
     g_free(devpath);
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b8efe31897..1cce3c1df5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1030,9 +1030,12 @@
 #
 # @type: file system type string
 #
-# @used-bytes: file system used bytes (since 3.0)
+# @total-bytes: total file system size in bytes (since 8.3)
 #
-# @total-bytes: non-root file system total bytes (since 3.0)
+# @free-bytes: amount of free space in file system in bytes (since 8.3)
+#
+# @avail-bytes: amount of free space in file system for unprivileged
+#     users in bytes (since 8.3)
 #
 # @disk: an array of disk hardware information that the volume lies
 #     on, which may be empty if the disk type is not supported
@@ -1041,8 +1044,8 @@
 ##
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
-           '*used-bytes': 'uint64', '*total-bytes': 'uint64',
-           'disk': ['GuestDiskAddress']} }
+           '*total-bytes': 'uint64', '*free-bytes': 'uint64',
+           '*avail-bytes': 'uint64', 'disk': ['GuestDiskAddress']} }
 
 ##
 # @guest-get-fsinfo:
-- 
2.39.3


