Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf8Iu-0007pK-SC; Wed, 01 Jul 2026 23:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8It-0007nm-Aw; Wed, 01 Jul 2026 23:41:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wf8Ir-00006h-SI; Wed, 01 Jul 2026 23:41:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KYY52347186; Thu, 2 Jul 2026 03:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FUJNlc
 XLsvVjoIrA4leluus2yZjBDMj+HWg9P9s/QnY=; b=YuMw6Hfrsrn0uqYesykpxH
 tluM3m8/sGsFx/UbR4lj+YJ5PEdzVX3ZI7DQh8OWJRlDvn5K+Y/h2pZUYj4PwOgA
 rfIaKtOchNTthGi6bJW8Y4aWiFAG1smLhFjZP/GvRW/AV/9E5mITzrTrsDePjcV2
 xzKhNoaYZ8ArZwSy+ucJW4/ksDa4gy/b/RQTSmT43wAT5TMrEWrC9QW/zn6Hbqti
 9WaxtAKS0rp44xtqcmRFY3etFtFewwD8iDpdpaYgp917YRFkKo10R7KbHxXeHjlE
 ifM70oV51B0xOEs/bCXk+BVpB+1AZb57R7MwwWeh/czFw9NYrr2lM3WpiY8UV5QQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjyh6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:41:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6623YbUW017573;
 Thu, 2 Jul 2026 03:41:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suka8mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:41:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6623fN2X22217240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:41:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69DAA58055;
 Thu,  2 Jul 2026 03:41:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB22A58043;
 Thu,  2 Jul 2026 03:41:21 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.136.69]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 03:41:21 +0000 (GMT)
Message-ID: <8886009ec286f0682e4fb3ca82f262f7fe12e326.camel@linux.ibm.com>
Subject: Re: [PATCH v12 09/35] s390x/diag: Implement DIAG 320 subcode 2
From: Eric Farman <farman@linux.ibm.com>
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Date: Wed, 01 Jul 2026 23:41:21 -0400
In-Reply-To: <20260701204922.1320349-10-zycai@linux.ibm.com>
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-10-zycai@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzMCBTYWx0ZWRfX8TX9iSGPAtFK
 A0SL09dwsqV5UUpgKOQSAJ3s39qhb8/VoksJLFQUs9iJSNXBhXoCMuEEdflTPrOnUNvz1Hlf516
 CYLTswxIbKt9Ek+K3I0t1Yd2FGzTlqZy4zduLj6Fe0Juad6BgR63yLnn2abqyi6hk6ZWOCksFzH
 uzSi5LZPxOk4eL9HfrUGnQRQb1qUKIbYFwHws+bdAmC+0ILai3ztA8SW6BjtPW6x1I2xyf1Y8Ra
 IchEZka+d6pfA0t3PIhBCRYN70s+UErCeJqu6cAFzGKqvaxfxR/vCmk0mutuYckKZ+wDIs5aZoA
 Y7Ngv3ZmDYTN63p4346smqV6hXUyv9lMh7z62bS4wuhBDZ3yhspHOW4eMwpo98CiP19dPVqS+/o
 eNfFnAKtiFGPFYOfniFk28jZsENWQRw2WlmweoefbfraXFMoExhMf1MueAP1gxwa6NeEsvsLUkI
 0DaVVA+ZZG7sqWinYcg==
X-Proofpoint-GUID: yjle8emY_PirRmOe9YtxlkyUuDXOcrQi
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a45dde5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=hHZIFWYFNaKudbiwD8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzMCBTYWx0ZWRfXxxFnOVQYgADg
 vZqAhaHpi/jEodaD3DMUg2t5hamfq/Cr1Go1tkUiO+QmbdQPL7X3GIpDVQ/FLO/YRVcfMq5qzHT
 uGWahUwEON3RV0hD4JqoDid8YecRqJk=
X-Proofpoint-ORIG-GUID: yjle8emY_PirRmOe9YtxlkyUuDXOcrQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020030
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

On Wed, 2026-07-01 at 16:48 -0400, Zhuoying Cai wrote:
> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in t=
he
> certificate store. Only X509 certificates in DER format and SHA-256 hash
> type are recognized.
>=20
> The subcode value is denoted by setting the second-left-most bit
> of an 8-byte field.
>=20
> The Verification Certificate Block (VCB) contains the output data
> when the operation completes successfully. It includes a common
> header followed by zero or more Verification Certificate Entries (VCEs),
> depending on the VCB input length and the VC range (from the first VC
> index to the last VC index) in the certificate store.
>=20
> Each VCE contains information about a certificate retrieved from
> the S390IPLCertificateStore, such as the certificate name, key type,
> key ID length, hash length, and the raw certificate data.
> The key ID and hash are extracted from the raw certificate by the crypto =
API.
>=20
> Note: SHA2-256 VC hash type is required for retrieving the hash
> (fingerprint) of the certificate.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>  docs/specs/s390x-secure-ipl.rst |  24 +++
>  include/hw/s390x/ipl/diag320.h  |  38 ++++
>  target/s390x/diag.c             | 317 +++++++++++++++++++++++++++++++-
>  3 files changed, 378 insertions(+), 1 deletion(-)

Besides the g_free() that Matt mentioned, the comments I would have for thi=
s are purely style-
related. So,

Reviewed-by: Eric Farman <farman@linux.ibm.com>

