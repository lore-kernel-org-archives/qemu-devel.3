Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62225CFA47A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLZB-0007Yh-5o; Fri, 21 Nov 2025 02:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLYj-0007Ct-1P
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:27:57 -0500
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLXv-00062H-0u
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:27:48 -0500
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-b762de65c07so258821966b.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763709936; x=1764314736; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cskrPK+QxONz4k3u1F4DSco9fXxNJt/HV0VjLhKecYo=;
 b=Q3q7xJOkpaV0tvPMzhZfJ4xDsprWUdYTIIPMYqlBTjSy69G/qczCzI/2wu3at0vd/G
 LkizoSzUH5p6j0ZoSP/tF+zmjKIhbuF963g5oa1K7Ge1ly1vYn4LrUKag1mcwrQAJaUr
 ckS5HjgMPTz1NsP9MARnDpLw8OsxMzLbtTxiB8zRkUir2KDafaTpOKnQtlGoAC2O4EN6
 Kk00k0fY3IUpYWOBhRe58tnuvK+QwplOfk1PIAE3BvNPeueLMB36zFnoo1rgOyxlXXSp
 gxBxAwPI4Ex2VpFvfq34MW4q8dcScj4pE4X658brUeMr3XCCr6PBelB0HmrAy+xVL1ub
 qPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763709936; x=1764314736;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cskrPK+QxONz4k3u1F4DSco9fXxNJt/HV0VjLhKecYo=;
 b=KJk46aM6Ow/Zgz+N3c76+o4yOGsoxl1FmYU3idGGlIw5OFt3IRd0s1n88BSsd6jN2H
 f46ISqBZs0PTHGAmHdKRwsNRKp9A0I11HAfR3B2XkKD4no9jKoKnu/ga1WPByak0KlKm
 D7CPp25yWcgdhTSUHjXLAl86bgX198Fz1IXKeTw8zhfJuAx7bvkzw8HnFc6qaKBstL/9
 Ig+QhG17Cnz1eJJbZgYUdYpi57dGLfnWiuPfv7JM7FQBXwBfZZZPR6lPsI9SnCxjKPPU
 CqzTNYjPKLSQaeNpkjUWLqgLhEvyugsZCEN9XyziotAVLdGNnKfRAitaQmKpIrxV1+Zh
 pbZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhwymRQk+prGL/ouJlUR4eqkIbD8tSMTxF9KYqtp2O9uYqdB6pOBwTzLfpVZq3ZPYtwc4J/GK3AQtr@nongnu.org
X-Gm-Message-State: AOJu0Yze6P9lpy/FDSwTCPq3tq718/Psu9U+5DCMHwK6N+5hHJC1tIEf
 nYZG7EzJajRnabhK+w9tpC3Ruy2H0HRMChzxVbF4o/kN4sdnMyXM1tchhGwi5jTEWSB6C5iZZyc
 g57CabwGQnfVw
X-Gm-Gg: ASbGncu2ZH6/fURVu5ziUjLBmAOri6Ybcv4JE7t47VAl+8PTf5nvcPXGgoU8hF3qjEi
 X/L2vHKJh+GIt0rujRm0LhGXOB7ksiDmzIabt/2653ZpmzNrYDawbBm7JB2rIlFqQVm1eXo6yxJ
 JxHT0cq8LzNxSSjcU5ViOuUrZjvon5WU3UcQ/gWO9Fd9Cl/OZ6M6byxJSUlcEa0G6G/SGOoK8Xm
 xAxa6ItPmnxiNzC4v3rniqnD9dWKECqJLTEJZU425yyt51PYxxRd8ANYD2w4ZDxz1XzXzNm7U2Q
 qo9MmQBHVBP9KbDybCBaLwkoTfkKjXKfFHTrPsXRuTxhFDpTyj6yy7cagaQ8lL9lomQdqf15f4N
 mOHvLTGC59lP3x26Cm1yqoRGnX5E9odrn9y1y4H+BHSSmjyHTdGcbNtK3Nn78S5ODZ/WfhewdH+
 vAkez0E+SHXTfXwYrNsDlyNKGrF3FXWSGZchNqwqaYKClAgcO4jya7hg==
X-Google-Smtp-Source: AGHT+IGHN/KQ0bUk8m0DrtiIPbJyYZF2vimJtwu4hirLdJCh5xQio3RO8tP6oC4pcO1w1ZESKKMJsA==
X-Received: by 2002:a05:600c:4f88:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-477c018afa2mr11704075e9.14.1763709163800; 
 Thu, 20 Nov 2025 23:12:43 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96aa472sm85902195e9.0.2025.11.20.23.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 23:12:43 -0800 (PST)
Message-ID: <34ec72d0-dafa-418c-9372-d5d033a93c0d@linaro.org>
Date: Fri, 21 Nov 2025 08:12:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/armv7m: Disable reentrancy guard for
 v7m_sysreg_ns_ops MRs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20251114155304.2662414-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251114155304.2662414-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x643.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/11/25 16:53, Peter Maydell wrote:
> For M-profile cores which support TrustZone, there are some memory
> areas which are "NS aliases" -- a Secure access to these addresses
> really performs an NS access to a different part of the device.  We
> implement these using MemoryRegionOps read and write functions which
> pass the access on with adjusted attributes using
> memory_region_dispatch_read() and memory_region_dispatch_write().
> 
> Since the MR we are dispatching to is owned by the same device that
> owns the NS-alias MR (the TYPE_ARMV7M container object), this trips
> the reentrancy-guard that is applied by access_with_adjusted_size().
> 
> Mark the NS alias MemoryRegions as disable_reentrancy_guard; this is
> safe because v7m_sysreg_ns_read() and v7m_sysreg_ns_write() do not
> touch any of the device's state.  (Any further reentrancy attempts by
> the underlying MR will still be caught.)
> 
> Without this fix, an attempt to read from an address like 0xe002e010,
> which is a register in the NS systick alias, will fail and provoke
> 
>   qemu-system-arm: warning: Blocked re-entrant IO on MemoryRegion: v7m_systick at addr: 0x0
> 
> We didn't notice this earlier because almost all code accesses
> the registers and systick via the non-alias addresses; the NS
> aliases are only need for the rarer case of Secure code that needs
> to manage the NS timer or system state on behalf of NS code.
> 
> Note that although the v7m_systick_ops read and write functions
> also call memory_region_dispatch_{read,write}, this MR does not
> need to have the reentrancy-guard disabled because the underlying
> MR that it forwards to is owned by a different device (the
> TYPE_SYSTICK timer device).
> 
> Reported via a stackoverflow question:
> https://stackoverflow.com/questions/79808107/what-this-error-is-even-about-qemu-system-arm-warning-blocked-re-entrant-io
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/armv7m.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


