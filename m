Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6144FC021B6
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXA0-0000oN-Ld; Fri, 21 Feb 2025 12:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9y-0000nW-8g; Fri, 21 Feb 2025 12:49:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlX9w-0001at-Pa; Fri, 21 Feb 2025 12:49:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A1ECEFB65;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D68081BB581;
 Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D12FB53F7D; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 02/14] block: Fix leak in send_qmp_error_event
Date: Fri, 21 Feb 2025 20:49:32 +0300
Message-Id: <20250221174949.836197-2-mjt@tls.msk.ru>
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

From: Fabiano Rosas <farosas@suse.de>

ASAN detected a leak when running the ahci-test
/ahci/io/dma/lba28/retry:

Direct leak of 35 byte(s) in 1 object(s) allocated from:
    #0 in malloc
    #1 in __vasprintf_internal
    #2 in vasprintf
    #3 in g_vasprintf
    #4 in g_strdup_vprintf
    #5 in g_strdup_printf
    #6 in object_get_canonical_path ../qom/object.c:2096:19
    #7 in blk_get_attached_dev_id_or_path ../block/block-backend.c:1033:12
    #8 in blk_get_attached_dev_path ../block/block-backend.c:1047:12
    #9 in send_qmp_error_event ../block/block-backend.c:2140:36
    #10 in blk_error_action ../block/block-backend.c:2172:9
    #11 in ide_handle_rw_error ../hw/ide/core.c:875:5
    #12 in ide_dma_cb ../hw/ide/core.c:894:13
    #13 in dma_complete ../system/dma-helpers.c:107:9
    #14 in dma_blk_cb ../system/dma-helpers.c:129:9
    #15 in blk_aio_complete ../block/block-backend.c:1552:9
    #16 in blk_aio_write_entry ../block/block-backend.c:1619:5
    #17 in coroutine_trampoline ../util/coroutine-ucontext.c:175:9

Plug the leak by freeing the device path string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241111145214.8261-1-farosas@suse.de>
[PMD: Use g_autofree]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241111170333.43833-3-philmd@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 23ea425c14d3b89a002e0127b17456eee3102ab7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index 85bcdedcef..0c28091ef1 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2134,10 +2134,10 @@ static void send_qmp_error_event(BlockBackend *blk,
 {
     IoOperationType optype;
     BlockDriverState *bs = blk_bs(blk);
+    g_autofree char *path = blk_get_attached_dev_path(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk),
-                                   blk_get_attached_dev_path(blk),
+    qapi_event_send_block_io_error(blk_name(blk), path,
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
-- 
2.39.5


