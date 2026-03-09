Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48318EA854D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 00:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzObz-0006Tt-Ju; Sun, 08 Mar 2026 20:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObu-0006Sn-JX; Sun, 08 Mar 2026 20:36:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vzObt-0001hC-8F; Sun, 08 Mar 2026 20:36:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628MtleT1599036; Mon, 9 Mar 2026 00:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ikc7gr/1TvctqRb1A
 bu2usSH6QtlZ1QDD3Uc1w7K/Lw=; b=qL8kRLB5ZSRWz65Rl0ed2X2Sj+jnFDrye
 0baaWGLxychPqYatH3FtfHaIYBRx6avPiGtJsxGmmPgxqmWnTG598i5y2DFPN+RO
 sfy/63RZefeYpaDQYOXZDww+c6TWspe61SFHlL931j+2kANr/Mj76yeeD33b7oEl
 Mf4bvJjtfKLwzY8Mk+ivc9fuCKRLm3xTqM8cJrWVTeSj4rwJySVPNCrsCKDNsWul
 qbU/2o6RL/NQjW+Ohu13Ru01I9DMoaFsg7lyjeAB6gsUBF6dXahx81rBxfvO+38B
 LcDZd0JTPrkM/V+7KI2e9jedfK0NIcKTdNjSMcu8gfeZlZiEc6/rQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcun4ebj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628MY5qt023217;
 Mon, 9 Mar 2026 00:36:35 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cryukawfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 00:36:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6290aYfS19858172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 00:36:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ACB358050;
 Mon,  9 Mar 2026 00:36:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB2D58052;
 Mon,  9 Mar 2026 00:36:32 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.180.105])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 00:36:32 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 15/15] tests/qtest: Add s390x PCI boot test to cdrom-test.c
Date: Sun,  8 Mar 2026 20:36:01 -0400
Message-ID: <20260309003601.242634-16-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260309003601.242634-1-jrossi@linux.ibm.com>
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mTTdHyOiVaS1RRQsKLii2_h7C5vJwyoZ
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69ae1614 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=nJdWAAiftWQBe2TG7ssA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAwMyBTYWx0ZWRfX2RjkgsEfqHlu
 shU6YTqXJruNFHRmTilxLNrZ0gHYSl7GMMUZlTyHCrk/BsUCh45hksz3OgKge1O8Zb5uLSA7JQU
 jjkvUk7ZvIxJKg8XmsV4JnkneDG6XyZ5fji4P9tWv7m044i/xgk1Z8Kt3SQ/dwGC5NED1d4dk+6
 PTIZ6vdTp7nMxSG014sd7MU3/1rpMWXJl683Wwaw0oln1AecRwwUYavuehiJt0eq1tFBrcwp8Ii
 mvnNTuAiHkpbPeTz50YUPUSheyb1sHh2Fv+twwbejR0jsvY7iOQMDFeEu2kifsbBett8Ab3nFK+
 LOfo2Cul4QtxXf5/HJ5MDJ8LSBSw5jSKvV475jGty3ZAu5QHlYZoMyJ3y/i8tpQPL3SJs1CuvEg
 JvbpMrkI2llFfM80jO7wLEza/zDrawuL803Bqdf+pj4LDP9h3TdY9EuB4Smrl7BOpXnVq4gq3Cq
 l1B6SpZCINZSW4uXZzQ==
X-Proofpoint-ORIG-GUID: mTTdHyOiVaS1RRQsKLii2_h7C5vJwyoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_07,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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


