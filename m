Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D276FD44D4C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 11:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8e0i-0000ol-Jr; Wed, 06 Nov 2024 06:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8e0g-0000oI-IH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:15:38 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8e0e-0007y9-Ny
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 06:15:38 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so1355393a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 03:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730891734; x=1731496534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uw1uedBCH7d3arn4ihZmN6uaU48oZb9MqZlkhqdgoGs=;
 b=vYZqfJv5814gB/Twt5g+RZf/G8Jvc3dI8GXWpt5jhLYQFg48Tetsg0y/XJcnJgoOY7
 C32WgYkE209L+1ze2mMBH7s92HinaxqQyaKj2GdisrH1AQbxHPeFC5qUzVg6cz1hV+2I
 /z9VDyuv+dYWGQTkRDhNohOC22Oji5/3gJtdt2EbMuL7Cv5QpaSesHxKbo1+xwO7HNeN
 pcab7heh+YiLELDJj4MYERCWjm7tDMqi+ziy7XC6vd2ewjZCAQQ9Z2KsrKRQylf9kYSZ
 YAfmOWkxZosrcBMGdcrW/hwSUNLxyYFWaBFIhTv7wLY/lDkI4n+/lgdwfW28M20cBkjY
 QYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730891734; x=1731496534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uw1uedBCH7d3arn4ihZmN6uaU48oZb9MqZlkhqdgoGs=;
 b=FG+cauAJw2+SJ5Rinks13bx4SB8bxcIkDXiybpX0EkC9cLDt+v8Exe2tCqMQMJXL9J
 u/LYvlA/SdHlrUpJWimBswaONGVGkDi/LyOZx4Ja1bwlwfLtjmS+PMsEjto63OmkcNsy
 zuL1OR1lnFxTJiW+1oyyy8VnwS9otJkATjmwQy3rCYeJKKU1EEtgS4T7vd6Gh9KsNubL
 rTM+uS0v7A2MkoOpkzliiO7ctnAS9818kxgcyA1A+7Q0/M97xiLCr/9mzooUAJIkgTyt
 nTrECwWL1e3Ph6R+QozNp4q5sXYXlytbfHk4lJNqL+LNHa++r4duHed932Os8o2Xp4d6
 Urxw==
X-Gm-Message-State: AOJu0YzgKLROtq++FwAR16e2uHusFReR0WPBHJh2ELfi8V2bKRR0kC53
 fmIiIDf0GQNudQ4PK22mB+PChM83DQxRALeHQj6wjavlLCXp7VnFJLqEczriYgnI04hW0yRXD/u
 oRDup6KtKYcCPZWT6uJN/zxPXWyRNpFF8ZGGOeQ==
X-Google-Smtp-Source: AGHT+IEtb7qvCe2SbI+0EOsqD01CvPTAHHUV5ORwWjrODgtZE0FYy3tx0JiIayuBtYXgfo39nQXyrBGTzDKTNfhoEgg=
X-Received: by 2002:a05:6402:2806:b0:5ce:f9df:baea with SMTP id
 4fb4d7f45d1cf-5cef9dfbb0fmr677988a12.7.1730891734206; Wed, 06 Nov 2024
 03:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20241105104333.2534823-1-alex.bennee@linaro.org>
In-Reply-To: <20241105104333.2534823-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 11:15:23 +0000
Message-ID: <CAFEAcA8nNhTrvDgGZDJhhxdgfHQ2C2Gq8t60MuD5mz_b0FJqDg@mail.gmail.com>
Subject: Re: [PULL 0/3] final plugin updates for 9.2
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 5 Nov 2024 at 10:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit daaf51001a13da007d7dde72e1ed3b06bc4907=
91:
>
>   Merge tag 'seabios-hppa-v17-pull-request' of https://github.com/hdeller=
/qemu-hppa into staging (2024-11-04 16:01:23 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-plugin-tweaks-051124-1
>
> for you to fetch changes up to 55c84a72aba4a9406320943e6348bb120c2df08f:
>
>   contrib/plugins: remove Makefile for contrib/plugins (2024-11-05 09:13:=
51 +0000)
>
> ----------------------------------------------------------------
> final plugin updates for 9.2
>
>   - fix a warning in cflow plugin
>   - replace Makefile with meson.build
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

