Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F769C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugf9n-0002re-Vl; Tue, 29 Jul 2025 03:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugf9l-0002ky-No
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:53:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugf9j-0000Mn-SA
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:53:53 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7746135acso2551770f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753775630; x=1754380430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=daFnnClwoI8UI4l2E7ICtx4BnOkRUbAb2tnloyYUGwQ=;
 b=ILXlFQDO8Tr7ivh6/ZGzsEGWKKFn/3UGNbQAbMmY/RVWoFCBPLFQ2nkgUjA23mjSUz
 ISOHL4evKh+OvT3odRSgNGC9zTeRwud5odlqqrrXKOQhuY4VA9aRzhdVMYKiXtxciWoP
 8jZj0C34pE3YeD0E5RWIjGU7IiSOw+dK6qNJgnadzS24Dr9WQu9CVO1f7NvJhJHGm2jA
 SW7CzIVGCeCwlp+m41oGiw4dyBUboUrmKhkOCI5QiqQapwHq+t32rYLapmSiGeSjtVL0
 rkGVeC75mzYO+551ynke0UUw15+jImIowglHa8xFwEvloIxIURHt3YJk6u1lqba2vOhu
 tS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753775630; x=1754380430;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=daFnnClwoI8UI4l2E7ICtx4BnOkRUbAb2tnloyYUGwQ=;
 b=CivS+I19q5Of4hGRLDjGMPKotW+MDF+4H+OX/glh+SKkPT4+SO74qLTmU4g+aLP0GW
 5We8JwBudKiKIOZVlkmLda3DRoaGty21c3wgdD3hVEkYYi5alc7AZEKdLJGFc7tJxARr
 Ci7jJSabUTMlmn4RV+IoWnCsxM7bfYttVfMmI8g+XPBF2QEonwCl9TG3Gt7b8kcpmXZs
 2BjyZ/ULd1ouNpm8mDKUp3s5yKZnKbcMz3y901hN1TsKWzxgAH0h+4SHcLhzvv29Rw36
 hsJLGMsw4mbatFbr+IXNthRQFqTRfDokEUP88CetPoONZhAVdNXV3JvswEwMH9n+Eang
 BrCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHsVl2A+h42h/M/jLT5oqyRdkbkpw00A55Lk/TysEr4SfVvx0pdJ/O0LUOkXMKObNU/leSBFpnkd7g@nongnu.org
X-Gm-Message-State: AOJu0YxlUpCDc6uxEAIvHPrlJHpLQk/tOAXV6jA0kqbQsHTOT34I6BqW
 KjGqyIALaIS0K7V22UC9Yi2Pc55NkCcvoVQOQ85H8jXm0MbMEORMIcdweUfoU4MMyTA=
X-Gm-Gg: ASbGncvcm11XZ8ZpJyI+F/pe5ZuWngHw7qkZswSrhKXQwwW8nOBuCy6eK9QzEJOYidc
 /GSzcpqDkWtTIybpP5FQad+JcjvzLOCltRMNi+5XO8xCa03pn4qtAAvfnlZTNi9zIQyrBk98fpc
 bHmtiv1fKRWk2X0efQi5SAhCjkl13q2b3m8VScKFi2d/T15zVIosrU4x469dGXD8q6MoAn0i/Gi
 5hWlYsPMZjGPq/hIoStNMpB/NUM45Uie9/fmpRR+tGGAj99vINOYFOiE0q3muoOMXkQLENr8kNj
 jKZd29bokno56k4Jc1Ddnzxu7p8RIRuwAf9UkoIJ+Pa8gLrC6U0gAKV0godrOnj+41nL3hQnPB/
 dqjEFcvPSxZNWLMhwLnvqiuZTjS24bard6PAu1+cqq7sHqEb4bvrKgUx63ChyXn91YwAHwRJj0P
 a3
X-Google-Smtp-Source: AGHT+IHeKswrAsNGeC9Px4PQ7DfKYDYvBkEJqCQiMHCg6VwCae136XzVAtNn3KJrrPh6WpnRooKRFA==
X-Received: by 2002:a05:6000:1aca:b0:3b7:84fc:ef4c with SMTP id
 ffacd0b85a97d-3b784fcf176mr4941457f8f.6.1753775629914; 
 Tue, 29 Jul 2025 00:53:49 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b7822d8cbasm9246341f8f.68.2025.07.29.00.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 00:53:49 -0700 (PDT)
Message-ID: <29fff141-3d78-49bd-8f83-fe16035857a7@linaro.org>
Date: Tue, 29 Jul 2025 09:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial for 10.1] roms/Makefile: fix npcmNxx_bootrom build
 rules
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250727215511.807880-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250727215511.807880-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 27/7/25 23:55, Michael Tokarev wrote:
> Since commit 70ce076fa6dff60, the actual rom source dirs
> are subdirs of vbootrom/ submodule, not in top-level of it.
> 
> Fixes: 70ce076fa6dff60 "roms: Update vbootrom to 1287b6e"
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   roms/Makefile | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index beff58d9d5..6af68a922f 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -193,12 +193,12 @@ qboot:
>   	cp qboot/build/bios.bin ../pc-bios/qboot.rom
>   
>   npcm7xx_bootrom:
> -	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
> -	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
> +	$(MAKE) -C vbootrom/npcm7xx CROSS_COMPILE=$(arm_cross_prefix)
> +	cp vbootrom/npcm7xx/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
>   
>   npcm8xx_bootrom:
> -	$(MAKE) -C vbootrom CROSS_COMPILE=$(aarch64_cross_prefix)
> -	cp vbootrom/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
> +	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
> +	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(note: not working on macOS, only Linux)

Queued adding:

Fixes: 269b7effd90 ("pc-bios: Add NPCM8XX vBootrom")

Thanks!

