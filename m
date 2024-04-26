Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6231C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0MNp-0004iY-ME; Fri, 26 Apr 2024 10:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0MNn-0004ew-4l; Fri, 26 Apr 2024 10:16:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=oYEp=L7=kaod.org=clg@ozlabs.org>)
 id 1s0MNf-0000L5-C2; Fri, 26 Apr 2024 10:16:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VQvsz5lqpz4xLw;
 Sat, 27 Apr 2024 00:16:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQvsx0tFGz4wnv;
 Sat, 27 Apr 2024 00:16:36 +1000 (AEST)
Message-ID: <3ea873c8-3548-4a1b-84bd-ffe28ca19fc0@kaod.org>
Date: Fri, 26 Apr 2024 16:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] ppc/pnv: Introduce 'PnvChipClass::chip_type'
To: Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-3-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240426110023.733309-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=oYEp=L7=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/26/24 13:00, Aditya Gupta wrote:
> Introduce 'PnvChipClass::chip_type' to easily get which Power chip is
> it.
> This helps generalise similar codes such as *_dt_populate, and removes
> duplication of code between Power11 and Power10 changes in following
> patches.
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
> Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/pnv.c              |  5 +++++
>   include/hw/ppc/pnv_chip.h | 10 ++++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec76..74e7908e5ffb 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1457,6 +1457,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
>   
>       k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
> +    k->chip_type = PNV_TYPE_POWER8E;
>       k->cores_mask = POWER8E_CORE_MASK;
>       k->num_phbs = 3;
>       k->chip_pir = pnv_chip_pir_p8;
> @@ -1481,6 +1482,7 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
>   
>       k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
> +    k->chip_type = PNV_TYPE_POWER8;
>       k->cores_mask = POWER8_CORE_MASK;
>       k->num_phbs = 3;
>       k->chip_pir = pnv_chip_pir_p8;
> @@ -1505,6 +1507,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
>       PnvChipClass *k = PNV_CHIP_CLASS(klass);
>   
>       k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
> +    k->chip_type = PNV_TYPE_POWER8NVL;
>       k->cores_mask = POWER8_CORE_MASK;
>       k->num_phbs = 4;
>       k->chip_pir = pnv_chip_pir_p8;
> @@ -1779,6 +1782,7 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
>       static const int i2c_ports_per_engine[PNV9_CHIP_MAX_I2C] = {2, 13, 2, 2};
>   
>       k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
> +    k->chip_type = PNV_TYPE_POWER9;
>       k->cores_mask = POWER9_CORE_MASK;
>       k->chip_pir = pnv_chip_pir_p9;
>       k->intc_create = pnv_chip_power9_intc_create;
> @@ -2091,6 +2095,7 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
>       static const int i2c_ports_per_engine[PNV10_CHIP_MAX_I2C] = {14, 14, 2, 16};
>   
>       k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
> +    k->chip_type = PNV_TYPE_POWER10;
>       k->cores_mask = POWER10_CORE_MASK;
>       k->chip_pir = pnv_chip_pir_p10;
>       k->intc_create = pnv_chip_power10_intc_create;
> diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
> index 8589f3291ed3..ebfe82b89537 100644
> --- a/include/hw/ppc/pnv_chip.h
> +++ b/include/hw/ppc/pnv_chip.h
> @@ -17,12 +17,21 @@
>   OBJECT_DECLARE_TYPE(PnvChip, PnvChipClass,
>                       PNV_CHIP)
>   
> +typedef enum PnvChipType {
> +    PNV_TYPE_POWER8E,     /* AKA Murano (default) */
> +    PNV_TYPE_POWER8,      /* AKA Venice */
> +    PNV_TYPE_POWER8NVL,   /* AKA Naples */
> +    PNV_TYPE_POWER9,      /* AKA Nimbus */
> +    PNV_TYPE_POWER10,
> +} PnvChipType;

Nope.

> +
>   struct PnvChip {
>       /*< private >*/
>       SysBusDevice parent_obj;
>   
>       /*< public >*/
>       uint32_t     chip_id;
> +
>       uint64_t     ram_start;
>       uint64_t     ram_size;
>   
> @@ -137,6 +146,7 @@ struct PnvChipClass {
>       SysBusDeviceClass parent_class;
>   
>       /*< public >*/
> +    PnvChipType  chip_type;
>       uint64_t     chip_cfam_id;
>       uint64_t     cores_mask;
>       uint32_t     num_pecs;

Adding an enum type under PnvChipClass which is a type already
looks wrong. Please find another way. It is possible I am sure.

Thanks,

C.



