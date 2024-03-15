Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F237FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6hC-0002D8-MF; Fri, 15 Mar 2024 08:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h9-0002CL-10
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:55 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h6-0006OR-Hb
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=z+2upVLm5CJLKbcQAz4YdhJ9C1wGGiDlSEOSE/EyGsY=; b=nsINTdb8tBVP
 DgMlRXjEz2Umdf6eJMjrIGj3YLhtyxURzFMaZYZUg0vz4SvLdXt3v49+xk6lUIwDOWNjpEgY7tMrn
 IbEZ0Mit731NyOG3M/x+1H9/kKmi7OWfH2W3DtY6j3/NDGsn5lQv3jE9HKZVLUhWulXNfe5h5X9my
 TxJ7XHb5/gCdx3KziWy0NJrxy7JxKmYDrRQw0aKdDIqIcd5vzZr0Aoc240tb/F0U2C+Xo/GVVbOYN
 aiG8LvvrmfoiURwdl7u59v25oG0V1K2FXggBMLy1etY2oQgPybM77jvhzYkZBwzDEeG8uJV17g25T
 JYPn14efF1cRd1vsmqrnDA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rl6f4-005Caf-39;
 Fri, 15 Mar 2024 13:29:46 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 1/7] qga: guest-get-fsinfo: add optional 'total-bytes-root'
 field
Date: Fri, 15 Mar 2024 14:29:40 +0200
Message-Id: <20240315122946.39168-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
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
used = (f_blocks - f_bfree), total = (f_blocks - f_bfree + f_bavail) as
returned by statvfs(3).  While on Windows guests that's all we can get
with GetDiskFreeSpaceExA(), on POSIX guests we might also be interested in
total file system size, as it's visible for root user.  Let's add an
optional field 'total-bytes-root' to GuestFilesystemInfo struct, which'd
only be reported on POSIX and represent f_blocks value as returned by
statvfs(3).

While here, let's document better where those values come from in both
POSIX and Windows.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c |  2 ++
 qga/commands-win32.c |  1 +
 qga/qapi-schema.json | 12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 26008db497..8207c4c47e 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1569,8 +1569,10 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
         nonroot_total = used + buf.f_bavail;
         fs->used_bytes = used * fr_size;
         fs->total_bytes = nonroot_total * fr_size;
+        fs->total_bytes_root = buf.f_blocks * fr_size;
 
         fs->has_total_bytes = true;
+        fs->has_total_bytes_root = true;
         fs->has_used_bytes = true;
     }
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a1015757d8..9e820aad8d 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1143,6 +1143,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     fs = g_malloc(sizeof(*fs));
     fs->name = g_strdup(guid);
     fs->has_total_bytes = false;
+    fs->has_total_bytes_root = false;
     fs->has_used_bytes = false;
     if (len == 0) {
         fs->mountpoint = g_strdup("System Reserved");
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b8efe31897..093a5ab602 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1031,8 +1031,18 @@
 # @type: file system type string
 #
 # @used-bytes: file system used bytes (since 3.0)
+#     * POSIX: (f_blocks - f_bfree) * f_frsize, as returned by statvfs(3)
+#     * Windows: (TotalNumberOfBytes - TotalNumberOfFreeBytes), as returned
+#       by GetDiskFreeSpaceEx()
 #
 # @total-bytes: non-root file system total bytes (since 3.0)
+#     * POSIX: (f_blocks - f_bfree + f_bavail) * f_frsize, as returned by
+#       statvfs(3)
+#     * Windows: TotalNumberOfBytes, as returned by GetDiskFreeSpaceEx()
+#
+# @total-bytes-root: total file system size in bytes (as visible for a
+#     priviledged user) (since 8.3)
+#     * POSIX only: (f_blocks * f_frsize), returned by statvfs(3)
 #
 # @disk: an array of disk hardware information that the volume lies
 #     on, which may be empty if the disk type is not supported
@@ -1042,7 +1052,7 @@
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
            '*used-bytes': 'uint64', '*total-bytes': 'uint64',
-           'disk': ['GuestDiskAddress']} }
+           '*total-bytes-root': 'uint64', 'disk': ['GuestDiskAddress']} }
 
 ##
 # @guest-get-fsinfo:
-- 
2.39.3


