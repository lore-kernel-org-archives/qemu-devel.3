Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA562F8FA94
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDB1-0003vf-DV; Tue, 21 Apr 2026 11:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFDAx-0003vK-Ow; Tue, 21 Apr 2026 11:38:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wFDAw-0006Ba-1I; Tue, 21 Apr 2026 11:38:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63LDCsd01684519; Tue, 21 Apr 2026 15:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dx5SGU
 OWlRdKMjk/F4WqvYra1EDsuRZdbQLFCJNRan4=; b=IIM8kz54cr9tB/26O3lWLe
 1+k2l/eh7xvfBk6zcTOMnHO+eTvp3dXO9h0UdoPUvtVeYYJ0oVNPhOkYTBcXM+H6
 Vo+kuAUUYUR3u7X2taz5nu77z4rT3+Dc4zm7xPM7MOPWW683sga5NGtC6PXOj3PQ
 qO3tldluEuMfUN+M8JpeOvNCNTP+9VlWrhkN9iLgrMBKT4IH3rRrjpFVxtRxpzkw
 1ocVfe599/MtlT/LvjPh22GkUTnAVzmvwmriaKLNJzKLzi8CiFplXNGrtaD2r7JJ
 lg9nJZ0iWj8N+o/ntRyxdG0LNepabFJxqAxCyhfmNBOY08Zls5gpwsVYVxaduBFg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6n1c1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 15:38:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LFZY7F009536;
 Tue, 21 Apr 2026 15:38:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmn9k18be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Apr 2026 15:38:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63LFc0QK33882750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Apr 2026 15:38:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371B458056;
 Tue, 21 Apr 2026 15:38:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8438458052;
 Tue, 21 Apr 2026 15:37:59 +0000 (GMT)
Received: from [9.61.174.150] (unknown [9.61.174.150])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Apr 2026 15:37:59 +0000 (GMT)
Message-ID: <493bdab6-d30d-4d55-80ac-82661b2a5e37@linux.ibm.com>
Date: Tue, 21 Apr 2026 11:37:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] s390x/pci: implement IOMMU replay
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260411022618.2136588-1-kshk@linux.ibm.com>
 <20260411022618.2136588-2-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260411022618.2136588-2-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE1MyBTYWx0ZWRfX2hLeuAdrKE7e
 BwEHHNEUn7i3mnBZpgIri/7e9rTzepsh1Kh9O/Cl4lm9/M/5JTu/D49B+0mn+u59698sNxEfDjI
 t/DSBpaf3iYpd/75T/6O8fe5/xg5IUjj5oEVR4Y1HWk+Oe50pek+cOhEOadc71jKA9igXW1ILwk
 8/sbGo42JdxOHu/cHrkfc5gkAyFYDCyHU7UfQ0TEgndFJ2a8yqbsFI0NxW4wP3QyzTs4xsEt2mU
 Lunj9FbYBaFVvA8Dq4kxi+/25ZnSKawPrY0y3cDVsCjLTxOq47MQTRhg0Yf4vbM798FBHnBsrCV
 ysXe1gFjhFQkbGpBNY+oov7/H4kAN+0ktPU9GwjBm+jzxrSlzX+yeB52xxRaDbGYr8E68ca6EuJ
 7a0Uo4hwYsogVBtM29V+A3g3wLExWYKVLB7s7h+IdINJZ8l0Y5cIRUbDvXPRDZFz/ElbvDjJNiV
 /fPttWNdS28JqnFbxTQ==
X-Proofpoint-GUID: S3Mbrid64heAXi3L1K15sPKqWvsrB2l6
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e799da cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Y01Mh1kPsCn9PXDDTg0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S3Mbrid64heAXi3L1K15sPKqWvsrB2l6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210153
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

On 4/10/26 10:26 PM, Konstantin Shkolnyy wrote:
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
>  hw/s390x/s390-pci-bus.c          | 50 ++++++++++++++++++++++++++++----
>  hw/s390x/s390-pci-inst.c         |  4 +--
>  include/hw/s390x/s390-pci-inst.h |  1 +
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 4de7b587e8..3665aba106 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -592,14 +592,52 @@ err:
>      return ret;
>  }
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
> +            error_report("Failure to walk table during iommu remap");
> +            return;

Who wrote this junk?  :)

In this unlikely event, I think we should be putting the device into
error state and generating an error event for the guest to react to in
addition to this message.  Just like we do during rpcit_service_call()
in response to a failure here, minus the setting of cc/status code.

> +        }
> +
> +        if (entry.perm != IOMMU_NONE) {
> +            if (dma_avail > 0) {
> +                dma_avail = s390_pci_update_iotlb(iommu, &entry);
> +            } else {
> +                error_report("DMA mappings exhausted: iommu remap failed");
> +                return;

Probably also here.  But for this case, an error event is not how we
typically relay this condition to the guest, rather we use a special
status code against the instruction we were emulating (RPCIT) which we
can't do at this point in time.

So the question is largely what event code we should fabricate in this
latter case -- Let me think about that a little and I will send you an
updated version of this patch for you to try out and include in v3.

Thanks,
Matt


