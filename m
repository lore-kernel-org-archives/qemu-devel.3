Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959DBC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkBN-0002kb-31; Sat, 25 Jan 2025 12:42:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkBL-0002kO-8v
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:42:55 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkBJ-0007na-Ou
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:42:55 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216401de828so55492605ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737826972; x=1738431772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=88NPPgic9JgQJPqlM1y1Wu4MDGEBB6Zjx8EtTIj7fh8=;
 b=dxJCc8IHL3tegWnnftZtvRKhyb6ITG3pEGhg0yyhU8yQ/LxMkHG5D8H7EBnm1CEiDJ
 n0Enfwov9YvCeY8TCqUV7r37mhSYi+qdV6p3AJIwMoOlcJesxnNwJi7FINUVDoplpHjd
 oLIgLA1WLHvblmgB2xbwd9UkiG584mlcNrUX1KDmkwtvDoARn24UlRW3dTYJE8IAZOYb
 BY917DGlwZn+c5q/fnykTD6hYdjTOtYg6khtqG2f2Gkt1VvGOWReBKWsJOFqKQcGiwlU
 V1T7xYvug7V7RwGZTq90slRShe71PrOhWrqlMlDEUEKhZ0FFhMWrigljcIRwa/wm7dT9
 +t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737826972; x=1738431772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88NPPgic9JgQJPqlM1y1Wu4MDGEBB6Zjx8EtTIj7fh8=;
 b=IWYpEe5VoED2YlDfu0VFhHN4OH8WJ5gJtdnOv5u5aPgjl5ve1otvHm6nrUTEJBDJVj
 xCLULm6t7MWywHU/Pr8sgNi5xakh+GiOqF/kGr3S8blju6J1mwWTAnSJwT+h7SJprP8J
 RQd8OKXNLR2LoMR9l8oDJD4cN85cL7j5vcVLrDo54lAHSgqP93i2VYSfpUixBvcz2neZ
 nE+PaxOBLojwvnMW3JrIbFZ53W2bBXgKmoZluwpWDjaZqp6Ks1K571qeuicIMc7k76/1
 vtLVIXD3ye252bs2YWxX65L8NEYfV2DIo8kjTJL0qHsvkNEU0Tfnlop5R4K+Ti1paan7
 Iwyg==
X-Gm-Message-State: AOJu0YwQAHnsHqfafGn+MypG5PYMyofI+dqXor8cSSVNjsTAb2D8gnDG
 eEMy8TxISuP2iuzYu8+1VakaWvXpbL591oy2yUUuGL1aCb58ukLr6HY6cVKPb60TlpRUOstuO6u
 4
X-Gm-Gg: ASbGncvERh+bMlJf3n26/IhmFWzHwwoIy8uoK6N0KVf7vM0fUASBl0D2t9zit/zpltM
 jeHJAwaASk5OnwwHZfN67nxCoCJ6JwycReQenDaUUgb3GVr5G8MqCedon2VK/3b6P7BAIem7eXi
 vuXQkfLjLNovjXWnTCPKSlubmCKeL6G/1UhXAwzr5Xd40N6n3WwTclssdFXJ0W6Oa6sF8GYrb9X
 fW3ufY422dU0sTFwTY1vVI4lVyko4wYbtAa+8rxCkdBZcXZC7epIrHUibj61nYEevkp4Hu/cbE7
 ZBEZBP+L/jKA7T7kYH0PfQ==
X-Google-Smtp-Source: AGHT+IFyW43eQwCMMONBLIqFi6Tfjv0YO/OYCMgm0pNosG/LP/D41ku0BEx+RnjuxadGn1fPfgxxGw==
X-Received: by 2002:a05:6a20:7f8e:b0:1ea:ddd1:2fcf with SMTP id
 adf61e73a8af0-1eb2145ea9bmr53036806637.4.1737826972316; 
 Sat, 25 Jan 2025 09:42:52 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fcb2sm3956435b3a.33.2025.01.25.09.42.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:42:51 -0800 (PST)
Message-ID: <ee32133b-a3d5-4cc8-872a-174c38af32f2@linaro.org>
Date: Sat, 25 Jan 2025 09:42:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/76] target/arm: Use FPST_FPCR_AH for BFCVT* insns
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-35-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-35-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> When FPCR.AH is 1, use FPST_FPCR_AH for:
>   * AdvSIMD BFCVT, BFCVTN, BFCVTN2
>   * SVE BFCVT, BFCVTNT
> 
> so that they get the required behaviour changes.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 27 +++++++++++++++++++++------
>   target/arm/tcg/translate-sve.c |  6 ++++--
>   2 files changed, 25 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

