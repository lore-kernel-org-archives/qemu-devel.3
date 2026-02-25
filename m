Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF59EFD207
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9yp-0007fQ-R0; Wed, 25 Feb 2026 03:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vv9yi-0007f4-9u; Wed, 25 Feb 2026 03:10:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vv9yg-0001WP-Hg; Wed, 25 Feb 2026 03:10:40 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61OKHSkn2615756; Wed, 25 Feb 2026 08:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=8wwEFJ8VpyDDqnS/ord2au6YQrydNb81+Zw7+hIB5
 84=; b=U2ij4mVt4kqqjUIgwE++V16lDpYHBcJQMhEYl8+yRraBCB+RXtvK+8vVS
 7aeoQ/CKtx6JIHVbQlp7RAthQloPcZkRN+346X+Jm3gKftjs/mKnVOfnt6OypeAH
 qZ9p3xrduG93fVWkeQR1rxeVEIveqkiX8dzmvC4OQlHe4ih+35a4/o02NiMESUra
 PBYUiFuhww66ERUXMexzc/GGXuQomtgc5lWgS2Sh9LJzWUCN/Z4rv4n1DflOSguP
 BzCMDyOvr3DhKB7fMx/oPtDd+Zo02wjCbEIGACf8TIYPbF9etS8o9YRlj9o5cVMw
 wgVqttFOzAKTLp7bieSMlru+mfKxQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf471yb7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 08:10:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61P7nmda015750;
 Wed, 25 Feb 2026 08:10:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1smja9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 08:10:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61P8AU2X46268684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 08:10:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E8BE20043;
 Wed, 25 Feb 2026 08:10:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFA9F2004D;
 Wed, 25 Feb 2026 08:10:27 +0000 (GMT)
Received: from shivang.com (unknown [9.39.31.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 08:10:27 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, adityag@linux.ibm.com, milesg@linux.ibm.com,
 qemu-devel@nongnu.org, Shivang Upadhyay <shivangu@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH] ppc/pnv: fix dumpdtb option
Date: Wed, 25 Feb 2026 13:40:37 +0530
Message-ID: <20260225081037.21990-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9Xz2GNg-ZkwQ27ZKJT5PgUjcYezOL_G7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA3OSBTYWx0ZWRfX/XJeo06qzCOu
 CT3eDQV7vs3mzsUO7vteuhO8QFhp1RchJ+KyFep5oMsUoETBcfbioRpOLmA7heCn143oqT7gYTX
 qwiBfTFJleUpPilmbdJr6KDd05vyll1SJTFUETRKnyY1PFfeNbiZe8lu1Y6W3/GkB6lCrddIim/
 EkKh4MZYvY0jxPDIr95Z76Fo48j3luEpQrZIs1PLgSxIw/7aXgVJ5efwGiVfIfVYAKYktXCGqZQ
 FL6Q1bHtZi0W7wUkON/CCgeot6U+fwX+oE/TaGRrO4Aep1hH92hiixCYvOU0pAF2bzbnPW/qiaa
 5Ar7Kb1Uxf2lCpyzlgXqdS/hcN1peEX3AeqYruQkVAm5l6wNkFIkYqiAIFOOyDEKW3hRXSsWgbj
 PiJ6i5I1cjrMgEuLpQNFAf/j7iHW29PZxhoUizud5vhj3tvG1OWNq6IJTBUyTbavFX/5AMDKDcE
 /3LKnXAtFWJZOxMtWwA==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699eae7b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=Zd13O3uLRLaom6fN6REA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: HOC0fTSEINE06bNluFkr9-od9B1nn5I5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250079
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

The '-machine dumpdtb' command line option stopped working on
PowerPC/pnv systems after recent design change [1].

Fixing this by generating fdt blob in `pnv_init`.

[1] https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.maydell@linaro.org/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 hw/ppc/pnv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1513575b8f..9861714ad5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1261,6 +1261,10 @@ static void pnv_init(MachineState *machine)
     if (pmc->i2c_init) {
         pmc->i2c_init(pnv);
     }
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+    }
 }
 
 /*
-- 
2.52.0


