Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD45C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 08:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchqx-00015k-6x; Wed, 21 Feb 2024 03:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqt-00014X-6L; Wed, 21 Feb 2024 03:21:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqp-0002A9-IH; Wed, 21 Feb 2024 03:21:14 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 41CEC4F3C4;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0D984860A3;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142004 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 06/60] block/blkio: Make s->mem_region_alignment be 64
 bits
Date: Wed, 21 Feb 2024 11:19:54 +0300
Message-Id: <20240221082058.2141850-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: "Richard W.M. Jones" <rjones@redhat.com>

With GCC 14 the code failed to compile on i686 (and was wrong for any
version of GCC):

../block/blkio.c: In function ‘blkio_file_open’:
../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
  857 |                            &s->mem_region_alignment);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            size_t * {aka unsigned int *}
In file included from ../block/blkio.c:12:
/usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
   49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
      |                                                         ~~~~~~~~~~^~~~~

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-id: 20240130122006.2977938-1-rjones@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 615eaeab3d318ba239d54141a4251746782f65c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/blkio.c b/block/blkio.c
index 0a0a6c0f5f..bc2f21784c 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -68,7 +68,7 @@ typedef struct {
     CoQueue bounce_available;
 
     /* The value of the "mem-region-alignment" property */
-    size_t mem_region_alignment;
+    uint64_t mem_region_alignment;
 
     /* Can we skip adding/deleting blkio_mem_regions? */
     bool needs_mem_regions;
-- 
2.39.2


