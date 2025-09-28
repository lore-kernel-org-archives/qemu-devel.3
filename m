Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3I-0002kw-NI; Sun, 28 Sep 2025 15:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x3A-0002i2-Uy
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2y-00042W-ND
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:11 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH1cAF012149
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=M/IgocVQmqnivffpr
 MsyjnwuO6LtPsrNy0kfXzzvTNU=; b=qcuQMqAI7xhBWiutG1wR2Irxy46nDGb57
 TN1qqdZrro1fcskfYxl6DlbGw3q0Tyag/ViJzn/ys5yHx4bweJxMLou1FZzxCgLA
 H8vVwgBx7/suI4mzBH9+Em+iRM/j1OM7sydNqDkkQGaV4ry4UwhIEy7BOzMEk15D
 7zurbb9fpVp+HVjdq5l6N00ed9ZrP1uXYqzlnBDUbluc7rijgU03s8W5Ju1ShLxc
 5qJzvR/z0nJcj28vDCf2O6t96WQ5VNQXEGNPyw7bnTkacEk0PittHGuKbkNb0Brv
 aMF83iOGnUZRw/P6rPqhBccgf2fNnsWOPSzqNTOfIu+OEGMQ/N+5w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jw6err-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SH17KW020098
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49et8ru1a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 19:26:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQpBx25362812
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BEC220049;
 Sun, 28 Sep 2025 19:26:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 070E520040;
 Sun, 28 Sep 2025 19:26:50 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:49 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 09/27] target/ppc: IBM PPE42 general regs and flags
Date: Mon, 29 Sep 2025 00:56:11 +0530
Message-ID: <20250928192629.139822-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX7AmqsTLhQWsR
 06pnpq9g60HuS4KM9vxYw7TSmZVYYuuZf1yudHNnN59iLfNeiioB+aJHwaKds1gecr0ij7x8g67
 +CMzX5z1tygFiml3cGjMLNPWYJlPTBCXcOat1CQPy1j3gkm8fJO7OoQszvbbI13YiJthFuxL8Xr
 6pa9itnud5p9jXS8zW2CGc5fsvgs2ebEX7Bo6fPf9D4qK9a3gYU4H6zMd0urRjN3+UjFasNoGkg
 8aRcHPWMgFbK7ygHSUnXadLmfFIim+saKJxTYkpn8T6sgrjJ8H24k28p3MZDu/2yMmv0mS0dOeU
 H1VP6+ixMbzsEorQ/tuS4FLxXfACaAuASP55rblAWFAAUkGdMpUGgV7/sKuk8taiE9bsZPgQogZ
 Nbpw56EW1qX0oFRb2b/9A0eynZos0g==
X-Proofpoint-ORIG-GUID: 3GHno5kqHLQNUDx463T1BxeFZ04UvJ45
X-Proofpoint-GUID: 3GHno5kqHLQNUDx463T1BxeFZ04UvJ45
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68d98bff cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KjnWNliXgB7EaSLBB8sA:9 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

Introduces general IBM PPE42 processor register definitions
and flags.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925201758.652077-2-milesg@linux.ibm.com
Message-ID: <20250925201758.652077-2-milesg@linux.ibm.com>
---
 target/ppc/cpu-models.h |  4 ++++
 target/ppc/cpu.h        | 49 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

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
index 0e26e4343d..8e13ce41a9 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -282,6 +282,8 @@ typedef enum powerpc_input_t {
     PPC_FLAGS_INPUT_POWER9,
     /* Freescale RCPU bus               */
     PPC_FLAGS_INPUT_RCPU,
+    /* PPE42 bus                        */
+    PPC_FLAGS_INPUT_PPE42,
 } powerpc_input_t;
 
 #define PPC_INPUT(env) ((env)->bus_model)
@@ -433,39 +435,64 @@ typedef enum {
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
@@ -517,6 +544,9 @@ FIELD(MSR, PX, MSR_PX, 1)
 FIELD(MSR, PMM, MSR_PMM, 1)
 FIELD(MSR, RI, MSR_RI, 1)
 FIELD(MSR, LE, MSR_LE, 1)
+FIELD(MSR, SEM, MSR_SEM6, 7)
+FIELD(MSR, SIBRC, MSR_SIBRC2, 3)
+FIELD(MSR, SIBRCA, MSR_SIBRCA7, 8)
 
 /*
  * FE0 and FE1 bits are not side-by-side
@@ -785,6 +815,8 @@ enum {
     POWERPC_FLAG_SMT_1LPAR = 0x00800000,
     /* Has BHRB */
     POWERPC_FLAG_BHRB      = 0x01000000,
+    /* Use PPE42-specific behavior                                           */
+    POWERPC_FLAG_PPE42     = 0x02000000,
 };
 
 /*
@@ -1754,9 +1786,12 @@ void ppc_compat_add_property(Object *obj, const char *name,
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
@@ -1822,6 +1857,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_TBU40             (0x11E)
 #define SPR_SVR               (0x11E)
 #define SPR_BOOKE_PIR         (0x11E)
+#define SPR_PPE42_PIR         (0x11E)
 #define SPR_PVR               (0x11F)
 #define SPR_HSPRG0            (0x130)
 #define SPR_BOOKE_DBSR        (0x130)
@@ -1831,6 +1867,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_EPCR        (0x133)
 #define SPR_SPURR             (0x134)
 #define SPR_BOOKE_DBCR0       (0x134)
+#define SPR_PPE42_DBCR        (0x134)
 #define SPR_IBCR              (0x135)
 #define SPR_PURR              (0x135)
 #define SPR_BOOKE_DBCR1       (0x135)
@@ -1848,6 +1885,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HSRR1             (0x13B)
 #define SPR_BOOKE_IAC4        (0x13B)
 #define SPR_BOOKE_DAC1        (0x13C)
+#define SPR_PPE42_DACR        (0x13C)
 #define SPR_MMCRH             (0x13C)
 #define SPR_DABR2             (0x13D)
 #define SPR_BOOKE_DAC2        (0x13D)
@@ -1857,12 +1895,14 @@ void ppc_compat_add_property(Object *obj, const char *name,
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
@@ -2532,6 +2572,12 @@ enum {
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
@@ -2541,7 +2587,8 @@ enum {
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
-                        PPC2_BCDA_ISA206)
+                        PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
+                        PPC2_PPE42XM)
 };
 
 /*****************************************************************************/
-- 
2.43.5


