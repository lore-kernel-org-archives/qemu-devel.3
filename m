Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4138CF65FA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:39:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLrP-000841-5W; Mon, 26 Jan 2026 07:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vkLrD-0004LW-6l
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vkLr8-0004dy-96
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 07:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769431089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eG76UtdNuETi+vbhjS1uSVE1rLfPeT7xhnfPao0pqK8=;
 b=K7xYttuxhO/yXr+Ml1254PpzCsE+cE4Nre2W9G7IrCH4ZVICUBzASLJ12pDnEsqoK7yV4Q
 zX5nDY6H2oqa6z2V0mv78PksFhXeTQMDLQYD8GoZf+eUqvvNueIwCA/EjgDheHhTiDluVK
 OwnwBxrz6XqUfMHnxuFVpbCZ/KXl1EI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-OWtBDYY_O_W5TNP5adXUNA-1; Mon,
 26 Jan 2026 07:38:06 -0500
X-MC-Unique: OWtBDYY_O_W5TNP5adXUNA-1
X-Mimecast-MFC-AGG-ID: OWtBDYY_O_W5TNP5adXUNA_1769431085
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 526001944F11; Mon, 26 Jan 2026 12:38:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E3A180009E; Mon, 26 Jan 2026 12:38:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 12A8F180060B; Mon, 26 Jan 2026 13:37:56 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 5/5] igvm: move igvm file processing to reset callbacks
Date: Mon, 26 Jan 2026 13:37:55 +0100
Message-ID: <20260126123755.357378-6-kraxel@redhat.com>
In-Reply-To: <20260126123755.357378-1-kraxel@redhat.com>
References: <20260126123755.357378-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Move igvm file processing from machine init to reset callbacks.  With
that the igvm file is properly re-loaded on reset.  Also the loading
happens later in the init process now.  This will simplify future
support for some IGVM parameters which depend on initialization steps
which happen after machine init.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm-cfg.c |  7 +++++++
 hw/i386/pc_piix.c   | 10 ----------
 hw/i386/pc_q35.c    | 10 ----------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 4014062e0f22..f236b523df3b 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -16,6 +16,8 @@
 #include "system/igvm-internal.h"
 #include "system/reset.h"
 #include "qom/object_interfaces.h"
+#include "hw/core/qdev.h"
+#include "hw/core/boards.h"
 
 #include "trace.h"
 
@@ -45,7 +47,12 @@ static void igvm_reset_enter(Object *obj, ResetType type)
 
 static void igvm_reset_hold(Object *obj, ResetType type)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
+    IgvmCfg *igvm = IGVM_CFG(obj);
+
     trace_igvm_reset_hold(type);
+
+    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
 }
 
 static void igvm_reset_exit(Object *obj, ResetType type)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fea158fc4bfe..878db5721b78 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -320,16 +320,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
-
-#if defined(CONFIG_IGVM)
-    /* Apply guest state from IGVM if supplied */
-    if (x86ms->igvm) {
-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
-            g_assert_not_reached();
-        }
-    }
-#endif
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4d6046e47b0d..6e5a23d718f1 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -328,16 +328,6 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
-
-#if defined(CONFIG_IGVM)
-    /* Apply guest state from IGVM if supplied */
-    if (x86ms->igvm) {
-        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
-                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
-            g_assert_not_reached();
-        }
-    }
-#endif
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
-- 
2.52.0


