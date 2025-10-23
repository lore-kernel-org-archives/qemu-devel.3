Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A9DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtJP-0000LP-E2; Thu, 23 Oct 2025 07:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBtJM-0000IF-TJ; Thu, 23 Oct 2025 07:16:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBtJL-0005tj-5S; Thu, 23 Oct 2025 07:16:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N5HvaA008513;
 Thu, 23 Oct 2025 11:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=W0FoXx
 Oa/MGeRQfdJJpBtRMXrTeqqrMnKwyDGFHL4Sw=; b=UJUvS7rGEhhL+Dv5udhKLS
 oEYm+5CDQLLffYe+R1+h1XN875iVSlUQoPqWCv1u14QtN5PDwEa0RE/xFuO3VfSk
 D6y0hifTWzfGlPN3wqxQI/c7y00XfjoQ+LZPvYglMIAkfxYlz4nDYZFr3vBgmuFf
 hl+kKcsBr52qTGiB1lP68YxU8oJ0AiGwS1sq/SQByIOrvt017W8Du5kE6vxafbKn
 YjwHQTP5P8KttmbwWNGUGtNu9mnm/2Gc3y7I4AaOTsKcYB0DrWfxALjxiCgETAQJ
 kFMv3hdq/x4wBmaCHi+snE8eoojQdCLchKrPxYRS0/YKbp4q8D+1vo9zucOb198g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hr9nq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:16:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NB11Qv028325;
 Thu, 23 Oct 2025 11:16:47 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hr9nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:16:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9J2x9014676;
 Thu, 23 Oct 2025 11:16:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdkw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:16:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBGhFT31588790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:16:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 008F020043;
 Thu, 23 Oct 2025 11:16:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1F122004B;
 Thu, 23 Oct 2025 11:16:40 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:16:40 +0000 (GMT)
Message-ID: <4802ecac-e8af-4e47-ab21-ebc70bea8d95@linux.ibm.com>
Date: Thu, 23 Oct 2025 16:46:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] hw/ppc: Implement saving CPU state in Fadump
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-5-adityag@linux.ibm.com>
 <4f0ddce6-c738-4d5b-8dc6-d997dd89289f@linux.ibm.com>
 <3p2pi6gph3ta3pfsnsk6nl63lwvtrb2hsof2ak42ooapqim564@zt7s3pltaxfv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <3p2pi6gph3ta3pfsnsk6nl63lwvtrb2hsof2ak42ooapqim564@zt7s3pltaxfv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxvg3hg+fWE3l
 jURz6WV4U6ZqDMuEguOR8kGWTy0AKISiTCOrUYCNAAmd8zvHT/AvAesMuzqk2Ol1NZ0yRU+Xq/v
 RN41fjrj9zOitu3iwg4o8iOZU98uDAv/l6N60QVY6gWEiaQYeoYkqFu8mNa8XmH/zva3PHm57lr
 eTIz2n3zUNBYX82KMa3PCb7oRsXHyS2e/UpsETWWaUnjd38YBdmlGkBc3AW/Hdrmo2s+BNzL8kE
 Ndn8HyOzv/+TxPjcXPn73drgsbCq0xVpNla2QkPwvQQY0jzNUUsBq1koFSnIxOlc0IeQYBGtl7p
 d1iWe3A6dZtWdaFgYy/FXbTUnc27zSvQ2emIIH08tH4poqmEEOe8yJZzkC4ac6lW78QNsVOAetr
 2eG2o8VtRmWdHDgcbEQdj2w1W6LE/Q==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa0ea0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=8WvofhEzJAVrHyroUksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ICvuIzw9EejboGsERruH6EZKA5bVKLgb
X-Proofpoint-ORIG-GUID: 3uE3zffdajN1Ehg49Hf-5eyUj8qoDs1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 23/10/25 16:41, Aditya Gupta wrote:
> On 25/10/23 02:35PM, Sourabh Jain wrote:
>>
>>> <...snip...>
>>> +    /*
>>> +     * CPUSTRT and CPUEND register entries follow this format:
>>> +     *
>>> +     * 8 Bytes Reg ID (BE) | 4 Bytes (0x0) | 4 Bytes Logical CPU ID (BE)
>>> +     */
>>> +    curr_reg_entry->reg_id =
>>> +        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
>>> +    curr_reg_entry->reg_value = cpu_to_be64(
>>> +            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
>> Seems like converting full 64 bit CPU ID to 64 bit BE value will not bring
>> reg
>> entry in below format. Isn't it?
>>
>> 8 Bytes Identifier (BE) | 4 Bytes Reserved (0x0) | 4 Bytes Logical CPU ID
>> (BE)
>>
>>> <...snip...>
>>> +    /* End the registers for this CPU with "CPUEND" reg entry */
>>> +    curr_reg_entry->reg_id =
>>> +        cpu_to_be64(fadump_str_to_u64("CPUEND"));
>>> +    curr_reg_entry->reg_value = cpu_to_be64(
>>> +            ppc_cpu->vcpu_id & FADUMP_CPU_ID_MASK);
>> Same here.
> It will be in the same format, since even with storing 8 bytes at once,
> we do a 8 byte swap on the CPU ID, thus bringing the cpu id in the
> higher 4 bytes only (considering CPU ID fits in 4 bytes as ensured by
> the FADUMP_CPU_ID_MASK).
>
> So, it still follows the above format, just that it does not explicitly
> use 4 byte blocks.
>
> This is also consistent with how the Linux kernel reads this field:
>
> 	/* Lower 4 bytes of reg_value contains logical cpu id */
> 	cpu = (be64_to_cpu(reg_entry->reg_value) &
> 	       RTAS_FADUMP_CPU_ID_MASK);

Yeah looks good to me now. Thanks.

Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>


