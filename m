Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282BDF513E7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHOV-000134-A4; Thu, 05 Mar 2026 17:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOT-00011j-NW; Thu, 05 Mar 2026 17:42:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOS-00075Q-5Y; Thu, 05 Mar 2026 17:42:09 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625GmcKw2434764; Thu, 5 Mar 2026 22:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7jCarr+WGbmHu+2Yi
 3YrMYGZaXdJCHOLAvclBahg01U=; b=CSWwUxrccw0VfVF/jX1KBLLFH9oI5fPyB
 R0v0eEorzIqPcdrQ8hV1krJ12/PmzxVT2xL+6/FGza2b6idVxoqRoQkUyP3AleQY
 133zrJB7/yjqadGNx1ivu/dDn8Bse6mdehtOL01m9+nNwPTHSyuJhU+0eboyb26W
 miOKV0+vp9f+guk8QJTyh51v/l2QEXyIn6YngxQKeQtxt9mP8LHWTlCPtWYsFZhh
 NZDY1+/Tcs2RJa7srXcvydi0kSqCvQ+8dX8sfcsqCobglw7lVjFhcAU7X2CB2WHB
 hbIV+V/wVg9sv0fUDq0AAZfXRkju+y53GsyV+eZMUrVYDvLcR+c4Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrje0p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625LU93E028922;
 Thu, 5 Mar 2026 22:42:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsdh8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625Mg0Dr61931828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:42:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B339E58061;
 Thu,  5 Mar 2026 22:42:00 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86B1558057;
 Thu,  5 Mar 2026 22:41:59 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.36.214])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:41:59 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v9 06/30] s390x/diag: Refactor address validation check from
 diag308_parm_check
Date: Thu,  5 Mar 2026 17:41:21 -0500
Message-ID: <20260305224146.664053-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224146.664053-1-zycai@linux.ibm.com>
References: <20260305224146.664053-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69aa06bb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=130TwiEZxdn8fhqcL5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5NCBTYWx0ZWRfX60ljRJDZjdGh
 D/kaPJkL6cCB/lqSwdfrnkrfCEwrP+vXCv6YeeUDYFx80iFgcydesRt0SpyqG1bZvpVW2ea/N2p
 5qwnMRh8VEXSbyo6E+mcTmRWQJkfoAnE2Q6UYa15GSqBsesBCGnUaslwpNyDQBhYJsFEbokxMMd
 MuLKWMhYgmznk7yQWj6Ra3pP0dvjDWOREHV42ZtKYYj+r/ct1S6sehQnGmoPDlLl2m7hAc/Dozv
 Pgh58iLJU7aQhQRFJlJ0iZgflnILvJ+5GuM70VLaHGDM8YZ8j9Gbsbir7k+EMDzFxjV7072b9dr
 iCP215gBIx2VdOm8Bs2SLDb4yjxDpb3h/aDMVksRpZ5or9Um2W4Fzk3JgojJYcI5wU7xAs5aJBR
 TrzfU56NSZZ2K8nVUWPLFs4VdRWXji9Ola/QsexspYwxnYf8AggzfIS/ZK0fUZ+bzhoMypw5EVc
 2dGTYDiapNtonDBBrag==
X-Proofpoint-GUID: M1CaxduSBdOOlv_Jb8ddcR0aSoS2ttxR
X-Proofpoint-ORIG-GUID: M1CaxduSBdOOlv_Jb8ddcR0aSoS2ttxR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 6373544bb2..8ab40437a2 100644
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
2.53.0


