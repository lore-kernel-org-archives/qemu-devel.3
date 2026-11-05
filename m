Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB3606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVrFX5uE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOueE-0001ty-No; Thu, 05 Nov 2026 05:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOueD-0001tg-LL
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xOueB-0003rA-NO
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793874282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sR+wXFPR6i+NwMqhpcdylfpyBY8NGxv9YC8FJiIdC30=;
 b=VVrFX5uEtNi2z/rpPmmTqvSL+Q7wr+Hm0f0RfQ285/MlahGZTN47xSlmcMXDn13QKd5iUW
 gTD32U8V7se0QIGNWL+5q2KMtLj4VlCJvY6LZcLxwU/W8wC/3gnlmoKwP9TMPpqYNVaYuL
 Z1Di9ZV82uyq+qoLR/6NdLr8+gZk34A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-l13fXoxQObWXO7qPTO7r5A-1; Thu,
 05 Nov 2026 05:24:39 -0500
X-MC-Unique: l13fXoxQObWXO7qPTO7r5A-1
X-Mimecast-MFC-AGG-ID: l13fXoxQObWXO7qPTO7r5A_1793874277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F40621955E8F; Thu,  5 Nov 2026 10:24:36 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B970B187C36B; Thu,  5 Nov 2026 10:24:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] hw/core: record permitted targets against MachineClass
Date: Thu,  5 Nov 2026 10:24:29 +0000
Message-ID: <20261105102432.1131493-2-berrange@redhat.com>
In-Reply-To: <20261105102432.1131493-1-berrange@redhat.com>
References: <20261105102432.1131493-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Record a bitmask of QEMU_ARCH_nnnn in the 'targets' field
of MachineClass.

When a request is made to create a machine, it will be
validated against machine_class_is_available(MachineClass),
which checks target_arch() against the 'targets' field.

This prevents realization of, for example, an aarch64-only
machine linked into the arm emulator binary.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 18 ++++++++++++++++++
 hw/core/machine.c          | 13 +++++++++++++
 include/hw/core/boards.h   |  3 +++
 qapi/machine.json          | 12 +++++++++++-
 system/vl.c                |  9 +++++++++
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 0558d6d703c..3a33a046622 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -33,6 +33,7 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
+#include "qemu/base-arch-defs.h"
 
 /*
  * QMP query for enabled and present accelerators
@@ -153,6 +154,7 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 }
 
 MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
+                                    bool has_all_targets, bool all_targets,
                                     Error **errp)
 {
     GSList *el, *machines;
@@ -164,6 +166,10 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
 
+        if (!all_targets && !machine_class_is_available(mc)) {
+            continue;
+        }
+
         info = g_malloc0(sizeof(*info));
         if (mc->is_default) {
             info->has_is_default = true;
@@ -188,6 +194,18 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         }
         info->secure = object_class_is_secure(OBJECT_CLASS(mc));
 
+        if (all_targets) {
+            SysEmuTargetList **targets;
+            size_t i;
+            info->has_targets = true;
+            targets = &info->targets;
+            for (i = 0; i < SYS_EMU_TARGET__MAX; i++) {
+                if (mc->targets & QEMU_ARCH_BIT(i)) {
+                    QAPI_LIST_APPEND(targets, i);
+                }
+            }
+        }
+
         if (compat_props && mc->compat_props) {
             int i;
             info->compat_props = NULL;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ed9bf8f5008..9743754fc7f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,8 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 #include "hw/arm/smmuv3.h"
+#include "qemu/base-arch-defs.h"
+#include "qemu/target-info-qapi.h"
 
 GlobalProperty hw_compat_11_1[] = {
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },
@@ -711,6 +713,17 @@ bool device_type_is_dynamic_sysbus(MachineClass *mc, const char *type)
     return allowed;
 }
 
+bool machine_class_is_available(MachineClass *mc)
+{
+    /*
+     * XXX: Once all machines have 'targets' set, we
+     * can remove the 'mc->targets == 0' check
+     */
+    return mc->targets == 0 ||
+        QEMU_ARCH_BIT(target_arch()) & mc->targets;
+}
+
+
 static char *machine_get_audiodev(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index d0e4ad98201..cb493397b13 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -37,6 +37,8 @@ const char *machine_default_cpu_type(const MachineState *ms);
  */
 const char *machine_class_default_cpu_type(MachineClass *mc);
 
+bool machine_class_is_available(MachineClass *mc);
+
 void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
 bool machine_usb(MachineState *machine);
@@ -282,6 +284,7 @@ struct MachineClass {
         int default_ipa_size, int max_ipa_size);
     bool (*get_kernel_irqchip_default) (const MachineState *machine);
 
+    int targets; /* QEMU_ARCH_xxx bitmask */
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
     int max_cpus;
diff --git a/qapi/machine.json b/qapi/machine.json
index 18d9dce849b..95b02043768 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -194,6 +194,10 @@
 #     not providing a security boundary, or its status is undefined.
 #     (since 11.2)
 #
+# @targets: list of targets that the machine can be used with.  Only
+#     present when `query-machines` argument @all-targets is true.
+#     (since 12.0)
+#
 # Features:
 #
 # @unstable: Member @compat-props is experimental.
@@ -205,6 +209,7 @@
             '*is-default': 'bool', 'cpu-max': 'int',
             'hotpluggable-cpus': 'bool',  'numa-mem-supported': 'bool',
             'deprecated': 'bool', '*default-cpu-type': 'str',
+            '*targets': ['SysEmuTarget'],
             '*default-ram-id': 'str', 'acpi': 'bool',
             '*compat-props': { 'type': ['CompatProperty'],
                                'features': ['unstable'] },
@@ -217,6 +222,10 @@
 # @compat-props: if true, also return compatibility properties.
 #     (default: false) (since 9.1)
 #
+# @all-targets: if true, return info about all machines present
+#     instead of only those available with the current active
+#     target (since 12.0)
+#
 # Features:
 #
 # @unstable: Argument @compat-props is experimental.
@@ -248,7 +257,8 @@
 ##
 { 'command': 'query-machines',
   'data': { '*compat-props': { 'type': 'bool',
-                               'features': [ 'unstable' ] } },
+                               'features': [ 'unstable' ] },
+            '*all-targets': 'bool' },
   'returns': ['MachineInfo'] }
 
 ##
diff --git a/system/vl.c b/system/vl.c
index e7b759d5442..ace64284ae4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1583,6 +1583,9 @@ static void machine_help_func(const QDict *qdict)
     machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+        if (!machine_class_is_available(mc)) {
+            continue;
+        }
         if (mc->alias) {
             printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
@@ -2208,6 +2211,12 @@ static bool qemu_create_machine(QDict *qdict)
     MachineClass *machine_class = select_machine(qdict, &error_fatal);
     object_set_machine_compat_props(machine_class->compat_props);
 
+    if (!machine_class_is_available(machine_class)) {
+        error_report("Machine '%s' is not available with this target",
+                     machine_class->name);
+        return false;
+    }
+
     if (!object_class_check_security(OBJECT_CLASS(machine_class),
                                      &local_err)) {
         error_report_err(local_err);
-- 
2.56.0


