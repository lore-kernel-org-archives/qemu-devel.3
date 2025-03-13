Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0C9C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspZa-0005yO-LZ; Thu, 13 Mar 2025 16:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspZX-0005y1-AS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:54:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspZV-0005Ey-7u
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:54:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224019ad9edso38350115ad.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899267; x=1742504067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6wksDcsIfEaUdIx0JSRnKPLoKdYXL8Wt2b86ORLe44U=;
 b=HcIPSoZ0CcZ3aKCEVFsxesxOybiIxsiEbiwNmfcfup3gZGe7Q8oh29pmBba+u7IZr0
 /UF1mrM8LKJjoCju4gr03ei5k3l7jDSE9Z0RSfjsdUBFKYh3QZV1bR8T7w2jwcsQyS5w
 iRiSBklpCy0zRS7qlXW1I5NNVahCj5BL2TMZWbOFbQzX09v2MqKnsBlWZN1amp6WjhZr
 MbIS65kcVHDx5mx6Dg8/w+uzaNMkJ0yYBSZZRB1E810FE7z1SDtgMvD8yfkmxc3Wou1+
 v8LN/AYrztObGsL33ZlZS1Yff3icXddE4jTzyCwhbuXbzH1Qjt3ZgeRR5FweIhfQuEZ+
 z1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899267; x=1742504067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6wksDcsIfEaUdIx0JSRnKPLoKdYXL8Wt2b86ORLe44U=;
 b=rtdaAeJi4iS4IUG78yzd+6BOw6auX4lrxTxTLU+JhoR4W6ngc++jC18NQugBEfpps7
 CNxKCY6ia/nkpE+/6v0XgcHwnFlz5KuTg0wdcVcvjBRex3WiflyiYyCCCPq7vIn6NRIH
 G/LwCzb5h8Wvi9OE+Tap4vAz4wNFOF/PEqhQZa1UWjz8i11tMNUbnYXaon2rOJnVdSw1
 AN7AVWbbIFTLXNnNCXTZ/nPlv/EzrDPrCR4RJSA8puvYmqxDt+evdOmBBt2tBpcK9yFf
 w8yiyLrPSW95HN5kovP+I1n1EcluxfrXrRK+wAjGZXu6tUziUQQvXyx0Qzvrx70kfz3D
 C96w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLvZTul8Y1463Tiz88F4r+xXqwScrlFgAz6aPAVG9iQ6DVzg5/jRWByIdPqb/lVB6wZxOAeUQJ7ujx@nongnu.org
X-Gm-Message-State: AOJu0YxYCourcv4R7DLibOZVDjlPRzYk+yYKFf6Y/1ep+WxHg+aqahgN
 8e5V50N6DCv3Cuz5uOv98uE/20HkHzqq1aYC6EzYJoaLYLeXlD8JPDAmoiJoyhA=
X-Gm-Gg: ASbGnctd4rPUBU+ArFFjVL+qWyM16sVwebd436Jt4rVlcnW5NN3l5LctliyZkoMI2sd
 C4TE8xFZusjWx9pQQGFg6yLisi2GkjROw8+GpzyikEZHmuXEs3dhxGFZ7A0jy8uygeQ5np4apgR
 lpOILEWMScdZfbHXHIx/NqbLGJyA6FGc5pF/BK3Cm+4BwlaIxLbjHsRQC4KPgZ0kWbT3sTwvR/J
 UijdDa5nY71rKrdcqgJnteeOWwu87xdSvFtpxwkl/nDcn0VPHKnou0ql1ca7clEzGHUzkp5SbwN
 ekatX3hIeef9Y+v8R3QfWfWdD255SfBs1E9me5hqhStEC68rAQ3pominkA==
X-Google-Smtp-Source: AGHT+IG/MC/Q0Yi7HB49AnMTpFoAb+HMUuSnu/VMf4PrO/ZTVeTYJ8r/s6uCMPbXbk4GmTCXfoPNZA==
X-Received: by 2002:a05:6a00:3cc5:b0:736:fff2:99b with SMTP id
 d2e1a72fcca58-7371f19a138mr1038966b3a.23.1741899267681; 
 Thu, 13 Mar 2025 13:54:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737185ac9ebsm1096574b3a.19.2025.03.13.13.54.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:54:27 -0700 (PDT)
Message-ID: <ba29ce4e-352a-43a5-a803-af61cec2b056@linaro.org>
Date: Thu, 13 Mar 2025 13:54:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/37] target/xtensa: Protect semihosting call with
 CONFIG_SEMIHOSTING
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-22-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Semihosting is not enabled for user-only.
> Avoid the test for that case.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/xtensa/translate.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 4f02cefde3..d13d05878e 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -2241,13 +2241,16 @@ static uint32_t test_exceptions_simcall(DisasContext *dc,
>                                           const OpcodeArg arg[],
>                                           const uint32_t par[])
>   {
> -    bool is_semi = semihosting_enabled(dc->cring != 0);
> -#ifdef CONFIG_USER_ONLY
> -    bool ill = true;
> -#else
> +    bool ill = true, is_semi = false;
> +
> +#ifndef CONFIG_USER_ONLY
>       /* Between RE.2 and RE.3 simcall opcode's become nop for the hardware. */
> -    bool ill = dc->config->hw_version <= 250002 && !is_semi;
> +    ill = dc->config->hw_version <= 250002 && !is_semi;
>   #endif
> +#ifdef CONFIG_SEMIHOSTING
> +    is_semi = semihosting_enabled(dc->cring != 0);
> +#endif
> +
>       if (ill || !is_semi) {
>           qemu_log_mask(LOG_GUEST_ERROR, "SIMCALL but semihosting is disabled\n");
>       }

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


