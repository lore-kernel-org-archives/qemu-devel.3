Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C1DD13595
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 03:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5GbA-0001X5-02; Sun, 27 Oct 2024 23:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5Gb8-0001Wc-NA
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 23:39:18 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5Gb7-0007m4-4E
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 23:39:18 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso2608324a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730086755; x=1730691555; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QWiHVTVH5Z3RKhRacDXIi7jkGZ0Bcu/W10mjIj1T6RM=;
 b=S5Ja/ZEUxd7P/un5P1V/Io1WK/8Z74u+LXo/ocsSy/Bk+PY+Ik8+xDaB0yyUEBiYXq
 d+Zqd4ONHkHszorCXHZlUSEJZNSyNQSrbvbr8s0OGOdCcRWyHxaa2VqZwNH+pDn8UW56
 laW0oSeNiFBJsXVjhGQ46tQS14cRo8DTpFzHwDQkNbnK7PL+mo7lViA9Br9aWZcJkOnC
 QW7BlwwDeWhTUB4+S3hPJzGXyQV7vpHPypK+cgXdFCSpxfEshodWd4q8LRR3cX6I9Stb
 mWq8Ku5LG2GYdFTRefpTEX65DDJMqz4Cnu17Yt6ZusIiVzdtcwXdKOuvk5hs3AZMT4ss
 TnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730086755; x=1730691555;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWiHVTVH5Z3RKhRacDXIi7jkGZ0Bcu/W10mjIj1T6RM=;
 b=msiwPuW79LElsQjnIv1By7/tYgI1u3333K2MyLPgItK1EJ0cRuIDsb4KCVYzyXXldX
 b0AaFqGdOcWEfAvvi+YZND+fvccGNC8bGRQ/XMx0+TUSibIyIT1dFzis50Non+NmSR4E
 +rAocZ6Gaz1OkaKLfddyuWQRPhZJ3U18w5DetV9ExeTMQQlRqvL1oW73MhZnju8rPr5i
 Xxb+wBH+WtH/kJwMaSu3rwU1hY6Ne4dBi8+FZa8yREFpzRUIiBEAdIjlV0enQys9q/KM
 KuwH77wQeL/9renysqNoeTeH8Ih+v33P2Z9zBBAWgiim4SM2Gaau9gziDmDJuUWOWk9J
 0CCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwGc5vZEZfpIJEjLU/IpMRfVLeb0+Ik7jGKpedRqpbQU+2AVPvooxeslhQEJ339e4TlGNw6UJw1kEH@nongnu.org
X-Gm-Message-State: AOJu0YyVT/7HJnQRr1WN+Ml/v8R6NOFGx5bRCsFHrfr5uNSD2J5ewqy5
 5HlghrymH9ZLdZDtYQS1ER7nnHxEzHUnPat15AsVB7m52bGk0pizsXD9/PWmbrpGlgLdRj76A0r
 2
X-Google-Smtp-Source: AGHT+IERyy7mTynNT6eFHU2ra2LZFeBrGlNNIQwAoBiPTJq15evE55vHI20BIs5gOfC8m3lw0d8LpA==
X-Received: by 2002:a17:90a:9312:b0:2e2:a8e0:85fa with SMTP id
 98e67ed59e1d1-2e8f1057e59mr8287472a91.8.1730086755371; 
 Sun, 27 Oct 2024 20:39:15 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e36a26aasm6021006a91.27.2024.10.27.20.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2024 20:39:15 -0700 (PDT)
Message-ID: <4ab94b59-e19f-4e04-9fd5-0f41621d7d26@linaro.org>
Date: Mon, 28 Oct 2024 00:39:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure, meson: deprecate 32-bit MIPS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241027130726.244605-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241027130726.244605-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102b.google.com
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

On 27/10/24 10:07, Paolo Bonzini wrote:
> The mipsel architecture is not available in Debian Bookworm, and it will
> likely be a hard failure as soon as we drop support for the old Rust
> toolchain in Debian Bullseye.  Prepare by deprecating 32-bit little
> endian MIPS in QEMU 9.2.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/about/build-platforms.rst |  2 +-
>   docs/about/deprecated.rst      | 12 ++++++++----
>   meson.build                    |  8 ++++++++
>   3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
> index ff56091078e..6102f00aec0 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -41,7 +41,7 @@ Those hosts are officially supported, with various accelerators:
>        - Accelerators
>      * - Arm
>        - kvm (64 bit only), tcg, xen
> -   * - MIPS (little endian only)
> +   * - MIPS (64 bit little endian only)
>        - kvm, tcg
>      * - PPC
>        - kvm, tcg
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 74c75666c31..32b4cd16ec3 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -170,15 +170,19 @@ property types.
>   Host Architectures
>   ------------------
>   
> -BE MIPS (since 7.2)
> -'''''''''''''''''''
> +32-bit MIPS (big endian since 7.2; little endian since 9.2)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

