Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0485AE63F15
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2LR-0004Dy-C5; Mon, 16 Feb 2026 12:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs2LF-00047L-Lq
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:25:04 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs2LE-0001sd-4r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 12:25:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so18371785e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 09:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771262698; x=1771867498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=092vyY2pu5P0qQlyeuwKjkRm11oNmFxVu1mg8dthB50=;
 b=wqvDb+xOvj26q4VvtbW06tdTEkaSpIh6isWTOSYQazp1e31/TFhG4+Kvf12XPl5EYg
 sSjH5mn7RcdpxrdlFxMinGfGWD1lmXmY5YqxybpQBOODR4buDOgUDsZJH+Sd/HhGpDYo
 DhwapZTfesBz7rInJ+aj7MSy7sC+W5JrJs8VAWReMyn9aVfA0+zek/+iVIiFZ4NOGhxQ
 kFqNMVA3YhRtaV17wFhoYZMm/gonY+7Ts9pZtwNuWkXjQWmX7G4Rto2jjhekA/OMyCqp
 6GR6/+WsTmsDDlp6xQUbNAGaXMkYNidE49FoRsRxd7uDrVLw84pH1QJbmnubNY+Gslx7
 pd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771262698; x=1771867498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=092vyY2pu5P0qQlyeuwKjkRm11oNmFxVu1mg8dthB50=;
 b=Vp83k2b6fXDY+ypoMHhf4BdXxSBMgpxxLlpjqfwkVp3SPnew+CdWgZsDhcaibwrRFI
 qNvaIdnP6vog3T/wzv4+H+mjSABGBENCkAkWVWJJgpEuhWO/KJ5XC9dAzlV6hxYXU09W
 SGWozR2zAYJp4CJHd01TYw5NRqPhKind2M+7Nouwifzc/GVzNHALXUf6E6xrsOttQRcs
 ImciT9vrmNrEtD+VlycUdQ4BPdkoGVS5N3KBgEKs7DNEkHh18Zq0buS7S2PelN/nL3X7
 Y3lYtw9NvSWeJ61xqB6IyW8oA16uROyirPCmYf22rJ3X59KtBi2os+XlANX+k+Sx4Jsp
 Xy4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc+pJDWYxd71Pw8NbeEsdE/QO7SymEQnRVUvvlrDy4zRXPrr7VW7e1eE5HGnayPoZV9VG78WSkTgnX@nongnu.org
X-Gm-Message-State: AOJu0Yy38HIZoT8YhWO8kPkA9jSujztGADOWgwBiWlVtfeWCUXaxHgfV
 cEvJXJviiz39ZdIBfGaCxmezhqw+HDzUwahip28i2KZH1IsTF44niv9GsnYNC5D1Hgk=
X-Gm-Gg: AZuq6aI1oHb3tryVy958mpbqMSo/APh46U3UWcFzM4piw0UgHf5dhf7BnxJ8BESpIps
 qVGFZEAZ/XMQUoiBGFsYXy5RSSHsqeed+PrUst7qPzJAP5UyTvYtCgWGq6IbGevcFgyimhZUgYu
 kA7XAcMSpK1OaQfJY7BX9iAfxGkpKkbETwjbSS/3PCciMzJ2i/vGeHeLEEMxctqqkvxN6veyQpT
 uTtGSaJRMl41N5fZpKP6tKYIfsGizM29rdL+S2rJbAnkz6YcHOHK3wGNdUEwOy4yZSqMGjpCLPx
 knc+gDLWZc25YT0Jj3HW0B7wIjd+Rlc3ePig6aLwqlA1GCJvMw/Vg1e7qzTsZcM97r5PI8WReeE
 cazEfod7eTmf7dW0JvmuPdMhzgghOlLmP89mCSHIF1UdVujmBytLWnOR51EC+7bEKc302e0Qja3
 IqZFUOmKiSNJ5ddsSM9XXRem5/Jz8hQPLlWeu4JG/4RC5kv9cUVWzhGgdZPpb9/adzHqitfPQbJ
 NZT
X-Received: by 2002:a05:600c:6989:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-48373a44055mr196367945e9.26.1771262697669; 
 Mon, 16 Feb 2026 09:24:57 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8075sm27926909f8f.29.2026.02.16.09.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 09:24:56 -0800 (PST)
Message-ID: <b1dcb5e7-5680-4397-971d-3f7544a20568@linaro.org>
Date: Mon, 16 Feb 2026 18:24:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Don't require helper prototypes in
 helper.c
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260216160349.3079657-1-peter.maydell@linaro.org>
 <20260216160349.3079657-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260216160349.3079657-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 16/2/26 17:03, Peter Maydell wrote:
> In arm_cpu_do_interrupt_aarch64() we call the TCG helper function
> helper_rebuild_hflags_a64(), which requires helper.c to include the
> TCG helper function prototypes even when this file is being compiled
> with TCG disabled.
> 
> We don't actually need to do this -- because we have already written
> the new EL into pstate and updated env->aarch64, we can call
> aarch64_rebuild_hflags() to achieve the same effect. This is the
> function we use everywhere else in this file to update hflags.
> 
> Switch to aarch64_rebuild_hflags() and drop the include of the
> TCG helper headers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

