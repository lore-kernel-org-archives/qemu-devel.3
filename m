Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B1FC44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOEQ-0002lI-Nu; Thu, 16 Jul 2026 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkOE9-0002ka-Ay
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:42:21 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wkOE6-0001Yp-Lz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:42:21 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-39c8e65e3f5so61942821fa.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 08:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784216537; cv=none;
 d=google.com; s=arc-20260327;
 b=ZimcDOQeyoppbQ6oyQDMQOABlTYc7e+5iojeF5ZTDzpMwqCrCYtczyTz/FUde9sD6K
 09vCtoi6KIO94SKQGVOvlw9txOzJk/8H9PUjnW2oh98U4n0AVAaw3DokzONtTSi4ehSW
 4qoNvvREJC6jfdVEQl9h7xXnvL+d9IQHjFxZcFgmtGmAMDK9B3Cf4CyOszyDZ6OYIfai
 6hz9tGWL1YJJ9yh/r02HSPKPjUVaF2GztuuV9NXwiYrXw6jWpek0bXcmzQgCc7DSUjn2
 Jmz8D0J4jhbEfR/vu3wuJtXDRXmYGrTvZyysboRMtOz6CIh6lKHJ12rBCJyd75eqpi4X
 PXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RvkV5SCz1HQWwYNSS7q2+Fhodub8YNYqCHr1Ch/PE2Y=;
 fh=mCbCdfqyzUydTnVTNLelxMnRuTJKms5RY2fQFNiPER0=;
 b=McYKb6duHfP91njCifH+uwVT1TSNZP/8sxlYfqvP52nBrJTeK7as8rOJg8rj53Lx6O
 R3BL4Ttj49pSB1E6IF72fg8Nvlt3cX/aJZb24Ar+kqe+6xKk2Dd/U189PuvoZPJxWhSX
 etOjFsD9yynVV+GSP3xCql+np6oXd5aMpPsGlNjgewtoKhtFyBSkrGBef0PTTxeAW8mz
 VejSdpK8JBHCUNzdWg+BBA+Ci+zoA4a1rWpwZ9RgStc0s72OMBw3e3jf2X+xYzRVhmls
 NO/hw7JAKUg29Bfw9Zk/WIYFC01ZOB687Tp7Hsn/CxH+kiq2gjrtJLcTD4vu4jnWoJgt
 GHKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784216537; x=1784821337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RvkV5SCz1HQWwYNSS7q2+Fhodub8YNYqCHr1Ch/PE2Y=;
 b=dBKtjyQjhDA3Xz7Fcn401b4LQcmNpH2W4B1EgrFX3mlg7h+IHr5A2/TryEn7bnDNDq
 TaOqscn6HfVEokQHrA8qKJcehbse4NGsTSrl5oyzHsaxdAouHPW4mfj1Hklf4wjHMY59
 S40AVfOgfXVhAErE2ew1yUeLHQRaA3yYmRFWBDBx/wuSHjzUvMWa8ZfKQ8hQIFzXkJwY
 4NriGawEZqo2AVKcAOL0MKDOFewT8BpyN7dPo2V8oZnAhyFq//AU50UufMMHpuLElF8b
 5BAZZbkZ2e6HQFc12kSvbhnBw+zG4JiBQBbsum3dxaBhmD3MLPKgqHusBEg+AxsN4Tqb
 9AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784216537; x=1784821337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RvkV5SCz1HQWwYNSS7q2+Fhodub8YNYqCHr1Ch/PE2Y=;
 b=cIcyDzLa3BJa5DJSnBf5NLk+5stTAOTrtIgvthFvorJ84k0nbt8Lk4Oa7pHWSKPYfc
 NNLwgVLspcKEr/pGpiMk6vV0WeI5f9XqMFynu7TwAdfH47jBy3SXDKDqV5ckn4/GhtxQ
 /ZjlkB9KwBseRGxyVhes8XYJqtNjfBfxygGazhXBV4jnLCy1KtWAiCGLnNPk9N7BBiuq
 PRtTCk4QiwQzdgJ0Eu43fDQbjb5YrG0NqPWN4+qCDaWabL4pWyx5FYi7qwpvJZMYR3I4
 8TiYbyHNWIxoaYexfRuxQxFh1tai4c5lbDbLq6r3JmNejvjiX8vzNxKd65x+GQPSmdkV
 n+Vg==
X-Gm-Message-State: AOJu0YzY0KcwAy0fYLa3eHKptw3E9S19EMkPTa3VeKDpmXyQNku2cxp7
 wb1vhrjXDHfj0oOwvudYiU5hkV9PP7DGw4nu0qoFJUXu7uF3/JUqodkY7515PoEdbsRFXJ3cYlc
 ZGRhpx52yWObnjajFNl6tqRfXP33xG5w=
X-Gm-Gg: AfdE7clmy5Axod1akdvPTraKpw822cVANmuRWmG1iM3kILBA2mxdN1q0XFkGDfIJnte
 rvDIGWdpnZxjXZLXuBmakumjJrKSR//JMVWHzzO9IKHDTZYxCXAAUtoj9yCqtFGxglOEewOvOy4
 hQxu5R4QFhGUJeHeygzgUF0O5hVm89MOkXCvce6ran11IVmyfLQQZL5GrRd3iEwQu+9cLz7JcBh
 qonX+lZ6pLtZsNhdLM1Ifkdz5VHRTwAzVuMF074WmPk8mz1K2H+J/urrGFLgowGSw/SRJO5lGjb
 g2TEhuNHKUMtkO/Lpizc
X-Received: by 2002:a2e:9a14:0:b0:38d:e220:8dc2 with SMTP id
 38308e7fff4ca-39dadca9fd7mr22954121fa.20.1784216536465; Thu, 16 Jul 2026
 08:42:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260525215308.44096-1-mattst88@gmail.com>
 <bd5e479f-8ed7-405f-b38f-bd73f4990321@tls.msk.ru>
In-Reply-To: <bd5e479f-8ed7-405f-b38f-bd73f4990321@tls.msk.ru>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 16 Jul 2026 11:42:04 -0400
X-Gm-Features: AUfX_mzHwYYUGXO6Xpv9Zr7L3EI2-kJiCkT27dDlrFNt9RoGkfXVqjXA959N1Zk
Message-ID: <CAEdQ38H7LgsCsdix++zhxW+hrXdJi1wSv0DJ9bQRKFVU2QbwnQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user/alpha: add coredump support
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 15, 2026 at 7:19=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 5/26/26 00:53, Matt Turner wrote:
> > Define HAVE_ELF_CORE_DUMP and target_elf_gregset_t in target_elf.h,
> > mirroring the kernel's elf_gregset_t (ELF_NGREG =3D 66): r0-r31
> > [0..31], f0-f31 [32..63], pc [64], ps [65].  Implement
> > elf_core_copy_regs() in elfload.c to populate the gregset from
> > CPUAlphaState.
> >
> > Without this, bprm->core_dump is NULL for Alpha targets.  When a
> > guest signal goes unhandled, dump_core_and_abort() skips the core
> > write and falls through to die_with_signal(), which re-raises the
> > signal to the host.  The host kernel then writes an x86-64 core file
> > for the qemu-alpha process instead of an Alpha guest core.
>
> I'm picking this change up for currently active qemu stable series
> (10.0.x and 11.0.x).  While it is not a bugfix per se, but a lack
> of feature which can be very useful for debugging.
>
> For 11.0.x, picking up this patch makes subsequent patches in this area
> to apply cleanly (e.g. 7a2e863f9dd "populate AT_HWCAP from env->amask").
>
> For 10.0.x, where things are quite a bit different, both mentioned
> changes require manual apply, since in there, things are in different
> place (in linux-user/elfload.c) and organized a bit differently
> (HAVE_ELF_CORE_DUMP vs USE_ELF_CORE_DUMP).  But since I picked this
> one for 11.0.x, and since 10.0.x is an LTS series, I'm picking it for
> 10.0.x anyway.
>
> The result can be seen here:
>   https://gitlab.com/mjt0k/qemu/-/commit/bb9f5a3bbc2f06fba918432b40b56e5a=
eb2b3c76
>
> Hopefully I did the back-port correctly.  It would be nice to have
> another view on the result.

Looks good to me. Thank you!

