Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93632D3409C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklkf-0004Rl-RS; Tue, 27 Jan 2026 11:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vklju-0003ju-5j; Tue, 27 Jan 2026 11:16:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vkljs-0000qO-99; Tue, 27 Jan 2026 11:16:25 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6vWAZ026737;
 Tue, 27 Jan 2026 16:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Ikc7gr/1TvctqRb1A
 bu2usSH6QtlZ1QDD3Uc1w7K/Lw=; b=qaRoURP4cXXR6DQ05GqqUoO30TKSKLYEJ
 HQe04N/DN/psvqEhqmY2NtPWYVCdIfbOVuq8++sD31159uDLNZr3c2oIzhL+j2Nb
 EztIF84RkCKvR9wDpVwMyHXZj+CcOsmSTMvKnBeOjaqi+v3UOHOnREOyfp6owifj
 mJ1kfAQbRby/9YAoOd/4idzroVVXFr2NZ3/nQTt0YvrExewUB7DwvYugAbl5QzHg
 0VYVHRDWLeeoMQl4M1By7duhuUSnCYQUpAbNorWHjtQVPzODoAJk2w2S8nqabd8I
 bdsPvZ7wvB/TOX5+CmoWYSijJt83kvAMyK8+38ZkyyNLlrv1jRyHw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnt7pd0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE0GJ9026319;
 Tue, 27 Jan 2026 16:16:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk995j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jan 2026 16:16:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60RGGKLt28443282
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jan 2026 16:16:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEA465805D;
 Tue, 27 Jan 2026 16:16:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C24D35805A;
 Tue, 27 Jan 2026 16:16:18 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.94.134])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jan 2026 16:16:18 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v3 14/14] tests/qtest: Add s390x PCI boot test to cdrom-test.c
Date: Tue, 27 Jan 2026 11:15:47 -0500
Message-ID: <20260127161547.459443-15-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127161547.459443-1-jrossi@linux.ibm.com>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: phIZN-HiAODZ6HyPd4fNEkwd69-iTUeK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyOSBTYWx0ZWRfX3rMFskK811Dv
 vEoKGsMgwlprgEO3rUv0uL4hwws5LLqB3+C5ZzGhCDasmswzyhM8IU+khtDeJNOYCe1nFlcZNl3
 VltYikbMwvOsOpsIvj+FbRFZ3RByx+OMZb4KLRL7KXqu6T/WURKlme8kMe8ZeO5EfPT6r8BidMv
 iVukTRQZBDl8gqT2PAowCMfUAjsR0Y99DXVTj/zvXYyAhQYXPkTfdcPGFZukb3VeCSKpwXT0Bb3
 /pXDtJy4iib9qzAda58bouJjZShqu/j+uHFf6j1qbreDod9N3t6i0iDA5iUG/mxY6AJnh5yEwMC
 4gqRRrgF2mpmDWY4ItPWp1L0RamPy73ORpSECHKG5xdROO1H43j/UX1WgD7NII1wBfPt+FW3Wwy
 lEXD94SN+306t7Ez1S0un8BZw/DtREKCLQeM6vdtWygW7BlPoYYMvxAcUB3Hu9jsmH3Fefwe6Ay
 Yl/ASszu70H4fdDQ9Ow==
X-Authority-Analysis: v=2.4 cv=Zs3g6t7G c=1 sm=1 tr=0 ts=6978e4d6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=nJdWAAiftWQBe2TG7ssA:9
X-Proofpoint-ORIG-GUID: phIZN-HiAODZ6HyPd4fNEkwd69-iTUeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


