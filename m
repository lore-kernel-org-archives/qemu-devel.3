Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB47BC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wregd-0007Ud-JM; Wed, 05 Aug 2026 12:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas@kemnade.info>)
 id 1wregc-0007PM-Lr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:41:46 -0400
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas@kemnade.info>)
 id 1wrega-0001kW-U8
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Subject:Cc:To:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=EeY2yJQbNAzRJhoKBpkSSHbYxUogIMXGN8MeXWkTOQs=; t=1785948102; x=1787157702; 
 b=PXSgy+aQtp6ZyTJQUG/Li5bW9oQloAGlc4v86cioNeyDxhzbS7JMhUpbfQvbJNTOVSLg8b/SW+7
 w5JrKlZuNf1H7nW9m/0Ebct0UsCfeYtVmFzL8XTQ3bkLC+Vy4CgziMonySqSsv5eP4JWGqQzW4zS1
 cPTgLRz8eHcjnYLvyC2E4Q1j0ynmsWZ8uCQVDnlLw/n+1JiKgnvlovIjWSQkmmwjstnaBSLuj9FA1
 FjMSaqDKrF6RGCj1cF9au4xSpC2MjZi6MQORV5RoQZ/1zekfPABzf1Fni/ePr+8raQAT6p7AYkfea
 yp8Qv9VCkJN11upEyIQLwSsGTf/Ee1iKY86Q==;
From: Andreas Kemnade <andreas@kemnade.info>
To: qemu-devel@nongnu.org
Cc: sre@kernel.org,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] linux-user: fix issues with mmap on 4K guest on 16K host and
 library load
Date: Wed,  5 Aug 2026 18:40:52 +0200
Message-ID: <20260805164052.199608-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:c205:3004:2154::1;
 envelope-from=andreas@kemnade.info; helo=mail.andi.de1.cc
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Strace in qemu:
198005 openat(AT_FDCWD,"/lib/arm-linux-gnueabihf/libselinux.so.1",O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
198005 read(3,0x40802570,512) = 512
198005 statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT|AT_STATX_SYNC_AS_STAT,STATX_BASIC_STATS,0x408022a8) = 0
198005 mmap2(NULL,269428,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_DENYWRITE,-1,0) = 0x40868000
198005 mmap2(0x40870000,203892,PROT_EXEC|PROT_READ,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0) = 0x40870000
198005 munmap(0x40868000,32768) = 0
198005 munmap(0x408a2000,31860) = 0
198005 mprotect(0x40890000,61440,PROT_NONE) = 0
198005 mmap2(0x4089f000,8192,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_DENYWRITE|MAP_FIXED,3,0x1f) = -1 errno=14 (Bad address)

strace outside qemu:
[pid 195331] readlinkat(AT_FDCWD, "/usr/lib", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
[pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
[pid 195331] readlinkat(AT_FDCWD, "/usr/lib/arm-linux-gnueabihf/libselinux.so.1", 0x7fffd1a7fd00, 1023) = -1 EINVAL (Invalid argument)
[pid 195331] faccessat(AT_FDCWD, "/usr/gnemul/qemu-arm/lib/arm-linux-gnueabihf/libselinux.so.1", F_OK) = -1 ENOENT (No such file or directory)
[pid 195331] openat(AT_FDCWD, "/lib/arm-linux-gnueabihf/libselinux.so.1", O_RDONLY|O_CLOEXEC) = 3
[pid 195331] read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\0\0\0\0004\0\0\0"..., 512) = 512
[pid 195331] statx(3, "", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT|AT_EMPTY_PATH, STATX_BASIC_STATS, {stx_mask=STATX_ALL|STATX_MNT_ID|STATX_SUBVOL, stx_attributes=0, stx_mode=S_IFREG|0644, stx_size=132612, ...}) = 0
[pid 195331] mmap(0x408a8000, 16384, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x408a8000
[pid 195331] mprotect(0x408a8000, 16384, PROT_WRITE) = 0
[pid 195331] mprotect(0x408a8000, 16384, PROT_NONE) = 0
[pid 195331] mmap(0x40868000, 262144, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_DENYWRITE, -1, 0) = 0x40868000
[pid 195331] mprotect(0x408a0000, 16384, PROT_WRITE) = 0
[pid 195331] pread64(3, "", 8192, 196608) = 0
[pid 195331] mprotect(0x408a0000, 16384, PROT_READ) = 0
[pid 195331] mmap(0x40870000, 196608, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0x40870000
[pid 195331] mmap(0x40868000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x40868000
[pid 195331] mmap(0x408a4000, 32768, PROT_NONE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0) = 0x408a4000
[pid 195331] mprotect(0x4089c000, 16384, PROT_READ) = 0
[pid 195331] mprotect(0x40890000, 49152, PROT_NONE) = 0
[pid 195331] mprotect(0x4089c000, 16384, PROT_WRITE) = 0
[pid 195331] pread64(3, 0x4089f000, 4096, 126976) = -1 EFAULT (Bad address)

That makes simple commands like ls --version to fail.
Tested was arm32 on a arm64 only host.

Fix that issue by truncating file mapping and replacing out-of-file
mappings by anonymous mappings.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 linux-user/mmap.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 423c77856a..4fce6fae3c 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -796,6 +796,32 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
     bool misaligned_offset = false;
     size_t host_len;
 
+    if (!(flags & MAP_ANONYMOUS)) {
+        struct stat sb;
+
+        if (fstat(fd, &sb) == -1) {
+            return -1;
+        }
+        if (offset >= sb.st_size) {
+            /*
+             * The entire map is beyond the end of the file.
+             * Transform it to an anonymous mapping.
+             */
+            flags |= MAP_ANONYMOUS;
+            fd = -1;
+            offset = 0;
+        } else if (offset + len > sb.st_size) {
+            /*
+             * A portion of the map is beyond the end of the file.
+             * Truncate the file portion of the allocation.
+             */
+            len = sb.st_size - offset;
+            len = len + host_page_size - 1;
+            len /= host_page_size;
+            len *= host_page_size;
+        }
+    }
+
     if (start || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
         want_p = g2h_untagged(start);
     }
-- 
2.47.3


