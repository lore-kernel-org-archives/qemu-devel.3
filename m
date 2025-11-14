Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDB1CE7B09
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtR3-0006wo-NC; Fri, 14 Nov 2025 08:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vJtQX-0006rO-Bj
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:01:22 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael@videogpu.com>)
 id 1vJtQU-0004kW-3k
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:01:21 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so14517815e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=videogpu-com.20230601.gappssmtp.com; s=20230601; t=1763125275; x=1763730075;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PO12BqMIJDTcwAgg5ArVVi2jvQUIdx57542PZJSmqTM=;
 b=V+5qFIHsUe2NK0sVEH+0on0uWZNQwH8EKgwkQ+hVgFcUf2XXqZHfpQnGOi4m9jV9WB
 lqnGCoXfOmddtH9bVUNDd1i+h6mw/sfm7vC7VvfQowJXgQ9ewy3qY0uvZ9VgGPVbJRkv
 eWpBZX2CqFHyiYSgdKEjLIM/bbLO1pGYTTGew+W20rOshjVhJ/LsETV3b0Ah3ZeFauuj
 q51JAnljZBSlddRfb0Klqo2KDFzTx71atO9dPBdLKcb+NRXbiFd4pNP22j59+b3OU4BF
 ueOTmctj9xz754mALRXu8z3QBjgZkcZVXuwwG+dLCzMQ+tWrJgf8Em/D+XThAZfCkfGj
 oKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763125275; x=1763730075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PO12BqMIJDTcwAgg5ArVVi2jvQUIdx57542PZJSmqTM=;
 b=ur33VOwPz0yG6FiwTJLOU2oVzp16ijMyQo62+DCcFTeoKq7/Mn3+qv4vZv5ZgGJElh
 MCtwsPAlD+ecErOQscy/TlEEQk78Ba9WBWCKPJMY88ArF6Xb8NKHltu5cUYlnfjKTlSS
 JYVxeRq3xPKRCsoEHyufNfMK8NPrTlzQDSfnqrU//vLwAHJ9qPSAmmV1EqNfGJ6pd9zm
 LBuBvJa+pwfGiOdRmqGdDzRSBCiNSrnWYTpxlwPmIlp3loPu9vINWkhIp2x198KWQxul
 ZWCgJnkfN7ZLgR5fOUqqUFwQHYz5l/4x5XyvZyvOAgYnSFG/jDYASbb8/77mWM95dBSP
 42fA==
X-Gm-Message-State: AOJu0Ywa2gHCj4cw05tunUgJPbF3UQc+qMkPL9qqEbxDAwBvDILDFUfx
 LCtkME1zgbNNQOehH1jrgJE2lh/5XFm4uROdUHyPFnC7WSblP9sLRqScdJ72WYxbZ6Q=
X-Gm-Gg: ASbGncuD4JyuXi+SpugMqOcG/65l14sWazxcGknVwvxOFZulIyg5qCLSEQYPGCG0N5b
 hAsyukFgI7hK+wE3PB4AZOZGV1CqCKtB6RyNVlGtOY5l3/bmjTzctjDkPZKASLPNJGBwaqZfJ4g
 omjSk3dT/NI91tDn+fVjH7zMI3gzd0fttOtWVFS0MjNEDGc2Z52fmLwVSvq1EyN6H4SuI3E9QlU
 mwJ58iMjxj9hY6cWnKtr34NuWGSV+IdyvZLO8Erw16f9fCW1wiYbUmaJHuaRwqp7McDWsAF+5nX
 +mt9y9HDRliCWapxDWKaHp8nTeCuzGFe7Vs3FVpUdfmHrXb064q8/YUAQ0AtsbJWlReDAV5Xaak
 dU6GQ7nVUK45ts7sqq/kFQreazR06LAJqxQ5bsWNNwHmOE718D2Lz6QwozT2o1KPXUpybJVHGZB
 BqtuUgQksaZvIE4RDAq5o2sGozx1fbkpw2/i+t7Brv5s86/A==
X-Google-Smtp-Source: AGHT+IHiQymjt12wY6UCSSw0k0ufJhG1WyA81PINqexNaf0NKYuLhIHAiiEch6bASYl7EzOGLub7Jw==
X-Received: by 2002:a05:600c:8b4c:b0:477:7f4a:44ba with SMTP id
 5b1f17b1804b1-4778fe60072mr26155985e9.4.1763125273382; 
 Fri, 14 Nov 2025 05:01:13 -0800 (PST)
Received: from ?IPV6:2a10:8012:1:b32a:35:83e6:baea:8ad?
 ([2a10:8012:1:b32a:35:83e6:baea:8ad])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bb5ba68sm43686375e9.7.2025.11.14.05.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 05:01:12 -0800 (PST)
Message-ID: <3bcbd36e-5d9b-443a-9704-bbab84363f85@videogpu.com>
Date: Fri, 14 Nov 2025 15:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] hw/misc: add NEORV32 SYSINFO block
 (CLK/MISC/SOC/CACHE)
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org,
 pbonzini@redhat.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, smishash@gmail.com
References: <20251027100938.11822-1-michael@videogpu.com>
 <20251027100938.11822-3-michael@videogpu.com>
 <CAKmqyKOwBvq_Rut1pwEmAG0Y9uyevOCdH-MwutWx7mZRhZcwpA@mail.gmail.com>
Content-Language: en-US
From: Michael Levit <michael@videogpu.com>
In-Reply-To: <CAKmqyKOwBvq_Rut1pwEmAG0Y9uyevOCdH-MwutWx7mZRhZcwpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32e;
 envelope-from=michael@videogpu.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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


On 11/12/25 04:00, Alistair Francis wrote:
> On Mon, Oct 27, 2025 at 8:12 PM Michael Levit <michael@videogpu.com> wrote:
>> From: Michael <michael@videogpu.com>
>>
>> Add a minimal SYSINFO MMIO device compatible with NEORV32 SDK expectations:
>> CLK (rw), MISC/SOC/CACHE (ro) composed from constants. Includes Kconfig/meson.
>>
>> Signed-off-by: Michael Levit <michael@videogpu.com>
>>
>> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
>> index 4e35657468..3de644a9e0 100644
>> --- a/hw/misc/Kconfig
>> +++ b/hw/misc/Kconfig
>> @@ -235,4 +235,6 @@ config IOSB
>>   config XLNX_VERSAL_TRNG
>>       bool
>>
>> +config NEORV32_SYSINFO_QEMU
>> +    bool
>>   source macio/Kconfig
>>
>> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
>> index b1d8d8e5d2..4ea46ec2d1 100644
>> --- a/hw/misc/meson.build
>> +++ b/hw/misc/meson.build
>> @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>>   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>>   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>>   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
>> +system_ss.add(when: 'CONFIG_NEORV32_SYSINFO_QEMU', if_true: files('neorv32_sysinfo.c'))
>>
>>   subdir('macio')
>>
>> diff --git a/hw/misc/neorv32_sysinfo.c b/hw/misc/neorv32_sysinfo.c
>> new file mode 100644
>> index 0000000000..09378b17a9
>> --- /dev/null
>> +++ b/hw/misc/neorv32_sysinfo.c
>> @@ -0,0 +1,183 @@
> Run these all through checkpatch, you are missing license info
Fixed in later patch series.
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "system/address-spaces.h"
>> +#include "neorv32_sysinfo.h" /* QEMU related */
>> +#include "neorv32_sysinfo_rtl.h" /* RTL related */
>> +
>> +
>> +/* Register addresses (offsets) */
>> +enum {
>> +       REG_SYSINFO_CLK    = 0x00,
>> +       REG_SYSINFO_MISC   = 0x04,
>> +       REG_SYSINFO_SOC    = 0x08,
>> +       REG_SYSINFO_CACHE  = 0x0C,
>> +};
> Why an enum?
I wanted to be inline with a firmware implementation of the Neorv32 author.
So when debugging, it would be easy to compare the hardware state and 
QEMU emulated state.

>> +
>> +
>> +typedef struct Neorv32SysInfoState {
>> +    MemoryRegion mmio;
>> +    uint32_t clk_hz;   /* rw */
>> +    uint32_t misc;     /* ro */
>> +    uint32_t soc;      /* ro */
>> +    uint32_t cache;    /* ro */
>> +} Neorv32SysInfoState;
>> +
>> +
>> +/* Safe integer log2: assumes power-of-two sizes; returns 0 if size is 0 */
>> +static unsigned int neorv32_log2u(uint32_t x)
>> +{
>> +    if (x == 0U) {
>> +        return 0U;
>> +    }
>> +    unsigned int r = 0U;
>> +    while ((x >>= 1U) != 0U) {
>> +        r++;
>> +    }
>> +    return r;
>> +}
>> +
>> +/* Compose MISC register per the firmware header */
>> +static uint32_t neorv32_sysinfo_build_misc(void)
>> +{
>> +    const uint32_t imem_log2  = neorv32_log2u(SYSINFO_IMEM_SIZE) & 0xFFU;  /* [7:0]  */
>> +    const uint32_t dmem_log2  = neorv32_log2u(SYSINFO_DMEM_SIZE) & 0xFFU;  /* [15:8] */
>> +    const uint32_t harts      = (SYSINFO_NUM_HARTS & 0x0FU);               /* [19:16] */
>> +    const uint32_t bootmode   = (SYSINFO_BOOTMODE_ID & 0x03U);             /* [21:20] */
>> +    const uint32_t intbus_to  = (SYSINFO_INTBUS_TO_LOG2 & 0x1FU);          /* [26:22] */
>> +    const uint32_t extbus_to  = (SYSINFO_EXTBUS_TO_LOG2 & 0x1FU);          /* [31:27] */
>> +
>> +    uint32_t v = 0U;
>> +    v |= (imem_log2 << 0);
>> +    v |= (dmem_log2 << 8);
>> +    v |= (harts     << 16);
>> +    v |= (bootmode  << 20);
>> +    v |= (intbus_to << 22);
>> +    v |= (extbus_to << 27);
>> +    return v;
>> +}
>> +
>> +/* Compose CACHE register per the firmware header */
>> +static uint32_t neorv32_sysinfo_build_cache(void)
>> +{
>> +    uint32_t v = 0U;
>> +    v |= ((ICACHE_BLOCK_SIZE_LOG2 & 0x0FU) << 0);
>> +    v |= ((ICACHE_NUM_BLOCKS_LOG2 & 0x0FU) << 4);
>> +    v |= ((DCACHE_BLOCK_SIZE_LOG2 & 0x0FU) << 8);
>> +    v |= ((DCACHE_NUM_BLOCKS_LOG2 & 0x0FU) << 12);
>> +    v |= ((ICACHE_BURSTS_EN ? 1U : 0U) << 16);
>> +    v |= ((DCACHE_BURSTS_EN ? 1U : 0U) << 24);
>> +    return v;
>> +}
>> +
>> +static uint64_t neorv32_sysinfo_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    Neorv32SysInfoState *s = opaque;
>> +    uint32_t val = 0U;
>> +
>> +    switch (addr) {
>> +    case REG_SYSINFO_CLK:
>> +        val = s->clk_hz;
>> +        break;
>> +    case REG_SYSINFO_MISC:
>> +        val = s->misc;
>> +        break;
>> +    case REG_SYSINFO_SOC:
>> +        val = s->soc;
>> +        break;
>> +    case REG_SYSINFO_CACHE:
>> +        val = s->cache;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: invalid read addr=0x%" HWADDR_PRIx " size=%u\n",
>> +                      __func__, addr, size);
>> +        return 0;
>> +    }
>> +
>> +    /* Enforce access size semantics (1/2/4 ok); we just return the low bytes */
>> +    switch (size) {
>> +    case 4: return val;
>> +    case 2: return (uint16_t)val;
>> +    case 1: return (uint8_t)val;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: invalid read size=%u at addr=0x%" HWADDR_PRIx "\n",
>> +                      __func__, size, addr);
>> +        return 0;
>> +    }
>> +}
>> +
>> +static void neorv32_sysinfo_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
>> +{
>> +    Neorv32SysInfoState *s = opaque;
>> +
>> +    /* Only CLK is writable; others are read-only */
>> +    if (addr == REG_SYSINFO_CLK) {
>> +        /* Accept 1/2/4 byte writes; update the corresponding bytes of clk_hz */
>> +        uint32_t old = s->clk_hz;
>> +        uint32_t val = old;
>> +
>> +        switch (size) {
>> +        case 4:
>> +            val = (uint32_t)data;
>> +            break;
>> +        case 2: {
>> +            uint16_t part = (uint16_t)data;
>> +            /* Little-endian halfword at offset (0 or 2) */
>> +            if ((addr & 0x3) == 0x0) {
>> +                val = (old & 0xFFFF0000U) | part;
>> +            } else if ((addr & 0x3) == 0x2) {
>> +                val = (old & 0x0000FFFFU) | ((uint32_t)part << 16);
>> +            } else {
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "%s: misaligned 16-bit write at 0x%" HWADDR_PRIx "\n",
>> +                              __func__, addr);
>> +                return;
>> +            }
>> +            break;
>> +        }
>> +        case 1: {
>> +            uint8_t part = (uint8_t)data;
>> +            uint32_t shift = (addr & 0x3) * 8U;
>> +            val = (old & ~(0xFFU << shift)) | ((uint32_t)part << shift);
>> +            break;
>> +        }
>> +        default:
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: invalid write size=%u at addr=0x%" HWADDR_PRIx "\n",
>> +                          __func__, size, addr);
>> +            return;
>> +        }
>> +
>> +        s->clk_hz = val;
>> +        return;
>> +    }
>> +
>> +    qemu_log_mask(LOG_GUEST_ERROR,
>> +                  "%s: write to read-only addr=0x%" HWADDR_PRIx " val=0x%" PRIx64 " size=%u\n",
>> +                  __func__, addr, data, size);
>> +}
>> +
>> +static const MemoryRegionOps neorv32_sysinfo_ops = {
>> +    .read = neorv32_sysinfo_read,
>> +    .write = neorv32_sysinfo_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +    .valid.min_access_size = 1,
>> +    .valid.max_access_size = 4,
>> +};
>> +
>> +void neorv32_sysinfo_create(MemoryRegion *address_space, hwaddr base)
>> +{
>> +    Neorv32SysInfoState *s = g_new0(Neorv32SysInfoState, 1);
>> +
>> +    s->clk_hz = SYSINFO_CLK_HZ_DEFAULT;
>> +    s->misc   = neorv32_sysinfo_build_misc();
>> +    s->soc    = SYSINFO_SOC_VAL;
>> +    s->cache  = neorv32_sysinfo_build_cache();
> These should be properties that can be set
OK. Thanks for a guidance.
>
>> +
>> +    memory_region_init_io(&s->mmio, NULL, &neorv32_sysinfo_ops,
>> +                          s, "neorv32.sysinfo", 16 /* 4 regs x 4 bytes */);
>> +
>> +    memory_region_add_subregion(address_space, base, &s->mmio);
>> +}
>>
>> diff --git a/hw/misc/neorv32_sysinfo.h b/hw/misc/neorv32_sysinfo.h
>> new file mode 100644
>> index 0000000000..c0ac7d87e4
>> --- /dev/null
>> +++ b/hw/misc/neorv32_sysinfo.h
>> @@ -0,0 +1,79 @@
>> +#ifndef HW_NEORV32_SYSINFO_H
>> +#define HW_NEORV32_SYSINFO_H
>> +
>> +#include "system/memory.h"
>> +
>> +
>> +/* Internal memory sizes (bytes) */
>> +#define SYSINFO_IMEM_SIZE        0x00008000U  /* 32 KiB IMEM */
>> +#define SYSINFO_DMEM_SIZE        0x00008000U  /* 32 KiB DMEM */
>> +
>> +/* Number of harts (physical cores) */
>> +#define SYSINFO_NUM_HARTS        1U
>> +
>> +/* Boot mode (matches RTL BOOT_MODE_SELECT encoding used in your firmware) */
>> +#define SYSINFO_BOOTMODE_ID      0U           /* 0..3 */
>> +
>> +/* Bus timeout encodings: value is log2(cycles); 0 means "no timeout" per your helper */
>> +#define SYSINFO_INTBUS_TO_LOG2   0U           /* 0 => returns 0 */
>> +#define SYSINFO_EXTBUS_TO_LOG2   0U           /* 0 => returns 0 */
>> +
>> +/* Clock (Hz): writable at runtime via SYSINFO.CLK */
>> +#define SYSINFO_CLK_HZ_DEFAULT   100000000U   /* 100 MHz */
>> +
>> +/* Cache topology encodings (log2 values ) */
>> +#define ICACHE_BLOCK_SIZE_LOG2   0U           /* bits [3:0] */
>> +#define ICACHE_NUM_BLOCKS_LOG2   0U           /* bits [7:4] */
>> +#define DCACHE_BLOCK_SIZE_LOG2   0U           /* bits [11:8] */
>> +#define DCACHE_NUM_BLOCKS_LOG2   0U           /* bits [15:12] */
>> +#define ICACHE_BURSTS_EN         0U           /* bit 16 */
>> +#define DCACHE_BURSTS_EN         0U           /* bit 24 */
>> +
>> +/* Feature bitmap for SOC register. */
>> +#define SYSINFO_SOC_ENABLE(x)    (1U << (x))
>> +
>> +// Enable Bootloader, IMEM, DMEM, UART and SPI
>> +#define SYSINFO_SOC_VAL \
>> +    ( SYSINFO_SOC_ENABLE(SYSINFO_SOC_BOOTLOADER) | \
>> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IMEM)       | \
>> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_DMEM)       | \
>> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_UART0)   | \
>> +      SYSINFO_SOC_ENABLE(SYSINFO_SOC_IO_SPI) )
>> +
>> +/* --------------------------------------------------------------------------------------
>> + * Address map
>> + * ------------------------------------------------------------------------------------*/
>> +#define NEORV32_BOOTLOADER_BASE_ADDRESS (0xFFE00000U)
>> +#define NEORV32_IO_BASE_ADDRESS         (0xFFE00000U)
>> +
>> +#define NEORV32_IMEM_BASE               (0x00000000U)
>> +#define NEORV32_DMEM_BASE               (0x80000000U)
>> +
>> +/* IO base addresses */
>> +#define NEORV32_TWD_BASE     (0xFFEA0000U)
>> +#define NEORV32_CFS_BASE     (0xFFEB0000U)
>> +#define NEORV32_SLINK_BASE   (0xFFEC0000U)
>> +#define NEORV32_DMA_BASE     (0xFFED0000U)
>> +#define NEORV32_CRC_BASE     (0xFFEE0000U)
>> +#define NEORV32_XIP_BASE     (0xFFEF0000U)
>> +#define NEORV32_PWM_BASE     (0xFFF00000U)
>> +#define NEORV32_GPTMR_BASE   (0xFFF10000U)
>> +#define NEORV32_ONEWIRE_BASE (0xFFF20000U)
>> +#define NEORV32_XIRQ_BASE    (0xFFF30000U)
>> +#define NEORV32_MTIME_BASE   (0xFFF40000U)
>> +#define NEORV32_UART0_BASE   (0xFFF50000U)
>> +#define NEORV32_UART1_BASE   (0xFFF60000U)
>> +#define NEORV32_SDI_BASE     (0xFFF70000U)
>> +#define NEORV32_SPI_BASE     (0xFFF80000U)
>> +#define NEORV32_TWI_BASE     (0xFFF90000U)
>> +#define NEORV32_TRNG_BASE    (0xFFFA0000U)
>> +#define NEORV32_WDT_BASE     (0xFFFB0000U)
>> +#define NEORV32_GPIO_BASE    (0xFFFC0000U)
>> +#define NEORV32_NEOLED_BASE  (0xFFFD0000U)
>> +#define NEORV32_SYSINFO_BASE (0xFFFE0000U)
>> +#define NEORV32_DM_BASE      (0xFFFF0000U)
>> +
>> +/* MMIO creator */
>> +void neorv32_sysinfo_create(MemoryRegion *address_space, hwaddr base);
>> +
>> +#endif //HW_NEORV32_SYSINFO_H
>>
>> diff --git a/hw/misc/neorv32_sysinfo_rtl.h b/hw/misc/neorv32_sysinfo_rtl.h
>> new file mode 100644
>> index 0000000000..594e251c5b
>> --- /dev/null
>> +++ b/hw/misc/neorv32_sysinfo_rtl.h
>> @@ -0,0 +1,134 @@
>> +// #################################################################################################
>> +// # << NEORV32: neorv32_sysinfo.h - System Information Memory (SYSINFO) HW Driver >>              #
>> +// # ********************************************************************************************* #
>> +// # BSD 3-Clause License                                                                          #
>> +// #                                                                                               #
>> +// # Copyright (c) 2023, Stephan Nolting. All rights reserved.                                     #
>> +// #                                                                                               #
>> +// # Redistribution and use in source and binary forms, with or without modification, are          #
>> +// # permitted provided that the following conditions are met:                                     #
>> +// #                                                                                               #
>> +// # 1. Redistributions of source code must retain the above copyright notice, this list of        #
>> +// #    conditions and the following disclaimer.                                                   #
>> +// #                                                                                               #
>> +// # 2. Redistributions in binary form must reproduce the above copyright notice, this list of     #
>> +// #    conditions and the following disclaimer in the documentation and/or other materials        #
>> +// #    provided with the distribution.                                                            #
>> +// #                                                                                               #
>> +// # 3. Neither the name of the copyright holder nor the names of its contributors may be used to  #
>> +// #    endorse or promote products derived from this software without specific prior written      #
>> +// #    permission.                                                                                #
>> +// #                                                                                               #
>> +// # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS   #
>> +// # OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF               #
>> +// # MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE    #
>> +// # COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     #
>> +// # EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE #
>> +// # GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED    #
>> +// # AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING     #
>> +// # NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED  #
>> +// # OF THE POSSIBILITY OF SUCH DAMAGE.                                                            #
>> +// # ********************************************************************************************* #
>> +// # The NEORV32 Processor - https://github.com/stnolting/neorv32              (c) Stephan Nolting #
>> +// #################################################################################################
>> +
>> +
>> +/**********************************************************************//**
>> + * @file neorv32_cfs.h
>> + * @brief System Configuration Information Memory (SYSINFO) HW driver header file.
>> + **************************************************************************/
> Can we cleanup the autogen file
>
> Alistair
Done in later patch series.
>> +
>> +#ifndef neorv32_sysinfo_h
>> +#define neorv32_sysinfo_h
>> +
>> +/**********************************************************************//**
>> + * @name IO Device: System Configuration Information Memory (SYSINFO)
>> + **************************************************************************/
>> +/**@{*/
>> +/** SYSINFO module prototype - whole module is read-only */
>> +typedef volatile struct __attribute__((packed,aligned(4))) {
>> +        uint32_t CLK;   /**< offset 0:  Clock speed in Hz */
>> +  const uint32_t MISC;  /**< offset 4:  Miscellaneous system configurations (#NEORV32_SYSINFO_MISC_enum) */
>> +  const uint32_t SOC;   /**< offset 8:  SoC features (#NEORV32_SYSINFO_SOC_enum) */
>> +  const uint32_t CACHE; /**< offset 12: Cache configuration (#NEORV32_SYSINFO_CACHE_enum) */
>> +} neorv32_sysinfo_t;
>> +
>> +/** SYSINFO module hardware access (#neorv32_sysinfo_t) */
>> +#define NEORV32_SYSINFO ((neorv32_sysinfo_t*) (NEORV32_SYSINFO_BASE))
>> +
>> +/** NEORV32_SYSINFO.MISC (r/-): Miscellaneous system configurations */
>> +enum NEORV32_SYSINFO_MISC_enum {
>> +  SYSINFO_MISC_IMEM_LSB =  0, /**< SYSINFO_MISC  (0) (r/-): log2(internal IMEM size in bytes) (via IMEM_SIZE generic), LSB */
>> +  SYSINFO_MISC_IMEM_MBS =  7, /**< SYSINFO_MISC  (7) (r/-): log2(internal IMEM size in bytes) (via IMEM_SIZE generic), MSB */
>> +
>> +  SYSINFO_MISC_DMEM_LSB =  8, /**< SYSINFO_MISC  (8) (r/-): log2(internal DMEM size in bytes) (via DMEM_SIZE generic), LSB */
>> +  SYSINFO_MISC_DMEM_MSB = 15, /**< SYSINFO_MISC (15) (r/-): log2(internal DMEM size in bytes) (via DMEM_SIZE generic), MSB */
>> +
>> +  SYSINFO_MISC_HART_LSB = 16, /**< SYSINFO_MISC (16) (r/-): number of physical CPU cores ("harts"), LSB */
>> +  SYSINFO_MISC_HART_MSB = 19, /**< SYSINFO_MISC (19) (r/-): number of physical CPU cores ("harts"), MSB */
>> +
>> +  SYSINFO_MISC_BOOT_LSB = 20, /**< SYSINFO_MISC (20) (r/-): boot mode configuration (via BOOT_MODE_SELECT generic), LSB */
>> +  SYSINFO_MISC_BOOT_MSB = 21, /**< SYSINFO_MISC (21) (r/-): boot mode configuration (via BOOT_MODE_SELECT generic), MSB */
>> +
>> +  SYSINFO_MISC_ITMO_LSB = 22, /**< SYSINFO_MISC (22) (r/-): log2(internal bus timeout cycles), LSB */
>> +  SYSINFO_MISC_ITMO_MSB = 26, /**< SYSINFO_MISC (26) (r/-): log2(internal bus timeout cycles), MSB */
>> +
>> +  SYSINFO_MISC_ETMO_LSB = 27, /**< SYSINFO_MISC (27) (r/-): log2(external bus timeout cycles), LSB */
>> +  SYSINFO_MISC_ETMO_MSB = 31  /**< SYSINFO_MISC (31) (r/-): log2(external bus timeout cycles), MSB */
>> +};
>> +
>> +/** NEORV32_SYSINFO.SOC (r/-): Implemented processor devices/features */
>> +enum NEORV32_SYSINFO_SOC_enum {
>> +  SYSINFO_SOC_BOOTLOADER =  0, /**< SYSINFO_SOC  (0) (r/-): Bootloader implemented when 1 (via BOOT_MODE_SELECT generic) */
>> +  SYSINFO_SOC_XBUS       =  1, /**< SYSINFO_SOC  (1) (r/-): External bus interface implemented when 1 (via XBUS_EN generic) */
>> +  SYSINFO_SOC_IMEM       =  2, /**< SYSINFO_SOC  (2) (r/-): Processor-internal instruction memory implemented when 1 (via IMEM_EN generic) */
>> +  SYSINFO_SOC_DMEM       =  3, /**< SYSINFO_SOC  (3) (r/-): Processor-internal data memory implemented when 1 (via DMEM_EN generic) */
>> +  SYSINFO_SOC_OCD        =  4, /**< SYSINFO_SOC  (4) (r/-): On-chip debugger implemented when 1 (via OCD_EN generic) */
>> +  SYSINFO_SOC_ICACHE     =  5, /**< SYSINFO_SOC  (5) (r/-): Processor-internal instruction cache implemented when 1 (via ICACHE_EN generic) */
>> +  SYSINFO_SOC_DCACHE     =  6, /**< SYSINFO_SOC  (6) (r/-): Processor-internal instruction cache implemented when 1 (via DCACHE_EN generic) */
>> +//SYSINFO_SOC_reserved   =  7, /**< SYSINFO_SOC  (7) (r/-): reserved */
>> +//SYSINFO_SOC_reserved   =  8, /**< SYSINFO_SOC  (8) (r/-): reserved */
>> +//SYSINFO_SOC_reserved   =  9, /**< SYSINFO_SOC  (9) (r/-): reserved */
>> +//SYSINFO_SOC_reserved   = 10, /**< SYSINFO_SOC (10) (r/-): reserved */
>> +  SYSINFO_SOC_OCD_AUTH   = 11, /**< SYSINFO_SOC (11) (r/-): On-chip debugger authentication implemented when 1 (via OCD_AUTHENTICATION generic) */
>> +  SYSINFO_SOC_IMEM_ROM   = 12, /**< SYSINFO_SOC (12) (r/-): Processor-internal instruction memory implemented as pre-initialized ROM when 1 (via BOOT_MODE_SELECT generic) */
>> +  SYSINFO_SOC_IO_TWD     = 13, /**< SYSINFO_SOC (13) (r/-): Two-wire device implemented when 1 (via IO_TWD_EN generic) */
>> +  SYSINFO_SOC_IO_DMA     = 14, /**< SYSINFO_SOC (14) (r/-): Direct memory access controller implemented when 1 (via IO_DMA_EN generic) */
>> +  SYSINFO_SOC_IO_GPIO    = 15, /**< SYSINFO_SOC (15) (r/-): General purpose input/output port unit implemented when 1 (via IO_GPIO_EN generic) */
>> +  SYSINFO_SOC_IO_CLINT   = 16, /**< SYSINFO_SOC (16) (r/-): Core local interruptor implemented when 1 (via IO_CLINT_EN generic) */
>> +  SYSINFO_SOC_IO_UART0   = 17, /**< SYSINFO_SOC (17) (r/-): Primary universal asynchronous receiver/transmitter 0 implemented when 1 (via IO_UART0_EN generic) */
>> +  SYSINFO_SOC_IO_SPI     = 18, /**< SYSINFO_SOC (18) (r/-): Serial peripheral interface implemented when 1 (via IO_SPI_EN generic) */
>> +  SYSINFO_SOC_IO_TWI     = 19, /**< SYSINFO_SOC (19) (r/-): Two-wire interface implemented when 1 (via IO_TWI_EN generic) */
>> +  SYSINFO_SOC_IO_PWM     = 20, /**< SYSINFO_SOC (20) (r/-): Pulse-width modulation unit implemented when 1 (via IO_PWM_EN generic) */
>> +  SYSINFO_SOC_IO_WDT     = 21, /**< SYSINFO_SOC (21) (r/-): Watchdog timer implemented when 1 (via IO_WDT_EN generic) */
>> +  SYSINFO_SOC_IO_CFS     = 22, /**< SYSINFO_SOC (22) (r/-): Custom functions subsystem implemented when 1 (via IO_CFS_EN generic) */
>> +  SYSINFO_SOC_IO_TRNG    = 23, /**< SYSINFO_SOC (23) (r/-): True random number generator implemented when 1 (via IO_TRNG_EN generic) */
>> +  SYSINFO_SOC_IO_SDI     = 24, /**< SYSINFO_SOC (24) (r/-): Serial data interface implemented when 1 (via IO_SDI_EN generic) */
>> +  SYSINFO_SOC_IO_UART1   = 25, /**< SYSINFO_SOC (25) (r/-): Secondary universal asynchronous receiver/transmitter 1 implemented when 1 (via IO_UART1_EN generic) */
>> +  SYSINFO_SOC_IO_NEOLED  = 26, /**< SYSINFO_SOC (26) (r/-): NeoPixel-compatible smart LED interface implemented when 1 (via IO_NEOLED_EN generic) */
>> +  SYSINFO_SOC_IO_TRACER  = 27, /**< SYSINFO_SOC (10) (r/-): Execution tracer implemented when 1 (via IO_TRACER_EN generic) */
>> +  SYSINFO_SOC_IO_GPTMR   = 28, /**< SYSINFO_SOC (28) (r/-): General purpose timer implemented when 1 (via IO_GPTMR_EN generic) */
>> +  SYSINFO_SOC_IO_SLINK   = 29, /**< SYSINFO_SOC (29) (r/-): Stream link interface implemented when 1 (via IO_SLINK_EN generic) */
>> +  SYSINFO_SOC_IO_ONEWIRE = 30  /**< SYSINFO_SOC (30) (r/-): 1-wire interface controller implemented when 1 (via IO_ONEWIRE_EN generic) */
>> +//SYSINFO_SOC_reserved   = 31  /**< SYSINFO_SOC (31) (r/-): reserved */
>> +};
>> +
>> +/** NEORV32_SYSINFO.CACHE (r/-): Cache configuration */
>> + enum NEORV32_SYSINFO_CACHE_enum {
>> +  SYSINFO_CACHE_INST_BLOCK_SIZE_0 =  0, /**< SYSINFO_CACHE  (0) (r/-): i-cache: log2(Block size in bytes), bit 0 (via CACHE_BLOCK_SIZE generic) */
>> +  SYSINFO_CACHE_INST_BLOCK_SIZE_3 =  3, /**< SYSINFO_CACHE  (3) (r/-): i-cache: log2(Block size in bytes), bit 3 (via CACHE_BLOCK_SIZE generic) */
>> +  SYSINFO_CACHE_INST_NUM_BLOCKS_0 =  4, /**< SYSINFO_CACHE  (4) (r/-): i-cache: log2(Number of cache blocks), bit 0 (via ICACHE_NUM_BLOCKS generic) */
>> +  SYSINFO_CACHE_INST_NUM_BLOCKS_3 =  7, /**< SYSINFO_CACHE  (7) (r/-): i-cache: log2(Number of cache blocks), bit 3 (via ICACHE_NUM_BLOCKS generic) */
>> +
>> +  SYSINFO_CACHE_DATA_BLOCK_SIZE_0 =  8, /**< SYSINFO_CACHE  (8) (r/-): d-cache: log2(Block size in bytes), bit 0 (via CACHE_BLOCK_SIZE generic) */
>> +  SYSINFO_CACHE_DATA_BLOCK_SIZE_3 = 11, /**< SYSINFO_CACHE (11) (r/-): d-cache: log2(Block size in bytes), bit 3 (via CACHE_BLOCK_SIZE generic) */
>> +  SYSINFO_CACHE_DATA_NUM_BLOCKS_0 = 12, /**< SYSINFO_CACHE (12) (r/-): d-cache: log2(Number of cache blocks), bit 0 (via DCACHE_NUM_BLOCKS generic) */
>> +  SYSINFO_CACHE_DATA_NUM_BLOCKS_3 = 15, /**< SYSINFO_CACHE (15) (r/-): d-cache: log2(Number of cache blocks), bit 3 (via DCACHE_NUM_BLOCKS generic) */
>> +
>> +  SYSINFO_CACHE_INST_BURSTS_EN    = 16, /**< SYSINFO_CACHE (16) (r/-): i-cache: issue burst transfers or cache update (via CACHE_BURSTS_EN generic) */
>> +  SYSINFO_CACHE_DATA_BURSTS_EN    = 24  /**< SYSINFO_CACHE (14) (r/-): d-cache: issue burst transfers or cache update (via CACHE_BURSTS_EN generic) */
>> +};
>> +/**@}*/
>> +
>> +
>> +#endif // neorv32_sysinfo_h
>>

