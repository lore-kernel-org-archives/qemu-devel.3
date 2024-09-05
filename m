Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C085ECD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIYG-0005IB-11; Thu, 05 Sep 2024 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smIYA-0005HB-Gv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:53:51 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smIY8-00052A-Uc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:53:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c3d209da98so1574227a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725566026; x=1726170826; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+Nb2gsgSCazn1/c2pURQrPKaprz5UmqgtIOgW9CkTpM=;
 b=oXxYDP5Hs2DvCzJjMGN7s1ELaj8JGWD8xEBWEonjdnOxU3zReT83hFF7ewdhmZzFVV
 f2IYnZYa315nvgPv/tbGP3nA+iXucKWIJtfNKAIIc2jKxL6BVX4oXQEUlCMrgfN3D0CE
 kk7BXqWaaytAawGwMunWg2oxH9WtNsXfrHmTPY+HgWFWYCAiHIARh6Q05C+xbndPQT/K
 mkCdxN5bSp9Os99cigveH2SkWwfBYeCXdRE0YYxIukkcYR2wtHsKOa2w60uy9EDpackq
 +1UYagJXOM8fWqoHlL38XHigcj3PirtJLj0f1iZIYjy7XkHoGMI4xtbXGF5HvZ3fLiy5
 1PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566026; x=1726170826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Nb2gsgSCazn1/c2pURQrPKaprz5UmqgtIOgW9CkTpM=;
 b=Mq5Q2gjVn/cqyToJ57Ik9tNZgJBqVLHJz9LfdEp6mDaoiUklmnWFUUjEEDTzgntbdH
 CoZeHQSrUlqZbOLkr4yV8U9Kcom9+g/o8FQiS7joeGM1UKTFTJe3BQ1pGuEf47zdVTsu
 FKUIQc82aIYxswRUChBLY6BDOnEfTKX2JvN9OvHsnl0xTTKjeBzVpBzzBogt8U+RR5AR
 kVdMns7zii40vZaBtELsa+8LIqlPUNyoDLMApss2wmuniT++x4JhKU4dqdEIhg+nwQyf
 +0fcNnnvYZFrJlELEcYNDxho8DiOiLtViUXSz2c9YYJMV66c66wqp/CwlcG7Z3ZBg8MT
 rxXA==
X-Gm-Message-State: AOJu0Yyv9xrRN9HqnSrf3VOlW8C1wRcm3jYY5fjEenCerribCoAL5X4s
 xZkVG1AX6UID6HepK9weUhbIqjg3IMXCB4irT6TggnJMX5IO+vpVFTIxScjaYNw7+hk3LGtsiVM
 0a1df0ALLcsmdgERYDFsMaiOfKgHeqcrhWCPwaw==
X-Google-Smtp-Source: AGHT+IFb1V2AHBfQkeV/xGQQ9k7ryhd2VakZ4YP8/rHTas5ipkVsHGvmy9oe00geIP/WzmmM6lVbQUdPe/wA5DEddFM=
X-Received: by 2002:a05:6402:2089:b0:5c3:cc1c:4d9c with SMTP id
 4fb4d7f45d1cf-5c3cc1c4dbdmr5450500a12.18.1725566026209; Thu, 05 Sep 2024
 12:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-8-thuth@redhat.com>
In-Reply-To: <20240905191434.694440-8-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 20:53:35 +0100
Message-ID: <CAFEAcA8NqfTdHhCJo8QzPy=EJQYKm=9dCC41UN4K_2pqeXifqA@mail.gmail.com>
Subject: Re: [PATCH 7/8] Revert "target/riscv: Restrict semihosting to TCG"
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 5 Sept 2024 at 20:16, Thomas Huth <thuth@redhat.com> wrote:
>
> This reverts commit 10425887ba54241be1ce97f8935fc320332b531c.
>
> Using "imply" instead of "select" is causing a build failure:
>
>  /usr/bin/ld: libqemu-riscv32-softmmu.a.p/target_riscv_cpu_helper.c.o: in function `riscv_cpu_do_interrupt':
>  .../qemu/target/riscv/cpu_helper.c:1678:(.text+0x2214): undefined reference to `do_common_semihosting'
>
> Thus revert to fix the build.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/riscv/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
> index c332616d36..5f30df22f2 100644
> --- a/target/riscv/Kconfig
> +++ b/target/riscv/Kconfig
> @@ -1,9 +1,9 @@
>  config RISCV32
>      bool
> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>      select DEVICE_TREE # needed by boot.c
>
>  config RISCV64
>      bool
> -    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
> +    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
>      select DEVICE_TREE # needed by boot.c

This will break the intended "we don't need semihosting if
this is a KVM-only compile", though. Can we fix the
build problem use see with
 "select ARM_COMPATIBLE_SEMIHOSTING if TCG"

?

-- PMM

