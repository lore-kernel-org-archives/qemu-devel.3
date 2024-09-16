Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B283FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 10:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq8bF-00047f-2E; Mon, 16 Sep 2024 06:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sq8bD-00046a-5A; Mon, 16 Sep 2024 06:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sq8bB-0003kt-Hc; Mon, 16 Sep 2024 06:04:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48FLu3K3001735;
 Mon, 16 Sep 2024 10:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=4
 EUo04ockDsPOFSUJJAB/IowIoDMmzJHKkbC9w6u//k=; b=iSSIGnWD8bY39BelA
 lAxuAEu/1j4wcYvVT7ctpQ1H+rjM1Z7peuIcq3cXKb4or0BvHgpXedyrCjUENh4Y
 zKoxWx4tlflYxBEZHmvvNDW6sBc9JUjgZ8lMRczix+D/jaT1YZdU/znDnDoXW6DI
 0+hsYOfd4t12X/GAMBJJq3euKlz1rNwtDE4bLdYGoz3iveRG2vJ3yb2t8e6KTa22
 lCHRy10Z15CmZcBkfLEWn1RzLTQbq+aKw8xrlhJpZxpOpBQDNaE01YZue0646dYz
 BmCAskW42QGejrmWYv10lkTiltPCAagFct4Kxcs96DWqP1+pkYvn0Lon/vgl63ih
 MKUmg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vngtm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 10:04:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48GA4ZsO031377;
 Mon, 16 Sep 2024 10:04:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vngtky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 10:04:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48G9v51e024699;
 Mon, 16 Sep 2024 10:04:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1mp84e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Sep 2024 10:04:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48GA4USJ57999698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Sep 2024 10:04:31 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFE7720065;
 Mon, 16 Sep 2024 10:04:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3AE720063;
 Mon, 16 Sep 2024 10:04:28 +0000 (GMT)
Received: from [9.113.207.171] (unknown [9.113.207.171])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Sep 2024 10:04:28 +0000 (GMT)
Message-ID: <bfc954e3-554c-4942-8772-0206ebecf721@linux.ibm.com>
Date: Mon, 16 Sep 2024 15:34:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com
References: <20240807202804.56038-1-philmd@linaro.org>
 <d30b16a2-a45a-4596-bef8-2eac898a00e9@kaod.org>
 <d93476aa-d777-419b-90a2-b50bb2d861ff@linux.ibm.com>
 <2f888d59-b2ee-4fe8-9193-728f322fa132@kaod.org>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@linux.ibm.com>
In-Reply-To: <2f888d59-b2ee-4fe8-9193-728f322fa132@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QXccjWpp_B1W2yDy2piUcvgQvMauDUUP
X-Proofpoint-GUID: dmuIl4vReXXWH3mKkKT94ie3L3kQAoDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_06,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=827
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409160063
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 13-09-2024 19:07, Cédric Le Goater wrote:
> Hello,
>
> On 9/13/24 15:24, Chalapathi V wrote:
>>
>> On 12-09-2024 22:25, Cédric Le Goater wrote:
>>> Chalapthi,
>>>
>>> On 8/7/24 22:28, Philippe Mathieu-Daudé wrote:
>>>> v2:
>>>> - Cover PowerNV SSI in MAINTAINERS
>>>> - Use GLib API in pnv_spi_xfer_buffer_free()
>>>> - Simplify returning early
>>>>
>>>> Supersedes: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
>>>
>>> I was wondering where we were on this series. I see there were comments
>>> on the initial one that would need some response at least. Do you have
>>> plans for a respin ?
>>>
>>> Thanks,
>>>
>>> C.
>>>
>> Hello Cedric,
>>
>> Thank You so much for reminding me. I apologize for not getting back 
>> on this sooner. 
>
> That's fine. We have some spare time before the QEMU 9.2 cycle
> closes. I'd say ~2 months. Still, it would be good to address
> these issues before adding more models (Dan's TPM device model)
> relying on it.
Sure. Thank You.
>
>> I am working on the review comments from initial v1 patchset and send 
>> the v2 patchset ASAP.
>
> That would be a v3 ? Since Philippe sent a v2.
>
> Thanks,
>
> C.
Sure. Will send v3 for the series: hw/ssi/pnv_spi: Fixes Coverity CID 
1558831 and

a separate series for resolving Coverity CID 1558827.

Thank You,

Chalapathi


