Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AF6CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuNb-0002wr-3o; Thu, 07 May 2026 04:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuNZ-0002wS-8K
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:46:45 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuNX-0007QG-Kw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:46:44 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c7efdb7d8so558351d50.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778143602; cv=none;
 d=google.com; s=arc-20240605;
 b=D++xLKSAx1t5wlG5ymWrqmhMsKv8Pf/KDkp+bz8gO2HyEyfBh8jWtkqTLtqAWMFe+J
 nBOOW2rpODD4i1Z8/DtFrVW3ovDo/5gxeRpddghDhD3vlIHZ/nu5PbZQPf/qeZzASZns
 O+5xRv8kn+jV58bwFUb+doiHCNu1JgmxvFDPStBz2J1DWqBNbjhhxatASNKbIA5x/bBb
 KM+Skmf8sIxxx7SPlKFD8IhC15hbt15jkXg9ljTGdbvGJtha9sRJfS1m9JIzpu/NkgwS
 M8RWTppL7MqjjCRrTxKXOWT/P3zZ5NbPlyZIxXXbJcjG0a4GYRQEQO4WdkrzcSa4T59h
 VCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NuowibDaYz/E5UJzAi4YOhi3AeXL9KU2XALgMKVzdDo=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=CFFCkRIU+xv520lm/8xhYN67pGy7MxT7/ge2vG5s6Kl9Tg0fTAgmp1ZFnA5xJ2Ijvs
 xlgwDFq2u2ztXZ/WR6fj1BxfjGkul5KJ64UQrZgH6qhvx6kCTTwfIPgkcNIBHXRRUkSk
 MR9D3NfaTpn2l92FHi8jua/WOhypZe2O17pzpIZY+XxP33H3NIQgYMufLw1gvccII1Wp
 9nGNQ8dapExf0EG3x47yU+GioJT6NKBasH07+b0gd+vmMa+m4eSZFAYPeB57UN2chkcR
 PE8o38Q1wyMNP5iCevzEKJrMAPCX6bbB37QU5NoxH8XzGhHbgRyc7+R3XVDeScvlhvDW
 D1bg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778143602; x=1778748402; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NuowibDaYz/E5UJzAi4YOhi3AeXL9KU2XALgMKVzdDo=;
 b=X8pbPEsSdMZyGpwXNDXC0qRszmn48EdBdvm2sorxCCSrNiA6d8gaGQj00FlTslpWyW
 /NIhLlgxFfe7soTf68i0xrhOeKOb7LyLk5eTPmmFprJSmLjGrLy744e7Z4CgJOZ2S5T8
 QppHRrEEJloediyNUtrkWeYoWuERraugnavtADWsBg1Z/oxOjlh1kExj6ckUv56K31B+
 hPpXyVaf+CPO93HIvnH+Ta1V0iP5tWCm/ho3/exeHGNRaTaw2//U8sNXEI8kTou8Npmt
 GM/hSdWL4tVFINnMl7H3ePnzkypYIPKMlBsIVjsM3hIpdXQfxN5E1uCYNgyDnx9FGHgI
 q50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778143602; x=1778748402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuowibDaYz/E5UJzAi4YOhi3AeXL9KU2XALgMKVzdDo=;
 b=Cf2eY8MufjeqIkEsx0/bJjc5Gv0dlZ/ASA3hF+Vl0XMwRpgckF580WopkNJ/+rCFzi
 bNdgIUm9BiAbtyDqP/vNdf7IJQ/ZAV/EwgYIJ4wHBHkRrCvGg9DnbSTRVVXYbJnFPMVJ
 GM70uCt5dL/tLVAhwrgMThYqSBV2ZCY4yqZshEt8XH8PcwW17EGGo8ynBkXv0U1lPLTO
 pPZs2nDFmP9xJj20ZLV00/he3xjdZyXwgrHkthznl89j3m05Qvcdxvs4+6xXa+zqQmMI
 iLjK7VR6LrI6y/1iJ22DSq8TQ4B4Z07F9b//apESSOHQEpz1yWE2NJgUfH00cU4rnfFv
 1SRQ==
X-Gm-Message-State: AOJu0YwzO068MfAZM2gl/6VD0YQHJujwoVuGCFTV3R/LtKSwtyVDZxuy
 JFNtzO1H17XAri48FbLIl6ySsRgBqyP2t/thg7pk9YM39zrBb7B6sz8ix7dRbqYI9FSbMIZWoC+
 VkV2auRP76K600AkJdzhc7LVhadQFX8p4b3Jzfo8+1g==
X-Gm-Gg: AeBDieustICYVKGce9dwM2wlBCB68TYbn/mHj3WgJvOJszBJu8Pk/sepOP5pO4cfwBy
 c/mX8A5dtOAhpXSft7Px9TSCr0kU/p6tigbgC71y7yOZi3yGmNUBx7cftMn1bjy7ulokw5XuA/J
 FDGyBpBvFg7TVxtNvE1pFpBV4mJ4aHREjE92gqq9dfL0Knutd+LT0LgggNQVkw8V91vG5kx4k8r
 UwzQWRD9LrVvnT6TzS+dR2rqTO9TVDzSyYnPthcYrtI0yZbGqOsh0CE2jRtadV3wZNyIFADNXCz
 moTlmpAzyY/fhdJ9ymXu11DkniKlAdwq6Bxf0JfDj85zYYr2N1kkd9TzZRnfaQRcj3QFzVdBOFT
 FSmmq5LsdvH/EyFOJ81nrK60=
X-Received: by 2002:a53:e03c:0:b0:65c:2066:a99e with SMTP id
 956f58d0204a3-65c7999b07bmr5683162d50.33.1778143602420; Thu, 07 May 2026
 01:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260505103726.419195-1-peter.maydell@linaro.org>
 <2c23feac-abf7-4c55-b4b7-51b0dc1059ac@linaro.org>
In-Reply-To: <2c23feac-abf7-4c55-b4b7-51b0dc1059ac@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 09:46:28 +0100
X-Gm-Features: AVHnY4JhTn_qrcrPhA7XnR2Nl7fpBErDEUNPt4ba76A7-t2ss6pFUqsXjX5YbhE
Message-ID: <CAFEAcA9h6UcCXhMrJVibF-bTcKTvUnuCGicYVK9rCnoSmkCFyQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Report IL=0 for Thumb 16-bit BKPT insn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 6 May 2026 at 13:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/5/26 05:37, Peter Maydell wrote:
> > The Thumb BKPT insn is 16-bit, and the ESR_ELx syndrome register
> > definition requires that we set the IL bit to 0 for this, and 1 for
> > the 32-bit A32 and A64 BKPT/BRK.
> >
> > We used to do this correctly, but accidentally lost it in the
> > conversion to decodetree, because we converted the A32 BKPT first,
> > and then when we converted the T16 BKPT we forgot that trans_BKPT()
> > was unconditionally setting IL=1.
> >
> > Pass the right value for syn_aa32_bkpt()'s is_16bit argument.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3474
> > Fixes: 43f7e42c7d515f ("target/arm: Convert T16, Miscellaneous 16-bit instructions")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   target/arm/tcg/translate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> > index ce427c5a3c..7f76a57653 100644
> > --- a/target/arm/tcg/translate.c
> > +++ b/target/arm/tcg/translate.c
> > @@ -3580,7 +3580,7 @@ static bool trans_BKPT(DisasContext *s, arg_BKPT *a)
> >           (a->imm == 0xab)) {
> >           gen_exception_internal_insn(s, EXCP_SEMIHOST);
> >       } else {
> > -        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, false));
> > +        gen_exception_bkpt_insn(s, syn_aa32_bkpt(a->imm, s->thumb));
> >       }
> >       return true;
> >   }
>
> While correct, perhaps clearer to use curr_insn_len.

Ah, I didn't notice we had that; I'll use it. (I was following
the use of s->thumb in the syn_aa32_svc() call.)

-- PMM

