Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93390C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxpl-0000vf-3Y; Tue, 25 Feb 2025 11:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpe-0000pk-Jw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpa-0006Uf-7b
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740501048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nlon3lcs2EaVmcEa1E17wkJPm3yExxTTmix/tARvYQ=;
 b=cePvFFTW73AEqh8N92UwsvMkx5yNUd3Jo6HmjQQHcMlDYat0eZrJtQiV02gFQfPPxD2/wg
 IRRob8a+L2Hvq1oFb/Y8jY6BYYYelUeemEA6Cbb5nYVi0WnwyaBEWZbivqs1FpRtEL6Vwa
 nujU8R8cKAAjRYskwH6cVNBeo/MuKIk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-k8bxSjTANQ-xjE4QX4FD1A-1; Tue,
 25 Feb 2025 11:30:42 -0500
X-MC-Unique: k8bxSjTANQ-xjE4QX4FD1A-1
X-Mimecast-MFC-AGG-ID: k8bxSjTANQ-xjE4QX4FD1A_1740501035
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19AB31800878; Tue, 25 Feb 2025 16:30:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB4521800357; Tue, 25 Feb 2025 16:30:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8C75C18000A6; Tue, 25 Feb 2025 17:30:31 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 01/24] Add support for etc/hardware-info fw_cfg file
Date: Tue, 25 Feb 2025 17:30:05 +0100
Message-ID: <20250225163031.1409078-2-kraxel@redhat.com>
In-Reply-To: <20250225163031.1409078-1-kraxel@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

edk2 looks for the etc/hardware-info fw_cfg file to discover hardware
which can not easily be found in other ways.  Entries consist of a
header with hardware type and entry size (HARDWARE_INFO_HEADER),
followed by the actual hardware description (which is type specific).
The file can have multiple entries.

This patch adds the infrastructure to add entries to the file and an
entry struct for simple devices (HARDWARE_INFO_SIMPLE_DEVICE) which have
an mmio address only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/uefi/hardware-info.h | 35 +++++++++++++++++++++++++++++++++
 hw/uefi/hardware-info.c         | 31 +++++++++++++++++++++++++++++
 hw/uefi/meson.build             |  1 +
 3 files changed, 67 insertions(+)
 create mode 100644 include/hw/uefi/hardware-info.h
 create mode 100644 hw/uefi/hardware-info.c
 create mode 100644 hw/uefi/meson.build

diff --git a/include/hw/uefi/hardware-info.h b/include/hw/uefi/hardware-info.h
new file mode 100644
index 000000000000..94c38cff2007
--- /dev/null
+++ b/include/hw/uefi/hardware-info.h
@@ -0,0 +1,35 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * pass hardware information to uefi
+ *
+ * see OvmfPkg/Library/HardwareInfoLib/ in edk2
+ */
+#ifndef QEMU_UEFI_HARDWARE_INFO_H
+#define QEMU_UEFI_HARDWARE_INFO_H
+
+/* data structures */
+
+typedef enum {
+    HardwareInfoTypeUndefined  = 0,
+    HardwareInfoTypeHostBridge = 1,
+    HardwareInfoQemuUefiVars   = 2,
+} HARDWARE_INFO_TYPE;
+
+typedef struct {
+    union {
+        uint64_t            uint64;
+        HARDWARE_INFO_TYPE  value;
+    } type;
+    uint64_t  size;
+} HARDWARE_INFO_HEADER;
+
+typedef struct {
+    uint64_t  mmio_address;
+} HARDWARE_INFO_SIMPLE_DEVICE;
+
+/* qemu functions */
+
+void hardware_info_register(HARDWARE_INFO_TYPE type, void *info, uint64_t size);
+
+#endif /* QEMU_UEFI_HARDWARE_INFO_H */
diff --git a/hw/uefi/hardware-info.c b/hw/uefi/hardware-info.c
new file mode 100644
index 000000000000..930502a4df3a
--- /dev/null
+++ b/hw/uefi/hardware-info.c
@@ -0,0 +1,31 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * pass hardware information to uefi
+ *
+ * see OvmfPkg/Library/HardwareInfoLib/ in edk2
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/nvram/fw_cfg.h"
+#include "hw/uefi/hardware-info.h"
+
+static void      *blob;
+static uint64_t  blobsize;
+
+void hardware_info_register(HARDWARE_INFO_TYPE type, void *info, uint64_t infosize)
+{
+    HARDWARE_INFO_HEADER hdr = {
+        .type.value = cpu_to_le64(type),
+        .size       = cpu_to_le64(infosize),
+    };
+
+    blob = g_realloc(blob, blobsize + sizeof(hdr) + infosize);
+    memcpy(blob + blobsize, &hdr, sizeof(hdr));
+    blobsize += sizeof(hdr);
+    memcpy(blob + blobsize, info, infosize);
+    blobsize += infosize;
+
+    fw_cfg_modify_file(fw_cfg_find(), "etc/hardware-info", blob, blobsize);
+}
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
new file mode 100644
index 000000000000..a8b168941255
--- /dev/null
+++ b/hw/uefi/meson.build
@@ -0,0 +1 @@
+system_ss.add(files('hardware-info.c'))
-- 
2.48.1


