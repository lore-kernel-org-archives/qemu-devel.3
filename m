Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2835D2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 13:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viBlG-000597-09; Tue, 20 Jan 2026 08:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viBlC-00057n-Tb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:27:08 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viBlB-0003Eg-8j
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 08:27:06 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so50799185e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 05:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768915623; x=1769520423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=24Lzy8XLb6E4fTuSbPaMcNncPA4fzwwO58f3XTv3F0c=;
 b=ZaLJdcmEUaKmAXiGLA/4wCV+sHKuYm4sGayv336qnXHk1nEQR1vqXRMK32TyYTKNxD
 Ukl4b6dLsNCu8AYIZ326itJ0zxIORgO0S+VCi891MzjqyLu9PtUj/8umJFc48/9Cp3or
 D/TN2xVBYqje10/P5jCkyA+9x/Ip+/j8ryjWwAsM850uC1xQftXgLStifkwkdDEEm9TH
 ovaAFgKU4TkgYzZ/dC/NJqmjkxxoXrpUuit3vklQIrhdcm7kZZMU7Ob+wgo/hjYFXSgH
 wUQ2+glmZ1Gh2vD0od9kpl1C4aBdJtqDdoshhrgkTQkumWgJeevYAP6DkHggJXlZUwWI
 HMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768915623; x=1769520423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24Lzy8XLb6E4fTuSbPaMcNncPA4fzwwO58f3XTv3F0c=;
 b=MuYSh557yEczUBASYfvjgY6cSozwR+duw2KNvZGpnn891KaRzYO7FMXtdC5eLzxmy3
 g2qrtSV1MfnayYgtYyCUs070JwKpej5Mq5Th7irSf7O75G+vzBU58f6tY50n8KKgE9WX
 QjsicUYyQlCHi4sivgnIuWPN/j0G29GKgcC9dteVbDsQeQYLPjEs7hU26N6VKreH8wqz
 3+2G08Ek4gCKI2mcfz9ZrkC96OrUIFHyTb1qQUA7auXK4MzUs8nd6qDfm9puNsOMKmRi
 0d0aqwI0WmvsqN2TetYXWTDhOFupM2hPdLytnpy0jSZ1G97DG2iwg/BDXZbiqrQI5MMY
 itvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIGuigxZ9PYuFYzBItzowSX9XfYz8FcCVQS8Fn3y+weNY3/ZORj4bHlrNiCkhkAxGggRsapXdGMhLz@nongnu.org
X-Gm-Message-State: AOJu0Yx1xseV6FA7XPxdGMZtMM4FdKwt82u7ozT6pVRxfyCn6s1D33dO
 iU8m37ecvFdGxBSTf4VuJOjg/KwgQ6owKmgxYZEDtQSs7018sRecNJHPxnfBUCizA+I=
X-Gm-Gg: AY/fxX7t+ryNYrSQPNzo8XhevDQgDRtVHDc5u7vw9ETOzn39VfhnIHqNYOntOQgIFbD
 7Xp2nC8W/uUv4AO5sOvaldN28+iBiJVf6oBveOZQrWmRGvfFqHVgybY1hEHZNEgNiXjhNQNG+xc
 mCIJNPC/uFU7FSr+HDVV4vy5MH5vtFxaVdho06viABLN6jU9xA6iAeFn54lhQaoirvYxEb4E264
 TKWwhXi7FaJ0QQhstDRf4wPCAE6AKmbJ+d2TP9BqRDVZroDjwhm0/JjtIYyqbgOfGPTDxQ6jpmI
 nCLJePna07MEYfrV7dXNwVcVYQNei7+3WDnYU8b1ep5eZFMgy6aOG02Iafdnnw3eGQXDgO+wWwQ
 Q34qkAm9mIhcXdbdW6hxcJB6/pFD65A4vYIN0XRjKL9VmDr40D7aOPbm9kMHJLBLzUv3cXe+84C
 91zxzmu65LxCr2f03vbmZgKOvVvgTlMWdizgGG6Bnqz5DS9RygRHJ1Dw==
X-Received: by 2002:a05:600c:524e:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-4803e7f1860mr28565145e9.32.1768915622992; 
 Tue, 20 Jan 2026 05:27:02 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c9cbcsm245909735e9.12.2026.01.20.05.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 05:27:02 -0800 (PST)
Message-ID: <eeaf48b1-b995-43da-90a7-669cb82a21a5@linaro.org>
Date: Tue, 20 Jan 2026 14:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] meson: update C++ standard to C++23
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
 <20260119191138.811069-11-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260119191138.811069-11-pierrick.bouvier@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/1/26 20:11, Pierrick Bouvier wrote:
> C++ is evolving faster than C, so it's useful to enable new standards,
> especially for standard library.
> Update to most recent standard available in our build environments.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

