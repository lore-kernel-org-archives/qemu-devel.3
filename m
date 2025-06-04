Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D54FC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw77-0002gE-G3; Wed, 04 Jun 2025 17:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6y-0002dg-1C; Wed, 04 Jun 2025 17:57:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6v-0006x7-FI; Wed, 04 Jun 2025 17:57:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554EQqUc020207;
 Wed, 4 Jun 2025 21:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fJYSbVjfrWwKL0XxE
 eJzaB+6MNq/r1DKi+Jxwu58uxk=; b=AOrYwmV+v0wAgfzyGj+mIjxtJ1UjUMi6H
 UnCYVFTjuap7SFdo6pOOq3NvMTL2v7efgKoCinIpmlYwwSLSfwAJCDJbnzvcSHZN
 IPcBUXGKt9lUKCLwXr+Fu0Mxv7ILO62oRfhMvBwIkmwXaVRYGfhbOVsh9CPvLFC1
 5qNSQAbbf55nVPnuNlQGgtGgrNSqE4owz83FKg2S2SMolcoXi9VOB9/7AdcCb+O6
 PAJUF5PQKecVosDVLnGO7kpNAgMezlMGw3eoj0smxJiHaGggw/kSlXynzj9x5PfM
 /cyoh1/gcZMro+fWejC3jvlpGqshXx/SoyvQG06NVb2kMuwp0ISZw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf0d61n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JC0lw019937;
 Wed, 4 Jun 2025 21:57:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p1urg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvKgS60162514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66EB558050;
 Wed,  4 Jun 2025 21:57:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0C0B58045;
 Wed,  4 Jun 2025 21:57:18 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:18 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 06/28] s390x/diag: Refactor address validation check from
 diag308_parm_check
Date: Wed,  4 Jun 2025 17:56:34 -0400
Message-ID: <20250604215657.528142-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 93KiqRDgdrrKG43FLhXzfSkf9fHl4WCz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX30T4lPLAZvoR
 OVfaVzo6f/nlszpUE1of0VIwpMgMXW6eWcodmplWpBgNJ7f9VJgcVmywP3Wc4+mvt970hzQYf1Z
 e/r7hfZ/55Oidy+5gjfXy9nfibE3ashirsvqa7XHRtX2iO2ITO7xkJtJk5VU6UpK0D67Ns9NwID
 hTNvut6+J0ARf97d655NvcyAt9/LfH/fbkr3kZgLbGbVoezsD5BW4FcmJrDfF8Ischpf6vYqLVG
 NUaJo3yshJYESFzbIMhaLXst/J49SMOUlqfK1WTVQNRgi5fJ8+xowHixy4L8tMGUMtyuPnPNsrM
 hPN1hpNZOGf7whMLNfAL/nychE3aQ8Vj4/hd9qVYz10zuBnnMFG7BdVox0kTDOq42kwl45iEakK
 UVeaz0LM5W171DLy3WeQi0L8213w4F/+tFKqlYsMBV4VnSYDxGd+Xz9vq8TyOEq+0KLO7Blv
X-Proofpoint-ORIG-GUID: 93KiqRDgdrrKG43FLhXzfSkf9fHl4WCz
X-Authority-Analysis: v=2.4 cv=c+WrQQ9l c=1 sm=1 tr=0 ts=6840c142 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=130TwiEZxdn8fhqcL5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=824 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


