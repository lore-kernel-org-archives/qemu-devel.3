Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F445C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJn-0007iV-Tr; Wed, 16 Sep 2026 16:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJP-0007Zp-LL; Wed, 16 Sep 2026 16:33:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJL-00030j-Mg; Wed, 16 Sep 2026 16:32:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1gLB4057271; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=N1RQqv8BerfSGHh2m
 j70Qx4yNG9w4P0djTg8FoWU7Ic=; b=l4CM9snabKSrZ0AiJgylItJaE3izoCa40
 oPhe/PduUU6nIuEenWSHB2JVTMzmzenFQ2V/uqurQkST9DNVvnEmhqPdC8inSRNO
 vMK0PaPS7XvZNF/hcX0sejB3SZ6IfxMcvttstRQSoRt+688mh6hH3N+3qNWfRy6O
 Kv0N5ATFCm7k72VV3ajANrVXC/THZNnWK1XoTW4V840c7jcwjOcQuCXcHT/qFitB
 b9aOkB64mANhFITMne4EGTbGInbq8A76DF2Wfvr7be8gxGeIoAfeVVcVkE721LtU
 spI+cN6scwEjp2KV83eZuXeNhyiFE07kl1Jl67E18e4beZ4Jpq5rw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hxs8d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIv4pU1663487; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq089r9rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWkO641353494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B702C2004E;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 984102004B;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 7F73616129A; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH 4/9] vfio/ap: Clear error object pointer after non-fatal errors
Date: Wed, 16 Sep 2026 22:32:36 +0200
Message-ID: <20260916203242.2509787-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX/va+STHw+6lB
 ztCZeKq/4T7nGpUTgFmOBvbB3La/ScyTTFhPy+9Emk30HLxXI8BliNezw0LSHgxqXPW4VVw/WeQ
 9a+OV6sjkp4pkoQygsVEqX/aveUTeFVRPaeTgltq5fbhTeXjaITgesnNwUhEhjNJUBlemIsrx4R
 wKzOEofgHvHR+g2cXlw/fMutRBxeRJcwO26/kWoRbZLqwh3NJSrrQ8dWOoqcRiLDfjbhM2clGTE
 xyixNkEi8f8IvXkFJh2x7ba5T8MpVdVrgEm9lPlvRbn2mOhNpwyPoRyWma0BjCc1APEez40KB2Z
 uLYLwZelPhstPK9njATMzWgVXV/aDS6S2zd+pdv3FmaxBH3l/3JY3moxonOy0TRA5irV0M6oZNl
 2gsLMBqyaqH3HsjY0O1+XXAiVLd1MRqgTgYi1jP5cNoBmmcSjAwmXikN7XkKj/Up65EHDYuWvRC
 fofrzmFtaixeURWzX+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX1acdV/6F80/I
 9iIxl8zzwq8SK5uiREndUashXmIfPhdmojBjbHURC3BQp13wIv4bpAkcJYWm5ZIy/NX2fXbRW3o
 Dtxm7dttIlp9Wt5s7oFax4ZNwAk8dwk=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=rlruftgHjx7kiOjKd_sA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: mzcf6HZHWLuhAP9_v42POIhXh0fYlegt
X-Proofpoint-GUID: mzcf6HZHWLuhAP9_v42POIhXh0fYlegt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160285
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


