Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E2606A884
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxZejT2e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtw-0005wH-AS; Thu, 12 Nov 2026 08:31:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtv-0005vZ-3N
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUts-0002kq-To
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pskDY9UXLntxsMXAn7nnyy6LvDGLXm2iPTQ888sClKk=;
 b=MxZejT2eBKl3m2XPA5jA9TISy4w/h3+xDQcnaqMQ0R/8N3KH3hjPN3qt4wvO1bB2b8vHjP
 7eYFW+5XafbWSvoKl85vTHxQEh8vbjTCjCy52NWq7B5gso/BAo7R8kgfZv4C2RBfgUk5xN
 uZRPgmic752HflP9rNPERl+RcPtS8SI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-MULHDot7OhmvUqF5pf2B_A-1; Thu,
 12 Nov 2026 08:31:32 -0500
X-MC-Unique: MULHDot7OhmvUqF5pf2B_A-1
X-Mimecast-MFC-AGG-ID: MULHDot7OhmvUqF5pf2B_A_1794490291
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 200C01801316; Thu, 12 Nov 2026 13:31:31 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FF21195608A; Thu, 12 Nov 2026 13:31:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 18/48] hw/ppc: convert machines to use AliasedClass interface
Date: Thu, 12 Nov 2026 13:30:24 +0000
Message-ID: <20261112133054.1977618-19-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/ppc/pnv.c   |  7 ++++++-
 hw/ppc/spapr.c | 14 ++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f9478545ff9..a93d2953604 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -62,6 +62,7 @@
 #include "hw/char/serial-isa.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "exec/cpu-common.h"
+#include "qom/object_interfaces.h"
 
 #include <libfdt.h>
 
@@ -3472,6 +3473,10 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
     PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
     XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
     static const char compat[] = "qemu,powernv11\0ibm,powernv";
+    AliasedClass *alc = ALIASED_CLASS(oc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("powernv"), NULL
+    };
 
     static GlobalProperty phb_compat[] = {
         { TYPE_PNV_PHB, "version", "5" },
@@ -3493,7 +3498,7 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
     mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
 
-    mc->alias = "powernv";
+    alc->aliases = aliases;
 
     object_class_property_add_bool(oc, "big-core",
                                    pnv_machine_get_big_core,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8816f607a8f..aa14322222c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -92,6 +92,7 @@
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/ppc/spapr_numa.h"
+#include "qom/object_interfaces.h"
 
 #include <libfdt.h>
 
@@ -4752,9 +4753,18 @@ static const TypeInfo spapr_machine_info = {
     }                                                                \
     type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
 
-#define DEFINE_SPAPR_MACHINE_AS_LATEST(major, minor) \
+#define DEFINE_SPAPR_MACHINE_ALIASES_LATEST(...) \
+    AliasedClass *alc = ALIASED_CLASS(oc); \
+    static const char *const MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)[] = \
+    { \
+        MACHINE_TYPE_NAME("pseries"), \
+        NULL, \
+    }; \
+    alc->aliases = MACHINE_VER_SYM(aliases, virt, __VA_ARGS__)
+
+#define DEFINE_SPAPR_MACHINE_AS_LATEST(major, minor)    \
     DEFINE_SPAPR_MACHINE_IMPL({ \
-            mc->alias = "pseries"; \
+            DEFINE_SPAPR_MACHINE_ALIASES_LATEST(major, minor);   \
             mc->is_default = true; \
         }, major, minor)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
-- 
2.56.1


