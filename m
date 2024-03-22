Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A32BC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnduv-0002iV-JH; Fri, 22 Mar 2024 08:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rndut-0002iM-JM
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:22:35 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rndus-0006bi-3e
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:22:35 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56bdf694a81so800151a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711110152; x=1711714952; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vnbn6++GhNEkqEX3ZvDd4Fs9CDtU6H9BnM3zL7lRx98=;
 b=ma1xXWaDFqqRcIjfBC14h46OZ1LNelVaNtf1TYR5ZCkesip9ymjMUvMNDI2Eh1jdQ7
 5AFhktfkb2Pj5Gcp+lI2H4PkSJ2xyi9BUfVfUjIVXcB7VKBvKQqGfkWRllSxjlb3zX1i
 ljvWN5gjHgGgga2KnG6yiZQycmhnQdr6xda5BQHI7Mr+CQMBNY6TxWgh9HFiDCF1kCim
 0oivxnRv+anqTOXy7odWhKBof4n3DwKVfn5JCPaYfoxYsNPXUhS8pJMsl/eGd9d3ZIYt
 aDkSE8JQZ0O39LNzOB2bmHyMwRN0ImQZjnu4zERyTnxIpOpOpOMclrd9vPUezbAEuYtF
 /yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711110152; x=1711714952;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vnbn6++GhNEkqEX3ZvDd4Fs9CDtU6H9BnM3zL7lRx98=;
 b=Zg73yHy/5S6qC0nxd4w+znfI3EaIcj82Y2sK80wU47XRc4cbAvR8WEADbmIesTtxzw
 NAS1nRdyQAomzg0uD3Ufcu+oVlkMHH1qYkfEBctLDpEUJw6LUxZToWHyxrcyfTByATUn
 REBfwB4I66o7QF5QvUYl6ji+E/DiiZjt94rPLIUGHg/HNPh3cER4E7YBzsAEUfaX7fKF
 08B84ZOrB5FDKPo5EaeC3DwKrrLrMKd5lEeVvCiD6VAw0Jpf1csMNO2+xN1Pib9Sa827
 LL+qlJAD7c4MRgaRyidm/js8OUAeal+/IQJKZEfnyl8UuEzkcOK+1O6VSNcCyxX8Hlw3
 rY0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrbGsXlEzSLmSAVCcmxWOGp/eOq9o3mWGwqZjqFWbhtgRPiw2kvFBvEcEdTe+vZrpeTh9zmblQJpfp1gm8gok6/ik45cA=
X-Gm-Message-State: AOJu0YxnjWXMK5cLzQeCUj/Co11mH4b9UURt/IvE2HqRjdwjbFRylOkG
 zPHaNgPX7Xk+gCZre7cMzQiJUwekvfQHWRD+3qHKFRghUMx4lfr+7Kn1cazK7xe3bBKg481mQVf
 EzkIbllMZ/kAQ8ot9pjruHd14bjprFpZwnmmt4A==
X-Google-Smtp-Source: AGHT+IHNi338xwukx6CZyOXhq7HRKaf2dKLUTyzhYYK3yqPZRvP262yZAcsPyFFk5xUM1ZPEz0rnbIBB0BPSd/Rpd2Q=
X-Received: by 2002:a50:cd94:0:b0:567:2cf:1ecc with SMTP id
 p20-20020a50cd94000000b0056702cf1eccmr1491855edi.30.1711110151586; Fri, 22
 Mar 2024 05:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
 <20240318-fixes-v1-1-34f1a849b0d9@daynix.com>
In-Reply-To: <20240318-fixes-v1-1-34f1a849b0d9@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:22:19 +0000
Message-ID: <CAFEAcA80J1zDs1odrHmJGm0sjcg1O_rS0N3su4Gvq+NNLpaUXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/cocoa: Fix aspect ratio
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 18 Mar 2024 at 07:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> [NSWindow setContentAspectRatio:] does not trigger window resize itself,
> so the wrong aspect ratio will persist if nothing resizes the window.
> Call [NSWindow setContentSize:] in such a case.
>
> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index fa879d7dcd4b..d6a5b462f78b 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -508,6 +508,25 @@ - (void) drawRect:(NSRect) rect
>      }
>  }
>
> +- (NSSize)fixAspectRatio:(NSSize)original
> +{
> +    NSSize scaled;
> +    NSSize fixed;
> +
> +    scaled.width = screen.width * original.height;
> +    scaled.height = screen.height * original.width;
> +
> +    if (scaled.width < scaled.height) {

Is this a standard algorithm for scaling with a fixed
aspect ratio? It looks rather weird to be comparing
a width against a height here, and to be multiplying a
width by a height.

> +        fixed.width = scaled.width / screen.height;
> +        fixed.height = original.height;
> +    } else {
> +        fixed.width = original.width;
> +        fixed.height = scaled.height / screen.width;
> +    }
> +
> +    return fixed;
> +}
> +

thanks
-- PMM

