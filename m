Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEDEE7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF8v-0008QN-5a; Tue, 03 Feb 2026 07:04:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8Y-0007le-57
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8W-0007fJ-G3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RmXmcEqa3262D5qIjCHLmaAOTgx6BTKLMY37a3LazWY=;
 b=hQlzr288p3ipuIJdhYZ8cHceVMpaqfil50jpMMJONbJAx7AhbryyO7WQH2YlnVG0BidgB/
 3vjByJ4rPNNwpevcGkOsOJEih5NHzn0i0jGQkshnzPT2z0rMMCWpp5tjTCxxpXOIRvXFIV
 p0dussBkBO8ZYRXo7V/PnG2/zzLmbRw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-mTO2un3sPhi48GGBvGocSQ-1; Tue,
 03 Feb 2026 07:03:58 -0500
X-MC-Unique: mTO2un3sPhi48GGBvGocSQ-1
X-Mimecast-MFC-AGG-ID: mTO2un3sPhi48GGBvGocSQ_1770120237
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D18619560B5; Tue,  3 Feb 2026 12:03:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53EDE1955F16; Tue,  3 Feb 2026 12:03:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 116741800990; Tue, 03 Feb 2026 13:03:44 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/17] igvm: move igvm file processing to reset callbacks
Date: Tue,  3 Feb 2026 13:03:33 +0100
Message-ID: <20260203120343.656961-9-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260126123755.357378-6-kraxel@redhat.com>
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


