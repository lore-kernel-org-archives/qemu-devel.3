Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB8DCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAiMw-0004y8-2T; Mon, 20 Oct 2025 01:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vAiMr-0004xJ-Kl; Mon, 20 Oct 2025 01:23:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vAiMp-0006BX-CN; Mon, 20 Oct 2025 01:23:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLv943030017;
 Mon, 20 Oct 2025 05:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gLDRyd
 aDJ3BznQM/dcvfkngB8yt1ORIIMutubl9SOE8=; b=M0QE7bHfoxaMmnozH1pbp5
 e5LhyP65m0F7JIh/CKoOHsLJyiXW33JgLy5evYbxJC8z8ndnVPmn25tDMTBasg6E
 //JBDiRhemZrHLwO+WakZNWfkrOyHGEmkFP9H2oDzJUYltArM6QklWlF2N1cicfx
 oMBSWLxYdrDwX5vOilXoPQYYo3az1nz+lenytGu9OrH1PTgx8QA4KPVrYrGwACVv
 LmTcrBPam82KsEr3iJTmXs3mWG4BCBuFVKKFopwgktQUiVWjd6ImCgQ+L5e9sUY6
 WYFfWP+T2p3VeSNOs8Jlgw3GPR6XkRTnSOzo5ftPKGhqWolrwbI5x5bbiRIcPbcw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rqs6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:23:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59K5NU7Q001603;
 Mon, 20 Oct 2025 05:23:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rqs6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:23:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K1jtxx024690;
 Mon, 20 Oct 2025 05:23:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjm477-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:23:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59K5NO9k43057660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 05:23:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA1992004B;
 Mon, 20 Oct 2025 05:23:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C726920040;
 Mon, 20 Oct 2025 05:23:22 +0000 (GMT)
Received: from [9.124.220.242] (unknown [9.124.220.242])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 05:23:22 +0000 (GMT)
Message-ID: <20657aaf-2326-4be1-b7e6-d3928ac8eb97@linux.ibm.com>
Date: Mon, 20 Oct 2025 10:53:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
 <0827c237-df2b-4a7a-8157-c496c4fa98cc@linux.ibm.com>
 <m5l3cqemaikgnrjqej3zqcdpo4o6ukj3id3ojx2ron4wjpbtul@roskcbsdes2g>
 <x2eomjkxpq2znoxm3wuw4qtcxhz4sted7l7ql6pjxgy6yy3nxx@qz437owiq5w4>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <x2eomjkxpq2znoxm3wuw4qtcxhz4sted7l7ql6pjxgy6yy3nxx@qz437owiq5w4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IAq3IXbkFrF1hmbkqrbUTTpdvDeK5ldR
X-Proofpoint-GUID: 9jy24sE6uno1eje3u1-pMQQKlr9uK2I3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2i1x9+nmQxHj
 sjmIskGCUC+oCYvBI/kuV/3/hiAKjWw+mDKWm6DUtp3C4ugEDqWpqe1vhvaDCfQ83U+0skt0mQN
 E+sI4q5tC8CHQFhhVyh8PVyZviP9d17gkLDTvqXYQrwuRAZwBvKNLw3hnv9/yLL/aDO60B4eJ+M
 +HWLaWqIMwMdUtw/DRZuk6pfy7vy33nAGJpBpMQbIJWpCi37yCaPbT175JRIqivFd3LZxe/Wo9r
 8llOmK5d/+ingsIDfKswjbKJVfGwgUx11PTAPwb+VW6FrENtYcTvgheHaMMstYbShHtLXZNqNc/
 sUkIcuWZ+8s3TEp+uyE9/WJFkIIu+dDVZgUOW5nyHU7o1uwPegNLtF5MshbPZU/06VjK29SUShp
 ef2y1H2wW0EnBcdse4IELMw4c/v/JQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f5c752 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1qlc2dnvocV2h5NDR1gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 17/10/25 17:14, Aditya Gupta wrote:
> On 25/10/17 05:08PM, Aditya Gupta wrote:
>> Hello Sourabh,
>>
>> Thanks for your detailed reviews.
>>
>> On 25/10/17 02:10PM, Sourabh Jain wrote:
>>> Hello Aditya,
>>>
>>>> <...snip...>
>>>> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>>>> +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>>>> +                                   SpaprMachineState *spapr,
>>>> +                                   uint32_t token, uint32_t nargs,
>>>> +                                   target_ulong args,
>>>> +                                   uint32_t nret, target_ulong rets)
>>>> +{
>>>> +    target_ulong cmd = rtas_ld(args, 0);
>>>> +    uint32_t ret_val;
>>>> +
>>>> +    /* Number of outputs has to be 1 */
>>>> +    if (nret != 1) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>> +                "FADump: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
>>>
>>> No rtas_st for above failure?
>> Will add.
>>
>> Also I think I should remove the LOG_GUEST_ERROR, since I mostly use it
>> for qemu side errors, wrong parameters is an invalid usage rather than>
>> guest/qemu error.
>>
>> What do you say ? Should I remove qemu_log_mask here ?
>>
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Number of inputs has to be 3 */
>>>> +    if (nargs != 3) {
>>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>>> No qemu_log_mask for the above failure?
>> Thinking to remove it, as mentioned above.
> On a second thought, I will keep the qemu_log_mask as suggested.
> More logs helps for debug if kernel passes invalid arguments to fadump.
>
> Is that okay ?
Yes, lets keep the debug logs.

- Sourabh

