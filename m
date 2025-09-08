Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7FECAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 20:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvi3M-0001lh-Qg; Mon, 08 Sep 2025 16:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3K-0001l8-EB; Mon, 08 Sep 2025 16:01:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3G-0006qq-SD; Mon, 08 Sep 2025 16:01:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588Fqqxj018799;
 Mon, 8 Sep 2025 20:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RQtxonTOjRwPC9RPC
 w19uNdTlo87v2Np4J9qhVBWPyY=; b=lYs4zV/u1Nf2l4oe1imPa1UQSVVXjTSz2
 mhJBayWAlCZNltyYdcUIHXsXJT2+qK27tI9VPk3qhsOohmUqO8VWJBZAiYy3fsnm
 K/XOJ5KTXSpnxEz9hdcFPEynyIalZacf7UKlpgbpSNqCefth1ZwRo/0xmurgeyqB
 Wwijm2uCbKoXHX+ZaECAC2plty9CtDeanAQZCMT3iWN3cgFCEu/UUd5XuhQDHic2
 dfxGTE4E/Z/WP4mNadT1NPecfuEgjALbMYHffkEnznlxNogpjbTIwHPT4nMFN2xE
 Cggtj0rXenCA1E3xBmP1DA/elarqmLnEd/k6k8Z4wwsB6tA51TZhA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwkn4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588Jsbmf024589;
 Mon, 8 Sep 2025 20:01:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwkn4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588H5fnY010594;
 Mon, 8 Sep 2025 20:01:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smqnfa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 588K1EGv23134866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Sep 2025 20:01:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 922DA5805D;
 Mon,  8 Sep 2025 20:01:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C44935805B;
 Mon,  8 Sep 2025 20:01:13 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Sep 2025 20:01:13 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v3 1/9] target/ppc: IBM PPE42 general regs and flags
Date: Mon,  8 Sep 2025 15:00:11 -0500
Message-ID: <20250908200028.115789-2-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908200028.115789-1-milesg@linux.ibm.com>
References: <20250908200028.115789-1-milesg@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RpSFy1WWXHUeupbhXw8y5V345ZhGK2GA
X-Proofpoint-ORIG-GUID: ehoxSyENBwdVF9thY2pIZhvuj3zLeyf_
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bf360e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=KjnWNliXgB7EaSLBB8sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxi0ECsInUwVu
 Yxn1EFcPw6FhDr9uML3SBtYBwfvphMdZvtzCkvBypUcj4FMky64WjiyfI6TNcn38s4O3PGTCBMt
 5Nq3lxqmUkNqMir40icOD4Rl/O+9tPBvhfXyDRSU9NYPlovKHp9ID1I1LGytWUuhQWXbdHNKEGb
 iJ4s+uAAg+TcxsRskcA/XhIxmL3U7FJ8oK/KVVsMcIxYftXqG+LeaCwHodwVCc+T5wwv2/c2+mY
 gtNLuNQsUvffAl49jjFyATKura8RdnvBsbAcvUJTiX/IihjdrD3dw6S92YyDup8ih/00QgTgwjn
 ab3x47VeoC5yG+jOxf5S9WVI5LZ5pUQ7sQ6YIH3WYTd92HLyTL5P6Hah9kXF3AntfADubHTaNDg
 oxkCia+4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
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

Introduces general IBM PPE42 processor register definitions
and flags.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---

Changes from v2:
  - Split general registers and flags from v2 patch 1

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
index 6b90543811..81a0e16641 100644
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
@@ -1750,9 +1782,12 @@ void ppc_compat_add_property(Object *obj, const char *name,
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
@@ -1818,6 +1853,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_TBU40             (0x11E)
 #define SPR_SVR               (0x11E)
 #define SPR_BOOKE_PIR         (0x11E)
+#define SPR_PPE42_PIR         (0x11E)
 #define SPR_PVR               (0x11F)
 #define SPR_HSPRG0            (0x130)
 #define SPR_BOOKE_DBSR        (0x130)
@@ -1827,6 +1863,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_BOOKE_EPCR        (0x133)
 #define SPR_SPURR             (0x134)
 #define SPR_BOOKE_DBCR0       (0x134)
+#define SPR_PPE42_DBCR        (0x134)
 #define SPR_IBCR              (0x135)
 #define SPR_PURR              (0x135)
 #define SPR_BOOKE_DBCR1       (0x135)
@@ -1844,6 +1881,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_HSRR1             (0x13B)
 #define SPR_BOOKE_IAC4        (0x13B)
 #define SPR_BOOKE_DAC1        (0x13C)
+#define SPR_PPE42_DACR        (0x13C)
 #define SPR_MMCRH             (0x13C)
 #define SPR_DABR2             (0x13D)
 #define SPR_BOOKE_DAC2        (0x13D)
@@ -1853,12 +1891,14 @@ void ppc_compat_add_property(Object *obj, const char *name,
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
@@ -2528,6 +2568,12 @@ enum {
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
@@ -2537,7 +2583,8 @@ enum {
                         PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
                         PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
                         PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
-                        PPC2_BCDA_ISA206)
+                        PPC2_BCDA_ISA206 | PPC2_PPE42 | PPC2_PPE42X | \
+                        PPC2_PPE42XM)
 };
 
 /*****************************************************************************/
-- 
2.43.0


