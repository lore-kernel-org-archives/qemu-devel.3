Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AD1EDEC04
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcTr-0003Gy-KC; Tue, 03 Mar 2026 22:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSs-0002Uc-2o; Tue, 03 Mar 2026 21:59:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxcSp-0000ZK-35; Tue, 03 Mar 2026 21:59:56 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623DnGlr902068; Wed, 4 Mar 2026 02:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ikc7gr/1TvctqRb1A
 bu2usSH6QtlZ1QDD3Uc1w7K/Lw=; b=Upjte9VjhpGsM9qPHU68L6RbgvucaaNX9
 m4KzYF2OazVeVT2hCI8RL/S1DqxMPYvkn6GcvYxgQEDepdZSE5/gDb4YNLPE4nva
 14bJBSSxUjs/mDH7NaPBNO9GbMDBtoSicrK4dpuANhv0S573313MOZXM1HC8uA06
 66sNBKuoawXJX+a4zwhU9yHpNm8tew7lkn9p1bfVah/fIF3jqIJdHWJaazQbg41D
 M8NTHXIsVXYBanPtQCKLWhYxdqDGe3OwMS46UuuB9Z8tRhvL0l/qUCzD8RanaR55
 GLEH3Cwsnh3GDh+GdYdJ1hrqHob7ojHGx6EdS/3xZvVsX3E17vHig==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3wc7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62408nIT010299;
 Wed, 4 Mar 2026 02:59:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6k4xfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 02:59:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6242xp2T25821816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 02:59:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9364158053;
 Wed,  4 Mar 2026 02:59:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6825A58059;
 Wed,  4 Mar 2026 02:59:50 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 02:59:50 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 15/15] tests/qtest: Add s390x PCI boot test to cdrom-test.c
Date: Tue,  3 Mar 2026 21:59:17 -0500
Message-ID: <20260304025917.2157032-16-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260304025917.2157032-1-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wAUowWit9HFCba-_qIkp_LjiaruDjnbk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAyMSBTYWx0ZWRfX/VphLtkKlHJB
 u7Oh6Q2TrhRKmVrGeGFGG5bPiGWHhHOVQhVygLuv6E9u8TGqKz/VDLwDDGoeiwr0eXTWwD4gLZn
 sRASWNi3g5JbRd0qzWvFucl9WK9sCW0OJ6rTOHOzElDvNhvn3wOxAoM99mxhpkBTfqL4rYEwyE0
 Z1BVME6jnKbKroVWsr6g+dbuMqSoZXBFX9h+XEWSXuQU0vhJaesFmgW2k8OERTeUzdAfZSBzHg7
 c/9jiIp1ECvDrG3rm9f5Ps9IhGec4BY1kKVN/WicrGs0kyWhytJycdmer3JRZbtir7Hq4DxGQCU
 AUz1R0JKTg7FTVKPEVLv4PZbr7JVg33y/g9ts5iALNfPygZG1SoIVFcwQuenyLZ5cEKfoStIOin
 rFaY52mKj7lw4D48yJ/TC33L5nfiueqnHrn4VPeqnzIfhCmPKMOBrNhdBZjuo/59uRm2btWk57f
 0uwuLHhbHEnCBZ2129w==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a7a029 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=nJdWAAiftWQBe2TG7ssA:9
X-Proofpoint-GUID: wAUowWit9HFCba-_qIkp_LjiaruDjnbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_01,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a rudimentary test for s390x IPL to verify that a guest may boot using
virtio-blk-pci device.

Reviewed-by: Thomas Huth <thuth@redhat.com>
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
2.52.0


