Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07B8CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZsN-0007AL-Vr; Wed, 22 Oct 2025 10:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZs7-00073d-6U
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:31:32 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBZs4-000510-Mr
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:31:26 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3c917ea655bso4564647fac.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761143483; x=1761748283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTMMM1abis8wKKlNpR9iDknabGHb/qjIKHrlZwMyg8Y=;
 b=pfOiNucl/IE+WwiN4GstK/gb5e733JYt/d9A4vdXG0PeqspBkoOHzC1xAev47Fc+p+
 Wx1anyNXVq3vo0ULGr8SDi1C8RiozAo8KwJj2oQBTptKLRgJ5C5OZtexOpJ6VOGndAtk
 01VPrSYIesj4kb6Sqe0mp7kai6wGmQJfQz7bPrXl/Gl5ET61dy7t7H83W/3Jo1H8WZQt
 Ug4AQW5ffeuuzQp51B0AYB4y+v9u516tWgQlwRfqD9PoZzAHMygLFK8h+jUywlLyqdJN
 207QL8ma72qfTGs1Vx0xVQvTtfy15x8hr8A5TFMTlZ9S6VxlJBvNmQjzIGG0m4AsXHYO
 mU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761143483; x=1761748283;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iTMMM1abis8wKKlNpR9iDknabGHb/qjIKHrlZwMyg8Y=;
 b=wD4pgzAhm4ZCprv0lrWCOgJWW2Fs2wWaitndIcFylVAR/Tq4mPxU6+1i6zIjhOMY50
 QX+hPNzTB09KIrBzXkyC1WIpZARVRoO2DBhe4Qj/PJFPmbSgUQotQAbey/PnOHGtzNA6
 RTX3frUBnHVG1QRy6JauDUbKmeMnqmU8A4fXioVqsDXOcV9eLbOOOOqTsE48Gui6xVJA
 txbzoet4LPzkuo+CLmXwpfI1FBMdiz/VDQOZmk1I/fioheVJptGfMFE/FTsDMLpVdZit
 Cvh/sPgkJaenjbv/dFBPLZ/WveY8pmUM/VGjjBSSy2n9R38MD/njrKWgBc4Mp0BkVuSf
 hAyg==
X-Gm-Message-State: AOJu0Yz77ZAzcAL8Y13JF+X9lZbqRMkfwYqpScCCtGmEV5XF9sRnS9mU
 fCxVlnoGrCuTrLondgW1kA2xad6ETtYNN0Quq7JeGMMqQ/z0WJyxOUDnzcuu7yNf/sPVWNvxwSA
 IPHRm
X-Gm-Gg: ASbGnctpP4pI7a04RwCIb4JWT+CK36pm9idsKugjAkR9cm/ozZSLXCTQ187l3Ujygv/
 bI5Zya94diaHoGKXO0zvbDOfEtC0o+i7EHurpQhvNWuOnIFQTAZB7G5GO+5TJBE6Pp+hINoEhMh
 J5yv/QTLiJ+IaXSkojKoUTc2JH+c2FgYXUxfNPI4nOFBigNUuWCJIs9Bvcu3Lsi9ApaLVh+AWB6
 1sGfuL2F0AbRvd8cZ21OcHak3Moi42+Vztc7rej76mZe1uN3Y2t+MyTIjGXs03hkHBGQe5L2kMD
 YqaNu0a8QM+e2SY5LRcW4uvZDsODjQFu7LENQkELE3JsN3ijtZLWk/LiVzMGlaIoUHolrgO6WHj
 oE6XjDdGAmr41e5J6B71xzQecjToK5blkuNCHbhngCtjn7dAyoJUQ2dV/rI9JdAD3vxOctqRtPm
 sXTOcLV6jr9q1B7s8Tv6J+x1gss2rjKTyPYtcDXQ==
X-Google-Smtp-Source: AGHT+IFvtLZEMZqUbkIgDSEQnbU9JJkQ538k6tog23KWoxS+/V5zzXY5h+B3WEbpZQXAm0Jqmu7nGw==
X-Received: by 2002:a05:6870:7a0d:b0:31d:736d:ebdd with SMTP id
 586e51a60fabf-3c98cf42e93mr8537369fac.13.1761143482757; 
 Wed, 22 Oct 2025 07:31:22 -0700 (PDT)
Received: from [10.128.41.227] ([50.194.179.134])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9aef54fb8sm3971499fac.5.2025.10.22.07.31.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 07:31:20 -0700 (PDT)
Message-ID: <4b01b603-0fe4-4911-9b0e-b345259e2834@linaro.org>
Date: Wed, 22 Oct 2025 09:31:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] aspeed queue
To: qemu-devel@nongnu.org
References: <20251022122953.877335-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

On 10/22/25 07:29, Cédric Le Goater wrote:
> The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:
> 
>    Merge tag 'pull-request-2025-10-21' ofhttps://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-aspeed-20251022
> 
> for you to fetch changes up to d7bd42a740d0e8887540d7b450d0bdb2d6ba31ea:
> 
>    hw/arm/aspeed: Remove ast2700fc self-aliasing (2025-10-22 08:14:09 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Improve AST2700 co-processor models
> * Add vbootrom support to the ast2700fc multi-soc machine
> * Bump SDK version to v09.08 for the ast2700fc machine
> * Add 32 bits property for Aspeed GPIOs
> * Change ast2600-evb machine flash model to w25q512jv

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

