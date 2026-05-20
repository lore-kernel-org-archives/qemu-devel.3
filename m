Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9FBCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjoz-0003YQ-EP; Wed, 20 May 2026 12:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPjoh-0003XC-SD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:30:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPjof-0003aM-Pa
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:30:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso26426755e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779294640; x=1779899440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NvE211tLDUK+DqhPrGAStWbtnpDgRBNgHSUFuNKIRDQ=;
 b=Yr0BolXsEPifsUfCgxAA9RKmdVd6FlQtTEx7prOEiNyZDYdb2gKSaVT/Sd6UfIq2sI
 6+3AohOWBIVtmGcVX29Y97iBSmeGR7JtqIWGyzPV5lR9WX7mWCw9z5gb8gGH2oOZgHMw
 8I1j6Kp41yAnQ8/A+T9khqrbAKC8FjbdN5C2NFQkhmw1fwhbXQdYzr2PPAZuUvYY9qba
 J9nWkkx2ak3/arNUEoUT19nSYcbzCgBY4Wjg3fZxqJOwmPEzPq6eaFpX+JJQ/TLIDWo6
 1am5nboE6Sn8R9a9evz3duDPNrN81Udxw5akLz+9NCCMvPhbtEiGNQ74b5Zm74KIeTwx
 9Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294640; x=1779899440;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NvE211tLDUK+DqhPrGAStWbtnpDgRBNgHSUFuNKIRDQ=;
 b=kNnsaPbOOSjMMlyqBpItjOYd6v+bHzLHimPhWgY345JUecVvtjoe6PpKX6Yi9rn5bn
 xfsmYQQ0GWbszGbHTTb7f87MSyiRGcNmMYtXRSKb8jMI/49fKLUErWOz+d8az1vmt+pS
 2F0qrRFkkXrZNuzqMeNo6PDs0HHYeaE03VqOViv7UJJWCYrzG/eOM4JLP+jcBytlBnpe
 mgH1Cf0ZNEi2QL+iHux9fjKguJEFU85sGsfG8ngwoDQblzAjiHUvxg8fGMarfnsGHAIr
 RxcVlhyGfE4hHE6KygifZSD3At0/IpOgNtv9aNqn+f3tgQEkR8yH1f+LsG85KW261rFz
 FAyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a32OWY2FSNS0C4wUPy4AEyolv92++TJrNo5x75kp0q2YSKyo3/EqvXBj4YUO6VM+bhTzt663GFqVW@nongnu.org
X-Gm-Message-State: AOJu0YwNLhJUcHvsBYSYfjrGr+joRpaEBacOTR4riQptSE38e5WgJHkX
 mYS+nWr2lDBoqoy5ZaCOZJSVJf3PHYFBzCYzeYNw2/kWz+hbgqUUC3B9VG3Q+APpaFM=
X-Gm-Gg: Acq92OHdS4/6WEmswkvV3DOq+7Xi9CY+lKRFua7T29U0LL/6Hqdx3sNWpV+aUouKxJ+
 QdA9hkDTTjSHlJ2kbc1umrxWUWu5UotsYdF6EUyIpKsls6RWKS26LG7rBxvDMDLCMY9ZqsBbvpe
 LXlt/7SbklZu1j3F9+gDXfqPnWe0wetPqyhidizsBMnTb2RqfzzFD4tO6n5+nT/VxBOKiypct/4
 OoMuwf8NW71A5qM/idhkpY5Km0pgFLdMSyzlv65bnkGlqgH38b26udl7VOJyzxwEORsM1icLPUs
 qzm7vzfA20RHe8FcAjhCwgIC+1wmReRLAyBJNxK9cLMJFERRZ/C+XPHp94QW0vhQw2P0wAFI22V
 MjbXElsk/LIAGbqt5t3k6wHny5lZD9E6ivjHIARSI/7tHkBV4XYBiq5lIT7eH8pHVjJRtfFuP3y
 7gK4/POuSIRLdYW5B4++mke4Z3P9F1zdbGPuRBqva4yXjanG/ZyGz94qJOBzTHyPY1DE6Sc4g=
X-Received: by 2002:a05:600c:8901:b0:485:ae14:8191 with SMTP id
 5b1f17b1804b1-48fe60e3663mr334861665e9.5.1779294639702; 
 Wed, 20 May 2026 09:30:39 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6b9efsm207836105e9.5.2026.05.20.09.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 09:30:38 -0700 (PDT)
Message-ID: <5048812c-5196-4b88-b980-b9b5bb5fdbe5@linaro.org>
Date: Wed, 20 May 2026 18:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] hw/mips: add Microchip PIC32MK GPK/MCM board
To: Ericson Joseph <ericsonjoseph@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260429-pic32mk-board-support-v1-0-1dfac14f8e2d@voltumotor.com>
 <20260429-pic32mk-board-support-v1-1-1dfac14f8e2d@voltumotor.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260429-pic32mk-board-support-v1-1-1dfac14f8e2d@voltumotor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Ericson,

On 29/4/26 23:51, Ericson Joseph wrote:
> Add emulation for the Microchip PIC32MK GPK/MCM family of 32-bit MIPS
> microcontrollers (DS60001519E). The family uses a MIPS32 microAptiv MCU
> core running at up to 120 MHz with 256 KB SRAM and 1 MB program flash.
> 
> The following peripherals are modelled:
> 
>    - EVIC  — 216-source interrupt controller with SET/CLR/INV registers,
>               single-vector and multi-vector modes, and OFFx vector offsets
>    - UART  — 6 instances with TX/RX FIFOs and interrupt generation;
>               UART1 wired to the first serial port
>    - Timer — 9 instances using QEMU ptimer; Timer1 drives a 1 kHz tick
>    - GPIO  — 7 ports (A–G) with TRIS/LAT/PORT/ANSEL/CNPU/CNPD registers
>    - SPI   — 6 instances including master and slave modes
>    - I2C   — 4 instances (register-level stub, interrupt capable)
>    - DMA   — 8 channels with CELL/BLOCK/PATTERN transfer modes
>    - CAN FD — 4 instances exposed via QEMU can-bus; SocketCAN accessible
>               with -object can-bus,id=canbus<n>
>    - USB   — 2 Full-Speed OTG instances exposed as chardev PTY
>    - ADC   — ADCHS high-speed 12-bit ADC with 7 cores and FIFO
>    - NVM   — Flash controller with backed host-file support for persistence
>    - DataEE — Software data EEPROM layer over program flash
>    - OC    — 16 Output Compare units
>    - IC    — 16 Input Capture units
>    - CRU   — Clock and Reset Unit (SYSCLK, PBCLK, RCON, RSWRST)
>    - WDT   — Watchdog timer (write-once WDTKEY protocol)
>    - CFG   — Configuration registers and SYSKEY unlock sequence
> 
> All unimplemented SFR ranges log LOG_UNIMP rather than silently ignoring
> accesses. The SET (+4), CLR (+8), and INV (+C) sub-register convention
> is implemented for all peripheral register banks.
> 
> The boot ROM at 0xBFC00000 contains a j 0xBFC40000 trampoline; firmware
> is loaded into Boot Flash 1 at physical 0x1FC40000 via -bios.
> 
> Reference: Microchip DS60001519E (publicly available from microchip.com)
> 
> Signed-off-by: Ericson Joseph <ericsonjoseph@gmail.com>
> ---
>   MAINTAINERS                                |    9 +
>   configs/targets/mipsel-softmmu.mak         |    1 +
>   hw/mips/Kconfig                            |    8 +
>   hw/mips/meson.build                        |   21 +
>   hw/mips/pic32mk.c                          |  815 ++++++++++++++++++++
>   hw/mips/pic32mk_adchs.c                    |  583 ++++++++++++++
>   hw/mips/pic32mk_canfd.c                    | 1143 ++++++++++++++++++++++++++++
>   hw/mips/pic32mk_cfg.c                      |  247 ++++++
>   hw/mips/pic32mk_cru.c                      |  375 +++++++++
>   hw/mips/pic32mk_dataee.c                   |  463 +++++++++++
>   hw/mips/pic32mk_dma.c                      |  255 +++++++
>   hw/mips/pic32mk_evic.c                     |  399 ++++++++++
>   hw/mips/pic32mk_gpio.c                     |  418 ++++++++++
>   hw/mips/pic32mk_i2c.c                      |  184 +++++
>   hw/mips/pic32mk_ic.c                       |  384 ++++++++++
>   hw/mips/pic32mk_nvm.c                      |  572 ++++++++++++++
>   hw/mips/pic32mk_oc.c                       |  293 +++++++
>   hw/mips/pic32mk_spi.c                      |  532 +++++++++++++
>   hw/mips/pic32mk_timer.c                    |  294 +++++++
>   hw/mips/pic32mk_uart.c                     |  334 ++++++++
>   hw/mips/pic32mk_usb.c                      | 1033 +++++++++++++++++++++++++
>   hw/mips/pic32mk_wdt.c                      |  230 ++++++
>   include/hw/mips/pic32mk.h                  |  952 +++++++++++++++++++++++
>   include/hw/mips/pic32mk_adchs.h            |   87 +++
>   include/hw/mips/pic32mk_canfd.h            |  210 +++++
>   include/hw/mips/pic32mk_evic.h             |   45 ++
>   include/hw/mips/pic32mk_usb.h              |  181 +++++
>   tests/functional/mipsel/pic32mk_test_fw.S  |   64 ++
>   tests/functional/mipsel/pic32mk_test_fw.ld |   20 +
>   tests/functional/mipsel/test_pic32mk.py    |   92 +++
>   tests/qtest/pic32mk-canfd-test.c           |  411 ++++++++++
>   tests/qtest/pic32mk-test.c                 |  457 +++++++++++
>   32 files changed, 11112 insertions(+)

This patch is HUGE, no way my human brain can review it.
Could you split it in 1 patch per hw model type? Even USB
or CAN peripherals patch will result in more than 1k LoC each.

 > diff --git a/hw/mips/pic32mk_adchs.c b/hw/mips/pic32mk_adchs.c

> +static void pic32mk_adchs_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    device_class_set_legacy_reset(dc, pic32mk_adchs_reset);

Also please do not use the legacy API. See for example this
commit to convert to the newer API:
https://gitlab.com/qemu-project/qemu/-/commit/ce788d3740f

Regards,

Phil.

> +}

