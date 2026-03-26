Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FE1109E558
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5eDl-000484-1E; Thu, 26 Mar 2026 02:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5eDi-00047o-7d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:29:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5eDf-0001Ou-Ve
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:29:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a9296b3926so3639065ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774506566; x=1775111366; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dNRgSmqCrayQIjOm9DVicZTgSCAPajaWHfNuPxi6les=;
 b=VDZJhoFS5F8pI2+grnwwpELsZ/7cdefRAWDykAJ2mV/5p99ZTQJj5gAQtvv/JoH743
 ujmsv7++xt0/VE122pC3OwiSg44K/4SjvGYvA0LDZSywP+06vamHMIPBzQDNO1vPbj3x
 VPHNjofh6xNcgfpBObDLaNXPpEHEOcXbkWEM+hMljj1tOxaSBV2vc2CGtD867ex7U6va
 XVmm3McL1C2Ok4bWV4TTq/9icA8AVJ/fH4RYFkW0pXPa4i3cCj6mvkNzRLIWzidmsV9D
 2pGcdtA9eKjL0c1El6C2elEmwl5StesiFmv9pLBccV9A3+q46wc2opCPygluhpn7Dgvs
 9Pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774506566; x=1775111366;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNRgSmqCrayQIjOm9DVicZTgSCAPajaWHfNuPxi6les=;
 b=rmbUCMmIjW5pAa25vU/3WsAZkdbmfUPKC4Wpvu9fXQADpzFFP6z+WPr7PioFrRzoMk
 gAjD90RD0eTj78tR5FluINlH3bI0IsRCvac8PFb5xBMhK/17N5Fmxj/J7y+8Z/ZUaniU
 wqTdSxzP00Xo+eXMOxWvx7NmsIbZZBiP/ghdGr4X394RA5vxjFnNTPCxZdGv/ragwC+B
 XxP3/sgkHOtjmBR17rCDdrFSUpERzGzW1H+LT+WMBumDknAgG/MkJBo6Rdsr4CV0BVpj
 vfj0RtbJ1mM7bxlKdcHzoLBR+ea2voDegR7cDGa4nbd1YXsEkygQW36/TWlL1ZA0iGMU
 ecTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Z0x7t5Xt5jbKhh9C/F1CzMY1WiUMfbCrJrWgZf1QB+Lqh2nmzPZErKj6tbGJqiBT+yBjHEUnPpqY@nongnu.org
X-Gm-Message-State: AOJu0YzTNwOu+41KKPchfN4/g5drko75q51pORivycdAi7nB2m8YGG/A
 A8ELeVDJ1FxUoAv00R9z1/E7gBdAQAx9VJH4N0WbYTpGqFi8ZkSGs6Uw
X-Gm-Gg: ATEYQzw8g5P4Gxp+krc8JgwnAN6IneHpBnm8ZzELGu790nu5TwZaStyLt9br3XCVjxg
 NYSU44Yq45NHZ2AYBXOfMzXh2blr/HCWfy3lTiMuaKy8cws9Mg0U8v7YeRbErf2A6kRZ+JUZ4ED
 tx3cPV8vtFkuhGTRrbG9hs3CLH3n71JFc9fXMTeX7HfCuH7w49QYC6sMMNmHQMYH2GzbIbkXAN8
 tLTBU/SrD5oaS4VACASg7+1EIbpONW9gAUmpl14CkPy9BnxR4z7qrqS6Te1ydhC6CzS718BNhSE
 LTSSCuJUV8iiAAqTcxVnyr2WI/LWmSSGZ4lfbB/zv3g+nMgd5HEbTd8l+FlEuh99oP4fGh9xkBh
 mxXoALAWDOM6RPwBGVztpxYOdk/4KaqoSWhvpDmVUn/P9blI+z+rbi88KWTq3uPq3abx1v10Fvt
 5StwNhSNc523ZG3zH8vKxFUAgQdOZCTUS7j3ZelWxcJdyknvEhnFzqL+CIIyD6L3y6OTvJNIqA9
 U4=
X-Received: by 2002:a17:902:e784:b0:2b0:4eeb:f80a with SMTP id
 d9443c01a7336-2b0b0ab3a21mr72702405ad.29.1774506566469; 
 Wed, 25 Mar 2026 23:29:26 -0700 (PDT)
Received: from localhost (103.95.112.190.qld.leaptel.network. [103.95.112.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc917b5fsm18321605ad.84.2026.03.25.23.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:29:25 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:29:22 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-riscv@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Nicholas Joaquin <njoaquin@tenstorrent.com>, 
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix IALIGN check in misa write
Message-ID: <acTSDKzeEb3bbv08@lima-default>
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-2-npiggin@gmail.com>
 <acNQ3kVLEr92Kfjw@ZEVORN-PC.localdomain>
 <CAKmqyKPCzgZec1v79FfdRz3yA4zdY7C_k_qdPS8oMkSuo644HQ@mail.gmail.com>
 <acNYexbXVoMmUMPo@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acNYexbXVoMmUMPo@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 25, 2026 at 11:40:18AM +0800, Chao Liu wrote:
> On Wed, Mar 25, 2026 at 01:26:56PM +1000, Alistair Francis wrote:
> > On Wed, Mar 25, 2026 at 1:09 PM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> > >
> > > On Sun, Mar 22, 2026 at 12:45:52AM +1000, Nicholas Piggin wrote:
> > > > The instruction alignment check for the C extension was inverted.
> > > > The new value should be checked for C bit clear (thus increasing
> > > > IALIGN). If IALIGN is incompatible, then the write to misa should
> > > > be suppressed, not just ignoring the update to the C bit.
> > > >
> > > > From the ISA:
> > > >
> > > >   Writing misa may increase IALIGN, e.g., by disabling the "C"
> > > >   extension. If an instruction that would write misa increases IALIGN,
> > > >   and the subsequent instruction’s address is not IALIGN-bit aligned,
> > > >   the write to misa is suppressed, leaving misa unchanged.
> > > >
> > > > This was found with a verification test generator based on RiESCUE.
> > > >
> > > > Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> > > > Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > ---
> > > >  target/riscv/csr.c                        | 16 ++++-
> > > >  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
> > > >  tests/tcg/riscv64/misa-ialign.S           | 88 +++++++++++++++++++++++
> > > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > > >  create mode 100644 tests/tcg/riscv64/misa-ialign.S
> > > >
> > > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > > > index 5064483917..91421a2dd8 100644
> > > > --- a/target/riscv/csr.c
> > > > +++ b/target/riscv/csr.c
> > > > @@ -2129,9 +2129,19 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
> > > >      /* Mask extensions that are not supported by this hart */
> > > >      val &= env->misa_ext_mask;
> > > >
> > > > -    /* Suppress 'C' if next instruction is not aligned. */
> > > > -    if ((val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
> > > > -        val &= ~RVC;
> > > > +    /*
> > > > +     * misa writes that increase IALIGN beyond alignment of the next
> > > > +     * instruction cause the write to misa to be suppressed. Clearing
> > > > +     * "C" extension increases IALIGN.
> > > > +     */
> > > > +    if (!(val & RVC) && (get_next_pc(env, ra) & 3) != 0) {
> > > > +        /*
> > > > +         * If the next instruction is unaligned mod 4 then "C" must be
> > > > +         * set or this instruction could not be executing, so we know
> > > > +         * this is is clearing "C" (and not just keeping it clear).
> > > "this is is clearing" — double "is"
> > >
> > > > +         */
> > > > +        g_assert(env->misa_ext & RVC);
> > > > +        return RISCV_EXCP_NONE;
> > > write_misa() is also reachable via riscv_csrrw_debug()
> > > with ra=0, where get_next_pc() falls back to env->pc.
> > 
> > Ah good catch
> > 
> > > A debugger can set PC to a 2-byte-aligned address while C is
> > > already disabled, then write misa keeping C=0. This hits
> > > the condition and fires the g_assert.
> > 
> > I'm not convinced that that's necessarily bad, as that's an odd and
> > invalid thing to be writing. But we probably shouldn't assert
> > 
> > >
> > > The ISA spec language:
> > >
> > >     "if an instruction that would write misa..."
> > >
> > > does not cover debug writes, so the IALIGN suppression
> > > arguably should not apply in that case at all.
> > >
> > > We can:
> > >
> > >     if (ra && !(val & RVC)
> > >         && (get_next_pc(env, ra) & 3) != 0) {
> > >         g_assert(env->misa_ext & RVC);
> > >         return RISCV_EXCP_NONE;
> > >     }
> > 
> > Maybe it's best to change the `g_assert()` to a log GUEST_ERROR
> > instead. That way we flag that something fishy is going on, but don't
> > exit QEMU
> > 
> Agreed!
> 
> Replacing the g_assert() with qemu_log_mask(LOG_GUEST_ERROR, ...)
> sounds like the right balance — it still surfaces the anomaly for
> anyone debugging, without taking down QEMU over what is ultimately
> a debugger-induced corner case.
> 
> The IALIGN suppression logic itself is still correct for the normal
> execution path, so there's no reason to skip it entirely; just don't
> crash on the weird one.

Okay good feedback, thanks to you both. I agree, I'll make the changes
and resend.

Thanks,
Nick

