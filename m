Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F41D12D5B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 12:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQmR1-0005xH-UR; Wed, 03 Dec 2025 07:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQmR0-0005ws-6p
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:58:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQmQy-0001Nq-Ix
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 07:58:17 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so41634535e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 04:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764766694; x=1765371494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wUWYNa9SYVdjH+aqgfHqE81FatJotoRI+3Jq7RDZonI=;
 b=XXg0sdOfTSF9wFVAl6R/a3DVb6z05FN3t2+4kfO60sEzstP8rc4HHLaO5F9dpVjWwF
 s/p8BQIdEg9/jRUnyU3MjhsybuGceJMHggxtkd8NXyTPxUW+K8iLjpc0OvJ5gQohMlXs
 M5yRKfB6C3Hel+ulaImRZUz+5vEIxmjiM+FZZQKrHSSM7SWGyyyEMVR0ROjF/9+2Ku1/
 5KIomCsuOwwU/aO4BHcn1QmNNBgrKVW7K6OL99qbKGnG4QIAXi+lrIinRYJSVCXDGxam
 imFvA8GhGD3TGHteqdmhQABNoDBxbk6CBi2grvSzIsnL/9LPAkvZldS7kMWeZqhvIeVH
 tzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764766694; x=1765371494;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUWYNa9SYVdjH+aqgfHqE81FatJotoRI+3Jq7RDZonI=;
 b=BVLk0cjsNju6RI15K2eN3caKB2DQf3JxN4b/iEIF9UTHD7QEEmV7189GkFg9EHs4T1
 o8ysCiXXxKFVnxk8GvD+K30RaANpZSOA/ejDBoYTSxYh99pLG7N0L7Obpwf0S2Bz6w6I
 BCtWRUZRFRtqFLzeDVwJgXJqRcmkzu87YZ/ZdAMIqHWkX25DzjnxDRhGg7EX61YUAk5p
 cFccq9z6YdYZjKG3e8GYvWy3kpWDQspWokwpjZiHbDnLpjJoecGgYgc8zXFpT9n8Qh+a
 rWUMSjWm4AZxxXZuxBF5CTF/iNi2HB8a3K4neJ6x7DQtnkMoGY5BfiSPoTR3mXW8HxXj
 2Xmw==
X-Gm-Message-State: AOJu0YyHZD6XF4+fJFbR/knsMIFitXcmjhkpmZ4V9pWDd3o/Mga1sbbd
 zbWllvxT6xG9lyFx8CE9xDjdfvER/KT4rkPXXpAtbx53I5q64LMiJj9WNgOLPY0jSWSKGnHWu5f
 a+iBQ7Bs=
X-Gm-Gg: ASbGncuFpcSsekWkqVXoRvWfquGh3de3Z11767pRlZX/3Xl9+X/+v07wycmAZmMKAYi
 dpNd0Rt6z5TUcaEnHj2BFEEZSufpuw4GTCptZYF34AQmx7OMXG+z6kj1kzc0NIdAKHJlIpFqeU3
 zdqOM2njHeTDQtVv72uZ3P1xWelOHjJJQNh3JGzmZTVHIC42fZi6iPhOfIcAYFBzg4eitozDhwi
 FLePGlwhhD84ZbBNWDZ5lI4oSpscNsM0yrXLQTxj0DmsFW7UNt4Cwv5PFkyS6p3reXE+Olx/vw0
 uFVwxtLEwdfMxqyN2iDTfE1N8yqTJDtjVlzRdaZgWXfuSRGEdi2X/MpDObCz1E6nArsDgr6yY1W
 zT+We0jeZu7tKSk6iiNXNiAhvy5ESH5YtgJgbLxSxJQTQG1MJalE9A20BgLC61TtrKWHTG+TAAR
 Vaq5FN6dCHRxPHtz922Eq6Z7q8SsPhKHiV7C3ghBdgeHguc461gBGDjw==
X-Google-Smtp-Source: AGHT+IEl03cQ63doGU5OTasIBgMZok4MBY/4CwtGBrh1kUvwk+/S8/bZa0VK3yzB8FbFGK5OTN9a2g==
X-Received: by 2002:a05:600c:198a:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-4792af3f949mr22145465e9.26.1764766694376; 
 Wed, 03 Dec 2025 04:58:14 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b04e1c1sm15694285e9.5.2025.12.03.04.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 04:58:13 -0800 (PST)
Message-ID: <1f667be2-0b12-477d-a308-2e5b86c3fd5f@linaro.org>
Date: Wed, 3 Dec 2025 13:58:12 +0100
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
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
> 
> diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
> index ccce35902fb..5c654b63f56 100644
> --- a/tests/tcg/multiarch/gdbstub/catch-syscalls.py
> +++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
> @@ -22,7 +22,8 @@ def run_test():
>           gdb.execute("catch syscall pipe2 read")
>       except gdb.error as exc:
>           exc_str = str(exc)
> -        if "not supported on this architecture" in exc_str:
> +        if "not supported on this architecture" in exc_str \
> +                or if "Unknown syscall name 'pipe2'" in exc_str:

I just noticed I didn't commit a local change where I removed that
extraneous 'if' :/

>               print("SKIP: {}".format(exc_str))
>               return
>           raise


