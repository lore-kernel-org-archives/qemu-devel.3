Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C010FC8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur8m8-0002U1-VQ; Wed, 27 Aug 2025 01:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ur8m6-0002T4-Np; Wed, 27 Aug 2025 01:32:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ur8m0-0005ii-5N; Wed, 27 Aug 2025 01:32:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QJ5EWL006358;
 Wed, 27 Aug 2025 05:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=78aJeJWqPy0WZtxtDFmgX5Jc6tj8qXF6Cwr+63gdl
 QI=; b=B3j6G3TWGD2XRMJIvEiHZqq2+Xz+r+h/aGZzHHoVkFwO1FwC/VQsdjToL
 A+dVm8L1pXBzqf8ZUQlXl0RdlLv/dT5cFZmYcqkF8Su7VkYvgxkh3UDhUl8vJP5P
 SH1wqtxExfxTB5E9G3l6rCkOaks/04F+dl6Cbw/0dF37KNVyZ5fWhr83VICu7//N
 zdiAJ4qVj5UDpK7cHnGUJq+NRzDp2nrj9giX/TcU1qfM1gqukZOxYVu7pXyTiXYC
 DkjBM+LgYJEdrsXW2rZRPP9g98yWtU9IT9ZsTjLRF4okb/NXfuVtbF58p/v4tcrr
 OzJpP/xKvauIaOPoLKCFOD2Kiw5lQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hq298j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 05:32:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57R2o4P1020838;
 Wed, 27 Aug 2025 05:32:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrc0pkkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 05:32:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57R5WUv545744602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 05:32:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 431E820043;
 Wed, 27 Aug 2025 05:32:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2463A20040;
 Wed, 27 Aug 2025 05:32:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.214.234])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Aug 2025 05:32:28 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH] docs: fix typo in xive doc
Date: Wed, 27 Aug 2025 11:02:28 +0530
Message-ID: <20250827053228.519707-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXzqkRm7hN5XBD
 MiAG69fzDu6/WEqYY6JeJOnRWV6RnX61NToSAZkydkg4tUqiJMmpyrNEROB33TLxZJvbn33v6mT
 nFyR6rzCbXrp0Emaf9hxIh4XLkTQaI+PYEVDV1Zng7/+VaYy86lRbOSq5Xsz1gmHb8MCk3dE3mN
 s8e/9QDKFrrEloMhP0RrMA0KFyDS/zrYpLdDRifGfvF3H52qTxt0GH0HAPiH5qp6eq61/UcUwAu
 dVS8Cacjjpge2z1dNqBz7abM8+DBxT0suMj25dawuV2Aw3fVXfYfH/WvXdoYXZqZi9A8Vq/10t3
 TmEOtJ9+8qrdorwsyXmXEuDccuvWIJAdiItro9c3r5t+bmR1LmWHNYnl2sZyz07JagahDnnmM9Z
 np2ZNN0D
X-Proofpoint-ORIG-GUID: uIIAcTm4KvF_8HkynvPL2l5wYjqqK5iO
X-Proofpoint-GUID: uIIAcTm4KvF_8HkynvPL2l5wYjqqK5iO
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68ae9872 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=Ag8-cTVUF9tB8l3BjPcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

"Interrupt Pending Buffer" IPB, which got written as IBP due to typo.

The "IPB" register is also mentioned in same doc multiple times.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/specs/ppc-xive.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
index 83d43f658b90..968cc760d466 100644
--- a/docs/specs/ppc-xive.rst
+++ b/docs/specs/ppc-xive.rst
@@ -157,7 +157,7 @@ Interrupt flow from an O/S perspective
 
 After an event data has been enqueued in the O/S Event Queue, the IVPE
 raises the bit corresponding to the priority of the pending interrupt
-in the register IBP (Interrupt Pending Buffer) to indicate that an
+in the register IPB (Interrupt Pending Buffer) to indicate that an
 event is pending in one of the 8 priority queues. The Pending
 Interrupt Priority Register (PIPR) is also updated using the IPB. This
 register represent the priority of the most favored pending
-- 
2.50.1


