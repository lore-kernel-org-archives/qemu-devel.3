Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7212B108B8EE
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Xd2-0005Zi-5z; Fri, 20 Mar 2026 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Xcp-0005YN-A1
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:02:45 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3Xcn-0001r2-Cz
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 07:02:43 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso401404d50.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 04:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774004560; cv=none;
 d=google.com; s=arc-20240605;
 b=jrYZTc+ANUrqSevdoZkbvp795eT+iVhNJ8QzmcFvhFl3GEcPir2F3JnY1pQY0mRuSW
 dbc89Bnkp2WwRO2d+gbPvcUDnYnkryxhd+i4EIBkkC02MvkXOmDhe0ONvmaiuXO6LeXP
 0/+PTs+eApjEIsyZzv2mem42HXOwVAmBL5bt9mwSuZ52iNMDA+iFOhWf5wySnhqASAE4
 DVOFte8wzM0IqniCvK6A4Sw0+ZHD+L9zDZIDEyQORVhkbiBPPNL95hcWnhIe+aapIvm1
 9cY7uCF6cowx1uYZ4dFRI0prXLS6CEjb3hrUaWqV1csrL6KtfY3JyObwjccRptIOVGi5
 +3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aUiMsebAfyqqQUTXu1UsEugOT0lrKXEEhYz948DS5ws=;
 fh=hHQwqgTY7ltwat616CldellfBTSzzr31raK2NubcdK0=;
 b=dtetkoAoAGeFUyp4wTbMbLPjGG2eQCq8n1Qbx75qkItoPrXQ5jTI1DbyyRJx3HNfl3
 ZgfVEvkEEK16q2cP+JgmIia0hPRAE6CZLXgE258dmCt95f4LrqdB6ftXvPMwDwWY/SCv
 ML1wm59ptKdCZPBbvUo1cq+5mthLfJm8O2KHVHcGmIXpx28sBEFdlOlrLkwVpC2IkePI
 y19BeXffMFYzJtLfMY/vzwHZ875U5Sb/UkGaDz4a72bymCGc1nhfH3x69wdszoTs/FId
 hGXNecJ2ukDlwxZO32H/SDRKuMtpQ0dvUP0fkSTnVYSwDTQLHAeP5++empkR8ISxJz5z
 +phQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774004560; x=1774609360; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aUiMsebAfyqqQUTXu1UsEugOT0lrKXEEhYz948DS5ws=;
 b=aSMyWL3xoWBR5HLy6Jf0bkGzevyNcBC/w9H8V6q/0T0CMuDL2H47BMp8/OebMA4Gdo
 T//4+hC06hMAIIHUnsk7EnTduEEQxdMefx4ZPX9m+1bxrd71Ezgw8jsItnUYXvMiE/0m
 WdvF5KRQBIiLZz+M6AiXx9kUCKNVTLGGQDJxphqiIdQrUCIffvg5s04WkwThnRROceT6
 FBqdB1SGOM4cWaMl/xWbIiim4n7R/KFZs3f1/eg63tIAAJ6MpAjAKf3GrrB6RBmbuOUN
 wS1CUTqLQiMX/Ob7poZ+bHSa9UcnNphGh71f83Co3fVlardv0dPSVTaB0ZQWPUKMygvM
 bLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774004560; x=1774609360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUiMsebAfyqqQUTXu1UsEugOT0lrKXEEhYz948DS5ws=;
 b=LzI/BPrr+AbAOWYy0K5dzYyh16td4vRgBpj5Zug0EiXhQuZYysjEXVSqEC5UUq1Gu/
 q8rAyRwSFUUANCpljyyRcLsu5UPXeRG9t3AUOH+aGSe/RijDLED0v0WFsrwQknvgmd/m
 AFrUd3+7nPmXOFj3nYC1djKH2T6KBDUw9icJDi3X3mq8ZE7rJmtPLQQE4KawTel4XOoK
 dQ3Se6v1NLQClHuAvDR5QM5y4xyifxYvLrvk+e0u0PydQCmRGcng6t1ZMYP+MOrVwG1r
 MJlOW3DOJ2Zz6zpN+/fy5AYBKvmBsgExrlrMbLb/fmoJinCEDcA+ngtTJ07d6nyo9JDp
 FlRw==
X-Gm-Message-State: AOJu0Yxwk8afliovPElF8tka+bnSaY3LG46kqf+rI0Ye8UVAjFia/UTV
 qrX5OJ7lwbTg9Qy0hG0lmQZvh5r3rZpLKLC4CA6fQFgl3pTxF8Tt/pDjo/LKRxssveir2/sYLY3
 xKMUJRlt9Xy8ehiJ8iAz+XxuoQmrl3EQ1dws51Lcbyg==
X-Gm-Gg: ATEYQzxzEtYrNyXjsTw4tW29d5tc0rXZW6Mu5HWs5BQrDyYx3MyrmiwhqYG0PA+8eFh
 M/+dOXsl1mTu2r8FBAYp/Ieafwr2G66P9BvmoticgGkmeOmqSWp22TOWqQux2I6vyExy94TAfJj
 l0vjE643gA5GAQ9RpvaAr84R+p3/k3pOGeYf54HSWUbT76rC98BrlGv4yaLcM6/W3VMfZzUq8v5
 YsvQHN5a1omOQ/T3sjnuZr6xTRwlmnPwFIEXaoT3YMXEmaxG93K7Or3ej6+FyIdH8Wntm+JeqBP
 0F+dMnSqLCp3mJ6HG40JfJ/ZmVWiFB6nGyr0/PVxRyhj9aryyVOT08vmRcmUBpot4LXNKJStPOU
 eMQ==
X-Received: by 2002:a05:690e:e83:b0:64a:db13:962e with SMTP id
 956f58d0204a3-64eaa70635bmr2820997d50.26.1774004559590; Fri, 20 Mar 2026
 04:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
In-Reply-To: <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 11:02:28 +0000
X-Gm-Features: AaiRm52GGvi6UlE1Whih_uVFoS0m7XGwco_3kWPIksLe4OuUSddkksYrkbl8_4U
Message-ID: <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Mon, 16 Mar 2026 at 21:42, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 13/03/2026 17:09, Peter Maydell wrote:
>
> > In the SPARC CPU state, env->regwptr points into the env->regbase
> > array at wherever the architectural CWP (current window pointer) says
> > we are in the register windows.  We don't migrate this directly,
> > since it's a host pointer, so we must ensure it is set up again
> > after migration load.
> >
> > We also have to deal with a special case when CWP is (nwindows - 1).
> > In this case, while running we keep the "in" register data for this
> > window in a temporary location at the end of the regbase[] array, so
> > that generated code doesn't have to special case this "wrap around"
> > case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> > wrapped data from its temporary location into the architectural
> > location in window 0's "out" registers.  We then migrate only
> > (nwindows * 16) entries in the regbase[] array.  So on the
> > destination we need to copy the "in" register data back to its
> > temporary location again.
> >
> > For 32-bit SPARC we get this right, because the CWP is in the PSR.
> > The get_psr() function does:
> >      env->cwp = 0;
> >      cpu_put_psr_raw(env, val);
> > which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> > sets up both regwptr and the wrapped-register data.
> >
> > However, for 64-bit SPARC the CWP is not in the PSR, and
> > cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> > register state in a corrupted state, and the guest will likely crash
> > on the destination if it didn't happen to be executing with CWP == 0.
> >
> > Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
> > for the 64-bit case, and enough commentary to explain what is going
> > on.
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I ran into this because the "sparc64-migration" functional test seems
> > to hit this reliably when built with the address sanitizer.  This is
> > probably a timing thing, because it doesn't trip any ASAN failures,
> > the guest just crashes on the destination side most of the time
> > because it returns from a subroutine to a corrupt %o7 return address.
> >
> > As far as I can tell this is what the problem is, but I'm a bit
> > surprised that we have never hit this, given how likely you are to
> > hit it on a vmsave/vmload or migration.  So am I missing something?
> > ---
> >   target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> > index 4dd75aff74..b935c31630 100644
> > --- a/target/sparc/machine.c
> > +++ b/target/sparc/machine.c
> > @@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
> >       SPARCCPU *cpu = opaque;
> >       CPUSPARCState *env = &cpu->env;
> >
> > -    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
> > -     * window as the outs of the first window
> > +    /*
> > +     * If env->cwp == env->nwindows - 1, this will set the ins of the last
> > +     * window as the outs of the first window. We do this because we only
> > +     * transfer the (nwindows * 16) entries of regbase[] that correspond
> > +     * to the "proper" locations of the registers; this call has the
> > +     * effect of copying the wrap register values from their temporary
> > +     * location down to their proper location ready for migration.
> >        */
> >       cpu_set_cwp(env, env->cwp);
> >
> >       return 0;
> >   }
> >
> > +static int cpu_post_load(void *opaque, int version_id)
> > +{
> > +    /*
> > +     * For 32-bit SPARC we set the register window data structures
> > +     * up again correctly when get_psr() called cpu_put_psr_raw(),
> > +     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
> > +     * part of the PSR, so we need to handle it here.
> > +     *
> > +     * There are two things we need to have happen:
> > +     * 1. regwptr points into regbase[] at the location determined by CWP.
> > +     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
> > +     *    in a copy at a temporary location at the end of the regbase[]
> > +     *    array. For migration we only transferred the (nwindows * 16)
> > +     *    entries of regbase[] that correspond to the "proper" locations
> > +     *    of the registers, so now we must copy the wrap registers back to
> > +     *    their temporary location.
> > +     *
> > +     * We achieve both of these by setting env->cwp to 0 and then calling
> > +     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
> > +     */
> > +#if defined(TARGET_SPARC64)
> > +    SPARCCPU *cpu = opaque;
> > +    CPUSPARCState *env = &cpu->env;
> > +    uint32_t cwp = env->cwp;
> > +
> > +    env->cwp = 0;
> > +    cpu_set_cwp(env, cwp);
> > +#endif
> > +    return 0;
> > +}
> > +
> >   /* 32-bit SPARC retains migration compatibility with older versions
> >    * of QEMU; 64-bit SPARC has had a migration break since then, so the
> >    * versions are different.
> > @@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
> >       .version_id = SPARC_VMSTATE_VER,
> >       .minimum_version_id = SPARC_VMSTATE_VER,
> >       .pre_save = cpu_pre_save,
> > +    .post_load = cpu_post_load,
> >       .fields = (const VMStateField[]) {
> >           VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
> >           VMSTATE_UINT32(env.nwindows, SPARCCPU),
>
> Nice analysis! I suspect the reason this doesn't always show up is because any
> context switch (e.g. OpenBIOS, kernel to user, 32-bit to 64-bit etc.) will flush the
> entire register window set to the stack, and hence reset env->cwp back to 0.
>
> It does instinctively feel odd that 32-bit and 64-bit aren't handled in the same way
> - I wonder if this implicit behaviour on 32-bit somehow needs to be more explicit?

I did wonder about that, but I preferred leaving the 32-bit handling
the way it is -- trying to unify it with 64-bit would require making
the get_psr() code path go out of its way to avoid updating the
reg window data structures, which seems awkward and a bit unnecessary
given the code does work. So I opted to describe the way the 32-bit
targets do it in the cpu_post_load() comment, so at least we have
a record of it.

Are you OK with this patch as it stands, or would you like me to
change it?

thanks
-- PMM

