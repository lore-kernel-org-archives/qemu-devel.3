Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E33C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6J4-0008Uh-T3; Wed, 12 Aug 2026 06:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6J3-0008UR-Tl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1wu6J1-0003ZS-AO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:35:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C9fpXr3997183
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=39wbZK+jO4Q
 ipQJLt8R1eOTn1ke65e+zRVsVgp2czzs=; b=oUyrlNQD5EoK/ZPJjlNnSX08k7c
 FXquUKaRTxqgvtw6NzP9S3Br+QPel4rQVGO6nTt6TER0QDTaY2m2Xw/syOLXwjoF
 fI6ruPPOKje1K+ZYOFr+22WGAp7q9Gsq9YAE3FX8qSlfvucF5Mj7HzRB7eQyyyVr
 PMv5LbhS6koAl6LxYM/WeIQmITCYaEDTcJG/1icxRpBfymx+RyJ+Cf+NCh0ZcELH
 K0xHUDSKRuVOPS9nfaKhTgzS7ugbzuo0CkONwPqeKu2+7uUb5xWQX2p6A5UgL+nd
 hiYFPiyHWx2atCVxHU6FxUHddWr9nb7I1tsp07fpGd1ZDBqLSXrJYEXPFJg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5kdf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 10:35:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbe416a212eso52390a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786530929; x=1787135729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=39wbZK+jO4QipQJLt8R1eOTn1ke65e+zRVsVgp2czzs=;
 b=KqafkotnuKfOZQaxLSc+DJKi0y3vz5Vyns625MLnpoHJVdj5UzWmFO2+y0nyhsrMx4
 I5opDIbEaa0cFS9Guswktl/tdsQVEXnfhURou1cwLfypcPRxvy4tDbiLI1MqBeqfXjQm
 H1nlHOR5Pj65E+naz6AT0macCtwqTwveYqElIgvuoK+i/08uTgXje303oFjcz4Gx+kmK
 +1GNJ5edJXVwhtQadBash0RtfbImMG1oD5Vd0wDRvykNXbp1/YsP5S3B7oUBDTZQpNu1
 CgY4Wf/25tiSZEMxtIMe8cSs/p0i1S1YtoI4meEugN+X4dYtMo/Ay87Hw+xdgCvZ4GXO
 n0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530929; x=1787135729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=39wbZK+jO4QipQJLt8R1eOTn1ke65e+zRVsVgp2czzs=;
 b=N4flGEXTKjJWw+8/8HGApbeuck82RFxHqDwFDUXZIOrGCKr8xo1BU+30IA65LolS54
 cgRPFuiAffNllLpiCJFO1FFn0WPryDqjXT6UyzMZvhaSyp9QWpsnEkVIu15lUTxblFtS
 KWwwGFMIX7TTnouxeb/KhgqbgUu4PwGANFcGODByL8QfZfA6gZcUX0Bp04rfQuTrFChl
 yAUTukOmBcW+r+WIeBMyDL/8QjeIaNM5soXVS1lt5rnRlwjsOTxkV6O8pNO33DznCxLU
 NP4i30TkftxaAuIs2v2Y6a4DGfR7BQprtAAF+i7qqEc2aA0PaaHAEI5uz+DnIJeeth68
 k10Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCT19Rwl+mengIb/r3FwiDQZamrkm0FVk9lxfOpHENw6Oi655qO75vG7EQ7tkpEDbTQL/2coYmr7dM@nongnu.org
X-Gm-Message-State: AOJu0YzH3QWjMONQC15S0Ub0swg6aFaHJlslC9CRlrx9SBfwy7As3zgB
 SUth6cbi0E1pQyN+ukECeQWHgzodJcpgkJZjgsU/H+HFyjvg/nE4PfKugL5ws/xCONxD9I46nc4
 nsRmijgIUew9+VcsmdRKBBpFsI7TKbvFHLw7tY7YA8fdnioi94XaEv8oM7g==
X-Gm-Gg: AR+sD13L7ZipATV22OvV/v8VVNp/XKNatT5HulTFBcRCkgMsqzmhCU/gb8P1LPzGcbu
 8055n8EMIutwqL3+UPpu1VhZ1e9e8jct1CqUxZ/PDl87sAytzsyjB87Tk1Hm/E7sslm+sIq6fPL
 g3JwfjHVUHwXJTM0BnaNVEw/tLWlCo64/G3IqFqAbQh21xomYIw52vh8lhAIqT6en36Am0CfNZU
 Lynu9vsg+l5616LKCaKgx/qgUvCeHgIccCwTkJg1cO6sST8zn8zPj69jjhlcruiAyu4FYk/oqEq
 g3WESTZb7ykKC7PV/zOaOziN8EQnE4AkBVM/lVIbUNEJhNHaiRHy6BryYhNhSi4VxqoNzAj9dLI
 s49vA9DK+opK9i9qblfxV+xZoYO0UlfskvXN+SfqvOKwDGqQH53oPft6MY3IDv1OAG5ol5yVa6Y
 HEfZbo9uoDRPJ/sNDLWBkDuy3YlgXwHiM=
X-Received: by 2002:a17:903:1104:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d345754553mr31698045ad.3.1786530928651; 
 Wed, 12 Aug 2026 03:35:28 -0700 (PDT)
X-Received: by 2002:a17:903:1104:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2d345754553mr31697555ad.3.1786530928174; 
 Wed, 12 Aug 2026 03:35:28 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31d6aec3947sm6910326eec.17.2026.08.12.03.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:35:27 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-riscv@nongnu.org
Cc: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v7 07/10] riscv: add RPMI system suspend service
Date: Wed, 12 Aug 2026 16:04:41 +0530
Message-ID: <20260812103445.3451960-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260812103445.3451960-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX0v/kI8dMVz8m
 qyvsoZwuiB3uwRPLainyNKS6NPecN5AOhmk7Rxmuh0r/SeFIY1G7xjpsAIps5BLp3afGuZmL2UE
 TBcxkIgpcKQW0sjmAxl7as0FcK2mPSw=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c4c71 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=YpNgDGc-obDsCk2VH-MA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: FTBabkwhDJGLZWNztxt8FzO2EhhZTtEg
X-Proofpoint-ORIG-GUID: FTBabkwhDJGLZWNztxt8FzO2EhhZTtEg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX2zLdrmn/QVp+
 ywLBkAbPUausikpRO3KiqrAvSK9+4nCBJ3PxlM8TSOH1Z1slQiUOQuOpz5GoKZ7LD7A3MmK963D
 W9aiVjxgOLIvXyXoOO/vtFm4Ek8eMfvuVotETZntRbT8+equFVMwC5QgIkpGWPdX7ysH7ZWL5Nf
 53Mq4gpZO47Zk2YJht0N3RhEOXKEA7gPVmu2vkyLbF2PM/OoC9YM71SEoFIjC5LhHjiPIjKrOaq
 Heq6Ek7Cc5kwiH1fNJwMPANAaS2t4ASuZhMyp4/spBcFgHo/xImu9T6QALO1G2A9qwjs1+xB+8S
 H0xL9fyLIL8lwq181tyOmVWLB6Uu3PCZaQYBYUL7Az4Vbskzww6THK62fn7UIAD6VxAs93tR0m4
 OPxEdTHjPceGBMzHlZhjVatpxAKepj5FohwS8ChbgMtCG7/ixMLMTVdO4J/zh4Q2NJXMq4wHXhz
 3ST/fFe8MzuzsYwVpEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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
index 6c70d93358..b37acee0f1 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -172,4 +172,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
+  'riscv_rpmi_syssusp.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index e11a3911bc..c6f50ac1d6 100644
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
index 006ddc3b5a..037952dd22 100644
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
index f4539e3f8a..b97451811d 100644
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
index 0000000000..1773828757
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
+        s->machine_ops->register_wakeup_support();
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
+        s->machine_ops->system_suspend();
+    }
+}
+
+static rpmi_bool_t riscv_rpmi_syssusp_can_resume(void *priv,
+                                                 rpmi_uint32_t hart_index)
+{
+    RiscvRpmiState *s = priv;
+
+    if (s->machine_ops && s->machine_ops->system_can_resume) {
+        return s->machine_ops->system_can_resume();
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
+        s->machine_ops->register_wakeup_support();
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
index 66f619f229..8f166a5e12 100644
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
@@ -1029,6 +1030,12 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
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
@@ -1046,9 +1053,27 @@ static void virt_rpmi_system_shutdown(void)
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }
 
+static void virt_rpmi_system_suspend(void)
+{
+    qemu_system_suspend_request();
+}
+
+static void virt_rpmi_register_wakeup_support(void)
+{
+    qemu_register_wakeup_support();
+}
+
+static bool virt_rpmi_system_can_resume(void)
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
index 551980c9d6..75d72622a5 100644
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
     void (*system_reset)(void);
     void (*system_shutdown)(void);
+    void (*system_suspend)(void);
+    void (*register_wakeup_support)(void);
+    bool (*system_can_resume)(void);
 } RiscvRpmiMachineOps;
 typedef struct RiscvRpmiServiceConfig {
     RiscvRpmiServiceKind kind;
@@ -84,9 +89,15 @@ struct RiscvRpmiState {
     char *platform_info;
     const RiscvRpmiMachineOps *machine_ops;
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


