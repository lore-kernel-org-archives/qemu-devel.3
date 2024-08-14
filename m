Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAC8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 22:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seMKo-0007wJ-ON; Wed, 14 Aug 2024 18:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMKm-0007vD-PT
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:19:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seMKl-0003sa-BF
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 18:19:12 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so266791b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723673950; x=1724278750; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QeT5XpZRHWm4pw5MCUjeaUOPokD1QjobM7JmYjx/uGw=;
 b=g8/CDuRgPaF2+XEkNEOyZMD3D5vX9nRWRsxjYYYVo14vbAAVvHzvikI92VWEq+W86Y
 UprTvNdp9KRXhNx0+wLcodlKFWunOD4htoYDKnRdxKB2welO/Ysm71ycsJLyWfCIXEi8
 hctBgOQzpBq2nUw91+0dp+Ku8RLLV6ZBRQrMV6fFvcJ2uf9BCMgD9FugPW6E2FCBe0eA
 Qm+DUK9MJs7upA7TW9n9RUufN5JmtfTiCCjRFzFdOdj9mrGa90MLelnc9oWrx6knH/MF
 2Bhpgc3y0Iab0zYX/zVeEGJRnCgQwt4Om1ZdQMTE62dffo0jXq7BvF42dflk6l70Pa5a
 v9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723673950; x=1724278750;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QeT5XpZRHWm4pw5MCUjeaUOPokD1QjobM7JmYjx/uGw=;
 b=g7P8VJe5rTiXkxD2bYQQhGBz7fIQAV6M3u+FURMMFaxKcO5Kz+rQYSbQYgD+9z8ml0
 FBUcBWzN6c5xsG6tv1pnpsIKxglIgqKK3M0x0CE0AnBnFl/Bj2aI10OIyUm4M/yM9S5f
 sHpmC7okaWqRrRJE/weXf3W1a2Xv2USNkjWtXzBbNzS74SI8f5Z7q6B4Z4J62XDDUd3e
 2Rp+9qZ8wf/YEzYNsue0YnFG57MBgIqj4AahV7hUV5zEjcvQ6PlWy29JOTxoEJY8ivv/
 HK7Kghar8DWR3jyoxFd9U1hrHdYk/hxO8FgLr1kkY3blDYBwdZpS79PWIKRAkZYK9j8u
 58YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6d3giEWYoselxLraop9oY83N1hSGBJgB8fBFAd1r7D+hRQuI0YiUSJ4dR0CDt1sPgtHPZXmAKjxqB8EoF1jmm9OobKIo=
X-Gm-Message-State: AOJu0YxZIcZv/YQU/Rpth9UB/GJ0i03SxsfMl3fwOc810oNCB3ujGaJf
 FEI93DDyO8z9fUUbMbYDbm8Bbl34c8gGw2FAbEYpvPxH0LMZ/Xlf+jgt0obIWboKtxMRSDqHULv
 Ied8=
X-Google-Smtp-Source: AGHT+IEfKm3pzGLnFZJf34Q9pGPNcqDqholUyDKNY3ACmRvHp/4bdu4Y1VPizKm3F/DesOIZRVKxAA==
X-Received: by 2002:a05:6a20:9d90:b0:1c4:a531:bafd with SMTP id
 adf61e73a8af0-1c8eae6f596mr5524883637.18.1723673949690; 
 Wed, 14 Aug 2024 15:19:09 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127af3df55sm55569b3a.206.2024.08.14.15.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 15:19:09 -0700 (PDT)
Message-ID: <db278a37-6031-4fc0-b667-d72aa8d193cc@linaro.org>
Date: Thu, 15 Aug 2024 08:19:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 3/4] linux-user/mips: Select MIPS64R2-generic for
 Rel2 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier
 <laurent@vivier.eu>, YunQiang Su <syq@debian.org>
References: <20240814133928.6746-1-philmd@linaro.org>
 <20240814133928.6746-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240814133928.6746-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/14/24 23:39, Philippe Mathieu-Daudé wrote:
> Cc: YunQiang Su<syq@debian.org>
> Reported-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/mips64/target_elf.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

