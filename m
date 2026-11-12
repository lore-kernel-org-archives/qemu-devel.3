Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D12606A338
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b4DZjen7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUtj-0005r3-HY; Thu, 12 Nov 2026 08:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtV-0005hf-E7
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtT-000175-1m
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LlneQmjnKE9WT1F9Xz9iD9ar5TKhxHjLqfpr2u0vw64=;
 b=b4DZjen7nd8KgpsELBy3L3AVjEuscnK2jfrhvavseNefX1YUfKjcaUj0nh0BeHwSo2Dcvy
 04USncuqoFQFXExu4IzgvNmScNVxX1afRbl6oapYJCT21m8gcQ3h37wjjrps98e7q9dHhD
 7YX020xQOLLeU6JAiBZFzz/pdBV88d4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-Lt1y-CojPd2KIm9Xi4OdmQ-1; Thu,
 12 Nov 2026 08:31:08 -0500
X-MC-Unique: Lt1y-CojPd2KIm9Xi4OdmQ-1
X-Mimecast-MFC-AGG-ID: Lt1y-CojPd2KIm9Xi4OdmQ_1794490267
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFF0318850FA; Thu, 12 Nov 2026 13:31:07 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B49A01956087; Thu, 12 Nov 2026 13:31:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/48] hw: tweak approach to setting alias in machine macros
Date: Thu, 12 Nov 2026 13:30:11 +0000
Message-ID: <20261112133054.1977618-6-berrange@redhat.com>
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

Currently the pattern for DEFINE_MACHINE macros is to
pass a boolean "latest" flag as a macro parameter, which
is then used in a test. For example

        ...
        if (latest) {
            mc->alias = "s390-ccw-virtio";
            mc->is_default = true;
        }

On the surface this looks fine, but this is actually taking a
build time static characteristic of the machine type and turning
it into a runtime tunable that only ever has a single code path.
ie the macro code expands to:

        if (true) {
            mc->alias = "s390-ccw-virtio";
            mc->is_default = true;
        }

or

        if (false) {
            mc->alias = "s390-ccw-virtio";
            mc->is_default = true;
        }

The compiler should optimize out the condition, but we can do
do this explicitly by passing the desired extra initializers
to the macro directly.

This makes the macro definition a bit more verbose, but it will
facilitate forthcoming changes that require more complex
initialization to be added to the class initializer methods.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c              | 12 ++++++------
 hw/i386/pc_piix.c          |  7 +++++--
 hw/i386/pc_q35.c           | 10 +++++++---
 hw/loongarch/virt.c        | 14 +++++++-------
 hw/m68k/virt.c             | 12 ++++++------
 hw/ppc/spapr.c             | 19 +++++++------------
 hw/s390x/s390-virtio-ccw.c | 14 +++++++-------
 include/hw/core/boards.h   | 18 +++++++++---------
 include/hw/i386/pc.h       |  5 ++---
 9 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b11f7e328c..e481d0e548b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -112,7 +112,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
                      arm_virt_compat_defaults_len);
 }
 
-#define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+#define DEFINE_VIRT_MACHINE_IMPL(classinitextra, ...) \
     static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
         ObjectClass *oc, \
         const void *data) \
@@ -122,9 +122,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
-        if (latest) { \
-            mc->alias = "virt"; \
-        } \
+        classinitextra \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
@@ -142,9 +140,11 @@ static void arm_virt_compat_default_set(MachineClass *mc)
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
 #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+    DEFINE_VIRT_MACHINE_IMPL({ \
+            mc->alias = "virt"; \
+        }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
-    DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
+    DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
 
 
 /* Number of external interrupt lines to configure the GIC with */
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 446590e4e55..88356bf0d77 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -363,10 +363,13 @@ static void pc_i440fx_init(MachineState *machine)
 }
 
 #define DEFINE_I440FX_MACHINE(major, minor) \
-    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, false, NULL, major, minor);
+    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, \
+                          {}, major, minor);
 
 #define DEFINE_I440FX_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, true, "pc", major, minor);
+    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, { \
+            mc->is_default = true; mc->alias = "pc"; \
+        }, major, minor);
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c3ce9c56492..9c6459b934d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -339,13 +339,17 @@ static void pc_q35_machine_set_wdat(Object *o, bool value, Error **errp)
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
-    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor);
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, {}, \
+                          major, minor);
 
 #define DEFINE_Q35_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, "q35", major, minor);
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, { \
+            mc->alias = "q35"; \
+        }, major, minor);
 
 #define DEFINE_Q35_MACHINE_BUGFIX(major, minor, micro) \
-    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, false, NULL, major, minor, micro);
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, {}, \
+                          major, minor, micro);
 
 static void pc_q35_machine_options(MachineClass *m)
 {
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index c67dad095ab..30a2ab6be9d 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1521,7 +1521,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
                                           "for PCI MMIO");
 }
 
-#define DEFINE_VIRT_MACHINE_VERSION(latest, ...) \
+#define DEFINE_VIRT_MACHINE_VERSION(classinitextra, ...) \
     static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
         ObjectClass *oc, \
         const void *data) \
@@ -1530,10 +1530,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " LoongArch Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
-        if (latest) { \
-            mc->alias = "virt"; \
-            mc->is_default = true; \
-        } \
+        classinitextra \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
@@ -1550,9 +1547,12 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
 #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_VIRT_MACHINE_VERSION(true, major, minor)
+    DEFINE_VIRT_MACHINE_VERSION({ \
+            mc->alias = "virt"; \
+            mc->is_default = true; \
+        }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
-    DEFINE_VIRT_MACHINE_VERSION(false, major, minor)
+    DEFINE_VIRT_MACHINE_VERSION({}, major, minor)
 
 static void virt_instance_finalize(Object *obj)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index e52546e4fab..2418bd3d503 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -337,7 +337,7 @@ static void virt_machine_register_types(void)
 
 type_init(virt_machine_register_types)
 
-#define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+#define DEFINE_VIRT_MACHINE_IMPL(classinitextra, ...) \
     static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
         ObjectClass *oc, \
         const void *data) \
@@ -346,9 +346,7 @@ type_init(virt_machine_register_types)
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
-        if (latest) { \
-            mc->alias = "virt"; \
-        } \
+        classinitextra \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
@@ -365,9 +363,11 @@ type_init(virt_machine_register_types)
     type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
 
 #define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+    DEFINE_VIRT_MACHINE_IMPL({ \
+            mc->alias = "virt"; \
+    }, major, minor)
 #define DEFINE_VIRT_MACHINE(major, minor) \
-    DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
+    DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
 
 static void virt_machine_11_2_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 54e3cc3cbe4..8816f607a8f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4728,13 +4728,7 @@ static const TypeInfo spapr_machine_info = {
     },
 };
 
-static void spapr_machine_latest_class_options(MachineClass *mc)
-{
-    mc->alias = "pseries";
-    mc->is_default = true;
-}
-
-#define DEFINE_SPAPR_MACHINE_IMPL(latest, ...)                       \
+#define DEFINE_SPAPR_MACHINE_IMPL(classinitextra, ...)               \
     static void MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__)(     \
         ObjectClass *oc,                                             \
         const void *data)                                            \
@@ -4742,9 +4736,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
         MachineClass *mc = MACHINE_CLASS(oc);                        \
         MACHINE_VER_SYM(class_options, spapr, __VA_ARGS__)(mc);      \
         MACHINE_VER_DEPRECATION(__VA_ARGS__);                        \
-        if (latest) {                                                \
-            spapr_machine_latest_class_options(mc);                  \
-        }                                                            \
+        classinitextra;                                              \
     }                                                                \
     static const TypeInfo MACHINE_VER_SYM(info, spapr, __VA_ARGS__) = \
     {                                                                \
@@ -4761,9 +4753,12 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     type_init(MACHINE_VER_SYM(register, spapr, __VA_ARGS__))
 
 #define DEFINE_SPAPR_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_SPAPR_MACHINE_IMPL(true, major, minor)
+    DEFINE_SPAPR_MACHINE_IMPL({ \
+            mc->alias = "pseries"; \
+            mc->is_default = true; \
+        }, major, minor)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
-    DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
+    DEFINE_SPAPR_MACHINE_IMPL({}, major, minor)
 
 /*
  * pseries-11.2
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 214445c018f..eafb603f3e0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -961,7 +961,7 @@ static const TypeInfo ccw_machine_info = {
     },
 };
 
-#define DEFINE_CCW_MACHINE_IMPL(latest, ...)                                  \
+#define DEFINE_CCW_MACHINE_IMPL(classinitextra, ...)                          \
     static void MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__)(MachineState *mach) \
     {                                                                         \
         MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(mach);            \
@@ -979,10 +979,7 @@ static const TypeInfo ccw_machine_info = {
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
         mc->init = MACHINE_VER_SYM(mach_init, ccw, __VA_ARGS__);              \
         MACHINE_VER_DEPRECATION(__VA_ARGS__);                                 \
-        if (latest) {                                                         \
-            mc->alias = "s390-ccw-virtio";                                    \
-            mc->is_default = true;                                            \
-        }                                                                     \
+        classinitextra                                                        \
     }                                                                         \
     static const TypeInfo MACHINE_VER_SYM(info, ccw, __VA_ARGS__) =           \
     {                                                                         \
@@ -999,10 +996,13 @@ static const TypeInfo ccw_machine_info = {
     type_init(MACHINE_VER_SYM(register, ccw, __VA_ARGS__))
 
 #define DEFINE_CCW_MACHINE_AS_LATEST(major, minor) \
-    DEFINE_CCW_MACHINE_IMPL(true, major, minor)
+    DEFINE_CCW_MACHINE_IMPL({ \
+            mc->alias = "s390-ccw-virtio"; \
+            mc->is_default = true; \
+        }, major, minor)
 
 #define DEFINE_CCW_MACHINE(major, minor) \
-    DEFINE_CCW_MACHINE_IMPL(false, major, minor)
+    DEFINE_CCW_MACHINE_IMPL({}, major, minor)
 
 
 static void ccw_machine_11_2_instance_options(MachineState *machine)
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d0e4ad98201..a25c627c0c8 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -464,7 +464,7 @@ struct MachineState {
  * For example, a macro that can be used to define versioned
  * 'virt' machine types would look like:
  *
- *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+ *  #define DEFINE_VIRT_MACHINE_IMPL(classinitextra, ...) \
  *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
  *          ObjectClass *oc, \
  *          void *data) \
@@ -473,9 +473,7 @@ struct MachineState {
  *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
  *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
  *          MACHINE_VER_DEPRECATION(__VA_ARGS__); \
- *          if (latest) { \
- *              mc->alias = "virt"; \
- *          } \
+ *          classinitextra \
  *      } \
  *      static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = { \
  *          .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
@@ -494,23 +492,25 @@ struct MachineState {
  *
  *  // Normal 2 digit, marked as latest e.g. 'virt-9.0'
  *  #define DEFINE_VIRT_MACHINE_LATEST(major, minor) \
- *      DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+ *      DEFINE_VIRT_MACHINE_IMPL({ \
+ *              mc->alias = "virt"; \
+ *          }, major, minor)
  *
  *  // Normal 2 digit e.g. 'virt-9.0'
  *  #define DEFINE_VIRT_MACHINE(major, minor) \
- *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
+ *      DEFINE_VIRT_MACHINE_IMPL({}, major, minor)
  *
  *  // Bugfix 3 digit e.g. 'virt-9.0.1'
  *  #define DEFINE_VIRT_MACHINE_BUGFIX(major, minor, micro) \
- *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro)
+ *      DEFINE_VIRT_MACHINE_IMPL({}, major, minor, micro)
  *
  *  // Tagged 2 digit e.g. 'virt-9.0-extra'
  *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, tag) \
- *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, _, tag)
+ *      DEFINE_VIRT_MACHINE_IMPL({}, major, minor, _, tag)
  *
  *  // Tagged bugfix 2 digit e.g. 'virt-9.0.1-extra'
  *  #define DEFINE_VIRT_MACHINE_TAGGED(major, minor, micro, tag) \
- *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor, micro, _, tag)
+ *      DEFINE_VIRT_MACHINE_IMPL({}, major, minor, micro, _, tag)
  */
 
 #define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 844ae835784..190d966c7bb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -308,7 +308,7 @@ extern const size_t pc_compat_4_1_len;
     DEFINE_PC_MACHINE_EXTENDED(suffix, namestr, initfn, optsfn, true)
 
 
-#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, isdefault, malias, ...) \
+#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, classinitextra, ...) \
     static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
         MachineState *machine) \
     { \
@@ -322,8 +322,7 @@ extern const size_t pc_compat_4_1_len;
         MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
         mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
-        mc->is_default = isdefault; \
-        mc->alias = malias; \
+        classinitextra \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
     { \
-- 
2.56.1


