Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C0EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Xrp-0008Qe-FP; Wed, 23 Apr 2025 07:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Xrm-0008PO-Am
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:02:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Xrk-0008JH-4w
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:02:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so71005495e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745406124; x=1746010924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oX4XNxoeJ1fXZF688vfyDjm4beCGYePdnTaDiHhBDIo=;
 b=cpkKDWXQ88oTaOqf7w9Z19T1bKHmD02AM2CiMOmJTY9cOaniM9iYcmjx+7uwFj/msm
 PNF7s7dymdAUYTGupZZnQ5qlVkICFcfagfmOnWe6xWtAqCzZaxFTso8KjbJNZyBUisH5
 OibIqv4XLc28dnlSm4Tv9WScXIfeGAEAn4zQiuPHNIC3davvCAtg6MfLAamtkmk1ZsoA
 1TGIQAt8DtEJZgP6x7PbiLkLhuZtnn1AAR4ftTcfB1EiqexJBCaQ75P8lWprF6tNcvrH
 pqe9kpEbYJPdL6iPfUym0/CuguME1t3x1llvqbJX0u1x3tY5/9sDVavfrlErP3QVrZOf
 7DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745406124; x=1746010924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oX4XNxoeJ1fXZF688vfyDjm4beCGYePdnTaDiHhBDIo=;
 b=VbbP44kYEbyBZ3FP/wIwQRrlmqyzsH/gvB7n4IHJrbtMVD7J9QhAEO7zdUlg/COH5t
 U1eeTYiQzOE5tafmcSZAODbhMY7jDGjm7Oa/Z9aaZBpvIkcIVZz5Wxcg0uaW+ZKbF+GT
 TpYiqelP1pkA83ioXqhy3RvmbHX3JJ33TOWhhbY/VXej323nvZQJSAnwgqEiTVCOhYU0
 o4IWzKPCNj/qlqQuIyfVUfLIPm7/011OdEnS3AUWzPWQ+WraAlkpvUhZr21QeK9KkhVF
 L4UsGgsB/uU1gQkTQIvbv28xwgcB8XO+Ukq2+ob2vL5Z8UNJCOijRTyCtsdnuRQCM6qo
 JIeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWszGJLxADS2YWzB4XitRzPbWeMDU7txoTvAS1NJMJpv7cnTSkl73Zwi8HySBz5AyjBU7+tMKciuEiW@nongnu.org
X-Gm-Message-State: AOJu0YxG2LXw36GLGd8JqWDLPHYFMlabEK7UVFUL8HM8NslYnLqqUD4X
 9Uwst8U5b6afSmKAsbIjZswFexS68cwg0GJ9WC45bIJVkP/VVB8OZvGpBO0a73s9gyBzn/XkFNX
 m
X-Gm-Gg: ASbGncvXRDk8lzj/s2zsrhStx6pXmdvkSwOZvrYRSi8mr1d4nOK5eKzkfQ6d46W7z9v
 qQdPT8ys8Dkzr43qNPdtVbTXVtE/UitVSu0fp0wJAHJYFMkBYBpMEJ0s9uJgg2OGksfnq7C3KIu
 ubxokVDV8pPpAFoAyeyPZXtoKW4YcuoqXro3NsaKPaDkAI/33PXkl2CKE33A2QkI9bMYjyeT8iJ
 EDrHjo3F9pQsIvZI/DKQhblG13fZOE1H+N+AElaSczROFyYvrrmmjaf3HlyGmjb8a0/V1Ar95yo
 2VxUqlMaZO7rsPmTID0xGhw4acE16LdkmsyANcWNng0vGu8hkkk1oYWbDtW6hyOeutTt5QpA8rC
 kjoyfTQl4
X-Google-Smtp-Source: AGHT+IGAGSnDsOxfpnJ6VzDm8ygV1kypft0WUkxBMqjl+XpZGasEidmmquVWTLzgBvV5QjGrUKc7oA==
X-Received: by 2002:a05:600c:190d:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-4406ab67e15mr170279065e9.7.1745406124591; 
 Wed, 23 Apr 2025 04:02:04 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d40392sm22026205e9.36.2025.04.23.04.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:02:03 -0700 (PDT)
Message-ID: <53f9e6dc-8bcf-414d-8491-6c1c3d972962@linaro.org>
Date: Wed, 23 Apr 2025 13:02:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 112/147] exec/cpu-all: remove this header
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-113-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-113-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 22/4/25 21:27, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250325045915.994760-16-pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h  | 25 -------------------------
>   include/hw/core/cpu.h   |  2 +-
>   include/qemu/bswap.h    |  2 +-
>   target/alpha/cpu.h      |  2 --
>   target/arm/cpu.h        |  2 --
>   target/avr/cpu.h        |  2 --
>   target/hexagon/cpu.h    |  2 --
>   target/hppa/cpu.h       |  2 --
>   target/i386/cpu.h       |  1 -
>   target/loongarch/cpu.h  |  2 --
>   target/m68k/cpu.h       |  2 --
>   target/microblaze/cpu.h |  2 --
>   target/mips/cpu.h       |  2 --
>   target/openrisc/cpu.h   |  2 --
>   target/ppc/cpu.h        |  2 --
>   target/riscv/cpu.h      |  2 --
>   target/rx/cpu.h         |  2 --
>   target/s390x/cpu.h      |  2 --
>   target/sh4/cpu.h        |  2 --
>   target/sparc/cpu.h      |  2 --
>   target/tricore/cpu.h    |  2 --
>   target/xtensa/cpu.h     |  2 --
>   accel/tcg/cpu-exec.c    |  1 -
>   hw/hyperv/hyperv.c      |  1 -
>   semihosting/uaccess.c   |  1 -
>   tcg/tcg-op-ldst.c       |  2 +-
>   26 files changed, 3 insertions(+), 68 deletions(-)
>   delete mode 100644 include/exec/cpu-all.h


> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index b915835bea..8782056ae4 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -206,7 +206,7 @@ CPU_CONVERT(le, 64, uint64_t)
>    * (except for byte accesses, which have no endian infix).
>    *
>    * The target endian accessors are obviously only available to source
> - * files which are built per-target; they are defined in cpu-all.h.
> + * files which are built per-target; they are defined in system/memory.h.

IIUC in patch #2 "exec/tswap: implement {ld,st}.*_p as functions instead
of macros" you moved them to "exec/tswap.h", not "system/memory.h".

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


