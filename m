Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65386C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JpV-0000mo-9Y; Wed, 09 Sep 2026 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x4JpT-0000mB-34; Wed, 09 Sep 2026 11:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x4JpR-0001oL-9D; Wed, 09 Sep 2026 11:03:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689B1icI3839778; Wed, 9 Sep 2026 15:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PwB3qG
 SXTYayHCPTCEspZ1+bu2Jxoz8RMyHcTqfyuN0=; b=KE5hWk5URtlhM1HfiOhWes
 5oTEdHRdR4zbnShPcGAET0EN3TNrkC8u5O7C2r5eZ4B9gP5BhcIvjUoAXswmwA16
 b2yQbrkmrugAok2ak17I7CbmBkqhUhMyKDiS67WwgndphIutjKuh/iXjIHmW+bkN
 fN9DYGRo+mhQw4XbXtWdB9hP+X2uzI9GIuo4xDeBF6+YSWkEdi/xLtdnv+6joSLU
 EYzWUs+xcRYOW/b4ur0NplETjkbwi0LyuIHnk1F+u/YehIEZ+jO4Qs+c1zSLoYME
 rPywUG3uQIPXieOelwpuuet2XWhBl2V/5D6EcY/PXoLcNWqK0JKH5kcN3Idfh7fw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf687j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 15:03:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689EuIQo001749;
 Wed, 9 Sep 2026 15:03:09 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yjpvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 15:03:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 689F2PI042271212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Sep 2026 15:02:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06BE458067;
 Wed,  9 Sep 2026 15:03:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23E8658066;
 Wed,  9 Sep 2026 15:03:06 +0000 (GMT)
Received: from [9.61.96.29] (unknown [9.61.96.29])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  9 Sep 2026 15:03:06 +0000 (GMT)
Message-ID: <387c6343-41ac-46d2-a429-706c5f17c7e3@linux.ibm.com>
Date: Wed, 9 Sep 2026 11:03:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block lengths
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, zycai@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-3-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2OCBTYWx0ZWRfXykIpvXBuShAw
 061+IBRMwDq629m49ic3ZzCn4nCnF9tIH+u86yerdGNEfF4fZB2wpVEHbe15em5xsjP2Gkzi76V
 IosgNSC9xfsk56MjaccbZZ3q0xjAPenlEmqBfQg2ksiv1FcELAHkeZtcxIBAw5UNbNWDNxT7AOX
 dXIJIcPODbPMH/Raarvs+EkP2A53Xcs6a5hKMSHT4TgVh4jQvXCXBP6XLwr6BUYY2IaKuHoUV9J
 YSQ3nLQwvYLQX0WMHVYuBSO4LXrQL4xbl0NP6tE11IPbz8QubmEsBh86KVySjd6djYsZqHmoEMJ
 JJIXW0Kd8pw/BbNfh0XWkqj+LcZQ9ZuMVtRiVNPd7d2HyLDb67fsqIp4Q2TjkqbQ/BVJF5fofpi
 BEDkKCvUlS8zNrbH6oPQEzVdAyUm9g==
X-Proofpoint-GUID: DTkH86tODxbXtGadJ0BBC5dJUK2jMPgI
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa1752e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=F2PNqkVtL6hlYDCPSBMA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2OCBTYWx0ZWRfX70jtSmAd2tWs
 tL8kjEiI5fPC12yQbonjYCgGYNlqTa8qk+JzvyLvkRKMnNFGhAJzaHIsjg9D+GqXzpF8DpauE+p
 TTNXxtJlskFfux/0KzxnNSM0w1W/M0k=
X-Proofpoint-ORIG-GUID: DTkH86tODxbXtGadJ0BBC5dJUK2jMPgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2609090168
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 8/31/26 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The length of the PCI IPLB is calculated by size of the IplBlockPci struct
> plus the number of bytes used for common IPLB fields.
> 
> Fix the S390_IPLB_MIN_PCI_LEN to reflect this, and assign a valid blk0_len
> while we are at it.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 395116781df5 ("s390x: Build IPLB for virtio-pci devices")
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/ipl.c              | 2 ++
>  include/hw/s390x/ipl/qipl.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d59ed36c78..ba69ee89bb 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -615,6 +615,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>          switch (devtype) {
>          case PCI_DEVTYPE_VIRTIO:
>              iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
> +            iplb->blk0_len =
> +                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
>              iplb->pbt = S390_IPL_TYPE_PCI;
>              iplb->pci.fid = cpu_to_be32(pbdev->fid);
>              break;
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 3fa9649112..69b0023ea3 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -39,7 +39,7 @@ typedef enum S390IplType S390IplType;
>  #define S390_IPLB_MIN_PV_LEN 148
>  #define S390_IPLB_MIN_CCW_LEN 200
>  #define S390_IPLB_MIN_FCP_LEN 384
> -#define S390_IPLB_MIN_PCI_LEN 376
> +#define S390_IPLB_MIN_PCI_LEN (offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci))

Thanks!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>  #define S390_IPLB_MAX_LEN 4096
>  


