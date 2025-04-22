Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E73CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Kg6-0001WX-4Z; Tue, 22 Apr 2025 16:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Kg4-0001SX-0C
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:57:12 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Kg2-0007WI-Cg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:57:11 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22401f4d35aso63014695ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745355429; x=1745960229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Owdw+ia49ygYXT2n4GaYk4tAKzGwakItdCizYbPzus=;
 b=VrAfwoVHiWAW0VW1MI0c+y+XlpX27/iRBH/iOyCU9bGz2ZqzfWtx3WWEU3HmNhJqmg
 6OYuaVjIvwIbN8qB0O0HdIgJi1No14JL86Y11932ZLEpf4vd1fQosae2uRJph9xc5SgJ
 XWxWJYgze/bVgHq5WIzOTiPXlAU5sD0E/3mfGlQJxLdr0+8LOsnsoKLgmadjL290AAz4
 T+9k1eXBPiqe0kF6Fs0Xzyuk20vkCS/rLXODr2aCFuucmuoG/ZgFiKkBQ46Evu+YA2K3
 2NFpyJrjNmp8hQC1TXfgtFyEvFWww2ZbpxfwzjjDSP79GokmGfd6TbFKzwejpNVmQt6W
 ac8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745355429; x=1745960229;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Owdw+ia49ygYXT2n4GaYk4tAKzGwakItdCizYbPzus=;
 b=N+yBD4NPw/BgU7FOxTPGTnh9JijwYBzsNYyWodSUEB7Tq++Hu6sv5fxkHplvTWhgYm
 LGMR/hosohT0W1U/i6lFdFKpoUEdPQo9XcczxYv/a+051koH1ITL/vUICCLa8CTy0a1F
 Ap6Gv4Aok9HwvCRHK/Nke6ktzpnAw3M5R9Ib3qKnC65CMrR3VgzWhTR22cGalBDa/r0r
 dgCKA9jJq5XqCKLNf67IuUGFwSX4aJ64PuLjM96oPWHtUb+Hvtq4bphTX9hE/0CJkYRI
 7mCDN9jk5SXAjxXhSyvz8DsgW4HmbIOM5DY3BYKFfNPVOwSsO3OSLenM0a6TWghtG1FG
 DADw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSNChM9bDtOGpy67upmJtgtgX4Z+aU6rf9GNYHhYrCf96DN+Wmaa5efdTbPxZEadWZ9+QaFmY57N5f@nongnu.org
X-Gm-Message-State: AOJu0YxUQdteDJKIUKMYqmWmoPw0HNTlCphhlDjM+es/Rcrjv/zfWp7v
 Ei8OKz1n2y+560aazT9SnyNXp8nmiZJSV7JWhbefkLP+TdSikGMO/6otEcfK5Mc=
X-Gm-Gg: ASbGncuVQ4IZnYvxqHcIh2jC9GkerJjxm5Jpi+ngFvHbCGLGYzwOagZL4Yr98PETZcr
 +6/A5DCAoxs645dNMWfE9GrPlB137rch+auL4fdTpYSfmZz/kyzcH8Fy+XxdBSFNxNDK8v2pi+O
 6HZ3XNLOTe++u/ByHAgbVzUDposEBs+IlZCw1Mcrz7ksXYNpcfFeb1BVaUNXDO7lhxcYZCXzI4m
 j0j2LjiWV5eCyo+tgx4Kfxzicbdd9Q71XsxszWJXZgy+6Z1oySbah02OMQOykGIiwZUEhaXFAkU
 zl1pdME5DWN4WxylelYK9nBeaJ2A1+7G2iTWQ1V6Zdb+vJuSIh9wrw==
X-Google-Smtp-Source: AGHT+IGU/CmIstBfOIogkVQ5u7GNLhT0ue1gopSUkHaAOpC8fBlo5Bl2fjdB6gYwN5Huq3kDCWSnZg==
X-Received: by 2002:a17:902:f70d:b0:225:abd2:5e39 with SMTP id
 d9443c01a7336-22c535ac94bmr232782995ad.30.1745355428928; 
 Tue, 22 Apr 2025 13:57:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf55d0sm90407315ad.86.2025.04.22.13.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:57:08 -0700 (PDT)
Message-ID: <58c695bc-3616-4884-af8d-c867842754f6@linaro.org>
Date: Tue, 22 Apr 2025 13:57:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 144/147] accel/tcg: Move mttcg warning to tcg_init_machine
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-145-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-145-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/22/25 12:28, Richard Henderson wrote:
> Delay the warning to tcg_init_machine, because we will
> have resolved the CPUClass at that point.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


