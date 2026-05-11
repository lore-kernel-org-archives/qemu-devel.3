Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51DDCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRtu-0005S2-TS; Mon, 11 May 2026 10:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRti-0005PV-2X
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:46:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRte-0001hA-TS
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:46:16 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67f94c078e8so2114775a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510769; cv=none;
 d=google.com; s=arc-20240605;
 b=hv8mrY1llmgnZOpjSs1tKa+yesA8n4A9+umybASH1V4vVWYGvY5wDaHpXwyy7VJEi2
 Rn3j1hQd8lE3K08CUoda6NE7zT+9Awq+Ubwxj+iguVaF78/BtD2T+ZgCW3S37PMYAq+D
 YK0ao73EJWIWo3+yk/0xpHqjQwbr3UnDKxQfDSZjq7naKamP67gUbb5DTw8SYW36r/t5
 KhDXoLKC4vd8/dS+rsxlZlfIay94rb+N0letoOkdvtFls1oJXaV6XwXOkDhFR3KECvwM
 5repJFLk/QFDo403Bidg2q40lI9jYc2vvzDwANQRobleOEX+Dt1gnUXaRkk9BpQLhaOe
 fHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bPq6g292dxMPpfdQvcDiTlDVkggHD/4oIZoEOkwGY7I=;
 fh=hHQwqgTY7ltwat616CldellfBTSzzr31raK2NubcdK0=;
 b=frGFtYs30hLk64K8kHFtnKDrUYTSBbuuhvokigECRg8QiUew8qy7Obbjq21HUk1dkB
 5IWrGbT6k/QsXAVvRzKijBZ90CRv9yrDC982U9VOP9hMLedYst0VTAHtk4FrkOGU7sEg
 d8bdVAqN8Ls6pi3KU6H+4Bo5DBURyhFGsOWaN7eeNEaycr1TcAVflR699MNR/Y+3JElk
 tipiZjbNB20S2KtgJKehoYdLe33AHXkLNGxxgT2WxROAQ8f3gL+D1WX0WXQcDHJGu8UZ
 yMR17RBop5VU8FMUzjZjP7KmjZZ/bEi3IB1YYYbGe6plBtv1UwNwp6DV2W2c8w4Yu7wJ
 exHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778510769; x=1779115569; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bPq6g292dxMPpfdQvcDiTlDVkggHD/4oIZoEOkwGY7I=;
 b=i5EHjw5BUJhgphWKuJ5sVJdKz+b3TI51jj/C+H08mtL+P6S4zfw8+JAuccAjGmUTR5
 YoaIyMfD6BYcsUGEsug6ds9iiv+j/YgjyA6zMWXqi+zHZnu98oJRMx8GHhg8tAIoVVgf
 YDp96oexUorcU2+Inzp1xd7eABeeUh0pHDb7RZIzHc8p7QvUToUia9MKhiOMIYv7Bwz1
 fv278s1Ft2iZhwCIIcM8BK35nEsLcO6Mrqa4arflzLZ/uf1bbm7KyuxfFAOqIEQex0Hb
 B3lV63f/2+28ZDBdpSKzakBFzYcGLZsQmtcmeKkjYghZ4wASXRj/veoPyuNa+z4T2E2g
 nzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778510769; x=1779115569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPq6g292dxMPpfdQvcDiTlDVkggHD/4oIZoEOkwGY7I=;
 b=BWI655lEWXD18z1RQC84fHaEIPxO84waxFie/TDOMnheClNn2twqAnbsbVdhX9Ro4V
 Gl6itxGYfTF6i7gvgECzyD3oT61vqMYEObt94B3xKvEpyo6/I2YCEbZQFvSGPSCqRbRz
 pDr9uy+bSqBVnpdBX91fSirmgrKIokGtdcDX/DiyBo0TfZD3I93z1SAruiXHD916J5RE
 Syoa1/50v1Dax0/IV4Y5XNaaQqYsGSpCzWHrf2eDa/KPnMOPzmSUGGSXGB1s6BvrLIZ2
 uf4X2GvDbMzj0wqj88BFJvJ32eePD6/9pM8wooMj8NtlkCp3eAt7Yc69wnF39RfrlYG0
 8p6A==
X-Gm-Message-State: AOJu0Yz6u+tYW7tvskAds89ONg8A4j/MLGKImzkXIXJVirUfiJcEa/Df
 ja7Aiyyc5LLmnbZIW7Qzevdu+YbF/w8/LKAbSXCbHRI1UkwfHmKL/uOdBQw7lDcQ9ohdihdRnVi
 z0eCisxdX4BfKsGUFSIaEPXvTNUQgEdvVjNe6zDGNXA==
X-Gm-Gg: Acq92OFeXChwbUv+toBG81afoDxbC756Qy2sMIntwtKelpRsVdj9ByyMb8H6HjhLXRd
 g+dMODiVPJuUnAKTvzUninx7O03K8MpuNfr1+LJUow02qozfm5s0igd9s5pvr8mm5N+FZbFg4Kx
 lKEDR/A35BdGKpjwlRnwhbCBKN81KYtBhey5ktYG404Z9xzFq+GItZ8jfhKjQ1ryFdSrWxD9oCE
 XOsC2UtT99iznFnvvp2HTQ7FGHztcPs4y0ICGDN44jfV6Jx5Uo4IqZf+Xp2lSIvOYNdoUG667OP
 7McE3kWjz7zMod86i6yj7eMsSxGftwa+TodapZr06dfNS8gsatBldOfppWa86yTO/NeTMScDUNJ
 vYPHclAT9AqOt
X-Received: by 2002:a05:6402:3137:b0:67c:4e1b:9134 with SMTP id
 4fb4d7f45d1cf-67d642c320fmr8920391a12.14.1778510768644; Mon, 11 May 2026
 07:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
 <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
 <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
In-Reply-To: <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:45:55 +0100
X-Gm-Features: AVHnY4Kqq4AjYGd4m-ukpplMfGFLKJiM-sJupnkgWnpkR6NJD_j3h1fBChtWiWI
Message-ID: <CAFEAcA_boBOkNAaUgX=QEQvm3Mgy2ewkSNtx8zR9e=P58aWmmQ@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

Ping^2. I think this is now the only remaining blocker to being
able to do a full sanitizer test run. I'm happy to throw it into
my target-arm queue if you don't have any other sparc patches you
need to send, but I think it would be better if it had a
reviewed-by tag first :-)

-- PMM

On Thu, 30 Apr 2026 at 14:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping ? Now we're in the 11.1 cycle it would be nice to get these
> remaining sanitizer errors fixed so we can maybe get a CI job
> to test a sanitizer build.
>
> thanks
> -- PMM
>
> On Fri, 20 Mar 2026 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Mon, 16 Mar 2026 at 21:42, Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> > >
> > > On 13/03/2026 17:09, Peter Maydell wrote:
> > >
> > > > In the SPARC CPU state, env->regwptr points into the env->regbase
> > > > array at wherever the architectural CWP (current window pointer) says
> > > > we are in the register windows.  We don't migrate this directly,
> > > > since it's a host pointer, so we must ensure it is set up again
> > > > after migration load.
> > > >
> > > > We also have to deal with a special case when CWP is (nwindows - 1).
> > > > In this case, while running we keep the "in" register data for this
> > > > window in a temporary location at the end of the regbase[] array, so
> > > > that generated code doesn't have to special case this "wrap around"
> > > > case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> > > > wrapped data from its temporary location into the architectural
> > > > location in window 0's "out" registers.  We then migrate only
> > > > (nwindows * 16) entries in the regbase[] array.  So on the
> > > > destination we need to copy the "in" register data back to its
> > > > temporary location again.
> > > >
> > > > For 32-bit SPARC we get this right, because the CWP is in the PSR.
> > > > The get_psr() function does:
> > > >      env->cwp = 0;
> > > >      cpu_put_psr_raw(env, val);
> > > > which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> > > > sets up both regwptr and the wrapped-register data.
> > > >
> > > > However, for 64-bit SPARC the CWP is not in the PSR, and
> > > > cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> > > > register state in a corrupted state, and the guest will likely crash
> > > > on the destination if it didn't happen to be executing with CWP == 0.
> > > >
> > > > Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
> > > > for the 64-bit case, and enough commentary to explain what is going
> > > > on.
> > > >
> > > > Cc: qemu-stable@nongnu.org
> > > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > > ---
> > > > I ran into this because the "sparc64-migration" functional test seems
> > > > to hit this reliably when built with the address sanitizer.  This is
> > > > probably a timing thing, because it doesn't trip any ASAN failures,
> > > > the guest just crashes on the destination side most of the time
> > > > because it returns from a subroutine to a corrupt %o7 return address.
> > > >
> > > > As far as I can tell this is what the problem is, but I'm a bit
> > > > surprised that we have never hit this, given how likely you are to
> > > > hit it on a vmsave/vmload or migration.  So am I missing something?
> > > > ---
> > > >   target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
> > > >   1 file changed, 39 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> > > > index 4dd75aff74..b935c31630 100644
> > > > --- a/target/sparc/machine.c
> > > > +++ b/target/sparc/machine.c
> > > > @@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
> > > >       SPARCCPU *cpu = opaque;
> > > >       CPUSPARCState *env = &cpu->env;
> > > >
> > > > -    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
> > > > -     * window as the outs of the first window
> > > > +    /*
> > > > +     * If env->cwp == env->nwindows - 1, this will set the ins of the last
> > > > +     * window as the outs of the first window. We do this because we only
> > > > +     * transfer the (nwindows * 16) entries of regbase[] that correspond
> > > > +     * to the "proper" locations of the registers; this call has the
> > > > +     * effect of copying the wrap register values from their temporary
> > > > +     * location down to their proper location ready for migration.
> > > >        */
> > > >       cpu_set_cwp(env, env->cwp);
> > > >
> > > >       return 0;
> > > >   }
> > > >
> > > > +static int cpu_post_load(void *opaque, int version_id)
> > > > +{
> > > > +    /*
> > > > +     * For 32-bit SPARC we set the register window data structures
> > > > +     * up again correctly when get_psr() called cpu_put_psr_raw(),
> > > > +     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
> > > > +     * part of the PSR, so we need to handle it here.
> > > > +     *
> > > > +     * There are two things we need to have happen:
> > > > +     * 1. regwptr points into regbase[] at the location determined by CWP.
> > > > +     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
> > > > +     *    in a copy at a temporary location at the end of the regbase[]
> > > > +     *    array. For migration we only transferred the (nwindows * 16)
> > > > +     *    entries of regbase[] that correspond to the "proper" locations
> > > > +     *    of the registers, so now we must copy the wrap registers back to
> > > > +     *    their temporary location.
> > > > +     *
> > > > +     * We achieve both of these by setting env->cwp to 0 and then calling
> > > > +     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
> > > > +     */
> > > > +#if defined(TARGET_SPARC64)
> > > > +    SPARCCPU *cpu = opaque;
> > > > +    CPUSPARCState *env = &cpu->env;
> > > > +    uint32_t cwp = env->cwp;
> > > > +
> > > > +    env->cwp = 0;
> > > > +    cpu_set_cwp(env, cwp);
> > > > +#endif
> > > > +    return 0;
> > > > +}
> > > > +
> > > >   /* 32-bit SPARC retains migration compatibility with older versions
> > > >    * of QEMU; 64-bit SPARC has had a migration break since then, so the
> > > >    * versions are different.
> > > > @@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
> > > >       .version_id = SPARC_VMSTATE_VER,
> > > >       .minimum_version_id = SPARC_VMSTATE_VER,
> > > >       .pre_save = cpu_pre_save,
> > > > +    .post_load = cpu_post_load,
> > > >       .fields = (const VMStateField[]) {
> > > >           VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
> > > >           VMSTATE_UINT32(env.nwindows, SPARCCPU),
> > >
> > > Nice analysis! I suspect the reason this doesn't always show up is because any
> > > context switch (e.g. OpenBIOS, kernel to user, 32-bit to 64-bit etc.) will flush the
> > > entire register window set to the stack, and hence reset env->cwp back to 0.
> > >
> > > It does instinctively feel odd that 32-bit and 64-bit aren't handled in the same way
> > > - I wonder if this implicit behaviour on 32-bit somehow needs to be more explicit?
> >
> > I did wonder about that, but I preferred leaving the 32-bit handling
> > the way it is -- trying to unify it with 64-bit would require making
> > the get_psr() code path go out of its way to avoid updating the
> > reg window data structures, which seems awkward and a bit unnecessary
> > given the code does work. So I opted to describe the way the 32-bit
> > targets do it in the cpu_post_load() comment, so at least we have
> > a record of it.
> >
> > Are you OK with this patch as it stands, or would you like me to
> > change it?

