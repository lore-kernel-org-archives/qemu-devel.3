Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27946CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEw2-0005OL-UX; Wed, 10 Jun 2026 05:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEvt-00059e-An; Wed, 10 Jun 2026 05:09:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wXEvr-0000qu-Km; Wed, 10 Jun 2026 05:09:09 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7m0Z03513101; Wed, 10 Jun 2026 09:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JAO9gO1hKSWmDVv3T
 C2aVGl7+UytZCZu6nN0cvXymbw=; b=J2/7mSqJFCakjloF6PmiAKbap7rWo/LIo
 cJ9affnhYmephcaRU7L7naTjQHcV0ZEhLi+pTG1wUdq874mF7hN5URZIUGUB+I9t
 J4DU2Sldc7MloK7wvoX/KvdeD7Zn50B2a1Xth99co+eKlvBIvPpQsC6xzCXHPnUT
 xhyEXgdhFfaBrCJ5s8S2QDoPh3xhnisPbZflPU7b0tMJ9YxorbIH4bzRikfbQOWb
 7hJcFakwITWLN8IxzovN6xTv8K3WkQrZ60TTgT+UhPYkc/GwZ3I5+MvN41ZX/tKY
 oZRT+2n+XoBuj/8lkUampH/GAZAK0zktacsgrBq0k9o9o8afm0KqA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb240dj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:08:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A94bUU021052;
 Wed, 10 Jun 2026 09:08:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w62sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 09:08:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65A98gGg39780764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 09:08:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38B412004B;
 Wed, 10 Jun 2026 09:08:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FF8D20043;
 Wed, 10 Jun 2026 09:08:37 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.29.92]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 09:08:37 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
Date: Wed, 10 Jun 2026 14:38:00 +0530
Message-ID: <20260610090800.3672832-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090800.3672832-1-adityag@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a2929a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Wu8VgyIhYT4XZz0aUjsA:9
X-Proofpoint-ORIG-GUID: IgiFaFSVZyCEBOd-9QYUjy9etMX2hEzz
X-Proofpoint-GUID: -egbwWIFnz4aigFFpyMvPK7QVXt_ACDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX0HznTcaZZ6Nx
 F9PC5NMz1YyZoFQCrEhvjQYzlFaPzaW5sYdLIlg5LmGNmqugb/1GvIGmT1LNLHqcjMSplFjNh7/
 bdgZgi+OgAuf7a90G5fwFwzOFl9rn7d63k0VysRvbbmBn1volpsIUOnvsAlzNPGDwCB2E7ftZWp
 fU/G8eHLAH570fR3jwNy5q23Ne8efRj6kBbBMrIK4ygh+9coK9TVzkcElhQBwdcmDM1cXqV3cem
 ZA/s+8aXiDXG3X0aJxi/x1tVMeg2g9QTWVYeR5iXraYMBC77isxLmM6ABY3wfVwp3nHt8wdxajR
 tIqqTcsRhxaXOQ028rab13Tu7pctXHzmoK8YPdHDwclte1LN3mIKy6+nFJmpG4P4dQ4GvwWrKuJ
 lXomnqX4rKO/ol3ac78eIsMYgKrrHip3kkF4H48CISu6Nva8mvOFFZwDCrPZ0eTB0Shcrf9Zz9o
 lJJeAQUCkhXQDsFLKiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

With no use of 8E and 8NVL, in powernv chips or spapr cores, remove the
CPU definitions for the cores

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/about/deprecated.rst | 9 ---------
 target/ppc/cpu-models.c   | 6 ------
 target/ppc/cpu-models.h   | 4 ----
 target/ppc/cpu_init.c     | 6 ------
 target/ppc/kvm.c          | 4 +---
 5 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 97750f5edc91..3930ef08ed4b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -215,15 +215,6 @@ embedded 405 for power management (OCC) and other internal tasks, it
 is theoretically possible to use QEMU to model them. Let's keep the
 CPU implementation for a while before removing all support.
 
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
 
diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 26b6debcfc96..aa13654e83e8 100644
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
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index a439eb37ee41..ef019cdb1f3c 100644
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
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d25f69f13ba5..87186ec32179 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6310,12 +6310,6 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
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
index b94c2997a07f..78a1c4a8393e 100644
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
2.54.0


