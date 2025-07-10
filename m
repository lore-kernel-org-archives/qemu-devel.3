Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF1C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZw2Y-0004sK-CS; Thu, 10 Jul 2025 14:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvMa-0004Dl-Ia
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:47:34 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvMX-0001Nc-NY
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:47:15 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2efb0b03e40so325956fac.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752169621; x=1752774421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h4VXI9dQz8PkeFDVbPZMHI6h5TMJPB74mhdSzB8OoQY=;
 b=p2Rm1V5GKztGEF3+EFFpJF/EtPv9eLBNrID3rJ0/15AFyBFQyh/C+qMLmFPcLlt2yK
 iSlzlRuae1DxE3ZJeZlSEUBPtgqFSTtszZSkuA9fz+usY5th2fQDZpgHpczPc0mKlbvz
 68BxEWAber0SMWY9+w8jl2v9ZaTM11EyQfYoDBcynYRfd5fIXEOa7t4MBWE0yMO2ItQK
 YNnmXGh4FPTfKc7MfEJQs0jme7RJw6iu/xVWRGQ00vzk3elzoztNbzzVf74bDeOep/ZA
 nPFppM/1mqEl/6SaqTPA82d4k/47SXygeMiLY1scpnwJEQSRvVhN5tbvQQsQqq77Edwm
 M5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752169621; x=1752774421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4VXI9dQz8PkeFDVbPZMHI6h5TMJPB74mhdSzB8OoQY=;
 b=izQpO2H2UMHi7jFAdwXaKX0vUmnCp/A6PvLRfQvIRMqO4OyJkWljXiSoSoaiNWbSEv
 PthCZRDHVazJdTwBqG4h7jrdvVf0Pkbdv/SAZFHoy+wWo/IvYifV5zoZIR4CwzcBMT04
 Dc6CHXISPCow4T4/wqewq1ObdLODrWsgzPVOykBSGLeLXQ4QxutGLvJ5MvvZEuVZbAwL
 DFga2fGVjmqZyi58+MjEq2aYp4vMUQItIoT8GAX6o9aROFuh0ylC3/qEWhWQDSaSjY7A
 s7dTrl8EYnvJVdN/MqIEHe9BdAV5LHTM+zJ+EsQ+QgL+Iam3bB9KDIZGLXis6z93iO/c
 rR7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+bOE1VevWC9G9yJ+BQYIRZz3NCkUGY8+y51JPCi7oNHKlLb9KxXZdabm6M4EB0moM2SGCt7jECmde@nongnu.org
X-Gm-Message-State: AOJu0Yy0X/vbffSFTKU+p9akWhFitcIbDWMUwbrGLdKmBSRkAHiMNasH
 G4YNCBe9P1rkaQQJ+nl5wuj5+hxCuELucT9WNejmZ8KjgHIOnmS8W4cd3WPg0qrRHIo=
X-Gm-Gg: ASbGnctwKRxpd8a1ecN4/xs6XpQAYDigfuOg5snbqV6LDB1rG0JWaRUO7MH7h4k118g
 axS0VIaOzMgOkNJPk7TBv+NUPyVSIgMtRnFVaJI0ivu4LlzE+ASpyChh4lhGShoxk9xRkzd6q5j
 0kkI1LJCJSDAHsQdv1MC7bfGarl0AO6m8JyfZFQOKZopmBNQXhbWbHerUx/aeJYeFf8pc5Sgk60
 Ai+hQckpOezfKiEiZuND9/AtrxEUY+M+iKmynUhznd5JZJhVbB6MbqcgWZoTXfp/YSQqbE+ov+v
 YwKwxmsUCluMbv/Yp4UMtSrbOEwrm/mEM2Y5tgYeRTaHZwuebcmqHsQRVt5vGPaoKVlGXFWvlCp
 0QcI=
X-Google-Smtp-Source: AGHT+IGLcUXESrgeULLz11wo4aYw8fiyrEmsfbUq845mATqz2YVuevaFrDykzmEZTf/Wdh9kYZrzcg==
X-Received: by 2002:a05:6870:d291:b0:2ea:7963:534e with SMTP id
 586e51a60fabf-2ff267742d4mr144042fac.14.1752169620901; 
 Thu, 10 Jul 2025 10:47:00 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff116d8509sm387445fac.40.2025.07.10.10.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:47:00 -0700 (PDT)
Message-ID: <b2262e4b-bdf4-42f1-a01c-7a1234c10683@linaro.org>
Date: Thu, 10 Jul 2025 11:46:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/gen-vdso: Don't write off the end of buf[]
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
 <20250710170707.1299926-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710170707.1299926-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 7/10/25 11:07, Peter Maydell wrote:
> In gen-vdso we load in a file and assume it's a valid ELF file.  In
> particular we assume it's big enough to be able to read the ELF
> information in e_ident in the ELF header.
> 
> Add a check that the total file length is at least big enough for all
> the e_ident bytes, which is good enough for the code in gen-vdso.c.
> This will catch the most obvious possible bad input file (truncated)
> and allow us to run the sanity checks like "not actually an ELF file"
> without potentially crashing.
> 
> The code in elf32_process() and elf64_process() still makes
> assumptions about the file being well-formed, but this is OK because
> we only run it on the vdso binaries that we create ourselves in the
> build process by running the compiler.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> Hardening all of elf*_process() seems like overkill, but this is
> an easy check to add.
> ---
>   linux-user/gen-vdso.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

