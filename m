Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E8EC07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 19:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryyxZ-0007hH-5Y; Mon, 22 Apr 2024 15:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1ryyxW-0007h2-0E
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 15:04:10 -0400
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1ryyxT-0007bq-T8
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 15:04:09 -0400
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout12.t-online.de (Postfix) with SMTP id 3A2A421710;
 Mon, 22 Apr 2024 21:04:04 +0200 (CEST)
Received: from [192.168.211.200] ([84.175.235.158]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1ryyxL-1rcn0z0; Mon, 22 Apr 2024 21:03:59 +0200
Message-ID: <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
Date: Mon, 22 Apr 2024 21:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
 <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1713812639-C2FFADDA-C49EE972/0/0 CLEAN NORMAL
X-TOI-MSGID: 8b85ed22-dfc3-4879-a631-ed74d7cc55a6
Received-SPF: pass client-ip=194.25.134.22; envelope-from=vr_qemu@t-online.de;
 helo=mailout12.t-online.de
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_HTTP=0.001, RCVD_IN_SORBS_SOCKS=1.927, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 20.04.24 um 07:40 schrieb Mark Cave-Ayland:
> On 20/04/2024 02:21, Richard Henderson wrote:
>
>> On 4/19/24 12:51, Mark Cave-Ayland wrote:
>>> The various Intel CPU manuals claim that SGDT and SIDT can write
>>> either 24-bits
>>> or 32-bits depending upon the operand size, but this is incorrect.
>>> Not only do
>>> the Intel CPU manuals give contradictory information between processor
>>> revisions, but this information doesn't even match real-life behaviour.
>>>
>>> In fact, tests on real hardware show that the CPU always writes
>>> 32-bits for SGDT
>>> and SIDT, and this behaviour is required for at least OS/2 Warp and
>>> WFW 3.11 with
>>> Win32s to function correctly. Remove the masking applied due to the
>>> operand size
>>> for SGDT and SIDT so that the TCG behaviour matches the behaviour on
>>> real
>>> hardware.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
>>>
>>> -- 
>>> MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed
>>> that this
>>> patch fixes the issue in WFW 3.11 with Win32s. For more technical
>>> information I
>>> highly recommend the excellent write-up at
>>> https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
>>> ---
>>>   target/i386/tcg/translate.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
>>> index 76a42c679c..3026eb6774 100644
>>> --- a/target/i386/tcg/translate.c
>>> +++ b/target/i386/tcg/translate.c
>>> @@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s,
>>> CPUState *cpu)
>>>               gen_op_st_v(s, MO_16, s->T0, s->A0);
>>>               gen_add_A0_im(s, 2);
>>>               tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State,
>>> gdt.base));
>>> -            if (dflag == MO_16) {
>>> -                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
>>> -            }
>>> +            /*
>>> +             * NB: Despite claims to the contrary in Intel CPU
>>> documentation,
>>> +             *     all 32-bits are written regardless of operand size.
>>> +             */
>>
>> Current documentation agrees that all 32 bits are written, so I don't
>> think you need this comment:
>
> Ah that's good to know the docs are now correct. I added the comment
> as there was a lot of conflicting information around for older CPUs so
> I thought it was worth an explicit mention.
>
> If everyone agrees a version without comments is preferable, I can
> re-send an updated version without them included.
>

Hi Mark,

I wouldn't remove the comment.

Quote from the Intel® 64 and IA-32 Architectures Software Developer’s
Manual Volume 2B: Instruction Set Reference, M-U March 2024:

IA-32 Architecture Compatibility
The 16-bit form of SGDT is compatible with the Intel 286 processor if
the upper 8 bits are not referenced. The Intel 286 processor fills these
bits with 1s; processor generations later than the Intel 286 processor
fill these bits with 0s.

Intel still claims the upper 8 bits are filled with 0s, but the
Operation pseudo code below is correct. The same is true for SIDT.

With best regards,
Volker

>>    IF OperandSize =16 or OperandSize = 32 (* Legacy or Compatibility
>> Mode *)
>>      THEN
>>        DEST[0:15] := GDTR(Limit);
>>        DEST[16:47] := GDTR(Base); (* Full 32-bit base address stored *)
>>    FI;
>>
>>
>> Anyway,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Thanks!
>
>
> ATB,
>
> Mark.
>
>
>


