Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DE9FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 22:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK1av-0001xa-QB; Mon, 04 May 2026 18:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ag-0001vx-H4; Mon, 04 May 2026 18:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wK1ac-0002sm-7b; Mon, 04 May 2026 18:16:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644AduFV2476923; Mon, 4 May 2026 22:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tIKv9cAjaGUzdvSZi
 tiD4ES7uaq5h/YoWDY0LPNlWyA=; b=lqU0wq5fOOFyq9z+QF/LAW0c4Lw61mAfw
 D/WL50HZA4KFe+8mwc9w+aWAtNOAhdJrHxQHop9BNv49BJkcsDlMM+kqbmhu3gjJ
 XZ1DPlkk8JzXILszao7NX9inUWVhmbsMKcoVmNiLHlONHTe9e5+af8dxnGkR1YSa
 P2boUqELFaCVHqw8bVRm9CmU3Dhei/g9IU4ZMODC2o9QlAcLL9xmWOyOX1cNmgWK
 I6ublX/pXdpXhLiNRTTtpiJ84Rly7X6xUQarWEs/MDycTIJb3Knqbm2jQxdkg97D
 b6sNywipoAi6OOx3IA9oQ7xGEFe0rTeiGmMi1jLCjNraBf0j8E1KA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4gvfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644M9fXh012299;
 Mon, 4 May 2026 22:16:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg6w5k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:16:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644MGRJ215532732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 22:16:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F9BC58055;
 Mon,  4 May 2026 22:16:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7FFB58043;
 Mon,  4 May 2026 22:16:26 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.119.68])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 22:16:26 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 jrossi@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH 6/6] tests/qtest: Add s390x PCI SCSI fallback test to
 cdrom-test.c
Date: Mon,  4 May 2026 18:16:13 -0400
Message-ID: <20260504221613.826825-7-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260504221613.826825-1-jrossi@linux.ibm.com>
References: <20260504221613.826825-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDIwNSBTYWx0ZWRfX1QdPGjFGLXgW
 FoTawqyS9ZQTkji+JPubh+E3MuKftU7yS7fWdowQsgRn2zKjepYdz+DHtxywNpW7o2Xwd5YtXMl
 IRrCl+jcnoo3zL/Fyd/8Dlck2NdGry8AwCtT0k4QFtKGEJOSEGS8y5lDTSzbwa7SQOdyTEpTjXs
 gn4WrUySr7tmH0WfKH4nrCqvHaUWyfV+t4qy/zX+z/ZpT4Z+pswrdPcOjiVHkivrRvRRqhpbNLl
 klAKKo2ltp7p/y/LkvUJuB4hfcuq1JBN3vyl7D4hLATImhXslP5GtiiQDSNtRTiSmUljj3WFW+v
 5J7IF+NI8fzl9g1g2vtey7oRWsN1qffhzp2G5dXTKGEO9f2/Vrgs8RboeD+43urm26TUetdIz1b
 iWWikDFb9/KeoOucqOCoBR5NouT287mNkHE8BR+hmWi1vPxG7rP8pGt47abMY6mUGkPA8wIm9Iq
 HZ8DHIMmEXResuM0Knw==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f91abd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=MvDj_lKWWGcuVSP3geIA:9
X-Proofpoint-GUID: c8lxLE2yJyQE6VEXRpNEMLUp_W5sVFup
X-Proofpoint-ORIG-GUID: c8lxLE2yJyQE6VEXRpNEMLUp_W5sVFup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Jared Rossi <jrossi@linux.ibm.com>

Add a test to verify that a guest can use a PCI controlled CD as a fallback boot
device after a failed CCW IPL.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 tests/qtest/cdrom-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
index a65854d2bc..50706b6f84 100644
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
2.52.0


