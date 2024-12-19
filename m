Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66BFE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOAOh-00055m-OJ; Thu, 19 Dec 2024 01:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOAOf-00055D-Rj; Thu, 19 Dec 2024 01:52:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1tOAOe-0003We-79; Thu, 19 Dec 2024 01:52:33 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BINaEel030637;
 Thu, 19 Dec 2024 06:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nWDzEI
 iQwJAdxuaHsBmbfakdWjpxwI1+ornHB2P250E=; b=IpRue22tJ1HEt7voiYz8SH
 tELQ8PUvAwspgwMEynygqi2uAvtFIlT/q5GT2tGNWjQfGC8Bx/62kj3RFqqQpbNi
 xbdEN5qTPW51nia0G9XssuRyJfLbG1lOdfTMF4vzqYV/SS87Vq5OS+Zw0+Oe+8zl
 TFJd6Z17IK/nfJxOQnBmmyRX6aZpBmyEbKRh0Pc7OggY6/FHDSuuMCsddRHM4hw1
 4XVq2Ui/LpRHFruSCSP4IUbOuwEJvfsLW4a6taAQA0y8mD9HzA2k+/zZ6WzbRHuV
 lIKJHlWK61nA6cU2rw9PgYTy8iMnGXiHjupbOcIc46WDtFAYX1r1c3F5boGZ5lTQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m87a1c7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:52:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJ6nEkk019675;
 Thu, 19 Dec 2024 06:52:22 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43m87a1c7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:52:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ5XGu9014383;
 Thu, 19 Dec 2024 06:52:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21uh1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Dec 2024 06:52:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BJ6qLlG58327550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Dec 2024 06:52:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02C6758052;
 Thu, 19 Dec 2024 06:52:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1325158045;
 Thu, 19 Dec 2024 06:52:17 +0000 (GMT)
Received: from [9.39.21.210] (unknown [9.39.21.210])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Dec 2024 06:52:16 +0000 (GMT)
Message-ID: <83dda697-30d8-49d1-8d82-a63beb229470@linux.ibm.com>
Date: Thu, 19 Dec 2024 12:22:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] hw/ppc/spapr: Convert HPTE_DIRTY() macro as
 hpte_is_dirty() method
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
 <20241218182106.78800-5-philmd@linaro.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20241218182106.78800-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Ufbs9krIcrSwjZ_M5aILwUOXTgJdPOt
X-Proofpoint-GUID: q-blh985jzl7Cn4SDEsQJ0-CbmUXFrFL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=883 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Similar issue here as with patch 2 ..

On 12/18/24 23:51, Philippe Mathieu-Daudé wrote:
> Convert HPTE_DIRTY() macro as hpte_is_dirty() method.
> Since sPAPR is in big endian configuration at reset,
> use the big endian LD/ST API to access the HPTEs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b67ab1ee685..5bc49598a97 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1411,7 +1411,11 @@ static bool hpte_is_valid(SpaprMachineState *s, unsigned index)
>       return ldq_be_p(hpte_get(s, index)) & HPTE64_V_VALID;
>   }
>   
> -#define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_HPTE_DIRTY)
> +static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
> +{
> +    return ldq_be_p(hpte_get(s, index)) & HPTE64_V_HPTE_DIRTY;
> +}
> +
>   #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &= tswap64(~HPTE64_V_HPTE_DIRTY))
>   #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
>   
> @@ -2257,7 +2261,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>   
>           /* Consume non-dirty HPTEs */
>           while ((index < htabslots)
> -               && !HPTE_DIRTY(hpte_get(spapr->htab, index))) {
> +               && !hpte_is_dirty(spapr->htab, index)) {

hpte_is_dirty expects SpaprMachineState * as arg, need to update 
accordingly.

regards,
Harsh
>               index++;
>               examined++;
>           }
> @@ -2265,7 +2269,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>           chunkstart = index;
>           /* Consume valid dirty HPTEs */
>           while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && hpte_is_dirty(spapr->htab, index)
>                  && hpte_is_valid(spapr->htab, index)) {
>               CLEAN_HPTE(hpte_get(spapr->htab, index));
>               index++;
> @@ -2275,7 +2279,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
>           invalidstart = index;
>           /* Consume invalid dirty HPTEs */
>           while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
> -               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && hpte_is_dirty(spapr->htab, index)
>                  && !hpte_is_valid(spapr->htab, index)) {
>               CLEAN_HPTE(hpte_get(spapr->htab, index));
>               index++;

