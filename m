Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B88C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wJi-0007eg-U8; Wed, 16 Sep 2026 16:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJN-0007Zg-Eu; Wed, 16 Sep 2026 16:32:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x6wJK-00030l-LN; Wed, 16 Sep 2026 16:32:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1ksR3041641; Wed, 16 Sep 2026 20:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SdT/JrjvbwyWVjNyd
 lot7w+cYAfHbMY4DmT/koQ2fr4=; b=tlETLle5DSdkHLFECTV5PLRoFbJlSnfej
 0fbRlPCUD+LqHrhX7kKBo6bZfHWMATXjl6EfwJ/KtsTVnaNe10bnPeOkVxZYDZhb
 KSbg4PsFiQIr9FcAIpGeCUxgFF6xYi64vL65EK+yCIWLORQc+f/0s8iQ+zT8n868
 4RP/8bFRrhLUB7sVZe4ltLljdqJpxkkMiKpfcBUgcH8P5DtMXgmM0QSBJxoJTz+n
 ZRJ3zSXB+e1/3L1cV4dd45qL7Ms2m2UcxKNJmtmxTrpRpsYzzkNNUYruikvM5WYS
 WNa6QTonFYQBvcDRwy+vVT+atdKTRrK/kSTNy/atQFlDBjnx6Rr4Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e6jwy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GIxgaG1649278; Wed, 16 Sep 2026 20:32:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03c0b4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 20:32:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GKWkbp42205612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 20:32:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D81D12004D;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BADBC20043;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Wed, 16 Sep 2026 20:32:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 85DAB1613EC; Wed, 16 Sep 2026 22:32:46 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH 7/9] hw/intc/s390x: Fix check after g_try_realloc
Date: Wed, 16 Sep 2026 22:32:39 +0200
Message-ID: <20260916203242.2509787-8-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203242.2509787-1-farman@linux.ibm.com>
References: <20260916203242.2509787-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX6B/hlszrjDkC
 /4G9hdKjPo6x8VU51FOObXswVKKu4dRwJSvWA8uv2CRVxWrJxEaTLqHFkB03k8fAoETk9nnbnTC
 UK4rMy+5KPVLBrSn+/x4TWaWl2ZCiUS4a/eOLJaW5YA8SdwY9Qoxo6+Y2MUzJFR2a4As/gjknrK
 TwBaC0YTXqbPPnmdLouZfzp8hYn2cF+XvA1fbtuW/shz8KjiyV7gBriLQA6wpmoEBGsD/Kha5x7
 UsL8px2qh9F9LQateyvn/Jd9wqLHHMBo8yyWyTSwFES7P9VWDJuKOQaqWPglb02F82BctxHxGtc
 uAwsPd5fd81HcaJRFTEPV1NoCFaAjUmuXCTaupNG+yKzvpki3191lfaVRIDSa5LFF6VMtKK/vXP
 d7XIvHBMiNnTFn2BlHH7IxgnJ5BmMrtwTCCRzTVpoWkhLFUdWt6H43wctlB3jjiFbmVSUnUmiRo
 wQumcyEqYiyA7rVAXDA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aaafcf3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=ye_SPjtrCc-UUvtwVFUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: n5-MkZ8TkFUTwuANm1CE7pW5lz480MZJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI4NSBTYWx0ZWRfX4Voz3CJao9q/
 AVF1nowIzMfGurH7DvErPzFmffAZWLFpRKP4L5zeqWrxf7gTeAwj/jl00mDXvjpj8AR1XMfM5Vb
 OaHrKdNZz/pO9vmvXOGNforBAoR/Dxc=
X-Proofpoint-GUID: n5-MkZ8TkFUTwuANm1CE7pW5lz480MZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

The loop to store pending IRQs uses g_try_realloc() to expand the
buffer being used, but the returned address is stored in a
pointer-to-pointer. Thus, the check needs to examine its contents
and not the pointer itself.

Cc: qemu-stable@nongnu.org
Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller de=
vice")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 5e6d422fba..ce9c720512 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -264,7 +264,7 @@ static int __get_all_irqs(KVMS390FLICState *flic,
         }
         len *=3D 2;
         *buf =3D g_try_realloc(*buf, len);
-        if (!buf) {
+        if (!*buf) {
             return -ENOMEM;
         }
     } while (r =3D=3D -ENOMEM && len <=3D KVM_S390_FLIC_MAX_BUFFER);
--=20
2.53.0


