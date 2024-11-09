Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EBED5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kPP-0006MC-42; Sat, 09 Nov 2024 07:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kNR-0003sU-TR; Sat, 09 Nov 2024 07:15:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kNQ-00054T-5r; Sat, 09 Nov 2024 07:15:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A09CA1632;
 Sat,  9 Nov 2024 15:08:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E50BC167FB9;
 Sat,  9 Nov 2024 15:09:01 +0300 (MSK)
Received: (nullmailer pid 3296154 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 09/58] raw-format: Fix error message for invalid
 offset/size
Date: Sat,  9 Nov 2024 15:08:10 +0300
Message-Id: <20241109120901.3295995-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Kevin Wolf <kwolf@redhat.com>

s->offset and s->size are only set at the end of the function and still
contain the old values when formatting the error message. Print the
parameters with the new values that we actually checked instead.

Fixes: 500e2434207d ('raw-format: Split raw_read_options()')
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240829185527.47152-1-kwolf@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 04bbc3ee52b32ac465547bb40c1f090a1b8f315a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/raw-format.c b/block/raw-format.c
index ac7e8495f6..e08526e2ec 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -111,7 +111,7 @@ raw_apply_options(BlockDriverState *bs, BDRVRawState *s, uint64_t offset,
     if (offset > real_size) {
         error_setg(errp, "Offset (%" PRIu64 ") cannot be greater than "
                    "size of the containing file (%" PRId64 ")",
-                   s->offset, real_size);
+                   offset, real_size);
         return -EINVAL;
     }
 
@@ -119,7 +119,7 @@ raw_apply_options(BlockDriverState *bs, BDRVRawState *s, uint64_t offset,
         error_setg(errp, "The sum of offset (%" PRIu64 ") and size "
                    "(%" PRIu64 ") has to be smaller or equal to the "
                    " actual size of the containing file (%" PRId64 ")",
-                   s->offset, s->size, real_size);
+                   offset, size, real_size);
         return -EINVAL;
     }
 
-- 
2.39.5


