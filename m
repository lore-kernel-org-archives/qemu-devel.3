Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD28CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGFhD-0005sC-Vh; Mon, 12 Oct 2026 09:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGFhC-0005ro-BU
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 09:04:02 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGFhA-0005G9-Ni
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 09:04:02 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8aca54b75d4so26557507b3.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 06:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791810239; cv=none;
 d=google.com; s=arc-20260327;
 b=njmEHrRGqCdg0vVHMRKJgbUNbRMac4vBfkC/2l8yw38a1lpeg+BuPexIAKI70C7BaB
 tJ5MoTl8OBxZ4oq1z4UHx6GYmRGOGTAyV6DzexIAyBAU57Ps3jIZJn4eLTOUC7rxNePy
 505UVyN1mfP66qqZ5OqoL50dXAs1bZk7SZhTHQhvBiJC4ILu7L+SCg6iv0j52xCnpsCE
 lXOmB0Z5CrUdQfZ2D5iAiDK/GsP4RO7EX5WnUzvebdP31qUrgsiDUTf3+2RM84luTjKF
 TbqF0P5E+PoiS7+h07lxKiJ4AnZtOyx2ldIyjmgslD8cVBtoQJRwahF2qyHOiI64Zrm0
 9YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M1Ceg4BNxPx3Lp7b7T2/b14QKQtr9LAb4SftbUi0Pa0=;
 fh=MaPMZVROFfhGPd6Epx9Ku7CN+EKyDtJKTKzt6bmFhMc=;
 b=NzsQOSkwfg1nVWqG079y2Md748icPyGOp71BDaESoCOl/6kb9buPDMeQDmVUxjAhxb
 N7wDeY4jSIsje795kU1xT5RNWJpr4LM69c5wsxDfE56Uej6xnzYpbx8KFjlhWEWnbKdp
 qXumdgVH/NPxuCVT+N17bkY3JNIl/Kzdt4dnMLRm5Juz1CqWgBpfggfoT6O+XbHkQ7wN
 AmFxO0KUDAe2gNXAf14+Gu3aKQpQrgvasrTDB0owIY76q26FGTTJm9Z1g2rlzQ6Mu62T
 VetYelSvuf9NaqD7ccbmWVCbon8hvdmNw1mktMaqjb84xon/AtQrDPoTKRWmx514kOcG
 iwtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791810239; x=1792415039; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M1Ceg4BNxPx3Lp7b7T2/b14QKQtr9LAb4SftbUi0Pa0=;
 b=Ds6xThXBMKgAV3kFQaEScYP9SWAgzepMWf/JrU2yF3Wpxq3vo9iMS6FWGhbAbK4eHL
 JGOtFQngWkdoNtFJiq5b/4Pa+jxgnZ3zA8MWXcFrgRpfF9L3zD5InJ2li8LgE+LUpust
 2DB8CTfOYRvMQHwBjuKydBFTRa4bhG5k7zhz4anEExOLWq1m6kuRR55qJPTKQprEzGUS
 MM/5brIJJjonDKhO6ZVeUv7bQjdvv8nfQpCAa7a7INnt+Zy1ebQ7FYNlykXchedCMNPG
 RQC7dVi7x6IPq4G83IuE/7aGs3uJVzs2ZhOB25E2Vl/7MoEmOPXAIkYfudcoRXBuf01X
 pu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791810239; x=1792415039;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M1Ceg4BNxPx3Lp7b7T2/b14QKQtr9LAb4SftbUi0Pa0=;
 b=Lr75JA/Yvkhs/2oVS9uE2UpDa7O06yT6OtjFHRRN5SgXGIBQtL3XDMcXdpDU4T/Tt1
 8c/jPTQARj299wGC0Uzn50g4Rr1/ca2wmN52UNNBcVxmos+ejSrUXovtNmMdbOd6K7RI
 7xLouV4VzmapFiZWkLIdXa9XPX75rIGwFMX2vKpVrC68rzCghN5RsxeKm4AXcb59hiq/
 7c7o/orqK8oDPGwCcx1RqDF6saqNeP4caiukwbsqoYjDtOQIR3GXV/9cmrpgNrIbYMuv
 wUvUxFQP5a/HsF2X8hc5blbx6q3shKIx4bziBu2oyw58W8OAKgryEpO8DVxflxfw5dKP
 Zz/g==
X-Gm-Message-State: AFq9FYJ7mc3hsnKpr7MCSm/YQ+jYIDOr+eJFz27R/pQPbwBWnA0sJ/9G
 maqUaeB0/5O8yV1Wi1p5al3Sjsa9Gu+M98IunnqMESqZZd3rXWkHbe9E2ef1OIHQ5iWW40SKVBm
 OyNzdzk/4TJpBwlY5gNk45bRIIpuoyzNNHC3Bb8cVgA==
X-Gm-Gg: AYBFou1BQvFHaSy8B4uhUKKmOZOv8BZGLuRCvbk5/jHlzLeAmsl6xyhYzo5LD/RzV8Q
 3UYdo33Mb3kf4E3dmpTXlMjdl7kxf3tmdufjjnIOC9dteHGUBWzTR+DoBl7ECjuhI21WQyPRvR8
 F0TC0BGnBZFGqG1w3puGAzj4VHyQWCmoWUVdiilmpg7Hz8sfnkSm2W/ES1sC+rRVhUm6Hy9wqSO
 6D9HSuKDYMz+AadNvK0UXivrVnExWErC2SoSqGq/lJHXE2BVLTdk3ZyPIUPKTj4+hzKEZs3hXdL
 Ey/YK4sTwog7nnerG/mR2kxqkoilKOUN8TjdAlNz4INuZbqYFNxpjb5hqnkDTnkGcZTGEmdKmfk
 no1RPSHNDiG28SHXJrsEgMWPFG2XkrH8VEJkJUyc=
X-Received: by 2002:a05:690c:9e:b0:8a9:a1e9:2665 with SMTP id
 00721157ae682-8b07d3c4195mr32928067b3.6.1791810239141; Mon, 12 Oct 2026
 06:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com>
In-Reply-To: <20261009-allwinner-gpio-eint-v1-0-c55d2958ae0b@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2026 14:03:47 +0100
X-Gm-Features: AclHuK-Yhq9VknjquIDZElJveRyqvDNiTmgEqsgz-0iIk-SIKj9yfErrpsvrh-Q
Message-ID: <CAFEAcA9PfDvtOgXnUeWkB+h8bGTRzZLbsUeoLeORf-o1gF6jkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix: Allwinner GPIO interrupt handling
To: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 9 Oct 2026 at 17:26, Strahinja Jankovic
<strahinja.p.jankovic@gmail.com> wrote:
>
> The original patches assumed that pin had to be configured as input in
> order to be able to receive interrupt. However, after additional testing
> with libgpiod and gpiomon, the pin is actually supposed to be configured
> as EINT (0x06). In the following example with PH1
>
> root@cubieboard-ng:~# gpioget -c 0 224
> allwinner_gpio_read [PH:CFG0] -> 0x1061061
> allwinner_gpio_write [PH:CFG0] <- 0x1061060
> allwinner_gpio_read [PH:DAT] -> 0x49
> "224"=active
> root@cubieboard-ng:~# gpiomon -c 0 224
> allwinner_gpio_read [PH:CFG0] -> 0x1061060
> allwinner_gpio_write [PH:CFG0] <- 0x1061066
> ...
>
> The CFG0 value on the lowest nibble changes from 0 to 6.
>
> This patch set fixes that behavior to expect that pin is configured as
> EINT in order to allow interrupt-related functionality.
>
> Tests are also updated to reflect this change, and a new test for pins
> configured as input is added.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> ---
> Strahinja Jankovic (2):
>       hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
>       tests/qtest: Update Allwinner GPIO test

This series fails "make check" when patch 1 is applied but not 2.
We need to retain "builds and passes tests" at every point in a
multiple-commit series, so that "git bisect" works.

I would suggest moving the minimal changes to update the test
to match the new behaviour into patch 1, and adding the new
get_input_pins patch in patch 2.

thanks
-- PMM

