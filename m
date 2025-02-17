Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D40C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw6t-00048w-Dp; Mon, 17 Feb 2025 03:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw6j-00046u-Fj
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:04:01 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw6h-00084Q-VW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:04:01 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220c92c857aso63389125ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779438; x=1740384238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xbv02Mq8gZJ4LRHi8wjFzm32gnurY4zd5Q14eu6qk3w=;
 b=vrvOKBw8/2E3BhzHDqVwxJeXz5fI6NWfxovx0AZAXSrJ8K63gxR7MsbpiR7do+sW5L
 SmRd6oU0tFeJ6J4GvsvOx/tuxdthhvp6Pg5yTZ2+Sad5XvOqGH9og/TK1HYnGa+o3/hT
 IEl3jB89EN2y5WhoVEN3DB7tFVpwoAW4jda/+r9EdymN7PcCwZMMdnO3d8M/m3GlQbt+
 XfWiUFYtpSFcglvPke5Ri7uwvKu818rjHLESITI6nBz5R3PUMLE2UfuiZsBnCtwrD2Of
 FSfmB4uJPHsbTq5lrEvazzqh/tSLyWqMqSWjSKt4cvcH2wNt3TslRgOTRAW+PTqkh3RA
 qXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779438; x=1740384238;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xbv02Mq8gZJ4LRHi8wjFzm32gnurY4zd5Q14eu6qk3w=;
 b=C2stb+uVxqQaIcREgOZgd0zZs7lHWM2Hqyr54qG1zlzdRx0VfMGTyySkQYmXkLWmK8
 voVNd9BG6gyu0kP2fFJsZ9pLpVLOj855ZxcJg4lwZC37MivShmlDxHCdVJk/98SXBhnR
 nR1gKkjvkm4mKH4/wa6Y7ajiS4MHuAWA7BJ8EVSUI5vFWaZfRhzPpLOPfrT4dAeNQwIq
 +tZr3am3rD11X+O+8Iz8OcYX7xMVMHRT9dy5G4/+hHElYg/ZAvzyn1rAPjZFvRWLlEbr
 0+CHGfBwj5puGbNRp8Apup7/alf3hWb/fhB+s+OaGAPX2d1BReBMQYyFrge4dcoVdDQE
 smjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9KPXR0AEaAqya5xByjFS5i8mI0C+i5uyfb9X8jar8a2CnOsEjHDmpDCqw6HtCPCqo7NHqsJ3PmM9P@nongnu.org
X-Gm-Message-State: AOJu0YyWDVV8inYraPKdetZ2ydX92BXmUr3t2RYrjKCnw9N8c4PBxHbF
 u7j2tyTai+b+KOBdbR1V/ICgs6nAgJozK8zRhN06QCx4FsnvipeO8QaHe9XJ0po=
X-Gm-Gg: ASbGncsKo8gb05KMw1OyP1xLgPNiUvB7MIDMxrL4/2o2op7KXLsNDJ0F2Wl4AxXzb1M
 rX7DARX/0vBgycZw5muT+91grvnjbch69cMLa8HZobLBE4HGYH0ZSNSSAsxQQ1IRJ4sN2ftby2f
 YxnR9YZnX7WnnZy8ObYfPPZELJOoH60MJKydFoqgjWH43jgxuf4XkvZwVM/TP3fLyYyKo6Gy9/i
 T9VYJwaV924um+lyE3iowXefYBUnU6zdS6BNnU/gqOdczkH/UsO467hx1FWmckXccaY6V+qHyMe
 aLwhKlppZ0T9bS/QHsUUIlipXNQmzw==
X-Google-Smtp-Source: AGHT+IGSZhTePV4frEYO1sOMIllpZDOC701TdwDNgsnCO9YT1RgmayEITGP62dmGFZZigqPaYl12rA==
X-Received: by 2002:a17:903:244a:b0:21f:4c8b:c4da with SMTP id
 d9443c01a7336-2210460bcd2mr138528165ad.18.1739779438657; 
 Mon, 17 Feb 2025 00:03:58 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491a6sm65714215ad.20.2025.02.17.00.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:03:58 -0800 (PST)
Message-ID: <b284a79d-b555-452d-9c54-5b5fe5117f45@linaro.org>
Date: Mon, 17 Feb 2025 09:03:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 070/162] tcg: Merge INDEX_op_mulu2_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-71-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-71-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x629.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 17 +++++++++--------
>   tcg/tcg-op.c             | 10 +++++-----
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                |  6 ++----
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  3 +--
>   7 files changed, 22 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


