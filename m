Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E61CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXKAj-0004tB-HV; Wed, 10 Jun 2026 10:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXKAe-0004ry-38
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:44:45 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXKAb-0004xD-53
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:44:42 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so13662325a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 07:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102677; cv=none;
 d=google.com; s=arc-20240605;
 b=Z9wlBQL8KZQpHLq+WDMQ64N9eqJGKmcxLSKmoEUj+z2ie965JyI+b7NL3L8MIgocaj
 f2ykwotzn3b0/cxN1p4sVn59b6smAkg4s7mpp0gKuh5qRRZgMcKCaBVwnOH/FaXlLkqD
 IJNP8WYwb2B1pUXxFOVsaGxCZ5rO4+eiWeMk176i8e7hOsgbry/K1Q9a783UQGccLCVk
 vHbcEMqt/2aNl3JFaUyMVkhpmTpZo1Jp1074E+FqCioKWodoMBXM4zb2QCpyh922q6f2
 JhxL9CE6WgghXV76t99uYnLWoeOn2zPi8ET94/QR4sWulLpMaCezmNh1iKP9O1Fj0kLj
 O+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9uBkvm2Ar2ALT4tNDQRdE/vlwOfcLAS+15w4KOby7MY=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=b1awl0PEV1WOkjxU2AnLqFrhldspuXuNOZy9XO1mVdafpvKyKSUZ7nO5hzq1wrRg3p
 j4GRRjwHKWTv/P8OVvuHvMAsfzWVRE3H17tBIFJ8Tmz+E+GDF3qcVTrl+AoGbZsz2HCi
 QkAD0QyI/Zp5QQ4gMgnE997arNCu4XGKZBoEP0T4eZXm1U+W4mnun63HIAELppxezI9K
 tEQDsvIKwdg+tRQh77aB/IckCOlrH00JJaKHmnPlnFMibeF5otHm2VPNYKAw3YGiztoD
 7t8OxfenFu48mJbfGydlSkh6CkcYZDjIykANXUsQ9jhnwsb0rgw8LmQFq6Ha0s5IHBld
 Hh3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781102677; x=1781707477; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9uBkvm2Ar2ALT4tNDQRdE/vlwOfcLAS+15w4KOby7MY=;
 b=rCAZc+L3RAN+Fpfct5cH1tCkTyS2fQ094btOZ1BnsC7ojQRG6GTUcEj0DD+Lr+HdaI
 6UoPz0+Fv6Q8lBl25oxgtZ4TUVfdH5z4fx95xgfEMfa9XkW20wahGeOu+BUF33UqELx3
 xOcmhWwVT/pvkPEIJUB/j5qleIhI4oRhvv1u5S7f3FClEWcJDO/LmnJKExoojDbz40gC
 n64nrpB1Oc5MnddJz+pRAplbJ4lf4zk7vURU/14ViEkWV3kA7mPnokCx5q2eqOSrauJp
 H0lU7B/9mRjsLsuw1h2X1s0LRvb5nWg3+NxE7LyORb4TVfQ1Iiq2oXipmwYnDlBpdSMD
 4ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102677; x=1781707477;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uBkvm2Ar2ALT4tNDQRdE/vlwOfcLAS+15w4KOby7MY=;
 b=CGEmSDo81mvhUpKvCpNtskBNenjf/7N/l9g6CRaBP7b3cxGbYxZ6/ppFO929nL3Lf8
 /nX6iit9i/IBAl6DtfCD+NZY8f3POQYSREulN4CpigyNtgqaRwoCht/pQ4ac0vT6jPlE
 DS7QOXU3rz5n5MHgjLxnGilaRzFfZa0n092t2SCLsOqqfbn5gGekWaL6jYSay7vo3aAk
 UxOi+BiiovvlTnAbaV3Smupz1zxb4JiaoE8FjHZclZ7Q5Y4zhzvOMHu1ONOJ3e20PH6+
 PmfxHzpWZqebJw+bpaLL2ss3Lk5wDwTkSGj9xh1Q1DQS+HsoOTTAng/h0hVRpXV8P2gD
 nzbA==
X-Gm-Message-State: AOJu0Yx7tXNv+Z6cfRt4NrTxOQstlSpO5CanD0h8iGqqn0BbZSm6OeDy
 F/l6/rYAFgXByWoYVxtRmekpcHpkp61zkizPBhcdN0nCy3uNMx6KUtomJgvPnl6/Lumnz53SQFX
 gT4LVzv+1mOJBMc7zH7GxpxF9XODBvvFoPL8pcZbEfw==
X-Gm-Gg: Acq92OHiTXRMqooHNpLQHO0hxxGHTsC/RphHfPRj3CnKOWyl1gMNtbguggwW/T+07Gp
 3SXFSFU3DR+KoBVYJfnmGlfbWRXphGK61JHqXTj6GrGwGddw0ExAvDD1mYEi2QkYQAHTp1oU0Mh
 e58WXHLm/42OISW4DJrbeqTVGOakJXW/Jp0v79/p9aHCNU0Loq9Rk8wu0o0Si2v8pur7ohw8HJs
 pSmj8Rti+a8jqrnZaO/5xj27B+o6VVunPrMRtNQ364M4NPi4EtkEw6tYwHTvSEfIkmjlrKKlVij
 DOV51S1UP8T+fb3tUr8+mtExSoYZKAmHlZMc+hAC/BYDzCughX+fuifUFzDw90s4mlHGjwBUlYL
 86lrB8Tocvskk
X-Received: by 2002:a17:906:6a1c:b0:bf1:ac1d:94b0 with SMTP id
 a640c23a62f3a-bf373eec601mr1263821966b.35.1781102676726; Wed, 10 Jun 2026
 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260608190155.637067-1-richard.henderson@linaro.org>
In-Reply-To: <20260608190155.637067-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jun 2026 15:44:21 +0100
X-Gm-Features: AVVi8CcZpG1FTWxyoYHPuW57ta3fbWT-7vyQ1YhZ08msIktsgqS28FiDpO_sr6A
Message-ID: <CAFEAcA-opunS9Krj2C2CkSVgg_U_GzaZTURXGtTGeu-WJEZS7w@mail.gmail.com>
Subject: Re: [PATCH 0/2] fpu: Handle all rounding modes in
 softfloat-parts.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 8 Jun 2026 at 20:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Fix up some unusual rounding modes.
>
> r~
>
> Richard Henderson (2):
>   fpu: Handle all rounding modes in partsN_uncanon_normal
>   fpu: Handle all rounding modes in partsN_round_to_int_normal
>

I'm going to apply this to target-arm.next since it's
a prerequisite for the FEAT_FP8 series.

thanks
-- PMM

