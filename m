Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95579C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 03:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf86n-0005hq-T0; Wed, 01 Jul 2026 23:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf86h-0005gs-5D; Wed, 01 Jul 2026 23:28:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wf86f-0005GA-6R; Wed, 01 Jul 2026 23:28:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621Kbor2509641; Thu, 2 Jul 2026 03:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TKylQj
 SVrqNXU9bAqbrhcKamN9tGG/kcNYmP9+vu6iI=; b=C34zJGvZH0oUHCDLjf6ayz
 xixiXTF/4F6cXwggnc7x3o7ZS9KQD5GVBNXPQ9hTvU3sOYy+bKnLCYY5HHae/Grn
 uvNMSF0hw/FTg8ZnL4GA7V9no6uRwq8+AGHgXLEEtgtsN91+Dz/p0PqT5+BY4RQX
 vtkQ6bCMIfKDFbjFszXTc4Z3vn8GxEu10F+M3if+ZhFImM2LKhqTLukiadzD4xOG
 vHxM7DMBsRWDceLC/uIwoJjZ4eOZntt+oUjC2dGjy5T+RwapE+hoyDET/l5jERhn
 JFqoq6Ku4V6yN52wxvZVOuuvScgDk/X5ZwQGj1D77dJA9GHoLJB6mk2LOOPCzHBg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe7xga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:28:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6623JaHB010612;
 Thu, 2 Jul 2026 03:28:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyhyxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 03:28:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6623Sk7o21627526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 03:28:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A8CF58057;
 Thu,  2 Jul 2026 03:28:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE7BA58058;
 Thu,  2 Jul 2026 03:28:44 +0000 (GMT)
Received: from [9.61.143.111] (unknown [9.61.143.111])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 03:28:44 +0000 (GMT)
Message-ID: <5935d754-5e22-4926-84f1-2dea52d9455e@linux.ibm.com>
Date: Wed, 1 Jul 2026 23:28:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 31/35] hw/s390x/ipl: Handle secure boot without
 specifying a boot device
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-32-zycai@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260701204922.1320349-32-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wNNKjYg51wcmd0mb5020BpT3FnUCde1I
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAzMCBTYWx0ZWRfX6oTkT64ORTsD
 3YVHozGY0hbE5DBrOx40qBq5C4jgsogzuzcUjJrmD8xn8YcNhWS6clP6UcS1Uq/Rjh66hM/JJkE
 pTyMRWGNjdMDjB/ZcKDJLsb+Lez7Ixs=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a45daf1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=sOHrDYPWMb0swp6piUcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAzMCBTYWx0ZWRfXwepYi/5tP/xL
 yMZy1uAS8GgOXo8QRcUPW9KChLxYkgR+UIwNNVYkVwYpGbFmcwBvoWqCi4+Fk2BIHRdVzcIjOs1
 7vJ1Nyo+Rw1IYqblkhIA/OgVXjAHDG5zbYttvhERkais9zNiqTbZBezSVZ8PezBja8DTfeh7L1c
 3B16P41v0FsISJyQ+xf5KCFbBNEH9IjYRLxp/+bNaBRCVsrz0ZHTwqGomAyjrqBWFKcWGH3htQF
 O6mXFYKlT6EWEHPt+wS0Blmg9x5hfwLYErh1FWnCzNHZYCfryQZA+3Tbpu++aRsRfEq2/rOrMmE
 5Crrsp6hY+oazfABM/oZydOcU/AX2yuz+1vl4qB+PF/XexYl6GrVIe9P66/ieBY77bfp1BhxP6e
 QgGIV5KZxGKfffxxzayCLOtfBsotP3fBzL/fioYmK92gbHPj8X+milfNpzClQ/RhEu0nWGCSnBf
 azsfcrsNx1DTDIz2fkg==
X-Proofpoint-ORIG-GUID: wNNKjYg51wcmd0mb5020BpT3FnUCde1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020030
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> If secure boot in audit mode or True Secure IPL mode is enabled without
> specifying a boot device, the boot process will terminate with an error.
>
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/ipl.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d6a783d9f..f4e01b6918 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -865,6 +865,16 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>           cpu->env.psw.addr = ipl->bios_start_addr;
>           if (!ipl->iplb_valid) {
>               ipl->iplb_valid = s390_init_all_iplbs(ipl);
> +
> +            /*
> +             * Secure IPL without specifying a boot device.
> +             * IPLB is not generated if no boot device is defined.
> +             */
> +            if ((s390_has_certificate() || s390_secure_boot_enabled()) &&
> +                !ipl->iplb_valid) {
> +                error_report("No boot device defined for Secure IPL");
> +                exit(1);
> +            }
>           } else {
>               ipl->qipl.chain_len = 0;
>           }

I think this check should be introduced quite a bit earlier in the 
series when audit mode is first added.  Audit mode should give a warning 
and continue, then this strict enforcement could be added with true 
secure IPL mode.

Regards,
Jared Rossi

