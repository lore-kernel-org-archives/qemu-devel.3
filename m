Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C402C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIS-0007VV-Vs; Thu, 28 Aug 2025 13:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urdNo-000716-GH
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:13:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urdNl-0004cD-39
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:13:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3c79f0a604aso623551f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390415; x=1756995215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QTWnd5slutuE8xh2bP16X1xquxXLhAzwTf/UcVfg3hY=;
 b=gJ1FU7V7s/GXFLFWvO0IgCdyrtZef19R91A43LBYTMx3fMkuMTPPxF/0u91k2fDh1j
 dqVIwmbGU9M/2Kzgq1lY1ZpfXLh1GEkPzfmdqhjU0shrdD4YqLqQ0SGilDFKBjPxrdQP
 7C9gYDRIcoFo1dOHWyhNp7FTpK/1JxqS5sDpS4+xoq9F1EeMIHGzFHF0muCap1fpAhFO
 HgNFBSzXQv8sSECsu6aVFo/xYPrvaRbj0EOXdDr90o6ADneAjb0YCqVByJSZH7KqyAsA
 x9LeRyRTuxVMBvrtXalROPrl7VCOw8qt5UdNc8EofVZFrwpH+QPa/ivu8WJvRkwkiV4q
 Qb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390415; x=1756995215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QTWnd5slutuE8xh2bP16X1xquxXLhAzwTf/UcVfg3hY=;
 b=GXYtXATX0bYDno7ig3Bh/XdUZSNDSYj++fZ3a+y2s4OIBn/KDJ29YSpdu+GVSBLFxC
 4GiLoCkWhJA88fbU5Po5XEjPSaISY3UZW/ykI/a7SSpHQpbLwDS5RxP7BrCGqCM2xzxF
 1iIxVV3gnnba7nfrQJ+q0XnVJtZxklJ7npY+9PnuzhJUT+58zLjA4dZNgC+apBDlz1Zh
 9QQjNxDjGxBBvM8EhCuIcUAREb9hFTiSCdAK3HKK0HT59pNpnt7aOizbVgWOARfE0Wcd
 6NMKRIZLKN+V+1slfdPZ+EdhL/AGn0lLwHxrd8tRqDB63r4kQjPW1O6k7BqGYL2YkMpt
 qh9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYHwGtQ6aWfamc6tk3Yp0tHyGkSHhvvL1SEVFGZZv4PzrfiNhHCedF6U+jBlY5LOrG1eK/FKiRxkeU@nongnu.org
X-Gm-Message-State: AOJu0Yx13lJ2S4jgCKHOHyPPC+TqAqa0v18nQ7gv19LaGxrY0gaGX2Oz
 i/cbtsAl7sm4U7s1muEmsSLTWKdqToeR3r89AxTmmPEBWhDhqqDFBeSmFBcvOljkca/a4kJKHSf
 nlm87kVw=
X-Gm-Gg: ASbGnct3uaAYhbAvnM97kLoC3hJds1fVqPcz0akWQa9cncpih2Pgy/5xGqCgE3RHQQk
 FMCdBXO3sAmkbkJeN7hBQt8PmiJK6TllE8Ukhxzjb8vBxWXkSDOt6gSyp6fxHeL0Holvx3wLq0w
 /ZIz5KoUvckfz+dg38Ap1wMj/pmR+5kv8vnbXVh93vm5KwwtR2qp4R1x3p3IRxOtQnhF/WXG4J6
 jsez+858fy3oXkabzXkqgc9z01fejjtKJYqPlSiqzjE+S0KZV9VrZXQfpTQkLcekzHL28yRjVf0
 exltEnfZd2lK/PIcEX1nj9jIigPxe82qRndwvz2B8pBUVXwRZramPLUSjQ4BKX5mGAVDL5y095p
 UZCxRH1N4aTbKJLGsaDVcg8h4BjCHqww6r9kPEkgdpJ398Ou+JlaEvnVtPnrEj/s8JBWSMgBkzz
 d7
X-Google-Smtp-Source: AGHT+IHQYJP+D8iM3ZJGp2oUQgAhz/CMtS9x/84s8UUaPIDlMk4CkKvswdNxgZF6MYue3X4gGy8Qhw==
X-Received: by 2002:a05:6000:288e:b0:3ca:3b3f:ecb8 with SMTP id
 ffacd0b85a97d-3ca3b3ff1d0mr9403752f8f.41.1756390414774; 
 Thu, 28 Aug 2025 07:13:34 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797d18bfsm37492595e9.11.2025.08.28.07.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 07:13:34 -0700 (PDT)
Message-ID: <7c2833b4-379b-4d95-a795-c4ae8936dbaf@linaro.org>
Date: Thu, 28 Aug 2025 16:13:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Tidy print_socket_protocol
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250827213820.37624-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250827213820.37624-1-richard.henderson@linaro.org>
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

On 27/8/25 23:38, Richard Henderson wrote:
> Sink all of the qemu_log calls to the end, collecting only
> a string for the name, if identified.  Merge separate if
> blocks into one switch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/strace.c | 102 ++++++++++++++++++++++----------------------
>   1 file changed, 52 insertions(+), 50 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


