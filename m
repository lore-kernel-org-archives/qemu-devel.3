Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F259EC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2zE-00083T-R7; Wed, 12 Aug 2026 03:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2z3-0007zI-6X
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:02:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu2yy-00011J-Sw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:02:38 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62EpD2992730
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=82l3PjnXb0G
 ZlmKaawQ08Xl5HnrTAdtiJbEN8JRS2d0=; b=pB6uaM69JkRBrvXWCdfgPGORFoU
 Xq6pjng2pYKwlvGxjgb8QJub+oC1l0HXS9NGkvGc2Osppbw9xt9zWc3jiFCDXmZh
 NewoJ9C0YbHkipuLHLSb2PqL8TXJWVKWHOlILxdzimyb5T79QTCrlXEpHxkh6J3O
 aUmCY03qxVA6zDV+b7WMfFza6EMBFwygJo5659Lf/55cLFYJ4XjmlxAhPiordLxE
 ZzE9KMULdWMhNMWbeIjVt9+SQiuP/hOnVBC0fGE4WEWahANSukHEYFNiLEwhhRQ3
 GGE5XZ2DCg9IE2ShRlASv8N+FwncJTJlTxnQ66tw4IhehKCcQSqdYD5CFpQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049dkxm2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:02:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc98d6a88bso2009355ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786518153; x=1787122953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82l3PjnXb0GZlmKaawQ08Xl5HnrTAdtiJbEN8JRS2d0=;
 b=GvbDhScLYioP3rtwfFCrai3yvn1Ty9aC7MBxUOIhfcp/Ffe//ZCL3GXRcRkCqkmy+a
 f4rx7sbMseGzQCzDpbX/7wG7I2m9PGBiiWNg8Zn34P3qhX/m22JOHwI01TbW30PUOSit
 J8pAnvV7D6nOe5r+B88CWUIWNEXw9zJUal+nqNioDkPAuo+IGTYOv+F641Him35g1llW
 Npjn73tq8ZRIpOPsq4nmF+7GrGVGCbDWSMnldi7A/qZyKykxScRaF9BNcnKlPbPGw+12
 xaSP6MPlHoC05Hq+jlaZEyaP2vX5O/rPYhtBaENYtisbhiG0EfOrbLTZCv9zB8DIOxF9
 Gmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786518153; x=1787122953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=82l3PjnXb0GZlmKaawQ08Xl5HnrTAdtiJbEN8JRS2d0=;
 b=ECMtKr/1crE9zzn4frEFqRawJEjaWH5SZ04JA2DyQ4N+0QYsupeLjFIuhhj6Hp3cfU
 ZqxYhtyuiYWOEWcH5fUJNxttSDjsHX1TLlnE/vivOS/4bRjY03W8dwO2xeCIjUxJwm4R
 2pWNva1Q4ojW0Rhf6KyAcAzXUQQOx7qLnaxvmjx4gqwgFJX6TdNyzNkZbf9irfiIbRBF
 LQGytMKXbwY/C50uRTu4ARXSWNw1MD6eC6nLe3goVSyJ0OzBPd77oF7VMu+/kAoU2kng
 Oa41B3tC/Xdm9nyXPNMEKM2Y+w8lVObRthKoMGAdeT1QrJBysxdTtKPNao7Q4IuieruE
 6Cvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RooJv4OtuctWKRAmDAkoZ2V323quRptckGE/lLrKYFSWSSW0aFzKDBT3dkHjwjEeONTLry5aFDjhg4S@nongnu.org
X-Gm-Message-State: AOJu0YygoqLPgie7QUARKrlFXzvog0hyeyxao/L5atEcfc4rLox3ZFzq
 2FgtkB0CLnNb5AuBoi/tZi/9vUG1qTcYflv/SKfVbQWc68LTT+O5e265RFQ3GzxP8W4Y7EuZBaE
 86scG8oDdpl6T67qKeSwB1EWQSxZXDNmI/A7oepxctJUnoO6QYERatNnMRQ==
X-Gm-Gg: AR+sD12wUF3WOPf23Z0Msrt/5KDbPvyH/tOhMSApTNspF26xGyNORJRUzrPzkQFfssR
 5kRDHD5C3ZBhMbn3ZOEVV0y1eP1uAGksDokObFHQQomMTDSA4GLOWvC8G2KB3g+hfB0IidF07cG
 W9950QO0t3A11uIVccpqGwf8Ar3i6XHZP8i9N9FXsQ/ATZaXzGcVOPOqXRs7ZUSmzD+Sxxusnx8
 NevGePbnKR1znzXupBoi5sI8H3dN+E4MmiXz7O9/XIDWZRfu3TeWruTJwvJ8pt0D7zKLR/CezUp
 pxUfuy0eJuwDOHNQm2qu7PRf6Dvb09VKanOWwY2MMnmuGbyshtr/ZJW0eIBOf6PrUye7j3lf3+0
 mKVOuCR1lC3E+IhkRBPagVZeuj1lQYnwU6RV9ce0HPl+yqBwIhgyDn1FyTyQ+owy8iirymgZwzi
 oI47w0PrE/zPlXyOfcFB0JrkatybUD1qI=
X-Received: by 2002:a17:903:292:b0:2cc:f4d4:29a0 with SMTP id
 d9443c01a7336-2d3456c187amr27918895ad.3.1786518153478; 
 Wed, 12 Aug 2026 00:02:33 -0700 (PDT)
X-Received: by 2002:a17:903:292:b0:2cc:f4d4:29a0 with SMTP id
 d9443c01a7336-2d3456c187amr27918375ad.3.1786518152830; 
 Wed, 12 Aug 2026 00:02:32 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31cf3c08163sm6796627eec.7.2026.08.12.00.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 00:02:32 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v6 03/10] hw/riscv: add RPMI FDT helpers
Date: Wed, 12 Aug 2026 12:31:25 +0530
Message-ID: <20260812070133.3059679-4-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812070133.3059679-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX29mFMWI8QVTo
 J3sW33g2PxkOHrzxrQejMYBFl2PZKqdu/nKOdm9XKqdJNgCESQ6e+f68GaSEr7mylN2MefLTMVT
 r3YGdi50MYd6uWGLDTvlDe+7PsUmSU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX3yfvDr+0eh1t
 3811X+qehqSEm/VzVhfUlt8epcyxLTTzERqfkJ5VTT/msuqUg12Hb966ZOFskKesankZE7zIS5/
 4H577Ty/laPm4yoocjH7fnavmihJok7Jg86M6MHyiOGChZY3u2waDD2IvXOcPSfvR2IXM1j9ukb
 UCqTtonpSyqcf0lh705RkT9GAT9o1iQzFTyRjEKxJhgwnS4Fw8Xa+9RWoMkUVm+z/rW5XGLKHOv
 yLSpPRJoxtjeYdNx5gC4ao9x5dJFuhz66vs+jwYDivShHdnj+3VZ+PDloG7QEpvUm5Yx1DFhab9
 N3OAlCFrLwz0qSBLY0cD82OV8EoNGheCp/FsGPhezkdEvlNRyfueSgXP0wdl+yCou8WzmHtwv1o
 zEB+TcRD4n+OrXORm6ZQz8oJUlvNVs+DrHmc4IL7e5X+00jwbBDPzzjjf0NqyLjIp8lxVKXHrDq
 neGdUYsU516xBVIw63Q==
X-Proofpoint-GUID: BJ1_mmQ873_4D_Jq725oaCh1bGm0SqhQ
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7c1a8a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: BJ1_mmQ873_4D_Jq725oaCh1bGm0SqhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add helper routines for describing RPMI shared-memory mailbox transports
and service child nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build        |   1 +
 hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b70a054579..ae69426eb1 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: files('rpmi-fdt.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
new file mode 100644
index 0000000000..439c91c894
--- /dev/null
+++ b/hw/riscv/rpmi-fdt.c
@@ -0,0 +1,103 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI device-tree helpers
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "hw/riscv/rpmi-fdt.h"
+#include "hw/misc/riscv_rpmi.h"
+#include "system/device_tree.h"
+
+void riscv_rpmi_fdt_add_mbox(void *fdt,
+                             const RiscvRpmiFdtMboxConfig *cfg,
+                             uint32_t *phandle,
+                             uint32_t *mbox_handle)
+{
+    g_autofree char *name = NULL;
+    hwaddr a2p_req_base, p2a_ack_base, p2a_req_base, a2p_ack_base;
+    static const char * const regnames_all[RPMI_ALL_NUM_REGS] = {
+        "a2p-req", "p2a-ack", "p2a-req", "a2p-ack", "a2p-doorbell"
+    };
+    static const char * const regnames_a2p[RPMI_A2P_NUM_REGS] = {
+        "a2p-req", "p2a-ack", "a2p-doorbell"
+    };
+
+    a2p_req_base = cfg->shmem_base;
+    p2a_ack_base = a2p_req_base + cfg->a2p_req_size;
+    p2a_req_base = p2a_ack_base + cfg->a2p_req_size;
+    a2p_ack_base = p2a_req_base + cfg->p2a_req_size;
+
+    *mbox_handle = (*phandle)++;
+    name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx, cfg->shmem_base);
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,rpmi-shmem-mbox");
+    qemu_fdt_setprop_cell(fdt, name, "riscv,slot-size", RPMI_QUEUE_SLOT_SIZE);
+    qemu_fdt_setprop_cell(fdt, name, "#mbox-cells", 1);
+
+    if (cfg->p2a_req_size) {
+        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
+                                      (char **)&regnames_all,
+                                      ARRAY_SIZE(regnames_all));
+        qemu_fdt_setprop_cells(fdt, name, "reg",
+            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_req_base >> 32), (uint32_t)p2a_req_base,
+            0x0, cfg->p2a_req_size,
+            (uint32_t)(a2p_ack_base >> 32), (uint32_t)a2p_ack_base,
+            0x0, cfg->p2a_req_size,
+            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
+            0x0, cfg->doorbell_size);
+    } else {
+        qemu_fdt_setprop_string_array(fdt, name, "reg-names",
+                                      (char **)&regnames_a2p,
+                                      ARRAY_SIZE(regnames_a2p));
+        qemu_fdt_setprop_cells(fdt, name, "reg",
+            (uint32_t)(a2p_req_base >> 32), (uint32_t)a2p_req_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(p2a_ack_base >> 32), (uint32_t)p2a_ack_base,
+            0x0, cfg->a2p_req_size,
+            (uint32_t)(cfg->doorbell_base >> 32), (uint32_t)cfg->doorbell_base,
+            0x0, cfg->doorbell_size);
+    }
+
+    qemu_fdt_setprop_cells(fdt, name, "phandle", *mbox_handle);
+}
+
+void riscv_rpmi_fdt_add_service(void *fdt, hwaddr shmem_base,
+                                const char *node_name,
+                                const char *compatible,
+                                uint32_t mbox_handle,
+                                uint32_t service_group,
+                                bool has_mpxy_channel,
+                                uint32_t mpxy_channel)
+{
+    g_autofree char *name = g_strdup_printf("/soc/mailbox@%" HWADDR_PRIx "/%s",
+                                            shmem_base, node_name);
+
+    qemu_fdt_add_subnode(fdt, name);
+    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
+    qemu_fdt_setprop_cells(fdt, name, "mboxes", mbox_handle, service_group);
+    if (has_mpxy_channel) {
+        qemu_fdt_setprop_cell(fdt, name, "riscv,sbi-mpxy-channel-id",
+                              mpxy_channel);
+    }
+}
+
+void riscv_rpmi_fdt_add_service_node(void *fdt, hwaddr shmem_base,
+                                     const RiscvRpmiServiceConfig *service,
+                                     uint32_t mbox_handle)
+{
+    riscv_rpmi_fdt_add_service(fdt, shmem_base, service->node_name,
+                               service->compatible, mbox_handle,
+                               service->service_group,
+                               service->has_mpxy_channel,
+                               service->mpxy_channel);
+}
diff --git a/include/hw/riscv/rpmi-fdt.h b/include/hw/riscv/rpmi-fdt.h
new file mode 100644
index 0000000000..b157bda1d1
--- /dev/null
+++ b/include/hw/riscv/rpmi-fdt.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI device-tree helpers
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#ifndef HW_RISCV_RPMI_FDT_H
+#define HW_RISCV_RPMI_FDT_H
+
+#include "exec/hwaddr.h"
+#include "hw/misc/riscv_rpmi.h"
+
+typedef struct RiscvRpmiFdtMboxConfig {
+    hwaddr shmem_base;
+    hwaddr doorbell_base;
+    uint32_t a2p_req_size;
+    uint32_t p2a_req_size;
+    uint32_t doorbell_size;
+} RiscvRpmiFdtMboxConfig;
+
+void riscv_rpmi_fdt_add_mbox(void *fdt,
+                             const RiscvRpmiFdtMboxConfig *cfg,
+                             uint32_t *phandle,
+                             uint32_t *mbox_handle);
+
+#endif
-- 
2.43.0


