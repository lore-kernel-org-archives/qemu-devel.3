Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A90C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsSL-0006Ro-4Z; Wed, 19 Jun 2024 06:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsSJ-0006RY-OL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:22:19 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJsSH-0006JU-OH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:22:19 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a63359aaaa6so990033366b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718792536; x=1719397336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0cmp6TtXj8ZZv5VruN2ldve+MWRF/k1BTlWxu6YMlA=;
 b=BoBOL5U4I4jPmbISoJm/bUwr9zaZYXFS3Uwtlx68+xTlRhPOOEJbjc+b/NgtDLiXHu
 0p03Z7eC2z3LoMXl8rD7v3Q5y9zotYlS24wPWhh6WoF/Cqwn496VTaV/72rq2x0cUEfc
 q5oKEkDfNtCr4kK44EyPP/TQT/ALCcJRMPdY2wlPx0OlPEAzccxSdqigVErFHpuzS6YG
 y7Q8/LBs44ugRa1QxKjysdtUY5jDAMwcp5hLyr5MajDQloyR8YxxaA7wVsSixq5DuGqr
 yBYpHR9jSnAHZ9TuAte5hii2fsE15ypRITGlbtPxfyCc2SDOFNvNAtbi02amr/wjt29I
 glXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718792536; x=1719397336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0cmp6TtXj8ZZv5VruN2ldve+MWRF/k1BTlWxu6YMlA=;
 b=knDlvnXYC3MSNfRfByEqEuyaDy9WS0vJPktHphiD8B208j4HJFlZHIw+G85mfwb4Ka
 b9UFF19Dn7YQgdJ6rT1SikggV1LP3/QXoLu5hZWM3UKeQysyAaQKkjK207TRx8u/shZF
 Op8ozbEZ0VhMc2XrKll2MENz/EuQO1mFaRPZoP7dKjgyNZ2i3JRjSP/g3dd1777lI835
 BBJazrROtuzStpxwmSD3FHEUeRNZ+lzvRPm3KojoC4zDhIo4OgS0tgePhsU5VXKoNVtq
 wJIlyTl+k453E27Iv1BSPG1ZsAa5obpBp2MJ2d014U08y857eOzl57GZNx6BiLVugYh0
 qtUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIWaouXJoiwpdBjvEma7PHKb1sihQ8OiFtCiJbE5gIAE8bMwk0CHmCn6TBvUJFMqwuO91xZiHP3T1qYL5xtu4fOY3FSPM=
X-Gm-Message-State: AOJu0YwX0spBEwr5dBlmWZ7QVJyyJ78WXhiwfYChwVWVt/3I/sVwLN4I
 ojW6xuHlDRkimZFkMjALcLYoNLZDrlx8LJIEPORuPTcad1P9JB7FqfqEO+08K0c=
X-Google-Smtp-Source: AGHT+IH9kjqjnq0Kze+0x+J4pIRj58OFZEnmahtVU9Zdt6RkUWpCAPiHxQ31RVBJnkjvNVj1oDTNnw==
X-Received: by 2002:a17:907:c787:b0:a6f:392d:51a9 with SMTP id
 a640c23a62f3a-a6fab60bb95mr117970666b.14.1718792536011; 
 Wed, 19 Jun 2024 03:22:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f4177csm652680766b.162.2024.06.19.03.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:22:15 -0700 (PDT)
Message-ID: <ee4149fd-890d-43c6-a7c0-0d6df63bbb2f@linaro.org>
Date: Wed, 19 Jun 2024 12:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] exec: avoid using C++ keywords in function parameters
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224553.878869-1-rkir@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240618224553.878869-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/6/24 00:45, Roman Kiryanov wrote:
> to use the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: Ic4e49b9c791616bb22c973922772b0494706092c
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>   include/exec/memory.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 1be58f694c..d7591a60d9 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -945,7 +945,7 @@ struct MemoryListener {
>        * the current transaction.
>        */
>       void (*log_start)(MemoryListener *listener, MemoryRegionSection *section,
> -                      int old, int new);
> +                      int old_val, int new_val);
>   
>       /**
>        * @log_stop:
> @@ -964,7 +964,7 @@ struct MemoryListener {
>        * the current transaction.
>        */
>       void (*log_stop)(MemoryListener *listener, MemoryRegionSection *section,
> -                     int old, int new);
> +                     int old_val, int new_val);

OK but please keep the implementations in sync with the prototype
argument names:

accel/hvf/hvf-accel-ops.c:264: 
MemoryRegionSection *section, int old, int new)
accel/hvf/hvf-accel-ops.c:274: 
MemoryRegionSection *section, int old, int new)
accel/kvm/kvm-all.c:549:                          int old, int new)
accel/kvm/kvm-all.c:566:                          int old, int new)
hw/i386/xen/xen-hvm.c:430:                          int old, int new)
hw/i386/xen/xen-hvm.c:441:                         int old, int new)
hw/virtio/vhost.c:1070:                            int old, int new)
hw/virtio/vhost.c:1077:                           int old, int new)
include/exec/memory.h:948:                      int old, int new);
include/exec/memory.h:967:                     int old, int new);

See also:
target/arm/tcg/translate-a64.c:2161:        int new = a->imm * 3;
target/sparc/trace-events:23:sparc64_cpu_check_irqs_set_irq(unsigned int 
i, int old, int new) "Set CPU IRQ %d old=0x%x new=0x%x"
util/lockcnt.c:81:            int new = expected - 
QEMU_LOCKCNT_STATE_LOCKED + QEMU_LOCKCNT_STATE_WAITING;
util/trace-events:65:lockcnt_fast_path_attempt(const void *lockcnt, int 
expected, int new) "lockcnt %p fast path %d->%d"
util/trace-events:66:lockcnt_fast_path_success(const void *lockcnt, int 
expected, int new) "lockcnt %p fast path %d->%d succeeded"
util/trace-events:67:lockcnt_unlock_attempt(const void *lockcnt, int 
expected, int new) "lockcnt %p unlock %d->%d"
util/trace-events:68:lockcnt_unlock_success(const void *lockcnt, int 
expected, int new) "lockcnt %p unlock %d->%d succeeded"
util/trace-events:69:lockcnt_futex_wait_prepare(const void *lockcnt, int 
expected, int new) "lockcnt %p preparing slow path %d->%d"
util/trace-events:71:lockcnt_futex_wait_resume(const void *lockcnt, int 
new) "lockcnt %p after wait: %d"

and:
$ git grep -wE 'u?int(8|16|32|64)_t new'
hw/core/trace-events:28:clock_set(const char *clk, uint64_t old, 
uint64_t new) "'%s', %"PRIu64"Hz->%"PRIu64"Hz"
hw/display/trace-events:5:jazz_led_write(uint64_t addr, uint8_t new) 
"write addr=0x%"PRIx64": 0x%x"
hw/display/trace-events:14:g364fb_write(uint64_t addr, uint32_t new) 
"write addr=0x%"PRIx64": 0x%x"
hw/gpio/aspeed_gpio.c:276:    uint32_t new = value;
hw/ide/trace-events:70:ahci_check_irq(void *s, uint32_t old, uint32_t 
new) "ahci(%p): check irq 0x%08x --> 0x%08x"
hw/ide/trace-events:71:ahci_trigger_irq(void *s, int port, const char 
*name, uint32_t val, uint32_t old, uint32_t new, uint32_t effective) 
"ahci(%p)[%d]: trigger irq +%s (0x%08x); irqstat: 0x%08x --> 0x%08x; 
effective: 0x%08x"
hw/intc/aspeed_vic.c:47:    uint64_t new = (s->raw & s->enable);
hw/intc/imx_avic.c:63:    uint64_t new = s->pending & s->enabled;
hw/net/opencores_eth.c:304:        uint32_t old, uint32_t new)
hw/net/rocker/rocker.c:762:static void 
rocker_port_phys_enable_write(Rocker *r, uint64_t new)
hw/net/rocker/rocker_desc.c:252:bool desc_ring_set_head(DescRing *ring, 
uint32_t new)
hw/net/rocker/rocker_desc.h:35:bool desc_ring_set_head(DescRing *ring, 
uint32_t new);
hw/net/trace-events:208:e1000e_irq_clear(uint32_t offset, uint32_t old, 
uint32_t new) "Clearing interrupt register 0x%x: 0x%x --> 0x%x"
hw/net/trace-events:209:e1000e_irq_set(uint32_t offset, uint32_t old, 
uint32_t new) "Setting interrupt register 0x%x: 0x%x --> 0x%x"
hw/ssi/aspeed_smc.c:285: 
uint64_t new)
hw/timer/aspeed_timer.c:380:                                 uint8_t 
old, uint8_t new)
hw/timer/hpet.c:137:static uint64_t hpet_fixup_reg(uint64_t new, 
uint64_t old, uint64_t mask)
hw/timer/hpet.c:144:static int activating_bit(uint64_t old, uint64_t 
new, uint64_t mask)
hw/timer/hpet.c:149:static int deactivating_bit(uint64_t old, uint64_t 
new, uint64_t mask)
hw/usb/trace-events:82:usb_ehci_opreg_change(uint32_t addr, const char 
*str, uint32_t new, uint32_t old) "ch mmio 0x%04x [%s] = 0x%x (old: 0x%x)"
hw/usb/trace-events:85:usb_ehci_portsc_change(uint32_t addr, uint32_t 
port, uint32_t new, uint32_t old) "ch mmio 0x%04x [port %d] = 0x%x (old: 
0x%x)"
hw/virtio/trace-events:134:virtio_iommu_set_page_size_mask(const char 
*name, uint64_t old, uint64_t new) "mr=%s old_mask=0x%"PRIx64" 
new_mask=0x%"PRIx64
hw/virtio/virtio.c:2406:                                    uint16_t 
off_wrap, uint16_t new,
include/hw/timer/a9gtimer.h:94:    uint64_t new;
target/arm/cpu.h:1202:void aarch64_set_svcr(CPUARMState *env, uint64_t 
new, uint64_t mask);
target/arm/helper.c:7350:void aarch64_set_svcr(CPUARMState *env, 
uint64_t new, uint64_t mask)
target/arm/tcg/mte_helper.c:334:        uint8_t new = deposit32(old, 
ofs, 4, tag);
target/i386/tcg/sysemu/excp_helper.c:107:static bool ptw_setl_slow(const 
PTETranslate *in, uint32_t old, uint32_t new)
target/i386/tcg/sysemu/excp_helper.c:124:        uint32_t new = old | set;
util/trace-events:6:poll_shrink(void *ctx, int64_t old, int64_t new) 
"ctx %p old %"PRId64" new %"PRId64
util/trace-events:7:poll_grow(void *ctx, int64_t old, int64_t new) "ctx 
%p old %"PRId64" new %"PRId64


