Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CA1C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 19:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufNpG-0006cX-1M; Fri, 25 Jul 2025 15:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ufNoP-0006G9-SU
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 15:10:33 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ufNoN-0000RR-NW
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 15:10:33 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 316551F387;
 Fri, 25 Jul 2025 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753470628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gtgz+oj/Dc8q5WpxWX0kLS8C/+SbxJez1hlasJimaAc=;
 b=H+TL0JhB2zTgPtmvcJJTBOhgsvx6uOcmAxUqyYI2DIQQii+cahrvZPf18UTOP6aZsyR9k+
 +N/YTknMQYVC/HnbNhzl6Jvav73I1D2wzu1OGqhyOTBji8treo3qvA+p5d7G9vGcEg4Kve
 8WrgvDE+1D9gpiY4lJg0zTVQXvHeetg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753470628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gtgz+oj/Dc8q5WpxWX0kLS8C/+SbxJez1hlasJimaAc=;
 b=NOOBMD/hd9E74TEJJY4ZK0re3dXyXNzvT1G4fsxciDI82M0miRLbtXUOlYgTrqTkEHurP1
 GlK+5eQUbiqDgrCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753470628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gtgz+oj/Dc8q5WpxWX0kLS8C/+SbxJez1hlasJimaAc=;
 b=H+TL0JhB2zTgPtmvcJJTBOhgsvx6uOcmAxUqyYI2DIQQii+cahrvZPf18UTOP6aZsyR9k+
 +N/YTknMQYVC/HnbNhzl6Jvav73I1D2wzu1OGqhyOTBji8treo3qvA+p5d7G9vGcEg4Kve
 8WrgvDE+1D9gpiY4lJg0zTVQXvHeetg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753470628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gtgz+oj/Dc8q5WpxWX0kLS8C/+SbxJez1hlasJimaAc=;
 b=NOOBMD/hd9E74TEJJY4ZK0re3dXyXNzvT1G4fsxciDI82M0miRLbtXUOlYgTrqTkEHurP1
 GlK+5eQUbiqDgrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4B04134E8;
 Fri, 25 Jul 2025 19:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uj3JGaPWg2hSJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 25 Jul 2025 19:10:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Peter Xu
 <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PULL 02/20] target/arm: Correct encoding of Debug
 Communications Channel registers
In-Reply-To: <CAFEAcA9kxDdkEyLguTsEV_nDX9L5mAT+Rw_4Rmk68YQq50ee-A@mail.gmail.com>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
 <20250721132718.2835729-3-peter.maydell@linaro.org>
 <87ms8uh7ln.fsf@suse.de>
 <CAFEAcA9kxDdkEyLguTsEV_nDX9L5mAT+Rw_4Rmk68YQq50ee-A@mail.gmail.com>
Date: Fri, 25 Jul 2025 16:10:25 -0300
Message-ID: <87pldo3x3y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 23 Jul 2025 at 23:20, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > We don't implement the Debug Communications Channel (DCC), but
>> > we do attempt to provide dummy versions of its system registers
>> > so that software that tries to access them doesn't fall over.
>> >
>> > However, we got the tx/rx register definitions wrong. These
>> > should be:
>> >
>> > AArch32:
>> >   DBGDTRTX   p14 0 c0 c5 0  (on writes)
>> >   DBGDTRRX   p14 0 c0 c5 0  (on reads)
>> >
>> > AArch64:
>> >   DBGDTRTX_EL0  2 3 0 5 0 (on writes)
>> >   DBGDTRRX_EL0  2 3 0 5 0 (on reads)
>> >   DBGDTR_EL0    2 3 0 4 0 (reads and writes)
>> >
>> > where DBGDTRTX and DBGDTRRX are effectively different names for the
>> > same 32-bit register, which has tx behaviour on writes and rx
>> > behaviour on reads.  The AArch64-only DBGDTR_EL0 is a 64-bit wide
>> > register whose top and bottom halves map to the DBGDTRRX and DBGDTRTX
>> > registers.
>> >
>> > Currently we have just one cpreg struct, which:
>> >  * calls itself DBGDTR_EL0
>> >  * uses the DBGDTRTX_EL0/DBGDTRRX_EL0 encoding
>> >  * is marked as ARM_CP_STATE_BOTH but has the wrong opc1
>> >    value for AArch32
>> >  * is implemented as RAZ/WI
>> >
>> > Correct the encoding so:
>> >  * we name the DBGDTRTX/DBGDTRRX register correctly
>> >  * we split it into AA64 and AA32 versions so we can get the
>> >    AA32 encoding right
>> >  * we implement DBGDTR_EL0 at its correct encoding
>> >
>> > Cc: qemu-stable@nongnu.org
>> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2986
>> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Message-id: 20250708141049.778361-1-peter.maydell@linaro.org
>> > ---
>> >  target/arm/debug_helper.c | 13 +++++++++++--
>> >  1 file changed, 11 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
>> > index 69fb1d0d9ff..aee06d4d426 100644
>> > --- a/target/arm/debug_helper.c
>> > +++ b/target/arm/debug_helper.c
>> > @@ -988,11 +988,20 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
>> >        .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
>> >        .access = PL1_RW, .accessfn = access_tdcc,
>> >        .type = ARM_CP_CONST, .resetvalue = 0 },
>> > -    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
>> > -    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
>> > +    /* Architecturally DBGDTRTX is named DBGDTRRX when used for reads */
>> > +    { .name = "DBGDTRTX_EL0", .state = ARM_CP_STATE_AA64,
>> >        .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
>> >        .access = PL0_RW, .accessfn = access_tdcc,
>> >        .type = ARM_CP_CONST, .resetvalue = 0 },
>> > +    { .name = "DBGDTRTX", .state = ARM_CP_STATE_AA32, .cp = 14,
>> > +      .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
>> > +      .access = PL0_RW, .accessfn = access_tdcc,
>> > +      .type = ARM_CP_CONST, .resetvalue = 0 },
>> > +    /* This is AArch64-only and is a combination of DBGDTRTX and DBGDTRRX */
>> > +    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_AA64,
>> > +      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
>> > +      .access = PL0_RW, .accessfn = access_tdcc,
>> > +      .type = ARM_CP_CONST, .resetvalue = 0 },
>> >      /*
>> >       * OSECCR_EL1 provides a mechanism for an operating system
>> >       * to access the contents of EDECCR. EDECCR is not implemented though,
>>
>> Hi, this patch breaks migration. I'm leaving for the day and will take a
>> closer look in the morning. But since we have timezones, here it is:
>
> Thanks for the report; I can repro this. It happens because
> the loop in cpu_post_load hits the "register in their list but
> not ours" check, because the source VM has the AArch32
> {.cp = 14, .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0}
> register which should never have existed.
>

My debugging (in dst) shows:

(gdb) x/16x 0x555557ad5d20 //cpu->cpreg_vmstate_indexes[0x18 to 0x1c]
0x555557ad5d20: 0x200e0205      0x40200000      0x200e0284<     0x40200000
0x555557ad5d30: 0x200e0285      0x40200000      0x200e0298      0x40200000
0x555557ad5d40: 0x200e0302      0x40200000      0x200e0380      0x40200000
0x555557ad5d50: 0x200e0800      0x40200000      0x200e0838      0x40200000

(gdb) x/16x 0x555557ad4ac0 //cpu->cpreg_indexes[0x18 to 0x1c]
p0x555557ad4ac0: 0x200e0205      0x40200000      0x200e0280<     0x40200000
0x555557ad4ad0: 0x200e0284      0x40200000      0x200e0285      0x40200000
0x555557ad4ae0: 0x200e0302      0x40200000      0x200e0380      0x40200000
0x555557ad4af0: 0x200e0800      0x40200000      0x200e0838      0x40200000


> I'm not sure how to handle this, as we have no mechanism for
> "ignore this incoming register value, it is bogus". I'm surprised
> we've never run into this before...
>

I was thinking the same.

I actually don't understand what the encoding in cpu->cpreg_indexes is
supposed to represent. How does comparing the indexes implies "in our
list"/"in their list"? Is there some sort of ISA level assumption?

       if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
            /* register in our list but not incoming : skip it */
            continue;
        }
        if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
            /* register in their list but not ours: fail migration */
            return -1;
        }
 
> I won't be able to look at this further til the tail end of
> next week.
>
> As an aside, it is a shame that post_load hooks do not
> take an Error** -- if they did we would be able to report
> this more usefully to the user by saying why the migration
> failed instead of just returning -1. Perhaps it would be
> worth adding _err versions of the hook fields in
> VMStateDescription so that devices can optionally
> implement them instead if they have interesting or
> complicated errors to report ?
>

Definitely, there's work happening at moment in the upper layer that
will allow errors to be propagated from post_load.

https://lore.kernel.org/r/20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com

> thanks
> -- PMM

