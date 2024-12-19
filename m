Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04354E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOASz-0005yb-L4; Thu, 19 Dec 2024 01:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOASy-0005yP-MD; Thu, 19 Dec 2024 01:57:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOASx-0004rJ-1n; Thu, 19 Dec 2024 01:57:00 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BINxC1m025491;
 Thu, 19 Dec 2024 06:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=75bMUC
 iE8sbwRuyja2gOy+v8t1AQYLpBf50DzgqWaN8=; b=pLBeGqUCV20MLOrFXzBfIf
 7bVtSaoD1S80Goi1e9+pA7anFe9lVzguvv7Eoaq26xH1zLXm2MR2802X5QzfJROV
 2W/gM4FkSrpCypy+j+l4HVjsCpVbWjSRT8sqwdftLAKA+7YwV+iGK8dzuMu51h6T
 Ek5pvv1QuzTk1K3NEmbJkFKYkikHbv5uHxAdnI0dtHWSCfTrxfZm41NAXLOa+BPq
 G0zzaZRUbSCKCgmaFLNq6BTGAzV4Zdu5QG68TMXwfb2wVxs6U6JLtUchI3wzbUl2
 y/Fmauye+Kw0QucVJeKAqCMZ7iY8Deo8/QaPnJ/kDSo8uheJPze0aluUyng4JJpg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m8hh1c15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:56:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJ6lTpA026595;
 Thu, 19 Dec 2024 06:56:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m8hh1c13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:56:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ4khNe024027;
 Thu, 19 Dec 2024 06:56:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukkth7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:56:52 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BJ6upYe51773938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 06:56:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4E2A58045;
 Thu, 19 Dec 2024 06:56:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 109BA58050;
 Thu, 19 Dec 2024 06:56:48 +0000 (GMT)
Received: from [9.39.21.210] (unknown [9.39.21.210])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2024 06:56:47 +0000 (GMT)
Message-ID: <29a9351a-c85a-4571-8f85-a11b401813f8@linux.ibm.com>
Date: Thu, 19 Dec 2024 12:26:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] hw/ppc/spapr: Convert CLEAN_HPTE() macro as
 hpte_set_clean() method
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-6-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241218182106.78800-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QzI6De7MIb09rI94a4gkBpn3-OKuS7EH
X-Proofpoint-ORIG-GUID: YCgct3EumyENJOCwr1500cIxizBoy0e6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=952 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412190050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.116, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 12/18/24 23:51, Philippe Mathieu-Daudé wrote:
> Convert CLEAN_HPTE() macro as hpte_set_clean() method.
> Since sPAPR is in big endian configuration at reset,
> use the big endian LD/ST API to access the HPTEs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5bc49598a97..4e1fe832c29 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1416,7 +1416,12 @@ static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
>       return ldq_be_p(hpte_get(s, index)) & HPTE64_V_HPTE_DIRTY;
>   }
>   
> -#define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
> +static void hpte_set_clean(SpaprMachineState *s, unsigned index)
> +{
> +    stq_be_p(hpte_get(s, index),
> +             ldq_be_p(hpte_get(s, index)) & ~HPTE64_V_HPTE_DIRTY);
> +}
> +
>   #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
>   
>   /*
> @@ -2213,7 +2218,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
>           /* Consume invalid HPTEs */
>           while ((index < htabslots)
>                  && !hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);

Ditto. I see patch 6 also have similar issue. Please take care.

Thanks
Harsh

>               index++;
>           }
>   
> @@ -2221,7 +2226,7 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
>           chunkstart = index;
>           while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
>                  && hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>               index++;
>           }
>   
> @@ -2271,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>           while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
>                  && hpte_is_dirty(spapr->htab, index)
>                  && hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>               index++;
>               examined++;
>           }
> @@ -2281,7 +2286,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>           while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
>                  && hpte_is_dirty(spapr->htab, index)
>                  && !hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>               index++;
>               examined++;
>           }

