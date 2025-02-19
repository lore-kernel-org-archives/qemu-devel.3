Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5032CC021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeJH-00037k-Fi; Wed, 19 Feb 2025 02:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeII-0002Fa-PM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:14:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIG-0004yF-Hv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739949286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M488v8strzoU10ZKHxB/mEcFlevFrNsMwLtpHFimZyw=;
 b=gN0+yRHlarvFVBz3BUvS/Pv7KYxNxHK7NJa0vsXLFrHiyNgOifs/G+Yryd34aETLGw6bhu
 9O2OE1NjqkysBHcYwOrvbRzFNHSVNzVEFntoS1fycn3ZnqIBTgkCrsxw7lLfdyThSMx3tO
 d4LtJH+E5GvtK371oCLsh2P9UY6TGiE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-JSj32AoqOZWIfLbK5pOkaA-1; Wed,
 19 Feb 2025 02:14:38 -0500
X-MC-Unique: JSj32AoqOZWIfLbK5pOkaA-1
X-Mimecast-MFC-AGG-ID: JSj32AoqOZWIfLbK5pOkaA_1739949276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AAB11801A16; Wed, 19 Feb 2025 07:14:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.78])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67DAF1800D9D; Wed, 19 Feb 2025 07:14:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3984180093D; Wed, 19 Feb 2025 08:14:31 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 graf@amazon.com, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 01/24] Add support for etc/hardware-info fw_cfg file
Date: Wed, 19 Feb 2025 08:14:03 +0100
Message-ID: <20250219071431.50626-2-kraxel@redhat.com>
In-Reply-To: <20250219071431.50626-1-kraxel@redhat.com>
References: <20250219071431.50626-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/uefi/hardware-info.c         | 33 +++++++++++++++++++++++++++++++
 hw/uefi/meson.build             |  1 +
 3 files changed, 69 insertions(+)
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
index 000000000000..19a83f377ccd
--- /dev/null
+++ b/hw/uefi/hardware-info.c
@@ -0,0 +1,33 @@
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
+        .type.value = type,
+        .size       = infosize,
+    };
+    void *ptr;
+
+    blob = g_realloc(blob, blobsize + sizeof(hdr) + infosize);
+    memcpy(blob + blobsize, &hdr, sizeof(hdr));
+    blobsize += sizeof(hdr);
+    memcpy(blob + blobsize, info, infosize);
+    blobsize += infosize;
+
+    ptr = fw_cfg_modify_file(fw_cfg_find(), "etc/hardware-info", blob, blobsize);
+    g_free(ptr);
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


