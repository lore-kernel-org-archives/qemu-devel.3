Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8005D3B997
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT42V-0006rW-O3; Tue, 09 Dec 2025 15:10:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vT42P-0006p9-W9
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:10:22 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vT42O-00027I-1U
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:10:21 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-656de56ce7aso1950310eaf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765311017; x=1765915817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j05eipSotYjHxurEXn1ovuSgQ/l1I6HNQmnbjvpQGGc=;
 b=swuwhg9I0VI+YKf0M3UxNAauUo9l8va6TaO4xMSUQZ6gK+he245ss4VjCPGmWWIVw8
 a2WAKnflgwGdvJNUdulUOC7Z5m9CCSLhVULuW4SrUBipKBv9+LbTDkggNhFP7CkcC2lF
 XH3ctrWppR+iqTU47MuGt2z9UGw34oOtq0IsSCQ9+mC/isUY6Q1jdkNV6GhKIY9SgUBk
 mZvZU6E3L34qhFwJJ/fKv2eIYsgFa+weCvNXcLAWSNfVOqgSAQJbp6QMM7PljQI/SGUq
 mol4AH9s5uvvS5+D5CWjyLgW/2ux0A6dqSxHcdPRkxweUy+GouyBoz5+r0JCW0CAwwAY
 lNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765311017; x=1765915817;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j05eipSotYjHxurEXn1ovuSgQ/l1I6HNQmnbjvpQGGc=;
 b=I2utduYTZSMPgnqsiU3WBlokhPU7Z0IzzM0CK/HYlz8Mb5WmPUnoANQEf83TA70+cO
 eaQtybHU1xIjIttl5XG5HFT29WMFgLZsyVE0Vs7th6WWnbZJQNoWeB4Q/5r1P+jEmebo
 53gWW1A2g/JKOhUq2olzGXixqYlTm6hlhrYv92Hxx/cjEptDfSHraEJlDFh7MOgsFE7N
 BgEzYVA0Qq82WduQQATMhK87lTwR0o/O7CIBoPflvPJLD699TtTv2Q/X3N2w7k40og9t
 X0xSx2IWitxbwVZYRKzj4XYMMUuoWyB9G/GHyTslpAUBkyDFxvIBwv7mnWtyWn7M2vCg
 2xrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDa+f4WUIOQY4G+A9miDhPIbuzvveKIjOv4xwertmGFu306CUCdmriWhrMYP1B2BpOHEqVkC2PFbfx@nongnu.org
X-Gm-Message-State: AOJu0Yz+tsVyr8R4skZs+Sfiajr33dNjjcBGZyqnNk+bbaYAy1jla07O
 LWfYtwjiV9epxQUevWM9qGHQvtGTJQxGZD6F0JZ7gE1bkj7nEEn2v3m96ZVHrrRdFDcqLnFUVlW
 /wAO93ic=
X-Gm-Gg: ASbGnctCheuje733smHbR1/iSmRYZMDV3xUcbFyMiOKdxmo8ueHctzAiEzLAskILwdK
 AbMHESrW82iLeUUcaG8gxLonEMCAlb4g8Ye6Qh0eGL0YUWmY2zbxlsAY5fxsQKvpR89X0w/OcV4
 3jBRGvHEX+1IkPLvbwjss4wAdRJeKJld6YHc7lTaU79NZFohExQ3hs1V+PAh8inhH+dG8zinavd
 65Y5dt5HDP0KBmfK40w+s6ZAkli60u6O3JJ1mOO8iy/CqEy8EyyNeKxwfNWKwAb8rzwkc1Cll4s
 rVkcrfqLHvMGdpIS2e79sOjgZbq+JDvZhYpqqELH2Ei1+ncPcAMDmICEkOcOYvYh/oWHVU+ZxFz
 +4xQK40Ji839qVraPHhPC4ZaTSboXpBOPiL1qm23BPcEWHBrgZ2+NqgkMXduVKNqdojmD6FOx02
 4/DF4XQ0ylJmezt+0FID0bFMCx+kOq3dSUSn6mC1saXAyGuB5A3Tw=
X-Google-Smtp-Source: AGHT+IFVjep0ck64+61rnGd7zelMnmOUrwLmnGdeAr5h0wNINIazhgs9LEmhRR1TaSSCxu4BjZIB9A==
X-Received: by 2002:a05:6820:188e:b0:657:56ba:7455 with SMTP id
 006d021491bc7-65b2abb3939mr73495eaf.1.1765311017287; 
 Tue, 09 Dec 2025 12:10:17 -0800 (PST)
Received: from [10.152.62.227] ([172.58.182.152])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef0ca05sm8084585eaf.11.2025.12.09.12.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 12:10:16 -0800 (PST)
Message-ID: <dd11ee38-13dd-4626-9a84-aff23bfdf365@linaro.org>
Date: Tue, 9 Dec 2025 14:10:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.2? v2] tests/tcg: Skip syscall catchpoint test
 if pipe2() syscall not available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20251203143755.65535-1-philmd@linaro.org>
 <eee34d92-3c8d-4ae9-93fc-66bff89d279f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <eee34d92-3c8d-4ae9-93fc-66bff89d279f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 12/9/25 13:26, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 3/12/25 15:37, Philippe Mathieu-Daudé wrote:
>> Avoid the following errors testing i386 and ppc64:
>>
>>    $ make check-tcg
>>    ...
>>      TEST    hitting a syscall catchpoint on i386
>>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access 
>> files locally instead.
>>    Traceback (most recent call last):
>>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>>        main(run_test)
>>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>>        test()
>>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>>        gdb.execute("catch syscall pipe2 read")
>>    gdb.error: Unknown syscall name 'pipe2'.
>>    qemu-i386: QEMU: Terminated via GDBstub
>>    ...
>>      TEST    hitting a syscall catchpoint on ppc64
>>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access 
>> files locally instead.
>>    Traceback (most recent call last):
>>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>>        main(run_test)
>>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>>        test()
>>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>>        gdb.execute("catch syscall pipe2 read")
>>    gdb.error: Unknown syscall name 'pipe2'.
>>    qemu-ppc64: QEMU: Terminated via GDBstub
>>    ...
>>      TEST    hitting a syscall catchpoint on ppc64le
>>    warning: File transfers from remote targets can be slow. Use "set sysroot" to access 
>> files locally instead.
>>    Traceback (most recent call last):
>>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 53, in <module>
>>        main(run_test)
>>      File "tests/guest-debug/test_gdbstub.py", line 53, in main
>>        test()
>>      File "tests/tcg/multiarch/gdbstub/catch-syscalls.py", line 22, in run_test
>>        gdb.execute("catch syscall pipe2 read")
>>    gdb.error: Unknown syscall name 'pipe2'.
>>    qemu-ppc64le: QEMU: Terminated via GDBstub
>>    make: Target 'check-tcg' not remade because of errors.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> RFC because I have no clue whether SYS_pipe2 should be present
>>      on these targets, I just want the CI to pass full green.
>>
>> v2: Drop extraneous 'if'
>> ---
>>   tests/tcg/multiarch/gdbstub/catch-syscalls.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/tcg/multiarch/gdbstub/catch-syscalls.py b/tests/tcg/multiarch/ 
>> gdbstub/catch-syscalls.py
>> index ccce35902fb..79c8d532d1f 100644
>> --- a/tests/tcg/multiarch/gdbstub/catch-syscalls.py
>> +++ b/tests/tcg/multiarch/gdbstub/catch-syscalls.py
>> @@ -22,7 +22,8 @@ def run_test():
>>           gdb.execute("catch syscall pipe2 read")
>>       except gdb.error as exc:
>>           exc_str = str(exc)
>> -        if "not supported on this architecture" in exc_str:
>> +        if "not supported on this architecture" in exc_str \
>> +                or "Unknown syscall name 'pipe2'" in exc_str:
>>               print("SKIP: {}".format(exc_str))
>>               return
>>           raise
> 
> 

Seems reasonable.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
s

