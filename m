Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE215CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 00:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uld8R-0005X9-MN; Mon, 11 Aug 2025 20:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uld8Q-0005Wl-0x
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:45:02 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uld8N-0001uO-IO
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 20:45:01 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76b8d289f73so4602460b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754959494; x=1755564294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0wjTdEInx1voNPyBP+vwOL72UeL9nC/yJM0MnsyYCxo=;
 b=cBZoprV6sMA/t84OK1bPOHQmsxKkLA1LcKWlCdlhQd84XaM2ya0dmQd3QxFv1ySB7J
 DILX8lubCiuecxIRz+pBaFkP+ybKk8B3hJWOmh8c+HlCpuWqXZScmItnyi3sPj7bPHH3
 LhKhbvTd4TaWuJJrzvpQR5l68TXGQZmGTAZjIGrMjc2BCay4uFJSBj1bQOG2LWEX5qdK
 SR1zn4K223A6o7+qLhU1gs/vLToyJ9w7xGyvq22EfLZGtbKtYv0Ap2bcKIUhq986RoBC
 EybqBW9YeFiCYJOghS+M0MtEwnp+/NpR7mHizyCbtN8CtsRjFzjGtpv/tVwxznot7zFx
 ygwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754959494; x=1755564294;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wjTdEInx1voNPyBP+vwOL72UeL9nC/yJM0MnsyYCxo=;
 b=pmCelOnwbE1rDa5id6j46DD9FoI3Qkt3IQfsa1F0kfv3aonGex0ZBQ5H/JHFW7818b
 75y3LVht1rL6xqzWzF9Yd8Bl698BXzlrZhy/P4p4VsO2frq7Wt5Ow58eTpZ2HATuRsmV
 yTsJUg65f6GVpCqCa2Y7WffeSyglRhxXak8+xdBXHDzVHwk9FYeueM1BaAiY5zwtKRgF
 yOWHg7ENgMXInomd19VVIL1Xf9BsAi0fJ5DE53za0HpkKRtyiuxBlOhkQ18Zw3/w9RK8
 7PJnFKhfpu9Pk/iiy+ZmyQisUHbg9espoQIvRxyailC/O0LujO6BlbLnW7HwBma1kYK+
 PyxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEFDFpDGqKHsOGUis+Pqyr17yerVjaZ7U2vVC3R+//UOhopfnxvq7LGuJbOMIHNrG3vs4xzhafBUI/@nongnu.org
X-Gm-Message-State: AOJu0YyCRkpJ+b4rEcGKmBxjPOJXMsjhKmVCcwwYRVCCtkYjVG911azS
 92tjvyEbCEXB0HsvaJ5Tjkk+dKDatjZHszQAGT4FryChN4/BnfXJ18bjAF7yRmjYquOb7f/5RyS
 28pGvRnU=
X-Gm-Gg: ASbGncs8B4zm6wvC+fFqISi0ugYdi/wqTwF/ErWzff5pD4dtw9XfMxbEmuQfXeN0eDX
 PtPPQE99jKXfU6/Y+8Asm27tm0834as2u3DO0yIHuqYITgnhFGvcUcqmklNO2yFF6cc23sw5lWz
 HYtt4aO0+NbTAX2wIeBqG6/KP/hSLhlJqg11kz0D+JyHFtpW9BDnBaJhq2A2f3oSEa5rZQAIAxe
 4eyZagmB1gpuPt/i74P26ujCWXR4EAAlmC8YrTz2IJUSk/t2dcxqA7PcAZ+klc9RVZuVnCan7vO
 eHRdrWogxE/YyY5xwVaZWfg6zN89Eu95YyHP8TfKKQ+DLiX95jzfOB70o0Jjg3kW+7kJKmBA+Pj
 LYv9dp4zqOy/SvFqamIDJOiSQQvIvFuLXxzyyfWc39A==
X-Google-Smtp-Source: AGHT+IHSqmeE3bmr8Zn1t1wPPiFWzysP8jzm17DBzK9jGkXPGOVovCR8K361L5iTfQ2CbHmVk1GMfQ==
X-Received: by 2002:a05:6a20:7494:b0:220:9545:2c96 with SMTP id
 adf61e73a8af0-2409a8915f7mr2440330637.1.1754959494149; 
 Mon, 11 Aug 2025 17:44:54 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b423d2f5035sm22229159a12.39.2025.08.11.17.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 17:44:53 -0700 (PDT)
Message-ID: <34cb2f32-1cc9-40af-803d-78f5d995dd5f@linaro.org>
Date: Tue, 12 Aug 2025 10:44:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/11] target/arm: Introduce
 host_cpu_feature_supported()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250811170611.37482-1-philmd@linaro.org>
 <20250811170611.37482-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250811170611.37482-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/12/25 03:06, Philippe Mathieu-Daudé wrote:
> +bool host_cpu_feature_supported(enum arm_features feat, bool can_emulate)
> +{
> +#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
> +    static enum { F_UNKN, F_SUPP, F_UNSUPP } supported[64] = { };
> +
> +    assert(feat < ARRAY_SIZE(supported));
> +    if (supported[feat] == F_UNKN) {
> +        supported[feat] = arm_hw_accel_cpu_feature_supported(feat, can_emulate);
> +    }
> +    return supported[feat] == F_SUPP;
> +#elif defined(CONFIG_TCG)
> +    return can_emulate;
> +#else
> +#error
> +#endif
> +}

How much startup time is saved by this cache?
This feels like premature optimization.

r~

