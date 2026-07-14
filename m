Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77627C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjY29-0002sT-J3; Tue, 14 Jul 2026 03:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY28-0002s4-Pb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wjY26-0003eU-FO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 03:58:28 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SKPq3912619
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=K4SlKOD1/vx
 0Y6pFxA52n0uwz9eJFLoRt8gU9Kdo/tY=; b=HxaueUI3rK6YLC/I6R8H3BgFyWU
 ypoDDgu1rS5/HLeKvwtp1F8PrdYGTg3q6bBE9Thkiz+7PaLOQ954ozlPTzIEMuAH
 v2i5j/SSRuf/PNz/xj/IKvPfHa1wdCxfIUDuN0y/gDlCbQsXPiCLPFe23V9JT0D2
 LowVDcG2TbFOXcJ5yjiTAMJDqTHS7z0pGRmnxB+Zrt8X7zDniJ3nSAjk3Ojdev94
 nAwF32P+ogevfq8IMd3fn9s5Wn6HDV1xDek++7HDQYK6g4+MjLeunpYbOOYEc6aW
 A4X2Hycf6tLkEoCllJo+caMtEe4zuVLl3vn1HngVGwHHlDgW22HEBqlO71Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdeu4gmw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:58:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca6a6373ad4so453536a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784015904; x=1784620704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K4SlKOD1/vx0Y6pFxA52n0uwz9eJFLoRt8gU9Kdo/tY=;
 b=UwPq4uJlCYO0NSDinn+QSVum9J7DqqmgsYYPRo/0RrOSkOwcHgasOLm4H5Or/fhHj1
 Ny9+omhMIuBo2MzX1K8KLB1icDtKSebARBuhwq997U63IRac+po0SrDLo4Q0K6rWT5kS
 v6pV62SRqftwLR6X191DNjnDCpYoO0WD0EaqOHxCwV3G/WPTxI/8BvbOvJM1l2m7nvf9
 1V6+B59nGNNn1Go1gNbA6vlgA878C06r+5TxPDAdqYwsTerqWxxm7SEZLzzqAMEAqAsF
 WUkrg2RBOdaY6o0wC8RGKQ5eCIsuQVbim8fSOge5tHWE4U0hgjzN3QqoNTUheCEg+ode
 av1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784015904; x=1784620704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K4SlKOD1/vx0Y6pFxA52n0uwz9eJFLoRt8gU9Kdo/tY=;
 b=C0hhWbBsBM4SbQkzbUHEmbC2+dLH4l8B3Nhw+MPErCAo+c0G9r+9Of5c4X32WSNJoH
 1vGTL2+3Yr4xO4zYdO5jWryN7JgB2cHiS2txJ6V/3+UbMk9a5HBO4GZutwteGJey7u8B
 fSXHIbyCsQXBJ/LTsFgLCYwk8rWQVnXuJlyMZKI/6jou6k5O1Q6+hOQas+4XDrGvVAjf
 crlqeeHhzz2PvduEHT1uq/kpS/8H8vEabRNsnUugCTzJM2TCxlNbB6P7fA35pTD/J9Rx
 0Y6I1B9skDi6JJA3P+/Y2mSeZ46ykOJzH07ygs4C38xOxZXTZBBIxKB4bRWxtJaXpvir
 ugjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RonDvbgXLYNuGsno2Xn+3Uo4LD5L8K5KqN5YZqEAQVtnV9qEnAzWBq/oIE5LYVbJfM5RzOIhQXHm5ji@nongnu.org
X-Gm-Message-State: AOJu0YzcrsnRKoZ1vCIcitkEScD932AoA80Psxg8yRQFRCJYjlUPsL/u
 05GQa7qfQ6xXD+BgBjhdAI71e/3pIxvkAtcVVCc0Mbp0WI12qGQ35StIWb1JQRYpyp7iDbp2+Zx
 z029/DagsD1vJJVRRo6t+5okpnS31wbQ6US9WZ4RNOHcJIqz7mK76xyI65A==
X-Gm-Gg: AfdE7cklt2oTR2IYjNhFaCMcY14l/yw8OyXuI5ZditDztasxoUNErnYRXjISFUARXtg
 DeKUwDCa1hgo1u/mzrpFsnnAYWDK3c5KWzl3srKrN1eQEfhglSCdo+jj2Ly4aKbkh70jnt9gv1+
 0MpWwnyc81tAjbvxnlLPoM1cyYCQn7Q/wLQrP/NkCGFgd1NGe6DwUjrLA6vYk0s1mpHI4OYAOma
 FqtxSAlNH2Jzxg6JuEdRFBXS47IpzE04pN+s8pVs9DrQcVlL/HE82pIbxbn1CUQpQgnaS94aULs
 SfBYZdTl3HLlbEx+CXGrQTShv7+VA3SWy/DyxQLyUzMutWd8VPMbbE1Zu5RCuElQPWljKLQF2KV
 ewYDcbUjkRYyBdP1rI3yqSFZt6hO4lVGCCvKh+sbFd9Xc09RNdi7lFRoj0lr2sqe+kJB3Ab6wTY
 GIfwiPZYGlrWFg7SvUwxGZpIRMotM4+iMTe3Y6LFBIGw==
X-Received: by 2002:a17:90b:5209:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-38dc77e8861mr8801727a91.8.1784015904235; 
 Tue, 14 Jul 2026 00:58:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5209:b0:37f:eac0:18f6 with SMTP id
 98e67ed59e1d1-38dc77e8861mr8801708a91.8.1784015903798; 
 Tue, 14 Jul 2026 00:58:23 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311950eb930sm55606355eec.8.2026.07.14.00.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 00:58:23 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v3 07/10] riscv: add RPMI system suspend service
Date: Tue, 14 Jul 2026 13:26:56 +0530
Message-ID: <20260714075659.2258023-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260714075659.2258023-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zuNVULC6DN8XM3yGYlkm-uZoI99G2w3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX/DFkbgMb2gZ2
 Ft8GMqg6cVuCnXL5pB3sHDMKfdhbJwiNONCyJjolsyRjK/fSegS74/R+YKEoGdNyH3v+DZsipap
 0TZZfKzHw/pGemCDFT+cW58KgiKX5SKOFZiX3q79k4cinZqc5jgcXyaipHhpQxGcfPlH7XTKYOc
 7IYm+HVxuHYS29FImGBQq5lcp9AljzY2CjASUvEoRgcdV2JABx+kNOHK8DC+I6PvG5d+2ZYTxqj
 KhksgkUe2nvRZGhU67fTP8tAAcWXF9tmgp3tn+CAbMQE70Q/vg+1ElBAecR2q0ITpBn18QfePxP
 /g/v/B/nZx6r6kck+1fkezO6w/WqGNyRqEjBT7Qvh1zScJ3vht/qIK4mOLdGvl58D0TXTDOuSI8
 a4Veq1LiQ9Bin1svJZNdbbwwJFU9I016B5wqWy+dgd2sXCJUmQw/RGxpu9X8NejKFuHaOj7KdgR
 HXJIxu2F0V5/E6Y4DRw==
X-Proofpoint-GUID: zuNVULC6DN8XM3yGYlkm-uZoI99G2w3a
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a55ec21 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=YpNgDGc-obDsCk2VH-MA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA4MiBTYWx0ZWRfX1bDtrPo91qc0
 KaHQU/Idmure9NT3mT35DB7zdBEugAI8SpbXfcygM56OAev07VZkmSXiuD96s71kF3wOn/p4zgk
 bcH1+OYAZfmt9kuwZBSLdNKG/vwqVes=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140082
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

Add the RPMI System Suspend service group for RISC-V virt.

The service advertises suspend-to-RAM support through librpmi,
registers QEMU wakeup support, and routes the suspend finalize callback
to the machine suspend path. On wakeup it processes RPMI group events
and defers the HSM hart resume until vCPUs are ready to run again.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |   4 +
 hw/misc/riscv_rpmi_hsm.c      |   9 +-
 hw/misc/riscv_rpmi_internal.h |   5 +
 hw/misc/riscv_rpmi_syssusp.c  | 191 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  25 +++++
 include/hw/misc/riscv_rpmi.h  |  11 ++
 7 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index fc5b11ed57..cb093a8642 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -172,4 +172,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
+  'riscv_rpmi_syssusp.c',
 ), librpmi])
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index 820b1d5d63..08691861b0 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -187,6 +187,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
         .kind = RISCV_RPMI_SERVICE_HSM,
         .add = riscv_rpmi_hsm_add,
         .remove = riscv_rpmi_hsm_remove,
+    }, {
+        .kind = RISCV_RPMI_SERVICE_SYSSUSP,
+        .add = riscv_rpmi_syssusp_add,
+        .remove = riscv_rpmi_syssusp_remove,
     },
 };
 
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
index 9a9859b10c..bacdabcac6 100644
--- a/hw/misc/riscv_rpmi_hsm.c
+++ b/hw/misc/riscv_rpmi_hsm.c
@@ -235,7 +235,6 @@ static void riscv_rpmi_hsm_destroy(RiscvRpmiState *s)
     g_clear_pointer(&s->hsm_hw_states, g_free);
 }
 
-
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
 {
     struct rpmi_service_group *group;
@@ -278,3 +277,11 @@ void riscv_rpmi_hsm_reset(RiscvRpmiState *s)
         rpmi_hsm_process_state_changes(s->hsm);
     }
 }
+
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index)
+{
+    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STARTED);
+    if (s->hsm) {
+        rpmi_hsm_process_state_changes(s->hsm);
+    }
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index 42a6708907..34cab35c32 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -33,5 +33,10 @@ void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
 void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index);
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s);
+
 
 #endif
diff --git a/hw/misc/riscv_rpmi_syssusp.c b/hw/misc/riscv_rpmi_syssusp.c
new file mode 100644
index 0000000000..d455e08163
--- /dev/null
+++ b/hw/misc/riscv_rpmi_syssusp.c
@@ -0,0 +1,191 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * RISC-V RPMI System Suspend service.
+ *
+ * Copyright (c) 2026 Qualcomm Technologies, Inc.
+ * Author:
+ *  Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
+ */
+
+#include "qemu/osdep.h"
+#include "riscv_rpmi_internal.h"
+#include "qemu/timer.h"
+#include "system/runstate.h"
+
+static const struct rpmi_system_suspend_type riscv_rpmi_syssusp_types[] = {
+    {
+        .type = RPMI_SYSSUSP_TYPE_SUSPEND_TO_RAM,
+        .attr = RPMI_SYSSUSP_ATTRS_FLAGS_RESUMEADDR,
+    },
+};
+
+static enum rpmi_error riscv_rpmi_syssusp_prepare(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->register_wakeup_support) {
+        s->machine_ops->register_wakeup_support(s->machine_opaque);
+    }
+    return RPMI_SUCCESS;
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_ready(void *priv,
+                                            rpmi_uint32_t hart_index)
+{
+    return true;
+}
+
+static void riscv_rpmi_syssusp_finalize(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->system_suspend) {
+        s->machine_ops->system_suspend(s->machine_opaque);
+    }
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
+                                                 rpmi_uint32_t hart_index)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->system_can_resume) {
+        return s->machine_ops->system_can_resume(s->machine_opaque);
+    }
+
+    return true;
+}
+
+static enum rpmi_error riscv_rpmi_syssusp_resume(
+    void *priv, rpmi_uint32_t hart_index,
+    const struct rpmi_system_suspend_type *syssusp_type,
+    rpmi_uint64_t resume_addr)
+{
+    RiscvRpmiState *s = priv;
+
+    s->syssusp_resume_hart_index = hart_index;
+    s->syssusp_resume_pending = true;
+    return RPMI_SUCCESS;
+}
+
+static const struct rpmi_syssusp_platform_ops riscv_rpmi_syssusp_ops = {
+    .system_suspend_prepare = riscv_rpmi_syssusp_prepare,
+    .system_suspend_ready = riscv_rpmi_syssusp_ready,
+    .system_suspend_finalize = riscv_rpmi_syssusp_finalize,
+    .system_suspend_can_resume = riscv_rpmi_syssusp_can_resume,
+    .system_suspend_resume = riscv_rpmi_syssusp_resume,
+};
+
+static void riscv_rpmi_wakeup_timer(void *opaque)
+{
+    RiscvRpmiState *s = opaque;
+
+    if (s->syssusp_resume_pending) {
+        riscv_rpmi_hsm_resume(s, s->syssusp_resume_hart_index);
+        s->syssusp_resume_pending = false;
+    }
+}
+
+static void riscv_rpmi_wakeup_notify(Notifier *notifier, void *data)
+{
+    RiscvRpmiState *s = container_of(notifier, RiscvRpmiState,
+                                     wakeup_notifier);
+
+    if (s->context) {
+        rpmi_context_process_group_events(s->context,
+                                          RPMI_SRVGRP_SYSTEM_SUSPEND);
+    }
+    if (s->wakeup_timer) {
+        /*
+         * Wakeup notifiers run before vCPUs resume. Defer the HSM
+         * kick so OpenSBI can leave WFI after QEMU restarts execution.
+         */
+        timer_mod(s->wakeup_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 10);
+    }
+}
+
+static bool riscv_rpmi_syssusp_create(RiscvRpmiState *s,
+                                      struct rpmi_service_group **group,
+                                      Error **errp)
+{
+    if (!s->hsm) {
+        error_setg(errp, "RPMI system suspend service requires HSM service");
+        return false;
+    }
+
+    if (s->machine_ops && s->machine_ops->register_wakeup_support) {
+        s->machine_ops->register_wakeup_support(s->machine_opaque);
+    }
+    if (!s->wakeup_timer) {
+        s->wakeup_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                       riscv_rpmi_wakeup_timer, s);
+    }
+    if (!s->wakeup_notifier_registered) {
+        s->wakeup_notifier.notify = riscv_rpmi_wakeup_notify;
+        qemu_register_wakeup_notifier(&s->wakeup_notifier);
+        s->wakeup_notifier_registered = true;
+    }
+
+    *group = rpmi_service_group_syssusp_create(
+        s->hsm, ARRAY_SIZE(riscv_rpmi_syssusp_types),
+        riscv_rpmi_syssusp_types, &riscv_rpmi_syssusp_ops, s);
+    if (!*group) {
+        error_setg(errp, "failed to create RPMI system suspend service group");
+        return false;
+    }
+
+    return true;
+}
+
+static void riscv_rpmi_syssusp_destroy(RiscvRpmiState *s)
+{
+    if (s->wakeup_notifier_registered) {
+        notifier_remove(&s->wakeup_notifier);
+        s->wakeup_notifier_registered = false;
+    }
+    if (s->wakeup_timer) {
+        timer_free(s->wakeup_timer);
+        s->wakeup_timer = NULL;
+    }
+
+    if (s->syssusp_group) {
+        rpmi_service_group_syssusp_destroy(s->syssusp_group);
+        s->syssusp_group = NULL;
+    }
+}
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp)
+{
+    struct rpmi_service_group *group;
+
+    if (s->syssusp_group) {
+        error_setg(errp, "duplicate RPMI system suspend descriptor");
+        return false;
+    }
+
+    if (!riscv_rpmi_syssusp_create(s, &group, errp)) {
+        return false;
+    }
+
+    if (!riscv_rpmi_context_add_group(s, group, "system suspend", errp)) {
+        s->syssusp_group = group;
+        riscv_rpmi_syssusp_destroy(s);
+        return false;
+    }
+
+    s->syssusp_group = group;
+    return true;
+}
+
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s)
+{
+    riscv_rpmi_context_remove_group(s, s->syssusp_group);
+    riscv_rpmi_syssusp_destroy(s);
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2b5f367bdb..21c218a78d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -51,6 +51,7 @@
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/tpm.h"
@@ -1020,6 +1021,12 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-hsm",
         .service_group = RISCV_RPMI_SRVGRP_HSM,
     },
+    {
+        .kind = RISCV_RPMI_SERVICE_SYSSUSP,
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
@@ -1037,9 +1044,27 @@ static void virt_rpmi_system_shutdown(void *opaque)
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
+static void virt_rpmi_system_suspend(void *opaque)
+{
+    qemu_system_suspend_request();
+}
+
+static void virt_rpmi_register_wakeup_support(void *opaque)
+{
+    qemu_register_wakeup_support();
+}
+
+static bool virt_rpmi_system_can_resume(void *opaque)
+{
+    return runstate_check(RUN_STATE_RUNNING);
+}
+
 static const RiscvRpmiMachineOps virt_rpmi_machine_ops = {
     .system_reset = virt_rpmi_system_reset,
     .system_shutdown = virt_rpmi_system_shutdown,
+    .system_suspend = virt_rpmi_system_suspend,
+    .register_wakeup_support = virt_rpmi_register_wakeup_support,
+    .system_can_resume = virt_rpmi_system_can_resume,
 };
 
 static RiscvRpmiConfig virt_rpmi_config(RISCVVirtState *s,
diff --git a/include/hw/misc/riscv_rpmi.h b/include/hw/misc/riscv_rpmi.h
index 37c56ea2e8..a4fe2aac63 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -29,6 +29,7 @@
 
 #define RISCV_RPMI_SRVGRP_SYSTEM_RESET   3
 #define RISCV_RPMI_SRVGRP_HSM            5
+#define RISCV_RPMI_SRVGRP_SYSTEM_SUSPEND 4
 
 #define TYPE_RISCV_RPMI "riscv-rpmi"
 OBJECT_DECLARE_SIMPLE_TYPE(RiscvRpmiState, RISCV_RPMI)
@@ -43,11 +44,15 @@ typedef enum RiscvRpmiServiceKind {
     RISCV_RPMI_SERVICE_INVALID = 0,
     RISCV_RPMI_SERVICE_SYSRESET,
     RISCV_RPMI_SERVICE_HSM,
+    RISCV_RPMI_SERVICE_SYSSUSP,
 } RiscvRpmiServiceKind;
 
 typedef struct RiscvRpmiMachineOps {
     void (*system_reset)(void *opaque);
     void (*system_shutdown)(void *opaque);
+    void (*system_suspend)(void *opaque);
+    void (*register_wakeup_support)(void *opaque);
+    bool (*system_can_resume)(void *opaque);
 } RiscvRpmiMachineOps;
 typedef struct RiscvRpmiServiceConfig {
     RiscvRpmiServiceKind kind;
@@ -86,9 +91,15 @@ struct RiscvRpmiState {
     const RiscvRpmiMachineOps *machine_ops;
     void *machine_opaque;
     struct rpmi_service_group *sysreset_group;
+    struct rpmi_service_group *syssusp_group;
     struct rpmi_hsm *hsm;
     struct rpmi_service_group *hsm_group;
     uint32_t *hsm_hw_states;
+    Notifier wakeup_notifier;
+    bool wakeup_notifier_registered;
+    QEMUTimer *wakeup_timer;
+    bool syssusp_resume_pending;
+    uint32_t syssusp_resume_hart_index;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;
-- 
2.43.0


