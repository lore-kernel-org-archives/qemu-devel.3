Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E80FC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ece-00062N-PL; Thu, 17 Sep 2026 12:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcY-0005uf-1L
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcU-0006ts-QZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fYsuiuQ5aFVUk7Zo7NwjKQO4rNj68Q6fb48JsuCOHU=;
 b=OXiKwZ40nqE9gBBw3vjtvtYgLJYEmZxnlHc0iFRH+m94p5fKpo/20Lt22m84y33V6EkSqp
 pGXSm6Vq3MkG4+/uP3tAuQdtJDpU/eAZEU32t3KcusOr/me0n+b9C8Sfun38DB0oZQTkrO
 mcYWE+AsATLSDV2fn2B1jyPUzQykouk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-q4Q7OAu7MKOQg_fS1q9m7g-1; Thu,
 17 Sep 2026 12:05:50 -0400
X-MC-Unique: q4Q7OAu7MKOQg_fS1q9m7g-1
X-Mimecast-MFC-AGG-ID: q4Q7OAu7MKOQg_fS1q9m7g_1789661149
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6ABE1977012
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:05:49 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC40930002C2; Thu, 17 Sep 2026 16:05:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 14/14] machine: add helpers for declaring secure/insecure
 machine types
Date: Thu, 17 Sep 2026 17:05:25 +0100
Message-ID: <20260917160525.1275388-15-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The current DEFINE_MACHINE macro will declare machine type without any
explicit statement about the security status. As such the machine type
will be treated as implicitly insecure at runtime.

Introduce a new DEFINE_SECURE_MACHINE macro (with variants) that
allow code to make an explicit statement that the machine is treated
as secure. This should primarily be used for versioned machine types
that are intended to be used with KVM, though some others may warrant
a security declaration.

Use of the existing macros marks a machine as insecure, which is the
desired default for most machines servicing emulation use cases.

The same is done for the specialized i386 PC related macros.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/bananapi_m2u.c    |  2 +-
 hw/arm/cubieboard.c      |  2 +-
 hw/arm/imx8mm-evk.c      |  2 +-
 hw/arm/integratorcp.c    |  2 +-
 hw/arm/mcimx7d-sabre.c   |  2 +-
 hw/arm/orangepi.c        |  2 +-
 hw/ppc/pegasos.c         |  3 ++-
 include/hw/core/boards.h | 25 ++++++++++++++++++++-----
 include/hw/i386/pc.h     | 11 ++++++++++-
 9 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 8f59111fd4e..ccf60ba2955 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, NULL)
+                        bpim2u_machine_init, false, false, NULL)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index ae27056938f..e4fef9cd76b 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -133,5 +133,5 @@ static void cubieboard_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
-                        cubieboard_machine_init, false,
+                        cubieboard_machine_init, false, false,
                         NULL)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 8a5737502fd..c3215b11cb9 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -134,5 +134,5 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
-                        imx8mm_evk_machine_init, false,
+                        imx8mm_evk_machine_init, false, false,
                         NULL)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 382ea7850d8..b766edeeee1 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -704,7 +704,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
-                        integratorcp_machine_init, false,
+                        integratorcp_machine_init, false, false,
                         NULL)
 
 static const Property core_properties[] = {
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index db8a62e5f6c..65fdb19c06f 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -86,5 +86,5 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
-                        mcimx7d_sabre_machine_init, false,
+                        mcimx7d_sabre_machine_init, false, false,
                         NULL)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 7a19732f5df..18ed174032b 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -133,5 +133,5 @@ static void orangepi_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
-                        orangepi_machine_init, false,
+                        orangepi_machine_init, false, false,
                         NULL)
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 9d7e279123b..fba2a558905 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -788,7 +788,8 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
 }
 
 DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
-                        pegasos_machine_init, true, (const InterfaceInfo[]) {
+                        pegasos_machine_init, true, false,
+                        (const InterfaceInfo[]) {
                         { TYPE_PPC_VIRTUAL_HYPERVISOR },
                         { TYPE_VOF_MACHINE_IF }, { } })
 
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index dba465efc2c..3b86724cf00 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -514,7 +514,7 @@ struct MachineState {
  */
 
 #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
-                                machine_initfn, ABSTRACT, ifaces...) \
+                                machine_initfn, ABSTRACT, SECURE, ifaces...) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -526,6 +526,7 @@ struct MachineState {
         .class_init = machine_initfn##_class_init, \
         .instance_size = sizeof(InstanceName), \
         .abstract = ABSTRACT, \
+        .secure     = SECURE, \
         .interfaces = ifaces, \
     }; \
     static void machine_initfn##_register_types(void) \
@@ -534,18 +535,32 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+/* Implicitly insecure */
 #define DEFINE_MACHINE(namestr, machine_initfn) \
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, NULL)
+                            false, false, NULL)
 
-#define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...)\
+#define DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...) \
     DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
-                            false, ifaces)
+                            false, false, ifaces)
 
-#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
+#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...)    \
     DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
                                         (const InterfaceInfo[]) { __VA_ARGS__ })
 
+
+#define DEFINE_SECURE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, true, NULL)
+
+#define DEFINE_SECURE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, ifaces...) \
+    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, machine_initfn, \
+                            false, true, ifaces)
+
+#define DEFINE_SECURE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
+    DEFINE_SECURE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
+                                               (const InterfaceInfo[]) { __VA_ARGS__ })
+
 /*
  * Helper for dispatching different macros based on how
  * many __VA_ARGS__ are passed. Supports 1 to 5 variadic
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ac03da97b64..d5dc79df178 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -275,7 +275,7 @@ extern const size_t pc_compat_4_2_len;
 extern GlobalProperty pc_compat_4_1[];
 extern const size_t pc_compat_4_1_len;
 
-#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+#define DEFINE_PC_MACHINE_EXTENDED(suffix, namestr, initfn, optsfn, issecure) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
     { \
@@ -287,6 +287,7 @@ extern const size_t pc_compat_4_1_len;
         .name       = namestr TYPE_MACHINE_SUFFIX, \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = pc_machine_##suffix##_class_init, \
+        .secure     = issecure, \
     }; \
     static void pc_machine_init_##suffix(void) \
     { \
@@ -294,6 +295,14 @@ extern const size_t pc_compat_4_1_len;
     } \
     type_init(pc_machine_init_##suffix)
 
+/* Implicitly insecure */
+#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+    DEFINE_PC_MACHINE_EXTENDED(suffix, namestr, initfn, optsfn, false)
+
+#define DEFINE_SECURE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+    DEFINE_PC_MACHINE_EXTENDED(suffix, namestr, initfn, optsfn, true)
+
+
 #define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, isdefault, malias, ...) \
     static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
         MachineState *machine) \
-- 
2.55.0


