Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F61CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 18:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6CS0-0004tJ-92; Tue, 07 Oct 2025 14:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v6CRw-0004qO-IM
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:30:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v6CRs-0002Nl-KQ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:30:12 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597IJX0l031300;
 Tue, 7 Oct 2025 18:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=UI6WBPgzX70SvC6fCGDI0/yZ7rKib
 8fzzRc7YgpoNNg=; b=WLblL5jN7YMtAATZ0lXgG+I1aPzWgkheMj28hjwa+HtLy
 a7O+dDgkfCZmHP6LSWWZsCguIP+yHJRVnwAFOniV9gWgUWbNUcmwIuxIm5CVcrCi
 w81URnUrLzh4qOQlGoKOZPFrcjYZveRZv3d4Fbon8Kb5Quku3/86Rvai56V4CR+c
 EZH7NjQN07L9P8JsJLv4eHwYlsuB0kUp+0OPWH53Q+a4sI6wpg6IbfdxR81xLQVj
 ydOizfkY8seCCr2QlkvdyYFNxXFn2omr7aBIB/Ci+3VjON2PSJI3juRc5qblMXTe
 w9NboA9Xuw+hiir0xP0XDkZeGYYL8nJ1BFvwZItxg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n81r00km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Oct 2025 18:29:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 597HaXrM036075; Tue, 7 Oct 2025 18:29:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49jt18kqm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Oct 2025 18:29:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 597ITq24012184;
 Tue, 7 Oct 2025 18:29:52 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 49jt18kqku-1; Tue, 07 Oct 2025 18:29:52 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org, mst@redhat.com, clg@redhat.com, sarunkod@amd.com
Cc: philmd@linaro.org, clement.mathieu--drif@eviden.com, vasant.hegde@amd.com, 
 suravee.suthikulpanit@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH] MAINTAINERS: Update entry for AMD-Vi Emulation
Date: Tue,  7 Oct 2025 18:29:51 +0000
Message-ID: <20251007182951.1284171-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510070145
X-Proofpoint-GUID: H8oKOc-8x58LBmCLdMiOL7Z7FiwYkVQK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE0NCBTYWx0ZWRfX6TlHk/L25lTD
 fHS/bf6mUP0PB4e3VPjwHrTRLigt9HoT+gNsZzdM7PrbNNlxI4aFGPvMgUKYJDnTP5dRb3k5Hn+
 AdSZT6vS1MQTMHFv296PCmvjvtn1JmsccSFQLx+lR9eKi5wdpk8pAwHmc+BgfAIIpSKXyy0vKuR
 PcuGckjkFinLTaRX5Ko9r8Y/yComC5yordhKLkkLQXDn+HmqgkahpkaLfc1kM7zveYPwLytAPa6
 kHYON5HH0rXATZjpYPfuAyf+Mc1qg2KXL/h7p8rcNjH9Q183Hho71qkSiTK2ZPT8SAQoBsF+7XK
 F1tzESm0gRXzX00fESIH1VfXim2i+uOA+Huv4wYws+pgE32X8do1A+duKquHwBvimCpqykbB6l7
 HF1OqcSFq74I90jnJHh78ubCPlNtPPfoC1RbVWcgmnYC9AWZ/ao=
X-Authority-Analysis: v=2.4 cv=dubWylg4 c=1 sm=1 tr=0 ts=68e55c22 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8 a=69wJf7TsAAAA:8
 a=FCmSo5QTj4tFlZMtZ9wA:9 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: H8oKOc-8x58LBmCLdMiOL7Z7FiwYkVQK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add myself as maintainer and Sairaj Kodilkar as reviewer.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75e1fa5c307ea..08de896ca942a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3891,8 +3891,10 @@ F: tests/functional/x86_64/test_intel_iommu.py
 F: tests/qtest/intel-iommu-test.c
 
 AMD-Vi Emulation
-S: Orphan
-F: hw/i386/amd_iommu.?
+M: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
+R: Sairaj Kodilkar <sarunkod@amd.com>
+S: Supported
+F: hw/i386/amd_iommu*
 
 OpenSBI Firmware
 L: qemu-riscv@nongnu.org
-- 
2.43.5


