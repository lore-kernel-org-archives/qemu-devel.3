Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93048C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5b-00047k-0R; Thu, 08 May 2025 18:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5M-00042W-9v; Thu, 08 May 2025 18:51:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5K-0006SB-LO; Thu, 08 May 2025 18:51:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LgQr9031823;
 Thu, 8 May 2025 22:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=K123qVbR6FjP1+2vE
 tqc2MnLaQtxPFBSH4ICvILJ2bU=; b=qo1T40r6AH5ESc5cSgiolSx5Jd7HblzH/
 WZh8jqc8UGNGN8WpXjk9DHTdMdNkUFXKCcUonOfdLjHRILG1YMtOYZ1NoCYPQdjd
 N3JKaBFbtf583kBMDNikgkFMJluztXbWO7tr2q2MsQ9PbqhJKjItzU6MwwcbJIw/
 2+PNVAKiwX7yOP0VqjJ43Iu/N2udz936MG6CvJ/GXHY/XOYrNVVCKiBxhF1UUrI1
 uevreWVUKakRAcNNDRzv4BhS89Ft7OxcKtvsE5yNLhRYgyixPrYNF4sqzrONkLcA
 ZuuZ1bDKwGRjurv678s4sZ3cc6z+ryFy43flm6t7DYNIeIv/RMrgA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rw87xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548KgcIo004231;
 Thu, 8 May 2025 22:51:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2crf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MpINK31720150
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:18 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 298C258055;
 Thu,  8 May 2025 22:51:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2E3E5804B;
 Thu,  8 May 2025 22:51:16 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:16 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 05/25] s390x/diag: Refactor address validation check from
 diag308_parm_check
Date: Thu,  8 May 2025 18:50:21 -0400
Message-ID: <20250508225042.313672-6-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681d3568 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=130TwiEZxdn8fhqcL5YA:9
X-Proofpoint-GUID: neVzzL9R2TPF94WzB7-LMbPD6lNp-YCT
X-Proofpoint-ORIG-GUID: neVzzL9R2TPF94WzB7-LMbPD6lNp-YCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX3XzSaD2rqegE
 kD+RkHntlOTwwn6JkRLBmwM6rPLJJoBAt1RvBOJaOjCNl3GcLt8UvhmI5rxJ88cZcxPkARyn6JJ
 ZZ94QUuV56n0xg0zdiRC7IlDEcXf+vpcJHeQ/8Jv+agULeKiZHGQesH9n9HX33vUS6F/RgfJer0
 VLsMZWF5Hegn4d8jv640686w3kyjYJ+7Trjqc/WgC1Ya1GmXCRneLr77S285nEvHEQgaO3mMI5/
 YvR5EjhRZ0Jez98Ln3ZO7Y02ke88ohC9h8dCn6IE0WFfQBECGfMruMG/wUJCbYDQBOLQgxXGESC
 kq5lZMpVDcTVCyn2tpBU6RtAf1bW2bBhSFLVIhWVgwNY9gSAmNvbd7tXpPVO4U5G9YphnePyW6V
 Whs/d/qY9yWgXC2gXQtOcAuzUO525GxhvWEhOlsbCdcl4yJqfvQ9BgP2XjhbwKfdjGuTuJjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=823 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a function to validate the address parameter of DIAGNOSE.

Refactor the function for reuse in the next patch, which allows address
validation in read or write operation of DIAGNOSE.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.h      | 6 ++++++
 target/s390x/diag.c | 4 +---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index d9c089928e..254cf6a46a 100644
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
index 21129dbc91..9d249831b3 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -64,9 +64,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
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


