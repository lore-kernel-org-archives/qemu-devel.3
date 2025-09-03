Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6942CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 17:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utrcz-00037b-QA; Wed, 03 Sep 2025 13:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1utrcd-000301-Rf; Wed, 03 Sep 2025 13:50:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1utrcZ-0001xT-BD; Wed, 03 Sep 2025 13:50:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583En0dS000501;
 Wed, 3 Sep 2025 17:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wlESbv
 d+VLP5m9HFcsMeMBKR1U2NgmbferJSin1sTJE=; b=TxI+i6Y69lpKiWHsBDRUOy
 t3Q9g5H0EbWXGlGGExppCDjhsfDqJyx2qshegUMZK7ebUjUIEIRBldbXfw57i11u
 DNHcFv+0/Ew9p3AxYiNhlQPw/J60td5sf7xMVwXn/K/DHfvPxQeGZksgfjlIEkbS
 IYpTVeZjErYyO35/Et+03u6cJmX8nrzX7DRLcpQ0lvgYgBhAnsPPbZEjSdGscmDB
 RlKQA4/hToaNOzZNZkiCth0OI6EPFugQkFf+2zyAJo0q+bGx6viklShsNuytrno7
 vTbhzQHgUbi6SuWv6RQErF1Nt4Gsr3AXNC7H+QPVBsomUfUZkaya5Tp1JbTDXkAg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdduan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 17:50:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 583EcmjA019313;
 Wed, 3 Sep 2025 17:49:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n0he9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 17:49:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 583HnnqE24904308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Sep 2025 17:49:49 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7356E5804E;
 Wed,  3 Sep 2025 17:49:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E0335803F;
 Wed,  3 Sep 2025 17:49:57 +0000 (GMT)
Received: from [9.61.89.204] (unknown [9.61.89.204])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Sep 2025 17:49:57 +0000 (GMT)
Message-ID: <5ed9c5ef-cb1d-428c-a822-9f378fabd755@linux.ibm.com>
Date: Wed, 3 Sep 2025 13:49:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] s390x/pci: Add PCI error handling for vfio pci
 devices
To: Farhan Ali <alifm@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-4-alifm@linux.ibm.com>
 <24333a79-2a49-4abb-8bb7-8e5b30a0d58b@redhat.com>
 <d396992a-1412-433c-afa8-619c7574de29@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <d396992a-1412-433c-afa8-619c7574de29@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b87fc8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=jTy7u8df8b6q5aTuflMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXxkkOOhKfMkjg
 x3kOIWGIHE9bR3/cvrCcc2deTKM8+9hZZgQFWkgvF+qXgNxmcUjpDpHuBOjzth5kF9HO2nUX/jr
 ZyrpT/blbjsprUHAhoH+obwF0zb/SGJPivoz53kZRP8mgKxaoWAPTW2Zio8HAO3IV+Nj0f957Sl
 ARgX2wtCcjX1QHf2c70R+U/B5GBu5sryC696w/bR4qfpzdrvbpghz87Nc+1HnTCx3S+RhUfWjgM
 3720UqNucwUmg7LNT1Kei0I68cLUDHqGV+y3kuBxSFc/f29UiXFQTOwuBv/AU88N6Oc1QOJZjOH
 8QdgWH+vqNceazE/lm73cu28DzxY8pTyZrIcmyuNsIjKePkXkmohM2uQUD+ZxsL28j8QFdkb8ar
 PkaLU18c
X-Proofpoint-GUID: ASOolwTxc-2OBG7-iIoujXkoLE26bzz5
X-Proofpoint-ORIG-GUID: ASOolwTxc-2OBG7-iIoujXkoLE26bzz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 9/3/25 1:12 PM, Farhan Ali wrote:
> 
> On 9/1/2025 4:25 AM, Cédric Le Goater wrote:
>> On 8/25/25 23:24, Farhan Ali wrote:
>>> Add an s390x specific callback for vfio error handling. For s390x pci devices,
>>> we have platform specific error information. We need to retrieve this error
>>> information for passthrough devices. This is done via a memory region which
>>> exposes that information.
>>>
>>> Once this error information is retrieved we can then inject an error into
>>> the guest, and let the guest drive the recovery.
>>>
>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>> ---
>>>   hw/s390x/s390-pci-bus.c          |  5 +++
>>>   hw/s390x/s390-pci-vfio.c         | 76 ++++++++++++++++++++++++++++++++
>>>   include/hw/s390x/s390-pci-bus.h  |  1 +
>>>   include/hw/s390x/s390-pci-vfio.h |  2 +
>>>   4 files changed, 84 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index f87d2748b6..af42eb9938 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -158,6 +158,8 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>>   {
>>>       HotplugHandler *hotplug_ctrl;
>>>   +    qemu_mutex_destroy(&pbdev->err_handler_lock);
>>> +
>>>       if (pbdev->pft == ZPCI_PFT_ISM) {
>>>           notifier_remove(&pbdev->shutdown_notifier);
>>>       }
>>> @@ -1140,6 +1142,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>           pbdev->iommu->pbdev = pbdev;
>>>           pbdev->state = ZPCI_FS_DISABLED;
>>>           set_pbdev_info(pbdev);
>>> +        qemu_mutex_init(&pbdev->err_handler_lock);
>>>             if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>>>               /*
>>> @@ -1164,6 +1167,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>               pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
>>>               /* Fill in CLP information passed via the vfio region */
>>>               s390_pci_get_clp_info(pbdev);
>>> +            /* Setup error handler for error recovery */
>>> +            s390_pci_setup_err_handler(pbdev);
>>
>> This can fail. Please add an 'Error **' parameter and change the returned
>> value to bool.
>>
> I wanted to avoid hard failing here as we can have mismatch in kernel and QEMU support for the feature. For example we can have a newer QEMU version with the feature running on an older kernel. So wanted to treat any error in setting up the error handler would be more of an info/warn message.

+1, please do not cause a hard failure if the underlying host kernel is simply missing support...

>>> +void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev)
>>> +{
>>> +    int ret;
>>> +    VFIOPCIDevice *vfio_pci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
>>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>> +                              sizeof(uint64_t))] = {};
>>> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
>>> +
>>> +    feature->argsz = sizeof(buf);
>>> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>>> +
>>> +    ret = vfio_pci->vbasedev.io_ops->device_feature(&vfio_pci->vbasedev,
>>> +                                                     feature);
>>
>> Please introduce vfio helpers to hide the internal indirection :
>>
>>   ->vbasedev.io_ops->device_feature(...)
>>
>>> +
>>> +    if (ret) {
>>
>> Shouldn't we test the return value to decide if the error is
>> an unimplemented feature or an unexpected error ?
> 
> Yeah, I think it makes sense separate out error for unimplemented feature (ENOTTY) vs any other unexpected error. Will change this.
> 

... But if you add differentiation here between the 2 types of errors then I would be fine with hard-fail for unexpected cases and info/warn for missing host kernel support.

