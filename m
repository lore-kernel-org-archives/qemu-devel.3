Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05464104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6jr-0003UP-Tr; Fri, 27 Feb 2026 17:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6jq-0003Tk-2q
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:55:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6jo-0004nu-EX
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:55:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso18397065e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232910; x=1772837710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0a5uP1894ry7yEA9gjp1wYvDF4YFdOKcuKXZ+yEAaM=;
 b=HY/+Xd3o7GtxKVX5+0Msxr+DoU053xakQ5pXT6DMoAcisi3CxDUDH6zQg42GilPWLC
 0O7NbtkzMwACp5r82mHRTz9lJvzyzlu2YszJWNuQ/gCs8uEAOxBnBV3Br2M79eHD4Kuq
 QR9M1Pa+uWsF9ShrJ86+sEz6dF7ElAgM4hn9G/ZTDlZmtAZ3cJxp3I/F4Tyf+nTNrYu2
 ceAgR0UhCaTI77+u2AO4c5mOcOT4IKFmBRN/SygoS8G0/VvmjF2L84nJgALq1SgwM7zT
 EK/7vo8jgQJS8Vr7TsQhjB9wl2x8YGEy9mojIuR0kW9KtiFqm2OvwpDA3eDEQ8WaWc+D
 hQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232910; x=1772837710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0a5uP1894ry7yEA9gjp1wYvDF4YFdOKcuKXZ+yEAaM=;
 b=mLWZjh8M7U2dmtdDnPaFVcxBdYehOSMmRHaBfZqNNoNjmdkxwFTc7XXEQ7L6ubcpG7
 2CXRTCr76dDsncDNLF+uPRCD+bk9hL29TMQ+ITMsmPCHIj3sxQVl7scQzGsYKqJSiaaP
 1JrQUQRvjrOPYcvqv0D72gF+wzLggNLNaBpqhi2FKGJR4hJZ0Rc6Pi7095Jh5FiP4Xss
 jAx2lgcwz7Kq6dKWp/GYNTYpQfW4YCZAMlCdoxRcJU84uxvt38xibQGE35xDt0oJGDH2
 oq6ZPuGXtgN74B7IZEQynpqqgKb2P7b/R+c58aIPt5aB8DvmWr8wNp52GlwaZXSmEdES
 FLPg==
X-Gm-Message-State: AOJu0YwlyIfdiQosBoUQv+Q1F/L7hKymD85VjV36Du+b50ANII/LZKgW
 dgUfKrraMTrgaN9vHeXkc9REAdwkUNozngzbr6lC1I/mSeX3Ty4J3hot94m89gbFkOE=
X-Gm-Gg: ATEYQzyS5x+Flks8Itpziv150rLBaRtncSBinyJ+CpIsLgjkn7qaAQ02IoLKXHlmqvY
 BOxknpqYUEufackvsfwo5VdwFC1qxTHCYDG8T4PqzwzeU7iK5aDQ9R6qeMCAsSmA0KZxv14Lbmo
 Vuzro7stltheDSqUgAHZIf7sIm8oF8Zu+7jSpMzOezQSXuAgPsnVh8vN37P35zZ8v4A2BM9v7Ry
 cVU5qSbT7lCWmLItBTggGCjaie/micGxzI4ir68LZsPyYWTvfLE++jrOBkchBlA45b97vdtiiFR
 b6OSAeQGo1uGwKu1bwcW7Se3J3iLcPK4F+x7ty19UMZto+k929RXSynQ5soI64aRZhNv6NBO4C3
 bn8Fh0FsnuolidX8J+enUwRm1B+56B0qeU6Q5WB4O+uHyk/GNg7UKv4/mGOnRR5IkVM3ErO0Swa
 3f4N9LFLqfKiywDFy8qTps1yko1pwz+NlneMFK4IbVPY4d8au/YZrt8A5q8Nj7g3V2UZoYwzvAD
 81C
X-Received: by 2002:a05:6000:2482:b0:439:852f:c9e0 with SMTP id
 ffacd0b85a97d-4399de21f73mr7568733f8f.47.1772232910598; 
 Fri, 27 Feb 2026 14:55:10 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c7657c7sm10448194f8f.28.2026.02.27.14.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:55:09 -0800 (PST)
Message-ID: <57469b5c-4bc0-4884-b682-0a953c7ca695@linaro.org>
Date: Fri, 27 Feb 2026 23:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] linux-user/riscv: Disable vDSO for big-endian
 targets
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-12-djordje.todorovic@htecgroup.com>
 <CAKmqyKO=aQUWZG_DqvCgKYnME6UGVWn6Cyr6z8v1OJ=d84f6ig@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKO=aQUWZG_DqvCgKYnME6UGVWn6Cyr6z8v1OJ=d84f6ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/2/26 00:33, Alistair Francis wrote:
> On Wed, Feb 25, 2026 at 8:20 PM Djordje Todorovic
> <Djordje.Todorovic@htecgroup.com> wrote:
>>
> 
> Why?

I suppose we need to rename linux-user/riscv/vdso-32.so
-> linux-user/riscv/vdso-32le.so and build / commit the
vdso-32be.so equivalent. Similarly for 64-bit.

> 
> Alistair
> 
>> From: djtodoro <djordje.todorovic@htecgroup.com>
>>
>> ---
>>   linux-user/riscv/target_elf.h | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
>> index dbbfdf54d3..6f416ac3e2 100644
>> --- a/linux-user/riscv/target_elf.h
>> +++ b/linux-user/riscv/target_elf.h
>> @@ -12,10 +12,16 @@
>>
>>   #ifdef TARGET_RISCV32
>>   #define ELF_CLASS               ELFCLASS32
>> -#define VDSO_HEADER             "vdso-32.c.inc"
>>   #else
>>   #define ELF_CLASS               ELFCLASS64
>> -#define VDSO_HEADER             "vdso-64.c.inc"
>> +#endif
>> +
>> +#if !TARGET_BIG_ENDIAN
>> +# ifdef TARGET_RISCV32
>> +#  define VDSO_HEADER            "vdso-32.c.inc"
>> +# else
>> +#  define VDSO_HEADER            "vdso-64.c.inc"
>> +# endif
>>   #endif
>>
>>   #define HAVE_ELF_HWCAP          1
>> --
>> 2.34.1


