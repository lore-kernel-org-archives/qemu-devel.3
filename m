Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AEACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3MU-0001OH-Lw; Mon, 15 Jun 2026 05:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wZ3MT-0001O9-Dg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wZ3MR-00009a-5U
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781514720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IWP4+CzVC5fllNO8vedEBQPG2t07SA087lAOLVLv77A=;
 b=F6BbcdLa0ePtP634LNf1wEXdYizMfpNRwzdMcfkc7UD17lpjQoRvdQFQPsGKW7lYFEHTfg
 lWeuHjsVQ2CQ1d5omzrXdNpukMVX7GbbxiqOEiqVXqq4hgk10dFnV5xSJu3HMoIoWLE0DC
 vqAkxYTlPgH+ek9rcisBqUGxfrYXfs0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-Ho6YVTJNMRCiBMlL0J4M6A-1; Mon, 15 Jun 2026 05:11:59 -0400
X-MC-Unique: Ho6YVTJNMRCiBMlL0J4M6A-1
X-Mimecast-MFC-AGG-ID: Ho6YVTJNMRCiBMlL0J4M6A_1781514718
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490c840efe6so35721435e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781514718; x=1782119518; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IWP4+CzVC5fllNO8vedEBQPG2t07SA087lAOLVLv77A=;
 b=I7Cl49UJLYgGCsEmdeuVe8XPgPzeIruOf/I4LDep+YEJ5TPgfpCIr3j6vo0AW5qbFl
 pZL8vJqGUeH8gGzD+YM7UoTXDD5JFAmyBblBA0kON6QuV8FlHSaPFqDlb2YmXtSxxg4S
 2mif0sz9FkJYgh9Q/6fNpQBy6DbrJuCV698l636PTqhK+6T6ilyHx+NiEcHDZXHFJpjB
 /FXUgES2HDcDLHlhFxXuqGO7WGnHMxelscy75v65+xr5GQBu6PtMI+ziwCHmaNu2J0V4
 +HU0o2C7Q5+q8snnv16Nyy1x1K3HXDaH1VX5iBugUZRWrqPb0KytYHf8oEfBnxFHfFIP
 3c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514718; x=1782119518;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWP4+CzVC5fllNO8vedEBQPG2t07SA087lAOLVLv77A=;
 b=CTHYdX6NWzzI5Cj1e81GN8vreZjxeEN4+JwzyC0aNmNVwkEzdpK2QhLVxq7PM8JqG0
 4S6KLrkeUzcynOnWZ0K4sdPApWRM8EuP5RbGdDANUGqF6OnnStjjhkWn9PzQwjgB3meu
 m32m/sFcYjpGVSLkd7Ut66qur3rY25WP2s1CTuy2mashfcs07HFqxHghv0f1dxs8Zli0
 akk6sF6Oppo3iNNz5nAwLtRibRYSmUOdg4xF7nAUTFM1NF+9lLYgie7hMg6u4vAObk63
 jJUa29EG9rbby2f8R3nVGdVkAd2znGW7Hy1HXIbcwEC2rElmYzAEjQDF/3cX6nyjeLxK
 0WBw==
X-Gm-Message-State: AOJu0Yx5ikwadUJ8v/2NqEZ3jJ5yBrpCwxjOgWx0yR+x0W88IeF/1kLe
 aP8Rb46SBrGCYS3Xh0R46sSvxXxGObwNQGrgRaw8d+mvk2kbO4jNk0MZVfr0umxYTVzUVsJ/Ku+
 EpymT0MhjFaNZKGS+V+oHyPSBezKf6jcql3YDsGgo+zEdyTFgjZgkE5k5
X-Gm-Gg: Acq92OFi4oM/VXiSkoUJCs9ItlEP2mVczMDcXQ02qvu1eH/hxuQa68noX0B6PFKsko6
 uqZgyPGOnxDxuKo+RS8/pXrDNibzaBRbQrT6HdXx9Z/0luyoOb/HypQ/1Kjc6aKZlcALahnmsYg
 uLlJ4fd3qlLUnokkt1P9JtJJIdB0IWF/9vWNMtS2RiMLcyex/LUIkFrSo3FJSxO6OPU92K4FDVK
 D0YfRcHlbKxnoQG9KnsD9ULaBg8WdYrCRfS4FEo7oQKgghrRamNSMC9VPCzAgpYLVThT/XooISz
 gpIeBz5lM2/NVfAKWQaz/jP69lWzCrftTIF4C7mK0sFcJzs+4AX0tS2DoaEsthVVqx0inE1gjf5
 2KCFGGWjb/URBYma9Q/Hyctru8NbDnnnbl3WIhDWqUcti0T8t7ZnWpwtjjucAlUYKkXq4nnlwcK
 SwGn2vrqSdyT0EwpEv
X-Received: by 2002:a05:600c:42d6:b0:490:bf3d:c7de with SMTP id
 5b1f17b1804b1-490ea9dc050mr89700405e9.10.1781514717621; 
 Mon, 15 Jun 2026 02:11:57 -0700 (PDT)
X-Received: by 2002:a05:600c:42d6:b0:490:bf3d:c7de with SMTP id
 5b1f17b1804b1-490ea9dc050mr89700045e9.10.1781514717181; 
 Mon, 15 Jun 2026 02:11:57 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.21.116])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm5184874f8f.6.2026.06.15.02.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 02:11:56 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 15 Jun 2026 11:11:53 +0200
Subject: [PATCH v4] igvm: add device tree parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-microvm_device_tree-v4-1-128a59fd2f78@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OSw6CMBAG4KuQrq2Z0oaHK+9hDKHtVLoATEsaD
 eHuDqwwEpf/PL6ZmUUMHiO7ZDMLmHz040BBnTJmunZ4IPeWMsshL6CAivfehDH1jaVhg80UEDn
 1pJFaaKwKRpvPgM6/NvV2p9z5OI3hvR1JYq3+95LgwEsJValaCwDVNaDt2ulsxp6tYMp3iIBjJ
 CdEOa0USUbV7geRe0QcI5ILbp2ujaM/QH9/sizLBxKG7mpBAQAA
X-Change-ID: 20260608-microvm_device_tree-0263c3b1be86
To: qemu-devel@nongnu.org
Cc: Luigi Leonardi <leonardi@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coconut SVSM, with the upcoming device tree support [1], will use
the IGVM device tree parameter to discover virtio-mmio and ISA serial
devices instead of relying on the fw_cfg interface, which is
QEMU-specific.

The device tree is packed before copying into the IGVM parameter area
to reduce its size, since IGVM files can define tighter memory
constraints for parameter areas. Packing is done in the generic IGVM
backend rather than in per-architecture device tree setup code, so
that each architecture does not need to handle it individually.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
This device tree will be consumed by Coconut SVSM with the upcoming device
tree support [1]. This will allow SVSM to run on a normal CPU
(not AMD SEV-SNP) and execute all its tests using upstream QEMU.

Eventually edk2 will also be able to consume DT via IGVM, but the work
has not started yet.

[1] https://github.com/coconut-svsm/svsm/pull/1006

To: qemu-devel@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Oliver Steffen <osteffen@redhat.com>
---
Changes in v4:
- Using g_memdup2 [Stefano]
- madt directive is now protected by CONFIG_FDT [Stefano]
- Link to v3: https://lore.kernel.org/qemu-devel/20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com

Changes in v3:
- Device tree is packed in igvm core code. [Gerd]
- Dropped microvm patch.
- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com

Changes in v2:
- First patch introduced a shadowed variable, fixed.
- When parameter area is not found return -1.
- Moved `qigvm_directive_device_tree` to backends/igvm.c
- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com
---

Error handling on qigvm_find_param_entry will change once [2] is
merged. I am already using the new approach here.

[2] https://lore.kernel.org/qemu-devel/20260610-igvm_error-v1-1-59d133a69f2f@redhat.com
---
 backends/igvm.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index c347d0c17e..db54f24f7b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,9 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#ifdef CONFIG_FDT
+#include <libfdt.h>
+#endif
 
 /*
  * Some directives are specific to particular confidential computing platforms.
@@ -100,6 +103,10 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+#ifdef CONFIG_FDT
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp);
+#endif
 
 struct QIGVMHandler {
     uint32_t type;
@@ -130,6 +137,10 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+#ifdef CONFIG_FDT
+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_device_tree },
+#endif
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
@@ -752,6 +763,49 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+#ifdef CONFIG_FDT
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    g_autofree void *fdt_packed = NULL;
+    QIgvmParameterData *param_entry;
+    uint32_t fdt_size;
+
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        error_setg(errp, "IGVM: parameter area index %u not found",
+                   param->parameter_area_index);
+        return -1;
+    }
+
+    if (ctx->machine_state->fdt == NULL) {
+        error_setg(errp, "IGVM: device tree not available");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(ctx->machine_state->fdt);
+    fdt_packed = g_memdup2(ctx->machine_state->fdt, fdt_size);
+
+    if (fdt_pack(fdt_packed)) {
+        error_setg(errp, "IGVM: failed to pack device tree");
+        return -1;
+    }
+
+    fdt_size = fdt_totalsize(fdt_packed);
+    if (fdt_size > param_entry->size) {
+        error_setg(errp,
+                   "IGVM: device tree size exceeds parameter area"
+                   " defined in IGVM file");
+        return -1;
+    }
+
+    memcpy(param_entry->data, fdt_packed, fdt_size);
+
+    return 0;
+}
+#endif
+
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data, Error **errp)
 {

---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260608-microvm_device_tree-0263c3b1be86

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


