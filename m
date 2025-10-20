Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF17CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 05:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAieR-0001e5-Dn; Mon, 20 Oct 2025 01:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vAieH-0001cn-QN; Mon, 20 Oct 2025 01:41:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vAieE-0007kv-TF; Mon, 20 Oct 2025 01:41:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JFjKNK032408;
 Mon, 20 Oct 2025 05:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ts3y6K
 u6vD8Qt4WfOkkTmrPr+D6oxylhYGKSr6FwaVM=; b=Lg+2TnNATfueUAweE0QWSf
 lBS5HWD2N9OgvdLCq5ckDMNu0IMgMfLOBOZS01CAgIgKPoWaO+Dlg+fecmPod/jS
 sHGH9ncf5V9P3jokowc1wZKVyOSTIfoJ3AhuusLWHLXvK47lyI2ov5WZNjCLQa05
 u3kEjfK8xA2VKgM5bmsiEKwZ8M6M7CXtQDcplUmjAxwcAGQl3GFhGtdIO00keg/l
 Q9LSss2OQvQJiKCanvBCCDC32oM6kHjvUBEVNnDRmtrzSphHZPv4IRydh2oaJgbG
 DuRsCS36PgchlTNXc5GBlkoAymVumCEBOfGw4GuYo2T2ggSYTbzzKXlxho08B+QQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31bxvwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:40:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59K5eqnU023886;
 Mon, 20 Oct 2025 05:40:52 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31bxvwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:40:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K3AZn0011049;
 Mon, 20 Oct 2025 05:40:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx0uyua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Oct 2025 05:40:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59K5elb447907106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Oct 2025 05:40:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE64020043;
 Mon, 20 Oct 2025 05:40:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE10620040;
 Mon, 20 Oct 2025 05:40:45 +0000 (GMT)
Received: from [9.124.220.242] (unknown [9.124.220.242])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 20 Oct 2025 05:40:45 +0000 (GMT)
Message-ID: <3c3584c7-a171-45ca-8a4f-078125eb6ac5@linux.ibm.com>
Date: Mon, 20 Oct 2025 11:10:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] hw/ppc: Implement saving CPU state in Fadump
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-6-adityag@linux.ibm.com>
 <6a6f9e93-c824-4c6a-a24f-9b6e5f0d9cee@linux.ibm.com>
 <gzakxmmxnvzhlogu2577s6zd2jq2fkuixzvhj3zuh56z2hqnxv@4iqas73suad3>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <gzakxmmxnvzhlogu2577s6zd2jq2fkuixzvhj3zuh56z2hqnxv@4iqas73suad3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VRzbVD5BhhIQMmGhzKB-_p58gcaihRgu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5BAqNeUA2GMy
 lrdK4XnLm3Iw25GY19CKay5GgQi2VcLqDN/C9NngvPBALO30Wa2tnjyB3k4cSG6lw4Om3eV3m+m
 hFj5pZii79zO2QAyVeEGzJiA2Hhi60FTW4nhkEOPIUmf7P4blAJOqsy/M4set/unaf3JQ37rd87
 zceI9eN/4kaR3VkAX3fhtywdMMz/N550nhoLUdPh3qKcbGd84ti7bP17gKPjPkGB64RSa8DREkT
 B5RJHn5HGTtJu09YBVbiRu1VS2itE4wYI32TWrMRncnVTVQPZlZcWMyFGu5WzLpO9p92QKPw+ii
 G9DQ55I55grNUhVrZpH1hW8kvmKDdMTH2hil2HaWhcYpBYe6Hzg71Cu6b0TinsjqqQolUCa81Um
 PYi0x4CkOGmxBLpYRxLXpLxiXkJSoQ==
X-Proofpoint-GUID: 2QZqLchlOTGfFYp6PriT-d_Ag9igcdCn
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f5cb65 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=z9OrF-1DCn4JAXiPA0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 20/10/25 00:52, Aditya Gupta wrote:
> On 25/10/18 04:24PM, Sourabh Jain wrote:
>>> <...snip...>
>>> +    curr_reg_entry->reg_id =
>>> +        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
>>> +    curr_reg_entry->reg_value = ppc_cpu->vcpu_id;
>> Aren't we suppose to store CPU ID in big endian?
>> As per PAPR the format CPUSTRT and CPUEND node is
>>
>> 8 Bytes Identifier (BE) | 4 Bytes Reserved (0x0) | 4 Bytes Logical CPU ID
>> (BE)
>>
>> It feels like storing vcpu_id as little endian may not get the
>> reg entrie for CPUSTRT in above format, isn't it?
> Will fix in v5.
>
>> Ideally we should have two struct to mange two types of Reg Entries.
>> That way we can manage reserved bytes in CPUSTRT/CPUEND node
>> easily. I understand that it will bring unnecessary complexity in
>> populate_cpu_state_data function. So how about adding a note for
>> future reference?
> Will add a note about the format.
> I also think another struct might be unnecessary complexity since we
> just need it at 2 instances (CPUSTRT & CPUEND), and can be done with
> simple bit math.
>
>>> +    ++curr_reg_entry;
>>> +
>>> <...snip...>
>>> +    /* End the registers for this CPU with "CPUEND" reg entry */
>>> +    curr_reg_entry->reg_id =
>>> +        cpu_to_be64(fadump_str_to_u64("CPUEND"));
>> CPU ID as value to CPUEND reg entry needed, right?
> Yes, will add in v5.
>
>>> +
>>> <...snip...>
>>> +            /*
>>> +             * We will write the cpu state data later, as otherwise it
>>> +             * might get overwritten by other fadump regions
>> Isn't the destination address of cpu state data and RMR region are
>> different?
>>
>> I don't understand the above comment. Can you please give more details.
>>
>>> +             */
>>> +
>>> <...snip...>
>>> +    /*
>>> +     * Write the Register Save Area
>>> +     *
>>> +     * CPU State/Register Save Area should be written after dumping the
>>> +     * memory to prevent overwriting while saving other memory regions
>>> +     *
>>> +     * eg. If boot memory region is 1G, then both the first 1GB memory, and
>>> +     * the Register Save Area needs to be saved at 1GB.
>> Every region is copied to their destination address and as per below kernel
>> function:
>> https://github.com/torvalds/linux/blob/f406055cb18c6e299c4a783fc1effeb16be41803/arch/powerpc/platforms/pseries/rtas-fadump.c#L98
>>
>> the destination address shouldn't  be same for fadump region then how come
>> there
>> is overwrite scenario? Am I missing something?
> Yes, with current kernel logic, destination address of cpu state data
> and RMR region are different.
>
> I remember having faced some issue in past (don't recall, might have
> been with powernv, or it might not exist anymore) hence the comment.
>
> Ideally kernel should ensure CPU and memory regions don't overlap.
>
> Possible overlap can be like, memory region being 0x0 - 512MB, and
> generally the cpu region's destination also lies in this low memory.
>
> PAPR says nothing about order of saving iirc. I kept current way to
> ensure we have CPU registers even if such overlap happens.
>
> What do you say ? Should we save CPU region first and then go with
> saving memory regions ?

Yeah, I think we shouldn’t delay the CPU region. Even in the case of
such overlap, corruption in register values is easier to identify and fix
it in the kernel than corruption in the kernel memory dump.



>
>>> +     * And as the CPU_STATE_DATA region comes first than the
>>> +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
>>> +     * overwritten if saved before the 0GB - 1GB region is copied after
>>> +     * saving CPU state data
>>> +     */
>>> +    io_result = address_space_write(default_as, cpu_state_addr, attrs,
>>> +            cpu_state_buffer, cpu_state_len);
>> Hope cpu_state_buffer will be freed automatically...
> Yes, as it's declared with g_autofree, glibc/compiler takes care of
> adding cleanup functions ensuring it gets freed.

That's nice.

>
>>> <...snip...>
>>> +/* Number of registers stored per cpu */
>>> +#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)
>> #nit-pick
>> How about FADUMP_PER_CPU_REG_ENTRY ?
> How about FADUMP_PER_CPU_NUM_REGS ? Basically explicitly saying it's
> number of registers per cpu ?

I suggested FADUMP_PER_CPU_REG_ENTRY because it’s a reg entry count 
which include also includes the start and end. But it’s okay, I’m not 
picky about it. Feel free to use any of the three. - Sourabh

