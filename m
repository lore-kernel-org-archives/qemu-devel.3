Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6EBC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIB5Y-0006mF-LW; Thu, 22 May 2025 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIB5L-0006hK-RK; Thu, 22 May 2025 14:56:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1uIB5G-0004jH-EV; Thu, 22 May 2025 14:56:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MIoVUl022784;
 Thu, 22 May 2025 18:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6S8oCW
 KhPnBUkA+4zpEOR/yGMCc96KbNfw1zh3EM3Ek=; b=L93Yx3gPGQvOm8SIjR0g/g
 psP7loPor6FV+8UPrObjPGycJunS5MlCi0r5fGfspuqzfu8DPIo2qzdq3T2/swm9
 eEaAys4o8T0YsYz4MobbBocH7GTb7itQwq1EZk4gAmtETsYnmErGj+p/hSlVpjsU
 DES9esRgID/h24axVesww0B1oZbZEvPY2UFQrwIuYHVWK9o1GHsqCPgzvdINKcL+
 8Ay9wUwro4DiLD7ehOal6xefXU12QH7r5sUK6IYSCo39jnyd+fdLESfD7WNpOFKt
 NlidVpf/rlghHKEb23VTSvBDKBT053Q5scpxegU4OtqMSfgyYVWl6q2EWuSqFITw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46t9j900tg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 18:55:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHlmNq020749;
 Thu, 22 May 2025 18:55:26 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwkq2th8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 18:55:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MItP1F51773856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 18:55:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF7C758045;
 Thu, 22 May 2025 18:55:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACE2B58050;
 Thu, 22 May 2025 18:55:23 +0000 (GMT)
Received: from [9.61.89.69] (unknown [9.61.89.69])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 18:55:23 +0000 (GMT)
Message-ID: <31cc61cf-d2f9-45ea-b825-623ae619c298@linux.ibm.com>
Date: Thu, 22 May 2025 14:55:23 -0400
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
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <7d1699d4-6d7d-4de3-a0bc-6dd345d9c2dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fegi-pUtRz9486cjiSDM6tq-nql-6lZX
X-Authority-Analysis: v=2.4 cv=O6Y5vA9W c=1 sm=1 tr=0 ts=682f731f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=P-Ai1DofQ6mkf9K0NxsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE4NyBTYWx0ZWRfX0hOQXgscIzSY
 7q1zFiv28OCy9fUqvdYhMz9PtDU38W45Pkd/mOsqmNmSyxRzeJP825q3n/zhFDa05g1ifIt/gNr
 aXo7M6UI6FbbrCpoSbX+4ahcaG08tETkDAiv//UwWNslbRTA2uqC4SfnGd0cRYYFhXkWpCAjhgc
 y2Ek/GXyzRHT5EExfLyEnPnTytFsYBDXcMI1S5f3J1wC68+WYH7Ot3jcATCGR91qJv8KAtS7Duc
 Sn9Mj03ppf911lMIBlpkIM1a9iN46m+fK86M30kp03mwSKY7Ndv5TS3mGYbxOBrMR05jW/6rWW5
 XC8LEc689iQ0RVg1q5Qk3blucvt5nwmyx3lv40HdmqHnbrrcUOz7ojIqPA01mFMXqmcLjGHSgQs
 wWQvON30mw+ujEiB7NXlxoCIMclpOzUlOrta0m9IqiqWlgb6f0Dme3IYCNsswILtJ+RenE8l
X-Proofpoint-ORIG-GUID: Fegi-pUtRz9486cjiSDM6tq-nql-6lZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_09,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220187
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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




On 5/22/25 9:30 AM, Cédric Le Goater wrote:
> On 5/12/25 20:02, Rorie Reyes wrote:
>> These functions can be invoked by the function that handles interception
>> of the CHSC SEI instruction for requests indicating the accessibility of
>> one or more adjunct processors has changed.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c                 | 39 ++++++++++++++++++++++++++++++++++++
>>   include/hw/s390x/ap-bridge.h | 22 ++++++++++++++++++++
>>   2 files changed, 61 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 5ea5dd9cca..4f88f80c54 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -96,6 +96,45 @@ static void vfio_ap_cfg_chg_notifier_handler(void 
>> *opaque)
>>     }
>>   +int ap_chsc_sei_nt0_get_event(void *res)
>> +{
>> +    ChscSeiNt0Res *nt0_res  = (ChscSeiNt0Res *)res;
>> +    APConfigChgEvent *cfg_chg_event;
>> +
>> +    if (!ap_chsc_sei_nt0_have_event()) {
>> +        return 1;
>> +    }
>> +
>> +    cfg_chg_event = QTAILQ_FIRST(&cfg_chg_events);
>> +    memset(nt0_res, 0, sizeof(*nt0_res));
>> +
>> +    QTAILQ_REMOVE(&cfg_chg_events, cfg_chg_event, next);
>
> btw, I don't know if this was discussed. Are we OK to manipulate the
> 'cfg_chg_events' construct withou locking ?

This has never been discussed, but it's an interesting question. The
ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event functions
are called as a result of a SIE exit to handle interception of a
CHSC SEI instruction. Handling of the intercepted instructions is
done under the Big QEMU Lock (see kvm_arch_handle_exit in 
target/s390x/kvm/kvm.c),
so presumably no other processes will get access to these functions
until the instruction is handled.

On the other hand, the vfio_cfg_chg_notifier_handler function that 
handles the eventfd
indicating the guest's AP configuration has been changed by the host 
device driver
adds  APConfigChgEvent objects to this queue. If, however, you think 
about the flow,
when the notifier handler gets called to handle an AP config changed 
event, it
queues a channel request word (CRW) indicating there is an SEI pending. 
Consequently,
the ap_chsc_sei_nt0_get_event and ap_chsc_sei_nt0_have_event functions 
will get called
only after the guest receives the CRW event and executes the CHSC SEI 
instruction. Since
the Big QEMU Lock is taken when the CHSC SE instruction is intercepted, 
it can not proceed
until whatever the holding process releases it; so for that flow, it 
seems highly likely if not
impossible for conflict given the event will always be added to the 
queue before an attempt
can be made to retrieve it.

Having gone through this dissertation, I don't see how it can hurt to 
lock the queue when
it is being accessed and would certainly make things bullet proof. What 
is your opinion?

>
>> +    g_free(cfg_chg_event);
>> +
>> +    /*
>> +     * If there are any AP configuration change events in the queue,
>> +     * indicate to the caller that there is pending event info in
>> +     * the response block
>> +     */
>> +    if (ap_chsc_sei_nt0_have_event()) {
>> +        nt0_res->flags |= PENDING_EVENT_INFO_BITMASK;
>> +    }
>> +
>> +    nt0_res->length = sizeof(ChscSeiNt0Res);
>> +    nt0_res->code = NT0_RES_RESPONSE_CODE;
>> +    nt0_res->nt = NT0_RES_NT_DEFAULT;
>> +    nt0_res->rs = NT0_RES_RS_AP_CHANGE;
>> +    nt0_res->cc = NT0_RES_CC_AP_CHANGE;
>> +
>> +    return 0;
>> +
>> +}
>> +
>> +int ap_chsc_sei_nt0_have_event(void)
>> +{
>> +    return !QTAILQ_EMPTY(&cfg_chg_events);
>> +}
>> +
>>   static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>>                                             unsigned int irq, Error 
>> **errp)
>>   {
>> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
>> index 470e439a98..f4d838bf99 100644
>> --- a/include/hw/s390x/ap-bridge.h
>> +++ b/include/hw/s390x/ap-bridge.h
>> @@ -16,4 +16,26 @@
>>     void s390_init_ap(void);
>>   +typedef struct ChscSeiNt0Res {
>> +    uint16_t length;
>> +    uint16_t code;
>> +    uint8_t reserved1;
>> +    uint16_t reserved2;
>> +    uint8_t nt;
>> +#define PENDING_EVENT_INFO_BITMASK 0x80;
>> +    uint8_t flags;
>> +    uint8_t reserved3;
>> +    uint8_t rs;
>> +    uint8_t cc;
>> +} QEMU_PACKED ChscSeiNt0Res;
>> +
>> +#define NT0_RES_RESPONSE_CODE 1;
>> +#define NT0_RES_NT_DEFAULT    0;
>> +#define NT0_RES_RS_AP_CHANGE  5;
>> +#define NT0_RES_CC_AP_CHANGE  3;
>
>
>
> please drop the ending ';'
>
>
> Thanks,
>
> C.
>
>
>> +int ap_chsc_sei_nt0_get_event(void *res);
>> +
>> +int ap_chsc_sei_nt0_have_event(void);
>> +
>>   #endif
>


