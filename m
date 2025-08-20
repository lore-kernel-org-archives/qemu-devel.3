Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFDDCA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohtF-0007Ya-F6; Wed, 20 Aug 2025 08:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uohtA-0007Xl-VW; Wed, 20 Aug 2025 08:26:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1uoht8-0002JQ-3E; Wed, 20 Aug 2025 08:26:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KC2C9D001831;
 Wed, 20 Aug 2025 12:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=bKOzUNNY+VD8OkIEvDBz8PxQQSkp
 /oo9keJUowhsYW4=; b=kURmiLt87QAWeN4Ig7AdxpbpUU2rkf+/D2FTsRLgBsoG
 GhsmS3ysNZptsBS51NgOjO8k35ey259Ndevj+NRaKNzl7zeQKooTHM0bEAP4wXPs
 15RieFsWQCYAvSb8v3x3wuvsBswOk5WpkqXGEvyc2Fb50tU0qNHFi99g5zL+1fkY
 tc6IfUqLwHcTV4s6hZMs+rM6YOHA87Q0h7q4hCfaIRzen1+1hc6ldFDy+gazwjMr
 jBQN3eBeObNJJclAbnN8CM43MLZRJF0GPg1yr0KKeaVtlfIsIeZ7tVRHFLQZtw4h
 WuM5oDdNxU4fA2yu2mUR24FvhLtuVGi3LtdSYsYm5g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w2q6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 12:25:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57KCORhB023630;
 Wed, 20 Aug 2025 12:25:54 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w2q65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 12:25:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9WqFN031994;
 Wed, 20 Aug 2025 12:25:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y36tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 12:25:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57KCPoMR43057654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Aug 2025 12:25:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D6E020043;
 Wed, 20 Aug 2025 12:25:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E3DA20040;
 Wed, 20 Aug 2025 12:25:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.39.18.124]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 Aug 2025 12:25:47 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] fix: Fix build error with CONFIG_POWERNV disabled
Date: Wed, 20 Aug 2025 17:55:17 +0530
Message-ID: <20250820122516.949766-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX1uogxLt/oL3i
 16w7KJCBZXrFPRC/ve7D4+K5KNo5il3S/aNPaNgHfctoAvThIdutsYBhgdeqm6mkjgpaU1o3rqZ
 pEME5FQuba5q5sj40Gv8fOQ7coSAZHMQqosh0AXv+FJwVbqsfDtg6/YImlYdC8BJaFzWPkMyEd7
 A0fI8aUQi9/xFvwdLi92tUa1cqX9sbhyTl690KSrZXYpDnJ1ES3wuBpC+xew05dBkCrr6vnleoG
 3foWKFv+jWLzzi/hGhHwIoGRasiuHg0bYBAsqbKOcDQTtn6+s+qNh6kPHt2zSYWx8xYADPUtHTi
 RZjStW+w6SsiSmejbseCyQ8cMJjugM5gdTufwcnyxbYJQ+jgtsmNHIsqcbP6S/KowX7ruvlV5xQ
 aHZzw6jlPAGRvduWUo+sfzgK3LloVg==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a5bed3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=C3vVYmK1WFFpptpIGSsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TmU1JGELO-Ztf3VbhkEoBORv0_1qmV8W
X-Proofpoint-GUID: 6deFOvo-gGUV9gw3qDmNyzkEIknPmWE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently when CONFIG_POWERNV is not enabled, the build fails, such as
with --without-default-devices:

    $ ./configure --without-default-devices
    $ make

    [281/283] Linking target qemu-system-ppc64
    FAILED: qemu-system-ppc64
    cc -m64 @qemu-system-ppc64.rsp
    /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
    .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
    /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
    .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
    collect2: error: ld returned 1 exit status
    ...

This is since target/ppc/misc_helper.c references PowerNV specific
'pnv_chip_find_core' call.

Split the PowerNV specific SPRD code out of the generic PowerPC code, by
moving the SPRD code to pnv.c

Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
Note that while moving the code, the 'target_ulong' type for sprc has been
modified to 'uint64_t'.

Based on the discussion happened on [1].
Requires patch 1 and patch 2 of [1] to be applied, to fix the build.

[1]: https://lore.kernel.org/qemu-devel/20250526112346.48744-1-philmd@linaro.org/
---
---
 hw/ppc/pnv.c             | 86 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h         |  4 ++
 target/ppc/misc_helper.c | 59 +++------------------------
 3 files changed, 96 insertions(+), 53 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d84c9067edb3..9c74f46091a7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
@@ -1794,12 +1795,83 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static uint64_t pnv_handle_sprd_load(CPUPPCState *env)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    uint64_t sprc = env->spr[SPR_POWER_SPRC];
+
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        return pc->scratch[(sprc >> 3) & 0x7];
+
+    case 0x1e0: /* core thread state */
+        if (env->excp_model == POWERPC_EXCP_POWER9) {
+            /*
+             * Only implement for POWER9 because skiboot uses it to check
+             * big-core mode. Other bits are unimplemented so we would
+             * prefer to get unimplemented message on POWER10 if it were
+             * used anywhere.
+             */
+            if (pc->big_core) {
+                return PPC_BIT(63);
+            } else {
+                return 0;
+            }
+        }
+        /* fallthru */
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+    return 0;
+}
+
+static void pnv_handle_sprd_store(CPUPPCState *env, uint64_t val)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    uint64_t sprc = env->spr[SPR_POWER_SPRC];
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    int nr;
+
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        /*
+         * Log stores to SCRATCH, because some firmware uses these for
+         * debugging and logging, but they would normally be read by the BMC,
+         * which is not implemented in QEMU yet. This gives a way to get at the
+         * information. Could also dump these upon checkstop.
+         */
+        nr = (sprc >> 3) & 0x7;
+        pc->scratch[nr] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+}
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     Pnv9Chip *chip9 = PNV9_CHIP(dev);
     PnvChip *chip = PNV_CHIP(dev);
     Pnv9Psi *psi9 = &chip9->psi;
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *cpu_class;
     Error *local_err = NULL;
     int i;
 
@@ -1827,6 +1899,12 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Set handlers for Special registers, such as SPRD */
+    cpu = chip->cores[0]->threads[0];
+    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
+    cpu_class->load_sprd = pnv_handle_sprd_load;
+    cpu_class->store_sprd = pnv_handle_sprd_store;
+
     /* XIVE interrupt controller (POWER9) */
     object_property_set_int(OBJECT(&chip9->xive), "ic-bar",
                             PNV9_XIVE_IC_BASE(chip), &error_fatal);
@@ -2078,6 +2156,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     PnvChip *chip = PNV_CHIP(dev);
     Pnv10Chip *chip10 = PNV10_CHIP(dev);
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *cpu_class;
     Error *local_err = NULL;
     int i;
 
@@ -2105,6 +2185,12 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Set handlers for Special registers, such as SPRD */
+    cpu = chip->cores[0]->threads[0];
+    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
+    cpu_class->load_sprd = pnv_handle_sprd_load;
+    cpu_class->store_sprd = pnv_handle_sprd_store;
+
     /* XIVE2 interrupt controller (POWER10) */
     object_property_set_int(OBJECT(&chip10->xive), "ic-bar",
                             PNV10_XIVE2_IC_BASE(chip), &error_fatal);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b90543811f0..0e26e4343de7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1522,6 +1522,10 @@ struct PowerPCCPUClass {
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int  (*check_attn)(CPUPPCState *env);
+
+    /* Handlers to be set by the machine initialising the chips */
+    uint64_t (*load_sprd)(CPUPPCState *env);
+    void (*store_sprd)(CPUPPCState *env, uint64_t val);
 };
 
 static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e7d94625185c..0e625cbb704d 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -328,69 +328,22 @@ target_ulong helper_load_sprd(CPUPPCState *env)
      * accessed by powernv machines.
      */
     PowerPCCPU *cpu = env_archcpu(env);
-    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
-    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    if (pc->big_core) {
-        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    if (pcc->load_sprd) {
+        return pcc->load_sprd(env);
     }
 
-    switch (sprc & 0x3e0) {
-    case 0: /* SCRATCH0-3 */
-    case 1: /* SCRATCH4-7 */
-        return pc->scratch[(sprc >> 3) & 0x7];
-
-    case 0x1e0: /* core thread state */
-        if (env->excp_model == POWERPC_EXCP_POWER9) {
-            /*
-             * Only implement for POWER9 because skiboot uses it to check
-             * big-core mode. Other bits are unimplemented so we would
-             * prefer to get unimplemented message on POWER10 if it were
-             * used anywhere.
-             */
-            if (pc->big_core) {
-                return PPC_BIT(63);
-            } else {
-                return 0;
-            }
-        }
-        /* fallthru */
-
-    default:
-        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
-                                  TARGET_FMT_lx"\n", sprc);
-        break;
-    }
     return 0;
 }
 
 void helper_store_sprd(CPUPPCState *env, target_ulong val)
 {
-    target_ulong sprc = env->spr[SPR_POWER_SPRC];
     PowerPCCPU *cpu = env_archcpu(env);
-    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
-    int nr;
-
-    if (pc->big_core) {
-        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
-    }
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    switch (sprc & 0x3e0) {
-    case 0: /* SCRATCH0-3 */
-    case 1: /* SCRATCH4-7 */
-        /*
-         * Log stores to SCRATCH, because some firmware uses these for
-         * debugging and logging, but they would normally be read by the BMC,
-         * which is not implemented in QEMU yet. This gives a way to get at the
-         * information. Could also dump these upon checkstop.
-         */
-        nr = (sprc >> 3) & 0x7;
-        pc->scratch[nr] = val;
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
-                                  TARGET_FMT_lx"\n", sprc);
-        break;
+    if (pcc->store_sprd) {
+        return pcc->store_sprd(env, val);
     }
 }
 
-- 
2.50.1


