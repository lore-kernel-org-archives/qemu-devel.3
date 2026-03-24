Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4097EF54AB9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w51xi-0000h9-T3; Tue, 24 Mar 2026 09:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51xg-0000gf-NZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:38:24 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w51xe-00049X-OA
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:38:24 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso3223522d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 06:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774359500; cv=none;
 d=google.com; s=arc-20240605;
 b=gkVdV0uue0f6IUru8vOqUMYXbrJ3JGg+B7MD07WogdPWE9Z6HaP0Hm+q5YxptWj4Gp
 ZI5Z1+WE3GdydAIz+xkr0QbMAySyp/Vlm3OH01rJqnLbkF9kX/d7ftzL8jhgQnTPmXRb
 3Q6MWWVhjHZQ86f+3CwcNWABwjTInK4j66Y77ZNCYx24NkQppv20DOcq3w188sZJf0iV
 qKjgyH4aVm6brdlcQCNQRqxXYhUAI3UAMoGUVs04ydX/H9M8q0fMxwwYXpr36H3oEn8M
 CXjuIlrYFj52PJbhNWL8OAOz5HN2SIZv2rWE+gEXtNoIZEWBC2hzjNMhQlvGJAA6qETN
 IzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TPOzL2/PxgXplEfzLP4gJiOQHyowhZVV0LiuIEGPfxk=;
 fh=oF7acPCYJXtnkf90Y0LDbuP54lAfQrIKYg9nzrimFrU=;
 b=SLE/k12JNKsv5cZnbTpU0G+bc36s9Tre2Xt/eWj+2iaG00fwrnW6W38oiFo6tEuD86
 CdOoIO2pZUv1/GUI1LgHfsWjwArLHi4vSyZF2TBkhRR6rLqwQL9lJNiUHE+/I5uhNoa8
 R3Ef6mhPgcMk2VIr5hSFexLnvX5SuAsRiAXeJOJqjcESb6RzVD2kSAW9qWP3aQlo+l+O
 kCGkC+PAjql+RGj7acBnxAdj3aUu4YhmSh8LKHG2anlcYVYFNStY4cJvNLYb8Rpzo3ud
 u2+PY8YCxqlrObiKAZ/iURPolz2/IkftsmtTfYDlLr4RNCrMfbdo0wJUoK0ScsYKwft5
 gPQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774359500; x=1774964300; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TPOzL2/PxgXplEfzLP4gJiOQHyowhZVV0LiuIEGPfxk=;
 b=NNabnAgSN7+91VJ2m6Cf/HTC/MccxnwPPJcm23fbz4alk1K9RoZt6L9TtoZK0HrcGw
 /BgZ0uDUGvqy0zoyxAOPgQGlmybGL+M8cWwK2vYISxGbxq4iVKGc26n+UfmHeqUVCLWI
 U8NgIZEqc3hpDsS0bIMNpJDCgqS6fUMA9abpljMl7TT67Ue6xTD6/w/Wg0/OB2ZpNqCX
 Z6lwwX6UIy4IkCN/ItJ/WwxynSKTvDPyGqsZMQeBLU9vxDKB1mX+v6XeNtRyHZnIb3UR
 kWTjs3hiM3iBhCdo+2Gz8SXhx+9tPELU5yIhV4Z3CxaAImtE+6SSIzWeJKH0EXKTFuaF
 juug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774359500; x=1774964300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPOzL2/PxgXplEfzLP4gJiOQHyowhZVV0LiuIEGPfxk=;
 b=Hu/5MnyAOQodciOdMVPR9J7jkOVpLYyXjwIyHnGSTsgytSNrSLn9W7LQ/C2sQGFaFt
 VkR2HrWxwYfLhltToWDnyEnolH7JqtHpSrUfuGRTq/0zHTGYt0owf1x46oZQWTZf/6EA
 DBvsxEpl9lICfZgT8l3LXO1cyAfVPtitHFA3WLlJjUWevSE9hI7YZs4tE5H5vwtr/16g
 gJQ4xnA/D76SvD1pNnm2R6I/8yVcJcUIaDrXnmr6eCXqhLPNYWXB/MVsRh4rXh31ffr0
 DK6E4sCJKW0H2a0U26EJXtAy33Ep4/bn+sItUPh+OygUbOOcPsw3WX7+Um5PHVFM9WRy
 dhNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUQMMEuJnceAKCyWHgQB2LOI/ljXeC6PXcWT4BuYhGyZNvB3dBx8GfVAij1SIuh6/DB8N0wHhiDu2M@nongnu.org
X-Gm-Message-State: AOJu0Yy3oFlHSnOGOt5d/fRmsnK44MoRE9GVZwnAm/6kERQ7yb4on0pA
 32879ADeHN4E5WGKtQx5d0N9/bV5ddwvbslQLgb3a6pgWyMUy+SBrMC1LK4nub8zAqnR/AJkS8z
 ekrZx83R/wb2CGPm7sOhb6B3u1/+I7QM43S50uaxTBg==
X-Gm-Gg: ATEYQzzQKH6mbG6/K0+iG5/Z5V6M0UqpafxsBnMHX5BT4VRS+sihSAESANGKl/mmm6g
 Bm1+m7VsEWY7q6xsIxirB/qTiEg94RGP6pT+DpyKBbdGIm70eilIa3AJNlOVomD5qdbjTOXLrCC
 e5RqYxuAt+YJbjYhIyfYSmsxBZPK1DhBNrb3si0m5XwaNpq8dUIIagmhGmcx2OPTWGE4DrKUl2w
 +JTNarw4eNCShrQa+H6y3zC+CkzUMB1BkAyA54lMrBHr39EzDTU9SFfKLQWUah2HBs2OXvsJ1Vk
 0znV1cNNMuM/u4yGd5Ozxy01jpso8e/Yc3alBwnbJvRTSK/o7Ilosiz/su5ih96mE0pSdHTmfLk
 yEQ==
X-Received: by 2002:a0d:e705:0:b0:79a:c28b:b077 with SMTP id
 00721157ae682-79ac28bce8fmr29452717b3.37.1774359500050; Tue, 24 Mar 2026
 06:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260317122517.47627-1-zenghui.yu@linux.dev>
 <CAFEAcA9bGVuWXAPA0=EaAWXhSigm_yf5OYfnYoTjaQ8x1qXKYg@mail.gmail.com>
In-Reply-To: <CAFEAcA9bGVuWXAPA0=EaAWXhSigm_yf5OYfnYoTjaQ8x1qXKYg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 13:38:08 +0000
X-Gm-Features: AaiRm50FE7_OIbx50eS9N4iPq-PfmnGcL4qMWUg1G44_vZig7hi2R-ol00aaJQs
Message-ID: <CAFEAcA9sovFYwoF1Jk6sN7Aheh1WXj+imAVhJ7ifpvTu7PHuFg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Don't skip access flag fault for AccessType_AT
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 19 Mar 2026 at 17:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 17 Mar 2026 at 12:25, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > As per the pseudo code from DDI0487 M.a.a (on J1-16021) AArch64.S1Walk():
> >
> >   // Check descriptor AF bit
> >   elsif (descriptor<10> == '0' && walkparams.ha == '0' &&
> >           (!accdesc.acctype IN {AccessType_DC, AccessType_IC} ||
> >            boolean IMPLEMENTATION_DEFINED "Generate access flag fault on IC/DC operations")) then
> >       fault.statuscode = Fault_AccessFlag;
> >
> > an access flag fault should be generated for AccessType_AT, if the AF bit
> > is 0 and !param.ha.
>
> Did you find this by code inspection, or because it caused
> a guest to go wrong?
>
> We should probably
>
> Cc: qemu-stable@nongnu.org
>
> > Fixes: efebeec13d07 ("target/arm: Skip AF and DB updates for AccessType_AT")
> > Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> > ---
> >  target/arm/ptw.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 8b8dc09e72..572048d560 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -2118,6 +2118,12 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
> >      descaddr &= ~(hwaddr)(page_size - 1);
> >      descaddr |= (address & (page_size - 1));
> >
> > +    /* Check descriptor AF bit */
> > +    if (!(descriptor & (1 << 10)) && !param.ha) {
> > +        fi->type = ARMFault_AccessFlag;
> > +        goto do_fault;
> > +    }
> > +
> >      /*
> >       * For AccessType_AT, DB is not updated (AArch64.SetDirtyFlag),
> >       * and it is IMPLEMENTATION DEFINED whether AF is updated
> > @@ -2127,15 +2133,9 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
> >          /*
> >           * Access flag.
> >           * If HA is enabled, prepare to update the descriptor below.
> > -         * Otherwise, pass the access fault on to software.
> >           */
> > -        if (!(descriptor & (1 << 10))) {
> > -            if (param.ha) {
> > -                new_descriptor |= 1 << 10; /* AF */
> > -            } else {
> > -                fi->type = ARMFault_AccessFlag;
> > -                goto do_fault;
> > -            }
> > +        if (!(descriptor & (1 << 10)) && param.ha) {
> > +            new_descriptor |= 1 << 10; /* AF */
> >          }
>
> This is definitely correct behaviour for AT insns. The only
> thing I'm wondering about is what we should do for the
> ptw->in_debug == true case. Before commit efebeec13d07 we
> were checking !ptw->in_debug to skip both the testing and
> the updating of the access flag; now we will skip the update
> (definitely correct) but will fail debug accesses if the
> access flag is not set.
>
> There's an argument that if you're doing a debugger access
> it's not very helpful for it to not work just because the OS
> happens to have cleared the access flag on the page table entry
> (we also ignore permissions on debug accesses, though there
> are some code paths where we do enforce permissions, not
> really intentionally).
>
> On the other hand, we don't and I think have never suppressed
> AccessFlag faults for the get_phys_addr_v6 short-descriptor
> tables, so honouring them here too is at least consistent.

Having thought about this a little more, I think we should
continue to not raise the AccessFlag fault for in_debug = true:
it is what we've been doing previously for LPAE, at least, and
it is what intention of the debugger access codepath is.

Could you do a v2 of this patch that handles in_debug = true, please?

thanks
-- PMM

