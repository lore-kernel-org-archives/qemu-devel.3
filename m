Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F1D103E301
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0dRp-0004jC-IM; Thu, 12 Mar 2026 06:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0dRn-0004it-Oq
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:39:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0dRk-0003Fg-U5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:39:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439c9bdc1eeso739832f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773311955; x=1773916755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zeI1EQgnZi27sY58fRreneSlNsPc5OgibL18nohxgXA=;
 b=dtpB/twFtVLrhwGgUZSvrxc5EVJ8RHBJwe0vS+kzVTAUyyb2fXle+4KdM9gPur6ob0
 Try/wY9dqQZOWd8Z8cHyGE9Y92cXqT0Vgm5VNHYNNCt3MFZh8D7UCBRzqyouURDEeIg1
 Jgm+xSN3pg8aSa1cqYYB0SMLaXJvJiRDgHSwThmlLZU2S6TFJEb08OrfUdergD1zo6Ut
 UCb9vwbB06q+TeX0fv+Ubbi3vFnhN2eXfwY3Wn3dUHok7maNZS5C/2c3fjE4hTR1EG3z
 GAzcCUoB890MLD3QJGjMZ5Ip2ZTtPPQHkb2pV0PMD1LiN72n94gi6txPsTwuZpB0ZrST
 fwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773311955; x=1773916755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zeI1EQgnZi27sY58fRreneSlNsPc5OgibL18nohxgXA=;
 b=sRkRic1fLdfdYURxpb51AA4YSR8shO0IWHfNBFVxKo7S8InQfz17OWTe+wxyppH5hW
 GT+ax4LTej/3+FMp5q+Is6/Py3Ru2IyCMflsKQ9xx3qs/KzYxmEjcw9IBU9jYFqAQ5/k
 58lc91DKOrmKYp5NkzmNwAiulirQoxTf16apLx8VelS/oY33uPXSRk74HLHci7OuXoTY
 RVA5DLJSKxAiC/5iI+EFUnNb8p/4wG6nlWq0Ca2ftsCBjmRwseg+Vq+daWm7vMY++NXq
 tMFvts9+Sxq2q+Z8DFkPTneYJ5m2eo6GbOxkCd6qE2aa3ImLsZsy4XCGLVWjGmrOOZuD
 QfFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkTvzlguYvf7oJF0xhNCGRApI8tdsmaUP13RrS7NweiPF1ljqZCXhvJIkuCg8SmXPw9WMqiaEa2DVw@nongnu.org
X-Gm-Message-State: AOJu0YwxqaOm0+m0FJiTo7+36T1S1inUuPv2tIi98o/gE5Cin9p5wLhm
 2Yi/7/MUSXLukkuWgIWqMyIEEaZgnV7h4vvdodPUa/J53b2Wzhz6Bk+UWvDqcB7wBn0=
X-Gm-Gg: ATEYQzwYJjMSdgP1/vbes/VnHXPOsX20u8M+wQWLL6vLnA9ELq9jsx6wAfdtr53e7iy
 KhQx5W82LZnl/JHpffKwl1Y+7CzG51Fx467AxfNAk4nt7eUSzkf0m/x5hb4OEUBXQG4PH1Tvm+M
 qmYhFJY9nqlfTndz9KupiuXYTQdKctNhjBslbExLNiEgxYpqtY7mgPgbmlY1KJk6d0woHb22D51
 mTXpv3hvTAwuu5t1eS4kITnTQiQ5S4TugLaRTvnkvYHPE5yavIA2AoHWhNgRU1QFCyWwZv28L8r
 fQLkQVpYkLEBhYKvU8YoY5Qu4i4EXEzd3d/sd5Whjh+0c37Jv8AcUIF+OCS7+sIjb+q2KKet+MA
 sYAMpm/FQUuNyv3XsFTU4PtsrJAKxIs6m6Q2gsTgmIdTHKk3wJ3lbxCu7D9MhAtq6Xj+BMgeg1i
 7yOb0ARlhLF85JwNHvuqZwN3T9ksVhUZm2vomuIy7k9wtpw9SV4KAikCuD3KdM+h1oDw==
X-Received: by 2002:a05:6000:1a89:b0:439:b7a4:9188 with SMTP id
 ffacd0b85a97d-439f843b563mr9890742f8f.52.1773311955069; 
 Thu, 12 Mar 2026 03:39:15 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm7887204f8f.7.2026.03.12.03.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 03:39:14 -0700 (PDT)
Message-ID: <1493fdd5-5254-4398-bb69-8c83eee8bef2@linaro.org>
Date: Thu, 12 Mar 2026 11:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/docker: add gdb-multiarch to all-test-cross
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-2-alex.bennee@linaro.org>
 <78c8b024-6dd5-4f1b-a19c-c7a71c7acc9f@linaro.org>
 <7e6cdb4b-4cb8-4968-acce-56db2f0ee307@linaro.org>
 <97506340-18a4-4691-8017-110ab2fc76b8@linaro.org>
 <3c2bf09d-245c-4de7-b55d-37085ef24545@linaro.org>
 <c776bbc1-6021-45d0-a5ca-74e50d906f4f@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c776bbc1-6021-45d0-a5ca-74e50d906f4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/3/26 11:11, Ilya Leoshkevich wrote:
> 
> On 3/11/26 00:28, Philippe Mathieu-Daudé wrote:
>> On 11/3/26 00:22, Pierrick Bouvier wrote:
>>> On 3/10/26 4:07 PM, Philippe Mathieu-Daudé wrote:
>>>> On 10/3/26 23:33, Philippe Mathieu-Daudé wrote:
>>>>> On 6/3/26 17:17, Alex Bennée wrote:
>>>>>> This allows the gdb integration tests to be run as well.
>>>>>>
>>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>> ---
>>>>>>    tests/docker/dockerfiles/debian-all-test-cross.docker | 1 +
>>>>>>    tests/lcitool/refresh                                 | 1 +
>>>>>>    2 files changed, 2 insertions(+)
>>>>>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>> I'm getting:
>>>>
>>>> Python Exception <class 'gdb.MemoryError'>: Cannot access memory at
>>>> address 0x45001fff
>>>> Error occurred in Python: Cannot access memory at address 0x45001fff
>>>> qemu-hppa: QEMU: Terminated via GDBstub
>>>> make[1]: ***
>>>> [/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121:
>>>> run-gdbstub-prot-none] Error 1
>>>> make[1]: *** Waiting for unfinished jobs....
>>>> qemu-hppa: QEMU: Terminated via GDBstub
>>>> warning: Could not load shared library symbols for linux-vdso32.so.1.
>>>> Do you need "set solib-search-path" or "set sysroot"?
>>>> make: *** [/builds/philmd/qemu/tests/Makefile.include:66:
>>>> run-tcg-tests-hppa-linux-user] Error 2
>>>>
>>>
>>> To add more information, we tested it on GitHub, our machines and 
>>> GitLab, and for an unknown reason, it only fails on GitLab runners.
>>
>> Also we tested on our local Linux machines, where this test pass
>> for all our targets ;)
>>
>>>
>>> Which is unfortunate since it is where QEMU run its CI.
>>>
>>> Regards,
>>> Pierrick
>>
> FWIW it passes on my laptop as well.
> 
> Does this test fail only for hppa, or for other architectures as well?

Have a look at these job failures:
https://gitlab.com/philmd/qemu/-/pipelines/2376819801

Python Exception <class 'gdb.MemoryError'>: Cannot access memory at 
address 0x7e085b4b1fff
Error occurred in Python: Cannot access memory at address 0x7e085b4b1fff
qemu-aarch64: QEMU: Terminated via GDBstub
make[1]: *** 
[/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121: 
run-gdbstub-prot-none] Error 1
make: *** [/builds/philmd/qemu/tests/Makefile.include:66: 
run-tcg-tests-aarch64-linux-user] Error 2

Python Exception <class 'gdb.MemoryError'>: Cannot access memory at 
address 0x40802fff
Error occurred in Python: Cannot access memory at address 0x40802fff
qemu-arm: QEMU: Terminated via GDBstub
make[1]: *** 
[/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121: 
run-gdbstub-prot-none] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [/builds/philmd/qemu/tests/Makefile.include:66: 
run-tcg-tests-arm-linux-user] Error 2

Python Exception <class 'gdb.MemoryError'>: Cannot access memory at 
address 0x45001fff
Error occurred in Python: Cannot access memory at address 0x45001fff
qemu-hppa: QEMU: Terminated via GDBstub
make[1]: *** 
[/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121: 
run-gdbstub-prot-none] Error 1
make[1]: *** Waiting for unfinished jobs....
qemu-hppa: QEMU: Terminated via GDBstub
make: *** [/builds/philmd/qemu/tests/Makefile.include:66: 
run-tcg-tests-hppa-linux-user] Error 2

Python Exception <class 'gdb.MemoryError'>: Cannot access memory at 
address 0x7d742025efff
Error occurred in Python: Cannot access memory at address 0x7d742025efff
qemu-alpha: QEMU: Terminated via GDBstub
make[1]: *** 
[/builds/philmd/qemu/tests/tcg/multiarch/Makefile.target:121: 
run-gdbstub-prot-none] Error 1
make: *** [/builds/philmd/qemu/tests/Makefile.include:66: 
run-tcg-tests-alpha-linux-user] Error 2

So at least Alpha / ARM / Aarch64 / HPPA.

(I haven't checked whether the test is run for other targets).

We also run these on GitHub runners where the tests pass, and apparently
when running on k8s private runner on GitLab they also pass. The problem
is with public runner on GitLab.

> I'm asking because it may have something to do with /proc/self/mem or 
> with the architecture.
> 


