Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD90C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYbp-0006Cw-4b; Thu, 30 Jul 2026 17:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbm-000652-Vt; Thu, 30 Jul 2026 17:48:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYbl-0002U4-Ho; Thu, 30 Jul 2026 17:48:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJlq223942701; Thu, 30 Jul 2026 21:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2vNILidGvjJw9UaJT
 fRoBN5GPJ37VkzBww+mtHmijTE=; b=KUlGtl+rnil/RRAjWyrKklIxfVyp780pG
 uD0nNi4gr6sV4bO1Rbmli3KEFOW/YqFkioQEhLWrGZrFYwR1khSal2/+WG4/e27s
 iO/CR8H9E8djN2TevjTDZyd3xiaBRrxAXkVSS9hvszJAr46S6UEk+bheSkGavrks
 lSVNCeXHTXHB/KuK0ptdvE7G/etgIvyNiSq6oyewPOw8ZftLmgthqbvhvuCB/DB4
 qFy692DKgMyhilj1ntJKP05hVO7kdFIIRvdtv5vnRe9RsRFrwfaw3Qcf80HtFGW2
 oMGtvaehFuMBWddYXTy36IJW1TvL0q2RwH9+MB3GS5j9hGzsqYAXQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7t260-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfLDY025793;
 Thu, 30 Jul 2026 21:47:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkda6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:47:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULldvr10420866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:47:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C3D958065;
 Thu, 30 Jul 2026 21:47:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AC5D58043;
 Thu, 30 Jul 2026 21:47:37 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:47:37 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 34/34] MAINTAINERS: Add secure IPL files to S390-ccw boot
 group
Date: Thu, 30 Jul 2026 17:46:23 -0400
Message-ID: <20260730214624.2328883-35-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vfz5yliz_dcJ_Ugmrjwi-i7lzFrjte3X
X-Proofpoint-ORIG-GUID: vfz5yliz_dcJ_Ugmrjwi-i7lzFrjte3X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX0Wn8ECGZBngo
 EyEGUjHYfwW5t+VcKI/PPB68tDo8Z7wigbBXc/VRuRQ4eqftR9S0xv+V8tOMOSP97gv+/9Nhobh
 4W/yUEH3pvZBlIgGi3sNaA3viXIxe/zwnmpk8jU1J+hfzxF2zGgGONhTQtFOQNQ5ViRaFij5EG9
 0iZkmgQYmyDAGznPUlFErTPd3wGgg/sbsJ642veFnSW1XBgfj2pRg5izbm544xTGr8Xaj1IBMr9
 rj+uLIJixVn8I2YCi460GP4uJwFWAbOekQG4rzMmnkjMpKuillVCUZTKYKu0YAWilA8bdB9GZeY
 E1IYCR/tApsuhpjLgi4+DWjPQb9mJbqfe11cyK+t8qiepJSguh2JAC/kCjyvUEff5X5vO8+PiDa
 cv2HMsgIoQk9W+N4WFnWC6odcKBEHJ3GRKb/+vS+CV7QGKlrrxdjzzcqtHIPVoiaCAfMAElkZuh
 SAGmEhtHQfks0nj0rGw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bc67e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=khayYW2hrwmvPydVraMA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfXxDFVMZEfviLL
 4xDFBqKdmG/qja+m3J9Agk7RuQgLalbEdVc5RuEsbXJxZLOUoNzAcswqMlRmcMKnqBBlNxfp3bG
 oljHc53f6oqUbTtIYEZiWlv/wj9KCRw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300157
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

Add entries for the files introduced by the secure IPL series (cert-store,
diag headers, documentation, and functional test) to the S390-ccw boot
maintainer group.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 902db77218..0742076861 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1926,10 +1926,15 @@ R: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Jason Herne <jjherne@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
+F: hw/s390x/cert-store.[ch]
+F: include/hw/s390x/ipl/
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: docs/devel/s390-dasd-ipl.rst
+F: docs/specs/s390x-secure-ipl.rst
+F: docs/system/s390x/secure-ipl.rst
 F: tests/functional/s390x/test_pxelinux.py
+F: tests/functional/s390x/test_secure_ipl.py
 L: qemu-s390x@nongnu.org
 
 S390 PCI
-- 
2.55.0


