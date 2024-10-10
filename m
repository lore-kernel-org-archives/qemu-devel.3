Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F990CF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHf-0006S2-CV; Thu, 10 Oct 2024 06:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syqHd-0006Qi-0B
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:37 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syqHa-0003Xl-DZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbddso882591a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728555633; x=1729160433; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CbtJNlh/4kU+uT8XlT+C+4NJ05bnQ2F+DNUZIKZyGBs=;
 b=HcuWs1h2XG6rZRvuZuqLl0rp9PDJMFurROihz0xflWSstrMxNIMON7G+hzeeQ+FN7L
 sR7J+mM3suqajH1XsLx9ReT6Q+eqkmhG4kMHV8r3F3HjivOL/xQxch8ARG1Y6M9A8Drb
 xGUmXSL51zypEaydCZyLW7oNn7YcemAAh+grsSoXRSpPvakn6OEQ31G4e+H3Dzu/Nnob
 PapZ1PQ8nvw7HL0pgZbEGz0uswTHTlsduw0EAjylGvCeJF16FEZOH0YPb28OxBXE0uSt
 wvbQHsJs3zAe02t9D2yCZWvkUMPOY2VC73o+w0VxUvdYTWepsHSu3jk+dvj5I1PVroDl
 xPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555633; x=1729160433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbtJNlh/4kU+uT8XlT+C+4NJ05bnQ2F+DNUZIKZyGBs=;
 b=B41jfi8y6QvOwF10CxRgZHTu+jns/rtFs7zHo8pqaDf8xunpsHpQnKq7Flr83f1Sxk
 b30EMqlgjIgRqb/1Ll7YhauPMyKUr1wGYlOeuM5MG+aX1Nk04DccaqX4UQHIp3LrEHWn
 NQ1wwSO4QpkY/IWAyLMl/0xVCUQ2szTPvuODNdA2ugRG+onzMGjIjZi9lTwaAUoAbv2Z
 OKrpLj5QWj5mYOooTuZHDLHYC7HONao0/uuHpGPcKyRgQdyyboGFjzZDw+U+pwaIC2CO
 u6VQ78Z4EUIt2BnoqmDWYBGc59oDKJBhdzGomJOAd9dZHMfGMa8v+aqTzo6xlcMRmlnm
 kSyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuKFyhF+/BSYMPRqARsddYLx5UfF7JKYqi5LgqzN4wIzXrDF/xyHOPJ4ttmvufBlj4/9QbBIQMFjEV@nongnu.org
X-Gm-Message-State: AOJu0YwzepYz83YefEfjNOq4CGjpTica1IgucqfDrySRArc4ilMMx0ST
 MzdaM/lPKdtlq1TyU7v4MaVQcGQL/cAQTzBQFOMDcPxNLFrmm0le8RV39B25OdH9RZH1c0o3dRk
 1IPgKOioKbZfHYOo+JSQZaxfvrwajfRgrzUDXdg==
X-Google-Smtp-Source: AGHT+IFGBascQtGIyEfu5Mn2dacaqhjfsvlBOjYQgl6LDLV668i+mMlKHf9f0WT6QmD4DnC8jmgFcqIM7fPFRHIUOQQ=
X-Received: by 2002:a05:6402:4411:b0:5c4:a6f:9be7 with SMTP id
 4fb4d7f45d1cf-5c91d57f4a4mr5480758a12.8.1728555632724; Thu, 10 Oct 2024
 03:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240927150738.57786-1-rcardenas.rod@gmail.com>
 <20240927150738.57786-3-rcardenas.rod@gmail.com>
 <CAFEAcA-QUAKPuzcjLafU8U_=wk2HWhHbxx76WgwN+Cgdec_kGQ@mail.gmail.com>
 <63F1DC02-ECC8-44C8-91BB-337DDC9420D8@gmail.com>
In-Reply-To: <63F1DC02-ECC8-44C8-91BB-337DDC9420D8@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Oct 2024 11:20:21 +0100
Message-ID: <CAFEAcA89FVucYjnJpMzUg4mewX4F8rhq-b9nnMzDcP5omzMU9w@mail.gmail.com>
Subject: Re: [PATCH 3/4] STM32: new GPIO device
To: =?UTF-8?B?Um9tw6FuIEPDoXJkZW5hcyBSb2Ryw61ndWV6?= <rcardenas.rod@gmail.com>
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 9 Oct 2024 at 15:32, Rom=C3=A1n C=C3=A1rdenas Rodr=C3=ADguez
<rcardenas.rod@gmail.com> wrote:
>
> Looks like the stm32l4x5 is quite similar to my implementation. It didn=
=E2=80=99t exist when I started with my implementation . I will take a clos=
er look and work on improving/extending the stm32l4x5 GPIO with my proposal=
. Is it OK if I rename it to stm32_gpio? so it is clearer that the implemen=
tation is generic and can fit almost any STM32 target.

Yes, renaming would be OK. (Do that in a patch of its own
that does the rename and nothing else.)

> Sorry about the issues with the patches, I am not familiar with this meth=
odology of working with git.
> Could you guide me on how to send with you a revised version of patches 3=
 and 4?

So I've taken your patches 1 and 2 into my git tree; they
will appear upstream probably either end of this week
or beginning of next week. If that happens before you're
ready to send out a version 2 of this series, you can
rebase your patches on head-of-git and then send
out a new series with patches 3 and 4 in it. If you're
ready to send v2 before the other patches land in upstream
git, just send out v2 with the whole 4-patch set in it.

thanks
-- PMM

