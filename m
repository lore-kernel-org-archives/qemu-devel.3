Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F75CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdEQ-0004I5-W9; Fri, 21 Nov 2025 21:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdEL-00040X-ME; Fri, 21 Nov 2025 21:20:05 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdDT-0003sW-Az; Fri, 21 Nov 2025 21:20:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E854D16C6F1;
 Fri, 21 Nov 2025 16:51:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 49FCB32198E;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 25/76] block: remove 'detached-header' option from
 opts after use
Date: Fri, 21 Nov 2025 16:51:03 +0300
Message-ID: <20251121135201.1114964-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The code for creating LUKS devices references a 'detached-header'
option in the QemuOpts  data, but does not consume (remove) the
option.

Thus when the code later tries to convert the remaining unused
QemuOpts into a QCryptoBlockCreateOptions struct, an error is
reported by the QAPI code that 'detached-header' is not a valid
field.

This fixes a regression caused by

  commit e818c01ae6e7c54c7019baaf307be59d99ce80b9
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Mon Feb 19 15:12:59 2024 +0000

    qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header

which identified that the QAPI field was unused, but failed to
realize the QemuOpts -> QCryptoBlockCreateOptions conversion
was seeing the left-over 'detached-header' option which had not
been removed from QemuOpts.

This problem was identified by the 'luks-detached-header' I/O
test, but unfortunately I/O tests are not run regularly for the
LUKS format.

Fixes: e818c01ae6e7c54c7019baaf307be59d99ce80b9
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250919103810.1513109-1-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 6eda39a87f4fda78befa4085e3644e4440afc1dd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/crypto.c b/block/crypto.c
index d4226cc68a..17b4749a1e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -792,7 +792,7 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     char *buf = NULL;
     int64_t size;
     bool detached_hdr =
-        qemu_opt_get_bool(opts, "detached-header", false);
+        qemu_opt_get_bool_del(opts, "detached-header", false);
     unsigned int cflags = 0;
     int ret;
     Error *local_err = NULL;
-- 
2.47.3


