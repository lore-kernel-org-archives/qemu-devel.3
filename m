Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AB8C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4Fj-0001Zl-5Q; Wed, 17 Jul 2024 08:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sU4Fg-0001Xy-UF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:59:24 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sU4Fb-000891-N5
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:59:24 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b966b41fbso8273443a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721221157; x=1721825957; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idvDtEwZOQUpT0NLawRdOHb4ouT+t6TnY0ba6XL3flE=;
 b=xpvzlPznk2dkQjRInxeKwFllXxX/OSU1YTC0VA657B+eOt5KUmAANTVQ/1ahAHCv2n
 RCLHcnSDDGmlYn5D19ig7MGpcFNmvbh8uJ6PcbzTSk3GvkoMAfxHlp/dsLTqhayIlxuX
 unQY/zMBv0xAcxf7C9bHCWTGbKsJjHq0XkAG1/6FYuw6e/96i0NL4xwjuIQaoWUVjWeC
 d30dO/AT5NFWmb4lIvN/ozeLqiLC/yf+iPXGq8GldIYbC/dSrF5Tonj1xg5WCWaN7fUM
 UotySLFncBcAeKv3qTPBYGi6StNZNXzR7E/bPG3loIH90LqlK5X7PsEMn/SHsQ4YZNzP
 +YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721221157; x=1721825957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idvDtEwZOQUpT0NLawRdOHb4ouT+t6TnY0ba6XL3flE=;
 b=BOkCKWDdWAmaDjMoW1M/qpU47c+TKOpNQfwnfS7uL0nL+vb5KsIFKuTJ3ye9rWh+p/
 EWCYuOQbyHw++IpJb42O4UY11t0c0FpZERQPcG2tUoSk1c4/8l1fe7CnL8OVP1KbhLUn
 jO4JwzoNbKmUFihRVOtZIYi5NXPJUjkt3r/KML2DwuolpOuM6nbEa5ANRtwXoQ42+3OG
 RpPb6Sn1uCrgbZQCXMCgCDvF+A3LIatip/nAsuWCPfSc01GTBx5G4BV5KMY79SSy4GdN
 Op59kiXcjPlcRrS2hNocPFL8yt5/z2ejDbrQEGeInexJ2q6/A73yn7rVelKnuJrJquI2
 EFkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1TmlVUssutZCsbynSoLMNO/OgyFFzgaCzr0iFWHBO7elzlEptaEtVljhsmTjCvLdTg53qe6LuIWnP7VmbBQlR+fSczEM=
X-Gm-Message-State: AOJu0YwgtCFBD/wiLRmpXA2Vf6mQesNchL3YEFPJcSHUAdSnNPs956bI
 TE+ACR2O8LeYgmOxISDiA2865z8NtLgRntd+99y8yXte4aEwNt6C3qUOPMOgidlknlZA7zHvNEY
 mXjOlBiEeKhhwqbp9y31bcJYXp7p7kVhk//2rdA==
X-Google-Smtp-Source: AGHT+IFIUuXnEci4DiEIoFp6WIqY0KqFLP1+LkwPme9Rh2y3HQn+Xu9skocf2a45JCK74J5eI8CfO5CZHJxgCl4etdE=
X-Received: by 2002:a05:6402:f24:b0:5a0:f7ca:5e97 with SMTP id
 4fb4d7f45d1cf-5a0f7ca60f3mr504964a12.12.1721221157012; Wed, 17 Jul 2024
 05:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9b178fc-04f5-49a6-992a-f6920408b41f@linaro.org>
 <87cyndgtui.fsf@draig.linaro.org>
 <afa432f7-ed06-4074-8849-796984be0bc5@linaro.org>
In-Reply-To: <afa432f7-ed06-4074-8849-796984be0bc5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jul 2024 13:59:05 +0100
Message-ID: <CAFEAcA-huKegPEAUh==S0bkLPT2TA3FVNw=u03VagG5+nW7-Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 16 Jul 2024 at 22:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/17/24 02:55, Alex Benn=C3=A9e wrote:
> >> Are you expecting the same GdbCmdParseEntry object to be registered
> >> multiple times?  Can we fix that at a higher level?
> >
> > Its basically a hack to deal with the fact everything is tied to the
> > CPUObject so we register everything multiple times. We could do a if
> > (!registerd) register() dance but I guess I'm thinking forward to a
> > hydrogenous future but I guess we'd need to do more work then anyway.
>
> Any chance we could move it all to the CPUClass?

No, because different instances of the same CPUClass might
have different feature sets. In this case, one CPU might have
MTE and another not, or one be AArch64 and another not.

The underlying problem here is that there's quite a lot here
that potentially varies across different CPUs in the system,
but the gdbstub layer has an assumption of heterogeneity.
(cf also the stuff about system registers.)

thanks
-- PMM

