Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165F1CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKSY-0002Es-CD; Wed, 10 Jun 2026 11:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wXKSL-0002CU-8X; Wed, 10 Jun 2026 11:03:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wXKSJ-0004RL-Ec; Wed, 10 Jun 2026 11:03:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AC0tf0096772; Wed, 10 Jun 2026 15:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OXVzYJ
 2fWRFgyp8TrvxYkfvo1OwkkXzuWh3rf8sjFiw=; b=K9ye07VmrJ96kxTVXdL/bM
 NnHpS1dI/GB3lnjji4HwS0lsONlMR5pQGN6MLTZ6l/X/MhBEJ2W3XVctq+cWU5dG
 v+qb+6uJj9DtN6mKg0Jdixa1cpydwldGAGjvPR71UwbyixWXOCfTAUWl78NZwIL7
 RtHpgVYkTRSv2rAOpEU6P/jhwEVSgbmeRGjje5lsUqJ9e48pSJsVPZKH0nlx7BGb
 bAXfuhUJs5fPn2Vk8RqyNQOsThvj8zTjD2f9NYF2k8cdA+Fhgtx0izgnBgrBqzi4
 lR7cCNsjt/Qp4KKKadf7eHrl5FIULFBOC3XD4mfX4m7ja9LCJHKHd3BsrdKN/3pw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb241rmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 15:02:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEnegm012299;
 Wed, 10 Jun 2026 15:02:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq7a0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 15:02:51 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65AF2oOj7144350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jun 2026 15:02:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 539775805B;
 Wed, 10 Jun 2026 15:02:50 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 529FB58058;
 Wed, 10 Jun 2026 15:02:49 +0000 (GMT)
Received: from [9.61.8.181] (unknown [9.61.8.181])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jun 2026 15:02:49 +0000 (GMT)
Message-ID: <b988f3af-adcf-4504-8677-1f1eb4f38063@linux.ibm.com>
Date: Wed, 10 Jun 2026 11:02:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] s390x/pci: implement IOMMU replay
To: Farhan Ali <alifm@linux.ibm.com>, Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-2-kshk@linux.ibm.com>
 <07c1b1b7-3767-4230-8362-e90cbbc01ff7@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <07c1b1b7-3767-4230-8362-e90cbbc01ff7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a297c9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=_lsXRUp17OYT0JyQVX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DPCHKCyuaZ9PDoE_HugBE07cCwR7V84u
X-Proofpoint-GUID: DPCHKCyuaZ9PDoE_HugBE07cCwR7V84u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE0MCBTYWx0ZWRfX8ZN+hEySh2J3
 lWpFl/Lqdbu+BpSDV11YD4eyuOGPIVZldM6OMs5ARI0LhnzixrrhmJRVjYv+/PAaVgQAy5optgD
 UL+r2nF005wVt5m7+yLic30zB97KJbRx/KIskRUQQ73e55U6MVIJlL9ub15SZr1DjmmDovb7Pxw
 uBSCBJBfjiCCDhK2ZK6usr7R9YRREwtkdJ9lppx2FZ9rzX1Wid0u7XX7RB8iVZBmOdhDdKF/X12
 1g6d7M7JFFOv//M83p3L3oLr4jwUMChMJZ652XAKPi3evNvyUJWpo7/AEVIdrF7LNnu5spEwvSM
 sKUR1IF230JAOQqKQfUwz4e0Bbr3h5es4cpm+3Es+YRpwJsQSdKl6tDPTROocWbDfurLsaHMf7I
 Jx7vUq+dA2m/pKoePUPtN2Qo1Zf3RoHypgjM1tKZyjZwQrICbJjFnpj9NhXATG+iX/0JzQiqbxm
 kOwD+Mgn5n7OPQq7Thw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100140
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 6/9/26 6:07 PM, Farhan Ali wrote:
> 
> On 6/4/2026 7:17 PM, Konstantin Shkolnyy wrote:
>> From: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> There are a few scenarios where IOMMU replay can potentially be needed
>> for zPCI device, namely VFIO device reset scenarios where the guest
>> continues running and expects the contents of its IOMMU to be replayed
>> upon IOAT re-registration and migration scenarios where the destination
>> must reconstruct the IOMMU on the destination.
>>
>> zPCI migration is not supported yet, but the IOMMU replay function is
>> implemented so that it can be called both from IOMMUMemoryRegionClass
>> now and migration post_load later.
>>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c          | 62 ++++++++++++++++++++++++++++----
>>   hw/s390x/s390-pci-inst.c         |  4 +--
>>   include/hw/s390x/s390-pci-inst.h |  1 +
>>   3 files changed, 59 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 4de7b587e8..a104e550b1 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -592,14 +592,64 @@ err:
>>       return ret;
>>   }
>>   -static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
>> +static void s390_pci_ioat_replay(S390PCIIOMMU *iommu)
>> +{
>> +    S390IOTLBEntry entry;
>> +    uint16_t error = 0;
>> +    uint32_t dma_avail;
>> +    hwaddr curr, end;
>> +
>> +    curr = iommu->pba;
>> +    end = iommu->pal;
>> +
>> +    if (iommu->dm_mr) {
>> +        /* If direct mapping is used, there are no guest tables to replay */
>> +        return;
>> +    }
> 
> I am curious, how would migration work if direct mapping is used? How is the IOMMU state replicated on the target machine?

Hm, good question.

For this series, it's not really an issue; emulated devices are always
disallowed from direct mapping and only emulated devices are being
enabled for migration here (passthrough devices are still fenced) --
so you'll never take this path during a migration with this series.

When I wrote this patch I was testing the VFIO reset case where we will
get a new MPCFIC from the guest to drive reg_ioat().  But you're right,
that won't happen with a migration; rather migration code will need
specific handling to re-trigger the mapping done in reg_ioat() for 
direct-mapped devices in order to fill the host IOMMU without a guest
IOMMU to replay.

Actually, I believe Konstantin is doing the necessary work already in 
patch 14 via a call to s390_pci_iommu_direct_map_enable() during
s390_pci_device_post_load().

Thanks,
Matt

