Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E74CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA7-0001jY-IX; Thu, 18 Jun 2026 08:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa65D-0005sY-Qo; Thu, 18 Jun 2026 02:18:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcallies@linux.ibm.com>)
 id 1wa65C-0008A3-B0; Thu, 18 Jun 2026 02:18:35 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HHmWri1000576; Thu, 18 Jun 2026 06:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xlbQHL
 7hfw4CBF/pPGdCMk7QbCL/frsMC2oG5PqMGgU=; b=W6XHLGglaHiSY/0apu/zKv
 7NzSSd8bQvtsKeHNHNp6sAlxjS/8MlgHiNt2Y/HwSy6jvuL/ke5YJMWLl9GM8qIG
 LDRhzMjo5dGLwi27j8kr6T523CZaCc2AvanDtW7I9Bhmjc0c7kYvCSQ0tGLUiJ0f
 1pSbf+Bd7S9UONEA+E5LeK62a1vaWCRERy2YjDh+ha8nZlXsAzapi2a6EJI8WdiR
 YaYduisksLWxA8Gfya4l7Xzx3ZqqerZoY3iL4OAc0DN88D5jG0pVY8a54piIvYaF
 1G4qUK1xuh2zuIP5FOaD4kLnixBPXXJV9ZNPnkNbaDClciOW+Vt68FXW22QCx+gw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6jpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:18:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I64ZSN013479;
 Thu, 18 Jun 2026 06:18:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1722b4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 06:18:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65I6IP0L58327332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2026 06:18:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8024120040;
 Thu, 18 Jun 2026 06:18:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E6CE20043;
 Thu, 18 Jun 2026 06:18:25 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2026 06:18:25 +0000 (GMT)
Message-ID: <e427e3ba-49e0-4daf-820a-62942173fd88@linux.ibm.com>
Date: Thu, 18 Jun 2026 08:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/17] target/s390x: Minimal protected key AES XTS
 support for cpacf pcc instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-14-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-14-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX3PMhdnl8uwWD
 FX4FkDLf6FecOfR+t1zJJU9MP7fQWKoU+YG2SDqSYOUih3HAE7epac6CqZerKtwguF8nDOUHe1k
 jBFI8rkyoaB5Vurme3SQVTJvALem08hbLfyULR9PTtBqHgMt3PGgXhtR/rW8+sIW5bcnJB1/aIz
 k8G3k4jcjBStVRA0/vxufMOemSbXfFZe62ffUtTTTtyqP1EZDhlgEMTyclQ2lf+IUX7rVDywnBm
 OML7sOX3GWLkmlFV3pcDUoIP76hv3PoXQ4ZNgqHi0lEg3CvmYxdzNV48QTygessB5tKuM3Ugl0u
 vcr00pNXcS2hPWm9AniW7kxjOv7GQ7pNBumsXaFyEH6uyV9rV5+5jQRRP3HCvzw2PNVaW/FYODD
 e/BT7p0XirptNxunTfjUD7UIdh809259+A9jzTnsy1ddawiEkXMTVeAXuVIMJelBFsRRRp5Lh/o
 qYUNOwWpMkL9rTQ5HNA==
X-Proofpoint-GUID: PdxUSfULzifwCStjajX1pFQQ07aBDkZW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NSBTYWx0ZWRfX1rKqhhFCJI6J
 yKdKfkS/1m7B6NM5+kqT5Bq1BkGjM4+KMr3Gw7Yos2U/e33STaCTdQbpU3bYn+JsXB3di69uAm1
 vB1xxTrBmJQ56lPXLTbLkssoafl3Ov8=
X-Proofpoint-ORIG-GUID: PdxUSfULzifwCStjajX1pFQQ07aBDkZW
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a338db6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=eUxyj7r3WZgfnnLVGjMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180055
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=fcallies@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support CPACF pcc subfunctions PCC-Compute-XTS-Parameter-Encrypted-AES-128
> and PCC-Compute-XTS-Parameter-Encrypted-AES-128 but only for the special
> case block sequential number is 0. However, this covers the s390 PAES XTS
> implementation in the Linux kernel.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the suggestions:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  2 +
>   target/s390x/tcg/cpacf_aes.c     | 80 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  4 ++
>   4 files changed, 88 insertions(+)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 4a131dc191..126bacb281 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -943,6 +943,8 @@ static uint16_t qemu_MAX[] = {
>       S390_FEAT_KMCTR_EAES_256,
>       S390_FEAT_PCC_XTS_AES_128,
>       S390_FEAT_PCC_XTS_AES_256,
> +    S390_FEAT_PCC_XTS_EAES_128,
> +    S390_FEAT_PCC_XTS_EAES_256,

EAES -> PAES or EAES -> ENCRYPTED_AES

>       S390_FEAT_PCKMO_AES_128,
>       S390_FEAT_PCKMO_AES_192,
>       S390_FEAT_PCKMO_AES_256,

[ snip ]


