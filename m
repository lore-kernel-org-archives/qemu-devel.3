Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39993C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnLHm-0006bY-R0; Fri, 24 Jul 2026 15:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLHl-0006b3-2i; Fri, 24 Jul 2026 15:10:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wnLHj-0006pn-6V; Fri, 24 Jul 2026 15:10:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66OHBoov556115; Fri, 24 Jul 2026 19:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dmdpeW
 LI+F/gFzhSdLGfLfuH92gjIBtNoRfabf9+f/o=; b=BVIFQGB1mKmZEsRontWfFD
 mg/MrKaeLD6w9jogTnxwY7Wbmal2qIn3nnnbNtgny7O4ZAzsyWNTOnbONAXoZYw1
 eAaLPr+no622Vw2j+rdYCssrvqF6wNSf5VtJtplgIJ1ZZoc8E5zWVaDaAYDuoNZ7
 BuVIYAbg5bZE7eBV31qR5JqvatQX3rtshqJIjpKviU6QC/qDG1giMaCYI/RcsFBg
 OLuT2P/+aMe0fwjNLjMn/jyVDhdkTkvv6W+OeUUWGj46Wg4MaRF8BLcZc9yhaO+h
 eOkYLs8IzLZ/jCERq3TtFiRiSyYjIz3wUfhzMOAVB6fksvFxGhLP4r+2CqObOGTw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs9hs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:10:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OJ4coY014005;
 Fri, 24 Jul 2026 19:10:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyt12b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 19:10:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66OJA78l37880324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 19:10:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A2A158056;
 Fri, 24 Jul 2026 19:10:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97AAE58052;
 Fri, 24 Jul 2026 19:10:06 +0000 (GMT)
Received: from [9.61.253.58] (unknown [9.61.253.58])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 19:10:06 +0000 (GMT)
Message-ID: <74c3efe9-41e4-4db1-a1b3-f0ceb48809a3@linux.ibm.com>
Date: Fri, 24 Jul 2026 12:10:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] s390x/pci: implement IOMMU replay
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260724030919.123733-1-kshk@linux.ibm.com>
 <20260724030919.123733-2-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260724030919.123733-2-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2OCBTYWx0ZWRfX5CqnzhnUy1SE
 4wL84G1YWLm0IH3Lhx4sYhzN34gIvxfcxY04CSNV2LsdDdlZrZmsba5VlW4j3Pin2cLxCxyu70A
 ys5tyVjx61pLYTGbCKwZhy6g2iIo6Z0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2OCBTYWx0ZWRfXwxhTVyGt/5ii
 C6uALItnKNWixQtLCp9E7ZlCIH44kQcZU+u7Nr3E8EIgwGW/mlRgvNtYS71LHXuWAO86t3EybAO
 /I7mkLtjA/TuUKrEM4zKwK/DkEiP95IPalOxmue53GZ1N1dF5yi13YkbrlEB2XtSsBsdcxvzdSF
 d77/SCZyHW02BnSgnn5JXVxBQ+i8zqkdweEiJcujZ/romvf33CEBbv+O94BDWH59uHsAGOo6X5S
 TVuU9HyqU1kYxZLlejIJfB1kvNLViA9/ejbSua6kxXOV6phQr4VneaQdhz15+wA4BxP1ifOUYbp
 ussmIfVBc+quJC/FsdVXgOrUlebvRUdxMIhFhmJIecSG7sNO84E3/RHDW1GnYH6IW2jJY8Cwlz8
 00yeuK/V+1fC98SqxDOsvUlsAAD22ZCvb5ZNbRCRMzAhvl1HeEoVNGB8YNsAuGF3lczSNjlAR+r
 iP9b63pOJxKlE9sFtFA==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a63b892 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=7Y_GWkelQ_qsqdOeeVgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sAgntLs2VvMzQ64wAk-ewDH6t2PsuF0t
X-Proofpoint-GUID: sAgntLs2VvMzQ64wAk-ewDH6t2PsuF0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240168
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


On 7/23/2026 8:09 PM, Konstantin Shkolnyy wrote:
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
> index eff980fdfe..511926c151 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -593,14 +593,64 @@ err:
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

This patch doesn't compile on its own. Trying to compile with just this 
patch gives the error:

i-bus.c.o -c ../hw/s390x/s390-pci-bus.c
../hw/s390x/s390-pci-bus.c: In function ‘s390_pci_ioat_replay’:
../hw/s390x/s390-pci-bus.c:620:13: error: ‘pbdev’ undeclared (first use 
in this function)
   620 |             pbdev->state = ZPCI_FS_ERROR;
       |             ^~~~~
../hw/s390x/s390-pci-bus.c:620:13: note: each undeclared identifier is 
reported only once for each function it appears in

This should be fixed to avoid breaking git bisectability.

Thanks

Farhan




