Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C2AC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9Nd-0000rf-Mg; Sat, 21 Jun 2025 21:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9Nc-0000r9-01
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:20:20 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9Na-0006bK-Er
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:20:19 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748d982e92cso1918200b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555217; x=1751160017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dFK/lzs0VBop3YuZvRTWCSzwH6R/w0p86fXeE5vgjv8=;
 b=me+bCVCVDZSJdLn1Tk3zP+bzH0u4oGh5z0wi59azOKVoqTpIZa3HY0bALIoAjiOggK
 fqDvOcXDmGDEn/peD7N7CJCF7042EJwoPTPeCCU70FY/rID1W3SOVVIDJxigOf4csPJL
 CMd7pjaw1BT8QdnRfH/l5MXhfHWiGFgKYovlfF1he0b09TXghjUUm/uMPk1G7+3ginU8
 x3LLKhXtFXJWaYWkxXcSCvQbYVbqDIJSrr5Q5j3TWdObsz1aw6XGvs1mTbvC5lO5W4rw
 S5Zc5U3sGAdFV0YZ710qRW3Y5+hRCm0ZulDIcKa20CIyN6dnHURwPgZMyof5axqWs/J9
 SztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555217; x=1751160017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFK/lzs0VBop3YuZvRTWCSzwH6R/w0p86fXeE5vgjv8=;
 b=r0HFwvYI2gn7/oX3Suf7ADV8I83rEd5Fa8kL9HBCEp5tKVLxXyolz/i0tREFsaE9AG
 SqX5tQ4QG72oUCGvGX+DoIwX48OfOqZu/akbQBizdYG1YpmqFntl891XSpJjkW8D7aVP
 BEccadEJ4rOZBqqWh4FlTtsNEyJD3C0r4xEzFYAhunxevF/o3eA1tL3B92Qg/mKbGR2v
 EJi6I/Fm9MROa6ezhW4qYSD35j31LIMjTuE2cu+AZ265WE9R0wwIvFiNo8csMGmdxMs4
 1QsqKtFV9EPt0v3j/Fadv4+5gLvoCrqvHTOgEMmMnpfnBdxnTjtOo/bq1sn92DtUVkR+
 uyug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYLA7V0NR643YU0H60OfnAPsj2IPu1HFcNpt1V1MyxFvnnZ88UbbV/YWXtqDDo/tFYgkNAD81X3/Nn@nongnu.org
X-Gm-Message-State: AOJu0YzjvZ41eBp0IekdDPWWhp7ToaeggqhCHcxEaUzKxWCInNIh9QC6
 xV4hrpOw4CGR1mNjikYTdAzuvNiGxYg5kN6gTV0sNBqRKAbur+OvwNBeHsi1UKqs0QfMB/W26ZG
 MOeEBoIA=
X-Gm-Gg: ASbGncv9TN3sQU82LZ5fnI8EjYHGiN2JvD30lEKi6cmT+NGt4WpGZubGVRAJdmvFX9h
 vp1ygmunTaiWJKi9JDhu8aynbM9F+CloVYComEzV/tdkJehfp8LeEiuqglf7oIS+nSj7L6xQzob
 giWGf8mEY0OK6gbW3LY4LvBiZn6wljjZlSf5qUwO6XYKtPRfWwRufmBYkjrezgIMNmgiFCzKXUQ
 kbhR4PRgP4z1AhTVF/kxsk6LfHz4BVjnWhIb4dU35tJeg0tjw9vq+jjmUKDltlrmGxUJbN4D/As
 O5iTI8ydq8uhlg7IOqcI/FYDYmvDqNRCy2kZhBxadPBINWqo58g2WcBlv/3rVreM5Rs2Z5tuqFz
 C+dMd6AnEjEw2jxIy5coKDHIBHmBc
X-Google-Smtp-Source: AGHT+IGx6CziI0XVsdcix7n3BCPURbCPCoLTBPKceqOMfN9RAdWnqChFUw79M+cUpq8uOQ+NYtYgfg==
X-Received: by 2002:a05:6a21:998a:b0:218:75de:d924 with SMTP id
 adf61e73a8af0-22026d727demr11328568637.19.1750555216849; 
 Sat, 21 Jun 2025 18:20:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584eesm3873889a12.58.2025.06.21.18.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:20:16 -0700 (PDT)
Message-ID: <10c2b02b-2257-4171-af34-d9e7fc047706@linaro.org>
Date: Sat, 21 Jun 2025 18:20:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/48] accel: Move supports_guest_debug()
 declaration to AccelClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> AccelOpsClass is for methods dealing with vCPUs.
> When only dealing with AccelState, AccelClass is sufficient.
> 
> In order to have AccelClass methods instrospect their state,
> we need to pass AccelState by argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h       | 1 +
>   include/system/accel-ops.h | 1 -
>   include/system/hvf.h       | 2 +-
>   accel/hvf/hvf-accel-ops.c  | 2 +-
>   accel/tcg/tcg-accel-ops.c  | 6 ------
>   accel/tcg/tcg-all.c        | 6 ++++++
>   gdbstub/system.c           | 7 ++++---
>   target/arm/hvf/hvf.c       | 2 +-
>   target/i386/hvf/hvf.c      | 2 +-
>   9 files changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

