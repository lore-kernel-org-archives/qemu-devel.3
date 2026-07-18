Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6A4C4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 08:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl0h8-0006uZ-HO; Sat, 18 Jul 2026 04:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wl0h7-0006uD-Og
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 04:46:49 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wl0h5-0001T6-N3
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 04:46:49 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81e9f7491ffso108269367b3.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 01:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784364406; cv=none;
 d=google.com; s=arc-20260327;
 b=VhrOVgdNjsghe3ddEGRoDByR793dWOCA5jX7e8f/t4GzTTLdxXVIU+OmZ/hdDNbfET
 GdMCMTY8TlN5gQFyeZ1E3njlFibW5pfpzpTFUioL0pmWSoHDt8OTHMMoy2YK8O25bKVh
 N8ewRhsGtlk7wz68b4ZbBuIzAHTcx3X0Yj5Y7E5THfszKH7IpO6SkdQtr6HECGDvsQmB
 UKrcVgxefLYhB9EpyBLikcGS//ism65+m1RnZjEbckyQ+3gzLdALI2VzHblBJe+H+MGg
 uJ+A5DbnVI0C8G3T5WYbLnXa/N3Z8ZkFpqhn99OkTq88bhBNDUc24vOx0aDi1wB7WivL
 AtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hQ9wju8zMMYK2IRw5pjD8AVLUQicw+TqfdvxBzIpRj0=;
 fh=hHQwqgTY7ltwat616CldellfBTSzzr31raK2NubcdK0=;
 b=aYY0u87vJT0uOctaXQ1GhUXQlNo5vjzMLCC8Go7tZzC1Lf1vdnOlCCCmwV/hTnVwgj
 7yDfHu/1gn38ga2b50Fwm3sCRVW1sprO4RpUuY1tKhetE9gTcvbzGhjUSaUo+83OXpRz
 JLMWHu5nXcc4Ff3jT5ae37UKfn1lwZBXWkuIbyKsCeXTOHKe9h3OwJSDfnJte0+QHb81
 UK0kH12lGQUgijZ/wfR65JbNuSxXIQnN2q70t/2FUizu36B11J5tTFAPX1T0e6dQZ7G8
 sUn04mfGKlUfiw5FOi1O8bpCKamYqkwoHoDsekN39W2Os4kJJpt3I+9VBl0HZ9iK4sIn
 ddaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784364406; x=1784969206; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hQ9wju8zMMYK2IRw5pjD8AVLUQicw+TqfdvxBzIpRj0=;
 b=uIFgvDbaq17ROS/oTwbYotxfdugZkbuhE0qWTe3oYbYU8qedzRAJ+QOjTZpUfu3OTt
 daRXxKrUB1ZyASzM4ZOpoK3N9y9PelAcmIeV0xe/Mo8+squPB/Ta2Z8m6Lzv6OXhktuf
 F9QV/FHFWgpZ2Lgu2oba2IKIeErUTyC1tU3CBm/be0p/a0joMwBXLyo+9n9huCpxk3hY
 OxYt74lq+otlTnXNIlkMLF39V1w+br6pUv2WpofD1bhH4f41dlqQsjga7+z3CNJgjCA/
 K+F2c5vhu5PWtpOSEF3JCSgg/ZGWkGjLf/Jk67n39jB3/GxMO45U3gX3KDArzC9B6Jg1
 Edbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784364406; x=1784969206;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hQ9wju8zMMYK2IRw5pjD8AVLUQicw+TqfdvxBzIpRj0=;
 b=qUtcgjuGFiV4SMazdnUYkYDVpGfukVb2+QfKa0nQfv38FfZ9/JragwQbbyPwEcMSgX
 oHQ9tIE9fI2YlSl8P1hwjGhZ1nsPDw9MvVk1z+HTWv5D0MECqHaP8dQi2cifuB5toAun
 2pr/gdik20D+DrOQy2CH+j7PAf+0qsIbu/004F2zsLU6EjiF0IBfSnijJYGwQbljTbMH
 JtoUNgZryKJyvGWPGVClbiItRbrRXYBtg1rLsAe6zeVymFHUUP9sMHWf/quf6fa3rMoF
 wkAXkn/IhJYK0J3/293aV4Mr+L6Dv3Kg2nPpt2Xm8calpKkVdeuRjkVVqYvFiUDGRkRJ
 HYzQ==
X-Gm-Message-State: AOJu0YxwHeFDNKGpJy1evH2dc/WznORDKRP6zAqnTU0SSlHZ3iVJAFFj
 AKUhm7E8RDKOcmQ/r5i7Ij080I8AcWnId3EVAR3rIV3xOa2i6nGv7JIn6RpvAYeWDJTtnS0GYlD
 idhtMVURdh+6ppErn5OF/QSFXvtY/Rg4m14QDbBZRyw==
X-Gm-Gg: AfdE7cmwZ5726K98EKGDOITY2W5GJEnOwqjPCKdrrc8FN8rj9wOoJF+3UyscZP+BVBT
 UZJ9k2xqHXKPdBKIbMHLJsSTQ6/RAa/o7K3d1W0E9qilqKcoNfsxqV7HzRry8XKknYc/D0rrWNY
 3kts8gDRc1irQmu1JibicCEm2YWna4QaaX25PrJKKtSw/n5lKymS9AZlriguoN65bIkAZ5LfbZi
 Pf0BS2cSoQ1bjGQwYyFfxwkVIu2D4ZA4KWcGgSU4VPF4tAhOGiw2XNbLhzPzNRBrkGxJxCfExWq
 MXRYKpgHYjw5DhngWnnAeRZgcUCAWsy+kbCaMEk3qB3UvZ0SZFcJ5mWS
X-Received: by 2002:a05:690c:4b90:b0:81d:5ee3:aef9 with SMTP id
 00721157ae682-81ef26dd7edmr19305917b3.8.1784364405904; Sat, 18 Jul 2026
 01:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
 <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
 <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
 <CAFEAcA_boBOkNAaUgX=QEQvm3Mgy2ewkSNtx8zR9e=P58aWmmQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_boBOkNAaUgX=QEQvm3Mgy2ewkSNtx8zR9e=P58aWmmQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2026 09:46:34 +0100
X-Gm-Features: AUfX_mxnvce9eks6gI06cdKprwmA-k6V6VLSJnNUAqaFgppwtsk5zkxcV_2A4YA
Message-ID: <CAFEAcA-VF47TGkRQBh_phZVvZ36tN5OJepbb1z=t=O=R3CwZDg@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping^3. It would be nice to get this fix into 11.1, since it's
a bug that trips the address-sanitizer.

thanks
-- PMM

On Mon, 11 May 2026 at 15:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping^2. I think this is now the only remaining blocker to being
> able to do a full sanitizer test run. I'm happy to throw it into
> my target-arm queue if you don't have any other sparc patches you
> need to send, but I think it would be better if it had a
> reviewed-by tag first :-)
>
> -- PMM
>
> On Thu, 30 Apr 2026 at 14:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Ping ? Now we're in the 11.1 cycle it would be nice to get these
> > remaining sanitizer errors fixed so we can maybe get a CI job
> > to test a sanitizer build.
> >
> > thanks
> > -- PMM
> >
> > On Fri, 20 Mar 2026 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Mon, 16 Mar 2026 at 21:42, Mark Cave-Ayland
> > > <mark.cave-ayland@ilande.co.uk> wrote:
> > > >
> > > > On 13/03/2026 17:09, Peter Maydell wrote:
> > > >
> > > > > In the SPARC CPU state, env->regwptr points into the env->regbase
> > > > > array at wherever the architectural CWP (current window pointer) says
> > > > > we are in the register windows.  We don't migrate this directly,
> > > > > since it's a host pointer, so we must ensure it is set up again
> > > > > after migration load.
> > > > >
> > > > > We also have to deal with a special case when CWP is (nwindows - 1).
> > > > > In this case, while running we keep the "in" register data for this
> > > > > window in a temporary location at the end of the regbase[] array, so
> > > > > that generated code doesn't have to special case this "wrap around"
> > > > > case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> > > > > wrapped data from its temporary location into the architectural
> > > > > location in window 0's "out" registers.  We then migrate only
> > > > > (nwindows * 16) entries in the regbase[] array.  So on the
> > > > > destination we need to copy the "in" register data back to its
> > > > > temporary location again.
> > > > >
> > > > > For 32-bit SPARC we get this right, because the CWP is in the PSR.
> > > > > The get_psr() function does:
> > > > >      env->cwp = 0;
> > > > >      cpu_put_psr_raw(env, val);
> > > > > which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> > > > > sets up both regwptr and the wrapped-register data.
> > > > >
> > > > > However, for 64-bit SPARC the CWP is not in the PSR, and
> > > > > cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> > > > > register state in a corrupted state, and the guest will likely crash
> > > > > on the destination if it didn't happen to be executing with CWP == 0.
> > > > >
> > > > > Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
> > > > > for the 64-bit case, and enough commentary to explain what is going
> > > > > on.
> > > > >
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > > > ---
> > > > > I ran into this because the "sparc64-migration" functional test seems
> > > > > to hit this reliably when built with the address sanitizer.  This is
> > > > > probably a timing thing, because it doesn't trip any ASAN failures,
> > > > > the guest just crashes on the destination side most of the time
> > > > > because it returns from a subroutine to a corrupt %o7 return address.
> > > > >
> > > > > As far as I can tell this is what the problem is, but I'm a bit
> > > > > surprised that we have never hit this, given how likely you are to
> > > > > hit it on a vmsave/vmload or migration.  So am I missing something?
> > > > > ---
> > > > >   target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
> > > > >   1 file changed, 39 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> > > > > index 4dd75aff74..b935c31630 100644
> > > > > --- a/target/sparc/machine.c
> > > > > +++ b/target/sparc/machine.c
> > > > > @@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
> > > > >       SPARCCPU *cpu = opaque;
> > > > >       CPUSPARCState *env = &cpu->env;
> > > > >
> > > > > -    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
> > > > > -     * window as the outs of the first window
> > > > > +    /*
> > > > > +     * If env->cwp == env->nwindows - 1, this will set the ins of the last
> > > > > +     * window as the outs of the first window. We do this because we only
> > > > > +     * transfer the (nwindows * 16) entries of regbase[] that correspond
> > > > > +     * to the "proper" locations of the registers; this call has the
> > > > > +     * effect of copying the wrap register values from their temporary
> > > > > +     * location down to their proper location ready for migration.
> > > > >        */
> > > > >       cpu_set_cwp(env, env->cwp);
> > > > >
> > > > >       return 0;
> > > > >   }
> > > > >
> > > > > +static int cpu_post_load(void *opaque, int version_id)
> > > > > +{
> > > > > +    /*
> > > > > +     * For 32-bit SPARC we set the register window data structures
> > > > > +     * up again correctly when get_psr() called cpu_put_psr_raw(),
> > > > > +     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
> > > > > +     * part of the PSR, so we need to handle it here.
> > > > > +     *
> > > > > +     * There are two things we need to have happen:
> > > > > +     * 1. regwptr points into regbase[] at the location determined by CWP.
> > > > > +     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
> > > > > +     *    in a copy at a temporary location at the end of the regbase[]
> > > > > +     *    array. For migration we only transferred the (nwindows * 16)
> > > > > +     *    entries of regbase[] that correspond to the "proper" locations
> > > > > +     *    of the registers, so now we must copy the wrap registers back to
> > > > > +     *    their temporary location.
> > > > > +     *
> > > > > +     * We achieve both of these by setting env->cwp to 0 and then calling
> > > > > +     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
> > > > > +     */
> > > > > +#if defined(TARGET_SPARC64)
> > > > > +    SPARCCPU *cpu = opaque;
> > > > > +    CPUSPARCState *env = &cpu->env;
> > > > > +    uint32_t cwp = env->cwp;
> > > > > +
> > > > > +    env->cwp = 0;
> > > > > +    cpu_set_cwp(env, cwp);
> > > > > +#endif
> > > > > +    return 0;
> > > > > +}
> > > > > +
> > > > >   /* 32-bit SPARC retains migration compatibility with older versions
> > > > >    * of QEMU; 64-bit SPARC has had a migration break since then, so the
> > > > >    * versions are different.
> > > > > @@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
> > > > >       .version_id = SPARC_VMSTATE_VER,
> > > > >       .minimum_version_id = SPARC_VMSTATE_VER,
> > > > >       .pre_save = cpu_pre_save,
> > > > > +    .post_load = cpu_post_load,
> > > > >       .fields = (const VMStateField[]) {
> > > > >           VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
> > > > >           VMSTATE_UINT32(env.nwindows, SPARCCPU),
> > > >
> > > > Nice analysis! I suspect the reason this doesn't always show up is because any
> > > > context switch (e.g. OpenBIOS, kernel to user, 32-bit to 64-bit etc.) will flush the
> > > > entire register window set to the stack, and hence reset env->cwp back to 0.
> > > >
> > > > It does instinctively feel odd that 32-bit and 64-bit aren't handled in the same way
> > > > - I wonder if this implicit behaviour on 32-bit somehow needs to be more explicit?
> > >
> > > I did wonder about that, but I preferred leaving the 32-bit handling
> > > the way it is -- trying to unify it with 64-bit would require making
> > > the get_psr() code path go out of its way to avoid updating the
> > > reg window data structures, which seems awkward and a bit unnecessary
> > > given the code does work. So I opted to describe the way the 32-bit
> > > targets do it in the cpu_post_load() comment, so at least we have
> > > a record of it.
> > >
> > > Are you OK with this patch as it stands, or would you like me to
> > > change it?

