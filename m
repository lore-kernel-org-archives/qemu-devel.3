Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2071FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00Kp-0004GP-Tg; Tue, 10 Mar 2026 12:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00Kl-0004Fx-V4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:53:28 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w00Ki-0004UY-Jn
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:53:27 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b96e9c59339so463171266b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773161603; cv=none;
 d=google.com; s=arc-20240605;
 b=dlUf8kt0NP9H8wlaxggF3/HwmO7b0t0f6rKUsOEBs/jVHN+G9BuEXAnFeILV/6q7sP
 U2QJQwJfA/OwzBfyriRooxrNIlvheaGojA2f7KpJFhNz6WQwJCi7esE1l3qtKt7YE8Ji
 mKNQc5pot5m6abvltHo3K11jw4QzpJlOygRNV9cPWZrdjKxFUwpV1OaqbM8AMz788GBZ
 mMSuBy6ovSS8i44ywK/6KkB0AW9ONWXAKscfM8vd8RbzlM3RBfwANOspmTQwLOwQuYRy
 lJwuy45/oDgV+efr+Tv3dK6GKV7Uqr9nZFUxipvnvT5hwQFek3s9epjABZ7VknWuB01q
 id4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OucPCdHK4onxE3uCRwVBvRy1iNOvvWI1LWD86E5XmPc=;
 fh=2+ROL61GaolZp+du6n9ufjYYdS54csK0eB12Ik9P49M=;
 b=gWlbfuoDHJ5oY/UcwF3isTxMKLpTUo/T+XVvx2b0ogAdl2pIlATHdcxKkmFu5xo84O
 qGBxGf6yVhZpgUoyCSWxnR+rhTrkqT13Jtclis6jwkDGRJp6NZZhOSSB16qdtskFV0WM
 dy515tJY0SHI3wBa2CinSDfjDbr/mKRLk9x0g1B6/DrxtMOKassAv8RGvijyAp5lilZA
 SdEYMvPvTmdOVzE/Tnliilh1UTUIWI8fgHhW/ooCSt+ElMU4t8A8Q0BTcJtIOLszr/qG
 NF31vLzwfem4funnAeYdeq2bs+0SJxHzkRbxnd9NIdXUs1bLEpsM88Dc0HJDcmN7Dq7N
 8hXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773161603; x=1773766403; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OucPCdHK4onxE3uCRwVBvRy1iNOvvWI1LWD86E5XmPc=;
 b=TU9KAKdQlpGzChMg4d3utqeTa50slTuOJ0cMaq8G4ceXMADpkOI+sUTkpPXIzYj+we
 8OMN69I6+XuIUlMZ5PkXlAPnk2rsQ14t9bURcGBIvq2EX7oM3NzMpzYaUA0o65ijary3
 rzvq+yLSPuHy36UJG9GmJIPmBU58QEyBJuquEi76q4f+EZu7TCkrNabOCfl/vQ1vGqXH
 l2HphZB0q7ak6nyRc/sV97QQuZ+UHLRK0wiRQHeNsGgcgKYjHEUFoaPTjNXCxfiVYzb3
 ZTPOf3gYAx37AZBMY/Ms10vf3MA1cc4g/PmRkn69hQJQgcyA/zUqIQGzATtSdHZS9DTZ
 +wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773161603; x=1773766403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OucPCdHK4onxE3uCRwVBvRy1iNOvvWI1LWD86E5XmPc=;
 b=p0+puWCMoJZ01B9899z8Xjx7vJwhy3BkpTMctCplBM05dFiA/FetcW6OtPeX2MQ6f0
 GwpJ8SaQSyEkS407+hSmZov/L7+Ift6HLj21mxjCTZkffxreM9DMbVxN0aI1IWr7qMTt
 8YKWvY/42v4T+DZ7ZMdRonPrEXpmAYus2gCRetYii31gC0O0e4yexTXbX0FMQjUL9/lv
 KOuYKAbKueg5PXedStENdrH+t0doUzBFLaz2F/wUlKArbeX8kkp31KeUNvhXbTzXcg2V
 Vkd4OVEZKMkRIInGIGLbXFeJUy2LTBnQdLszrpMDvkVZSu8tiYgYG8f//Hpc9GMaDH3D
 g+cw==
X-Gm-Message-State: AOJu0YxuKl3ez6iHbrVh4xpoVWc4bG5ZrgrR/AtQ9SyChvTt5gLEOGOU
 /PJowcivItw18DIn0BW0QbOnnSPYo2zGqyyoMomfeGBI/pOEFpePZquILpwky21nOqoEokoFvRS
 imCdr/M/Jd1d0tiiYYKph/OeEfnrAHSOfqbGl4GR4vg==
X-Gm-Gg: ATEYQzw4GvfMRWDnzyCMNsjvnZNh2AUsVLIt+jpeqU8S59lFuHW/4wbZWrOJKgQgQnk
 9yHUf5WBGwmCk423wreueQ8sWMaYnUpjJRaXZBTgGsb8sYmCeWmRefxpZZf3Lu7Hbsyhg3SWwP9
 y+0VWPdt+QD16GORmvcPQQxJVl+djjJykq7XlgJ+YHgtZTn7TpRD2+isCzebkZhbl7tE8UhpwiA
 re8UnB3Qvy2N6jZtvDtuqWQGZcZN/aGAlTtlRnMH38LjK9cKpasM/LTAR3X3RcEC2qiCImgFZBA
 iGnqlomYvMf6j1Z4Pe4QBn5fXra3k6SazFzg5xE0ILce1ZXS/xqOEwI/REz2wMCtUpc=
X-Received: by 2002:a17:906:209a:b0:b97:1db4:e59d with SMTP id
 a640c23a62f3a-b971db505bdmr91047266b.1.1773161602747; Tue, 10 Mar 2026
 09:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260309185752.76865-1-pbonzini@redhat.com>
 <20260309185752.76865-7-pbonzini@redhat.com>
In-Reply-To: <20260309185752.76865-7-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 16:53:09 +0000
X-Gm-Features: AaiRm51487PF4CsY4WgubzWJlWGPJQptRRXtuYHg0gGFSVg22L68lSJj6rqwDhc
Message-ID: <CAFEAcA_VjvAigGT0vEZ+fQyqnRMN0oZS77fhfRy6bG-ehmcEjA@mail.gmail.com>
Subject: Re: [PULL 06/10] target/i386: emulate: LA57 fix
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Mon, 9 Mar 2026 at 18:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> Seen on a Sapphire Rapids box with LA57.
>
> The top level of the pte array is taken for CR3, so there was
> one entry too little for 5-level paging.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Link: https://lore.kernel.org/r/20260307181856.2209-6-mohamed@unpredictable.fr
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/emulate/x86_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> index 8261ca16351..4e39bae025e 100644
> --- a/target/i386/emulate/x86_mmu.c
> +++ b/target/i386/emulate/x86_mmu.c
> @@ -56,7 +56,7 @@ static bool is_user(CPUState *cpu)
>  struct gpt_translation {
>      target_ulong  gva;
>      uint64_t gpa;
> -    uint64_t pte[5];
> +    uint64_t pte[6];
>  };

Also detected by Coverity (CID 1645466, 1645468).

-- PMM

