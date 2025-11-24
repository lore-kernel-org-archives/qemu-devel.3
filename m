Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE1CFD31C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 07:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNQeG-0001Wc-UJ; Mon, 24 Nov 2025 02:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNQdz-0001Sv-DP
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNQdu-00033u-Ke
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 02:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763967942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXyyS4csK7oZMaBE0F9TQbLBAxGjG5ZMck9UujdsTK8=;
 b=cPyFATx5S5WqXv0A9Mjwrc4+pcz1t/LQ/6rYHAEVMqjjQ/cVoevBGl3vZGHUhQW31jtxpn
 NsZGhwMPl0zyUAz2XFZxi1O3txIeUqdD0+D6A6MOS/RNlTHoRvMJn5hfTabKBKynootKOO
 /fotIzN/+VpN1tvRJGeogenDIevTiWc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-w0iZxHMhO8KSrRoYYjTtBQ-1; Mon,
 24 Nov 2025 02:05:38 -0500
X-MC-Unique: w0iZxHMhO8KSrRoYYjTtBQ-1
X-Mimecast-MFC-AGG-ID: w0iZxHMhO8KSrRoYYjTtBQ_1763967937
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE275180034F; Mon, 24 Nov 2025 07:05:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88CE418004A3; Mon, 24 Nov 2025 07:05:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nabih Estefan <nabihestefan@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/3] hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port
 capabilities and enable MSI to support hotplug
Date: Mon, 24 Nov 2025 08:05:24 +0100
Message-ID: <20251124070524.240618-4-clg@redhat.com>
In-Reply-To: <20251124070524.240618-1-clg@redhat.com>
References: <20251124070524.240618-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

This patch updates the ASPEED PCIe Root Port capability layout and interrupt
handling to match the hardware-defined capability structure as documented in
the PCI Express Controller (PCIE) chapter of the ASPEED SoC datasheet.

The following capability offsets and fields are now aligned with the actual
hardware implementation (validated using EVB config-space dumps via
'lspci -s <bdf> -vvv'):

- Added MSI capability at offset 0x50 and enabled 1-vector MSI support
- Added PCI Express Capability structure at offset 0x80
- Added Secondary Subsystem Vendor ID (SSVID) at offset 0xC0
- Added AER capability at offset 0x100
- Implemented aer_vector() callback and MSI init/uninit hooks
- Updated Root Port SSID to 0x1150 to reflect the platform default

Enabling MSI is required for proper PCIe Hotplug event signaling. This change
improves correctness and ensures QEMU Root Port behavior matches the behavior
of ASPEED hardware and downstream kernel expectations.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: 2af56518fa91 ("hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make address configurable")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251121050108.3407445-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/pci-host/aspeed_pcie.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index f7593444fc42..1fc2c617727d 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -68,6 +68,38 @@ static const TypeInfo aspeed_pcie_root_device_info = {
  * PCIe Root Port
  */
 
+#define ASPEED_PCIE_ROOT_PORT_MSI_OFFSET        0x50
+#define ASPEED_PCIE_ROOT_PORT_MSI_NR_VECTOR     1
+#define ASPEED_PCIE_ROOT_PORT_SSVID_OFFSET      0xC0
+#define ASPEED_PCIE_ROOT_PORT_EXP_OFFSET        0x80
+#define ASPEED_PCIE_ROOT_PORT_AER_OFFSET        0x100
+
+static uint8_t aspeed_pcie_root_port_aer_vector(const PCIDevice *d)
+{
+    return 0;
+}
+
+static int aspeed_pcie_root_port_interrupts_init(PCIDevice *d, Error **errp)
+{
+    int rc;
+
+    rc = msi_init(d, ASPEED_PCIE_ROOT_PORT_MSI_OFFSET,
+                  ASPEED_PCIE_ROOT_PORT_MSI_NR_VECTOR,
+                  PCI_MSI_FLAGS_MASKBIT & PCI_MSI_FLAGS_64BIT,
+                  PCI_MSI_FLAGS_MASKBIT & PCI_MSI_FLAGS_MASKBIT,
+                  errp);
+    if (rc < 0) {
+        assert(rc == -ENOTSUP);
+    }
+
+    return rc;
+}
+
+static void aspeed_pcie_root_port_interrupts_uninit(PCIDevice *d)
+{
+    msi_uninit(d);
+}
+
 static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
                                              const void *data)
 {
@@ -80,7 +112,13 @@ static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
     k->device_id = 0x1150;
     dc->user_creatable = true;
 
-    rpc->aer_offset = 0x100;
+    rpc->aer_vector = aspeed_pcie_root_port_aer_vector;
+    rpc->interrupts_init = aspeed_pcie_root_port_interrupts_init;
+    rpc->interrupts_uninit = aspeed_pcie_root_port_interrupts_uninit;
+    rpc->exp_offset = ASPEED_PCIE_ROOT_PORT_EXP_OFFSET;
+    rpc->aer_offset = ASPEED_PCIE_ROOT_PORT_AER_OFFSET;
+    rpc->ssvid_offset = ASPEED_PCIE_ROOT_PORT_SSVID_OFFSET;
+    rpc->ssid = 0x1150;
 }
 
 static const TypeInfo aspeed_pcie_root_port_info = {
-- 
2.51.1


