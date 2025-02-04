Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BE7C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIsn-0006p0-5T; Tue, 04 Feb 2025 08:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfIsY-0006oA-96; Tue, 04 Feb 2025 08:22:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rreyes@linux.ibm.com>)
 id 1tfIsW-0004Ot-DD; Tue, 04 Feb 2025 08:22:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514CHWJS016593;
 Tue, 4 Feb 2025 13:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Gtxo+J
 IXRQANKuw81rowHJGM22SNX8UbHiRgoN4Mfbw=; b=LvcAJWMV+EOlz4ZFaF3hJj
 e/2UCbcMj19zMpoB3MLJyi21WRneVQhX6H+iVHstddtEmTcGNV+20aw2H+nzfYzQ
 vJeM/TcuphmwWqndkgyFkb1/F4Aitxl20c/FO1SWSUdW7ioZZgwZnp8gfbTx3caj
 VzbIvuxbwuShBSDVSgtdVT+XlpkqH0LSY2sOcUZyGL06OzISclWA83FELh3GPzWe
 +V+LmPq/GfivJ95QOm+ypxj2Gbpdt3vBiIS83BlMUqy0w29qE98uhgnCqpGF2IW3
 VJqHw337mOcbjTKUw8g18e6hLUaBE6neikRo0UYrY299TS4D+vWqV5MGc6/Cf5CQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44k02ynq6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 13:22:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514CvQW7006543;
 Tue, 4 Feb 2025 13:22:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyekbjcf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Feb 2025 13:22:03 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 514DM2Df27394804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 13:22:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0059C5805A;
 Tue,  4 Feb 2025 13:22:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EED7F5805C;
 Tue,  4 Feb 2025 13:22:00 +0000 (GMT)
Received: from [9.61.251.73] (unknown [9.61.251.73])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Feb 2025 13:22:00 +0000 (GMT)
Message-ID: <71b55a11-8fa5-4005-ba56-79df2815a915@linux.ibm.com>
Date: Tue, 4 Feb 2025 08:22:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] hw/vfio/ap: store object indicating AP config
 changed in a queue
To: Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com
References: <20250107184354.91079-1-rreyes@linux.ibm.com>
 <20250107184354.91079-4-rreyes@linux.ibm.com>
 <d80b686c-71ee-4a25-82bf-5cf96c43975d@linux.ibm.com>
Content-Language: en-US
From: Rorie Reyes <rreyes@linux.ibm.com>
In-Reply-To: <d80b686c-71ee-4a25-82bf-5cf96c43975d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _qEuwJSO9b-4Tdb9iNSf4O03oe18Wn9E
X-Proofpoint-ORIG-GUID: _qEuwJSO9b-4Tdb9iNSf4O03oe18Wn9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_06,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040104
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rreyes@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


On 2/3/25 11:50 AM, Anthony Krowiak wrote:
>
>
>
> On 1/7/25 1:43 PM, Rorie Reyes wrote:
>> Creates an object indicating that an AP configuration change event
>> has been received and stores it in a queue. These objects will later
>> be used to store event information for an AP configuration change
>> when the CHSC instruction is intercepted.
>>
>> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 533cadb2dd..508c6eed7a 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -41,6 +41,13 @@ struct VFIOAPDevice {
>>       EventNotifier cfg_notifier;
>>   };
>>   +typedef struct APConfigChgEvent {
>> +    QTAILQ_ENTRY(APConfigChgEvent) next;
>> +} APConfigChgEvent;
>> +
>> +QTAILQ_HEAD(, APConfigChgEvent) cfg_chg_events =
>> +    QTAILQ_HEAD_INITIALIZER(cfg_chg_events);
>> +
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>>     static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> @@ -76,6 +83,9 @@ static void vfio_ap_cfg_chg_notifier_handler(void 
>> *opaque)
>>   {
>>       VFIOAPDevice *vapdev = opaque;
>>   +    APConfigChgEvent *new_event = g_new0(APConfigChgEvent, 1);
>> +
>> +    QTAILQ_INSERT_TAIL(&cfg_chg_events, new_event, next);
>
> I didn't notice this before giving my r-b, but I don't think new_event 
> should be
> inserted into the queue until the 'event_notifier_test_and_clear' below
> passes.


Hey Tony,

Can you give me a quick explanation for this suggestion?

>>       if (!event_notifier_test_and_clear(&vapdev->cfg_notifier)) {
>>           warn_report("Event notifier not initialized");
>>           return;
>

