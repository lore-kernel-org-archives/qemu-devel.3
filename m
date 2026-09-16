Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF19C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ud5-0000Ii-KK; Wed, 16 Sep 2026 14:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6ucz-0000IK-WB; Wed, 16 Sep 2026 14:45:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6ucx-0003i6-Sj; Wed, 16 Sep 2026 14:45:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GG1nf0046150; Wed, 16 Sep 2026 18:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HduV2l
 D/K1jjudToyg5L1jEnqRx0OKTJ6KOVY86Mkak=; b=daR6cImm/KkNPX5/0BbH56
 kg5fmL3QGEr+ZG+c2kjADeWIxjXlHz/iohRf8B2X1SQ61yAmiqnMWTURMMj5hsKE
 JuTVol25ne3WF2XCaTOkMPkdefjlRK+tURedjwjBUMGzO388fINS01A/tdXxX8q9
 vWsoi28l42hb48cRpORAIlWnmQJ0JjGceCRA4oDQ971JgLWxkrRPmbRYUoWlp1zR
 z0auJlDQftXQR6Y2maE/A4d+e8fGvCtJx2S/JH9BXZvQoNVng1W7yuyeb/jcLxF1
 i/jqrChtTZK+TRiMmZAdy/fsePvdsvmSaIwKuw1Sth3u+ogfUvjbuM51UqJqep7Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv5xbb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 18:44:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFe42V1649278; Wed, 16 Sep 2026 18:44:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gq03byu9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 18:44:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68GIivCR17891934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Sep 2026 18:44:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7887558055;
 Wed, 16 Sep 2026 18:44:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4960F5804B;
 Wed, 16 Sep 2026 18:44:56 +0000 (GMT)
Received: from [9.61.249.152] (unknown [9.61.249.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Sep 2026 18:44:56 +0000 (GMT)
Message-ID: <2c2bf867-a11a-4591-88bf-bf38d114d364@linux.ibm.com>
Date: Wed, 16 Sep 2026 11:44:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/16] s390x/pci: implement IOMMU replay
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260911152137.676602-1-kshk@linux.ibm.com>
 <20260911152137.676602-2-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260911152137.676602-2-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDI1NSBTYWx0ZWRfX/eh2WGn7vrHK
 oEcNVfoEsgajW3hV01l/FNqFbF1w9uf0G+/nZxh5SBXsgpuTbPb1QeihW/0hBszQzOLk/vCo1hT
 sRAzkTd1C4BCY26ilg7gOHL8x/0l8E0=
X-Proofpoint-ORIG-GUID: 4ZyBeXVpTAQ-Ne1CdS2off0wHsVOebDh
X-Proofpoint-GUID: 4ZyBeXVpTAQ-Ne1CdS2off0wHsVOebDh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDI1NSBTYWx0ZWRfX9uCim0HHSOz/
 g5Ct74aft6w3qYXHUJe48KT0+Dtck2AnTjrUQrmCgVtDupMd5G/k7HSQ4indYjeKQhUJAPgflRq
 f2FHf1PH4om3lqSaJFBJvOpEmRznVw1927jXj1giPmTqirTiYU+3tV4b4c/R7Fu2nv8ZU9mcycQ
 2HimCIkwxsqgG/q8TU9QPSPFr5XyWKsJ6Z4RbjJKmrK2oUXX4nIId68eormtWjIGy/pfQ7BVIMb
 TjpIczxEVGbkaAiFkPbHBbXcA89s0axnOxeo/7CXtzITl7Ab5x896nGsrjhFzapQ/zPIUYSltWY
 aS5UuKgW/VcHxdRLMAqShmyxiPPxS6+KsYzBD0PZji6AhrVHcxFfMl98Unc45wnQ+z++c4/xlbG
 k89Ar9k1ct5eML9I58K1dSf9ESzLY2b7ptqbGsjee+zNp7kHI1cZtb5Hw+43nIGBdaRBc/kBLf1
 t7X6TgWRj+mCFp+OhNQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaae3ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=MCo1tqE0FQsNgFF58BcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160255
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


On 9/11/2026 8:21 AM, Konstantin Shkolnyy wrote:
> From: Matthew Rosato <mjrosato@linux.ibm.com>
>
> There are a few scenarios where IOMMU replay can potentially be needed
> for zPCI device, namely VFIO device reset scenarios where the guest
> continues running and expects the contents of its IOMMU to be replayed
> upon IOAT re-registration and migration scenarios where the destination
> must reconstruct the IOMMU on the destination.
>
> zPCI migration is not supported yet, but the IOMMU replay function is
> implemented so that it can be called both from IOMMUMemoryRegionClass
> now and migration post_load later.
>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c          | 68 +++++++++++++++++++++++++++++---
>   hw/s390x/s390-pci-inst.c         |  4 +-
>   include/hw/s390x/s390-pci-inst.h |  1 +
>   3 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index eff980fdfe..10b417a779 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -593,14 +593,70 @@ err:
>       return ret;
>   }
>   
> -static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
> +static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
> +{
> +    S390PCIBusDevice *pbdev = iommu->pbdev;
> +    S390IOTLBEntry entry;
> +    uint16_t error = 0;
> +    uint32_t dma_avail;
> +    hwaddr curr, end;
> +
> +    curr = iommu->pba;
> +    end = iommu->pal;
> +
> +    if (iommu->dm_mr || !pbdev) {
> +        /* If direct mapping is used, there are no guest tables to replay */
> +        return;
> +    }
> +
> +    if (iommu->dma_limit) {
> +        dma_avail = iommu->dma_limit->avail;
> +    } else {
> +        dma_avail = 1;
> +    }
> +
> +    while (curr < end) {
> +        error = s390_guest_io_table_walk(iommu->g_iota, curr, &entry);
> +        if (error) {
> +            pbdev->state = ZPCI_FS_ERROR;
> +            s390_pci_generate_error_event(error, pbdev->fh, pbdev->fid, curr,
> +                                          0);
> +            error_report("Failure to walk table during iommu remap");
> +            return;
> +        }
> +
> +        curr += entry.len;
> +        if (entry.perm != IOMMU_NONE) {
> +            while (entry.iova < curr && entry.iova < end) {
> +                if (dma_avail > 0) {
> +                    dma_avail = s390_pci_update_iotlb(iommu, &entry);
> +                } else {
> +                    /*
> +                     * There is no reliable method to request the guest to
> +                     * release mappings other than in response to a RPCIT
> +                     * instruction; generate a permanent error condition and
> +                     * require the device to be completely re-initialized from
> +                     * the guest side.
> +                     */
> +                    pbdev->state = ZPCI_FS_ERROR;
> +                    s390_pci_generate_error_event(ERR_EVENT_PERMERR, pbdev->fh,
> +                                                  pbdev->fid, 0, 0);

A permanent error will indicate to the guest that PCI device in 
unusable, in that case would the guest drive a device re-initialization? 
Would it be better to generate a ERR_EVENT_SERVAC to allow the guest to 
attempt recovery and so drive the mappings again?

Thanks

Farhan

> +                    error_report("DMA mappings exhausted: iommu remap failed");
> +                    return;
> +                }
> +                entry.iova += TARGET_PAGE_SIZE;
> +                entry.translated_addr += TARGET_PAGE_SIZE;
> +            }
> +        }
> +    }
> +}
> +
> +static void s390_pci_iommu_replay(IOMMUMemoryRegion *mr,
>                                     IOMMUNotifier *notifier)
>   {
> -    /* It's impossible to plug a pci device on s390x that already has iommu
> -     * mappings which need to be replayed, that is due to the "one iommu per
> -     * zpci device" construct. But when we support migration of vfio-pci
> -     * devices in future, we need to revisit this.
> -     */
> +    S390PCIIOMMU *iommu = container_of(mr, S390PCIIOMMU, iommu_mr);
> +
> +    s390_pci_ioat_replay(iommu);
>   }
>   
>   static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index b7de23c7d2..37ca70dcf1 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -630,8 +630,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>       return 0;
>   }
>   
> -static uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
> -                                      S390IOTLBEntry *entry)
> +uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu,
> +                               S390IOTLBEntry *entry)
>   {
>       S390IOTLBEntry *cache = g_hash_table_lookup(iommu->iotlb, &entry->iova);
>       IOMMUTLBEvent event = {
> diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
> index 5cb8da540b..c782990e3b 100644
> --- a/include/hw/s390x/s390-pci-inst.h
> +++ b/include/hw/s390x/s390-pci-inst.h
> @@ -111,6 +111,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
>   int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
>                            uintptr_t ra);
>   void fmb_timer_free(S390PCIBusDevice *pbdev);
> +uint32_t s390_pci_update_iotlb(S390PCIIOMMU *iommu, S390IOTLBEntry *entry);
>   
>   #define ZPCI_IO_BAR_MIN 0
>   #define ZPCI_IO_BAR_MAX 5

