Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B0AC5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJsxX-0000LX-7Y; Tue, 27 May 2025 07:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uJsxT-0000IY-QD; Tue, 27 May 2025 07:59:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uJsxO-0004P3-Sd; Tue, 27 May 2025 07:59:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RATrfb017901;
 Tue, 27 May 2025 11:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cP70YZ
 qFM+/4cTwKEoxjX6Xskvz+r3N+83QupSTzpsQ=; b=YpA5CHmKhBQjN4+O1RXQQ6
 M1gtfCVCBUysVWtKoIz6Tf1lmyoYId1fwx4YYxNmPSf3SNA4NPUKJF4Sr8vtTduT
 ZRwkwnnO12SXR5n6DkCKoy8zpTfeA1SKbiouJWl9xmCL/FgV/PwJDI9H/c0et8te
 FEzroFM937G+p/Wz38HWTDTsjpHfCtdxfmJrJ901qLcjRfU3HshGipFBGXQyrZDG
 i9pltKtxp02hoij8bdbv2RasdCsZ3FrkzPAs7NgJN8nbrm3LWVN7ggCCFgE6iNdp
 96c4qcw5UwBSfGmPUqAXwWU0R4almwYpVaWE4DwqfcoO+q6nOvlTH9TCI7apdHhw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46u3hrxetm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 11:58:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R7bjrR010673;
 Tue, 27 May 2025 11:58:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46useptfh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 11:58:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54RBwCvZ12845650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 May 2025 11:58:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E2975805D;
 Tue, 27 May 2025 11:58:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38BAD58052;
 Tue, 27 May 2025 11:58:11 +0000 (GMT)
Received: from [9.61.152.228] (unknown [9.61.152.228])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 May 2025 11:58:11 +0000 (GMT)
Message-ID: <ed2a2aa3-68a7-480c-a6a4-a8219af12d7b@linux.ibm.com>
Date: Tue, 27 May 2025 07:58:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] hw/vfio/ap: Storing event information for an
 AP configuration change event
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com
References: <20250512180230.50129-1-rreyes@linux.ibm.com>
 <20250512180230.50129-4-rreyes@linux.ibm.com>
 <7d1699d4-6d7d-4de3-a0bc-6dd345d9c2dd@redhat.com>
 <31cc61cf-d2f9-45ea-b825-623ae619c298@linux.ibm.com>
 <0d300bd0-7c9e-4f14-bb85-877da56fdc9d@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <0d300bd0-7c9e-4f14-bb85-877da56fdc9d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AOOMbaiN c=1 sm=1 tr=0 ts=6835a8d6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=CNAAoIheG9QQydUqnToA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pWC4d98Uf3cQ8tYPCCgQ8VNKlyqNqPzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA5NCBTYWx0ZWRfX7Ya8rDF80T6O
 919PU3t0YhJXmOZeD5Dy3jpz4ad/BV5USAF0B+7Euv3MR/rEf2jfYVtm417e8++rdPZdOXglKoI
 E66diM/dAPA3YqfIucf4j+EYi7qmQEF6Jblc1QqwJduDmSjGvtm3WkC20NuXCn1eoenDcx3uiiG
 G5hnhsTEX6zwdJu++yGsqZU4hDNV460TjhmbB5TYbbajabeNN3WcfvXdj28mahR9k22VRBENsS+
 63yynPd9WHzuoeSVBVrQFiDsk/mWsjG6n9wu3xGlXbpLy0oT9GQzG0EnblpJ6PGWFdtKtgk0khZ
 D9L/yFnatSmgiW4aYFl3n7juF6uYCU968DTeFSsHLej6f8oD1hZ5yA5vQgwyIf6T0GQac2tPiDf
 RULipco0OuwRD2VztQ5ufLERJxK7JL2050AJc5qAJpfp/4sGivxjDvhR9P1Fvm24VkoKXJPp
X-Proofpoint-GUID: pWC4d98Uf3cQ8tYPCCgQ8VNKlyqNqPzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505270094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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




On 5/26/25 4:43 AM, Cédric Le Goater wrote:
> On 5/22/25 20:55, Anthony Krowiak wrote:
>>
>>
>>
>> On 5/22/25 9:30 AM, Cédric Le Goater wrote:
>>> On 5/12/25 20:02, Rorie Reyes wrote:
>>>> These functions can be invoked by the function that handles 
>>>> interception
>>>> of the CHSC SEI instruction for requests indicating the 
>>>> accessibility of
>>>> one or more adjunct processors has changed.
>>>>
>>>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>>>> ---
>>>>   hw/vfio/ap.c                 | 39 
>>>> ++++++++++++++++++++++++++++++++++++
>>>>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>>>>   2 files changed, 61 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>> index 5ea5dd9cca..4f88f80c54 100644
>>>> --- a/hw/vfio/ap.c
>>>> +++ b/hw/vfio/ap.c
>>>> @@ -96,6 +96,45 @@ static void 
>>>> vfio_ap_cfg_chg_notifier_handler(void *opaque)
>>>>     }
>>>>   +int ap_chsc_sei_nt0_get_event(void *res)
>>>> +{
>>>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>>>> +    APConfigChgEvent *cfg_chg_event;
>>>> +
>>>> +    if (!ap_chsc_sei_nt0_have_event()) {
>>>> +        return 1;
>>>> +    }
>>>> +
>>>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>>>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>>>> +
>>>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>>>
>>> btw, I don't know if this was discussed. Are we OK to manipulate the
>>> 'cfg_chg_events' construct withou locking ?
>>
>> This has never been discussed, but it's an interesting question. The
>> ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event functions
>> are called as a result of a SIE exit to handle interception of a
>> CHSC SEI instruction. Handling of the intercepted instructions is
>> done under the Big QEMU Lock (see kvm_arch_handle_exit in 
>> target/s390x/kvm/kvm.c),
>> so presumably no other processes will get access to these functions
>> until the instruction is handled.
>>
>> On the other hand, the vfio_cfg_chg_notifier_handler function that 
>> handles the eventfd
>> indicating the guest's AP configuration has been changed by the host 
>> device driver
>> adds  APConfigChgEvent objects to this queue. If, however, you think 
>> about the flow,
>> when the notifier handler gets called to handle an AP config changed 
>> event, it
>> queues a channel request word (CRW) indicating there is an SEI 
>> pending. Consequently,
>> the ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event 
>> functions will get called
>> only after the guest receives the CRW event and executes the CHSC SEI 
>> instruction. Since
>> the Big QEMU Lock is taken when the CHSC SE instruction is 
>> intercepted, it can not proceed
>> until whatever the holding process releases it; so for that flow, it 
>> seems highly likely if not
>> impossible for conflict given the event will always be added to the 
>> queue before an attempt
>> can be made to retrieve it.
>>
>> Having gone through this dissertation, I don't see how it can hurt to 
>> lock the queue when
>> it is being accessed and would certainly make things bullet proof. 
>> What is your opinion?
>
> In that case, let's keep it simple (no mutex) and add a 
> assert(bql_locked())
> statement where we think the bql should be protecting access to shared

I don't think we want to do that in the vfio_cfg_chg_notifier_handler 
function because
that function is called when the host device driver signals an eventfd 
to notify
userspace that the guest's AP configuration has been changed and I don't 
think the
Big QEMU Lock is taken during that process.

> resources.
>
> Thanks,
>
> C.
>


