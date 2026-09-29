Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE5ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZdG-00043d-QD; Tue, 29 Sep 2026 11:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBZdD-00042h-7q; Tue, 29 Sep 2026 11:20:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxbr@linux.ibm.com>)
 id 1xBZdB-00071w-JK; Tue, 29 Sep 2026 11:20:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5Qfk4060015; Tue, 29 Sep 2026 15:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=AyWEwOYPKBgiHx49e
 2sKdwXr45PgJ49vFwtRTt1WrwA=; b=UEV0nhgAnrLeuRfvxseBsiIJpVdOHJhKk
 C2pK3IznICj+I2o+2LQdHr4nzVUhfaDI88a7HWJrDyIkJJ3R8D0XnDteOjbvQZlb
 mEeiRQ88gkwPg+lLMb+J3bDzhd9gGaylAZ3tzz9eFKdJ/1GqWoq+KaQ8EI8zTeEP
 VbmFz+FknTTSCPlnzLf/4WPP0ZE26UCFMJ3FbwAGyY9SpySJ5NqEmL0M1aOKc9Ni
 RIMHUx//Ys7nSbMP9Nn8RTVTVjgNrp1pjVLhpbGqRNjT4yFf3FhIsrTt/8yvVDvq
 VgWjMBLx8t18CGc10PiVoG3n3rKmTZr9BqAogZOAFSBkzzbvZf7oQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j57vmp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:20:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF3uCC1647349; Tue, 29 Sep 2026 15:20:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2ya25g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:20:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFKF7L47382880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:20:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92BBD20043;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F8032004B;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown
 [9.224.79.183]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:20:15 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: filip.hejsek@gmail.com
Cc: amit@kernel.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@mailo.com, qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, brueckner@linux.ibm.com,
 farman@linux.ibm.com, cohuck@redhat.com,
 maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v3 1/2] s390x/sclpconsole: fix indentation for console_reset
Date: Tue, 29 Sep 2026 17:20:11 +0200
Message-ID: <20260929152012.2696005-2-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929152012.2696005-1-maxbr@linux.ibm.com>
References: <20260921121641.1354712-1-maxbr@linux.ibm.com>
 <20260929152012.2696005-1-maxbr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfXx6DtGAQbeBUV
 2nSlWTzrkLIRBJZV6egEeeaiVWlaIyX/AFVb2kIc29hTdNGFfZWBsKCemXum2RnVVlK/vSKegSp
 4q54a/49cWAYEtJL662sQTp9y4weMPg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX6qjyndfstdDp
 95eiLLgP3SjLpsJ5cVD8OwOhUnEXukYNwFhaKKrIAZEWEc0EKtmVVRwcrJAfKOh6+s9ZLw1uNGJ
 36AnMSTAd/wxPUF3vvFPtAkvx94O5Djc8XqUTwSJcbmU28NIjzg+KGY2sTU4+V/+oNyBlR1dIHw
 r7fV2w6xqT4iD2p/kbtQEDnkejqiUdayQwCLAbhm2+NLfxfIyD5oI8w0gPps8a13MKyLu0/uxp+
 PF/ZxK9ffhKSml56nNY48Pw//i4Ng2MEwbJcLON9IpgdW/Zp8sh3sVuPk/Z19/RGK5a4BLv8r/4
 wW7osoirt71zh+8vd6vMxAUEXyqiMf7pWXygLVH3+YiPzhtiJrts93EE0RkW9CvKbPHHR9L1Tv0
 KlKnPma5sIJURu8uQqVd56jJxK6kNiyhwpYSxPuUZp11w/UPiWTW6LhzfZp/lz8xXH2AWm22jQn
 p0jf820UUS3mbLRpT/Q==
X-Proofpoint-GUID: o5eDxxRLaaJRzVmma7spIycD3H7AfosS
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abbd734 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=vA-fpVHSMCYthAec8ikA:9
X-Proofpoint-ORIG-GUID: SSoGeQlfOoOnMXf5jn1IrQ5Gu6ueyIKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=maxbr@linux.ibm.com;
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

Adjust indentation to match the rest of the file. No functional change
intended.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
 hw/char/sclpconsole.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index 179d12745c..1ad39084d3 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -240,15 +240,15 @@ static int console_init(SCLPEvent *event)
 
 static void console_reset(DeviceState *dev)
 {
-   SCLPEvent *event = SCLP_EVENT(dev);
-   SCLPConsole *scon = SCLP_CONSOLE(event);
-
-   event->event_pending = false;
-   scon->iov_sclp = 0;
-   scon->iov_bs = 0;
-   scon->iov_data_len = 0;
-   scon->iov_sclp_rest = 0;
-   scon->notify = false;
+    SCLPEvent *event = SCLP_EVENT(dev);
+    SCLPConsole *scon = SCLP_CONSOLE(event);
+
+    event->event_pending = false;
+    scon->iov_sclp = 0;
+    scon->iov_bs = 0;
+    scon->iov_data_len = 0;
+    scon->iov_sclp_rest = 0;
+    scon->notify = false;
 }
 
 static const Property console_properties[] = {
-- 
2.54.0


