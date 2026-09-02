Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0859BC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1o40-0000h2-3t; Wed, 02 Sep 2026 12:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1o3x-0000g9-JY; Wed, 02 Sep 2026 12:43:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x1o3u-0001iX-Th; Wed, 02 Sep 2026 12:43:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682GXS4c535927; Wed, 2 Sep 2026 16:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LNa5mJ
 bcIYuO7CIH4ZCkY1/EEFQbr9QB5vpef1gyvnM=; b=bsZAKc0XCSvE+lbUiaOQqQ
 TobZVkci2UySh1cV/SWULdiKrrJPVr0beav/Zb7F8pe1n0f7MbDGLQMPJ47wxhrd
 i17+1P+A9WRHdV98KzZ/E6J3FVZPnHDFMCtRM3PHqq0kTh5TX6nSb07UElG24S7z
 vW2Fkr3k/6q4hbICC7GvjWxW4bPdvk0mwwCb5WX4DDldFRdqgqc7RLd8RlzRY+CI
 uWsM1zfQjjfzQ0WKhRCk/NbFdBI4ElXffnwxF8IBoBlAbK8v05LjvkaozFWeoz8W
 RCXXm56lAf+qasCbE8tZHTbKO9tUGoCZNm0F/hjWsRGuWorxrV3/CvAH17WdYC0Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5r28s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:43:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682Gfgo2028333;
 Wed, 2 Sep 2026 16:43:43 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8hk0eu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 16:43:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 682GhflF51183954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Sep 2026 16:43:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C504458056;
 Wed,  2 Sep 2026 16:43:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C066558054;
 Wed,  2 Sep 2026 16:43:40 +0000 (GMT)
Received: from [9.61.241.1] (unknown [9.61.241.1])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  2 Sep 2026 16:43:40 +0000 (GMT)
Message-ID: <a6f174c3-de6b-4b9e-97bc-179c44bd3237@linux.ibm.com>
Date: Wed, 2 Sep 2026 09:43:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] s390x/pci: Add PCI error handling for vfio pci
 devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-4-alifm@linux.ibm.com>
 <5e59ad40-e50e-4671-b55f-2d891898b6e7@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <5e59ad40-e50e-4671-b55f-2d891898b6e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a985240 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=rkBsMlECKNENESMDzYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BJ63OUknvHQbsBthk55r1hF1T-Wsu098
X-Proofpoint-ORIG-GUID: BJ63OUknvHQbsBthk55r1hF1T-Wsu098
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX2Ic0orh5h9eD
 btQc5dxi0cCDH3NxGK0uGBcuUJAQJzde8Qjs3cf1ROIsOQdQcAVfStIcVL0v6oMQ4RBmMQBT7PA
 9sjXSPwi0WwM5dJP7V6S085o+MjbTiQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0NiBTYWx0ZWRfX8KSW8f9iEH4y
 HdvLc09iimGJEwosg3Q057iNzz+n1qB5Be17TQsPOQa7Gz39uUpAhkpmsqIvFPUNUWCeQzk4paU
 o967ipl3KKb4RIfpF+T6ANRYnxo6wJ2lKAemEE++8GEQjS0gq/pWgAdlCbknvvNPGDYZ5kPYwqZ
 Vd0X7mryvp3Egtkj/qr0yNKNRc1QX/MyIV3iBuvGcxV90zT4higmc963Ps93A5X4k2XJ6BK6Da9
 3QYDhrA5mVFTY2SSYCL9UK+/1Xqwld6ECidUcph5D5ip/bOI21lSv79YJifXN6WZb6+8JR7MxgR
 pogN+Z6GA5QmZZx7b6UhcFnO3d1ivNzb82RogZZxXcXMnNXCFgTChM7umxFLajYJ/z251H8efd2
 gKcoEkWAeZAsIH+2JXSDWC7irkP52f3cOkyCML/Df3zqJAI2w4nfT3xqDE7bMNMp/8wXcp38HvJ
 US+LiJqP5mJoYTy9cKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020146
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/2/2026 1:22 AM, Cédric Le Goater wrote:
> On 8/31/26 20:31, Farhan Ali wrote:
>> Add an s390x specific callback for vfio error handling. For s390x pci 
>> devices,
>> we have platform specific error information. We need to retrieve this 
>> error
>> information for passthrough devices. This is done via a 
>> VFIO_DEVICE_FEATURE
>> ioctl which exposes that information.
>>
>> Once this error information is retrieved we can then inject an error 
>> into
>> the guest, and let the guest drive the recovery.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          |   9 +++
>>   hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
>>   hw/s390x/s390-pci-vfio.c         | 100 +++++++++++++++++++++++++++++++
>>   include/hw/s390x/s390-pci-bus.h  |   2 +
>>   include/hw/s390x/s390-pci-vfio.h |   1 +
>>   5 files changed, 118 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 9ecf3c30ad..b2db7f3df4 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -160,6 +160,8 @@ static void 
>> s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>   {
>>       HotplugHandler *hotplug_ctrl;
>>   +    qemu_mutex_destroy(&pbdev->err_handler_lock);
>> +
>>       if (pbdev->pft == ZPCI_PFT_ISM) {
>>           notifier_remove(&pbdev->shutdown_notifier);
>>       }
>> @@ -1123,6 +1125,7 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>       S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>>       PCIDevice *pdev = NULL;
>>       S390PCIBusDevice *pbdev = NULL;
>> +    Error *local_err = NULL;
>>       int rc;
>>         if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>> @@ -1189,6 +1192,7 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>           pbdev->iommu->pbdev = pbdev;
>>           pbdev->state = ZPCI_FS_DISABLED;
>>           set_pbdev_info(pbdev);
>> +        qemu_mutex_init(&pbdev->err_handler_lock);
>>             if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
>>               /*
>> @@ -1213,6 +1217,11 @@ static void s390_pcihost_plug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>               pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, 
>> pbdev);
>>               /* Fill in CLP information passed via the vfio region */
>>               s390_pci_get_clp_info(pbdev);
>> +            /* Setup error handler for error recovery */
>> +            if (!s390_pci_setup_err_handler(pbdev, &local_err)) {
>> +                warn_report_err(local_err);
>> +            }
>> +
>>               if (!pbdev->interp) {
>>                   /* Do vfio passthrough but intercept for I/O */
>>                   pbdev->fh |= FH_SHM_VFIO;
>> diff --git a/hw/s390x/s390-pci-vfio-stubs.c 
>> b/hw/s390x/s390-pci-vfio-stubs.c
>> index d9882b7aad..9fc84ca135 100644
>> --- a/hw/s390x/s390-pci-vfio-stubs.c
>> +++ b/hw/s390x/s390-pci-vfio-stubs.c
>> @@ -30,3 +30,9 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, 
>> uint32_t *fh)
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>>   {
>>   }
>> +
>> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
>> +{
>> +    error_setg(errp, "VFIO not available, cannot setup error handler");
>> +    return false;
>> +}
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index db6de00bd2..9a63040e22 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -105,6 +105,73 @@ void s390_pci_end_dma_count(S390pciState *s, 
>> S390PCIDMACount *cnt)
>>       }
>>   }
>>   +static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
>
> returning a bool would be preferred unless the errno is important
>
I can change it to bool. Don't have a strong preference here.


>
>> + PciCcdfErr *ccdf,
>> +                                    uint32_t ccdf_err_length,
>> +                                    Error **errp)
>> +{
>> +    int ret;
>> +    size_t total_size;
>> +    struct vfio_device_feature_zpci_err *err;
>> +    g_autofree void *buf = NULL;
>> +    g_autofree struct vfio_device_feature *feature = NULL;
>> +
>> +    total_size = sizeof(*feature) + sizeof(*err);
>> +    feature = g_malloc(total_size);
>> +    feature->argsz = total_size;
>> +    feature->flags = VFIO_DEVICE_FEATURE_GET | 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +
>> +    buf = g_malloc(ccdf_err_length);
>> +    err = (void *)feature->data;
>> +    err->data = (uint64_t)buf;
>> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
>> +
>> +    if (ret) {
>> +        if (ret != -ENOMSG) {
>> +            error_setg(errp, "Failed feature get 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR"
>> +                              " (rc=%d)", ret);
>> +        }
>> +        return ret;
>> +    }
>> +
>> +    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
>> +
>> +    return 0;
>> +}
>> +
>> +static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
>> +{
>> +    S390PCIBusDevice *pbdev;
>> +    PciCcdfErr ccdf;
>> +    bool success = false;
>
> This means errp should be set. It is not obvious from the code below.
>
>> +    int ret = 0;
>> +
>> +    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
>> + DEVICE(&vfio_pci->parent_obj)->id);
>
> can pbdev be NULL ?
>
>   if (!pbdev) {
>       error_setg(errp, "No matching zpci device found");
>       return false;
>   }
>> +
>> +    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
>> +    pbdev->state = ZPCI_FS_ERROR;
>> +
>> +    if (sizeof(ccdf) != pbdev->ccdf_err_length) {
>> +        error_setg(errp,
>> +                   "CCDF size mismatch expected size=%zu, provided 
>> size=%d",
>> +                   sizeof(ccdf), pbdev->ccdf_err_length);
>> +        return false;
>> +    }
>> +
>> +    while (ret == 0) {
>> +        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
>> + pbdev->ccdf_err_length, errp);
>> +        if (ret) {
>> +            success = ret == -ENOMSG ? true : false;
>> +            break;
>> +        }
>> +        s390_pci_generate_error_event(ccdf.pec, pbdev->fh, 
>> pbdev->fid, 0, 0);
>
> why not use ccdf.e and ccdf.faddr for more diagnostic details ?

That's a fair point, will add that. I think this was based on the older 
version which only had the pec as the valid information.

Thanks

Farhan

>
>
>> +    }
>> +
>> +    return success;
>> +}
>> +
>>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>                                  struct vfio_device_info *info)
>>   {
>> @@ -134,6 +201,10 @@ static void s390_pci_read_base(S390PCIBusDevice 
>> *pbdev,
>>       /* Store function type separately for type-specific behavior */
>>       pbdev->pft = cap->pft;
>>   +    if (hdr->version >= 3) {
>> +        pbdev->ccdf_err_length = cap->ccdf_err_length;
>> +    }
>> +
>>       /*
>>        * If the device is a passthrough ISM device, disallow relaxed
>>        * translation.
>> @@ -371,3 +442,32 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>>       s390_pci_read_util(pbdev, info);
>>       s390_pci_read_pfip(pbdev, info);
>>   }
>> +
>> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
>> +{
>> +    int ret;
>> +    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
>> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>> +                              sizeof(uint64_t))] = {};
>> +    struct vfio_device_feature *feature = (struct 
>> vfio_device_feature *)buf;
>> +
>> +    feature->argsz = sizeof(buf);
>> +    feature->flags = VFIO_DEVICE_FEATURE_PROBE | 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR;
>> +
>> +    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
>> +
>> +    if (ret != 0) {
>> +        if (ret == -ENOTTY) {
>> +            error_setg(errp, "Automated error recovery unavailable 
>> for device");
>> +        } else {
>> +            error_setg(errp,
>> +                       "Failed to probe for 
>> VFIO_DEVICE_FEATURE_ZPCI_ERROR (ret=%d)",
>> +                       ret);
>> +        }
>> +        return false;
>> +    }
>> +
>> +    vfio_pci->err_handler = s390_pci_err_handler;
>> +
>> +    return true;
>> +}
>> diff --git a/include/hw/s390x/s390-pci-bus.h 
>> b/include/hw/s390x/s390-pci-bus.h
>> index 9228523ce8..bc67f7e065 100644
>> --- a/include/hw/s390x/s390-pci-bus.h
>> +++ b/include/hw/s390x/s390-pci-bus.h
>> @@ -364,6 +364,8 @@ struct S390PCIBusDevice {
>>       bool forwarding_assist;
>>       bool aif;
>>       bool rtr_avail;
>> +    QemuMutex err_handler_lock;
>> +    uint32_t ccdf_err_length;
>>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>>   };
>>   diff --git a/include/hw/s390x/s390-pci-vfio.h 
>> b/include/hw/s390x/s390-pci-vfio.h
>> index f7d6149daf..c7886b63ea 100644
>> --- a/include/hw/s390x/s390-pci-vfio.h
>> +++ b/include/hw/s390x/s390-pci-vfio.h
>> @@ -20,5 +20,6 @@ S390PCIDMACount 
>> *s390_pci_start_dma_count(S390pciState *s,
>>   void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
>>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>> +bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
>>     #endif
>

