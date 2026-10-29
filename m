Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D23E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BrcgulON
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBu-00008P-Md; Thu, 29 Oct 2026 13:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUB9-0006pX-3N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xMUAr-0003b8-Mw
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:35 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDGNg227428; Thu, 29 Oct 2026 17:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=H5wpOaiIViz
 qveYDE8IUJizXtU+oTDZpnDE+irMlMc8=; b=BrcgulONHwIXyg0IP7kx95dixcZ
 ady1HeyDiweK42PClzwnG9+TbyIv89R3xFG1z44jdBDZJPNskhLnp3DLhCA5v4oX
 KKxQmCXSwYvgQ+Dlz6EmLljNpK8FTOH+J2WEuSenNozUh6yydw6qGuqxckyQH1OX
 LVg6bjDAqS1GxL8vAwXP/Mqgm9E/gjiL1Tgzd5iu+BFQ3Fj9hPVyuZt5G4FmHx4U
 z482aW6tRsB5ElbCm1HRdnMKLEFe919PMVyzTcRicnz3ehl5Ob2sQLIw+B2OsF0X
 cLQj61uF+3chcJJW838OpXNStLs1rHUstuV+8oliWqa79NwoMPC8T3U/dGA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm42fjjpw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:14 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69THiE8f2619245; Thu, 29 Oct 2026 17:44:14 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69THiD4W2619235
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:44:13 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 6D71124CCC; Thu, 29 Oct 2026 10:44:13 -0700 (PDT)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 01/20] target/hexagon: manage HLX contexts through CCR
Date: Thu, 29 Oct 2026 10:43:54 -0700
Message-ID: <20261029174413.643130-2-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXxkiZhNbcI6Cf
 0stk4d6doqJrDYmWhL13bvchyB8sY8mpGoNp+KNnRR9a+vi8bp/X03VVOSASEo+sCWNxWN2MfMf
 xz25FdAJOo6vMsaup15WO0b9qJ0RlxZyTFv5YQtOMFJ2TSx5HMrjK+xudiP/Ltu51UM7zQrSU6Z
 ZSax53wn4XJu+KIfwHV41SxPAq5icpSxGsXVJ5zBZcDFa+ejdfsSL8A/VNBJGaREVqqC6oIoACz
 R2wIMf7B6SUJOhPm2hVZKB8PAt3bzOuWa1E79Uucv5sArcZJkKFh8Hsk3/n0VkGrkrBHWxBmKJZ
 iHwLhkHzGL4x+7LXM2kBVNL8KU3bokpagWxWGM5loH2lzVRAHyFYe6r6aOlyR4/yyj0Id+2chma
 3tQfRkOIfz7Ibrq0oWeoB1fcg9o8Ew==
X-Proofpoint-GUID: Clj4-O8BGxYuw28JULx6otsxaie_Ygmu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfXyJaxRqf3L5oB
 OvPwrsWJNL9Ea8Mylqm+ILNUxYS0KHSaeK2K00le0QlAfS+X2rtghnLLfEc4JXu2wEvG3G5/ACV
 c56wSZJ6V01R7UHORt2nP9EF5JLm/FM=
X-Authority-Analysis: v=2.4 cv=UN9Ijyfy c=1 sm=1 tr=0 ts=6ae385ef cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=LlQuIALrLaYFAbz-TXoA:9
 a=weFjcOMTUDrAlh5w:21
X-Proofpoint-ORIG-GUID: Clj4-O8BGxYuw28JULx6otsxaie_Ygmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add an HLX context pool and select the active context from CCR.XE3
and CCR.XA3. Preserve it across reset, migration and debugger writes.
Commit CCR changes at the packet boundary and end the TB.

Add a CCR enablement test.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 hw/hexagon/hex-subsys.c             |  16 ++++
 hw/hexagon/hexagon_hlx.c            | 113 ++++++++++++++++++++++++++++
 hw/hexagon/meson.build              |   1 +
 include/hw/hexagon/hexagon.h        |   1 +
 include/hw/hexagon/hexagon_hlx.h    |  33 ++++++++
 target/hexagon/cpu.c                |  16 ++++
 target/hexagon/cpu.h                |  20 +++++
 target/hexagon/cpu_helper.c         |  36 +++++++++
 target/hexagon/cpu_helper.h         |   1 +
 target/hexagon/gdbstub.c            |   5 ++
 target/hexagon/genptr.c             |   5 +-
 target/hexagon/helper.h             |   1 +
 target/hexagon/hlx/hlx.h            |  64 ++++++++++++++++
 target/hexagon/machine.c            |  47 +++++++++++-
 target/hexagon/op_helper.c          |   6 ++
 target/hexagon/reg_fields_def.h.inc |   2 +
 target/hexagon/translate.c          |   8 ++
 17 files changed, 372 insertions(+), 3 deletions(-)
 create mode 100644 hw/hexagon/hexagon_hlx.c
 create mode 100644 include/hw/hexagon/hexagon_hlx.h
 create mode 100644 target/hexagon/hlx/hlx.h

diff --git a/hw/hexagon/hex-subsys.c b/hw/hexagon/hex-subsys.c
index 1e6578255e..1a043818f6 100644
--- a/hw/hexagon/hex-subsys.c
+++ b/hw/hexagon/hex-subsys.c
@@ -9,6 +9,7 @@
 #include "qapi/error.h"
 #include "hw/hexagon/hex-subsys.h"
 #include "hw/hexagon/hexagon_globalreg.h"
+#include "hw/hexagon/hexagon_hlx.h"
 #include "hw/hexagon/hexagon_hvx_context.h"
 #include "hw/hexagon/hexagon_tlb.h"
 #include "hw/intc/hex-l2vic.h"
@@ -120,6 +121,18 @@ static void hvx_contexts_create(HexagonCommonMachineState *hms,
     hms->num_hvx_ctx = n;
 }
 
+static DeviceState *hlx_create(HexagonCommonMachineState *hms,
+                               const struct hexagon_machine_config *m_cfg)
+{
+    DeviceState *hlx = qdev_new(TYPE_HEXAGON_HLX);
+
+    object_property_add_child(OBJECT(hms), "hexagon-hlx", OBJECT(hlx));
+    qdev_prop_set_uint32(hlx, "contexts-bitmap", m_cfg->cfgtable.coproc2_reg2);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(hlx), &error_fatal);
+
+    return hlx;
+}
+
 static DeviceState *cluster_create(HexagonCommonMachineState *hms)
 {
     DeviceState *cluster = qdev_new(TYPE_CPU_CLUSTER);
@@ -167,6 +180,7 @@ void hex_subsys_create(HexagonCommonMachineState *hms,
     hms->glob_regs = globalreg_create(hms, m_cfg, rev);
     hms->tlb = tlb_create(hms, m_cfg);
     hvx_contexts_create(hms, m_cfg);
+    hms->hlx = hlx_create(hms, m_cfg);
 }
 
 void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
@@ -178,6 +192,8 @@ void hex_subsys_add_cpu(HexagonCommonMachineState *hms, DeviceState *cpu)
                              &error_fatal);
     object_property_set_link(OBJECT(cpu), "l2vic", OBJECT(hms->l2vic),
                              &error_fatal);
+    object_property_set_link(OBJECT(cpu), "hlx", OBJECT(hms->hlx),
+                             &error_fatal);
     for (unsigned i = 0; i < hms->num_hvx_ctx; i++) {
         g_autofree char *name = g_strdup_printf("hvx-context[%u]", i);
         Object *ctx = object_resolve_path_component(OBJECT(hms), name);
diff --git a/hw/hexagon/hexagon_hlx.c b/hw/hexagon/hexagon_hlx.c
new file mode 100644
index 0000000000..3ac21500e0
--- /dev/null
+++ b/hw/hexagon/hexagon_hlx.c
@@ -0,0 +1,113 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/host-utils.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/hexagon/hexagon_hlx.h"
+#include "migration/vmstate.h"
+
+static int hlx_xa3_to_pool_idx(uint32_t contexts_bitmap, uint32_t xa3)
+{
+    uint32_t below_mask;
+
+    if (!((contexts_bitmap >> xa3) & 1u)) {
+        return -1;
+    }
+    below_mask = (xa3 == 0) ? 0u : ((1u << xa3) - 1u);
+    return ctpop32(contexts_bitmap & below_mask);
+}
+
+HexagonHLXContext *hexagon_hlx_get_context(HexagonHLXState *s, uint32_t xa3)
+{
+    int idx = hlx_xa3_to_pool_idx(s->contexts_bitmap, xa3);
+    if (idx < 0 || idx >= s->num_contexts) {
+        return NULL;
+    }
+    return &s->contexts[idx];
+}
+
+void hexagon_hlx_reset_all(HexagonHLXState *s)
+{
+    if (!s->contexts) {
+        return;
+    }
+    memset(s->contexts, 0, sizeof(HexagonHLXContext) * (size_t)s->num_contexts);
+}
+
+static void hexagon_hlx_realize(DeviceState *dev, Error **errp)
+{
+    HexagonHLXState *s = HEXAGON_HLX(dev);
+
+    s->num_contexts = (int32_t)ctpop32(s->contexts_bitmap);
+    if (s->num_contexts == 0) {
+        s->contexts = NULL;
+        return;
+    }
+    s->contexts = g_new0(HexagonHLXContext, (size_t)s->num_contexts);
+}
+
+static void hexagon_hlx_unrealize(DeviceState *dev)
+{
+    HexagonHLXState *s = HEXAGON_HLX(dev);
+    g_clear_pointer(&s->contexts, g_free);
+    s->num_contexts = 0;
+}
+
+static const Property hexagon_hlx_properties[] = {
+    DEFINE_PROP_UINT32("contexts-bitmap", HexagonHLXState, contexts_bitmap, 0),
+};
+
+/* VMSTATE_BUFFER requires a uint8_t array field. */
+static const VMStateDescription vmstate_hexagon_hlx_context = {
+    .name = "hexagon-hlx-context",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_UNSAFE_INFO_TEST(LRegs, HexagonHLXContext, NULL,
+                                        0, vmstate_info_buffer,
+                                        sizeof_field(HexagonHLXContext,
+                                                     LRegs)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_hexagon_hlx = {
+    .name = TYPE_HEXAGON_HLX,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(contexts_bitmap, HexagonHLXState),
+        VMSTATE_INT32(num_contexts,     HexagonHLXState),
+        VMSTATE_STRUCT_VARRAY_ALLOC(contexts, HexagonHLXState,
+                                    num_contexts, 1,
+                                    vmstate_hexagon_hlx_context,
+                                    HexagonHLXContext),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void hexagon_hlx_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize   = hexagon_hlx_realize;
+    dc->unrealize = hexagon_hlx_unrealize;
+    dc->vmsd      = &vmstate_hexagon_hlx;
+    device_class_set_props(dc, hexagon_hlx_properties);
+}
+
+static const TypeInfo hexagon_hlx_info = {
+    .name          = TYPE_HEXAGON_HLX,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(HexagonHLXState),
+    .class_init    = hexagon_hlx_class_init,
+};
+
+static void hexagon_hlx_register_types(void)
+{
+    type_register_static(&hexagon_hlx_info);
+}
+
+type_init(hexagon_hlx_register_types)
diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
index fa5bc5eb9f..46e9f8de9c 100644
--- a/hw/hexagon/meson.build
+++ b/hw/hexagon/meson.build
@@ -3,6 +3,7 @@ hexagon_ss.add(files('hexagon_tlb.c'))
 hexagon_ss.add(files('hexagon_globalreg.c'))
 hexagon_ss.add(files('hexagon_hvx_context.c'))
 hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hex-subsys.c'))
+hexagon_ss.add(files('hexagon_hlx.c'))
 hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c'))
 hexagon_ss.add(when: 'CONFIG_HEX_BOARD', if_true: files('hex-board.c'))
 hexagon_ss.add(when: 'CONFIG_HEX_VIRT', if_true: files('virt.c'))
diff --git a/include/hw/hexagon/hexagon.h b/include/hw/hexagon/hexagon.h
index 678e658a6d..e01e2bb464 100644
--- a/include/hw/hexagon/hexagon.h
+++ b/include/hw/hexagon/hexagon.h
@@ -187,6 +187,7 @@ struct HexagonCommonMachineState {
     DeviceState *qtimer;
     DeviceState *glob_regs;
     DeviceState *tlb;
+    DeviceState *hlx;
     unsigned num_hvx_ctx;
 };
 
diff --git a/include/hw/hexagon/hexagon_hlx.h b/include/hw/hexagon/hexagon_hlx.h
new file mode 100644
index 0000000000..68c3f001aa
--- /dev/null
+++ b/include/hw/hexagon/hexagon_hlx.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_HEXAGON_HEXAGON_HLX_H
+#define HW_HEXAGON_HEXAGON_HLX_H
+
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "target/hexagon/hlx/hlx.h"
+
+#define TYPE_HEXAGON_HLX "hexagon-hlx"
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonHLXState, HEXAGON_HLX)
+
+typedef struct HexagonHLXContext {
+    HLXVector LRegs[NUM_LREGS] QEMU_ALIGNED(16);
+} HexagonHLXContext;
+
+struct HexagonHLXState {
+    SysBusDevice parent_obj;
+
+    uint32_t contexts_bitmap;
+    int32_t num_contexts;
+    HexagonHLXContext *contexts;
+};
+
+HexagonHLXContext *hexagon_hlx_get_context(HexagonHLXState *s, uint32_t xa3);
+
+void hexagon_hlx_reset_all(HexagonHLXState *s);
+
+#endif
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 281d201250..c3930ab4e4 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -42,6 +42,7 @@
 #include "hexswi.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/page-protection.h"
+#include "hw/hexagon/hexagon_hlx.h"
 #include "exec/target_page.h"
 #include "hw/hexagon/hexagon_globalreg.h"
 #include "hw/hexagon/hexagon_hvx_context.h"
@@ -72,6 +73,8 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
         TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
     DEFINE_PROP_UINT32("htid", HexagonCPU, htid, 0),
+    DEFINE_PROP_LINK("hlx", HexagonCPU, hlx,
+                     TYPE_HEXAGON_HLX, HexagonHLXState *),
 #endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, cfg.lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, cfg.lldb_stack_adjust,
@@ -498,6 +501,12 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     env->cfi_active = 0;
     env->cfi_active_log = 0;
     env->cfi_updated = 0;
+#ifdef CONFIG_USER_ONLY
+    memset(&env->hlx_user_ctx, 0, sizeof(env->hlx_user_ctx));
+    env->hlx_ctx = &env->hlx_user_ctx;
+#else
+    env->hlx_ctx = NULL;
+#endif
 #ifndef CONFIG_USER_ONLY
     memset(env->t_sreg, 0, sizeof(uint32_t) * NUM_SREGS);
     memset(env->greg, 0, sizeof(uint32_t) * NUM_GREGS);
@@ -508,11 +517,18 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 
     env->t_sreg[HEX_SREG_HTID] = cpu->htid;
     env->threadId = cpu->htid;
+    if (cs->cpu_index == 0 && cpu->hlx) {
+        hexagon_hlx_reset_all(cpu->hlx);
+    }
+
     hexagon_cpu_soft_reset(env);
     hexagon_hvx_select_context(env, env->t_sreg[HEX_SREG_SSR]);
     env->cause_code = HEX_EVENT_NONE;
     env->gpr[HEX_REG_PC] = cpu->boot_addr;
 #endif
+
+    memset(env->future_LRegs, 0, sizeof(env->future_LRegs));
+    memset(env->tmp_LRegs, 0, sizeof(env->tmp_LRegs));
 }
 
 static void hexagon_cpu_disas_set_info(const CPUState *cs,
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index feb8036823..904dcc2e7d 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -18,6 +18,13 @@
 #ifndef HEXAGON_CPU_H
 #define HEXAGON_CPU_H
 
+typedef struct HexagonHLXContext HexagonHLXContext;
+
+#ifdef CONFIG_USER_ONLY
+/* linux-user embeds an HLX context and needs the full type. */
+#include "hw/hexagon/hexagon_hlx.h"
+#endif
+
 #include "fpu/softfloat-types.h"
 
 #ifndef CONFIG_USER_ONLY
@@ -30,11 +37,13 @@
 typedef struct HexagonTLBState HexagonTLBState;
 typedef struct HexagonGlobalRegState HexagonGlobalRegState;
 typedef struct HexagonHVXContextState HexagonHVXContextState;
+typedef struct HexagonHLXState HexagonHLXState;
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/target_long.h"
 #include "hex_regs.h"
+#include "hlx/hlx.h"
 #include "mmvec/mmvec.h"
 #include "hw/core/registerfields.h"
 #include "qemu/bitmap.h"
@@ -186,6 +195,16 @@ typedef struct CPUArchState {
 
     MMQReg future_QRegs[NUM_QREGS] QEMU_ALIGNED(16);
 
+    /* Active HLX context, or NULL when disabled or unavailable. */
+    HexagonHLXContext *hlx_ctx;
+
+#ifdef CONFIG_USER_ONLY
+    HexagonHLXContext hlx_user_ctx;
+#endif
+
+    HLXVector future_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
+    HLXVector tmp_LRegs[NUM_LREGS] QEMU_ALIGNED(16);
+
     /* Temporaries used within instructions */
     MMVectorPair VuuV QEMU_ALIGNED(16);
     MMVectorPair VvvV QEMU_ALIGNED(16);
@@ -222,6 +241,7 @@ struct ArchCPU {
     HexagonGlobalRegState *globalregs;
     uint32_t htid;
     HexL2VicInterface *l2vic;
+    HexagonHLXState *hlx;
 #endif
 };
 
diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index baffe6bbaa..940c724be9 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -25,6 +25,7 @@
 #include "macros.h"
 #include "sys_macros.h"
 #include "arch.h"
+#include "hw/hexagon/hexagon_hlx.h"
 
 #ifndef CONFIG_USER_ONLY
 
@@ -327,6 +328,41 @@ static uint32_t set_enable_mask(CPUHexagonState *env)
     return thread_enabled_mask;
 }
 
+void hexagon_modify_ccr(CPUHexagonState *env, uint32_t new, uint32_t old)
+{
+    const uint32_t mask = (1u << reg_field_info[CCR_XA3].offset) |
+                          (1u << reg_field_info[CCR_XE3].offset);
+    bool old_XE3;
+    bool new_XE3;
+    uint32_t old_XA3;
+    uint32_t new_XA3;
+    HexagonCPU *cpu;
+    HexagonHLXState *pool;
+
+    g_assert(bql_locked());
+
+    if (((old ^ new) & mask) == 0) {
+        return;
+    }
+
+    old_XE3 = GET_FIELD(CCR_XE3, old);
+    new_XE3 = GET_FIELD(CCR_XE3, new);
+    old_XA3 = GET_FIELD(CCR_XA3, old);
+    new_XA3 = GET_FIELD(CCR_XA3, new);
+    cpu = HEXAGON_CPU(env_cpu(env));
+    pool = cpu->hlx;
+
+    if (!new_XE3) {
+        env->hlx_ctx = NULL;
+        return;
+    }
+
+    if (!old_XE3 || old_XA3 != new_XA3) {
+        env->hlx_ctx = pool ? hexagon_hlx_get_context(pool, new_XA3) : NULL;
+        /* A missing XA3 context makes HLX instructions trap. */
+    }
+}
+
 static uint32_t clear_enable_mask(CPUHexagonState *env)
 {
     HexagonCPU *cpu;
diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
index b261b9177b..5c0c129dfd 100644
--- a/target/hexagon/cpu_helper.h
+++ b/target/hexagon/cpu_helper.h
@@ -13,6 +13,7 @@ void hexagon_peek_memory_range(CPUHexagonState *env, uint32_t start_addr,
                                uint32_t length, uintptr_t retaddr);
 uint32_t hexagon_get_pmu_counter(CPUHexagonState *cur_env, int index);
 void hexagon_modify_ssr(CPUHexagonState *env, uint32_t new, uint32_t old);
+void hexagon_modify_ccr(CPUHexagonState *env, uint32_t new, uint32_t old);
 unsigned hexagon_hvx_select_context(CPUHexagonState *env, uint32_t ssr);
 int get_cpu_mode(const CPUHexagonState *env);
 int get_exe_mode(const CPUHexagonState *env);
diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 85d9845cc9..5b79e42c4d 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -23,6 +23,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "cpu_helper.h"
 #include "hw/hexagon/hexagon_globalreg.h"
+#include "hw/hexagon/hexagon_hlx.h"
 #endif
 
 int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
@@ -120,6 +121,10 @@ int hexagon_sys_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             uint32_t old = env->t_sreg[HEX_SREG_SSR];
             env->t_sreg[HEX_SREG_SSR] = val;
             hexagon_modify_ssr(env, val, old);
+        } else if (n == HEX_SREG_CCR) {
+            uint32_t old = env->t_sreg[HEX_SREG_CCR];
+            env->t_sreg[HEX_SREG_CCR] = val;
+            hexagon_modify_ccr(env, val, old);
         } else if (n < HEX_SREG_GLB_START) {
             env->t_sreg[n] = val;
         } else if (cpu->globalregs) {
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 7ef36e336f..d0aabacf35 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -287,7 +287,7 @@ static const uint32_t sreg_immut_masks[NUM_SREGS] = {
     [HEX_SREG_STID] = 0xff00ff00,
     [HEX_SREG_ELR] = 0x00000003,
     [HEX_SREG_SSR] = 0x00008000,
-    [HEX_SREG_CCR] = 0x10e0ff24,
+    [HEX_SREG_CCR] = 0x00c0ff24,
     [HEX_SREG_HTID] = IMMUTABLE,
     [HEX_SREG_GEVB] = 0x000000ff,
 };
@@ -308,7 +308,8 @@ static void gen_log_sreg_write(DisasContext *ctx, int rnum, TCGv_i32 val)
     if (reg_mask != IMMUTABLE) {
         if (rnum < HEX_SREG_GLB_START) {
             gen_masked_reg_write(val, hex_t_sreg[rnum], reg_mask);
-            if (ctx->need_commit || rnum == HEX_SREG_SSR) {
+            if (ctx->need_commit || rnum == HEX_SREG_SSR ||
+                rnum == HEX_SREG_CCR) {
                 tcg_gen_mov_i32(ctx->t_sreg_new_value[rnum], val);
             } else {
                 tcg_gen_mov_i32(hex_t_sreg[rnum], val);
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 8c49e79809..8a2a6563d2 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -147,6 +147,7 @@ DEF_HELPER_1(wait, void, env)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
+DEF_HELPER_3(modify_ccr, void, env, i32, i32)
 DEF_HELPER_1(pending_interrupt, void, env)
 DEF_HELPER_2(tlbinvasid, void, env, i32)
 #endif
diff --git a/target/hexagon/hlx/hlx.h b/target/hexagon/hlx/hlx.h
new file mode 100644
index 0000000000..81c0434df7
--- /dev/null
+++ b/target/hexagon/hlx/hlx.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HEXAGON_HLX_H
+#define HEXAGON_HLX_H
+
+#define NUM_LREGS 16
+#define HLX_VEC_SIZE_BYTES 2048
+
+typedef union {
+    uint8_t  ub[4];
+    int8_t   b[4];
+    uint16_t uh[2];
+    int16_t  h[2];
+    uint32_t uw;
+    int32_t  w;
+} lreg_element_t;
+
+typedef struct {
+    union {
+        uint64_t ud[HLX_VEC_SIZE_BYTES / 8];
+        int64_t  d[HLX_VEC_SIZE_BYTES / 8];
+        uint32_t uw[HLX_VEC_SIZE_BYTES / 4];
+        int32_t  w[HLX_VEC_SIZE_BYTES / 4];
+        uint16_t uh[HLX_VEC_SIZE_BYTES / 2];
+        int16_t  h[HLX_VEC_SIZE_BYTES / 2];
+        uint8_t  ub[HLX_VEC_SIZE_BYTES / 1];
+        int8_t   b[HLX_VEC_SIZE_BYTES / 1];
+    };
+} HLXVector;
+
+typedef union {
+    lreg_element_t l[HLX_VEC_SIZE_BYTES / 2];
+} HLXVectorPair;
+
+static inline HLXVector hlx_zero_vector(void)
+{
+    HLXVector ret;
+    memset(&ret, 0, sizeof(ret));
+    return ret;
+}
+
+/* Interleave separate low and high halfwords as {lo, hi}. */
+static inline void hlx_interleave_pair(HLXVectorPair *pair,
+                                       const HLXVector *lo,
+                                       const HLXVector *hi)
+{
+    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 2; i++) {
+        pair->l[i].h[0] = lo->h[i];
+        pair->l[i].h[1] = hi->h[i];
+    }
+}
+
+static inline void hlx_deinterleave_pair(HLXVector *lo, HLXVector *hi,
+                                         const HLXVectorPair *pair)
+{
+    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 2; i++) {
+        lo->h[i] = pair->l[i].h[0];
+        hi->h[i] = pair->l[i].h[1];
+    }
+}
+
+#endif
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
index 6a41551d8f..4d2b09c519 100644
--- a/target/hexagon/machine.c
+++ b/target/hexagon/machine.c
@@ -5,23 +5,67 @@
  */
 
 #include "qemu/osdep.h"
+#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "cpu.h"
 #include "cpu_helper.h"
+#include "macros.h"
+#include "hlx/hlx.h"
+#include "hw/hexagon/hexagon_hlx.h"
 
 static int hexagon_cpu_post_load(void *opaque, int version_id)
 {
     HexagonCPU *cpu = opaque;
     CPUHexagonState *env = &cpu->env;
+    uint32_t ccr;
+    bool xe3;
+    uint32_t xa3;
 
     hexagon_hvx_select_context(env, env->t_sreg[HEX_SREG_SSR]);
+    if (!cpu->hlx) {
+        env->hlx_ctx = NULL;
+        return 0;
+    }
 
+    ccr = env->t_sreg[HEX_SREG_CCR];
+    xe3 = GET_FIELD(CCR_XE3, ccr);
+    xa3 = GET_FIELD(CCR_XA3, ccr);
+    env->hlx_ctx = xe3 ? hexagon_hlx_get_context(cpu->hlx, xa3) : NULL;
     return 0;
 }
 
+static int get_hlxvector(QEMUFile *f, void *pv, size_t size,
+                         const VMStateField *field)
+{
+    HLXVector *v = pv;
+    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 8; i++) {
+        v->ud[i] = qemu_get_be64(f);
+    }
+    return 0;
+}
+
+static int put_hlxvector(QEMUFile *f, void *pv, size_t size,
+                         const VMStateField *field, JSONWriter *vmdesc)
+{
+    HLXVector *v = pv;
+    for (int i = 0; i < HLX_VEC_SIZE_BYTES / 8; i++) {
+        qemu_put_be64(f, v->ud[i]);
+    }
+    return 0;
+}
+
+static const VMStateInfo vmstate_info_hlxvector = {
+    .name = "hlxvector",
+    .get  = get_hlxvector,
+    .put  = put_hlxvector,
+};
+
+#define VMSTATE_HLXVECTOR_ARRAY_V(_f, _s, _n, _v) \
+    VMSTATE_SUB_ARRAY(_f, _s, 0, _n, _v, vmstate_info_hlxvector, HLXVector)
 const VMStateDescription vmstate_hexagon_cpu = {
     .name = "cpu",
-    .version_id = 3,
+    .version_id = 4,
     .minimum_version_id = 2,
     .post_load = hexagon_cpu_post_load,
     .fields = (const VMStateField[]) {
@@ -38,6 +82,7 @@ const VMStateDescription vmstate_hexagon_cpu = {
         VMSTATE_UNUSED(sizeof(uint64_t)),
         VMSTATE_UINT32(env.imprecise_exception, HexagonCPU),
         VMSTATE_UINT32_V(env.cfi_active, HexagonCPU, 3),
+        VMSTATE_HLXVECTOR_ARRAY_V(env.future_LRegs, HexagonCPU, NUM_LREGS, 4),
 
         VMSTATE_END_OF_LIST()
     },
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 6076a5f29f..477c8d6b66 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1356,6 +1356,12 @@ void HELPER(modify_ssr)(CPUHexagonState *env, uint32_t new, uint32_t old)
     hexagon_modify_ssr(env, new, old);
 }
 
+void HELPER(modify_ccr)(CPUHexagonState *env, uint32_t new, uint32_t old)
+{
+    BQL_LOCK_GUARD();
+    hexagon_modify_ccr(env, new, old);
+}
+
 static void hex_k0_lock(CPUHexagonState *env, uint32_t PC)
 {
     HexagonCPU *cpu = env_archcpu(env);
diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
index 21babbbb98..a490b0e07f 100644
--- a/target/hexagon/reg_fields_def.h.inc
+++ b/target/hexagon/reg_fields_def.h.inc
@@ -130,10 +130,12 @@ DEF_REG_FIELD(CCR_HFIL2, 18, 1)
 DEF_REG_FIELD(CCR_HFDL2, 19, 1)
 DEF_REG_FIELD(CCR_SFD, 20, 1)
 
+DEF_REG_FIELD(CCR_XA3, 21, 1)
 DEF_REG_FIELD(CCR_GIE, 24, 1)
 DEF_REG_FIELD(CCR_GTE, 25, 1)
 DEF_REG_FIELD(CCR_GEE, 26, 1)
 DEF_REG_FIELD(CCR_GRE, 27, 1)
+DEF_REG_FIELD(CCR_XE3, 28, 1)
 DEF_REG_FIELD(CCR_VV1, 29, 1)
 DEF_REG_FIELD(CCR_VV2, 30, 1)
 DEF_REG_FIELD(CCR_VV3, 31, 1)
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 91925d2ddb..ed246e226f 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -345,6 +345,7 @@ static bool need_slot_cancelled(Packet *pkt)
 static bool sreg_write_ends_tb(int reg_num)
 {
     return reg_num == HEX_SREG_SSR ||
+           reg_num == HEX_SREG_CCR ||
            reg_num == HEX_SREG_STID ||
            reg_num == HEX_SREG_IMASK ||
            reg_num == HEX_SREG_IPENDAD ||
@@ -986,6 +987,13 @@ static void gen_sreg_writes(DisasContext *ctx)
             tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
             gen_helper_modify_ssr(tcg_env, ctx->t_sreg_new_value[reg_num],
                                   old_reg);
+        } else if (reg_num == HEX_SREG_CCR) {
+            tcg_gen_mov_tl(old_reg, hex_t_sreg[reg_num]);
+            tcg_gen_mov_tl(hex_t_sreg[reg_num], ctx->t_sreg_new_value[reg_num]);
+            gen_helper_modify_ccr(tcg_env, ctx->t_sreg_new_value[reg_num],
+                                  old_reg);
+            /* A CCR write can change context, so end the TB. */
+            ctx->base.is_jmp = DISAS_NORETURN;
         } else if ((reg_num == HEX_SREG_STID) ||
                     (reg_num == HEX_SREG_IMASK) ||
                    (reg_num == HEX_SREG_IPENDAD) ||
-- 
2.43.0


