Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A01C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRBO9-0003UZ-Uq; Mon, 16 Jun 2025 11:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uRBNx-0003E3-H3
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:04:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1uRBNv-0003fQ-GL
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 11:04:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GAGt3c019629;
 Mon, 16 Jun 2025 15:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2YB1G2
 vOmBRtX95y9h00Z8qf8jZnjoKFVCPiGlmKpko=; b=ad2UGfDy5Hn46LoQT3tZP8
 l8qBO+R7nrd2KJYIfTpHuyvFj8oWnQey0TVLdXEY5y9C86kMhT8G4efqrKBY5Tw3
 GmA6Y2xSBW2c8Y/i7eSKbObUY+WObs0rdvAQtF/0m8N9fs7Ivn1S6vsckfhqUNIF
 5HX53mPGTtE3Cvn4xWbKK0e4//rtf8NLAiddDl/9NDyyiLy69SG1Rt6Nne7pXr/i
 d2qHz2AEq5kl7S9ZaXaUiuUQs96mHGGDSRVV+a0mgYD9Q5L5aktm58CvM+NYXk6Z
 KcydBVxFt37Cr/nggbXwAQboTfU3saijzUFcIMjKwW3mnUEWYqdjnspsXFoD17pA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp1m5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 15:04:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GC79a8027475;
 Mon, 16 Jun 2025 15:04:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479ksypsp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Jun 2025 15:04:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55GF4PMW24773140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Jun 2025 15:04:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFFFD58051;
 Mon, 16 Jun 2025 15:04:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5734F5805E;
 Mon, 16 Jun 2025 15:04:25 +0000 (GMT)
Received: from [9.61.75.155] (unknown [9.61.75.155])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 16 Jun 2025 15:04:25 +0000 (GMT)
Message-ID: <7a8ede02-0b97-4ad8-8a2b-3af7683368e4@linux.ibm.com>
Date: Mon, 16 Jun 2025 11:04:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/23] hw/s390x: Build an IPLB for each boot device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20241023131710.906748-1-thuth@redhat.com>
 <20241023131710.906748-16-thuth@redhat.com>
 <469f3e5a-897a-4456-bd02-185435129ec4@linaro.org>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <469f3e5a-897a-4456-bd02-185435129ec4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uffP9YJRZp8oWOgox3F9GuWk7PJ3d7yz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA5NCBTYWx0ZWRfX4d+smoHd5J5T
 GzoqFjx1DZ5o9Z6iR604W1s1xut5Qn+QOH3SOriXAo42Um209/WU44zx1p0IPgEhdE7483EMqTY
 1qPwpkyGVDE0gh54m48bh6QD99oKW5IYJfba9FvcvHnTcBA9gp48ZXqoo0VO/wjyJXXGgXsmI+C
 KwPGXjiJ0+KLBbpfST9JHdfZiqUjU9WUfcdVYmSiqBHkK6b5vI7N1/LA9CULidrthoXAMThLW1x
 FYjceEIjEgSzPrQAGtAC4cVClJGcxtfYsl+tJRl43mjHH/CmCUVvtEM7zCvDK2cAo5A9mAP7Iqh
 sEVTr5m3+92DmOv8iQh6U26ZSjW2xQ3XzCQHkcGb6W22I16+W+abEc6Q1o7u+xlrathUpZgO1tQ
 cXgNbcURaMyq0M+LU6z+OkKlEnDpx3oNtL94B4mILI1QZyiyXpsovH93pwO3Nz1L3Uh3SkqF
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=6850327a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=gN00BdxvhetB8T4w0pQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uffP9YJRZp8oWOgox3F9GuWk7PJ3d7yz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_07,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160094
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Philippe,

I update this to use the proper API call.

Regards,
Jared Rossi

On 6/16/25 6:04 AM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 23/10/24 15:17, Thomas Huth wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Build an IPLB for any device with a bootindex (up to a maximum of 8 
>> devices).
>>
>> The IPLB chain is placed immediately before the BIOS in memory. 
>> Because this
>> is not a fixed address, the location of the next IPLB and number of 
>> remaining
>> boot devices is stored in the QIPL global variable for possible later 
>> access by
>> the guest during IPL.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Message-ID: <20241020012953.1380075-16-jrossi@linux.ibm.com>
>> [thuth: Fix endianness problem when accessing the qipl structure]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/ipl.h              |   1 +
>>   include/hw/s390x/ipl/qipl.h |   4 +-
>>   hw/s390x/ipl.c              | 129 ++++++++++++++++++++++++++++--------
>>   3 files changed, 105 insertions(+), 29 deletions(-)
>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 656996b500..b9d741d0b0 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>
>
>> +static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>> +{
>> +    S390IPLState *ipl = get_ipl_device();
>> +    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>> +    uint64_t len = sizeof(IplParameterBlock) * count;
>> +    uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, 
>> count);
>> +
>> +    cpu_physical_memory_write(chain_addr, iplb_chain, len);
>
> This patch introduces a call to a legacy API (documented since at least
> 2017 in commit b7ecba0f6f6: "docs/devel/loads-stores.rst: Document our
> various load and store APIs"). Can we access the device address space 
> instead?
>
>> +    return chain_addr;
>> +}
>


