Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B59C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBaD-0007AD-Gw; Fri, 10 Jul 2026 09:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiBa7-00078f-Mj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:47:58 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiBa5-0000hq-On
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:47:55 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66666bad8beso1313167d50.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783691272; cv=none;
 d=google.com; s=arc-20260327;
 b=BRjFnM+REaD/MKTEeGXmIiGKrMdYQW8QvO4CCOrES7pcZ4+TtwS/HYyufuHA22c0Ok
 qS5UfkS0waGeT4hezSj44hLErwIS5ayh5TFIpR2tX308cYa0VYsuMZRi/JYcBqcJl8wI
 lM8JRksM4lmpee+4X0GjpZh6C8cp1VYNynjJakXsHxZMl5xP0L1Pv0aS7mISkOeJoxCL
 eTpeaM/EaWRgCVeNsERLw/HMTAl89CDwwkAbyyQOWXqHnuPB29AE0xqZLpUJvMVdrnqR
 Dwrnjevos/HgVL1EIS+FPMcvdqmsnr8+hpXt2kXtPp7khVjLbN0vRLv6OkMFxD41e2Ss
 5hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=noV3pNFHSvC73WlAIdd6Ur3Bp1y+Ncl85Yg+rP6ZOwU=;
 fh=OGCmJLUP0SDa9Ex01DM5bZ6kIElysIl2mTkIXt0Fcs0=;
 b=Ut7gwcp1W/6TNoxHrWdAHZ7XgJQ3hz5oU4uz9zD9jeCt0foHiEMHBdB42NhPc+3gLD
 brRSMAbXQAT4gkivsCxHDjrplJWN2DqGrO8RfR1HhjPMi8DOwpPMKRGHTAl/f59Hs7UE
 sUSubm29Jv3ED5D5q0uRwy5JSpxxBi59/w0IgrFsiMU+H0zq9iSWjY4COFbW13LbhwMR
 vBQndIBQAdj4RXrkRt5RO6bIXypbHx4jaUNZ0ZsdZbQcVfbtqq02sMTzjWpb54TkFntB
 X2RFJwuLYwusvwe5tUnzJz4cNK098MA7t3upu59156AX1Vndz6YN6Vk/uoCaGZDBm75H
 sAdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783691272; x=1784296072; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=noV3pNFHSvC73WlAIdd6Ur3Bp1y+Ncl85Yg+rP6ZOwU=;
 b=uSF7dwX+WULVqwevbS+eg2MhETrypPXkf1XHBLbEFVBVnABkQ0kjykDX/sMEKEftGj
 YuSZUG3L3yBzu0fQ2Ar3WJSI2J808OpCSXGTEiiGaBZX5fctM7gaJlbfCTIQh/Wja0Gc
 QjrAE/pvIDdVm3wKDELIOEhX3LCizaEYX+63d1isIu8kuS1r3GB4mo9bWe58uW5xz7eg
 qurmuYdavH1CyllQNgKO7alRz32etjqTFGQ3bYVuKGmNXwMl10eQFGxCz6lAH9QQEXnP
 k+awK+mD5I4I6Ojdq3ZA2D8srhVC/586Ru8LYqGsWW1NMIdUSToOSXf/hKdRGY7sEMfG
 4EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691272; x=1784296072;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=noV3pNFHSvC73WlAIdd6Ur3Bp1y+Ncl85Yg+rP6ZOwU=;
 b=iDV3JtXmJmSmNvgQYEyWfB8aEfhEx+OZJgVqV1/R5JiGU1hXtLFvEseKNg5Wp5KbmZ
 3PBegzJynu0ZOfbZ/rvAWCR9XGYLrQDE82UfnNi7zvzJy8fMrvxgd7k/Vnhq704e20Q3
 0O5zrrxFxMqWEax4TZ077MM6l7x5tnA+U0Veeq0SIEHsTNYr6iFA1R3lMDw1trvZm6Kf
 OxrzkG1y7DW4imeG9YHTPnCTOWlU07fVnxpXBrfsVRR2NB/ukgrJXZucVF+2AHG/WujB
 ww4PnSOVUeK1wPyaIUkTA8kAJMD+mvWCwRWkff0Gm+hrWN2OXykce7D14rJ4DqdnpQgx
 9lfA==
X-Gm-Message-State: AOJu0YxKLf4oBLPxai49BMUo7XRmx7DS/OkwvGoeKtltmn1vK2J5Rr9W
 IY/+k07AeyTBhEccVuWZX+vyZis8AGyDEj2/dUzoFD6OD5TegHDq/ZNvqnI/7Y9GYuf0NxTckAw
 qtJIs6987+Jbb4KXs5XQdKINFSvOzwie0OQ1p8DOgVg==
X-Gm-Gg: AfdE7ck6Oh2NpHotqQ2G6QV6XBwgrSskLCQyG3GgP7QbfIC4X8q6mGIi9ckenMWLtob
 ViqqYBDsXOp4bSWnjs00zopvuQ3JD5BDuctEZ7BPAELKpgUsW7XF1+Afs27TDMOf2pQshdjA/1w
 Cupd/w6my+2cg78AbY9tqzBbMVdpBOGPv1+4cK8Mc20IBMWqLPrna2cr31XWhiEvfxBAMPZBlpG
 /PuEcDxkIA28xKqSX6R/xDyxNs7IYZDD+5Mjg0Nmq/BB0TIRNHn/40jOPsqYWm0kVlluRWLa/cv
 ck/yLwZ6Z3a6JwXuwkvbPYJ6Nx9NWRdq6zsoYoGVe/ev7yFJqov+sMv1
X-Received: by 2002:a05:690e:450a:20b0:667:b04d:c0e5 with SMTP id
 956f58d0204a3-667b04dd1e2mr5433957d50.27.1783691272048; Fri, 10 Jul 2026
 06:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
 <20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org>
 <CAFEAcA_M0Z770FApDyhNcYaP89JP3Q8MDj5bMjYKSpmONYrr7A@mail.gmail.com>
 <alDq8uq0QsaH2LLN@linaro.org>
In-Reply-To: <alDq8uq0QsaH2LLN@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 14:47:40 +0100
X-Gm-Features: AVVi8Cfn4HPBklRmCDG1fU4MYRQxwm8MQQwZY9ht7w2AvWcb-P9ep9uAl_sylkU
Message-ID: <CAFEAcA-bzToSzzmOQ1z_oCDtWEHdyZmWxDRQPgBC42s5V429Xg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] target/arm/cpu-features.h: x-rme now means GPC3
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Fri, 10 Jul 2026 at 13:52, Jim MacArthur <jim.macarthur@linaro.org> wrote:
>
> On Mon, Jun 29, 2026 at 01:00:05PM +0100, Peter Maydell wrote:
> > On Thu, 18 Jun 2026 at 17:33, Jim MacArthur <jim.macarthur@linaro.org> wrote:
> > >
> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > > ---
> > >  target/arm/tcg/cpu64.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > > index f7a920a202..75c2027900 100644
> > > --- a/target/arm/tcg/cpu64.c
> > > +++ b/target/arm/tcg/cpu64.c
> > > @@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
> > >  {
> > >      ARMCPU *cpu = ARM_CPU(obj);
> > >
> > > -    /* Enable FEAT_RME_GPC2 */
> > > -    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
> > > +    /* Enable FEAT_RME_GPC3 */
> > > +    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
> > >  }
> >
> > Just noticed this, but does this mean we should now list
> > FEAT_RME_GPC3 in docs/system/arm/emulation.rst ?
> > (If so, we can fix that as a followup patch.)
> >
>
> Looking at this again, we don't currently implement the APAS instruction which is a necessary part of FEAT_RME_GPC3, so probably shouldn't advertise that in the documentation yet.
> I'm unsure how to handle this instruction at the moment; it might be that we can simply decode it and ignore it, in which case I can easily make up another patch to complete FEAT_RME_GPC3, but if not I'll need to seek further advice

If we don't think we've finished implementing the feature, we probably
ideally shouldn't advertise it in the ID registers either, but given
that this is an x- feature we can be more lenient there I guess.

-- PMM

