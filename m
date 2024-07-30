Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3B1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 07:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhDc-00082B-7C; Tue, 30 Jul 2024 03:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYhDZ-0007yc-V9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:24:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYhDY-0001oI-7c
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 03:24:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so1902677f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722324258; x=1722929058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+hWEeZgmQLWvZKuUcgvuQYHB1gC3yeiQ+90apa7U6ww=;
 b=loP+S2fj5rCD79Et3RCMs4HzpngL8RVtWwLrWMXcWiTZ2r5fCc5gQLf6tA5f7IDyTM
 951K6BPOUjqxqwUP+PR3U71e3KtuaDDlUW2olS9D/8rY+6wt07pL4B3UrcggS5bY6VwH
 lBYne7lGqmb6RaJ4sWsga8Ef+D0oKm1QhgKdHv/FwgO6LkOPbXEYWe2HxSDNvaHOlb1V
 cLB9a5XPuo2Uc8FrALDlt15wtaRvp7UnQ/0CAiv7UnTUsiC4n15WEExXkB2vGpr3COrx
 MfcriKn0ZsGFRCucIEYbeqKs4H3dz0NXAAYOayGB40jtU0FrFT4I4YN/j67RjrVMQzw9
 MMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722324258; x=1722929058;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hWEeZgmQLWvZKuUcgvuQYHB1gC3yeiQ+90apa7U6ww=;
 b=mGdySNA5ok/A2u74yFuxg0LMRZCwGCQZi3RNIpgJx5M1qywoNPwklrffFCZ2MwC1WQ
 liD1p6qV43TtNDlDTFINOGlpfO+wMWjkGH3gLyc06GrY9KAte498UsflFGOPR+LI5eAX
 O3Uuz0jMvthvjc8VcPyZo/NQKtxs3sCuZE7TKr6UVoHtPMomLCA/Imi9QcvWlfm5mzRc
 Zdsa0bRfHYzHkL72WLpRB5S6CKmaNiKDpsmWjhrGTjlOaa8j8+zK9I5k0u+tqd3yxEDQ
 5C3YzyjNpOJkRgRoAVGHWEUqt4cU7By2onWxALlnHKBshCz/+w4K3NSAm2bL6r4u71mp
 Vj4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTvLsC9qWJP2sVeclR+loT2bUFBCBXLXmgsHWRzjbMOEcOkKb+Fv/ei9nSiuaOCcLrDPPIxWIex5Birb0P+tLnA4a95Hc=
X-Gm-Message-State: AOJu0YzX38Y8P44xoIA7VzO9sj+X8cMojGyyxL0OhR68q8fLPdxZtB9h
 gvJYslqt0fC5q3te/dWXvKYXURqrfeCqlUtkqblHPChpd3nfaeiz6Jt9wgBNYK0=
X-Google-Smtp-Source: AGHT+IEiVk4MUKtRtkZZdaSlhl2OawIk0XrN256zxArHbWGc5CV+e7lAk510y2ZHj1KeFDE5WparQw==
X-Received: by 2002:a5d:56c3:0:b0:367:96d6:4c2d with SMTP id
 ffacd0b85a97d-36b5ceed146mr6509949f8f.25.1722324258253; 
 Tue, 30 Jul 2024 00:24:18 -0700 (PDT)
Received: from [192.168.38.175] (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857ca5sm13941730f8f.89.2024.07.30.00.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 00:24:17 -0700 (PDT)
Message-ID: <89bfc587-8e32-44ac-8039-456b6fa0c663@linaro.org>
Date: Tue, 30 Jul 2024 09:24:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix BTI versus CF_PCREL
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240730013922.540523-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730013922.540523-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 30/7/24 03:39, Richard Henderson wrote:
> With pcrel, we cannot check the guarded page bit at translation
> time, as different mappings of the same physical page may or may
> not have the GP bit set.
> 
> Instead, add a couple of helpers to check the page at runtime,
> after all other filters that might obviate the need for the check.
> 
> The set_btype_for_br call must be moved after the gen_a64_set_pc
> call to ensure the current pc can still be computed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    |  3 ++
>   target/arm/tcg/translate.h     |  2 --
>   target/arm/tcg/helper-a64.c    | 38 ++++++++++++++++++++
>   target/arm/tcg/translate-a64.c | 64 ++++++++--------------------------
>   4 files changed, 55 insertions(+), 52 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


