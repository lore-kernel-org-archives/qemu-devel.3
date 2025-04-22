Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EF4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hif-0005vv-Rz; Tue, 22 Apr 2025 13:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hi1-0005p6-Sm
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:47:06 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hi0-0001Cc-9F
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:47:01 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7376dd56f60so3940253b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344019; x=1745948819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E9CIr3zu+eQ9FN2xXW+S0HsFDZ+5VywKHN86XL5nnN4=;
 b=OzQ68og2dnmplBPaTiS7i5qlPaq4/8wHsxFPkz2XcX25UTgVfobWccmZchXqvytGhg
 0iE2so9VdhdcxIh4/EXhSuGToH6+wFb10thFL8PqlVD2tfVhNag5nkIWOgJ6+Q1SZIWl
 04QRu4ow4xwK1sTXwNYYNdjk+cBY+aPEEjzxCykEgUkw/rQClZN0+/gOYqOY1jIBglPt
 WSoJ1phPzT8vjxzyOK/i1Cd+ucSXL2nV6wZUyBjDp6jcXq3kYYB5OUPAOtR1yrWN9KtG
 P/eznCsJZcI97gXLvnbXhI9bUPVlMMTfu9V91yi+6kb2t362T3c4UPSjzwcwuCKq7go8
 mqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344019; x=1745948819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E9CIr3zu+eQ9FN2xXW+S0HsFDZ+5VywKHN86XL5nnN4=;
 b=qurMemFykr+u+bVFC+ljjyQTw1rjG8pGSCY18vZLMQEWio9xOyV/8BVTSG7Apd8WSt
 0//EpfXlQcDf4E65fv1N0NWOYrtbkamqhKBpoypHZETLFgOZ0Lo1cqptvErlRXDLF2lG
 kfGBa7XYXiLDFdo/93DjRmguP1iwPHxs0Yeej1FRfkOnHICrCaIpt9K5Xjtcx17B25Zq
 aRzbD7Y9SY51J+WWyoWTkFxOTCU7mV1UqKVQOAIp8WGspj0Wtfz2u1h4ghUkdz3D9OrL
 FHwRId+WaowPxf7xt2K+Zajg9lNdmRYmjGrNf390pSaBNe5/JxGBPNc9qHwFY1CdZ+GG
 BijA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpH+efxfzX5RiBFIJuDao21FYj1ZJPDMd2fM+gzSdXrW9ORo+T2dPKraaxjB5UsEw6iXlu+XyAmyBU@nongnu.org
X-Gm-Message-State: AOJu0YxBeY6JUXdFDSOR18hl7vCg104wfpiW27e0YIe14b85jk8+xNgu
 DMbu3k66vZwCSEbDvFZJm8LsKw3A1B/MMfA90sqNZOfvgkyEyl1kfU5KDauJF14=
X-Gm-Gg: ASbGnctugQPk+YPrANMli3U8o2DgU4nZdRqEg4/n72tUqrb7Czayk7utRL+IR24HMKj
 WHwXj/Z3tMct0+eltMDrZ389kmCeLbhPCWZtk+f6FHNEVu729lw2Gi+62IhnjE2pm1/r1+FHfEZ
 eupmxEBuQj5WSJ6ndROllqUMtaoDAF9qpFCo/QhgIu5WKZU+RMwnWkix323IftstUKTGwp1XTkQ
 4pm6Qae7wFOhZAOsCcg6tyFMJnSAQ4YNyudSqvDtIgjRGaWIqSoKzpEscFVhl3Y7dRnuXNjcof0
 06g0aHYQijlNvSHhxGKqmqtldexxOnnd+GItsI6fqfMIn/Fhhd34e58WWfgTwCu2PDQ8p14b6Ev
 vcCaIB4o=
X-Google-Smtp-Source: AGHT+IFkhary2xFPrjwf9jrmbzHcnh2DlDDncFZr4epYOYQ9rMpt5wfCP6VpRlzgR96Mxj8wBC+4UQ==
X-Received: by 2002:a05:6a20:d49a:b0:1f5:8605:9530 with SMTP id
 adf61e73a8af0-203cbd0bda4mr21963188637.28.1745344018724; 
 Tue, 22 Apr 2025 10:46:58 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfae99d6sm8885853b3a.159.2025.04.22.10.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:46:58 -0700 (PDT)
Message-ID: <d425b8df-b00b-43ce-90f8-8afebfd87d63@linaro.org>
Date: Tue, 22 Apr 2025 10:46:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 15/19] qemu/target_info: Add target_aarch64() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Add a helper to distinct the binary is targetting
> Aarch64 or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

