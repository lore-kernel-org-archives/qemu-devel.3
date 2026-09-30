Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0A0CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAi-0008RE-Qe; Wed, 30 Sep 2026 11:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAe-0008KH-GV; Wed, 30 Sep 2026 11:24:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAc-00022i-QR; Wed, 30 Sep 2026 11:24:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5VNN2986280; Wed, 30 Sep 2026 15:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MQl01JvBsXek9vvfN
 PoqLJy9XoHBYqu7dbSk2K9FG04=; b=hOKPk7Ye6qnSAPe92Hs/YrNDwweC25Weh
 6XAQkxt9sSKSKaLsKckSyJy4UiicVF4nVVLuUOq/oADjvkXti1dCq1j01VXKtOuS
 8rR4AyVvE++X7hz9wsndFvLqA3CK4ioWxM8Gm7xlJzEDM9VQP3NdhM7dc+3GTjnY
 OLNAfP357ddZIe8p7oEbvz+/r4FwhPhEY5YJrH5WW0JMxK+rDraTRQAekTVZm783
 u8xyxvy5+7jQYId9fHWEGwRrEu8ckYPakvhctptkix1Tx2O2lbZnb3TVhezkxAmo
 rjGbN1rhXca0SVlyT/HCLo71GPZwN7F5e0sZ0wjZGrcuCsrLlgIAA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkd8b7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE39Fi2287814; Wed, 30 Sep 2026 15:24:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pb3ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:32 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOVXB3146466
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCFB45805F;
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 546355805A;
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:31 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 17/23] tests/qtest: Add s390x virtio net PCI test to pxe-test.c
Date: Wed, 30 Sep 2026 11:24:14 -0400
Message-ID: <20260930152420.1956230-18-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IQk7g8FsPC4Bic-9RgWTPA7lGlbCeUCh
X-Proofpoint-GUID: IQk7g8FsPC4Bic-9RgWTPA7lGlbCeUCh
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX7LLC2pIgrPXi
 UbGtuwwdPdrZcpoUgF8TMWH+6PEY6hTUqgU5cinZKA8SgmabfMZF/HXVD8R1mTkGwXttu3VnbAA
 mB01+XZ0mMZJ2NXyiGfIi4pO28H1uJw=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd29b1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=PkLLOfym-WlFbigP99UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX+JoYWEqPw6Y1
 pnn5kHu17/3oFlJv59sBY0604jIajP2JrySrcjVLVwQpLiSRgLpyj4Z5fq3MeekmnyyBzks1KcF
 KQXrQkm0oOx77dnpQ+Pc942v6zYpaVDmOQrhhWp1zA482ce+lNO2bjtnjVZpkcJeZQUFZJkDWQD
 M2yWelhK2EjH+yCdlRIDWvCac09IKC4zvrddN+R88c6aQUyFIRf04wbEQVTBtgg00CKQ5MZGWmD
 Xqawiqi6KGcLN+6r02cdwdNgN0W5nKZdG2sKHV9BpibMul0pHrguJ39iAQLO+zqnC/RWgmo+OGl
 sZIEk6A2W+mOy/hdKJGv78O9v80SiwfubLr6afbSaqEmw7rzfWzcvSAZ5GvmAfa7CSlr4RlQqwN
 LYDHRFlTDstXI2JtIQ19bQ5Qh3WCPsMMiXNDC+CVMjfXr4kK2K/TlB2ntu7Bm84ApkEzDXxvaou
 448nDLBL5B9q3PbR1+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Add test coverage for virtio-net-pci network booting on s390x by
including it in the PXE test suite. The test verifies that PXE
network booting works correctly with virtio-net-pci devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-8-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/qtest/pxe-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 5c6415b936..61c92a2df4 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -130,9 +130,20 @@ static bool s390_bios_has_net_ccw(void)
     return s390_bios_has_string("Network boot starting...");
 }
 
+static bool s390_bios_has_net_pci(void)
+{
+    /*
+     * Check for a string unique to virtio-net-pci boot support in the bios
+     * to determine if the binary was built with support for this device.
+     */
+    return s390_bios_has_string("Setup failed for virtio-net-pci");
+}
+
 static testdef_t s390x_tests[] = {
     { "s390-ccw-virtio", "virtio-net-ccw",
       .boot_dev_support = s390_bios_has_net_ccw },
+    { "s390-ccw-virtio", "virtio-net-pci",
+      .boot_dev_support = s390_bios_has_net_pci },
     { NULL },
 };
 
-- 
2.55.0


