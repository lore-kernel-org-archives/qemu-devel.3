Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C06C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtCc-0001pD-Cw; Mon, 17 Aug 2026 05:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvtCZ-0001od-P3; Mon, 17 Aug 2026 05:00:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wvtCY-0000yd-7G; Mon, 17 Aug 2026 05:00:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLWLlF3781469; Mon, 17 Aug 2026 09:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+epRt/
 qT6hNL9RHH1FIo2Qx4P+Hdz55gC/aQpn47SoI=; b=l/NkzAQ0CvbxkP2Q0BT0pI
 tCbPPGe32FvC3rDbvqICCnDL61xTEB8KyZZX4TpHUWOdk2Pggh6gyGw7zHjruZy5
 WcIp/CI1V4SqnJ27INJpd0n4D9Xv1sQ5Xphbqh79WzT+s0WkctJiAjvqtqFmalrk
 dDpOl5oefHRoHH9plj5h5OE6BIl6DyHPTKi3/rYBeALSQ9Hzyd+Rs3VpnWhquq7h
 qGZNJw/8xiNAqBk5z8R5uiWR3+DMjlKnBMh3NgRDIxyos0d+e5bmLoJVTxmGKbBX
 1w16ZTj5rZB7gQwtYRBtWn7UyrmyI/mI/t/3xJ7Zg13Cdqau8rxE3mR5rYAiZylw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt11dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 09:00:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8uRln016330;
 Mon, 17 Aug 2026 09:00:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y50fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 09:00:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67H9057n41746770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 09:00:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26F4B2004B;
 Mon, 17 Aug 2026 09:00:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9277420040;
 Mon, 17 Aug 2026 09:00:04 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 09:00:04 +0000 (GMT)
Message-ID: <e42723bd-84b5-4543-a1eb-5668d836f16d@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 17/19] target/s390x: Support protected key AES XTS for
 cpacf km instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org, 
 david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org, 
 dengler@linux.ibm.com, borntraeger@linux.ibm.com,
 fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-18-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-18-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a82cd99 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=fyHvZGQlsBxjgjT89q4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2MyBTYWx0ZWRfX8OSB2uaY+K5Z
 XaCOWT00vzYtno0JCJVbON7QeTGEkiFq++1aROzJA/DeWiVTh375ePm3lxQAtQ6N43ms/Ib7iBa
 V1WjBCdVyAIc4USchOJagitGT2wwW1c=
X-Proofpoint-GUID: sAHlVmODxxd962wLRphRiqhqOZWrfEZN
X-Proofpoint-ORIG-GUID: sAHlVmODxxd962wLRphRiqhqOZWrfEZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2MyBTYWx0ZWRfX1/zi/Q+QEE0V
 Bvc3b9F42R2HObEJYSmunIJxSTuQzUBRXzDoaMzGfrDFJDtiy7BhYj9XAXwNo41a4gTZcdVYzhQ
 c3KGpteCKy3oc5bpayx2KEuZArHA41EhagqLKkxIlEBaNBBiNA9cazuagoBCkyOAhrXqru/H71c
 i4tctgUUhser5IHs+v0DKHRebuhXZbEsNakj9uRJEhyf+ati61YnbkrNr2WTcVc0Pp+nC0cqAcr
 GbwghXInwkn19XbJ02GIl8tthhzSKojynE4EE1/4P65uqK5KggmQl0x6O+BQvDeqhJt84J6OE3f
 DC8pxejh5po/USmAEIcwPmG8bVjnS39GRWebpPBi7KYO+CbLzMgIpLYb7xcsx+u5zjkGFS7YTUG
 EW37+qmUSNT2FsSzkUZGB17OZFgHrvDfSQ0Bd0jJWtLgCcaZ+H20ozADVf6+r0uDIKmaxTsrfBP
 XkW2rvHCQ9bjpteZp9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_PXTS_128 and CPACF_KM_PXTS_256
> for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  2 +
>   target/s390x/tcg/cpacf.h         |  4 ++
>   target/s390x/tcg/cpacf_aes.c     | 93 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  6 +++
>   4 files changed, 105 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>



