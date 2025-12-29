Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F6D3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3oR-0005su-Kw; Sun, 28 Dec 2025 22:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3oP-0005rA-N1
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:20:49 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3oO-0005cg-Cn
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:20:49 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-644798bb299so6780560d50.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978447; x=1767583247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x3k+xICPnPspLnfk9LelAL9K6BYZi87iEVVXgTWnLY0=;
 b=rdFjQ994AnTwKuHMH0Zhs7jgj0c0SwtmB8c95yVkOV17KjaQUyqs59AOSd7wd63kdh
 PRMnmOx++szThZBIuEncvi8SfditdcZqeeqpLdRzJT1+dfPc8yYGXVRSKrA2PSmy+pNY
 9Zp1GbqeHA1xtRwRn9pMHP4Bva421JqtPwyvGXIH6ivLgssSdrP8Veamis0mhsAvUhV9
 QUbEVjfnsBI6eDwwujCGnIhjZBWixbZComdBjoUo5MMcRk17OJB/960o8in996GqxhTb
 V4uQylhcw3q/hvhlTMHdjlMBiYdHVMRMl3DHHVlme1+3BahtgdO5bkau1sz3mrXa3Z6P
 7OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978447; x=1767583247;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x3k+xICPnPspLnfk9LelAL9K6BYZi87iEVVXgTWnLY0=;
 b=pSeFr5PJpzn15uLhxlYUBLrXd2e/zekOF35uBRn3BEI87rpLZvXlOzJ23zV7JXOJYz
 tm/+rDTwYqxcRFseCdzc36wosMrGGHfH9vdCSR45SvyM5HKStLnrV+sLuzL02oSXcVFZ
 C7sGg2eHXB0gmNL/Gw3ZPjbyPjgvyErmwwSDUpTQ8qDyh+m8fV0p1j9YQoSEE4ji+gX7
 X4oAvYZo6kcYkaGwqBbmCJksCxC5lS8B94GiEscM0PBHJbns8xKA166vEtD1ZFzabU9B
 bylHQpTh06Vyc3LU+hUdlrmMnMgs86Ueg7UtQ7zb3cJf+xuSn92AqFg3mw1o/1j5694R
 HbNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuN4gTgi5iEgNVj/Kq3KGnnqhUvJMU3sVxBIbkKXtQ80waYG+PLYOkDeMTlDQ/eWtHxzy2+SVgUvrg@nongnu.org
X-Gm-Message-State: AOJu0Ywphn62CnkZ/phEfoj9uCoOs5Ymeqxhw2SO8h//sNCtybQLGX3o
 X+VU5/4vXhgb55hyXrMslK2TCDQxqPzDM8tOzTjNRRJCUhplyTzNGE+z5NJO8XT78I8HdNeCkTt
 6+6p148c=
X-Gm-Gg: AY/fxX4iaPxDgN8M/dbGOSoysu1OUGOQmYPGgHYNZGnh/4ZjQwK6OoLkQyZObgnSmwS
 BQYHY5sEHvIkcaKii13OGGxVZMrVlhu74SH8rQ0XiS8edAEfbiqI7IrGUf8fzIcQyjD0vEARDUc
 +8ryG9boAeAL4unhK34iT+FFCH+ACEzCDbxn/WUq2yRYHZUKjWt2obczY8EjlsUBBso6RftbXdx
 vz1RMMOEg9yNy4tnQl4SjzflLrG8zISw+RV8rxJK+raCkwWQwt9DE7hsxXuEMEQvo/A+rZZLocW
 m9beqssqkcZeU3PjDS48wH/LqI2UwLty4YambKCgswsChJFczsi+4TPkgOLOHAQYeEDYOVh5pP2
 hoqjLS1ZRtH5/ICXEHlWuAI0hUWRMJGESBTj8CVMsBTpM/g1lo68UAuuLbn7W4f0ozKfk8DcuQd
 Kc584qYlHE2KxWxfRbggVu9fAS1q9ZNLyieQr6
X-Google-Smtp-Source: AGHT+IEKF817ql9QGKb/2NpX9AcqcPb/58gCsY+9GVwqUk6hHEOFzxZX5Us6TLfjsGPmJQS92wJr4A==
X-Received: by 2002:a53:d019:0:b0:63f:ab8d:a572 with SMTP id
 956f58d0204a3-6466a834c3bmr15786669d50.4.1766978447191; 
 Sun, 28 Dec 2025 19:20:47 -0800 (PST)
Received: from [192.168.1.105] ([206.83.118.74])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a8bd6ffsm14357945d50.9.2025.12.28.19.20.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:20:46 -0800 (PST)
Message-ID: <b2893075-3885-4909-b041-9b81fdcfe22f@linaro.org>
Date: Mon, 29 Dec 2025 14:19:22 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] configs/targets: Forbid Alpha to use legacy native
 endianness APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb130.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> All Alpha-related binaries are buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   configs/targets/alpha-linux-user.mak | 1 +
>   configs/targets/alpha-softmmu.mak    | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
> index aa25766236e..ee505e16ef4 100644
> --- a/configs/targets/alpha-linux-user.mak
> +++ b/configs/targets/alpha-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
>   TARGET_SYSTBL=syscall.tbl
>   TARGET_LONG_BITS=64
>   TARGET_XML_FILES= gdb-xml/alpha-core.xml
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
> diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
> index e31f059a52d..22fbbf0cb08 100644
> --- a/configs/targets/alpha-softmmu.mak
> +++ b/configs/targets/alpha-softmmu.mak
> @@ -1,3 +1,4 @@
>   TARGET_ARCH=alpha
>   TARGET_LONG_BITS=64
>   TARGET_XML_FILES= gdb-xml/alpha-core.xml
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

