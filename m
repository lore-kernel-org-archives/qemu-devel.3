Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77310C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 21:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcWl1-0003q4-TY; Mon, 27 Jan 2025 16:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWkx-0003pe-PH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:34:55 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcWkw-0004Ot-6s
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 16:34:55 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2166651f752so100526735ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 13:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738013692; x=1738618492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r7gsIIcQvUJ0JH2mAc1rpcS3+SsghCgsaj/oUrn8DsI=;
 b=b/z/5pNEYhYKyR904v5qtOGv5LM+UUdNMoaZsEcu+PqHVhDXvL8suCI2ocqJoChs+q
 vWb0DUrQeUiC9kgnX2Ps4dOtS+2vV35NZM33S0xO3lhXloYKgxFnWZneRmHN0idUF12V
 ChzkNna5c5BIB3HtQnQyYpftrlu27x4F8jwxQZTi0e8cJ2bzezEeIJPpNV2KVbxFgN3C
 vMkXEKfYYDKEyLv2A2LdUvo1HWMmslzlsWMT8Y8/1tTxBbNf0n0Vly3WNfMBjmV9coQH
 sWXbcb9Newd75k7QRKgE4B7lrbzqkBzydxvCz0U3/CZLRr7VNjZXpeDBWFovFujFYreL
 TNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738013692; x=1738618492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r7gsIIcQvUJ0JH2mAc1rpcS3+SsghCgsaj/oUrn8DsI=;
 b=qHBGWIEXlTql279OW/WS7z7C8kMv9gdjphYNT7R2bCxJPldiVKZvI5BmVeLotTzQoy
 JTbEp7sYbiKTsB2C/xAGFLYYoiNmOLbW+JheboDRbpa/ZanRU/XaW9v4vhBTgRU1MSdu
 T+6ymUWyuZG1S1bjO7lV7iefIEqzVaG28UCwk5JDTj85s7FcMBdeKImGDEgVflloDUwx
 8SwzlQuxPUSj+A623bgtH5PFvW43huVBasPG/qxzQ7h9I1xgrC+e0Lfs/eGf5hPQ7mMF
 KZpitry0yXj5hiCekgQDDEH5+3TvvOs2lFFQAAAgs5QZgT/Rz8oence+FFDqB8S/A1Ej
 DMWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjJkw0AzRkBXXTxqErbD3RNStD1uGmgP9rUfa465SWXeqLA4SmiRAUCHu1mxO3GsGN6TMG2fauVtXy@nongnu.org
X-Gm-Message-State: AOJu0YzzlgczbhrSLB7oVrtSQ1Ly2bBkwBlUtwdFGXhJbu0Lby91DhNn
 cNRg0l8fgE5W50ambdyC3CDGC5Gg5guOOH5BrQWMXn7E1c2gII9jAlSPO9KxnqE=
X-Gm-Gg: ASbGncvU8gfu/+qGBsUVrkOroi8J9Ah5oytOYzI5DK7gMnKRWMdob3QIsXrkIdRCbA9
 Pa5DsOFkJhYncXz6EBfr1zrBl3e3bv+pD523iIGyadmG4S+tyu81MDChJLORqTNjoQM6FL5zJJo
 OAxnjoSzktb5tlM9QFuGSrojteILYjeEJUgj3sj71Qvdejfs+V+cDg+nh4+iNmJiTjcMSPZoN+M
 ZxdUsSSffcEaCuDpgRoQuxJbo1cHwBa/0Iu+MRBRD7O8smTMFaeWqlSEU9a1Hzge0JLc+O33yh9
 J/Xy/5rDLW+9SCo4jNL79MLb2oC/gL6BUOjPSuTJe2oUPeQ=
X-Google-Smtp-Source: AGHT+IFzB9K8UbPAWbfGtU2Z6kIZtJm2FU/x805Oyll7oDMqM3Cc3+11FCkGdapSjgqAWgO/4+1VzA==
X-Received: by 2002:a05:6a20:12d6:b0:1e5:dace:693f with SMTP id
 adf61e73a8af0-1eb2144d3f1mr64665975637.4.1738013692166; 
 Mon, 27 Jan 2025 13:34:52 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac495d57960sm7049522a12.50.2025.01.27.13.34.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 13:34:51 -0800 (PST)
Message-ID: <3a24e07f-3da2-4798-942d-65d2ec398db6@linaro.org>
Date: Mon, 27 Jan 2025 13:34:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/loader: Pass ELFDATA endian order argument to
 load_elf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
 <20250127113824.50177-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250127113824.50177-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/27/25 03:38, Philippe Mathieu-Daudé wrote:
> Rather than passing a boolean 'is_big_endian' argument,
> directly pass the ELFDATA, which can be unspecified using
> the ELFDATANONE value.
> 
> Update the call sites:
>    0                 -> ELFDATA2LSB
>    1                 -> ELFDATA2MSB
>    TARGET_BIG_ENDIAN -> TARGET_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Sorry, couldn't find good ways to split this patch...
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

