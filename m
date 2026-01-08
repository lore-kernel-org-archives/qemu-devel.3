Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E2DD185D6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnns-0008Sc-61; Thu, 08 Jan 2026 06:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnnn-0008Dn-2h
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:03:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnnk-0000xM-Kd
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:03:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so22005925e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870215; x=1768475015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSiQ9yHOPbbyjJ19q2uL3Bh87+NQFRoO6wjef8IbFq8=;
 b=PydBcebIqGwX2skfYrwJl1ZE+62Zv2VfI/EfN9vD7m3Q69s5siBCj4w43xJ2Qbth7I
 br5ZZI4FV7d/QN0CkeNVLCmDilwBy4oWs1H2xGC2q149a9lFv2wQaYW3lLHFuBvYh0t0
 +V+dmKk+xZmyF9Ylb9tB57ovmd4yeaVkP3TsQ7kjwsYaZI09SUTZGicoNvXJExk3k4oi
 eOehDw+ML9Raj9vQ/S60wZkra9Bj53sKZFN3bbm3Pcl35nsBJKb886kgXuWQsZDqdJac
 1TN8FNdYisDh8+eiWD4T2ScjAswJ5sG6eTEAhKACingCbei/pu1POM46g3wrQL1ujUSU
 G0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870215; x=1768475015;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xSiQ9yHOPbbyjJ19q2uL3Bh87+NQFRoO6wjef8IbFq8=;
 b=eA/pXvohPj4wxOOQ7jGTNHiQSKNXZw97MIpb8oKlnZqFPOOTgzUKbq71bygtYVYOZv
 L45jiWIuU4Vw9cTA8zlAm/ms8zsdJDzK2mr6ci6Ui93i/er+QZ2MOzShEie0JAAbIh2D
 3KEpSXLxDGCzLfTwcq3OgDP1ZzFhO7NTUGnFWKc2VUUv8I/KpTJY38r1pxkBX17VNjw8
 fHDgbqwLDBd72TTalzrWmQ/l/fnCKSIciqHsanS7CPWVzoWnKIGs8wqSjqRbsiP5DVSk
 VLRAAQdZuwd6r0snMRqrf8hQCIpz6CM9uy30WyEDX+Eaj23evAnRIwY7hBjC+aNUFvNl
 Ovow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVobAhjXXezHVdAfFcVr8t1yZdT3xFM/f2F5cASGA7T2OJlX+teVuxt6KkQpe6BSyd8GFkb3+o0bc05@nongnu.org
X-Gm-Message-State: AOJu0YwS2A9wgDXi6Hzl6jlDM2KSRBoFfJKrkDzoeSTE4yGR5UtVxB71
 87J+kvCpKokAIGJWo65Jzr+ml6iFI0udmJSpWObl9IJZB9mhfOtILXhn+CqBayS2ELY=
X-Gm-Gg: AY/fxX42icbQbJSAFYv62TT6OQtafs7Lilaicyq1BAbGuBdYaNVgQGZIyUMmWrVDdZR
 Dk4myCmmBTLaxUNYoYKxVTl2Ms7X6BVOw4v7FlfblXs7NCS/ZSS2sndvJxVcdLKs0wMu5+FhBDo
 HQAYOS7yAzZq+0FCV1nFflQOwW8Z2Vge0fv3sLhq6Ebd6+Ll2E3/WLxPXmgsWmKUH+hhiSV1P71
 C1rzla4HpDJUYeNj1AwgGbf32JxSoaM2nkJGBJQr9cDmjQLm3pE6AobbIr7VNYisVu41gIzEgKK
 qobW7hRxNEWSchce0+UDsP50oA/dJyRXb9uVTl4pMwchEqIc5qzkbIyuH5pZR7jvSqti0I/KODb
 Ri/KI+FKLiUqtj2qAa0qpCQAct1mkzAnbHq/atTDyuVwlxJdOdaGIu7sjv01nFzfazKIAJpJDS3
 8LIih0RxKHyNi3GMrKx/KNmKX29+KI45xbQnvtdOGUilIJj5LEdqf25Q==
X-Google-Smtp-Source: AGHT+IHxpn1XOzKrJq3U0G+IDe5jAyVF6W0TZD+Vgx57KpSD/Ogzn1ClSslD1YmrG5YPVBJwVlZJTw==
X-Received: by 2002:a05:600c:3556:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47d84b0a23cmr68951865e9.3.1767870214942; 
 Thu, 08 Jan 2026 03:03:34 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm15803165f8f.35.2026.01.08.03.03.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:03:34 -0800 (PST)
Message-ID: <cdbf9671-3def-4921-a0c1-f0b1fcff65c7@linaro.org>
Date: Thu, 8 Jan 2026 12:03:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/50] tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260108053018.626690-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/1/26 06:29, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


