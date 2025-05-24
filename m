Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C288C54FC6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 13:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIoe3-0007HK-5z; Sat, 24 May 2025 09:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoe1-0007HB-So
 for qemu-devel@nongnu.org; Sat, 24 May 2025 09:10:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIoe0-0006c7-AL
 for qemu-devel@nongnu.org; Sat, 24 May 2025 09:10:33 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-44b1ff82597so5800005e9.3
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748092230; x=1748697030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K3JLK9pZmogTjVHVYQLPlR6FT90z3gKv0ZAIHmISogY=;
 b=Kf1U57wEmBO9jbhIVrALGhJs6gKz09sIpnN7AUsVKr/y4fqhW91aG2Y9N0eurd9qYu
 A1sioNVjg7A+x8x/nYUj3GWRL1XwRNw8afDWmh9C6V2saPXXfw7UVgJrcXb/TbCd0CUH
 RSuhDCb4bz6Wr5PNZ8Tw2Hjtu0xVD4ikzDdND3xA4Geq8UJbet5ShqUj28khnfHNPwNF
 Bri+/xH6Cim34hlRgZoG7khos61JbrRSMh8kzyrTk0ZX3fKphaeVvvfk+QJJztH5q2l6
 QRxLxIHISSzXcerEsU6ZdJP3XiKHW4fjZL+VUCy2HXFJ1ewIyFR4/WpvewrVyZymKL7W
 +l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748092230; x=1748697030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3JLK9pZmogTjVHVYQLPlR6FT90z3gKv0ZAIHmISogY=;
 b=uz7a6dbUOdxUAnokl+3Swlm7Szf1j+d8VW/XRe7N2PbEpLSXQYov7G+m3XUYWQKT3y
 ALln6zojSho/OkgyQOeMoO/ay7DJZH/8tfZe9orjbvejPgcAut5SEFgCwNrmi1jRCzHA
 p4983YCPuU2sw84OZkD1Yt2ASCrY3Z4s9WdjiaBga3qUPrONGsiEU7qXOX9LZ6bQg2Iv
 gT2aCeEVvYaoYCnFWsJ+bo2Ilxq68L4Sh56x72TbmQ4TPach2aH48OTkVkzoW/Tcc8WO
 5x9A1vT53Cp80SDE9iKUOv0GzdCj5DMHgcRkf7KMrkSBhMXDFURPm6fupn/tXhYy6Ytf
 xyTQ==
X-Gm-Message-State: AOJu0Yz4fdncAf68qTK02As9+amYuwuVbgUs4MayjP2vusorD8jLZQwi
 0mUtYsIxcR6NBOO94+BUuHB5CV4Z2Eb292J71Hjy9OhctR1wAyJh+OOLV9jY5sM1x2I=
X-Gm-Gg: ASbGncuh7KJbizNh9g1qLYDMEM832Z84+RyaIyY3Eeaz/3WXyyBhdtRLnKsrfan8K4D
 iydVKCNlZV3QeDNJkQbfA1N5BhVIVQUyIH1cbgtMkXsh8ux8OMmx5Kpf5FFUJhtIWHlnGPrl7Pi
 YFnlGEaQzTG6tFqGC6xntnmMXGfE3We3hFgsmKY+dL4xxV6txk0/6/EYELOwlzVJHqmRHJsKwwh
 N2qAsFIC4yw4L5+IUfhezQ4u5oOFfU7t4Q1Z+nS2/+HXZuRrHzF4OshHdimB2twwKAKdlexYi2v
 OPz4Hn7uNNTaqZV3aR43hm0+AcXJtdh1ZHtcqYeq62J8N1l5hweW7PKncuJngRehLw==
X-Google-Smtp-Source: AGHT+IF0PHHPrrD9sq64hK2QwW+XiNCTHVkKOLdytI4DnqKoNWzfodqPAp7yQD9ibLmgOCKbLU+PMg==
X-Received: by 2002:a05:600c:83cd:b0:440:66a4:8d1a with SMTP id
 5b1f17b1804b1-44c917f3f54mr20476455e9.7.1748092229890; 
 Sat, 24 May 2025 06:10:29 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142b8sm174439155e9.30.2025.05.24.06.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 06:10:29 -0700 (PDT)
Message-ID: <f51ba01f-2886-4e73-8c89-396a6b21b18c@linaro.org>
Date: Sat, 24 May 2025 14:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/perf: Placate clang-21's
 -Wdefault-const-init-field-unsafe
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250519214903.55284-1-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250519214903.55284-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 5/19/25 22:48, Ilya Leoshkevich wrote:
> diff --git a/tcg/perf.c b/tcg/perf.c
> index 4e8d2c1bee7..f30c5b489d1 100644
> --- a/tcg/perf.c
> +++ b/tcg/perf.c
> @@ -154,7 +154,7 @@ struct debug_entry {
>       uint64_t addr;
>       int lineno;
>       int discrim;
> -    const char name[];
> +    char name[];
>   };
>   
>   struct jr_code_debug_info {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

