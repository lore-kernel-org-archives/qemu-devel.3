Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BFACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDelK-0004eN-Fn; Tue, 28 Oct 2025 04:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDelF-0004ay-Lv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:08:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDelD-0001Pz-6S
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:08:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711810948aso41288605e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638928; x=1762243728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVWTljkXVCTmCGl9b8w5geYtD3dB6kSA80gd6yn4Cfw=;
 b=ujEqzv+kqidc2CJqpmtTi8izy3nGcICwdp+RCzxwJajyiaH8seouNSKmjo4QOvFRZZ
 V/PnWkeBWviUv2NN8wY7ca10wR+SNBzIDPSf5rJehUc8wOZfuNbpY8PIEkpegD6SWxra
 agyrHzecZwauvG4KUWX5hguZcumYPA+BqyA7vBsPACTyxrWQus10+59uA+cMgHQ3oNFW
 wtH6ZYUAndobFr5eZaZdEYNv4FYxfLYLDGlAev5SrKebvbG/E98UyXZwY82I2IM89sCC
 vAJINTTUzEqi9WR0mZoepaCHGTnfXqnZwgwdrAwGQbeluIkzC/ABhVW9Mv4w+BF+9s1p
 vSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638928; x=1762243728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVWTljkXVCTmCGl9b8w5geYtD3dB6kSA80gd6yn4Cfw=;
 b=VcL0HoiEs9fEdvZ9o39EuVmXOFI/s0lC5V+kkRO03ZxnPcrTywXAW3aHuJ4iOJV6Ev
 fc7cgLdrGuO3kFNODTrqymXUXlHkZRU5PYsMI5AZ3IsdMydalKVip4YFUd1Zy1LWU/LA
 7R0Hh5lg/MSUu6J7gRLf4XDqMSPfuPMt1yG32c/tUS+DCeNoOxqeRKqBaPEr52V0Zz0L
 eJji0ikiHW5bFE3BGyTkcek2q0rmtc9q9JXOZN9EeIkGs8Gh5Vd+8KH4rWOm5cr/v6FB
 WXTOB5fLAMlQIZgGalyz/FXGjjvg/kzY8diedKBrulfS5xvw3WqRpuf7AiM9cg1Bxip0
 jaQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaA+Cvnt97lKGRbSn1o/i82mpjyJbbCw7lWAc2JKGrMXXqZqNuqQ0MCjMwOfU55tcO9T7e2MEwoxQq@nongnu.org
X-Gm-Message-State: AOJu0YxVu6z84pxzLjDDNMVfAgPUSk97ijy4n8YMMwrIkFOmcJtw+mKv
 hGnqcjycsKxPMrbWBRCZq3Zo8bTDobx6F4S/adbM781xIc5v6SlMxlsZ9W9NvjP6dqUIGZCD4jZ
 Wsfi0C3k=
X-Gm-Gg: ASbGncvKsKntcIwPOU+lxH25WUM7mkEzs+AvzYV9s/0sl7y9od/z0rG60j7CBnH/UN0
 WoZ3CmoUfJB+grgDvxJKYLkVXFQv3esnEC/3Od8gtVjJvLw/loXonw+CV9mLKsUuYOItIK7ExLk
 NCUmtmPtmgTXn1J/GYTXPOKmZ33rAcYgWSF5lrbw575YfqeRet0IVeNFJE9cyMo7SflChTtvtkj
 rvgcgd4WNXqp9Eh1mV+OkXdzL4FN1hRI1fgeBsKZp97kG93v+msHNNFgGpLfSNw/4AWrRCXfBzb
 9Sy4MEVn2qfbb1SOh9gHQIW8uFZ//Vfqzi5FFysMY45up/Pyi5EiWvg8Mo2EoYSbJ2noBy3nf9D
 1f48UeN2A73JALsOM8YmGenlZS1KvgDhg7k5fsUEFpRpzDAHymWZArydJGFzQvM3WBw8lsIW6f1
 h2E1yNpjkDoMweRWLAugP6FeCqyGu42RW8qVIgUOB58NRGpDVUSGf9zFA7e/eFMvTHMw==
X-Google-Smtp-Source: AGHT+IGY5X9k/KotatrXHbgp+P90RfyZdcomc1ztZNfmPPso1qSeRiOhZLBaZ+Ip+tZXndK3csp0SQ==
X-Received: by 2002:a05:600c:5487:b0:475:de68:3c28 with SMTP id
 5b1f17b1804b1-47717def760mr22830775e9.8.1761638928418; 
 Tue, 28 Oct 2025 01:08:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca979sm19308604f8f.14.2025.10.28.01.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:08:48 -0700 (PDT)
Message-ID: <e25cb599-807f-4e43-a96f-27cddbec6c0b@linaro.org>
Date: Tue, 28 Oct 2025 09:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/xen: Use BITS_PER_BYTE & MAKE_64BIT_MASK() in
 req_size_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251022140114.72372-1-philmd@linaro.org>
 <20251022140114.72372-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251022140114.72372-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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

On 2025-10-22 16:01, Philippe Mathieu-Daudé wrote:
> Replace magic 8 by BITS_PER_BYTE, use MAKE_64BIT_MASK()
> instead of open coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xen/xen-hvm-common.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


