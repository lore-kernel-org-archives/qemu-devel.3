Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D9CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6h3-0003nv-TO; Fri, 01 Mar 2024 12:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6h2-0003me-0Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:08 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6gx-0005d1-VX
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=z+2upVLm5CJLKbcQAz4YdhJ9C1wGGiDlSEOSE/EyGsY=; b=WEtGjaprVOM9
 3oi6XZ7u1Xm+AnZ++p2+HndqRrEsznR0fYwa5CNE0TOFZlJNSA4xbdzOBIqfAyqagL7SnkoR3/woy
 iZXnGaRzGB5Odi0krFHqF4QPIgdtgrtEOra4qHxeKEggipiNLTiFRGZd8p/PNndwlyq65nxy7AX2V
 0OVco3OI1KHeVZRn87NzXG/ugWupSnn+30tnOuqkFJE2a1U6MHs3gqoWss7a7G9pBpMuUqYQym7bf
 pQcxwA1m4nidt8MEUYjBwD14zaIQ/XVOhrTprQOhA6H5JlqGCKYvpZ2nUmmoYyySu98cwQlq/fk8A
 DTyoBUiCTHzGuCkfXh90ew==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rg6fM-0022sZ-0b;
 Fri, 01 Mar 2024 18:28:57 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 1/7] qga: guest-get-fsinfo: add optional 'total-bytes-root'
 field
Date: Fri,  1 Mar 2024 19:28:52 +0200
Message-Id: <20240301172858.665135-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
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


