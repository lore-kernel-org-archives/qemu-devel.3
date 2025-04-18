Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5032BC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5py1-00032T-JN; Fri, 18 Apr 2025 13:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pxx-0002x4-DR
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:57:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pxu-0003fb-D7
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:57:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2260c91576aso19925345ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744999044; x=1745603844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oAculvTHDPhihl9UkE0Zb21PAt6tKThbvV5yac1Jfbg=;
 b=h9zY9Gyq+AL5hME7/sfJcIb7fdChZ5z+uJ6v2eIcQBTF86NPRTtH6VLVl2h0w8lsYK
 J5bkCfYmuPVNDpABTajURX+pAiARrqD571e//wtGMNdtMgJsmK5fHXat57let0cLYai7
 0QMgsEx72xlSxyFrCo17rgX+L0OXpgipUAk73pltcuztVkl/fd6LX/zgK3Qk6rt3ryon
 MosdbaxLZqxrzUBD/HwVj6RevT1tHeuDuLhQo3F3QY7BB2Ftoaz3zqhCgAfB3/4ZBEY3
 oAVvScxKHr5u3yDFADg1aQKNEsfuvshYpSIXhR1Gg+Bh9/uMcLX69bYjc3joVLx596eS
 IdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744999044; x=1745603844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oAculvTHDPhihl9UkE0Zb21PAt6tKThbvV5yac1Jfbg=;
 b=aql08TEN4hO+H8ldekCk05nknSX+2wArjQm4qI8v6QUDv9GVj/T2SfAAV7rssh8Dtu
 eW2Rrm+VvNVdWrVQoHmIrZxAUuhReO5ivveqXPIlLdQSBA38PohRy/WkZclH50ywf4r5
 zOM5sc3x4DGT7pk9Idp06vkqF5PXWqBP8gokYVdt9MdpvllcQBD7cPIp3QQu2orV6dzY
 r7r8vLQNMpkHhDj85aH3Df8wHfHwV48mTwFSfReTwSEIKOP78tzVTiq9sWX6FgCwib8/
 xqPvy0IjH82AjPt/WrX717USRV32uQa0b6BB68dGVE5n8KcniM/hb+Tn4AONzIDIInbe
 cuiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMgvJXjoWoKqku26x7d/G/5fJPMSxNSWewtghK/WhHCDi8bHIqDy+Rkjbpxr5rDunxMFU5onzV6Ryb@nongnu.org
X-Gm-Message-State: AOJu0YxUnjS2o3ZZdRUH9DCNzvyHU/R5CMKIBbcS4fFbGS4x6GF968RF
 Bl/30AcR1UopNQW6fOY5C6HcVntKNJsOyMbk6xvhBQ4BaxuIjpDu8O7jn25u8arbrc+fSdF/+vP
 Z
X-Gm-Gg: ASbGncvGPeusyKz277tDVHDdSqXf3TDdzJYXURavxl4eptwkEc3JI/onIRti5ptM2bq
 4iW6YFaXeW7QWINgypjOkqZXaDBpmGWrB/6c0iyD0BWW9WjxUD/ArcdxmNMgiI3xLqtDVVF1+r9
 4gKEfRYl1Cqrq1mLNLqE1jzPT5d31LLcs+w/SXIXFGaAAGDZdA6LJx2CxMzMm5gnDg9AQuzvCOZ
 zEcr5CARlmL+zpIMyIPWaheABnzgj8UB9e+/1LQzN38fFfgbX+uhUtiZxG9ci602jNI72AB338Q
 o9orOooEEj9E3x+VspoqOG5QBWhdPnjCloAU1LkKryaveBP1t2uXUazqoCSkkxuDqRRg4gKYjBr
 uyzTlFos=
X-Google-Smtp-Source: AGHT+IH5QO1qvbCJRwDhMHHrfGsbkw8zJAg9YXCd12LmHTYdKbIbo1fz8eMv2WMYtB/Ntd0hJkAOxg==
X-Received: by 2002:a17:902:e74f:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-22c5360de0amr53100275ad.32.1744999044271; 
 Fri, 18 Apr 2025 10:57:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4bc9sm19595025ad.128.2025.04.18.10.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:57:23 -0700 (PDT)
Message-ID: <e8769e0b-bbaf-48da-b1bb-988e591b3248@linaro.org>
Date: Fri, 18 Apr 2025 10:57:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/mips: Evaluate TARGET_BIG_ENDIAN at compile time
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/17/25 06:10, Philippe Mathieu-Daudé wrote:
> Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
> time via #ifdef'ry, do it in C at compile time
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/jazz.c    | 10 +++-------
>   hw/mips/malta.c   | 21 ++++++---------------
>   hw/mips/mipssim.c | 10 +++-------
>   3 files changed, 12 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

