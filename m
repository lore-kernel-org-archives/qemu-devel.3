Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D12DC021B8
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXA0-0000oI-Bm; Fri, 21 Feb 2025 12:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9x-0000nJ-Kb; Fri, 21 Feb 2025 12:49:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9v-0001au-VB; Fri, 21 Feb 2025 12:49:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 321AFEFB66;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE8A11BB582;
 Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D41B453F7F; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 03/14] block-backend: Fix argument order when calling
 'qapi_event_send_block_io_error()'
Date: Fri, 21 Feb 2025 20:49:33 +0300
Message-Id: <20250221174949.836197-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
References: <qemu-stable-9.2.2-20250221204240@cover.tls.msk.ru>
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

From: Peter Krempa <pkrempa@redhat.com>

Commit 7452162adec25c10 introduced 'qom-path' argument to BLOCK_IO_ERROR
event but when the event is instantiated in 'send_qmp_error_event()' the
arguments for 'device' and 'qom_path' in
qapi_event_send_block_io_error() were reversed :

Generated code for sending event:

  void qapi_event_send_block_io_error(const char *qom_path,
                                      const char *device,
                                      const char *node_name,
                                      IoOperationType operation,
                                      [...]

Call inside send_qmp_error_event():

     qapi_event_send_block_io_error(blk_name(blk),
                                    blk_get_attached_dev_path(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    [...]

This results into reporting the QOM path as the device alias and vice
versa which in turn breaks libvirt, which expects the device alias being
either a valid alias or empty (which would make libvirt do the lookup by
node-name instead).

Cc: qemu-stable@nongnu.org
Fixes: 7452162adec2 ("qapi: add qom-path to BLOCK_IO_ERROR event")
Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Message-ID: <09728d784888b38d7a8f09ee5e9e9c542c875e1e.1737973614.git.pkrempa@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 107c551de0d7bc3aa8e926c557b66b9549616f42)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index 0c28091ef1..61b935e3c4 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2137,7 +2137,7 @@ static void send_qmp_error_event(BlockBackend *blk,
     g_autofree char *path = blk_get_attached_dev_path(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk), path,
+    qapi_event_send_block_io_error(path, blk_name(blk),
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.39.5


