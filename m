Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EB0CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUuI-00060t-QA; Fri, 22 May 2026 14:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wQUuE-0005tX-K7; Fri, 22 May 2026 14:47:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1wQUuC-0000X1-Tv; Fri, 22 May 2026 14:47:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M7SM8n069628; Fri, 22 May 2026 18:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0/17QK
 3eb6+QKF2enQ84suwMXGW31FG7/Y693k7TYC8=; b=llk/p7t0Pnw7AKw8NYaDxb
 0UBwxi6L/NShVbZhDTl8N8hDU7eAUFungXVtkGeiXFz9sOC/B/wUEY58GgfsoFND
 3IBR1cMGVLQ4graYoV/FNXa43J5zCrWWJD/dj5GA4cHDhRxGSzjJxjqHCQiG6tku
 5a+ZYLHET5/Bwd0D3lMQMS2xeN3U4koDiIE1M1N+ruxBc89RbmqJUcss3YAnAthY
 0f3Shz0m4UiUbugiay5JVBeBfk3tAj0YZvni7e6cPCyhmQ9FdlBIStbubtu4mINc
 MOLoID1o4VYI1O6MJhWsHljD5mL1bLOKNm1o8e7qrJHF1Z27Gh04w5OyxDzw6Hng
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n5d8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:47:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MIdAw4018067;
 Fri, 22 May 2026 18:47:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkj7ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:47:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MIlP0U29229780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 18:47:25 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4386858056;
 Fri, 22 May 2026 18:47:25 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A86C55803F;
 Fri, 22 May 2026 18:47:24 +0000 (GMT)
Received: from [9.61.253.232] (unknown [9.61.253.232])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 May 2026 18:47:24 +0000 (GMT)
Message-ID: <04bc4b44-a7ce-4551-9313-5ecee3024e4f@linux.ibm.com>
Date: Fri, 22 May 2026 14:47:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: Fix interrupt forwarding disable for
 interpreted devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 qemu-stable@nongnu.org, Niklas Schnelle <schnelle@linux.ibm.com>
References: <20260521182946.1607-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Omar Elghoul <oelghoul@linux.ibm.com>
In-Reply-To: <20260521182946.1607-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JJKW6MiYNaw79qTvnqGIpoSyyW_K037D
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a10a4bf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=B7zm4avvAfTAtJRvoU8A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: JJKW6MiYNaw79qTvnqGIpoSyyW_K037D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4NSBTYWx0ZWRfX3k+xeFy3lmyX
 wVxsCPz76Va22CJRHf/z+L0KLyjF+WxRvnGG9B7q6vr5O5rqy+Ie23nu0D3oqx28JdYGWoa0w15
 hjs+wIiDy3gBebIhaBIfElYTmh2o/I9IHx36rUsNzLJMF7Xoic4aosddSLsMoDD2YVEfmYqcr1+
 3iy/MTPwTwc6cYMfgcBOaDGTMeY0B2P1ZhjPe5hVa4SKOeiSHucE6xDuTWcCXgQDUk68t2Y6Dsz
 2xYgiw4MexeVUsaDrEVZ6zRBwhrMJ7YTLGqte+Ie9YUpweDb1XqXY+rFSloTJohJYHd8O8OfM+I
 34jni5dEoptfFBCtuMU/byyjIQfnD4U7nuISqfKM8gWCkK1JYO6W1TB6WHjMCYQg+1F5BlcsBPN
 jsFpi/dOkpklUmQ8oxEs/ARw++XR2xPhZixgOVXgmZOglrsSC3EwL9et1ZPLRPcGOAXyoYiqU7E
 vcX88m/ZD/y5IOtjrDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220185
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 5/21/26 2:29 PM, Farhan Ali wrote:

> Remove the FH_MASK_ENABLE check when disabling interrupt forwarding
> during device reset. This check was broken for the default case in
> the switch statement above, preventing proper cleanup of interrupt
> forwarding.
>
> The pbdev->aif check in s390_pci_kvm_aif_disable() already guards
> against double-disabling of interrupt forwarding.
I tested this patch with PCI mlx, ISM, and NVMe devices in combinations of
guest kernels, including and excluding the patch that originally exposed
this issue, and have found it to be resolved. I did not find any new
regressions with kernels that don't expose this issue either.

Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>

Thanks.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 3665aba106..2f7b214891 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1542,7 +1542,7 @@ static void s390_pci_device_reset(DeviceState *dev)
>           break;
>       }
>   
> -    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE)) {
> +    if (pbdev->interp) {
>           /* Interpreted devices were using interrupt forwarding */
>           s390_pci_kvm_aif_disable(pbdev);
>       } else if (pbdev->summary_ind) {

