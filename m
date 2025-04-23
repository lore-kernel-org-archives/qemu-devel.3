Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9701FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7crB-0002Lb-QZ; Wed, 23 Apr 2025 12:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cr9-0002Kz-KK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:21:51 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cr6-0002Y7-JJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:21:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso88730b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745425307; x=1746030107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E+7yj1DlqyNmsQqQj7S4tmkODOfVa1roMM+jzcRDUyU=;
 b=YP3PVOemr9ezFT5j5FJHrb0gt+P83FChwA02BgZd2sAKyg3bOEbVQzfrNtoiaoHUdg
 Ujg8dw9v5b46Ay505v6OouJ8QaFULyNdm1kVcqjfmii74mJpuTskaHIoP50Cx3VJQSlc
 nuI4yXruOVkK0blHk8dRxMrrtelIX0fzI6phRd54ALU2uhc6MAOleWwzITgZ4x8GDjc/
 PEa8obzwSUf5GCUL94TXVEWRLuV1euFPrXd+7GXbM14aiChUS4o7HjXao/N1uRgp7O+2
 y2mOHjwbjXviKrzEWzfOr4UBz3lfi024vaQRv7q/2U7OwFgyL+sm4/zyqALf6x+yN0CF
 /+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745425307; x=1746030107;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E+7yj1DlqyNmsQqQj7S4tmkODOfVa1roMM+jzcRDUyU=;
 b=De/8l5F2wLW6VxdfMDi+r5E9jTceLPTT0cZkv+Sr3d+n3JpUzRhzugHhwbItT4VOze
 B9IaGx3tWsSYH/ik2qXJsrty31rnNUqn5njsuRq+j0olHgXsr1kTQWKvwipBtPm93Exp
 9BuUwvvZfNWAD1Za960s0VZE3J+pHgv8inlBX53vPwabjgAzIKe+z0AECWxttQyGy5X1
 wxs1UIW/Pc5nVrF63bMkNxNi+JMpzmRGjYGEWd+tpRYFaJS19D+F23mh9mFaz5Wl2lkx
 QnfQ0BM8yDmoa9f9CIO5FKgOofnyYI3fgD3nwGsU0TidLTouvdTeTMDgJb8JiB9CQ7Wc
 kdjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYopYZZWTbO9ZxnBTkMXnD57IWt46hLthdjdxkhgVFxzeHdxQpsIuXP26PByYH9q1R0hvC2RvdnKAV@nongnu.org
X-Gm-Message-State: AOJu0YzCLk/ktdOkX5UXCr3yy0fWQ40H6+CGRTD8JYkti2k5wY7vdSHi
 ihqcy86a6heLKy1HkTqV1J/XW6msDrgmwzuHD5Nci5JY0FFFXcitjpkL9s+QDo0=
X-Gm-Gg: ASbGncuYxHF87Ftt3lMIlavTKm7uD+z+NhgqgOkFd2up9sTjjs11vhBvciemR3mAeSW
 8d4CAJYomUObiv5dXOFTbYlyUnRDIT02SqsMfTtlSe6pJTBlRqF7L9zm8M1/F6ixUwaT56nFzdg
 xsKMw8oyR+Ai7HsupSjP/2wlxpntlh/XEZScLxkWmK0ZKQTt3Ddhb2Fx7x94X/4166RF4ja5shW
 QyC/Ve9wwntEUCIcIL8jv7kHE7wjq1bAgUdJP4X5v3z15pgWne7hPjOU4hSGS8Bvox5Wqe85mNX
 k9rDQHaYC3b53Lh9ouy/38PAHEJ3Ba8soT9WDgcoZ66HyNaSpxpsJQ==
X-Google-Smtp-Source: AGHT+IEO6eMdOhqoiUU/m4tGZ8/sAKQmJc3MDWv2HbPfQCNdZ/1JUI5QRdvga9dLybBWp8eSQoCTyw==
X-Received: by 2002:a05:6a00:2b4a:b0:725:4a1b:38ec with SMTP id
 d2e1a72fcca58-73e1355e97cmr4458996b3a.3.1745425306972; 
 Wed, 23 Apr 2025 09:21:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8bf5b9sm11205521b3a.19.2025.04.23.09.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:21:46 -0700 (PDT)
Message-ID: <0a6a63db-3191-4c17-8d7e-866bf3bddb5d@linaro.org>
Date: Wed, 23 Apr 2025 09:21:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 112/147] exec/cpu-all: remove this header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-113-richard.henderson@linaro.org>
 <53f9e6dc-8bcf-414d-8491-6c1c3d972962@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <53f9e6dc-8bcf-414d-8491-6c1c3d972962@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/23/25 04:02, Philippe Mathieu-Daudé wrote:
> On 22/4/25 21:27, Richard Henderson wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20250325045915.994760-16-pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/cpu-all.h  | 25 -------------------------
>>    include/hw/core/cpu.h   |  2 +-
>>    include/qemu/bswap.h    |  2 +-
>>    target/alpha/cpu.h      |  2 --
>>    target/arm/cpu.h        |  2 --
>>    target/avr/cpu.h        |  2 --
>>    target/hexagon/cpu.h    |  2 --
>>    target/hppa/cpu.h       |  2 --
>>    target/i386/cpu.h       |  1 -
>>    target/loongarch/cpu.h  |  2 --
>>    target/m68k/cpu.h       |  2 --
>>    target/microblaze/cpu.h |  2 --
>>    target/mips/cpu.h       |  2 --
>>    target/openrisc/cpu.h   |  2 --
>>    target/ppc/cpu.h        |  2 --
>>    target/riscv/cpu.h      |  2 --
>>    target/rx/cpu.h         |  2 --
>>    target/s390x/cpu.h      |  2 --
>>    target/sh4/cpu.h        |  2 --
>>    target/sparc/cpu.h      |  2 --
>>    target/tricore/cpu.h    |  2 --
>>    target/xtensa/cpu.h     |  2 --
>>    accel/tcg/cpu-exec.c    |  1 -
>>    hw/hyperv/hyperv.c      |  1 -
>>    semihosting/uaccess.c   |  1 -
>>    tcg/tcg-op-ldst.c       |  2 +-
>>    26 files changed, 3 insertions(+), 68 deletions(-)
>>    delete mode 100644 include/exec/cpu-all.h
> 
> 
>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>> index b915835bea..8782056ae4 100644
>> --- a/include/qemu/bswap.h
>> +++ b/include/qemu/bswap.h
>> @@ -206,7 +206,7 @@ CPU_CONVERT(le, 64, uint64_t)
>>     * (except for byte accesses, which have no endian infix).
>>     *
>>     * The target endian accessors are obviously only available to source
>> - * files which are built per-target; they are defined in cpu-all.h.
>> + * files which are built per-target; they are defined in system/memory.h.
> 
> IIUC in patch #2 "exec/tswap: implement {ld,st}.*_p as functions instead
> of macros" you moved them to "exec/tswap.h", not "system/memory.h".
> 

You're right, the comment does not make sense, especially that now we 
can include those in common file too (so they are not accessible only in 
per-target code). I just did a mass replace of cpu-all.

If someone is looking for where their implementation is, they can grep 
it or use their autocompletion to reach it.

@Richard, could you please remove those two comments line?

Thanks,
Pierrick

> Otherwise,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


