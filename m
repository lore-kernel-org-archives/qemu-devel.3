Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF997C83F21
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL1o-0000YW-Il; Fri, 11 Jul 2025 17:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1h-0000RS-QZ; Fri, 11 Jul 2025 17:11:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1f-0002oS-PB; Fri, 11 Jul 2025 17:11:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBUXV1009196;
 Fri, 11 Jul 2025 21:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fJYSbVjfrWwKL0XxE
 eJzaB+6MNq/r1DKi+Jxwu58uxk=; b=BKLcne8E1y9S7shk6x5FdoODhGDet95Mt
 9+Pmv42oMWeXS5mk/aGhp3l2wSWqt1QN1a5WCRMPEJlully/6fmJyQTl50KWTV4J
 WrraAA4Nm55KCsZCNnvXCia7Ysxy0alhPuj/s74nAYL7+F/gKF1aGlzBrYEPWTjX
 zx1Y69TYd3ADa0VIxY0bWSeM2EX/kCNEnbrjhnv8VeqsuzVHfUBpiMBdEqpLOPrX
 qEBhgJlKz95tZckN7YOJ806BuZXdIvf/WYweYoaY+YTw0AZ+ebGRLMODMsjfNzSk
 ze1nRymcbpvswLcQR1bFOnzPD3C3dEMqsey+tgV2QdJqFzbElspBw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47svb2db07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BK5QPK002888;
 Fri, 11 Jul 2025 21:11:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmvebr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBK5r60096926
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0237558059;
 Fri, 11 Jul 2025 21:11:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85F855805B;
 Fri, 11 Jul 2025 21:11:18 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:18 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 06/28] s390x/diag: Refactor address validation check from
 diag308_parm_check
Date: Fri, 11 Jul 2025 17:10:42 -0400
Message-ID: <20250711211105.439554-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfX7IK+a0oiNfcU
 iaxo4J+GxrMkdyWBKLMtlh19onaON7EeS5XJcZmjT+yAzTuVmluQ568fqk8xMIJ+crakqrJnF3C
 RZbv1XYDAlDnZtBv/ct3LqUry8pUELQ0mob/2exUUdKyLIiHuPlTwZjS6Hh1K+pPNNpdA2xbzJ1
 tI/OTaxu+3Cmio9Zx9v2U2GaHd+siI1hKE5ZqULsIEfXcUumfJPMndRQvpCtWWromrW1ApRmiAi
 f/Fz620qu19yTg1q7ywmKY08J3dBQtXuBDY1XKwqjt7TmQN26WUaHQskMFk9BZQg4WyciPrOncH
 nO/kcjqFkKEtMTn7ynUW+TDB4V3ZKaL6QVX3iHtezP79NOXH750vqW+FzaK7FaNfxoZCmDBnnzS
 x4bhmi0uPFgAnynDqYEJwUYGoo6E1IChQLFsVq3Ddpp3+QXWZ6xnP/c5R6xJxfcBTZdhgjcs
X-Authority-Analysis: v=2.4 cv=Y774sgeN c=1 sm=1 tr=0 ts=68717dfa cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=130TwiEZxdn8fhqcL5YA:9
X-Proofpoint-ORIG-GUID: W0yZKrCOrRpGk-OYs8C-o64alkD9L7QI
X-Proofpoint-GUID: W0yZKrCOrRpGk-OYs8C-o64alkD9L7QI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=812 mlxscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Create a function to validate the address parameter of DIAGNOSE.

Refactor the function for reuse in the next patch, which allows address
validation in read or write operation of DIAGNOSE.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.h      | 6 ++++++
 target/s390x/diag.c | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index bee72dfbb3..e26fc1cd6a 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -118,6 +118,12 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
 #define S390_IPLB_MIN_FCP_LEN 384
 #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
 
+static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
+{
+    return address_space_access_valid(&address_space_memory, addr,
+                                      size, write, MEMTXATTRS_UNSPECIFIED);
+}
+
 static inline bool iplb_valid_len(IplParameterBlock *iplb)
 {
     return be32_to_cpu(iplb->len) <= sizeof(IplParameterBlock);
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index d33c5daf38..7b9b47a171 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -65,9 +65,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return -1;
     }
-    if (!address_space_access_valid(&address_space_memory, addr,
-                                    sizeof(IplParameterBlock), write,
-                                    MEMTXATTRS_UNSPECIFIED)) {
+    if (!diag_parm_addr_valid(addr, sizeof(IplParameterBlock), write)) {
         s390_program_interrupt(env, PGM_ADDRESSING, ra);
         return -1;
     }
-- 
2.49.0


