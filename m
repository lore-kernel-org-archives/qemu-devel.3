Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA39CCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxPe-0002xX-Hz; Tue, 09 Jun 2026 10:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8025c35d04272eebb6d9d04ad607ca5c3c2c046a@kylie.crudebyte.com>)
 id 1wWxPY-0002td-Ov; Tue, 09 Jun 2026 10:26:38 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8025c35d04272eebb6d9d04ad607ca5c3c2c046a@kylie.crudebyte.com>)
 id 1wWxPW-0001Sm-KO; Tue, 09 Jun 2026 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=sp0WkOTMIe228ItB5HcjR8cQW87AIQqOYxQTM+5MspM=; b=oO6A7
 VpgnhRxK1zorSTb3GEeCUgKdYJ0EX1TmfbDVSD1EROdVisX68vhAlPxV9lXw65C99XgSnrqlOc1Vp
 gLw/XloS/tndUgPtk1iXnM9UMDXlkRg4wpLIOoxmZqMKKtEdv5lNDCyG7DWARTlsRle4kQ1ZwmTrM
 dgLFi3PDTBkU3MDZmA7tNX8L+mA7SM+EPfLOxuJT7u8FBl7wEHe/OQWecrhviAqXDQwMzDsboxXKL
 OlZNAc0bCCW2ZcrbmA7CNxq5TJaMLeHpCZWn2FjzmiL/7vx1Anv05OB1yrkkL9/KxjPeYsywx6XQf
 +NSzF6RHR1lzn5je/KEhVwtmai2+/NCcar177ud4CVK+n+mocilYFpDYxQHtdSrMU9EwPGVSeQdCL
 /DKJpZCAJHavzM5rluiKr4sSPSS86k119VY35qKoTCTQV+vrtP/mdEQYwzXJui8SdLtyRaV4T+aIy
 w3MbLwbGEG294bYRgg/eZSYr3bQoDb0O+B9AIZv81in/p5WoGJkXet/EE25lBxsnL/i43qXr+HxzM
 UG1yGCNbGeD6L2emQZGpcwjkmognsgdX6mbhg1s9Cygem541W53i+F7boCVYXE7x2lZx+MEskbtbu
 QD5wnv6Ra7qjE5BUIw2zeJpsRko5207WscOXXEGRBm1HOlNZQB2b7e9Z9aabLY=;
Message-ID: <8025c35d04272eebb6d9d04ad607ca5c3c2c046a.1781012549.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 09 Jun 2026 15:47:06 +0200
Subject: [PATCH v2 07/12] hw/9pfs: enable xattr (mockup) support for synth fs
 driver
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=8025c35d04272eebb6d9d04ad607ca5c3c2c046a@kylie.crudebyte.com;
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


