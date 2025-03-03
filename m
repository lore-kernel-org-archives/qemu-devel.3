Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D869BC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 12:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp56B-0007ip-Ky; Mon, 03 Mar 2025 07:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp54T-0007WN-Dc
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:39:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp54R-0001AP-53
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 07:38:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so10830045e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 04:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741005531; x=1741610331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F4UYeXdqwyctSY62KBMASteRGUXei+yMQov4/X3UKu0=;
 b=HpwJLdmtjy6gw4c8vje48GE2K+QUllPdirGz02ahWW1jYJpaLk3WtuF7ImzyGoBNJT
 oqeQzVRcSq6QRKkWUcfcaCo2cbWa243yXMLZyAvjzaagz9Iym8UpkziUo40DNNeoBuwY
 tNvNvtm/FjqzmbKnUNlaDSs3WtRFFQvUUVDN6WVTFKBP2G2xjKMp7J84ZsZgdABEtRU4
 Eg3cBoHZ+labZfdH95YcjJszMZs/ha5bQ6/+jGsxEAkakkNBn3Wy96EtZ7WVQdtTBc9x
 VgSHwNexm4mjZPi1QQdretS4VZ0i0KwIEORJjqLcgmnmn4SM6dJnCgC8WRM5T9tD4G+t
 UOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741005531; x=1741610331;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F4UYeXdqwyctSY62KBMASteRGUXei+yMQov4/X3UKu0=;
 b=GWoXFTITZpWqM08KsClDzPV2Ogk3VIFj8pxOLSBGuNwuVPgpAUxL1IxalDu/+UwRZI
 86kvdUtiHUPRxQOGcnKt/hAh6atXqMWEePjGhpq4PU82e7bQw6ACh+vCgCdGrIszx2bb
 sa3SAIuCDuGsjm4m1Y1Ebm7x3Krd8ngrWbE4zPSJEMFVEjJLmGVgMaLbxFmC+RzuK+lE
 /ODzpD+RB7pVEv/NyNjeKoptuTeOL8FxD9VTE3mgrvKrMnYjxH/Sb23WzG1IFM7rPk6E
 5tEgwA0N4o4zfeVG17As3dJyfSzHK+p9eqoFBDXEDbH01RC/xwXg142FU0opNeLBrFD8
 /NLA==
X-Gm-Message-State: AOJu0YwpxHbgcjYDUhCVmP+l+PEjCIhUUvRUSdJT/dRC+ZDuyO7jswiH
 dsVN2eccL6UQ79cLyzwGoBxIfmtptkxeM8LaLg8FsJvRPZdfCRNwPVC64mvNeQaTl3D/Mf9Paak
 feZjfLA==
X-Gm-Gg: ASbGncsd0UjhfQEdHftTO9XXGqatbUwuDOf0NFE/dVg/F/LdTaplmJOBVVU8p+ar6Oe
 bL/YdQQ641GiW7RN1xPsqqKWQNhh4HtgJ9UdPXuEl9nBqtFTvNOeI4wc7Jh+GdiCM+mCKIvYouQ
 s66Cbx3+GNvtw4rXCxkNdsECmkoX5ZilkpiEYPdSl7XdMkCoz50iZlgZ+DDLUpsQ4ahtOf9Es7k
 maishhP94b8kMkvEwubQyeoHFA+2ANQ8llAAD7lpWmkpVKLomi8R4+ZAZAXl2+kl5GVnquv7YoM
 FGRv7/Z2TkWtoXlwTFxa+m9KKNOLY7l2DANa96ZFPaL1xspHySR/k+OJoQnzkMl3apvRe6DAXzH
 2bN+qlE7ysho4
X-Google-Smtp-Source: AGHT+IHUHlQ/5XUXQcB00VdgvQQSxddXSD+g+DDVekgzd6TlgCOMDZ+5L/jn01FUyxiFpvTfKOf+tw==
X-Received: by 2002:a05:600c:444d:b0:439:96aa:e502 with SMTP id
 5b1f17b1804b1-43ba66e6317mr137315605e9.12.1741005531415; 
 Mon, 03 Mar 2025 04:38:51 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844a2dsm14434172f8f.72.2025.03.03.04.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 04:38:50 -0800 (PST)
Message-ID: <f6c0ba30-ee78-40f0-ae11-dc7c6abf30f9@linaro.org>
Date: Mon, 3 Mar 2025 13:38:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] hw/char: Improve RX FIFO depth uses
To: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20250220092903.3726-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250220092903.3726-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 20/2/25 10:28, Philippe Mathieu-Daudé wrote:

>    hw/char/pl011: Warn when using disabled receiver
>    hw/char/pl011: Simplify a bit pl011_can_receive()
>    hw/char/pl011: Improve RX flow tracing events
>    hw/char/pl011: Really use RX FIFO depth
>    hw/char/bcm2835_aux: Really use RX FIFO depth
>    hw/char/imx_serial: Really use RX FIFO depth
>    hw/char/mcf_uart: Use FIFO_DEPTH definition instead of magic values
>    hw/char/mcf_uart: Really use RX FIFO depth
>    hw/char/sh_serial: Return correct number of empty RX FIFO elements

Series queued, thanks!

