Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7C6C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHnuy-0004Z3-E7; Thu, 13 Jun 2024 13:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHnux-0004Yj-CS
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHnus-00035W-OZ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718298434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lPpdJlVEtrVEdrmklULOeuNtP9CViJnCb9oSVnuP3vI=;
 b=NwK8oZojxusL7yUC1YLr7jguUwi+XFflloq6e8q9PqiSYY1GaGXMiwTCBpXJNoAFvweR3L
 t3XAgFjMy9J+jWkOb+hjzOGvbCzEGy53z33prBIpLYcIRXFwM6PVrg9M/QRGUuOYQTVCfy
 Js2AVOQfXm0DaV7psnql8wDhQjl/mSo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-OEtGT5vYPMiG3R4ynIiUpQ-1; Thu,
 13 Jun 2024 13:07:10 -0400
X-MC-Unique: OEtGT5vYPMiG3R4ynIiUpQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3C0419560BB; Thu, 13 Jun 2024 17:07:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.29])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EE8F3000220; Thu, 13 Jun 2024 17:07:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH] target/s390x: Add a CONFIG switch to disable legacy CPUs
Date: Thu, 13 Jun 2024 19:07:02 +0200
Message-ID: <20240613170702.523591-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Old CPU models are not officially supported anymore by IBM, and for
downstream builds of QEMU, we would like to be able to disable these
CPUs in the build. Thus add a CONFIG switch that can be used to
disable these CPUs (and old machine types that use them by default).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 If you're interested, the PDF that can be downloaded from
 https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history
 shows the supported CPUs in a nice diagram

 hw/s390x/s390-virtio-ccw.c | 9 +++++++++
 target/s390x/cpu_models.c  | 3 +++
 target/s390x/Kconfig       | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
index d886be48b4..8a95f2bc3f 100644
--- a/target/s390x/Kconfig
+++ b/target/s390x/Kconfig
@@ -2,3 +2,8 @@ config S390X
     bool
     select PCI
     select S390_FLIC
+
+config S390X_LEGACY_CPUS
+    bool
+    default y
+    depends on S390X
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index efb508cd2e..ffae95dcb3 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "qemu/hw-version.h"
 #include "qemu/qemu-print.h"
+#include CONFIG_DEVICES
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #include "target/s390x/kvm/pv.h"
@@ -47,6 +48,7 @@
  * generation 15 one base feature and one optional feature have been deprecated.
  */
 static S390CPUDef s390_cpu_defs[] = {
+#ifdef CONFIG_S390X_LEGACY_CPUS
     CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 GA1"),
     CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM zSeries 900 GA2"),
     CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM zSeries 900 GA3"),
@@ -78,6 +80,7 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2964, 13, 1, 47, 0x08000000U, "z13", "IBM z13 GA1"),
     CPUDEF_INIT(0x2964, 13, 2, 47, 0x08000000U, "z13.2", "IBM z13 GA2"),
     CPUDEF_INIT(0x2965, 13, 2, 47, 0x08000000U, "z13s", "IBM z13s GA1"),
+#endif
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
     CPUDEF_INIT(0x3906, 14, 2, 47, 0x08000000U, "z14.2", "IBM z14 GA2"),
     CPUDEF_INIT(0x3907, 14, 1, 47, 0x08000000U, "z14ZR1", "IBM z14 Model ZR1 GA1"),
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3d0bc3e7f2..7529d2fba8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -47,6 +47,7 @@
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
+#include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
 
@@ -603,6 +604,8 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
     s390_cpu_restart(S390_CPU(cs));
 }
 
+#ifdef CONFIG_S390X_LEGACY_CPUS
+
 static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
 {
     /* same logic as in sclp.c */
@@ -623,6 +626,8 @@ static ram_addr_t s390_fixup_ram_size(ram_addr_t sz)
     return newsz;
 }
 
+#endif
+
 static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
@@ -989,6 +994,8 @@ static void ccw_machine_6_1_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(6_1, "6.1", false);
 
+#ifdef CONFIG_S390X_LEGACY_CPUS
+
 static void ccw_machine_6_0_instance_options(MachineState *machine)
 {
     static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V6_0 };
@@ -1272,6 +1279,8 @@ static void ccw_machine_2_4_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2_4, "2.4", false);
 
+#endif
+
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.45.2


