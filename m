Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4494FC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 21:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkrTL-0002SB-Pz; Wed, 19 Feb 2025 16:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrTJ-0002Ro-QQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:19:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkrTF-0001F6-DY
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 16:19:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f31f7731fso122164f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739999942; x=1740604742; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MTZyFvk/MmhyFwdgEoEznPgS5WzX+XFPCOWMNG95xdI=;
 b=AmwCZiMix8OQvdnbyqXbRo0jPXQ/Ic9F/K8wO+6IRHqPGJle0oJl/Dsx5ATSEvvDYX
 sRFGA1ZOM0oYbvrPEdpKwz2gPBCYS5FqG8ly8/bE6+1H711Q+MuylTEk01nx6KfO5fMD
 46y/GoQbFXCWqI0BuYDADnVNhyKkylcP8ezxkvBd33ONF4mErIlCSzf5KEwfkHcGz0bP
 /oky/NZTheZisKhstMW/M4+EVzTAC4XRiDRnQPcous/Ms6zhuaMlT+kfAsLKMsB7jTTV
 h0stUCo3agiG1ScDc0X+3lLUhAAdT7tRyogpgrQimDPiIaED9M8ohDvVUTI7RpKKUFom
 Zebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739999942; x=1740604742;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MTZyFvk/MmhyFwdgEoEznPgS5WzX+XFPCOWMNG95xdI=;
 b=kY1aHWM0z9FCdPfZPyfUAr8Dgh0RGcLjeyoBI9xNXRGcXPbFqRm8Mudh2FH5fwWDr6
 LLpR8+xomXGmhX+PND88babpTSJSY+t0IslZFHHT0NGT0ad8sAWlMZsiQw9ipnr4HySB
 n+2tZAZMDiP3FsWMTO1qYGwdXl+6n/IsDmH/UFD+b1nT702jJv5ygh7RL2DPCHa9IwDn
 w1EyDKqfaunV932+utytJ7m5S0d+ExtVYAljibz+P/WqjPwtMejzWtvM3De4fg10QcRn
 qy0/XVJcT6za/bh36tXdM34EFhtaqXL5XiD0AetVbUPNe8cJ7ERyaIaSJZWiDMKHAAiC
 7VhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDw/0cwOTn66LqLrm4FpUCGRv6pbcdYuokLtortue3Erceb+qfpbSVWis39EB5mhm9MhgVdyNQfNyg@nongnu.org
X-Gm-Message-State: AOJu0YzLfpFJrLuqAh1MB/wJAdfehHOGPbfYeiYAWbx8RdVu3Aftsrux
 P93rEuZSnK8h3dvMTL3thQkqmfg8bJ4H8Plv9dcOxEJBMZqGDKaWQcnTD14fzKw=
X-Gm-Gg: ASbGncsdD1w6Cvw/0RdjPOteMyxbgytsX9RvrKyIdJSDABhgK7rlPKRliCUXlQAuP7+
 qSUjbjwVUfmH+mpE5O3BVObVgVhNcQKqNi9aLA1LQFl3uuXb6A9r1kjc0DJWeiFsEoE4sSwC5cY
 n5EFjNpO8zCv1e6zk5+rtdguwFUYn3/XSeXHl4v4FZqols6zVNja3AGbkMnAicLIX+46ZIPSrKX
 MK0u509CIJrTgY1jJqIOO0W8Lg+mhTnbrtLSV7orNmGv83TZc7LIqZOlF0FAkSd6Qb/FAoy0HOy
 ouzuboaPjd70RQo4xn2ZPeLA8db0eEW1NcwcIFZPBT0QUXozsYKEjLEzFFs=
X-Google-Smtp-Source: AGHT+IEp+BHW6dhJDTYdo7QYSjQEfwq6CmOglAITLDrPINq1NazK28A+2DChye55DeE0YqvITrZNgg==
X-Received: by 2002:a05:6000:178a:b0:38d:d8fb:e90f with SMTP id
 ffacd0b85a97d-38f58795868mr4682886f8f.24.1739999942536; 
 Wed, 19 Feb 2025 13:19:02 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f85c2sm19477858f8f.91.2025.02.19.13.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 13:19:02 -0800 (PST)
Message-ID: <7c0ebdbc-1e45-44fa-bf12-b15e1e11f6ac@linaro.org>
Date: Wed, 19 Feb 2025 22:19:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tests/functional: Allow running TCG plugins tests on
 macOS
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Yonggang Luo <luoyonggang@gmail.com>
References: <20250219192340.92240-1-philmd@linaro.org>
 <19fb735c-6e0e-4ae2-a553-fbfcba15b3b7@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <19fb735c-6e0e-4ae2-a553-fbfcba15b3b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 19/2/25 21:30, Pierrick Bouvier wrote:
> Hi Philippe,
> 
> On 2/19/25 11:23, Philippe Mathieu-Daudé wrote:
>> Pierrick kindly helped me to resolve this issue which ended
>> being trivial (to him!). Not tested on Windows so far.
>>
>> I'm still having some meson dependency problem, even on Linux:
>>
>>    $ make check-functional-aarch64
>>    ...
>>    Traceback (most recent call last):
>>      File "python/qemu/qmp/protocol.py", line 834, in _bh_close_stream
>>        await wait_closed(self._writer)
>>      File "python/qemu/qmp/util.py", line 130, in wait_closed
>>        await writer.wait_closed()
>>      File "/usr/lib/python3.10/asyncio/streams.py", line 343, in 
>> wait_closed
>>        await self._protocol._get_close_waiter(self)
>>      File "/usr/lib/python3.10/asyncio/selector_events.py", line 862, 
>> in _read_ready__data_received
>>        data = self._sock.recv(self.max_size)
>>    ConnectionResetError: [Errno 104] Connection reset by peer
>>
>>    The above exception was the direct cause of the following exception:
>>
>>    Traceback (most recent call last):
>>      File "python/qemu/machine/machine.py", line 448, in launch
>>        self._launch()
>>      File "python/qemu/machine/machine.py", line 497, in _launch
>>        self._post_launch()
>>      File "python/qemu/machine/machine.py", line 381, in _post_launch
>>        self._qmp.connect()
>>      File "python/qemu/qmp/legacy.py", line 153, in connect
>>        self._sync(
>>      File "python/qemu/qmp/legacy.py", line 102, in _sync
>>        return self._aloop.run_until_complete(
>>      File "/usr/lib/python3.10/asyncio/base_events.py", line 649, in 
>> run_until_complete
>>        return future.result()
>>      File "/usr/lib/python3.10/asyncio/tasks.py", line 408, in wait_for
>>        return await fut
>>      File "python/qemu/qmp/protocol.py", line 382, in connect
>>        await self._session_guard(
>>      File "python/qemu/qmp/protocol.py", line 456, in _session_guard
>>        raise ConnectError(emsg, err) from err
>>    qemu.qmp.protocol.ConnectError: Failed to establish session: [Errno 
>> 104] Connection reset by peer
>>
>>    The above exception was the direct cause of the following exception:
>>
>>    Traceback (most recent call last):
>>      File "tests/functional/test_aarch64_tcg_plugins.py", line 80, in 
>> test_aarch64_virt_insn
>>        self.run_vm(kernel_path, kernel_command_line,
>>      File "tests/functional/test_aarch64_tcg_plugins.py", line 52, in 
>> run_vm
>>        raise excp
>>      File "tests/functional/test_aarch64_tcg_plugins.py", line 46, in 
>> run_vm
>>        vm.launch()
>>      File "python/qemu/machine/machine.py", line 461, in launch
>>        raise VMLaunchFailure(
>>    qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to 
>> establish session: [Errno 104] Connection reset by peer
>>        Exit code: 1
>>        Command: build/plugins/qemu-system-aarch64 -display none -vga 
>> none -chardev socket,id=mon,fd=6 -mon chardev=mon,mode=control - 
>> machine virt -chardev socket,id=console,fd=11 -serial chardev:console 
>> -cpu cortex-a53 -kernel /home/philippe.mathieu-daude/.cache/qemu/ 
>> download/ 
>> ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7 - 
>> append printk.time=1 panic=-1 console=ttyAMA0 -plugin tests/tcg/ 
>> plugins/libinsn.so -d plugin -D /tmp/plugini36uailv.log -net none -no- 
>> reboot
>>        Output: qemu-system-aarch64: Could not load plugin tests/tcg/ 
>> plugins/libinsn.so: tests/tcg/plugins/libinsn.so: cannot open shared 
>> object file: No such file or directory
>>    make[1]: *** [Makefile.mtest:26: do-meson-check] Error 1
>>
>> I don't mind much building the plugins manually:
>>
>>    $ make tests/tcg/plugins/libinsn.so
>>    [1/2] Compiling C object tests/tcg/plugins/libinsn.so.p/insn.c.o
>>    [2/2] Linking target tests/tcg/plugins/libinsn.so
>>
> 
> Meson tests dependency is missing for plugins, so we need to add it.
> 
> By running: make check-functional-aarch64 V=1, you can see it's only 
> building qemu-img, qemu-system and roms files.
> 
> You can integrate this patch in your series:
> 
> commit a375e9b560685bf4ccd6332cc23ce6850ec2fbbe
> Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Date:   Wed Feb 19 12:26:53 2025 -0800
> 
>      plugins: add explicit dependency in functional tests
> 
>      ./tests/functional/test_aarch64_tcg_plugins.py needs to have plugin
>      libinsn built. However, it's not listed as a dependency, so meson 
> can't
>      know it needs to be built.
> 
>      Thus, we keep track of all plugins, and add them as an explicit
>      dependency.
> 
>      Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> diff --git a/meson.build b/meson.build
> index 18b40a21a5a..80b9c8edd71 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3658,6 +3658,7 @@ qtest_module_ss = ss.source_set()
> 
>   modules = {}
>   target_modules = {}
> +plugin_modules = []
>   hw_arch = {}
>   target_arch = {}
>   target_system_arch = {}
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index c4f5061a7b3..327b48c8886 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -27,3 +27,5 @@ if t.length() > 0
>   else
>     run_target('contrib-plugins', command: find_program('true'))
>   endif
> +
> +plugin_modules += t
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 21c7e2087e9..dcea5d41e10 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -364,7 +364,7 @@ foreach speed : ['quick', 'thorough']
>         # 'run_target' logic below & in Makefile.include
>         test('func-' + testname,
>              python,
> -           depends: [test_deps, test_emulator, emulator_modules],
> +           depends: [test_deps, test_emulator, emulator_modules, 
> plugin_modules],
>              env: test_env,
>              args: [testpath],
>              protocol: 'tap',
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 7f927357421..0e4d4f5d6af 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -19,3 +19,5 @@ if t.length() > 0
>   else
>     run_target('test-plugins', command: find_program('true'))
>   endif
> +
> +plugin_modules += t
> 

[26/36] Compiling C object tests/tcg/plugins/libbb.so.p/bb.c.o
[27/36] Linking target tests/tcg/plugins/libinsn.so
[28/36] Compiling C object tests/tcg/plugins/libinline.so.p/inline.c.o
[29/36] Linking target tests/tcg/plugins/libinline.so
[30/36] Compiling C object tests/tcg/plugins/libmem.so.p/mem.c.o
[31/36] Compiling C object tests/tcg/plugins/libempty.so.p/empty.c.o
[32/36] Linking target tests/tcg/plugins/libempty.so
[33/36] Linking target tests/tcg/plugins/libbb.so
[34/36] Linking target tests/tcg/plugins/libmem.so
[35/36] Compiling C object tests/tcg/plugins/libsyscall.so.p/syscall.c.o
[36/36] Linking target tests/tcg/plugins/libsyscall.so

Yes this works, thanks!

For your embedded patch:
 > Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


