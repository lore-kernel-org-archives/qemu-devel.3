Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D010ECE7B09
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smYpJ-0002bR-8D; Fri, 06 Sep 2024 09:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYpC-0002Hn-O4
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:16:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smYpB-00078U-3o
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:16:30 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so166945266b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725628586; x=1726233386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J25UgehM51d/UasgMPRP3FkQ9Ibu/lVyewG7HJ6x1jY=;
 b=uSU4RzLrBTSm30wqIJRBLAXTr8r6wcAUwB4fWi4xqEzj+PR/ry446JhVAV3FJSpj21
 yP9neX1DiZlpISDznVv452XVWN2WgIhgHqA+T4CXGEHA37d0oaZcnDchrjQ2gdD8Bf2n
 YOQlxBSFt+u1PRymTZ2EQBuuFp/94DZtqT0VFSK9y67d/VrUcckdWaoxj0Q5B2ItCKjc
 qSS+ECgEC06N8I7NxNQoLXiCmpEGyOHjCXomo0sOjSgZS+kc/yvk0/IQaMD9vv6/FMpU
 h5llcldiSdKlppypIl7SUbO+ozmkmqIVfxrsRYyu3JDrQwbjSOsdib2swGs0GpGeslau
 4fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725628586; x=1726233386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J25UgehM51d/UasgMPRP3FkQ9Ibu/lVyewG7HJ6x1jY=;
 b=J0WqUMgpWEMNH0vDJ3INWjgqRWgugJJoRkXs6fiRypMl0s9Xrk6zEBZY18nDR3RyLW
 M2EFeSqSwixY9/QPH7b9Tgnw8L3gFXr5x9KVzMVzrRGRy6QA8clb03BgTUwTExPXmuq9
 YWHslaX4vdZx/l1TF2IKyF3WVychMVT8WDe2aVqWz/EOKt23lRr8BvdBi3fU8Cv/yh5G
 LDWs+lfWN+3Of1sWh4ZJHPyJ46PgWIlNMRZR1pjc/wOchR/aFdy/cxCow4+lALDqdwIK
 8mjUw7cruRDngJ6idBf6o3XQIll5oRNAJthtbAqTSxwD/VH6JXo01iCEu3qFewC2WeGb
 t0Ow==
X-Gm-Message-State: AOJu0YxTeX26rYKuz9zCClTJhyfRc9GpMFT+gUmuqHEjqhhuWmZp0HrZ
 7Ds1nj2iLIV9K9KdAOGyi1jVtUkC3RqyM2jRJWPd1R/EaSaEeXolA3n23Ma6/Cx+5He2fAtIfIe
 N
X-Google-Smtp-Source: AGHT+IEIF6aMVmjK7JoXKfRy8vY8knOixO2F8TGFOpuKGXFPn3JH9Eb9IrqaYTfw5vsvfZ3xqi9ezg==
X-Received: by 2002:a17:907:31c8:b0:a86:f960:411d with SMTP id
 a640c23a62f3a-a8a885bfbd6mr224987466b.2.1725628586442; 
 Fri, 06 Sep 2024 06:16:26 -0700 (PDT)
Received: from [192.168.55.118] ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a623a9aa6sm277459566b.149.2024.09.06.06.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 06:16:26 -0700 (PDT)
Message-ID: <71acbddd-0483-45b7-a9e3-4fc52ecc3006@linaro.org>
Date: Fri, 6 Sep 2024 15:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/unit: Comment FIFO8 tests
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>
References: <20240906131217.78159-1-philmd@linaro.org>
 <20240906131217.78159-4-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906131217.78159-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 6/9/24 15:12, Philippe Mathieu-Daudé wrote:
> Add comments describing how the FIFO evolves during each test.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/unit/test-fifo.c | 190 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 188 insertions(+), 2 deletions(-)


> @@ -65,23 +100,50 @@ static void test_fifo8_peek_bufptr_wrap(void)
>   {
>       Fifo8 fifo;
>       uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
> -    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
> +    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };

Oops, this hunk is part of patch 1. Will squash locally.


