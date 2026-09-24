Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D4FC9831F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 20:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pta-0002m7-GO; Thu, 24 Sep 2026 16:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9ptY-0002lr-1U; Thu, 24 Sep 2026 16:18:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9ptV-0002PY-Hz; Thu, 24 Sep 2026 16:18:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5RAx3107019; Thu, 24 Sep 2026 20:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TcFnzm
 cOK7LCFG5BT0smSHVK/+2fYCyjVsWRSbY0hB0=; b=YOW+L21+tQzgExJook9HCF
 kLtAoKOM25GSOKl8ryvg0mT4flSAvvOoarZXHrMgIfyTZ5B8Rbz199AQyabwEYnC
 a9U5ykLhk3bdyrDjSyEFFCxTipCasN+soOXVxDUKBFgWzLpQtWppI2bcDEV+3oa4
 r8cq2Gz2IkRCq/vmTf4G9C14HVpvUMKyoTF+0ZDUXSMR8BYkPmBzMOTBMEM3UTW5
 iKJNHsFNOvaqCwVxCi3eWLwr79WfYpzWImcBpV47YXp+smZvxQzhBHSVICHLey5n
 0wJMkL1as1gWnXpaU1R92rsMA4LuPtBi3a71Jt2t4K6NYNfkzoXM/r2Baa8+HNNw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvjmgh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:18:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlU2q2521564; Thu, 24 Sep 2026 20:18:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2ygc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 20:18:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OKI9iZ28574210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 20:18:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A0705805C;
 Thu, 24 Sep 2026 20:18:09 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F33A458054;
 Thu, 24 Sep 2026 20:18:07 +0000 (GMT)
Received: from [9.61.83.151] (unknown [9.61.83.151])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 20:18:07 +0000 (GMT)
Message-ID: <401d454c-6a18-4e20-83e0-5168234d4db3@linux.ibm.com>
Date: Thu, 24 Sep 2026 16:18:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci
 IPL
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-5-zycai@linux.ibm.com>
 <19fa931f-5672-4595-b7ec-98c60db94260@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <19fa931f-5672-4595-b7ec-98c60db94260@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7RN1DWXrpEcDLTpbHxdBNx57c8-k0tuO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MiBTYWx0ZWRfX40vyoNTokyWq
 3Zy55Y0CRtX0fRi6vToMxYvClZ3wqckPPWaIcAz7Fev78sdNyROE3dDqqiSsm868Qzp2QyXpA/6
 WbaSYJKgQqy43PCJlOe8s7nMTUWS5pk=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab58583 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=b3FoWnpCNj8zXTmlz68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7RN1DWXrpEcDLTpbHxdBNx57c8-k0tuO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MiBTYWx0ZWRfXzx8bB0eiVO7e
 NlIrc8eIgOAWvEc3x2Jy0JzrS1x75DMsn8chjjHt0HcPFnpoM9v2gj9nK48moPdsckqv9gAGbht
 KFq9rDyiRzRZXj743nuyCcU1GdwgE9Yw3B4iJencDlSi+nKLQnoiI67jcMAGrtYccJizm58yS3p
 lOjufbcz4xgbap6vWrkEJ6A3PgCVerjBK1zvBAo7ducJJIVsa0oibCCHLd+EHx1LOfoqOejq/5i
 9Q284r14bbmXEIYDcAXV9+cqYjbNkpMvmDyA3c/JY/RjOcV2tBq+EAQ2dVDaau8ipb9/GJOiZgh
 ctk62RsjGC8JqNR80Y0TCRRuzn98wJvdmhwOKQ6Umn86gpDuC5/o7AZQgQThky3/LH8c9UNT2sR
 l8B70jNbDMGbm2PHlxi6ReDWEi6AXl7HAJeoLDICbNLAipDqkfmzxYc+NAbQsb5Zg3RgBRZRfNU
 sSTbOzLmazuBI8qGUOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

On 9/24/26 4:12 PM, Matthew Rosato wrote:
> On 9/24/26 3:48 PM, Zhuoying Cai wrote:
>> Enable network booting via virtio-net-pci by implementing PCI transport
>> support for virtio-net.
>>
>> This patch also extends endianness handling for virtio PCI ring operations in
>> little-endian to ensure correct behavior on s390x.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Looks like rebase errors with this patch, see below...
> 

Thanks for catching this. I’ll fix the rebase errors.

> 
>>      /* Move index to next entry */
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
>> index 277c3ea68d..7fb987099d 100644
>> --- a/pc-bios/s390-ccw/virtio-pci.c
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -55,6 +55,9 @@ void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>>      case 0x1048:
>>      case 0x1004:
>>          vdev->dev_type = VIRTIO_ID_SCSI;
> 
> missing break?
> 
>> +    case 0x1041:
>> +    case 0x1000:
>> +        vdev->dev_type = VIRTIO_ID_NET;
>>          break;
> 
> [...]
> 
> 
>> @@ -413,6 +428,9 @@ int virtio_pci_setup(VDev *vdev)
>>          vdev->nr_vqs = 3;
>>          vdev->cmd_vr_idx = 2;
>>          virtio_pci_get_scsi_config();
> 
> missing break?
> 
>> +    case VIRTIO_ID_NET:
>> +        vdev->nr_vqs = 2;
>> +        virtio_pci_get_net_config();
>>          break;
>>      default:
>>          puts("Unsupported virtio device");
> 


