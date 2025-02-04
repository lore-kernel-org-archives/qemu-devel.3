Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C52C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfLB6-0005g7-LO; Tue, 04 Feb 2025 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLB4-0005ai-8A
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:49:30 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfLB2-0008EV-FM
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:49:29 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so5869908276.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738684167; x=1739288967; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gx6h/sKWlMPC8H6OLa3HGlBIfvFzU25N9x7MCpmX5l0=;
 b=v5L759CmzobfZDNmGudYEuZ43xBu95hJXLhrjmwfxcRpojAPFdRlft8/h3rSPG7MfP
 uliJq6BgAOXzJGlsnhuFW56UElLojXXpJVAQNh0J+HPMMxZVYN+JUV7ENCSnhgfg9PoF
 tc2tncA0kwuR4bo9QZRPjWk5vaJfNkjLDLyP/RFZx8uHuqqubA06m5Gzaxi19Y5fEATy
 oLg6A6ylcSw7QBOBDiNBiNhhTZ4yqFVl1eKl1b8HF8/g8Og9XdmKQLWRo2GnmjcBQXSB
 qzysI8W7gm7XJHcZfzn9O+doqEuKKotMiFAoRfi7k0fP7Y/mrVyjQ4+9ariTlDFAcaNm
 gvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738684167; x=1739288967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gx6h/sKWlMPC8H6OLa3HGlBIfvFzU25N9x7MCpmX5l0=;
 b=gPFIjg3X2hzsEL/ARt31UiotPU4hjr68cvwPyxLuU14LYRig0KoRQEWKW6a7LOmaSi
 Vf45UzLx+O4S2/79FGXj1jahC4CQEDkbqnb5bmPDKpMKSoSjvM1JynQNKMc6UIuxuCPC
 D3NSs1HyD+4ynywkHibPNskt05G5nzjmTXMGT1xNs0npgsYkIUqmNxRofmr6cK2Vftve
 I6Wu4M7X8WDx6XC60ARfeOxsw2MszgBZpPVYYYovC9+zIXrhaA0J53SHKBaJBS5ySGPe
 6nKajsJC64iFRfZeZ1x5KTG4rhd+vDYEqh4ocxyKCIDe93yTfbu9ruMNS6q9KmlWTSRY
 4U4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQlr/8nl4mLXWFbKZGdbmjr6/Ne5Ft6JEXjHZ2V1yY3jrn6b7oL6eKtu4boJRD8moDXFZToJIeOP7m@nongnu.org
X-Gm-Message-State: AOJu0YxhVZASUtvvHkft+kmGfKWgFNfH1FeJB5ltLls6lbhauPYrHXt8
 SUEmfj4oT0pk84HNi/q7u0BTZYwyZWvI67Tx91634eQTp7X8WN43Gyab3i2jWBq+xgdJ15V6XH/
 ANwbuq+k0uXPMYD2murgUu1LjX7mZgvhu85swhw==
X-Gm-Gg: ASbGncuALNkP+2LjVMi77dqnuY5FwWNUntv7gHtc6ifOdTsVxTq2TDQQBkm5r+N/SQm
 DSYWsDZ9bZjlPBLJP9XDsja0vBw4ghr5TJaopgoNBhWQKKwO9GpT4OQqxal+dwieCItYLd3/kbw
 ==
X-Google-Smtp-Source: AGHT+IEfdd9R8+9ZyToNS06X2RlyDdZsK1pwZAfDnWwxpwyqZ0JUd1dZAMX2SoyX+VyBLWsRfShOr890gBqSYYAjYBg=
X-Received: by 2002:a05:6902:260d:b0:e5b:12f7:cdb1 with SMTP id
 3f1490d57ef6-e5b12f7cfe0mr3789121276.34.1738684167193; Tue, 04 Feb 2025
 07:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-9-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-9-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:49:16 +0000
X-Gm-Features: AWEUYZmL5M92dUsBRhXl5g0IjyjiLhFUK0vBG-J9ehpVqZTt2qpIOOGPJMSc1pk
Message-ID: <CAFEAcA8Z=kTymMs1YPFUvqgr4sgNg0R2nOfKzyM28YUFikqT6A@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] hw/misc: Add support for NPCM8XX GCR
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/misc/npcm_gcr.c         | 131 ++++++++++++++++++++++++++++++++++++-
>  include/hw/misc/npcm_gcr.h |   6 +-
>  2 files changed, 134 insertions(+), 3 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

