Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F48BC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CoO-00063h-6o; Thu, 03 Sep 2026 15:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoK-0005zs-Ba; Thu, 03 Sep 2026 15:09:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jjherne@linux.ibm.com>)
 id 1x2CoG-0004yb-QJ; Thu, 03 Sep 2026 15:09:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2Wso3425680; Thu, 3 Sep 2026 19:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GsXGKX
 BF+iKYmy4J9vof5FM88FwWEq3mUSNDyDd2AGk=; b=JWAGrVnfCTwHSEiA+Flmfe
 bKAOrx+8ZO7QjouFgy5teq4gGVa5DpYLJ0Yck/Q5yKITFUspHPVxA3D2qDf7pkSs
 doGYpwkcQVl1tIKUl0/M8HgurTfCUa0Y4bCUy3IHtcgTNsQkcR1j4ZYYQLYA1y1E
 6RX2CnNbYwr/iQVlsM+gr6jTyQ9EOo/PgdxQphCXuUq3Cry1odPbzBt8NzxfvaBA
 h6slNqkP7AYEqbpfuPX6ZW2+Afq8hBq7nYDpcVHg5KypVh+7KOpXI0EjNynmUrsp
 Y99dOOHnY6m4Fc5rS6u6R74x5OZE5FeJVZxaQQnKfTzg34HqOD/gvXWj9ED9GCrQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq556pqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683IfLtR017277;
 Thu, 3 Sep 2026 19:09:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkh4fj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 19:09:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683J99UN33555082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 19:09:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 026CB58051;
 Thu,  3 Sep 2026 19:09:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A5485805C;
 Thu,  3 Sep 2026 19:09:08 +0000 (GMT)
Received: from [9.61.21.65] (unknown [9.61.21.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 19:09:08 +0000 (GMT)
Message-ID: <0974da44-89de-433d-9f4f-2307237e58a8@linux.ibm.com>
Date: Thu, 3 Sep 2026 08:56:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block lengths
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, zycai@linux.ibm.com, qemu-stable@nongnu.org
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-3-jrossi@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfXzvh5+sN53FT4
 OtIJQU83ZQNIYmicy5lFI3O+AtbC2iTy3G7fmmkrfLPmnKRypT7WuPY3NvjcRB3r5fHbYDlHtTP
 rS8Ml46Nj3XS9yzYpeiDwgbdU+8ZU/s9RDx6Xb96Yt7K+L0CxBYZJtxv3zE7rRehGCDZPeRS9SO
 au3AMX4ZW7T9FHa/FmMDqfzFZjFlr9bbRNa8PBeUnCYQU7TWx+1EJ5bCQ9d7lLFu935DWL9RWgL
 CvEQC3k0Ja9muVXeMho3QgSJAr+jvGi0EaZK7HMNHujC8gR4kKDJNMTmbJo4mDrjXYUQK2H9L1Q
 RFgKKbyGcWffigYdqNp0KEhR2IvXAheoR5GxbaoV5j2I7NPiTzZD0RLsZUCtSIv7ElZ51Kjzb5J
 SZ2CkaFPDRzWpAnkbjUkd7Tz5UwvwYdOq8U0dGG9LgGJF5I/JaFa87aLYMjR0+A2uKA9KQMMud9
 hOqhH9GnGGW8xn1zVlA==
X-Proofpoint-ORIG-GUID: Hw9kBIcp0pZ7bqRWFQl7pG6DYbkYinmV
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a99c5d7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=F2PNqkVtL6hlYDCPSBMA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Hw9kBIcp0pZ7bqRWFQl7pG6DYbkYinmV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NiBTYWx0ZWRfX5hAOJH9uGNo7
 ZqaiBItYfWTub+mMLx5q8C+rkLQJY6U5VX7AWd6GW0Oh+VJJTBmKToVAgzwdEPfb6f8KznfAA/k
 L0QbRGVfWgr2LvfLMhyFvnPe9emBT9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jjherne@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>   hw/s390x/ipl.c              | 2 ++
>   include/hw/s390x/ipl/qipl.h | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d59ed36c78..ba69ee89bb 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -615,6 +615,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           switch (devtype) {
>           case PCI_DEVTYPE_VIRTIO:
>               iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
> +            iplb->blk0_len =
> +                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
>               iplb->pbt = S390_IPL_TYPE_PCI;
>               iplb->pci.fid = cpu_to_be32(pbdev->fid);
>               break;
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index 3fa9649112..69b0023ea3 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -39,7 +39,7 @@ typedef enum S390IplType S390IplType;
>   #define S390_IPLB_MIN_PV_LEN 148
>   #define S390_IPLB_MIN_CCW_LEN 200
>   #define S390_IPLB_MIN_FCP_LEN 384
> -#define S390_IPLB_MIN_PCI_LEN 376
> +#define S390_IPLB_MIN_PCI_LEN (offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci))
>   #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>   #define S390_IPLB_MAX_LEN 4096
>   

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

