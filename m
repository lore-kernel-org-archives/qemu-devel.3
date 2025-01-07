Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D830BE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3p6-0005O2-GQ; Tue, 07 Jan 2025 02:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3p3-0005Lw-1g
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:16:17 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3p1-000723-95
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:16:16 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so158479675e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234173; x=1736838973; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GXkm0vMIRob+DQKmFalrIFk08/jYLS0dbSDrjj3esJs=;
 b=sZVCUpL9Krpns0QH6YRIOz7VbaDSKamrouaAsHWlR1vCbsSvxiDoYN7PNepyyWIyjD
 s5E/8K+c9lmR8fcYVm7ZfMqMJTrN8vA9RZhX1UgN//lPxr/+RuwtKxgkpqZBVo6LR+lR
 hlbyCjpoGnjiemA2x18C+fsRlycCDI56ojTbIBJLTLidX2a0Z19rpLtMhGrslFbsEkFG
 iZ4dooXkX7J1FtAEDdyZGOVXM2yOOn5u7I4Um+7krAHOkgL/4dBXINHmun0sb3sSBjkK
 JAaXJmTIaojhn+ZdMNpdbmGAl6d227St/jHfHFHYRGRnFuNc9Vp280p22y5GtK0JHS16
 8+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234173; x=1736838973;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXkm0vMIRob+DQKmFalrIFk08/jYLS0dbSDrjj3esJs=;
 b=h4Fy33BGVikd8GbFzChlj2meBcNLVi9TCXeRDD5L1+1+8nqzQ/YLI1qWtkrJ576NYs
 s0VvQY4MibtA4ucxJoTBLLyekjbKaBKLbwbByjfJ8Hes6PkQjbSmLUKfthXezHmoWtEw
 dqyXnT7rXQJo+SmFfcv1OQdeAarfsUKmoVdNUbPrCzAj0HlgyEebGuy6kwzQAQubcGkI
 LB+amFNV5nIO7R85j/VHsYqq1Mu6+GE0wvmZMMtFpUa26hfvYvGNRcp4us2/dXS6JGf9
 vxRDZYu+5FMRgkPrGUSB4oEbbBsYrvg64xeuEqW2WR5x5zuk60Jo32zDEjiDvGRLDBvl
 r9Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsNqyklYEvy0sJqoDdmuZczfF1BDOeHlW/yvsTVj2Rv+vx2BUqMeENwr3ba2lkwBflIUot/t4qAPSe@nongnu.org
X-Gm-Message-State: AOJu0YxZRKFBoBBsfEceKHooQifxjEtjkeXQVQLtJoVnM8++5isQ8FkC
 WeUIAIXX6nQRRdcwjtpoiMGF/pvuzMfxtR6HVyfyxYHxJaUIOy6K2Kzow3jMtwM=
X-Gm-Gg: ASbGncswiMucB6VjM0Pu3bsVSbd6+h5o5g2RT5UGpbZ3KIq1/vjQSdag+oYkg3jCO93
 Any52BTGOdrcXS/GuFY324rBSHLxM6SDWIvWltkuIYBy4NWeam8FT/UDDTsFVegIkzWBVbfjTcH
 7V3QGJQAMWNZHGX6R2qBJWZrBZ1y1zYCcH0gB+r2K/UIJnvl3kL2ZG+f66QkCnZ8eBzmY889TDR
 x8/n4phIEqbBke1No0/gM+fr6qRNhhzhT2tSb5BNsbUAQd9llYkXDU6Z2KwVp89AvSfqqx6hbPE
 Y0v+7rL0mhz/99SyeQxKsOeZ
X-Google-Smtp-Source: AGHT+IFDLoLNcJSKKlmA+3MqoIExT1vDkMbqY+K8G76PefeAearF8xFSZc0rzm2QFoJa/JY6A1nmrQ==
X-Received: by 2002:a5d:588b:0:b0:385:de8d:c0f5 with SMTP id
 ffacd0b85a97d-38a221eabecmr58151551f8f.16.1736234172914; 
 Mon, 06 Jan 2025 23:16:12 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e26csm50419664f8f.78.2025.01.06.23.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:16:12 -0800 (PST)
Message-ID: <9da2e73d-ad99-43af-8350-8553b7e90319@linaro.org>
Date: Tue, 7 Jan 2025 08:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/73] tcg: Add TCGType argument to tcg_op_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h |  2 +-
>   tcg/tcg.c         | 10 ++++++----
>   2 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


