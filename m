Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC186CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kHM-00029v-1T; Fri, 17 Oct 2025 09:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9ivS-00020d-OL; Fri, 17 Oct 2025 07:47:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1v9ivK-0007MB-Bg; Fri, 17 Oct 2025 07:47:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HAauok012279;
 Fri, 17 Oct 2025 11:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Uv3NOj
 mxChVKqQ+vNHo3sU/2ZKZe+HHgCsZiMtN5RGY=; b=TQPiOMI09SC1m5z00kH9Z8
 i6Ta2LY86D5a69Tk167nAIi+hoYWrmh8FeSZ3zh/XSuRFCLiyeidwYnhjjfiQZwS
 VpVzFrv2XoQj/QbUCh9mxcAWo07OhitxtljZcu+3gFl5VqK1bvx+3UEFTYxJeUFg
 6te4TLsZytw1fZQz7/aZkxC7OXM9HHXyAXdK6FmMWYd/X0jAICQ8Qsp/UCYNug+P
 HSYEt/avUIBD+RFCXO31dPhXZHyLvO6KVLdpsTEz6pD3V0Z8lK5QKAgdvFHAyYlr
 vg9bMK2oWZzwtmWFyImuxuAbZTE0CdchsTd3c6F7Vu6VLZRaH8VU1xPXvIFgnhAg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrs9yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:46:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBdrGr025613;
 Fri, 17 Oct 2025 11:46:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrs9yu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:46:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HASiel015178;
 Fri, 17 Oct 2025 11:46:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1jsn9gc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:46:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBksa952232682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:46:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB61020095;
 Fri, 17 Oct 2025 11:46:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B661320094;
 Fri, 17 Oct 2025 11:46:52 +0000 (GMT)
Received: from [9.124.221.21] (unknown [9.124.221.21])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 Oct 2025 11:46:52 +0000 (GMT)
Message-ID: <d2b492d2-6a21-490a-bba0-8b8f4e33d446@linux.ibm.com>
Date: Fri, 17 Oct 2025 17:16:51 +0530
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
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <m5l3cqemaikgnrjqej3zqcdpo4o6ukj3id3ojx2ron4wjpbtul@roskcbsdes2g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f22cb3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uibWy6ydtR8dLGYn6YUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7LM7CXJvZxvjvAlPG-KpsmVgx9DLgRW9
X-Proofpoint-ORIG-GUID: Snt67ng7QxEVeHARTME4cZob9vW--CBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfXyS/wXnx7POxr
 R6moz+1DLKPrYSQ5MksuB8Fr8q7rz3UOmBVf8GtrA888HwjxKDuIUYwEjGFkPgIZWULgjpCBByo
 ze/RXExVSzFxxkHXv+BA1GmBaxeqxmXH8dix4akM8uDxk3ADItITTpe//2pwI2bdgssVMy7D0Yq
 8S2x+RGdybEKVZcTiuDBGdeP4GlWF3frtY5IBO0xK2NAePRpmb03ia9JBOEnMVMB0qk+fHNk+hv
 J+YanPlXtWFpwXcZa6ca1oA4pPqJtaN51Y8lmoUWhSqXUY1/IBlAiRUmRTm6pWOm300KJlDCnww
 ORLmcnliOzI0N+pvoHTcqAVM9Dp961KvP6FOrDRsD7gWQ0619FImlYN4NlwPHtMmvy3/zW5Cjvz
 zD6ds31EZXOVOpEKMqWq3YRz38K71w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 Oct 2025 09:13:23 -0400
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



On 17/10/25 17:08, Aditya Gupta wrote:
> Hello Sourabh,
>
> Thanks for your detailed reviews.
>
> On 25/10/17 02:10PM, Sourabh Jain wrote:
>> Hello Aditya,
>>
>>> <...snip...>
>>> +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>>> +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>>> +                                   SpaprMachineState *spapr,
>>> +                                   uint32_t token, uint32_t nargs,
>>> +                                   target_ulong args,
>>> +                                   uint32_t nret, target_ulong rets)
>>> +{
>>> +    target_ulong cmd = rtas_ld(args, 0);
>>> +    uint32_t ret_val;
>>> +
>>> +    /* Number of outputs has to be 1 */
>>> +    if (nret != 1) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                "FADump: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
>>
>> No rtas_st for above failure?
> Will add.
>
> Also I think I should remove the LOG_GUEST_ERROR, since I mostly use it
> for qemu side errors, wrong parameters is an invalid usage rather than>
> guest/qemu error.
>
> What do you say ? Should I remove qemu_log_mask here ?

Having such log helps. Not sure qemu_log_mask with LOG_GUEST_ERROR is right
a function to use but keep the logging with whatever logging function 
you think
works best here.

>
>>> +        return;
>>> +    }
>>> +
>>> +    /* Number of inputs has to be 3 */
>>> +    if (nargs != 3) {
>>> +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
>> No qemu_log_mask for the above failure?
> Thinking to remove it, as mentioned above.

Same as above.

>
>>> +        return;
>>> +    }
>>> +
>>> +    switch (cmd) {
>>> +    case FADUMP_CMD_REGISTER:
>>> +        ret_val = do_fadump_register();
>>> +        if (ret_val != RTAS_OUT_SUCCESS) {
>>> +            rtas_st(rets, 0, ret_val);
>>> +            return;
>>> +        }
>>> +        break;
>>> +    case FADUMP_CMD_UNREGISTER:
>>> +        if (spapr->fadump_dump_active == 1) {
>>
>> fadump_dump_active is bool, so comparing with an integer is not needed.
> Nice catch. Thanks !
>
>>> +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
>>> +            return;
>>> +        }
>>> <...snip...>
>>> +#define FADUMP_VERSION                 1
>>> +
>>> +/*
>>> + * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
>>> + * in the dump memory structure. Presently, three sections are used for
>>> + * CPU state data, HPTE & Parameters area, while the remaining seven sections
>>> + * can be used for boot memory regions.
>>> + */
>>> +#define FADUMP_MAX_SECTIONS            10
>>> +#define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
>> Please move RTAS_FADUMP_MAX_BOOT_MEM_REGS to the respective patch
>> if it’s used; otherwise, remove it if it’s not needed.
> Again nice catch. It's not used anymore, will remove.
>
>>> +
>>> +typedef struct FadumpSection FadumpSection;
>>> +typedef struct FadumpSectionHeader FadumpSectionHeader;
>>> +typedef struct FadumpMemStruct FadumpMemStruct;
>>> +
>>> +struct SpaprMachineState;
>>
>> Didn't understand the reason for the above forward declaration.
> Yes, in this patch it doesn't make sense, when merging the 1st and 2nd
> patch, then we see the use. Idea is as explained below.
>
> It is because it's defined in spapr.h, and we use SpaprMachineState at
> the end of this header in declaration of 'do_fadump_register'.
>
> But spapr.h includes spapr_fadump.h, so can't include that else it will
> become a cyclic dependency.
>
> Hence forward declaration was a way to solve that cyclic dependency.
Yeah I got that while reviewing the second patch in the series.

Why are we merging 1st and 2nd patch?

- Sourabh


