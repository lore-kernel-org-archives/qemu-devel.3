Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5EFCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtMg-0003BO-RT; Thu, 23 Oct 2025 07:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtMe-0003Ah-Cf; Thu, 23 Oct 2025 07:20:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtMb-0006jY-Oz; Thu, 23 Oct 2025 07:20:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5bBu3003883;
 Thu, 23 Oct 2025 11:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dzdO9j
 1oPeZ62AXCHpkiR8it91ib87CrP8/WtzHlO1o=; b=KCPwfYX1aDf3MhKcl1inyM
 hGgZxSArSq8uxgwH+IowyskdJzigHwZHQUQMETZFECBCz+M6ooKwE5Tjf0/q4Pc/
 ibh8XNIuN9bDVc67K8L1CEpd8jBDq7w2qnlbhCuJtuM/MC5CL1P/AwxhzsPFWJgj
 Y7qkZNhgepEdSElg2JXRCY00C36nKVC3ZVTWmwzAbKUhokHSRJLgYl9WUGuNbpFn
 I69MyIhOWU2Ww5hxEg42Si7CyZgC44mzc8d7yYVJrsVSJ2nASuTbXlAp1A5e6Dyi
 CjEmQtKsjrgsV+eCAvLzTHhBkbMbJCjjwlg9j08t4Tq4mGYNXxms27GjbZ8h2IFQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271tts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:20:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NBHNWm015012;
 Thu, 23 Oct 2025 11:20:10 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271ttk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:20:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7ma8f011033;
 Thu, 23 Oct 2025 11:20:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1d3w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:20:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBK89830081656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:20:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C050658057;
 Thu, 23 Oct 2025 11:20:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B1EF58058;
 Thu, 23 Oct 2025 11:20:05 +0000 (GMT)
Received: from [9.124.221.73] (unknown [9.124.221.73])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:20:04 +0000 (GMT)
Message-ID: <7e3aa7fe-13b2-432a-bb0b-9dae4aed00fa@linux.ibm.com>
Date: Thu, 23 Oct 2025 16:50:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] hw/ppc: Implement saving CPU state in Fadump
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-5-adityag@linux.ibm.com>
 <4f0ddce6-c738-4d5b-8dc6-d997dd89289f@linux.ibm.com>
 <3p2pi6gph3ta3pfsnsk6nl63lwvtrb2hsof2ak42ooapqim564@zt7s3pltaxfv>
 <4802ecac-e8af-4e47-ab21-ebc70bea8d95@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <4802ecac-e8af-4e47-ab21-ebc70bea8d95@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa0f6b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=PQnYJY510iHoEEqZoIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx1Y9HTgJwQj+
 /9sue+MEJ/NZPYzxMKznoQUhrnLM+BvGKTBQYxkSpoLf1yqKn+mYOAAgtH77yvQa8W0CJLRuBqQ
 pu38TAyLnKFTYWq9MsueIBfYunR0K1mcFShvMoynPyOLB0zTS88g7recNqPaaScGMFr7O6jlqq1
 D021jEgyoJJmViZX39SFGg5O2GZsMSxZwRjQUeur+xK3etKRpTBHeptCO4d4tZphUun6fnRu53K
 p+EPlMG429mm7rq7XTOWdJEaEPLsyl6R58Oh/MrqB04j7Jw7HOBifMY69zWDD6dK1Mh8Xgksi7w
 ijzrCuYEbqbpyKDtQZZUkl/E6kh/fQ1nR4MXP/qtVx0LiflNpFGbeowuBjX8658lBNlqpG4OePG
 WOmPsXy0y6hjdSHsadM7Xckk/oz4sQ==
X-Proofpoint-GUID: PO-SYUq57zu_sEw68pjUMnehx0WgYm_h
X-Proofpoint-ORIG-GUID: u0R4xxSDZm4oyp_ic24WAjQioI_PjrAY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/23/25 16:46, Sourabh Jain wrote:
> 
> 
> On 23/10/25 16:41, Aditya Gupta wrote:
>> On 25/10/23 02:35PM, Sourabh Jain wrote:
>>>
>>>> <...snip...>
>>>> +    /*
>>>> +     * CPUSTRT and CPUEND register entries follow this format:
>>>> +     *
>>>> +     * 8 Bytes Reg ID (BE) | 4 Bytes (0x0) | 4 Bytes Logical CPU ID 
>>>> (BE)
>>>> +     */
>>>> +    curr_reg_entry->reg_id =
>>>> +        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
>>>> +    curr_reg_entry->reg_value = cpu_to_be64(
>>>> +            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
>>> Seems like converting full 64 bit CPU ID to 64 bit BE value will not 
>>> bring
>>> reg
>>> entry in below format. Isn't it?
>>>
>>> 8 Bytes Identifier (BE) | 4 Bytes Reserved (0x0) | 4 Bytes Logical 
>>> CPU ID
>>> (BE)
>>>
>>>> <...snip...>
>>>> +    /* End the registers for this CPU with "CPUEND" reg entry */
>>>> +    curr_reg_entry->reg_id =
>>>> +        cpu_to_be64(fadump_str_to_u64("CPUEND"));
>>>> +    curr_reg_entry->reg_value = cpu_to_be64(
>>>> +            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
>>> Same here.
>> It will be in the same format, since even with storing 8 bytes at once,
>> we do a 8 byte swap on the CPU ID, thus bringing the cpu id in the
>> higher 4 bytes only (considering CPU ID fits in 4 bytes as ensured by
>> the FADUMP_CPU_ID_MASK).
>>
>> So, it still follows the above format, just that it does not explicitly
>> use 4 byte blocks.
>>
>> This is also consistent with how the Linux kernel reads this field:
>>
>>     /* Lower 4 bytes of reg_value contains logical cpu id */
>>     cpu = (be64_to_cpu(reg_entry->reg_value) &
>>            RTAS_FADUMP_CPU_ID_MASK);
> 
> Yeah looks good to me now. Thanks.
> 
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks Sourabh and Shivang for your diligent reviews and validation efforts.

Queued.

regards,
Harsh
> 

