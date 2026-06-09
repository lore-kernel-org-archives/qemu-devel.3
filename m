Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1839CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 22:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4bU-0006gY-Rv; Tue, 09 Jun 2026 18:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wX4bK-0006fS-Vy; Tue, 09 Jun 2026 18:07:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wX4bI-0001LH-O2; Tue, 09 Jun 2026 18:07:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659Drvsf2567161; Tue, 9 Jun 2026 22:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qFAlme
 1pAIxR8ayNZcKlS0LBSfxU1fRZH8/esqvxylY=; b=WWq4GykzIpGFeBp4YAAGCZ
 LPhPUv8eSRmG9+a0cSn0gVKGf0oG1ZLmgRaKz+1cR8tOjFAw+VotRBlHw4UzqAjf
 FRPimiUwZZO06ZFrbi+w9l21aaUvRqJcy3scxF21juyEoXxQ6iW6w2OZIk/KR21M
 niRvfWXmkNvKfyb7s/+sNMd2pmAOcA6qWJTvdww8DrwVKfy1WuZbwUrwTrqYtXDj
 47xdRv504T2rETKbq5zOIVNLwCoCoamJIqeIbVizOKKNWSIggo5BHHl5vmVeJXnT
 NtItLls7GBLNVsIJyrP5YG5s83ZMUzwl61FcQJpvs3y/oWbS4J5Gv1rTXIDY2uKw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23xhb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 22:07:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659M4wH5029248;
 Tue, 9 Jun 2026 22:07:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w44me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 22:07:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659M73B323790246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 22:07:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE8E58056;
 Tue,  9 Jun 2026 22:07:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98D2058052;
 Tue,  9 Jun 2026 22:07:02 +0000 (GMT)
Received: from [9.61.254.40] (unknown [9.61.254.40])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 22:07:02 +0000 (GMT)
Message-ID: <07c1b1b7-3767-4230-8362-e90cbbc01ff7@linux.ibm.com>
Date: Tue, 9 Jun 2026 15:07:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] s390x/pci: implement IOMMU replay
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-2-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260605021728.1125090-2-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a288e89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=MCo1tqE0FQsNgFF58BcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: g3p9dQhFL5TSdKzLEOrWrm1ffhjqcDEc
X-Proofpoint-GUID: g3p9dQhFL5TSdKzLEOrWrm1ffhjqcDEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwOCBTYWx0ZWRfXyEgCY91WLg5s
 RjZfFNIUNVn3aWZTYCLRugc3Kovzv0MJuFcURkF+6dQ88Cg/M0B+f/vtM4joaj1jEiQEOw9rRBR
 9Qbb2LeSIV6Z/x9tJRArGC5SVFZxCrWGdzhR6Dr038OmAFNGyzPwG4tpuGteDgffGsj5EH9On7s
 XWnfAKIgWWaELB/Gwqz7tnvRCVhc60FCbjgRwEsDsEGCa3dRCbhOXrGLY3gIeh5v+pOJtf9Vcs4
 YTtu2v7FJ8G8acjfm5ayaERDScY058MsQf2YBmGrq5abxxJcXbYUHMeZ+pT6NaFT/tEufbbu9jP
 oXQJdiR2ejyKNVLfh2/R5Xicar0Bm/1R/6JwnzMI6EvPatFRbug21+7O8BzK2XP5l6oJ/w8r6o1
 8w6T8F+BDcPj2vt4ESDMsEAdHuY+05Feg1Al22BC7PGA9vFEvD/z3NBqM0MHUsNM+LAA8w9rSBY
 9TDQWk7irjbSRwYiyNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090208
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


On 6/4/2026 7:17 PM, Konstantin Shkolnyy wrote:
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
>   hw/s390x/s390-pci-bus.c          | 62 ++++++++++++++++++++++++++++----
>   hw/s390x/s390-pci-inst.c         |  4 +--
>   include/hw/s390x/s390-pci-inst.h |  1 +
>   3 files changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 4de7b587e8..a104e550b1 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -592,14 +592,64 @@ err:
>       return ret;
>   }
>   
> -static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
> +static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
> +{
> +    S390IOTLBEntry entry;
> +    uint16_t error = 0;
> +    uint32_t dma_avail;
> +    hwaddr curr, end;
> +
> +    curr = iommu->pba;
> +    end = iommu->pal;
> +
> +    if (iommu->dm_mr) {
> +        /* If direct mapping is used, there are no guest tables to replay */
> +        return;
> +    }

I am curious, how would migration work if direct mapping is used? How is 
the IOMMU state replicated on the target machine?


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
> +        if (entry.perm != IOMMU_NONE) {
> +            if (dma_avail > 0) {
> +                dma_avail = s390_pci_update_iotlb(iommu, &entry);
> +            } else {
> +                /*
> +                 * There is no reliable method to request the guest to release
> +                 * mappings other than in response to a RPCIT instruction;
> +                 * generate a permanent error condition and require the device
> +                 * to be completely re-initialized from the guest side.
> +                 */
> +                pbdev->state = ZPCI_FS_ERROR;
> +                s390_pci_generate_error_event(ERR_EVENT_PERMERR, pbdev->fh,
> +                                              pbdev->fid, 0, 0);
> +                error_report("DMA mappings exhausted: iommu remap failed");
> +                return;
> +            }
> +        }
> +        curr += entry.len;
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
> index 10066ca618..1834596076 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -613,8 +613,8 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
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

