Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30F5C43458
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 04:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfsNf-00033U-1M; Sat, 04 Jul 2026 00:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfsNb-00032F-6U
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 00:53:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfsNZ-0007hY-DZ
 for qemu-devel@nongnu.org; Sat, 04 Jul 2026 00:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783140803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk3TZcngtC3GBV5X5R9Qkzk3YE0MN12ilj829zBD1wM=;
 b=L3qnDgnAignUpj+bKJm0ISBwy/a8VzGiTRDUAHY/Aqk3pa94Q+N6xrW4Puq5Oqh4WuLxpC
 DhGMv40W+AdUWe3tiG2nD/YzrIO0n7DTgX84DLVLXgF+569vXfN/8duXhVW0F/T+uuLg9m
 i/vUlHtSsMuc5Ltz2fraymjDM9ICZTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-cPd42J_WMFCYtYkrLZX1Tg-1; Sat,
 04 Jul 2026 00:53:21 -0400
X-MC-Unique: cPd42J_WMFCYtYkrLZX1Tg-1
X-Mimecast-MFC-AGG-ID: cPd42J_WMFCYtYkrLZX1Tg_1783140800
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73C7F19560BF; Sat,  4 Jul 2026 04:53:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1528A30030DF; Sat,  4 Jul 2026 04:53:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8F73A1800DFC; Sat, 04 Jul 2026 06:53:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 3/3] igvm: add device tree parameter support
Date: Sat,  4 Jul 2026 06:53:16 +0200
Message-ID: <20260704045316.1624628-4-kraxel@redhat.com>
In-Reply-To: <20260704045316.1624628-1-kraxel@redhat.com>
References: <20260704045316.1624628-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Luigi Leonardi <leonardi@redhat.com>

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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20260626-microvm_device_tree-v6-3-9cd13cf057e2@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c      | 54 ++++++++++++++++++++++++++++++++++++++++++++
 backends/meson.build |  2 +-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index a5a2a4eccc19..80e87fe6029a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -26,6 +26,10 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
+#ifdef CONFIG_FDT
+#include <libfdt.h>
+#endif
+
 #ifndef IGVM_VHT_OPTIONAL_BIT
 #define IGVM_VHT_OPTIONAL_BIT (1U << 31)
 #endif
@@ -121,6 +125,10 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+#ifdef CONFIG_FDT
+static int qigvm_directive_device_tree(QIgvm *ctx, const uint8_t *header_data,
+                                       Error **errp);
+#endif
 
 struct QIGVMHandler {
     IgvmVariableHeaderType type;
@@ -151,6 +159,10 @@ static struct QIGVMHandler handlers[] = {
       qigvm_initialization_guest_policy },
     { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_madt },
+#ifdef CONFIG_FDT
+    { IGVM_VHT_DEVICE_TREE, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_device_tree },
+#endif
 };
 
 static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType raw_type,
@@ -786,6 +798,48 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
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
+    param_entry = qigvm_find_param_entry(ctx,
+                                         param->parameter_area_index, errp);
+    if (param_entry == NULL) {
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
diff --git a/backends/meson.build b/backends/meson.build
index aabfaea5fd8d..8792c58c361f 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -35,7 +35,7 @@ endif
 system_ss.add(when: gio, if_true: files('dbus-vmstate.c'))
 system_ss.add(when: 'CONFIG_SGX', if_true: files('hostmem-epc.c'))
 
-system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c')])
+system_ss.add(when: igvm, if_true: [files('igvm-cfg.c', 'igvm.c'), fdt])
 
 system_ss.add(when: 'CONFIG_SPDM_SOCKET', if_true: files('spdm-socket.c'))
 
-- 
2.55.0


