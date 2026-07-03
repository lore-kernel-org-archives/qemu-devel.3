Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3E4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wffrD-0003Xz-0J; Fri, 03 Jul 2026 11:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ebbe1432d1be2316c5c0096476beb0a43dad83df@kylie.crudebyte.com>)
 id 1wffrB-0003Xg-OP; Fri, 03 Jul 2026 11:31:09 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <ebbe1432d1be2316c5c0096476beb0a43dad83df@kylie.crudebyte.com>)
 id 1wffr6-0000Yk-Sd; Fri, 03 Jul 2026 11:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=N4W0LJdQRwD4ETmwmY9B5dDVjq81cfRWAWEOEHWYBXM=; b=uFjOE
 7zr35ZSP3OrT2lygioUZnGC1tsMSfyXLOBv55TokLQNv1vRMNCfLQyhNxpjKBOt4fF4MfXAYUGDQS
 7ov17Pcxk4hlMfhpMzb3Kc83qQSEkpGqvh/8QN20VJBeG4C4Cwcu5Vf96EnvYMaAxcJWFv1LTVVDO
 N4m54OUSltAw9SZ/m+utPjF8FdpY6Jq1cgKmbRv0lCqFfoYlOlMZOcZLgyDqF2Tr7gS7tWoKdqCoh
 M3zT/QtljU6hPJE88ktAMjh9JHXp0NoBXixFO4izt0xMfmK3YNH7RzX0140Tk/1b00NAEPI07R4jw
 AjD7sJPEDembIYatZH2zDw95m4Ufm1TBvlE9ZcPXyNzUbwFE7XlIOzyYvyhaMKkk/lj5CnRgtGESr
 Ec8I8fE9LUaaim9I2L9bUoWuRc8KaBsXGfywFOU1pbnWOvGKbTvEsPGBhDXc/1tZ0Hyg28iRGO3pR
 U4g/A7iOM8Aqd6q3bKEYToY0ImcjJaQuVfu/4QVTV9vCKoZutRE6CbQp2aYAqStxr3QhbCxT4eMkN
 wMNEAfyhqMytDL0XCx0JGAFf7xC8vkTXKG8tHLuQ6bztmVmHmrU/VgU14aDOLXNFbXEffjGP6xZDN
 d+cdWJ2e9yiGt7AYGbnAwfdrSdfiBeIcgPsi2o3BO3CEQkPlkbCFkPKoXKipLA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 3 Jul 2026 17:26:08 +0200
Subject: [PATCH] tests/9p: reduce xattr size to 1k
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <E1wffqw-001Sc8-I9@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=ebbe1432d1be2316c5c0096476beb0a43dad83df@kylie.crudebyte.com;
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

On host systems with ext4 and ea_inode capability not enabled, the max. size
for xattr values is slightly below 4k, which caused the new xattr tests to
fail on such host systems.

Reduce the xattr size for our tests to 1k to prevent them to fail on such
host systems.

Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Fixes: 04a62cdfe8 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index cfd3c02da4..938b5a4717 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -38,11 +38,17 @@
 /*
  * xattr size to be used for xattr tests
  *
- * 64k is the max. xattr size supported by the Linux kernel, However btrfs
- * for instance supports only 16219 bytes. So let's be conservative and
- * just use 8k for the xattr tests.
+ * 64k is the max. xattr size supported by the Linux kernel on high-level VFS
+ * layer. However filesystems impose their own limits:
+ *
+ * - btrfs: 16219 bytes
+ *
+ * - ext4: blocksize - 56 bytes (~4KB) if no ea_inode capability enabled,
+ *         64k if ea_inode enabled
+ *
+ * So let's be conservative and just use 1k for the xattr tests.
  */
-#define TEST_XATTR_SIZE (8 * 1024)
+#define TEST_XATTR_SIZE (1 * 1024)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


