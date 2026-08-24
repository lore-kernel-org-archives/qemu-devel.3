Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D21C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4P-00059E-C9; Mon, 24 Aug 2026 11:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4K-000588-MF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4H-0001le-Fv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFnO4R3329989
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/8CYFYfa9H1
 v1FCwMzUwBVeaTtmLH8lkoQDGrh7ZyBg=; b=huDvGo6sbeT36lQBKsZH/4lz5PF
 V8A4xOI2jdRdFsORLUxtrgH+uQb8lMk5wKMogUKvBxZNxvzKISx6k8rRmbXnHQNI
 H5ZUVJxXK3AthlHapTuJO2jpwUrW546prNqjuNdR/OXRdhMwVYMB8SuVv6tFQ/ya
 SazkMbWOfgY/ldDtSxo9XlAJ31SauWmpgX9Zma9ZNCXG0urOK+bwTlDTrkMzNBV8
 wYXbnElEOeyNlGoKJwGvxWg076qKNLwHZg1oFiP+Wk4gvsWXkKpFux6PtV36nrOw
 JfZ00micDJHQrr/0+JDzvULzPlNIydk+MeOkdG1YKIgCQLIhRkGBfKu49TQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1xyb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso2709558a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587115; x=1788191915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/8CYFYfa9H1v1FCwMzUwBVeaTtmLH8lkoQDGrh7ZyBg=;
 b=DL2UPsklOSfeeiholfXvUaRIclDJW8SEgcKqqOfWDfKePzxmt7HuWTbzDCKbQ5uWo5
 ULACHPPiQjKCAD32LV/2wdaIHjk4LPq5M/er0heFt/UwYhFRdANa9uwNMQpBp56W3Yf6
 7OM1FbxVLTz+990ZiSj0RO562+MdcxDpf2YroqqPEkiMBsoDnD/RIaPQtckqm7NkUPy6
 6LvEd6a+uU5PDg3yg9AgdBeRVUGXEA08j0hjF0l4PQgDHR6EBjcNuZQlbJkEybNMB2GL
 M3DpkKInrfAwn2qjF8iG4E/04aUDlqPhFIjsoX3cLKCb9N0MAtu9+TFWiEB88K+r9R5S
 BVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587115; x=1788191915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/8CYFYfa9H1v1FCwMzUwBVeaTtmLH8lkoQDGrh7ZyBg=;
 b=Rjixmk9WcKKmt3Pii+kW2b3vFFtuNca8ecglrX1mEo1LUlNs6Hy5PpsLMxDMq4hzrT
 /MyU2CW4WvfWnDN7dBgIkm0KjlvIpIXBA/emqpmHkdh3fjaYu58lbe5lnNAR5+0m0Kbw
 ShFp1ZULXRj/wCR7GfunOqQQyZ5o7moQiU0SpiCMEV5cVtMuIN+a7W5fxFiGgBH4XO7s
 9buP+9tVrRsytuMLilWNb3JZNo7RkyL8ORollZuUBpY51WeNFkA5rFBloYRatxLeS0XC
 6kU1WSc0uO5lLE7hrvkqzqrLFf4CZdiWj45z+ueqbCwzMiQ1VoGCAg50IxWxfUSanzY6
 TSjQ==
X-Gm-Message-State: AFuF++niilv70PAZcBZ1raStjF5H1sPJTL3IIjWiq/zg3o2IKVFDzeXV
 EkhO8hA4Miixe8KCRGqzYPO7uN/ozLqPfs3eaIb7IDwARSifzBsOz98LQiFzfGufRiDvLxkiqvU
 hZsQq+MQN89tMSM8kflYgukc1sLO7YBVIZGrqhpzP+XmBO1IXnN4CJsw1yfIKe/01ZzsV
X-Gm-Gg: AR+sD137O2u/3N0zbgfPtH8JE01tVjvI+D4d6C7JQogoTsWS792cM2XBNVZzHXQ0TWb
 XJpI5EwR6zssI+mS+Pljg9WKUjJSouehauzCJZKsHTh+/ekFCowShFdtJtfMRkTtgeba1mzU5m+
 wr3A7wVD6Dd/mN2DdadbRAlNSmazmQCywhtnsIKz6ZL4SKd0V4kXSF4KUxypfGAOVZrX7AQ1wjc
 XVtKmXCqbq8OQ3XfztJEzz6kiu592ET5R5mfJHV6IgoQ9fZdLgTwlw+k4mOXSOkihrZOOXFeUuY
 r+Flk666ouHSFyuPTG3H7EBtbaThRbhcXmqNA4oJK6nDFd5khfbs7D/7vGomQNMDmXNZdsX5OXk
 OTsu9Q0ofnoC4Xw0tQhpzQeP4rvW/UEw9lOTVL+odl7ck74qqYLPAXzPKMQKQXiY=
X-Received: by 2002:a05:6a21:6010:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cd3009ca00mr52445739637.10.1787587115272; 
 Mon, 24 Aug 2026 08:58:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:6010:b0:3c3:f371:1ea9 with SMTP id
 adf61e73a8af0-3cd3009ca00mr52445636637.10.1787587114770; 
 Mon, 24 Aug 2026 08:58:34 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:34 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 08/14] target/hexagon: add semihosting support
Date: Mon, 24 Aug 2026 08:58:17 -0700
Message-Id: <7529648c7810ff5fbe7770ea9087b6e399e277a7.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX/s25MaRNGaaV
 StLYBz9oaQOp5sxY7R4tSUSp0LHL7bQdhv96tcNbLlCrqQ+VJJ1PF9cufc2kp9ghvqVxU5XxoAX
 8uXZUbg4mFiO5uRYsF+R3O9qmSi4QlHlmRk1k/ty6CwTEMApO0s+Yy/4s9mM31Oko5eV2ThYoY1
 NVRu3CiGZRXnjjjPtgfumgAOYmAeq5ywp2UUjHXfOg6qiTZYux7FHk55EYqd9u7XGP2204sE0MZ
 pzA/AFwjWpm08729ZgKU2p9ZVUB0V5RjHChbg4zDUpnh0Omwewc6J0HfF2JLbJEpHsH32uCgs+q
 zYklxIFBkZo9Q/KlI2P4zgvdRuJC9OJ8R6CnDyCDwIjLGjt0mXFHH0AMf/0DWy9QekRfAFzUFA8
 oM1XU2JLKSYvMRiYPKAkiACos2yukDD54Y6uIXhA9SKsgteZxS8P2zZquTMf+nNv3JaQalPrMT2
 ive+WmNz75mTegDwwfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX0cVL99C1IMUN
 gJpvY25E6nMlflBRyhVDESkhhi5dz/bo7n5ycFV8J+N69xxUcuUDbi9HJ1H7RSPO0xZLIbTGP/5
 kj8bgX4SatFDQtM6NNXwq5caDtpt0oQ=
X-Proofpoint-GUID: dT21YrmESwbcVtl2Z0tUwr3uG-dxBcc-
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c6a2c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=9cnYKv1u39FlQambOaYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: dT21YrmESwbcVtl2Z0tUwr3uG-dxBcc-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Baremetal Hexagon programs use trap0 #0 to invoke
semihosting calls for I/O and process control.  Wire up the
arm-compatible semihosting framework for softmmu by enabling
CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
semihosting handler.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 configs/targets/hexagon-softmmu.mak |   2 +
 docs/system/target-hexagon.rst      |   8 +-
 hw/hexagon/Kconfig                  |   1 +
 hw/hexagon/hexagon_dsp.c            |   2 +
 qemu-options.hx                     |   8 +-
 target/hexagon/common-semi-target.c |  51 +++++++++
 target/hexagon/hexswi.c             | 167 +++++++++++++++++++++++++++-
 target/hexagon/meson.build          |   1 +
 8 files changed, 230 insertions(+), 10 deletions(-)
 create mode 100644 target/hexagon/common-semi-target.c

diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
index a77c100f0c..6cbdc64be5 100644
--- a/configs/targets/hexagon-softmmu.mak
+++ b/configs/targets/hexagon-softmmu.mak
@@ -6,3 +6,5 @@ TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
 TARGET_NEED_FDT=y
+CONFIG_SEMIHOSTING=y
+CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/docs/system/target-hexagon.rst b/docs/system/target-hexagon.rst
index 416b8f7be7..a9f8c29810 100644
--- a/docs/system/target-hexagon.rst
+++ b/docs/system/target-hexagon.rst
@@ -91,9 +91,11 @@ Semihosting
 -----------
 Hexagon supports a semihosting interface similar to other architectures'.
 The ``trap0`` instruction can activate these semihosting calls so that the
-guest software can access the host console and filesystem.  Semihosting
-is not yet implemented in QEMU hexagon.
-
+guest software can access the host console and filesystem. Read the
+`Hexagon Semihosting Specification
+<https://docs.qualcomm.com/doc/80-N2040-101_102648/topic/semihosting-specification.html>`__
+for details. Semihosting is enabled by default on hexagon-sim-compatible
+machines. This can be further configured through ``-semihosting-config``.
 
 Hexagon Features
 ================
diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
index 83b2763d1e..bb8a254fd2 100644
--- a/hw/hexagon/Kconfig
+++ b/hw/hexagon/Kconfig
@@ -5,6 +5,7 @@ config HEX_DSP
     select CPU_CLUSTER
     select HEX_L2VIC
     select HEX_QTIMER
+    select ARM_COMPATIBLE_SEMIHOSTING
 
 config HEX_VIRT
     bool
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 20306c28e7..2198436a44 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -26,6 +26,7 @@
 #include "target/hexagon/internal.h"
 #include "system/physmem.h"
 #include "system/reset.h"
+#include "semihosting/semihost.h"
 
 #include "machine_cfg_v66g_1024.h.inc"
 
@@ -153,6 +154,7 @@ static void init_mc(MachineClass *mc)
     mc->no_serial = 1;
     mc->is_default = false;
     mc->max_cpus = 8;
+    qemu_semihosting_enable();
 }
 
 /* ----------------------------------------------------------------- */
diff --git a/qemu-options.hx b/qemu-options.hx
index 34970fffc9..56f42b02c8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5507,7 +5507,7 @@ ERST
 DEF("semihosting", 0, QEMU_OPTION_semihosting,
     "-semihosting    semihosting mode\n",
     QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
+    QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_HEXAGON)
 SRST
 ``-semihosting``
     Enable :ref:`Semihosting` mode (ARM, M68K, Xtensa, MIPS, RISC-V only).
@@ -5523,11 +5523,11 @@ DEF("semihosting-config", HAS_ARG, QEMU_OPTION_semihosting_config,
     "-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]\n" \
     "                semihosting configuration\n",
 QEMU_ARCH_ARM | QEMU_ARCH_M68K | QEMU_ARCH_XTENSA |
-QEMU_ARCH_MIPS | QEMU_ARCH_RISCV)
+QEMU_ARCH_MIPS | QEMU_ARCH_RISCV | QEMU_ARCH_HEXAGON)
 SRST
 ``-semihosting-config [enable=on|off][,target=native|gdb|auto][,chardev=id][,userspace=on|off][,arg=str[,...]]``
-    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V
-    only).
+    Enable and configure :ref:`Semihosting` (ARM, M68K, Xtensa, MIPS, RISC-V,
+    Hexagon only).
 
     .. warning::
       Note that this allows guest direct access to the host filesystem, so
diff --git a/target/hexagon/common-semi-target.c b/target/hexagon/common-semi-target.c
new file mode 100644
index 0000000000..210d33e54e
--- /dev/null
+++ b/target/hexagon/common-semi-target.c
@@ -0,0 +1,51 @@
+/*
+ * Target-specific parts of semihosting/arm-compat-semi.c.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_helper.h"
+#include "semihosting/common-semi.h"
+
+uint64_t common_semi_arg(CPUState *cs, int argno)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    return env->gpr[HEX_REG_R00 + argno];
+}
+
+void common_semi_set_ret(CPUState *cs, uint64_t ret)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    env->gpr[HEX_REG_R00] = ret;
+}
+
+void common_semi_set_err(CPUState *cs, int err)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    env->gpr[HEX_REG_R01] = err;
+}
+
+bool common_semi_sys_exit_is_extended(CPUState *cs)
+{
+    return false;
+}
+
+bool is_64bit_semihosting(CPUArchState *env)
+{
+    return false;
+}
+
+uint64_t common_semi_stack_bottom(CPUState *cs)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    return env->gpr[HEX_REG_SP];
+}
+
+bool common_semi_has_synccache(CPUArchState *env)
+{
+    return false;
+}
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 43c373ea2e..a5d56fb844 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -24,9 +24,171 @@
 #error "This file is only used in system emulation"
 #endif
 
+#include "semihosting/common-semi.h"
+#include "semihosting/console.h"
+#include "semihosting/syscalls.h"
+#include "semihosting/guestfd.h"
+#include "system/runstate.h"
+
+/* non-arm-compatible semihosting calls */
+#define HEXAGON_SPECIFIC_SWI_FLAGS \
+    DEF_SWI_FLAG(OPEN,             0x01) \
+    DEF_SWI_FLAG(ISTTY,            0x09) \
+    DEF_SWI_FLAG(HEAPINFO,         0x16) \
+    DEF_SWI_FLAG(EXCEPTION,        0x18) \
+    DEF_SWI_FLAG(SEEK,             0x0A) \
+    DEF_SWI_FLAG(READ_CYCLES,      0x40) \
+    DEF_SWI_FLAG(PROF_ON,          0x41) \
+    DEF_SWI_FLAG(PROF_OFF,         0x42) \
+    DEF_SWI_FLAG(WRITECREG,        0x43) \
+    DEF_SWI_FLAG(READ_TCYCLES,     0x44) \
+    DEF_SWI_FLAG(LOG_EVENT,        0x45) \
+    DEF_SWI_FLAG(REDRAW,           0x46) \
+    DEF_SWI_FLAG(READ_ICOUNT,      0x47) \
+    DEF_SWI_FLAG(PROF_STATSRESET,  0x48) \
+    DEF_SWI_FLAG(DUMP_PMU_STATS,   0x4a) \
+    DEF_SWI_FLAG(READ_PCYCLES,     0x52) \
+    DEF_SWI_FLAG(COREDUMP,         0xCD) \
+    DEF_SWI_FLAG(FTELL,            0x100) \
+    DEF_SWI_FLAG(FSTAT,            0x101) \
+    DEF_SWI_FLAG(STAT,             0x103) \
+    DEF_SWI_FLAG(GETCWD,           0x104) \
+    DEF_SWI_FLAG(ACCESS,           0x105) \
+    DEF_SWI_FLAG(OPENDIR,          0x180) \
+    DEF_SWI_FLAG(CLOSEDIR,         0x181) \
+    DEF_SWI_FLAG(READDIR,          0x182) \
+    DEF_SWI_FLAG(EXEC,             0x185) \
+    DEF_SWI_FLAG(FTRUNC,           0x186)
+
+/*
+ * We use the arm-compatible semihosting routines for these ones, but we do
+ * need some hexagon-specific preprocessing.
+ */
+#define HEX_SYS_WRITE       0x05
+#define HEX_SYS_READ        0x06
+#define HEX_SYS_READC       0x07
+
+#define DEF_SWI_FLAG(name, val) HEX_SYS_ ##name = val,
+enum hex_swi_flag {
+    HEXAGON_SPECIFIC_SWI_FLAGS
+};
+#undef DEF_SWI_FLAG
+
+#define DEF_SWI_FLAG(_, val) case val:
+static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
+{
+    switch (what_swi) {
+    HEXAGON_SPECIFIC_SWI_FLAGS
+        return true;
+    }
+    return false;
+}
+#undef DEF_SWI_FLAG
+
+static void init_semihosting_guestfds(void)
+{
+    static gsize initialized;
+
+    if (g_once_init_enter(&initialized)) {
+        if (qemu_semihosting_console_has_chardev()) {
+            alloc_guestfd();
+            console_guestfd(0);
+            alloc_guestfd();
+            console_guestfd(1);
+            alloc_guestfd();
+            console_guestfd(2);
+        } else {
+            alloc_guestfd();
+            associate_guestfd(0, 0);
+            alloc_guestfd();
+            associate_guestfd(1, 1);
+            alloc_guestfd();
+            associate_guestfd(2, 2);
+        }
+        g_once_init_leave(&initialized, 1);
+    }
+}
+
+static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
+{
+    uint32_t addr, count;
+    uintptr_t retaddr = 0;
+
+    hexagon_read_memory(env, swi_info + 4, 4, &addr, retaddr);
+    hexagon_read_memory(env, swi_info + 8, 4, &count, retaddr);
+    hexagon_peek_memory_range(env, addr, count, retaddr);
+}
+
+static void sim_handle_trap0(CPUHexagonState *env)
+{
+    target_ulong what_swi, swi_info;
+    CPUState *cs = env_cpu(env);
+
+    g_assert(bql_locked());
+    init_semihosting_guestfds();
+
+    what_swi = env->gpr[HEX_REG_R00];
+    swi_info = env->gpr[HEX_REG_R01];
+
+    qemu_log_mask(CPU_LOG_INT,
+                  "sim_handle_trap0: swi=0x%" PRIx32
+                  " info=0x%" PRIx32 " PC=0x%" PRIx32
+                  " thread=%" PRId32 "\n",
+                  (uint32_t)what_swi, (uint32_t)swi_info,
+                  (uint32_t)env->gpr[HEX_REG_PC],
+                  (uint32_t)env->threadId);
+
+    if (!is_hexagon_specific_swi_flag(what_swi)) {
+        if (what_swi == HEX_SYS_READ || what_swi == HEX_SYS_READC ||
+            what_swi == HEX_SYS_WRITE) {
+            /*
+             * Avoid page faults if the buffer is not in memory yet.
+             * NOTE: Counterintuitive, but a WRITE must be able to LOAD from
+             * the input address. The contents of that buffer will be
+             * directed to the SWI interface.
+             */
+            do_preload(env, swi_info, (what_swi == HEX_SYS_WRITE));
+        }
+        /*
+         * ARM-compat semihosting SWI numbers are all <= 0x31.
+         * If R0 holds a value outside that range (e.g. guest code
+         * executing trap0(#0) with an arbitrary R0), treat it as an
+         * unrecognized request rather than forwarding to
+         * do_common_semihosting() which would abort.
+         */
+        if (what_swi > 0x31) {
+            qemu_log_mask(LOG_UNIMP,
+                          "trap0(#0): unrecognized request in r0: "
+                          "0x" TARGET_FMT_lx "\n", what_swi);
+            return;
+        }
+        do_common_semihosting(cs);
+        return;
+    }
+
+    switch (what_swi) {
+
+    case HEX_SYS_EXCEPTION:
+    {
+        uint32_t ret = env->gpr[HEX_REG_R02];
+        env->gpr[HEX_SREG_MODECTL] = 0;
+        gdb_exit(ret);
+        exit(ret);
+    }
+    break;
+
+    /* TODO: implement other hexagon-specific semihosting calls */
+
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "unknown swi request: 0x%" PRIx32 "\n",
+                      (uint32_t)what_swi);
+        common_semi_cb(cs, -1, ENOSYS);
+    }
+}
+
 static void set_addresses(CPUHexagonState *env, uint32_t pc_offset,
                           uint32_t exception_index)
-
 {
     HexagonCPU *cpu = env_archcpu(env);
     uint32_t evb = cpu->globalregs ?
@@ -95,8 +257,7 @@ void hexagon_cpu_do_interrupt(CPUState *cs)
     switch (cs->exception_index) {
     case HEX_EVENT_TRAP0:
         if (env->cause_code == 0) {
-            qemu_log_mask(LOG_UNIMP,
-                          "trap0 is unhandled, no semihosting available\n");
+            sim_handle_trap0(env);
         }
 
         hexagon_ssr_set_cause(env, env->cause_code);
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 4c921eee73..09620de332 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -261,6 +261,7 @@ hexagon_softmmu_ss.add(files(
     'hex_interrupts.c',
     'hexswi.c',
     'machine.c',
+    'common-semi-target.c',
 ))
 
 #
-- 
2.37.2


