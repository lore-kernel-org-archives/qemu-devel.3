Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69361C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vO-0000GD-V8; Tue, 22 Sep 2026 16:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tu-000823-NZ; Tue, 22 Sep 2026 16:15:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tr-0007fg-Dh; Tue, 22 Sep 2026 16:15:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI86R3966047; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=hbKLXDVe/JdietrQf
 g9C30EtOc49ilGcFKU3mWEKI0w=; b=KqY7cEU8KrzDXjECIQSR74hn4ouqEOXQn
 JFV+OfAvlvpU0BqoFpLPhigh7JJk5gyKMJiyuGhmFAm1AcBkbFwSuckRvX3ZivXi
 VGruUWBLXZfcWcnHqUHh9dLjD7FntUou2MUEGsKi02SGtxCSWCdwVJ2U8vImVrZv
 Rdp4WoTrmDAiKtjP1cMi6bqV7EHhKg8wJm8CzWCs6BBo/JGDCkgIrh7BUdorRHM3
 OS7lcUf6gXNO0XV7c7gCvRI1+PRLbLqB6mAbenZYeB++tXy2MLoozmWyCwCXVzwn
 hav6cNFw0ulcstIo4pQpBgFmZgXetWMMjV0flLMPCTbMi3olF5AUA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fgds-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHYTm3198577; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjuba2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFR5Y46924154
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6FF120040;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 821712004B;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 65342161561; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v3 4/9] vfio/ap: Clear error object pointer after non-fatal
 errors
Date: Tue, 22 Sep 2026 22:15:20 +0200
Message-ID: <20260922201526.2383047-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FVRxDRKOTw7HzR2squYY0FV4bxhq6gKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX+Af+w9RoWuFB
 H6PRMlDVyTUr1cHNyTLrihGT5Ya3XneScYmzXBbroiVmjW5hMN7JFO4HxjxbfGrQLkjEwPKY/aw
 ZIJzG6B7smtONHmlApPwUxM6RoISdK1U31iESd2r5THaKAvyDEkxgLCJiqWgEw9dCYCzrW8XPiP
 /77VJD/KpBksIIoiMxjTg9G4urlQ1MiKcJW//nMLl7z+5MFZubJ2mtFx9w88ygJ/GxhVa35OZSJ
 7FFOswv9IcBPhtGi0+pMs3pwyc87QJKX9nHyWeD+NVTa4qou9xOwvr1Eep34/Oo7Y5EaC+6svV2
 lTWVNZCp96Yy3xGUV91MqUpEnmXrxw5eNjXbqjaYadYrJMPDTqjEHNX51eMrcEYZp21d+zZoFi9
 zomSAxUAduYk0SCJSECTq44toVzebslZzuUx/pCLt0Se7b7IHMUezAy1P7ar9gXPqs0dpgSRe+1
 fQdJK0sEICviPiYvBBQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=rlruftgHjx7kiOjKd_sA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX/ZwtH9UH1A58
 yhUIpLppSmvrMiBkqOAe48bAgEfMPMR4UPenxqPkTUzZUEyHVfQAdGoOGmEeD3Ylp82tl0UGG/X
 YS5YrspniQpUra3r8tG2fNjoqst70sM=
X-Proofpoint-GUID: FVRxDRKOTw7HzR2squYY0FV4bxhq6gKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220293
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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


