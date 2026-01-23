Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF261D74EED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJWa-00038n-UQ; Fri, 23 Jan 2026 10:56:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjJWX-00036H-3b
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:56:38 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjJWV-000550-GW
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:56:36 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-790992528f6so22668267b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:56:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769183793; cv=none;
 d=google.com; s=arc-20240605;
 b=QjnAUuUHWGFBDaetgDazxmivfNkPnysjBmcxRivjKizijcLcxffpN1BK2jqB7r6mZi
 4lW+LWvogzyTjiQ3y8HCwylTCddEDhYviBuwdSYVBIlybrbqfBi2gDDYgO9P5akElzBX
 YDYBV1xc5CWLMGzNngzmioClon0VyskJAJKprZHgJbBiNwHUVioSqOY7rbgZvhwdF1i2
 GDw79nyih6a9ijet3GgYXP9AzpvLnFmZh+PEQVaqAHjeB63fC7KlDp5uZijUUEFNo4Kq
 zNwiU13qDLNCGgjUvsi0bBTF7taivBol4vQsuu4ajYf5VzsRIKNvlWPZprOEn0MO65dp
 U6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q19Lt6qTHHvQk100RngOWuE6NSsbJSzvksHMg4joRqQ=;
 fh=IhYtUYV/suwyKA3jDIsz05sLs0xMqitg26tC8cbRvl8=;
 b=cwUtyHXY4/xzURkKomaajlO5hOJ8ziym9ENhehgNgLjb+4XVq3JZiJ8At/cuyAXgdI
 6T6jengb8klvwsZLZG9Hw7bfgLeV914cZ3LP8C7TBO2kfgewGurTx6ibsRxTXlBtAb4l
 HI7ziWzTGoU3UhCQdaPNifbl2k0/AaPpihSli25Adb40fKyTo1533CCIdk+jV+cc9qQA
 wb7B8AakfSYTApb9svAGoQOF/VdRbtqYZrx0uFxDzN458Kr5Q4wR9B8PojwOpUdy4C4O
 JUBpEhVub3o0xMJTbFFTsGOKoT+G8kPhkWKe8m1gHuXcUvXbZ+Lp2xgOLcg5t3RB4yU5
 vRBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769183793; x=1769788593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q19Lt6qTHHvQk100RngOWuE6NSsbJSzvksHMg4joRqQ=;
 b=GtsSJps6hsrjMeQKAqk+tGwPZWR3YVNVTCZ70DsM4KRqIgMJFXsX5XD4LBOJkM4izm
 dkk3jpvc0kpIax29323VzNvbMovpqseEz0y8tfDQ7aaDV4vYdwqlYuTrl4Cn3vP5XpID
 1SM4OuI9Tv8sGWAOirQML5iZD2+hbBQRZKdi5nTKVOGmFvdFuH0I5IXTUnN+L9Qj/nP+
 GmZ/9fXS4pZUgQkXHnvaA9UREHSlsYE4Slzi+4Yf9otqRLvXJ0r0YwmfProGa1cGHYhK
 EpkVMhMiXDoPH6tYrZY+6jk4+sY2av4xnTi8FVnAQWQHOiCxCOLR6N23ZRGBVEV/+dKx
 Zj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183793; x=1769788593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q19Lt6qTHHvQk100RngOWuE6NSsbJSzvksHMg4joRqQ=;
 b=ahtyluXBDyZrNd2tnZOzVF5T4oLzEwH95FwmhYQKs2AkqmJQXS5/9LhIYEh/WVXoHt
 XE1BPobiL1cgBh1zFLVLbu+51RkhSVfZkQEKGWy7im4tTRTXXnViyfYnzCC/+tcxdgFM
 dtJo3dRB3ViWPPZ+vHcm8swwR22W1wPnejlImBPeFXbwjb6zyEftoUYStIg8m1u+aJE/
 D0cq0GTOsH1TKtP90HZhAntqdpCnR5b3QjnVz4aSRdXCLI+r5IRO0Qm++5FmyIaMdo+U
 PnceaScGBQZH9PEq8oQ8NQ/qzDnn3r4xzSIxzYMLrcrsj7cmZ2H3Ab7TqaTFinxMuneS
 Rtiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBf62LPXwuOphVA01IFrV4Cy2WKDy6pqCzBiR247LMwHGhIS0YNO4sxUVhZPquXSYHvoOSlfCqVWlR@nongnu.org
X-Gm-Message-State: AOJu0YxH/sEVlzUMbMNxyuIami9cwFBa9wzVMR535L3h8eV+9AGhRskQ
 fC1XX8p73cCW2NfO3ddemdQwwK2DwGA9S8f8T6FO6WMVe9xOgkLJsSelWzoCaJYYgzseS+ZrUoA
 nurk8yRvpGUW8QzOuj8ltIQj+bvu0H0zVRUBu6nD30Q==
X-Gm-Gg: AZuq6aKOX2srdDwqGaqO7GunDKfKl/XvwjKlTfBmrrps+3zaV4DpdyPR0BvtifSU8S+
 Z2YJzvVKkyujjT1F3DFf1TtJAJNJQ8xtjhnsMDM5wleybedcsCBFvtWNBI16MNiJwiQSYmiIyae
 Wbz9W9VZBhW7A4SarNlOcgnHDqBGhCsjPD9FTpmwMZ1IdA4+SOsQoclsNcJSFV+u1vYyky9ry9J
 CXwkSDoZN9aZpJ+/Faqaf3dO0DqWd8Hwz8UXia7jReecJmUUTn3J17SamK6dlbLi/txyw==
X-Received: by 2002:a05:690c:4b0b:b0:793:995f:25f9 with SMTP id
 00721157ae682-794398e5c16mr28525327b3.28.1769183792801; Fri, 23 Jan 2026
 07:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20260123150921.17891-1-deller@kernel.org>
 <20260123150921.17891-3-deller@kernel.org>
In-Reply-To: <20260123150921.17891-3-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 15:56:20 +0000
X-Gm-Features: AZwV_QhpALjz0klmyo8XYHR0oIMsCON8Q_nSkkprGFy565nPdCdQUtG9JVPaC8E
Message-ID: <CAFEAcA9cvvM8SAYQGNwah+7C3Uq_27LDXk6_X0rMPtmJVjy8_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] linux-user: val3 parameter of futex() syscall needs
 endianess swapping
To: deller@kernel.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 23 Jan 2026 at 15:11, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The FUTEX_WAIT_BITSET and FUTEX_WAKE_BITSET operations use a val3
> parameter for comparism. Even if this 32-bit parameter is in most cases
> 0xffffffff, ensure that we do a required endianess swapping if host and
> guest endianess differ.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/syscall.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c0a9a86529..7cb9de97e9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8106,7 +8106,10 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
>  #endif
>      switch (base_op) {
>      case FUTEX_WAIT:
> +        val = tswap32(val);
> +        break;
>      case FUTEX_WAIT_BITSET:
> +        val3 = tswap32(val3);
>          val = tswap32(val);
>          break;

I see why we need to swap the "val" for these operations:
it is the value that the host kernel will be comparing
against the in-memory value. It's currently in host
order but it will be in memory in guest order, so we
must swap it.

But why do we need to swap the bitmask in val3 ? That
is in host order now and I would have thought the
host kernel also wants it in host order.

thanks
-- PMM

