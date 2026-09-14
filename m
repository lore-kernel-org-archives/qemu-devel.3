Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CE7C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CSc-0007Gq-M8; Mon, 14 Sep 2026 15:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CSE-00070e-2p; Mon, 14 Sep 2026 15:35:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CSB-0004F4-8L; Mon, 14 Sep 2026 15:35:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJ1Qcq2880868; Mon, 14 Sep 2026 19:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YAMsQTb6rhmU3d06p
 gaPDi4Pf/RAqnYY1tnOu3bhyyk=; b=npv2km2gvLdNc4KsMGFuL0KyMMt1Nsi/r
 QplU4mO7v9eEXvHs3jNwNy7zTXpec3MQ8VFrzEttaEGZvHX3iks/LPycBi79dffZ
 5jOoNWyHRDNcgXc1Vq6KzZPDvuW6YAqnxP4HvsNXkHkA3ghmBsXF812sYyHYlWj5
 keAIOXGrqdi0Q13WgFo7F9dQg6hiiSyBkNvWJoMkRR1lpUqoHKAcaS8mfDoyyhSu
 Si869y97qhzFnbgAVEYjkbs5z/+fIlbclp3bhmYA9D8iR8hDapqeV4bg6g6QcMoC
 ljlGLTKmlzZ6nPypJaquRZ2MWx0aVKkxBvOccpRnj5mR3/I/b0hBw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83km38-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIoov72817784; Mon, 14 Sep 2026 19:34:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j7ny2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EJYsoh33096222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 19:34:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3770C5805B;
 Mon, 14 Sep 2026 19:34:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C060158058;
 Mon, 14 Sep 2026 19:34:52 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.78.15])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 19:34:52 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v3 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
Date: Mon, 14 Sep 2026 15:34:37 -0400
Message-ID: <20260914193438.526407-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914193438.526407-1-zycai@linux.ibm.com>
References: <20260914193438.526407-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX1oRtW2Z8ujqj
 erRAYi2gcqJOKMxSfJAsvB465eA3qenjf03IYsTw2QJXoHURabukUjFBp6/zv3K0tZGwNqSAVh+
 jOJInNxLG4hbI4j6ILACmHwOad1tob90JwTEi3J9nPTbXA7D82aPv5DFUNAXelcrd5E3C/Ykbot
 HTl/Jf1byceergPRRold6jLnLYZXsJM6/gPSmkOF/3mZWec09EG/pIb62LkE0UXYlqt0d4DMwc0
 ZdPP0221gx1xlpEWhvplZVHloKI/cQp4JZI0MH8A15r9pQea7J5t6wcc2M5eV10drF79NXRZtd5
 MnNYf1NQefAs8+yPgpo8gkqd2CRB+6ns0nBKQuS6e8ZeFysuFMuU10Fg0cSarQ61qsP0cJFFkKO
 aGHg5NnEavq1w3FjwCuJLYxipr9CeNpRB8Uma9OarEBtARJ4+/2lWEJbGPq6sx2pgwz7CFnRssl
 gC30nRRkNJDDZCNdDcQ==
X-Proofpoint-ORIG-GUID: 4o2zkpLxxXklrZvnP-j5GSWeqxUdrJ-k
X-Proofpoint-GUID: 4o2zkpLxxXklrZvnP-j5GSWeqxUdrJ-k
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX5qSzdeK3WPqp
 iJQ2KSF1YNyXsOhAOZLKnxiaNFHZwsStLM/6c2VzK9i5J1owF4k7cnY2M4wdILF+kAmRWP58uKY
 VBdbhx36Izqh8G8r7o7v1Iyx4lRwtn0=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa84c60 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dWYI0Se9NbB5ALU5aogA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140278
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add test coverage for virtio-net-pci network booting on s390x by
including it in the PXE test suite. The test verifies that PXE
network booting works correctly with virtio-net-pci devices.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 tests/qtest/pxe-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
index 8b6015b6cd..c29386ed4b 100644
--- a/tests/qtest/pxe-test.c
+++ b/tests/qtest/pxe-test.c
@@ -129,9 +129,16 @@ static bool s390_bios_has_net_ccw(void)
     return s390_bios_has_string("Network boot starting...");
 }
 
+static bool s390_bios_has_net_pci(void)
+{
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


