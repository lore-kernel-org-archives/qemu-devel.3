Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E75EC71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 10:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ1ia-0004M9-Jm; Fri, 13 Jun 2025 06:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ1iZ-0004Jf-9o
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:33:03 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ1iX-0001DI-Oi
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:33:02 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70e3e0415a7so19141177b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749810780; x=1750415580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=If4kGmFmMukX9qb+e/hifH9l/FBRtkjVpd8CeCvuk1M=;
 b=lNC/VamScBUzs5dtZM1bzuTsVatW+M1KuMHTdzpsmElFui/j01129pN02y06LIdEPQ
 361NSHCr07Erl8iNqjvuIpGH1lbeo2U2Bz2ZJkCVlcVXL5wBBFMd9Q/2Ajgf8P3L9Px0
 SfIvpkzDt5NcsS8IyhGWUnjX0Luox39fN73UoBboDK26VGknIx8ApIYoxkNEGC3edj4i
 dz0ZbCgeRbboZRpwO2qv8tMD90NPj61v2rTW2dblQ00gPU5+cqOkLeAY1go9wsxqTJmr
 DXvlvTKli1Ts3bqLfNZ308tki3STpCAnRhwb9qkKnkD32chbw92EoiwYHg0tUZ3RL0e+
 NTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749810780; x=1750415580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=If4kGmFmMukX9qb+e/hifH9l/FBRtkjVpd8CeCvuk1M=;
 b=qcKO8osYoht3EK5XTM8nogaRj98he3lyTWz/jdNuOCXphntNBgFAnf0bs6xnVxTK6o
 aRX0KMPaPiW6lbXc2n6c+SCY2aC2vsoGCHOKglzGLap9Zez3cpCsJ6qfsNJqBgv7OBid
 proFFCRZ25VbZBWnZT+8JAg7lqT1ZOJv/DAxhmfxxDK0W04FAMgXgbMNq4awXDYXJibw
 hKBjLwN39Dm2u8ltD1EGVQWODTTWFEulitj3gyWjw09jS0pYt9XU5neiTbF7hMRMwniA
 U+QIuJyQyIqNEIEzfLPtu7QUoH0eJk1XY61Ql9+pesB/gA7Ze6c/WN1fyMfpIi0DZSkZ
 HJ/Q==
X-Gm-Message-State: AOJu0YzsrQc2kbP0QCN5jHFqRjqwIUi+j8qiQgHGKOUEiHnqEhTAuock
 CZPYrjIKRrDLS6hAVXUJdIi4Uop/XlTbW8GNfeaTg6My4GOlf9xrJa1MqR62NYdeuObryPH8Vnw
 y9CB2WEO4QzMubxXXWMFtCukP2tnXCnfrf8C+1lrugw==
X-Gm-Gg: ASbGncv96f8Q/g6Eo2E5/Aw+YtY3UJaPTEpgcwAmepThoRXY8P2LLNW1e3xGaRUUcaR
 OX6BKLzloEgpHoFP/40R74doV+fQFTtOEIQCinT5qX5mIbFXywAsRWzfJMAyNwZnFDSoyUA8vMF
 r6zb3Trn5o7twjPheAppF90pv2GHoKsYDnKmScz7f2Yvz1
X-Google-Smtp-Source: AGHT+IGADNIPmaMohnRjL1LchwzbVPQDFGWGQp+uNAbvBMw/5zJxjAVe+BDhbTuYOQIjvXkUq7IjWSQpk4TVEebz9Ms=
X-Received: by 2002:a05:690c:4889:b0:710:e81e:1364 with SMTP id
 00721157ae682-71172580180mr2107187b3.6.1749810779990; Fri, 13 Jun 2025
 03:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250526085523.809003-1-chigot@adacore.com>
 <20250526085523.809003-3-chigot@adacore.com>
In-Reply-To: <20250526085523.809003-3-chigot@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 11:32:48 +0100
X-Gm-Features: AX0GCFtmefTMxKElQsTWkxr_1RmuiosBfIx55mWgdZALc_62mNdeFhXeJ-DJXAM
Message-ID: <CAFEAcA_XFRNJgN4dYe4euqh-u5-16ncfgtu2bOLR0tYamFUCqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/intc/arm_gic: introduce a first-cpu-index
 property
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 26 May 2025 at 09:55, Cl=C3=A9ment Chigot <chigot@adacore.com> wrot=
e:
>
> From: Frederic Konrad <konrad.frederic@yahoo.fr>
>
> This introduces a first-cpu-index property to the arm-gic, as some SOCs
> could have two separate GIC (ie: the zynqmp).
>
> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

