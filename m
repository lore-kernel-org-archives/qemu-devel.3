Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3977CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxcz-0005VP-BN; Mon, 17 Nov 2025 06:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vKxcx-0005TX-4X
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:42:35 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vKxcv-0002Zc-Lv
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:42:34 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-78802ac2296so39227627b3.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763379752; x=1763984552; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UBxkJwjosmQ014MCdjMhpJyjVPKexKK0fujxek1a/vA=;
 b=pjxARpIEG6dMNBRbzYeON92GhD7rmObG2tUTVYoOZzhN2eTp024jVkTAXgOsBwwt3M
 bdlkiMh/jsq5LXYyLYZ+spRER/5ptd+y+FfbeaB7lvo1n8JYoKYQH5XlpV+Z/JZo4Hos
 ayBg7mNsPp800Tr+hRBfNhy5ehGZ8eOFSwDr/RjCnM95YM3CKxJP1J0dUcarPvAFgBSz
 3gsA/5JRuaiCyr5kwDZ6CczGmLweZgdFmbGLSxva8PMklzi6YG2W1alVbCq3o9qW2BwM
 yyFdY5ranj4AS512pjDd9stGEz0ABi00PKnzK/KCqsCiy1nrkNuKWZsJ4/R9xZxrkYTm
 +QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763379752; x=1763984552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBxkJwjosmQ014MCdjMhpJyjVPKexKK0fujxek1a/vA=;
 b=pyyuVwbYXJReKfpGbveZsoFyp8UyvhpiCAmuobAznkTODhBUiolGSUN27tDs5JhM/X
 apnxFCYfw86zC6xcggjopSrXFtUVZR2Hhv6bGbocZacKizZvsUxJjXVoqe2B+GjVjucZ
 JbjJtNqInRlToeEMON+OitI5qPNt3NKebClMB4UHgmBuYWRy6wO2KYwFZfVvknF0mprO
 CQZA1qveQA6ip7Xe77twcf8FFz/XQ0BCi6DFZ8ySRP6vP7TE4KEsc4I8kdz8lQZ2v5zF
 lniuH17i3nkqhFomklCNPW6G34evp3cBlhtAXopArXjG4euLYjf1x1RUu1brD06gZ5Xa
 CBfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtwosdiLZ2HN3wjzpieZC3zUWIALpM3SG3r8ATANA5QOE9T6ve4j8Qk9E+fPnyrq2K3geSpUfgnkzh@nongnu.org
X-Gm-Message-State: AOJu0Ywpd9GkZXaWv03aqHVXxSsUObwFEpTzoEFcI0zKWm8lIvhl84K+
 RrK/SAYLdIXL4mXT9T4FgDNLlF/Haxl5sF7shw1rZYHP5k5bnH4JvSlGbOnno7SC1NgPYXqnVmS
 m7LSxdBRf7zVGWuwk1VUEMgjGA0YAQl/leLvnpZ6cDcfH1rYw6EhbEds=
X-Gm-Gg: ASbGnctj3AunvH9vj3dyYYUG/xlru+sSMqbR+mE6Mc5tqHuOPSVdDsO1PDXucrECDA7
 VBJqJxbE0AshjejZdDeBuhN1cY+ScmVG7pAcDJ2iSydah8tCDTPU6ya7+Gl9QGIAqk+VzZMITQr
 7k5hPM/Gs9YJ0q6yud7hAIOP3u7OoFuzgIdJ9LaaOOAzskpewXckZBYs2HaZtFz/dEtb/NVZQgW
 0dwUxnJbHHw1FaNrJmJGz0lm8Hl5CtuVedphSVwPsqjoTncIFTGBpsgHo2n1udWRL/g4JLBkL7w
 4deu26M=
X-Google-Smtp-Source: AGHT+IEiqau49uMwrHyM1+PwgTncue4WuO7dP0MDrYg2HnE0Je4/AwGl1g5y+4RUyQ4arz0xwZExNuX+hYPt12z7X3Y=
X-Received: by 2002:a05:690c:385:b0:787:ec83:5d0e with SMTP id
 00721157ae682-78929f33136mr111459187b3.60.1763379752272; Mon, 17 Nov 2025
 03:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <f495c43b-3d35-4763-853e-4e70428cb666@tls.msk.ru>
In-Reply-To: <f495c43b-3d35-4763-853e-4e70428cb666@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Nov 2025 11:42:20 +0000
X-Gm-Features: AWmQ_bm_-I1x2TYm0dlvlNQz1U1wN0RiaGYAYxMoKXHKcfFkznZRJ_uCd94SKnc
Message-ID: <CAFEAcA_8DbBoQdxRzqedssk6hdKrCNSVrO8i6iK4o5SWrkrNaw@mail.gmail.com>
Subject: Re: [PATCH 0/4] linux-user: fix several mremap bugs
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Matthew Lugg <mlugg@mlugg.co.uk>, qemu-devel@nongnu.org, laurent@vivier.eu,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Mon, 17 Nov 2025 at 08:40, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> A friendly ping?  Has this series been forgotten?
> It looks like it should be picked up for 10.2 release.

No, there are review comments on the series that need to be
addressed before it can be applied.

thanks
-- PMM

