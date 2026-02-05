Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CD2E91297
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0Jq-0001Cd-GV; Thu, 05 Feb 2026 09:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Je-00014f-Pk
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:43 -0500
Received: from qs-2003g-snip4-3.eps.apple.com ([57.103.86.66]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0Ja-0007z9-36
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:42 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 411921800D94; Thu,  5 Feb 2026 14:26:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301595; x=1772893595;
 bh=HkRHMpTl2uKI4wNS8ZKWqrFWgjwWuAAq5M2BiLLuN7c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=ALRQgfKz/zyayEJBdnoMACE7HQaJE5oG64doclQ25QV1igMOF3Gxyxe+EG849ilqw6HzhYTYqp69m5NLIBhG3OR6lVvTVYobpV5hAszTD7ghPD0FNC5ojMzx4bGUwoFRt/Q9q0P3uV2KooliMxL/MvDJGDit3vBuE0RVr6w3gedHAefF5VpC2VwHeBpodcYRJoaa/ztynzpDBqcPmO+qoOnyMJ8EZYc0C5r9Hvecl4QDbD0iDv9CnqRE+HFAcgalqsKiCmiXO4UbrkEnrUIa5KpoI9tRmc05mDXcfZDgSIJE9PhLMk2/HyTv6lK8MpaPBuxrC2UKuEjGvW6CjoWuiQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 079B91800DAA; Thu,  5 Feb 2026 14:26:25 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 14/22] whpx: add arm64 support
Date: Thu,  5 Feb 2026 15:25:32 +0100
Message-ID: <20260205142543.64818-15-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=AIp8DMUn c=1 sm=1 tr=0 ts=6984a89a
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=coTCL0kfoV_fbKzCm0sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: bv3gTa5u23C5GWh3fyGFpP8t921CH0eN
X-Proofpoint-ORIG-GUID: bv3gTa5u23C5GWh3fyGFpP8t921CH0eN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfXzHpIfEc2EyhA
 cf56cjLEx5p2cEniTMCGRrDLgTK+wZQNfBNVFH6OeFBNfZDBigfcJLlH3Ew/EdMZp6e5AR6mW9Q
 uNo1vKzWl0Fnlpe2amAQZKdv1aBOfW7ZnZL016yuIaFPrKP2KVss3CM3thFnsnLZq9xAhookE0k
 K/n1R83Sy3619MZeiTX5Ie8SednPt1h7vWOBnoym8wm3fLmR/N7VNsMGp5i1RE1/r+Vw2b225Lq
 5IqVBMQ4IXtwDT5LnHIVGLL3BJ7PxcCvUTuOiop0I4iSA5WrllQvKgbhcofOu5z3WFYqDiJ+GO7
 ADdBiozlA2CR8WAeUkOJi4jnmxskzKtrh0gMuHyNJor4ObwbdUOP5yDsTXmyQ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAAB51jWS8+Sil+dHWyX5FBnUG9OBl9al6nLWtpmJc/thkQ9zi8Y7bt3eDI2plvRDtwAwxZxX5yMVPUXAvRGAi6YGpNSfcjirX8ygyrPzoP58I+nXMFN+gniM4dzLVANEgPb7FP/ttE1l2CPCunue24ZnWcjszEdDANGEkNku6CjQfufljJJG55RjO6wu+RoE/M6tdfCwSHzc23v0N4dv0QeWsReQAzeoSYWFy4mFNBJctGNC1biVY0A00Luc6R710nNi4r1DoTYQ3w4GjO5aQlhFKADeSz5niLzjzAgeGfsX+jnASaLGi4KjPonLdHPQFiHKcPwMXW2PfF6PXTg0ZNP3z9hDOjJTOsGNJlCyFtxwR+IeNxV5EJSTlykG11tEkLDoBaI5Zxzn6bWayQW7fnLHAkhxtt1WVKxdcOKdZdUI6MgLS90WJ1E8IZJuiaHbXo+SrQM+TbLkuOjvGiC7JaLgxFQjbsems8zi+5Ja0oXgNPuku6TdhodpqyPkF6oF/zCHWDYzLdlqSEjPxlqxmlZE+USQvqZaHbRZm7lFLBRn65e4JbInkqv0xJgdrVvqUxEYT35m0mVgd6tivMKVNIVV03PasozhtWgjyorC1a2M3s2GfST91GGr+kog3TfQBSThQFPNDR8f+/K5ytCR8LWiNdcg6ldVNTirWEKu9ncs/tJhMd5lSocJ91QTvJV6Mif5Uz+KgKCtRWjEGi2kbmNsV3/VeYdUte9kFaeKI6iJucmRLWJivSkCvQ/svyu4KP0JR6FZ3BN22MWPeMmBwb/8oyfCZZGWMNhNIOhS2oALLVVuMa1U19Gd9wDEuFw6G8N60Omlj9PBo2NYKxMq5cylAGLbmif/XXP4hRD5W5qdMC94W3HkcdC67VHh2omDho6ykWT1xRRo66+rl0ESuZ/FdJ4S934wfc5eV1WL5Pank3rCErNyZAJpr9UgQ==
Received-SPF: pass client-ip=57.103.86.66;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                 |   1 +
 accel/whpx/whpx-common.c    |   1 +
 target/arm/meson.build      |   1 +
 target/arm/whpx/meson.build |   3 +
 target/arm/whpx/whpx-all.c  | 810 ++++++++++++++++++++++++++++++++++++
 5 files changed, 816 insertions(+)
 create mode 100644 target/arm/whpx/meson.build
 create mode 100644 target/arm/whpx/whpx-all.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 126f72e587..a92cd7050f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -566,6 +566,7 @@ M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx/
 F: hw/intc/arm_gicv3_whpx.c
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 05f9e520b7..827f50f3e0 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -12,6 +12,7 @@
 #include "gdbstub/helpers.h"
 #include "qemu/accel.h"
 #include "accel/accel-ops.h"
+#include "system/memory.h"
 #include "system/whpx.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 462c71148d..ce155ba9b4 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -59,6 +59,7 @@ arm_common_system_ss.add(files(
 ))
 
 subdir('hvf')
+subdir('whpx')
 
 if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
new file mode 100644
index 0000000000..1de2ef0283
--- /dev/null
+++ b/target/arm/whpx/meson.build
@@ -0,0 +1,3 @@
+arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+  'whpx-all.c',
+))
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
new file mode 100644
index 0000000000..192d7ec7a8
--- /dev/null
+++ b/target/arm/whpx/whpx-all.c
@@ -0,0 +1,810 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Windows Hypervisor Platform accelerator (WHPX)
+ *
+ * Copyright (c) 2025 Mohamed Mediouni
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "system/address-spaces.h"
+#include "system/ioport.h"
+#include "gdbstub/helpers.h"
+#include "qemu/accel.h"
+#include "accel/accel-ops.h"
+#include "system/whpx.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "qemu/main-loop.h"
+#include "hw/core/boards.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-types-common.h"
+#include "qapi/qapi-visit-common.h"
+#include "migration/blocker.h"
+#include "accel/accel-cpu-target.h"
+#include <winerror.h>
+
+#include "syndrome.h"
+#include "cpu.h"
+#include "target/arm/cpregs.h"
+#include "internals.h"
+
+#include "system/whpx-internal.h"
+#include "system/whpx-accel-ops.h"
+#include "system/whpx-all.h"
+#include "system/whpx-common.h"
+#include "hw/arm/bsa.h"
+#include "arm-powerctl.h"
+
+#include <winhvplatform.h>
+#include <winhvplatformdefs.h>
+
+typedef struct WHPXRegMatch {
+   WHV_REGISTER_NAME reg;
+   uint64_t offset;
+} WHPXRegMatch;
+
+static const WHPXRegMatch whpx_reg_match[] = {
+    { WHvArm64RegisterX0,   offsetof(CPUARMState, xregs[0]) },
+    { WHvArm64RegisterX1,   offsetof(CPUARMState, xregs[1]) },
+    { WHvArm64RegisterX2,   offsetof(CPUARMState, xregs[2]) },
+    { WHvArm64RegisterX3,   offsetof(CPUARMState, xregs[3]) },
+    { WHvArm64RegisterX4,   offsetof(CPUARMState, xregs[4]) },
+    { WHvArm64RegisterX5,   offsetof(CPUARMState, xregs[5]) },
+    { WHvArm64RegisterX6,   offsetof(CPUARMState, xregs[6]) },
+    { WHvArm64RegisterX7,   offsetof(CPUARMState, xregs[7]) },
+    { WHvArm64RegisterX8,   offsetof(CPUARMState, xregs[8]) },
+    { WHvArm64RegisterX9,   offsetof(CPUARMState, xregs[9]) },
+    { WHvArm64RegisterX10,  offsetof(CPUARMState, xregs[10]) },
+    { WHvArm64RegisterX11,  offsetof(CPUARMState, xregs[11]) },
+    { WHvArm64RegisterX12,  offsetof(CPUARMState, xregs[12]) },
+    { WHvArm64RegisterX13,  offsetof(CPUARMState, xregs[13]) },
+    { WHvArm64RegisterX14,  offsetof(CPUARMState, xregs[14]) },
+    { WHvArm64RegisterX15,  offsetof(CPUARMState, xregs[15]) },
+    { WHvArm64RegisterX16,  offsetof(CPUARMState, xregs[16]) },
+    { WHvArm64RegisterX17,  offsetof(CPUARMState, xregs[17]) },
+    { WHvArm64RegisterX18,  offsetof(CPUARMState, xregs[18]) },
+    { WHvArm64RegisterX19,  offsetof(CPUARMState, xregs[19]) },
+    { WHvArm64RegisterX20,  offsetof(CPUARMState, xregs[20]) },
+    { WHvArm64RegisterX21,  offsetof(CPUARMState, xregs[21]) },
+    { WHvArm64RegisterX22,  offsetof(CPUARMState, xregs[22]) },
+    { WHvArm64RegisterX23,  offsetof(CPUARMState, xregs[23]) },
+    { WHvArm64RegisterX24,  offsetof(CPUARMState, xregs[24]) },
+    { WHvArm64RegisterX25,  offsetof(CPUARMState, xregs[25]) },
+    { WHvArm64RegisterX26,  offsetof(CPUARMState, xregs[26]) },
+    { WHvArm64RegisterX27,  offsetof(CPUARMState, xregs[27]) },
+    { WHvArm64RegisterX28,  offsetof(CPUARMState, xregs[28]) },
+    { WHvArm64RegisterFp,   offsetof(CPUARMState, xregs[29]) },
+    { WHvArm64RegisterLr,   offsetof(CPUARMState, xregs[30]) },
+    { WHvArm64RegisterPc,   offsetof(CPUARMState, pc) },
+};
+
+static const WHPXRegMatch whpx_fpreg_match[] = {
+    { WHvArm64RegisterQ0,  offsetof(CPUARMState, vfp.zregs[0]) },
+    { WHvArm64RegisterQ1,  offsetof(CPUARMState, vfp.zregs[1]) },
+    { WHvArm64RegisterQ2,  offsetof(CPUARMState, vfp.zregs[2]) },
+    { WHvArm64RegisterQ3,  offsetof(CPUARMState, vfp.zregs[3]) },
+    { WHvArm64RegisterQ4,  offsetof(CPUARMState, vfp.zregs[4]) },
+    { WHvArm64RegisterQ5,  offsetof(CPUARMState, vfp.zregs[5]) },
+    { WHvArm64RegisterQ6,  offsetof(CPUARMState, vfp.zregs[6]) },
+    { WHvArm64RegisterQ7,  offsetof(CPUARMState, vfp.zregs[7]) },
+    { WHvArm64RegisterQ8,  offsetof(CPUARMState, vfp.zregs[8]) },
+    { WHvArm64RegisterQ9,  offsetof(CPUARMState, vfp.zregs[9]) },
+    { WHvArm64RegisterQ10, offsetof(CPUARMState, vfp.zregs[10]) },
+    { WHvArm64RegisterQ11, offsetof(CPUARMState, vfp.zregs[11]) },
+    { WHvArm64RegisterQ12, offsetof(CPUARMState, vfp.zregs[12]) },
+    { WHvArm64RegisterQ13, offsetof(CPUARMState, vfp.zregs[13]) },
+    { WHvArm64RegisterQ14, offsetof(CPUARMState, vfp.zregs[14]) },
+    { WHvArm64RegisterQ15, offsetof(CPUARMState, vfp.zregs[15]) },
+    { WHvArm64RegisterQ16, offsetof(CPUARMState, vfp.zregs[16]) },
+    { WHvArm64RegisterQ17, offsetof(CPUARMState, vfp.zregs[17]) },
+    { WHvArm64RegisterQ18, offsetof(CPUARMState, vfp.zregs[18]) },
+    { WHvArm64RegisterQ19, offsetof(CPUARMState, vfp.zregs[19]) },
+    { WHvArm64RegisterQ20, offsetof(CPUARMState, vfp.zregs[20]) },
+    { WHvArm64RegisterQ21, offsetof(CPUARMState, vfp.zregs[21]) },
+    { WHvArm64RegisterQ22, offsetof(CPUARMState, vfp.zregs[22]) },
+    { WHvArm64RegisterQ23, offsetof(CPUARMState, vfp.zregs[23]) },
+    { WHvArm64RegisterQ24, offsetof(CPUARMState, vfp.zregs[24]) },
+    { WHvArm64RegisterQ25, offsetof(CPUARMState, vfp.zregs[25]) },
+    { WHvArm64RegisterQ26, offsetof(CPUARMState, vfp.zregs[26]) },
+    { WHvArm64RegisterQ27, offsetof(CPUARMState, vfp.zregs[27]) },
+    { WHvArm64RegisterQ28, offsetof(CPUARMState, vfp.zregs[28]) },
+    { WHvArm64RegisterQ29, offsetof(CPUARMState, vfp.zregs[29]) },
+    { WHvArm64RegisterQ30, offsetof(CPUARMState, vfp.zregs[30]) },
+    { WHvArm64RegisterQ31, offsetof(CPUARMState, vfp.zregs[31]) },
+};
+
+struct whpx_sreg_match {
+    WHV_REGISTER_NAME reg;
+    uint32_t key;
+    bool global;
+    uint32_t cp_idx;
+};
+
+static struct whpx_sreg_match whpx_sreg_match[] = {
+    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) },
+
+    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) },
+    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) },
+    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) },
+    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) },
+#ifdef SYNC_NO_RAW_REGS
+    /*
+     * The registers below are manually synced on init because they are
+     * marked as NO_RAW. We still list them to make number space sync easier.
+     */
+    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
+    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
+    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
+#endif
+    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
+    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 0), true },
+    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, 1), true },
+#ifdef SYNC_NO_MMFR0
+    /* We keep the hardware MMFR0 around. HW limits are there anyway */
+    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 0) },
+#endif
+    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
+    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
+    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
+
+    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
+    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
+    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
+    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
+    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
+    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
+
+    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) },
+    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) },
+    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) },
+    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) },
+    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) },
+    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) },
+    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) },
+    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) },
+    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) },
+    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) },
+
+    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
+    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
+    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
+    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
+    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
+    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
+    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
+    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
+    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 1) },
+    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
+    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) },
+    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
+    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
+    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) },
+    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) },
+    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) },
+    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
+};
+
+static void flush_cpu_state(CPUState *cpu)
+{
+    if (cpu->vcpu_dirty) {
+        whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+        cpu->vcpu_dirty = false;
+    }
+}
+
+HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
+{
+    if (exceptions != 0) {
+        return E_NOTIMPL;
+    }
+    return ERROR_SUCCESS;
+}
+void whpx_apply_breakpoints(
+    struct whpx_breakpoint_collection *breakpoints,
+    CPUState *cpu,
+    bool resuming)
+{
+    /* Breakpoints aren’t supported on this platform */
+}
+void whpx_translate_cpu_breakpoints(
+    struct whpx_breakpoints *breakpoints,
+    CPUState *cpu,
+    int cpu_breakpoint_count)
+{
+    /* Breakpoints aren’t supported on this platform */
+}
+
+static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+
+    flush_cpu_state(cpu);
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+static void whpx_set_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, cpu->cpu_index,
+         &reg, 1, &val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+static void whpx_get_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE *val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(whpx->partition, WHV_ANY_VP,
+         &reg, 1, val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+static void whpx_set_global_reg(WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE val)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(whpx->partition, WHV_ANY_VP,
+         &reg, 1, &val);
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register %08x, hr=%08lx", reg, hr);
+    }
+}
+
+static uint64_t whpx_get_gp_reg(CPUState *cpu, int rt)
+{
+    assert(rt <= 31);
+    if (rt == 31) {
+        return 0;
+    }
+    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
+    WHV_REGISTER_VALUE val;
+    whpx_get_reg(cpu, reg, &val);
+
+    return val.Reg64;
+}
+
+static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
+{
+    assert(rt < 31);
+    WHV_REGISTER_NAME reg = WHvArm64RegisterX0 + rt;
+    WHV_REGISTER_VALUE reg_val = {.Reg64 = val};
+
+    whpx_set_reg(cpu, reg, reg_val);
+}
+
+static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
+{
+    uint64_t syndrome = ctx->Syndrome;
+
+    bool isv = syndrome & ARM_EL_ISV;
+    bool iswrite = (syndrome >> 6) & 1;
+    bool sse = (syndrome >> 21) & 1;
+    uint32_t sas = (syndrome >> 22) & 3;
+    uint32_t len = 1 << sas;
+    uint32_t srt = (syndrome >> 16) & 0x1f;
+    uint32_t cm = (syndrome >> 8) & 0x1;
+    uint64_t val = 0;
+
+    assert(!cm);
+    assert(isv);
+
+    if (iswrite) {
+        val = whpx_get_gp_reg(cpu, srt);
+        address_space_write(&address_space_memory,
+                            ctx->Gpa,
+                            MEMTXATTRS_UNSPECIFIED, &val, len);
+    } else {
+        address_space_read(&address_space_memory,
+                           ctx->Gpa,
+                           MEMTXATTRS_UNSPECIFIED, &val, len);
+        if (sse) {
+            val = sextract64(val, 0, len * 8);
+        }
+        whpx_set_gp_reg(cpu, srt, val);
+    }
+
+    return 0;
+}
+
+static void whpx_psci_cpu_off(ARMCPU *arm_cpu)
+{
+    int32_t ret = arm_set_cpu_off(arm_cpu_mp_affinity(arm_cpu));
+    assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
+}
+
+int whpx_vcpu_run(CPUState *cpu)
+{
+    HRESULT hr;
+    struct whpx_state *whpx = &whpx_global;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    AccelCPUState *vcpu = cpu->accel;
+    int ret;
+
+
+    g_assert(bql_locked());
+
+    if (whpx->running_cpus++ == 0) {
+        ret = whpx_first_vcpu_starting(cpu);
+        if (ret != 0) {
+            return ret;
+        }
+    }
+
+    bql_unlock();
+
+
+    cpu_exec_start(cpu);
+    do {
+        bool advance_pc = false;
+        if (cpu->vcpu_dirty) {
+            whpx_set_registers(cpu, WHPX_SET_RUNTIME_STATE);
+            cpu->vcpu_dirty = false;
+        }
+
+        if (qatomic_read(&cpu->exit_request)) {
+            whpx_vcpu_kick(cpu);
+        }
+
+        hr = whp_dispatch.WHvRunVirtualProcessor(
+            whpx->partition, cpu->cpu_index,
+            &vcpu->exit_ctx, sizeof(vcpu->exit_ctx));
+
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to exec a virtual processor,"
+                         " hr=%08lx", hr);
+            ret = -1;
+            break;
+        }
+
+        switch (vcpu->exit_ctx.ExitReason) {
+        case WHvRunVpExitReasonGpaIntercept:
+        case WHvRunVpExitReasonUnmappedGpa:
+            advance_pc = true;
+
+            if (vcpu->exit_ctx.MemoryAccess.Syndrome & BIT(8)) {
+                error_report("WHPX: cached access to unmapped memory"
+                "Pc = 0x%llx Gva = 0x%llx Gpa = 0x%llx",
+                vcpu->exit_ctx.MemoryAccess.Header.Pc,
+                vcpu->exit_ctx.MemoryAccess.Gpa,
+                vcpu->exit_ctx.MemoryAccess.Gva);
+                break;
+            }
+
+            ret = whpx_handle_mmio(cpu, &vcpu->exit_ctx.MemoryAccess);
+            break;
+        case WHvRunVpExitReasonCanceled:
+            cpu->exception_index = EXCP_INTERRUPT;
+            ret = 1;
+            break;
+        case WHvRunVpExitReasonArm64Reset:
+            switch (vcpu->exit_ctx.Arm64Reset.ResetType) {
+            case WHvArm64ResetTypePowerOff:
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+                break;
+            case WHvArm64ResetTypeReboot:
+                qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            bql_lock();
+            if (arm_cpu->power_state != PSCI_OFF) {
+                whpx_psci_cpu_off(arm_cpu);
+            }
+            bql_unlock();
+            break;
+        case WHvRunVpExitReasonNone:
+        case WHvRunVpExitReasonUnrecoverableException:
+        case WHvRunVpExitReasonInvalidVpRegisterValue:
+        case WHvRunVpExitReasonUnsupportedFeature:
+        default:
+            error_report("WHPX: Unexpected VP exit code 0x%08x",
+                         vcpu->exit_ctx.ExitReason);
+            whpx_get_registers(cpu);
+            bql_lock();
+            qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+            bql_unlock();
+            break;
+        }
+        if (advance_pc) {
+            WHV_REGISTER_VALUE pc;
+
+            flush_cpu_state(cpu);
+            pc.Reg64 = vcpu->exit_ctx.MemoryAccess.Header.Pc + 4;
+            whpx_set_reg(cpu, WHvArm64RegisterPc, pc);
+        }
+    } while (!ret);
+
+    cpu_exec_end(cpu);
+
+    bql_lock();
+    current_cpu = cpu;
+
+    if (--whpx->running_cpus == 0) {
+        whpx_last_vcpu_stopping(cpu);
+    }
+
+    qatomic_set(&cpu->exit_request, false);
+
+    return ret < 0;
+}
+
+static void clean_whv_register_value(WHV_REGISTER_VALUE *val)
+{
+    memset(val, 0, sizeof(WHV_REGISTER_VALUE));
+}
+
+void whpx_get_registers(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    WHV_REGISTER_VALUE val;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
+        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
+        *(uint64_t *)((char *)env + whpx_reg_match[i].offset) = val.Reg64;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
+        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
+        memcpy((char *)env + whpx_fpreg_match[i].offset, &val, sizeof(val.Reg128));
+    }
+
+    whpx_get_reg(cpu, WHvArm64RegisterPc, &val);
+    env->pc = val.Reg64;
+
+    whpx_get_reg(cpu, WHvArm64RegisterFpcr, &val);
+    vfp_set_fpcr(env, val.Reg32);
+
+    whpx_get_reg(cpu, WHvArm64RegisterFpsr, &val);
+    vfp_set_fpsr(env, val.Reg32);
+
+    whpx_get_reg(cpu, WHvArm64RegisterPstate, &val);
+    pstate_write(env, val.Reg32);
+
+    for (i = 0; i < ARRAY_SIZE(whpx_sreg_match); i++) {
+        if (whpx_sreg_match[i].cp_idx == -1) {
+            continue;
+        }
+
+        if (whpx_sreg_match[i].global) {
+            /* WHP disallows us from accessing global regs as a vCPU */
+            whpx_get_global_reg(whpx_sreg_match[i].reg, &val);
+        } else {
+            whpx_get_reg(cpu, whpx_sreg_match[i].reg, &val);
+        }
+        arm_cpu->cpreg_values[whpx_sreg_match[i].cp_idx] = val.Reg64;
+    }
+
+    assert(write_list_to_cpustate(arm_cpu));
+    aarch64_restore_sp(env, arm_current_el(env));
+}
+
+void whpx_set_registers(CPUState *cpu, int level)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    WHV_REGISTER_VALUE val;
+    clean_whv_register_value(&val);
+    int i;
+
+    assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
+
+    for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
+        val.Reg64 = *(uint64_t *)((char *)env + whpx_reg_match[i].offset);
+        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
+        memcpy(&val.Reg128, (char *)env + whpx_fpreg_match[i].offset, sizeof(val.Reg128));
+        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
+    }
+
+    clean_whv_register_value(&val);
+    val.Reg64 = env->pc;
+    whpx_set_reg(cpu, WHvArm64RegisterPc, val);
+
+    clean_whv_register_value(&val);
+    val.Reg32 = vfp_get_fpcr(env);
+    whpx_set_reg(cpu, WHvArm64RegisterFpcr, val);
+    val.Reg32 = vfp_get_fpsr(env);
+    whpx_set_reg(cpu, WHvArm64RegisterFpsr, val);
+    val.Reg32 = pstate_read(env);
+    whpx_set_reg(cpu, WHvArm64RegisterPstate, val);
+
+    aarch64_save_sp(env, arm_current_el(env));
+
+    assert(write_cpustate_to_list(arm_cpu, false));
+
+    /* Currently set global regs every time. */
+    for (i = 0; i < ARRAY_SIZE(whpx_sreg_match); i++) {
+        if (whpx_sreg_match[i].cp_idx == -1) {
+            continue;
+        }
+
+        val.Reg64 = arm_cpu->cpreg_values[whpx_sreg_match[i].cp_idx];
+        if (whpx_sreg_match[i].global) {
+            /* WHP disallows us from accessing global regs as a vCPU */
+            whpx_set_global_reg(whpx_sreg_match[i].reg, val);
+        } else {
+            whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
+        }
+    }
+}
+
+static uint32_t max_vcpu_index;
+
+static void whpx_cpu_update_state(void *opaque, bool running, RunState state)
+{
+}
+
+int whpx_init_vcpu(CPUState *cpu)
+{
+    HRESULT hr;
+    struct whpx_state *whpx = &whpx_global;
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    uint32_t sregs_match_len = ARRAY_SIZE(whpx_sreg_match);
+    uint32_t sregs_cnt = 0;
+    WHV_REGISTER_VALUE val;
+    int i;
+
+    hr = whp_dispatch.WHvCreateVirtualProcessor(
+        whpx->partition, cpu->cpu_index, 0);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to create a virtual processor,"
+                     " hr=%08lx", hr);
+        return -EINVAL;
+    }
+
+    /* Assumption that CNTFRQ_EL0 is the same between the VMM and the partition. */
+    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
+
+    cpu->vcpu_dirty = true;
+    cpu->accel = g_new0(AccelCPUState, 1);
+    max_vcpu_index = MAX(max_vcpu_index, cpu->cpu_index);
+    qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
+
+    env->aarch64 = true;
+
+    /* Allocate enough space for our sysreg sync */
+    arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
+                                     sregs_match_len);
+    arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
+                                    sregs_match_len);
+    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
+                                             arm_cpu->cpreg_vmstate_indexes,
+                                             sregs_match_len);
+    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
+                                            arm_cpu->cpreg_vmstate_values,
+                                            sregs_match_len);
+
+    memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
+
+    /* Populate cp list for all known sysregs */
+    for (i = 0; i < sregs_match_len; i++) {
+        const ARMCPRegInfo *ri;
+        uint32_t key = whpx_sreg_match[i].key;
+
+        ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+        if (ri) {
+            assert(!(ri->type & ARM_CP_NO_RAW));
+            whpx_sreg_match[i].cp_idx = sregs_cnt;
+            arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
+        } else {
+            whpx_sreg_match[i].cp_idx = -1;
+        }
+    }
+    arm_cpu->cpreg_array_len = sregs_cnt;
+    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
+
+    assert(write_cpustate_to_list(arm_cpu, false));
+
+    /* Set CP_NO_RAW system registers on init */
+    val.Reg64 = arm_cpu->midr;
+    whpx_set_reg(cpu, WHvArm64RegisterMidrEl1,
+                              val);
+
+    clean_whv_register_value(&val);
+
+    val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
+    whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
+
+    return 0;
+}
+
+void whpx_cpu_instance_init(CPUState *cs)
+{
+}
+
+int whpx_accel_init(AccelState *as, MachineState *ms)
+{
+    struct whpx_state *whpx;
+    int ret;
+    HRESULT hr;
+    WHV_CAPABILITY whpx_cap;
+    UINT32 whpx_cap_size;
+    WHV_PARTITION_PROPERTY prop;
+    WHV_CAPABILITY_FEATURES features;
+
+    whpx = &whpx_global;
+    /* on arm64 Windows Hypervisor Platform, vGICv3 always used */
+    whpx_irqchip_in_kernel = true;
+
+    if (!init_whp_dispatch()) {
+        ret = -ENOSYS;
+        goto error;
+    }
+
+    whpx->mem_quota = ms->ram_size;
+
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeHypervisorPresent, &whpx_cap,
+        sizeof(whpx_cap), &whpx_cap_size);
+    if (FAILED(hr) || !whpx_cap.HypervisorPresent) {
+        error_report("WHPX: No accelerator found, hr=%08lx", hr);
+        ret = -ENOSPC;
+        goto error;
+    }
+
+    memset(&features, 0, sizeof(features));
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeFeatures, &features, sizeof(features), NULL);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to query capabilities, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    if (!features.Arm64Support) {
+        error_report("WHPX: host OS exposing pre-release WHPX implementation. "
+            "Please update your operating system to at least build 26100.3915");
+        ret = -EINVAL;
+        goto error;
+    }
+
+    hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to create partition, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    memset(&prop, 0, sizeof(prop));
+    prop.ProcessorCount = ms->smp.cpus;
+    hr = whp_dispatch.WHvSetPartitionProperty(
+        whpx->partition,
+        WHvPartitionPropertyCodeProcessorCount,
+        &prop,
+        sizeof(prop));
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set partition processor count to %u,"
+                     " hr=%08lx", prop.ProcessorCount, hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    if (!whpx->kernel_irqchip_allowed) {
+        error_report("WHPX: on Arm, only kernel-irqchip=on is currently supported");
+        ret = -EINVAL;
+        goto error;
+    }
+
+    memset(&prop, 0, sizeof(prop));
+
+    hr = whp_dispatch.WHvSetupPartition(whpx->partition);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to setup partition, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
+    whpx_memory_init();
+
+    return 0;
+
+error:
+    if (whpx->partition != NULL) {
+        whp_dispatch.WHvDeletePartition(whpx->partition);
+        whpx->partition = NULL;
+    }
+
+    return ret;
+}
-- 
2.50.1 (Apple Git-155)


