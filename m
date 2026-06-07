Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1335CD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHm7-0000GQ-4M; Sun, 07 Jun 2026 13:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f3e89e13712ecc50b1f68e5fb10b66f48a8a1cee@kylie.crudebyte.com>)
 id 1wWHm5-0000FZ-1J; Sun, 07 Jun 2026 13:59:05 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f3e89e13712ecc50b1f68e5fb10b66f48a8a1cee@kylie.crudebyte.com>)
 id 1wWHm3-0004Ix-NO; Sun, 07 Jun 2026 13:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=sp0WkOTMIe228ItB5HcjR8cQW87AIQqOYxQTM+5MspM=; b=muydM
 NCbVMLTz1yEMv9Rjx7Yc4jxK/vtoeaa6DNBpSu/WRxeQTEas1R1DQokxoE5wXOM0OsnBFYQp0ZTJh
 WvS9xiGhoMvfMx+2X7vemgQuQ5WO7R1ZnS52ck8sCL/vEUjkF9tY8Wmuy7mXHVSHr7DHIgdM9oJ1d
 FkpwMoVSexbwpUI3J8BftlaqLa5lofisg1bqcuUTOzx+rLAY6RxsdefNXNeMohK/EVYwnPAc6F8js
 77xUiT/SqQeUHMU7uDwjXCaGniQXvEzMmJBlpXxUjR6qVR+tJetQsX20gEbeC4dVBmEXTA60864Fp
 Wsht5UaggSKH1P0VnkYfjfGN9rT6yM+LnNj90BMrlsunyuh/M4AQKnRxALmd+vHmAjcvsRa0YHD+c
 u9iWnZnL4H1Z0KHI6v4wXn1Bi3sAgXS6TDGTH4NSrz2XFCOYpotIbs6T0wkUjAnLq9lE/4+RRblZY
 8oqc8s135SVhwXiL4P+0tilPjqW7YstAKqtpdzvQlGdVhXsIMEJI2ob32xq/d8zTzqOwhSG0nhxzo
 WQR0xwN27wKN0hFL38FehP7f9aH7Fpp/8HDLHGm0apVdFZQ2Tent9AmWcrie6drMIPCnjeoCnrUvc
 Bjc8vsypnpv0ei6qpCITbBbRAF/tnOQxonBN+9UE+iBo57XbXyrtvLEBnOfalo=;
Message-ID: <f3e89e13712ecc50b1f68e5fb10b66f48a8a1cee.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 07/12] hw/9pfs: enable xattr (mockup) support for synth fs
 driver
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=f3e89e13712ecc50b1f68e5fb10b66f48a8a1cee@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The synth backend is used for testing only. Enable xattr operations
by making lsetxattr and lremovexattr callbacks to return success
result.

They are still actually not doing anything, they just pretend to be
working to prevent 9pfs server from erroring out on xattr requests.

This allows the subsequent test case patches to verify xattr FID
limit enforcement.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-synth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 322dc3bb69..4b0732e093 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -477,15 +477,15 @@ static int synth_lsetxattr(FsContext *ctx, V9fsPath *path,
                                 const char *name, void *value,
                                 size_t size, int flags)
 {
-    errno = ENOTSUP;
-    return -1;
+    /* pretend it worked */
+    return 0;
 }
 
 static int synth_lremovexattr(FsContext *ctx,
                                    V9fsPath *path, const char *name)
 {
-    errno = ENOTSUP;
-    return -1;
+    /* pretend it worked */
+    return 0;
 }
 
 static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
-- 
2.47.3


