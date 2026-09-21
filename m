Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051C3C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8izM-0005NQ-8R; Mon, 21 Sep 2026 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz7-0005HZ-5z; Mon, 21 Sep 2026 14:43:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8iz2-0005zp-9s; Mon, 21 Sep 2026 14:43:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8B3v1869514; Mon, 21 Sep 2026 18:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hbKLXDVe/JdietrQf
 g9C30EtOc49ilGcFKU3mWEKI0w=; b=SiaPMxcfZMlPgl2oO5PTiMkb0vLmTC4YP
 mTWx3TM3dKeQQ5VWrOLWKrCyUC9pTjDYGjI66f5iJMiuYf0mcwa4qRnPchNJNu5R
 vQO1viXY6xEfpZ/FhsXDi9Fc5Ok8CoQjmUJj+fSU5dVZ21Pe18qsGAZaOIMJQczZ
 hmzGt0aGYzpsk1RVLJmoHNxis5QOi29FM4mV+oTsp/cWzbZ7y7KM0vkvtzDWKydY
 B58iIYZl1rvs4FrifY4HL9Q7ONEnGnwchJEjzcDHnQJc9P2H3wT1j/UGiPXKCNH0
 DT93XrKWcXbrvneX3jYznVOVTBFK+A7Z6HeYipocX7ca+3o6oVRQA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs2721-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LFHkhH167243; Mon, 21 Sep 2026 18:43:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bk96a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 18:43:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LIh9P646727552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 18:43:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B33922004F;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89B2D2004B;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 21 Sep 2026 18:43:09 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6E8A5161DE2; Mon, 21 Sep 2026 20:43:09 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 4/9] vfio/ap: Clear error object pointer after non-fatal
 errors
Date: Mon, 21 Sep 2026 20:43:00 +0200
Message-ID: <20260921184305.3791311-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921184305.3791311-1-farman@linux.ibm.com>
References: <20260921184305.3791311-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab17ac2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=rlruftgHjx7kiOjKd_sA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: oGK8ntajq5wZYkur7l_mvT5EqDEQyhUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX1l/wA93PhuZi
 RglJNBdPhRxJJNrbVed2PL7ONMCA7ok1HOzZZBtOibGenqWxJqSog+j1YpCZoezEaKte2i7+nIl
 /3vEC+adi7v6Oau4xdjqQt996qPkOKj604S3BXB9p/TqC2fhOGWrTohQr8VuA3viY1YE2VwXysM
 WvPLdizKk1X/eGN1Voi3iUGA6fPwKNR2HaAv0NOWZgDcYMv0venZ6zGEXvcflZM0p4EO6yjbU/7
 3dHOKnOO3AQpw+oAtLEWq4QDCnMhlatVOxeC/2QLpAk0ruQyQW3kOjBghCTgMn8WLNZ5NCI/bi0
 5YRbTIT0MPBKx5ciUg+g8aUnpBlg19k3Kx0TjXXPHpdBZdTHLDA0f5DVXREQvWgCXqg7aGoQcNf
 dE1D2qcHnWLgfS63ri3bCtAoTcW5YMjDScCWG3aMDIxdD47dX/IOt9e/DIR+AWX+uiLsZo7/m1Z
 DWqzQMdLuU+gI3cAYPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3MiBTYWx0ZWRfX3QG/gCsSl33k
 27947Puo/PXrr2PcwJ2OK8PfA0aMU2qFgv696dCIdmiYkHWAdRor6CMHiaJv9YDknAok7GVjhUZ
 C2uJcmRaOdqGCJwmdBjEVmFzhoeWNFQ=
X-Proofpoint-GUID: oGK8ntajq5wZYkur7l_mvT5EqDEQyhUM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210272
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

Registering a new IRQ notifier will allocate an error object if needed,
and warn_report_err() will release that memory once it's finished.
The pointer remains, however, so subsequent errors after the non-fatal
errors in vfio_ap_realize() would cause an assertion failure for a
non-NULL pointer.

Fix this by clearing the pointer once the warning has been reported,
to reset the state of the error objects.

Cc: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: 1360b2ad1f ("s390x/ap: Wire up the device request notifier interfa=
ce")
Fixes: 0fb8a62fe4 ("hw/vfio/ap: notification handler for AP config change=
d event")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6e2a1223ea..2926e04ad4 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -247,8 +247,10 @@ static void vfio_ap_realize(DeviceState *dev, Error =
**errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operatio=
n.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err =3D NULL;
     }
=20
     if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX=
, &err))
@@ -256,8 +258,10 @@ static void vfio_ap_realize(DeviceState *dev, Error =
**errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operatio=
n.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err =3D NULL;
     }
=20
     return;
--=20
2.53.0


