Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E44FC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUj6X-0002MA-8i; Tue, 30 Jan 2024 03:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUj6U-0002KR-It
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:04:22 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUj6Q-0007wh-KO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:04:21 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33af4a0beb3so859895f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706601856; x=1707206656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WQS/DTCAth843XXnQ/ILjuXfgm4N90QaEJs6VGT5BG4=;
 b=pwEtIsaC80/Bw3g9BYUM7Kg7+Qx1Rx2SGojP8IUnKDdkV2FtdJBk2S1GFRusMOkbBq
 IzCi5y82nUX5rTV2NFKD3T3y6cxY5up4zXeg8WykK5zJJslrpx2ZCcnGGWQfnEtlGfV4
 egfkm8dYVQ8W388oXAEXMmj63fSaFlj7ry11M1v0pvh5h5cc7yfdXpl4nZANNh6layx9
 hxJtrwi/YcHqIMsEyhXTR3DgL67mBXOZkvOuXRXGlvp7kT+QY1l6Drl1Q3K4AxG67axQ
 aqq3WZEkgE6mA63hUBBORoAxV/wvCbue5hyWsxeyBKKr7ke+i6YT+qsXogcQd7t+Nw3W
 7bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706601856; x=1707206656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WQS/DTCAth843XXnQ/ILjuXfgm4N90QaEJs6VGT5BG4=;
 b=lzetvmXUISz7edJysRwP9dEkhUbrQS34JN5Hov88pMZyQuVTbMIdkmnqel6TxiMEOC
 woqzMPfYJLDJ2ybc9Pr1GMrW0wTCrGwmgvdl4Z1gsMAHrsJjqN9BXBIx2NN935MynSd3
 ZogCMBSMu/+DBJfilB+DSFv1NljEEROWkEfjY6avUEmjOetI++QXQBezUAo7kbATuZn5
 WwIKZTSV5ZXZ2xW685+QnqZUIYJSNBWefTvl8nAg8yYoeLyLkjY9Sh+bT90CrVqnOhGZ
 YohhNYuLmrLAwe1c1YLjtaRrotBFmAM9nDjGPRNTAM+1Sod54x6pttCKi0ivkb6+WAg8
 l1GQ==
X-Gm-Message-State: AOJu0YxP/d92VJGvdI5ilI61hD0yQXCg9b4iooBShX7wGFrpzU6dDAt7
 K0aYhpW9qNtO3dwPUu5vkl5z81vg9RV3UlrIwfMDsDPh4MnHND8UVRRUR3Vwx6k=
X-Google-Smtp-Source: AGHT+IG9a3km+EaU2eDSNGISmPlQrbiVbiNNglwhGEQhf4gPfb6QeIOEZ1cEHfgRWox+Rx/L7nwaHA==
X-Received: by 2002:a5d:5264:0:b0:337:bf81:e07f with SMTP id
 l4-20020a5d5264000000b00337bf81e07fmr5321795wrc.52.1706601856171; 
 Tue, 30 Jan 2024 00:04:16 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 by12-20020a056000098c00b0033afd0950c7sm318791wrb.81.2024.01.30.00.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 00:04:15 -0800 (PST)
Message-ID: <5372cba1-48e3-4927-b4a3-15e69a0583e7@linaro.org>
Date: Tue, 30 Jan 2024 09:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] target/sparc: Inline FNEG, FABS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20231103173841.33651-1-richard.henderson@linaro.org>
 <20231103173841.33651-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103173841.33651-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 3/11/23 18:38, Richard Henderson wrote:
> These are simple bit manipulation insns.
> Begin using i128 for float128.
> Implement FMOVq with do_qq.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  6 ----
>   target/sparc/fop_helper.c | 34 ---------------------
>   target/sparc/translate.c  | 62 +++++++++++++++++++--------------------
>   3 files changed, 30 insertions(+), 72 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


