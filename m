Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9FEC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzV9-0004bV-CJ; Thu, 20 Aug 2026 05:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wwzV1-0004aI-7x
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:55:53 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wwzUx-0005jI-Fs
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:55:49 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9DF3D583492;
 Thu, 20 Aug 2026 11:55:45 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Lh7swRI1N0KS; Thu, 20 Aug 2026 11:55:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0EE7B583224; Thu, 20 Aug 2026 11:55:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0D465583223;
 Thu, 20 Aug 2026 11:55:43 +0200 (CEST)
Date: Thu, 20 Aug 2026 11:55:43 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Purr Box <54weasels@gmail.com>
cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v4 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
In-Reply-To: <CAFWf6u-D2WJA01gz=eHgwShtt9si3_R-7FJvfTPDRNQFyt17EA@mail.gmail.com>
Message-ID: <3dcc49bd-8c96-0a99-9f7d-806319461672@eik.bme.hu>
References: <20260818022225.31801-1-54weasels@gmail.com>
 <20260818022225.31801-3-54weasels@gmail.com>
 <a9c04b36-c217-c0f7-0328-70c89d5ca667@eik.bme.hu>
 <CAFWf6u-D2WJA01gz=eHgwShtt9si3_R-7FJvfTPDRNQFyt17EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1248267766-1787219743=:96923"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1248267766-1787219743=:96923
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hello,

On Wed, 19 Aug 2026, Purr Box wrote:
> Hi Zoltan,
>
> Thanks for the review!
> I've refactored the logic for v5. I removed the redundant M68040 checks in
> frestore (keeping just the FIXME), and streamlined fsave so that it
> uniformly checks for M68K_FEATURE_FPU, writing an IDLE frame (0x41000000)
> for the 68040 and a NULL frame (0x00000000) for the 68881/68882.
> Also, thanks for the tip on the Context: tag. I've updated my script to
> inject it below the --- separator in the .patch files so it stays off the
> permanent git commit log while remaining visible to reviewers.

Update your script to also run qemu/scripts/checkpatch.pl or do that 
before submission. See 
https://www.qemu.org/docs/master/devel/submitting-a-patch.html
That should catch things like missing Signed-off-by that I've just 
noticed.

Regards,
BALATON Zoltan

> I'll wait a bit longer to see if there are comments on the rest of the
> series before spinning new patches.
>
> Dan.
>
> On Tue, Aug 18, 2026 at 3:52 AM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
>> On Mon, 17 Aug 2026, 54weasels wrote:
>>> High level description:
>>> The 68881/68882 FPUs require fsave/frestore instructions to read/write
>> state frames. QEMU only fully implemented this for the 68040. The Sun-3
>> uses a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence.
>> This patch adds basic 68881 FPU state frame handling (NULL frame) to
>> accurately simulate an idle FPU state.
>>>
>>> Impact on existing functionality:
>>> Fixes FPU detection for 68881/68882 across all M68k boards without
>> affecting 68040 specific state logic.
>>
>> Comments such as the next Context: should go below the --- as everything
>> before that is part of the commit message. In QEMU a Context: tag is not
>> commonly used so I think you want this as a comment not part of the
>> commit message.
>>
>>> Context: This patch was originally submitted as part of the monolithic
>> Sun-3 Machine Emulation series (
>> https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and
>> has been split into atomic components.
>>> ---
>>> target/m68k/translate.c | 20 ++++++++++++++++----
>>> 1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index 138c89d3e5..bdf619883c 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -5364,11 +5364,19 @@ DISAS_INSN(frestore)
>>>         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
>>>         return;
>>>     }
>>> -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
>>> +    if (m68k_feature(s->env, M68K_FEATURE_M68040) ||
>>> +        m68k_feature(s->env, M68K_FEATURE_FPU)) {
>>
>> M68020+ (including M68040) has FPU set so no need to keep that test and
>> can be replaced with M68K_FEATURE_FPU.
>>
>>>         SRC_EA(env, addr, OS_LONG, 0, NULL);
>>> -        /* FIXME: check the state frame */
>>> +        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
>>> +            /* FIXME: check the state frame */
>>> +        } else {
>>
>> What about M68060 or other CPUs with built-in FPU? As none of these do
>> anything maybe the if/else is not needed and can just keep the FIXME
>> comment?
>>
>>> +            /*
>>> +             * 68881/68882 FRESTORE: read the state frame
>>> +             * (NULL frame is 4 bytes)
>>> +             */
>>> +        }
>>>     } else {
>>> -        disas_undef(env, s, insn);
>>> +        disas_undef_fpu(env, s, insn);
>>>     }
>>> }
>>>
>>> @@ -5383,8 +5391,12 @@ DISAS_INSN(fsave)
>>>         /* always write IDLE */
>>>         TCGv idle = tcg_constant_i32(0x41000000);
>>>         DEST_EA(env, insn, OS_LONG, idle, NULL);
>>> +    } else if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
>>> +        /* 68881/68882 FSAVE: always write NULL frame */
>>> +        TCGv null_frame = tcg_constant_i32(0x00000000);
>>> +        DEST_EA(env, insn, OS_LONG, null_frame, NULL);
>>
>> Same comment as above about CPUs with FPU. Maybe there should be only one
>> block for M68K_FEATURE_FPU replacing M68K_FEATURE_M68040 and a switch for
>> setting the frame value?
>>
>> Regards,
>> BALATON Zoltan
>>
>>>     } else {
>>> -        disas_undef(env, s, insn);
>>> +        disas_undef_fpu(env, s, insn);
>>>     }
>>> }
>>> #endif
>>>
>>
>
--3866299591-1248267766-1787219743=:96923--

