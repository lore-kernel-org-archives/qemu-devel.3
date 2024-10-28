Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB0AD1039A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 13:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5PvS-0005qs-PY; Mon, 28 Oct 2024 09:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5PvR-0005qX-AW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 09:36:53 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5PvM-0004T3-Sk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 09:36:53 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2bd0e2c4fso3399042a91.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730122604; x=1730727404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PHRfrTrnpftClJsLyL4P6uD4ixuzVq64/uHGMFx0JYQ=;
 b=RW2tdhB/WYO/WCvRf+1X8UWh9PH0Y9f0BFw3tnutFxV4tsadAm70OIDatrmw5u+bmB
 /zyng4RGOaR4kG2S2ahVgwqq62tc4F4paWPFUmlui8Jy7clLoaM0k8EHNypCRanvrhOj
 mjSy3srPRIoZa6Dn22c1Ui/0t5Vhwrqd31z0Llnbh5Q55Y7DQI4dXPP91Mi1fIN7kUT1
 AL78KOVwIYQSMAYfO33yLanC8mh5npzmyDEvCmhGQLaVXOCrG1QQzYWeUYnFA92k06aH
 bhMsH6cWJvpmiwCWCyB9Hc1wes0DP95orKDo/eOKG31BSXye1wsKCFp0jpUvvQf2pQeG
 hLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730122604; x=1730727404;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHRfrTrnpftClJsLyL4P6uD4ixuzVq64/uHGMFx0JYQ=;
 b=lsS2Fl8aouEE7bc0qM4ccs52abIIjcw/SIDwKExu/8OyNBNNGpuYbtgvr74jnet04u
 7LmjOWKyEQIjFpb2RxS9Rffo5CIqVZJq4LDOEbZjW2MKkaC3VySurb/egokiDTpxZaTd
 mDjlfmfYpzzOVZ7flw9MY/nDTN8kM8XwoaiEUZZmixjKoPe1X0vH4breI53acc5nt5ay
 w1E4tPtQdBQwXxw3OzMBYw6fWa8UIbjQMiBeh7FCFnytcCDQ1+Z3UkOWZsntMPeOIeju
 UvVCeXL9ZRarjSWOQNVYXuM50Nf4dcOFWaz43jPWJMEY9DkWZM6aO0fGv4NWC5/4iqRb
 VGFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeZifO0+hExvF88E7jMhsx1Gd8/RjtqfKzkGyc6fXV1PElq47AUTZGYv/weBBpILn9IEMbZrhIM7OA@nongnu.org
X-Gm-Message-State: AOJu0YzIJD8am+nRQOc0pr2kqPXiogREPtd1o6W68h7BSfYV6x5LRQkO
 XHjOjlB4Irh/8aKjT/PkLhCiZVxFWsUjH+V4FplgNijRCMdZ8JCh+1LXw950pAI=
X-Google-Smtp-Source: AGHT+IGqtbSlqdp4wPacrnqeVV87BTU8phDXP8TRZjY7I6qKD+rdoJobkjsMuHGG1GBMcwsg2JErsg==
X-Received: by 2002:a17:90a:f2d8:b0:2e2:7f8f:3ad7 with SMTP id
 98e67ed59e1d1-2e8f0f52f4bmr10194785a91.7.1730122604073; 
 Mon, 28 Oct 2024 06:36:44 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e3771775sm7165409a91.49.2024.10.28.06.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 06:36:43 -0700 (PDT)
Message-ID: <ec64037c-de68-4053-a3e2-4b68845c8f11@linaro.org>
Date: Mon, 28 Oct 2024 10:36:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configure, meson: deprecate 32-bit MIPS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241028082416.265437-1-pbonzini@redhat.com>
Content-Language: en-US
Cc: Michael Tokarev <mjt@tls.msk.ru>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241028082416.265437-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1031.google.com
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

On 28/10/24 05:24, Paolo Bonzini wrote:
> The mipsel architecture is not available in Debian Trixie, and it will
> likely be a hard failure as soon as we drop support for the old Rust
> toolchain in Debian Bookworm.  Prepare by deprecating 32-bit little
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
> index 8fd7da140a3..b779eb54934 100644
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
> index ce38a3d0cf0..f3f4cd4059f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -164,15 +164,19 @@ property types.
>   Host Architectures
>   ------------------
>   
> -BE MIPS (since 7.2)
> -'''''''''''''''''''
> +Big endian MIPS since 7.2; 32-bit little endian MIPS since 9.2
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>   
>   As Debian 10 ("Buster") moved into LTS the big endian 32 bit version of
>   MIPS moved out of support making it hard to maintain our
>   cross-compilation CI tests of the architecture. As we no longer have
>   CI coverage support may bitrot away before the deprecation process
> -completes. The little endian variants of MIPS (both 32 and 64 bit) are
> -still a supported host architecture.
> +completes.
> +
> +Likewise, the little endian variant of 32 bit MIPS is not supported by
> +Debian 13 ("Trixie") and newer.
> +
> +64 bit little endian MIPS is still a supported host architecture.
>   
>   System emulation on 32-bit x86 hosts (since 8.0)
>   ''''''''''''''''''''''''''''''''''''''''''''''''
> diff --git a/meson.build b/meson.build
> index 5e2b0fb82b2..110e93f84e9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4721,6 +4721,14 @@ if host_arch == 'unknown'
>       message('configure has succeeded and you can continue to build, but')
>       message('QEMU will use a slow interpreter to emulate the target CPU.')
>     endif
> +elif host_arch == 'mips'
> +  message()
> +  warning('DEPRECATED HOST CPU')
> +  message()
> +  message('Support for CPU host architecture ' + cpu + ' is going to be')
> +  message('dropped as soon as the QEMU project stops supporting Debian 12')
> +  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
> +  message('that QEMU will compile or work on this host CPU.')
>   endif
>   
>   if not supported_oses.contains(host_os)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

