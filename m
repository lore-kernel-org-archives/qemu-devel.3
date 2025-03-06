Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C818C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 17:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFN2-0005w3-9j; Thu, 06 Mar 2025 12:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqFMz-0005vi-Ui
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:50:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqFMx-0006vy-7J
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 12:50:53 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso621253f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741283449; x=1741888249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GzL1wmnYzX0x1R9dTMiKuEwyMh6et1pxH8MfNvaya3w=;
 b=aOa3t+PW5vsuF7Nsve5UkbhmI3IX1WKjSX/O2UK80CbK5Jc7RiBOmwDaSPaqTlCYJh
 VB6eyJMtdgsk4UvbLhV5gKhGHGD+oGKksdTpT6UZhF0oi7/+aC7ult4B3S/nLDNcI14k
 1pGk6aYD9BAbYYERHuq/PP+SVU9Nsm/Iq/E+1OXL0TFmv6DCPIoALwe7FewaQFLPpyyz
 oAj/PYhaR4XC7bUmCOB2yqTHAPXOh7oqkjAQn9yZQE6pjAg0I8VwtddMN0yP4f/AT+nr
 2xeVwE41PhXBj0LjG9QdoJ4hoWqQJ+i+nj8cmLE++/6++v33rlSHRqeBoznmdbdCIfcR
 l3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741283449; x=1741888249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GzL1wmnYzX0x1R9dTMiKuEwyMh6et1pxH8MfNvaya3w=;
 b=fRgd4R+uyq+PIgiWyns9qyV4EXzjNKrsU61fRSvtDGVJnMIMwdZBWQwGE4dlgwn3+i
 rg4GUdA7ZWx+rl1kzzsoVCAghXqrYzreg6PGM38EcnY0xOsaWyo4AYoD18kUZTiz54HX
 1w1DLpokzMCv6/T3yynMFY2u9T9/Q0xBG6TYhYNDok2w51Vuw1B1hVLOdO7EDLdS8AQx
 8DtsqSRzZi5rtRhHydgxMLUZX0zk3VZOXo8s9fd7OnVMX5V58NO8nI6zfisKl8rimDny
 bPdg9P3pizOM28sa75e36tsj8/UmsPKPXP+k9ag5ZtUhSL7vOyhS0CYVzSHDjdxK3naf
 lP1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyyuVR6+NduOTi0LymnhKkK382PFGgctVczCjHd2uAjTTYN9Hk5qRtjpUv5P+6iEUx6kOqu+Incltw@nongnu.org
X-Gm-Message-State: AOJu0YzIMPIY0NSS365iAe4b5VPvEoAp05TWvyFqPEynVH1IkALReEOO
 1qJpdS0Bt7+uCm45FyMSWxSYRMEeBWxtbZIe0REm5sawBq8Q0dCBLT7PfJ9JPfFA9JdlYgLOvGk
 bnQU=
X-Gm-Gg: ASbGncsubJoBQUH7YYjqGbxGXkZqoEGy/dIBdwd7pJX9rd38jDe12vY73ME7dcZdIs0
 1jaCtvXSe7vwmRYbNECDYFrbGbrp4vIja/osRd5oUmPM0vCmpb3EkORU0o8QFgktwjT5mrBm/P8
 arz1vuHgQMZlJ65Rea87XARzkBMniznYKjd75/8R6lgasd/GZovWfxVFshZ1tW3P8nyZA9n6S2Y
 CSZDLsQMNLhWJbgQIDZaqcmVd3urbZNZMBCHynm5XWugyJQen/Nhf9siMi5LeSJWfzaqGr+hhOp
 7XDFUAePpB0FHwtg1EZ93m1k5aeUntk8VN9AmfJ9pm5MTRnl0epQC3LSD9hnTGJu3orqBHc4TWp
 PUuG0PD9foicC
X-Google-Smtp-Source: AGHT+IG+04NQyQ6qVRW1cY8Cbh2ezZ5euoK3IMI/9AkxtYDZ1UkA3jvwr4id2vvbDFAiTj02i2C+Rw==
X-Received: by 2002:a05:6000:402a:b0:38f:2ffc:1e99 with SMTP id
 ffacd0b85a97d-39132dd9426mr17216f8f.49.1741283448941; 
 Thu, 06 Mar 2025 09:50:48 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015d1csm2665597f8f.44.2025.03.06.09.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 09:50:48 -0800 (PST)
Message-ID: <211519d6-ea5d-48bc-8213-154b94a6fdde@linaro.org>
Date: Thu, 6 Mar 2025 18:50:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Rename default-configs to configs
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250306174113.427116-1-groug@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250306174113.427116-1-groug@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 6/3/25 18:41, Greg Kurz wrote:
> This was missed at the time.
> 
> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reorganise")
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   docs/devel/build-system.rst | 10 +++++-----
>   docs/devel/kconfig.rst      | 16 ++++++++--------
>   2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


