Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6ABC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJr-0007kH-0w; Wed, 16 Sep 2026 16:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJP-0007Zq-LU; Wed, 16 Sep 2026 16:33:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJM-00031L-Nr; Wed, 16 Sep 2026 16:32:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1QFd017615; Wed, 16 Sep 2026 20:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FuGKytLMs2BC3h9ds
 0S7fGLwYIr34qH+N7VVjas75qY=; b=gpTkwU8909m45vNFjOrKaKlyCiC0j0wsf
 rrMRdsyhLbk/I00M4uiJ4E+cPwKC/fn2OJi/7yzb/ZIgGUQy/im8q1/CRTZmUJso
 Gp8SCXSu4QjwvsW+FaG+J/TGEJH/0wiVwboE0Zd0bZcZapqsgKSq8mdvND35RhBi
 QDg76As/2BbktEYZk8xRRNt6pPX/t97PcSE3koJ33pEl6dK1dBPpcuArqzqxhQqW
 9r8ZBFpjYMBNsjW6Vp3xdrGJLcU8uzHjRgZPN7aBUI92m8hpPWu4alcENyjlwZ8Y
 uvAoOc4jkGXXXBVkzmjQpgjqrwVKP6AZQ1o/J9y9fZ3AlW0d3DQBw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf56vtw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GJ0la71699595; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gq03vgb05-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWkcY47710516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D45D62004B;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B720320040;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 816D916129C; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 5/9] vfio/ccw: Clear error object pointer after non-fatal
 errors
Date: Wed, 16 Sep 2026 22:32:37 +0200
Message-ID: <20260916203242.2509787-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DgSABzF4iJvsVuu8P3-VGxSG9sPKRMSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX1j1GYgCjGlk3
 uhDi892GRwT7Xza9MPz1g8o4Lqko0LkBb6s7YPTc8RB7ZI/mefXyapX8AU23UJYbfXX++KZ1Bqs
 NelRPmejfLzY26YU8VA72wFVwfVmhWs=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aaafcf5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=WuYEg3pJWr1ZmXxL5igA:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: DgSABzF4iJvsVuu8P3-VGxSG9sPKRMSJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX26mx5RET8Ui5
 Fh+i98gLkx5yl7uHuM8wwGjQcTdXaNb6OogTwF0MIJcXJhvJmL8q8OG3KU6oz6dSP4vCiSPE9WW
 TV2C4Kr13gk0fKY4nOeoIoxMi9WpHlKVrAfotm0XA2Vz/Hd+fJqBWf3qtutzFl/Ru+EDN02Mjtb
 ZJYaxZAENqYCROywlscLRReaEtKoPqK8IK2s6j2nlhfbi0Gukb7MLBiHydE6uKK+P3bnLTiZqGw
 JA/JCNYhTE7siuG00rGqaczLZz5zS4x0vnAcsF/RXL8mdeFfA4QxieGqGKkrP0vXFDHCI5ENuSu
 u+44B+NYQhdo0oz6VpKL/m8+i0x6mD7xoX+qUoYtE/XePIaxnXIMrMZS0Tqfjz997UyxqzgtnzK
 fkslhQ14ETvtHTMvzDf0KONQIb76t7SsJBLMO1KPdvFP+rwj2GGv7fbru08Hbq2lyEUQ8tUb04i
 YH7e754Y8tnjopCkzeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160285
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

Just like in vfio/ap, there is a non-fatal message that could be
generated, with a stale pointer in the error object variable.

Unlike vfio/ap, there is no secondary message that could attempt
to use it. Clear it in the same way, in case that ever changes.

Cc: qemu-stable@nongnu.org
Fixes: 6178d4689a ("vfio-ccw: Permit missing IRQs")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/vfio/ccw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c3dc7c1962..8e29a3ae61 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -604,8 +604,10 @@ static void vfio_ccw_realize(DeviceState *dev, Error=
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


