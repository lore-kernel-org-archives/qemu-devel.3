Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01A8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhwe-00051O-Aj; Tue, 30 Jul 2024 04:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwc-0004tU-B6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwY-0001F2-RV
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722327049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mG2jBgj04xk8zZTpAn2zlZbw7IxC1BxkgwSaG5MXnSU=;
 b=NyesTqLgpCKSpxAnIDNXU/rwOl4qYVYG0Ut6mJ7bMNJiVIRWJkj6nG8v84G4GTD1s7Wf96
 ThHqiQT1r/VsF6CMhaOo7AV9Sf8Imy8P7eSKfdSzWmdnRh4z1XpMIF7/B6dB548r/bzAsV
 pr0eNdXsy+n6iVg4gKtMU1u2+Sc5DNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-a9-VGcDbOEWUkAtlAAG-6Q-1; Tue,
 30 Jul 2024 04:10:47 -0400
X-MC-Unique: a9-VGcDbOEWUkAtlAAG-6Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223DA1955BF2; Tue, 30 Jul 2024 08:10:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98D6019560AE; Tue, 30 Jul 2024 08:10:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB3AE21F4B96; Tue, 30 Jul 2024 10:10:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH 09/18] qapi/machine: Rename CpuS390* to S390Cpu,
 and drop 'prefix'
Date: Tue, 30 Jul 2024 10:10:23 +0200
Message-ID: <20240730081032.1246748-10-armbru@redhat.com>
In-Reply-To: <20240730081032.1246748-1-armbru@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QAPI's 'prefix' feature can make the connection between enumeration
type and its constants less than obvious.  It's best used with
restraint.

CpuS390Entitlement has a 'prefix' to change the generated enumeration
constants' prefix from CPU_S390_POLARIZATION to S390_CPU_POLARIZATION.
Rename the type to S390CpuEntitlement, so that 'prefix' is not needed.

Likewise change CpuS390Polarization to S390CpuPolarization, and
CpuS390State to S390CpuState.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine-common.json            |  5 ++---
 qapi/machine-target.json            | 11 +++++------
 qapi/machine.json                   |  9 ++++-----
 qapi/pragma.json                    |  6 +++---
 include/hw/qdev-properties-system.h |  2 +-
 include/hw/s390x/cpu-topology.h     |  2 +-
 target/s390x/cpu.h                  |  2 +-
 hw/core/qdev-properties-system.c    |  6 +++---
 hw/s390x/cpu-topology.c             |  6 +++---
 9 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index fa6bd71d12..b64e4895cf 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -9,13 +9,12 @@
 ##
 
 ##
-# @CpuS390Entitlement:
+# @S390CpuEntitlement:
 #
 # An enumeration of CPU entitlements that can be assumed by a virtual
 # S390 CPU
 #
 # Since: 8.2
 ##
-{ 'enum': 'CpuS390Entitlement',
-  'prefix': 'S390_CPU_ENTITLEMENT',
+{ 'enum': 'S390CpuEntitlement',
   'data': [ 'auto', 'low', 'medium', 'high' ] }
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index a552e2b0ce..6ee682adad 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -400,15 +400,14 @@
                    'TARGET_RISCV' ] } }
 
 ##
-# @CpuS390Polarization:
+# @S390CpuPolarization:
 #
 # An enumeration of CPU polarization that can be assumed by a virtual
 # S390 CPU
 #
 # Since: 8.2
 ##
-{ 'enum': 'CpuS390Polarization',
-  'prefix': 'S390_CPU_POLARIZATION',
+{ 'enum': 'S390CpuPolarization',
   'data': [ 'horizontal', 'vertical' ],
   'if': 'TARGET_S390X'
 }
@@ -445,7 +444,7 @@
       '*socket-id': 'uint16',
       '*book-id': 'uint16',
       '*drawer-id': 'uint16',
-      '*entitlement': 'CpuS390Entitlement',
+      '*entitlement': 'S390CpuEntitlement',
       '*dedicated': 'bool'
   },
   'features': [ 'unstable' ],
@@ -483,7 +482,7 @@
 #          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
 ##
 { 'event': 'CPU_POLARIZATION_CHANGE',
-  'data': { 'polarization': 'CpuS390Polarization' },
+  'data': { 'polarization': 'S390CpuPolarization' },
   'features': [ 'unstable' ],
   'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
 }
@@ -498,7 +497,7 @@
 # Since: 8.2
 ##
 { 'struct': 'CpuPolarizationInfo',
-  'data': { 'polarization': 'CpuS390Polarization' },
+  'data': { 'polarization': 'S390CpuPolarization' },
   'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
 }
 
diff --git a/qapi/machine.json b/qapi/machine.json
index fcfd249e2d..bdb418696d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -41,15 +41,14 @@
              'x86_64', 'xtensa', 'xtensaeb' ] }
 
 ##
-# @CpuS390State:
+# @S390CpuState:
 #
 # An enumeration of cpu states that can be assumed by a virtual S390
 # CPU
 #
 # Since: 2.12
 ##
-{ 'enum': 'CpuS390State',
-  'prefix': 'S390_CPU_STATE',
+{ 'enum': 'S390CpuState',
   'data': [ 'uninitialized', 'stopped', 'check-stop', 'operating', 'load' ] }
 
 ##
@@ -66,9 +65,9 @@
 # Since: 2.12
 ##
 { 'struct': 'CpuInfoS390',
-  'data': { 'cpu-state': 'CpuS390State',
+  'data': { 'cpu-state': 'S390CpuState',
             '*dedicated': 'bool',
-            '*entitlement': 'CpuS390Entitlement' } }
+            '*entitlement': 'S390CpuEntitlement' } }
 
 ##
 # @CpuInfoFast:
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 59fbe74b8c..beddea5ca4 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -47,9 +47,9 @@
         'BlockdevSnapshotWrapper',
         'BlockdevVmdkAdapterType',
         'ChardevBackendKind',
-        'CpuS390Entitlement',
-        'CpuS390Polarization',
-        'CpuS390State',
+        'S390CpuEntitlement',
+        'S390CpuPolarization',
+        'S390CpuState',
         'CxlCorErrorType',
         'DisplayProtocol',
         'DriveBackupWrapper',
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 438f65389f..cdcc63056e 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -88,7 +88,7 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 
 #define DEFINE_PROP_CPUS390ENTITLEMENT(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_cpus390entitlement, \
-                       CpuS390Entitlement)
+                       S390CpuEntitlement)
 
 #define DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, qdev_prop_iothread_vq_mapping_list, \
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index c064f427e9..a11b1baa77 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -37,7 +37,7 @@ typedef struct S390TopologyEntry {
 
 typedef struct S390Topology {
     uint8_t *cores_per_socket;
-    CpuS390Polarization polarization;
+    S390CpuPolarization polarization;
 } S390Topology;
 
 typedef QTAILQ_HEAD(, S390TopologyEntry) S390TopologyList;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d6b75ad0e0..6cbd77dfdf 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -133,7 +133,7 @@ typedef struct CPUArchState {
     int32_t book_id;
     int32_t drawer_id;
     bool dedicated;
-    CpuS390Entitlement entitlement; /* Used only for vertical polarization */
+    S390CpuEntitlement entitlement; /* Used only for vertical polarization */
     uint64_t cpuid;
 #endif
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..f2db20417a 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1188,12 +1188,12 @@ const PropertyInfo qdev_prop_uuid = {
 
 /* --- s390 cpu entitlement policy --- */
 
-QEMU_BUILD_BUG_ON(sizeof(CpuS390Entitlement) != sizeof(int));
+QEMU_BUILD_BUG_ON(sizeof(S390CpuEntitlement) != sizeof(int));
 
 const PropertyInfo qdev_prop_cpus390entitlement = {
-    .name  = "CpuS390Entitlement",
+    .name  = "S390CpuEntitlement",
     .description = "low/medium (default)/high",
-    .enum_table  = &CpuS390Entitlement_lookup,
+    .enum_table  = &S390CpuEntitlement_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index f16bdf65fa..7d4e1f5472 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -105,7 +105,7 @@ static void s390_topology_init(MachineState *ms)
  */
 void s390_handle_ptf(S390CPU *cpu, uint8_t r1, uintptr_t ra)
 {
-    CpuS390Polarization polarization;
+    S390CpuPolarization polarization;
     CPUS390XState *env = &cpu->env;
     uint64_t reg = env->regs[r1];
     int fc = reg & S390_TOPO_FC_MASK;
@@ -357,7 +357,7 @@ static void s390_change_topology(uint16_t core_id,
                                  bool has_book_id, uint16_t book_id,
                                  bool has_drawer_id, uint16_t drawer_id,
                                  bool has_entitlement,
-                                 CpuS390Entitlement entitlement,
+                                 S390CpuEntitlement entitlement,
                                  bool has_dedicated, bool dedicated,
                                  Error **errp)
 {
@@ -446,7 +446,7 @@ void qmp_set_cpu_topology(uint16_t core,
                           bool has_socket, uint16_t socket,
                           bool has_book, uint16_t book,
                           bool has_drawer, uint16_t drawer,
-                          bool has_entitlement, CpuS390Entitlement entitlement,
+                          bool has_entitlement, S390CpuEntitlement entitlement,
                           bool has_dedicated, bool dedicated,
                           Error **errp)
 {
-- 
2.45.0


