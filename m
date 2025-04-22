Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7743C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HW0-0006n8-NZ; Tue, 22 Apr 2025 13:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HVt-0006lk-GR
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:34:29 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HVr-0007K6-9L
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:34:28 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so106264a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343265; x=1745948065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+5kxFAbI0lBrrHXjBk9fEE7MQBdKjoDDI9y5a2VBb18=;
 b=esUjXunAUNg+ky4QOSm8TpEMw9QtPGQVX+AEIctioCXLijT58iMYpAZ+MCgMWp9CVx
 LkPfL/5kXsWP2Tfr7excYc6n24y6vG5YeocfsmRnJmItoF1enBTE8+VO3FnvjMZEfBpU
 guSk3Q+zryxcGWg102Sv0VdjwlroB5rHyIOPAiX/vTsW1ouTQAwzLh8sXJebLiafhhmF
 yAleDDiLx40Hcc6fAozEtjUOCT/pcoQjaKrwqzLLQSel6N7K1KNWA3oq4f95sxCFKdkl
 sc1y337qazrbWNsoWL/Pqf2Z3UF8W+veBxcTiCbj9f1rh/zu7gNR8xRhywj6OIEDT9zj
 gUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343265; x=1745948065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5kxFAbI0lBrrHXjBk9fEE7MQBdKjoDDI9y5a2VBb18=;
 b=vjB/prXBKSSWA5aOW6Bo8Hvv6yDWd/SF/ZPQqMCTH1ytk7sEsylJQGngDissXshpRY
 Q2QaZUbSWsr51U92jO36s5rZeWpk0w7xgFHOdRZtYZ6auvNDqP63epU3POLlPNnv+WEE
 tl+vMMkta8dFTozpkt1W22MuInP/wSs9rPWXNsAT4lO2IUoHeVEju1NDF2Q8Tjp5oyaC
 7WC+09fgMph+aPlg8goKE9LC0bFkVll4cN1CP+xhhaeF68LaSs3M+ry8OdySNLJPQW7k
 JS5VqcLPlBMIL8OfpjmSfseD9I+gjw5J0vLCuNUJkWmnouqJE+43G1JSLRu77vDdezdy
 ACKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULIv/9NFqu2+t3oMsRyTNubveCyR67cS7B/+8eaW/PwtLrYSoPXjpoBXbdFsEUMsXTCFvo21u+JWG9@nongnu.org
X-Gm-Message-State: AOJu0Yy7mh5i8Nq558F1g3zyILXesXL6OvI60PmYZdY+EqOioTUoku+Z
 srozsaxQ/oyTJUR8fXoUSJ/PLM9TdTXG+Htx+SHKozdCcYFz+hCnfhGJIRqeId4=
X-Gm-Gg: ASbGnctOCPhiSSC9Kf7/sIKchVIigsPGbbb9spLNqKdv9Lpuz5zxMwPRvxdlAHQmMap
 5PFKILF2TTfHsGNh67onGtLQj5jOdXQrKBzwdzycn87WuWmA8+nIortblnhQgKBG+QavUAIgf+w
 2ggyBsrBOOvfn4l+Rlp1R0XssGOvHdExppEe59GKIWZHG31P1DxJ30zGGAObZliV4N2JDrRL9DE
 L74uH0yoWf9rfP89ACQEHAhKj2fEMAfFW0cb97HrE00OMLEwAEy6JUgR1YIJALVJ5haP00hVuqN
 5sjuJKnCzOu5iAy5YrjbDlEvtMS6ehQW2qOWpWxzO8UbeQZ/lmJZ+szkwN+HKgFKqt7PpNc6lhA
 BziDscAM=
X-Google-Smtp-Source: AGHT+IHNe+LLpS5sPL+JQJU7XlQ1ZcjwHTLuDtm02w6209zvqProgyjZhqK+jUfiQMHrjwk8njdyJA==
X-Received: by 2002:a17:90a:fc46:b0:302:fc48:4f0a with SMTP id
 98e67ed59e1d1-3087c1c120dmr23995290a91.0.1745343264955; 
 Tue, 22 Apr 2025 10:34:24 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e0feb2csm10195787a91.37.2025.04.22.10.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:34:24 -0700 (PDT)
Message-ID: <62ceffc7-eaa5-418a-bc9a-4ae70f711e1a@linaro.org>
Date: Tue, 22 Apr 2025 10:34:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 05/19] hw/core: Allow ARM/Aarch64 binaries to use
 the 'none' machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
> When we'll start to use target_machine_typename() to filter
> machines for the ARM/Aarch64 binaries, the 'none' machine
> will be filtered out. Register the proper interfaces to keep
> it available.

Perhaps "would be filtered"?

> @@ -62,6 +63,11 @@ static const TypeInfo null_machine_types[] = {
>           .name           = MACHINE_TYPE_NAME("none"),
>           .parent         = TYPE_MACHINE,
>           .class_init     = null_machine_class_init,
> +        .interfaces     = (InterfaceInfo[]) {
> +            { TYPE_TARGET_ARM_MACHINE },
> +            { TYPE_TARGET_AARCH64_MACHINE },
> +            { },
> +        },

I presume this list will continue to grow.
Perhaps sort alphabetically.


r~

