Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84238C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA567-0005DY-1R; Thu, 23 May 2024 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA564-00057q-KC
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:50:52 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA562-00026s-Tw
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:50:52 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso12857501a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716457848; x=1717062648; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WHcJe+TvxtDKxywqD/FnM9pJ648Y4FHeJcGEAYNrvpI=;
 b=uRCSD4C03Oxo092FpTHQxcgsPXiewycLpZPEQctGb5UfLkDjUJPO6r3ioUyVXBkeqn
 afMJnw+adlVlPjXWl4NZ3CCLdvYzOne4EnpyiOlEUKvjiCIdD4IKWCAFyCpxJn0Yg3j2
 eUQSF9o07RU3HLicEV4jMYOmPPfnuel+ISMm0AyFhj0zQY3vBbGII6c6+HfHKJD3y+lU
 Iil1C3m/KmS3+a48yQckTB8Pi7GcPv5HKMVAKIqGJHyP6NqvAx/3txfjWE+jX1eR5JMO
 7SiNfNXDeVuYFLrN143gEdsXjAt0ekad3jsJ9KbXnWLR+A6h6rcSDTQ37D/KaGFCvw/R
 Ng5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716457848; x=1717062648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHcJe+TvxtDKxywqD/FnM9pJ648Y4FHeJcGEAYNrvpI=;
 b=kdWQSCwRiZ8JfiZW3kGinGo1PFhV24G40Qgc/LZw7bgk/ge72vuppIQNUM7grZ0z3h
 LBpnrDN1hGFC2bhZH33xrekyrI+KUuSfvCAHtFTUfCKsVYzkM+tTZvx1cOpJ8HYlCaUd
 LdtDRvhuq1XHT35zSGFiZMle/sN7Q6Ex+3wUf8PTxLE35OvU6InzOdY7oJG/Gb0lDPgC
 aQu37p99Zr9G/FKtY+/xA6I5Jhyfr+/MUACtLpvAbjauZy1K+rvQY4UohYjZ0mkwX5Xt
 gwohP/5LP2i+IsrtYqJ+rHz7YGtItQvDtal7wQ3kQar690WejqE/LQ+k077R1uKCNNKp
 ivUw==
X-Gm-Message-State: AOJu0YzJzkQCbyYYS8mY+yJDLiFSpxWFzJEaqTkue9SXY+rBGULsz2T7
 uBi4SC6r0MGpZSuB9EFdDNYT6QSwCFactzvuYU04BUK0xsL8OVYFGXphnIF/i2qv6r3N8iMMhxG
 SvMmz/yDH68id0cy1z4EfpMcfGDgdwDkej0JhxA==
X-Google-Smtp-Source: AGHT+IErnUTJWPf2U7wGTmt7/F8I8S/n68vm6lTD35uJnqdSzLRmonCkWGfXLJZPkj/C+KZCYVtBAEHtLoCSwyDLZHY=
X-Received: by 2002:a50:ab46:0:b0:570:388:ee0b with SMTP id
 4fb4d7f45d1cf-57832c8626cmr2684362a12.42.1716457847993; Thu, 23 May 2024
 02:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-4-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 10:50:36 +0100
Message-ID: <CAFEAcA_VQQsaUAqNwXWWB08aP+OEtQR3griSyHmn2RMVNEkQfw@mail.gmail.com>
Subject: Re: [PATCH 03/57] target/arm: Convert Cryptographic AES to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 6 May 2024 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      | 21 +++++++--
>  target/arm/tcg/translate-a64.c | 86 +++++++++++++++-------------------
>  2 files changed, 54 insertions(+), 53 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

