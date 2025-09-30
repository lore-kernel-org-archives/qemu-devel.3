Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8883CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 00:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ONA-00057a-Jr; Mon, 29 Sep 2025 20:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3ON8-00056v-Qs
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:37:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3ON2-0002af-H7
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 20:37:38 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b555b0fb839so3876302a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 17:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759192646; x=1759797446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=upJZQb1xXQgeVLMtUjuSv0bKfilTjHFJ9aR2pspfrjE=;
 b=SdNBTjOrLFSS2H4aToLYKFOtr32G/LksI9vJEYQl2peyYkTQoEx9DksF8USakBG4HE
 M+wxz7HmUBafKPk61h/nAVz0cMaJ2d+U2GaUNSq7smGDQOjEoMBBpIFzyA7DTl88QB7s
 5hzut0f+qCX0gMQbhgbfPpw+pd0sMk8/N1hJgxbcQWPEG9Ix7iqa7glrBKsdu9LPDHg3
 QfoisTxvgyWGxirUvRY0p4Q5qVwMinKCbyO7a2qgmC55xyWXo6R3N7GaDL/2UAcigpo1
 nX/K3I0FnHV+Zxow/idK+x/wrc49Jx4eSoAS+9exDOysG1O52EBqamVzrDESa8GYRhT2
 OYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192646; x=1759797446;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upJZQb1xXQgeVLMtUjuSv0bKfilTjHFJ9aR2pspfrjE=;
 b=h6Mu8u1XWrsQggLyoWjTe5k6M3yl58oSzRwuKo8OfFw3SOOKtl7ECFBUDTw8VHlIuq
 O6CLsIaqLvY4CFUfzDeCd3dJpW7of9bRdYq9aMW7xEQ4E7/+M5h49TVBL3UYGcI/QVks
 nwe5T53iqOnnvygPm6RHBer7PtqZ+O6DPSJ6Szet+Qfs8SPe7UWGmOCEKixnrPvRHxqK
 +jOKMw1sxaIFm6DUSzI7v61H4HL1IqMCss13Tf2KEtIO/ZQMHFHT9N5msdyje3lN0rQu
 90gqslMHLHHFbLokuf0he3O5lfI2yvkxT5eumhBU9M7q97V/kjoODxYG/6b7fgJC4lYo
 Ao+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEDEyoxhhLog6oOcvrHrcRbnkAv4QNAU00NYVytlSkAB6ZcXerPvyeH+Ktyr04DSqnFwpE8+T0oE5h@nongnu.org
X-Gm-Message-State: AOJu0Yx15Ua+C0edSJEuD3vVlaLSfpqPkGEb5DNo3qIJpJDsZHlHFNtJ
 hu9aCXTbq8iYHgBgTuaU5R06JQ7Am8KRlSO0TsDC7Za7D2civhKyJDAAT0ZXvS9dayQ=
X-Gm-Gg: ASbGncsch6/p++vAccigDjzgxy5HaqNgqZLiMweTTHF6K0nRNLZx2szO+Umla7G5761
 GltRnkZX4aVHpPx3TamR75DDWiJ/OtfXBF3d23b6ZMch8459xMH3u1ZhekX+C1FOi8u1sAp1m27
 G7l9PxzLyzJEadXi67geO8aGNcLWftbJz6RNPmy/fEdHRUphb+ljuOQjo2tWb0teEC3tiBR0XfX
 oZnMeueTUVEeGVsZ35kJEuspqMPZBN7VrnB2MEHncP6U3Ofu8SsM0PkAg8t8adYtGocQy1bt0yD
 3ZtXMZnP8aom31nNJqexCz0TBT8T6o/xaYbD5eL43w6mUxetiyEBrxgTXPScDv6tyenSSCQv7fa
 AS7K0QBcjRhwzQJpuq4AGkBvfjJqxgp4Sjic43SmO9BTh7PNdVvCM2TMU8aNN
X-Google-Smtp-Source: AGHT+IEGKHSCl9qzpQDYwz7X7ctj0gqS/UxJiXTLf5dRhGmFgfQ8GX8zMIxSi7dH2J/ECrIkoOGJKg==
X-Received: by 2002:a17:902:d4c3:b0:265:57dc:977b with SMTP id
 d9443c01a7336-27ed4aea9d1mr201425925ad.61.1759192646493; 
 Mon, 29 Sep 2025 17:37:26 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6700cb6sm141535335ad.34.2025.09.29.17.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:25 -0700 (PDT)
Message-ID: <40cc7682-317f-4e53-9725-9c028700cf78@linaro.org>
Date: Mon, 29 Sep 2025 17:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] system/physmem: Pass address space argument to
 cpu_flush_icache_range()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250929183254.85478-1-philmd@linaro.org>
 <20250929183254.85478-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250929183254.85478-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/29/25 11:32, Philippe Mathieu-Daudé wrote:
> Rename cpu_flush_icache_range() as address_space_flush_icache_range(),
> passing an address space by argument. The single caller, rom_reset(),
> already operates on an address space. Use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-common.h | 2 --
>   include/system/memory.h   | 2 ++
>   hw/core/loader.c          | 2 +-
>   system/physmem.c          | 5 ++---
>   4 files changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

