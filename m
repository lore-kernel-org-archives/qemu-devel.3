Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A131D1266D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQia8-0004v3-WB; Wed, 03 Dec 2025 03:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQia4-0004ud-IF
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:51:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQia2-0003iu-UT
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:51:24 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42e2d44c727so1777856f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 00:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764751880; x=1765356680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+KOuTArHrH3TSVaiu7Nfp9Vmwdn9GEDudyjQq0VY6LA=;
 b=Hat3EuNdyJYzwE1e8WTrwzYYV4hsF8LU0nQkN8n2xqLZuFddzG24tmZOOoRyaJCbxi
 1A3ry/7VWYwsfxIbry/stAqdbeh0SrbOBgHI8Nc7pv1g4m14CCKN2gna/R79KjPT7+9M
 YHE2D1ZmTzlZyhLLegXpd5mXETOYVBZCCEfIIrPUxJ71PNj9+ouX1HSPUvTZoEYahs7J
 lu10yKVUMg9RP5FYq8PkES8w0ZfN/PuSYs7p79Y3oRmA7MXR/FDGJSTZanKLqx5Oe8td
 LJU9priCXXDKgsXIVCizRib7EnuJ0Vcg/rGn6RbwTHhe3mi7kqElTJqzgx8RvIOUusoA
 lmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764751880; x=1765356680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KOuTArHrH3TSVaiu7Nfp9Vmwdn9GEDudyjQq0VY6LA=;
 b=bYUe5PNzi/pephsb1K7gHWkX2JyRfmjhJqjhwNgb+OqO1r5qcaErSpQnF4Mgc0CTuE
 FQ0Vtq9AvlJSXFv4N95oMkqU/7/v6dqve44uAuSr4yhJfHj2tLeLSY2nBFn8zKWdskZ3
 BOWUGEXjhvSJw8GpKOQDoVGHjObVXLzZDKJyfjog0JYPBEDuPFH/63WGotEvr0evMEOf
 WZla1N8cMgT3Gh2VWxIZGcrhhmRrbNAAw1Zwt4Y06hsinqfl3zbukSqKraOAbexghXMa
 MKFOH4CgLOnKyv4mQT6wtMjXQh5mNwMKN8LbdgsHsAN1TvT4nRF0sLAlC1QOw95EAqmz
 v9tw==
X-Gm-Message-State: AOJu0YyXWbqm4Hqmr3NmRsH5jBlHQy1L+XwIps6JlBFXNJw5Y5vGKmZh
 i35nJNQnBzAnnqbGDR+2XenEvveEej2AlDxurqnPjkvuvlf0pj+GK3r+moM+ZRd603OVQcB/aWd
 3z9jt0bs=
X-Gm-Gg: ASbGncvb16dvLK7/ShHmwPeCX4LbcHCSS4KHPLdkPdQG4OyE6CJjTCn/AI05ZCiybIp
 ovBaj3Gj98f72QQIPXrj7inD6gyAx4LyikWZ5ETNDzjEQ8OI2OBe6BUy5cHzmQt5K/EBl8B+q9g
 5CKsdtnhuZoXYpiIpXnzjYQgDD5JwAIYFMfDk+MSQ8LFlJ0vM9LnsXS1JzXeAvr47TwUCwRVoD8
 BvC+sMlkYjJt1AXh/c9u1qFbjKcAYoNBk65hK1+pIqzw6dFqCp1v6mpuc4YwUoB/V+q7/c60zWq
 WjYxqDb7D5A60+92Ylegqkg1XwS/tU1uXttx7oPT6wnYhr1Ow+rnNv1K4NhIo3bRBZ97bPbmmUZ
 xbl/mNUeLMP9YYX5Y2im/vlM5dIfuz9J19dC8hP3CePnZfgPj1WPeKSRhtJe+aHoO8kcN81AM7a
 E5uDmOkqx5ato45nsJFIfNBWf6nCvd9yDXJ7SjYBHKueZPRqrqePvTQQ==
X-Google-Smtp-Source: AGHT+IEJC+LjDHS0ddmnS7WCscTh+KwWlFHjX6dsF++rVnSon3QtoBHiFhbHk6dgJayBcxbIAomtJg==
X-Received: by 2002:a05:6000:430d:b0:42b:3ee9:4773 with SMTP id
 ffacd0b85a97d-42f7318fd33mr1338679f8f.7.1764751880236; 
 Wed, 03 Dec 2025 00:51:20 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6049sm39673094f8f.10.2025.12.03.00.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 00:51:19 -0800 (PST)
Message-ID: <f4d2bdbf-fd6d-4391-a909-37c69007eb38@linaro.org>
Date: Wed, 3 Dec 2025 09:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.2?] tests/tcg: Skip syscall catchpoint test if
 pipe2() syscall not available
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20251203084743.60753-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203084743.60753-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 3/12/25 09:47, Philippe Mathieu-Daudé wrote:
> Avoid the following errors testing i386 and ppc64:
> 
>    $ make check-tcg
>    ...
>      TEST    hitting a syscall catchpoint on i386
>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
>    Traceback (most recent call last):
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>        main(run_test)
>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>        test()
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>        gdb.execute("catch syscall pipe2 read")
>    gdb.error: Unknown syscall name 'pipe2'.
>    qemu-i386: QEMU: Terminated via GDBstub
>    ...
>      TEST    hitting a syscall catchpoint on ppc64
>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
>    Traceback (most recent call last):
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>        main(run_test)
>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>        test()
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>        gdb.execute("catch syscall pipe2 read")
>    gdb.error: Unknown syscall name 'pipe2'.
>    qemu-ppc64: QEMU: Terminated via GDBstub
>    ...
>      TEST    hitting a syscall catchpoint on ppc64le
>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access files locally instead.
>    Traceback (most recent call last):
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>        main(run_test)
>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>        test()
>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>        gdb.execute("catch syscall pipe2 read")
>    gdb.error: Unknown syscall name 'pipe2'.
>    qemu-ppc64le: QEMU: Terminated via GDBstub
>    make: Target 'check-tcg' not remade because of errors.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/tcg/multiarch/gdbstub/catch-syscalls.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

(RFC because I have no clue whether SYS_pipe2 should be present
  on these targets, I just want the CI to pass full green).

