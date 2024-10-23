Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DE2CDDE5D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 10:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Ybn-00089B-8s; Wed, 23 Oct 2024 06:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3Ybj-00088V-8W
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:28:51 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t3Ybd-0002CX-Nf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 06:28:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so1260037a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 03:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729679323; x=1730284123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Toes6rdBZiqjKLHb+Mgyoe0zFFm7Szb2c/qGWoXSuvo=;
 b=C7GAVAVfNTNE4dRVwfHFjxZTQXi4GY2KqPvl+yRJiiGoPqMJ4Mbf8SePDq/tsPsWjJ
 rhlxXfqDK1DZ5DevS3xjY0C7T7M8PIP5ShJEPN/Z1sYhrjFHd74vhQ1xb2N0b695kCK5
 Xu/qcd/lYI2ZYWsHLvrZuc0GgMwJSV853OFDqIp59xi4UhOl2RZpQQroS1cPfOREZRoI
 AwlW9f03+ERWnOdcQ+dtdRORJIlAqyRnS6eRvwhq1oJ5+81yy79yLhhKqSmKukZKWp+4
 lHFfMGlQC0R0KemgEzrc2fK4fFm8uUKPe9A3WtxoJovsNE2C3qYYpzNsPMSOYQCC4C8j
 yYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729679323; x=1730284123;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Toes6rdBZiqjKLHb+Mgyoe0zFFm7Szb2c/qGWoXSuvo=;
 b=to255YVP6Hximcxk3HgmEST5E1y0kZVf1ZElKQGRW2TZZBLdDUemWwAGwy98oish5H
 VHHFiQFIU64XPjyl1C2S3MApGEQbLuK/v2zbvVYlTRVqtz6XWPJTemo7FMKpT0WsPhDk
 c6frRCq0Am5NIwDjIJyz+8SRnkQXbCX+uZr1pnYfn2heJDIug54Ds7TRDb0tG87HBQpw
 K2OQW4qEJLZ2DrCYK20snwvZCFdyUCScKE7ARbsYz0wx/XJqEjygfRxOp4xWgoChBl+5
 QKLO3iw2YLzja3U6iqnqRABH6zLvGZmIrujcwP1Tt4HbbG2N8eGrI5Ew/75BGdzRJzQD
 qSOw==
X-Gm-Message-State: AOJu0Yx38G23dEtGQiAwisaBk7SA0RVib5P6nml1V2nG2B7UA2KiTCBJ
 mZV9eWVkNFXNVJyKbsRjMnBUjr3NILkbyQGvVJQez1je9kHV37lUSrRyr/1Q7V2UxNvKv7UqSjS
 ODd812cU+zETDLrl9TxiE5Gg5U3WPkKDeIIBq4w==
X-Google-Smtp-Source: AGHT+IHaQHTYsSR/6M0tqdPJYgovdog0uxprV1E15nlqSAliO8PzYeCxlR3h0+vQFSpPQpVbsiiLxDpBT2OSTUU1gA8=
X-Received: by 2002:a17:906:c150:b0:a91:1699:f8eb with SMTP id
 a640c23a62f3a-a9abf325382mr219903166b.28.1729679322901; Wed, 23 Oct 2024
 03:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241022085359.186470-1-pbonzini@redhat.com>
In-Reply-To: <20241022085359.186470-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 23 Oct 2024 13:28:26 +0300
Message-ID: <CAAjaMXaaRGXY4shzF_-9Mzhb69Bs5gEHuMHWGczkfmvGyfkPUA@mail.gmail.com>
Subject: Re: [PATCH] arm: Kconfig: disable stellaris if Rust is enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

Hello Paolo,

On Tue, 22 Oct 2024 at 11:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The stellaris board requires the pl011-luminary variant of pl011,
> which is not supported by the Rust implementation.
>
> There are at least three possibilities: 1) implement the subclass
> (a bit harder in Rust since the language does not have subclasses)
> 2) change the ID to a property 3) split pl011-luminary to a separate
> Kconfig symbol and leave the subclass as C code.
>
> Just for the sake of starting the discussion, this RFC patch uses
> the big axe and disables stellaris.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/arm/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index e7fd9338d11..d5ade150d23 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -219,12 +219,12 @@ config STELLARIS
>      bool
>      default y
>      depends on TCG && ARM
> +    depends on !HAVE_RUST # Rust does not implement pl011-luminary
>      imply I2C_DEVICES
>      select ARM_V7M
>      select CMSDK_APB_WATCHDOG
>      select I2C
> -    select PL011 if !HAVE_RUST # UART
> -    select X_PL011_RUST if HAVE_RUST # UART
> +    select PL011 # UART
>      select PL022 # SPI
>      select PL061 # GPIO
>      select SSD0303 # OLED display
> --
> 2.46.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

By the way I already have a patch that adds a -luminary version,
planning on including it with the rest of my procedural macro patches
I will send.

