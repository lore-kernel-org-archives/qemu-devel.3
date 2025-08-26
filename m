Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FD1CA0FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0AV-0004WQ-DT; Tue, 26 Aug 2025 16:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ur0AS-0004VI-NZ; Tue, 26 Aug 2025 16:21:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ur0AL-0004xV-S5; Tue, 26 Aug 2025 16:21:19 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCAhTA024902;
 Tue, 26 Aug 2025 20:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=K4s6i3fQj+v/vlN1J
 qpVnRDBlDhUY7RKA6m5T2EQxDg=; b=C45uzxVjO1N/a4X/8HJRTQ4qCYjttHiA4
 aPsfRTWlHG4ZuffJ4XfMnXiA521tyECCBy29iBEH/MhN55wrt15intamq234/lb8
 Iu3/bEV1a+x0YvBEJMLqAFKuEHqznCRd3p3zLV2sTFSRTqwl7UiVJS8IdpEqPmqo
 WfYkUVx/oCcSJFiGab8CstE1E17PSpRy13MiEsfQtoyq/MTXfgCpmBGUYAdPAqQe
 oFowoJXwM6DC2+rjPZOUndptT11MXEvwoCbeMg9+DJaOCPP4PU42cWngaaa79t12
 rpZCvh5hT+7UjuPS+kZ1ZiyZfqT5ub/Xlf8w2uOkKAU5TMSsd7VoQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5580t7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:21:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QKGVjD023047;
 Tue, 26 Aug 2025 20:21:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5580t7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:21:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57QGgR91018006;
 Tue, 26 Aug 2025 20:21:08 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3c94q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:21:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57QKL7mc17957604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 20:21:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D13958066;
 Tue, 26 Aug 2025 20:21:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B44A5805A;
 Tue, 26 Aug 2025 20:21:06 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Aug 2025 20:21:06 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v2 1/4] target/ppc: Add IBM PPE42 family of processors
Date: Tue, 26 Aug 2025 15:17:48 -0500
Message-ID: <20250826201920.335308-2-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826201920.335308-1-milesg@linux.ibm.com>
References: <20250826201920.335308-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: raRx9i1TRFYoASaZgKzqxsspkxwYXtZ9
X-Proofpoint-ORIG-GUID: SPyl-AiTY5JNz8uYFz07nJmkPSQsrDHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX8oBs8LiE0UAr
 c3+4n3KbrcCKw4v3aPDocFfzCc2Z0wcmNYxlVyvuM0mt3sWEfo9J3avbshWBO5H6FBgku6F76uB
 44g2SbjYtQAkS1sDJOtQ86j5e8J9zOMTZVHjUjQOmK+H6CJSRWpnkemFpo0iA1Kio3z5c5Cap6k
 cv9R58ItsNrLQMdbuN5SUmyHGrXSDK27GlyS0QCQ/QhIJjEeZSrj5RqIcomTxKI0T9Wd8ZguFaF
 rRHyCdw9cX8d05+cfb9agZzRYsj4CJ3SPrmPptoyew6Fv2pUZcdlu4BFoePvmFm4aaW+IoSFtfD
 gt4S/kiIjx208QhgRA2ac1gtatrzQYIfsDuCs5lyGa4aejTuWn5DdJbD8MADOf4UqswmwDG6KwS
 KCcPjlU6
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68ae1736 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=jRLB2SoPAAAA:8 a=VnNF1IyMAAAA:8 a=0wKqFDJD4ESPtWG4DLYA:9
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Adds the IBM PPE42 family of 32-bit processors supporting
the PPE42, PPE42X and PPE42XM processor versions.  These
processors are used as embedded processors in the IBM
Power9, Power10 and Power12 processors for various
tasks.  It is basically a stripped down version of the
IBM PowerPC 405 processor, with some added instructions
for handling 64-bit loads and stores.

For more information on the PPE 42 processor please visit:

https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf

Supports PPE42 SPR's (Including the MSR) and  Exceptions.

Does not yet support new PPE42 instructions and does not
prevent access to some invalid instructions and registers
(currently allows for access to invalid GPR's and CR fields).

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---

Changes since previous version
- Added "32-bit" wording to commit message
- Added 'unlikely' specifier to hreg_compute_hflags_value conditional
- Added PPE42_ prefix to ISR definitions
- Moved ISR_MCS* definitions from excp_helper.c to cpu.h
- Moved common cpu_init code to a common function
- Added 'likely' specifier to gen_mtmsr conditional
- Formatting changes to fit comments within 80 character limit

 target/ppc/cpu-models.c      |   7 +
 target/ppc/cpu-models.h      |   4 +
 target/ppc/cpu.h             |  76 ++++++++++-
 target/ppc/cpu_init.c        | 241 +++++++++++++++++++++++++++++------
 target/ppc/excp_helper.c     | 163 +++++++++++++++++++++++
 target/ppc/helper_regs.c     |  28 +++-
 target/ppc/tcg-excp_helper.c |  12 ++
 target/ppc/translate.c       |   6 +-
 8 files changed, 492 insertions(+), 45 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index ea86ea202a..09f73e23a8 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -116,6 +116,13 @@
                 NULL)
     POWERPC_DEF("x2vp20",        CPU_POWERPC_X2VP20,                 405,
                 NULL)
+    /* PPE42 Embedded Controllers                                            */
+    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42,                  ppe42,
+                "Generic PPE 42")
+    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X,                 ppe42x,
+                "Generic PPE 42X")
+    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM,                ppe42xm,
+                "Generic PPE 42XM")
     /* PowerPC 440 family                                                    */
 #if defined(TODO_USER_ONLY)
     POWERPC_DEF("440",           CPU_POWERPC_440,                    440GP,
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 72ad31ba50..c6cd27f390 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -69,6 +69,10 @@ enum {
     /* Xilinx cores */
     CPU_POWERPC_X2VP4              = 0x20010820,
     CPU_POWERPC_X2VP20             = 0x20010860,
+    /* IBM PPE42 Family */
+    CPU_POWERPC_PPE42              = 0x42000000,
+    CPU_POWERPC_PPE42X             = 0x42100000,
+    CPU_POWERPC_PPE42XM            = 0x42200000,
     /* PowerPC 440 family */
     /* Generic PowerPC 440 */
 #define CPU_POWERPC_440              CPU_POWERPC_440GXf
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b90543811..c68dd4f141 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -220,6 +220,8 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_POWER10,
     /* POWER11 exception model           */
     POWERPC_EXCP_POWER11,
+    /* PPE42 exception model            */
+    POWERPC_EXCP_PPE42,
 } powerpc_excp_t;
 
 /*****************************************************************************/
@@ -282,6 +284,8 @@ typedef enum powerpc_input_t {
     PPC_FLAGS_INPUT_POWER9,
     /* Freescale RCPU bus               */
     PPC_FLAGS_INPUT_RCPU,
+    /* PPE42 bus                        */
+    PPC_FLAGS_INPUT_PPE42,
 } powerpc_input_t;
 
 #define PPC_INPUT(env) ((env)->bus_model)
@@ -433,39 +437,64 @@ typedef enum {
 #define MSR_TM   PPC_BIT_NR(31) /* Transactional Memory Available (Book3s)   */
 #define MSR_CM   PPC_BIT_NR(32) /* Computation mode for BookE         hflags */
 #define MSR_ICM  PPC_BIT_NR(33) /* Interrupt computation mode for BookE      */
+#define MSR_SEM0 PPC_BIT_NR(33) /* SIB Error Mask Bit 0 (PPE42)              */
+#define MSR_SEM1 PPC_BIT_NR(34) /* SIB Error Mask Bit 1 (PPE42)              */
+#define MSR_SEM2 PPC_BIT_NR(35) /* SIB Error Mask Bit 2 (PPE42)              */
 #define MSR_GS   PPC_BIT_NR(35) /* guest state for BookE                     */
+#define MSR_SEM3 PPC_BIT_NR(36) /* SIB Error Mask Bit 3 (PPE42)              */
+#define MSR_SEM4 PPC_BIT_NR(37) /* SIB Error Mask Bit 4 (PPE42)              */
 #define MSR_UCLE PPC_BIT_NR(37) /* User-mode cache lock enable for BookE     */
 #define MSR_VR   PPC_BIT_NR(38) /* altivec available                x hflags */
 #define MSR_SPE  PPC_BIT_NR(38) /* SPE enable for BookE             x hflags */
+#define MSR_SEM5 PPC_BIT_NR(38) /* SIB Error Mask Bit 5 (PPE42)              */
+#define MSR_SEM6 PPC_BIT_NR(39) /* SIB Error Mask Bit 6 (PPE42)              */
 #define MSR_VSX  PPC_BIT_NR(40) /* Vector Scalar Extension (>= 2.06)x hflags */
+#define MSR_IS0  PPC_BIT_NR(40) /* Instance Specific Bit 0 (PPE42)           */
 #define MSR_S    PPC_BIT_NR(41) /* Secure state                              */
+#define MSR_SIBRC0 PPC_BIT_NR(41) /* Last SIB return code Bit 0 (PPE42)      */
+#define MSR_SIBRC1 PPC_BIT_NR(42) /* Last SIB return code Bit 1 (PPE42)      */
+#define MSR_SIBRC2 PPC_BIT_NR(43) /* Last SIB return code Bit 2 (PPE42)      */
+#define MSR_LP   PPC_BIT_NR(44) /* Low Priority (PPE42)                      */
 #define MSR_KEY  PPC_BIT_NR(44) /* key bit on 603e                           */
 #define MSR_POW  PPC_BIT_NR(45) /* Power management                          */
 #define MSR_WE   PPC_BIT_NR(45) /* Wait State Enable on 405                  */
+#define MSR_IS1  PPC_BIT_NR(46) /* Instance Specific Bit 1 (PPE42)           */
 #define MSR_TGPR PPC_BIT_NR(46) /* TGPR usage on 602/603            x        */
 #define MSR_CE   PPC_BIT_NR(46) /* Critical int. enable on embedded PPC x    */
 #define MSR_ILE  PPC_BIT_NR(47) /* Interrupt little-endian mode              */
+#define MSR_UIE  PPC_BIT_NR(47) /* Unmaskable Interrupt Enable (PPE42)       */
 #define MSR_EE   PPC_BIT_NR(48) /* External interrupt enable                 */
 #define MSR_PR   PPC_BIT_NR(49) /* Problem state                      hflags */
 #define MSR_FP   PPC_BIT_NR(50) /* Floating point available           hflags */
 #define MSR_ME   PPC_BIT_NR(51) /* Machine check interrupt enable            */
 #define MSR_FE0  PPC_BIT_NR(52) /* Floating point exception mode 0           */
+#define MSR_IS2  PPC_BIT_NR(52) /* Instance Specific Bit 2 (PPE42)           */
+#define MSR_IS3  PPC_BIT_NR(53) /* Instance Specific Bit 3 (PPE42)           */
 #define MSR_SE   PPC_BIT_NR(53) /* Single-step trace enable         x hflags */
 #define MSR_DWE  PPC_BIT_NR(53) /* Debug wait enable on 405         x        */
 #define MSR_UBLE PPC_BIT_NR(53) /* User BTB lock enable on e500     x        */
 #define MSR_BE   PPC_BIT_NR(54) /* Branch trace enable              x hflags */
 #define MSR_DE   PPC_BIT_NR(54) /* Debug int. enable on embedded PPC   x     */
 #define MSR_FE1  PPC_BIT_NR(55) /* Floating point exception mode 1           */
+#define MSR_IPE  PPC_BIT_NR(55) /* Imprecise Mode Enable (PPE42)             */
 #define MSR_AL   PPC_BIT_NR(56) /* AL bit on POWER                           */
+#define MSR_SIBRCA0 PPC_BIT_NR(56) /* SIB Return Code Accumulator 0 (PPE42)  */
+#define MSR_SIBRCA1 PPC_BIT_NR(57) /* SIB Return Code Accumulator 1 (PPE42)  */
 #define MSR_EP   PPC_BIT_NR(57) /* Exception prefix on 601                   */
 #define MSR_IR   PPC_BIT_NR(58) /* Instruction relocate                      */
 #define MSR_IS   PPC_BIT_NR(58) /* Instruction address space (BookE)         */
+#define MSR_SIBRCA2 PPC_BIT_NR(58) /* SIB Return Code Accumulator 2 (PPE42)  */
+#define MSR_SIBRCA3 PPC_BIT_NR(59) /* SIB Return Code Accumulator 3 (PPE42)  */
 #define MSR_DR   PPC_BIT_NR(59) /* Data relocate                             */
 #define MSR_DS   PPC_BIT_NR(59) /* Data address space (BookE)                */
 #define MSR_PE   PPC_BIT_NR(60) /* Protection enable on 403                  */
+#define MSR_SIBRCA4 PPC_BIT_NR(60) /* SIB Return Code Accumulator 4 (PPE42)  */
+#define MSR_SIBRCA5 PPC_BIT_NR(61) /* SIB Return Code Accumulator 5 (PPE42)  */
 #define MSR_PX   PPC_BIT_NR(61) /* Protection exclusive on 403        x      */
 #define MSR_PMM  PPC_BIT_NR(61) /* Performance monitor mark on POWER  x      */
 #define MSR_RI   PPC_BIT_NR(62) /* Recoverable interrupt            1        */
+#define MSR_SIBRCA6 PPC_BIT_NR(62) /* SIB Return Code Accumulator 6 (PPE42)  */
+#define MSR_SIBRCA7 PPC_BIT_NR(63) /* SIB Return Code Accumulator 7 (PPE42)  */
 #define MSR_LE   PPC_BIT_NR(63) /* Little-endian mode               1 hflags */
 
 FIELD(MSR, SF, MSR_SF, 1)
@@ -517,6 +546,9 @@ FIELD(MSR, PX, MSR_PX, 1)
 FIELD(MSR, PMM, MSR_PMM, 1)
 FIELD(MSR, RI, MSR_RI, 1)
 FIELD(MSR, LE, MSR_LE, 1)
+FIELD(MSR, SEM, MSR_SEM6, 7)
+FIELD(MSR, SIBRC, MSR_SIBRC2, 3)
+FIELD(MSR, SIBRCA, MSR_SIBRCA7, 8)
 
 /*
  * FE0 and FE1 bits are not side-by-side
@@ -730,6 +762,31 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define ESR_VLEMI PPC_BIT(58) /* VLE operation                          */
 #define ESR_MIF   PPC_BIT(62) /* Misaligned instruction (VLE)           */
 
+/* PPE42 Interrupt Status Register bits */
+#define PPE42_ISR_SRSMS0  PPC_BIT_NR(48) /* Sys Reset State Machine State 0   */
+#define PPE42_ISR_SRSMS1  PPC_BIT_NR(49) /* Sys Reset State Machine State 1   */
+#define PPE42_ISR_SRSMS2  PPC_BIT_NR(50) /* Sys Reset State Machine State 2   */
+#define PPE42_ISR_SRSMS3  PPC_BIT_NR(51) /* Sys Reset State Machine State 3   */
+#define PPE42_ISR_EP      PPC_BIT_NR(53) /* MSR[EE] Maskable Event Pending    */
+#define PPE42_ISR_PTR     PPC_BIT_NR(56) /* Program Interrupt from trap       */
+#define PPE42_ISR_ST      PPC_BIT_NR(57) /* Data Interrupt caused by store    */
+#define PPE42_ISR_MFE     PPC_BIT_NR(60) /* Multiple Fault Error              */
+#define PPE42_ISR_MCS0    PPC_BIT_NR(61) /* Machine Check Status bit0         */
+#define PPE42_ISR_MCS1    PPC_BIT_NR(62) /* Machine Check Status bit1         */
+#define PPE42_ISR_MCS2    PPC_BIT_NR(63) /* Machine Check Status bit2         */
+FIELD(PPE42_ISR, SRSMS, PPE42_ISR_SRSMS3, 4)
+FIELD(PPE42_ISR, MCS, PPE42_ISR_MCS2, 3)
+
+/* PPE42 Machine Check Status field values */
+#define PPE42_ISR_MCS_INSTRUCTION             0
+#define PPE42_ISR_MCS_DATA_LOAD               1
+#define PPE42_ISR_MCS_DATA_PRECISE_STORE      2
+#define PPE42_ISR_MCS_DATA_IMPRECISE_STORE    3
+#define PPE42_ISR_MCS_PROGRAM                 4
+#define PPE42_ISR_MCS_ISI                     5
+#define PPE42_ISR_MCS_ALIGNMENT               6
+#define PPE42_ISR_MCS_DSI                     7
+
 /* Transaction EXception And Summary Register bits                           */
 #define TEXASR_FAILURE_PERSISTENT                (63 - 7)
 #define TEXASR_DISALLOWED                        (63 - 8)
@@ -785,6 +842,8 @@ enum {
     POWERPC_FLAG_SMT_1LPAR = 0x00800000,
     /* Has BHRB */
     POWERPC_FLAG_BHRB      = 0x01000000,
+    /* Use PPE42-specific behavior                                           */
+    POWERPC_FLAG_PPE42     = 0x02000000,
 };
 
 /*
@@ -1750,9 +1809,12 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_CSRR0       (0x03A)
 #define SPR_BOOKE_CSRR1       (0x03B)
 #define SPR_BOOKE_DEAR        (0x03D)
+#define SPR_PPE42_EDR         (0x03D)
 #define SPR_IAMR              (0x03D)
 #define SPR_BOOKE_ESR         (0x03E)
+#define SPR_PPE42_ISR         (0x03E)
 #define SPR_BOOKE_IVPR        (0x03F)
+#define SPR_PPE42_IVPR        (0x03F)
 #define SPR_MPC_EIE           (0x050)
 #define SPR_MPC_EID           (0x051)
 #define SPR_MPC_NRI           (0x052)
@@ -1818,6 +1880,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_TBU40             (0x11E)
 #define SPR_SVR               (0x11E)
 #define SPR_BOOKE_PIR         (0x11E)
+#define SPR_PPE42_PIR         (0x11E)
 #define SPR_PVR               (0x11F)
 #define SPR_HSPRG0            (0x130)
 #define SPR_BOOKE_DBSR        (0x130)
@@ -1827,6 +1890,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_EPCR        (0x133)
 #define SPR_SPURR             (0x134)
 #define SPR_BOOKE_DBCR0       (0x134)
+#define SPR_PPE42_DBCR        (0x134)
 #define SPR_IBCR              (0x135)
 #define SPR_PURR              (0x135)
 #define SPR_BOOKE_DBCR1       (0x135)
@@ -1844,6 +1908,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HSRR1             (0x13B)
 #define SPR_BOOKE_IAC4        (0x13B)
 #define SPR_BOOKE_DAC1        (0x13C)
+#define SPR_PPE42_DACR        (0x13C)
 #define SPR_MMCRH             (0x13C)
 #define SPR_DABR2             (0x13D)
 #define SPR_BOOKE_DAC2        (0x13D)
@@ -1853,12 +1918,14 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_DVC2        (0x13F)
 #define SPR_LPIDR             (0x13F)
 #define SPR_BOOKE_TSR         (0x150)
+#define SPR_PPE42_TSR         (0x150)
 #define SPR_HMER              (0x150)
 #define SPR_HMEER             (0x151)
 #define SPR_PCR               (0x152)
 #define SPR_HEIR              (0x153)
 #define SPR_BOOKE_LPIDR       (0x152)
 #define SPR_BOOKE_TCR         (0x154)
+#define SPR_PPE42_TCR         (0x154)
 #define SPR_BOOKE_TLB0PS      (0x158)
 #define SPR_BOOKE_TLB1PS      (0x159)
 #define SPR_BOOKE_TLB2PS      (0x15A)
@@ -2528,6 +2595,12 @@ enum {
     PPC2_MEM_LWSYNC    = 0x0000000000200000ULL,
     /* ISA 2.06 BCD assist instructions                                      */
     PPC2_BCDA_ISA206   = 0x0000000000400000ULL,
+    /* PPE42 instructions                                                    */
+    PPC2_PPE42         = 0x0000000000800000ULL,
+    /* PPE42X instructions                                                   */
+    PPC2_PPE42X        = 0x0000000001000000ULL,
+    /* PPE42XM instructions                                                  */
+    PPC2_PPE42XM       = 0x0000000002000000ULL,
 
 #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
                         PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
@@ -2537,7 +2610,8 @@ enum {
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
-                        PPC2_BCDA_ISA206)
+                        PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
+                        PPC2_PPE42XM)
 };
 
 /*****************************************************************************/
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a0e77f2673..698d61bf0c 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1653,6 +1653,47 @@ static void register_8xx_sprs(CPUPPCState *env)
  * ... and more (thermal management, performance counters, ...)
  */
 
+static void register_ppe42_sprs(CPUPPCState *env)
+{
+    spr_register(env, SPR_PPE42_EDR, "EDR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_PPE42_ISR, "ISR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    spr_register(env, SPR_PPE42_IVPR, "IVPR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
+                 0xfff80000);
+    spr_register(env, SPR_PPE42_PIR, "PIR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_pir,
+                 0x00000000);
+    spr_register(env, SPR_PPE42_DBCR, "DBCR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_40x_dbcr0,
+                 0x00000000);
+    spr_register(env, SPR_PPE42_DACR, "DACR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_generic,
+                 0x00000000);
+    /* Timer */
+    spr_register(env, SPR_DECR, "DECR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_decr, &spr_write_decr,
+                 0x00000000);
+    spr_register(env, SPR_PPE42_TSR, "TSR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_booke_tsr,
+                 0x00000000);
+    spr_register(env, SPR_BOOKE_TCR, "TCR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_booke_tcr,
+                 0x00000000);
+}
+
 /*****************************************************************************/
 /* Exception vectors models                                                  */
 static void init_excp_4xx(CPUPPCState *env)
@@ -1679,6 +1720,30 @@ static void init_excp_4xx(CPUPPCState *env)
 #endif
 }
 
+static void init_excp_ppe42(CPUPPCState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    /* Machine Check vector changed after version 0 */
+    if (((env->spr[SPR_PVR] & 0xf00000ul) >> 20) == 0) {
+        env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000000;
+    } else {
+        env->excp_vectors[POWERPC_EXCP_MCHECK]   = 0x00000020;
+    }
+    env->excp_vectors[POWERPC_EXCP_RESET]    = 0x00000040;
+    env->excp_vectors[POWERPC_EXCP_DSI]      = 0x00000060;
+    env->excp_vectors[POWERPC_EXCP_ISI]      = 0x00000080;
+    env->excp_vectors[POWERPC_EXCP_EXTERNAL] = 0x000000A0;
+    env->excp_vectors[POWERPC_EXCP_ALIGN]    = 0x000000C0;
+    env->excp_vectors[POWERPC_EXCP_PROGRAM]  = 0x000000E0;
+    env->excp_vectors[POWERPC_EXCP_DECR]     = 0x00000100;
+    env->excp_vectors[POWERPC_EXCP_FIT]      = 0x00000120;
+    env->excp_vectors[POWERPC_EXCP_WDT]      = 0x00000140;
+    env->ivpr_mask = 0xFFFFFE00UL;
+    /* Hardware reset vector */
+    env->hreset_vector = 0x00000040UL;
+#endif
+}
+
 static void init_excp_MPC5xx(CPUPPCState *env)
 {
 #if !defined(CONFIG_USER_ONLY)
@@ -2200,6 +2265,80 @@ POWERPC_FAMILY(405)(ObjectClass *oc, const void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
+static void init_proc_ppe42(CPUPPCState *env)
+{
+    register_ppe42_sprs(env);
+
+    init_excp_ppe42(env);
+    env->dcache_line_size = 32;
+    env->icache_line_size = 32;
+    /* Allocate hardware IRQ controller */
+    ppc40x_irq_init(env_archcpu(env));
+
+    SET_FIT_PERIOD(8, 12, 16, 20);
+    SET_WDT_PERIOD(16, 20, 24, 28);
+}
+
+static void ppe42_class_common_init(PowerPCCPUClass *pcc)
+{
+    pcc->init_proc = init_proc_ppe42;
+    pcc->check_pow = check_pow_nocheck;
+    pcc->check_attn = check_attn_none;
+    pcc->insns_flags = PPC_INSNS_BASE |
+                       PPC_WRTEE |
+                       PPC_CACHE |
+                       PPC_CACHE_DCBZ |
+                       PPC_MEM_SYNC;
+    pcc->msr_mask = R_MSR_SEM_MASK |
+                    (1ull << MSR_IS0) |
+                    R_MSR_SIBRC_MASK |
+                    (1ull << MSR_LP) |
+                    (1ull << MSR_WE) |
+                    (1ull << MSR_IS1) |
+                    (1ull << MSR_UIE) |
+                    (1ull << MSR_EE) |
+                    (1ull << MSR_ME) |
+                    (1ull << MSR_IS2) |
+                    (1ull << MSR_IS3) |
+                    (1ull << MSR_IPE) |
+                    R_MSR_SIBRCA_MASK;
+    pcc->mmu_model = POWERPC_MMU_REAL;
+    pcc->excp_model = POWERPC_EXCP_PPE42;
+    pcc->bus_model = PPC_FLAGS_INPUT_PPE42;
+    pcc->bfd_mach = bfd_mach_ppc_403;
+    pcc->flags = POWERPC_FLAG_PPE42 | POWERPC_FLAG_BUS_CLK;
+}
+
+POWERPC_FAMILY(ppe42)(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->desc = "PPE 42";
+    pcc->insns_flags2 = PPC2_PPE42;
+    ppe42_class_common_init(pcc);
+}
+
+POWERPC_FAMILY(ppe42x)(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->desc = "PPE 42X";
+    pcc->insns_flags2 = PPC2_PPE42 | PPC2_PPE42X;
+    ppe42_class_common_init(pcc);
+}
+
+POWERPC_FAMILY(ppe42xm)(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->desc = "PPE 42XM";
+    pcc->insns_flags2 = PPC2_PPE42 | PPC2_PPE42X | PPC2_PPE42XM;
+    ppe42_class_common_init(pcc);
+}
+
 static void init_proc_440EP(CPUPPCState *env)
 {
     register_BookE_sprs(env, 0x000000000000FFFFULL);
@@ -6802,53 +6941,63 @@ static void init_ppc_proc(PowerPCCPU *cpu)
 
     /* MSR bits & flags consistency checks */
     if (env->msr_mask & (1 << 25)) {
-        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
+        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE |
+                              POWERPC_FLAG_PPE42)) {
         case POWERPC_FLAG_SPE:
         case POWERPC_FLAG_VRE:
+        case POWERPC_FLAG_PPE42:
             break;
         default:
             fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n");
+                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n"
+                    "or POWERPC_FLAG_PPE42\n");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
         fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_SPE nor POWERPC_FLAG_VRE\n");
+                "Should not define POWERPC_FLAG_SPE nor POWERPC_FLAG_VRE\n"
+                "nor POWERPC_FLAG_PPE42\n");
         exit(1);
     }
     if (env->msr_mask & (1 << 17)) {
-        switch (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE)) {
+        switch (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE |
+                              POWERPC_FLAG_PPE42)) {
         case POWERPC_FLAG_TGPR:
         case POWERPC_FLAG_CE:
+        case POWERPC_FLAG_PPE42:
             break;
         default:
             fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_TGPR or POWERPC_FLAG_CE\n");
+                    "Should define POWERPC_FLAG_TGPR or POWERPC_FLAG_CE\n"
+                    "or POWERPC_FLAG_PPE42\n");
             exit(1);
         }
-    } else if (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE)) {
+    } else if (env->flags & (POWERPC_FLAG_TGPR | POWERPC_FLAG_CE |
+                             POWERPC_FLAG_PPE42)) {
         fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_TGPR nor POWERPC_FLAG_CE\n");
+                "Should not define POWERPC_FLAG_TGPR nor POWERPC_FLAG_CE\n"
+                "nor POWERPC_FLAG_PPE42\n");
         exit(1);
     }
     if (env->msr_mask & (1 << 10)) {
         switch (env->flags & (POWERPC_FLAG_SE | POWERPC_FLAG_DWE |
-                              POWERPC_FLAG_UBLE)) {
+                              POWERPC_FLAG_UBLE | POWERPC_FLAG_PPE42)) {
         case POWERPC_FLAG_SE:
         case POWERPC_FLAG_DWE:
         case POWERPC_FLAG_UBLE:
+        case POWERPC_FLAG_PPE42:
             break;
         default:
             fprintf(stderr, "PowerPC MSR definition inconsistency\n"
                     "Should define POWERPC_FLAG_SE or POWERPC_FLAG_DWE or "
-                    "POWERPC_FLAG_UBLE\n");
+                    "POWERPC_FLAG_UBLE or POWERPC_FLAG_PPE42\n");
             exit(1);
         }
     } else if (env->flags & (POWERPC_FLAG_SE | POWERPC_FLAG_DWE |
-                             POWERPC_FLAG_UBLE)) {
+                             POWERPC_FLAG_UBLE | POWERPC_FLAG_PPE42)) {
         fprintf(stderr, "PowerPC MSR definition inconsistency\n"
                 "Should not define POWERPC_FLAG_SE nor POWERPC_FLAG_DWE nor "
-                "POWERPC_FLAG_UBLE\n");
+                "POWERPC_FLAG_UBLE nor POWERPC_FLAG_PPE42\n");
             exit(1);
     }
     if (env->msr_mask & (1 << 9)) {
@@ -6867,18 +7016,23 @@ static void init_ppc_proc(PowerPCCPU *cpu)
         exit(1);
     }
     if (env->msr_mask & (1 << 2)) {
-        switch (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM)) {
+        switch (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM |
+                              POWERPC_FLAG_PPE42)) {
         case POWERPC_FLAG_PX:
         case POWERPC_FLAG_PMM:
+        case POWERPC_FLAG_PPE42:
             break;
         default:
             fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                    "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM\n");
+                    "Should define POWERPC_FLAG_PX or POWERPC_FLAG_PMM\n"
+                    "or POWERPC_FLAG_PPE42\n");
             exit(1);
         }
-    } else if (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM)) {
+    } else if (env->flags & (POWERPC_FLAG_PX | POWERPC_FLAG_PMM |
+                             POWERPC_FLAG_PPE42)) {
         fprintf(stderr, "PowerPC MSR definition inconsistency\n"
-                "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM\n");
+                "Should not define POWERPC_FLAG_PX nor POWERPC_FLAG_PMM\n"
+                "nor POWERPC_FLAG_PPE42\n");
         exit(1);
     }
     if ((env->flags & POWERPC_FLAG_BUS_CLK) == 0) {
@@ -7243,39 +7397,40 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     msr = (target_ulong)0;
-    msr |= (target_ulong)MSR_HVB;
-    msr |= (target_ulong)1 << MSR_EP;
+    if (!(env->flags & POWERPC_FLAG_PPE42)) {
+        msr |= (target_ulong)MSR_HVB;
+        msr |= (target_ulong)1 << MSR_EP;
 #if defined(DO_SINGLE_STEP) && 0
-    /* Single step trace mode */
-    msr |= (target_ulong)1 << MSR_SE;
-    msr |= (target_ulong)1 << MSR_BE;
+        /* Single step trace mode */
+        msr |= (target_ulong)1 << MSR_SE;
+        msr |= (target_ulong)1 << MSR_BE;
 #endif
 #if defined(CONFIG_USER_ONLY)
-    msr |= (target_ulong)1 << MSR_FP; /* Allow floating point usage */
-    msr |= (target_ulong)1 << MSR_FE0; /* Allow floating point exceptions */
-    msr |= (target_ulong)1 << MSR_FE1;
-    msr |= (target_ulong)1 << MSR_VR; /* Allow altivec usage */
-    msr |= (target_ulong)1 << MSR_VSX; /* Allow VSX usage */
-    msr |= (target_ulong)1 << MSR_SPE; /* Allow SPE usage */
-    msr |= (target_ulong)1 << MSR_PR;
+        msr |= (target_ulong)1 << MSR_FP; /* Allow floating point usage */
+        msr |= (target_ulong)1 << MSR_FE0; /* Allow floating point exceptions */
+        msr |= (target_ulong)1 << MSR_FE1;
+        msr |= (target_ulong)1 << MSR_VR; /* Allow altivec usage */
+        msr |= (target_ulong)1 << MSR_VSX; /* Allow VSX usage */
+        msr |= (target_ulong)1 << MSR_SPE; /* Allow SPE usage */
+        msr |= (target_ulong)1 << MSR_PR;
 #if defined(TARGET_PPC64)
-    msr |= (target_ulong)1 << MSR_TM; /* Transactional memory */
+        msr |= (target_ulong)1 << MSR_TM; /* Transactional memory */
 #endif
 #if !TARGET_BIG_ENDIAN
-    msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
-    if (!((env->msr_mask >> MSR_LE) & 1)) {
-        fprintf(stderr, "Selected CPU does not support little-endian.\n");
-        exit(1);
-    }
+        msr |= (target_ulong)1 << MSR_LE; /* Little-endian user mode */
+        if (!((env->msr_mask >> MSR_LE) & 1)) {
+            fprintf(stderr, "Selected CPU does not support little-endian.\n");
+            exit(1);
+        }
 #endif
 #endif
 
 #if defined(TARGET_PPC64)
-    if (mmu_is_64bit(env->mmu_model)) {
-        msr |= (1ULL << MSR_SF);
-    }
+        if (mmu_is_64bit(env->mmu_model)) {
+            msr |= (1ULL << MSR_SF);
+        }
 #endif
-
+    }
     hreg_store_msr(env, msr, 1);
 
 #if !defined(CONFIG_USER_ONLY)
@@ -7725,6 +7880,18 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
          * they can be read with "p $ivor0", "p $ivor1", etc.
          */
         break;
+    case POWERPC_EXCP_PPE42:
+        qemu_fprintf(f, "SRR0 " TARGET_FMT_lx " SRR1 " TARGET_FMT_lx "\n",
+                     env->spr[SPR_SRR0], env->spr[SPR_SRR1]);
+
+        qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
+                     "    ISR " TARGET_FMT_lx "   EDR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_PPE42_TCR], env->spr[SPR_PPE42_TSR],
+                     env->spr[SPR_PPE42_ISR], env->spr[SPR_PPE42_EDR]);
+
+        qemu_fprintf(f, "  PIR " TARGET_FMT_lx "   IVPR " TARGET_FMT_lx "\n",
+                     env->spr[SPR_PPE42_PIR], env->spr[SPR_PPE42_IVPR]);
+        break;
     case POWERPC_EXCP_40x:
         qemu_fprintf(f, "  TCR " TARGET_FMT_lx "   TSR " TARGET_FMT_lx
                      "    ESR " TARGET_FMT_lx "   DEAR " TARGET_FMT_lx "\n",
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1efdc4066e..d8bca19fff 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -949,6 +949,125 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     powerpc_set_excp_state(cpu, vector, new_msr);
 }
 
+static void powerpc_excp_ppe42(PowerPCCPU *cpu, int excp)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong msr, new_msr, vector;
+    target_ulong mcs = PPE42_ISR_MCS_INSTRUCTION;
+    bool promote_unmaskable;
+
+    msr = env->msr;
+
+    /*
+     * New interrupt handler msr preserves SIBRC and ME unless explicitly
+     * overridden by the exception.  All other MSR bits are zeroed out.
+     */
+    new_msr = env->msr & (((target_ulong)1 << MSR_ME) | R_MSR_SIBRC_MASK);
+
+    /* HV emu assistance interrupt only exists on server arch 2.05 or later */
+    if (excp == POWERPC_EXCP_HV_EMU) {
+        excp = POWERPC_EXCP_PROGRAM;
+    }
+
+    /*
+     * Unmaskable interrupts (Program, ISI, Alignment and DSI) are promoted to
+     * machine check if MSR_UIE is 0.
+     */
+    promote_unmaskable = !(msr & ((target_ulong)1 << MSR_UIE));
+
+
+    switch (excp) {
+    case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
+        break;
+    case POWERPC_EXCP_DSI:       /* Data storage exception                   */
+        trace_ppc_excp_dsi(env->spr[SPR_PPE42_ISR], env->spr[SPR_PPE42_EDR]);
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_DSI;
+        }
+        break;
+    case POWERPC_EXCP_ISI:       /* Instruction storage exception            */
+        trace_ppc_excp_isi(msr, env->nip);
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_ISI;
+        }
+        break;
+    case POWERPC_EXCP_EXTERNAL:  /* External input                           */
+        break;
+    case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_ALIGNMENT;
+        }
+        break;
+    case POWERPC_EXCP_PROGRAM:   /* Program exception                        */
+        if (promote_unmaskable) {
+            excp = POWERPC_EXCP_MCHECK;
+            mcs = PPE42_ISR_MCS_PROGRAM;
+        }
+        switch (env->error_code & ~0xF) {
+        case POWERPC_EXCP_INVAL:
+            trace_ppc_excp_inval(env->nip);
+            env->spr[SPR_PPE42_ISR] &= ~((target_ulong)1 << PPE42_ISR_PTR);
+            break;
+        case POWERPC_EXCP_TRAP:
+            env->spr[SPR_PPE42_ISR] |= ((target_ulong)1 << PPE42_ISR_PTR);
+            break;
+        default:
+            /* Should never occur */
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
+                      env->error_code);
+            break;
+        }
+#ifdef CONFIG_TCG
+        env->spr[SPR_PPE42_EDR] = ppc_ldl_code(env, env->nip);
+#endif
+        break;
+    case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
+        break;
+    case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt           */
+        trace_ppc_excp_print("FIT");
+        break;
+    case POWERPC_EXCP_WDT:       /* Watchdog timer interrupt                 */
+        trace_ppc_excp_print("WDT");
+        break;
+    case POWERPC_EXCP_RESET:     /* System reset exception                   */
+        /* reset exceptions don't have ME set */
+        new_msr &= ~((target_ulong)1 << MSR_ME);
+        break;
+    default:
+        cpu_abort(env_cpu(env), "Invalid PPE42 exception %d. Aborting\n",
+                  excp);
+        break;
+    }
+
+    env->spr[SPR_SRR0] = env->nip;
+    env->spr[SPR_SRR1] = msr;
+
+    vector = env->excp_vectors[excp];
+    if (vector == (target_ulong)-1ULL) {
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
+    }
+    vector |= env->spr[SPR_PPE42_IVPR];
+
+    if (excp == POWERPC_EXCP_MCHECK) {
+        /* Also set the Machine Check Status (MCS) */
+        env->spr[SPR_PPE42_ISR] &= ~R_PPE42_ISR_MCS_MASK;
+        env->spr[SPR_PPE42_ISR] |= (mcs & R_PPE42_ISR_MCS_MASK);
+        env->spr[SPR_PPE42_ISR] &= ~((target_ulong)1 << PPE42_ISR_MFE);
+
+        /* Machine checks halt execution if MSR_ME is 0 */
+        powerpc_mcheck_checkstop(env);
+
+        /* machine check exceptions don't have ME set */
+        new_msr &= ~((target_ulong)1 << MSR_ME);
+    }
+
+    powerpc_set_excp_state(cpu, vector, new_msr);
+}
+
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
@@ -1589,6 +1708,9 @@ void powerpc_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_POWER11:
         powerpc_excp_books(cpu, excp);
         break;
+    case POWERPC_EXCP_PPE42:
+        powerpc_excp_ppe42(cpu, excp);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1945,6 +2067,43 @@ static int p9_next_unmasked_interrupt(CPUPPCState *env,
 }
 #endif /* TARGET_PPC64 */
 
+static int ppe42_next_unmasked_interrupt(CPUPPCState *env)
+{
+    bool async_deliver;
+
+    /* External reset */
+    if (env->pending_interrupts & PPC_INTERRUPT_RESET) {
+        return PPC_INTERRUPT_RESET;
+    }
+    /* Machine check exception */
+    if (env->pending_interrupts & PPC_INTERRUPT_MCK) {
+        return PPC_INTERRUPT_MCK;
+    }
+
+    async_deliver = FIELD_EX64(env->msr, MSR, EE);
+
+    if (async_deliver != 0) {
+        /* Watchdog timer */
+        if (env->pending_interrupts & PPC_INTERRUPT_WDT) {
+            return PPC_INTERRUPT_WDT;
+        }
+        /* External Interrupt */
+        if (env->pending_interrupts & PPC_INTERRUPT_EXT) {
+            return PPC_INTERRUPT_EXT;
+        }
+        /* Fixed interval timer */
+        if (env->pending_interrupts & PPC_INTERRUPT_FIT) {
+            return PPC_INTERRUPT_FIT;
+        }
+        /* Decrementer exception */
+        if (env->pending_interrupts & PPC_INTERRUPT_DECR) {
+            return PPC_INTERRUPT_DECR;
+        }
+    }
+
+    return 0;
+}
+
 static int ppc_next_unmasked_interrupt(CPUPPCState *env)
 {
     uint32_t pending_interrupts = env->pending_interrupts;
@@ -1970,6 +2129,10 @@ static int ppc_next_unmasked_interrupt(CPUPPCState *env)
     }
 #endif
 
+    if (env->excp_model == POWERPC_EXCP_PPE42) {
+        return ppe42_next_unmasked_interrupt(env);
+    }
+
     /* External reset */
     if (pending_interrupts & PPC_INTERRUPT_RESET) {
         return PPC_INTERRUPT_RESET;
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 7e5726871e..9953d73884 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -186,6 +186,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
     if (env->spr[SPR_LPCR] & LPCR_HR) {
         hflags |= 1 << HFLAGS_HR;
     }
+    if (unlikely(ppc_flags & POWERPC_FLAG_PPE42)) {
+        /* PPE42 has a single address space and no problem state */
+        msr = 0;
+    }
 
 #ifndef CONFIG_USER_ONLY
     if (!env->has_hv_mode || (msr & (1ull << MSR_HV))) {
@@ -306,9 +310,6 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
         value &= ~(1 << MSR_ME);
         value |= env->msr & (1 << MSR_ME);
     }
-    if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
-        cpu_interrupt_exittb(cs);
-    }
     if ((env->mmu_model == POWERPC_MMU_BOOKE ||
          env->mmu_model == POWERPC_MMU_BOOKE206) &&
         ((value ^ env->msr) & R_MSR_GS_MASK)) {
@@ -319,8 +320,14 @@ int hreg_store_msr(CPUPPCState *env, target_ulong value, int alter_hv)
         /* Swap temporary saved registers with GPRs */
         hreg_swap_gpr_tgpr(env);
     }
-    if (unlikely((value ^ env->msr) & R_MSR_EP_MASK)) {
-        env->excp_prefix = FIELD_EX64(value, MSR, EP) * 0xFFF00000;
+    /* PPE42 MSR has bits overlapping with others */
+    if (!(env->flags & POWERPC_FLAG_PPE42)) {
+        if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
+            cpu_interrupt_exittb(cs);
+        }
+        if (unlikely((value ^ env->msr) & R_MSR_EP_MASK)) {
+            env->excp_prefix = FIELD_EX64(value, MSR, EP) * 0xFFF00000;
+        }
     }
     /*
      * If PR=1 then EE, IR and DR must be 1
@@ -462,6 +469,17 @@ void register_generic_sprs(PowerPCCPU *cpu)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
                  0x00000000);
+
+    if (env->insns_flags2 & PPC2_PPE42) {
+        spr_register(env, SPR_PVR, "PVR",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, SPR_NOACCESS,
+                 pcc->pvr);
+
+        /* PPE42 doesn't support additional SPRG regs or timebase */
+        return;
+    }
+
     spr_register(env, SPR_SPRG1, "SPRG1",
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_write_generic,
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index f835be5156..edecfb8572 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -229,6 +229,18 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     case POWERPC_MMU_BOOKE206:
         env->spr[SPR_BOOKE_DEAR] = vaddr;
         break;
+    case POWERPC_MMU_REAL:
+        if (env->flags & POWERPC_FLAG_PPE42) {
+            env->spr[SPR_PPE42_EDR] = vaddr;
+            if (access_type == MMU_DATA_STORE) {
+                env->spr[SPR_PPE42_ISR] |= PPE42_ISR_ST;
+            } else {
+                env->spr[SPR_PPE42_ISR] &= ~PPE42_ISR_ST;
+            }
+        } else {
+            env->spr[SPR_DAR] = vaddr;
+        }
+        break;
     default:
         env->spr[SPR_DAR] = vaddr;
         break;
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 27f90c3cc5..fc817dab54 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4264,8 +4264,10 @@ static void gen_mtmsr(DisasContext *ctx)
         /* L=1 form only updates EE and RI */
         mask &= (1ULL << MSR_RI) | (1ULL << MSR_EE);
     } else {
-        /* mtmsr does not alter S, ME, or LE */
-        mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
+        if (likely(!(ctx->insns_flags2 & PPC2_PPE42))) {
+            /* mtmsr does not alter S, ME, or LE */
+            mask &= ~((1ULL << MSR_LE) | (1ULL << MSR_ME) | (1ULL << MSR_S));
+        }
 
         /*
          * XXX: we need to update nip before the store if we enter
-- 
2.43.0


