Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B355FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGQ-00043a-LV; Thu, 30 Apr 2026 10:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIR2P-0006oE-62
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:02:41 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIR2M-0004A5-Hk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:02:40 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so671095d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554157; cv=none;
 d=google.com; s=arc-20240605;
 b=LiGTnNNUsdzIS2SRLZEMpfNZTUH10ENFLiqkmOjGxzjdft45YOBuCe1e0UJgksf+Kx
 rLVBTqJSGIPcgY+f4JeY6ETWGKMjCpT8d1516mpWubKwap2N4HaLqlgr2Wal4ZHpCWAV
 hFKPhr1gVQR+TZxqGfyPer+YCqwK1D5mK0ZIznEgx7L56lwO7NDah+kZJy//Lc9UQZzl
 gXcRNLE1uZ1YnEhCgvXLyi8DHNZu+t2IIGmsoNeiAarq9y+JYODYMUU0NcEncnvHjvKs
 iu1f8/5mJ6ch+VO2higu/0rkSqy09oshtDANIPymhLr8WkLlDFI/MgvDNQPHcPJQMQDs
 eL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AfbNeZ46DpVJJ0z6NgJouJu2HGCX8AKmImOqv3PMdlQ=;
 fh=hHQwqgTY7ltwat616CldellfBTSzzr31raK2NubcdK0=;
 b=K0XwOC7kHNNO2olk5rljwj6W0rTSvoitvtv1M7iDLOesbJ66pejYcqmMYbvZsNRdhP
 9uRLJLneySJONd2EyMah22IgiqJBHZkNFSogldr4D574He1VMIUl/u8DzL6+gWo1OqCm
 bpnfi+b2rtGPsHsdX7vY2f9vDil7grBItPy9isJnpUF6NZc86Hv1TbPaH2jjl6Cpm7J5
 cOxtYn/LZmE3+VZGpjihmytk+SJOLc9DJvJI6ZPgNAIHkVZ53PTDMo6pouEmtXhiNB96
 d9z5M7GuOiokp7hr/dvmu0uo9xnasVXkidpylb72TGDgT9yc5nyEXL9QWWmof7IHcoyl
 uyKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777554157; x=1778158957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AfbNeZ46DpVJJ0z6NgJouJu2HGCX8AKmImOqv3PMdlQ=;
 b=Yc7MMwgdoz7N6o2Ke1A/Hh1UahKhJsbcNoVunXX0sMtoRMbCwXTosNwRG9BAdP7emA
 aJFr0lDKGqJHTPdCYjz5QneGS67Zvl4BwD17Qr17V2Mk+pV8+djrz8VrQiz9RwfYKk9W
 JOtV1bPbPiZvVYq+ZO+n2Iq7Isdk/bUC74WGrnwM+DylPXsgd2iETwHDw5CDe4NGPlkE
 RJjlpem/BP82apH9xLnLFYkhOLCgKEn7/zO8m1sYqFsquy1/rO+6cgcAjThxtYA37EyJ
 2MA3+fDPOF+D2HFTUQpRH0MMXKyqZFHbBfO4XzgXI6uPTFparDCs4A/YwaSU3GMBOwkE
 F6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777554157; x=1778158957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfbNeZ46DpVJJ0z6NgJouJu2HGCX8AKmImOqv3PMdlQ=;
 b=SgcfvIposlrDEGMSS9tqD4JHxldBaUfxzg43RTfcW+SSNYabbOiKBmZ2P7jmDEanJb
 h0F02uqk1Z5j7LIBQ75TUwc92J6Smc4+aqOluLsH1e1DTXNbY3/IHl8cu6sUDQGZAiKC
 WwdtjMwqkVRXZ77IkGwVcrWCtnvaufQQ4HBJxUMbR1NKsjk9vBdNND4ge8nyrMgB6uAY
 aymAP/b04ges6hTZ42dDZ4O4qig86Wpv/ofJF6pUhPbCecR1Dx1MU+tLVWWBbAt+VFKw
 6sHvdwPtejCTrFN1rKYzY09Q9hgdaPCU2MAMg3mMM/bm0KuB1GFoL/fYmt+AcAmE6hBP
 oFmA==
X-Gm-Message-State: AOJu0YwGv/Tlc/PXKgl534oVXPZvfTfvX6YixMF67qhvcYe42Ymj9g+e
 uDwSz32PjMVmJ4/j+UvweaJSegMKuDHOGvI/3KTm+M2wJIeW1xgAvbigtS5KkR0IRrKBLPbBoFU
 zFUPcbPIYdgAojd1TOr5tpWCOApUhM89z9Yiv75ig+w==
X-Gm-Gg: AeBDievyZIKXPnMENhOV4Rt4Mc4FwvCpjgGLfGE5Vz0PM2iAnDYzd3Qwev78jSISk2j
 4F0eEAkixtFH8On8mPDkVI7NdeSYG/QHFjX8f9N38DO637mG0eXhMAr1QBojaOCHb9yC40LhkQK
 4r1mKmD/IzFN0XM8ktk4Z+Fxh6Zwg/EZQtUwxrTuP7XZT8RmucykR2NVZQ3nTLLlWOW5uBrbj+0
 g/mKDHu9QV7mT4koNgQpqLtUDZmumDGqSSgHeaIbDKJfFxDzVwLVYX7up2tEVfHL63gHWF8htrt
 bg/0mx+M7CNu4sFxZ2aAseQeJj1E6HUtrDdkz6OdIu7wlvJNj9t2Ax3KZT80/L7PCg22bKV8puQ
 SS8S21+2TZ6gy
X-Received: by 2002:a05:690e:120b:b0:651:cc9c:af0a with SMTP id
 956f58d0204a3-65c18b4d2dcmr1935210d50.15.1777554156600; Thu, 30 Apr 2026
 06:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260313170938.449538-1-peter.maydell@linaro.org>
 <48fdece2-5b98-4785-9b47-9eb2528803e2@ilande.co.uk>
 <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
In-Reply-To: <CAFEAcA_zf5joZKeiU=c5qP+PzbkrPEVOBZ0nMrOhidiywi_s8w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:02:23 +0100
X-Gm-Features: AVHnY4LvuS9AHENUl7bUhr_nCSbNsqhLbMoqgAQBKwFviE1V5wxcbKE0tFdqCkQ
Message-ID: <CAFEAcA-MQ8tObH=9j-O-bqfGMLc2oTwaM1xEzv__GU2qrncmgw@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Set reg window data structures currently
 after vmstate load
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

Ping ? Now we're in the 11.1 cycle it would be nice to get these
remaining sanitizer errors fixed so we can maybe get a CI job
to test a sanitizer build.

thanks
-- PMM

On Fri, 20 Mar 2026 at 11:02, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 16 Mar 2026 at 21:42, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
> >
> > On 13/03/2026 17:09, Peter Maydell wrote:
> >
> > > In the SPARC CPU state, env->regwptr points into the env->regbase
> > > array at wherever the architectural CWP (current window pointer) says
> > > we are in the register windows.  We don't migrate this directly,
> > > since it's a host pointer, so we must ensure it is set up again
> > > after migration load.
> > >
> > > We also have to deal with a special case when CWP is (nwindows - 1).
> > > In this case, while running we keep the "in" register data for this
> > > window in a temporary location at the end of the regbase[] array, so
> > > that generated code doesn't have to special case this "wrap around"
> > > case.  In cpu_pre_save() we call cpu_set_cwp() to force a copy of the
> > > wrapped data from its temporary location into the architectural
> > > location in window 0's "out" registers.  We then migrate only
> > > (nwindows * 16) entries in the regbase[] array.  So on the
> > > destination we need to copy the "in" register data back to its
> > > temporary location again.
> > >
> > > For 32-bit SPARC we get this right, because the CWP is in the PSR.
> > > The get_psr() function does:
> > >      env->cwp = 0;
> > >      cpu_put_psr_raw(env, val);
> > > which causes cpu_put_psr_raw() to call cpu_set_cwp() in a way that
> > > sets up both regwptr and the wrapped-register data.
> > >
> > > However, for 64-bit SPARC the CWP is not in the PSR, and
> > > cpu_put_psr_raw() will not call cpu_set_cwp().  This leaves the guest
> > > register state in a corrupted state, and the guest will likely crash
> > > on the destination if it didn't happen to be executing with CWP == 0.
> > >
> > > Fix this by adding a cpu_post_load hook which does the cpu_set_cwp()
> > > for the 64-bit case, and enough commentary to explain what is going
> > > on.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > I ran into this because the "sparc64-migration" functional test seems
> > > to hit this reliably when built with the address sanitizer.  This is
> > > probably a timing thing, because it doesn't trip any ASAN failures,
> > > the guest just crashes on the destination side most of the time
> > > because it returns from a subroutine to a corrupt %o7 return address.
> > >
> > > As far as I can tell this is what the problem is, but I'm a bit
> > > surprised that we have never hit this, given how likely you are to
> > > hit it on a vmsave/vmload or migration.  So am I missing something?
> > > ---
> > >   target/sparc/machine.c | 41 +++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 39 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> > > index 4dd75aff74..b935c31630 100644
> > > --- a/target/sparc/machine.c
> > > +++ b/target/sparc/machine.c
> > > @@ -167,14 +167,50 @@ static int cpu_pre_save(void *opaque)
> > >       SPARCCPU *cpu = opaque;
> > >       CPUSPARCState *env = &cpu->env;
> > >
> > > -    /* if env->cwp == env->nwindows - 1, this will set the ins of the last
> > > -     * window as the outs of the first window
> > > +    /*
> > > +     * If env->cwp == env->nwindows - 1, this will set the ins of the last
> > > +     * window as the outs of the first window. We do this because we only
> > > +     * transfer the (nwindows * 16) entries of regbase[] that correspond
> > > +     * to the "proper" locations of the registers; this call has the
> > > +     * effect of copying the wrap register values from their temporary
> > > +     * location down to their proper location ready for migration.
> > >        */
> > >       cpu_set_cwp(env, env->cwp);
> > >
> > >       return 0;
> > >   }
> > >
> > > +static int cpu_post_load(void *opaque, int version_id)
> > > +{
> > > +    /*
> > > +     * For 32-bit SPARC we set the register window data structures
> > > +     * up again correctly when get_psr() called cpu_put_psr_raw(),
> > > +     * which calls cpu_set_cwp(). But for 64-bit SPARC the CWP isn't
> > > +     * part of the PSR, so we need to handle it here.
> > > +     *
> > > +     * There are two things we need to have happen:
> > > +     * 1. regwptr points into regbase[] at the location determined by CWP.
> > > +     * 2. If CWP is (nwindows - 1) then we keep the "in" regs of this window
> > > +     *    in a copy at a temporary location at the end of the regbase[]
> > > +     *    array. For migration we only transferred the (nwindows * 16)
> > > +     *    entries of regbase[] that correspond to the "proper" locations
> > > +     *    of the registers, so now we must copy the wrap registers back to
> > > +     *    their temporary location.
> > > +     *
> > > +     * We achieve both of these by setting env->cwp to 0 and then calling
> > > +     * cpu_set_cwp(). This is the same thing get_psr() does for 32-bit.
> > > +     */
> > > +#if defined(TARGET_SPARC64)
> > > +    SPARCCPU *cpu = opaque;
> > > +    CPUSPARCState *env = &cpu->env;
> > > +    uint32_t cwp = env->cwp;
> > > +
> > > +    env->cwp = 0;
> > > +    cpu_set_cwp(env, cwp);
> > > +#endif
> > > +    return 0;
> > > +}
> > > +
> > >   /* 32-bit SPARC retains migration compatibility with older versions
> > >    * of QEMU; 64-bit SPARC has had a migration break since then, so the
> > >    * versions are different.
> > > @@ -190,6 +226,7 @@ const VMStateDescription vmstate_sparc_cpu = {
> > >       .version_id = SPARC_VMSTATE_VER,
> > >       .minimum_version_id = SPARC_VMSTATE_VER,
> > >       .pre_save = cpu_pre_save,
> > > +    .post_load = cpu_post_load,
> > >       .fields = (const VMStateField[]) {
> > >           VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
> > >           VMSTATE_UINT32(env.nwindows, SPARCCPU),
> >
> > Nice analysis! I suspect the reason this doesn't always show up is because any
> > context switch (e.g. OpenBIOS, kernel to user, 32-bit to 64-bit etc.) will flush the
> > entire register window set to the stack, and hence reset env->cwp back to 0.
> >
> > It does instinctively feel odd that 32-bit and 64-bit aren't handled in the same way
> > - I wonder if this implicit behaviour on 32-bit somehow needs to be more explicit?
>
> I did wonder about that, but I preferred leaving the 32-bit handling
> the way it is -- trying to unify it with 64-bit would require making
> the get_psr() code path go out of its way to avoid updating the
> reg window data structures, which seems awkward and a bit unnecessary
> given the code does work. So I opted to describe the way the 32-bit
> targets do it in the cpu_post_load() comment, so at least we have
> a record of it.
>
> Are you OK with this patch as it stands, or would you like me to
> change it?

