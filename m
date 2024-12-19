Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB36E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOA4r-0000dz-P0; Thu, 19 Dec 2024 01:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOA4q-0000dj-9I; Thu, 19 Dec 2024 01:32:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOA4o-0008Qp-De; Thu, 19 Dec 2024 01:32:04 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BINwKSw024086;
 Thu, 19 Dec 2024 06:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G+O2Nd
 63g+gj9mIJ31Xex/0YPoORCfakvroTSAbcctY=; b=HDl/m1DufYCtuI34LjFtm1
 R0JV7Jz7BzlZTZpXSrDdLNX2LXFOZBRfBZWmbRf173/A93LHJHK1W6j++Gz9mOKe
 ZsP8TY+HtQzzYX+UbRvo3q1L3MDd/Jp2RUa9Ko7lkkaZsMC+4QaXiM9Z9qi3U+6S
 7r1vmHqHdOfDk8b7px/Naqg+Edlvvh7HZFM0vf2xcb7zya8tOWKOR0kzV3jz0CEV
 3qcrjQlVYH/sVE04dsX0kSxfSFtLGmAyZ3YfayVdAoFh4NE/id2tTUNAwoOtubmY
 9u9UAxq1pLkDp2df0x6jaOZRQUfzlMRRL8yXQF13vwrqPmzLE58l8k/5f/NN/K+g
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m8hh19jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:31:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJ6OkZp015953;
 Thu, 19 Dec 2024 06:31:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m8hh19ja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:31:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ44UwH005523;
 Thu, 19 Dec 2024 06:31:46 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnbuq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:31:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BJ6VkO35309012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 06:31:46 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 909F958054;
 Thu, 19 Dec 2024 06:31:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20EA658052;
 Thu, 19 Dec 2024 06:31:42 +0000 (GMT)
Received: from [9.39.21.210] (unknown [9.39.21.210])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2024 06:31:41 +0000 (GMT)
Message-ID: <0c036e5c-beed-429b-aea1-628fa9d52b65@linux.ibm.com>
Date: Thu, 19 Dec 2024 12:01:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] hw/ppc/spapr: Convert HPTE() macro as hpte_get()
 method
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
 <20241218182106.78800-3-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241218182106.78800-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: axsD6mDfxsmoyPg2An3YD5MPX_Y748bV
X-Proofpoint-ORIG-GUID: Z5xpq2u0Q-2JDd_6w_L-vJ8Wh5gGhsbZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 phishscore=0
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

Hi Philippe,

On 12/18/24 23:51, Philippe Mathieu-Daudé wrote:
> Convert HPTE() macro as hpte_get() method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
>   1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3b022e8da9e..4845bf3244b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1399,7 +1399,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
>       }
>   }
>   
> -#define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
> +static uint64_t *hpte_get(SpaprMachineState *s, unsigned index)
> +{
> +    uint64_t *table = s->htab;
> +
> +    return &table[2 * index];
> +}
> +
>   #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_VALID)
>   #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
>   #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
> @@ -1614,7 +1620,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, int shift, Error **errp)
>           spapr->htab_shift = shift;
>   
>           for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
> -            DIRTY_HPTE(HPTE(spapr->htab, i));
> +            DIRTY_HPTE(hpte_get(spapr->htab, i));

Prev HPTE expected _table i.e. spapr->htab as arg, but this new hpte_get
expects SpaprMachineState* i.e. spapr as arg. Shouldn't the arg be
updated accordingly? Wondering it didnt complain during build.

As Nick suggested, hpte_get_ptr or get_hpte_ptr may be better renaming.

regards,
Harsh

>           }
>       }
>       /* We're setting up a hash table, so that means we're not radix */
> @@ -2172,7 +2178,7 @@ static void htab_save_chunk(QEMUFile *f, SpaprMachineState *spapr,
>       qemu_put_be32(f, chunkstart);
>       qemu_put_be16(f, n_valid);
>       qemu_put_be16(f, n_invalid);
> -    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
> +    qemu_put_buffer(f, (void *)hpte_get(spapr->htab, chunkstart),
>                       HASH_PTE_SIZE_64 * n_valid);
>   }
>   
> @@ -2198,16 +2204,16 @@ static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
>   
>           /* Consume invalid HPTEs */
>           while ((index < htabslots)
> -               && !HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>               index++;
>           }
>   
>           /* Consume valid HPTEs */
>           chunkstart = index;
>           while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>               index++;
>           }
>   
> @@ -2247,7 +2253,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>   
>           /* Consume non-dirty HPTEs */
>           while ((index < htabslots)
> -               && !HPTE_DIRTY(HPTE(spapr->htab, index))) {
> +               && !HPTE_DIRTY(hpte_get(spapr->htab, index))) {
>               index++;
>               examined++;
>           }
> @@ -2255,9 +2261,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>           chunkstart = index;
>           /* Consume valid dirty HPTEs */
>           while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_DIRTY(HPTE(spapr->htab, index))
> -               && HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>               index++;
>               examined++;
>           }
> @@ -2265,9 +2271,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>           invalidstart = index;
>           /* Consume invalid dirty HPTEs */
>           while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
> -               && HPTE_DIRTY(HPTE(spapr->htab, index))
> -               && !HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>               index++;
>               examined++;
>           }
> @@ -2449,11 +2455,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
>   
>           if (spapr->htab) {
>               if (n_valid) {
> -                qemu_get_buffer(f, HPTE(spapr->htab, index),
> +                qemu_get_buffer(f, (void *)hpte_get(spapr->htab, index),
>                                   HASH_PTE_SIZE_64 * n_valid);
>               }
>               if (n_invalid) {
> -                memset(HPTE(spapr->htab, index + n_valid), 0,
> +                memset(hpte_get(spapr->htab, index + n_valid), 0,
>                          HASH_PTE_SIZE_64 * n_invalid);
>               }
>           } else {

