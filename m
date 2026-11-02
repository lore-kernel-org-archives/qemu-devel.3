Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006C6076D85
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i+ZIWFAE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtF3-0005ZG-LH; Mon, 02 Nov 2026 09:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDH-0003G2-Pe
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD9-0008Tr-6b
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PWM8PrpHmU6nLEOgtkPdmeVQrzoEpi8sQJg+9hKNPEs=;
 b=i+ZIWFAEyODh8QrqEYPOROFiVNOTpCg8Yq2sA/1iGEZq9xmOrV3J9jD5PiBpV3oWIVR2U8
 vkXZ/SCLDcwAFrREVddr/NYy7xzB2xIh43VCuQPqCNdSjkcWlsF4Zfnht8vZOgjVpHBj8+
 i99qk4JldI3Obxci1WfPZAMYj39PKE0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-fm5K2MenN2mCUekUXyHEjQ-1; Mon,
 02 Nov 2026 09:40:31 -0500
X-MC-Unique: fm5K2MenN2mCUekUXyHEjQ-1
X-Mimecast-MFC-AGG-ID: fm5K2MenN2mCUekUXyHEjQ_1793630430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27D0B1802569; Mon,  2 Nov 2026 14:40:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A15B1300019F; Mon,  2 Nov 2026 14:40:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 85BBE21E681F; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 36/74] qom: convert struct properties to QAPI-aware registration
Date: Mon,  2 Nov 2026 15:39:40 +0100
Message-ID: <20261102144018.3212223-37-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert all callers of object_property_add() and
object_class_property_add() that register struct-typed properties with
QAPI visitor-based getters/setters to pass QAPITypeInfo.

This enables QMP QOM introspection to report accurate QAPI type
information for struct properties in member @qapi-type. Existing
getters/setters are preserved unchanged.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20261101201717.3911097-20-armbru@redhat.com>
---
 authz/list.c              |  3 ++-
 block/throttle-groups.c   |  4 +++-
 chardev/char-socket.c     |  4 +++-
 hw/core/machine.c         | 12 ++++++++----
 hw/cxl/cxl-host.c         |  4 +++-
 hw/remote/vfio-user-obj.c |  6 ++++--
 hw/vfio-user/pci.c        |  4 +++-
 target/i386/cpu.c         | 10 +++++++---
 target/i386/kvm/tdx.c     | 10 ++++++----
 target/s390x/cpu-system.c |  3 ++-
 10 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/authz/list.c b/authz/list.c
index 767e91b3aa..75155cf077 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -127,7 +127,8 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
                                    qauthz_list_prop_get_policy,
                                    qauthz_list_prop_set_policy);
 
-    object_class_property_add(oc, "rules", "QAuthZListRule", NULL,
+    object_class_property_add(oc, "rules", "QAuthZListRule",
+                              &QAuthZListRuleList_type_info,
                               qauthz_list_prop_get_rules,
                               qauthz_list_prop_set_rules,
                               NULL, NULL);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index cfe2ea67e3..5d6b089092 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -31,6 +31,7 @@
 #include "qemu/thread.h"
 #include "system/qtest.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
@@ -991,7 +992,8 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
     }
 
     /* ThrottleLimits */
-    object_class_property_add(klass, "limits", "ThrottleLimits", NULL,
+    object_class_property_add(klass, "limits", "ThrottleLimits",
+                              &ThrottleLimits_type_info,
                               throttle_group_get_limits,
                               throttle_group_set_limits,
                               NULL, NULL);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 6ce9c2a50b..d62a057e8c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qemu/yank.h"
 #include "trace.h"
@@ -1568,7 +1569,8 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
     cc->chr_get_filename = tcp_chr_get_filename;
 
-    object_class_property_add(oc, "addr", "SocketAddress", NULL,
+    object_class_property_add(oc, "addr", "SocketAddress",
+                              &SocketAddress_type_info,
                               char_socket_get_addr, NULL,
                               NULL, NULL);
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6948fc9c26..a787b39bb9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -18,6 +18,7 @@
 #include "hw/core/loader.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qemu/madvise.h"
@@ -1119,20 +1120,22 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dumpdtb",
         "Dump current dtb to a file and quit");
 
-    object_class_property_add(oc, "boot", "BootConfiguration", NULL,
+    object_class_property_add(oc, "boot", "BootConfiguration",
+                              &BootConfiguration_type_info,
                               machine_get_boot, machine_set_boot,
                               NULL, NULL);
     object_class_property_set_description(oc, "boot",
         "Boot configuration");
 
-    object_class_property_add(oc, "smp", "SMPConfiguration", NULL,
+    object_class_property_add(oc, "smp", "SMPConfiguration",
+                              &SMPConfiguration_type_info,
                               machine_get_smp, machine_set_smp,
                               NULL, NULL);
     object_class_property_set_description(oc, "smp",
         "CPU topology");
 
     object_class_property_add(oc, "smp-cache", "SmpCachePropertiesWrapper",
-                              NULL,
+                              &SmpCachePropertiesWrapper_type_info,
                               machine_get_smp_cache, machine_set_smp_cache,
                               NULL, NULL);
     object_class_property_set_description(oc, "smp-cache",
@@ -1216,7 +1219,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
 
-    object_class_property_add(oc, "memory", "MemorySizeConfiguration", NULL,
+    object_class_property_add(oc, "memory", "MemorySizeConfiguration",
+                              &MemorySizeConfiguration_type_info,
                               machine_get_mem, machine_set_mem,
                               NULL, NULL);
     object_class_property_set_description(oc, "memory",
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 9348c9841e..77ddf4511a 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -13,6 +13,7 @@
 #include "system/qtest.h"
 #include "hw/core/boards.h"
 
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
@@ -616,7 +617,8 @@ void cxl_machine_init(Object *obj, CXLState *state)
                                     "Set on/off to enable/disable "
                                     "CXL instantiation");
 
-    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow", NULL,
+    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
+                        &CXLFixedMemoryWindowOptionsList_type_info,
                         machine_get_cfmw, machine_set_cfmw,
                         NULL, state);
     object_property_set_description(obj, "cxl-fmw",
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index c4b3cb0b7b..205582a91f 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -47,6 +47,7 @@
 #include "hw/core/boards.h"
 #include "hw/remote/machine.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-events-misc.h"
 #include "qemu/notify.h"
@@ -931,8 +932,9 @@ static void vfu_object_class_init(ObjectClass *klass, const void *data)
 
     k->nr_devs = 0;
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL, NULL,
-                              vfu_object_set_socket, NULL, NULL);
+    object_class_property_add(klass, "socket", "SocketAddress",
+                              &SocketAddress_type_info,
+                              NULL, vfu_object_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress "
                                           "(ex: type=unix,path=/tmp/sock). "
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 4c76a3fe5d..c749ff149f 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
@@ -471,7 +472,8 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_properties);
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL, NULL,
+    object_class_property_add(klass, "socket", "SocketAddress",
+                              &SocketAddress_type_info, NULL,
                               vfio_user_pci_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress (UNIX sockets only)");
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4514de46ff..6a05a7144a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -35,6 +35,8 @@
 #include "sev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-type-infos-machine.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-machine.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/core/qdev-properties.h"
@@ -10569,11 +10571,12 @@ static void x86_cpu_initfn(Object *obj)
 
     x86_cpu_init_default_topo(cpu);
 
-    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo", NULL,
+    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
+                        &X86CPUFeatureWordInfoList_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)env->features);
     object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
-                        NULL,
+                        &X86CPUFeatureWordInfo_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features);
 
@@ -11041,7 +11044,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
 #if !defined(CONFIG_USER_ONLY)
     object_class_property_add(oc, "crash-information",
-                              "GuestPanicInformation", NULL,
+                              "GuestPanicInformation",
+                              &GuestPanicInformation_type_info,
                               x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
 #endif
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index f6707abd34..52bb2ec6ce 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,6 +14,7 @@
 #include "qemu/base64.h"
 #include "qemu/mmap-alloc.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
@@ -1586,10 +1587,11 @@ static void tdx_guest_init(Object *obj)
                             tdx_guest_get_mrownerconfig,
                             tdx_guest_set_mrownerconfig);
 
-    object_property_add(obj, "quote-generation-socket", "SocketAddress", NULL,
-                            tdx_guest_get_qgs,
-                            tdx_guest_set_qgs,
-                            NULL, NULL);
+    object_property_add(obj, "quote-generation-socket", "SocketAddress",
+                        &SocketAddress_type_info,
+                        tdx_guest_get_qgs,
+                        tdx_guest_set_qgs,
+                        NULL, NULL);
 
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index de2f1422e3..5b5406b947 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -30,6 +30,7 @@
 #include "system/reset.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "system/hw_accel.h"
 
@@ -138,7 +139,7 @@ void s390_cpu_system_init(Object *obj)
 
     cs->start_powered_off = true;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
-                        NULL,
+                        &GuestPanicInformation_type_info,
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
     cpu->env.tod_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
-- 
2.55.0


