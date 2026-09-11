Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC083C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Ps-0003vQ-V1; Fri, 11 Sep 2026 10:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mr-0002IS-3T
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Mo-0007ou-Ak
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=123pjNEHzCkIAWUZoFvGci86utv4Qh+kMiJ8nnUWnD4=;
 b=SojDltOaK5My0Z7+F/WSOd9qoFI1kxouPtbQzm5OBIcjgW++KMGTwoTizgoAthX/kWnhg5
 z9Knt3rFVGH/AFY1vXtw1K3vMyzGW8w1AremTKGL/OHt/xajzgS6cIWOsP3+Rvfzbn2cHA
 gWtR9f1UYFVNkBPAZvprdRp/iG/xKng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-u93WP60COd6io4ZK1zb54w-1; Fri,
 11 Sep 2026 10:36:34 -0400
X-MC-Unique: u93WP60COd6io4ZK1zb54w-1
X-Mimecast-MFC-AGG-ID: u93WP60COd6io4ZK1zb54w_1789137393
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00B5918005A0; Fri, 11 Sep 2026 14:36:33 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F055C300022B; Fri, 11 Sep 2026 14:36:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/28] hw: mark secure machines for x86, s390, ppc, arm,
 loonarch, riscv
Date: Fri, 11 Sep 2026 15:36:00 +0100
Message-ID: <20260911143627.2743803-2-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The versioned machine types are typically present for use in
virtualization use cases and can be expected to provide a security
barrier. The only exceptions are the m68k versioned machine types
which are only used with TCG. There are also a handful of other
machines declared secure in docs/system/security.rst, notably
the Xen machine variants and microvm.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/virt.c              | 1 +
 hw/arm/xen-pvh.c           | 1 +
 hw/i386/microvm.c          | 1 +
 hw/i386/pc_piix.c          | 4 ++--
 hw/i386/xen/xen-pvh.c      | 1 +
 hw/loongarch/virt.c        | 2 ++
 hw/ppc/spapr.c             | 1 +
 hw/riscv/virt.c            | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/xen/xen-pvh-common.c    | 1 +
 hw/xenpv/xen_machine_pv.c  | 2 +-
 include/hw/i386/pc.h       | 1 +
 12 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11..e62cd0055b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .secure = true, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index f05956c166..6b85eced1b 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -95,6 +95,7 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
+    .secure = true,
 };
 
 static void xen_arm_machine_register_types(void)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e7adab7d2e..9256b31a60 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -736,6 +736,7 @@ static const TypeInfo microvm_machine_info = {
     .instance_init = microvm_machine_initfn,
     .class_size    = sizeof(MicrovmMachineClass),
     .class_init    = microvm_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a929cc4dec..b6cd6dc5aa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -672,6 +672,6 @@ static void xenfv_machine_4_2_options(MachineClass *m)
     m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
-DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_machine_4_2_options);
+DEFINE_SECURE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
+                         xenfv_machine_4_2_options);
 #endif
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index ab90c83a83..d81575b4c9 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -115,6 +115,7 @@ static const TypeInfo xen_pvh_x86_machine_type = {
     .class_init = xen_pvh_machine_class_init,
     .instance_init = xen_pvh_instance_init,
     .instance_size = sizeof(XenPVHx86State),
+    .secure = true,
 };
 
 static void xen_pvh_machine_register_types(void)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9cc79929a8..0501512a24 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1553,6 +1553,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_LOONGARCH_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .secure = true, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
@@ -1583,6 +1584,7 @@ static const TypeInfo virt_machine_info = {
     .name           = TYPE_LOONGARCH_VIRT_MACHINE,
     .parent         = TYPE_MACHINE,
     .abstract       = true,
+    .secure         = true,
     .instance_size  = sizeof(LoongArchVirtMachineState),
     .class_init     = virt_class_init,
     .instance_init  = virt_initfn,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 20e024907b..4e05e8b71b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4750,6 +4750,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("pseries", __VA_ARGS__),       \
         .parent = TYPE_SPAPR_MACHINE,                                \
         .class_init = MACHINE_VER_SYM(class_init, spapr, __VA_ARGS__), \
+        .secure = true,                                              \
     };                                                               \
     static void MACHINE_VER_SYM(register, spapr, __VA_ARGS__)(void)  \
     {                                                                \
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f3a1cc5ba3..9d146205b3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1200,6 +1200,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .name       = MACHINE_TYPE_NAME("virt"),
     .parent     = TYPE_MACHINE,
     .class_init = virt_machine_class_init,
+    .secure     = true,
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 17266779a6..c9a646be8b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -973,6 +973,7 @@ static const TypeInfo ccw_machine_info = {
         .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
         .parent = TYPE_S390_CCW_MACHINE,                                      \
         .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
+        .secure = true,                                                       \
     };                                                                        \
     static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index cca37202ff..939e85317d 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -504,6 +504,7 @@ static const TypeInfo xen_pvh_info = {
     .name = TYPE_XEN_PVH_MACHINE,
     .parent = TYPE_MACHINE,
     .abstract = true,
+    .secure = true,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_pvh_instance_init,
     .class_size = sizeof(XenPVHMachineClass),
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index c406821c34..e0620a096e 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -69,4 +69,4 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->default_machine_opts = "accel=xen";
 }
 
-DEFINE_MACHINE("xenpv", xenpv_machine_init)
+DEFINE_SECURE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5dc79df17..45b92780d3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -325,6 +325,7 @@ extern const size_t pc_compat_4_1_len;
         .name       = MACHINE_VER_TYPE_NAME(namestr, __VA_ARGS__), \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__), \
+        .secure     = true, \
     }; \
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
-- 
2.55.0


