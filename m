Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F9CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ6oO-0003t9-KK; Tue, 24 Dec 2024 10:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQ6oM-0003se-KU
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:27:06 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQ6oK-0005Av-DC
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 10:27:05 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso54831615ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735054022; x=1735658822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JiLhIRHosJxOW+J0zPXeV5WBfWdG+502oCZ8WSyWqfQ=;
 b=y8Ts4+wUxpqP4HK0IQR2NdsJkn9VYL6xmqWGCrdlrExcP4EE8IAHGuK/8m9jHNMLH8
 rT9g1w0HC7W4I+QoNi7dyIAqrUvIroZLr0M/IN4ElvyafaYqArYIRgaeVT8C5WvBe4Mu
 oH0fywYLrNi6OkXAbn8ucZ6lzDW8z5CRugNgw+tpOXbqeQUEaMXa/fvcP6Kg4zT+iWDk
 qQD5vLwoAKq6OOEwYf1Obz/p8cUjduFHpqMm8pbVTJFF8X2xKadGBpyrHByg7rtapBJV
 pS5u1mWNR7d/cDaVwGoDSeMVn6lGxpoXcQAwRB1An4Ehu39qL5ojaOMZyPx7M8tIcdFF
 rY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735054022; x=1735658822;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JiLhIRHosJxOW+J0zPXeV5WBfWdG+502oCZ8WSyWqfQ=;
 b=Rcbeg2tgPAmOtVnkMb8+A9XDxDkok1VueDx7QGLQOAK/dCOfTzSpz+tbQ8EsD3oOVI
 yUiLxWSMuRR83a9h5LH3J1IvZWt5JMYtProstA6iKhxi6fqFBrhzcBvKbsV5DKeywFW9
 IiY3V6i5Q7OXl56ci2MV3rx/Rvz/LiabArNdNFAwHcbf/4GcSt0lfE/tY904RvXOHAqP
 9hABGZV2Ra65Tgyy2dB+dum1f6m6I14upbntDWcM5Qqt+Kda2oTYxCoeubM2oXvBWH4y
 ZVt7UFxwCj0dRlplrYTJLaWGbu6aDbf0+S/EWtVuidfqc3tB2pBO7m9pNABw2MZuLd4a
 RD2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR/93S7GstGyKrQZULF8gI+Kerr1vgFyM+bNv8ljckKRiRf1kbJsAYBR456boIcrqhHy1mveKh77Kz@nongnu.org
X-Gm-Message-State: AOJu0Yy5daMSMpq8NB4xcAnE0/8ZCPQLm4sZ6TX34WQ3gH9g/TYpF57l
 F4S0srrdtKqTu0mwY4rs6D/OO6ikXUiwgeu6eVPRpabCs3trGXfFKQ1rEyn5LH6PoIyNWUy+zCO
 Gojo=
X-Gm-Gg: ASbGncsPguYFtdNBFyzcHEM9im7eseNVG3obkFkI8hRWNPWux9JKHRBsvSofnsAKh88
 0GL5N7wMXFHf3X5ohJg9tMNXOCdHvarIFmbcO9zbRpfiBUHTrCIYP9mGqI5AA0lXV0I3qPdZDsN
 np/UPM7WKWXWYzR5RGU1zq7let/ldV/NH0D1/2QdE2pu6ANo5lVdT/eN3/l+515nW1L5LMkm8HE
 +rJ4vYFdDhd1KZfRg84mn7cYqQrTNS4TmSc2zJNr3pRbfIJIV54yN4fh9Ju75DnveHghsr9RAXO
 fX5JR2cd/kntW01/r+G7C+UUKyAZuiL3eNVNia4=
X-Google-Smtp-Source: AGHT+IHAbKu4KQgQ8fQ/Q5inOUmaLGyJAuP2fHl6LXp57iaMFvB0THUe8woyW1b+e47GBxuZ+PyBHw==
X-Received: by 2002:a05:6a00:410d:b0:725:e5a7:fdac with SMTP id
 d2e1a72fcca58-72abe1ad517mr24785590b3a.26.1735054022504; 
 Tue, 24 Dec 2024 07:27:02 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb9fcsm9833136b3a.164.2024.12.24.07.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 07:27:02 -0800 (PST)
Message-ID: <ec72358e-76ab-48f6-ad07-adc6f6504ab3@linaro.org>
Date: Tue, 24 Dec 2024 07:26:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/loongarch/boot: Support Linux raw boot image
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 "open list:ARM" <qemu-arm@nongnu.org>
References: <20241224-la-direct-kernel-boot-v2-1-3e8336c54c60@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241224-la-direct-kernel-boot-v2-1-3e8336c54c60@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/24/24 07:06, Jiaxun Yang wrote:
> +static int64_t load_loongarch_linux_image(const char *filename,
> +                                          uint64_t *kernel_entry,
> +                                          uint64_t *kernel_low,
> +                                          uint64_t *kernel_high)
> +{
> +    gsize len;
> +    int size;
> +    uint8_t *buffer;
> +    struct loongarch_linux_hdr *hdr;
> +
> +    /* Load as raw file otherwise */
> +    if (!g_file_get_contents(filename, (char **)&buffer, &len, NULL)) {
> +        return -1;
> +    }
> +    size = len;

This truncates from size_t to int, which will start to fail in odd ways at 2GB.

The code in load_aarch64_image has the same problem, so the best fix would be to change 
unpack_efi_zboot_image to take size_t.

> +
> +    /* Unpack the image if it is a EFI zboot image */
> +    if (unpack_efi_zboot_image(&buffer, &size) < 0) {
> +        g_free(buffer);
> +        return -1;
> +    }


r~

