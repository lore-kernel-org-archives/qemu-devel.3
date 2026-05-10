Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39B6CD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4UV-0002T1-7A; Sun, 10 May 2026 09:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4UJ-0001h6-KL
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4UH-0004uG-1Z
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3k5GcK7tkohWojWEr3yv8uJGegYcRXKyOwYa76tqI7k=;
 b=MrdSGz/9mQte/8Z7aSBALblH4jPWJG6urWqjmILOhTvhl4HdJ73D8MIUpLeo/p1DQnFfC4
 clhtM6Hhxc5D63VPXRKWJA86rMbzSnVo2RrzWztqD5AZuShncA3iYRog6OW1YGCjdu5q9l
 9pg83BUC5umIY/n+kT3ZzPfpRAfFHi4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-oLXIuUvkNQi-8fbJvdv3mg-1; Sun,
 10 May 2026 09:46:23 -0400
X-MC-Unique: oLXIuUvkNQi-8fbJvdv3mg-1
X-Mimecast-MFC-AGG-ID: oLXIuUvkNQi-8fbJvdv3mg_1778420782
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BED81800344
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:46:22 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37B643002D31; Sun, 10 May 2026 13:46:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:11 +0400
Subject: [PATCH 14/54] qom: convert struct properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-14-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11042;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eSC9/qItjtj4PED9ZnqsEUvcHj++6ICjnFw742cBUkg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItvD1HhLlaFVFDg+s0YZcsYAeMixlcvsxo8+
 nT3EY71tzqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbwAKCRDa6OEJdZac
 5TXAD/9zujifDaB1tazKbX5MQG1RpqkgENZQhhDLMFfjdq0NTTkfn8AFcBvshoUsftBIWBgMNw4
 HvaCkg3SmLcJnCvZmSZfgJruewpaK3Zln3VND7ezRIA5x4FNez+EY5QBEYr+S79m8RHFIrwb3tW
 pM9ZWo31xCj8jodaai59WK/QPLZBLA8r01KmqBr4OrCL5zzOBE/oyOghDGghZg3t+3UIj81tgSn
 fhuzGR3mZy7x71Pzmyj5Gli7uydziyLnauUvSQrsnM2xQ3ERXFgdGAaRTjKvo1vazUUH4qFiF3z
 CHQbrL2bL57gH7mOLM1F9/EOP0uN28wk422JXxET/Zz05LhxhvTVT3J7gG8aKtv+Jms7P2002oG
 ZyIZ5aE8ErMvW7E3fSbUoI54bXPZbGu+nyiivG6ed10QakjmxYVSIdUmeENivK/KNAprx5RPz5R
 ZChADmcciK6GRQeoAPwbyEODH+TSAeAP7YLlpyKrDB4ZwfF4crM14ZDNKWAcGu8DtoY/OoVlAWx
 1E6qhN4HZFSLcuOqado8h8iNM6VgsaAfJYX70ruTVBO6F0hdLmC1DcsAIbDRuTyCOIP9HmbwbPp
 yTsAg+1bjRG5rj3LSdLAEMxJs1HUSQZJfoHGp/7APa//7B31gmgFE4ZMGrDj/7QPqWKxZkkvpKj
 balbgZmcsQApZXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Convert all callers of object_property_add() and
object_class_property_add() that register struct-typed properties with
QAPI visitor-based getters/setters to use object_property_add_qapi() and
object_class_property_add_qapi() instead.

This replaces the manual string type name with a reference to the
generated QAPITypeInfo constant, enabling QMP introspection to report
accurate QAPI type information for struct properties. Existing
getters/setters are preserved unchanged.

The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
(not a real QAPI type) to "CXLFixedMemoryWindowOptions".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 authz/list.c              |  2 +-
 chardev/char-socket.c     |  3 ++-
 hw/core/machine.c         | 11 +++++++----
 hw/cxl/cxl-host.c         |  4 +++-
 hw/remote/vfio-user-obj.c |  5 +++--
 hw/vfio-user/pci.c        |  5 +++--
 target/i386/cpu.c         | 11 ++++++++---
 target/i386/kvm/tdx.c     |  4 +++-
 target/s390x/cpu-system.c |  4 +++-
 9 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/authz/list.c b/authz/list.c
index 363b2ee12c9..ed3d346004c 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
         .set = qauthz_list_prop_set_policy,
     ));
 
-    object_class_property_add(oc, "rules", "QAuthZListRule",
+    object_class_property_add_qapi(oc, "rules", &QAuthZListRule_type_info,
                               qauthz_list_prop_get_rules,
                               qauthz_list_prop_set_rules,
                               NULL, NULL);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e064b105c50..5268e037872 100644
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
@@ -1569,7 +1570,7 @@ static void char_socket_class_init(ObjectClass *oc, const void *data)
     cc->chr_listener_cleanup = tcp_chr_listener_cleanup;
     cc->chr_get_filename = tcp_chr_get_filename;
 
-    object_class_property_add(oc, "addr", "SocketAddress",
+    object_class_property_add_qapi(oc, "addr", &SocketAddress_type_info,
                               char_socket_get_addr, NULL,
                               NULL, NULL);
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1b661fd36ae..1dd5375caea 100644
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
@@ -1094,19 +1095,20 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "dumpdtb",
         "Dump current dtb to a file and quit");
 
-    object_class_property_add(oc, "boot", "BootConfiguration",
+    object_class_property_add_qapi(oc, "boot", &BootConfiguration_type_info,
         machine_get_boot, machine_set_boot,
         NULL, NULL);
     object_class_property_set_description(oc, "boot",
         "Boot configuration");
 
-    object_class_property_add(oc, "smp", "SMPConfiguration",
+    object_class_property_add_qapi(oc, "smp", &SMPConfiguration_type_info,
         machine_get_smp, machine_set_smp,
         NULL, NULL);
     object_class_property_set_description(oc, "smp",
         "CPU topology");
 
-    object_class_property_add(oc, "smp-cache", "SmpCachePropertiesWrapper",
+    object_class_property_add_qapi(oc, "smp-cache",
+        &SmpCachePropertiesWrapper_type_info,
         machine_get_smp_cache, machine_set_smp_cache, NULL, NULL);
     object_class_property_set_description(oc, "smp-cache",
         "Cache properties list for SMP machine");
@@ -1188,7 +1190,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
                                           "Set RAM backend"
                                           "Valid value is ID of hostmem based backend");
 
-    object_class_property_add(oc, "memory", "MemorySizeConfiguration",
+    object_class_property_add_qapi(oc, "memory",
+        &MemorySizeConfiguration_type_info,
         machine_get_mem, machine_set_mem,
         NULL, NULL);
     object_class_property_set_description(oc, "memory",
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index a94b893e999..87067b94b34 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -13,6 +13,7 @@
 #include "system/qtest.h"
 #include "hw/core/boards.h"
 
+#include "qapi/qapi-type-infos-machine.h"
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
@@ -350,7 +351,8 @@ void cxl_machine_init(Object *obj, CXLState *state)
                                     "Set on/off to enable/disable "
                                     "CXL instantiation");
 
-    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
+    object_property_add_qapi(obj, "cxl-fmw",
+                        &CXLFixedMemoryWindowOptions_type_info,
                         machine_get_cfmw, machine_set_cfmw,
                         NULL, state);
     object_property_set_description(obj, "cxl-fmw",
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 12ecdab6dea..d0d0a7be7d2 100644
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
@@ -928,8 +929,8 @@ static void vfu_object_class_init(ObjectClass *klass, const void *data)
 
     k->nr_devs = 0;
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL,
-                              vfu_object_set_socket, NULL, NULL);
+    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
+                              NULL, vfu_object_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress "
                                           "(ex: type=unix,path=/tmp/sock). "
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index facc79727ac..a4427ed0353 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include "qapi/qapi-type-infos-sockets.h"
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
@@ -468,8 +469,8 @@ static void vfio_user_pci_class_init(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, vfio_user_pci_reset);
     device_class_set_props(dc, vfio_user_pci_properties);
 
-    object_class_property_add(klass, "socket", "SocketAddress", NULL,
-                              vfio_user_pci_set_socket, NULL, NULL);
+    object_class_property_add_qapi(klass, "socket", &SocketAddress_type_info,
+                              NULL, vfio_user_pci_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress (UNIX sockets only)");
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97c66c22262..a98bcc218ba 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -34,6 +34,8 @@
 #include "sev.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-type-infos-machine.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-machine.h"
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/core/qdev-properties.h"
@@ -10506,10 +10508,12 @@ static void x86_cpu_initfn(Object *obj)
 
     x86_cpu_init_default_topo(cpu);
 
-    object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
+    object_property_add_qapi(obj, "feature-words",
+                        &X86CPUFeatureWordInfo_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)env->features);
-    object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
+    object_property_add_qapi(obj, "filtered-features",
+                        &X86CPUFeatureWordInfo_type_info,
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features);
 
@@ -10969,7 +10973,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
                               NULL, NULL);
 
 #if !defined(CONFIG_USER_ONLY)
-    object_class_property_add(oc, "crash-information", "GuestPanicInformation",
+    object_class_property_add_qapi(oc, "crash-information",
+                              &GuestPanicInformation_type_info,
                               x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
 #endif
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4714c9d514e..3bdecbe9c5d 100644
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
@@ -1572,7 +1573,8 @@ static void tdx_guest_init(Object *obj)
                             tdx_guest_get_mrownerconfig,
                             tdx_guest_set_mrownerconfig);
 
-    object_property_add(obj, "quote-generation-socket", "SocketAddress",
+    object_property_add_qapi(obj, "quote-generation-socket",
+                            &SocketAddress_type_info,
                             tdx_guest_get_qgs,
                             tdx_guest_set_qgs,
                             NULL, NULL);
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 285f5999661..349f2198c93 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -30,6 +30,7 @@
 #include "system/reset.h"
 #include "qemu/timer.h"
 #include "trace.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "system/hw_accel.h"
 
@@ -130,7 +131,8 @@ void s390_cpu_system_init(Object *obj)
     S390CPU *cpu = S390_CPU(obj);
 
     cs->start_powered_off = true;
-    object_property_add(obj, "crash-information", "GuestPanicInformation",
+    object_property_add_qapi(obj, "crash-information",
+                        &GuestPanicInformation_type_info,
                         s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
     cpu->env.tod_timer =
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);

-- 
2.54.0


