Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C4FC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWysE-0004qA-Sv; Wed, 02 Jul 2025 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWysC-0004pT-4G
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:55:44 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWysA-0003fZ-GK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:55:43 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so1128650fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468140; x=1752072940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNaGbkZjcofm3+wbLt0aDNbvCtikuOC0UMaQuN31ShM=;
 b=ZXp2jv536eeeH9x6CODUf5GxbAkr0qeVO4IECk77qNHS/wNofzRGxiIFqoW6dCRPIW
 trSH7YlNSbgKxy6gjk2HDv8+AaBTXz6qK0Vj71VR+TAFUdksvYUJAM6Ji2zHAKLIRy0L
 hUq+T1L+P/LnkDS+QG+zInyh/8T4+p8bnN8X9axE9bYYHTARTkQl/qAvL4913R+/jAwn
 E8q/aHf47USMlt5luWsi0HYNecKrLrSfRiUVJWNFMXhUjDW/kv5X91FMJojpyGUIgRBC
 V5DCvBJvqB4bOU/5PKY4j0Pi6Wmvtf6HHq8MFPi3hy5Du1XRwK62QXsPbgOiIPRzAkIn
 HSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468140; x=1752072940;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tNaGbkZjcofm3+wbLt0aDNbvCtikuOC0UMaQuN31ShM=;
 b=Onm4oCSkuZiJO3QKOpG8lQ2wtTq0VazHOOU8EHEBJc8den4IPf1utPdVUcA2GypiR4
 uyzbYrbKLaOLGNVjZFh/MyK01Pr3fWFY19l9/hRkpQBpGyrsntk6flllj3wNbMTvyl4F
 9TsjomRQId2BLoueq7/ynGEP69uj8Wd9rmPDV/8mRDfkjDufFk7pX8S5fvUb1CVVTwLQ
 DAsv33GQkRYzd9hEpNhexvy3z0GYADwTFHNA7yteT2dSLN8bytNuc1Yq6cgYzgSQqOn/
 4BGGqvYh53wSzGTg15s3XMblOHSuftwHYW/RpwbJLY6R+lOyVyg9/4nsbVBMEmGQbPrx
 RsOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULknPos4kuFKGjRvrtB5pFbuQ6BBeOalRv6t6B8uvbFARc6SCNNWZeFqClCj/kOcKinYEFXiN6sTUC@nongnu.org
X-Gm-Message-State: AOJu0YxUMvx0zMmOZYwMqcwEI3z931NRUTcTIX10hckWrorF8oPoMQ8V
 Ru1usNF2hnrbNf+3zL/Y+KFO05FRGI4WFO0CE7uNlsxShXFpCWs6yM0Se3O3biuMIXI=
X-Gm-Gg: ASbGnct7WA2ze4j8O1NyoQ8DSUM9kRvQguUILZS6sjl4S++nLXxVqufSO8UOlYQsUTi
 +KZewYlPwMDAvZjRCDJiloqKGha0hK57Zeu5bmUP55ZX3fGfMErCwlprCivGT58UBUUVmDJMpSO
 xchUufQ9wg3wR544p4AHPy/Zub+bFSVK9z6iWS6HsaDNcYyiI75YiH0XefyJ5RQbcgziPuDjW9m
 qna+p0VP9fi3SKiyD4t9BQJoTDSKTbdW6eIqxoreVOKBnxGZbgrHQMnJKbfIglhQbmyyfaVvx0D
 lHluLjjdpt3YbVQdn4/UDwvAlk/e00KDpdheX0w1ay54yPNcORTLHVuXQKtXuT62qcjlj77Ra2H
 9
X-Google-Smtp-Source: AGHT+IHHob7N5VyjJ32TO/Kz/4EOFTHDT6vL/MgjQ5h6y/d6aXtVUpx5Rd3gfqRQ66q+7hkhYEYS8w==
X-Received: by 2002:a05:6870:538e:b0:2d6:72a4:adfa with SMTP id
 586e51a60fabf-2f5a8d4584amr2488381fac.30.1751468140324; 
 Wed, 02 Jul 2025 07:55:40 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3896028fac.10.2025.07.02.07.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:55:39 -0700 (PDT)
Message-ID: <30a5646f-7278-4143-ac62-b07556a2bf7d@linaro.org>
Date: Wed, 2 Jul 2025 08:55:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/68] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-16-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/accel.h | 2 +-
>   accel/accel-system.c | 2 +-
>   accel/xen/xen-all.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

