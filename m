Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6413DE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgHj-0003af-DM; Mon, 09 Dec 2024 11:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgHg-0003a7-2W
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:06:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgHe-00015k-LK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:06:55 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434f094c636so11174185e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733760413; x=1734365213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sF1ENL3tbtVpzyUNPKbqpH47ocSD+Plr2/duZUM8iNU=;
 b=MHJCs10arNltc7BAKVy1mXinALlIY1pu7/oQQu0aBb49929edG/p1h85eagoSwoYYW
 RwYPrIgtaKs3jQ8t7qGFfCZLDLzBEgBmQRw1On9NpOMGRKnVCvH0LIRVHuDZCVhfmmJX
 MSIDHFb/e0f7WvkHeuGkDjBa31cLEC/N4C7Zd5OFtwvAGP/2bzaMJyPAPqYSjvUBSgko
 WE9TnQQHsx1xF9uX1nXvzKVQVJEtx4VTAmRFjf+++Y4d+xhCrjjoFGNdZDM4OBlLvnya
 kqPiXEgv+0Qk7Al0yjX3Tfq+HYpUIBLPFaaiWJq9PXs9u6TR1ELoEYcaT3T1W4I5O/0o
 WNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760413; x=1734365213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sF1ENL3tbtVpzyUNPKbqpH47ocSD+Plr2/duZUM8iNU=;
 b=PVpvn6dgHZeQQ8DoqbTdWg6MZL4MYpsyIorxMIaCmuQeYPa1LLVjAjiAfZcXabsNaN
 2rmf/G+9wlu2Vwl2MjF6UgqdCIuj43Vbrrc2jahnsYwsY+QMCXMy+0ksl+J3ZX9FU14T
 Kel6rcAOT/TYtmZCl1zSJ+vZXkQ5Je3URVm7WodH+K+UFXyQccnGjvH2++1SH9OUAxw8
 rDfcldUMf6SN5L0GgeU/3in7XarvgGO70+01rFMVmKUNxglPZ2CbPJ/K1SwUN7pAhBr9
 M0o241bWdSVNJXQCzcjyETV7oAnHUtYba23vFmCA7qvtGmX2dw0l7FchEwYbxhZkbqf5
 IRSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURN55v37Hcph6gIQ9esDN5vQHqmBJmFxhs7GPofTkaUQgVY9oWinlLY6MNcGZ+T3hFXTsvPGYN7V92@nongnu.org
X-Gm-Message-State: AOJu0YzxvQ5WvzQUCn1bg8XajRjg+u2j+F4B4e8T3SNsrMndO3yjpGxo
 5Aod6lXzsR45q1sG1PQI9UuBt8nZEUVGVVZfHpJ9h87dmC+Vq2k/M9RhVciH2r4=
X-Gm-Gg: ASbGncs+QEulEmw/VQkgxgOPYlF+cJfSewP7sWnqj53CBxfZr8M4s2uO58SsEvlxwoh
 3kOAjbIrIBlCkWYsygg2PLMBjvoKFHL37Ss/oMSmtUv6Nm/+4mikIOcCfLgrOOxrY6mpbe8GeaE
 uKZIyAb+Dtwx15j5bc9UbqRFTjs0siMJDW3z1+PmfbLBCdxH6cvDKbgk8tlTpUTpEfloNZDFyKe
 HpjOx3M7Bj8RomwrbXp/hqoj/koyW9pAIGlXPKQ5+KQUyJ9cLETbr15PwLfbe94XxcKUA68ET0W
 VxkjLMmox5FZp7sNnc1+NVCCKRNnJE/Q
X-Google-Smtp-Source: AGHT+IFVUDlD1QwdfU3oOSO3aodmV5XXvWRNVGVZPrZohTVk2zRniDS++ucS5RCNt/2wwGJTHAsm6g==
X-Received: by 2002:a05:600c:1e25:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-434f8711ec5mr31917395e9.29.1733760412889; 
 Mon, 09 Dec 2024 08:06:52 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4350159f6a4sm3313485e9.21.2024.12.09.08.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:06:52 -0800 (PST)
Message-ID: <dd89693b-2259-4f21-bb6f-46be90837506@linaro.org>
Date: Mon, 9 Dec 2024 17:06:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] target/sparc: Use float*_muladd_scalbn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241208224844.570491-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/12/24 23:48, Richard Henderson wrote:
> Use the scalbn interface instead of float_muladd_halve_result.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  4 +-
>   target/sparc/fop_helper.c |  8 ++--
>   target/sparc/translate.c  | 80 +++++++++++++++++++++++----------------
>   3 files changed, 54 insertions(+), 38 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


