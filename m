Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B00CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1jiq-0002I2-14; Thu, 25 Sep 2025 07:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jio-0002Hl-DC
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:01:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1jik-0002BJ-Pf
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:01:10 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso5123325e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758798059; x=1759402859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFHYvzY/++X3HkGhLwunEollbtsaOYMDnGj71kgzpac=;
 b=YJn1lzPBSh+CuQgmdn0EUXmPzSxDxZS1CeVCu1/qkskerUC75id6UE6wcpHdSgUUFE
 2HXK8u7qHDquit5P9evA7p3L4cmEjofW7gTO1OsOE0cBtEqyLg8w9EtDcYjK7ZWSruGt
 M2VuIC2rRNXIVpQsP3eQdW2kS955+sQvI9GybJ6TS1lOjvTl2fEbrZtCmD5DJeSlnDyZ
 Iwux2VzXgh59E612RlRtGanh2BsB4xpQXp9p9dOnLWdfKH2ioNaxDuZi6jJMmet7zcJl
 Xar9RKf6dsHKys1xuzrLlpNTUuvFudob57MzCOb7WcMpWECkEjlKX8YvghuGNGzB+2EE
 M15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758798059; x=1759402859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFHYvzY/++X3HkGhLwunEollbtsaOYMDnGj71kgzpac=;
 b=BghpI02jBqZG6/d4LhC4IYrJDeaslkbJf0U257Vnhq9wdNfj4G3c9wsWvXid6WqFnh
 Y7hK8N/XljAZORkYbOwNu5EY90T93vrhJPvm1ajAxCXAOjBRLmdusDN4aRRMGL1WaK2q
 av6KsJeXy1gxhyRJimrkFNm6QJBxJJ71JgaL/OITvLq61k5pjdPB5y1G+hHrpIm29euc
 AlC3FiqNeDlKXOUHBPYcMl2i2OaPr8N+kROy9fLcGRrCQV3TsiKRx0MB1Gixo3Te8EHY
 jbBxINrI07qZ+ol7PugKsIYJpMtEI2palHuNbmOoB0axByHUQgWjRIy59TTmc+MeRvIK
 Cpgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9ksIPJOGiCmY99fcODmwU4fI6HtCqVO9gq/LLEc7dHZ2M2gwKnPWh59x7l3eVlFjtWzgRrKq6DPc@nongnu.org
X-Gm-Message-State: AOJu0Yy6CdQ6gmp2cYKH5rID+l0IyJ245/MFjXzHkXaGQdwcQwsfdGjd
 +FEMekNLl6DjzfMpIQNaAxnl+DYZb7l4d/yoxaJ4EAzZoqymRbShcMVoRgBn6ers3no=
X-Gm-Gg: ASbGncsLVQbEwgj6i+3GiBf4VCWnhADWNajzbcf0Nc3LfIARdjf93/88o+zwGCbnIGd
 CBpQY6QlrRGq5B5fe2O+XvfRMu/CNUTAQp+ghc0FxgzxSIR2H4Wb5u3TWBKbO/JZrSuOgNQL3IG
 Gdtv46JcgH7FTuGh45M+oMqgY4MRrOees+etIcqpiITRoev/UfGV0yCp/Ya3g3xH7JuIVZvZLnd
 6DuMZXYqmjyk7LVi6oMQ39ASlXtIsMtNZhMQNw+clzfZGiScbWDlqj/GjLmtb5uULctD6RfrcQw
 pw8MfU2VBiAKLbwsfDzEFY6i4cSKeaBaeQx2CD/ALBdhrTTzqYUh7WoL9iY4gvrrXFVHX7KOGcR
 mCjFN8bFKN8gh/L5vzzhG3mJ0YfsweJFKA3x0wyVn7lKhqJE1M7qOufMqr5A1aN+oMA==
X-Google-Smtp-Source: AGHT+IFF32wEFWE2RuUHdDYVuNb3GVRDeJPzrQk3k5HajP6vELcMdWrOLm2UmHBrzOpcEdkZ+3GspA==
X-Received: by 2002:a05:600c:4511:b0:46e:1d07:5cac with SMTP id
 5b1f17b1804b1-46e3292451amr31373435e9.0.1758798058879; 
 Thu, 25 Sep 2025 04:00:58 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab7d4e3sm71687535e9.23.2025.09.25.04.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:00:58 -0700 (PDT)
Message-ID: <29991d4f-dbdb-468e-a1d0-ed9fac8652ad@linaro.org>
Date: Thu, 25 Sep 2025 13:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/36] target/arm: Move cp processing to
 define_one_arm_cp_reg
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> Processing of cp was split between add_cpreg_to_hashtable and
> define_one_arm_cp_reg.  Unify it all to the top-level function.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 53 +++++++++++++++++++--------------------------
>   1 file changed, 22 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


