Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE27EC98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pRJ-00040R-No; Thu, 24 Sep 2026 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pRB-0003yU-W0; Thu, 24 Sep 2026 15:48:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pRA-0008BQ-Hz; Thu, 24 Sep 2026 15:48:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5RNe3107018; Thu, 24 Sep 2026 19:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=1MSnTIvkAItdvPLYX
 ArpBwaReNTXxtOmB6hatitdplY=; b=GU43G6oBS7gUU85ywe1H5tIgYKkv77/4U
 eWnrp0Wuu41qCSg0ZVe86ZXJ4FVacVNR4hRkD7KeWaZx6Ll4wd80C3Y59JZljgLe
 wQsUHKghF/2JQ4ugJKIKyIN5u4kJeKAtMQ+GU7Z9Wblsr6FMVhR6NP8O66f6mFOJ
 ZUIDfwbIeSt82E2QX6AQVN9pWTXObkrY88cT3bMa8m015UCszpE7T/AL7WtdjrVF
 XIMD60m7mvh28s4UqBNnnSUMhg1UR9MMu3Oa0xHFsXzqyN4Ma/eoIJhpBUkg6BSd
 OSeFno+q2vzBh0mRCqNfT3OIj5f/2thsdoTVpVJifV7BBTti5KVLw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvjfve-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlWsX2521574; Thu, 24 Sep 2026 19:48:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2ycg9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OJmrLR18875026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 19:48:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 763205805C;
 Thu, 24 Sep 2026 19:48:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2F5F58059;
 Thu, 24 Sep 2026 19:48:51 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 19:48:51 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v4 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
Date: Thu, 24 Sep 2026 15:48:36 -0400
Message-ID: <20260924194837.80732-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924194837.80732-1-zycai@linux.ibm.com>
References: <20260924194837.80732-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YPZphbCrLpWczhgNtSlj7mT_ZJfQolus
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfXy0nZirp24efi
 WersafbVATltE39SaQGE2dSY65k6Ig2dVgidfykSzp6EiIiBGge+zZGUF5VCWlNkX3G1/Tr1Cm2
 wTAgBN1JGCtRJY3SKHmgwpylSmF5/ns=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab57ea7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=PkLLOfym-WlFbigP99UA:9
X-Proofpoint-GUID: YPZphbCrLpWczhgNtSlj7mT_ZJfQolus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX4LYSrCdr0Lxv
 vUtyrirIJDLx5MJ1f6H/lBcFEzlUZk7LSsgGmnzKkvaxCoAIkpHiewg9wB0f0Ea1zYAucyysvQq
 43V2aEeGcCCqc+zrPZ2+WgxsNLsIZ4imp0RaHv671WokIhrBcavszU2TcGhw4K7U0mJ6LIaCnDz
 kNoQJQRNBb0mY9ii6iix8YOnR9MsakY8/nLIq6abVkxHFczeL+x3bI3jN/jtIqlkymUxfhMYLYn
 E20TpCqHjyXBOJbnjMQKWmiJL0iGJJgaCI0O1JFuZjzYkvndaso7muRG3o3bevxKpVVNNZdU0kY
 HmzdINU2PBkUIrEqypbJwZC4NKACk1qfcxLncQLG9XePo3Vkkiq8NLUYMiBUhqvxmE0YKPjLWrg
 PfpoLqaNHCdrTyd2uPplwynX/jCFFSvWkpZl1BR6qpRFMey7htN1+tb2HL8t9JK4F1CBwCdpxsx
 4pHg9SVjeGjnm9z+XFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240080
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Add test coverage for virtio-net-pci network booting on s390x by
including it in the PXE test suite. The test verifies that PXE
network booting works correctly with virtio-net-pci devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Tested-by: Joshua Daley <jdaley@linux.ibm.com>
---
 tests/qtest/pxe-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 61ad572bb7..b12de2bedc 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -126,9 +126,20 @@ static bool s390_bios_has_net_ccw(void)
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


