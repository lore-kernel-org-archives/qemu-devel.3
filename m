Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9820C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqEo-00023C-0w; Tue, 11 Aug 2026 13:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqEf-00021U-L7; Tue, 11 Aug 2026 13:25:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wtqEd-0006ip-4J; Tue, 11 Aug 2026 13:25:57 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGVYKQ933892; Tue, 11 Aug 2026 17:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2lmvru
 dA+iTFhVyKdiIvc81c538we0g+XkJ73AhXdog=; b=CNDVSRFtMHvLqrb+qPcUUF
 TJc/xrCQBikzjYV0srwCeutR3OAwP9DGD3R8CpDhVaaG49vWlxR8bmPZfhcpCT8w
 n0YzlRR7G81Vejpk7w7PAVGJKb4Ut/ciPWDeIgTrNxafkhkLAAgkIjWY6wkj/ubw
 nSQ/lJukpxRjmdDV7UW9p8UfE1nuu1fYx0sklpPcGuhWq2Ngt90kIGEY6989t/DY
 9kcRgBD8q8nOoralBFoeNKZsI4HYcMop+WKBWk4qYwkdrk1m8tS11BYNCLVJgdp3
 EK8ZFRQAFfxgTeAcfoalU6YBNlfvRxJZbtvckNWmMVw5rPzsx+SfoKdZXWJWggBw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9p79u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:25:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BHBGAZ015037;
 Tue, 11 Aug 2026 17:25:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1wf0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Aug 2026 17:25:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67BHPmBj8127042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Aug 2026 17:25:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D4C58062;
 Tue, 11 Aug 2026 17:25:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D65D45805A;
 Tue, 11 Aug 2026 17:25:47 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 11 Aug 2026 17:25:47 +0000 (GMT)
Message-ID: <6b0624d7-9bce-465b-bf7b-307858b6368f@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:25:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/15] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260807170812.658820-1-kshk@linux.ibm.com>
 <20260807170812.658820-10-kshk@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260807170812.658820-10-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfXzwl6y12Ejaj5
 VcpgtQCBoTve6M7N3JNbsqacB3qLGKqFmDlBSXoP4VdsWsW5hWLXtl++ZoM7258ozFjCJyBHO0n
 JX2ZW1zrth/yQiCIh81/kvl2Xf4Z1k4MYKXQZEs/npNksMmBkBwH3ZK996HyDs8nIUjJ+COTYO5
 q+CyMKn4lRT0fiFZM9BFBkI9S4X7JRoakbbAp1iYxe/YGcE6mKL+PWWBdccm67wEfQiFTbgoyRX
 9HVyNowsR93+54mfwJmXRwcOY40jFr6i6/7Cz0fE/f25YqXNoeTU4bTcwqLIRzFlSUn/bAY0+Vp
 rbJ9pFIrKW2RjnpuTd4Usv2wwVI2s8D7JQU4llc8B6CVZYqB/kTJITNvT7YWW/glR6GGWJ6kAup
 y5Yaa/eX61y3QUswzuuGWqolcPsuYDY+buDlh6Gmm+PsH1Bi4hxYySwsttag39FtavqPmDkq0Ma
 wb7Iom1PNulsY7s+HDQ==
X-Proofpoint-ORIG-GUID: 4LbSCH1Zmnmwb59KO1Dj3gopu58UiSCd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE0MiBTYWx0ZWRfX+FT+NxoJVmE9
 vqAvuCKZ8WpJIhqs614Na8Fn0eg9vrqOmYeSJUARDnfTOTYRjCOp/1Keyu29L3KX9PzXtGQroap
 mSl/9Jo1M9d/WoxsDX9AhvXz9kN36hg=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b5b1f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=NT-D918DeMxGRRny-ogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4LbSCH1Zmnmwb59KO1Dj3gopu58UiSCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110142
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


On 8/7/2026 10:08 AM, Konstantin Shkolnyy wrote:
> This field is only used when S390PCIBusDevice exists, so it can be moved
> there to simplify S390PCIIOMMU which purpose is just to store the "root"
> AddressSpace.
>
> This also allows to save/restore this field during migration.
>
> Signed-off-by: Konstantin Shkolnyy<kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         |  2 +-
>   hw/s390x/s390-pci-inst.c        | 10 +++++-----
>   include/hw/s390x/s390-pci-bus.h |  2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



