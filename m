Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E6CC982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 05:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x74bR-0007up-0L; Thu, 17 Sep 2026 01:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74b7-0007lL-L3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <subrahmanya.lingappa@oss.qualcomm.com>)
 id 1x74b5-00045p-5W
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:23:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H0ko4b3402965
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cfgjce3yYMW
 W9YCXaIJLk4QXTxmSfaDKEfYHucfBIDQ=; b=RWE1A5c19NEUIR7HOgW6tx4tg5r
 7ON5XxycWmpVHAnBLhI+iLAtxySgGv+gf/xnQV6mlKLuvmXnFnG3SjSOGMglpsIP
 ++OnPyKWxL9Ids0quNzEo3GjjqbeFSCRXHKjUvbm5Fc4vBEa4VlcPbp0te0D087Y
 q2kt3YN62KjS3THmICovc5+KZJWsZRwSjrQmMXMQVyWY+cC9KLYyd7kufF9kxjIz
 /eYkWZZvloDN+GIroMMWVdO04w2K918GXewDHpIpZ/YNIrUu5qbDkNd/b2PXu4yx
 fds+YEVJASP6Un5IbbV78+BQGbph4bOuiWvdOwz8vrpKvGXuForBTJk2JuQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d2pfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:23:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3967eca9c6aso125173a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789622625; x=1790227425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cfgjce3yYMWW9YCXaIJLk4QXTxmSfaDKEfYHucfBIDQ=;
 b=OFLsLVmMkoNl1JZ60+VoWDCXVJOE/CFqr8MVEV9mIxN44CB33GOKj5+w2KexkPzFhf
 Pl7tWtbStGH/ntEt28UWsrGLdA2rMbObIEI+80pKXCXlBtDMAdKw/XHrJ7MvQRlJqNyt
 9gvO9QuB8SE3T7Be+iAJ0YSwrJr2cNuyF3i6eZwS82yXNwOLoeZItsmGw6rp9NKS6tpd
 gYPXSpJrlJ91FJbE1k095k25u3PEVKEusveruKrRE80SvSqgvXFeMCx+KQKgKP1oFVOd
 Te3knsQw5oYXWgyBK5g9kPy6b7sv8A/l57hPUfCfKi1dlcSFep356NkAHwuNr/Nzmd+c
 oBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789622625; x=1790227425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cfgjce3yYMWW9YCXaIJLk4QXTxmSfaDKEfYHucfBIDQ=;
 b=A9LIckBaydl9Z9StCs382HK6j9gEYoY4e3OsBpP4FtPG8i8MRt8SwHg2XoXwuFjjhm
 c/1rn73x35SVfec5ZdXYSEKRwCxhlIENmk3STyhqoi4tw/g4e+KiH0fWQVB5aQQtYuIk
 JQHoAVHk7cu06bRlnJqaGE/P3bMO7SJiY7vjLrcPfhdo/4xHAHz7msYnIbDMz5jMkgpa
 ycqqScgODMrPML8olTOoQqjQ72+/UODz30Vl4cY6XyTiqN4svUPVG2ZH2jRO2b6ArbfO
 Oxzc/5g3u9EyaAyz2eiulIxo1GcMmFdcJMeZ64LS4zyHU98al8Hf24lKDsTS7EaQ8sR7
 uDvw==
X-Gm-Message-State: AFuF++mIselfb1BVSEwMoqk82M/g8qZ77wN4IMSjeX1E/gOCA3g4Rbmo
 QoMJXiA0flKBA78y6UxRWqePVTveEf8bSNn0Po3/aCCl92POYdB7acv1roUJnEVs2Gi6hhN8RdF
 sVF0863tKYOrNrgrvaTx/TpXJT44JDpXHcNCoXGvINwN/UlU6tFWtB6tsK7ct6WX6PQ==
X-Gm-Gg: AYBFou2NU6irJgq2qwlgoSaj1s9JsyVeWWhXeZd+OqtsUhvd+n47VBL1lvngvX4tDJj
 WBaqv+ieAeS1PpTOZmDW6WkkwZ1PQoRplR0/+85FjohJD/I6XGIEH/blUOOex58MmUK3Yih8NXA
 fYKFC0o4nUE5uabdpaGCriYX5Iq53uIa4V+g5BhuEUUkZgn0PIyyuKTbR/oepKb2RI36RnH3lQp
 IG6J5K1sGo0KQ1NLPLBWuHuOLCKOD2hISWRoTAxPRWB5kVGNO2vSZoFaRjhdtYjS5CxnqezffXT
 BfudHJfVcWrnLCaRt569oPCm5OThDHk9hoYVZ0szX8dxDy0a9vjUFyHczGMfb2JJ2w97R4CbfsN
 EUTWz5+Ns81VzcKaZkGRQnKIYa7fam8OlhAgH5G3qcGdyE8beeE4cAYj77xul/oIbktd7zfT/yR
 Vk+WyEVID7yaG8oFF4g+kvMdnQr8rR15U=
X-Received: by 2002:a17:90b:2250:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e1e5285d8mr7860542a91.5.1789622624983; 
 Wed, 16 Sep 2026 22:23:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2250:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e1e5285d8mr7860506a91.5.1789622624435; 
 Wed, 16 Sep 2026 22:23:44 -0700 (PDT)
Received: from hu-slingapp-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5af4f0bsm14256187eec.24.2026.09.16.22.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 22:23:44 -0700 (PDT)
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PATCH v11 07/10] riscv: add RPMI system suspend service
Date: Thu, 17 Sep 2026 10:52:46 +0530
Message-ID: <20260917052250.1041262-8-subrahmanya.lingappa@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260917052250.1041262-1-subrahmanya.lingappa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gvRQHq9l4WK7KgANxe-bJkMaYTZZC1Jl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfXyNQDJNfll/a4
 WMcS1zM6zdaaOilJlLEo7x0JpiwYsMw7r5V8AOInWAoManzegJvpf3ip3KrXsMsKMyNNfy3laVa
 64dLbBnAIjhS8ihwN6ClvO4anA0zrx0=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aab7961 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=U8RMtI3d1EX5IS3VA7UA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: gvRQHq9l4WK7KgANxe-bJkMaYTZZC1Jl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA2OCBTYWx0ZWRfXwDmopyDvAL3x
 KwQXBh8A84p6+EAegfkBfhG3IxBFXoDcCfUfoep/5nyL850zjYMmpTuiTwSWLijuk0jfCqm0+G5
 JLQR8CWfpyHE4WHdc4A3KqowyOYtybIYEbUCZRGER74NZRTm8Q11/AWG8Dl2TFjF5oTizPqfXra
 7vEIqjb4ev8NTOPf7tEzVNSumHMqyJfWtlAYwlzrBQCIVSYTya0qToMZ5cJZwaanBqo+EL//Etp
 RAvG8VgZzQkSisM17V+EyhyAVk0WjHg5mR7ad219+t/flwI896V5ZeOhzUjS1rJITZ5FqFIICf3
 Is3HHP4AOjAzoBZl1AYTZkBL6ZWZZuQBQINVbWLVWunQXK7U57tbUQWA/2I2gE6HIrDfu1DQGFG
 lysQEQ0WIJJe8gYtz+8/gYm0WNyNmxth0zd6T4rteGKWRmSb3YI+YwiXfQPiGV7EAsZ1oA8yCRt
 wjH+Xb3Rzv2fdNtT8iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170068
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_rpmi.c          |   4 +
 hw/misc/riscv_rpmi_hsm.c      |  10 +-
 hw/misc/riscv_rpmi_internal.h |   6 ++
 hw/misc/riscv_rpmi_syssusp.c  | 194 ++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               |  24 +++++
 include/hw/misc/riscv_rpmi.h  |  10 ++
 7 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/riscv_rpmi_syssusp.c

diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 3f2caaf06f..a0b15aaf2e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -180,4 +180,5 @@ system_ss.add(when: 'CONFIG_RISCV_RPMI', if_true: [files(
   'riscv_rpmi.c',
   'riscv_rpmi_sysreset.c',
   'riscv_rpmi_hsm.c',
+  'riscv_rpmi_syssusp.c',
 ), librpmi], if_false: files('riscv_rpmi-stub.c'))
diff --git a/hw/misc/riscv_rpmi.c b/hw/misc/riscv_rpmi.c
index b3b9a202a5..83a41cb71c 100644
--- a/hw/misc/riscv_rpmi.c
+++ b/hw/misc/riscv_rpmi.c
@@ -215,6 +215,10 @@ static const RiscvRpmiServiceOps riscv_rpmi_service_ops[] = {
         .service_group = RPMI_SRVGRP_HSM,
         .add = riscv_rpmi_hsm_add,
         .remove = riscv_rpmi_hsm_remove,
+    }, {
+        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
+        .add = riscv_rpmi_syssusp_add,
+        .remove = riscv_rpmi_syssusp_remove,
     },
 };
 
diff --git a/hw/misc/riscv_rpmi_hsm.c b/hw/misc/riscv_rpmi_hsm.c
index 08a985cb30..928fe3e52e 100644
--- a/hw/misc/riscv_rpmi_hsm.c
+++ b/hw/misc/riscv_rpmi_hsm.c
@@ -236,7 +236,6 @@ static void riscv_rpmi_hsm_destroy(RiscvRpmiState *s)
     g_clear_pointer(&s->hsm_hw_states, g_free);
 }
 
-
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp)
 {
     struct rpmi_service_group *group;
@@ -279,3 +278,12 @@ void riscv_rpmi_hsm_reset(RiscvRpmiState *s)
         rpmi_hsm_process_state_changes(s->hsm);
     }
 }
+
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index,
+                           uint64_t resume_addr)
+{
+    riscv_rpmi_hsm_set_hw_state(s, hart_index, RPMI_HART_HW_STATE_STARTED);
+    if (s->hsm) {
+        rpmi_hsm_process_state_changes(s->hsm);
+    }
+}
diff --git a/hw/misc/riscv_rpmi_internal.h b/hw/misc/riscv_rpmi_internal.h
index 7f9d110776..2c4723ad6b 100644
--- a/hw/misc/riscv_rpmi_internal.h
+++ b/hw/misc/riscv_rpmi_internal.h
@@ -33,5 +33,11 @@ void riscv_rpmi_sysreset_remove(RiscvRpmiState *s);
 bool riscv_rpmi_hsm_add(RiscvRpmiState *s, Error **errp);
 void riscv_rpmi_hsm_remove(RiscvRpmiState *s);
 void riscv_rpmi_hsm_reset(RiscvRpmiState *s);
+void riscv_rpmi_hsm_resume(RiscvRpmiState *s, uint32_t hart_index,
+                           uint64_t resume_addr);
+
+bool riscv_rpmi_syssusp_add(RiscvRpmiState *s, Error **errp);
+void riscv_rpmi_syssusp_remove(RiscvRpmiState *s);
+
 
 #endif
diff --git a/hw/misc/riscv_rpmi_syssusp.c b/hw/misc/riscv_rpmi_syssusp.c
new file mode 100644
index 0000000000..f4a9bbdaf4
--- /dev/null
+++ b/hw/misc/riscv_rpmi_syssusp.c
@@ -0,0 +1,194 @@
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
+    s->syssusp_resume_addr = resume_addr;
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
+        riscv_rpmi_hsm_resume(s, s->syssusp_resume_hart_index,
+                              s->syssusp_resume_addr);
+        s->syssusp_resume_pending = false;
+        s->syssusp_resume_addr = 0;
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
index 7c29e3634c..87399ed803 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -50,6 +50,7 @@
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/tpm.h"
@@ -1013,6 +1014,11 @@ static const RiscvRpmiServiceConfig virt_rpmi_services[] = {
         .compatible = "riscv,rpmi-hsm",
         .service_group = RPMI_SRVGRP_HSM,
     },
+    {
+        .node_name = "suspend",
+        .compatible = "riscv,rpmi-system-suspend",
+        .service_group = RPMI_SRVGRP_SYSTEM_SUSPEND,
+    },
 };
 
 static uint32_t virt_rpmi_service_count(RISCVVirtState *s)
@@ -1030,9 +1036,27 @@ static void virt_rpmi_system_shutdown(void)
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
index 9f7aa9f6ef..a0381e31d7 100644
--- a/include/hw/misc/riscv_rpmi.h
+++ b/include/hw/misc/riscv_rpmi.h
@@ -49,6 +49,9 @@ struct rpmi_hsm;
 typedef struct RiscvRpmiMachineOps {
     void (*system_reset)(void);
     void (*system_shutdown)(void);
+    void (*system_suspend)(void);
+    void (*register_wakeup_support)(void);
+    bool (*system_can_resume)(void);
 } RiscvRpmiMachineOps;
 
 typedef struct RiscvRpmiServiceConfig {
@@ -85,9 +88,16 @@ struct RiscvRpmiState {
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
+    uint64_t syssusp_resume_addr;
     uint32_t *hart_ids;
     uint32_t hart_count;
     const RiscvRpmiServiceConfig *services;

