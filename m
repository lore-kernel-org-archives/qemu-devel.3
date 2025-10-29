Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBADCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE15y-0001lK-2o; Wed, 29 Oct 2025 03:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE15g-0001j9-Qr
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:59:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE15b-0002ra-SP
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:59:32 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3c2db014easo323473266b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761724764; x=1762329564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rtrcuGnt6vJx3EFClRN3jGogajhK+VkjqZiF2y+v8mg=;
 b=M4ibEhX1C1fVnXEGAt0b5EM10PxydzqR9olMVz2k5m+aYdG71+WeSgO7rjf/08bxJg
 jrDdTbb3YhOtWC2ZBdluBfREgimeQxfc4IetNbA4fBfIDIQOErbFsSjR/UcdA5VP+9UH
 U0TEK9Mbd3RORc9/2zQpvp+4lpFr3hw942AlGsk62DqTkqQ5KOgtMeTK/AurHmWqPwf8
 bY+gYdi8pMfbBMo6oy8gZ2tNulqrdVE3WSKSyc9TsSOyr2oBTU3HS6RjVirJ9kh/SxXk
 5/BDJL5RTfRCs5gKF3NhEuHFamAUFqEu2rqOeJDzfe7hKs7uyydggYqELErsGOOg436X
 srLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761724764; x=1762329564;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rtrcuGnt6vJx3EFClRN3jGogajhK+VkjqZiF2y+v8mg=;
 b=q+e6hdD4jlgQwvJjf2VXtIPPgs0GPSCBHcLBIBrURw29RYSiY2Y9AfT+VaoSXOVXb0
 okmsl2E/UEGyqip+kVX1tfT0G9gLASRh2xnh2f0Vpk7Kq1UIiEUBc2oVxV4ohgEbOcIM
 2toVIeikk/4gkoubMm7VfXP9uZLQY+ZZnbZ81L8JefFPlHbhB1Cga9jBJ6MEPLyOcMbu
 GdKW2ZhvbIJFM02jSqRYaZWiqZpz1gnVdNJafH+6jsWY4kA3WicQoVkOwh7KmT9IhFFy
 UdZVHFj7lV5VYHEVtcyjGToU+KhhhhpC4i/29YAwuQGH6MQxjS5v2yi7oy32Xpplq5n6
 Foxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu5eNT6ug35to4K6hmpDl9lIWiDYs3h7QOaexG0ct5Gp2CxZ4buj2CiM2mlwjHLZqHTayb1de6wBFs@nongnu.org
X-Gm-Message-State: AOJu0YzwiS8CMiEZbPMOzrFcK9IMyO0SFLiw6nF4aAhUHS4JlS9n+ZNt
 FuOIe8NdcgmMKoDYydo2PPWntrAVMfrw9GkaJxRhSndMK7JWj8Jn6faUF2xUB7d1FTY=
X-Gm-Gg: ASbGncsPi9xyDqrEQvGtZEUhpUskUcARTr9jSGIzbfv3m8nBa1fo9C9yzjXg2ITnyan
 5/xy7lDrvMUpTk07Fj2K6RGhXIz+VMU38VeeFAKq9fLLE5YgqLu0F2Udf/39HQUimTXcf295uNt
 BsybP7/y115Kl3ws5fzwaFQly4lKOpu4gaCgXsBsCk/1hURVED9B9Y7G61PbbZVGqhfnRwUpWal
 nNxL9C1JEyumVSdSQYZnn+f88DR6TwcMHKnwjEYRj/zS62tAhbvowdJzNrnbzXEIreAaim15+fl
 dAKl1wX39Kg+5bYp3mBkQ4//PXWx1cBga7Iz30VGEesYHwcDo6qg9n+uLRWNgZ2HDrNj2elIbdy
 m9BW3M2LlSaTeOY37yTVQeZqOsan+dDwsuJ/PXE5hWi1XSkavDoatcetNZ+7Z0sdlUPVbZEQBBn
 5OL38OboLZLlkaqp22Pz7Mhn6tq1I=
X-Google-Smtp-Source: AGHT+IFneTYXqCNNYo4U8F63k3+djyfOw3EIzSfx0y+RaI01setV3VwcR/zyJ3iQ55xP7kX9pJT/Yw==
X-Received: by 2002:a17:907:a45:b0:b47:70bf:645 with SMTP id
 a640c23a62f3a-b703d5e5ee1mr194156866b.58.1761724764512; 
 Wed, 29 Oct 2025 00:59:24 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853c5c0dsm1336470066b.40.2025.10.29.00.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 00:59:24 -0700 (PDT)
Message-ID: <1dafdc49-b61e-4fce-b0c1-5dcb6a7a20a5@linaro.org>
Date: Wed, 29 Oct 2025 08:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/25] hw/s390x: Use memory_region_size()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::size is private data of MemoryRegion,
> use the proper memory_region_size() getter to get it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-pci-inst.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

