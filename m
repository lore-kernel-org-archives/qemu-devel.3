Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EABCA0FE9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWRo-0000FY-H7; Mon, 25 Aug 2025 08:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqWRk-0000Du-8B; Mon, 25 Aug 2025 08:37:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqWRe-0003uE-94; Mon, 25 Aug 2025 08:37:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OMp4hw021753;
 Mon, 25 Aug 2025 12:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=163zGu
 nfAIh/FlpP56mzOGwQTeCgE6s6nc6fBpLwj/Q=; b=iyaLKd8PwMU108nsGiy/3Q
 lXQo/H2Cq+ilbvbUd2xFF+cPa4fl3eQDkm3r22S0rSMvyWoc2mP/k3m2me42Y1vw
 8DMdp9ply3bb1mVd6C7O3OFjZ/dvMLNApZtXfpMfjp9Qctq9CO+P8IKDjsA7AF7x
 9VxzkFv6p0CJAHWnmQmDAZquamjmfxLOlfpncbgQonW1cmF4NlNjOl4HTmoda5Wk
 pxHCJbPqsq2lsuCyuBh64itMejq4i9W7VKxw5MM2/Q6GOoYsJZpLuVvEb9OsovU9
 rztE82lg/PWab0wdz/TNYVJ/mItkwsar+JrYfeCUh+KD5NUapyJjocstUQT4fp+w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5av8vy8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 12:37:00 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57PCPTLq020656;
 Mon, 25 Aug 2025 12:36:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5av8vy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 12:36:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57PA3pfu002528;
 Mon, 25 Aug 2025 12:36:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypdt9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 12:36:58 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57PCauHE18874938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 12:36:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9888E58056;
 Mon, 25 Aug 2025 12:36:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C9065804E;
 Mon, 25 Aug 2025 12:36:53 +0000 (GMT)
Received: from [9.39.20.14] (unknown [9.39.20.14])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Aug 2025 12:36:52 +0000 (GMT)
Message-ID: <e946e0f7-cc9f-40fa-bd41-3044510ce261@linux.ibm.com>
Date: Mon, 25 Aug 2025 18:06:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: Thomas Huth <thuth@redhat.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <c13f63a6-5fef-42f2-89fe-946f71498f51@redhat.com>
 <fd855a38-976f-430e-9db1-1bdce1cf869d@linux.ibm.com>
 <dc6dc7db-f4c3-4641-9707-383737e2b678@redhat.com>
 <0b6d96c7-b28f-42c0-93db-579d80f0298b@linux.ibm.com>
 <fd6f2788-b1a8-41af-88b5-9eb2ebdfd9d8@redhat.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <fd6f2788-b1a8-41af-88b5-9eb2ebdfd9d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tiOIIOArKPVE76qMRfxWDHpl52RmMt0c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX5RGVb0Y0ES+C
 onfXXhJB0pVzdY9z+a2OiZ+1ba7C57RYQKuuyRXJxhB7FJm/8IBfpNlLcGtJORBpKRiwET5hkS2
 6p9hj0LBu51Z8oQ4HUPAtkH6khLGbks0ll36IAoRo6KPhPlVHJ2d+dtuJy+jrxzoNgBA7Hk/Hko
 L7ELGwxnc8ip0JNldMV1W9qUeqtE1+uBySfn+KPuPlnjWFLgNZJRjTXCepssSqZQ13FAStUr9g0
 4tPTrzRsrRRd3ZuObWasW0+oi61eIaTJgDQWyNCyKA/T3bMILicL1Gokioy+QBxtFV8oVH+Xk/4
 ra7cbxdgs4xy0YFM3nT5lSQrBOZCXs47oudGBe8hWCGBG3aSRjer/rZ9W0XJ3wpZXaGHPZ1EMbX
 fCnF+hbh
X-Proofpoint-ORIG-GUID: QyMZJwGvYy_FAwkrtBKLf_7gu5JgZyH1
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68ac58ec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10 a=jRLB2SoPAAAA:8
 a=VnNF1IyMAAAA:8 a=g1FnTc_4fx5JVJLKS1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 8/25/25 17:52, Thomas Huth wrote:
> On 25/08/2025 14.08, Harsh Prateek Bora wrote:
>>
>>
>> On 8/25/25 17:28, Thomas Huth wrote:
>>> On 25/08/2025 13.46, Harsh Prateek Bora wrote:
>>>> Hi Thomas,
>>>>
>>>> On 8/25/25 17:04, Thomas Huth wrote:
>>>>> On 25/08/2025 13.24, Harsh Prateek Bora wrote:
>>>>>> Hi Glenn,
>>>>>>
>>>>>> This seems significant work. Thanks for upstreaming.
>>>>>>
>>>>>> On 8/20/25 02:58, Glenn Miles wrote:
>>>>>>> Adds the IBM PPE42 family of processors supporting the
>>>>>>
>>>>>> family of 32-bit processors ?
>>>>>>
>>>>>>> PPE42, PPE42X and PPE42XM processor versions.  These
>>>>>>> processors are used as embedded processors in the IBM
>>>>>>> Power9, Power10 and Power12 processors for various
>>>>>>> tasks.  It is basically a stripped down version of the
>>>>>>> IBM PowerPC 405 processor, with some added instructions
>>>>>>> for handling 64-bit loads and stores.
>>>>>>>
>>>>>>> For more information on the PPE 42 processor please visit:
>>>>>>>
>>>>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>>>>
>>>>>>> Supports PPE42 SPR's (Including the MSR) and  Exceptions.
>>>>>>>
>>>>>>> Does not yet support new PPE42 instructions and does not
>>>>>>> prevent access to some invalid instructions and registers
>>>>>>> (currently allows for access to invalid GPR's and CR fields).
>>>>>>>
>>>>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>>>>> ---
>>>>>>>   target/ppc/cpu-models.c      |   7 +
>>>>>>>   target/ppc/cpu-models.h      |   4 +
>>>>>>>   target/ppc/cpu.h             |  66 +++++++-
>>>>>>>   target/ppc/cpu_init.c        | 286 
>>>>>>> ++++++++++++++++++++++++++++++-----
>>>>>>>   target/ppc/excp_helper.c     | 171 +++++++++++++++++++++
>>>>>>>   target/ppc/helper_regs.c     |  28 +++-
>>>>>>>   target/ppc/tcg-excp_helper.c |  12 ++
>>>>>>>   target/ppc/translate.c       |   6 +-
>>>>>>>   8 files changed, 535 insertions(+), 45 deletions(-)
>>>>>>>
>>>>>>> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
>>>>>>> index ea86ea202a..09f73e23a8 100644
>>>>>>> --- a/target/ppc/cpu-models.c
>>>>>>> +++ b/target/ppc/cpu-models.c
>>>>>>> @@ -116,6 +116,13 @@
>>>>>>>                   NULL)
>>>>>>>       POWERPC_DEF("x2vp20", CPU_POWERPC_X2VP20,                 405,
>>>>>>>                   NULL)
>>>>>>> +    /* PPE42 Embedded 
>>>>>>> Controllers                                            */
>>>>>>> +    POWERPC_DEF("PPE42",         CPU_POWERPC_PPE42, ppe42,
>>>>>>> +                "Generic PPE 42")
>>>>>>> +    POWERPC_DEF("PPE42X",        CPU_POWERPC_PPE42X, ppe42x,
>>>>>>> +                "Generic PPE 42X")
>>>>>>> +    POWERPC_DEF("PPE42XM",       CPU_POWERPC_PPE42XM, ppe42xm,
>>>>>>> +                "Generic PPE 42XM")
>>>>>>
>>>>>> Can all the PPE42 specific code be conditionally compiled only for
>>>>>> !TARGET_PPC64 (and !CONFIG_USER_ONLY wherever possible)?
>>>>>> Not only to reduce the bloating size of respective binaries, but 
>>>>>> also to
>>>>>> avoid some code being added to hot path routines like 
>>>>>> hreg_compute_hflags_value().
>>>>>
>>>>> qemu-system-ppc64 is a superset of qemu-system-ppc, and there are 
>>>>> even efforts to unify all system functionality into a singly 
>>>>> binary, so excluding a 32-bit feature from qemu-system-ppc64 sounds 
>>>>> like a step into the wrong direction to me right now...?
>>>>
>>>> We do have existing code getting conditionally compiled for 
>>>> TARGET_PPC64
>>>> which I guess gets enabled with:
>>>>   --configure target-list=<ppc64|ppc>-softmmu
>>>> I understand the efforts are towards having a single binary to support
>>>> both, but what gets built-in is still decided with configure choice?
>>>>
>>>> Please correct/clarify with above understanding.
>>>
>>> As I said, qemu-system-ppc64 is currently a full superset of 
>>> qemu-system- ppc. The ppc64 binary contains all the 32-bit code, you 
>>> can perfectly run a "g3beige" or "bamboo" machine with 
>>> qemu-system-ppc64, too. By disabling the ppe42 code in the ppc64 
>>> binary, this would now introduce an execption to that unwritten rule, 
>>> so I'd expect that we'd not rather want to do this now.
>>
>> My understanding is that above holds true only for default builds which
>> builds all targets. We certainly do not build 32 bit ppc code when using
>> --configure target-list=ppc64-softmmu. (we have ppc-softmmu for 32 bit 
>> though)
> 
> Just give it a try:
> 
>   ./configure --target-list=ppc64-softmmu --disable-docs
>   make -j$(nproc)
>   ./qemu-system-ppc64 -M g3beige
> 
> ... works perfectly fine for me.
> 
This would work because the respective code is not restricted with 
#ifndef TARGET_PPC64.

However, there are instance like below in hw/ppc/mac_oldworld.c:

static void heathrow_class_init(ObjectClass *oc, const void *data)
{
     MachineClass *mc = MACHINE_CLASS(oc);
     FWPathProviderClass *fwc = FW_PATH_PROVIDER_CLASS(oc);

     mc->desc = "Heathrow based PowerMac";
     mc->init = ppc_heathrow_init;
     mc->block_default_type = IF_IDE;
     /* SMP is not supported currently */
     mc->max_cpus = 1;
#ifndef TARGET_PPC64
     mc->is_default = true;
#endif

Similarly, we have multiple instances with #else block for #ifdef
TARGET_PPC64 which doesnt get compiled with ppc64-softmmu, but only with
ppc-softmmu meant for 32-bit targets. See target/ppc/excp_helper.c for 
example.

regards,
Harsh

> AFAIK we don't have a switch to disable 32-bit code in the ppc64 binary.
> 
>   Thomas
> 

