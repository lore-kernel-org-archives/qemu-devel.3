Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1F5C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCdV-0000Nj-Ag; Thu, 06 Jun 2024 08:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCdR-0000N9-K3
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:54:31 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCdP-00058h-OW
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:54:29 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52b90038cf7so1454251e87.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717678465; x=1718283265; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=15tVYli2ChvVNa0VO01EKIcWe4g9oe8PmeG38aQPSO8=;
 b=BhmugmbofsN9mtRLr3DRoWadmQmNe8zIQ8HFIaN2oJbH0oHSUeqCdw85++gIAKLFLR
 /KUH0Pwvs7vng/7g27EHoYwtrhDvVBcY5XEJmjVFzd627JkFUr/O4vGjaxjSA5pPuH8m
 tNFHWYFHdObmgKqdICkdv8kNCRwQ6mBwKdmsvYgB9cYRjJXpokP2XCZx+OMTTYBsiCpP
 1Y30C/1kqEuwvoMu8J+A2ETHrp9x7QHu5BN9atwik5fNcqo73jeAUYEoBHoMBwQbMeow
 dtFDH2u2gGGjZXflkroPFmzIF2xQYMnytePOrVecTEsxXVT9dLEG9HQboDsUX6m4Q9fn
 BaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717678465; x=1718283265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=15tVYli2ChvVNa0VO01EKIcWe4g9oe8PmeG38aQPSO8=;
 b=TwRy650gAPUNRW9EqJh8ptF18W0XyW19QzYUgY1dBYf8Kj8FlW1nCVJkRbS2sN+FXS
 /NlE09+b4ak35rYrfTtoXojuwhpIWv69OX7QwlR1kKWdUTfrQ7b+rwb2O6IrJRnrrm4F
 aQZnqMLPEkB2vgntgcg4gS8SdEpVenIKclVExsrRPAhZX/Dn/iWbV/JciVoRipkO/1/g
 u9u876FsDcebzPjwz22W7PHTpl0qFxCGYy4OsP7N43Y6r+atBDt5hhjbAYryHQswrcJR
 /mgATrmeyjUwQPabr6P7e3DnEEEjqXF4k49oxSAm6odAjayMe95saigu53UTL6tPHCK8
 FluQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8HWNI0inJVZvhXztHQrswl2eG8IiuFXAEmkI9LmaN3RkFH6eKQM/H3Ul7ebGpuJlePAFa0qK3fy7O+P7VrTPv7yavwIc=
X-Gm-Message-State: AOJu0YyA9I2rIkKppFtxqnp1EPEueqdF3eimfPSCOa3fXZZJCOd2giDX
 +fzXNAyocb529y/gdWU26sen2/odhKhqpBT0GcB+mNQUBVWfKk94YKRfKVtyJWI=
X-Google-Smtp-Source: AGHT+IFXul0bgnY7zk4NOzGxHHsdzLgF1+KQj4j7GMxEgYU8BY/yav2YNP5bl3G/GV0ZWypitMVumQ==
X-Received: by 2002:a05:6512:6d1:b0:529:a55d:8d7 with SMTP id
 2adb3069b0e04-52bab4b0904mr3965171e87.14.1717678465313; 
 Thu, 06 Jun 2024 05:54:25 -0700 (PDT)
Received: from [192.168.183.175] (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a59a3sm21039495e9.22.2024.06.06.05.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:54:24 -0700 (PDT)
Message-ID: <2712ea39-89f6-4c1f-92d8-b7cd3f923d0e@linaro.org>
Date: Thu, 6 Jun 2024 14:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/5] Revert "meson: Propagate gnutls dependency"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com, Roman Bolshakov <roman@roolebo.dev>
References: <20240527104937.30443-1-pbonzini@redhat.com>
 <20240527104937.30443-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527104937.30443-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

On 27/5/24 12:49, Paolo Bonzini wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> This reverts commit 3eacf70bb5a83e4775ad8003cbca63a40f70c8c2.
> 
> It was only needed because of duplicate objects caused by
> declare_dependency(link_whole: ...), and can be dropped now
> that meson.build specifies objects and dependencies separately
> for the internal dependencies.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-ID: <20240524-objects-v1-2-07cbbe96166b@daynix.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   meson.build                | 4 ++--
>   block/meson.build          | 2 +-
>   io/meson.build             | 2 +-
>   storage-daemon/meson.build | 2 +-
>   ui/meson.build             | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 9772c145bdb..84dbd7fb371 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3486,7 +3486,7 @@ if have_block
>       'blockdev-nbd.c',
>       'iothread.c',
>       'job-qmp.c',
> -  ), gnutls)
> +  ))
>   
>     # os-posix.c contains POSIX-specific functions used by qemu-storage-daemon,
>     # os-win32.c does not
> @@ -4004,7 +4004,7 @@ if have_tools
>                dependencies: [block, qemuutil], install: true)
>     qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
>                  link_args: '@block.syms', link_depends: block_syms,
> -               dependencies: [blockdev, qemuutil, gnutls, selinux],
> +               dependencies: [blockdev, qemuutil, selinux],
>                  install: true)
>   
>     subdir('storage-daemon')
> diff --git a/block/meson.build b/block/meson.build
> index 158dc3b89db..f1262ec2ba8 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -39,7 +39,7 @@ block_ss.add(files(
>     'throttle.c',
>     'throttle-groups.c',
>     'write-threshold.c',
> -), zstd, zlib, gnutls)
> +), zstd, zlib)
>   
>   system_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
>   system_ss.add(files('block-ram-registrar.c'))
> diff --git a/io/meson.build b/io/meson.build
> index 283b9b2bdbd..1164812f912 100644
> --- a/io/meson.build
> +++ b/io/meson.build
> @@ -13,4 +13,4 @@ io_ss.add(files(
>     'dns-resolver.c',
>     'net-listener.c',
>     'task.c',
> -), gnutls)
> +))
> diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
> index fd5e32f4b28..5e61a9d1bdf 100644
> --- a/storage-daemon/meson.build
> +++ b/storage-daemon/meson.build
> @@ -1,6 +1,6 @@
>   qsd_ss = ss.source_set()
>   qsd_ss.add(files('qemu-storage-daemon.c'))
> -qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil, gnutls)
> +qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil)
>   
>   subdir('qapi')
>   
> diff --git a/ui/meson.build b/ui/meson.build
> index cfbf29428df..28c7381dd10 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -44,7 +44,7 @@ vnc_ss.add(files(
>     'vnc-jobs.c',
>     'vnc-clipboard.c',
>   ))
> -vnc_ss.add(zlib, jpeg, gnutls)
> +vnc_ss.add(zlib, jpeg)
>   vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
>   system_ss.add_all(when: [vnc, pixman], if_true: vnc_ss)
>   system_ss.add(when: vnc, if_false: files('vnc-stubs.c'))


