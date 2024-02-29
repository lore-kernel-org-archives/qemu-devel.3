Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B65BC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa4I-0001dv-O4; Thu, 29 Feb 2024 01:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa4F-0001W6-Oy
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:38:56 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa4D-0004LA-Lo
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188733; x=1740724733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mqsivFidOwyANOqQ34ic4QNOWtNIkjS4ap6ufsTEevA=;
 b=g1bTtyhiU16IApc46N/XKWtPmZEV5SgTHQGU5Puxb2abUnUHXaYOCUb0
 B+3kQYLygPz2Ket2N1CAyopPQrSIDfHmJ18/x91fwnE1C3rHo0s1Xlwxr
 U87R5pKrUkQHyhyGLgXcbEU67vbvSSdlvwjxUYcLQ0JdaejTWE6+5extK
 vcC6U7aTdyH9ePi2/aXBvWZwaS8SMkWxsOrHvGHCy+LsEYgyj9hIEp0Cu
 /+TJ5o3WyO1gx8UPAi/ycB9pC4UAbX9OTAQC2C4dqWMDzDw3oBEs2x/jM
 GjpetldJv5aukleKAN5i6epYdbZw0YKEAqRGT9rRWAqx7IFljEoFUmwVc w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802580"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802580"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:38:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075041"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:38:46 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 12/65] i386: Introduce tdx-guest object
Date: Thu, 29 Feb 2024 01:36:33 -0500
Message-Id: <20240229063726.610065-13-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce tdx-guest object which inherits CONFIDENTIAL_GUEST_SUPPORT,
and will be used to create TDX VMs (TDs) by

  qemu -machine ...,confidential-guest-support=tdx0	\
       -object tdx-guest,id=tdx0

So far, it has no QAPI member/properety decleared and only one internal
member 'attributes' with fixed value 0 that not configurable.

QAPI properties will be added later.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
Changes in v4:
 - update the new qapi `since` filed from 8.2 to 9.0

Changes in v1
 - make @attributes not user-settable
---
 configs/devices/i386-softmmu/default.mak |  1 +
 hw/i386/Kconfig                          |  5 +++
 qapi/qom.json                            | 12 +++++++
 target/i386/kvm/meson.build              |  2 ++
 target/i386/kvm/tdx.c                    | 40 ++++++++++++++++++++++++
 target/i386/kvm/tdx.h                    | 19 +++++++++++
 6 files changed, 79 insertions(+)
 create mode 100644 target/i386/kvm/tdx.c
 create mode 100644 target/i386/kvm/tdx.h

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 598c6646dfc0..9b5ec59d65b0 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -18,6 +18,7 @@
 #CONFIG_QXL=n
 #CONFIG_SEV=n
 #CONFIG_SGA=n
+#CONFIG_TDX=n
 #CONFIG_TEST_DEVICES=n
 #CONFIG_TPM_CRB=n
 #CONFIG_TPM_TIS_ISA=n
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a1846be6f761..c0ccf50ac3ef 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -10,6 +10,10 @@ config SGX
     bool
     depends on KVM
 
+config TDX
+    bool
+    depends on KVM
+
 config PC
     bool
     imply APPLESMC
@@ -26,6 +30,7 @@ config PC
     imply QXL
     imply SEV
     imply SGX
+    imply TDX
     imply TEST_DEVICES
     imply TPM_CRB
     imply TPM_TIS_ISA
diff --git a/qapi/qom.json b/qapi/qom.json
index 2a6e49365a4a..220cc6c98d4b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -895,6 +895,16 @@
             'reduced-phys-bits': 'uint32',
             '*kernel-hashes': 'bool' } }
 
+##
+# @TdxGuestProperties:
+#
+# Properties for tdx-guest objects.
+#
+# Since: 9.0
+##
+{ 'struct': 'TdxGuestProperties',
+  'data': { }}
+
 ##
 # @ThreadContextProperties:
 #
@@ -974,6 +984,7 @@
     'sev-guest',
     'thread-context',
     's390-pv-guest',
+    'tdx-guest',
     'throttle-group',
     'tls-creds-anon',
     'tls-creds-psk',
@@ -1041,6 +1052,7 @@
       'secret_keyring':             { 'type': 'SecretKeyringProperties',
                                       'if': 'CONFIG_SECRET_KEYRING' },
       'sev-guest':                  'SevGuestProperties',
+      'tdx-guest':                  'TdxGuestProperties',
       'thread-context':             'ThreadContextProperties',
       'throttle-group':             'ThrottleGroupProperties',
       'tls-creds-anon':             'TlsCredsAnonProperties',
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index e7850981e62d..26a1ab038513 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -7,6 +7,8 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
+i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
 i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
new file mode 100644
index 000000000000..d3792d4a3d56
--- /dev/null
+++ b/target/i386/kvm/tdx.c
@@ -0,0 +1,40 @@
+/*
+ * QEMU TDX support
+ *
+ * Copyright Intel
+ *
+ * Author:
+ *      Xiaoyao Li <xiaoyao.li@intel.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object_interfaces.h"
+
+#include "tdx.h"
+
+/* tdx guest */
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
+                                   tdx_guest,
+                                   TDX_GUEST,
+                                   CONFIDENTIAL_GUEST_SUPPORT,
+                                   { TYPE_USER_CREATABLE },
+                                   { NULL })
+
+static void tdx_guest_init(Object *obj)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    tdx->attributes = 0;
+}
+
+static void tdx_guest_finalize(Object *obj)
+{
+}
+
+static void tdx_guest_class_init(ObjectClass *oc, void *data)
+{
+}
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
new file mode 100644
index 000000000000..415aeb5af746
--- /dev/null
+++ b/target/i386/kvm/tdx.h
@@ -0,0 +1,19 @@
+#ifndef QEMU_I386_TDX_H
+#define QEMU_I386_TDX_H
+
+#include "exec/confidential-guest-support.h"
+
+#define TYPE_TDX_GUEST "tdx-guest"
+#define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
+
+typedef struct TdxGuestClass {
+    ConfidentialGuestSupportClass parent_class;
+} TdxGuestClass;
+
+typedef struct TdxGuest {
+    ConfidentialGuestSupport parent_obj;
+
+    uint64_t attributes;    /* TD attributes */
+} TdxGuest;
+
+#endif /* QEMU_I386_TDX_H */
-- 
2.34.1


