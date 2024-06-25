Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858A2C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4Zl-00066R-5m; Tue, 25 Jun 2024 07:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM4Zj-00065l-Fw
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:43:03 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM4Zh-0008H1-Pn
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:43:03 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so5632949a12.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719315779; x=1719920579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lbhlHzqKAFNHgBfnOZCK8ziGh6lv0WMXemBIWKBjie4=;
 b=AZOwmSegoksSClxirEUwJgSyBuy33/gcyl2BucgytqlbW3V79pYrNYvxP5laFVPobq
 1hXpEDsUzL/G+QnS5YspTKie4CT9KnsPxp2hNae0DDkOGWCCwcPXtW93ryq9GkMJk75Y
 NZCaalQOkHK5Xhiz1pk3G9xY0hTQWsqVoxLqj2oNUZHbftmE5dZvsJu5fn30mana8gWU
 pz8144xv3abVcXgeRHyocnLFg7tYAkhRDPqTGpXz+dGJh3WvDITUmwv9o48EN2sQSfgK
 D58ZFHYgMWvxIBS6s56r2bQo47B/t5gp/KPp8Ny3Lvneb1IHNmG7ObZ8RT4v1SSygS4r
 6Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719315779; x=1719920579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbhlHzqKAFNHgBfnOZCK8ziGh6lv0WMXemBIWKBjie4=;
 b=thiVlE4AUeolTeBRhU5sOhaFiq7TlYOkU69pSH1c0VoXnsLBzntaAe6ADp02B1YIbu
 ujt8TSEQM4fcF2lNuswKW+FHJGmAY9lea0FC9RyM6SvUhxysFHMZZaswfX3FUxBBkf8D
 xh9Ny9iGDdGb5HGBuyJpIGPrTJkvyHHYvnG5fiktgMabcFYfCQW0CYi4zZL0NtayEqeB
 zLOMnK8wBzMUrSCsiz5E7Iq6ncSlwGPfW2oyzgco/E9ePIyAim+2gClevIZcVOQ8GYxg
 azUq1IMbWLoEcRd4qdLylu6A6ioMJG6Do7IMT04AikeaK/YBvUmdcPuNGoAFBc5SfHft
 SVRA==
X-Gm-Message-State: AOJu0Yx6Tlv0GABsPb29DMu1XF0T7QwAWNezieebaAJPq6Zm67h+GxN/
 svBue69HOPYrKgQejh41zt0Zedmsnx/juestvhXw3Bhss1dTa+lArd10u9Ndktm+jjI+TTbjWHP
 66O9ajmm6k6LyVlRTFhvGZGDXsfZogNH/gkm1KA==
X-Google-Smtp-Source: AGHT+IG2zbGjZDPwkFQkWWn0VEAnPXW+0Lfi+4LDDk0UZmc/9rC7vQX0WLGr/kkm/gKUuoqwVZ4c7pJA1ZlvtTUhr/g=
X-Received: by 2002:a50:f61d:0:b0:57d:5c0:9dc0 with SMTP id
 4fb4d7f45d1cf-57d7007f509mr1947217a12.38.1719315778927; Tue, 25 Jun 2024
 04:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-2-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 12:42:47 +0100
Message-ID: <CAFEAcA_cSXxr=6Ye0QvQADGbZKTmtkTOUQe+FsvghY-Cv+bRQQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] target/arm: Fix VCMLA Dd, Dn, Dm[idx]
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The inner loop, bounded by eltspersegment, must not be
> larger than the outer loop, bounded by elements.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 18fc2405781 ("target/arm: Implement SVE fp complex multiply add (indexed)")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2376
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

