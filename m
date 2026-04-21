Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B636AF8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFE55-0004xd-Oa; Tue, 21 Apr 2026 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE47-0004gr-FS
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wFE3t-0007NK-Mx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 12:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776789296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xxmDsZWnKddXny8XJXbH9vxYlCbZpDY9wqE6WUzTjA=;
 b=Iwxo+whJWCRsQemcZW+fLtJBqn0fO7wpNHt9B2AkQ0tMsc8+YwllmtZ2bTLRlTfnBvPHcg
 VAuQ3Zp4w/3QsHWAspiV1W/Up+65hhTVNEFfahGkT2dPKlt7IknZDs/t55VhAE+jgYcvSt
 hfHx86hIPVn3PyWD7i4K4tS4eKPeXRQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-PIrh7glOMqiQvKw1fUIX0A-1; Tue,
 21 Apr 2026 12:34:51 -0400
X-MC-Unique: PIrh7glOMqiQvKw1fUIX0A-1
X-Mimecast-MFC-AGG-ID: PIrh7glOMqiQvKw1fUIX0A_1776789289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0354C1800451; Tue, 21 Apr 2026 16:34:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A52119560AB; Tue, 21 Apr 2026 16:34:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/14] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
Date: Tue, 21 Apr 2026 18:34:27 +0200
Message-ID: <20260421163438.3447280-4-clg@redhat.com>
In-Reply-To: <20260421163438.3447280-1-clg@redhat.com>
References: <20260421163438.3447280-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Add stubs for needed functions.

vfio_pci_hot_reset_info must be forwarded declared on non linux platforms:
In file included from ../hw/vfio/igd-stubs.c:9:
../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
  265 |                                     struct vfio_pci_hot_reset_info **info_p);
      |

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260318174733.1717643-4-pierrick.bouvier@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |  2 ++
 hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
 hw/vfio/pci-quirks.c |  5 -----
 hw/vfio/meson.build  |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 hw/vfio/igd-stubs.c

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d6495d7f297513605db363dcdb3dd9b8dfb29a8d..c3a1f53d35004c914854c97d6e3608e4a20b121a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -258,6 +258,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+struct vfio_pci_hot_reset_info;
+
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
 void vfio_pci_post_reset(VFIOPCIDevice *vdev);
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
new file mode 100644
index 0000000000000000000000000000000000000000..f7687d909125c2233e76f7e6d03aa90f38c3b89f
--- /dev/null
+++ b/hw/vfio/igd-stubs.c
@@ -0,0 +1,20 @@
+/*
+ * IGD device quirks stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qmp/qerror.h"
+#include "pci.h"
+#include "pci-quirks.h"
+
+void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
+{
+    return;
+}
+
+bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
+{
+    return true;
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 66e02b15a481aa810cca6fac465e64639673e970..bccf31751fd47387fd89110e27b695e5c822d5c4 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -11,7 +11,6 @@
  */
 
 #include "qemu/osdep.h"
-#include CONFIG_DEVICES
 #include "exec/memop.h"
 #include "qemu/units.h"
 #include "qemu/log.h"
@@ -1128,11 +1127,9 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
  */
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-#ifdef CONFIG_VFIO_IGD
     if (!vfio_probe_igd_config_quirk(vdev, errp)) {
         return false;
     }
-#endif
     return true;
 }
 
@@ -1179,9 +1176,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
     vfio_probe_nvidia_bar5_quirk(vdev, nr);
     vfio_probe_nvidia_bar0_quirk(vdev, nr);
     vfio_probe_rtl8168_bar2_quirk(vdev, nr);
-#ifdef CONFIG_VFIO_IGD
     vfio_probe_igd_bar0_quirk(vdev, nr);
-#endif
 }
 
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index f2a7728d3d00f70b6a6f6e3ea24749e6246b5c43..6c00a7f51bbe79d8e45d828a11d4deecf21512be 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -17,6 +17,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
+stub_ss.add(files('igd-stubs.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
-- 
2.53.0


