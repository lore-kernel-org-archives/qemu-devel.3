Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DF6C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtvt-0000P3-3p; Fri, 30 May 2025 03:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvo-0000AT-K3
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtvl-0006qC-Ub
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7J/PKsdjyO75T/ahNYZnTAukxtHL/1y+JI/M/+zeKQ=;
 b=ggi8xOoznHniQIr1hJoitevqJau6cgTlTfj0llv8X3AVe+23w8hxKDyr8AIfvgHULn7CK2
 dqNImylqKBIEnkvMd+62+su8V/1NXSzI0Rh2w4KeliJDhKw3Y26aJ9mwtCSPO/piYveoNl
 P3FLgt47gR8MrHTuVtwxJ46JuBd34lo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-rAidFBXZO0qiw0rL2B_WNg-1; Fri, 30 May 2025 03:13:27 -0400
X-MC-Unique: rAidFBXZO0qiw0rL2B_WNg-1
X-Mimecast-MFC-AGG-ID: rAidFBXZO0qiw0rL2B_WNg_1748589206
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acbbb0009aeso130569166b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589206; x=1749194006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7J/PKsdjyO75T/ahNYZnTAukxtHL/1y+JI/M/+zeKQ=;
 b=IYbmifEUh6BMaZgOKn41RWo6LPuVJsOSBj2j/3V/Tx0hrqkd2EWjNJGtxUQcyUMR2I
 vixfWeCtH6HFx8//tiUS1/7snj6oBSV5+iNr0ED2BWypqWlS2dPKCiW6+TBg/HK/TT02
 OcCq8jpt/F83Ui0tX5wLC1Pw+erfvbgxXUl/jJpcVOcPLW8c8YfonMNONf/GiYlwh3kF
 01s33VXmkm4OXl4ILtoCePTNsufL+nuum0Z2Zi+HMTNTEblTvimuAXRz9hp49V7NvRQ6
 xAj5TyV9fLBb8n4SuJK8CAWv5PiktJGK0DSATFNF30p/OeHYl7sESSOLrgKshiPPbJ7R
 o2QQ==
X-Gm-Message-State: AOJu0YwGKDoBygZaqO9vo7M/8Osz7T5TOsY++h6aHYhdB8oze7O21I+h
 jJwhrIjugjrmhICPD7JBg3ABx+HldmI0M89OTZ8qPVEskL+cughZiBHWbWwu3Si/mhMlrEEg+pF
 nRj5Z+QIAoFwacMNNNJ9wZfSKJlXS9kI1OXu4Beaaa08nS1MVXqRAGy6fYgY8bKmS0jnUHhm3jM
 WDoH1U86GC/6d6B9/U+nFdN9Yugw7FemplCdW7b8pJ
X-Gm-Gg: ASbGncttJiPqqNrbBHALDTyzlOe1wqsmOO7bTtSL06sXjlIMqfnHsLvydI2UVYiaIoj
 Lv2cTRoTNmd0/XMq8/mpDNbiBixn9JvH6ApitCA45cdsgMPyWExuy1c8JW9qt55T+mQBuUM55da
 G3r3Sqoll3AwLAO4/EWJHNKzqqOFLp7URR06kFVxg0zkdDejajyYYEpBGYhmmNkkec6tUc6FTPl
 y7yWKIWOsFzv6yzAHNUY77g43bUfy2De+Q5vl3h0MVZte7zdsfdZZC6qqNEu06su9xAHXRlaQG6
 mquy2mB5V+2Fiz0gGkU+1Cji
X-Received: by 2002:a17:907:2d10:b0:adb:7f8:9ecf with SMTP id
 a640c23a62f3a-adb32301978mr201230366b.45.1748589205453; 
 Fri, 30 May 2025 00:13:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbeDxfmsjJ49OrrqGMQCVowujdXZ7NQpIqjgaIYZJqMak5sjF+jQEYgnCy1xZ7+s+RNwOvkA==
X-Received: by 2002:a17:907:2d10:b0:adb:7f8:9ecf with SMTP id
 a640c23a62f3a-adb32301978mr201227466b.45.1748589204976; 
 Fri, 30 May 2025 00:13:24 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5dd04537sm277865566b.92.2025.05.30.00.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/77] i386: Introduce tdx-guest object
Date: Fri, 30 May 2025 09:11:44 +0200
Message-ID: <20250530071250.2050910-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

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
Link: https://lore.kernel.org/r/20250508150002.689633-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/i386-softmmu/default.mak |  1 +
 qapi/qom.json                            | 15 +++++++++
 target/i386/kvm/tdx.h                    | 21 ++++++++++++
 target/i386/kvm/tdx.c                    | 43 ++++++++++++++++++++++++
 hw/i386/Kconfig                          |  5 +++
 target/i386/kvm/meson.build              |  2 ++
 6 files changed, 87 insertions(+)
 create mode 100644 target/i386/kvm/tdx.h
 create mode 100644 target/i386/kvm/tdx.c

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 4faf2f0315e..bc0479a7e0a 100644
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
diff --git a/qapi/qom.json b/qapi/qom.json
index 04c118e4d61..3d7e11efc38 100644
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
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
new file mode 100644
index 00000000000..f3b72533616
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
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
new file mode 100644
index 00000000000..ab70566c7df
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
+static void tdx_guest_class_init(ObjectClass *oc, const void *data)
+{
+}
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d34ce07b215..cce9521ba93 100644
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
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 3996cafaf29..466bccb9cb1 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -8,6 +8,8 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
+i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'))
+
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
 i386_system_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
-- 
2.49.0


