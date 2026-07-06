Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAC5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgee2-0004On-Rz; Mon, 06 Jul 2026 04:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedf-0004IN-VD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedd-0007nU-QD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MIAch2303805; Mon, 6 Jul 2026 08:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZrWZF6
 7EJZz5UCvw2a0cf2k3To3fDxxI0YU8eFddmRU=; b=keD53DsF5Dfrs7/3RM5wKH
 jo/MHHXc66PbQPRCKl5u3pf3WnnTy25DrNao5YeBOVMSFTcffTk944UL5ffi+UM4
 ZmQdEdsWvxhLhr7eAunxjZ+iT/q0gH0Id7x0kdz+MCCDB0nrCz+8mTchMdfI0V9L
 dn+FbAaG1tIdOlWJzMjcN3wSVFyFnsRQSkjEj3zgTeMs8BlnHc7y/2oEKuhUKi3L
 z6C3CEuI/IbTb/kIUgEqtW9qST9dzYZbRyxc5pOSbnFglE9CV3owHWn7wmTS6yiG
 Qjr/gB6VXkl4Z3zfRe6CpK4Fcjy6wG4OLmY6/xvnGp/Yw1CwDhsrw4kZm+eFOLeA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3gfr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668Jc7E011038;
 Mon, 6 Jul 2026 08:25:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpvxje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 08:25:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668P7VQ13566460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:25:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC3192004B;
 Mon,  6 Jul 2026 08:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF66520040;
 Mon,  6 Jul 2026 08:25:06 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:25:06 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>
Subject: [PULL 7/8] ppc/pnv: Remove Power8E and Power8NVL CPUs
Date: Mon,  6 Jul 2026 13:54:50 +0530
Message-ID: <20260706082451.59299-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4b6668 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=D9DhIS6rGg1hnALM87YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX0jQC8sUY3Ndu
 cPm/fRY3jGaN2ZBthw7OoI+B7ct/RbRyODuWzst7LP2FHFwsvUUYG0VoUOek52mPVvLsGYodsme
 TtmGLo6DG2t8CxDLcBGqn+LnioAI/ds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXxZviVRbE/SyC
 eG3+qy6SLrvHjnSzkTKhdVYhFAIZHUB3kKfdNuu96GrbBDE3TnjZKFfKkrxdpdM5rkjfLCnq/NO
 /4jMA+0gx4PHuaZMq7v/xsj0AR4bPC15hAdnD/uDUaEriVQ9ioP4Sn7R7oOmsQNcTjGJlv3dcSc
 K0cgfMkOuhHOwLdkJTEMuWYhwYYtJeuKg6Z8C5MayE35Rywwue/Qz9e+RGcQjtd80v/75/WGoxs
 +6q0kABW/bjqJtf3okissunVg84+nE9oIc9me28r6XDoR+rzppBfxT0s42qjWk7lgIi/Rq8kdnd
 cmpoOcuniAsr2jlWiVMaiKDS6cDBJ6IFzyT7DBht817hADGq2ss9pHz0fBbN78jF8OZmPrAPh5A
 utd8VIcajZ1DSWq2YDrPOENG8k1R2j8zVAovuN0mFKxWl9TPlVLavw9NVuC41vq5xw3oYLVxN4t
 QekChUDD+m48L6vQCaA==
X-Proofpoint-ORIG-GUID: QzbwiaSxIXOLaJcATPxsZjLXXs8sGO6z
X-Proofpoint-GUID: QzbwiaSxIXOLaJcATPxsZjLXXs8sGO6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

Remove the corresponding 8E and 8NVL CPU cores from spapr/pseries

Also, with no use of 8E and 8NVL, in powernv chips or spapr cores,
remove the CPU definitions for the cores

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-8-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 docs/about/deprecated.rst       | 9 ---------
 docs/about/removed-features.rst | 8 ++++++++
 docs/system/ppc/pseries.rst     | 2 +-
 target/ppc/cpu-models.h         | 4 ----
 hw/ppc/spapr_cpu_core.c         | 2 --
 target/ppc/cpu-models.c         | 6 ------
 target/ppc/cpu_init.c           | 6 ------
 target/ppc/kvm.c                | 4 +---
 8 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 169c5dfe4f..ef1d7b9ea8 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -206,15 +206,6 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
-Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The Power8E and Power8NVL variants of Power8 are not really useful anymore
-in qemu, and are old and unmaintained now.
-
-The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
-be considered deprecated.
-
 System emulator machines
 ------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index d1bea4d75b..f7a2aa326d 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1038,6 +1038,14 @@ initial RISC-V QEMU port. Its usage was always been unclear: users don't know
 what to expect from a CPU called 'any', and in fact the CPU does not do anything
 special that isn't already done by the default CPUs rv32/rv64.
 
+Power8E and Power8NVL CPUs (removed in 11.1)
+''''''''''''''''''''''''''''''''''''''''''''
+
+The Power8E and Power8NVL variants of Power8 are not really useful anymore
+in qemu, and are old and unmaintained.
+Hence, the CPUs as well as corresponding Power8NVL and Power8E PnvChips have
+been removed
+
 System accelerators
 -------------------
 
diff --git a/docs/system/ppc/pseries.rst b/docs/system/ppc/pseries.rst
index 107091a37f..8bd8eae617 100644
--- a/docs/system/ppc/pseries.rst
+++ b/docs/system/ppc/pseries.rst
@@ -16,7 +16,7 @@ Supported devices
 
  * Multi processor support for many Power processors generations:
    - POWER7, POWER7+
-   - POWER8, POWER8NVL
+   - POWER8
    - POWER9
    - Power10
    - Power11
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index a439eb37ee..ef019cdb1f 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -341,12 +341,8 @@ enum {
     CPU_POWERPC_POWER7_v23         = 0x003F0203,
     CPU_POWERPC_POWER7P_BASE       = 0x004A0000,
     CPU_POWERPC_POWER7P_v21        = 0x004A0201,
-    CPU_POWERPC_POWER8E_BASE       = 0x004B0000,
-    CPU_POWERPC_POWER8E_v21        = 0x004B0201,
     CPU_POWERPC_POWER8_BASE        = 0x004D0000,
     CPU_POWERPC_POWER8_v20         = 0x004D0200,
-    CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
-    CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
     CPU_POWERPC_POWER9_DD1         = 0x004E1100,
     CPU_POWERPC_POWER9_DD20        = 0x004E1200,
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 41e37103c0..9a9351991c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -408,8 +408,6 @@ static const TypeInfo spapr_cpu_core_type_infos[] = {
     DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power7p_v2.1"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power8_v2.0"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power8e_v2.1"),
-    DEFINE_SPAPR_CPU_CORE_TYPE("power8nvl_v1.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.0"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power9_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("power10_v2.0"),
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 26b6debcfc..aa13654e83 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -734,12 +734,8 @@
                 "POWER7 v2.3")
     POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
                 "POWER7+ v2.1")
-    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
-                "POWER8E v2.1", "CPU is unmaintained.")
     POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
                 "POWER8 v2.0")
-    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
-                "POWER8NVL v1.0", "CPU is unmaintained.")
     POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
                 "POWER9 v2.0")
     POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
@@ -918,9 +914,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "power7", "power7_v2.3" },
     { "power7+", "power7p_v2.1" },
     { "power7+_v2.1", "power7p_v2.1" },
-    { "power8e", "power8e_v2.1" },
     { "power8", "power8_v2.0" },
-    { "power8nvl", "power8nvl_v1.0" },
     { "power9", "power9_v2.2" },
     { "power10", "power10_v2.0" },
     { "power11", "power11_v2.0" },
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8cab5e12b6..f404c7e549 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6311,12 +6311,6 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
         if (base == CPU_POWERPC_POWER8_BASE) {
             return true;
         }
-        if (base == CPU_POWERPC_POWER8E_BASE) {
-            return true;
-        }
-        if (base == CPU_POWERPC_POWER8NVL_BASE) {
-            return true;
-        }
     }
     if (base != pcc_base) {
         return false;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b94c2997a0..78a1c4a839 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2437,9 +2437,7 @@ static bool kvmppc_power8_host(void)
 #ifdef TARGET_PPC64
     {
         uint32_t base_pvr = CPU_POWERPC_POWER_SERVER_MASK & mfpvr();
-        ret = (base_pvr == CPU_POWERPC_POWER8E_BASE) ||
-              (base_pvr == CPU_POWERPC_POWER8NVL_BASE) ||
-              (base_pvr == CPU_POWERPC_POWER8_BASE);
+        ret = (base_pvr == CPU_POWERPC_POWER8_BASE);
     }
 #endif /* TARGET_PPC64 */
     return ret;
-- 
2.52.0


