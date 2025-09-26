Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51486CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1wZi-0007U2-FZ; Thu, 25 Sep 2025 20:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1wZd-0007Sp-7r
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:44:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1wZQ-0000tq-CD
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:44:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f5d497692so2271910b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758847451; x=1759452251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aOQ2on0sdHmvkvs5kV3n78531hzg3jHGKjG2QwgxWVc=;
 b=s9xNxoYMn1Xaq4L9dGvhppEnFvXgHCFHgC3RyMixEAE+ll6NaE0cjMHE6pFc1h63VR
 i35CmNheXB30TCgPba1i59l5TkBw6xFVmenTpR6QBd8+MwCGk6Hk0VUehjRLqfeVaE0t
 /6/qjKpdWOVpefei/EV+Ag7ILyPKU9GyXv+erA+lQ6we3O4NTJ8Rm2FG4Vv5Zaxcn+NA
 +80uYxKrgmTamV4mBr5KysWZL0iIxT6ESD+atUHMJQldMElGQ1Dw/mU7SYjXRqpw8ut/
 Pp1i/DcVIjtU8eRovA59+7bpfGOTw/6LWQAplOIrSIMYIAwgSuQIg1Ipp3DYN14fFTvA
 XFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758847451; x=1759452251;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aOQ2on0sdHmvkvs5kV3n78531hzg3jHGKjG2QwgxWVc=;
 b=Omdg/JI7d4eCSJSo5V8loeeRZDjE0TAbVNBkZRuDgvom/huBxRn+y/AiLFKb4w3Z5Z
 2BkObXlRO6yAftkar2CQ1v8gMaYcvdJwvlJnY3la1L+Jwv+0EXbJQzm79sFOCqYH98Yh
 ztixINUBIsxUDBr3OxL1/lxA/+eX9xE0jCFzcEdytvzZ2itv6qBV5kyTbVPWqsj2Nj/W
 CNEjRypW8Z0Y0gH3ph4kOcXffuTldLRNEDJb6nN56vjAtmP1O0ujFTR2h6DoWk+1IL4U
 1XHmDqxZ4iRRRWdeAsy55HoDH/mAceSLUF8TaPNbXth5jhggtOJ9CMh+sl0zCO4vkkvl
 V6UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHFnPa5N0lKLjYQ8ae2lU+SPKjGzIhoyapTw4NjqBkVYIZMfiGersnNCl1CfeWmS8FkW9PGxbDIkWw@nongnu.org
X-Gm-Message-State: AOJu0YwrpOs4PlgLDgzr91AlGEjh9UWjqkjY6QxIcm4EZ35w81PJXQ1Z
 hGaq/zBOVX//u36fKo6Lbfffd9J5F1aux1/PFHKbYY7tbyppn0zmS6PpS7QYFTZH3MQ=
X-Gm-Gg: ASbGncswr0hjT3clK3ztR+zi4b3TDYTkgEyYMgqSemw0NpkJ8YTS7djiNc5NSYrBmxu
 MjkkO3OVbzEMCV5T/mpIb6tOgmke9hQtRxr9aw27fgGmJjC8R0RFlzrFOmSeXM0UoWkYHgAZQIO
 DxsEXDrUMYB8CT/paJBVm1aA5okVbszk5y4tehAjmTeO3Q9TQr0+TQ2iOBfYA97Ytq9EvMNOSCs
 /W0yV5+1X/72L18PuqxfVm3sPuCIYY9h/c/N8PEq6HtBZxqIFMWUNaNogeBXDST5ddqpxQpCk8k
 +6fE+DiEd4shmaLqC4aHPrPZ3hh43KDrOeE/5jxa3K1RNoKaWvBi2PuulHrVJhnw6pHt0lqI3X3
 xbEEbs22E8hrypRVXpbvEXb68B2ocjEBHuZwT
X-Google-Smtp-Source: AGHT+IEbePRjOkGDneGHqZXxVcGYjNNtyohHWF/XopAofqSBWE1cF+FGHKuqH3H2oV6KaFq37fG5Zg==
X-Received: by 2002:a05:6a00:2e98:b0:77f:620f:45bd with SMTP id
 d2e1a72fcca58-780fcdd2201mr5708373b3a.7.1758847450665; 
 Thu, 25 Sep 2025 17:44:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-781023cb369sm2981427b3a.40.2025.09.25.17.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 17:44:10 -0700 (PDT)
Message-ID: <80a57c75-cd17-42e4-a678-aaadb6a47a92@linaro.org>
Date: Thu, 25 Sep 2025 17:44:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] accel/tcg: Use cpu_is_stopped() helper to access
 CPUState::stopped
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Mads Ynddal
 <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250925025520.71805-1-philmd@linaro.org>
 <20250925025520.71805-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250925025520.71805-5-philmd@linaro.org>
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

On 9/24/25 19:55, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 2fb46439971..f84342e0449 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -197,7 +197,7 @@ static void *rr_cpu_thread_fn(void *arg)
>       qemu_guest_random_seed_thread_part2(cpu->random_seed);
>   
>       /* wait for initial kick-off after machine start */
> -    while (first_cpu->stopped) {
> +    while (cpu_is_stopped(first_cpu)) {
>           qemu_cond_wait_bql(first_cpu->halt_cond);
>   
>           /* process any pending work */


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

