Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0D1C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 15:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY6ZE-0007fl-Ne; Thu, 08 Feb 2024 10:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY6ZD-0007fT-7j
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 10:43:59 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY6ZB-0005Am-MC
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 10:43:58 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-556c3f0d6c5so2412171a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707407036; x=1708011836; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MIlgp7c3WkYA2b+aebwwSO7bAEXpR0cjF81qe3HfwNM=;
 b=lScd+v9JHkyOfXKKDco17YWSi5tv1lSao2X8K3EbCd0cXSCi9+XZ199i6FM+zkqwtv
 lIDQQ3LCp4aEFQTJzoSX5Zs6TiMYpkN1goehtQzaL6v19ja8EdOy0fBMDXmNDTAfdo+4
 pvVa2FAf+3TblNPcfUeADVdGszYk7ln+GlhY04BWbFTXm3gxPMdMadYYfQ/fRkO8oBST
 hpBKXkjzeDDtrjV8XD8NC3V/9hm0lyS/x0GlI+1122jaXv/piQBTfP6WX15+ooym9Aij
 dbYWGw1s7RvRiU0rd8nG9hRmEbzBz5mVIrMg2LW9bkIVziUPkpjBPEmMgQy7fRVJ11Co
 IFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707407036; x=1708011836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MIlgp7c3WkYA2b+aebwwSO7bAEXpR0cjF81qe3HfwNM=;
 b=VDqyW8cqVK9ONAYVm9mCpcL8bZfIt+qhV0ZmACD5AWfeCO3iNOnx4l0WFGggSnJ55A
 TKUt4Jkwv2wB0u5iIaoJAZ4fXIoR/aGTQ7QJD0rC9a33d5DSKw49+b95gRDi3vc8Avgp
 bsGX1vrhLd2M6WCQAuvdRy7lr9A2RXg+cebvaLk3n2bDm7NoPH4MXL4oI9qQ2vGIFFJ2
 UoWsG1IsZYIm9+X0nCjZcB7s2XyeQ90ap1OsZnyoTkoREKsNGCQ1WGGFl99eXDVAQlAm
 DYnlFLFy1rksWuhQ90FcSmHV0m/ZRIaLHBt0qGXj8rwo2hs8w+jKPKPEyREoTsAKqhyy
 mvwQ==
X-Gm-Message-State: AOJu0Yz53jL+S1dinm5mJMgeSDFGGxLORfek4wRxOIplGle+Hi+Ad7zP
 yANW8Q/kQG16HisFOLZdT8bfJ1oqFYQ162dHYxlLt01Q0ghFEL99BbMBJkdDFJwKGMsbBAmoeUM
 yKlRvkMc9bq2CBpiowGBj7eA4w0ryABbURZ1JfqfXm9cEGMzO
X-Google-Smtp-Source: AGHT+IHFjRhFEA5He7aVoEJGB7GsdXZjWKPmBOfWcJwK3AtImygA8cHnlMXWK+LuqLQ4tb2h4C1ksDCIb2gpiW8TxVg=
X-Received: by 2002:aa7:d646:0:b0:560:590:1044 with SMTP id
 v6-20020aa7d646000000b0056005901044mr6655292edr.6.1707407036121; Thu, 08 Feb
 2024 07:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20240208154038.553385-1-mjt@tls.msk.ru>
In-Reply-To: <20240208154038.553385-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 15:43:44 +0000
Message-ID: <CAFEAcA_x1Rhivkk-mGRavYcNi-hgz+xK6bu_V_Q6rThtGev=HQ@mail.gmail.com>
Subject: Re: [PATCH trivial v2] qemu-options.hx: document that tftp=dir is
 readonly
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 8 Feb 2024 at 15:40, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1286
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v2: include suggestion by Peter.
>    Not keeping Reviewed-by tags.
>
>  qemu-options.hx | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5adbed1101..e7f07d8ccf 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3100,6 +3100,8 @@ SRST
>          server. The files in dir will be exposed as the root of a TFTP
>          server. The TFTP client on the guest must be configured in
>          binary mode (use the command ``bin`` of the Unix TFTP client).
> +        The built-in TFTP server is read-only, it does not implement any

semicolon, not comma.

> +        command for writing files. QEMU will not write to this directory.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

