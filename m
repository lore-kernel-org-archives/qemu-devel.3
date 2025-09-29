Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1767CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H7X-0002pk-K9; Mon, 29 Sep 2025 12:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7J-0002mD-F0
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7E-0002ja-Il
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YwnCMRnzfS6ydXr/4LdmYO6fYAQiLlu8Z8EF//WiayE=;
 b=Pn+YOIRNNgOPvtYUbfAN1ekkZXAkrI6gqmO5PTyNFQnu2rIPcFKXYfGeU5f81Eg6YZJSCO
 H6v12TncwgOXg79eDAoiKY+UXP6zZWjX3YikSNZ1avbdltc1KaXP4Ozam97V2F07gF4RAp
 CmgltaB1thonuQYEiSrEG8qCuzm+1kA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-5iJUJmXMMPS3_HMFmRB2Uw-1; Mon,
 29 Sep 2025 12:52:37 -0400
X-MC-Unique: 5iJUJmXMMPS3_HMFmRB2Uw-1
X-Mimecast-MFC-AGG-ID: 5iJUJmXMMPS3_HMFmRB2Uw_1759164756
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6366B1800357; Mon, 29 Sep 2025 16:52:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFAB81800446; Mon, 29 Sep 2025 16:52:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/32] hw/nvram/aspeed_otp: Add ASPEED OTP memory device model
Date: Mon, 29 Sep 2025 18:51:59 +0200
Message-ID: <20250929165230.797471-2-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Introduce a QEMU device model for ASPEED's One-Time Programmable (OTP)
memory.

This model simulates a word-addressable OTP region used for secure
fuse storage. The OTP memory can operate with an internal memory
buffer.

The OTP model provides a memory-like interface through a dedicated
AddressSpace, allowing other device models (e.g., SBC) to issue
transactions as if accessing a memory-mapped region.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-2-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/nvram/aspeed_otp.h | 33 ++++++++++++
 hw/nvram/aspeed_otp.c         | 99 +++++++++++++++++++++++++++++++++++
 hw/nvram/meson.build          |  4 ++
 3 files changed, 136 insertions(+)
 create mode 100644 include/hw/nvram/aspeed_otp.h
 create mode 100644 hw/nvram/aspeed_otp.c

diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h
new file mode 100644
index 000000000000..375235386079
--- /dev/null
+++ b/include/hw/nvram/aspeed_otp.h
@@ -0,0 +1,33 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_OTP_H
+#define ASPEED_OTP_H
+
+#include "system/memory.h"
+#include "hw/block/block.h"
+#include "system/address-spaces.h"
+
+#define TYPE_ASPEED_OTP "aspeed-otp"
+OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)
+
+typedef struct AspeedOTPState {
+    DeviceState parent_obj;
+
+    BlockBackend *blk;
+
+    uint64_t size;
+
+    AddressSpace as;
+
+    MemoryRegion mmio;
+
+    uint8_t *storage;
+} AspeedOTPState;
+
+#endif /* ASPEED_OTP_H */
diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
new file mode 100644
index 000000000000..e5b7ca96767c
--- /dev/null
+++ b/hw/nvram/aspeed_otp.c
@@ -0,0 +1,99 @@
+/*
+ *  ASPEED OTP (One-Time Programmable) memory
+ *
+ *  Copyright (C) 2025 Aspeed
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "system/block-backend.h"
+#include "hw/qdev-properties.h"
+#include "hw/nvram/aspeed_otp.h"
+
+static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
+{
+    AspeedOTPState *s = opaque;
+    uint64_t val = 0;
+
+    memcpy(&val, s->storage + offset, size);
+
+    return val;
+}
+
+static void aspeed_otp_write(void *opaque, hwaddr otp_addr,
+                                uint64_t val, unsigned size)
+{
+    AspeedOTPState *s = opaque;
+
+    memcpy(s->storage + otp_addr, &val, size);
+}
+
+static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
+{
+    uint32_t *p;
+    int i, num;
+
+        num = s->size / sizeof(uint32_t);
+        p = (uint32_t *)s->storage;
+        for (i = 0; i < num; i++) {
+            p[i] = (i % 2 == 0) ? 0x00000000 : 0xFFFFFFFF;
+        }
+
+    return true;
+}
+
+static const MemoryRegionOps aspeed_otp_ops = {
+    .read = aspeed_otp_read,
+    .write = aspeed_otp_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_otp_realize(DeviceState *dev, Error **errp)
+{
+    AspeedOTPState *s = ASPEED_OTP(dev);
+
+    if (s->size == 0) {
+        error_setg(errp, "aspeed.otp: 'size' property must be set");
+        return;
+    }
+
+    s->storage = blk_blockalign(s->blk, s->size);
+
+    if (!aspeed_otp_init_storage(s, errp)) {
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &aspeed_otp_ops,
+                          s, "aspeed.otp", s->size);
+    address_space_init(&s->as, &s->mmio, NULL);
+}
+
+static const Property aspeed_otp_properties[] = {
+    DEFINE_PROP_UINT64("size", AspeedOTPState, size, 0),
+};
+
+static void aspeed_otp_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = aspeed_otp_realize;
+    device_class_set_props(dc, aspeed_otp_properties);
+}
+
+static const TypeInfo aspeed_otp_info = {
+    .name          = TYPE_ASPEED_OTP,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(AspeedOTPState),
+    .class_init    = aspeed_otp_class_init,
+};
+
+static void aspeed_otp_register_types(void)
+{
+    type_register_static(&aspeed_otp_info);
+}
+
+type_init(aspeed_otp_register_types)
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 10f3639db6ae..b66f23605b77 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -19,3 +19,7 @@ system_ss.add(when: 'CONFIG_XLNX_BBRAM', if_true: files('xlnx-bbram.c'))
 
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_nvram.c'))
 specific_ss.add(when: 'CONFIG_ACPI', if_true: files('fw_cfg-acpi.c'))
+
+system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+  'aspeed_otp.c',
+  ))
\ No newline at end of file
-- 
2.51.0


