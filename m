Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903DF106ACCD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0kez-0001IE-Jn; Thu, 12 Mar 2026 14:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1w0kew-0001HA-Bc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:21:22 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1w0ket-0006kX-Uc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 14:21:22 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-67bd152d3d9so731808eaf.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 11:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773339678; cv=none;
 d=google.com; s=arc-20240605;
 b=M8fIdmIuQ1JL4a/3cPlIkDbWz8FmyScksidblxNI5/W7r3LYiRexAdbf19+Yzuy8t7
 kDg59kiAv5AsdV87pqHdmlI9tIyx/PIj+bCVphqt9SB5Tcz44+aP+/89D64iyWtFxrN8
 3Gbg+4qLkqsajh7Ycm1VMeMHMfJUC2wEuWtrRbDTTHzmFmX0iRiZ4YVDN4RKKh/Y78bK
 nK08R3fTr45wvyzuVz5tuVjrPgwZ2B/LuS48MSmU0tJgxgH/0kmdT6ip/yd/ABZJSmen
 fjFqRjp50TfTQqvEhzd+4y4S9vLOMlUXI9r4jd3T8Ep3z5zQ91LBFy18yGsCuHdn6oDs
 ZVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3GUBg4/MKX2N2US5F4ShWPk7363f3mIcvS87GGNVCTE=;
 fh=OZkx7Lnc0PH+IXADSDTOK0nknyBxzNDzQbfD/KROBVY=;
 b=dV5EBGa3LYAjZ1/px+Oz4bBFRHmPOBDPPZ9AWYzTbjgxOQhz9cqVx1bozp1BNTbPZl
 CRA1/ER81RaAzHcHbiJUdnwJzYTWACF9CkWDN0iswThPQCuv78wqz1HVv2+90BTZkjS+
 uInuakAC7DR477dIBFW8NDtCs15k40OuzIE1dHuaPdwL3l1b9KcOowwBiwCr+IZDwQ+l
 iAZbgneQCvClNuMCsfkCr3lld8nNLOxoAKe1KKL5uJj+mY61yhNd2RrAjH2fVTSSjme5
 47M/u2GSqHYiMkMxJYEHZT+t2wbXf7+PklCdXScT/GbxCl2ZIS0K7BvLB+FNxMn8Jr5B
 nOWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773339678; x=1773944478; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3GUBg4/MKX2N2US5F4ShWPk7363f3mIcvS87GGNVCTE=;
 b=PskAIHvx9BY8DtwHXaQJt6uCwJkclVkMdNy9nyucfmLoMYHia5oOF5v+5GL2juW3Sk
 mSJD39/e98Bj/JFqKKK9QksQADw0N8U/mpkH5gkSqiGmeMo8wn8XxAbMiSakiuvsQ2wg
 ubA+rIPzcqd9bwHIq7vhx5Wp7QepAtYztFI2cNDu125nW1FoN14N/u1CkEPwZ/juzzIo
 iaM6wu0nzNXUh/6pOBzh5WQi75nAgK6/Dse5TSkVgR3GJroiJoH+m5KXkhYAOLWwNHXM
 zXq2PnD5Z0xsxmTzoI1evdpKzeSB4R7aOAMyUAppRJf6gvuG2cI9gR+HwhMzCQmNXxXB
 uKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773339678; x=1773944478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3GUBg4/MKX2N2US5F4ShWPk7363f3mIcvS87GGNVCTE=;
 b=V+/S0tym6bCUDTdNptSv16lKuBeFgM1EkLnTSMPndnynzNlHaMOg3vHnJIKtQLNeMj
 RH9jCpQfyUVxjdO4A544VAVwKwIkkhe6owA81QTdOxouf3Y2AoQ6Jp494MF2NksDxOg0
 xsPP9A9T411OTuzHo/Aa/9AACWhnvlv/ox1EuE2BD/lDiky9vgrVHyND8BTBWiIUcm34
 RTc0q9UGATY3aL61k6ac0y8hNoo4jJvMdTmDnSwFz6RAlcJr46rYylU+ogfJSV3q2Zpd
 ztlCrvyQ0t7SMc+dgVh3bt+Ggc+GiCiDg5DDU3HJQnx1HGcBZBZVO2VsJVx0kJZDhRXV
 5NIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLDDxdyGnHBwQg0ICbf3l19R9Oo9O3ER0oqpj6zZqn/l+bjni5ReBeItgzAT+dB7hhMjLsagF9+W/R@nongnu.org
X-Gm-Message-State: AOJu0YyyNLSvvn9F5f3gsfU6+CAI/DVX38AygdFu6M1hhlLVoTIDA05W
 H8IEV0rXmoxU5J5K9lVDxdDANoimW1nKBV/1kQtuykvduqxk8KCCcCyBMZQ0iESF/XducUohY0o
 hA2qPDQPcJ3waRfcRhm5eC6g/19NufUd4MaBodrBvKg==
X-Gm-Gg: ATEYQzxvRkBeqfoJPTKcehMRIV1rDkVbrXfavvCEVSgvn6mji1TcEdhSVLGU9/JgR5F
 vDUc7UJzChvmqTFVQKWLuB73h9EaAztglTkeABBgIqYNionDbr2JIeCto/AOwO/ck6TCjRO//MH
 Z2hvYpCvwR6bAYKMqEPQ/K4cVrhVaswTsAfeRYYaDKEhKYOIQvk9rosNixrY0+OOYm6dViAfnmz
 Ti0yZwfW7mMrLFKP1ib8BvS8K1YFqM29VHtEy8Hu78qYdkYIfE+zjtu3f6Pydvy98QbJfdK3nOL
 Wo2X47U=
X-Received: by 2002:a05:6820:e0ab:b0:67b:db41:595f with SMTP id
 006d021491bc7-67bdb415a91mr32098eaf.74.1773339678166; Thu, 12 Mar 2026
 11:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
 <20260311151014.55915-6-mohamed@unpredictable.fr>
 <c3a46ba7-7f5b-4a4b-8d24-6d78b7c0f5ec@linaro.org>
In-Reply-To: <c3a46ba7-7f5b-4a4b-8d24-6d78b7c0f5ec@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 12 Mar 2026 19:21:06 +0100
X-Gm-Features: AaiRm53gxsJT3x_Gu04pyKeNLjfiiYP2-bB0WctywLWioSlpdS9ntOXnzGAO4U8
Message-ID: <CAPMQPELPaVbVg6HzsUm0s_w=xMqrmKUyC1dD5rEUu_FujU_hoA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] target/arm: cpu: alter error message for host CPU
 type
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-oo1-xc32.google.com
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

On Thu, 12 Mar 2026 at 19:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 11/3/26 16:10, Mohamed Mediouni wrote:
> > Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > ---
> >   target/arm/cpu.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> > index 7e3e84b4bb..e73d7eb4fc 100644
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1629,8 +1629,8 @@ static void arm_cpu_realizefn(DeviceState *dev, E=
rror **errp)
> >        * this is the first point where we can report it.
> >        */
> >       if (cpu->host_cpu_probe_failed) {
> > -        if (!kvm_enabled() && !hvf_enabled()) {
> > -            error_setg(errp, "The 'host' CPU type can only be used wit=
h KVM or HVF");
> > +        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
> > +            error_setg(errp, "The 'host' CPU type can only be used wit=
h KVM, HVF or WHPX");
>
> Squash with patch #1?
>
> >           } else {
> >               error_setg(errp, "Failed to retrieve host CPU features");
> >           }
>

At any rate,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

