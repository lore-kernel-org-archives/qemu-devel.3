Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 03:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq3Ju-00017E-6f; Thu, 28 Mar 2024 23:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rq3Js-00016z-Ou; Thu, 28 Mar 2024 23:54:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rq3Jq-00085n-Q3; Thu, 28 Mar 2024 23:54:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42T3YKTH019643; Fri, 29 Mar 2024 03:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Q9eHamyek3XkXu2utWmN+p4Wz8/6jfdiv2lBEKtNRY8=;
 b=Nayz9f9Vh/ipa5RvR/esppNFGBDpsbi//7/Hx6KBZQyfg6j+x7MZ5akv23lfTgOGJ55b
 heTPazLLm2BT1xjjusUeyJLlTKz9KwO13FJfr07MMyUzAXado4WcWpiYubsjtlroO2da
 yg+wLHbguFWcDslxZCiHV71v+mG0JjLH+b8VMuGR35q/EBpOWS9q7hOiNvUpdVMI1ijq
 R7JCl+uIorRo0Cv8Tb1iA1HJ214W1PEHQt16Llw+YoDq/6VgEVnbvvGo5TipoVXu5iNp
 GTcUcvIL5ltGvRAm6uqHTKLxeJ5qTH+Mznct5ILgX/yjApKiUzAhVJ/zlkLEjsRhkR23 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5ntvr0tp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 03:53:40 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42T3reOF014159;
 Fri, 29 Mar 2024 03:53:40 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5ntvr0tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 03:53:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42T0c3pl011233; Fri, 29 Mar 2024 03:53:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmmhd1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Mar 2024 03:53:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42T3rbd024445286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2024 03:53:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AC2958058;
 Fri, 29 Mar 2024 03:53:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E466658057;
 Fri, 29 Mar 2024 03:53:34 +0000 (GMT)
Received: from [9.171.42.229] (unknown [9.171.42.229])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Mar 2024 03:53:34 +0000 (GMT)
Message-ID: <9006efb3-0187-4dd7-9a98-bb0c94f503a6@linux.ibm.com>
Date: Fri, 29 Mar 2024 09:23:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 35/38] spapr: nested: Introduce H_GUEST_[GET|SET]_STATE
 hcalls.
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Neuling <mikey@neuling.org>
References: <20240312165851.2240242-1-npiggin@gmail.com>
 <20240312165851.2240242-36-npiggin@gmail.com>
 <CAFEAcA9dLHYvY7-zCntKFZGr1VJUW6b3y5UqFAq-XN8zgVe2WQ@mail.gmail.com>
 <1bc2bb17-23a5-4b36-a11b-bc7384a54a1d@linux.ibm.com>
 <CAFEAcA9BxWD66dCRJCbmf-YN-PzLMo0Hx12vZDWWsUZmbhYnxQ@mail.gmail.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA9BxWD66dCRJCbmf-YN-PzLMo0Hx12vZDWWsUZmbhYnxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BNKvW4iVgD3cLtSTC9ecV_9bQNNaIlCh
X-Proofpoint-ORIG-GUID: pzcVLFHJM_4XddJmLApzpuVl4gYDPcqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_02,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 spamscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 3/28/24 20:55, Peter Maydell wrote:
> On Wed, 27 Mar 2024 at 05:41, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>>
>>
>> On 3/26/24 21:32, Peter Maydell wrote:
>>> On Tue, 12 Mar 2024 at 17:11, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>>
>>>> From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>>
>>>> Introduce the nested PAPR hcalls:
>>>>       - H_GUEST_GET_STATE which is used to get state of a nested guest or
>>>>         a guest VCPU. The value field for each element in the request is
>>>>         destination to be updated to reflect current state on success.
>>>>       - H_GUEST_SET_STATE which is used to modify the state of a guest or
>>>>         a guest VCPU. On success, guest (or its VCPU) state shall be
>>>>         updated as per the value field for the requested element(s).
>>>>
>>>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>>>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Hi; Coverity points out a problem with this code (CID 1540008, 1540009):
>>>
>>>
>>>
>>>> +static target_ulong h_guest_getset_state(PowerPCCPU *cpu,
>>>> +                                         SpaprMachineState *spapr,
>>>> +                                         target_ulong *args,
>>>> +                                         bool set)
>>>> +{
>>>> +    target_ulong flags = args[0];
>>>> +    target_ulong lpid = args[1];
>>>> +    target_ulong vcpuid = args[2];
>>>> +    target_ulong buf = args[3];
>>>> +    target_ulong buflen = args[4];
>>>> +    struct guest_state_request gsr;
>>>> +    SpaprMachineStateNestedGuest *guest;
>>>> +
>>>> +    guest = spapr_get_nested_guest(spapr, lpid);
>>>> +    if (!guest) {
>>>> +        return H_P2;
>>>> +    }
>>>> +    gsr.buf = buf;
>>>> +    assert(buflen <= GSB_MAX_BUF_SIZE);
>>>> +    gsr.len = buflen;
>>>> +    gsr.flags = 0;
>>>> +    if (flags & H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
>>>
>>> flags is a target_ulong, which means it might only be 32 bits.
>>> But H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE has a bit set in the
>>> upper 32 bits only. So Coverity complains about this condition
>>> being always-zero and the body of the if being dead code.
>>>
>>> What was the intention here?
>>
>> Hi Peter,
>> Ideally this is intended to be running on a ppc64 where target_ulong
>> should be uint64_t. I guess same holds true for existing nested-hv code
>> as well.
> 
> Sorry, I'm afraid I misread the Coverity report here;
> sorry for the confusion. The 32-vs-64 bits question is a red
> herring.
> 
> What Coverity is actually pointing out is in this next bit:
> 
>>>> +        gsr.flags |= GUEST_STATE_REQUEST_GUEST_WIDE;
>>>> +    }
>>>> +    if (flags & !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE) {
> 
> The C operator ! is the logical-NOT operator; since
> H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE is a non-zero value
> that means that !H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE is 0;
> so we're testing (flags & 0), which is always false, and this
> is the if() body which is dead-code as a result.
> 
> Should this be the bitwise-NOT ~  (ie "if any flag other
> than this one is set"), or should this be an else clause
> to the previous if() (ie "if this flag is not set") ?

Oh, this should have been bitwise-NOT, I shall send a follow-up patch 
for the fix.

regards,
Harsh
> 
>>>> +        return H_PARAMETER; /* flag not supported yet */
>>>> +    }
>>>> +
>>>> +    if (set) {
>>>> +        gsr.flags |= GUEST_STATE_REQUEST_SET;
>>>> +    }
>>>> +    return map_and_getset_state(cpu, guest, vcpuid, &gsr);
>>>> +}
>>>
> 
> thanks
> -- PMM

