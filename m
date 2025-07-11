Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80958C83F1D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKgO-0005mZ-0V; Fri, 11 Jul 2025 16:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdw-0003Kb-Eg; Fri, 11 Jul 2025 16:46:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKds-0003jE-40; Fri, 11 Jul 2025 16:46:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 64908135D02;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 431D623FF3D;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 04/15] hw/core/qdev-properties-system: Add missing
 return in set_drive_helper()
Date: Fri, 11 Jul 2025 23:46:19 +0300
Message-ID: <20250711204632.1804872-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Fiona Ebner <f.ebner@proxmox.com>

Currently, changing the 'drive' property of e.g. a scsi-hd object will
result in an assertion failure if the aio context of the block node
it's replaced with doesn't match the current aio context:

> bdrv_replace_child_noperm: Assertion `bdrv_get_aio_context(old_bs) ==
> bdrv_get_aio_context(new_bs)' failed.

The problematic scenario is already detected, but a 'return' statement
was missing.

Cc: qemu-stable@nongnu.org
Fixes: d1a58c176a ("qdev: allow setting drive property for realized device")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250523070211.280498-1-f.ebner@proxmox.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit eef2dd03f948a512499775043bdc0c5c88d8a2dd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d350789e76..15dacbee6d 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -116,6 +116,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
         if (ctx != bdrv_get_aio_context(bs)) {
             error_setg(errp, "Different aio context is not supported for new "
                        "node");
+            return;
         }
 
         aio_context_acquire(ctx);
-- 
2.47.2


