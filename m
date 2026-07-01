Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45993C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1sY-0003E8-UB; Wed, 01 Jul 2026 16:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1sW-0003Ct-E2; Wed, 01 Jul 2026 16:49:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wf1sU-0003yb-Sl; Wed, 01 Jul 2026 16:49:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661Gmx4N1456533; Wed, 1 Jul 2026 20:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=k8tvPzrQo6/t7WcdV
 eAWkNdKQiKyShsjewFS2iwPC9A=; b=TKn0vIqS7aYzJT2bDlliW8U82Xwhr7NNO
 ZTDNAkDQfHxJYtKVk58ixh2d5F2ThImTQmGxorwTJlh1L0naMqR0S8bT5iMjIIR3
 SBd/mRIuZbWXkx5IRzOkc2pi9XRAc9NEf95hw3+2+k1j3lmj354FT7/NIbTb5Du0
 LkrVCmxYMsF+IZcwf2WJd126yGAesWtzXi+/zzUgr63Ofh6FOpw/nEKlwlEYfHXX
 zWudkNQLZNrkvTChvHdyloi/QRLzvaa5HfS0UQimJXI/ZfYTWV5UZ6HsjoOz8Z/1
 IFH96lHgHaofglLutN3ThvfpByOsz4V0cbG+1I+TqBt1QlPeLw64w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe6q0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:49:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661Knakw030801;
 Wed, 1 Jul 2026 20:49:46 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ggxqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 20:49:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 661Knj2U13763180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 20:49:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 111205804E;
 Wed,  1 Jul 2026 20:49:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5809D5803F;
 Wed,  1 Jul 2026 20:49:42 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.149.234])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 20:49:42 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v12 06/35] s390x/diag: Refactor address validation check from
 diag308_parm_check
Date: Wed,  1 Jul 2026 16:48:52 -0400
Message-ID: <20260701204922.1320349-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701204922.1320349-1-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rCqUSbGtnx-FfMu4BYKGtDT3rCtRRQSq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX+rFjDt6Jjv95
 DjSypHgRGZCH/C1xepoi4+4Mz+M0iq7t9wydhhQmJKOIZNY/LK98CencnWjjqtw8i5C8t0UPuII
 QiRVeSVO33O+mWmPWLV2ikxH+0s0MkI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a457d6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=130TwiEZxdn8fhqcL5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyMiBTYWx0ZWRfX2+GXixHUvfAd
 0oAOv0rqiL9jLPYsliqeftRvPo2XC+rddGZhCVmpPzLQZ7fFYM7BLrtORSM9jROqH3j+EfUHNOZ
 DX7EM1fwzOn3Dp8vFKxd4CTJnt3tsc0u07JN9ETwmrggUCponhnK/UwwoXKfU4NfutDlt5C9E8Z
 cJOoJGq3wVlEW8CZ4mctRlSSRAlpZwdxoCf0qJVkme2r9PG0r0dfcswekjLdxRoZ0u/ste8TtDe
 LLifAZZWBtaqSwttygwgCCbdCiapvSg+EFrpGM+EzVm+tfCmccN956QAzItZ2+DWnQI0I0sPSg6
 uaGB4hyqxameW/UJ2rVb+Xst8t5RDvKlxUfo/8oRLusdGEIp30EW0ZHv/AYguqszi80NDVTg9/k
 cTVWGspdqv+nbsjDQgXG0PywukgxnquLWX28ZBxi1nTqnPVkWSXwgIQR+0Ym8i8fWaVuz2eds/1
 xeYFsN421XILjtKbqZA==
X-Proofpoint-ORIG-GUID: rCqUSbGtnx-FfMu4BYKGtDT3rCtRRQSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010222
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

Create a function to validate the address parameter of DIAGNOSE.

Refactor the function for reuse in the next patch, which allows address
validation in read or write operation of DIAGNOSE.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/diag.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 9131e8b1c9..9f98e4b677 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -26,6 +26,12 @@
 #include "qemu/error-report.h"
 
 
+static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
+{
+    return address_space_access_valid(&address_space_memory, addr,
+                                      size, write, MEMTXATTRS_UNSPECIFIED);
+}
+
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 {
     uint64_t func = env->regs[r1];
@@ -65,9 +71,7 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
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
2.54.0


