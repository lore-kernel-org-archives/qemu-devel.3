Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27805CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 16:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAscx-0003pb-U7; Mon, 20 Oct 2025 12:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscl-0003k8-S3; Mon, 20 Oct 2025 12:20:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vAscj-0000tX-UY; Mon, 20 Oct 2025 12:20:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCkPwx030017;
 Mon, 20 Oct 2025 16:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NAyieAw2SufomrfZF
 UwB2+pmnqmdJ+XxYzKZ+g9/cLk=; b=QzpphJTVt6efYu/bC1Uk/Flacz4kre+oi
 wjsPBb6WvNBUYMlfmkK0qfkhOxRe5FVR0GQlqMDhtj+eqEjHm1hpMA02GDhH3DMS
 Fde3vscowvOMEmn96sADPqEhuo55HdpVn0jPsTNXmrX32xkiDSdPQgzCmuxwpCm6
 tbB7YWGyS6ymAWbuT/kb08Q9G8irSkTPltI8dn6UKvpptkNdBcPiPzmvfbRcVsVT
 2jiBUNfcJGP9kmhG1gjMU3m9s/mCPR27DAF4MT1d6ihIeI1pLP86ZT54j4kif7Zm
 yIRdR03ODQMkDIxOsP+ukyhWSP8jchvp/z71ptVW/SJ2bLA+jlhHg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rtg4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFAbKL002926;
 Mon, 20 Oct 2025 16:20:39 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej6brt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 16:20:39 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59KGKcIV31064736
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 16:20:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A1D758067;
 Mon, 20 Oct 2025 16:20:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7248958065;
 Mon, 20 Oct 2025 16:20:37 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.78.141])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 16:20:37 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 7/7] tests/qtest: Add s390x PCI boot test to cdrom-test.c
Date: Mon, 20 Oct 2025 12:20:23 -0400
Message-ID: <20251020162023.3649165-8-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251020162023.3649165-1-jrossi@linux.ibm.com>
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HwU4zMJLiw7IuG5MtiZ7AQ7NIEP9e4YS
X-Proofpoint-GUID: HwU4zMJLiw7IuG5MtiZ7AQ7NIEP9e4YS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxM9Ose+l/0ed
 ub/ZUu9xiaMiLcXsaBAStlhiA4PNoLxFp86tnPrb1zbqmQzlQaPhAFd8mztO/NDe+YW5UUrchxy
 N4WE5lXT4KRT4wsOpuOHKDeLVBjmsYP26hcuMyASScj+SpxNun0z4dBY01NRP6fyDJwFl29Ei3A
 Rana9KX/2yug+KVzx9PmjjRjCiKMVJTuSgGYa9BeWJH+Os/u7AiYVX3XPZC/RKdV+068k+yC4IY
 LEmo8WSH35NhSbizkqxRm5rr1GqmqR7DMikMzb7G9Ryndvjg44QzxsR8RihCd5dEOrdsAfdWSIp
 edWVQer+AQZF/qT+/S8DY4LNTZoYBk9EMPD/eKOCKId6EJQ7/M9Z/Is71h/Ms9s/NVpDNZ6Pdzf
 cw2VTOacnXCbpIPWC3eSn3D2jFF/JA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f66158 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=nJdWAAiftWQBe2TG7ssA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add a rudimentary test for s390x IPL to verify that a guest may boot using
virtio-blk-pci device.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 tests/qtest/cdrom-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 56e2d283a9..a65854d2bc 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -246,6 +246,13 @@ static void add_s390x_tests(void)
                             "-drive if=none,id=d2,media=cdrom,file=",
                             test_cdboot);
     }
+    if (qtest_has_device("virtio-blk-pci")) {
+        qtest_add_data_func("cdrom/boot/pci-bus-with-bootindex",
+                            "-device virtio-scsi -device virtio-serial "
+                            "-device virtio-blk-pci,drive=d1,bootindex=1 "
+                            "-drive if=none,id=d1,media=cdrom,file=",
+                            test_cdboot);
+    }
 }
 
 int main(int argc, char **argv)
-- 
2.49.0


