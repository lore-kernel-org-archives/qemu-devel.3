Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A98606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT6T3-00007r-Oq; Mon, 16 Nov 2026 18:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xT6T2-00007I-KV
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:50:32 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xT6Sy-0005Ek-Td
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:50:32 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 502B448657;
 Tue, 17 Nov 2026 00:50:19 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH for-12.0 2/2] hw/i386/microvm: add versioned machine types
Date: Tue, 17 Nov 2026 00:30:14 +0100
Message-ID: <20261116235010.3622909-3-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
References: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794873016032
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

microvm was meant for short-lived guests [1] and thus wasn not
versioned, so migration across QEMU versions is not supported. It is now
also intersting for long-lived ones as better isolated alternative for
Linux containers though, which would be nice to allow migration to hosts
with a newer QEMU, and Paolo noted that microvm could start having
versioned variants [2].

Add microvm-X.Y machine types, starting with 12.0. "microvm" itself is
left "unversioned" as it is, instead of becoming an alias of the latest
version. An unversioned machine type is meant to be a moving target
[2], which includes resolving a CPU model name without a version, like
"Cascadelake-Server", to the latest version of the model. A versioned
type needs a fixed default for that, and an alias cannot differ from
the type it refers to. So the versioned types derive from microvm and
default to version 1, like pc and q35 do.

A machine class does not inherit the compat property array of its
parent class and TypeInfo.secure is not inherited either, so the
versioned types add microvm_properties and set the flag again.

Both sides of a migration have to use the same versioned type. The
machine type check of the migration stream does not fully enforce
this, as it only compares as many characters as the name of the source
has, i.e., it rejects microvm-12.0 to microvm, but not microvm to
microvm-12.0.

Also document that with KVM or HVF migration needs the same guest
physical address width on both hosts.

[1] https://lore.kernel.org/qemu-devel/af3acd26-f114-5889-182a-7dbd025393b9@redhat.com/
[2] https://lore.kernel.org/qemu-devel/004396c0-8370-4015-b746-3c800f45984f@redhat.com/

Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---
 docs/system/i386/microvm.rst                  | 21 ++++++++-
 hw/i386/microvm.c                             | 43 +++++++++++++++++++
 .../x86_64/test_cpu_model_versions.py         | 41 ++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/docs/system/i386/microvm.rst b/docs/system/i386/microvm.rst
index 077ea15751..56804f1bd8 100644
--- a/docs/system/i386/microvm.rst
+++ b/docs/system/i386/microvm.rst
@@ -9,6 +9,24 @@ designed for short-lived guests. microvm also establishes a baseline
 for benchmarking and optimizing both QEMU and guest operating systems,
 since it is optimized for both boot time and footprint.
 
+``microvm`` itself is not versioned: its defaults may change with every
+QEMU version, so it does not support migration between QEMU versions.
+The ``microvm-X.Y`` machine types are versioned. They keep the behaviour
+they had in the QEMU X.Y release, so that VM migration works between
+QEMU versions, as long as both sides use the same versioned type. The
+first one is ``microvm-12.0``.
+
+On the versioned types, a CPU model name without a version, like
+``Cascadelake-Server``, refers to the first version of the model, as on
+the ``pc`` and ``q35`` machine types, while ``microvm`` uses the latest
+version. Use a versioned name, like ``Cascadelake-Server-v5``, to select
+a specific one.
+
+With KVM or HVF and a 64-bit CPU model, microvm uses the host's
+physical address width for the guest, so migration also requires the
+same width on both hosts, for example by capping it with the
+``host-phys-bits-limit`` CPU property to a value both hosts support.
+
 
 Supported devices
 -----------------
@@ -34,7 +52,8 @@ Currently, microvm does *not* support the following features:
 
 - PCI-only devices.
 - Hotplug of any kind.
-- Live migration across QEMU versions.
+- Live migration across QEMU versions, unless a versioned machine type
+  is used.
 
 
 Using the microvm machine type
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index ae22bdf433..5bb6cd1f51 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -735,3 +735,46 @@ static void microvm_machine_init(void)
     type_register_static(&microvm_machine_info);
 }
 type_init(microvm_machine_init);
+
+/*
+ * Defaults of the versioned machine types, which derive from the
+ * unversioned one. The compat properties are added again, as a machine
+ * class does not inherit the compat_props array of its parent class.
+ */
+static void microvm_machine_options(MachineClass *mc)
+{
+    MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(mc);
+
+    mmc->default_cpu_version = 1;
+    compat_props_add(mc->compat_props, microvm_properties,
+                     G_N_ELEMENTS(microvm_properties));
+}
+
+#define DEFINE_MICROVM_MACHINE(major, minor) \
+    static void MACHINE_VER_SYM(class_init, microvm, major, minor)( \
+        ObjectClass *oc, \
+        const void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        microvm_machine_options(mc); \
+        MACHINE_VER_SYM(options, microvm, major, minor)(mc); \
+        MACHINE_VER_DEPRECATION(major, minor); \
+    } \
+    static const TypeInfo MACHINE_VER_SYM(info, microvm, major, minor) = \
+    { \
+        .name = MACHINE_VER_TYPE_NAME("microvm", major, minor), \
+        .parent = TYPE_MICROVM_MACHINE, \
+        .class_init = MACHINE_VER_SYM(class_init, microvm, major, minor), \
+        .secure = true, \
+    }; \
+    static void MACHINE_VER_SYM(register, microvm, major, minor)(void) \
+    { \
+        MACHINE_VER_DELETION(major, minor); \
+        type_register_static(&MACHINE_VER_SYM(info, microvm, major, minor)); \
+    } \
+    type_init(MACHINE_VER_SYM(register, microvm, major, minor));
+
+static void microvm_machine_12_0_options(MachineClass *mc)
+{
+}
+DEFINE_MICROVM_MACHINE(12, 0)
diff --git a/tests/functional/x86_64/test_cpu_model_versions.py b/tests/functional/x86_64/test_cpu_model_versions.py
index 36c968f1c0..18b9e934b0 100755
--- a/tests/functional/x86_64/test_cpu_model_versions.py
+++ b/tests/functional/x86_64/test_cpu_model_versions.py
@@ -178,6 +178,47 @@ def test_unversioned_alias(self):
 
         self.validate_aliases(cpus)
 
+    def test_microvm_alias(self):
+        """
+        Check if unversioned CPU model is an alias pointing to the latest
+        version on the unversioned microvm machine type
+        """
+        self.set_machine('microvm')
+        self.vm.add_args('-S')
+        self.vm.launch()
+
+        cpus = dict((m['name'], m) for m in
+                    self.vm.cmd('query-cpu-definitions'))
+
+        latest = max(int(m.group(1)) for m in
+                     (re.fullmatch(r'Cascadelake-Server-v(\d+)', name)
+                      for name in cpus) if m)
+        self.assertEqual(cpus['Cascadelake-Server'].get('alias-of'),
+                         'Cascadelake-Server-v%d' % latest,
+                         'Cascadelake-Server must be an alias of its latest '
+                         'version')
+
+        self.validate_aliases(cpus)
+
+    def test_microvm_12_0_alias(self):
+        """
+        Check if unversioned CPU model is an alias pointing to right version
+        on a versioned microvm machine type
+        """
+        self.set_machine('microvm-12.0')
+        self.vm.add_args('-S')
+        self.vm.launch()
+
+        cpus = dict((m['name'], m) for m in
+                    self.vm.cmd('query-cpu-definitions'))
+
+        self.assertEqual(cpus['Cascadelake-Server'].get('alias-of'),
+                         'Cascadelake-Server-v1',
+                         'Cascadelake-Server must be an alias of '
+                         'Cascadelake-Server-v1')
+
+        self.validate_aliases(cpus)
+
     def test_none_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to some version
-- 
2.47.3



