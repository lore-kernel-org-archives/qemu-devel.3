Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BF5C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmGZ-0001Co-Gt; Wed, 19 Aug 2026 15:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGY-0001CS-P4
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:02 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwmGX-0000Eu-4P
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:48:02 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so1516829a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787168879; x=1787773679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+5qDZ9W2SFX307Cs9Fnkeo8Z5O9ChMoEnp+GiJdsMJk=;
 b=kjlIpU5QIFizaZ76uDthMvaLLL10Ki6zvsMRtPqCv44PSXhYtHmkpT7I5GAt1c4TGk
 ufVwVDJRYUhUfLf/C7hBeKmodcYkapR+fazVlCB0pMHWsZfjiXznWsS+5YCkiuGif/yN
 pAZSe/TzGoRrR5MzyjLmZbU1DkkcXIrR/pSOhv6uPQVSqeagmzmDUnYF3bIV/zM6mkHM
 vOuqur2y8c/A2krBUyav7TVQ6FYmMY6NtgdTyDe6TRFhorvVq6A+pphC5tIqaBN2PSvP
 C+zWNPUlm+XwFqt8fku9y+p40GgxLdlGIy2N5HXn9WItvwy3vD/n3SlkzUgdck9JRrEw
 Hy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787168879; x=1787773679;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+5qDZ9W2SFX307Cs9Fnkeo8Z5O9ChMoEnp+GiJdsMJk=;
 b=gTptWqBZ+FPoKgKmnvGQmv7PgZRTvZT/rmmYq5aTmQvgYsS0/upUIVPFMszaRW+KEm
 9QF/XgCaPn9o9xjE51cTSeqn3T46+NvfdBr3pXqZZcolhk/phu5+ioSnzuRr8I8xWlHF
 z35+eNBkysESjSRh1cwhadY93iSiTfKy+HOM3zdA9wfjd2eiy7RY4Bir+q+nYgS1+A/u
 425lXBtwNePovo1Pg+4J3foLauFy1ruw/XXUM7eMTG2jzVwQ+GgoGwAI9eyWZPc9N5XQ
 YXoeYd29clXmuNSe4wNwptqfRmb7oQvdwLCbKok7OtyexRy6em0MSbQLUJ05DE6jBghf
 frwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUaU5OO8USdqH/ANVWcG6rb2rBdbdoQOmRBRKywfaEpDQkUWB9vjLUK3gSIJH+QdZhoKwl3lNMK20x@nongnu.org
X-Gm-Message-State: AFuF++nyEMUWyUMM7PJ1i+b5oFeoGe2F0XBAiiiEMWT2AeK4yKXFBabG
 1L/xbYyhUKN697N8UGhLyZ1DlO11vVj8s99ufc5H3xtVA3WXxc631IsFZ/GvOQ7epHo=
X-Gm-Gg: AR+sD1059PIrZvAuvIelc2p9iwwl74IyONOftj7DnhFO/4fzmWRtQtpdyc726wKZgoW
 +WMV/X3opgs9xI1a1M6/dElqLKSie6Hx/nMzmSv0zFbpFNe35y5aGR16p5lcbpQo5i2z/nWLzyt
 cFqTdURB7b7eLNY/g8kxPdi7nIq/0REOIwVoM0Tq3Bl8GlcIPbJ7WOeam3ng3qtPTsgYASVEX9V
 CMiN+GeX9G3teYkvoHBYOESaztVJZo1U9bsLONgnpKYX9Q8bNI8EU04qlohHYpPmCThor0HW/u4
 QiK27EcY4/sXaOzPmrJAoE4s9CMU3u9VxnLCxoI07WLRJfCI7j6DPDnhlN5JEQskkCFaElHzs4u
 J/drrfA9yjnkZMF0WtR/tFPSl416W32UfeQpRAW9AzQRZUlVbWyOpEuKWUbDu6LFsvrTod2co0U
 u75mxQRZNZt4gmTKR8QCUuW1u7YPsUeYBJrdH5Y9LYzm3iEXorPhV5jdqgFtRrZckyEEjrxnHGd
 xH+4fa2
X-Received: by 2002:a17:90b:1a8f:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-3958125a864mr13053401a91.15.1787168879307; 
 Wed, 19 Aug 2026 12:47:59 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb51271sm4055310a91.7.2026.08.19.12.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 12:47:58 -0700 (PDT)
Message-ID: <85a2fdb4-e235-4411-be0c-e020a6d233fc@linaro.org>
Date: Wed, 19 Aug 2026 12:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] arm/mps: Remove 32bit define for MPS3_DDR_SIZE
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-4-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818172012.3052821-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/18/26 10:20, Peter Xu wrote:
> QEMU has switched to 64bit-only hosts for all system emulations.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/arm/mps2-tz.c | 9 ---------
>   hw/arm/mps3r.c   | 8 --------
>   2 files changed, 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
> index d6d178642b..f47b0cacb8 100644
> --- a/hw/arm/mps2-tz.c
> +++ b/hw/arm/mps2-tz.c
> @@ -178,16 +178,7 @@ OBJECT_DECLARE_TYPE(MPS2TZMachineState, MPS2TZMachineClass, MPS2TZ_MACHINE)
>   
>   /* Slow 32Khz S32KCLK frequency in Hz */
>   #define S32KCLK_FRQ (32 * 1000)
> -
> -/*
> - * The MPS3 DDR is 2GiB, but on a 32-bit host QEMU doesn't permit
> - * emulation of that much guest RAM, so artificially make it smaller.
> - */
> -#if HOST_LONG_BITS == 32
> -#define MPS3_DDR_SIZE (1 * GiB)
> -#else
>   #define MPS3_DDR_SIZE (2 * GiB)
> -#endif
>   
>   /* For cpu{0,1}_mpu_{ns,s}, means "leave at SSE's default value" */
>   #define MPU_REGION_DEFAULT UINT32_MAX
> diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
> index caad820d3b..82a354e958 100644
> --- a/hw/arm/mps3r.c
> +++ b/hw/arm/mps3r.c
> @@ -59,15 +59,7 @@ typedef struct RAMInfo {
>       int flags;
>   } RAMInfo;
>   
> -/*
> - * The MPS3 DDR is 3GiB, but on a 32-bit host QEMU doesn't permit
> - * emulation of that much guest RAM, so artificially make it smaller.
> - */
> -#if HOST_LONG_BITS == 32
> -#define MPS3_DDR_SIZE (1 * GiB)
> -#else
>   #define MPS3_DDR_SIZE (3 * GiB)
> -#endif
>   
>   /*
>    * Flag values:


