Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF3ACD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfvo-00082n-Ru; Mon, 22 Jun 2026 10:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wbfvi-00080n-T9; Mon, 22 Jun 2026 10:47:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wbfvh-0003YB-8Y; Mon, 22 Jun 2026 10:47:18 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MDIPnU2922011; Mon, 22 Jun 2026 14:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=si9Cut
 SixT9ZRBFKhe2ZvR7How3QRxVcR11o+TwlH/Y=; b=e5xRpe/RhROXLiSG9ESE98
 rERZqtoABsD2KzNagtJ1mfy1qSuJWjNpEI4JwjTZ4/TZGOmf2xd0wDYeuhGYYm84
 1w+Y4KIkA4NotFW163ny2K6Cd6l1t+wJ2M2oSmMfTCfPPVdlF7qfONAkgquglKq4
 zh5lddVPGT25/U1dKR79RWuPoJZp0MwkmG9lKBBcyJlW+mghcp/XvaV13Tm+CCkO
 maUMbB+QBJ9J5VjU5rTNuqevuoekw43BOvqD7yicTXEPhjzN/M34M/8Za7ycYlHO
 HPqdgn6LVXTv2W/rTWp6LARPIA8vHAOfcgynNCvQW/04p2tJ9GY+mrYyhiBxj25g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk49sed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:47:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MEYdpM029513;
 Mon, 22 Jun 2026 14:47:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q6wq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 14:47:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65MEl8Qc17367800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2026 14:47:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7019058056;
 Mon, 22 Jun 2026 14:47:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CF825803F;
 Mon, 22 Jun 2026 14:47:08 +0000 (GMT)
Received: from [9.16.62.165] (unknown [9.16.62.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jun 2026 14:47:08 +0000 (GMT)
Message-ID: <a4a7563b-2d64-4465-9cfc-a37106675745@linux.ibm.com>
Date: Mon, 22 Jun 2026 09:47:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] s390x/pci: Move iommu_mr from S390PCIIOMMU to
 S390PCIBusDevice
To: Farhan Ali <alifm@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-4-kshk@linux.ibm.com>
 <1d6a9c54-c352-40f3-a132-cf60ea8ab958@linux.ibm.com>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <1d6a9c54-c352-40f3-a132-cf60ea8ab958@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX2JSuRAc60/Za
 bcbdTq8zbBaVYZhXQjRRGWsD1TRmOImY2clRIOwlT+MerupdAzd9g0LZRHAW4K7U3G9M76PjI3U
 zbk0Cl1pYZRXKfVo8T0YmU/20/7leYI=
X-Proofpoint-ORIG-GUID: L1midlb7HM_nuJ0oZC0qHU2bEYd2VEuR
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a394aef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=GZO5g-VNeBu4E_CnEO8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX+jJnFF/qDKqi
 4FoYu9MNI/t4q6+sI8dQ+jetHpjHaPPQ/fV7db9RAShm3yh/Zaunr1pDlalyJGmtHwUVaH8+P0q
 4w5/hhFcLQmIRpjuCpKHyW6rtRIOq6AwNuab87/1sRNNecBgne1y8RIb6htpCerxL9xHBLltu2T
 Pa1w57liW2/KAotNSgTLnJzGL75J5lcNpKFGlQwu9QFY5tmLpHcgSkX5iYoWacDxIUM03pc+oxq
 ZdKDzkTF3e6PKwx5dcaylzACmOprYLkTkyYksFZzqcIBfa2oc/XO+yRIfhhN00evuB/skVppsyc
 QpYEQpeKDz+aiSamJGUggA7+UE0DHrz2+2QIR0zNCtjWUJ5BywkASRpLxfZGZWTNF3Sn0WOhKFi
 TRmOD/IJPQOkzd6e5ND/5/7g8VqZXQ85n/tD8taNSzch72B10wF8peciB7tn1q3CGz7RaRourtF
 YMoqyviTz1BbjpGEtGg==
X-Proofpoint-GUID: L1midlb7HM_nuJ0oZC0qHU2bEYd2VEuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
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

On 260619 17:16, Farhan Ali wrote:
> <..snip..>
> 
> On 6/4/2026 7:17 PM, Konstantin Shkolnyy wrote:
>> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390- 
>> pci-bus.h
>> index eb15cb8b2d..a71f562dfc 100644
>> --- a/include/hw/s390x/s390-pci-bus.h
>> +++ b/include/hw/s390x/s390-pci-bus.h
>> @@ -276,7 +276,6 @@ struct S390PCIIOMMU {
>>       S390PCIBusDevice *pbdev;
>>       AddressSpace as;
>>       MemoryRegion mr;
>> -    IOMMUMemoryRegion iommu_mr;
>>       MemoryRegion *dm_mr;
>>       bool enabled;
>>       uint64_t g_iota;
>> @@ -354,6 +353,7 @@ struct S390PCIBusDevice {
>>       S390MsixInfo msix;
>>       AdapterRoutes routes;
>>       S390PCIIOMMU *iommu;
>> +    IOMMUMemoryRegion iommu_mr;
>>       MemoryRegion msix_notify_mr;
>>       IndAddr *summary_ind;
>>       IndAddr *indicator;
> 
> Maybe I am missing something, but why do we need to remove iommu_mr from 
> S390PCIIOMMU? S390PCIBusDevice already has a reference to the 
> S390PCIIOMMU in its definition. So is there something about iommu_mr 
> defined in S390PCIIOMMU makes it difficult to migrate? Its hard to 
> understand from the commit message.

For migration, indeed it's not necessary to move it. It'll function 
either way. It's purely a "cleanup" change - I want S390PCIIOMMU to only 
contain the fields that _can't_ live in S390PCIBusDevice (as described 
in the patch 13).

All the patches that move fields from S390PCIIOMMU to S390PCIBusDevice 
are aiming to simplify this code, so the reader isn't left to wonder, as 
he's today, (1) why a field is located in one of them rather than the 
other, and (2) whether S390PCIIOMMU can be deallocated somehow while a 
field is being referenced by pbdev->iommu->field.


