Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD9C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtnkf-0002bf-ML; Tue, 11 Aug 2026 10:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnke-0002aE-ET; Tue, 11 Aug 2026 10:46:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wtnkc-0003gc-Uj; Tue, 11 Aug 2026 10:46:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDXAXH451252; Tue, 11 Aug 2026 14:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FxCr26HQGGPcNVJuI
 cyctYV5TU9dYfbvI5MmrgksQyA=; b=d9atHhDYjG0repHOJSb4pJQMIgaeYciNb
 NabO+r6ModH+ToWTQXn1hWEB/j7SI/62N3RA0bQl6/LB8HJeYcAa4CekJO3rdV9E
 PFPAxMazdM7zSEvrfK8cl9ZXlPE6zXbFQLu0MIlzPFhuREza2+mCmqqzB1vcm1q2
 NJYdFnHe03XNV/YGe4iz9TTby2qWohHET92gOJDaEmiT5bmMCgfD19rIHMFLqrWR
 9vfsZ2klNmjwgLJ4buvaiD6gRSblWux+20riWkr7R2q9H60GemkBlsllx1rn55H5
 v6MhFYY+gXM1SFRfuY62qwJKm29D5jVYRt41NUQiKF3o39F12z+Xw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2vtsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEfEkW019833;
 Tue, 11 Aug 2026 14:46:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy14kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 14:46:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BEkiL734472322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 14:46:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E36C58043;
 Tue, 11 Aug 2026 14:46:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C4D858055;
 Tue, 11 Aug 2026 14:46:43 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.86.140])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 14:46:43 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v2 8/8] tests/qtest: Add s390x PCI SCSI fallback test to
 cdrom-test.c
Date: Tue, 11 Aug 2026 10:46:29 -0400
Message-ID: <20260811144629.866641-9-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260811144629.866641-1-jrossi@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b35d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=MvDj_lKWWGcuVSP3geIA:9
X-Proofpoint-GUID: 7Out4OhClajwtlDLKuI6sDqQTVsbCH5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX6iRqt/2W319b
 fqHP12f1VHug4Kc3rlmnSrCoM0kfTj2pRTRdEvck3WfInZH4/yYiFMjiQooDtuCnafdf9Ax8rQP
 Gxq35ipe4QjjPFuzb4flpHHWuZhavekwglIbkzuGrrHDdyu59ZZIYefiCksyqJtrmIWrc8jjRFI
 /zzqUW8v151jaRyykxOwt6nd4TpwgWoJY5CsZslwPVFfMwhA9xe4w12QTRQ8Pb2WaDvnfnmZate
 q60T+WerapWHNyZRtYcJxXB5bmMtpdlt5oJ01YF24aR+KYD9tGmWpHmmcfSk76hsKQBwHwGE3uO
 rkMPDyIvx4G1O8VLGLJBJTi8iOMv3NI0tq9EkiJFkDsYbJNCThKSBCyVcI89pT5lGo152zXVAmm
 x+rOur6qkc13QKeKu6t8q3LN1Ef3R3p9cgZRQukEY3/DJM0G3kguRfgaonpg+j5jLdUmz6ij9Bp
 nUb5hoZXPOxl6j+wayg==
X-Proofpoint-ORIG-GUID: 7Out4OhClajwtlDLKuI6sDqQTVsbCH5n
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX+gyJvDXPWEWF
 6zy1PktN9oQRrrZM1hQGr/vfzrRuPYwde2Li63y84cKJkQ0canlaa9N3zCZ/vLS2vB6hqVTo8nL
 usbV8tD/K1RkImnO020Csy1NuSDbVRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add a test to verify that a guest can use a PCI controlled CD as a fallback boot
device after a failed CCW IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 tests/qtest/cdrom-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index a65854d2bc..ab34930404 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -253,6 +253,14 @@ static void add_s390x_tests(void)
                             "-drive if=none,id=d1,media=cdrom,file=",
                             test_cdboot);
     }
+    if (qtest_has_device("virtio-scsi-pci")) {
+        qtest_add_data_func("cdrom/boot/pci-scsi-fallback-from-blk-ccw",
+                            "-device virtio-scsi-pci -device virtio-serial "
+                            "-device virtio-blk-ccw,drive=d1,bootindex=1 "
+                            "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                            "-device scsi-cd,drive=d2,bootindex=2 "
+                            "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    }
 }
 
 int main(int argc, char **argv)
-- 
2.54.0


