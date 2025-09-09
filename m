Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FDACA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 16:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1fo-0006VU-Dg; Tue, 09 Sep 2025 12:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fc-0006On-Cj
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uw1fV-0007e5-NE
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 12:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757437087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkLaMxh9bLXpdIL2Z4N+0XG+jnR5jNzoYt6bWjoMlmQ=;
 b=RVi37KDbXS7klF0G1n8KdRQmB1QkJ+DUYtLeh17LCWZO6hb03I0Cw9CYjpL30NMfO5mGkm
 8Zts95NcWbcClqgVCVD9ywPYcLXMie+adcHo/dgbxyS92m3dBT1ocpGju0gkjvEfxLyAoQ
 BLJNwAFZ/N9W7PaccoTM+L8BiZwXswI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-OrDTUahgP-6xmCnBAnoVqQ-1; Tue,
 09 Sep 2025 12:58:06 -0400
X-MC-Unique: OrDTUahgP-6xmCnBAnoVqQ-1
X-Mimecast-MFC-AGG-ID: OrDTUahgP-6xmCnBAnoVqQ_1757437085
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B2BA180057B; Tue,  9 Sep 2025 16:58:05 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 763031800447; Tue,  9 Sep 2025 16:58:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 12/15] hw: declare Xen & microvm machines as secure,
 isapc as insecure
Date: Tue,  9 Sep 2025 17:57:23 +0100
Message-ID: <20250909165726.3814465-13-berrange@redhat.com>
In-Reply-To: <20250909165726.3814465-1-berrange@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/xen-pvh.c           |  1 +
 hw/i386/isapc.c            |  2 +-
 hw/i386/microvm.c          |  1 +
 hw/i386/pc_piix.c          |  4 ++--
 hw/i386/xen/xen-pvh.c      |  1 +
 hw/i386/xen/xen_pvdevice.c |  1 +
 hw/xen/xen-pvh-common.c    |  1 +
 hw/xenpv/xen_machine_pv.c  |  2 +-
 include/hw/boards.h        | 13 ++++++++++++-
 include/hw/i386/pc.h       |  4 +++-
 10 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 1a9eeb01c8..d6b777cb20 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -95,6 +95,7 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
+    .secure = true,
 };
 
 static void xen_arm_machine_register_types(void)
diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 44f4a44672..4564baa5dc 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -186,4 +186,4 @@ static void isapc_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options);
+                  isapc_machine_options, false);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 94d22a232a..c9ff29da0e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -729,6 +729,7 @@ static const TypeInfo microvm_machine_info = {
     .instance_init = microvm_machine_initfn,
     .class_size    = sizeof(MicrovmMachineClass),
     .class_init    = microvm_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index caf8bab68e..168f1821b6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -756,7 +756,7 @@ static void xenfv_machine_4_2_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_machine_4_2_options);
+                  xenfv_machine_4_2_options, true);
 
 static void xenfv_machine_3_1_options(MachineClass *m)
 {
@@ -768,5 +768,5 @@ static void xenfv_machine_3_1_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_machine_3_1_options);
+                  xenfv_machine_3_1_options, true);
 #endif
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 067f73e977..f30cb82962 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -115,6 +115,7 @@ static const TypeInfo xen_pvh_x86_machine_type = {
     .class_init = xen_pvh_machine_class_init,
     .instance_init = xen_pvh_instance_init,
     .instance_size = sizeof(XenPVHx86State),
+    .secure = true,
 };
 
 static void xen_pvh_machine_register_types(void)
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index 87a974ae5a..adf4948b9a 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -139,6 +139,7 @@ static const TypeInfo xen_pv_type_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XenPVDevice),
     .class_init    = xen_pv_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index b93ff80c85..5b1572f531 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -389,6 +389,7 @@ static const TypeInfo xen_pvh_info = {
     .instance_size = sizeof(XenPVHMachineState),
     .class_size = sizeof(XenPVHMachineClass),
     .class_init = xen_pvh_class_init,
+    .secure = true,
 };
 
 static void xen_pvh_register_types(void)
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 99c02492ef..26a77ef007 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -69,4 +69,4 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->default_machine_opts = "accel=xen";
 }
 
-DEFINE_MACHINE("xenpv", xenpv_machine_init)
+DEFINE_SECURE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 61f6942016..bef22d917d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -767,7 +767,7 @@ struct MachineState {
         } \
     } while (0)
 
-#define DEFINE_MACHINE(namestr, machine_initfn) \
+#define DEFINE_MACHINE_IMPL(namestr, machine_initfn, issecure, isinsecure) \
     static void machine_initfn##_class_init(ObjectClass *oc, const void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
@@ -777,6 +777,8 @@ struct MachineState {
         .name       = MACHINE_TYPE_NAME(namestr), \
         .parent     = TYPE_MACHINE, \
         .class_init = machine_initfn##_class_init, \
+        .secure     = issecure, \
+        .insecure   = isinsecure, \
     }; \
     static void machine_initfn##_register_types(void) \
     { \
@@ -784,6 +786,15 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+#define DEFINE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_IMPL(namestr, machine_initfn, false, false)
+
+#define DEFINE_SECURE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_IMPL(namestr, machine_initfn, true, false)
+
+#define DEFINE_INSECURE_MACHINE(namestr, machine_initfn) \
+    DEFINE_MACHINE_IMPL(namestr, machine_initfn, false, true)
+
 extern GlobalProperty hw_compat_10_1[];
 extern const size_t hw_compat_10_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 7c31bf1444..8b76d21825 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -301,7 +301,7 @@ extern const size_t pc_compat_2_7_len;
 extern GlobalProperty pc_compat_2_6[];
 extern const size_t pc_compat_2_6_len;
 
-#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
+#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn, issecure) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
     { \
@@ -313,6 +313,8 @@ extern const size_t pc_compat_2_6_len;
         .name       = namestr TYPE_MACHINE_SUFFIX, \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = pc_machine_##suffix##_class_init, \
+        .secure     = issecure, \
+        .insecure   = !issecure, \
     }; \
     static void pc_machine_init_##suffix(void) \
     { \
-- 
2.50.1


