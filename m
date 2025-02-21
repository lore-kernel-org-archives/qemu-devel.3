Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9466EC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXA8-0000vr-R5; Fri, 21 Feb 2025 12:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXA5-0000sM-BU; Fri, 21 Feb 2025 12:50:05 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tlXA3-0001ci-Cq; Fri, 21 Feb 2025 12:50:05 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 46365EFB6A;
 Fri, 21 Feb 2025 20:49:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EF74A1BB586;
 Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DE83B53F87; Fri, 21 Feb 2025 20:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.2 07/14] vfio/iommufd: Fix SIGSEV in iommufd_cdev_attach()
Date: Fri, 21 Feb 2025 20:49:37 +0300
Message-Id: <20250221174949.836197-7-mjt@tls.msk.ru>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When iommufd_cdev_ram_block_discard_disable() fails for whatever reason,
errp should be set or else SIGSEV is triggered in vfio_realize() when
error_prepend() is called.

By this chance, use the same error message for both legacy and iommufd
backend.

Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20250116102307.260849-1-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 7b3d5b84cbd742356a1afc6b0fa489d0663f235d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index e7bece4ea1..a60c899dc6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -515,8 +515,8 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         } else {
             ret = iommufd_cdev_ram_block_discard_disable(true);
             if (ret) {
-                error_setg(errp,
-                              "Cannot set discarding of RAM broken (%d)", ret);
+                error_setg_errno(errp, -ret,
+                                 "Cannot set discarding of RAM broken");
                 goto err_discard_disable;
             }
             goto found_container;
@@ -544,6 +544,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     ret = iommufd_cdev_ram_block_discard_disable(true);
     if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
         goto err_discard_disable;
     }
 
-- 
2.39.5


