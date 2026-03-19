Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22081075288
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w39fD-0006R5-QK; Thu, 19 Mar 2026 05:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w39fA-0006Qp-Ds
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:27:32 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w39f7-0001f8-5c
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:27:30 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso1139892d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 02:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773912447; cv=none;
 d=google.com; s=arc-20240605;
 b=J0JCTlZ5snurk26FdDCB+7cXwaKAMTCdtHRAKCv6sLM7PKae9T/PwS1AwGc49a8hGs
 tlcRweuCo3Qa2CmrWs5bH7o7bBP/wuD3RBKF37izMyON/BWKsykEY8UaoE6hM88hE5YB
 VxPK8QZkAtFhvrjQDbEQwDy5x3et4ardE46DJw31saZmPVhQ58QJT8P7oqYMxxRkI8ZO
 tsOOVanEEr6Iv8oMwOk1PnGOgMi+coBKwyqvDiU1CDl8NTGxfEekO7U7J+GkG7i3kz/K
 2dVp04e2JqmzkkNHxFXpowZlY9ht7BC1GmEM42vkMd/oE7c3fbFcHL6bOnVKKZiU83XN
 bI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/3jq1UWLK1EM6BOmYw+nbLbSBfJ1+YJMHpsMj9wapyw=;
 fh=PzbTjfSh5thByvES80y7/ymjUitiQ4VIxw4ZoPURAB0=;
 b=IMCMhBtA6vvIGgfRojA4+OKKdsTrjtyy6vjeBNSeKxOWi7yR/kLfWfmOr+f+0R7Kqb
 IcbpVkc+g9DNvZogKVAZPZ3BvWpqlCMz4v/6hzwL9h/eBCzi+b3SEcbRWz1ZA0qKAwpm
 1XG9m2WVc73pjMyWMSVP9I0nitCE58YshVzfz0FBJ+XFrQRcL9qn4+y31y+5GFANdmxM
 9DsfhDvnkWKAta+X4c8lze1uoJkPHrgFdJjtCydWe65RfubM5xEOgdcL++DH58Dt0iJM
 Nm+18qvuGDLbhwVBvkxdfLJtEFJh2GdtoJrQsf8bPVlp2RrKDKd8JkHhSazaWYiWhQOo
 iKQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773912447; x=1774517247; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/3jq1UWLK1EM6BOmYw+nbLbSBfJ1+YJMHpsMj9wapyw=;
 b=e2Vqrs97B72V7W9WtMSC2zJQpvRTR5UHCRndqEfFVB4FpoSoy8vwqdYkmxzQpncarI
 p1HLxq5Xx/qs3nDBis1j7uLgXSas6NO/rM821odndtZANh+TDKDpY6TkUe8YrRPxNqsy
 eVr6MWY0R9rQSOKVVjZn5yKKZDvS48l3rK7cxvprkhngraPAfZBjP4Y1bjF2Q9zDUx5K
 rNwjSERG+rXKQSGe+5eTMwbvkd/npovJJEEog+x4BTiwIf6vVUpcPrrufkeG8r2zKGho
 RzJYM5iE36CRLSBiSD34aWVEhsF4GGwoPYT7dhvGxBZf37EsciMEzIJqNtkKGJXhmasb
 Zxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773912447; x=1774517247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/3jq1UWLK1EM6BOmYw+nbLbSBfJ1+YJMHpsMj9wapyw=;
 b=BaEPAfXO5nfqO7SdLQ8aof7+I6r54jyZ1bGgvLHJoe6OAZoR1uN3ohh4g+zFOPE8i8
 VCq0s5AKLxZtL9HcmwmVtEUa5/437K21hJVK4R8yEKDnGbUWtjLdbZKfVv1ss/oiBfa1
 lVFh7rSYCIae+vP3uF2eaJZDPViSmNYCpEmluUlb+i2SAufOzQYIlumAoezEp7wz53H6
 7tBWkEFy0fDxAopmETKPCq0AdMuCQWejwcFlo/53P6XA4Hbp7H69Pw+QhyiiJwfhz8cr
 e//TNzmSNCWClgaRnnfWk0cb02IDBrCeAk4ZrO6HCsVI44gki4Vd/29zp5VNvRqX6uTq
 m+eA==
X-Gm-Message-State: AOJu0YyGJmXSwBIXF7QI8qXZCjd4+tmeCED3wEc0HAdQ04oiiw5GP+N+
 DlWH0v9jYBeiXHhrCPXyThx+UJ5wEImf4Ireq6H9vTuSNNAUaXrRXPXBJiXPvcVeI2enuLkTKYy
 R/9qReg2PgR77hjfHczwZRdf1G05IHOydWaWNZGIqPA==
X-Gm-Gg: ATEYQzzeYTSBe/9gTGQymd0tjEWzjFcETSoGM0TzFTMK2Qptmb8LvUGwT1YTsPa40UR
 50NpR+Dq9nm3k4P5nHl40jSYO3XLcyo+LIBMcJ6yqJe57/8fT/0AoANt+4PNv0nUrshqdQkyAKL
 54xhAZnDTP07ysgRPMPMwSf5A86pobNMmaHNgJ/XXTy50MXZgv6ZspN4ch4I3NV+SuRBNUzVtvY
 sNKwdXjW5L2R2GMgWn0Oe75ZkY6hFH6LSLIrOcBF+6wr9AzNK46vMv7l1QhaylNpuZvNK0kNJNf
 YFHDopgcozNQb8ov5Up0hIoL9FFvv6cwpzQNNschWmzsHlGYdE44D+MLHLez46nhiAKFK88LZsW
 zew==
X-Received: by 2002:a53:d9d0:0:b0:64a:d705:31d0 with SMTP id
 956f58d0204a3-64e9133f743mr5884941d50.28.1773912446935; Thu, 19 Mar 2026
 02:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260305161739.1775232-1-peter.maydell@linaro.org>
 <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
In-Reply-To: <8d76a679-4d7c-4c3b-80d2-11799dc98fdc@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2026 09:27:15 +0000
X-Gm-Features: AaiRm51SeHGCQGPj1-4bnWtyTcyXT1DlKeEE1gxer2vxn-R5OdysEsEE0IEabbM
Message-ID: <CAFEAcA9HgVmbe9TXGOZW5Vbkvbn-Dvah24f1oPn4zvymk=_mZg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/i386/signal.c: Correct definition of
 target_fpstate_32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 19 Mar 2026 at 03:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/6/26 05:17, Peter Maydell wrote:
> > Our definition of the target_fpstate_32 struct doesn't match the
> > kernel's version.  We only use this struct definition in the
> > definition of 'struct sigframe', where it is used in a field that is
> > present only for legacy reasons to retain the offset of the following
> > 'extramask' field.  So really all that matters is its length, and we
> > do get that right; but our previous definition using
> > X86LegacySaveArea implicitly added an extra alignment constraint
> > (because X86LegacySaveArea is tagged as 16-aligned) which the real
> > target_fpstate_32 does not have.  Because we allocate and use a
> > 'struct sigframe' on the guest's stack with the guest's alignment
> > requirements, this resulted in the undefined-behaviour sanitizer
> > complaining during 'make check-tcg' for i386-linux-user:
> >
> > ../../linux-user/i386/signal.c:471:35: runtime error: member access within misaligned address 0x1000c07f75ec for type 'struct sigframe', which requires 16 byte alignment
> > 0x1000c07f75ec: note: pointer points here
> >    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
> >                ^
> >
> > ../../linux-user/i386/signal.c:808:5: runtime error: member access within misaligned address 0x1000c07f75f4 for type 'struct target_sigcontext_32', which requires 8 byte alignment
> > 0x1000c07f75f4: note: pointer points here
> >    0a 00 00 00 33 00 00 00  00 00 00 00 2b 00 00 00  2b 00 00 00 40 05 80 40  f4 7f 10 08 58 05 80 40
> >                ^
> >
> > and various similar errors.
> >
> > Replace the use of X86LegacyXSaveArea with a set of fields that match
> > the kernel _fpstate_32 struct, and assert that the length is correct.
> > We could equally have used
> >     uint8_t legacy_area[512];
> > but following the kernel is probably less confusing overall.
> >
> > Since in target/i386/cpu.h we assert that X86LegacySaveArea is 512
> > bytes, and in linux-user/i386/signal.c we assert that
> > target_fregs_state is (32 + 80) bytes, the new assertion confirms
> > that we didn't change the size of target_fpstate_32 here, only its
> > alignment requirements.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> I think it's more complicated than that.  I think this is indicative of the alignment
> being wrong.  In fact, I have a vague memory that we have an Issue outstanding for this,
> which I looked into once upon a time, and I think we're well out of spec.

I could definitely believe that I'm missing something subtle here :-)

> There are two parts: fpregs, which should be 64-byte aligned (for xsave/xrestore), and the
> main signal frame, which must be x % 16 == 16 - sizeof(void *), so that SP, after pushing
> the return address, is 16-byte aligned.

The 64-bit x86 signal frame and the 32-bit signal frame alignment
requirements are slightly different, I think (and this problem and
this patch are dealing only with 32-bit x86). In the kernel's
arch/x86/kernel/signal.c:get_sigframe() they calculate the frame
address like this:

        if (ia32_frame)
                /*
                 * Align the stack pointer according to the i386 ABI,
                 * i.e. so that on function entry ((sp + 4) & 15) == 0.
                 */
                sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
        else
                sp = round_down(sp, FRAME_ALIGNMENT) - 8;

So x % 16 == 16 - sizeof(void*) is true for 64-bit, but 32-bit is
slightly different.

In QEMU we do:

    /*
     * Align the stack pointer according to the ABI, i.e. so that on
     * function entry ((sp + sizeof(return_addr)) & 15) == 0.
     */
    sp += sizeof(target_ulong);
    sp = ROUND_DOWN(sp, 16);
    sp -= sizeof(target_ulong);

which matches the kernel for 32 bit (it does look like
it gives the wrong answer for 64-bit, but that's not relevant
for this bug).

I also note that for the data structure I am fixing, we never do
an xsave/xrestore on it -- it is purely junk unused padding.
The real xsave/xrestore info is elsewhere, in the dynamic part
of the signal frame.

thanks
-- PMM

