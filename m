Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350ECE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV5P-0001hh-D3; Wed, 08 Jan 2025 07:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tVV3Q-0004zg-4q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:20:58 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tVV3K-0002zb-VI
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:20:53 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so23647645276.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338848; x=1736943648; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eVYNppgdcmNt0E36IRx1GdDa33vA2v3mTMvFF0T6RpU=;
 b=T8FSWFKy+p2Js7udzIy/+b9azRbklXGCl6YnNe74yIkGi56WaOHsmZmOsHE5zpzwTf
 ii0m1c+KUWMtbh36FcHgbsppTZpBFeXHSqb2qvXgVp52ezrDwXwsHXuNXzG/H4Jeonrr
 RUi4Y/FQ6pPZIywSTS6FWMZouJzS3ioIX/bOBJExe0Mi+WCjjmKtPH6z6kKjOnN9BWTH
 qvgJHtDc+r0OoybzdTH9v+qmITVzDc53gszcfPzL+/UXuuG9YLP2rvReYq8Qq3/eGgOV
 x99XvSt0vflTLIWK61AFGKoAZLiJfO4EX3LvZ5HzTTTi4p2y7ua8ZP+AwyOsqfOoZK8i
 2zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338848; x=1736943648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVYNppgdcmNt0E36IRx1GdDa33vA2v3mTMvFF0T6RpU=;
 b=pEICJKfGPPGJ/hKJVpGySC+jMs+P5UZZbgh2uHptAJh6YnzN6kuynta6uVlYuzAD2g
 8WpKEXseOlnbEfXgB6bG15kRcTtN7jiLEYT3S1cGr+EtSEVOOkJpkPQpSDtafIrIJqNj
 c8kqn5SwxY5g2lcT784pW7SDwHGsUmH4eZNBQ0SbHEAeCVj/Z9a8vGyap8LC5t3qC0au
 Yks+OmpemyZ4tfVJe2bwlf6vsFmTsKNogk1K9V7QWek5fpFTiIgelskdfCm303BINE6S
 CbzwJUduovoM6Y+KfHzVyXJz87J2x82HR/zEsFPoRR+oTlLazte6vBzOWSylDxUwJcc/
 D0CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd1ESN47/YTX/Rybglb6hN4yaeOxR7EEp9jH0CAzKapG+Fq7Lh/gD2NUAAbqn6EUlQ2oNw4dTj1uru@nongnu.org
X-Gm-Message-State: AOJu0Yw7kTqzFUiFGOrX2Tx9UJT8nh3o+e0Jk2zw/9T0BWUlSvBVcs7I
 qZ7Sw+5zaSruCDjMftjhCk4KsLbM2A5j7NMUPKubXkIgsnQnFVSmufV52LVPPHChu9JnLsb3gD1
 Cas7LjtDUOfnN6WJSVP8k1vEm23aewSHiYIZvYw==
X-Gm-Gg: ASbGncue0ZSS0PscnWQ2Paeh5fQzOhEVY6nTVxXqqhK3Zmoyixt4ZdStNGlwedCJbbP
 gjRgBWGyoaNrSPpwG1oylo9DEkNMQUMXNLoO2duo=
X-Google-Smtp-Source: AGHT+IER7AkRJgnFq6JGq8eSOOWVIGOxjcgjO7ia2qUwMlU3ag9Nm/V+/LAiCe4q/tRrN9BDq3UbzTwG9KEfgt3O4cw=
X-Received: by 2002:a05:6902:250f:b0:e4b:f516:38b9 with SMTP id
 3f1490d57ef6-e54edf26023mr1519070276.8.1736338848391; Wed, 08 Jan 2025
 04:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20250108100240.960593-1-clg@redhat.com>
 <76dfa092-7d20-46db-beb1-43848cb5ee4f@linaro.org>
 <11cbdc49-668d-4f73-b5a8-cdaa4c85a756@redhat.com>
In-Reply-To: <11cbdc49-668d-4f73-b5a8-cdaa4c85a756@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jan 2025 12:20:36 +0000
X-Gm-Features: AbW1kvana2YdQJPRAzxibeoZgi-2bIsicbKCJJmX-xSjWkYJbfeXOq3wqz6eXpA
Message-ID: <CAFEAcA-RBBiffKn2WrhurmRri3vzxyPSiUDvw6q8DJ4pW-nRnA@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/sdcard: Remove sd_set_cb()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Wed, 8 Jan 2025 at 10:47, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 1/8/25 11:43, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 8/1/25 11:02, C=C3=A9dric Le Goater wrote:
> >> Last user of sd_set_cb() was removed in commit ce5dd27534b0 ("hw/sd:
> >> Remove omap2_mmc device").
> >
> > https://lore.kernel.org/qemu-devel/20240903200446.25921-2-philmd@linaro=
.org/
> > ;)
> >
>
> Ah ! good. I was wondering what to do of the '*_cb' IRQs and
> 'me_no_qdev_me_kill_mammoth_with_rocks' too. You dropped them
> all.

Yeah, but we still have a caller of sd_init()...

I was vaguely planning to do the qdev conversion of
omap_mmc (should be straightforward since we now have a
functional test that exercises sd card boot so we can
be confident we don't break it in the process), which would
then let us drop sd_init() entirely. I don't think this is
much work, but I don't expect to get to it this month because
I have a chunk of higher-priority stuff I need to focus on
first.

thanks
-- PMM

