Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EDBD2127F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Onw-0005zu-FP; Thu, 17 Oct 2024 07:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oli-0003zk-AP
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Olf-0005th-B0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IVGurtBGi8qhjzGkNNt7nsmDooihiywp/qK+DexAPCQ=;
 b=frZjlwygi6o6sWmmtbKeT3JIKSpQSMCH0UiL6NEw7SHFd0COvpPp/pLiFOqJp3/QFPbZhh
 MzgR29kdDyIfU41gwrXEAAGqxn6UUY7FnAdEJhyg/kBTGC3P7jDje3xQQAfB+enkdpNYVn
 CsB3pd+PwPotwMuc9UyTCaj4sRYDBqU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-DQiRn-jYOSeI5i4m_lo7gA-1; Thu,
 17 Oct 2024 07:34:05 -0400
X-MC-Unique: DQiRn-jYOSeI5i4m_lo7gA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E0F195608F
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82DD419560A2; Thu, 17 Oct 2024 11:34:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 09/31] hw: adapt to new import path for qobject data type
 headers
Date: Thu, 17 Oct 2024 12:33:21 +0100
Message-ID: <20241017113344.883424-10-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/aspeed_ast27x0.c         | 2 +-
 hw/arm/mps2-tz.c                | 2 +-
 hw/arm/mps2.c                   | 2 +-
 hw/arm/mps3r.c                  | 2 +-
 hw/arm/sbsa-ref.c               | 2 +-
 hw/arm/stellaris.c              | 2 +-
 hw/arm/vexpress.c               | 2 +-
 hw/arm/virt.c                   | 2 +-
 hw/arm/xlnx-versal.c            | 2 +-
 hw/block/xen-block.c            | 4 ++--
 hw/core/machine-hmp-cmds.c      | 2 +-
 hw/core/machine-qmp-cmds.c      | 2 +-
 hw/core/qdev-properties.c       | 2 +-
 hw/core/qdev.c                  | 2 +-
 hw/hyperv/hv-balloon.c          | 2 +-
 hw/i386/acpi-build.c            | 2 +-
 hw/i386/kvm/xen_evtchn.c        | 2 +-
 hw/i386/monitor.c               | 2 +-
 hw/i386/pc.c                    | 2 +-
 hw/net/rocker/rocker-hmp-cmds.c | 2 +-
 hw/net/virtio-net.c             | 2 +-
 hw/net/xen_nic.c                | 2 +-
 hw/pci/pci-hmp-cmds.c           | 2 +-
 hw/ppc/pegasos2.c               | 2 +-
 hw/ppc/spapr_drc.c              | 2 +-
 hw/rx/rx62n.c                   | 2 +-
 hw/s390x/s390-skeys.c           | 2 +-
 hw/s390x/s390-stattrib.c        | 2 +-
 hw/usb/xen-usb.c                | 4 ++--
 hw/vfio/pci.c                   | 2 +-
 hw/virtio/virtio-hmp-cmds.c     | 2 +-
 hw/virtio/virtio-qmp.c          | 4 ++--
 hw/xen/xen-bus.c                | 2 +-
 33 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 761ee11657..63686de02b 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -19,7 +19,7 @@
 #include "net/net.h"
 #include "sysemu/sysemu.h"
 #include "hw/intc/arm_gicv3.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/log.h"
 
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8edf57a66d..63aef4922c 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -48,7 +48,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..d023c231f5 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -48,7 +48,7 @@
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "hw/qdev-clock.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 typedef enum MPS2FPGAType {
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d55a6564c..33e6432988 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..062c9db229 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -48,7 +48,7 @@
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..4540c47d45 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -31,7 +31,7 @@
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "ui/input.h"
 
 #define GPIO_A 0
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index de815d84cc..47ccb2db8a 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -42,7 +42,7 @@
 #include "hw/cpu/a15mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b2b991d97..eb7fd0cd97 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -70,7 +70,7 @@
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "standard-headers/linux/input.h"
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 3a1e2e29f1..346e09a3f3 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -12,7 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "net/net.h"
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index aed1d5c330..5c5a5fec19 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -16,8 +16,8 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qom/object_interfaces.h"
 #include "hw/block/xen_blkif.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 8701f00cc7..e68a0545f1 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..8e51a9031c 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 86a583574d..2d11e62925 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,7 +2,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index db36f54d91..be4cdd9667 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 3a9ef07691..76ed893ce8 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -26,7 +26,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-types-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4967aa7459..58cb77bcad 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -22,7 +22,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 #include "acpi-build.h"
 #include "acpi-common.h"
 #include "qemu/bitmap.h"
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 07bd0c9ab8..2a963a87df 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -20,7 +20,7 @@
 #include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qom/object.h"
 #include "exec/target_page.h"
 #include "exec/address-spaces.h"
diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
index 1ebd3564bf..1921e4d52e 100644
--- a/hw/i386/monitor.c
+++ b/hw/i386/monitor.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "hw/i386/x86.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2047633e4c..35650c9ed3 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -44,7 +44,7 @@
 #include "sysemu/reset.h"
 #include "kvm/kvm_i386.h"
 #include "hw/xen/xen.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "acpi-build.h"
diff --git a/hw/net/rocker/rocker-hmp-cmds.c b/hw/net/rocker/rocker-hmp-cmds.c
index 197c6e28dc..df40991f6d 100644
--- a/hw/net/rocker/rocker-hmp-cmds.c
+++ b/hw/net/rocker/rocker-hmp-cmds.c
@@ -18,7 +18,7 @@
 #include "monitor/monitor.h"
 #include "net/eth.h"
 #include "qapi/qapi-commands-rocker.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 void hmp_rocker(Monitor *mon, const QDict *qdict)
 {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index fb84d142ee..c0a4adfe8e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,7 +26,7 @@
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qemu/config-file.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "net/announce.h"
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 89487b49ba..31866bd1fb 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -24,7 +24,7 @@
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 
 #include <sys/socket.h>
diff --git a/hw/pci/pci-hmp-cmds.c b/hw/pci/pci-hmp-cmds.c
index fdfe44435c..a5f6483cc3 100644
--- a/hw/pci/pci-hmp-cmds.c
+++ b/hw/pci/pci-hmp-cmds.c
@@ -20,7 +20,7 @@
 #include "monitor/monitor.h"
 #include "pci-internal.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qapi-commands-pci.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ff4a00c34..086f6c0673 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -32,7 +32,7 @@
 #include "kvm_ppc.h"
 #include "exec/address-spaces.h"
 #include "qom/qom-qobject.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "trace.h"
 #include "qemu/datadir.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d..4b3dec6e50 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 560f53a58a..dd2122a562 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qom/object.h"
 
 /*
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index bf22d6863e..1b89092fe7 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -16,7 +16,7 @@
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/memory_mapping.h"
 #include "exec/address-spaces.h"
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index c4259b5327..b9116cd5f5 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "cpu.h"
 
 /* 512KiB cover 2GB of guest memory */
diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 13901625c0..13b065b0fa 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,8 +30,8 @@
 #include "hw/xen/xen-legacy-backend.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 #include "hw/xen/interface/io/usbif.h"
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c3..4b9ec847ab 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -30,7 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 477c97dea2..7d8677bcf0 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -9,7 +9,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-virtio.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 static void hmp_virtio_dump_protocols(Monitor *mon,
diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index cccc6fe761..fbcb7c57e8 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -15,8 +15,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-virtio.h"
 #include "qapi/qapi-commands-qom.h"
-#include "qapi/qmp/qobject.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qobject.h"
+#include "qobject/qjson.h"
 #include "hw/virtio/vhost-user.h"
 
 #include "standard-headers/linux/virtio_ids.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 95b207ac8b..c4e2b3c2f9 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -18,7 +18,7 @@
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/sysemu.h"
 #include "net/net.h"
 #include "trace.h"
-- 
2.46.0


