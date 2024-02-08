Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5344C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY1zD-00010S-6r; Thu, 08 Feb 2024 05:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY1zB-0000zR-GY
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:50:29 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY1z9-00070i-3Y
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:50:29 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55c2cf644f3so2061818a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707389425; x=1707994225; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hPBsWqZTzD+RAY8hNCyHctdvS/GY/KE37I37k7oDSII=;
 b=GLzj8mLWEWu/UY8PiE3CPvSWyhFNLAtt7gM2LB/Ap4Vpi7bj6EfMt7z24A3wr5TJLh
 u00yXq0TO2gg31o8oBPsdcyM9cVcHth3PwK1HfmbKR9nx8AUDOrPQCxD5Att6npHTXxe
 rLVfgRf/S1a02xfBdDdhFx5L3l7GIFl3fZTAloNzLE4JmkKkwCLUpcxr4anZxDCuXuRj
 cdVtiLM9fi6LDTPhkzc1PykHZv5lIusa2CIWonmFNQsfRdz3B1bcpvNS2qO7Pv+AkjQV
 DRM2BbCNjjWMJEy5932NXK6wvf563niRAt/AeqlTYO8pnpAeTTS0wJQNA3jYw2Kscvdj
 l7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707389425; x=1707994225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hPBsWqZTzD+RAY8hNCyHctdvS/GY/KE37I37k7oDSII=;
 b=s/2Ai6EeqCeF2WqUDUw84STESui2K93UylYamKpcRAaDocDz0zSjF6waY1QrpODr3m
 jEs69nWkkr9EFqqs7nc1A36+gIIOppzW6WOZtWUAr9FbYyq4eanKYyeYkDsNNZUdC7uQ
 ZuCXvJiFN5Xukgez0mHbtEG/bpOXMBpDtYvNFlFlJRrQifaTZJAQNvCb4f6eEgtXCF/K
 GQ7MqNAIvo2gQ2O+WBqQiKKOx+GA1M0vJaWY81chtKlbPUuxjvT/KpVEp97Uqv6R8/U+
 Twz8fAj+vxwc8F/OCBHcM/S1Jkx1uF3RWy4TKN16HuC6MSSqY9WLvNVUkdib8jAhWF0F
 XnNA==
X-Gm-Message-State: AOJu0YyDDvX67YM3W520J1VQORQ7o6kqoZSaM8xgJduyxZBBOwdaFEzo
 qvPbzN9/ZxzQe20hGRx/SVaHGontYeDuJsThrFELR2wKo0RycfHGuP8HB/MDC5G/NpNOoWmQVu/
 1pdSTuOa2u6jigC9wKedIsQTnOq0ScCldID2S4Q==
X-Google-Smtp-Source: AGHT+IEWtihh9X+7kzntuZm1h481fgn2yIPZeOq3177Mw6rLI1Z38d2QpKEJayAhg81ZcpbmrQqCSlCRMy8Rn0SLPSo=
X-Received: by 2002:aa7:cccf:0:b0:55f:e8b4:200a with SMTP id
 y15-20020aa7cccf000000b0055fe8b4200amr6130073edt.14.1707389425288; Thu, 08
 Feb 2024 02:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20240208060228.313616-1-mjt@tls.msk.ru>
In-Reply-To: <20240208060228.313616-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 10:50:13 +0000
Message-ID: <CAFEAcA9zz1idVTcKYsrd7AQ+mf2vLdyFVQ5QwLc+e0rBmtyz-A@mail.gmail.com>
Subject: Re: [PATCH trivial] qemu-options.hx: document that tftp=dir is
 readonly
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Feb 2024 at 06:02, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1286
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-options.hx | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5adbed1101..05f70231c9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3100,6 +3100,8 @@ SRST
>          server. The files in dir will be exposed as the root of a TFTP
>          server. The TFTP client on the guest must be configured in
>          binary mode (use the command ``bin`` of the Unix TFTP client).
> +        The built-in TFTP server is read-only, qemu will not write to
> +        this directory.

We could expand this a little:
  The built-in TFTP server is read-only and does not implement
  any of the commands for writing files. QEMU will not write to
  this directory.

>
>      ``tftp-server-name=name``
>          In BOOTP reply, broadcast name as the "TFTP server name"
> --
> 2.39.2

thanks
-- PMM

