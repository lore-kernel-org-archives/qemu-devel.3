Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EC0C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocWK-0003Dw-B6; Tue, 28 Jul 2026 03:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wocWC-0003B9-QX; Tue, 28 Jul 2026 03:46:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wocWA-0001rY-0T; Tue, 28 Jul 2026 03:46:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3mmeH4141685; Tue, 28 Jul 2026 07:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=g1ENLmRvCgKk2dh9xqCGZjk5s05iDu7cRVarThxcu
 4M=; b=YfPbbu2ixlLDXG23AYLAA2PT4fnGe7VMbl0l5dvI3MtNMrx5OAoonJqyP
 0m4ABbDVAsK8uX/oeZHUTBVuX9otp7nz4bD+JXVf7cuXnaPsnACUY+AWut1xvU60
 aPlyfjyBIwVV7NCAlrw0QVUyNXmYFmLxopVo/WjrX6qI+Vp9nVBKiZSruxW5bJpy
 cjKzgfgtOtm7WX8Ljx70bx66gQnnEdsQrji/JeCtBJld7V0Dk+CDqCfRO005/Cdg
 e13QDyFWZ8NYh10rwz3qdRNtqca6Fm0wByuTR2h8YhDu6zNftR2mCv+XUeYrciPi
 CdpJrYJ54zKRDLYuTerZZ5pfvDlyQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xm32d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 07:46:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S7fFdb002602;
 Tue, 28 Jul 2026 07:46:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq8yxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 07:46:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66S7kIjH52363528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 07:46:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8A00200A0;
 Tue, 28 Jul 2026 07:46:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFA6120097;
 Tue, 28 Jul 2026 07:46:15 +0000 (GMT)
Received: from shivang.com (unknown [9.39.23.204])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 07:46:15 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: shivangu@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 thuth@redhat.com
Subject: [PATCH v3] tests/functional/ppc: skip remote interrupts test if -net
 user not built
Date: Tue, 28 Jul 2026 13:16:12 +0530
Message-ID: <20260728074612.42397-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: -s57jmVy6z24VXfUQEI0QC1EKf_HjrRX
X-Proofpoint-ORIG-GUID: 6CZRPURYYOs_WCbS_4OKH0URiBfYna-n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MiBTYWx0ZWRfX9YE198f+DCaf
 YJIIZP2N04Upzik9eLtrhniQ1JRj1tBFm40KzTRZolPOX0Cry6SjN97rEPcNWWgsJcIc7phjnO2
 40HJbVVWUCbHG5cY79mqlkD6JSoTrNk=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a685e4f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=_mrNEnGEA0-oycTHUFkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MiBTYWx0ZWRfXwbI7fHcGo5+S
 EUr/WsRbkrbX/XYV6j0KlUCaKswMLYrbnoCbZgjL88H48syDO3bRLHv6aP4Fhe4fEy45vcpEUhU
 fNUYTbLDQ3VBqCqxh0kZLtYqXT2sxyp8SXqP6gwsCINhLwZOfK1glJO1/7Q7/ApMF/FM+6Ci56X
 8Mi8zDvOHohfby0t9bQFYz/dEoSxbR97gwBIzZmzuDvAMd04oo+ZYM4pIlJJekhlshMHTDY/sas
 /SQg3WupkXn+V1AKP9Inbqe5Vy1OgxWDjER4HVisRtM+zh4ybWDKtrvNLwppxcOxD/ef94aNdVq
 mCoc6Qm5vaedpxfCfDVer8WjLQemtKYna9S3GYjo0+L5H7LWGfF7N9D6WfnrU+qOm5Lr80N2Yqo
 pkD2dpW/24wrEb/QWPpghRvsxmSosAZl+Yy9bTGDoOUzCZmBo/PgagHwaXWuh5ax87rgtEKzXEN
 9WO+s9ywR29/xbxyP0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280062
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

While running remote interrupts test, without libslirp-devel installed,
facing the following panic logs.

  File
    ...
    raise VMLaunchFailure(
    ...<3 lines>...
    ) from exc
    ...
        Output: qemu-system-ppc64: -netdev user,id=net0: network backend
'user' is not compiled into this binary

Adding netdev user requirement for this test.

Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Fixes: 63f5ba80921 ("tests/functional: tests/functional: Add remote interrupts test for PowerNV")
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---

Changelog:

v3:
  - rearranging the require_netdev, before set_machine. to keep all test requirements in same
    place, as suggested by Amit.
  - keeping review tags from Thomas and Amit.

v2: https://lore.kernel.org/qemu-devel/20260725174600.17683-1-shivangu@linux.ibm.com/
  - moved to require_netdev method, suggested by Amit and Thomas.
  
v1: https://lore.kernel.org/qemu-devel/20260724085440.520125-1-shivangu@linux.ibm.com/


---
 tests/functional/ppc64/test_powernv.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index bac2017e18..f3e05e4d38 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -90,6 +90,7 @@ def test_linux_smt_boot(self):
 
     def test_linux_remote_interrupts(self):
         self.require_accelerator("tcg")
+        self.require_netdev('user')
         self.set_machine('powernv')
 
         # Have below setup in this test:
-- 
2.54.0


