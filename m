Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E28C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdByZ-0000T6-Hj; Wed, 29 Jan 2025 12:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdByX-0000QK-8i
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:35:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdByV-0002YW-Q4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:35:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso49503865e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172138; x=1738776938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gJs9T0ZtQ0+YnliRy9rXebazKhT7OCo6IO84HjD9uyw=;
 b=TzDsx0nyKeSmY6tf91UwANm02lXbl1YrQWuLZfwxX7NqB6wYiRA23cBsHnDvaW96GW
 7y2+7kXZBjcn3l5mMIhKrL0JyqPDWY0rn41PcNCU3MxQSo971NNGyW6IoSXxVvfOc64S
 a+e/MVzoIXhhkIyMsLcqwH4ogbYhbo9TIyXZ0W9MCEhC0A9fWRWQvEyWYzvNcG+jHf2O
 0bFtUYshlUd78eG3PO8yclY6b0R/70ROA+/MiC10DPQ3IdCzqhUn2J3GUmgX9v30L+TO
 oiw7/480dYOsiagH9hx+AZPvxV5RRnUaNSIr4ilm+dNq2iek+qah4KvtbcGPUqdcUciE
 2TRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172138; x=1738776938;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJs9T0ZtQ0+YnliRy9rXebazKhT7OCo6IO84HjD9uyw=;
 b=BbUP91XGl7RpKQ3fyzLkhOwmfl1PLzJHId91WRb/f/JKUqT8fDyUJcGFvT+XG1BFKd
 17BkBw/3pJwwv5gvIjk79N2UdJObK9X2Wy5LS656qM1GOkaqBJtlYosbiz+L509Pyfe1
 9KZH1NE+cU4ip5ur8/weUNF+loFcuKv6fY9xL6JtMN/CWxHqhNxPFlLkGF3dP3tfD428
 qtMNnN0CnXwc3ZbC18DoOcPB95f14FXG+4cKonvhlQ9gF6r/NIU3RiAMO+WHs+yDw8xs
 8IfWknBHhjnaSRhi2tR+46i3A4UY5KNnV2LSn3edfOPwnDQLt6a2LwRTBc/eKuqAnkHF
 65jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB8aZqkxU97Jzq7cBYVOczfq0NtKcS1bEqMzH+cgRpsO/sF+FhAVcWTkbMVYmtc7ET/bknvhU49LlA@nongnu.org
X-Gm-Message-State: AOJu0YyG63y+AdVMHX4KsttXKYNDMKTU+r7SyoHdoS1Sp5QoxhtnEOU1
 WuJTswEgAnMXM+VNnxFppPqKMUIQVe9ilgLYNr7dlhYliuSRw+DHQ4IXFgxqvgT6vtKkKeoHhO7
 ATrE=
X-Gm-Gg: ASbGncvLf577w99SWSluQgDps15+olcvobEmA0iH18SBbZCYOCCnRqFMgEQIGU4XZ9h
 0axYve7NtGxUlgNkBYB4Rqy/aEutGwvtlSkqHQDEEYLsIHw5c/xTnGTJHDvvWMQRhzMnO3M/U5Z
 3gsG7TCMcjBifF0aGEFvytFby+ahDyTyCJedl0LDjNT2gX5eVkgGkFpNpHWNnRjN1zL+1GRyGvd
 H+DSReMJmmEGeEPjOolH6ugccaGWh/cdyU3hZhB/4THbCfWhd51806OvjsvH2zbv7Nz5UMszoeK
 GIs0SqfcU+Q6pM4MRLIxRkefRWlXnbaRD56AI/HmzRyk5k86b3EJPnUMKiM=
X-Google-Smtp-Source: AGHT+IGGsG/2PQ1LKzObujSgQJzyhW0g9Uecq+M1UWqy1eqFMx3xcTMauZIJmjBidQW9FonD6NP++A==
X-Received: by 2002:a05:600c:468e:b0:436:fb02:e68 with SMTP id
 5b1f17b1804b1-438dc3a81ecmr37672255e9.2.1738172138228; 
 Wed, 29 Jan 2025 09:35:38 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc27125sm29356725e9.15.2025.01.29.09.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:35:37 -0800 (PST)
Message-ID: <5f1a242e-f0f1-4e4d-a8b4-e097ffb990b9@linaro.org>
Date: Wed, 29 Jan 2025 18:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/34] target/arm: Remove standard_fp_status_f16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_STD_F16].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h            |  1 -
>   target/arm/cpu.c            |  4 ++--
>   target/arm/tcg/mve_helper.c | 24 ++++++++++++------------
>   target/arm/vfp_helper.c     |  8 ++++----
>   4 files changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


