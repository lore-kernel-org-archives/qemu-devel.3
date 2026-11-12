Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03F606A332
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VXu1xvs0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUvU-0007RG-5k; Thu, 12 Nov 2026 08:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuO-0006OK-EM
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUuM-0004pW-JS
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+jvx/g9Fv4ivlDi/r8tlnWzF5Ht/Ad9ZDkBPfoHn90=;
 b=VXu1xvs0/MmjuJt/K6GEPnFgZ6aELnototyPYnBMLf2ycr+qu0906lwWDqODllyhpC6IMW
 X/KOp9tEQyDG3WlnzQLgbT6rHM2Y/uTpXcYaxJO7sp1c1nxE74N2k9TwWVVaSXhy0gIUBq
 D/6H33RoDyRgEH44yvqcnFRhNqmT0q4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-FDXSZJvOO8mdlGcQFRaBrA-1; Thu,
 12 Nov 2026 08:32:02 -0500
X-MC-Unique: FDXSZJvOO8mdlGcQFRaBrA-1
X-Mimecast-MFC-AGG-ID: FDXSZJvOO8mdlGcQFRaBrA_1794490321
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CC3C1800634; Thu, 12 Nov 2026 13:32:01 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D62F21956089; Thu, 12 Nov 2026 13:31:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 35/48] qapi: report target compatibility for machine types
Date: Thu, 12 Nov 2026 13:30:41 +0000
Message-ID: <20261112133054.1977618-36-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a 'targets' field to MachineInfo which is populated with
the list of targets a machine is declard to be compatible
with.

To avoid reporting redundant information for the traditional
per-target emulator binaries, this new field is only emitted
if no target is currently selected, or the 'all-targets'
flag is explicitly set.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 18 ++++++++++++++++++
 qapi/machine.json          | 12 +++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3f06ce8c75f..39624e91139 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -35,6 +35,7 @@
 #include "hw/s390x/storage-keys.h"
 #include "qom/object_interfaces.h"
 #include "qemu/target-info-def.h"
+#include "qemu/base-arch-defs.h"
 
 /*
  * QMP query for enabled and present accelerators
@@ -155,11 +156,16 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 }
 
 MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
+                                    bool has_all_targets, bool all_targets,
                                     Error **errp)
 {
     GSList *el, *machines;
     MachineInfoList *mach_list = NULL;
 
+    if (target_mask_selected() == QEMU_ARCH_ALL) {
+        all_targets = true;
+    }
+
     machines = object_class_get_list(TYPE_MACHINE, false);
     for (el = machines; el; el = el->next) {
         ObjectClass *oc = el->data;
@@ -167,6 +173,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
         AliasedClass *alc = ALIASED_CLASS(oc);
+        TargetSpecificClass *tsc = TARGET_SPECIFIC_CLASS(oc);
 
         /*
          * If we've selected a specific target, then filter
@@ -202,6 +209,17 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
             info->alias = g_strndup(alc->aliases[0], len);
         }
 
+        if (tsc->targets && all_targets) {
+            SysEmuTargetList **targets = &info->targets;
+            size_t i;
+            info->has_targets = true;
+            for (i = 0; i < SYS_EMU_TARGET__MAX; i++) {
+                if (tsc->targets & QEMU_ARCH_BIT(i)) {
+                    QAPI_LIST_APPEND(targets, i);
+                }
+            }
+        }
+
         info->name = g_strdup(mc->name);
         info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
         info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
diff --git a/qapi/machine.json b/qapi/machine.json
index 40fda705462..c3b3cce7e48 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -165,6 +165,11 @@
 #
 # @aliases: a list of aliases for the machine type name (since 12.0)
 #
+# @targets: a list of compatible targets for the machine (since 12.0)
+#      This is only reported if no target is currently selected
+#      for the binary, or if the `query-machines` argument
+#      @all-targets is true.
+#
 # @is-default: whether the machine is default
 #
 # @cpu-max: maximum number of CPUs supported by the machine type
@@ -207,6 +212,7 @@
   'data': { 'name': 'str',
             '*alias': { 'type': 'str', 'features': ['deprecated'] },
             '*aliases': ['str'],
+            '*targets': ['SysEmuTarget'],
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
@@ -222,6 +228,9 @@
 # @compat-props: if true, also return compatibility properties.
 #     (default: false) (since 9.1)
 #
+# @all-targets: if true, report all available targets even
+#     when a target is selected (default: false) (since 12.0)
+#
 # Features:
 #
 # @unstable: Argument @compat-props is experimental.
@@ -253,7 +262,8 @@
 ##
 { 'command': 'query-machines',
   'data': { '*compat-props': { 'type': 'bool',
-                               'features': [ 'unstable' ] } },
+                               'features': [ 'unstable' ] },
+            '*all-targets': 'bool' },
   'returns': ['MachineInfo'] }
 
 ##
-- 
2.56.1


