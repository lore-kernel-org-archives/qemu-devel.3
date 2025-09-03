Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8242BCA1011
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 17:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utr2d-0002hV-Ov; Wed, 03 Sep 2025 13:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1utr2b-0002gx-I8; Wed, 03 Sep 2025 13:13:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1utr2Y-0007HM-K3; Wed, 03 Sep 2025 13:13:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583E8HUR008655;
 Wed, 3 Sep 2025 17:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gYRr8F
 0R++5kC+4Y9Uk1Cuy5LbaAjl7xLruAPm4g8NQ=; b=QlELa2cqcP6apGiqKK0fkg
 1lOnOEIcyoQA4E29f7Jm0fK9t3MUoera5KlLWNtvjHMy492Z3pE8IoEYvzWJ/4WF
 DRMOqIOa4omP5Fr9njkJ3PC5O7AdMzV5CFdthjeaqcf0dJF/ZO+bmBY/Cf/CNY40
 6+y9tu/OeOHuq+dNAfwEEM7oiVLxwhzVq+HWrlaDF51WnrQtQTNuSQY/6CVZzHIT
 Bhdk/aEAOVBbifYgtTK9yz4lNBjz/m03SJ7l9kQ6S/4rOAuLzkSiAMmH4zTosDDm
 ysUsCpxhfJ0QMuSAmRthq4EpLOlOx04K8oD+DPfZ6v2nAIRq2s9byHGF5B0U66HA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswddpyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 17:12:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 583DuIG8019926;
 Wed, 3 Sep 2025 17:12:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmu8r71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 17:12:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 583HChWF10748460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Sep 2025 17:12:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E839D58053;
 Wed,  3 Sep 2025 17:12:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 102C558043;
 Wed,  3 Sep 2025 17:12:52 +0000 (GMT)
Received: from [9.61.246.70] (unknown [9.61.246.70])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Sep 2025 17:12:51 +0000 (GMT)
Message-ID: <d396992a-1412-433c-afa8-619c7574de29@linux.ibm.com>
Date: Wed, 3 Sep 2025 10:12:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] s390x/pci: Add PCI error handling for vfio pci
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-4-alifm@linux.ibm.com>
 <24333a79-2a49-4abb-8bb7-8e5b30a0d58b@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <24333a79-2a49-4abb-8bb7-8e5b30a0d58b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b87716 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=2uLQPuPdUKWSm3ymg8AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX0U3QjZS77CVb
 A3CS0Ni8ADPqdCSXCFVOQPtV5YkGDsfjqon7rlarnqPOiceaWxQvRgAU++VOQ8PgWNaK94z0+RP
 438jqviUJKowy+6Stirh1kHy27nnUSsmruevYqMgZ/Xtx8LUkfrLojmuFXf+XoU2r9njuv8pUrC
 q1si6BDzJLTEk/08z3I+yDlUZs4kpujC2FKB6PCExA17LGAMpjv/27R7FCG2uzSaCpDpUz3pVjv
 LX6tAhW/ilnpLuWZTwIgIq02RpB1wePn3DcVR8Apy+G5uqLYoPJ3k7bnZISui3OHRr0g7ziP4yI
 eFN/9ViNNJ4sOjsjvcyE53xbmHBJV7Hw/2LGFA3qFZHgKHwAn9PmAe0KpijkXQWCmZv+gD7wrEX
 H5lfSURJ
X-Proofpoint-GUID: rtHQ3ciOCJoRyNB-ZR7G-PmFDzlIupS8
X-Proofpoint-ORIG-GUID: rtHQ3ciOCJoRyNB-ZR7G-PmFDzlIupS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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


On 9/1/2025 4:25 AM, Cédric Le Goater wrote:
> On 8/25/25 23:24, Farhan Ali wrote:
>> Add an s390x specific callback for vfio error handling. For s390x pci 
>> devices,
>> we have platform specific error information. We need to retrieve this 
>> error
>> information for passthrough devices. This is done via a memory region 
>> which
>> exposes that information.
>>
>> Once this error information is retrieved we can then inject an error 
>> into
>> the guest, and let the guest drive the recovery.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          |  5 +++
>>   hw/s390x/s390-pci-vfio.c         | 76 ++++++++++++++++++++++++++++++++
>>   include/hw/s390x/s390-pci-bus.h  |  1 +
>>   include/hw/s390x/s390-pci-vfio.h |  2 +
>>   4 files changed, 84 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index f87d2748b6..af42eb9938 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -158,6 +158,8 @@ static void 
>> s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>   {
>>       HotplugHandler *hotplug_ctrl;
>>   +    qemu_mutex_destroy(&pbdev->err_handler_lock);
>> +
>>       if (pbdev->pft == ZPCI_PFT_ISM) {
>>           notifier_remove(&pbdev->shutdown_notifier);
>>       }
>> @@ -1140,6 +1142,7 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>           pbdev->iommu->pbdev = pbdev;
>>           pbdev->state = ZPCI_FS_DISABLED;
>>           set_pbdev_info(pbdev);
>> +        qemu_mutex_init(&pbdev->err_handler_lock);
>>             if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>>               /*
>> @@ -1164,6 +1167,8 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>               pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, 
>> pbdev);
>>               /* Fill in CLP information passed via the vfio region */
>>               s390_pci_get_clp_info(pbdev);
>> +            /* Setup error handler for error recovery */
>> +            s390_pci_setup_err_handler(pbdev);
>
> This can fail. Please add an 'Error **' parameter and change the returned
> value to bool.
>
I wanted to avoid hard failing here as we can have mismatch in kernel 
and QEMU support for the feature. For example we can have a newer QEMU 
version with the feature running on an older kernel. So wanted to treat 
any error in setting up the error handler would be more of an info/warn 
message.


>
>
>>               if (!pbdev->interp) {
>>                   /* Do vfio passthrough but intercept for I/O */
>>                   pbdev->fh |= FH_SHM_VFIO;
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index aaf91319b4..87ecd06a81 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -10,6 +10,7 @@
>>    */
>>     #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>     #include <sys/ioctl.h>
>>   #include <linux/vfio.h>
>> @@ -103,6 +104,60 @@ void s390_pci_end_dma_count(S390pciState *s, 
>> S390PCIDMACount *cnt)
>>       }
>>   }
>>   +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
>> +                                    struct 
>> vfio_device_feature_zpci_err *err)
>
> Please add an 'Error **' parameter and change the returned value to bool.

Ack, will change this.


>
>> +{
>> +    int ret;
>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
>> +                              sizeof(struct 
>> vfio_device_feature_zpci_err),
>> +                              sizeof(uint64_t))] = {};
>> +    struct vfio_device_feature *feature = (struct 
>> vfio_device_feature *)buf;
>> +
>> +    feature->argsz = sizeof(buf);
>> +    feature->flags = VFIO_DEVICE_FEATURE_GET | 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +    ret = vfio_pci->vbasedev.io_ops->device_feature(&vfio_pci->vbasedev,
>> +                                                     feature);
>
>
> Please introduce vfio helpers to hide the internal indirection :
>
>   ->vbasedev.io_ops->device_feature(...)
>
Should we define the helpers in include/hw/vfio/vfio-device.h and should 
we define a generic helper like vfio_device_get_feature(VFIODevice 
*vdev, struct vfio_device_feature *feat) ?


>
>> +
>> +    if (ret) {
>> +        error_report("Failed feature get 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR"
>> +                    " (rc=%d)", ret);
>> +        return ret;
>> +    }
>> +
>> +    memcpy(err, (struct vfio_device_feature_zpci_err *) feature->data,
>> +           sizeof(struct vfio_device_feature_zpci_err));
>> +    return 0;
>> +}
>> +
>> +static void s390_pci_err_handler(VFIOPCIDevice *vfio_pci)
>> +{
>> +    S390PCIBusDevice *pbdev;
>> +    struct vfio_device_feature_zpci_err err;
>> +    int ret;
>> +
>> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
>> + DEVICE(&vfio_pci->pdev)->id);
>> +
>> +    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
>> +
>> +    ret = s390_pci_get_feature_err(vfio_pci, &err);
>> +    if (ret) {
>> +        return;
>> +    }
>> +
>> +    pbdev->state = ZPCI_FS_ERROR;
>> +    s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 
>> 0);
>> +
>> +    while (err.pending_errors) {
>> +        ret = s390_pci_get_feature_err(vfio_pci, &err);
>> +        if (ret) {
>> +            return;
>> +        }
>> +        s390_pci_generate_error_event(err.pec, pbdev->fh, 
>> pbdev->fid, 0, 0);
>> +    }
>> +    return;
>> +}
>> +
>>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>                                  struct vfio_device_info *info)
>>   {
>> @@ -369,3 +424,24 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>>       s390_pci_read_util(pbdev, info);
>>       s390_pci_read_pfip(pbdev, info);
>>   }
>> +
>> +void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev)
>> +{
>> +    int ret;
>> +    VFIOPCIDevice *vfio_pci =  container_of(pbdev->pdev, 
>> VFIOPCIDevice, pdev);
>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>> +                              sizeof(uint64_t))] = {};
>> +    struct vfio_device_feature *feature = (struct 
>> vfio_device_feature *)buf;
>> +
>> +    feature->argsz = sizeof(buf);
>> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +
>> +    ret = vfio_pci->vbasedev.io_ops->device_feature(&vfio_pci->vbasedev,
>> +                                                     feature);
>
> Please introduce vfio helpers to hide the internal indirection :
>
>   ->vbasedev.io_ops->device_feature(...)
>
>> +
>> +    if (ret) {
>
> Shouldn't we test the return value to decide if the error is
> an unimplemented feature or an unexpected error ?

Yeah, I think it makes sense separate out error for unimplemented 
feature (ENOTTY) vs any other unexpected error. Will change this.


>
> Thanks,
>
> C.
>
>
>
>> +        info_report("Automated error recovery not available for 
>> passthrough device");
>> +        return;
>> +    }
>> +    vfio_pci->arch_err_handler = s390_pci_err_handler;
>> +}
>> diff --git a/include/hw/s390x/s390-pci-bus.h 
>> b/include/hw/s390x/s390-pci-bus.h
>> index 04944d4fed..3795e0bbfc 100644
>> --- a/include/hw/s390x/s390-pci-bus.h
>> +++ b/include/hw/s390x/s390-pci-bus.h
>> @@ -364,6 +364,7 @@ struct S390PCIBusDevice {
>>       bool forwarding_assist;
>>       bool aif;
>>       bool rtr_avail;
>> +    QemuMutex err_handler_lock;
>>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>>   };
>>   diff --git a/include/hw/s390x/s390-pci-vfio.h 
>> b/include/hw/s390x/s390-pci-vfio.h
>> index ae1b126ff7..66b274293c 100644
>> --- a/include/hw/s390x/s390-pci-vfio.h
>> +++ b/include/hw/s390x/s390-pci-vfio.h
>> @@ -22,6 +22,7 @@ S390PCIDMACount 
>> *s390_pci_start_dma_count(S390pciState *s,
>>   void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>> +void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev);
>>   #else
>>   static inline bool s390_pci_update_dma_avail(int fd, unsigned int 
>> *avail)
>>   {
>> @@ -39,6 +40,7 @@ static inline bool 
>> s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>>       return false;
>>   }
>>   static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
>> +static inline void s390_pci_setup_err_handler(S390PCIBusDevice 
>> *pbdev) { }
>>   #endif
>>     #endif
>
>

