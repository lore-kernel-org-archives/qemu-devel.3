Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81F0C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLg14-00034Y-0F; Mon, 24 Jun 2024 05:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLg12-00034K-7f
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:29:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sLg0y-0007BW-VY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:29:35 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 483394E6010;
 Mon, 24 Jun 2024 11:29:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GiO_WUVXRCqd; Mon, 24 Jun 2024 11:29:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E10724E6001; Mon, 24 Jun 2024 11:29:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DEEF5746E3B;
 Mon, 24 Jun 2024 11:29:26 +0200 (CEST)
Date: Mon, 24 Jun 2024 11:29:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH 2/2] target/m68k: pass alignment into TCG memory load/store
 routines
In-Reply-To: <da3ef608-8eff-485a-b831-9192c412858f@ilande.co.uk>
Message-ID: <dc9f80da-5cae-f696-d57e-ad32bce6c040@eik.bme.hu>
References: <20240623115704.315645-1-mark.cave-ayland@ilande.co.uk>
 <20240623115704.315645-3-mark.cave-ayland@ilande.co.uk>
 <9d74ba20-a17d-64fd-7203-e4d450f77472@eik.bme.hu>
 <da3ef608-8eff-485a-b831-9192c412858f@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1542887832-1719221366=:66817"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1542887832-1719221366=:66817
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 24 Jun 2024, Mark Cave-Ayland wrote:
> On 23/06/2024 16:23, BALATON Zoltan wrote:
>> On Sun, 23 Jun 2024, Mark Cave-Ayland wrote:
>>> Now that do_unaligned_access has been implemented for 68k CPUs, pass the 
>>> required
>>> alignment into the TCG memory load/store routines. This allows the TCG 
>>> memory core
>>> to generate an Address Error exception for unaligned memory accesses if 
>>> required.
>>> 
>>> Suggested-by: Laurent Vivier <laurent@vivier.eu>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2165
>>> ---
>>> target/m68k/translate.c | 18 +++++++++++++++---
>>> 1 file changed, 15 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index 445966fb6a..661a7b4def 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -303,13 +303,18 @@ static inline TCGv gen_load(DisasContext *s, int 
>>> opsize, TCGv addr,
>>>                             int sign, int index)
>>> {
>>>     TCGv tmp = tcg_temp_new_i32();
>>> +    MemOp memop = opsize | (sign ? MO_SIGN : 0) | MO_TE;
>>> 
>>>     switch (opsize) {
>>>     case OS_BYTE:
>>> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
>>> +        break;
>>>     case OS_WORD:
>>>     case OS_LONG:
>>> -        tcg_gen_qemu_ld_tl(tmp, addr, index,
>>> -                           opsize | (sign ? MO_SIGN : 0) | MO_TE);
>>> +        if (!m68k_feature(s->env, M68K_FEATURE_UNALIGNED_DATA)) {
>>> +            memop |= MO_ALIGN_2;
>>> +        }
>>> +        tcg_gen_qemu_ld_tl(tmp, addr, index, memop);
>> 
>> You could swap the order of these so byte comes last and fall through to it 
>> from word/long to avoid duplicated line.
>> 
>> Maybe this answers my question about where it's restriced by CPU type. I 
>> wonder if this check for M68K_FEATURE_UNALIGNED_DATA could be avoded here 
>> and done by checking it in init and only set the unaligned method for CPUs 
>> that need it to not add overhead for most CPUs that don't need it.
>
> I don't think that it matters too much if the method isn't implemented as the 
> logic surrounding when to call do_unaligned_access is contained within the 
> TCG core.

I've seen this after I've sent a patch for PPC where removing a 
conditional from a helper often called for memory access showed it had an 
effect on performance. So I thought adding a conditional here might cause 
some slow down for CPUs that don't need this. But this is compile time so 
maybe it's not that big problem as in a hepler. Yet only adding the 
unaligned method for CPUs then always set MO_ALIGN here avoiding the if 
only calls the method when needed if that works at all. I don't know if 
that's worth it, you could test with some memory intensive benchmark such 
as STREAM benchmark to check if this has any effect.

Regards,
BALATON Zotan

> I'll have a go at updating the ordering and send a v2 if it looks good.
>
>
> ATB,
>
> Mark.
>
>
--3866299591-1542887832-1719221366=:66817--

