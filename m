Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F41CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 14:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKznQ-0005Z4-Am; Mon, 17 Nov 2025 09:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKzn2-0005DC-Br
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 09:01:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKzmv-0008M7-4h
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 09:01:03 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b31507ed8so3467831f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763388057; x=1763992857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=brg7uRDq185l2/5NDQjHWbT0l/Th4/sFLDv0ZLlhKEY=;
 b=NO6/HxwcNa505VtUKZqyjpxDioLMkFLsMFdQ/bR0RfjFosiDQjVZrxE5zf+AdQmFC0
 6sW7W59WpFAtkr9VGHPHlL33rP56pgOEjCx1l9THJ2WmDAu6KHjuO7Hn8CT7aJBJ7JYQ
 mZlai7iXC1tmqqQH6iLWE5yxJ1F5r05YnsSTHDOm2toS+7baFQj/YtbkXHZsQcFUYVRn
 TdZMTuTGtP5T4dV26Wb1IdE6EJIAfcZCmzQH7nQeXTWIoFYabtK40gXPoNWDxKKDAQfG
 01h0/tByaJZv8/6LsO49UJ3cXTsTy53IwHcoEdoTi44LS2U1c2dev5MesCfRsDiIdqRe
 ATAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763388057; x=1763992857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=brg7uRDq185l2/5NDQjHWbT0l/Th4/sFLDv0ZLlhKEY=;
 b=hfboXk4xwgGJ93uYD2fQ8IjGYBVvRde70U82wicvZvW4VsHdIakMirSGbPmxWy7ByH
 vK2fkzT7FAUjqUrBCMvR1uTPsrA7XQ/dCFSDAk9PCZ/4O3vDhMsDZnxprzW5N0TsLo+j
 HRsEwABlYcLYAkITctbEinjjy+D3QTWfntDdcn+coP9wJQNe5HtM14kE6AcIfEH3DAD5
 ffytrgnVyo14G21ExwqUoXxCfD79c333UFQ6gYXaSUlmViIsHr6pyjLe7Kpk3PVR3fgG
 NG6RdcdOWKC5de9+EUFx7yc7SgWs7GCHx1AOyFDXq8JxJ3mp9nP4kFUdtumHNJZ+4wQN
 zEFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvEDgG9poq9iktXPZT1H4AAzsDmOUXzyKhn+B9c+pE2/R7is9O38TdaoRH7Pbs99nsRzijg60PY7Aq@nongnu.org
X-Gm-Message-State: AOJu0Yz4tg63lxujMXGcaLBLPWK4yBDHzJ6yEk0pjai0Cas2CaFnEdFw
 kgmteCchwAd0QYy2HbZbRfj4yuR/E+hBfIXDTqwrnHdoJtFu2Q3nzhRXkXHkJ/lkDO4=
X-Gm-Gg: ASbGnctECLW3oxSKV3zwF/ATzvwN1bN1xUmUq+rIqx3ny2y2tjWt0VQKLz8wgNiW+wz
 GUNZQoUQrjlR8A5x1qwHWPHMFX2QzYehJXl+iZK36imhvOWCQhbZmxBgixScvbrY9uCJyqqgDsV
 4SdTFs1QOy/jmGk/4u7BUHk8d+1ynDchO1e8Rp/Q7YgMkSe41+qYtAS3Op+DTBelOh4bGe6hsnK
 vz8bhFkAisPYJvPH/1u8kTUseXoeWLK3u8zy5GSuJgf8IhGmfAeUI2T2u94REByDG2F93WM84Yi
 orZXDed0WmamhqF2BQ/QlIqpdoI3st33w/trPgecV3STihDmPw7KIdS02ZDmwvS75B3QFWh/Fb7
 m0ZJGcbCfd1d3c+7RHOHT760TGKZ4SzGgF9fha+7bdIa+GlJibCGbNon9yPMrU07v358m9NWDlI
 wULuSJbbqxretYZN37XgyKzY0/THt5F9nsES7qJUbxiB0prMRMnZlqUw==
X-Google-Smtp-Source: AGHT+IH/7gI+UQRTQ+3MAGm4CKJ44DTKp80MRvjqQ61BvMNJpYeRjVF9+IJInJirojuzS6MFtEw1+Q==
X-Received: by 2002:a05:6000:25c8:b0:429:c851:69bc with SMTP id
 ffacd0b85a97d-42b59342f3fmr10029042f8f.8.1763388057404; 
 Mon, 17 Nov 2025 06:00:57 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b894sm27018673f8f.26.2025.11.17.06.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 06:00:54 -0800 (PST)
Message-ID: <0d18d036-f93a-4874-9306-ec769cb375d2@linaro.org>
Date: Mon, 17 Nov 2025 15:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/18] tests/lcitool: update ENV stazas outputted by
 refresh
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Thomas Huth
 <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>, Gustavo Romero <gustavo.romero@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
 <20251117115523.3993105-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251117115523.3993105-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Typo "stanzas" in subject?

On 17/11/25 12:55, Alex Bennée wrote:
> Now lcitool has been updated to use the non-legacy ENVs we should do
> the same for what refresh adds.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20251113102525.1255370-4-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/debian-amd64-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian-arm64-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian-armhf-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian-i686-cross.docker     | 4 ++--
>   tests/docker/dockerfiles/debian-mips64el-cross.docker | 4 ++--
>   tests/docker/dockerfiles/debian-mipsel-cross.docker   | 4 ++--
>   tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 4 ++--
>   tests/docker/dockerfiles/debian-riscv64-cross.docker  | 4 ++--
>   tests/docker/dockerfiles/debian-s390x-cross.docker    | 4 ++--
>   tests/docker/dockerfiles/debian.docker                | 2 +-
>   tests/docker/dockerfiles/fedora-win64-cross.docker    | 4 ++--
>   tests/lcitool/refresh                                 | 6 +++---
>   12 files changed, 24 insertions(+), 24 deletions(-)


