Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE20DC2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 02:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcaRM-0008SH-RS; Sun, 04 Jan 2026 21:35:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaRG-0008OE-UW
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:35:23 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcaRE-0006CG-EZ
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 21:35:22 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso121645025ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767580518; x=1768185318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GjUEMC2qOMhWebF+WzDZYA6CuVn2Mpeuy8/UEW4nk2Y=;
 b=dG5sl9iPAnXbXTR1jfwHUZy4k1TsrgB8peR+ClCqUIKb7RxCCX+jJENmkkgytmEvwg
 NbpcNJkQMdHUl5B4JriW9ZGvUVNyki+jFfFUIlMGXOEiAGwjSz3/soGwcCYQcZ6aqruu
 UIpsIy3cxX6MeP5LslxmK1tCDQW0dl1mRFJxtWJ7l1OZYSDq6/BLyBD9nZvzRrlpPHkF
 DUn3+qtpahOlYeH0TmTD6R+xD68eSnasuoPfweLaBFT7QvGXQO+pDo8HXAlDunGhdIx2
 NPcEYP/hukyJkDPIkXkcvbtF+8p1vcV3wygwQkOvi+F67ed506fRi5pyPvl8q7/NJhAS
 KfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767580518; x=1768185318;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjUEMC2qOMhWebF+WzDZYA6CuVn2Mpeuy8/UEW4nk2Y=;
 b=uShmCnoQixX9WbQP48vQAJaARfLWOTsekFggWTxRFbwGE13kKR9808BNpe5DWOd7Ot
 fec5u4LYUOGiccb4tzK4ZHk4VD/fD9gPG+aIPu8m/3RJHTyewKyUWE+tDwywWKRL/Dwx
 ozKg3EkgA9YU8HLqE4BY/3r3HgAMnzGAq4vEfU27yIqlSz0C+N9Cubek+5keA0RmMuI9
 muxkrDYSSrQ0moXed2UfnLzV0OYgFU/8lIuttUA1yYU48uyvwl89fJ+J1HtB6RFw3S9p
 1yV6onvM1m/UM9hzH5gfvHcWY/tZIT+QKqrH4+7nsYT52zFk9/LdfoT6aa2P4N/jASAr
 zg3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ8HMnBBOpQGFaAgyehDRVbkZCcFdeQeirtzMP1RCAcKCJC0LAvxEHuf+cmGKBg6r01GQIgx132Iky@nongnu.org
X-Gm-Message-State: AOJu0YzLKe1+L6mKu+F0LweB8nrnd+iC/WQtQTO9i4WE7NHxkJW382EG
 JNm4ZEWzqTkNNTCP09Q1vsKFaAv0srWlmv73eWLt6YsJRPbRHlREBViecO4FsuPwgVo=
X-Gm-Gg: AY/fxX6AYkuUVrM+bwROrjrLyJNTqNc5AsL6z7LYRkxdJGNqxUB5gvNBGr6VQic4s5f
 WxFvqXtNme/CwF0xAx7cG9B811wtruJVwY3Up39dTfTKInJOye2b/J19HLRnXEnhnDww9tY2tYp
 tG55q6QozZFwUvjRi4O+RVFPspCx3zLEffkn+7BmKnhi/3+1wPYAPyb88Asmhe7/q1UccPnEHkC
 wwOBFpkLn2iCHx77JlTgqWkL8hWYQgdbetFHgTkSlqf5q+KF2rXpwbX9/7RYBx8pnmEKQSWjskK
 JChU2XMKykVcrvQUc8BcY47Prth2WUp2Y1rUi1pOp/Tmy6GQkM1EneBUXZ9zZu20BIs1ukdL8Vx
 uzBzvjlmRyOuB6WgDswjgbMMjm93B1jcLpivXO4hmrvdaL8EMX4TEmoqSt9zYpYxZY6Z1kb6Q/Q
 zzYWz3KpjDGe7gghFbccB8Wop4dOqBuQ==
X-Google-Smtp-Source: AGHT+IG+fd+dzF7O+N3906re+2NLIM6tAY3zG6WXeK6XAGUmzlpNrTx/OrsC61RU6ewqCfsp6rf5yg==
X-Received: by 2002:a17:903:2cd:b0:2a0:e532:242e with SMTP id
 d9443c01a7336-2a2f220dd7bmr455632775ad.11.1767580517757; 
 Sun, 04 Jan 2026 18:35:17 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82762sm425311585ad.27.2026.01.04.18.35.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 18:35:17 -0800 (PST)
Message-ID: <2e5d50b9-4fbd-4050-bd1b-05b821358970@linaro.org>
Date: Mon, 5 Jan 2026 13:35:11 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] configs/targets: Forbid HPPA to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Sven Schnelle <svens@stackframe.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller
 <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>
References: <20251229225517.45078-1-philmd@linaro.org>
 <20251229225517.45078-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251229225517.45078-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 12/30/25 09:55, Philippe Mathieu-Daudé wrote:
> All HPPA-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Manos Pitsidianakis<manos.pitsidianakis@linaro.org>
> ---
>   configs/targets/hppa-linux-user.mak | 1 +
>   configs/targets/hppa-softmmu.mak    | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

