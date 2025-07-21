Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D83AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 12:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udpow-0004eI-BF; Mon, 21 Jul 2025 08:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udpoX-0003jV-9w
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:40:18 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udpoV-0004g8-1w
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 08:40:16 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70f94fe1e40so56450497b3.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753101612; x=1753706412; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fx+D3l+UaSeLFO1hwQVc7g7MnZhlXcFCOV7Ah1Fo6Rc=;
 b=RtmAmGUK4c//gLkPv0iQBKPYg/g+1+Tls3ZOmyc12IlvCbx+oJWDcbQE53sO80bVS8
 diq0yIMR4knQGky1jtMIkmMwqG+aw+aJm+dAtnQ9rKPzaIaEkEmrftZrt69I2Np7RbnC
 Kt82QNQTeKkPs8FgUWaxwYyCZJci1mbUjXX5hcwriO3uQtES/B5t1oqlfWlD3+ZNs0vE
 T5BWoylo0YcywxTy9Sm+gNrN0rud/H9Ecu9p60xkl0nG6BReUV8gaHq+vXuYfaaDolRs
 Mn/uT7xHsdmB+EYbBYvEG78C4oIzNteFHBxRQmnKjmLT0zkrdXvpiHyBTqRGw+Zbh2a7
 bp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753101612; x=1753706412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fx+D3l+UaSeLFO1hwQVc7g7MnZhlXcFCOV7Ah1Fo6Rc=;
 b=E6+gnm5pwHCO3e+ytEsiWw2/dDMPxDeWBUjeqsV4DkEp8kP9Bmfr4VGbWrOtDmyqDf
 dn0ytJnyo6kaAgrtpI3I56SOg3sGh9R7PUmVGwT45/2g8L+2tdzlPHA+fLRDYjiLkjnO
 n1J0x6oBpWkOnwfIWd+0iXgawTjmM8kHeW1wLOi1rzjK+IFOZssxRMYl10TeUxeKxStI
 dw6qRVgsJkIzMa+rbF1CVQkH3Z4EYadV4+2Fdqif3fcmkQJU6688c2DSItx0wjGSfWbJ
 zPXCwUuVTy4zyhtu06/Ux43o0FmL4VYM/m4bz0t2mwyEtR5qRG9srfnsX/Dgg8lQh/rv
 y7sQ==
X-Gm-Message-State: AOJu0YwD8ItV46SzPNukyYlInKqmbPwDDra5UW9oa61+BLiylWJ3N3J1
 JqJWx/ORD2FvYQ7Q2h1ykez3IJyvIVhWQBC98tIcbbAV5uRHaFzsFzLSQNgizIchMag2BGd4Vot
 bRYqS0uFXIVrlYmMfaATlrdlw+WMPgmcmvl1SSxmBTQ==
X-Gm-Gg: ASbGncvmZO6Y+9FW1Rg7NAsCuyDhySADiH6innCVlHeoSXGM7Vi2MDB3QqrbM7vpzdr
 4+r7TjwN6Zkatk1xNlX9rvCB5eTtJumHHE5/5vr0ZZ+Y6JSqhFR0cI9ELBJrgJTfax8sOzRtXAh
 jOnAv+xkP6E6hLfTG9yRiPaH3uV8Zxk1rMhJShTIB8h/GKiQSbcQgDWHbuSkKvfq3qtdOUiGDGV
 0ne99iI
X-Google-Smtp-Source: AGHT+IHJevQET7XJXhBkSvLqPk7DyBCQHZYlWaZzer6uYyUr850VWGHJH0TmMWmJliwbfdYc1Yos+OBgOV3nOYY8gN0=
X-Received: by 2002:a05:690c:4442:b0:70d:fd6f:b151 with SMTP id
 00721157ae682-7184f7a071cmr190726317b3.11.1753101611878; Mon, 21 Jul 2025
 05:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250716172813.73405-1-philmd@linaro.org>
In-Reply-To: <20250716172813.73405-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 13:40:00 +0100
X-Gm-Features: Ac12FXy0n4FBY3_CuQrcvs6E0l8ly649O1sjKkf_Q5yN2Byv5ZR4iVtMUBt9I-Q
Message-ID: <CAFEAcA-nt-qeP5u=WyKS9pTWrpkDMTBPF241xKVsr+Q-noWtAw@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 0/3] accel/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 16 Jul 2025 at 18:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Have get_physical_address_range() return when HVF is not
> usable, allowing to try another accelerator if requested
> with '-accel hvf:tcg', reported here:
> https://gitlab.com/qemu-project/qemu/-/issues/2981
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   accel/hvf: Display executable bit as 'X'
>   accel/hvf: Do not abort in hvf_arm_get_*_ipa_bit_size()
>   hw/arm/virt: Warn when HVF doesn't report IPA bit length


I've applied patch 1 to target-arm.next, since it's not
really related to the patch 2 and 3 bugfix.

thanks
-- PMM

