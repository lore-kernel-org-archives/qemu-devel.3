Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F0EC01A9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 09:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4bVz-0004sX-40; Mon, 23 Mar 2026 05:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bVx-0004sL-6p
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:24:01 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4bVv-0006Yw-KL
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 05:24:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43b467dcf0bso2913104f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774257836; x=1774862636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6jF7tWb1iPp0byNesh17yAGa7yqIFeQZUfNM1OxExA=;
 b=xKGmIOJ02C7Vh4fuUPZ8w9km8w0V04eybAsX61hQYk9tP9DBYzuW87iphws7u3UgA+
 Q6LM2pzVWqP5hrE6W565/WMhV7T6AHnU02JTbo3MBm/CrlIz9B0XlbfHPPUno1wYDSVZ
 f461HBpJm8V7okmayuSKVGjX6XzmENqb1/uWf8md0jvz+jLCTF2DsTdZ4fn9LvySJBr1
 cnFwNcVI+KhrgHZ9R5gX8ZX0z8sPBYinv4Se7FkydvCR13ZayLqlS4dYIzLFlLAf57PZ
 o743oQLTHeklf6ABTvhuiKwm1ySBJ/DW1h1Q2JNUNgZNkQjAopanv9L64nQlwcl1KFE6
 //Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774257836; x=1774862636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6jF7tWb1iPp0byNesh17yAGa7yqIFeQZUfNM1OxExA=;
 b=bH+sXGOjYoH0WfCEqDN2ESJuLOoW7T9O0xfLHfAMbiA0IcXxz5ZibIgmoDiflTiOb7
 ZG58UA9KTBbZUpcGFkJtasr9lH41sY5OC2uZ3CeHjvw/l2uv4ezPOqlWTfQR2dAHK75N
 VXFmTXpmmcD5Xfm5wtYfaIrNTf9FcEMXSa+EXdUkm9RH9oV5fAsGM+sRd6emjPJ2yDBF
 PxcdfBZdzxCGK2Pvy1y8NGne6OFt0tdvOaNKTxJgi0ptdbtfTutrWQ6bKoiOSNtZkitS
 WyniBU8mZL899bASTj73LDvfvOfFYmV2urYsrerQ6atmuUy4/pDo1dFWpHslDDo+ZfhK
 ppqw==
X-Gm-Message-State: AOJu0YwJdSLgVQ5LHy6bfXnHnooYLv4JRdAVPATENYkkZg8GC8UHGJaS
 PMWduqCCE6pwKDjHJxSD9ohvz0h8RBrfu4tcoHPAo+8bVC3J5xoItr9/bsObC9C3HpK0rQyu7SZ
 1RVnt8w3+qA==
X-Gm-Gg: ATEYQzxuwQRpEqb034y2onR6WfGWgIgUx9BHjvTGnvUcYLQJ7bW1N8buzXMnd2M8izI
 8fujwI6Em5kmrF+d5LCjEIvOuYGQ0XbtDQlOhvfBojs2LI1d8tBEWvwOCwx1odt4kZ0tGJSGdkr
 WkLNxci6gadZAN6UPi1PvKTBaQBLYBMDA2PKhisB1oLG2EXW+KolXfPABn87FyuGpZEu+/uGvDf
 5mN8wh288CZgKPYEd7cVmOM40seHY/T59IxHM/R9pdcyRUbbzzu/pwdcOHVKawOUpm0cS+yfBvm
 oRiKAQLtHa+RbyIKh/0cYE7wWJTSQW6JOVq8mdRxPg7nvHtDDooYw437C9DSVXqhInxUpFFZrbT
 fYDHeVk3MjBvicY8Bxy4SzAjIv0F5KyMFf2dZHYqGgvwzI/82AH7/aF3jPh1sBfaMm0phr9+Kl7
 irK8N/8LuaCVqBQ5qDJLcdwocE/ORtqYXDkslkUYxxfntrWNke76MeKEYJn6KhcYmb5w==
X-Received: by 2002:a05:6000:701:b0:43b:4951:6b37 with SMTP id
 ffacd0b85a97d-43b577233cbmr25009414f8f.15.1774257836538; 
 Mon, 23 Mar 2026 02:23:56 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6cdfdfa9sm18867872f8f.9.2026.03.23.02.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 02:23:55 -0700 (PDT)
Message-ID: <533c5094-6c62-4406-a894-07d1834efd66@linaro.org>
Date: Mon, 23 Mar 2026 10:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: preserve PYTHONPATH entries
Content-Language: en-US
To: Alyssa Ross <hi@alyssa.is>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260323084739.1013748-1-hi@alyssa.is>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260323084739.1013748-1-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/3/26 09:47, Alyssa Ross wrote:
> Otherwise, it's not possible to use a packaged qemu.qmp.
> 
> Fixes: 1497377857 ("tests/functional: Prepare the meson build system for the functional tests")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
>   tests/functional/meson.build | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

