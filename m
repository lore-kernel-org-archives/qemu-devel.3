Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C44CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 17:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utr3f-00038j-It; Wed, 03 Sep 2025 13:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1utr3c-00033t-5C; Wed, 03 Sep 2025 13:14:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1utr3a-0007Lj-2z; Wed, 03 Sep 2025 13:14:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DpuFD001199;
 Wed, 3 Sep 2025 17:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=iD+PDB
 +/lBIHSlOhm+EiphhNZpILv18wrNYhEKGBPjg=; b=BnOIiBEEkhGXvOq+cM28pL
 8vjQ2UH3mxHKbtuRKfhI8QZwwk60LSJxNQavwdwosdHPjGZWo469GV1aGeY7Ta4c
 7l/zk75iclt43dju8lAwGGe0PVDwyKMgr7JCFFv3SnLk+Cc18r5flI8xYwU5TYz0
 sEAN5Y7C2vJMz0jB11aC3wlonFvD5h3t1ASzcKq9GqkZNXx80H2pscmUHGnwTxdX
 XbJKUH8ZYZFHpv6zPjRY6DfGSbsru9L/Cd/9ENRyfLuyXbf4NSxawzW7ZNZKidlM
 DhvmW6jSQub4n0QW3riPS9shoLhG2fOdhH9X2oFWe5+J7rq/RbPz/CVq0/z8veJQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshf1fwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 17:13:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 583EDPxq021170;
 Wed, 3 Sep 2025 17:13:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmprgts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Sep 2025 17:13:59 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 583HDnjA14156298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Sep 2025 17:13:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B0D25805F;
 Wed,  3 Sep 2025 17:13:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4D1258053;
 Wed,  3 Sep 2025 17:13:57 +0000 (GMT)
Received: from [9.61.246.70] (unknown [9.61.246.70])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Sep 2025 17:13:57 +0000 (GMT)
Message-ID: <faf3b763-b59c-4000-b5f7-52034d4c1d23@linux.ibm.com>
Date: Wed, 3 Sep 2025 10:13:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] s390x/pci: Reset a device in error state
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, thuth@redhat.com, alex.williamson@redhat.com
References: <20250825212434.2255-1-alifm@linux.ibm.com>
 <20250825212434.2255-5-alifm@linux.ibm.com>
 <e3e6f261-4bc5-40f4-b3f9-65d2293e9276@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <e3e6f261-4bc5-40f4-b3f9-65d2293e9276@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yO0-20V3nEUjXkGlDy93xmfUtoIv9FoY
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b87757 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=E6UQ9Z90kloSS1QpMlcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yO0-20V3nEUjXkGlDy93xmfUtoIv9FoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfX+YlLv442RCW1
 7mbpOwpvqnvgdVrzEfp3rHM6YDSPedR3kXLVeEL3R0RSTTuYXCfqp17YuGO6flj0Qhi6aqO/oAs
 7Ur4tQpFSx1X0eoInliTw+D7BDUAO3s0Fm/REDh+/AwNAZKeXQ1if5FPt/+EuZgg4ih6LuZyFLh
 rM9kQkT9MRHoZmBXm/KF/4P2N+gHFAobyuvePfl8MyzcwPFwOV/7NPy3zFHRgW2yCu0+eeIkYJ/
 HwsYYIilVUQfohzE+JLT7FV3uD+zFr7ZXKfviNZOfipw7Ctnb/VMiMZsrhduS9s6DOlLJP/ulrS
 QtTEtqiGm+G9qCwADkS+8eixUvYIFxbZo0eWvc4i5Qn+8DtzEUeLMvdXmPNKyv92LEe6gNMo/Ny
 q/xUi9PB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/1/2025 4:17 AM, Cédric Le Goater wrote:
> On 8/25/25 23:24, Farhan Ali wrote:
>> For passthrough devices in error state, for a guest driven reset of the
>> device we can attempt a reset to recover the device. A reset of the 
>> device
>> will trigger a CLP disable/enable cycle on the host to bring the device
>> into a recovered state.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          | 7 +++++++
>>   hw/s390x/s390-pci-vfio.c         | 6 ++++++
>>   include/hw/s390x/s390-pci-vfio.h | 2 ++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index af42eb9938..c9c2d775f0 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -1493,6 +1493,8 @@ static void s390_pci_device_reset(DeviceState 
>> *dev)
>>           return;
>>       case ZPCI_FS_STANDBY:
>>           break;
>> +    case ZPCI_FS_ERROR:
>> +        break;
>>       default:
>>           pbdev->fh &= ~FH_MASK_ENABLE;
>>           pbdev->state = ZPCI_FS_DISABLED;
>> @@ -1505,6 +1507,11 @@ static void s390_pci_device_reset(DeviceState 
>> *dev)
>>       } else if (pbdev->summary_ind) {
>>           pci_dereg_irqs(pbdev);
>>       }
>> +
>> +    if (pbdev->state == ZPCI_FS_ERROR) {
>> +        s390_pci_reset(pbdev);
>> +    }
>> +
>>       if (pbdev->iommu->enabled) {
>>           pci_dereg_ioat(pbdev->iommu);
>>       }
>> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
>> index 87ecd06a81..a11ec770a7 100644
>> --- a/hw/s390x/s390-pci-vfio.c
>> +++ b/hw/s390x/s390-pci-vfio.c
>> @@ -158,6 +158,12 @@ static void s390_pci_err_handler(VFIOPCIDevice 
>> *vfio_pci)
>>       return;
>>   }
>>   +void s390_pci_reset(S390PCIBusDevice *pbdev)
>> +{
>> +    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, 
>> VFIOPCIDevice, pdev);
>> +    ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET);
>> +}
>> +
>>   static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>>                                  struct vfio_device_info *info)
>>   {
>> diff --git a/include/hw/s390x/s390-pci-vfio.h 
>> b/include/hw/s390x/s390-pci-vfio.h
>> index 66b274293c..c28dafeed8 100644
>> --- a/include/hw/s390x/s390-pci-vfio.h
>> +++ b/include/hw/s390x/s390-pci-vfio.h
>> @@ -23,6 +23,7 @@ void s390_pci_end_dma_count(S390pciState *s, 
>> S390PCIDMACount *cnt);
>>   bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
>>   void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
>>   void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev);
>> +void s390_pci_reset(S390PCIBusDevice *pbdev);
>>   #else
>>   static inline bool s390_pci_update_dma_avail(int fd, unsigned int 
>> *avail)
>>   {
>> @@ -41,6 +42,7 @@ static inline bool 
>> s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>>   }
>>   static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
>>   static inline void s390_pci_setup_err_handler(S390PCIBusDevice 
>> *pbdev) { }
>> +void s390_pci_reset(S390PCIBusDevice *pbdev) { }
>
> static inline void ... ^
>
>
> Thanks,
>
> C.

Ack, will change.

Thanks

Farhan


>
>
>
>>   #endif
>>     #endif
>
>

