Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D7DC3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBryS-0005HE-BP; Mon, 05 May 2025 05:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBryQ-0005Gy-W7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:18:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBryO-0008Tx-9F
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:18:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so26412225e9.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746436729; x=1747041529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1nmhLuQ8lgrbqA1dZmAZjtop7KjR2iFv+3I0rdib2c=;
 b=f97dpo0J0jj2NqBZ4GyYppywKpFxLMOCfxKHLam/ZFBvdcbpfXb/N6rp58R0rmtZ0D
 n978lIM0lWAUKIUv9//f0e2vcJKuNUb9IlJip66m82HVS87z3akX5wvqqvTbSbN80++o
 +ua69V9j/2ItBaOdvSx5zM512h+bRbpZsqRGS04kDEvLANzYKPbh3hY5esTBSdfl2QNg
 4fAzKNYLSPpV6EuzYdIzw6+7ZYfAFWVaflP8ER6P/tYgvNdqMf+ddrmeiI/ylRZFd2p7
 BLoTLkkMffF2G5kXIzwHOVvLCPlNioygmEnh8icaK7nbuhP4OF2xXYWuGiAHtd9reZk4
 M9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746436729; x=1747041529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1nmhLuQ8lgrbqA1dZmAZjtop7KjR2iFv+3I0rdib2c=;
 b=uEt9qQ8oEP3qaZTMci4L+az8kGG7MzLH+KbIK3xi8ZqgWYFNc3DoBGm78pOwJoxdzn
 iVjP/9ylZ9IUkHPYKGou0YEJ4YPb5g3Q6xfNPV0LNaIOoAnZUVOs8Mf5alsM7z7qhBCV
 GumKZAIG74qOYGdQu4WlZ0vc2nN0GPJWOX+x+HOx67CQ2sRUuSrRmtqxWBZikrEz1JFd
 dAhA8gKijI6XU3PEDFc2SfvMXXtK/3f2hsosUUNL4ZUbWuhPN9riKSHEldUWLVZP3hVZ
 WI6zi7BsDq6ZvGyojA3Ybtq566zmGSLonu/NnKUbXwLTv7irFkAPeE1hIFwA/vUDazpu
 /KhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfYP3V8nlRfnTv0SDwf/v42FHqhw9Zogtz+u83eU2EWMoS6RqfD2yGvjS8JHfxg+BzymN1/xfGfafy@nongnu.org
X-Gm-Message-State: AOJu0YytfHdNepXzQFvM4W9aEyCCq185y+cllZWdQpul75/A8OaW1rW4
 IfKVFl0JFGtGg46WIoEYTUNDTK6WhmT2phXwJ34NVWRgywuvTu3wE3SsONiZ74QJYPXz4LZgIyr
 e
X-Gm-Gg: ASbGncuU5+G4+7dH4Kx83uCxai76g28MTJ3/ojTawLetIFNbWO32MY0WWsexjfk/z/y
 u2PsYcD5rUijPSyLtYDb40/RR4lISpeBWO9vl1MTA4/Yb8tDhLBC6z+XlZvEYqHTJO81t2eFqVh
 pxNW7dVb7g979a1qLI0U9DC8jSksXJdewu3XrGTW46EGenj+taaA8iUkFtTIA7R8RMZ37TvweYy
 ZhCOZSOi5YN3Drcj53/huX562gJ6Nr2Y6FzA7/r/v6wDIN9DUrzLWDumHC8rp9fFOMtepAHrum6
 tUzo1SqSSpj/PWAs5NB+LtPt2mu/ZDbt+hLAxjtFHuh8zfwyx4q5xEzVe/Tk17hdjdk3lGLBn8T
 tR3r+S6Fco7cq2CSoxTJtGCo=
X-Google-Smtp-Source: AGHT+IE5cB+lXVNR6kl0fXmxqLXPygeXuoNfOaNDyLtGV0iGK03zTTQ8e+3MWnDYcMsBMuie9CqFJQ==
X-Received: by 2002:a05:600c:512a:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-441c492381emr48345955e9.26.1746436729199; 
 Mon, 05 May 2025 02:18:49 -0700 (PDT)
Received: from [10.194.152.213] (29.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.29]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0ca4sm9949444f8f.14.2025.05.05.02.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:18:48 -0700 (PDT)
Message-ID: <9375396a-66a4-4744-9b7b-2976016846f3@linaro.org>
Date: Mon, 5 May 2025 08:45:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: Use MO_ALIGN for system UNALIGN()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
References: <20250503212708.3235806-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250503212708.3235806-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 3/5/25 23:27, Richard Henderson wrote:
> This should have been done before removing TARGET_ALIGNED_ONLY,
> as we did for hppa and alpha.
> 
> Fixes: 8244189419f9 ("target/sh4: Remove TARGET_ALIGNED_ONLY")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


