Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3C3F364B0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 10:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB9Q5-0002qu-Hs; Fri, 10 Apr 2026 06:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wB9Q0-0002oM-Gd; Fri, 10 Apr 2026 06:48:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wB9Pw-0000E3-Po; Fri, 10 Apr 2026 06:48:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639N6Qun2327209; Fri, 10 Apr 2026 10:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=x0nY8t
 CmVwsLH0Z+8iONgUZGBaWbrsrJT0B2upYqN0I=; b=PuGba9pXuG++ozYeOTpBUN
 yXNVkxXf9Hoie8GO3Suh2za8k0XPa9UmQG3Gc4dFTuVtEwnKz0vlGG4gF27zF+Rv
 rrRRo7jebTZQA9trmqOarxib3zSZzqAGexqtN8W90cNZfS5RfyaDxScCvcmoJOR6
 Wh4hnx3+CzL8PbjF54FgTEcToOmjQoXUMY6g0pgjhQ8UgUpZjCINRRtfOnHkpghv
 Qs09QC0IMrKHzHdb5DIWRmo7QIWU6G4h+rftHJCAOrkieQaoHQLsQUI3l0mem09V
 YSqCKD6VyyITvdiwi6NVd6b3a0nGx5liIp5LcCzrt7I3wciJ6hpemWgO9WKCjoLg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2krdn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:48:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63A8UphI026661;
 Fri, 10 Apr 2026 10:48:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg87jph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 10:48:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63AAmmMI5506034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Apr 2026 10:48:48 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89A5058062;
 Fri, 10 Apr 2026 10:48:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE3A058057;
 Fri, 10 Apr 2026 10:48:47 +0000 (GMT)
Received: from [9.61.133.90] (unknown [9.61.133.90])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Apr 2026 10:48:47 +0000 (GMT)
Message-ID: <1427dff4-139a-43cd-8db7-fb3f5a73f731@linux.ibm.com>
Date: Fri, 10 Apr 2026 06:48:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/vfio/ap: Extend vfio device state description
 to facilitate live migration
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
 alex@shazbot.org, cohuck@redhat.com
References: <20260409141352.997844-1-akrowiak@linux.ibm.com>
 <20260409141352.997844-2-akrowiak@linux.ibm.com>
 <7bcb67c8-d3c7-4240-a055-a30cb0bb76a2@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <7bcb67c8-d3c7-4240-a055-a30cb0bb76a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwMCBTYWx0ZWRfX0fXmp+09AhGT
 qTFg918FnbrgKGJbmqQ183hJv7DbFOZ6HYWFrIKzxzMTIFTLRWq3L3Mllzn6kmUl+UYNXvcVo4K
 Hv+yyY+Kybijn6VC/V7S2BbKD+ZCcc3T3+csAwvvV+N3N7ZxqRTO6W46zPGXuqPvrUCHeLCGlei
 rZ6DYTNh60d+psK5QKCZ10dsyhLmwwMrwWVJaAZfzq/83MhExvuAlxthBM8E4rcDBXA80zg70n5
 WSFue1BYDKjMPlere/q7gJuppNVz/IFfA/6U3+wKyEjAHY8WcXnEVdJvkiMX/s24pu73fDExV/n
 GGVJ71rUKYr5/P5eYGbEc83AXhzYeHAsWJWTTHSbr/Sst7dnGSb0e400IM5IQinGsK5mTWhfqAb
 kZrBs6+TYvDrwdZAmxKJFzq6EMphLmcczgaATPLAOoznOqONaeki4fP7XNYOKvwZEO1aHJ5WTkI
 /G4oJqjUoMXPRkaI40w==
X-Proofpoint-ORIG-GUID: 8rYmj_qOvcyia9fFAMB0LyAGD5noboRR
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d8d593 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=PXnxOevhQeBq-AhzmBIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8rYmj_qOvcyia9fFAMB0LyAGD5noboRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100100
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 4/10/26 4:17 AM, Cédric Le Goater wrote:
> On 4/9/26 16:13, Anthony Krowiak wrote:
>> Make the changes needed to the VFIOAPDevice state description to 
>> facilitate
>> live guest migration.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c | 19 +++++++++++--------
>>   1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 5c8f305653..fd68983702 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -41,6 +41,16 @@ struct VFIOAPDevice {
>>       EventNotifier req_notifier;
>>       EventNotifier cfg_notifier;
>>   };
>> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>> +
>> +static const VMStateDescription vmstate_ap_device = {
>> +    .name = "vfio-ap-device",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>>     typedef struct APConfigChgEvent {
>>       QTAILQ_ENTRY(APConfigChgEvent) next;
>> @@ -56,8 +66,6 @@ static void __attribute__((constructor)) 
>> vfio_ap_global_init(void)
>>       qemu_mutex_init(&cfg_chg_events_lock);
>>   }
>>   -OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>> -
>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>>   {
>>       vdev->needs_reset = false;
>> @@ -297,11 +305,6 @@ static void vfio_ap_reset(DeviceState *dev)
>>       }
>>   }
>>   -static const VMStateDescription vfio_ap_vmstate = {
>> -    .name = "vfio-ap",
>> -    .unmigratable = 1,
>> -};
>> -
>>   static void vfio_ap_instance_init(Object *obj)
>>   {
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
>> @@ -335,7 +338,7 @@ static void vfio_ap_class_init(ObjectClass 
>> *klass, const void *data)
>>   #ifdef CONFIG_IOMMUFD
>>       object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
>>   #endif
>
> You will need to rebase on 'vfio-next' or 'master' when the changes
> pending in the vfio queue are merged.

Will do. Thanks for the review.

>
>
>> -    dc->vmsd = &vfio_ap_vmstate;
>> +    dc->vmsd = &vmstate_ap_device;
>>       dc->desc = "VFIO-based AP device assignment";
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       dc->realize = vfio_ap_realize;
>


