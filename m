Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484C0D5E39D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWTP-0003Jn-8T; Tue, 16 Dec 2025 09:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWTN-0003JM-LF; Tue, 16 Dec 2025 09:56:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWTK-0000gh-Ni; Tue, 16 Dec 2025 09:56:20 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGDaeQa008696;
 Tue, 16 Dec 2025 14:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vVnd8u
 EcK0Tllp3tLfwowyb8Bp4dZ9okRxYz4eYrjgA=; b=k/Jjd9D3gPyuyGeK4tUlHn
 qYDSP+GSr+Ymo7L8fphVHh8Qm+ZNNcZ2rUcuS9RWF7XaQI7gYK5NKqFsRvN+17Qc
 jsuzVuztuyAQnU1fEGoODSdumOjiaov0K95d6LE3zgMhw4bSg1AdZGG2XxuLDkWa
 xMlnhMOulr7Mblcs+hXrzQHq91dbEMTqYLgw5uWHZqy0WdqkDFvudLi39F1RD4L1
 2zi9QzwUPYoYCwbGe77wA3buUHkKNyuIsm9g1+6Gu2eUiWgUyJFcO2UWwVq9is38
 JZ2W824kEM6dlXhiApjCONQerlgqtur8wY1FJw2hOsiWZfeQvuRgWtA7ZmlhQ/ug
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjky34h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 14:56:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGEpptp030494;
 Tue, 16 Dec 2025 14:56:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjky34e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 14:56:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCxZH5012810;
 Tue, 16 Dec 2025 14:56:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy4sq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 14:56:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGEuCIk25821802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 14:56:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B15EF58056;
 Tue, 16 Dec 2025 14:56:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27BB658052;
 Tue, 16 Dec 2025 14:56:12 +0000 (GMT)
Received: from [9.61.245.21] (unknown [9.61.245.21])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 14:56:12 +0000 (GMT)
Message-ID: <821a8339-33fd-4533-9b5c-ef5e69d153e5@linux.ibm.com>
Date: Tue, 16 Dec 2025 08:56:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] hw/ppc: Add VMSTATE information to PnvPsi
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251215171813.1670241-1-calebs@linux.ibm.com>
 <20251215171813.1670241-8-calebs@linux.ibm.com>
 <ak2xwufxarhtcbaj6nj5mjaimlfhk5p2csty4uxljs4sjrkqol@axobvglzomg7>
 <51ce8be6-a13b-4916-85ba-383187418601@linux.ibm.com>
 <vmvjec6njy2f5sfriqtcstg5ypzldibobs7vstyvpc36vmfkrm@rr3fgx3ezlif>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <vmvjec6njy2f5sfriqtcstg5ypzldibobs7vstyvpc36vmfkrm@rr3fgx3ezlif>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xEZlhAPPwYPoJyYkrqsOG4i9JVGXhJbL
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6941730f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=wNzWfUkbdlMMbo2PYVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: xZyz-jQR4s98YelwFsU03MCBvrVIbpyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX0Moy338NF2yC
 3Yq/x6S5hk45zWExtQKFWGJaWiJTkSI7QaNof+cX/kt4dKh6sq3cMlE8oNMa2Zc+NGMrVxo5b6c
 yxajJgVVS2ToVdPuMkIYEDlctLzkfe7KY/JZPWjHEdUBgg9w2I/GvJQFFT40jPJux0yNlbjUsGP
 qp8EuRnS9Ru77091SKlZ5dyU9XhNn7XgbfV7DaBA0J+CRld+sK8BLuBGxqwnGqnWneuQzKxmmsb
 relBrGuHIfKwATJBh316/kG4VRwh34DjP0hZsSxjo0E95IvU4qkA4EC5gbH/NfuNKWpevtj6Jrw
 1L+9gZ1RgjOznZFYxcZFd6+fdpMZOqxocqmEyAvMRQPlXpvnxonZk/TjVJKFf2f93HuDk8jWDgk
 wkmzs/WKqeC2adWN77qdJwaA5AdY5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 12/16/25 8:36 AM, Aditya Gupta wrote:
> On 25/12/16 07:35AM, Caleb Schlossin wrote:
>>
>>
>> On 12/16/25 6:58 AM, Aditya Gupta wrote:
>>> Hello Caleb,
>>>
>>> On 25/12/15 11:18AM, Caleb Schlossin wrote:
>>>> <...snip...>
>>>>
>>>> --- a/hw/ppc/pnv_psi.c
>>>> +++ b/hw/ppc/pnv_psi.c
>>>> @@ -25,6 +25,7 @@
>>>>  #include "qemu/module.h"
>>>>  #include "system/reset.h"
>>>>  #include "qapi/error.h"
>>>> +#include "migration/vmstate.h"
>>>>  
>>>>  
>>>>  #include "hw/ppc/fdt.h"
>>>> @@ -35,6 +36,8 @@
>>>>  
>>>>  #include <libfdt.h>
>>>>  
>>>> +#undef PSI_DEBUG
>>>> +
>>>
>>> Is this intended or got left over from debugging ?
>>
>> This was indented to aid future debug, if needed.
>>
> 
> If so, i believe this should be removed.
> 
> With this we just unconditionally noped out the #ifdef PSI_DEBUG
> portions in this file, even if the user explicitly compiles with PSI_DEBUG
> 
> What do you say ?
> 
> - Aditya G

Sounds good, I'll remove it and send up a new set of patches.

> 
>>>
>>>>  #define PSIHB_XSCOM_FIR_RW      0x00
>>>>  #define PSIHB_XSCOM_FIR_AND     0x01
>>>>  #define PSIHB_XSCOM_FIR_OR      0x02
>>>> @@ -130,12 +133,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>>>>  {
>>>>      PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
>>>>      MemoryRegion *sysmem = get_system_memory();
>>>> -    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
>>>>  
>>>>      psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
>>>>  
>>>>      /* Update MR, always remove it first */
>>>> -    if (old & PSIHB_BAR_EN) {
>>>> +    if (memory_region_is_mapped(&psi->regs_mr)) {
>>>>          memory_region_del_subregion(sysmem, &psi->regs_mr);
>>>>      }
>>>>  
>>>> @@ -975,6 +977,40 @@ static void pnv_psi_register_types(void)
>>>>  
>>>>  type_init(pnv_psi_register_types);
>>>>  
>>>> +#ifdef PSI_DEBUG
>>>> +static void psi_regs_pic_print_info(uint64_t *regs, uint32_t nr_regs,
>>>> +                                    GString *buf) {
>>>> +    uint i, prev_idx = -1;
>>>> +    uint64_t  reg1, prev_reg1 = -1;
>>>> +    uint64_t  reg2, prev_reg2 = -1;
>>>> +    uint64_t  reg3, prev_reg3 = -1;
>>>> +    uint64_t  reg4, prev_reg4 = -1;
>>>
>>> Very minor nitpick, 2 spaces in the declaration between type and name.
>>> checkpatch doesn't point it out, so it's okay with me.
>>>
>>> Looks good to me overall. Please just see if the #undef was intentional,
>>> if so:
>>>
>>> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>>>
>>> Thanks,
>>> - Aditya G
>>>
>>


