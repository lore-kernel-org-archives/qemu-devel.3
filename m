Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD63C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2o5-0000zz-4z; Thu, 08 May 2025 11:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2o3-0000xT-9p
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:03 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2o0-0007Ez-Og
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716701; x=1778252701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vUjlF8Ac1iAIrx69S+KM0WHaJynMVnu83w0XBqlU04U=;
 b=D7/yYOciuZHyGcAJXN5zt0SB6I7I8bzJdz3ig91IXyHzgLZh0v59X8/d
 oUL2Gzx7rNfG9P2++IVoBFJbuJF1TUImIH1kyDNwuU7vZBqBy1dEWM+j1
 Ur81hP7Nfa8ECd4nCli54Hnu+As1RVf1vQSsGahEurdMfOwD/SdlPKSXY
 cp4yd0WAhPGZHrDsVI4ulHnTmwgUSRj2cHTFCy3mCmzZ52fiGtTZZVFMU
 jl+eo7zw1EQ/eqD32w066eDIro8D5cu8xrdO6glQFhX3+89wBw9BjS9Y5
 l4B91DpdvAwopx6IMlWPBroKJ3DPvu3tL7L638PXxzhCGAt5DbriptaYO A==;
X-CSE-ConnectionGUID: tWXQ7DbXQm6TqifVHqJzag==
X-CSE-MsgGUID: DIsAVKihRMmkTpsASU4v+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73887979"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73887979"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:04:59 -0700
X-CSE-ConnectionGUID: UOVqKJzlQ1GL4rsoBCVS4Q==
X-CSE-MsgGUID: Jq7glIq2RdK4WvpZ9wLNvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141439697"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:04:56 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 02/55] i386: Introduce tdx-guest object
Date: Thu,  8 May 2025 10:59:08 -0400
Message-ID: <20250508150002.689633-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Introduce tdx-guest object which inherits X86_CONFIDENTIAL_GUEST,
and will be used to create TDX VMs (TDs) by

  qemu -machine ...,confidential-guest-support=tdx0	\
       -object tdx-guest,id=tdx0

It has one QAPI member 'attributes' defined, which allows user to set
TD's attributes directly.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v7:
 - update QAPI version to 10.0;
 - update to use SPDX tags for license info;
 - update copyright to 2025;

Chanegs in v6:
 - Make tdx-guest inherits X86_CONFIDENTIAL_GUEST;
 - set cgs->require_guest_memfd;
 - allow attributes settable via QAPI;
 - update QAPI version to since 9.2;

Changes in v4:
 - update the new qapi `since` filed from 8.2 to 9.0

Changes in v1
 - make @attributes not user-settable
---
 configs/devices/i386-softmmu/default.mak |  1 +
 hw/i386/Kconfig                          |  5 +++
 qapi/qom.json                            | 15 +++++++++
 target/i386/kvm/meson.build              |  2 ++
 target/i386/kvm/tdx.c                    | 43 ++++++++++++++++++++++++
 target/i386/kvm/tdx.h                    | 21 ++++++++++++
 6 files changed, 87 insertions(+)
 create mode 100644 target/i386/kvm/tdx.c
 create mode 100644 target/i386/kvm/tdx.h

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 4faf2f0315e2..bc0479a7e0a3 100644
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
index d34ce07b215d..cce9521ba934 100644
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
index 28ce24cd8d08..c0b61df964ef 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1047,6 +1047,19 @@
             '*host-data': 'str',
             '*vcek-disabled': 'bool' } }
 
+##
+# @TdxGuestProperties:
+#
+# Properties for tdx-guest objects.
+#
+# @attributes: The 'attributes' of a TD guest that is passed to
+#     KVM_TDX_INIT_VM
+#
+# Since: 10.1
+##
+{ 'struct': 'TdxGuestProperties',
+  'data': { '*attributes': 'uint64' } }
+
 ##
 # @ThreadContextProperties:
 #
@@ -1132,6 +1145,7 @@
     'sev-snp-guest',
     'thread-context',
     's390-pv-guest',
+    'tdx-guest',
     'throttle-group',
     'tls-creds-anon',
     'tls-creds-psk',
@@ -1204,6 +1218,7 @@
                                       'if': 'CONFIG_SECRET_KEYRING' },
       'sev-guest':                  'SevGuestProperties',
       'sev-snp-guest':              'SevSnpGuestProperties',
+      'tdx-guest':                  'TdxGuestProperties',
       'thread-context':             'ThreadContextProperties',
       'throttle-group':             'ThrottleGroupProperties',
       'tls-creds-anon':             'TlsCredsAnonProperties',
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 3996cafaf29f..466bccb9cb17 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -8,6 +8,8 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
+i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
 i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
new file mode 100644
index 000000000000..ec84ae2947bb
--- /dev/null
+++ b/target/i386/kvm/tdx.c
@@ -0,0 +1,43 @@
+/*
+ * QEMU TDX support
+ *
+ * Copyright (c) 2025 Intel Corporation
+ *
+ * Author:
+ *      Xiaoyao Li <xiaoyao.li@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+                                   X86_CONFIDENTIAL_GUEST,
+                                   { TYPE_USER_CREATABLE },
+                                   { NULL })
+
+static void tdx_guest_init(Object *obj)
+{
+    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    cgs->require_guest_memfd = true;
+    tdx->attributes = 0;
+
+    object_property_add_uint64_ptr(obj, "attributes", &tdx->attributes,
+                                   OBJ_PROP_FLAG_READWRITE);
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
index 000000000000..f3b725336161
--- /dev/null
+++ b/target/i386/kvm/tdx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_I386_TDX_H
+#define QEMU_I386_TDX_H
+
+#include "confidential-guest.h"
+
+#define TYPE_TDX_GUEST "tdx-guest"
+#define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
+
+typedef struct TdxGuestClass {
+    X86ConfidentialGuestClass parent_class;
+} TdxGuestClass;
+
+typedef struct TdxGuest {
+    X86ConfidentialGuest parent_obj;
+
+    uint64_t attributes;    /* TD attributes */
+} TdxGuest;
+
+#endif /* QEMU_I386_TDX_H */
-- 
2.43.0


