Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97957CAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 04:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1e3V-0006TS-6S; Thu, 25 Sep 2025 00:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v1e3P-0006TC-NF; Thu, 25 Sep 2025 00:58:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v1e3M-0005dj-0z; Thu, 25 Sep 2025 00:58:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P16H0F001950;
 Thu, 25 Sep 2025 04:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Ip0i78
 gMypl4uv1T4ynB3bvgItTdboE5NOY4OlPhMaA=; b=VcOoV7g//QV7nTM+2dBOGu
 XNESQMXy3P4qTmytK9CESEgBLI96wkJVtddI7GV8u15rsqQOtfhmF/ejNjAbmU5k
 Sh++bNSHH9h79jXZWJPJ0z4MU4PTB3syX/J4r13KNMjtgfNyWRXnA3dsOm5EOpPz
 H0rwcextuBM8ImusxM7ifjDnBoQ+hcTCECOtqUy3FCVBhOAG3G1D4b7Q5dElsOry
 URz0YqGMtGDuIz2iBGl+t88H4m+xhgAkD42afrYPMGJIf349ZnGf4Wzj4YnAnIwb
 Nga/7F36Ci1wf8In12Wo+XZFqiPTtG+3brPklhW5cVolGIrNeVccW1AHTGoYW0LQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkjufn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:57:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58P4oOJF026557;
 Thu, 25 Sep 2025 04:57:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkjufm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:57:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P11YXX031186;
 Thu, 25 Sep 2025 04:57:51 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vdd2ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:57:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58P4vn4a31523546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 04:57:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E098458060;
 Thu, 25 Sep 2025 04:57:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7301958056;
 Thu, 25 Sep 2025 04:57:47 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 04:57:47 +0000 (GMT)
Message-ID: <2e723114-e98c-4912-adc1-495341f2f550@linux.ibm.com>
Date: Thu, 25 Sep 2025 10:27:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] target/ppc: Add IBM PPE42 family of processors
To: milesg@linux.ibm.com, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, thuth@redhat.com, 
 richard.henderson@linaro.org
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-3-milesg@linux.ibm.com>
 <2ac7b094-4365-46e6-9f44-50052e1b3827@linux.ibm.com>
 <a136e0ef3c7d04b7cc4cc1ef370ee046deed6e47.camel@linux.ibm.com>
 <a168b80b1fc1bb1b9fe9c41209271e644b441bb2.camel@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <a168b80b1fc1bb1b9fe9c41209271e644b441bb2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d4cbd0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10
 a=CQYRP949p__mkZoyfikA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX2hDn//5ivuQZ
 kw599Up5h5wITCty8YKHi9PJvhMgmtyMl5VIOdpNn8E5ofTkVmTQk1KPgIjPoNvWNU2GsZzLJ44
 YqnSHQxi5R9OdrA/EDa+L9UJVj4RndE+fyKavtya4t9VEQMf5YRhuWrStMaA4p2AiG4s98QOx3T
 9d0275A6PepDf5lnPPVEI8iRNDvPRtwHqYhFS1XTifVIk03Zt/iwQ6EAdgG5RaIY1T/EComRD4z
 aJsjQbmqhaUprssd+jPtIbCvjydXqEDBBQ/Ni+OJ7nnuGEzasDMCX1dOM/UH6JLiYzGh3AeE0Sz
 ze9h78QOAE3yGgslqXlEfVgrGcVn75hFZWD9f5weDd/0dVkeT1HzBHIlUaSQbA/p9Gn4EPOuRwe
 8ACxE+q9
X-Proofpoint-ORIG-GUID: 2sWXEAt4N1OEyf6U_p0Y0OwvgZuGjNtm
X-Proofpoint-GUID: RLIPB-5kBlkJgCtjBK_tZCUzNXg80rip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

Hi Glenn,

On 9/24/25 20:36, Miles Glenn wrote:
>>>> @@ -6802,53 +6916,63 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>>>>    
>>>>        /* MSR bits & flags consistency checks */
>>>>        if (env->msr_mask & (1 << 25)) {
>>>> -        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
>>>> +        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE |
>>>> +                              POWERPC_FLAG_PPE42)) {
>>>>            case POWERPC_FLAG_SPE:
>>>>            case POWERPC_FLAG_VRE:
>>>> +        case POWERPC_FLAG_PPE42:
>>>>                break;
>>>>            default:
>>>>                fprintf(stderr, "PowerPC MSR definition inconsistency\n"
>>>> -                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n");
>>>> +                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n"
>>>> +                    "or POWERPC_FLAG_PPE42\n");
>>>>                exit(1);
>>>>            }
>>>>        } else if (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
>>> Hey Glenn,
>>>
>>> Did you miss adding the POWERPC_FLAG_PPE42 flag here  ^  ?
>>>
>>> Thanks,
>>> Chinmay
>> No. All PPE42 processors will have bit 1 << 25 set in env->msr_mask, so
>> it will always fall into the previous condition block and never enter
>> the 2nd check.
>>
>> Glenn
>>
> Ah, sorry, I should have looked closer!  This is supposed to be
> checking that if 1 << 25 is not set that we shouldn't be setting the
> PPE42 flag either.  So, yes, I'll add that in v6.

While we are at it, can we also replace all hard-coded bit shifts with
appropriate macros which reflect what these shifts are about. There are
few more such checks in the patch. May be audit other patches as well
for such instances.

regards
Harsh

> 
> Thanks,
> 
> Glenn

