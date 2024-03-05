Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BFEC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUmQ-0000eu-Mm; Tue, 05 Mar 2024 08:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUmO-0000d4-4k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:24:24 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUmM-0000C7-Kq
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:24:23 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d27184197cso78027321fa.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645061; x=1710249861; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X5QXITXYDkd6TTrJ+Qrj62Q0dNhrIN/WqmYS6YiX5mQ=;
 b=omFEHzfPnh5xc5rXKXpuSjopd8Jwg1HPfxbC7jcgtcEl8KaK4ITfTwl/8xlVRI7RTW
 o6sHAHxI91z+m/KTvAblGy0MpS+odLU9D5iGsKPqa4QKlHQ1dK5OKBL/o8wnaZsJUWoq
 I3JtrD1AJGTUewhUZ/U6P1YN45tXZVN40M9PhVhUge9i23HpSenpu2SkCAsQcSLj+G1d
 S8MING5JH9RUb5GDpJWIO/HhkpzaxQmVtASmW8acfVujFxh5nTOsRfZVcr1F2Wx6yRuj
 el88nOf1ryAPWPXRHvFXAGaDXQwIOPm9hvWlsXn/HxrzOu4Juh++XAkh8kz7HN6Zr+1H
 pnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645061; x=1710249861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5QXITXYDkd6TTrJ+Qrj62Q0dNhrIN/WqmYS6YiX5mQ=;
 b=Uuk+zYjfSew+sQhTJkwvM8Tdz1kucR++7ZWkqJdpL+czDRWmC5TNUpecfhJIi/8vG3
 E2sne+tNL9Ssc7JzAkSlNZag79IWKJnpV4xtNOuUZLp/jWNT28AaYLEZR56gq+wKVhuS
 +6oIP4wSFxF7aU5LrNz93iUqwDtfSyRJIzBZIKxH8Y3qOvYk8ZEZXe7t/uebcdUcTk4Y
 uP5PIHOYRT8O4Uolt5zaKNVUNWQ7SPiAtxhgW0etTrhY99N7et06YSrszx2oTTtnO0x0
 8LnsUbuREdyAw9fGsLWmOkOIsAfEoG3RihtOjoKfHp35DKfxsMv4+yvLhR/AjQqEEKAS
 EmTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUauqA2fW4BBzAlrZA/LTIZeqzmU5yUdtnXGXFpjh3uQ9vxGcqHTDdz5KZsJbo2HlaZxjIutLFSa/aMCAywSR8g1QOunP8=
X-Gm-Message-State: AOJu0YzsHFYiojLEqBmU7/YCorYTTZt9QPQIeRTU9oICZWAxYIcDkpEo
 VPaCOtYDuuMBfbqlYinWpjfyyrgrxAvwe4VjUTCDJPAETXEflcvI7BrK2Wpbsg1mLE8yT7uFQjz
 AtG3JPkx+3IK7m4h626h+IG7QbM1lYK5aXTHWPw==
X-Google-Smtp-Source: AGHT+IFpq1L0Rw2tUCLCqVHy6QACapYCrGQyiY1GTlfOUmeWS0agn4U4ibdZ/p9q/LZr2E+zdNn6nkF2lMnmX9UXqE0=
X-Received: by 2002:a05:651c:1509:b0:2d3:318c:7651 with SMTP id
 e9-20020a05651c150900b002d3318c7651mr1465166ljf.44.1709645060687; Tue, 05 Mar
 2024 05:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-1-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-1-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:24:08 +0000
Message-ID: <CAFEAcA89pt9CqFT_ir=7dnm8A90UgBqHyRiBOsPK25h-7KOAoA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] contrib/elf2dmp: Remove unnecessary err flags
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> They are always evaluated to 1.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/pdb.c | 14 +++-----------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

