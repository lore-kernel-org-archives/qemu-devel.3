Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02582C44500
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2026 10:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfxk2-0002jf-5O; Sat, 04 Jul 2026 06:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wfxjz-0002hh-W5; Sat, 04 Jul 2026 06:36:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wfxjv-0003HD-7H; Sat, 04 Jul 2026 06:36:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6646o7FT1016972; Sat, 4 Jul 2026 10:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=A87RKt
 bDO4DcV+crlwTe7vWoL1PLlKly19ku5OZg2WY=; b=VBgN57+8Im+gBsiDx32VnC
 ipemXcRLFSIcs6wZfp6LgD8I+xHi2G8GQ86fBxfFc5tMsiKAYU1y0x2fx97gBqkC
 hWISlf36HYIMN8s5pToCIgtB/IaJ8hdzeFKjycqlW1VPGlc7BmKKFdzh+yJborik
 cwUgNyvUbRZO7P564fAqQyeb2SlrWc76/rBm+UOkrq3XZOX30EBXu1SL0zZkefT3
 4D9CQhg0/8noQHBM79U1e5DU1vTM9s/V7+ttJwAAb9u1HhlHCXpfq0zVlDnBXZw3
 /K6P7YBZ4Qo5L/kTtsk4ZfTmrgZ0aXVXMbCkYaJWrUr1Doq1iDfxIuCUCkXqJuCQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suq914c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 10:36:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 664AYlvu029296;
 Sat, 4 Jul 2026 10:36:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2sukmbr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 04 Jul 2026 10:36:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 664AagTv46137838
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 4 Jul 2026 10:36:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9ECC220043;
 Sat,  4 Jul 2026 10:36:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33CCB20040;
 Sat,  4 Jul 2026 10:36:38 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.212.207])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  4 Jul 2026 10:36:37 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, sbhat@linux.ibm.com, gautam@linux.ibm.com,
 Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH 1/2] ppc/spapr: refactor cpu hotplug code to separate file
Date: Sat,  4 Jul 2026 16:06:14 +0530
Message-ID: <20260704103617.632929-4-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704103617.632929-2-vishalc@linux.ibm.com>
References: <20260704103617.632929-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDEwMiBTYWx0ZWRfX02pHS2zsjpw5
 kV7t0wmFqno51fV6HPbFnKwoNlq/N9gbsQsvy+TBAci1GxxfQcIQnLsCBtUYLU2EhWytW3axbJO
 9I0p2FSZeqHm89KVRlfgcKqgut9cj7s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDEwMiBTYWx0ZWRfXzL8OBVg/aC8w
 JFRTmyL8ff7lg/tJqcwWwz5QQFK/4Vzyn7yyheEhJGC+h4x67z0mMT5GFFXqRE52M+sd/INC6Tz
 IYhtSEvLEqKn1L6s+/ZTt7jC06H79BH/HUwwU1kGwonxjporWjKuYqf0S9w2UB3apaT+UGuTbvi
 NWnPcV7C3Jpx8yoc+9yTs7FiJTnimVkNFtqslrn1ohoHjhoM1l2XBS8/aAcvNlhBKOhYS7tlQ4Q
 oR+x3tcvcOCP6Xqphm+mQCzXFx11MP4LLuMBHOHPC/GhV1wC/Yiq0etp9AKvG5JwR50prGnwUe5
 rF4QGhZNKuSaoXUVLqiiVcxGt06MOxM1TcfBb18d+wR+zozcYliOq4qM89DOayEvBtvRG5zgl2E
 GOiPk0NEN+cfqjG6MbDbfwq6CJqegaSStIL7sQwaxgiP2HBE+xosdYbKJIc/u8txLrUuSPl68bl
 C1knNM3FlSZUIqEVziA==
X-Proofpoint-GUID: 5mghCe_gL_gk9VKQ8-dQcQyeIqQ1O77P
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a48e241 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=QV2DFvGgecQSnC3fnDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y8MQLPSljNqRoJRIpON7vpAZeE1yBgoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Move CPU hotplug-related code from spapr.c into a new dedicated file
spapr_cpu_hotplug.c. A corresponding header file exports the public
interfaces needed by other sPAPR subsystems.

Also updating MAINTAINERS entry for PPC KVM CPUs to include these newly
added files along with spapr_cpu_core.c for better maintainability.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 MAINTAINERS                        |   3 +
 hw/ppc/meson.build                 |   1 +
 hw/ppc/spapr.c                     | 903 +-------------------------
 hw/ppc/spapr_cpu_hotplug.c         | 984 +++++++++++++++++++++++++++++
 include/hw/ppc/spapr_cpu_hotplug.h |  74 +++
 5 files changed, 1063 insertions(+), 902 deletions(-)
 create mode 100644 hw/ppc/spapr_cpu_hotplug.c
 create mode 100644 include/hw/ppc/spapr_cpu_hotplug.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded..cb19e868b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -490,6 +490,9 @@ M: Nicholas Piggin <npiggin@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 S: Odd Fixes
 F: target/ppc/kvm.c
+F: hw/ppc/spapr_cpu_core.c
+F: hw/ppc/spapr_cpu_hotplug.c
+F: include/hw/ppc/spapr_cpu_hotplug.h
 
 S390 KVM CPUs
 M: Halil Pasic <pasic@linux.ibm.com>
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 37aa535db2..98435bbca9 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -20,6 +20,7 @@ ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
   'spapr_rtc.c',
   'spapr_drc.c',
   'spapr_cpu_core.c',
+  'spapr_cpu_hotplug.c',
   'spapr_ovec.c',
   'spapr_irq.c',
   'spapr_tpm_proxy.c',
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e9..374bf1cfbf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -88,6 +88,7 @@
 #include "hw/intc/intc.h"
 
 #include "hw/ppc/spapr_cpu_core.h"
+#include "hw/ppc/spapr_cpu_hotplug.h"
 #include "hw/mem/memory-device.h"
 #include "hw/ppc/spapr_tpm_proxy.h"
 #include "hw/ppc/spapr_nvdimm.h"
@@ -116,220 +117,6 @@
 
 #define PHANDLE_INTC            0x00001111
 
-/* These two functions implement the VCPU id numbering: one to compute them
- * all and one to identify thread 0 of a VCORE. Any change to the first one
- * is likely to have an impact on the second one, so let's keep them close.
- */
-static int spapr_vcpu_id(SpaprMachineState *spapr, int cpu_index)
-{
-    MachineState *ms = MACHINE(spapr);
-    unsigned int smp_threads = ms->smp.threads;
-
-    assert(spapr->vsmt);
-    return
-        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;
-}
-static bool spapr_is_thread0_in_vcore(SpaprMachineState *spapr,
-                                      PowerPCCPU *cpu)
-{
-    assert(spapr->vsmt);
-    return spapr_get_vcpu_id(cpu) % spapr->vsmt == 0;
-}
-
-int spapr_max_server_number(SpaprMachineState *spapr)
-{
-    MachineState *ms = MACHINE(spapr);
-
-    assert(spapr->vsmt);
-    return DIV_ROUND_UP(ms->smp.max_cpus * spapr->vsmt, ms->smp.threads);
-}
-
-static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
-                                  int smt_threads)
-{
-    int i, ret = 0;
-    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
-    g_autofree uint32_t *gservers_prop = g_new(uint32_t, smt_threads * 2);
-    int index = spapr_get_vcpu_id(cpu);
-
-    if (cpu->compat_pvr) {
-        ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
-    /* Build interrupt servers and gservers properties */
-    for (i = 0; i < smt_threads; i++) {
-        servers_prop[i] = cpu_to_be32(index + i);
-        /* Hack, direct the group queues back to cpu 0 */
-        gservers_prop[i*2] = cpu_to_be32(index + i);
-        gservers_prop[i*2 + 1] = 0;
-    }
-    ret = fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
-                      servers_prop, sizeof(*servers_prop) * smt_threads);
-    if (ret < 0) {
-        return ret;
-    }
-    ret = fdt_setprop(fdt, offset, "ibm,ppc-interrupt-gserver#s",
-                      gservers_prop, sizeof(*gservers_prop) * smt_threads * 2);
-
-    return ret;
-}
-
-static void spapr_dt_pa_features(SpaprMachineState *spapr,
-                                 PowerPCCPU *cpu,
-                                 void *fdt, int offset)
-{
-    /*
-     * SSO (SAO) ordering is supported on KVM and thread=single hosts,
-     * but not MTTCG, so disable it. To advertise it, a cap would have
-     * to be added, or support implemented for MTTCG.
-     *
-     * Copy/paste is not supported by TCG, so it is not advertised. KVM
-     * can execute them but it has no accelerator drivers which are usable,
-     * so there isn't much need for it anyway.
-     */
-
-    /* These should be kept in sync with pnv */
-    uint8_t pa_features_206[] = { 6, 0,
-        0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
-    uint8_t pa_features_207[] = { 24, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0,
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
-    uint8_t pa_features_300[] = { 66, 0,
-        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
-        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
-        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
-        /* 6: DS207 */
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
-        /* 16: Vector */
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        /* 18: Vec. Scalar, 20: Vec. XOR */
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
-        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
-        /* 32: LE atomic, 34: EBB + ext EBB */
-        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
-        /* 40: Radix MMU */
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
-        /* 42: PM, 44: PC RA, 46: SC vec'd */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
-        /* 48: SIMD, 50: QP BFP, 52: String */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
-        /* 54: DecFP, 56: DecI, 58: SHA */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
-        /* 60: NM atomic, 62: RNG */
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
-    };
-    /* 3.1 removes SAO, HTM support */
-    uint8_t pa_features_31[] = { 74, 0,
-        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
-        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
-        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
-        /* 6: DS207 */
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
-        /* 16: Vector */
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
-        /* 18: Vec. Scalar, 20: Vec. XOR */
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
-        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
-        /* 32: LE atomic, 34: EBB + ext EBB */
-        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
-        /* 40: Radix MMU */
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
-        /* 42: PM, 44: PC RA, 46: SC vec'd */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
-        /* 48: SIMD, 50: QP BFP, 52: String */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
-        /* 54: DecFP, 56: DecI, 58: SHA */
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
-        /* 60: NM atomic, 62: RNG, 64: DAWR1 (ISA 3.1) */
-        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
-        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
-        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
-        /* 72: [P]HASHST/[P]HASHCHK */
-        0x80, 0x00,                         /* 72 - 73 */
-    };
-    uint8_t *pa_features = NULL;
-    size_t pa_size;
-
-    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06, 0, cpu->compat_pvr)) {
-        pa_features = pa_features_206;
-        pa_size = sizeof(pa_features_206);
-    }
-    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07, 0, cpu->compat_pvr)) {
-        pa_features = pa_features_207;
-        pa_size = sizeof(pa_features_207);
-    }
-    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0, cpu->compat_pvr)) {
-        pa_features = pa_features_300;
-        pa_size = sizeof(pa_features_300);
-    }
-    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
-        pa_features = pa_features_31;
-        pa_size = sizeof(pa_features_31);
-    }
-    if (!pa_features) {
-        return;
-    }
-
-    if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
-        /*
-         * Note: we keep CI large pages off by default because a 64K capable
-         * guest provisioned with large pages might otherwise try to map a qemu
-         * framebuffer (or other kind of memory mapped PCI BAR) using 64K pages
-         * even if that qemu runs on a 4k host.
-         * We dd this bit back here if we are confident this is not an issue
-         */
-        pa_features[3] |= 0x20;
-    }
-    if ((spapr_get_cap(spapr, SPAPR_CAP_HTM) != 0) && pa_size > 24) {
-        pa_features[24] |= 0x80;    /* Transactional memory support */
-    }
-    if (spapr->cas_pre_isa3_guest && pa_size > 40) {
-        /* Workaround for broken kernels that attempt (guest) radix
-         * mode when they can't handle it, if they see the radix bit set
-         * in pa-features. So hide it from them. */
-        pa_features[40 + 2] &= ~0x80; /* Radix MMU */
-    }
-    if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
-        g_assert(pa_size > 66);
-        pa_features[66] |= 0x80;
-    }
-
-    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
-}
-
-static void spapr_dt_pi_features(SpaprMachineState *spapr,
-                                 PowerPCCPU *cpu,
-                                 void *fdt, int offset)
-{
-    uint8_t pi_features[] = { 1, 0,
-        0x00 };
-
-    if (kvm_enabled() && ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
-                                          0, cpu->compat_pvr)) {
-        /*
-         * POWER9 and later CPUs with KVM run in LPAR-per-thread mode where
-         * all threads are essentially independent CPUs, and msgsndp does not
-         * work (because it is physically-addressed) and therefore is
-         * emulated by KVM, so disable it here to ensure XIVE will be used.
-         * This is both KVM and CPU implementation-specific behaviour so a KVM
-         * cap would be cleanest, but for now this works. If KVM ever permits
-         * native msgsndp execution by guests, a cap could be added at that
-         * time.
-         */
-        pi_features[2] |= 0x08; /* 4: No msgsndp */
-    }
-
-    _FDT((fdt_setprop(fdt, offset, "ibm,pi-features", pi_features,
-                      sizeof(pi_features))));
-}
-
 static hwaddr spapr_node0_size(MachineState *machine)
 {
     if (machine->numa_state->num_nodes) {
@@ -685,200 +472,6 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
     return 0;
 }
 
-static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
-                         SpaprMachineState *spapr)
-{
-    MachineState *ms = MACHINE(spapr);
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
-    int index = spapr_get_vcpu_id(cpu);
-    uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
-                       0xffffffff, 0xffffffff};
-    uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
-        : SPAPR_TIMEBASE_FREQ;
-    uint32_t cpufreq = kvm_enabled() ? kvmppc_get_clockfreq() : 1000000000;
-    uint32_t page_sizes_prop[64];
-    size_t page_sizes_prop_size;
-    unsigned int smp_threads = ms->smp.threads;
-    uint32_t vcpus_per_socket = smp_threads * ms->smp.cores;
-    uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
-    int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
-    SpaprDrc *drc;
-    int drc_index;
-    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
-    int i;
-
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, env->core_index);
-    if (drc) {
-        drc_index = spapr_drc_index(drc);
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
-    }
-
-    _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
-    _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
-
-    _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR])));
-    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-block-size",
-                           env->dcache_line_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-line-size",
-                           env->dcache_line_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-block-size",
-                           env->icache_line_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-line-size",
-                           env->icache_line_size)));
-
-    if (pcc->l1_dcache_size) {
-        _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
-                               pcc->l1_dcache_size)));
-    } else {
-        warn_report("Unknown L1 dcache size for cpu");
-    }
-    if (pcc->l1_icache_size) {
-        _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
-                               pcc->l1_icache_size)));
-    } else {
-        warn_report("Unknown L1 icache size for cpu");
-    }
-
-    _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
-    _FDT((fdt_setprop_cell(fdt, offset, "slb-size", cpu->hash64_opts->slb_size)));
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size", cpu->hash64_opts->slb_size)));
-    _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
-    _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
-
-    if (ppc_has_spr(cpu, SPR_PURR)) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
-    }
-    if (ppc_has_spr(cpu, SPR_PURR)) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
-    }
-
-    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
-        _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
-                          segs, sizeof(segs))));
-    }
-
-    /* Advertise VSX (vector extensions) if available
-     *   1               == VMX / Altivec available
-     *   2               == VSX available
-     *
-     * Only CPUs for which we create core types in spapr_cpu_core.c
-     * are possible, and all of those have VMX */
-    if (env->insns_flags & PPC_ALTIVEC) {
-        if (spapr_get_cap(spapr, SPAPR_CAP_VSX) != 0) {
-            _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
-        } else {
-            _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
-        }
-    }
-
-    /* Advertise DFP (Decimal Floating Point) if available
-     *   0 / no property == no DFP
-     *   1               == DFP available */
-    if (spapr_get_cap(spapr, SPAPR_CAP_DFP) != 0) {
-        _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
-    }
-
-    page_sizes_prop_size = ppc_create_page_sizes_prop(cpu, page_sizes_prop,
-                                                      sizeof(page_sizes_prop));
-    if (page_sizes_prop_size) {
-        _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
-                          page_sizes_prop, page_sizes_prop_size)));
-    }
-
-    spapr_dt_pa_features(spapr, cpu, fdt, offset);
-
-    spapr_dt_pi_features(spapr, cpu, fdt, offset);
-
-    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
-                           cs->cpu_index / vcpus_per_socket)));
-
-    _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
-                      pft_size_prop, sizeof(pft_size_prop))));
-
-    if (ms->numa_state->num_nodes > 1) {
-        _FDT(spapr_numa_fixup_cpu_dt(spapr, fdt, offset, cpu));
-    }
-
-    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
-
-    if (pcc->radix_page_info) {
-        for (i = 0; i < pcc->radix_page_info->count; i++) {
-            radix_AP_encodings[i] =
-                cpu_to_be32(pcc->radix_page_info->entries[i]);
-        }
-        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
-                          radix_AP_encodings,
-                          pcc->radix_page_info->count *
-                          sizeof(radix_AP_encodings[0]))));
-    }
-
-    /*
-     * We set this property to let the guest know that it can use the large
-     * decrementer and its width in bits.
-     */
-    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER) != SPAPR_CAP_OFF)
-        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
-                              pcc->lrg_decr_bits)));
-}
-
-static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr, CPUState *cs,
-                             int cpus_offset)
-{
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    int index = spapr_get_vcpu_id(cpu);
-    DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    g_autofree char *nodename = NULL;
-    int offset;
-
-    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
-        return;
-    }
-
-    nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
-    offset = fdt_add_subnode(fdt, cpus_offset, nodename);
-    _FDT(offset);
-    spapr_dt_cpu(cs, fdt, offset, spapr);
-}
-
-
-static void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
-{
-    CPUState **rev;
-    CPUState *cs;
-    int n_cpus;
-    int cpus_offset;
-    int i;
-
-    cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
-    _FDT(cpus_offset);
-    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
-    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
-
-    /*
-     * We walk the CPUs in reverse order to ensure that CPU DT nodes
-     * created by fdt_add_subnode() end up in the right order in FDT
-     * for the guest kernel the enumerate the CPUs correctly.
-     *
-     * The CPU list cannot be traversed in reverse order, so we need
-     * to do extra work.
-     */
-    n_cpus = 0;
-    rev = NULL;
-    CPU_FOREACH(cs) {
-        rev = g_renew(CPUState *, rev, n_cpus + 1);
-        rev[n_cpus++] = cs;
-    }
-
-    for (i = n_cpus - 1; i >= 0; i--) {
-        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);
-    }
-
-    g_free(rev);
-}
-
 static int spapr_dt_rng(void *fdt)
 {
     int node;
@@ -2650,150 +2243,6 @@ static void spapr_validate_node_memory(MachineState *machine, Error **errp)
 }
 
 /* find cpu slot in machine->possible_cpus by core_id */
-static CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
-{
-    int index = id / ms->smp.threads;
-
-    if (index >= ms->possible_cpus->len) {
-        return NULL;
-    }
-    if (idx) {
-        *idx = index;
-    }
-    return &ms->possible_cpus->cpus[index];
-}
-
-static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
-{
-    MachineState *ms = MACHINE(spapr);
-    Error *local_err = NULL;
-    bool vsmt_user = !!spapr->vsmt;
-    int kvm_smt = kvmppc_smt_threads();
-    int ret;
-    unsigned int smp_threads = ms->smp.threads;
-
-    if (tcg_enabled()) {
-        if (smp_threads > 1 &&
-            !ppc_type_check_compat(ms->cpu_type, CPU_POWERPC_LOGICAL_2_07, 0,
-                                   spapr->max_compat_pvr)) {
-            error_setg(errp, "TCG only supports SMT on POWER8 or newer CPUs");
-            return;
-        }
-
-        if (smp_threads > 8) {
-            error_setg(errp, "TCG cannot support more than 8 threads/core "
-                       "on a pseries machine");
-            return;
-        }
-    }
-    if (!is_power_of_2(smp_threads)) {
-        error_setg(errp, "Cannot support %d threads/core on a pseries "
-                   "machine because it must be a power of 2", smp_threads);
-        return;
-    }
-
-    /* Determine the VSMT mode to use: */
-    if (vsmt_user) {
-        if (spapr->vsmt < smp_threads) {
-            error_setg(errp, "Cannot support VSMT mode %d"
-                       " because it must be >= threads/core (%d)",
-                       spapr->vsmt, smp_threads);
-            return;
-        }
-        /* In this case, spapr->vsmt has been set by the command line */
-    } else {
-        spapr->vsmt = smp_threads;
-    }
-
-    /* KVM: If necessary, set the SMT mode: */
-    if (kvm_enabled() && (spapr->vsmt != kvm_smt)) {
-        ret = kvmppc_set_smt_threads(spapr->vsmt);
-        if (ret) {
-            /* Looks like KVM isn't able to change VSMT mode */
-            error_setg_errno(&local_err, -ret,
-                             "Failed to set KVM's VSMT mode to %d",
-                             spapr->vsmt);
-            /* We can live with that if the default one is big enough
-             * for the number of threads, and a submultiple of the one
-             * we want.  In this case we'll waste some vcpu ids, but
-             * behaviour will be correct */
-            if ((kvm_smt >= smp_threads) && ((spapr->vsmt % kvm_smt) == 0)) {
-                warn_report_err(local_err);
-            } else {
-                if (!vsmt_user) {
-                    error_append_hint(&local_err,
-                                      "On PPC, a VM with %d threads/core"
-                                      " on a host with %d threads/core"
-                                      " requires the use of VSMT mode %d.\n",
-                                      smp_threads, kvm_smt, spapr->vsmt);
-                }
-                kvmppc_error_append_smt_possible_hint(&local_err);
-                error_propagate(errp, local_err);
-            }
-        }
-    }
-    /* else TCG: nothing to do currently */
-}
-
-static void spapr_init_cpus(SpaprMachineState *spapr)
-{
-    MachineState *machine = MACHINE(spapr);
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    const char *type = spapr_get_cpu_core_type(machine->cpu_type);
-    const CPUArchIdList *possible_cpus;
-    unsigned int smp_cpus = machine->smp.cpus;
-    unsigned int smp_threads = machine->smp.threads;
-    unsigned int max_cpus = machine->smp.max_cpus;
-    int boot_cores_nr = smp_cpus / smp_threads;
-    int i;
-
-    possible_cpus = mc->possible_cpu_arch_ids(machine);
-    if (mc->has_hotpluggable_cpus) {
-        if (smp_cpus % smp_threads) {
-            error_report("smp_cpus (%u) must be multiple of threads (%u)",
-                         smp_cpus, smp_threads);
-            exit(1);
-        }
-        if (max_cpus % smp_threads) {
-            error_report("max_cpus (%u) must be multiple of threads (%u)",
-                         max_cpus, smp_threads);
-            exit(1);
-        }
-    } else {
-        if (max_cpus != smp_cpus) {
-            error_report("This machine version does not support CPU hotplug");
-            exit(1);
-        }
-        boot_cores_nr = possible_cpus->len;
-    }
-
-    for (i = 0; i < possible_cpus->len; i++) {
-        int core_id = i * smp_threads;
-
-        if (mc->has_hotpluggable_cpus) {
-            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                   spapr_vcpu_id(spapr, core_id));
-        }
-
-        if (i < boot_cores_nr) {
-            Object *core  = object_new(type);
-            int nr_threads = smp_threads;
-
-            /* Handle the partially filled core for older machine types */
-            if ((i + 1) * smp_threads >= smp_cpus) {
-                nr_threads = smp_cpus - i * smp_threads;
-            }
-
-            object_property_set_int(core, "nr-threads", nr_threads,
-                                    &error_fatal);
-            object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
-                                    &error_fatal);
-            qdev_realize(DEVICE(core), NULL, &error_fatal);
-
-            object_unref(core);
-        }
-    }
-}
 
 static PCIHostState *spapr_create_default_phb(void)
 {
@@ -3896,206 +3345,6 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                                               nr_lmbs, spapr_drc_index(drc));
 }
 
-/* Callback to be called during DRC release. */
-void spapr_core_release(DeviceState *dev)
-{
-    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
-
-    /* Call the unplug handler chain. This can never fail. */
-    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
-    object_unparent(OBJECT(dev));
-}
-
-static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
-{
-    MachineState *ms = MACHINE(hotplug_dev);
-    CPUCore *cc = CPU_CORE(dev);
-    CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
-
-    assert(core_slot);
-    core_slot->cpu = NULL;
-    qdev_unrealize(dev);
-}
-
-static
-void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
-                               Error **errp)
-{
-    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    int index;
-    SpaprDrc *drc;
-    CPUCore *cc = CPU_CORE(dev);
-
-    if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index)) {
-        error_setg(errp, "Unable to find CPU core with core-id: %d",
-                   cc->core_id);
-        return;
-    }
-    if (index == 0) {
-        error_setg(errp, "Boot CPU core may not be unplugged");
-        return;
-    }
-
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
-                          spapr_vcpu_id(spapr, cc->core_id));
-    g_assert(drc);
-
-    if (!spapr_drc_unplug_requested(drc)) {
-        spapr_drc_unplug_request(drc);
-    }
-
-    /*
-     * spapr_hotplug_req_remove_by_index is left unguarded, out of the
-     * "!spapr_drc_unplug_requested" check, to allow for multiple IRQ
-     * pulses removing the same CPU. Otherwise, in an failed hotunplug
-     * attempt (e.g. the kernel will refuse to remove the last online
-     * CPU), we will never attempt it again because unplug_requested
-     * will still be 'true' in that case.
-     */
-    spapr_hotplug_req_remove_by_index(drc);
-}
-
-int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
-                           void *fdt, int *fdt_start_offset, Error **errp)
-{
-    SpaprCpuCore *core = SPAPR_CPU_CORE(drc->dev);
-    CPUState *cs = CPU(core->threads[0]);
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    DeviceClass *dc = DEVICE_GET_CLASS(cs);
-    int id = spapr_get_vcpu_id(cpu);
-    g_autofree char *nodename = NULL;
-    int offset;
-
-    nodename = g_strdup_printf("%s@%x", dc->fw_name, id);
-    offset = fdt_add_subnode(fdt, 0, nodename);
-
-    spapr_dt_cpu(cs, fdt, offset, spapr);
-
-    /*
-     * spapr_dt_cpu() does not fill the 'name' property in the
-     * CPU node. The function is called during boot process, before
-     * and after CAS, and overwriting the 'name' property written
-     * by SLOF is not allowed.
-     *
-     * Write it manually after spapr_dt_cpu(). This makes the hotplug
-     * CPUs more compatible with the coldplugged ones, which have
-     * the 'name' property. Linux Kernel also relies on this
-     * property to identify CPU nodes.
-     */
-    _FDT((fdt_setprop_string(fdt, offset, "name", nodename)));
-
-    *fdt_start_offset = offset;
-    return 0;
-}
-
-static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
-{
-    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
-    MachineClass *mc = MACHINE_GET_CLASS(spapr);
-    SpaprCpuCore *core = SPAPR_CPU_CORE(OBJECT(dev));
-    CPUCore *cc = CPU_CORE(dev);
-    SpaprDrc *drc;
-    CPUArchId *core_slot;
-    int index;
-    bool hotplugged = spapr_drc_hotplugged(dev);
-    int i;
-
-    core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
-    g_assert(core_slot); /* Already checked in spapr_core_pre_plug() */
-
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
-                          spapr_vcpu_id(spapr, cc->core_id));
-
-    g_assert(drc || !mc->has_hotpluggable_cpus);
-
-    if (drc) {
-        /*
-         * spapr_core_pre_plug() already buys us this is a brand new
-         * core being plugged into a free slot. Nothing should already
-         * be attached to the corresponding DRC.
-         */
-        spapr_drc_attach(drc, dev);
-
-        if (hotplugged) {
-            /*
-             * Send hotplug notification interrupt to the guest only
-             * in case of hotplugged CPUs.
-             */
-            spapr_hotplug_req_add_by_index(drc);
-        } else {
-            spapr_drc_reset(drc);
-        }
-    }
-
-    core_slot->cpu = CPU(dev);
-
-    /*
-     * Set compatibility mode to match the boot CPU, which was either set
-     * by the machine reset code or by CAS. This really shouldn't fail at
-     * this point.
-     */
-    if (hotplugged) {
-        for (i = 0; i < cc->nr_threads; i++) {
-            ppc_set_compat(core->threads[i], POWERPC_CPU(first_cpu)->compat_pvr,
-                           &error_abort);
-        }
-    }
-
-}
-
-static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
-                                Error **errp)
-{
-    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
-    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
-    CPUCore *cc = CPU_CORE(dev);
-    const char *base_core_type = spapr_get_cpu_core_type(machine->cpu_type);
-    const char *type = object_get_typename(OBJECT(dev));
-    CPUArchId *core_slot;
-    int index;
-    unsigned int smp_threads = machine->smp.threads;
-
-    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
-        error_setg(errp, "CPU hotplug not supported for this machine");
-        return;
-    }
-
-    if (strcmp(base_core_type, type)) {
-        error_setg(errp, "CPU core type should be %s", base_core_type);
-        return;
-    }
-
-    if (cc->core_id % smp_threads) {
-        error_setg(errp, "invalid core id %d", cc->core_id);
-        return;
-    }
-
-    /*
-     * In general we should have homogeneous threads-per-core, but old
-     * (pre hotplug support) machine types allow the last core to have
-     * reduced threads as a compatibility hack for when we allowed
-     * total vcpus not a multiple of threads-per-core.
-     */
-    if (mc->has_hotpluggable_cpus && (cc->nr_threads != smp_threads)) {
-        error_setg(errp, "invalid nr-threads %d, must be %d", cc->nr_threads,
-                   smp_threads);
-        return;
-    }
-
-    core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
-    if (!core_slot) {
-        error_setg(errp, "core id %d out of range", cc->core_id);
-        return;
-    }
-
-    if (core_slot->cpu) {
-        error_setg(errp, "core %d already populated", cc->core_id);
-        return;
-    }
-
-    numa_cpu_pre_plug(core_slot, dev, errp);
-}
-
 int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp)
 {
@@ -4386,63 +3635,6 @@ static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static CpuInstanceProperties
-spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
-{
-    CPUArchId *core_slot;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-    /* make sure possible_cpu are initialized */
-    mc->possible_cpu_arch_ids(machine);
-    /* get CPU core slot containing thread that matches cpu_index */
-    core_slot = spapr_find_cpu_slot(machine, cpu_index, NULL);
-    assert(core_slot);
-    return core_slot->props;
-}
-
-static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
-{
-    return idx / ms->smp.cores % ms->numa_state->num_nodes;
-}
-
-static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
-{
-    int i;
-    unsigned int smp_threads = machine->smp.threads;
-    unsigned int smp_cpus = machine->smp.cpus;
-    const char *core_type;
-    int spapr_max_cores = machine->smp.max_cpus / smp_threads;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-    if (!mc->has_hotpluggable_cpus) {
-        spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
-    }
-    if (machine->possible_cpus) {
-        assert(machine->possible_cpus->len == spapr_max_cores);
-        return machine->possible_cpus;
-    }
-
-    core_type = spapr_get_cpu_core_type(machine->cpu_type);
-    if (!core_type) {
-        error_report("Unable to find sPAPR CPU Core definition");
-        exit(1);
-    }
-
-    machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
-                             sizeof(CPUArchId) * spapr_max_cores);
-    machine->possible_cpus->len = spapr_max_cores;
-    for (i = 0; i < machine->possible_cpus->len; i++) {
-        int core_id = i * smp_threads;
-
-        machine->possible_cpus->cpus[i].type = core_type;
-        machine->possible_cpus->cpus[i].vcpus_count = smp_threads;
-        machine->possible_cpus->cpus[i].arch_id = core_id;
-        machine->possible_cpus->cpus[i].props.has_core_id = true;
-        machine->possible_cpus->cpus[i].props.core_id = core_id;
-    }
-    return machine->possible_cpus;
-}
-
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(dev);
@@ -4504,99 +3696,6 @@ static bool spapr_match_nvt(XiveFabric *xfb, uint8_t format,
     return true;
 }
 
-int spapr_get_vcpu_id(PowerPCCPU *cpu)
-{
-    return cpu->vcpu_id;
-}
-
-bool spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
-{
-    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
-    MachineState *ms = MACHINE(spapr);
-    int vcpu_id;
-
-    vcpu_id = spapr_vcpu_id(spapr, cpu_index);
-
-    if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
-        error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
-        error_append_hint(errp, "Adjust the number of cpus to %d "
-                          "or try to raise the number of threads per core\n",
-                          vcpu_id * ms->smp.threads / spapr->vsmt);
-        return false;
-    }
-
-    cpu->vcpu_id = vcpu_id;
-    return true;
-}
-
-PowerPCCPU *spapr_find_cpu(int vcpu_id)
-{
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-        if (spapr_get_vcpu_id(cpu) == vcpu_id) {
-            return cpu;
-        }
-    }
-
-    return NULL;
-}
-
-static bool spapr_cpu_in_nested(PowerPCCPU *cpu)
-{
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    return spapr_cpu->in_nested;
-}
-
-static void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
-{
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    /* These are only called by TCG, KVM maintains dispatch state */
-
-    spapr_cpu->prod = false;
-    if (spapr_cpu->vpa_addr) {
-        CPUState *cs = CPU(cpu);
-        uint32_t dispatch;
-
-        dispatch = ldl_be_phys(cs->as,
-                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
-        dispatch++;
-        if ((dispatch & 1) != 0) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "VPA: incorrect dispatch counter value for "
-                          "dispatched partition %u, correcting.\n", dispatch);
-            dispatch++;
-        }
-        stl_be_phys(cs->as,
-                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
-    }
-}
-
-static void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
-{
-    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
-
-    if (spapr_cpu->vpa_addr) {
-        CPUState *cs = CPU(cpu);
-        uint32_t dispatch;
-
-        dispatch = ldl_be_phys(cs->as,
-                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
-        dispatch++;
-        if ((dispatch & 1) != 1) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "VPA: incorrect dispatch counter value for "
-                          "preempted partition %u, correcting.\n", dispatch);
-            dispatch++;
-        }
-        stl_be_phys(cs->as,
-                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
-    }
-}
 
 static void spapr_machine_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/hw/ppc/spapr_cpu_hotplug.c b/hw/ppc/spapr_cpu_hotplug.c
new file mode 100644
index 0000000000..d570fca417
--- /dev/null
+++ b/hw/ppc/spapr_cpu_hotplug.c
@@ -0,0 +1,984 @@
+/*
+ * sPAPR CPU hotplug — VCPU-id helpers, device-tree generation, and
+ * HotplugHandler / PPCVirtualHypervisor callbacks for sPAPR CPU cores.
+ *
+ * Code moved from hw/ppc/spapr.c; no functional changes.
+ *
+ * Copyright (c) 2004-2007 Fabrice Bellard
+ * Copyright (c) 2007 Jocelyn Mayer
+ * Copyright (c) 2010-2024 IBM Corporation.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "exec/cpu-common.h"
+#include "system/cpus.h"
+#include "system/kvm.h"
+#include "system/numa.h"
+#include "system/tcg.h"
+#include "hw/core/cpu.h"
+#include "hw/ppc/fdt.h"
+#include "hw/ppc/ppc.h"
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_cpu_core.h"
+#include "hw/ppc/spapr_cpu_hotplug.h"
+#include "hw/ppc/spapr_drc.h"
+#include "hw/ppc/spapr_numa.h"
+#include "kvm_ppc.h"
+#include "mmu-hash64.h"
+#include "target/ppc/cpu.h"
+#include "target/ppc/cpu-qom.h"
+#include "target/ppc/cpu-models.h"
+#include "target/ppc/mmu-hash64.h"
+
+#include <libfdt.h>
+
+/*
+ * VCPU-id / VSMT helpers
+ */
+
+/*
+ * These two functions implement the VCPU id numbering: one to compute them
+ * all and one to identify thread 0 of a VCORE. Any change to the first one
+ * is likely to have an impact on the second one, so let's keep them close.
+ */
+int spapr_vcpu_id(SpaprMachineState *spapr, int cpu_index)
+{
+    MachineState *ms = MACHINE(spapr);
+    unsigned int smp_threads = ms->smp.threads;
+
+    assert(spapr->vsmt);
+    return
+        (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_threads;
+}
+
+bool spapr_is_thread0_in_vcore(SpaprMachineState *spapr, PowerPCCPU *cpu)
+{
+    assert(spapr->vsmt);
+    return spapr_get_vcpu_id(cpu) % spapr->vsmt == 0;
+}
+
+int spapr_max_server_number(SpaprMachineState *spapr)
+{
+    MachineState *ms = MACHINE(spapr);
+
+    assert(spapr->vsmt);
+    return DIV_ROUND_UP(ms->smp.max_cpus * spapr->vsmt, ms->smp.threads);
+}
+
+/*
+ * CPU slot lookup
+ */
+
+/* find cpu slot in machine->possible_cpus by core_id */
+CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
+{
+    int index = id / ms->smp.threads;
+
+    if (index >= ms->possible_cpus->len) {
+        return NULL;
+    }
+    if (idx) {
+        *idx = index;
+    }
+    return &ms->possible_cpus->cpus[index];
+}
+
+/*
+ * Machine-initialisation helpers
+ */
+
+void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
+{
+    MachineState *ms = MACHINE(spapr);
+    Error *local_err = NULL;
+    bool vsmt_user = !!spapr->vsmt;
+    int kvm_smt = kvmppc_smt_threads();
+    int ret;
+    unsigned int smp_threads = ms->smp.threads;
+
+    if (tcg_enabled()) {
+        if (smp_threads > 1 &&
+            !ppc_type_check_compat(ms->cpu_type, CPU_POWERPC_LOGICAL_2_07, 0,
+                                   spapr->max_compat_pvr)) {
+            error_setg(errp, "TCG only supports SMT on POWER8 or newer CPUs");
+            return;
+        }
+
+        if (smp_threads > 8) {
+            error_setg(errp, "TCG cannot support more than 8 threads/core "
+                       "on a pseries machine");
+            return;
+        }
+    }
+    if (!is_power_of_2(smp_threads)) {
+        error_setg(errp, "Cannot support %d threads/core on a pseries "
+                   "machine because it must be a power of 2", smp_threads);
+        return;
+    }
+
+    /* Determine the VSMT mode to use: */
+    if (vsmt_user) {
+        if (spapr->vsmt < smp_threads) {
+            error_setg(errp, "Cannot support VSMT mode %d"
+                       " because it must be >= threads/core (%d)",
+                       spapr->vsmt, smp_threads);
+            return;
+        }
+        /* In this case, spapr->vsmt has been set by the command line */
+    } else {
+        spapr->vsmt = smp_threads;
+    }
+
+    /* KVM: If necessary, set the SMT mode: */
+    if (kvm_enabled() && (spapr->vsmt != kvm_smt)) {
+        ret = kvmppc_set_smt_threads(spapr->vsmt);
+        if (ret) {
+            /* Looks like KVM isn't able to change VSMT mode */
+            error_setg_errno(&local_err, -ret,
+                             "Failed to set KVM's VSMT mode to %d",
+                             spapr->vsmt);
+            /*
+             * We can live with that if the default one is big enough
+             * for the number of threads, and a submultiple of the one
+             * we want.  In this case we'll waste some vcpu ids, but
+             * behaviour will be correct
+             */
+            if ((kvm_smt >= smp_threads) && ((spapr->vsmt % kvm_smt) == 0)) {
+                warn_report_err(local_err);
+            } else {
+                if (!vsmt_user) {
+                    error_append_hint(&local_err,
+                                      "On PPC, a VM with %d threads/core"
+                                      " on a host with %d threads/core"
+                                      " requires the use of VSMT mode %d.\n",
+                                      smp_threads, kvm_smt, spapr->vsmt);
+                }
+                kvmppc_error_append_smt_possible_hint(&local_err);
+                error_propagate(errp, local_err);
+            }
+        }
+    }
+    /* else TCG: nothing to do currently */
+}
+
+void spapr_init_cpus(SpaprMachineState *spapr)
+{
+    MachineState *machine = MACHINE(spapr);
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const char *type = spapr_get_cpu_core_type(machine->cpu_type);
+    const CPUArchIdList *possible_cpus;
+    unsigned int smp_cpus = machine->smp.cpus;
+    unsigned int smp_threads = machine->smp.threads;
+    unsigned int max_cpus = machine->smp.max_cpus;
+    int boot_cores_nr = smp_cpus / smp_threads;
+    int i;
+
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    if (mc->has_hotpluggable_cpus) {
+        if (smp_cpus % smp_threads) {
+            error_report("smp_cpus (%u) must be multiple of threads (%u)",
+                         smp_cpus, smp_threads);
+            exit(1);
+        }
+        if (max_cpus % smp_threads) {
+            error_report("max_cpus (%u) must be multiple of threads (%u)",
+                         max_cpus, smp_threads);
+            exit(1);
+        }
+    } else {
+        if (max_cpus != smp_cpus) {
+            error_report("This machine version does not support CPU hotplug");
+            exit(1);
+        }
+        boot_cores_nr = possible_cpus->len;
+    }
+
+    for (i = 0; i < possible_cpus->len; i++) {
+        int core_id = i * smp_threads;
+
+        if (mc->has_hotpluggable_cpus) {
+            spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
+                                   spapr_vcpu_id(spapr, core_id));
+        }
+
+        if (i < boot_cores_nr) {
+            Object *core  = object_new(type);
+            int nr_threads = smp_threads;
+
+            /* Handle the partially filled core for older machine types */
+            if ((i + 1) * smp_threads >= smp_cpus) {
+                nr_threads = smp_cpus - i * smp_threads;
+            }
+
+            object_property_set_int(core, "nr-threads", nr_threads,
+                                    &error_fatal);
+            object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
+                                    &error_fatal);
+            qdev_realize(DEVICE(core), NULL, &error_fatal);
+
+            object_unref(core);
+        }
+    }
+}
+
+/*
+ * Device-tree helpers
+ */
+
+static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
+                                  int smt_threads)
+{
+    int i, ret = 0;
+    g_autofree uint32_t *servers_prop = g_new(uint32_t, smt_threads);
+    g_autofree uint32_t *gservers_prop = g_new(uint32_t, smt_threads * 2);
+    int index = spapr_get_vcpu_id(cpu);
+
+    if (cpu->compat_pvr) {
+        ret = fdt_setprop_cell(fdt, offset, "cpu-version", cpu->compat_pvr);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    /* Build interrupt servers and gservers properties */
+    for (i = 0; i < smt_threads; i++) {
+        servers_prop[i] = cpu_to_be32(index + i);
+        /* Hack, direct the group queues back to cpu 0 */
+        gservers_prop[i * 2] = cpu_to_be32(index + i);
+        gservers_prop[i * 2 + 1] = 0;
+    }
+    ret = fdt_setprop(fdt, offset, "ibm,ppc-interrupt-server#s",
+                      servers_prop, sizeof(*servers_prop) * smt_threads);
+    if (ret < 0) {
+        return ret;
+    }
+    ret = fdt_setprop(fdt, offset, "ibm,ppc-interrupt-gserver#s",
+                      gservers_prop, sizeof(*gservers_prop) * smt_threads * 2);
+
+    return ret;
+}
+
+static void spapr_dt_pa_features(SpaprMachineState *spapr,
+                                 PowerPCCPU *cpu,
+                                 void *fdt, int offset)
+{
+    /*
+     * SSO (SAO) ordering is supported on KVM and thread=single hosts,
+     * but not MTTCG, so disable it. To advertise it, a cap would have
+     * to be added, or support implemented for MTTCG.
+     *
+     * Copy/paste is not supported by TCG, so it is not advertised. KVM
+     * can execute them but it has no accelerator drivers which are usable,
+     * so there isn't much need for it anyway.
+     */
+
+    /* These should be kept in sync with pnv */
+    uint8_t pa_features_206[] = { 6, 0,
+        0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
+    uint8_t pa_features_207[] = { 24, 0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0,
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
+    uint8_t pa_features_300[] = { 66, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 40: Radix MMU */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+    };
+    /* 3.1 removes SAO, HTM support */
+    uint8_t pa_features_31[] = { 74, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 40: Radix MMU */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG, 64: DAWR1 (ISA 3.1) */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
+        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
+        /* 72: [P]HASHST/[P]HASHCHK */
+        0x80, 0x00,                         /* 72 - 73 */
+    };
+    uint8_t *pa_features = NULL;
+    size_t pa_size;
+
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_206;
+        pa_size = sizeof(pa_features_206);
+    }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_207;
+        pa_size = sizeof(pa_features_207);
+    }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_300;
+        pa_size = sizeof(pa_features_300);
+    }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_31;
+        pa_size = sizeof(pa_features_31);
+    }
+    if (!pa_features) {
+        return;
+    }
+
+    if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
+        /*
+         * Note: we keep CI large pages off by default because a 64K capable
+         * guest provisioned with large pages might otherwise try to map a qemu
+         * framebuffer (or other kind of memory mapped PCI BAR) using 64K pages
+         * even if that qemu runs on a 4k host.
+         * We dd this bit back here if we are confident this is not an issue
+         */
+        pa_features[3] |= 0x20;
+    }
+    if ((spapr_get_cap(spapr, SPAPR_CAP_HTM) != 0) && pa_size > 24) {
+        pa_features[24] |= 0x80;    /* Transactional memory support */
+    }
+    if (spapr->cas_pre_isa3_guest && pa_size > 40) {
+        /*
+         * Workaround for broken kernels that attempt (guest) radix
+         * mode when they can't handle it, if they see the radix bit set
+         * in pa-features. So hide it from them.
+         */
+        pa_features[40 + 2] &= ~0x80; /* Radix MMU */
+    }
+    if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
+        g_assert(pa_size > 66);
+        pa_features[66] |= 0x80;
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_size)));
+}
+
+static void spapr_dt_pi_features(SpaprMachineState *spapr,
+                                 PowerPCCPU *cpu,
+                                 void *fdt, int offset)
+{
+    uint8_t pi_features[] = { 1, 0,
+        0x00 };
+
+    if (kvm_enabled() && ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00,
+                                          0, cpu->compat_pvr)) {
+        /*
+         * POWER9 and later CPUs with KVM run in LPAR-per-thread mode where
+         * all threads are essentially independent CPUs, and msgsndp does not
+         * work (because it is physically-addressed) and therefore is
+         * emulated by KVM, so disable it here to ensure XIVE will be used.
+         * This is both KVM and CPU implementation-specific behaviour so a KVM
+         * cap would be cleanest, but for now this works. If KVM ever permits
+         * native msgsndp execution by guests, a cap could be added at that
+         * time.
+         */
+        pi_features[2] |= 0x08; /* 4: No msgsndp */
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pi-features", pi_features,
+                      sizeof(pi_features))));
+}
+
+void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
+                  SpaprMachineState *spapr)
+{
+    MachineState *ms = MACHINE(spapr);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
+    int index = spapr_get_vcpu_id(cpu);
+    uint32_t segs[] = {cpu_to_be32(28), cpu_to_be32(40),
+                       0xffffffff, 0xffffffff};
+    uint32_t tbfreq = kvm_enabled() ? kvmppc_get_tbfreq()
+        : SPAPR_TIMEBASE_FREQ;
+    uint32_t cpufreq = kvm_enabled() ? kvmppc_get_clockfreq() : 1000000000;
+    uint32_t page_sizes_prop[64];
+    size_t page_sizes_prop_size;
+    unsigned int smp_threads = ms->smp.threads;
+    uint32_t vcpus_per_socket = smp_threads * ms->smp.cores;
+    uint32_t pft_size_prop[] = {0, cpu_to_be32(spapr->htab_shift)};
+    int compat_smt = MIN(smp_threads, ppc_compat_max_vthreads(cpu));
+    SpaprDrc *drc;
+    int drc_index;
+    uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
+    int i;
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, env->core_index);
+    if (drc) {
+        drc_index = spapr_drc_index(drc);
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
+    }
+
+    _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
+    _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
+
+    _FDT((fdt_setprop_cell(fdt, offset, "cpu-version", env->spr[SPR_PVR])));
+    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-block-size",
+                           env->dcache_line_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "d-cache-line-size",
+                           env->dcache_line_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-block-size",
+                           env->icache_line_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "i-cache-line-size",
+                           env->icache_line_size)));
+
+    if (pcc->l1_dcache_size) {
+        _FDT((fdt_setprop_cell(fdt, offset, "d-cache-size",
+                               pcc->l1_dcache_size)));
+    } else {
+        warn_report("Unknown L1 dcache size for cpu");
+    }
+    if (pcc->l1_icache_size) {
+        _FDT((fdt_setprop_cell(fdt, offset, "i-cache-size",
+                               pcc->l1_icache_size)));
+    } else {
+        warn_report("Unknown L1 icache size for cpu");
+    }
+
+    _FDT((fdt_setprop_cell(fdt, offset, "timebase-frequency", tbfreq)));
+    _FDT((fdt_setprop_cell(fdt, offset, "clock-frequency", cpufreq)));
+    _FDT((fdt_setprop_cell(fdt, offset, "slb-size",
+                           cpu->hash64_opts->slb_size)));
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,slb-size",
+                           cpu->hash64_opts->slb_size)));
+    _FDT((fdt_setprop_string(fdt, offset, "status", "okay")));
+    _FDT((fdt_setprop(fdt, offset, "64-bit", NULL, 0)));
+
+    if (ppc_has_spr(cpu, SPR_PURR)) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,purr", 1)));
+    }
+    if (ppc_has_spr(cpu, SPR_PURR)) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,spurr", 1)));
+    }
+
+    if (ppc_hash64_has(cpu, PPC_HASH64_1TSEG)) {
+        _FDT((fdt_setprop(fdt, offset, "ibm,processor-segment-sizes",
+                          segs, sizeof(segs))));
+    }
+
+    /*
+     * Advertise VSX (vector extensions) if available
+     *   1               == VMX / Altivec available
+     *   2               == VSX available
+     *
+     * Only CPUs for which we create core types in spapr_cpu_core.c
+     * are possible, and all of those have VMX
+     */
+    if (env->insns_flags & PPC_ALTIVEC) {
+        if (spapr_get_cap(spapr, SPAPR_CAP_VSX) != 0) {
+            _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
+        } else {
+            _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
+        }
+    }
+
+    /*
+     * Advertise DFP (Decimal Floating Point) if available
+     *   0 / no property == no DFP
+     *   1               == DFP available
+     */
+    if (spapr_get_cap(spapr, SPAPR_CAP_DFP) != 0) {
+        _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
+    }
+
+    page_sizes_prop_size = ppc_create_page_sizes_prop(cpu, page_sizes_prop,
+                                                      sizeof(page_sizes_prop));
+    if (page_sizes_prop_size) {
+        _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
+                          page_sizes_prop, page_sizes_prop_size)));
+    }
+
+    spapr_dt_pa_features(spapr, cpu, fdt, offset);
+
+    spapr_dt_pi_features(spapr, cpu, fdt, offset);
+
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
+                           cs->cpu_index / vcpus_per_socket)));
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
+                      pft_size_prop, sizeof(pft_size_prop))));
+
+    if (ms->numa_state->num_nodes > 1) {
+        _FDT(spapr_numa_fixup_cpu_dt(spapr, fdt, offset, cpu));
+    }
+
+    _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
+
+    if (pcc->radix_page_info) {
+        for (i = 0; i < pcc->radix_page_info->count; i++) {
+            radix_AP_encodings[i] =
+                cpu_to_be32(pcc->radix_page_info->entries[i]);
+        }
+        _FDT((fdt_setprop(fdt, offset, "ibm,processor-radix-AP-encodings",
+                          radix_AP_encodings,
+                          pcc->radix_page_info->count *
+                          sizeof(radix_AP_encodings[0]))));
+    }
+
+    /*
+     * We set this property to let the guest know that it can use the large
+     * decrementer and its width in bits.
+     */
+    if (spapr_get_cap(spapr, SPAPR_CAP_LARGE_DECREMENTER) != SPAPR_CAP_OFF)
+        _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
+                              pcc->lrg_decr_bits)));
+}
+
+static void spapr_dt_one_cpu(void *fdt, SpaprMachineState *spapr, CPUState *cs,
+                             int cpus_offset)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    int index = spapr_get_vcpu_id(cpu);
+    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    g_autofree char *nodename = NULL;
+    int offset;
+
+    if (!spapr_is_thread0_in_vcore(spapr, cpu)) {
+        return;
+    }
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, index);
+    offset = fdt_add_subnode(fdt, cpus_offset, nodename);
+    _FDT(offset);
+    spapr_dt_cpu(cs, fdt, offset, spapr);
+}
+
+void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr)
+{
+    CPUState **rev;
+    CPUState *cs;
+    int n_cpus;
+    int cpus_offset;
+    int i;
+
+    cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
+    _FDT(cpus_offset);
+    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
+    _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
+
+    /*
+     * We walk the CPUs in reverse order to ensure that CPU DT nodes
+     * created by fdt_add_subnode() end up in the right order in FDT
+     * for the guest kernel the enumerate the CPUs correctly.
+     *
+     * The CPU list cannot be traversed in reverse order, so we need
+     * to do extra work.
+     */
+    n_cpus = 0;
+    rev = NULL;
+    CPU_FOREACH(cs) {
+        rev = g_renew(CPUState *, rev, n_cpus + 1);
+        rev[n_cpus++] = cs;
+    }
+
+    for (i = n_cpus - 1; i >= 0; i--) {
+        spapr_dt_one_cpu(fdt, spapr, rev[i], cpus_offset);
+    }
+
+    g_free(rev);
+}
+
+/*
+ * HotplugHandler callbacks
+ */
+
+/* Callback to be called during DRC release. */
+void spapr_core_release(DeviceState *dev)
+{
+    HotplugHandler *hotplug_ctrl = qdev_get_hotplug_handler(dev);
+
+    /* Call the unplug handler chain. This can never fail. */
+    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
+    object_unparent(OBJECT(dev));
+}
+
+void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
+{
+    MachineState *ms = MACHINE(hotplug_dev);
+    CPUCore *cc = CPU_CORE(dev);
+    CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
+
+    assert(core_slot);
+    core_slot->cpu = NULL;
+    qdev_unrealize(dev);
+}
+
+void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    int index;
+    SpaprDrc *drc;
+    CPUCore *cc = CPU_CORE(dev);
+
+    if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index)) {
+        error_setg(errp, "Unable to find CPU core with core-id: %d",
+                   cc->core_id);
+        return;
+    }
+    if (index == 0) {
+        error_setg(errp, "Boot CPU core may not be unplugged");
+        return;
+    }
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
+                          spapr_vcpu_id(spapr, cc->core_id));
+    g_assert(drc);
+
+    if (!spapr_drc_unplug_requested(drc)) {
+        spapr_drc_unplug_request(drc);
+    }
+
+    /*
+     * spapr_hotplug_req_remove_by_index is left unguarded, out of the
+     * "!spapr_drc_unplug_requested" check, to allow for multiple IRQ
+     * pulses removing the same CPU. Otherwise, in an failed hotunplug
+     * attempt (e.g. the kernel will refuse to remove the last online
+     * CPU), we will never attempt it again because unplug_requested
+     * will still be 'true' in that case.
+     */
+    spapr_hotplug_req_remove_by_index(drc);
+}
+
+int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
+                           void *fdt, int *fdt_start_offset, Error **errp)
+{
+    SpaprCpuCore *core = SPAPR_CPU_CORE(drc->dev);
+    CPUState *cs = CPU(core->threads[0]);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    DeviceClass *dc = DEVICE_GET_CLASS(cs);
+    int id = spapr_get_vcpu_id(cpu);
+    g_autofree char *nodename = NULL;
+    int offset;
+
+    nodename = g_strdup_printf("%s@%x", dc->fw_name, id);
+    offset = fdt_add_subnode(fdt, 0, nodename);
+
+    spapr_dt_cpu(cs, fdt, offset, spapr);
+
+    /*
+     * spapr_dt_cpu() does not fill the 'name' property in the
+     * CPU node. The function is called during boot process, before
+     * and after CAS, and overwriting the 'name' property written
+     * by SLOF is not allowed.
+     *
+     * Write it manually after spapr_dt_cpu(). This makes the hotplug
+     * CPUs more compatible with the coldplugged ones, which have
+     * the 'name' property. Linux Kernel also relies on this
+     * property to identify CPU nodes.
+     */
+    _FDT((fdt_setprop_string(fdt, offset, "name", nodename)));
+
+    *fdt_start_offset = offset;
+    return 0;
+}
+
+void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(spapr);
+    SpaprCpuCore *core = SPAPR_CPU_CORE(OBJECT(dev));
+    CPUCore *cc = CPU_CORE(dev);
+    SpaprDrc *drc;
+    CPUArchId *core_slot;
+    int index;
+    bool hotplugged = spapr_drc_hotplugged(dev);
+    int i;
+
+    core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
+    g_assert(core_slot); /* Already checked in spapr_core_pre_plug() */
+
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU,
+                          spapr_vcpu_id(spapr, cc->core_id));
+
+    g_assert(drc || !mc->has_hotpluggable_cpus);
+
+    if (drc) {
+        /*
+         * spapr_core_pre_plug() already buys us this is a brand new
+         * core being plugged into a free slot. Nothing should already
+         * be attached to the corresponding DRC.
+         */
+        spapr_drc_attach(drc, dev);
+
+        if (hotplugged) {
+            /*
+             * Send hotplug notification interrupt to the guest only
+             * in case of hotplugged CPUs.
+             */
+            spapr_hotplug_req_add_by_index(drc);
+        } else {
+            spapr_drc_reset(drc);
+        }
+    }
+
+    core_slot->cpu = CPU(dev);
+
+    /*
+     * Set compatibility mode to match the boot CPU, which was either set
+     * by the machine reset code or by CAS. This really shouldn't fail at
+     * this point.
+     */
+    if (hotplugged) {
+        for (i = 0; i < cc->nr_threads; i++) {
+            ppc_set_compat(core->threads[i], POWERPC_CPU(first_cpu)->compat_pvr,
+                           &error_abort);
+        }
+    }
+
+}
+
+void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                         Error **errp)
+{
+    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    CPUCore *cc = CPU_CORE(dev);
+    const char *base_core_type = spapr_get_cpu_core_type(machine->cpu_type);
+    const char *type = object_get_typename(OBJECT(dev));
+    CPUArchId *core_slot;
+    int index;
+    unsigned int smp_threads = machine->smp.threads;
+
+    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
+        error_setg(errp, "CPU hotplug not supported for this machine");
+        return;
+    }
+
+    if (strcmp(base_core_type, type)) {
+        error_setg(errp, "CPU core type should be %s", base_core_type);
+        return;
+    }
+
+    if (cc->core_id % smp_threads) {
+        error_setg(errp, "invalid core id %d", cc->core_id);
+        return;
+    }
+
+    /*
+     * In general we should have homogeneous threads-per-core, but old
+     * (pre hotplug support) machine types allow the last core to have
+     * reduced threads as a compatibility hack for when we allowed
+     * total vcpus not a multiple of threads-per-core.
+     */
+    if (mc->has_hotpluggable_cpus && (cc->nr_threads != smp_threads)) {
+        error_setg(errp, "invalid nr-threads %d, must be %d", cc->nr_threads,
+                   smp_threads);
+        return;
+    }
+
+    core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
+    if (!core_slot) {
+        error_setg(errp, "core id %d out of range", cc->core_id);
+        return;
+    }
+
+    if (core_slot->cpu) {
+        error_setg(errp, "core %d already populated", cc->core_id);
+        return;
+    }
+
+    numa_cpu_pre_plug(core_slot, dev, errp);
+}
+
+/*
+ * VCPU-id public accessors  (consumed by spapr_hcall.c, spapr_rtas.c, …)
+ */
+
+int spapr_get_vcpu_id(PowerPCCPU *cpu)
+{
+    return cpu->vcpu_id;
+}
+
+bool spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    MachineState *ms = MACHINE(spapr);
+    int vcpu_id;
+
+    vcpu_id = spapr_vcpu_id(spapr, cpu_index);
+
+    if (kvm_enabled() && !kvm_vcpu_id_is_valid(vcpu_id)) {
+        error_setg(errp, "Can't create CPU with id %d in KVM", vcpu_id);
+        error_append_hint(errp, "Adjust the number of cpus to %d "
+                          "or try to raise the number of threads per core\n",
+                          vcpu_id * ms->smp.threads / spapr->vsmt);
+        return false;
+    }
+
+    cpu->vcpu_id = vcpu_id;
+    return true;
+}
+
+PowerPCCPU *spapr_find_cpu(int vcpu_id)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+        if (spapr_get_vcpu_id(cpu) == vcpu_id) {
+            return cpu;
+        }
+    }
+
+    return NULL;
+}
+
+/*
+ * Machine-class CPU-topology callbacks
+ */
+
+CpuInstanceProperties
+spapr_cpu_index_to_props(MachineState *machine, unsigned cpu_index)
+{
+    CPUArchId *core_slot;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    /* make sure possible_cpu are initialized */
+    mc->possible_cpu_arch_ids(machine);
+    /* get CPU core slot containing thread that matches cpu_index */
+    core_slot = spapr_find_cpu_slot(machine, cpu_index, NULL);
+    assert(core_slot);
+    return core_slot->props;
+}
+
+int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    return idx / ms->smp.cores % ms->numa_state->num_nodes;
+}
+
+const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
+{
+    int i;
+    unsigned int smp_threads = machine->smp.threads;
+    unsigned int smp_cpus = machine->smp.cpus;
+    const char *core_type;
+    int spapr_max_cores = machine->smp.max_cpus / smp_threads;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+
+    if (!mc->has_hotpluggable_cpus) {
+        spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
+    }
+    if (machine->possible_cpus) {
+        assert(machine->possible_cpus->len == spapr_max_cores);
+        return machine->possible_cpus;
+    }
+
+    core_type = spapr_get_cpu_core_type(machine->cpu_type);
+    if (!core_type) {
+        error_report("Unable to find sPAPR CPU Core definition");
+        exit(1);
+    }
+
+    machine->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                             sizeof(CPUArchId) * spapr_max_cores);
+    machine->possible_cpus->len = spapr_max_cores;
+    for (i = 0; i < machine->possible_cpus->len; i++) {
+        int core_id = i * smp_threads;
+
+        machine->possible_cpus->cpus[i].type = core_type;
+        machine->possible_cpus->cpus[i].vcpus_count = smp_threads;
+        machine->possible_cpus->cpus[i].arch_id = core_id;
+        machine->possible_cpus->cpus[i].props.has_core_id = true;
+        machine->possible_cpus->cpus[i].props.core_id = core_id;
+    }
+    return machine->possible_cpus;
+}
+
+/*
+ * PPCVirtualHypervisor callbacks
+ */
+
+bool spapr_cpu_in_nested(PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    return spapr_cpu->in_nested;
+}
+
+void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    /* These are only called by TCG, KVM maintains dispatch state */
+
+    spapr_cpu->prod = false;
+    if (spapr_cpu->vpa_addr) {
+        CPUState *cs = CPU(cpu);
+        uint32_t dispatch;
+
+        dispatch = ldl_be_phys(cs->as,
+                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+        dispatch++;
+        if ((dispatch & 1) != 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "VPA: incorrect dispatch counter value for "
+                          "dispatched partition %u, correcting.\n", dispatch);
+            dispatch++;
+        }
+        stl_be_phys(cs->as,
+                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
+    }
+}
+
+void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+{
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    if (spapr_cpu->vpa_addr) {
+        CPUState *cs = CPU(cpu);
+        uint32_t dispatch;
+
+        dispatch = ldl_be_phys(cs->as,
+                               spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER);
+        dispatch++;
+        if ((dispatch & 1) != 1) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "VPA: incorrect dispatch counter value for "
+                          "preempted partition %u, correcting.\n", dispatch);
+            dispatch++;
+        }
+        stl_be_phys(cs->as,
+                    spapr_cpu->vpa_addr + VPA_DISPATCH_COUNTER, dispatch);
+    }
+}
+
diff --git a/include/hw/ppc/spapr_cpu_hotplug.h b/include/hw/ppc/spapr_cpu_hotplug.h
new file mode 100644
index 0000000000..f3b74396b5
--- /dev/null
+++ b/include/hw/ppc/spapr_cpu_hotplug.h
@@ -0,0 +1,74 @@
+/*
+ * sPAPR CPU hotplug helpers.
+ *
+ * Declarations for functions that manage CPU device-tree generation,
+ * VSMT/VCPU-id mapping, CPU-slot lookup, machine initialisation, and
+ * the HotplugHandler / PPCVirtualHypervisor callbacks for sPAPR CPU cores.
+ *
+ * Copyright (c) 2010-2024 IBM Corporation.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_SPAPR_CPU_HOTPLUG_H
+#define HW_SPAPR_CPU_HOTPLUG_H
+
+#include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_drc.h"
+#include "target/ppc/cpu-qom.h"
+#include "hw/core/hotplug.h"
+
+/* ---- VCPU-id / VSMT helpers ------------------------------------------ */
+
+/*
+ * These two functions implement the VCPU-id numbering: one to compute
+ * them all, one to identify thread 0 of a vcore.  Any change to the
+ * first is likely to affect the second, so they live together.
+ */
+int  spapr_vcpu_id(SpaprMachineState *spapr, int cpu_index);
+bool spapr_is_thread0_in_vcore(SpaprMachineState *spapr, PowerPCCPU *cpu);
+
+/* ---- CPU-slot lookup ------------------------------------------------- */
+
+/* Find the CPUArchId slot in machine->possible_cpus by core_id. */
+CPUArchId *spapr_find_cpu_slot(MachineState *ms, uint32_t id, int *idx);
+
+/* ---- Machine-initialisation helpers ---------------------------------- */
+
+void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp);
+void spapr_init_cpus(SpaprMachineState *spapr);
+
+/* ---- Device-tree helpers --------------------------------------------- */
+
+/*
+ * spapr_dt_cpu() fills the FDT node at @offset for vCPU @cs, including
+ * ibm,my-drc-index, pa-features, interrupt-server#s, etc.  It is called
+ * both during boot-time FDT construction and from spapr_core_dt_populate()
+ * during CPU hotplug.
+ */
+void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
+                  SpaprMachineState *spapr);
+void spapr_dt_cpus(void *fdt, SpaprMachineState *spapr);
+
+/* ---- HotplugHandler callbacks ---------------------------------------- */
+
+void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                         Error **errp);
+void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev);
+void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev);
+void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp);
+
+/* ---- Machine-class CPU-topology callbacks ----------------------------- */
+
+CpuInstanceProperties spapr_cpu_index_to_props(MachineState *machine,
+                                               unsigned cpu_index);
+int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int idx);
+const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine);
+
+/* ---- PPCVirtualHypervisor callbacks ---------------------------------- */
+
+bool spapr_cpu_in_nested(PowerPCCPU *cpu);
+void spapr_cpu_exec_enter(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+void spapr_cpu_exec_exit(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
+
+#endif /* HW_SPAPR_CPU_HOTPLUG_H */
-- 
2.54.0


