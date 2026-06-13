Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AADCD98D8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJY-00081t-Ix; Sat, 13 Jun 2026 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <9c1c7128135f3bd9c2f62a3f64bb730b6a94ec7a@kylie.crudebyte.com>)
 id 1wYQJT-0007zi-91; Sat, 13 Jun 2026 11:30:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <9c1c7128135f3bd9c2f62a3f64bb730b6a94ec7a@kylie.crudebyte.com>)
 id 1wYQJR-0005L3-UW; Sat, 13 Jun 2026 11:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=sp0WkOTMIe228ItB5HcjR8cQW87AIQqOYxQTM+5MspM=; b=xEjSp
 UnEU9TeO7VvNua2A2XR/XvNgvZoVHRcR2shueNWtb4e50fGFON/7lMlb5Ww6fdpUa8dkGRHhdkl1p
 d5OtQGdLE7tF0+loa8u8ALLu6yj/8CiPl53ANRfK2L3BF+3/g5QMjxDNB87cpuO219Lyf1ahCWdid
 /9oYPg85bEH2tcLSZa/F3ayREhJieSNZ433twLjOac/P5+AmA6K2q6/87FMbxQVAL5neROy075acR
 CmrnwmlnLKDmqrOUWY+YzXd9NkfrycupKvu3kJ4oqQSVo4KushrhsZ19tHCwIwz3++r/ra3qxIGr/
 ynn05+8LUjPIekvLi63hyi3cNxP6yfenYWpWix2S41HoxkA2+QXEbbPJ6iYDg2MQEARekz2/j6X2t
 pfWqc8bAZemj0OfgBNdlLv31eWS2uHNyTZ+3qQ+HR1chHxcG4DK2EBxqIzUdq7KVmeWocjlNYZk4X
 8xDnGGFOqJihZPDdPVRbpONd+SsyQspWOuyqp4/YpcSYJB2XLrw/5XwoyA8JxUvsKFg/7mQXJH0/8
 K+KDGNbfOiMgcpR41nNVivzFr1iiGJmuF3REUmhaJ/II1IjckiZatizAjJV8zUyCXR+fQd+DHq88m
 +Y+F8tWoblqxBBGoZOWLise4RBtetDJoontFgIQWMz61Izdkuwje1Ikt8tlh64=;
Message-ID: <9c1c7128135f3bd9c2f62a3f64bb730b6a94ec7a.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 07/12] hw/9pfs: enable xattr (mockup) support for synth fs
 driver
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=9c1c7128135f3bd9c2f62a3f64bb730b6a94ec7a@kylie.crudebyte.com;
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


