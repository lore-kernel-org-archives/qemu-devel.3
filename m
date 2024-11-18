Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE606D4921B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1TP-00015P-CF; Mon, 18 Nov 2024 08:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD1TL-00014w-Oc
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:07:19 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD1TJ-0008Q0-45
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:07:18 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cfabc686c8so2475720a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731935235; x=1732540035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnoKZdP8ZOAbTlJw/gV9H5tFfyw8/I2cE+JsQzi3yaI=;
 b=s/hZt94NclZIv/+vaXl5TWaVQQlMnks56e/5PIcVjR7qt7FDGId94FheMFFczR0nS2
 MRVf5eBe/pcBXoqNQaYbvQo5orDCznhhcNjx1F4qSI29Pdn0p0sZdC5c7f9X+JDHe56g
 kPEOCXjyB67t12yjqAdTDirPIZOF7UMquKiXfyp7l+5vWDwaHjMryuQjJ7MmkD94Wvx7
 BadDZJ1mFXrC+dbRTzx/5hn0UMpwOQRus/HWGRbXHOE9sLtuZSpe060DV/eyzhTWuqTo
 qPBDPHoPa6N8WMXkXbhxuBMKB8LdaIV5VNumQqOd7YIosP8KlB9svPLnJbTCE0QVmXHK
 Cl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731935235; x=1732540035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnoKZdP8ZOAbTlJw/gV9H5tFfyw8/I2cE+JsQzi3yaI=;
 b=xFisLHL+oXV+L7GBrH/0ekqn0Yy+pJJpwvlGfEmric5wakr4MVkpBPKpm04/JO7KH9
 QDyEjWEniYCxo9dhrIuSdi4g0NfD26bcWFYn2UKSBBiRHz/w5877rjMcIZQL2Tkskjr2
 XG5gU1N/WGA3i/nTP0pfab4GHsOPw0ymH8cjQh9mVOU5muxqfzPxgJbVtOMYO2d4UZPq
 qGCVvfKTgTK3s4y7groDBc+yE6yzSVhHlvFNiJcW2EkzYqXRy3ZmpVLCSklDmEIaVGK4
 7mILkkHieY4T6CwPN9DnLcyzF8cDGRk2P3tOu3H0HmLc3TcriaTqbTJx9fB/2bTwRPDY
 QVyQ==
X-Gm-Message-State: AOJu0YyTRuXrTOm3AY4WVVxRGl17WOmx2QEGHBd6RJIxOsEyXRy4/XdC
 iZEsI4S0jLvobY2VyUv9uSfAkU2CsYKHYpNW82S0rvipDn/XretK4sEuEKhOvi5Byto8Z3Z0IEL
 /SIAqXf2SzZ+OBAzHxmLo++GP0o4KlrSrFOW51A==
X-Google-Smtp-Source: AGHT+IGfrfK/jJaqRdqnEUr4njcxZoLWlAxCQyGwMCH8l8uAvbrJiHnFWKUo2oH6k33/FcMOBC8UzpQVHvfcnWe1sdE=
X-Received: by 2002:a05:6402:280e:b0:5cf:3f61:23ae with SMTP id
 4fb4d7f45d1cf-5cf8fbfe62emr11137590a12.3.1731935235269; Mon, 18 Nov 2024
 05:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20241118130109.7838-1-philmd@linaro.org>
In-Reply-To: <20241118130109.7838-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 13:07:04 +0000
Message-ID: <CAFEAcA9YQcseyQ3Csf3T99xRfbmvgetkTPZYO22_QE4SZpis-w@mail.gmail.com>
Subject: Re: [PATCH-for-9.2] hw/avr/arduino: Check for CPU types in
 machine_run_board_init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Iris Artin <iris@artins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 18 Nov 2024 at 13:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Leverage the common code introduced in commit c9cf636d48 ("machine:
> Add a valid_cpu_types property") to check for the single valid CPU
> type. This allows reporting an error for invalid CPUs:
>
>   $ qemu-system-avr -M 2009 -cpu avr51-avr-cpu
>   qemu-system-avr: Invalid CPU model: avr51
>   The only valid type is: avr5

This is a nice user-convenience feature, but why for 9.2?
We haven't bothered to error-check the user specified CPU
before, and we still don't on many (non-avr) board types.

thanks
-- PMM

