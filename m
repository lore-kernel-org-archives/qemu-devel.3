Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E32C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkVoV-0007P2-TA; Wed, 13 Mar 2024 17:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=aoFc=KT=redhat.com=clg@ozlabs.org>)
 id 1rkVoN-0007LY-6V
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:07:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=aoFc=KT=redhat.com=clg@ozlabs.org>)
 id 1rkVoI-00030e-8s
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:06:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tw33K0p0Jz4wck;
 Thu, 14 Mar 2024 08:06:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw33G1ytLz4wcR;
 Thu, 14 Mar 2024 08:06:33 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/iommufd: Fix memory leak
Date: Wed, 13 Mar 2024 22:06:28 +0100
Message-ID: <20240313210628.786224-1-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=aoFc=KT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Make sure variable contents is freed if scanf fails.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Fixes: CID 1540007
Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a75a785e90c64cdcc4d10c88d217801b3f536cdb..cd549e0ee8573e75772c51cc96153762a6bc8550 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -152,9 +152,8 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 
     if (sscanf(contents, "%d:%d", &major, &minor) != 2) {
         error_setg(errp, "failed to get major:minor for \"%s\"", vfio_dev_path);
-        goto out_free_dev_path;
+        goto out_free_contents;
     }
-    g_free(contents);
     vfio_devt = makedev(major, minor);
 
     vfio_path = g_strdup_printf("/dev/vfio/devices/%s", dent->d_name);
@@ -166,6 +165,8 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     trace_iommufd_cdev_getfd(vfio_path, ret);
     g_free(vfio_path);
 
+out_free_contents:
+    g_free(contents);
 out_free_dev_path:
     g_free(vfio_dev_path);
 out_close_dir:
-- 
2.44.0


