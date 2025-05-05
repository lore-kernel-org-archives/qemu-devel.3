Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF0BC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0iQ-0008Rs-Pg; Mon, 05 May 2025 14:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0iM-0008NR-BS
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:38:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0iK-0005gN-Jw
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:38:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso3832889b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746470331; x=1747075131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKyzw7dqii7wjo8QpjXm87u+f1HmCj0oWFjoWrILNos=;
 b=vmCbvsTl0YD7BAYiDWQzUFhqWYpu4eUPBq6J1r1Izme5DCX5gm2dOeijb3ONcQMQce
 M9NY5x0ipZ6jC8sWpxCKXVCZdgvPmvPbYXf8iYYJrq5Dq5tLeF1itxde/td1IInY524W
 v307cXhhREpk4kP8EUQ5lPRu7uB0IULC77f1vqJjmKZZfDob9a/K7r7OyIitZc0vcwye
 UDUeclefvf19H48+9YreQWJs7/EtfAjZeKCDQTTLC4E1v2NRCRYLPlFJaWVQveSX8yC7
 NOT5ronOXBdbN08AuOP8xvgNWp9vu8zm9beCInKUIJj7yzTjVRt70DtD9N7Tf90anV+f
 2F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746470331; x=1747075131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKyzw7dqii7wjo8QpjXm87u+f1HmCj0oWFjoWrILNos=;
 b=r0vftag4YkdFWBGJBHbnVcep5AoSWBX/55trNmRVYYCOag7rvuLbh8mJ8LrFnnfdZF
 FteMPuGKoUtZm3+JU1BQUFd8wR4VamjIiIccwBXIHYHDrqujXG7IqF4wUZuC0WAM5l9A
 n9q1RZ4oSb/BgtmumnkFqvf3Q0fVFFvRk7X/NqT4OKBPsbC4rKbigs3S7qtOirJEeCp8
 MOWdW8Mk3c4NSaZPBTz2mSBiV929lAwZ1FIiacb5dnzpEHLGrXDWkIRbqwPs2+2Mj+tK
 Od+C0/2waA19lnaN5Ll49HO+i+OGZg1gHOM6rs068km9m42QG7P49Fp1CvszysEcMwu7
 7qYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+clPOVlU4tZRN2fhYwFjxvyHsSaikCaqm1aF2lHOoOyZHXMlp/2t41JFWK2Ar9kdM/4TP23Le/j9O@nongnu.org
X-Gm-Message-State: AOJu0YxI4HodXcufrLg9+puysls91kDX1mWG34NBxybmusj59KgClJ2K
 mNyucT+16fvCt3DhMMGQeMpfCW7rs7Dx0NNKT9DDVj8lrzA+noPY2lkVg+nMpXQ=
X-Gm-Gg: ASbGncvV3jkhDsHHf7mDTnOn1FNRFVFos7WT6fX6YxyygBiHVn2K/E4+HfUn/t0PH5e
 VzWKmODGA6Lubo0AKXdj3BxoSnkuV4y/Ehz7Q8a/VwpSMpbMmSBbFXS5Sz/cSmf1aKJkGwYDtQl
 dWREAy3oICEzmF3d9jKGok3khBfXnCr6LPDSxwpXDXQanLMt1XV5wfL4WCjJ3ojAwiH16D7TU90
 +zPh8LPw601xG0nR4ahZc033HWowW+6CDaoR5sEtMYSll1HHMWrfmhiTpQh3u+sohHv7av88AxX
 wcwwHzjjLzhjZf2kcEQS8AfTw0R8+ZBR2Ot926T0w1dJtS0ZkYFqUdc7T6ANYJx/NYyMDB4Lgev
 eStXEkfA=
X-Google-Smtp-Source: AGHT+IGAAUCgJ+qHs+CPl3wY0lI93EZysTDceyPncdEvx0HUi2ww0QZf26oq01DkkIYwwBVPPIR4oA==
X-Received: by 2002:a05:6a00:3908:b0:732:706c:c4ff with SMTP id
 d2e1a72fcca58-74090f149f9mr821065b3a.7.1746470330721; 
 Mon, 05 May 2025 11:38:50 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405905d029sm7366657b3a.134.2025.05.05.11.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:38:50 -0700 (PDT)
Message-ID: <79916f8d-2793-40a7-b769-ee109c52ef63@linaro.org>
Date: Mon, 5 May 2025 11:38:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 41/48] target/arm/tcg/crypto_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -30,7 +30,6 @@ arm_ss.add(files(
>     'translate-mve.c',
>     'translate-neon.c',
>     'translate-vfp.c',
> -  'crypto_helper.c',
>     'hflags.c',
>     'iwmmxt_helper.c',
>     'm_helper.c',
> @@ -63,3 +62,10 @@ arm_system_ss.add(files(
>   
>   arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>   arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
> +
> +arm_common_system_ss.add(files(
> +  'crypto_helper.c',
> +))
> +arm_user_ss.add(files(
> +  'crypto_helper.c',
> +))

Could this use arm_common_ss?  I don't see anything that needs to be built user/system in 
this file...


r~

