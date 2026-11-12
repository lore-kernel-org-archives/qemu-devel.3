Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9D606A331
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F6HZ3z1Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtm-0005so-QP; Thu, 12 Nov 2026 08:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtj-0005qt-0r
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUth-0001xU-Eb
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3eclov/igAnmE0+S7yPMMU+UcIdDryFtvptHE205fI=;
 b=F6HZ3z1Y5CWzUGoa1nEJ+yPEkyf+fQMgZDaMekAAPX/ezpGTIkKr45TSMbIV75mgfebw8y
 +YvfYiw/TJCC8XH4bl+H9VfkDVCLwFiSgUwZIt3lawBSvzGAshl8aoOp6ubb5QaH9QtO4N
 041NZ/AcnfVRnib/qXJttbE7sOGoWt0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-TJo3aDEZMGKgtUY9KBEPxQ-1; Thu,
 12 Nov 2026 08:31:21 -0500
X-MC-Unique: TJo3aDEZMGKgtUY9KBEPxQ-1
X-Mimecast-MFC-AGG-ID: TJo3aDEZMGKgtUY9KBEPxQ_1794490280
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58FED1977687; Thu, 12 Nov 2026 13:31:20 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E08BD195608A; Thu, 12 Nov 2026 13:31:18 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 12/48] hw/arm: convert machines to use AliasedClass interface
Date: Thu, 12 Nov 2026 13:30:18 +0000
Message-ID: <20261112133054.1977618-13-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stop setting 'alias' in the MachineClass and instead set
'aliases' in the AliasedClass.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/aspeed_ast27x0_evb.c |  7 ++++++-
 hw/arm/virt.c               | 12 +++++++++++-
 hw/arm/xlnx-versal-virt.c   |  7 ++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 460c9ff0d2e..9f7d4395114 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -11,6 +11,7 @@
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/sensor/tmp105.h"
+#include "qom/object_interfaces.h"
 
 /* AST2700 evb hardware value */
 /* SCU HW Strap1 */
@@ -53,8 +54,12 @@ static void aspeed_machine_ast2700a2_evb_class_init(ObjectClass *oc,
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(oc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("ast2700-evb"), NULL,
+    };
 
-    mc->alias = "ast2700-evb";
+    alc->aliases = aliases;
     mc->desc = "Aspeed AST2700 A2 EVB (Cortex-A35)";
     amc->soc_name  = "ast2700-a2";
     amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e481d0e548b..60385971b6a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -94,6 +94,7 @@
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
+#include "qom/object_interfaces.h"
 
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
@@ -139,9 +140,18 @@ static void arm_virt_compat_default_set(MachineClass *mc)
     } \
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
+#define DEFINE_VIRT_MACHINE_ALIASES_LATEST(...) \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_TYPE_NAME("virt"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
 #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL({ \
-            mc->alias = "virt"; \
+            DEFINE_VIRT_MACHINE_ALIASES_LATEST(major, minor); \
         }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 4018f2bf7d1..309063d38d8 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -23,6 +23,7 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
+#include "qom/object_interfaces.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE \
     MACHINE_TYPE_NAME("amd-versal-virt-base")
@@ -368,9 +369,13 @@ static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     VersalVirtClass *vvc = XLNX_VERSAL_VIRT_BASE_MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(oc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("xlnx-versal-virt"), NULL,
+    };
 
     mc->desc = "AMD Versal Virtual development board";
-    mc->alias = "xlnx-versal-virt";
+    alc->aliases = aliases;
     vvc->version = VERSAL_VER_VERSAL;
 
     versal_virt_machine_class_init_common(oc);
-- 
2.56.1


