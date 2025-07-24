Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591E9C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepZV-0003vv-5q; Thu, 24 Jul 2025 02:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZO-0003uC-2z; Thu, 24 Jul 2025 02:36:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uepZL-0007Nk-L6; Thu, 24 Jul 2025 02:36:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O2YRBu004577;
 Thu, 24 Jul 2025 06:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=n7XbFDFhwYbvpEOzP
 JQqvr8n+k3RG4rXQYUE6l7nV9I=; b=LUYy30yjh5Dg4PZnY8pE0XMLREIJn9Tiz
 DqxJ24uuuDahuK9ZzxOkjwR5SZV/W7zHy14cP0sxYI+18SDH9OqnX1vMj0gsmVox
 5T9T2QLtqxp6vuFLE4oHNlmx09IPOQ3Nr7By2GCIYnrNnoaneRlkykWF43EfA3AJ
 UprD5rvcbx2AMTM3QaFH1w41NheesaqNi7gkNfBrlKKRHe+7HHUpM9H9Lm+IQ2Jy
 VwOChAb4TTA1lNy1OXdbWg4eKM8fEZofB9MHkqTLu6HSAJr6eavmcRKYjTa2LXU1
 bhfHmnvcivPsc6U7cmNeyObPdbbD4Ye/oj+Xe/mU5jLBmCzqhKLUg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff50y4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:41 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56O6afZK027111;
 Thu, 24 Jul 2025 06:36:41 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff50y4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6HBVY005470;
 Thu, 24 Jul 2025 06:36:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 480tvr2f2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jul 2025 06:36:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56O6aalL55640406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jul 2025 06:36:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0A8F2004D;
 Thu, 24 Jul 2025 06:36:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C328820040;
 Thu, 24 Jul 2025 06:36:34 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Jul 2025 06:36:34 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 clg@redhat.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
Subject: [PATCH 1/5] MAINTAINERS: Adding myself as a co-maintainer for
 ppc/spapr
Date: Thu, 24 Jul 2025 12:06:06 +0530
Message-ID: <20250724063623.3038984-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724063623.3038984-1-harshpb@linux.ibm.com>
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z20eXCuXI07bnmPVWS-JMAUnVXuSkUvl
X-Proofpoint-ORIG-GUID: zZytU0D4eIvB_MHbxV0ZbQOy6B29e3YO
X-Authority-Analysis: v=2.4 cv=Ae2xH2XG c=1 sm=1 tr=0 ts=6881d479 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Wb1JkmetP80A:10 a=f7IdgyKtn90A:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=69wJf7TsAAAA:8 a=r9MvvrW2hgB5ZokijoUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA0MCBTYWx0ZWRfX/cLpkZcIUhZK
 ntscwEsXrUyr+LAxS/4MLDsS0gAWGHkCFazRAh/RxQx6E4rxZVWwI1muS+WlisvhrYbUqvUA0FR
 VzD55vFFo4d0xPBR5nEdU8m4YFFl+g3tU0WTyc/5bBRCZqrmHIJ5B21TF+TeY1bbRy+F2NpcqPb
 WLBHvyhF9f6cfwJmpIAobGQzC8/SmdMPa4K41sdJYnSJDt5IdBTF5HwSHoCP1+VJESLOqf6WRvb
 AT/prmuMWQuogeI/tpEjegDdY3wLeDsPsd0fvfUgKb2Vtw7m7RjnwooGog22ma4By5x5ST+JQ2/
 g1yuYQ3zz4AFHdmnav+TyIiC4foVcDugcFvjucGc9FMhHxinxxhkslYrlgfDMayZC5G+RCxKvAL
 OHTttwE5/i7tZZjeHYPle1dIA+l+HjAuOgk43idYx60nbg5NGxcHlgDI+MFxx0gMYc43CGHL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=608 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Have been contributing in ppc/spapr and related areas for quite some
time as a contributor and reviewer. I think its time to step up as a
co-maintainer to help with maintainer activities.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a462345618..afc94e6e67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1550,6 +1550,7 @@ F: tests/functional/test_ppc_40p.py
 
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
+M: Harsh Prateek Bora <harshpb@linux.ibm.com>
 R: Daniel Henrique Barboza <danielhb413@gmail.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.43.5


