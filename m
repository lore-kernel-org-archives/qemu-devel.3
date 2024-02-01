Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6956C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaE4-0007uK-Rb; Thu, 01 Feb 2024 11:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB7-0002yF-Cn
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:42 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAv-0002Sc-2K
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=m7jMvVP0UpN6AMOjQGouoZqSl/IYWhHtH7lX+Ejn/NM=; b=DWjdfy5ZXbzudbvX+YP/FM+19o
 2771+Es9CzTgc5mc5Ts04xW22aq7n9Nb/U68h1kiISya0OkW6wTJpQCt+zUdpNByvVGbVoEYjTP6v
 p2LW7sjJOZDlm98NYfHKSTkpAl8/7hHctsA9qEvzAHw4Y1ZTpWYbpLvUKJB8T103WfjArrVqK+ivP
 NT33AHf96AMJ6SbCAwFS/zUG77sc8UbbMaAZBrRd6fG5RiLtASHO6ubK2aOQJHATaeC2JH7qOFu8M
 rVe9e07LuJuqUa1r3s2czxc0PL7uVIh8tMG7UA1T/In0j5+hn/cMpnRTHSi8nwiuR6tIzY2g6Za3H
 MIKE38+Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAf-0000000GIdT-2IoD for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IO4-2D6w for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/47] hw/m68k/q800: use qemu_find_nic_info()
Date: Thu,  1 Feb 2024 16:43:58 +0000
Message-ID: <20240201164412.785520-34-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

If a corresponding NIC configuration was found, it will have a MAC address
already assigned, so use that. Else, generate and assign a default one.

Using qemu_find_nic_info() is simpler than the alternative of using
qemu_configure_nic_device() and then having to fetch the "mac" property
as a string and convert it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/q800.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b80a3b6d5f..fa7683bf76 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -48,6 +48,7 @@
 #include "hw/display/macfb.h"
 #include "hw/block/swim.h"
 #include "net/net.h"
+#include "net/util.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
@@ -270,6 +271,8 @@ static void q800_machine_init(MachineState *machine)
     BusState *adb_bus;
     NubusBus *nubus;
     DriveInfo *dinfo;
+    NICInfo *nd;
+    MACAddr mac;
     uint8_t rng_seed[32];
 
     linux_boot = (kernel_filename != NULL);
@@ -370,13 +373,6 @@ static void q800_machine_init(MachineState *machine)
 
     /* MACSONIC */
 
-    if (nb_nics > 1) {
-        error_report("q800 can only have one ethernet interface");
-        exit(1);
-    }
-
-    qemu_check_nic_model(&nd_table[0], "dp83932");
-
     /*
      * MacSonic driver needs an Apple MAC address
      * Valid prefix are:
@@ -386,14 +382,21 @@ static void q800_machine_init(MachineState *machine)
      * 08:00:07 Apple
      * (Q800 use the last one)
      */
-    nd_table[0].macaddr.a[0] = 0x08;
-    nd_table[0].macaddr.a[1] = 0x00;
-    nd_table[0].macaddr.a[2] = 0x07;
-
     object_initialize_child(OBJECT(machine), "dp8393x", &m->dp8393x,
                             TYPE_DP8393X);
     dev = DEVICE(&m->dp8393x);
-    qdev_set_nic_properties(dev, &nd_table[0]);
+    nd = qemu_find_nic_info(TYPE_DP8393X, true, "dp83932");
+    if (nd) {
+        qdev_set_nic_properties(dev, nd);
+        memcpy(mac.a, nd->macaddr.a, sizeof(mac.a));
+    } else {
+        qemu_macaddr_default_if_unset(&mac);
+    }
+    mac.a[0] = 0x08;
+    mac.a[1] = 0x00;
+    mac.a[2] = 0x07;
+    qdev_prop_set_macaddr(dev, "mac", mac.a);
+
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", true);
     object_property_set_link(OBJECT(dev), "dma_mr",
@@ -414,7 +417,7 @@ static void q800_machine_init(MachineState *machine)
     prom = memory_region_get_ram_ptr(&m->dp8393x_prom);
     checksum = 0;
     for (i = 0; i < 6; i++) {
-        prom[i] = revbit8(nd_table[0].macaddr.a[i]);
+        prom[i] = revbit8(mac.a[i]);
         checksum ^= prom[i];
     }
     prom[7] = 0xff - checksum;
-- 
2.43.0


