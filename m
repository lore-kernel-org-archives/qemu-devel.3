Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2810BD44D4F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8e17-0000r3-3J; Wed, 06 Nov 2024 06:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8e13-0000qI-FP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:16:02 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8e11-0007zi-OG
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:16:01 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so1330263a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730891757; x=1731496557; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OBSek/wfNG7YagJdHahxQZMY3bUzYETgQTN3aI/Tu6k=;
 b=XeGAvrOZ+9fgaAelTG3faat/iGFuqOjiVwIZtNNDDtCHCNhopkTMvy2LV74QtPon4u
 58+f5bPZdDN47T/U9WiX8DatP4bdAhfTy98QvZUiD6/bGP+k0tJ6LPHJjuTQcYZzHe/v
 qu/R0lrlGs+IsjIZgyQa+uWKwMkd21oFsqM3RY6E7xMA9H0Te8S0pD78OPRgvydDv4+t
 WFxKerfN/9QVlTV0b1vkIOLPRTww5Lm9hjIZvLiTis3vSsDabiVrzAwTE8LKblVHK2OG
 5n/2KxkyacnZC7j2u31g9JZlgBCbnU8rgP7nGc0jAmSYW1c1AY/xi/G+g+LvG8mX2PYV
 cB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730891757; x=1731496557;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OBSek/wfNG7YagJdHahxQZMY3bUzYETgQTN3aI/Tu6k=;
 b=AwJfztWWy/PEzq7m79807n+uvNC4Vu99iALo3ZifE86LtKBWsVFtvVXdK7G/Tphq5r
 pBebFV9oZXA4pU3kGZ9cC6iwZf0TqtqFOkeNI1LVLVIBiz0Qz3I3Na01UL6mdKpjEH97
 aRnGVptkNHjmE8akvbQHjwb2j9ALYe+7l1TYX2dLazAzN6cKba55hvXVwnhS1yWc+5nt
 PBXUGsIkzaHm8w0uaCA9r99Vo2wdB3Dnpt+ya4MOWNUnkOoYIcIvkd6jZOm7xOE0Z/e+
 vVkr+3ofdM5GBXYsQxFqarWNbeiheoIl4Kt8jJM6IWTStYGkwcqWuasaOnJDHwRmWT5s
 Y+7w==
X-Gm-Message-State: AOJu0YzVJzOPdB3iU71SWFZJOhGJ0lApYSzwKmCNiVNPeL99B5p06rSL
 1qfCHE4ceNG916SZ3qjRfTgTLoL83BhbfrYP52m1LeBHyVurw1qJeAE3Q/nf7HzTJqukBwCkTcH
 sJePWTSQlPDVGewNEKvDkLUUU8wA963WulwLb3eyAzwnLzjNF
X-Google-Smtp-Source: AGHT+IGtB37RmNQO9xoo6Amo2Ibfsk+sOfde3Z/nBOl8oFwddL6Kqcvw8nBgJSjC34kM7k/hP1Dm+eRwIDCKV1DFXHs=
X-Received: by 2002:a05:6402:50c6:b0:5ce:e5be:d042 with SMTP id
 4fb4d7f45d1cf-5cef547848amr1725760a12.5.1730891756020; Wed, 06 Nov 2024
 03:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 11:15:44 +0000
Message-ID: <CAFEAcA_WmbyGGtWGyyDyAi7xyW75xabKv3XGD98eqj3unmLFpw@mail.gmail.com>
Subject: Re: [PULL 00/31] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 5 Nov 2024 at 11:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 11b8920ed2093848f79f93d106afe8a69a61a523:
>
>   Merge tag 'pull-request-2024-11-04' of https://gitlab.com/thuth/qemu into staging (2024-11-04 17:37:59 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241105
>
> for you to fetch changes up to 374cdc8efe4a039510cca47e8399d54a1aeb4f2d:
>
>   target/arm: Enable FEAT_CMOW for -cpu max (2024-11-05 10:10:00 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Fix MMU indexes for AArch32 Secure PL1&0 in a less complex and buggy way
>  * Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
>  * softfloat: set 2-operand NaN propagation rule at runtime
>  * disas: Fix build against Capstone v6 (again)
>  * hw/rtc/ds1338: Trace send and receive operations
>  * hw/timer/imx_gpt: Convert DPRINTF to trace events
>  * hw/watchdog/wdt_imx2: Remove redundant assignment
>  * hw/sensor/tmp105: Convert printf() to trace event, add tracing for read/write access
>  * hw/net/npcm_gmac: Change error log to trace event
>  * target/arm: Enable FEAT_CMOW for -cpu max
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

