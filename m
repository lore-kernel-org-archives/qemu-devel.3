Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B955CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbugC-00007r-CX; Tue, 23 Jun 2026 02:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wbugA-00007c-Iq; Tue, 23 Jun 2026 02:32:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wbug8-0006eD-RL; Tue, 23 Jun 2026 02:32:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N0mNm6408278; Tue, 23 Jun 2026 06:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ucU9Rb92tL5uSUoZ3qLzdeyB3F708Lcvhe0qrKFT6
 cM=; b=QgIhvWXDXRs+f5S6Xuv/B43exZrCVkhbQ5Uz1/BdtAHvDdhndCyTKySqW
 No997U9KBgVi9ls7fpYB00QAjMxHDUFpR+NN9at9Bo18BPbahoCpovK/wtPAiPvw
 TOZACkvYH0rgw+93piB6/ixZnN/xuiAqeDZvN1zJfQvqV1sQuETIZUgQsiCgRU2Y
 7l9Wof2EruDIoS4OwJHgUdVfe0FEEJ48p8abzaxCwb29fsON76Ww759iZSqpqFTZ
 sSBbdKI8O1V2m23ij4ihHc7Up0LPQJTu0ooYSxIEVTTrxMG1iNIxVj8kjOVPY+ma
 D61OeeJolE6GuIGO0b3Iy8jzOgz+Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3d12e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:32:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N6Ji32029989;
 Tue, 23 Jun 2026 06:32:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6ph9trd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:32:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N6W3KF29950264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 06:32:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A42B20040;
 Tue, 23 Jun 2026 06:32:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C7C82004B;
 Tue, 23 Jun 2026 06:32:01 +0000 (GMT)
Received: from shivang.com (unknown [9.124.222.24])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 06:32:00 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 0/2] ppc/pnv: fixing external dtb
Date: Tue, 23 Jun 2026 12:01:54 +0530
Message-ID: <20260623063156.1110370-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a2869 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ufWLgvX7MhiIfYz792EA:9 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfXy6zSmtsm8HEU
 LHWk4l4M531G+b8Y59Hee5/eVppZe51Ogbn+CJysdIOsED5uwobakusdIgs1bqSiiM9bPSJEfid
 L8Qs+ZjN1oS8UsR6P9TTH1QzSV++pzA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX0XlVzJZg67Mt
 q7fokBZdTjqRDEP00uXfZn8yxF25iPx9piFnOXmnGo+gzKMzEeRBsYwlsY0eOdJMhbERFdr7oZk
 M/cS1Qg1UVAJaWi+vICLkFnFDyxgmuWvprSS8O+pEalPL6odZya73DxbDJ7FPjvj9t3OLuKu6RZ
 rKjo7WWiE+z2gCrbr8faXBfSm9UYbMypezZ9WODWamoVS+287nhfQGC0zdCwZKDOGcBjAsUrRj6
 EBYDU30dtcjQrZ+rwTkYz+AJxJkNULopMLu4Yv4KG1D1Jd46oq9uodfl2Z7YxFbjdOiOJsIv1NF
 ldNXuvCN2mOQKOLwDjwFbK6zVasK4MybUx1ZMjuvdBVvODMsaE7s/dkEsdtdj3YpoJ2/jq757d1
 3I3JDmJnjDI0nl8tcjeBLikqTGor32HMMR/ZQEzhDkTELax8dSEMSs3soF/GJfOLpqSJP+ZYySJ
 tsDnCNbIgLYLDw/d7bA==
X-Proofpoint-ORIG-GUID: xDsNtROXZtAjTg0Dn8GQhHnh6cI3dcGl
X-Proofpoint-GUID: yM1l_OtreHvBjtCMgDAoctAmYmGQQm19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230048
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Currently powerpc pnv machines doesnt respect `-dtb`
argument passed from outside. During cpu start content of
machine->fdt is overwritten by `pnv_dt_create`.

This was previously found and fixed, during the discussion
for dumpdtb issue [1]. But reintroduced in MPIPL support
[2]. Saddly it skipped in the review phase [3].

Adding a functional test for checking the external dtb case
in powernv11.

[1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/
[2] https://lore.kernel.org/qemu-devel/20260310124619.3909045-8-adityag@linux.ibm.com/
[3] https://lore.kernel.org/qemu-devel/abAmBV7g_bGNw0Ax@shivang.upadyay/

Shivang Upadhyay (2):
  ppc/pnv: avoid regenerating DTB if external DTB is present
  ppc/pnv: add test to verify external DTB is honored

 hw/ppc/pnv.c                           | 10 ++++++++--
 tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.54.0


