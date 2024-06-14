Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF57AC27C79
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 12:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI6O6-00046T-SA; Fri, 14 Jun 2024 08:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sI6O5-00045c-3v
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 08:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sI6O3-0002gz-Bj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718369433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O3JeVG3a6wk6T2ZXv9ZVOhX5xEp/Dkl5YOd2GRH0fg4=;
 b=DBuujGc7ItCEAlI16WNOXWq2/9XjCGJtSjcGHMlE6DrGeqKo6kKqOS6fhK6zmdisqIA2ms
 Y9oltJZaT7Mn2Of2N5B/XsDQkyNLkmf8yitNEozrmPjypeXRedlFMz/19rH7l3j+I8u+43
 q3HFo7NF9+HDahfDQDrsSz0/M25h4E8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-oeNWr9tuOXu-vNQc_ctb2w-1; Fri,
 14 Jun 2024 08:50:30 -0400
X-MC-Unique: oeNWr9tuOXu-vNQc_ctb2w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6B4719560BD; Fri, 14 Jun 2024 12:50:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 481853000219; Fri, 14 Jun 2024 12:50:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2] target/s390x: Add a CONFIG switch to disable legacy CPUs
Date: Fri, 14 Jun 2024 14:50:19 +0200
Message-ID: <20240614125019.588928-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

The oldest model that IBM still supports is the z13. Considering
that each generation can "emulate" the previous two generations
in hardware (via the "IBC" feature of the CPUs), this means that
everything that is older than z114/196 is not an officially supported
CPU model anymore. The Linux kernel still support the z10, so if
we also take this into account, everything older than that can
definitely be considered as a legacy CPU model.

For downstream builds of QEMU, we would like to be able to disable
these legacy CPUs in the build. Thus add a CONFIG switch that can be
used to disable them (and old machine types that use them by default).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
v2:
 - Add comment in source code
 - Only consider z9 and older as legacy

 hw/s390x/s390-virtio-ccw.c | 5 +++++
 target/s390x/cpu_models.c  | 9 +++++++++
 target/s390x/Kconfig       | 5 +++++
 3 files changed, 19 insertions(+)

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
index efb508cd2e..a6bafe153e 100644
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
@@ -47,6 +48,13 @@
  * generation 15 one base feature and one optional feature have been deprecated.
  */
 static S390CPUDef s390_cpu_defs[] = {
+    /*
+     * Linux requires at least z10 nowadays, and IBM only supports recent CPUs
+     * (see https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history),
+     * so we consider older CPUs as legacy that can optionally be disabled via
+     * the CONFIG_S390X_LEGACY_CPUS config switch.
+     */
+#ifdef CONFIG_S390X_LEGACY_CPUS
     CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 GA1"),
     CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM zSeries 900 GA2"),
     CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM zSeries 900 GA3"),
@@ -64,6 +72,7 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x2096, 9, 2, 40, 0x00000000U, "z9BC", "IBM System z9 BC GA1"),
     CPUDEF_INIT(0x2094, 9, 3, 40, 0x00000000U, "z9EC.3", "IBM System z9 EC GA3"),
     CPUDEF_INIT(0x2096, 9, 3, 40, 0x00000000U, "z9BC.2", "IBM System z9 BC GA2"),
+#endif
     CPUDEF_INIT(0x2097, 10, 1, 43, 0x00000000U, "z10EC", "IBM System z10 EC GA1"),
     CPUDEF_INIT(0x2097, 10, 2, 43, 0x00000000U, "z10EC.2", "IBM System z10 EC GA2"),
     CPUDEF_INIT(0x2098, 10, 2, 43, 0x00000000U, "z10BC", "IBM System z10 BC GA1"),
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3d0bc3e7f2..cd063f8b64 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -47,6 +47,7 @@
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
+#include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
 
@@ -1126,6 +1127,8 @@ static void ccw_machine_2_12_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2_12, "2.12", false);
 
+#ifdef CONFIG_S390X_LEGACY_CPUS
+
 static void ccw_machine_2_11_instance_options(MachineState *machine)
 {
     static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_11 };
@@ -1272,6 +1275,8 @@ static void ccw_machine_2_4_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2_4, "2.4", false);
 
+#endif
+
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.45.2


