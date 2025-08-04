Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E99C87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqd8-0004AN-8D; Mon, 04 Aug 2025 04:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqd6-000488-43
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:33:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqd4-00009t-4M
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:33:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-459d44d286eso3017085e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296388; x=1754901188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0TDqnNSIWecUvKE/VOjWbWcQ72scB7dBIwBTQzV2wZE=;
 b=p6c4Aw/JdcMpdOMj7LjcpxKGX5hVzS63noCjlWN7Br9MlBj6JQA3XB/eaSrD/yfFvI
 YmN9StUuu5H8ID0P4+jtfuyAI/Z8izLYl9wZXg9cEhcvVWrL3Mw5pzm9BVxBktRd4xPb
 cF8Ie/D26tYS6yAy7p4bYs2GrUSx8TU6ZOGUIdhkx1YZi7HhiH9elxxJ/o5Y95ZEfFu5
 qoIJyxeAjkabKM72MXrPO9B0NzuyJDMwU9jOcbXpzC8b13R+ZegcQ5o6sVcmnyZqiAaU
 kDIDYyr/4C0GfXKG6RTRVpd+pppVzNNvB7sKnjq+tC1/yoRYYLh2aSgpA2HhYdBwIy+A
 yvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296388; x=1754901188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TDqnNSIWecUvKE/VOjWbWcQ72scB7dBIwBTQzV2wZE=;
 b=pHJ2PZFgyyCZF+UZIDHAQ1Sf6n8iyBl6ZvTZb5HhSe54J1lf0ENcpkL/TyAQ0MaXkA
 Oix4sMrYc5xrX9qnk3DVpBjerZBoFDEHFP6vv4a1NoBeAJr7qDAA2jKomP6A71fTJz7C
 w1EHUUrhue9M7KZcWkwtiWcW3TjzW780ZiTlgyDVaENQXIAU7mtpWDLTIU6MDKKX5woC
 G9pzTY1E3ypKauXXRWdzgtkVtlo9NHPAG7hHfS3tLslShGezaUAWQR3VgziFdPpZo+4D
 I4AzyUwgn1OARUE2iesrpLRMiCZoqhXE5qw8G0eZ5wfLhjssH7MjxN9LkNnwuDU72B9m
 aVIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXAoA4dHVj+dhumUQfTYUICw9TQ538u1usVr3ySCN35vpDosNm7zpymVFeirUxj6ifnZMVkpe8K4Jo@nongnu.org
X-Gm-Message-State: AOJu0YwNvtyyiI3g4CGcK+uLew8BOCqbPP7wjxVed6YYoWxa0BNoJtFf
 YUdivAz0otQR6/fLhWcsM3RqHmZtmf1AGaWo/DEVdPv1DyxYdUExfYCsDUMMkJ0J4YU=
X-Gm-Gg: ASbGnctDEIfZfsWdX+fYX9pVbeGyRiT0WdNYgYqngdeeSiyIYhav3gFPcv2vcTCxWxD
 DNzONT+oHc+GVyZUCaXZTFkI1agviSuGTa3Oev2nVE1UccrnP8jeXH4btPmVbL6Kk+oFkjku5ZX
 coyo8Hs89+fYWAXLikMqBJWfD8hrErldEF7wJx8glAn3gUZGKAGqhz1onZUkmeo+3a71WX/d0um
 l2vSBV70/jhqs3s5AjxUUZCiy0Nq1f+j1DHYhEE7EAwD4a3LnBFWg8gWX60E1I1rJOo3AlSMtz0
 im8BKNh70WPFiQkrhvKy6whgkx0lU2FQoWfzdR3LQKxES/ma6vpxM0U0TheEdW9LaSI3tRc5I1j
 zyVj8ZU6TnICZR4mSPpj4QkAc4lKZyRz3JgD0zS/plhkQnyZAGqTEzdLI02O0opkIrDcbQZs=
X-Google-Smtp-Source: AGHT+IHMHKEmQrlHwp9/4GG5etcI6DbeOG/6zT+fqwUhvhTSNW+jzvISbKCWqM7RkBL6VF7Lep2fPw==
X-Received: by 2002:a05:600c:1d18:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-458b59cfb66mr67270235e9.3.1754296387679; 
 Mon, 04 Aug 2025 01:33:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee4f089sm167482065e9.20.2025.08.04.01.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:33:07 -0700 (PDT)
Message-ID: <bbd2b72c-bb2b-4792-a23d-6c3319748a2f@linaro.org>
Date: Mon, 4 Aug 2025 10:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] tests/functional: Move sh4/sh4eb tests into
 target-specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-21-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-21-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> sh4 tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                       |  4 ++--
>   tests/functional/meson.build                      | 15 ++-------------
>   tests/functional/sh4/meson.build                  | 10 ++++++++++
>   .../{test_sh4_r2d.py => sh4/test_r2d.py}          |  0
>   .../{test_sh4_tuxrun.py => sh4/test_tuxrun.py}    |  0
>   tests/functional/sh4eb/meson.build                |  5 +++++
>   .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}      |  0
>   7 files changed, 19 insertions(+), 15 deletions(-)
>   create mode 100644 tests/functional/sh4/meson.build
>   rename tests/functional/{test_sh4_r2d.py => sh4/test_r2d.py} (100%)
>   rename tests/functional/{test_sh4_tuxrun.py => sh4/test_tuxrun.py} (100%)
>   create mode 100644 tests/functional/sh4eb/meson.build
>   rename tests/functional/{test_sh4eb_r2d.py => sh4eb/test_r2d.py} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f6b85ee132..a0174fca572 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1732,8 +1732,8 @@ F: hw/pci-host/sh_pci.c
>   F: hw/timer/sh_timer.c
>   F: include/hw/sh4/sh_intc.h
>   F: include/hw/timer/tmu012.h
> -F: tests/functional/test_sh4*_r2d.py
> -F: tests/functional/test_sh4_tuxrun.py
> +F: tests/functional/sh4*/test_r2d.py
> +F: tests/functional/sh4/test_tuxrun.py
>   
>   SPARC Machines
>   --------------
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index abaa4e00fca..ce713509e32 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -30,10 +30,8 @@ subdir('riscv32')
>   subdir('riscv64')
>   subdir('rx')
>   subdir('s390x')
> -
> -test_sh4_timeouts = {
> -  'sh4_tuxrun' : 240,
> -}
> +subdir('sh4')
> +subdir('sh4eb')

Here also I'd keep a single sh4/ directory (it is the same architecture
with an endianness variant we're going to remove).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


