Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0C5C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKL7X-0005vZ-Hg; Thu, 20 Jun 2024 12:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7V-0005tq-Mu
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7U-00010J-2u
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718902723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edYIAQPsyNTqsiVIVNO+4eC3DTlCCk5x2IKeT2Ev60Q=;
 b=Yle8S3LjfKBY7ywDKrLnU5ea8w/Czq0qTgwTCAuZs2vToiuCp1Ipb3gxYXAnSkP+3C1LQj
 p+xbL/M9VoFHAYdcc+eR3wlWdDntDC16Mej3Leg922nzkmklXDL8OqC/Ab3YXGVN2WsoMA
 mtHrAIZ7U3WtW4zzV93VktmoQhurXlo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517--EY-h88KO6iH_uXLpO2WVQ-1; Thu,
 20 Jun 2024 12:58:40 -0400
X-MC-Unique: -EY-h88KO6iH_uXLpO2WVQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 130B219560B0; Thu, 20 Jun 2024 16:58:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD58B19560AF; Thu, 20 Jun 2024 16:58:29 +0000 (UTC)
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
Subject: [PATCH v2 05/14] hw/m68k: convert 'virt' machine definitions to use
 new macros
Date: Thu, 20 Jun 2024 17:57:33 +0100
Message-ID: <20240620165742.1711389-6-berrange@redhat.com>
In-Reply-To: <20240620165742.1711389-1-berrange@redhat.com>
References: <20240620165742.1711389-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

This changes the DEFINE_VIRT_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

A DEFINE_VIRT_MACHINE_AS_LATEST helper is added so that it
is not required to pass 'false' for every single historical
machine type.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/m68k/virt.c | 51 ++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 09bc9bdfef..cd6ee692f7 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -335,99 +335,106 @@ static void virt_machine_register_types(void)
 
 type_init(virt_machine_register_types)
 
-#define DEFINE_VIRT_MACHINE(major, minor, latest) \
-    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
-                                                    void *data) \
+#define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+    static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
+        ObjectClass *oc, \
+        void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
-        virt_machine_##major##_##minor##_options(mc); \
-        mc->desc = "QEMU " # major "." # minor " M68K Virtual Machine"; \
+        MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
-    static const TypeInfo machvirt_##major##_##minor##_info = { \
-        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
+    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
+    { \
+        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = MACHINE_TYPE_NAME("virt"), \
-        .class_init = virt_##major##_##minor##_class_init, \
+        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
     }; \
-    static void machvirt_machine_##major##_##minor##_init(void) \
+    static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
-        type_register_static(&machvirt_##major##_##minor##_info); \
+        type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
-    type_init(machvirt_machine_##major##_##minor##_init);
+    type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
+
+#define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+#define DEFINE_VIRT_MACHINE(major, minor) \
+    DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
 static void virt_machine_9_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE(9, 1, true)
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
 
 static void virt_machine_9_0_options(MachineClass *mc)
 {
     virt_machine_9_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
-DEFINE_VIRT_MACHINE(9, 0, false)
+DEFINE_VIRT_MACHINE(9, 0)
 
 static void virt_machine_8_2_options(MachineClass *mc)
 {
     virt_machine_9_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_VIRT_MACHINE(8, 2, false)
+DEFINE_VIRT_MACHINE(8, 2)
 
 static void virt_machine_8_1_options(MachineClass *mc)
 {
     virt_machine_8_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
-DEFINE_VIRT_MACHINE(8, 1, false)
+DEFINE_VIRT_MACHINE(8, 1)
 
 static void virt_machine_8_0_options(MachineClass *mc)
 {
     virt_machine_8_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
-DEFINE_VIRT_MACHINE(8, 0, false)
+DEFINE_VIRT_MACHINE(8, 0)
 
 static void virt_machine_7_2_options(MachineClass *mc)
 {
     virt_machine_8_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
-DEFINE_VIRT_MACHINE(7, 2, false)
+DEFINE_VIRT_MACHINE(7, 2)
 
 static void virt_machine_7_1_options(MachineClass *mc)
 {
     virt_machine_7_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
 }
-DEFINE_VIRT_MACHINE(7, 1, false)
+DEFINE_VIRT_MACHINE(7, 1)
 
 static void virt_machine_7_0_options(MachineClass *mc)
 {
     virt_machine_7_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
 }
-DEFINE_VIRT_MACHINE(7, 0, false)
+DEFINE_VIRT_MACHINE(7, 0)
 
 static void virt_machine_6_2_options(MachineClass *mc)
 {
     virt_machine_7_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
 }
-DEFINE_VIRT_MACHINE(6, 2, false)
+DEFINE_VIRT_MACHINE(6, 2)
 
 static void virt_machine_6_1_options(MachineClass *mc)
 {
     virt_machine_6_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
 }
-DEFINE_VIRT_MACHINE(6, 1, false)
+DEFINE_VIRT_MACHINE(6, 1)
 
 static void virt_machine_6_0_options(MachineClass *mc)
 {
     virt_machine_6_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
-DEFINE_VIRT_MACHINE(6, 0, false)
+DEFINE_VIRT_MACHINE(6, 0)
-- 
2.43.0


