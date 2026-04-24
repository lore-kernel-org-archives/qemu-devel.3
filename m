Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CA7FED3E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIgm-0003VG-W4; Fri, 24 Apr 2026 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGIgB-0002wY-4x
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:42:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGIg8-0007SA-1D
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:42:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ba840146so71903305e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777045363; x=1777650163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=moiPY9hkSxnMb68PM+Zd30hQW4Ah6l7tWRbAok15If0=;
 b=xqOtIWbupHfKXili3cyKyciwFn1cvj9lsqPdcfvgAEXr+6XdXUdldt15xo9f+/A1dU
 iiTvEwnhniixxMiNDec7k9JHGcCYRsnbZW8bXwxEc9PCXaK6x3CH+NoBAV8UDZZf/JDc
 EWroDMfsc7wppyU7rFl0YK6gu0IXJUo2etpoPBBTQK9yPaJ5nTcn1F2UUdInCAqt7D+1
 RUPikJwYrq8sMF8q9szxT8ZHAsVKAXyQF6Qb1ukeZg1PgbzVNbF4nYTBlAHoQsfPKxWX
 7Qpdurf5BkNBsdnze7C5YhVSBkGOkA13IPQZnpUADzbKf/JB3c9j8x8XUNLYuSc2gTOH
 zFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777045363; x=1777650163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=moiPY9hkSxnMb68PM+Zd30hQW4Ah6l7tWRbAok15If0=;
 b=DG7CO/ru9XetPpBUrvY6UFTGuoQycCX8tW0njofMpryXctaeRylk96HWN1i+HpAnQ8
 upmovnEUidenkinYXltBYY2ELaQtrHU1NvP8HYtCT1bw93++Ep28Ky4AYJCCSP9ETZMT
 oOzdOVQ31qPq5gLofXXGLk3fPW3vsNkvIFj9Y5hnIQDoJOIsZfUtBQ9d8BcHWatvoSho
 TZ7j+mKl+yUh/Iu6Mg8BCMxDtiS9BzZ8tZviidcIjWmnvVm2nr0Po81vPL6zLcTFGAXv
 D6diejP/PxZv9pIdVw3hEfcnra+I0JgYomPAmyQO17/nsfAsSyeygrWAQMBNzW5i1CTj
 vvAw==
X-Gm-Message-State: AOJu0Yyw5KUuLAocHJGYMkvCt4mr6inA/zQUCLmmwnpngrGd+0i8lx0E
 +MPNMxTbzg7CePrwEu8xlDb4Aef4qadOBCk599O93BZNYem3vWkkx+IbwiiBl4CCEQVuup9jp/w
 NALUjfxk=
X-Gm-Gg: AeBDietr1XcWwwlokgLrYeDkMg0FosB0Qr080aKyvbiFHMeTUvvOibvCzJeC5IcRNCD
 S8k99tWr0z9YFjS29Ht5MQaiW0wzF2inA8BNX5vgX5gMMFcERrQdBrWIXptZQ0ZAp7rloSygOGb
 tUYlBDcwO4Xi3pRJDBJLEDTGdkW6xR4Yh5c9fRVvqbwPuxNPZ7mPH05wRicXG+L9DpryPiGiM59
 1+ViXW9SYqUFFxqgIBE6nob89UtEZWHZxg36YfrRUfPO/wkBJyNjD1GQCMD0NQmqMfRby+UGj3I
 kCbWXbIMqq648GTiHZYcw9FxGdm2s3smoSd/kGirY5KtDzmHttgD89Db1SzezZxd1ayx53yK5AC
 7ANGeNeV7MHhP6JH27QBGlPiW96uvIUyee9fmln0jb6ZjsSVDn0vb5ld94UpVNIKxGnHfDq0u0B
 qsB/15cXZuIABKBr5cZmAuZRShMccsxdpH5BU19WNvuiKMU/lX/Hpxz1hgx4wPvKib9ZMgTm35A
 RvP
X-Received: by 2002:a05:600c:4a15:b0:489:1aed:1658 with SMTP id
 5b1f17b1804b1-4891aed16d8mr191584425e9.23.1777045363097; 
 Fri, 24 Apr 2026 08:42:43 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm610940545e9.14.2026.04.24.08.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 08:42:42 -0700 (PDT)
Message-ID: <cd2e4678-04b3-454f-bc32-9a3d7937de02@linaro.org>
Date: Fri, 24 Apr 2026 17:42:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v3 00/52] Misc HW patches for 2026-04-22
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260423212856.68734-1-philmd@linaro.org>
 <CAJSP0QX-MyMPwatjaqMZzaLPFqH-9va4KB347V9wHDZX=TGFiw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QX-MyMPwatjaqMZzaLPFqH-9va4KB347V9wHDZX=TGFiw@mail.gmail.com>
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

On 24/4/26 14:07, Stefan Hajnoczi wrote:
> On Thu, Apr 23, 2026 at 5:30 PM Philippe Mathieu-Daudé 
> <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> 
>     v3:
>        now than target-arm.next is merged, 3 more MAINTAINERS patches
>     v2:
>     Rebased on top of
>        Merge tag 's390x-20260423' of https://gitlab.com/cohuck/qemu
>     <https://gitlab.com/cohuck/qemu> into staging
>     to fix:
>        CONFLICT (content): Merge conflict in include/hw/core/boards.h
> 
>     The following changes since commit
>     e5182fd198e85cb650cdfed1839ee8aac86e0b7e:
> 
>        Merge tag 'pull-11.1-virtio-gpu-hotfixes-230426-1' of https://
>     gitlab.com/stsquad/qemu <https://gitlab.com/stsquad/qemu> into
>     staging (2026-04-23 13:52:08 -0400)
> 
>     are available in the Git repository at:
> 
>     https://github.com/philmd/qemu.git <https://github.com/philmd/
>     qemu.git> tags/hw-misc-20260422
> 
>     for you to fetch changes up to 5d6beec09b2e41a73b3a299870865ebb31572857:
> 
>        MAINTAINERS: Transfer CI maintenance to Pierrick (2026-04-23
>     23:26:39 +0200)
> 
>     ----------------------------------------------------------------
>     Misc HW patches
> 
>     - Build hw/avr/ as common unit files
>     - Header cleanups around 'cpu.h', 'qemu/audio.h' or duplicated lines
>     - Remove obsolete TPMIfClass::ppi_enabled field
>     - Cleanups around load/store API
>     - Restrict 'compat' properties API to system emulation
>     - Correct TPM PPCI ACPI for Windows guests on ARM Virt machine
>     - Simplify physical_memory_range_includes_clean()
>     - Avoid including CONFIG_DEVICES in hw/arm/smmuv3
>     - Initialize bus frequency in PPC e500 device tree blob
>     - More ATI VGA fixes
>     - Fix fuzzing issues on AVR power controller and SH4 MCU
>     - MAINTAINERS updates
> 
>     ----------------------------------------------------------------
> 
> 
> This pull request breaks run-tcg-tests-riscv64-linux-user:
> 
> $ ./configure --target-list=riscv64-linux-user && make check-tcg
> ...
>    BUILD   debian-all-test-cross
>    BUILD   riscv64-linux-user guest-tests
>    RUN     riscv64-linux-user guest-tests
>    TEST    semihosting on riscv64
>    SKIPPED semiconsole on riscv64 because MANUAL ONLY
>    TEST    catch-syscalls on riscv64
>    TEST    convd on riscv64
>    TEST    convs on riscv64
>    TEST    madds on riscv64
>    TEST    fnmsub on riscv64
>    TEST    late-attach on riscv64
>    TEST    follow-fork-mode on riscv64
>    TEST    munmap-pthread on riscv64
>    TEST    overflow on riscv64
>    TEST    prot-none on riscv64
>    TEST    segfault on riscv64
>    SKIPPED float_convs check on riscv64 because no reference
>    TEST    sha1 on riscv64
>    SKIPPED float_convd check on riscv64 because no reference
>    TEST    sha512 on riscv64
>    SKIPPED float_madds check on riscv64 because no reference
>    TEST    sigbus on riscv64
>    TEST    signals on riscv64
>    TEST    sigreturn-sigmask on riscv64
>    TEST    tb-link on riscv64
>    TEST    test-mmap (default) on riscv64
>    TEST    testthread on riscv64
>    TEST    threadcount on riscv64
>    TEST    vma-pthread on riscv64
>    TEST    linux-madvise on riscv64
>    TEST    linux-shmat-maps on riscv64
>    TEST    linux-shmat-null on riscv64
>    TEST    linux-sigrtminmax on riscv64
>    TEST    linux-test on riscv64
>    TEST    test-vma on riscv64
>    TEST    test-div on riscv64
>    TEST    noexec on riscv64
>    TEST    test-noc on riscv64
> make[1]: *** [Makefile:223: run-test-noc] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [/home/stefanha/qemu/tests/Makefile.include:68: run-tcg-tests- 
> riscv64-linux-user] Error 2

Interesting, this is the single test setting a QOM property on a
linux-user binary!

> Please send a v4 that resolves the test-noc failure. Thanks!

v4 ready but I'll wait current /staging is pushed as /master first.

Regards,

Phil.

