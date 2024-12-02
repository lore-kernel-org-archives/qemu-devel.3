Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355BAD78309
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 10:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI47p-00029v-9p; Mon, 02 Dec 2024 05:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI47f-00029I-Bh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:57:47 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI47d-0002WL-EK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 05:57:47 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0ccd931a3so2771052a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 02:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733137064; x=1733741864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H/W1MgRVOSe8QGGE+aad1/X/nTuM1X5/7SpJy8wQRiM=;
 b=PZezeDtEyjZ6twJCU5J+ADtUlrpZfY00A8zLCN0ZXa2tSLWqsgkbRCiZqgco5wtA/E
 2ymkYRAgc2OFU49ky/gEljyijGYyNevmx6gaICMwb3BySnl8uKW7ZSq1OKXOxxWQ6v0B
 yiMBa1hRjVplz+jFZFhDhDr7Om91uQQoUqS9XJE/MaRJFDK5g+mC8S2pbooUouZ1o7Js
 6CCEnH3geqofq1Xu2ireWiFlqOpXqN6ty+T1IK6ujf8dzNjLOcfYtiqZdTuMBNj62QDy
 phGXNYWMLJOAXlKt79DGzkCusI/17bJ14KVuqnSS6aVmfKhsrflAFGp9B9f773DbZrNN
 VrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733137064; x=1733741864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H/W1MgRVOSe8QGGE+aad1/X/nTuM1X5/7SpJy8wQRiM=;
 b=Sei4EAWmsrdTg5ksKXV5sZQskCrumoHMeOMHZ8hgZ7KRKg7dxkhPtldsoVQoB2Cn9s
 WBlGmBurM3Qa6WW9QVegPcQOxh96RY/Qc1yg8j8seKlhJpKb7iu7d8Kv8s0196KNaZ6A
 bA8oxetanEMKRM1tOicpnAPGRdiXNJpbH+c1R65+nxsZ4gnfbXbE0CKA4e57M45GQIn4
 x32vO1MLP+tRqNWBQosG85XR59aiwE7BGrWhgDQ6QH0G3kH/yHSe/lJ2HZgZ0Pde+pTY
 7jne8q/8HCWX2+DnakRX8/S55xLpq4SEWOMtbfDvI6JIMxoYKT2K+BM2Pjrw48b+JZsV
 tOQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHJhTltlW7mi7tRXnd93Lkj/Onnm9xz0hw8d2eNfXfBYqU/iixZFXpHIqUuucnT5oT1XVxEuRvbSo3@nongnu.org
X-Gm-Message-State: AOJu0YzmuLjrA+0sDsjP3YKd1ewQtUOonK+ZrYk2OQOU+yko1xKVsJuJ
 FUitR6Py7M9LZ28sISVxKNjGBJMiFgd+JVLGGHGdgLBDtRocvjUZad15hDawtHLL0f1qBbWAK3q
 Vgyi2ziOQ03xODfUblci5cREp4gOIV087WREwrm5ipZVZJ39T
X-Gm-Gg: ASbGncsClqpcBe1lqYMI8cD1rjfz/DPjrNgASKunTTxpauNL5+Evsth2j1h/GzYmLI1
 l4valbNrsXpGxuo+gjUAurntZIlEAtj4S
X-Google-Smtp-Source: AGHT+IHNci2ZpLwz83fd7J1Yh8ElgkNw6ZVFSvSNPOekzEgRjlw7nCJ/S2cycQ82rP6R3C2BxXrWxjicroUbhEpqfQc=
X-Received: by 2002:a05:6402:4402:b0:5cf:f248:7715 with SMTP id
 4fb4d7f45d1cf-5d080c48680mr21164623a12.23.1733137063789; Mon, 02 Dec 2024
 02:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
In-Reply-To: <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 10:57:33 +0000
Message-ID: <CAFEAcA-xa1AKf2GAv7go5wdu+Td=4jf7Nriin-Oe3S6qEV6X0g@mail.gmail.com>
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 1 Dec 2024 at 18:09, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi Marcin,
>
> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
> > W dniu 28.11.2024 o 22:37, Pierrick Bouvier pisze:
> >> This boot an OP-TEE environment, and launch a nested guest VM inside it
> >> using the Realms feature. We do it for virt and sbsa-ref platforms.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >
> >> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> >> index 5c048cfac6d..b975a1560df 100644
> >> --- a/tests/functional/meson.build
> >> +++ b/tests/functional/meson.build
> >> @@ -13,6 +13,8 @@ endif
> >>    test_timeouts = {
> >>      'aarch64_aspeed' : 600,
> >>      'aarch64_raspi4' : 480,
> >
> >> +  'aarch64_rme_virt' : 720,
> >
> > Took 2974.95s on M1 Pro macbook.
> >
> >> +  'aarch64_rme_sbsaref' : 720,
> >
> > This one needed 2288.29s.
> >
> >>      'aarch64_sbsaref_alpine' : 720,
> >
> > Have to check cause timed out.
> >
> >>      'aarch64_sbsaref_freebsd' : 720,
> >
> > 331.65s
> >
> > So RME tests probably need longer timeouts or would not run at all.
> >
>
> By any chance, are you running those tests in debug mode?
> It seems to me that CI is running functional tests with optimized
> builds, so I'm not sure we want to support debug "times" here.

We do need to support debug times, because a common developer
use case is "doing a debug build, run 'make check-functional'
to check whether anything is broken. The debug times also
are useful because the CI runners can have highly variable
performance -- if a test is slow enough to hit the timeout
for a debug build locally, it's probably going to also hit
the timeout at least sometimes in CI.

thanks
-- PMM

