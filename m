Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0097C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKL7O-0005hd-KY; Thu, 20 Jun 2024 12:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7L-0005dm-Pq
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7J-0000yY-Nm
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718902713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNzNYawQLjHz5Qc9d7+ukYddQ2aoH2I1BuC6q69D6Cg=;
 b=gt4U3BDHr7nlYWVFM5IWBddekPcTnHEzmOpdzZrO2iYKrExur4TEelzb1UxtHmPZi3RdGD
 fU9gOVmbDa+73u6zX6/99QfihuRJbsLxk2KdHpndeTYGT4C6l+ivFDXn+LaiE+QS1vCjsS
 +FZJX/FsiGA2J7Tkn8OB0XyMuojUN7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-z-15_16vOqSe30KVMUtR8A-1; Thu,
 20 Jun 2024 12:58:25 -0400
X-MC-Unique: z-15_16vOqSe30KVMUtR8A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9B2D19560B2; Thu, 20 Jun 2024 16:58:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD4FF19560B4; Thu, 20 Jun 2024 16:58:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 03/14] hw/s390x: convert 'ccw' machine definitions to use
 new macros
Date: Thu, 20 Jun 2024 17:57:31 +0100
Message-ID: <20240620165742.1711389-4-berrange@redhat.com>
In-Reply-To: <20240620165742.1711389-1-berrange@redhat.com>
References: <20240620165742.1711389-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This changes the DEFINE_CCW_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number twice in two different formats in the calls
to DEFINE_CCW_MACHINE.

A DEFINE_CCW_MACHINE_AS_LATEST helper is added so that it
is not required to pass 'false' for every single historical
machine type.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 96 +++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3d0bc3e7f2..efed539bc6 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "exec/ram_addr.h"
 #include "exec/confidential-guest-support.h"
+#include "hw/boards.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
@@ -816,35 +817,44 @@ static const TypeInfo ccw_machine_info = {
     },
 };
 
-#define DEFINE_CCW_MACHINE(suffix, verstr, latest)                            \
-    static void ccw_machine_##suffix##_class_init(ObjectClass *oc,            \
-                                                  void *data)                 \
+#define DEFINE_CCW_MACHINE_IMPL(latest, ...)                                  \
+    static void MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__)(                \
+        ObjectClass *oc,                                                      \
+        void *data)                                                           \
     {                                                                         \
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
-        ccw_machine_##suffix##_class_options(mc);                             \
-        mc->desc = "Virtual s390x machine (version " verstr ")";              \
+        MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
+        mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
         if (latest) {                                                         \
             mc->alias = "s390-ccw-virtio";                                    \
             mc->is_default = true;                                            \
         }                                                                     \
     }                                                                         \
-    static void ccw_machine_##suffix##_instance_init(Object *obj)             \
+    static void MACHINE_VER_SYM(instance_init, ccw, __VA_ARGS__)(Object *obj) \
     {                                                                         \
         MachineState *machine = MACHINE(obj);                                 \
-        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(machine));          \
-        ccw_machine_##suffix##_instance_options(machine);                     \
+        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(machine));      \
+        MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(machine);         \
     }                                                                         \
-    static const TypeInfo ccw_machine_##suffix##_info = {                     \
-        .name = MACHINE_TYPE_NAME("s390-ccw-virtio-" verstr),                 \
+    static const TypeInfo MACHINE_VER_SYM(info, ccw, __VA_ARGS__) =           \
+    {                                                                         \
+        .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
         .parent = TYPE_S390_CCW_MACHINE,                                      \
-        .class_init = ccw_machine_##suffix##_class_init,                      \
-        .instance_init = ccw_machine_##suffix##_instance_init,                \
+        .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
+        .instance_init = MACHINE_VER_SYM(instance_init, ccw, __VA_ARGS__),    \
     };                                                                        \
-    static void ccw_machine_register_##suffix(void)                           \
+    static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
-        type_register_static(&ccw_machine_##suffix##_info);                   \
+        type_register_static(&MACHINE_VER_SYM(info, ccw, __VA_ARGS__));       \
     }                                                                         \
-    type_init(ccw_machine_register_##suffix)
+    type_init(MACHINE_VER_SYM(register, ccw, __VA_ARGS__))
+
+#define DEFINE_CCW_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_CCW_MACHINE_IMPL(true, major, minor)
+
+#define DEFINE_CCW_MACHINE(major, minor) \
+    DEFINE_CCW_MACHINE_IMPL(false, major, minor)
+
 
 static void ccw_machine_9_1_instance_options(MachineState *machine)
 {
@@ -853,7 +863,7 @@ static void ccw_machine_9_1_instance_options(MachineState *machine)
 static void ccw_machine_9_1_class_options(MachineClass *mc)
 {
 }
-DEFINE_CCW_MACHINE(9_1, "9.1", true);
+DEFINE_CCW_MACHINE_AS_LATEST(9, 1);
 
 static void ccw_machine_9_0_instance_options(MachineState *machine)
 {
@@ -865,7 +875,7 @@ static void ccw_machine_9_0_class_options(MachineClass *mc)
     ccw_machine_9_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
-DEFINE_CCW_MACHINE(9_0, "9.0", false);
+DEFINE_CCW_MACHINE(9, 0);
 
 static void ccw_machine_8_2_instance_options(MachineState *machine)
 {
@@ -877,7 +887,7 @@ static void ccw_machine_8_2_class_options(MachineClass *mc)
     ccw_machine_9_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_CCW_MACHINE(8_2, "8.2", false);
+DEFINE_CCW_MACHINE(8, 2);
 
 static void ccw_machine_8_1_instance_options(MachineState *machine)
 {
@@ -891,7 +901,7 @@ static void ccw_machine_8_1_class_options(MachineClass *mc)
     mc->smp_props.drawers_supported = false;
     mc->smp_props.books_supported = false;
 }
-DEFINE_CCW_MACHINE(8_1, "8.1", false);
+DEFINE_CCW_MACHINE(8, 1);
 
 static void ccw_machine_8_0_instance_options(MachineState *machine)
 {
@@ -903,7 +913,7 @@ static void ccw_machine_8_0_class_options(MachineClass *mc)
     ccw_machine_8_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
-DEFINE_CCW_MACHINE(8_0, "8.0", false);
+DEFINE_CCW_MACHINE(8, 0);
 
 static void ccw_machine_7_2_instance_options(MachineState *machine)
 {
@@ -915,7 +925,7 @@ static void ccw_machine_7_2_class_options(MachineClass *mc)
     ccw_machine_8_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
-DEFINE_CCW_MACHINE(7_2, "7.2", false);
+DEFINE_CCW_MACHINE(7, 2);
 
 static void ccw_machine_7_1_instance_options(MachineState *machine)
 {
@@ -939,7 +949,7 @@ static void ccw_machine_7_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     s390mc->max_threads = S390_MAX_CPUS;
 }
-DEFINE_CCW_MACHINE(7_1, "7.1", false);
+DEFINE_CCW_MACHINE(7, 1);
 
 static void ccw_machine_7_0_instance_options(MachineState *machine)
 {
@@ -954,7 +964,7 @@ static void ccw_machine_7_0_class_options(MachineClass *mc)
     ccw_machine_7_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
 }
-DEFINE_CCW_MACHINE(7_0, "7.0", false);
+DEFINE_CCW_MACHINE(7, 0);
 
 static void ccw_machine_6_2_instance_options(MachineState *machine)
 {
@@ -969,7 +979,7 @@ static void ccw_machine_6_2_class_options(MachineClass *mc)
     ccw_machine_7_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
 }
-DEFINE_CCW_MACHINE(6_2, "6.2", false);
+DEFINE_CCW_MACHINE(6, 2);
 
 static void ccw_machine_6_1_instance_options(MachineState *machine)
 {
@@ -987,7 +997,7 @@ static void ccw_machine_6_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
     mc->smp_props.prefer_sockets = true;
 }
-DEFINE_CCW_MACHINE(6_1, "6.1", false);
+DEFINE_CCW_MACHINE(6, 1);
 
 static void ccw_machine_6_0_instance_options(MachineState *machine)
 {
@@ -1002,7 +1012,7 @@ static void ccw_machine_6_0_class_options(MachineClass *mc)
     ccw_machine_6_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
-DEFINE_CCW_MACHINE(6_0, "6.0", false);
+DEFINE_CCW_MACHINE(6, 0);
 
 static void ccw_machine_5_2_instance_options(MachineState *machine)
 {
@@ -1014,7 +1024,7 @@ static void ccw_machine_5_2_class_options(MachineClass *mc)
     ccw_machine_6_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
 }
-DEFINE_CCW_MACHINE(5_2, "5.2", false);
+DEFINE_CCW_MACHINE(5, 2);
 
 static void ccw_machine_5_1_instance_options(MachineState *machine)
 {
@@ -1026,7 +1036,7 @@ static void ccw_machine_5_1_class_options(MachineClass *mc)
     ccw_machine_5_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
-DEFINE_CCW_MACHINE(5_1, "5.1", false);
+DEFINE_CCW_MACHINE(5, 1);
 
 static void ccw_machine_5_0_instance_options(MachineState *machine)
 {
@@ -1038,7 +1048,7 @@ static void ccw_machine_5_0_class_options(MachineClass *mc)
     ccw_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
 }
-DEFINE_CCW_MACHINE(5_0, "5.0", false);
+DEFINE_CCW_MACHINE(5, 0);
 
 static void ccw_machine_4_2_instance_options(MachineState *machine)
 {
@@ -1051,7 +1061,7 @@ static void ccw_machine_4_2_class_options(MachineClass *mc)
     mc->fixup_ram_size = s390_fixup_ram_size;
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
-DEFINE_CCW_MACHINE(4_2, "4.2", false);
+DEFINE_CCW_MACHINE(4, 2);
 
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
@@ -1065,7 +1075,7 @@ static void ccw_machine_4_1_class_options(MachineClass *mc)
     ccw_machine_4_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
 }
-DEFINE_CCW_MACHINE(4_1, "4.1", false);
+DEFINE_CCW_MACHINE(4, 1);
 
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
@@ -1079,7 +1089,7 @@ static void ccw_machine_4_0_class_options(MachineClass *mc)
     ccw_machine_4_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
-DEFINE_CCW_MACHINE(4_0, "4.0", false);
+DEFINE_CCW_MACHINE(4, 0);
 
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
@@ -1095,7 +1105,7 @@ static void ccw_machine_3_1_class_options(MachineClass *mc)
     ccw_machine_4_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
 }
-DEFINE_CCW_MACHINE(3_1, "3.1", false);
+DEFINE_CCW_MACHINE(3, 1);
 
 static void ccw_machine_3_0_instance_options(MachineState *machine)
 {
@@ -1110,7 +1120,7 @@ static void ccw_machine_3_0_class_options(MachineClass *mc)
     ccw_machine_3_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
 }
-DEFINE_CCW_MACHINE(3_0, "3.0", false);
+DEFINE_CCW_MACHINE(3, 0);
 
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
@@ -1124,7 +1134,7 @@ static void ccw_machine_2_12_class_options(MachineClass *mc)
     ccw_machine_3_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
 }
-DEFINE_CCW_MACHINE(2_12, "2.12", false);
+DEFINE_CCW_MACHINE(2, 12);
 
 static void ccw_machine_2_11_instance_options(MachineState *machine)
 {
@@ -1145,7 +1155,7 @@ static void ccw_machine_2_11_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_11, "2.11", false);
+DEFINE_CCW_MACHINE(2, 11);
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
@@ -1157,7 +1167,7 @@ static void ccw_machine_2_10_class_options(MachineClass *mc)
     ccw_machine_2_11_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
 }
-DEFINE_CCW_MACHINE(2_10, "2.10", false);
+DEFINE_CCW_MACHINE(2, 10);
 
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
@@ -1181,7 +1191,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     css_migration_enabled = false;
 }
-DEFINE_CCW_MACHINE(2_9, "2.9", false);
+DEFINE_CCW_MACHINE(2, 9);
 
 static void ccw_machine_2_8_instance_options(MachineState *machine)
 {
@@ -1198,7 +1208,7 @@ static void ccw_machine_2_8_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_8, "2.8", false);
+DEFINE_CCW_MACHINE(2, 8);
 
 static void ccw_machine_2_7_instance_options(MachineState *machine)
 {
@@ -1213,7 +1223,7 @@ static void ccw_machine_2_7_class_options(MachineClass *mc)
     ccw_machine_2_8_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
 }
-DEFINE_CCW_MACHINE(2_7, "2.7", false);
+DEFINE_CCW_MACHINE(2, 7);
 
 static void ccw_machine_2_6_instance_options(MachineState *machine)
 {
@@ -1233,7 +1243,7 @@ static void ccw_machine_2_6_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_6, "2.6", false);
+DEFINE_CCW_MACHINE(2, 6);
 
 static void ccw_machine_2_5_instance_options(MachineState *machine)
 {
@@ -1245,7 +1255,7 @@ static void ccw_machine_2_5_class_options(MachineClass *mc)
     ccw_machine_2_6_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len);
 }
-DEFINE_CCW_MACHINE(2_5, "2.5", false);
+DEFINE_CCW_MACHINE(2, 5);
 
 static void ccw_machine_2_4_instance_options(MachineState *machine)
 {
@@ -1270,7 +1280,7 @@ static void ccw_machine_2_4_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_4, "2.4", false);
+DEFINE_CCW_MACHINE(2, 4);
 
 static void ccw_machine_register_types(void)
 {
-- 
2.43.0


