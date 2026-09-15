Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15686C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NYK-0007A2-6p; Tue, 15 Sep 2026 03:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NXo-00072a-Ex
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6NXl-0003oa-JL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789457128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkJz1cYDdFso2M4EC6WyUDTgDDtbZALxBDNguIzm3gQ=;
 b=JXrhWtktR5wzTNxyE0cz5MWSdigDW2CwSiPuaINjW0jGaC6OpXWmQxdYI+t6S3TyMEZZsb
 u9q92nHyyRJdwitqeZ6oYuzS1SPpzgIg56URmrIP2Wb3WDApp7A7SB9Vmq5sbCpCKN1Z3j
 Lr6ZunlLE6X1Yc7TEq1z42OKg+MP7Cw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-k-uySmeyP_CApmYZ9vT9Xw-1; Tue,
 15 Sep 2026 03:25:24 -0400
X-MC-Unique: k-uySmeyP_CApmYZ9vT9Xw-1
X-Mimecast-MFC-AGG-ID: k-uySmeyP_CApmYZ9vT9Xw_1789457123
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9965019541B0; Tue, 15 Sep 2026 07:25:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.23])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45C13418; Tue, 15 Sep 2026 07:25:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/2] hw/pci-bridge: Add x-speed and x-width properties to
 xio3130-downstream
Date: Tue, 15 Sep 2026 09:25:06 +0200
Message-ID: <20260915072507.1230187-2-clg@redhat.com>
In-Reply-To: <20260915072507.1230187-1-clg@redhat.com>
References: <20260915072507.1230187-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Default to 16GT/s x32 for new machine types and add compat entries
for <= 11.1 to preserve the old 2.5GT/s x1 behavior.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4409
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/core/machine.c                  | 2 ++
 hw/pci-bridge/xio3130_downstream.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8939ae16666c2d9454d93eccc5ca44e231b1ef6d..b702a61f7335a30841164279e73432bc238ee5e5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,8 @@
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
+    { "xio3130-downstream", "x-speed", "2_5" },
+    { "xio3130-downstream", "x-width", "1" },
 };
 const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
 
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 0c3fed3053b0e2b2ee2cf703c5f9e1f33ec1ff5b..0669223159a43f334d7ed46bec347de1bb8420ca 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -25,6 +25,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
@@ -137,6 +138,10 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
 static const Property xio3130_downstream_props[] = {
     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
+    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
+                                speed, PCIE_LINK_SPEED_16),
+    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
+                                width, PCIE_LINK_WIDTH_32),
 };
 
 static const VMStateDescription vmstate_xio3130_downstream = {
-- 
2.55.0


