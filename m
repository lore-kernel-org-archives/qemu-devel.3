Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8BEC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nv5-0006L0-5D; Wed, 02 Sep 2026 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1nv3-0006KU-Dk; Wed, 02 Sep 2026 12:34:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1nv1-0007fB-EW; Wed, 02 Sep 2026 12:34:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GXdO43600651; Wed, 2 Sep 2026 16:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5VsAUS
 ZU+oDzhtGFv8HJWhpiXMywCjyH8ThbxBr0+JY=; b=eLs6mf8KqzXWQJxd2NKWXN
 cXWxeI+U29ygZaR7nFAscRh7hnVMJY55HBQXYUJxWE1xmyPJPGTiY/aKjt1KRi8k
 6Avjn8E3VaUFqofrIfF5LbM8nEYrrDUi3VIvMaLPBVeQRPWNIVUaErYyVwjvwLJ8
 NrK/0rm6xm2Pn68CIlNiWGl2y2jXr4xtZH6qmTOhQcgeBHkCcGBrECwA2tOs+5c4
 X/3BTaT5cIJjvNxzjy1uOMAoLuZYVc9IWfV+H//3AMWakthLaDNXPGXs7cU5zvTX
 3zlDZMOvqqQXy82XxOh4jmdfCYeG9Ld8QH0Oy2ZhefcY7vyHAYsj0x6EZ02SvEag
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudyqd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:34:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682GQG8i006293;
 Wed, 2 Sep 2026 16:34:32 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hjxkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:34:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682GYVmd11469348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 16:34:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 212DD58045;
 Wed,  2 Sep 2026 16:34:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14AC358050;
 Wed,  2 Sep 2026 16:34:30 +0000 (GMT)
Received: from [9.61.241.1] (unknown [9.61.241.1])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 16:34:29 +0000 (GMT)
Message-ID: <d32b992a-e4b2-494a-ad27-e38caaff7dc1@linux.ibm.com>
Date: Wed, 2 Sep 2026 09:34:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] vfio/pci: Add an error handler callback
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZO6aq3UFpVRYl7Iy_HFEiVdqNjns9hrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX1BOP115hKoVL
 iLK+geXGamxSzom/M31NPI1BSZVuY9l6oj9XiwphsdJnA+bHecKDLvc+tcYsUa7klRwcXic6+bV
 8RKJF34PdPPyU3iVg5La98hkxK02JchzFKPWhGOZhHFRL3xt1DdOirJX+1zrgFPtjMASus+xCeo
 vnoqbvPOWB02Ughq5MBO0ff4vVodJmdzEhpdAo/NTxAOey73akwM6jIF6EMIq3yWgr3chGKeTcs
 jq9uC49K1jKJpCDhz9Co6pasg/GoVLgh9eeB3BN269C73XcJ+Q8q7sY+2+Ooq30GtPdpTe/ZI9f
 JYHuj46cyiUNORc2I6xTstr0zCYhTaphxKmruwL6lwTz+CHqDomYcI6uNJzYU/uNRTvGkc6lNsc
 9W8nCD0qPF3OQZ2cQXRPE8Q76sfx9GFfw+SCB8c07j1ifaXC97o6+7ZcigJoyqE+lDeCqo19Nay
 /SaU4UJrFeIbupmXrCA==
X-Proofpoint-ORIG-GUID: ZO6aq3UFpVRYl7Iy_HFEiVdqNjns9hrC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX0gH4Jqm2mTvW
 SUrv9bzS3xe51AYrS+uSTZWh5DXbWxyThf6uT5wi7ZQCRoSJixvbVsHKsiioypGtsU2XGOgxZZF
 yf59xBHpGDN6DEh3O5GnVzZ8fF2SbE4=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a985019 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=UqCG9HQmAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=iUl3kLmSOR0th9mi1McA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020146
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
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


On 9/2/2026 1:07 AM, Cédric Le Goater wrote:
> +Shameer, who is looking at forwarding AER errors to guest :
>
> https://lore.kernel.org/qemu-devel/SJ0PR12MB8614DDFEE3A9575564EDEF99ABFF2@SJ0PR12MB8614.namprd12.prod.outlook.com/
>
> On 8/31/26 20:31, Farhan Ali wrote:
>> Provide a vfio error handling callback, that can be used by devices to
>> handle PCI errors for passthrough devices.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/vfio/pci.c | 27 +++++++++++++++++++++------
>>   hw/vfio/pci.h |  1 +
>>   2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 428ab2f069..a2f489b34d 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3244,21 +3244,36 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>   static void vfio_err_notifier_handler(void *opaque)
>>   {
>>       VFIOPCIDevice *vdev = opaque;
>> +    Error *err = NULL;
>>         if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>           return;
>>       }
>>         /*
>> -     * TBD. Retrieve the error details and decide what action
>> -     * needs to be taken. One of the actions could be to pass
>> -     * the error to the guest and have the guest driver recover
>> -     * from the error. This requires that PCIe capabilities be
>> -     * exposed to the guest. For now, we just terminate the
>> +     * We can retrieve the error details and decide what action
>> +     * needs to be taken in err_handler(). One of the actions could
>> +     * be to pass the error to the guest and have the guest driver
>> +     * recover from the error. This requires that PCIe capabilities be
>> +     * exposed to the guest.
>> +     *
>> +     * If err_handler() is not implemented/fails, we just terminate the
>>        * guest to contain the error.
>>        */
>>   -    error_report("%s(%s) Unrecoverable error detected. Please 
>> collect any data possible and then kill the guest", __func__, 
>> vdev->vbasedev.name);
>> +    if (vdev->err_handler && vdev->err_handler(vdev, &err)) {
>> +        return;
>> +    }
>> +
>> +    if (err) {
>> +        error_prepend(&err, "Unrecoverable PCIe error detected for 
>> device %s",
>> +                      vdev->vbasedev.name);
>> +        error_report_err(err);
>> +    } else {
>> +        error_printf("Unrecoverable PCIe error detected for device %s",
>> +                     vdev->vbasedev.name);
>> +    }
>> +    error_printf("Please collect any data possible and then kill the 
>> guest");
>
> how about that instead :
>
>   if (err) {
>       error_report("Unrecoverable PCIe error detected for device %s: %s",
>                    vdev->vbasedev.name, error_get_pretty(err));
>       error_free(err);
>   } else {
>       error_report("Unrecoverable PCIe error detected for device %s",
>                    vdev->vbasedev.name);
>   }
>   error_printf("Please collect any data possible and then kill the 
> guest\n");
>
>>         vm_stop(RUN_STATE_INTERNAL_ERROR);
>>   }
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c9ab949870..c067bbbebc 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -146,6 +146,7 @@ struct VFIOPCIDevice {
>>       EventNotifier err_notifier;
>>       EventNotifier req_notifier;
>>       int (*resetfn)(struct VFIOPCIDevice *);
>> +    bool (*err_handler)(struct VFIOPCIDevice *, Error **);
>
> Please add documentation, something like :
>
>   /*
>    * Platform-specific error recovery handler.
>    *
>    * Called when the host reports a PCI error via the VFIO error 
> notifier.
>    * The handler should attempt to recover the device and forward the
>    * error to the guest if the platform supports it.
>    *
>    * @vdev: the VFIO PCI device that triggered the error
>    * @errp: set with the failure reason on false return
>    *
>    * Return true on success, the VM continues running.
>    * Return false on failure and set @errp, the VM will be stopped.
>    */
>   bool (*err_handler)(struct VFIOPCIDevice *vdev, Error **errp);
>
Yup, I can add that.


>
> That said, I'd prefer to see AER forwarding first.

I am curious too to understand how AER forwarding will work. Based on 
qemu patches (which may not be complete) [1], I can't tell how AER or an 
event will be sent to a guest to notify of an error. Based on the 
discussion on the link you posted, it looks like APEI/GHES based events 
would be sent to the guest?

Another question regarding AER recovery series, do we need some 
mechanism to get the AER information from the kernel for userspace? I am 
trying to understand if QEMU has to forward an AER event, does it need 
to get information such status/mask registers etc?


[1] 
https://github.com/shamiali2008/qemu-master/commit/e45458710cd8509fa5bd81f4376126b77b6f40be


>
> Thanks,
>
> C.
>
>
>>       uint32_t vendor_id;
>>       uint32_t device_id;
>>       uint32_t sub_vendor_id;
>

