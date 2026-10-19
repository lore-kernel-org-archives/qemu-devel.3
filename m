Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F24CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDh-0002QE-Fh; Mon, 19 Oct 2026 10:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDO-0002Er-V9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDJ-0005aj-1x
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IhSgQDlIy9yx+J/WDOeDBd025kinnap1bcpRWub7oU0=;
 b=gFDNQprVHa+MM+AjCNMAMZTL3Xe8/Ob3ENb9PuPnK1NpnkwGCEjTykquz4N8oL6FbIYHar
 9t2KNyVSMd3Rk7sHTk38+iGnYfzdS/4oXjjVsJ6ve3nXxv4pjjyzVxhu3XpWjRG1VjE6NL
 Mv1Gb0v4qvFmvfxddMi9oExa1VVzCzs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-gmv2W9fWOL--ARy_Sfph0w-1; Mon,
 19 Oct 2026 14:19:42 +0000
X-MC-Unique: gmv2W9fWOL--ARy_Sfph0w-1
X-Mimecast-MFC-AGG-ID: gmv2W9fWOL--ARy_Sfph0w_1792419581
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 430371954ACF; Mon, 19 Oct 2026 14:19:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD981955F01; Mon, 19 Oct 2026 14:19:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5ECE521E683D; Mon, 19 Oct 2026 16:19:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 49/65] include: add QEMU_REPEAT helper macro
Date: Mon, 19 Oct 2026 16:19:13 +0200
Message-ID: <20261019141929.1594337-50-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Introduce a macro used in following commit, and convert a few existing
candidates. Inspired by a similar macro in Linux kernel/trace/bpf_trace.c

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/cxl/cxl_component.h |  5 +----
 include/qemu/osdep.h           | 33 +++++++++++++++++++++++++++++++++
 hw/misc/tz-ppc.c               | 19 ++-----------------
 hw/remote/vfio-user-obj.c      | 17 +++--------------
 4 files changed, 39 insertions(+), 35 deletions(-)

diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index ffc8220220..fca8b7055c 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -186,10 +186,7 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
 /* Support 4 decoders at all levels of topology */
 #define CXL_HDM_DECODER_COUNT 4
 
-HDM_DECODER_INIT(0);
-HDM_DECODER_INIT(1);
-HDM_DECODER_INIT(2);
-HDM_DECODER_INIT(3);
+QEMU_REPEAT(CXL_HDM_DECODER_COUNT, HDM_DECODER_INIT)
 
 /*
  * CXL r3.1 Section 8.2.4.21: CXL Extended Security Capability Structure
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230..a5e7ff99cb 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -191,6 +191,39 @@ extern "C" {
 
 #include "qemu/typedefs.h"
 
+/*
+ * QEMU_REPEAT(n, m) - invoke m(0) m(1) ... m(n-1)
+ *
+ * Expands to n invocations of m, each with a literal integer argument.
+ * n must be a compile-time constant in 0..16.
+ *
+ * Example - generate 4 per-index function definitions:
+ *
+ *   #define DEFINE_GETTER(i) \
+ *   static int get_##i(void) { return values[i]; }
+ *
+ *   QEMU_REPEAT(4, DEFINE_GETTER)
+ */
+#define QEMU_REPEAT_0(m)
+#define QEMU_REPEAT_1(m)   QEMU_REPEAT_0(m)   m(0)
+#define QEMU_REPEAT_2(m)   QEMU_REPEAT_1(m)   m(1)
+#define QEMU_REPEAT_3(m)   QEMU_REPEAT_2(m)   m(2)
+#define QEMU_REPEAT_4(m)   QEMU_REPEAT_3(m)   m(3)
+#define QEMU_REPEAT_5(m)   QEMU_REPEAT_4(m)   m(4)
+#define QEMU_REPEAT_6(m)   QEMU_REPEAT_5(m)   m(5)
+#define QEMU_REPEAT_7(m)   QEMU_REPEAT_6(m)   m(6)
+#define QEMU_REPEAT_8(m)   QEMU_REPEAT_7(m)   m(7)
+#define QEMU_REPEAT_9(m)   QEMU_REPEAT_8(m)   m(8)
+#define QEMU_REPEAT_10(m)  QEMU_REPEAT_9(m)   m(9)
+#define QEMU_REPEAT_11(m)  QEMU_REPEAT_10(m)  m(10)
+#define QEMU_REPEAT_12(m)  QEMU_REPEAT_11(m)  m(11)
+#define QEMU_REPEAT_13(m)  QEMU_REPEAT_12(m)  m(12)
+#define QEMU_REPEAT_14(m)  QEMU_REPEAT_13(m)  m(13)
+#define QEMU_REPEAT_15(m)  QEMU_REPEAT_14(m)  m(14)
+#define QEMU_REPEAT_16(m)  QEMU_REPEAT_15(m)  m(15)
+#define QEMU_REPEAT_(n, m) QEMU_REPEAT_##n(m)
+#define QEMU_REPEAT(n, m)  QEMU_REPEAT_(n, m)
+
 /**
  * Mark a function that executes in coroutine context
  *
diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
index 6f820430ee..5f09ce164c 100644
--- a/hw/misc/tz-ppc.c
+++ b/hw/misc/tz-ppc.c
@@ -303,26 +303,11 @@ static const VMStateDescription tz_ppc_vmstate = {
 
 #define DEFINE_PORT(N)                                          \
     DEFINE_PROP_LINK("port[" #N "]", TZPPC, port[N].downstream, \
-                     TYPE_MEMORY_REGION, MemoryRegion *)
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 
 static const Property tz_ppc_properties[] = {
     DEFINE_PROP_UINT32("NONSEC_MASK", TZPPC, nonsec_mask, 0),
-    DEFINE_PORT(0),
-    DEFINE_PORT(1),
-    DEFINE_PORT(2),
-    DEFINE_PORT(3),
-    DEFINE_PORT(4),
-    DEFINE_PORT(5),
-    DEFINE_PORT(6),
-    DEFINE_PORT(7),
-    DEFINE_PORT(8),
-    DEFINE_PORT(9),
-    DEFINE_PORT(10),
-    DEFINE_PORT(11),
-    DEFINE_PORT(12),
-    DEFINE_PORT(13),
-    DEFINE_PORT(14),
-    DEFINE_PORT(15),
+    QEMU_REPEAT(TZ_NUM_PORTS, DEFINE_PORT)
 };
 
 static void tz_ppc_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 7e6819f670..84c3ff05cf 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -496,22 +496,11 @@ static size_t vfu_object_bar_rw(PCIDevice *pci_dev, int pci_bar,
                                  buf, count, is_write);                        \
     }                                                                          \
 
-VFU_OBJECT_BAR_HANDLER(0)
-VFU_OBJECT_BAR_HANDLER(1)
-VFU_OBJECT_BAR_HANDLER(2)
-VFU_OBJECT_BAR_HANDLER(3)
-VFU_OBJECT_BAR_HANDLER(4)
-VFU_OBJECT_BAR_HANDLER(5)
-VFU_OBJECT_BAR_HANDLER(6)
+QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER)
 
+#define VFU_OBJECT_BAR_HANDLER_PTR(BAR_NO) vfu_object_bar##BAR_NO##_handler,
 static vfu_region_access_cb_t *vfu_object_bar_handlers[PCI_NUM_REGIONS] = {
-    &vfu_object_bar0_handler,
-    &vfu_object_bar1_handler,
-    &vfu_object_bar2_handler,
-    &vfu_object_bar3_handler,
-    &vfu_object_bar4_handler,
-    &vfu_object_bar5_handler,
-    &vfu_object_bar6_handler,
+    QEMU_REPEAT(PCI_NUM_REGIONS, VFU_OBJECT_BAR_HANDLER_PTR)
 };
 
 /**
-- 
2.55.0


