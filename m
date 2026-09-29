Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13226CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWsv-0005MZ-Dn; Tue, 29 Sep 2026 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xBWst-0005Lu-6C; Tue, 29 Sep 2026 08:24:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1xBWsr-0003t2-GI; Tue, 29 Sep 2026 08:24:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5o4U2188969; Tue, 29 Sep 2026 12:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=VPdi8V
 g8U5Hf9lSo/d6Vb/gHMT8pm881jGxob8h2CRY=; b=ir49Hxm83jnUxxiR5JmgYm
 0LdEcXaFrFE7yE/vjumlJFsMza/KX1bCHJ7tHfrsZKyUw042j4QnZiB1YR/ARVH0
 Ofz8AfHGDAwL9rLDW8FjC/YQpf6DrZ5ln1y56/BwW3RRvkfTyTBuqmOWVG9WLP/t
 SDJ6JP9XSym9ZtLBbRb/6GK06q3KsIBQwcgHYuAqW0jvDu0Lnw25GL8RTWTN/xEi
 q3N/DgBnRXajxoV/D8oYN3FboA2d6ZLrHsXdVKJJyhG23+08oOZYFZUlBhSQIEFO
 hAtv/A9+PpYusCColpTOOJVptiyfl9HNTggSZdoetKaxEnq/tC409gVTwWzRr6Eg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6w54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 12:24:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAlWSf1667683; Tue, 29 Sep 2026 12:24:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhhkch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 12:24:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TCON336947204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 12:24:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D65402004E;
 Tue, 29 Sep 2026 12:24:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E00E20043;
 Tue, 29 Sep 2026 12:24:23 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 12:24:23 +0000 (GMT)
Message-ID: <f36cbce6-1a85-45c9-9e5c-1ee606730534@linux.ibm.com>
Date: Tue, 29 Sep 2026 14:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] s390x/pci: Fix frame stepping in rpcit_service_call()
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
 <20260928202325.309353-2-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260928202325.309353-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX2ArQxzk5g3Lx
 /pb+PDrdSO2POM3qGG/kULcF8jCWopkDvhiYzwFIiNCFgk0BrmmAuA5TJ6RwLHoLZIrcbfAfuR2
 mSX19eRJ5l1/aLxZvsyfmwhagkr50cJNk00ewfldk2gDHIO4XVMY5r1bb1rkodCXPMBKc35FTkK
 yIflOAdPCJq5tZpB/VAzgB25JWWEzI8udW3ifGi+swLRFllVLdtPaM1By4Z05fbbn4taUB6iKl3
 CIAVC1ZuRVPLJ+ASZVaFb7n01bNW/jGCqFlRuagwCkSbDCdXKqU4maH39pg8qB/dMKpfv7hLjOR
 linZRbp08WOEMmG/Trvo5hve/NsyUFmezVkSyqUMhCdrVXis9c1eowENwmv3n+rGZaUmTN0zUXg
 PfbJFCKQv7oG3ahpMsIMtMSsCV7iENZdV5ba3NbuAgqp6qfkRsyAaV4drQZWobWvjz/J4PBkPhv
 NZCDkhxCc1sfRQ4nmsA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abbadfd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=ph5Z-r5AeXlLnT07bH4A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: ZP6Bv68pXuyE9Ai17PctnlFO2tOXml21
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX46EbVQrH/JD8
 GqVQWngZJ0bPpZBcs6pgGv3dHvPAODQ0pGU+VE+XaR7rAbNiYOmQGVccD5H7uZq+fq6eno9MGGt
 PzHoAlU+TYqu9ZslAKHcY+xvogMbEG8=
X-Proofpoint-GUID: ZP6Bv68pXuyE9Ai17PctnlFO2tOXml21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290048
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



Am 28.09.26 um 22:23 schrieb Matthew Rosato:
> When walking the guest IO address table, an invalid segment or region
> entry causes table_translate() to return entry.len equal to the frame
> size for that table level (1 MiB for ST, 2 GiB for RT).  Adding
> entry.len directly to start only advances to the correct next frame
> boundary if start is already frame-aligned at that level -- which is
> true for a well-behaved Linux guest but not a general requirement.
> 
> Add logic to advance start to the next frame boundary rather than
> simply adding entry.len.  For a frame-aligned start (the typical,
> well-behaved case) the result is identical.
> 
> Fixes: 0125861eacc3 ("s390x/pci: fixup the code walking IOMMU tables")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Looks good to me.

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   hw/s390x/s390-pci-inst.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 652e1712ec..a51543df44 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -808,7 +808,8 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>               coalesce = 0;
>           }
>   
> -        start += entry.len;
> +        /* Advance to next frame boundary if start was not frame-aligned */
> +        start = (start & ~(entry.len - 1)) + entry.len;
>           while (entry.iova < start && entry.iova < end) {
>               if (dma_avail > 0 || entry.perm == IOMMU_NONE) {
>                   dma_avail = s390_pci_update_iotlb(iommu, &entry);


