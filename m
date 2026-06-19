Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C028ECD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 22:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wahVo-0002uq-2f; Fri, 19 Jun 2026 18:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wahVk-0002uP-Th; Fri, 19 Jun 2026 18:16:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wahVi-0001HF-Qh; Fri, 19 Jun 2026 18:16:28 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLmbEP3392794; Fri, 19 Jun 2026 22:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gdkVHP
 g6FHcn//m4qdPaGGN7r6mp8OA+GDq4tn/nvwI=; b=HwGot23AI9vP5kr7cTlnyS
 3xbRDUV/akAXrFgZlMBFSfJcwevYwJH/9SPhlH75Wbo+Rm7Nw1ngOcULwBTajoK0
 ingVcVp97O9irqldzg1b25bnLebzENX9/Ghhs3MKLAV/a41qkaKmQTu+owPq8cNY
 KKhEwEyGYNboS2n7F2JmZRtK23JUVVj97/dQlzTuknAh+dj1bYNclZ3kIwcjKE3L
 9EjojHhGi2L0aPWrjQc4E5Gj/Hbkwi/g/jLtmAJKA51rcSz+bajFzg7OzL0DsUg/
 5vRvgJ+t7/u6iFHOTHkNWgKZ+On218UlbJ0Rm57papjlH/ps7hb7lgqRLukAsbDQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxqg7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 22:16:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JM4pfR024146;
 Fri, 19 Jun 2026 22:16:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jtfe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 22:16:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65JMGJ9I26018330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2026 22:16:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21A025805A;
 Fri, 19 Jun 2026 22:16:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2130C58054;
 Fri, 19 Jun 2026 22:16:18 +0000 (GMT)
Received: from [9.61.241.74] (unknown [9.61.241.74])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2026 22:16:18 +0000 (GMT)
Message-ID: <1d6a9c54-c352-40f3-a132-cf60ea8ab958@linux.ibm.com>
Date: Fri, 19 Jun 2026 15:16:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] s390x/pci: Move iommu_mr from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
 <20260605021728.1125090-4-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260605021728.1125090-4-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a35bfb4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=xH2wut0Fk4rgVtvIbVQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX5RqWhU4/Lxrl
 5drS3snbRc7nIZsm0atOvfovLPmaAgehj6/QW3QP0VFakfB6io2u7oX5Wb0Mxde5MYkbpsHC++o
 nqwn0tEeI9oyNUxOoYE6S0cbIMVaUQhEhdAZe4zwHvrhuxGTd88dviCKMt9rKoH8zXRKDLJmJEk
 Nkh60IJLQHmFBbBVBvsT4roWUptRIWyBYEsRjBb7DtzzRqnzwrwvDYY+Dsc3m3IuLImpvu9LY5i
 /3egQkoH0zZ9Z7LpmvRZ7mbdnH3rWVZxvmr4a2+Wn3yZdo4llbnpK/TL/uk6Pn9456kdPK2TeYP
 Tl+ItU5rrgIOAwi7/InKQE4cvvGhl0uRd6vZF5EsASzMRYqEQIe4P9H4SRbxqbJhwMrbJkM4VE3
 YHC31nbFW4uAUbrcdteW0Kfz/os9XPNhes6xNAOj4ZnPNSYU16nBNyVXuzMnaqMKQQVI+CzlS0f
 LOKQ3sVRcgOwSQymFCQ==
X-Proofpoint-GUID: GU2BcxCOwFn-kPfngwFp7rKtHQtghABk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX1L/LLOv5JkOC
 Rz9UOPoJ00ldcQUnWXV1p+T3Vu4NA1M+WErtzAGQFnCtP1HTswNeEZX3uDA0/EFNfrD3zIX4gh+
 z/2e7G2C062OrukfhmKUVcplygUYFXc=
X-Proofpoint-ORIG-GUID: GU2BcxCOwFn-kPfngwFp7rKtHQtghABk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210
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

<..snip..>

On 6/4/2026 7:17 PM, Konstantin Shkolnyy wrote:
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index eb15cb8b2d..a71f562dfc 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -276,7 +276,6 @@ struct S390PCIIOMMU {
>       S390PCIBusDevice *pbdev;
>       AddressSpace as;
>       MemoryRegion mr;
> -    IOMMUMemoryRegion iommu_mr;
>       MemoryRegion *dm_mr;
>       bool enabled;
>       uint64_t g_iota;
> @@ -354,6 +353,7 @@ struct S390PCIBusDevice {
>       S390MsixInfo msix;
>       AdapterRoutes routes;
>       S390PCIIOMMU *iommu;
> +    IOMMUMemoryRegion iommu_mr;
>       MemoryRegion msix_notify_mr;
>       IndAddr *summary_ind;
>       IndAddr *indicator;

Maybe I am missing something, but why do we need to remove iommu_mr from 
S390PCIIOMMU? S390PCIBusDevice already has a reference to the 
S390PCIIOMMU in its definition. So is there something about iommu_mr 
defined in S390PCIIOMMU makes it difficult to migrate? Its hard to 
understand from the commit message.

Thanks

Farhan



