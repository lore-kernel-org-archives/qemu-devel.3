Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3A7C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 15:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLP3x-0001fw-J1; Sun, 23 Jun 2024 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLP3v-0001fb-Qg
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:23:27 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLP3t-00039m-12
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 11:23:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65BF24E6001;
 Sun, 23 Jun 2024 17:23:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id qBjkaV_P_WQY; Sun, 23 Jun 2024 17:23:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2D33D4E6000; Sun, 23 Jun 2024 17:23:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B916746E3B;
 Sun, 23 Jun 2024 17:23:20 +0200 (CEST)
Date: Sun, 23 Jun 2024 17:23:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH 2/2] target/m68k: pass alignment into TCG memory load/store
 routines
In-Reply-To: <20240623115704.315645-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <9d74ba20-a17d-64fd-7203-e4d450f77472@eik.bme.hu>
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Sun, 23 Jun 2024, Mark Cave-Ayland wrote:
> Now that do_unaligned_access has been implemented for 68k CPUs, pass the required
> alignment into the TCG memory load/store routines. This allows the TCG memory core
> to generate an Address Error exception for unaligned memory accesses if required.
>
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2165
> ---
> target/m68k/translate.c | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 445966fb6a..661a7b4def 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -303,13 +303,18 @@ static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
>                             int sign, int index)
> {
>     TCGv tmp = tcg_temp_new_i32();
> +    MemOp memop = opsize | (sign ? MO_SIGN : 0) | MO_TE;
>
>     switch (opsize) {
>     case OS_BYTE:
> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
> +        break;
>     case OS_WORD:
>     case OS_LONG:
> -        tcg_gen_qemu_ld_tl(tmp, addr, index,
> -                           opsize | (sign ? MO_SIGN : 0) | MO_TE);
> +        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
> +            memop |= MO_ALIGN_2;
> +        }
> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);

You could swap the order of these so byte comes last and fall through to 
it from word/long to avoid duplicated line.

Maybe this answers my question about where it's restriced by CPU type. I 
wonder if this check for M68K_FEATURE_UNALIGNED_DATA could be avoded here 
and done by checking it in init and only set the unaligned method for CPUs 
that need it to not add overhead for most CPUs that don't need it.

Regards,
BALATON Zoltan

>         break;
>     default:
>         g_assert_not_reached();
> @@ -321,11 +326,18 @@ static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
> static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
>                              int index)
> {
> +    MemOp memop = opsize | MO_TE;
> +
>     switch (opsize) {
>     case OS_BYTE:
> +        tcg_gen_qemu_st_tl(val, addr, index, memop);
> +        break;
>     case OS_WORD:
>     case OS_LONG:
> -        tcg_gen_qemu_st_tl(val, addr, index, opsize | MO_TE);
> +        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
> +            memop |= MO_ALIGN_2;
> +        }
> +        tcg_gen_qemu_st_tl(val, addr, index, memop);
>         break;
>     default:
>         g_assert_not_reached();
>

