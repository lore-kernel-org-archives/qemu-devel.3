Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A201CCED251
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyq7-0004Gj-3x; Mon, 07 Oct 2024 21:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypx-0004Av-EG; Mon, 07 Oct 2024 21:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1sxypv-0008Mi-3C; Mon, 07 Oct 2024 21:16:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497Nt1WY026081;
 Tue, 8 Oct 2024 01:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=FDktUuboDI+n1
 AFaAgMdhRADb14wBWBDQNpa+o9LXrY=; b=R0G/E/PxkHhF4ABDKVpYTakmyhmY5
 LfjD01bf7A4Xg1KU4r8lrEbUvEmY7dhcsyZG91Rzk0my1ERHICOMYOLCVJO+4XJL
 zTti/G5gqhuAo2AVOK1/6/+nQ1G/DpRg1QuC5QKdCFkdQQ7QkG4vWKnjztDIXrba
 jcHWpJL4FPAMuYWgGM3jHfLV47w4FBWAq4xanVk+LZN0qOAFx8u0kcIm6MO69xU2
 RBC1E3IULEMi+YN3yUSml/qAf0m3hFtaYsnQSRy7YDmaVxH0zx8vzhIzoo/bNaMP
 aJsmKC6wfxnQvCZrcjFzaRkAsU+H5ySgpBtAK4h+AWcYTD+cYyT7mqkXQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424sr4g7j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4981GNl5017889;
 Tue, 8 Oct 2024 01:16:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424sr4g7hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497MEwQK010727;
 Tue, 8 Oct 2024 01:16:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0j9baw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 01:16:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4981GLOl19005992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Oct 2024 01:16:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59F7358055;
 Tue,  8 Oct 2024 01:16:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D47B158043;
 Tue,  8 Oct 2024 01:16:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.51.58])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Oct 2024 01:16:20 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: frankja@linux.ibm.com, jrossi@linux.ibm.com
Subject: [PATCH v3 19/19] tests/qtest: Add s390x boot order tests to
 cdrom-test.c
Date: Mon,  7 Oct 2024 21:15:52 -0400
Message-ID: <20241008011552.2645520-20-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008011552.2645520-1-jrossi@linux.ibm.com>
References: <20241008011552.2645520-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YHENZLcXuGpMAR25SlfNgy9wxotmDDAd
X-Proofpoint-GUID: 5sC-AWwAksOQLOd6KvIMJjBPhMmU_8A6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_16,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410080003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add two new qtests to verify that a valid IPL device can successfully boot after
failed IPL attempts from one or more invalid devices.

cdrom-test/as-fallback-device: Defines the primary boot target as a device that
is invalid for IPL and a second boot target that is valid for IPL. Ensures that
the valid device will be selected after the initial failed IPL.

cdrom-test/as-last-option: Defines the maximum number of boot devices (8)
where only the final entry in the boot order is valid. Ensures that a valid
device will be selected even after multiple failed IPL attempts from both
virtio-blk and virtio-scsi device types.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 tests/qtest/cdrom-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index 9d72b24e4b..123c067589 100644
--- a/tests/qtest/cdrom-test.c
+++ b/tests/qtest/cdrom-test.c
@@ -213,6 +213,30 @@ static void add_s390x_tests(void)
                         "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
                         "-device virtio-blk,drive=d2,bootindex=1 "
                         "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/as-fallback-device",
+                        "-device virtio-serial -device virtio-scsi "
+                        "-device virtio-blk,drive=d1,bootindex=1 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                        "-device virtio-blk,drive=d2,bootindex=2 "
+                        "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
+    qtest_add_data_func("cdrom/boot/as-last-option",
+                        "-device virtio-serial -device virtio-scsi "
+                        "-device virtio-blk,drive=d1,bootindex=1 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
+                        "-device virtio-blk,drive=d2,bootindex=2 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d2 "
+                        "-device virtio-blk,drive=d3,bootindex=3 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d3 "
+                        "-device scsi-hd,drive=d4,bootindex=4 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d4 "
+                        "-device scsi-hd,drive=d5,bootindex=5 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d5 "
+                        "-device virtio-blk,drive=d6,bootindex=6 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d6 "
+                        "-device scsi-hd,drive=d7,bootindex=7 "
+                        "-drive driver=null-co,read-zeroes=on,if=none,id=d7 "
+                        "-device virtio-blk,drive=d8,bootindex=8 "
+                        "-drive if=none,id=d8,media=cdrom,file=", test_cdboot);
     if (qtest_has_device("x-terminal3270")) {
         qtest_add_data_func("cdrom/boot/without-bootindex",
                             "-device virtio-scsi -device virtio-serial "
-- 
2.45.1


