Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D883C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96vK-00008t-Nr; Tue, 22 Sep 2026 16:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tu-00081v-5Q; Tue, 22 Sep 2026 16:15:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x96tq-0007fa-W4; Tue, 22 Sep 2026 16:15:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI74Ao4143497; Tue, 22 Sep 2026 20:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mkK0xTEskoCAyutOO
 i+o0+xNrxuIKwK4f3orGfmD+0I=; b=UqXXWBxc8BPeeOo/A/aru0A3lvWtrsMCC
 Knq7uma0FOg96+OVw5haSko6uqbwBbwtTJdJkfkDxB3K/bLbfXLzrFhnkWM8lcHU
 5kF1QWKrh1tcOjxdBo1zxsKf+UZ4pEpMZxnd0beW4m4uOzEq6w/3jpvl1cvJDbEq
 ya7L1yF63WNFhbV3CLdKT7oLbHttxFgrDYDnaOLjUrmnTEyg3E0czdzrRxvE09o8
 BRCHcQSIUCq+sgpqaei3O+e9CFlC4frPeRP+J4Aula8vlNnJoK6RTDSR7CtgYBIb
 vg+CVFluIboVlfqCfk+4xv2gIvrdsX3lb4aUHaZ0fjapU7YUJZ0tQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqfd57-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHceK3279472; Tue, 22 Sep 2026 20:15:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqbfe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:15:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKFRab26673550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:15:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B946D2005A;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E2A22004E;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Tue, 22 Sep 2026 20:15:27 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 6A16F1615D2; Tue, 22 Sep 2026 22:15:27 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 6/9] hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
Date: Tue, 22 Sep 2026 22:15:22 +0200
Message-ID: <20260922201526.2383047-7-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922201526.2383047-1-farman@linux.ibm.com>
References: <20260922201526.2383047-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2e1e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=cb2EWknS8209ijoe3xIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX8DLLxDBl0eCS
 zXSIobuAS5t6oEFuu9etUUV8dLa7zHkt9L8lrmH8e9v7hB6Tyi06+RWJi1bV0bZeIBoHSu/IMXO
 RCiG8dCnDfkAzc7dl5X9pQkkZZ9X2qGYSn6Z/gaB7MuI8RmjnsdxssOpev+wRbsUMbkBj3BvT2W
 dRW+wGCuMZMdXdjKT6vZfGArqgfv55rSdk46V0paoov2nCuspZmq3grI8zyHgDgllcwHIp2VgrY
 sTsQyojGFVDyBkhMCbK5+p7GoYRZQZ8jZoBeNcqIl0t+3vbGA1rgJdwozlqHPeks/jxnIpZ52Na
 owsdiJQPyBCytJ9tzqF7E27RxPnqqzsb72Nec0/r3GA78/uUNtdEBNq2UObOreyUNpi8jryFqki
 n7IjIaDZ93ssemjVVq1YmjOvxq+CHjgsTzPbgrtaeY0Z+2VKQIw6yLTipEeCLTgTGZOz6FtwFkt
 AErMkectpCWPR9KdBsg==
X-Proofpoint-ORIG-GUID: AdLDTlLL2wmf81QHKQONV-bco-3gDKhH
X-Proofpoint-GUID: AdLDTlLL2wmf81QHKQONV-bco-3gDKhH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5MyBTYWx0ZWRfX0boqVUOqpiAx
 USCZJnjzaVYewxsRavnOGqNd33olIl+/EOfDjf7CFA9o1pUjuAtWh4bjrT+9yfbWOAYH96Fg3XT
 ZGbaXw0Cz819vrQ3hcbY/683fV8qoJU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
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

The ioctl to determine whether KVM_DEV_FLIC_CLEAR_IO_IRQ is present
receives the contents of the attribute struct as its payload,
rather than a pointer to the payload itself as is convention.

This may result in erroneous errors from the ioctl, which would
result in clear_io_supported being false when it otherwise could
be used (which is helpful in device recovery).

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
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


