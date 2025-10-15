Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE2FCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92OR-00023h-S7; Wed, 15 Oct 2025 10:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v92O9-0001xn-9T; Wed, 15 Oct 2025 10:22:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v92O2-0003FR-Np; Wed, 15 Oct 2025 10:22:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhCed001388;
 Wed, 15 Oct 2025 14:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ikakZFOkBJy10rrPA
 eZilU3KdsWmkhTBix+X1U34fy8=; b=rVTiIUcLX1iXgK9Tq9lu5IopJWrkFBlZs
 Bx9rdnvyp/nxHGPVN53PV5F+t60dw1V24qVSG0t15bwso7DkO21TPz2phfetG+n+
 kLps+MOqXTOetGD3iETy6MfpaQM29hRfMxpg1M8aM8Ob6B7YQ+uEYvrODUxFwdOC
 g0lJ5Zf5AQLJScopISr/Y0cgLd6jfyfIlRgqK3wAsjncR/7glbWyyb2gY1+4jYVa
 N9pyO1wij76/RRmrae9psTAQ/JWrPmi1DFmLR6MI/PP0O0MTaxF1B25SWvm1Ph8R
 nRj1cDWzF16v2cyhdxQmZQ5OR3bTZseAO19gQOb0fvAtdm3vWA2GQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7yw6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 14:21:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FB0XN1016996;
 Wed, 15 Oct 2025 14:21:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32k0pq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 14:21:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59FELijM24052186
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 14:21:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACB9920107;
 Wed, 15 Oct 2025 14:21:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B08C20104;
 Wed, 15 Oct 2025 14:21:44 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.87.134.59])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Oct 2025 14:21:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 2/3] target/s390x: Fix missing clock-comparator interrupts
 after reset
Date: Wed, 15 Oct 2025 16:21:05 +0200
Message-ID: <20251015142141.3238-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015142141.3238-1-iii@linux.ibm.com>
References: <20251015142141.3238-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2_J1_GlimJC3egFq0biASorBo2lTvqKR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX9pjkXg7it3nf
 91Ro0ZKMmHowhoG+Jh+abcxwzg5208cySvDbiKOVbuh24zr0XzDVtURN15+Y1JIHHSZBfATu01P
 MN3NEGZUlVWi8Jt+L+TIBwhg+ziOViGLDvlTUH7Scs9BNh5DJWrwzBR4f/TQM5JqZu/ZJ4MBWa2
 /dTed3gu/RVP1iWeg006IfFqrBcJCbn6BnBm71iy3jSrO/Z1xxYXgjYzSrIwgdxWX36/7KaNIFk
 2Fv6xggsp82NvHBWC0ThZ4Fhv1Cl/EmbF8+OFFx4g3iI+sQ34LN1aFd2BcjE97Q4t8ZbT3j0nzu
 7WAxwBtzYOU+XVXPRE+tXb8ZkFX86P8S26YUUQC/vP71i2/ehm5pHalvgHHwEPnRQycpRopzApt
 B8URTcPJxytFwc1Ya8TkT993fB/tWQ==
X-Proofpoint-GUID: 2_J1_GlimJC3egFq0biASorBo2lTvqKR
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68efadfc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=4iyXZ4RDbAuoQZjARrEA:9 a=Fg1AiH1G6rFz08G2ETeA:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

After reset, CKC value is set to 0, so if clock-comparator interrupts
are enabled, one should occur very shortly thereafter.

Currently the code does not set tod_timer, so this does not happen.

Fix by adding a tcg_s390_tod_updated() call. Initialize TOD clock
before CPUs in order to ensure that the respective object exists
during the CPU reset.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 +++---
 target/s390x/cpu.c         | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ad2c48188a8..9f37a96ae5a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -286,6 +286,9 @@ static void ccw_init(MachineState *machine)
     /* init memory + setup max page size. Required for the CPU model */
     s390_memory_init(machine);
 
+    /* init the TOD clock */
+    s390_init_tod();
+
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
 
@@ -332,9 +335,6 @@ static void ccw_init(MachineState *machine)
         s390_create_sclpconsole(ms->sclp, "sclplmconsole", serial_hd(1));
     }
 
-    /* init the TOD clock */
-    s390_init_tod();
-
     /* init SCLP event Control-Program Identification */
     if (s390mc->use_cpi) {
         s390_create_sclpcpi(ms->sclp);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index f05ce317da1..cc2de6ce08e 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -40,6 +40,7 @@
 #include "system/reset.h"
 #endif
 #include "hw/s390x/cpu-topology.h"
+#include "tcg/tcg_s390x.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -215,6 +216,13 @@ static void s390_cpu_reset_hold(Object *obj, ResetType type)
             break;
         }
     }
+
+#ifndef CONFIG_USER_ONLY
+    if (tcg_enabled()) {
+        /* Rearm the CKC timer if necessary */
+        tcg_s390_tod_updated(CPU(cpu), RUN_ON_CPU_NULL);
+    }
+#endif
 }
 
 static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.51.0


