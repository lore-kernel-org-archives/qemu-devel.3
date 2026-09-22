Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A46CC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97ID-0006C8-BN; Tue, 22 Sep 2026 16:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x97IC-0006Bw-4U; Tue, 22 Sep 2026 16:40:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x97IA-0002Z7-Cg; Tue, 22 Sep 2026 16:40:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI6xEp1128981; Tue, 22 Sep 2026 20:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EQn8cp
 L993ZRVO4zQxql0LEjEzVK3TTyHLtHlVoDTAY=; b=ZV96ALf0aORjxtdS5VLbpG
 cDIg5SxebxlzPL0gNaP18v7CSmzluR8rnjbS2M8sMLu5kVp3mdaerSLpji+zGepF
 4cPhHAcwklcDQLxweFkQCuMhUkJLZKEGsL2vwd4hrGmIcWd/EdcO6b0fqrUZay/4
 n8iy7s8O9qLz0BGn9VHPJ3qsNIjTg/+gEAekJxkx+a3pVIcqoEUrnaUioT87bpha
 6x6o3HuaOHlbf4R7U/rmIupvKRNGjeOL5q9Wz108h0vS+5PM5BxF9tKVWko6oOEY
 hS3hRgJGaqL7SHP0/smDH9aQq95LCRJ/GSYXLPBjYXLk4nFpPX4WKDM9+FAiQlNw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2fwtm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:40:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHaI44187989; Tue, 22 Sep 2026 20:40:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyb6uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:40:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKeXMI30081320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:40:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 381512004B;
 Tue, 22 Sep 2026 20:40:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC4A120043;
 Tue, 22 Sep 2026 20:40:32 +0000 (GMT)
Received: from [9.111.77.23] (unknown [9.111.77.23])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 20:40:32 +0000 (GMT)
Message-ID: <6d1441dd-2c33-413c-95af-02ff529983fc@linux.ibm.com>
Date: Tue, 22 Sep 2026 22:40:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260922183654.798470-1-kshk@linux.ibm.com>
 <20260922183654.798470-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260922183654.798470-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N5_HRQe7ezHmYD2EpL1WD489YuOlFbut
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2e7c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=fJscykngOMZPDPbeOW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX2rSYhXIoq8/z
 I+2LokDz3jGf+wiXuBTxyp3pdT0uQqOvY2/r8XJtv2RkfZuUbojDJroC5v150oiQW0AkQ22XpND
 xUis6CpwpQGBpG1s/Nq/+fikFaOYr7q9+MWsaVPo083llfhC7BFfTUxdaXtIygw1MXgADQ4tm0B
 TEEqc6A/Bq3xzzD+RxPc57C7+sMvW2orFjtptEPpTJG5GzeIqBCX0JEy4d1i3fdD0g9Jh0ugi7l
 vFQR7ga8oazzz2SU9jUGm8U4/m9MkwYNz2CUhxXOOla9Yss/68APUt9iN620LqqctQm2sU+Yy2Z
 3dtiGpx7W2SIQA+pR8jQRZWTD6T0xL9OAW8/McJg+nGiD9aK8deJY4j4tMlw1KX+BF8cF7Jry5c
 1wpL4YdQrJ4yo7eVfoAJZJgcczo4dFtF3Zh5gQcHULW7YKZaN1DhUBfH6KjfQZSrZleqmllhvmz
 zNFbsEpcJZjfGT4ISjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX58UfFahWGtCq
 Jeg4r4UKD887y5QJvdvbX5bxzrd6UaeuPJcStGSUoxYMrsG9s6SfLTFyymMfjqlwq49BIkIt3Ri
 3Jst+WDBYUiMICF+oktX47/UoNHOXak=
X-Proofpoint-GUID: N5_HRQe7ezHmYD2EpL1WD489YuOlFbut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295
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



Am 22.09.26 um 20:36 schrieb Konstantin Shkolnyy:
> Extract the pba, pal and g_iota checks from reg_ioat() into a function.
> Make it external so that it can also be used in a follow up change.
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c         | 42 +++++++++++++++++++++-----------
>   include/hw/s390x/s390-pci-inst.h |  2 ++
>   2 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index f93db10c81..a1cd96f647 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -1024,31 +1024,45 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
>       return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
>   }
>   
> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
> +                             uint64_t pal, uint64_t g_iota, Error **errp)
> +{
> +    uint8_t dt = (g_iota >> 2) & 0x7;
> +    bool t = s390_pci_is_translation_enabled(g_iota);
> +
> +    if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
> +        return false;
> +    }

this return forgets to set the error pointer which can trigger a segfault later on.
guest triggerable.

> +    /* currently we only support designation type 1 with translation */
> +    if (t && dt != ZPCI_IOTA_RTTO) {
> +        error_setg(errp, "unsupported ioat dt %d t %d", dt, t);
> +        return false;
> +    }
> +    if (!t && !pbdev->rtr_avail) {
> +        error_setg(errp, "relaxed translation not allowed");
> +        return false;
> +    }
> +    return true;
> +}
> +

