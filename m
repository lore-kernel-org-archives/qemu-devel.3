Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C95C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 22:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rxG-0000Tx-RU; Thu, 24 Sep 2026 18:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rxC-0000Rm-MR; Thu, 24 Sep 2026 18:30:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9rxB-0005H4-0h; Thu, 24 Sep 2026 18:30:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5mhS1896649; Thu, 24 Sep 2026 22:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=W28NPNIANLUNQGp3I
 kCc6Izx8YgJrLiCy/E8HZaJJL0=; b=gu8Leq0uerC7A/+kdOZ7kBwHhEYCLERye
 trPpH4/ws4rMX6HgIBlLlNWwdWaXnZf9Pbhlaarx9PV6rshcLHCxzym25430+EcK
 4hG5TcHCOuAoDHSRy7T3k/gLfAmqZTIkQsN0M8GBZj5riKpfuaYZc8QvBlMqyi9g
 YMHnLZCcxIp12d4DbTgeJ8K/bZ0IkQgr/uSW/NtHNNy2P+DeQq7EK8E3F7AIW6RA
 WKa6/XtUP0Yta3jzt73wH44vd3NDqL7fi3TZJCLQ5pGPvPLpK7ygdOBd2LvvPImJ
 vZmCYdg3vQmOb94CoMrk/Pci6oZjQkcZdLquQRYp+llxmNxCfmt3A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqu28u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:30:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlZ4O2521605; Thu, 24 Sep 2026 22:30:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2ywsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 22:30:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OMU5Ef10289852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 22:30:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C42A058050;
 Thu, 24 Sep 2026 22:30:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D58158045;
 Thu, 24 Sep 2026 22:30:04 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 22:30:04 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v5 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
Date: Thu, 24 Sep 2026 18:29:48 -0400
Message-ID: <20260924222949.147720-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924222949.147720-1-zycai@linux.ibm.com>
References: <20260924222949.147720-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab5a46f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=PkLLOfym-WlFbigP99UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX3XOmylZyyR12
 G703LKZLvs6GjB8zCvZTeDpauIjt1en51c/FQoi0BZsM5om/YL9W36lEo7OoZudrAxWhI7G7OvG
 BDO5xfheHqcfo6K+aqAQEiGup6PUrxtB3aMyQgX8scvulzEln4LLYXdHlrg84zJqmVFlqxxIkUk
 6qm+zGI5I+FlA5Vk1yEJUCHcbJKYZmCN3yx02o9se8JWRv7YBRXEnDtt9y/TUluTR3nVN9WDOOh
 iGL4xODme55oxqSWrcwwTm//fYh2I9DEUZxvMWVZp4IrPPXDeC+5y6mp97ZAACj1csmlIiyl8ZB
 O49joqMYE1GsmEs7vxlUoJHro+fP23tE/2OhmLszrOl32Nb5LpTms4sc+OOzBwTPqU5IR0Vctth
 9NppSNAe4rW7n6EZNHJya9zk3FotacAMVsBC46FZX1NfVzZxLXwozjXkm2uRwfB7+BsYkQbdq+w
 lVYZGFNo+DpeS1H1Tmg==
X-Proofpoint-ORIG-GUID: gSLShaarW9KzUyvVSOS2ZWSxpo_imc98
X-Proofpoint-GUID: gSLShaarW9KzUyvVSOS2ZWSxpo_imc98
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA5MCBTYWx0ZWRfX3ednwrKOTR3C
 /AxUp2CvFRkD+QxH5WrybJ7OTf2iEJLHvJd3CIjRucj9RGAaGa5F6fppuMBNJTp7GznIvnOFGOp
 F8dncIc81A4USMSYHUeCfAMl0h7YJsI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240090
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
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


