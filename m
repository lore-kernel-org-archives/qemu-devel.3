Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E5CC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 14:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiXp-0001gz-Kx; Mon, 23 Jun 2025 10:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiXm-0001g3-6I
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:53:11 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiXk-0006hL-S6
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 10:53:09 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70e4b1acf41so32933227b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750690387; x=1751295187; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SECh/VJzh4swiyiDe5aK9fxlDNm1/UjDTBUB9rkCxE0=;
 b=g+jvIUop59Bkityo3Yd5R95YBu8F8emiuiYYy8M5owb103V49VYbIZX0rmFjCpAxEm
 WPx41VBgaYA/OIQP3mWT9QgGJBsEYodOqA7cjjHyu2Sw8JrCNc+UvpR+ozcvbA8TS7gR
 AKryvUiAsVdcD2a9SbQNfa/o8DtAApLznmDbRHaeJEpL5hsmxbeD1G68HAUCV2iTyNwf
 sRoecJgtI6gMhTYYtDpptD0KDuz+980DYf8Vs4e35dXNp8M/b1QBsv1Cfw2lvnM3ve8y
 W0zQclepvB6BAAltgY4msapVdEjD9saWOpFDh92LaUPd+1aS+1LZVnIq8YzuIg/9K1Bi
 ksJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750690387; x=1751295187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SECh/VJzh4swiyiDe5aK9fxlDNm1/UjDTBUB9rkCxE0=;
 b=NJc5vMXicdNJozQy0kVITdVsJ/qHxuAWmzPJwCDq0KGVGWkkE5Y7S+Rmo4AB/673zc
 +ATwSj3FkpbQ11WDO1WYB31nGoUk1Q6xJqjPI+bjDOTWK8iJSLw4GkDM6T82x4MQeAyZ
 SXzBo5VqtEk96BAxgbXGqX9Jbq367w+5FJppbUTN+f7TPalz8KZ0VtvfjskAeOLbmssg
 Guyh0mVo/4r/eUc/ArmKe4xbrzgOqRqIRjY5XW+fS4uwnusJTDWYg+Dyx18fGhDPYZi8
 eF5/PDgEUfSxW5JiKmZmK3sVtIUd7Au6Ft2I8r6+b8hKJlwyJmD7UrrbQVIyvtcInRUJ
 KRRA==
X-Gm-Message-State: AOJu0Yz1FXSkFs8ZDoXjeYjgd8+0f7zSnyn05ZDppZHe9WlIMm97Zn5i
 /GSsjOjijNfv95tUESjSbgGmeSmwgKCNg8LLnRxhfRwUkjJ2HKY/GjG1iPEJspAYUMH0D64ILPO
 cpG5/FsugewytD4ZAlW+MFCroF01RAMBDsQqeN5dA2A==
X-Gm-Gg: ASbGncsjjIWgE4H5Fv7B3QmEabgoCUK/7mEDhXaZXQADDdYXIc0zTU9HUKb/N5oCaof
 LPerx7Oi/koDCxfES0aF2J0ncwVnqz8tuUl1DQwaLMzTuZzInkYqNfw2opvRc90ZQwC2pWq3Da3
 kjJhtNtuSUw/tgcxPN5eE/S4SvUGTfwZz1PMiN36NKZJJtKznjx/XPIlQ=
X-Google-Smtp-Source: AGHT+IFpNAmCezQoRtLrWMZrawINtV8fHTUFlYb77+lZev5Nlnl5/spq1TgS05MbQyxrPPp0Htts+Skr2e5tX2QFqA0=
X-Received: by 2002:a05:690c:7401:b0:70e:2cba:868c with SMTP id
 00721157ae682-712c63c55e5mr204313377b3.11.1750690386939; Mon, 23 Jun 2025
 07:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-28-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 15:52:55 +0100
X-Gm-Features: AX0GCFseRPH1T7CNTcNfIQ5FgUoW0ngX7p6rQOsjXTCf7wFQ4huqO4cApDSGsZM
Message-ID: <CAFEAcA9_hGOPAN=Q_hLZMs1qXbdRhUUWp-NfW+=ikJTwwte0=Q@mail.gmail.com>
Subject: Re: [PATCH v2 027/101] target/arm: Implement SME2 SMOPS, UMOPS (2-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  4 ++++
>  target/arm/tcg/sme_helper.c    | 37 +++++++++++++++++++++++++---------
>  target/arm/tcg/translate-sme.c |  2 ++
>  target/arm/tcg/sme.decode      |  2 ++
>  4 files changed, 35 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

