Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D534EE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 12:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRVUz-0003Ed-VF; Sat, 28 Dec 2024 07:00:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tRVUW-00039i-Rw; Sat, 28 Dec 2024 07:00:33 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tRVUT-0006gI-OF; Sat, 28 Dec 2024 07:00:24 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 9DE2ECC838;
 Sat, 28 Dec 2024 14:59:39 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 4AA7E46164; Sat, 28 Dec 2024 14:54:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 04/11] vvfat: fix ubsan issue in create_long_filename
Date: Sat, 28 Dec 2024 14:54:39 +0300
Message-Id: <20241228115446.2478706-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241228115446.2478706-1-mjt@tls.msk.ru>
References: <20241228115446.2478706-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Found with test sbsaref introduced in [1].

[1] https://patchew.org/QEMU/20241203213629.2482806-1-pierrick.bouvier@linaro.org/

../block/vvfat.c:433:24: runtime error: index 14 out of bounds for type 'uint8_t [11]'
    #0 0x56151a66b93a in create_long_filename ../block/vvfat.c:433
    #1 0x56151a66f3d7 in create_short_and_long_name ../block/vvfat.c:725
    #2 0x56151a670403 in read_directory ../block/vvfat.c:804
    #3 0x56151a674432 in init_directories ../block/vvfat.c:964
    #4 0x56151a67867b in vvfat_open ../block/vvfat.c:1258
    #5 0x56151a3b8e19 in bdrv_open_driver ../block.c:1660
    #6 0x56151a3bb666 in bdrv_open_common ../block.c:1985
    #7 0x56151a3cadb9 in bdrv_open_inherit ../block.c:4153
    #8 0x56151a3c8850 in bdrv_open_child_bs ../block.c:3731
    #9 0x56151a3ca832 in bdrv_open_inherit ../block.c:4098
    #10 0x56151a3cbe40 in bdrv_open ../block.c:4248
    #11 0x56151a46344f in blk_new_open ../block/block-backend.c:457
    #12 0x56151a388bd9 in blockdev_init ../blockdev.c:612
    #13 0x56151a38ab2d in drive_new ../blockdev.c:1006
    #14 0x5615190fca41 in drive_init_func ../system/vl.c:649
    #15 0x56151aa796dd in qemu_opts_foreach ../util/qemu-option.c:1135
    #16 0x5615190fd2b6 in configure_blockdev ../system/vl.c:708
    #17 0x56151910a307 in qemu_create_early_backends ../system/vl.c:2004
    #18 0x561519113fcf in qemu_init ../system/vl.c:3685
    #19 0x56151a7e438e in main ../system/main.c:47
    #20 0x7f72d1a46249 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
    #21 0x7f72d1a46304 in __libc_start_main_impl ../csu/libc-start.c:360
    #22 0x561517e98510 in _start (/home/user/.work/qemu/build/qemu-system-aarch64+0x3b9b510)

The offset used can easily go beyond entry->name size. It's probably a
bug, but I don't have the time to dive into vfat specifics for now.

This change solves the ubsan issue, and is functionally equivalent, as
anything written past the entry->name array would not be read anyway.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/vvfat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/vvfat.c b/block/vvfat.c
index 8ffe8b3b9b..f2eafaa923 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -426,6 +426,10 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
         else if(offset<22) offset=14+offset-10;
         else offset=28+offset-22;
         entry=array_get(&(s->directory),s->directory.next-1-(i/26));
+        /* ensure we don't write anything past entry->name */
+        if (offset >= sizeof(entry->name)) {
+            continue;
+        }
         if (i >= 2 * length + 2) {
             entry->name[offset] = 0xff;
         } else if (i % 2 == 0) {
-- 
2.39.5


