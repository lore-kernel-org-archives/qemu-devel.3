Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E8C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n13-0003wq-Ph; Wed, 16 Sep 2026 06:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x6n0u-0003nS-FL; Wed, 16 Sep 2026 06:37:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1x6n0s-0001jb-6x; Wed, 16 Sep 2026 06:37:16 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FLVqYk791655; Wed, 16 Sep 2026 10:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=u+H3DkdBtUxaF+rhr
 m3DezAyLe8fhl+QaVzZEetcwG8=; b=dnvpv6pJE1Fvf5aJxaZVC+IQRLmenEI4e
 Jq2iDV+s67i8RmTfDaL2xk29styJZnDGZmTWdP/mFeJ+eOjRcvMLIj95KsDootJV
 ALMwOUsbnuhXn3kJRqNxNSCjJaYRt7RzkBNIRJYL3BN///nbBReD2hH/Jo9t6RoW
 AxK4cEEiHJaWXiJfSMJt0ux2Us/nZxc/dFPKxLSHJSTIBCTvCMDID0oAR6iTTxNH
 TMA5gipZ0KoerGDeyemTmG9c/brhgEAHFOv3+XS0loarAXiqGd63ZKSPw+m+m+bM
 ADFxK10Ph7UQfvhfUXAAk+EtbIXm91aqWn/N4Fp4Fr8BvMMhIilCA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e3sjr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:37:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G7UjRM477719; Wed, 16 Sep 2026 10:37:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywewvah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 10:37:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GAb1ia23855788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 10:37:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 571C820043;
 Wed, 16 Sep 2026 10:37:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B5BF20040;
 Wed, 16 Sep 2026 10:36:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.121])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Sep 2026 10:36:58 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: npiggin@gmail.com, rathc@linux.ibm.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com,
 thuth@redhat.com, asahu1x@linux.ibm.com
Subject: [PATCH v2 2/2] tests/functional/ppc64: extend ppc64 powernv net
 device tests
Date: Wed, 16 Sep 2026 16:06:35 +0530
Message-ID: <20260916103635.7797-3-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260916103635.7797-1-asahu1x@linux.ibm.com>
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfX3mnewUjM95Jy
 nLmn6mrT5lKMTp2Yz/TBCQRVpZhOFCuX2oJNqpPgSXD38mOgwZYqhBQoaZ8MAvi2TKRZwwXTvzE
 PWr24FwJaVIgv+162rG3JxQSHnL2g0hYxduE6WHIxKTeQMXsy4JNyI7aRktuXFTJBZOoMHu1E1/
 8lqsV0M0MASDLfTBaVOYCVU+BUNb44ko3MQVPYpoBO9twf6DQYplD4/Fn6RuCVIaThxQGbOLCMW
 wtF238+7PvVc0oAdpiclq5BE8YWmtKCPkzt15jNZew1Tsd34ngo6HsanJPln9QJirzVtmh5oLiZ
 qlpJZ4iAqepJaj7WJcfPm2xDefHZg9yZAc2ikN/U+TKJg/bANmeWRc/mggIoLvOUVeMV98pqsrQ
 CptZZLIo6Sy0Xan1vXi2gLeKqcQxFJyBhG/+BbGxw5N3yydDuScwjFVRog9XqpcPzlwKYLuJGIP
 0kTmj6BJ0HwuYtURWGg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaa7152 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=qvQqbTaxai10iMa-vdEA:9
X-Proofpoint-ORIG-GUID: YrGIeURe30P015aNh4iHPTzDkM7XL9Ja
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDEzOCBTYWx0ZWRfX7a85x/mfX10v
 f8nD2fkL+M3QJvShHJ3PCl9xqo2zG3SJt58rpah6jI/3ScWcKFtd4Xj9Pxn1XBqcbNfNUOnkQuj
 fuDQ3DHlu1e7MywJth2uoG6i0YyHpjQ=
X-Proofpoint-GUID: PUAZhxOPDENJ-5H8RmgHk84joWj6jKK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Added console checks as the probe log lines will appear before the
S14Silence-console init scripts.
---
 tests/functional/ppc64/test_powernv.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index f3e05e4d38..200fd2c894 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -201,9 +201,12 @@ def do_test_ppc64_powernv(self, proc):
 
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
         self.wait_for_console_pattern("INIT: Starting kernel at ")
+        # NVMe, e1000e, and xHCI are probed synchronously by the kernel
+        # during PCI enumeration, after OPAL hands off to Linux.
+        self.wait_for_console_pattern("nvme nvme0")
+        self.wait_for_console_pattern("e1000e")
+        self.wait_for_console_pattern("xhci_hcd")
         self.wait_for_console_pattern("Run /sbin/init as init process")
-        # Device detection output driven by udev probing is sometimes cut off
-        # from console output, suspect S14silence-console init script.
 
     def test_ppc64_powernv_external_dtb(self):
         self.set_machine('powernv11')
-- 
2.52.0


