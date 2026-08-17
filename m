Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEE4C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzpI-0004Jh-Ig; Mon, 17 Aug 2026 12:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wvzpF-0004Ig-PI; Mon, 17 Aug 2026 12:04:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1wvzpD-00077a-Nx; Mon, 17 Aug 2026 12:04:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFgHG01710898; Mon, 17 Aug 2026 16:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=222NOp
 qCek1mbSWsG8Co63Ze5w3i21LR/46kVBMMo0Q=; b=oHODi+arAhguL200pvqP/H
 /eucsggLqCuqwt8cIiNuqEKqakaZ4qpoyxxARJV90AoHJwoSBeg6Y3Uf5y6AOjDb
 1B5IR+BM9Ipek5Hm12ZPx56Xuj130+i/M+RB8marfWNDleX5HB338y4DC2e10PZF
 3QB1pwhbaYyYjLzrSXSKl9jngsfhmlpnLQ2PKa8ZvFtz8kRgsqfUPDaGvf6pSymI
 capVkQdO85zUbdK1wwAoP3cpMVzasIBg8qFSwAK8z1FFT8ruUzA7t70ElRP4zpXr
 jb0ve3zeVkZVS+E/0A4qPrtbGdu3NeSN3BNpa7aH6eAb7dvEjLVJGBJSJ74a3O/w
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhku36s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 16:04:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFuHnt031617;
 Mon, 17 Aug 2026 16:04:32 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epxux4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 16:04:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HG3qAJ29557380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 16:03:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 048ED58059;
 Mon, 17 Aug 2026 16:04:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64B5D58043;
 Mon, 17 Aug 2026 16:04:28 +0000 (GMT)
Received: from [9.124.209.96] (unknown [9.124.209.96])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 16:04:28 +0000 (GMT)
Message-ID: <1f4678b8-ef26-4b00-96b6-2e201d5c9148@linux.ibm.com>
Date: Mon, 17 Aug 2026 21:34:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Add lower bound check for watchdogNumber
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 harshpb@linux.ibm.com, aik@ozlabs.ru, amachhiw@linux.ibm.com
References: <20260817105854.437724-1-rathc@linux.ibm.com>
 <20260817165901.b9ff4441-8a-amachhiw@linux.ibm.com>
 <a759da8e-9ee6-4144-b593-c019310c9af3@linux.ibm.com>
 <20260817173922.db7772a5-0c-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260817173922.db7772a5-0c-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfX6mHDnoy4on5O
 BZSekok0u1MRFZLyYESmBuiQuVfcilmQ7STpQAeD+58QVuNkW1QAZS6AUVOU/KBsRJVVfGrrUa5
 Hdz5fkGZ/DlCLBj01uwRaEFJS19eikA5dqDWlG4K+7kiiIulRFdR2aJ1dgfOKmsK2bkAQje/yCC
 ipTS1Ad5Hw3Bbv31VQ7iwU6vNMzWvuxnDf5KJsYLoF4iTuMj9xov00lOBxbcUK/kPq1Xc3YlIaD
 wjUf9sa3WUXAkuI1vbmzE+rxNhWkEVT7TAFKRcnw6Bq8IgBx2xF5ysJnyl3fT14yVmE/+bJd4VT
 SfrwQzrcFLIY+YcTI76rCumEgVueGXeHTozzDnfQLfagDm5LERYZDybeZWLHwb3FBA5pPvr64iN
 87ZYSQq+rl/QeLmGLcaoZ1SXVF6GG4z9y3c3jCzNDjcEPN2yR+mM8e1+Jrn/59b8eb48eUDIDe/
 yDBpjYUfjZoPLChzCTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyMyBTYWx0ZWRfXwbFSCg6ezX6x
 WuG5LgpiEf1lu/LQKsrJQxYW9LXiVGSgP16fVX6AUrzMj63G+x1QlwVMxPb5bcsbr2Jsh20O5Dr
 EU9U5uAjOCR6DXTivf8KO/15CA3g58U=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a833111 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=AJhdjOHtEmRdEUaYv5kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wQ5uK0ffwMJ3dR_CKJR6lpaTTNEeKK9V
X-Proofpoint-GUID: kGYldjD3TDe6N-X7Slzk3a7dKptFsWkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 8/17/26 17:42, Amit Machhiwal wrote:
> On 2026/08/17 05:27 PM, Chinmay Rath wrote:
>> On 8/17/26 17:03, Amit Machhiwal wrote:
>>> On 2026/08/17 04:28 PM, Chinmay Rath wrote:
>>>> Add missing lower bound check for H_WATCHDOG H_CALL's watchdogNumber parameter
>>>> as per PAPR documentation ver 12.10.00 section 14.15.5 'H_WATCHDOG'.
>>>>
>>>> Closes : https://gitlab.com/qemu-project/qemu/-/work_items/3600
>>>>
>>> Nit: This newline is not needed.
>>>
>>>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>>>> ---
>>>>    hw/watchdog/spapr_watchdog.c | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
>>>> index 5b3f50de3a..5d7478e833 100644
>>>> --- a/hw/watchdog/spapr_watchdog.c
>>>> +++ b/hw/watchdog/spapr_watchdog.c
>>>> @@ -145,7 +145,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>>>        switch (operation) {
>>>>        case PSERIES_WDTF_OP_START:
>>>> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>>> +        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>>>                return H_P2;
>>>>            }
>>>>            if (timeoutInMs <= WDT_MIN_TIMEOUT) {
>>>> @@ -170,7 +170,8 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>>>        case PSERIES_WDTF_OP_STOP:
>>>>            if (watchdogNumber == PSERIES_WDT_STOP_ALL) {
>>>>                ret = watchdog_stop_all(spapr);
>>>> -        } else if (watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
>>>> +        } else if (watchdogNumber > 0 &&
>>>> +                   watchdogNumber <= ARRAY_SIZE(spapr->wds)) {
>>>>                ret = watchdog_stop(watchdogNumber,
>>>>                                    &spapr->wds[watchdogNumber - 1]);
>>>>            } else {
>>> Nit: The bounds check in OP_STOP uses a positive-selection guard
>>> (watchdogNumber > 0 && watchdogNumber <= ARRAY_SIZE(...)) with the error
>>> in the trailing else, which reads differently from the negative guards
>>> used in OP_START and OP_QUERY_LPM. Consider flipping it to match:
>>>
>>>     } else if (watchdogNumber < 1 ||
>>>                watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>>         return H_P2;
>>>     } else {
>>>         ret = watchdog_stop(watchdogNumber,
>>>                             &spapr->wds[watchdogNumber - 1]);
>>>     }
>>>
>>>> @@ -184,7 +185,7 @@ static target_ulong h_watchdog(PowerPCCPU *cpu,
>>>>            trace_spapr_watchdog_query(args[0]);
>>>>            break;
>>>>        case PSERIES_WDTF_OP_QUERY_LPM:
>>>> -        if (watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>>> +        if (watchdogNumber < 1 || watchdogNumber > ARRAY_SIZE(spapr->wds)) {
>>>>                return H_P2;
>>>>            }
>>> Suggestion (follow-up patch): After this fix lands, it may be worth
>>> extracting a small helper to avoid the repeated bounds expression across
>>> OP_START, OP_STOP, and OP_QUERY_LPM:
>>>
>>>     static inline bool watchdog_number_valid(target_ulong n,
>>>                                              SpaprMachineState *spapr)
>>>     {
>>>         return n >= 1 && n <= ARRAY_SIZE(spapr->wds);
>>>     }
>>>
>>> The three call sites then become a uniform !watchdog_number_valid(...)
>>> or watchdog_number_valid(...) expression, the bounds are defined in
>>> exactly one place, and any future change to the valid range (e.g. a
>>> dynamic wds size) has a single point of update. Not a blocker for this
>>> patch — just a clean-up worth a separate patch.
>> Hey Amit,
>> Thanks for the suggestion. I actually did think of this. But, this common
>> check would only be used by 2 operations : Start and LPM requirement. Stop
>> operation's watchdogNumber validation works differently in the sense that
>> unlike others, it can take a specific negative value, that is -1, which is
> Thanks for the explanation, Chinmay. Just a small correction though —
> PSERIES_WDT_STOP_ALL is not -1. It is defined as:
>
>    #define PSERIES_WDT_STOP_ALL  ((uint64_t)~0)
>
> Since watchdogNumber is target_ulong (an unsigned type), this is
> 0xFFFFFFFFFFFFFFFF — the maximum value of a 64-bit unsigned integer, not
> a negative value. -1 would only be the interpretation if the bit pattern
> were read through a signed type, which never happens here.
Oooh right, I missed this. Thanks ! Will send a v2 right away.
>> used to indicate stopping all watchdogs. (This is also the reason why the
>> bound check flow is different for stop operation as you have already pointed
>> out above).
>>
>> Due to this, I decided not to consolidate. However we can definitely pass
>> the operation type to the validator function and check accordingly though.
> This actually reinforces the case for the shared helper. Since
> watchdogNumber is unsigned, watchdogNumber < 1 can never be true for
> PSERIES_WDT_STOP_ALL — 0xFFFFFFFFFFFFFFFF < 1 is false for an unsigned
> comparison. More importantly, STOP_ALL is caught by the explicit ==
> PSERIES_WDT_STOP_ALL arm before the bounds check is ever reached, so it
> would never interact with watchdog_number_valid() at all.
>
> ~Amit

