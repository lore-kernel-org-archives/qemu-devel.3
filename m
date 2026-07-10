Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1500C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiAEu-0006Y4-Fu; Fri, 10 Jul 2026 08:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41M-0002Fh-Hu
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wi41K-0007mp-Rn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 01:43:32 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nSrt3848800
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IKyJmrjcSr9
 iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=; b=YgzvLiQWiGjv5ntjBzwkD6jvih4
 FwDob0FlZbop8Eu5I08VXACQNg7eXQ8kL6kZpP7t7OZKMucmrnWy96onjy4DSOFk
 fiIudgALb5RZxgYw45dFOx+Wd2XkIWtp+n9OTO7clnC2OtoKhdb/4W3pG7oI8uhR
 B2xrTFaRlXE5+W2AeYtGEfB8rQT3dUayeAbd8RtYOA2UB6N5hEVC9SF61CtVOIV/
 5CNVh3e3QFz5U8DGZRs2UCp5AOV3k4BeSLTAIRzFLfA2sFskIh1A4B92foDj1hgd
 X5X96KQT/mgqwk4S0+xxn2SLvdxZ2lVvgMtevfF2DtAZoR4KiePo+hKPanQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeestwkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 05:43:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc7ea29141so2957825ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 22:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783662209; x=1784267009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IKyJmrjcSr9iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=;
 b=exdYHK9Id9O9bCHwMs1sSqQ4gCdFstBKc9yM+H5lPvOx1mtHf1zDMSrdr0YWKqYfLS
 vBhQWOM/cDiIDkNsBITVn1lSBg6eiK6yiuv6jYvV78D38JEN05qhMNRDCODBUWPkRiMg
 6pr32BMDCmY878g6mBFZ5x4tfPQu8DlNckEuHHq/DjRv+7eZdNrPtvadpxahzpJHFfr3
 5sR+L7DL86PfDR29JrgH0GhSbai+Ow2N8jXLPp7L4xX71n8twZn8IQSN1KBpIOKMuXRj
 PCi4cFqk4GFh5nxNFqytsyLl69g9Uts0TBDFp1SChFyW58Ris5+uXrISUpT56ISr8hp5
 kowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662209; x=1784267009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IKyJmrjcSr9iKT+1GncuQy3zeUNSlN0odNLhTzFLUg8=;
 b=DPXm0Gk714HB0fnf3F5X5Hd4kFqEZDiZ0dctyvgaplFR1IysHvPzaop6CpMBLAmX71
 XsJxgwOmz6cwcOOujtbcfZaeylsNas4au3X80bdGD676Ecm1iJyfs8OACd6BYvUgd9Lt
 foMGnuI/ano+jOFBiemUlhOlcCWq5UdF8Rn5cYEfVI7gzNr2T1G3sLX7maJtBaa4pOFz
 5Ks5opOPtVTHWI+wgX+8qYsdF3S9t4MnH5lbbKsZh1eIg3H9kuIlebJJhq3yK+jmb8D0
 7qB2limG58piCrc5iP5nZkmSczMjkEaUaFNGdleg65SKDinofQZuwXJL0ixvk3zqK++z
 UEVQ==
X-Gm-Message-State: AOJu0YzRC+0BG9gro/nXgRkf+GXvDh3Jj2bRNvNNYHQmFPy7t1te8+0B
 22acEyeZyJC+yHcWoeJqrH/lZT34h9jiuSFaZz+68ouabtL4nWf88fAZEA3K/ARMyTIGoOe3dcn
 5dZZGERRWJpROpX2AVuoO0Yia/XSndhhCvZedhyrqd/l+aIkXPz78TNTQSCpbpU0DdA==
X-Gm-Gg: AfdE7cnLgkxmpo2f55zJh4tvGVok585Mi4d6fVTutnwFPZGGaNA+Ag2xVf1KM3XTgCG
 hByIC/7MI80QO9wdizAXx1HusXr0Q8CqMAYmMwW7YuHEY1L6D+vL+eW1QDZD+qGt69yelOHGyoJ
 3nJFh5SqKq6fWc1EZXUsMdVyjRUYfWAJp+gSrdgRtOD5zlt9U7IL0ENGeTK4rxOcucvR23v8Ql9
 LUgqJF+O6C30gaXw6DaOXGSCGOtaeS7uG94FVYPVnDFiKHgKh/rOkQEnrDar4xb7oo0HaarYHuE
 rQf+YzuHaSM3t5YDR7h9cjE1KE2xf6Jm86GYwfkI+DIVtoBpK/8yJljhprLQDFgZ9EJ5Lskj0+P
 jda+qonBJiLSSd2d2AeEdemfnkhRTQ4xXT1QJT8ceBupofZB4DwkhZwjEYKaEtuleyoxE7AnD5X
 x+x6O6YdZtHaxf9TLTldFANKjmr6+sB3hjshIImctXOA==
X-Received: by 2002:a17:903:8cd:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2ccea3f7733mr79842365ad.4.1783662208937; 
 Thu, 09 Jul 2026 22:43:28 -0700 (PDT)
X-Received: by 2002:a17:903:8cd:b0:2cc:e3b6:f305 with SMTP id
 d9443c01a7336-2ccea3f7733mr79842065ad.4.1783662208254; 
 Thu, 09 Jul 2026 22:43:28 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm39112785c88.11.2026.07.09.22.43.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 22:43:27 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/10] hw/riscv: add RPMI FDT helpers
Date: Fri, 10 Jul 2026 11:13:11 +0530
Message-ID: <0028254f03ea55c578dc6e79b7a8d9cbabaa201d.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
References: <cover.1783660209.git.subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: amKj_surRzBYBRn3pvkkhEA_WqBhCX7C
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508681 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=jHWy4UxqgUe44QwoGJQA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX4c1G6J70voOb
 6tWggGLR/OM6S+4rpzk56/W4Yr5sPvo8Uy9Xu/qyUYhQV7qxKoqlRCMiTP70Y5MHpN7ba0o9LYx
 ws1HaPpJahRXFFJWRv3Okmq8FzE1s0g=
X-Proofpoint-ORIG-GUID: amKj_surRzBYBRn3pvkkhEA_WqBhCX7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1MiBTYWx0ZWRfX9CUuzDjQLGhS
 39M59Jv2CN+n9eWibgPMI35tk4QAw/FYfqJ51/LDxy0j55EgOcWd6eQ2Y3F752h2WDtAmA2a9tv
 X69Eyls9szAw2sWvTgMvXTs3ZcDGuDWsPkLqZ1mqQgyPbSkG5qPmu/9frcecG2OvVy4L3zXtfVf
 6YFHFzc8GIHg2XxGRv7blAPv9InLeap3tKhiC3yj3U1ewM2S2njH9J1zlUivf418ON9LMRDfaky
 rxf8n1e7ntKt5InRsqjED5GFu5xvl9QyvCMtSK8rPJntuDPcYeUo98WvNpajzATN/oVt851qNLt
 tUx+LbFrr9gNx4a28kjlGM8ygRmkAz5v05CTDBUf1oNF+l0Q/S40HjuvQByjjAfe4RjyWjsIBDM
 G142v79ZBOAjiR9pT8iy0aOStOQ3vFPBHHAc1P5eInH+OmVv5ycx3O+szRaHSoK/88am1KqKWCk
 aoZQUaPCecx0/L0Cyow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2026 08:21:34 -0400
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
Message-ID: <20260710054311.I4b5XHLV1nUrXq1IAhicb2-vtzq3Q8TPuG0kvm1HXYM@z>

From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

Add helper routines for describing RPMI shared-memory mailbox transports
and service child nodes in the RISC-V virt device tree.

The helpers keep RPMI node construction in one place so the virt machine
can add service groups without open-coding compatible strings, channel
IDs, interrupts, and shared-memory references at each call site.

Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
---
 hw/riscv/meson.build        |   1 +
 hw/riscv/rpmi-fdt.c         | 103 ++++++++++++++++++++++++++++++++++++
 include/hw/riscv/rpmi-fdt.h |  30 +++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 hw/riscv/rpmi-fdt.c
 create mode 100644 include/hw/riscv/rpmi-fdt.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index b70a054579..529ec273fd 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('fdt-common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(files('rpmi-fdt.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
diff --git a/hw/riscv/rpmi-fdt.c b/hw/riscv/rpmi-fdt.c
new file mode 100644
index 0000000000..b2b3daea1c
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
index 0000000000..f053ae5d57
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


