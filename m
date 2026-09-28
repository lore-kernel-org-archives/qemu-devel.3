Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B375CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBok-0003Ct-W7; Mon, 28 Sep 2026 09:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBoj-0003Bi-10
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:54:53 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBoh-0002P9-Ef
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:54:52 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-674138cbe59so2161678d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603690; cv=none;
 d=google.com; s=arc-20260327;
 b=MAX0wEa+CkTHALOrA3eQSnza4vK1hDkDzvF6/d1k4eqwKPYCMmbAybt3DRU+AHzZcJ
 krgcnt0JfjFSbCNKxDZflLlWqduvvQBKOIjXfwkplS1tzltQlRYu7F9MpQSze9nVqtv8
 6E+tNG+tkyg+s+2/XJCngrzly+uLpHnE1X/fKTATlC7V6zqBFv6zNY2G6dVMsDVkqJIi
 xhnMvHOSLl6RxHIFAasSg+z/yRevd2iqp4xGE4px7saNm2NvSgQXlrj/S3pkS1ZJ8haH
 ZCxTG+1Xu2jHwNyjB1EiDHMomzr2PcyYftcDzw5oqys5pDuc5nSbJkEyd9WQaTT8bErT
 /2Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ij4uY4bkMYQGxRppabaKag+gIL2WEZJ23RiGoAkDOPo=;
 fh=gwJhe9BW/WntmRMo+gCDeYSj3sQ5xYkravNayQouye0=;
 b=qcLOH10Sa0nydmt2IriwNpFgJV+5NApkm67FnAvMxwNUfni8faZVGDF0k1+DDPetOr
 W2803RsyS4Y94PcNf3f5lCO7qV+lDojh7W1BO981NR90qvzrDZ+N4P4Lw8OQ1x6yMNif
 pL8umByM9K0vcNAMeYyHwCi9mkXQn9DrStDBN+DbL74Ay+zCKEtEqI3paEI1+diyXnoZ
 I6avFe4uZqxgDWrFVgLHR4T/KFlz2r8szTQA/w/A13eTMckznrG/GU2SvqLiY2pVReX9
 0LoLvr7ioVYft5aqXnFFwrZswt4/teCwgNiymLSEYZbRfT7UO7SJRV1wsIFzbtOG66/G
 YaMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790603690; x=1791208490; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ij4uY4bkMYQGxRppabaKag+gIL2WEZJ23RiGoAkDOPo=;
 b=UoNhlp7ZpUmZr810zn1/gIGDYwA9rfVwyWvgE5Xk9HUpeS6OMMZ76dO4874tX4POC0
 KGRO/e2Nt6dUILsnMpQSoqF2OKSr/lTKWBr8ZdID4r9Q4NJiRi9yEelMCuRospwFAAAL
 GawHPZAJNBKEWqDeQlDcDmzIP5KN5f4Az3je6FnZF5bH/gYwAt1zbLHgJ6bbZEMUUQZi
 jfIMHSBLhCTloUMeNFlESjaYD+uutAOEn7YYWQSKc8JU5H92LEmc/V1eP+C63NfxAf4D
 2bgvkl3OsFtqEiOaNDzktTrYG3TQucTUwedHXs35PozIFU2dpKgdCGtiN0Q6Zzx8nJiy
 6l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790603690; x=1791208490;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ij4uY4bkMYQGxRppabaKag+gIL2WEZJ23RiGoAkDOPo=;
 b=B5jmE0k7s54U+VgEEdDN8Y/ZMxXQvRDpQzhoSQbZYMta3Dqh1HiqwnqWItW+kEM0Ne
 T8Vi7IR+N2IF4kNsSrwNyHsC5rxpudNlixo7hZs0UFd3rJRX1vfGuJFz69NMJWlUq+en
 O0D9nf8jQWheGAHAPkSzpXmFVZdA5VkPB3wDYpmJq+SQP9axubO29O+RayO8Z0YT1YQx
 u9fmttnDSScFiJ1Y1nYPRbekJX36u8qG+wOOG0tYz2cgb/QFNAsUmQkZtUzQ2fp8bH+y
 22gPG2n6Xtwgt6DOwQUImA04MaVMZLadLZTSUbWhrqNWWkN0VVxohHEccnFiUjOwHXts
 py5Q==
X-Gm-Message-State: AFuF++mZQFOcQkNt3GRWznSWhYybloPcrMRZT2nt0tof/+1al+DK5D44
 fZaV58o5vPhbHucpVvpJf2o9DNEaYJ/CSLGMxPAS33x0WyIxlxjM6zfWfGYls+BC8JCB11cK0Qi
 jWXDwmGw/IAxenYhuAY38RbjKZnA9YR89fj1Gk3f5Pw==
X-Gm-Gg: AYBFou2rXzeob/RrZEInQNk2irvBtKnPHHtOqSzIIRpxPAtL9BgOWuwyCLk5HpiGWLv
 oDdX+QjibSBhbOuR2R+xk+JBYVfNERuhGnrN2Omu8ziogtSvwe+ZeXxT14r7Wwul9dB1FrdhPsC
 oYsee7A0RB9bK6zUvPbyazjh1DJColjNO2/nEIC+gZzGg+/xl/F8MqtsjkNpHcXt5TXR/Tbiarl
 crwQS0zQxtsYZf3kQSFjia3IDykKUkC3PTdF6pfcy1cPR3KX5JgzzpZ2+OnTk1QpU+SQSzBRY5O
 98tfNyoJ1xgN30Iwb9DhT3tgM4HwMdHkeu5cs6SZsOUx9VvFDGa5L74PXa5/3D6qpj1/O+KQO9y
 QZHb5bTjAGGVout6das/h9DWgPmcPKkuZiWOaaM0=
X-Received: by 2002:a05:690e:14c6:b0:675:3d40:3c1f with SMTP id
 956f58d0204a3-6753d403fcbmr1555494d50.71.1790603689729; Mon, 28 Sep 2026
 06:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-3-gilles.grimaud@univ-lille.fr>
 <CAFEAcA_=sRZboB1GyGDxEa4vTZe5YS4GwJV9aK=6h-fONgLVkQ@mail.gmail.com>
 <20260920220722.73501-1-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260920220722.73501-1-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 14:54:37 +0100
X-Gm-Features: AclHuK_eNBIKBT6Poa7gPEOoGww3X56YJ7ArQXHNcJ9lHMik8ltiNnY_jjJbN8o
Message-ID: <CAFEAcA9ScL5mmu1LKEhq3Qo0OSJL+-Ee4K6ura+2SgYYZi9O6g@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: model Cortex-M0+ privilege extension
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alex Bennee <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 20 Sept 2026 at 23:07, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> The Armv6-M Unprivileged/Privileged Extension is optional. Cortex-M0 does
> not implement it, while Cortex-M0+ may implement it. The RP2040 Cortex-M0+
> configuration provides the extension.
>
> Add an ARM feature bit that represents the optional privileged/unprivileged
> extension. Make ARM_FEATURE_M_MAIN imply ARM_FEATURE_M_UNPRIV (handled in
> arm_cpu_propagate_feature_implications) so that privileged writes to
> CONTROL.nPRIV are allowed when the Main Extension is present (or when the
> optional privilege extension is present without the Main Extension).
>
> Update the microbit Cortex-M0 test to verify that writes to nPRIV are
> ignored.
>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---
> Changes in v2:
> - Removed the Cortex-M0+ CPU type definition from this generic patch; it will
>   be added separately in the upcoming RP2040/Pico series.
> - Added the implication ARM_FEATURE_M_MAIN -> ARM_FEATURE_M_UNPRIV in
>   arm_cpu_propagate_feature_implications().
> - Changed the CONTROL.nPRIV write condition in m_helper.c to test only
>   ARM_FEATURE_M_UNPRIV (Main Extension CPUs acquire it via the implication,
>   while an Armv6-M CPU without Main Extension can expose the feature
>   independently).



Applied to target-arm.next, thanks.

-- PMM

