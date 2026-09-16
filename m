Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56039C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJf-0007dI-6B; Wed, 16 Sep 2026 16:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJN-0007Zk-Si; Wed, 16 Sep 2026 16:32:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJL-00030r-EB; Wed, 16 Sep 2026 16:32:57 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1c1P4057226; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YRQ6iUSta7ErXBwnm
 9x97G9tni/Xu3rWpcGEXumEoRA=; b=sVPQWHNKK9UV3U8wxMw2juJNzH3UDOY5y
 gNDBxs5Ayip7U626xiOBRfO+yINxmfjVvNSUkgaqroc+XXAvgSjhAca2zeJ9Kkvg
 38vUxfab3sHOCb1muJc0Ejm6u4UUURdzfZAZRD+in4Mc+UeY+WTR3gFYBeEo8X2c
 1tB+VBEHYVHciCqL5Qk1LklmKM9FuKzlhtcnbdPU66zBtKJ8yxELrjhvpdDHxs/G
 Wsux5XwSbuU/9wbJVJL/ieTJ4BnyT10N+r5+Cvph7Q+9kRM7rstqn6S+5+4ZEjxw
 tBdk1QE4KXOCKpqebefuz8A73adoRZezZl5OxEcMIadKgf5wlOSvA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hxs8c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIvu5d1712957; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywf0cqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWlnT47579530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E37F920043;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC5D32004D;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 838DD161392; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
Date: Wed, 16 Sep 2026 22:32:38 +0200
Message-ID: <20260916203242.2509787-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX7ZAVhPwRqAGZ
 HWbRG1C+xnCtWzjp1Xjb2CIfWmhaS/ynA4B0oyJae61IBXetekX10rgJRMPPqGXRneEwfECUPSL
 g+TlPrVp3DO6rkmwkmYicxkCZgPxF+G/Y9hS3FzuM9tWqb15f7T8TrJlZa3VCcXUgXKW5qX6O26
 TdaFbItpzKpgubGaYRqUl/NccNn6J/38MlPFcgFi4Y9645AZHus/5qq5lBlxF1izYWgrTbJ45QR
 PmOhmxx5d8Gq11IgUSr+MSN2HFNGWYV9qQmE+C0uDg/nkHVsk2t/8NsQZB+IA4YikcCDYXiXbyd
 UaTZklGQwwybep97Mds21M/9KH0RufHmEBU1ymUHGAqcTXkhmoW6UP8b9e9GUqfFvAarmXeDxiW
 fjPu+qU6LazRjbyijnIuo/hH0HvxcKU/5o8fnaFR+a9Qhu5jihKFWOpYuwwX/YThH+y9ry9Syau
 IHXKiRA1gM9sopR3D8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX09kBjP5aoX3u
 MtVJQVyXnx62OMIBNhp2xkRKau9gAAS44Wx984+VrC4dgP0b95utOjqqXlbraQ65Ceg1KlXHrvi
 1bjtwyw00UtNz2Q1Y6QyvW+qrH9eoys=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=2qTHi0OtVRMbIpyvczcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 7Xdffavw6FG4gibctbO-XWaeCFV2Baj6
X-Proofpoint-GUID: 7Xdffavw6FG4gibctbO-XWaeCFV2Baj6
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

The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
receives the contents of the attribute struct as its payload,
rather than a pointer to the payload itself as is convention.

This may result in erroneous errors from the ioctl, which would
result in clear_io_supported being false when it otherwise could
be used (which is helpful in device recovery).

Cc: qemu-stable@nongnu.org
Fixes: 9eccb8622c ("s390x/kvm: add interface for clearing IO irqs")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index f833a3996a..5e6d422fba 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -633,7 +633,7 @@ static void kvm_s390_flic_realize(DeviceState *dev, E=
rror **errp)
     /* Check clear_io_irq support */
     test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
     flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
-                                            KVM_HAS_DEVICE_ATTR, test_at=
tr);
+                                            KVM_HAS_DEVICE_ATTR, &test_a=
ttr);
 }
=20
 static void kvm_s390_flic_reset(DeviceState *dev)
--=20
2.53.0


