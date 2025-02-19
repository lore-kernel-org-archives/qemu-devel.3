Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E51C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 15:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklyY-0007jU-UK; Wed, 19 Feb 2025 10:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tklyX-0007iJ-GP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:27:01 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tklyR-0007h9-CT
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 10:27:01 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so5213651276.3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739978812; x=1740583612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F80fi1jt5GRI5yMXWRjFy6Mi+aTowS7IkpzYw+VLrVM=;
 b=NzeOuJC1VPfkE0t5QYziAi3oUDbFfacRkHKWgitjUh/h6RXwkPOjItZ30iN6dWhmCd
 eL1OLzgPQfTgKgofm4Oqt4p+GzWYvQFIojFKI9bIpoNvDVsp59Ra3vxZoXN8Kee+NinQ
 ZWXqe/1icofrKjY8/v24fe2gMHMixEf/4Mxci7EIKiIL22qgkfxOT/idhzysc4mrLAUZ
 SvBOsAtx6Lu9bkhKWx4CKIJkrbsB3r/EEla8jGSFqOGpagj5dGrLpKHtvZOsNa/Z8lhw
 yCkNaBwqlg2ctnSlGpQSIYlOrh1c7heJycPN72+UaeLFJ+WcfsccJJMfE02J3pbT9DEU
 dnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739978812; x=1740583612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F80fi1jt5GRI5yMXWRjFy6Mi+aTowS7IkpzYw+VLrVM=;
 b=uPVnopmPKTgZBorR2zDniZnrNaxsuGrSkun7iTTLZSgi/MlZcqGIik/wv5rkWaIldc
 kLR4vNXjZqUL/W1NsqH4z0hSFCdxR+YXrdkeu3DIe+oC+9NwXsyvYsKqJvaie4R1ZRHh
 9ac/2sP4+zT6B48oA/D5jr85IPKbAhaf4EYt35gUi+Y07G63ysOrfdOvVu/lG2TO46Mp
 a5U7KU/lw+8FsjqWOe+LqzvoLNmnI7Y5O8ybNoRBgx7bGU7lk8B5PVG+iwFDMANZ+B37
 84DVdUXoLYVKsDo0R9hkeOY0uTQu/Ot298qjvX9b5JuAMnlq1cco6xIxqVLl31iNYEVz
 LlcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKQ209XVNu5ZrcR9nLYo3ju/vcm3dcjJXH8LC2eMsUCmVgim2U5XTRAZQuK8xlxlDMLgFt+d9FyuZZ@nongnu.org
X-Gm-Message-State: AOJu0Yw0G2GGvyiFf36duj15rr4ZyVhZIy7oBjSbj5lqvWlpTbyqGdRS
 RgApRNtK7R8JtisSPStGZ72+vIGn0oG423Pir1o9m54+Ec3hnhe1fD5tWjCxw6XKUVIyK8oVuTm
 R/kB1j9lF/sOx1pi9JZTzrDnGhG3QroPHN1yyyA==
X-Gm-Gg: ASbGnctgeqedbPDT3fHzWtbwi8dpO96gfAO+ZKx9zHm4cm2/hFVDdwxQWN0WnYi+L/u
 dq50aOTwQCh4rkmoCq+OrnvAGrvmfw9Hy/cJy6xKc49VMktXsZRyxf3568aWv/m7W7WznLVTvEA
 ==
X-Google-Smtp-Source: AGHT+IGLENTlNAtIk7j76L5WcGQcUz96sw/2kCy23UZMGd7E1Prv71lCSuo5oWbl4fns47L/hpAxd78jblQDdbo8Epo=
X-Received: by 2002:a05:6902:707:b0:e5e:1062:bcc6 with SMTP id
 3f1490d57ef6-e5e1062bf7bmr1578432276.6.1739978812480; Wed, 19 Feb 2025
 07:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20250218222211.1092072-1-slongfield@google.com>
In-Reply-To: <20250218222211.1092072-1-slongfield@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Feb 2025 15:26:41 +0000
X-Gm-Features: AWEUYZlJOwrYZGC1FKxmrqvtZZH3mwLnKnkEL44TsRMoy3-yljNfUHs31eAO6kE
Message-ID: <CAFEAcA8yrLnyc-CHtiKeXa817qReW0yoJF--Dx=aA-+e0_8Y+g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix signed integer overflow undefined
 behavior.
To: Stephen Longfield <slongfield@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, roqueh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 18 Feb 2025 at 22:22, Stephen Longfield <slongfield@google.com> wrote:
>
> The problem is internal to t32_expandimm_imm, the imm intermediate
> immediate value. This value is sourced from x, which always comes from
> the return of a deposit32 call, which returns uint32_t already.
>
> It's extracted via: int imm = extract32(x, 0, 8);, so the value will be
> between 0-255
>
> It is then multiplied by one of 1, 0x00010001, 0x01000100, 0x01010101,
> or 0x80.
>
> Values between 128-255 multiplied by 0x01000100 or 0x01010101 will cause
> the upper bit to get set, which is a signed integer overflow. From
> Chapter 6.5, paragraph 5 of the C11 spec:
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf this is
> undefined behavior.

QEMU always compiles with -fwrapv. This means that this integer
overflow is not undefined behaviour in our dialect of C.

> Though this is a minor undefined behavior, I'd like to see this fixed,
> since the error is showing up when I enable clang's sanitizers while
> looking for other issues.

If clang's sanitizer reports the overflow as UB when built with
-fwrapv, that is a bug in the sanitizer and you should get
it fixed in clang.

We use and rely on 2s complement handling of signed integers
in a lot of places, so if you try to find and fix them
all you're going to be playing a pointless game of whackamole.

> Signed-off-by: Stephen Longfield <slongfield@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  target/arm/tcg/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 68ac393415..8770f0ce1c 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3508,9 +3508,9 @@ static int t32_expandimm_rot(DisasContext *s, int x)
>  }
>
>  /* Return the unrotated immediate from T32ExpandImm.  */
> -static int t32_expandimm_imm(DisasContext *s, int x)
> +static uint32_t t32_expandimm_imm(DisasContext *s, uint32_t x)

This function is following the API for decodetree !function
filters, which return 'int', not 'uint32_t'.

>  {
> -    int imm = extract32(x, 0, 8);
> +    uint32_t imm = extract32(x, 0, 8);

Given what we're doing in the function, it is reasonable
to make this a uint32_t, though.

>
>      switch (extract32(x, 8, 4)) {
>      case 0: /* XY */

thanks
-- PMM

