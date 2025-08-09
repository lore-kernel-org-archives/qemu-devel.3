Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A89C87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 16:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukmeL-0007Q9-6V; Sat, 09 Aug 2025 12:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmeI-0007P6-W1
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:42:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukmeE-0003xK-Sd
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 12:42:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76c3607d960so3367902b3a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 09:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754757740; x=1755362540; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IajzPP7n/1t1sz9qJp7hoAlMifuuQ6hE5b37OTIRbjE=;
 b=MfDyuGigDoV5mYQGYnvX0U/bHHF93cN4nQmmIiKbogHLpJAuHroDQZIVsJK3SNFaVH
 /3pDsl4glUxsmilEDk2Z68cicXFgiX62Ab2bE5adHsR9l/K/7CcMlXO8iT7iTfMuwPuZ
 dZyWlubAIQi7zoWmvztVlSpW8ggIYd7Lrg/Mg3PyEy3+xB9EQSC2P1oVV1ttwi0qcuFz
 psP3OkZovgXdwoYaFq5bgVIcE9R8XySCXxiCHSTyHD4ghdaDIhd+rC9C3QsOAknPO62V
 4pXELd5TO7F0ygy0PE3/cM8xDHnwm9ikyjIJ5loNsLxciDErQvVr32v2QbyhaNgVQjG+
 YesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754757740; x=1755362540;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IajzPP7n/1t1sz9qJp7hoAlMifuuQ6hE5b37OTIRbjE=;
 b=ICXLOYei90bYKLeH2Ysj3oM4g5nvBF2s/Hb9PuZQWuG7mk75YsNM5pw66RzEwCMFkU
 wMdeMXgcDipk86rau5WKgO+BIrugwidFZgdtiSLIwB3hqvDk92ZpkWZQF+lVijVKw7nI
 pHLFsf6ui48Yk2BvjSCEFDjSJTwh7tRaKCQ3GVsm+EFRlZ8wET5iOuWhrmi3Uwspv7+e
 z6qaxTnVn/i/wOvA9tUuwheHzdHn8YGJpdh8lPKABK+UKU6ZowstS7TjHaTE/1BpwZz1
 OgqEivzCEGdBy3MLBnP6dit21nzeLr25GlFoaEl97BoBdlXDPJGn3qOILldHYAel/Tlp
 idIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFhtt1sftg//Hq/gho9lVWmEzGRfuZ1oiEEankvKS5KLwuGmEGRx6Ro7KLk5xGG++ueMu9qjuB802v@nongnu.org
X-Gm-Message-State: AOJu0YzSMUVxrZAhrwGF4aCDOoA4xuB0vA0VHvcAR0V+28YIUncOfFYy
 im/6pPi67PaI0IKbGvzLo60npon4oPD0AJP9p5kgBg5AaQoYzubmqRwBjoFAaZI2/y4=
X-Gm-Gg: ASbGncuN4bKiy0DjpjRrdY4hNJymJubhcNGK9Sjlyi00swVxJ5Rkp0LzjAb2khu+ZYU
 gri8wnzKhNNnwtTFqQkatyTJ1hgJ7ZVg+TzQtkE3R2dYt4ohh53+PqgIp3pCWh61Jb38gYTEbIn
 WzmKge8iRky/x8b8HimFSig3a9w54Z8HtTYDpLJvO/u8D0qHE/3kNJdHB9zjJ/yXEoN0F90EBR3
 t1WML9h3Q2UOsYvdWvJOjL9jn8vAVEpooEiiEhX+a3QQHH7xJrq8cQAknMe4sb76ZOMi0IvRJDy
 KZbDkqGxMXW9PSBOFiHTPmJJgrFQsACfx4AaHwy8eSC9VeayCJrs/GRDF9wk1KbSxkWhPQ8y/wu
 xXP7IBiO4c3vPk9gyrt8US/J+JFLCVpWjegXNRH4i8Kshs3oX
X-Google-Smtp-Source: AGHT+IGrHztTVxsIZwvbERqD2BQnP7SvEw3ExT1ByWLFed+z/1ikeCHVS56IDnF0v5fHEkTY168DdQ==
X-Received: by 2002:a05:6a00:17a0:b0:748:eedb:902a with SMTP id
 d2e1a72fcca58-76c4619ff08mr9605087b3a.17.1754757739852; 
 Sat, 09 Aug 2025 09:42:19 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bea205365sm18395362b3a.83.2025.08.09.09.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 09:42:19 -0700 (PDT)
Message-ID: <302021ef-7960-4610-bed2-99405765f530@ventanamicro.com>
Date: Sat, 9 Aug 2025 13:42:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] hw/misc: riscv_wgchecker: Implement wgchecker
 slot registers
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-16-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-16-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> wgChecker slot is similar to PMP region. SW could program each slot to
> configure the permission of address range.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/misc/riscv_wgchecker.c          | 330 +++++++++++++++++++++++++++++
>   hw/misc/riscv_worldguard.c         |   3 +
>   include/hw/misc/riscv_worldguard.h |   4 +
>   3 files changed, 337 insertions(+)
> 
> diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
> index ea50f4f53a..8839d898c9 100644
> --- a/hw/misc/riscv_wgchecker.c
> +++ b/hw/misc/riscv_wgchecker.c
> @@ -53,6 +53,52 @@ REG64(ERRCAUSE,             0x010)
>        R_ERRCAUSE_IP_MASK)
>   
>   REG64(ERRADDR,              0x018)
> +REG64(WGC_SLOT,             0x020)
> +
> +/* wgChecker slots */
> +REG64(SLOT_ADDR,            0x000)
> +REG64(SLOT_PERM,            0x008)
> +REG32(SLOT_CFG,             0x010)
> +    FIELD(SLOT_CFG, A,          0,  2)
> +    FIELD(SLOT_CFG, ER,         8,  1)
> +    FIELD(SLOT_CFG, EW,         9,  1)
> +    FIELD(SLOT_CFG, IR,         10, 1)
> +    FIELD(SLOT_CFG, IW,         11, 1)
> +    FIELD(SLOT_CFG, LOCK,       31, 1)
> +
> +#define SLOT_SIZE               0x020
> +
> +#define SLOT0_CFG_MASK \
> +    (R_SLOT_CFG_ER_MASK | \
> +     R_SLOT_CFG_EW_MASK | \
> +     R_SLOT_CFG_IR_MASK | \
> +     R_SLOT_CFG_IW_MASK | \
> +     R_SLOT_CFG_LOCK_MASK)
> +
> +#define SLOT_CFG_MASK \
> +    (R_SLOT_CFG_A_MASK  | (SLOT0_CFG_MASK))
> +
> +#define WGC_SLOT_END(nslots) \
> +    (A_WGC_SLOT + SLOT_SIZE * (nslots + 1))
> +
> +/* wgChecker slot is 4K alignment */
> +#define WG_ALIGNED_SIZE         (1 << 12)
> +#define WG_ALIGNED_MASK         MAKE_64BIT_MASK(0, 12)
> +
> +/* wgChecker slot address is (addr / 4). */
> +#define TO_SLOT_ADDR(addr)      ((addr) >> 2)
> +#define FROM_SLOT_ADDR(addr)    ((addr) << 2)
> +
> +/* wgChecker slot cfg.A[1:0] */
> +#define A_OFF                   0
> +#define A_TOR                   1
> +#define A_NA4                   2
> +#define A_NAPOT                 3
> +
> +/* wgChecker slot perm */
> +#define WGC_PERM(wid, perm)     ((uint64_t)(perm) << (2 * (wid)))
> +#define P_READ                  (1 << 0)
> +#define P_WRITE                 (1 << 1)
>   
>   /*
>    * Accesses only reach these read and write functions if the wgChecker
> @@ -146,6 +192,28 @@ static uint64_t riscv_wgchecker_readq(void *opaque, hwaddr addr)
>       RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
>       uint64_t val = 0;
>   
> +    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
> +        /* Read from WGC slot */
> +        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
> +        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
> +
> +        switch (slot_offset) {
> +        case A_SLOT_ADDR:
> +            val = s->slots[slot_id].addr;
> +            break;
> +        case A_SLOT_PERM:
> +            val = s->slots[slot_id].perm;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
> +                          __func__, addr, 8);
> +            break;
> +        }
> +
> +        return val;
> +    }
> +
>       switch (addr) {
>       case A_ERRCAUSE:
>           val = s->errcause & ERRCAUSE_MASK;
> @@ -171,6 +239,37 @@ static uint64_t riscv_wgchecker_readl(void *opaque, hwaddr addr)
>       RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
>       uint64_t val = 0;
>   
> +    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
> +        /* Read from WGC slot */
> +        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
> +        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
> +
> +        switch (slot_offset) {
> +        case A_SLOT_ADDR:
> +            val = extract64(s->slots[slot_id].addr, 0, 32);
> +            break;
> +        case A_SLOT_ADDR + 4:
> +            val = extract64(s->slots[slot_id].addr, 32, 32);
> +            break;
> +        case A_SLOT_PERM:
> +            val = extract64(s->slots[slot_id].perm, 0, 32);
> +            break;
> +        case A_SLOT_PERM + 4:
> +            val = extract64(s->slots[slot_id].perm, 32, 32);
> +            break;
> +        case A_SLOT_CFG:
> +            val = s->slots[slot_id].cfg & SLOT_CFG_MASK;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
> +                          __func__, addr, 4);
> +            break;
> +        }
> +
> +        return val;
> +    }
> +
>       switch (addr) {
>       case A_VENDOR:
>           val = 0;
> @@ -228,11 +327,121 @@ static uint64_t riscv_wgchecker_read(void *opaque, hwaddr addr, unsigned size)
>       return val;
>   }
>   
> +/*
> + * Validate the WGC slot address is between address range.
> + *
> + * Fix the slot address to the start address if it's not within the address range.
> + * We need validation when changing "slot address" or "TOR/NAPOT mode (cfg.A)"
> + */
> +static void validate_slot_address(void *opaque, int slot_id)
> +{
> +    RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
> +    uint64_t start = TO_SLOT_ADDR(s->addr_range_start);
> +    uint64_t end = TO_SLOT_ADDR(s->addr_range_start + s->addr_range_size);
> +    uint32_t cfg_a = FIELD_EX32(s->slots[slot_id].cfg, SLOT_CFG, A);
> +
> +    /* First and last slot address are hard-coded. */
> +    if ((slot_id == 0) || (slot_id == s->slot_count)) {
> +        return;
> +    }
> +
> +    /* Check WGC slot address is between address range. */
> +    if ((s->slots[slot_id].addr < start) || (s->slots[slot_id].addr >= end)) {
> +        s->slots[slot_id].addr = start;
> +    }
> +
> +    /* Check WGC slot is 4k-aligned. */
> +    if (cfg_a == A_TOR) {
> +        s->slots[slot_id].addr &= ~TO_SLOT_ADDR(WG_ALIGNED_MASK);
> +    } else if (cfg_a == A_NAPOT) {
> +        s->slots[slot_id].addr |= TO_SLOT_ADDR(WG_ALIGNED_MASK >> 1);
> +    } else if (cfg_a == A_NA4) {
> +        /* Forcely replace NA4 slot with 4K-aligned NAPOT slot. */
> +        FIELD_DP32(s->slots[slot_id].cfg, SLOT_CFG, A, A_NAPOT);
> +        s->slots[slot_id].addr |= TO_SLOT_ADDR(WG_ALIGNED_MASK >> 1);
> +    }
> +}
> +
> +static bool slots_reg_is_ro(int slot_id, int slot_offset, uint32_t nslots)
> +{
> +    /*
> +     * Special slots:
> +     *   - slot[0]:
> +     *     - addr is RO
> +     *     - perm is RO
> +     *     - cfg.A is OFF
> +     *
> +     *   - slot[nslots]:
> +     *     - addr is RO
> +     *     - cfg.A is OFF or TOR
> +     */
> +    if (slot_id == 0) {
> +        switch (slot_offset) {
> +        case A_SLOT_ADDR:
> +        case A_SLOT_ADDR + 4:
> +        case A_SLOT_PERM:
> +        case A_SLOT_PERM + 4:
> +            return true;
> +        default:
> +            break;
> +        }
> +    } else if (slot_id == nslots) {
> +        switch (slot_offset) {
> +        case A_SLOT_ADDR:
> +        case A_SLOT_ADDR + 4:
> +            return true;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
>                                       uint64_t value)
>   {
>       RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
>   
> +    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
> +        /* Read from WGC slot */
> +        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
> +        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
> +        bool locked = FIELD_EX32(s->slots[slot_id].cfg, SLOT_CFG, LOCK);
> +
> +        if (locked) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Couldn't write access to locked wgChecker Slot: "
> +                          "slot = %d, offset = %d\n", __func__, slot_id,
> +                          slot_offset);
> +            return;
> +        }
> +
> +        if (slots_reg_is_ro(slot_id, slot_offset, s->slot_count)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
> +                          __func__, addr, 8);
> +        }
> +
> +        switch (slot_offset) {
> +        case A_SLOT_ADDR:
> +            s->slots[slot_id].addr = value;
> +            validate_slot_address(s, slot_id);
> +            break;
> +        case A_SLOT_PERM:
> +            value &= wgc_slot_perm_mask;
> +            s->slots[slot_id].perm = value;
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
> +                          __func__, addr, 8);
> +            break;
> +        }
> +
> +        return;
> +    }
> +
>       switch (addr) {
>       case A_ERRCAUSE:
>           s->errcause = value & ERRCAUSE_MASK;
> @@ -253,6 +462,81 @@ static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
>   {
>       RISCVWgCheckerState *s = RISCV_WGCHECKER(opaque);
>   
> +    if ((addr >= A_WGC_SLOT) && (addr < WGC_SLOT_END(s->slot_count))) {
> +        /* Write to WGC slot */
> +        int slot_id = (addr - A_WGC_SLOT) / SLOT_SIZE;
> +        int slot_offset = (addr - A_WGC_SLOT) % SLOT_SIZE;
> +        bool locked = FIELD_EX32(s->slots[slot_id].cfg, SLOT_CFG, LOCK);
> +        int cfg_a, old_cfg_a;
> +
> +        if (locked) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Couldn't write access to locked wgChecker Slot: "
> +                          "slot = %d, offset = %d\n", __func__, slot_id,
> +                          slot_offset);
> +            return;
> +        }
> +
> +        if (slots_reg_is_ro(slot_id, slot_offset, s->slot_count)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
> +                          __func__, addr, 4);
> +        }
> +
> +        switch (slot_offset) {
> +        case A_SLOT_ADDR:
> +            s->slots[slot_id].addr = deposit64(
> +                s->slots[slot_id].addr, 0, 32, value);
> +            validate_slot_address(s, slot_id);
> +            break;
> +        case A_SLOT_ADDR + 4:
> +            s->slots[slot_id].addr = deposit64(
> +                s->slots[slot_id].addr, 32, 32, value);
> +            validate_slot_address(s, slot_id);
> +            break;
> +        case A_SLOT_PERM:
> +            value &= wgc_slot_perm_mask;
> +            s->slots[slot_id].perm = deposit64(
> +                s->slots[slot_id].perm, 0, 32, value);
> +            break;
> +        case A_SLOT_PERM + 4:
> +            value &= extract64(wgc_slot_perm_mask, 32, 32);
> +            s->slots[slot_id].perm = deposit64(
> +                s->slots[slot_id].perm, 32, 32, value);
> +            break;
> +        case A_SLOT_CFG:
> +            if (slot_id == 0) {
> +                value &= SLOT0_CFG_MASK;
> +                s->slots[0].cfg = value;
> +            } else if (slot_id == s->slot_count) {
> +                old_cfg_a = FIELD_EX32(s->slots[s->slot_count].cfg, SLOT_CFG, A);
> +                cfg_a = FIELD_EX32(value, SLOT_CFG, A);
> +
> +                value &= SLOT0_CFG_MASK;
> +                if ((cfg_a == A_OFF) || (cfg_a == A_TOR)) {
> +                    value |= cfg_a;
> +                } else {
> +                    /* slot[nslots] could only use OFF or TOR config. */
> +                    value |= old_cfg_a;
> +                }
> +                s->slots[s->slot_count].cfg = value;
> +
> +                validate_slot_address(s, slot_id);
> +            } else {
> +                value &= SLOT_CFG_MASK;
> +                s->slots[slot_id].cfg = value;
> +            }
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Unexpected memory access to (0x%" HWADDR_PRIX ", %u) \n",
> +                          __func__, addr, 4);
> +            break;
> +        }
> +
> +        return;
> +    }
> +
>       switch (addr) {
>       case A_ERRCAUSE:
>           value &= extract64(ERRCAUSE_MASK, 0, 32);
> @@ -460,6 +744,8 @@ static void riscv_wgchecker_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    s->slots = g_new0(WgCheckerSlot, s->slot_count + 1);
> +
>       memory_region_init_io(&s->mmio, OBJECT(dev), &riscv_wgchecker_ops, s,
>                             TYPE_RISCV_WGCHECKER, s->mmio_size);
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
> @@ -523,6 +809,37 @@ static void riscv_wgchecker_reset_enter(Object *obj, ResetType type)
>   
>       s->errcause = 0;
>       s->erraddr = 0;
> +
> +    for (int i = 0; i < nslots; i++) {
> +        s->slots[i].addr = TO_SLOT_ADDR(start);
> +        s->slots[i].perm = 0;
> +        s->slots[i].cfg = 0;
> +    }
> +    s->slots[nslots].addr = TO_SLOT_ADDR(end);
> +    s->slots[nslots].perm = 0;
> +    s->slots[nslots].cfg = 0;
> +
> +    if (s->num_default_slots != 0) {
> +        /*
> +         * Use default slots:
> +         *   slot[0] is hard-coded to start address, so the default slots
> +         *   start from slot[1].
> +         */
> +        memcpy(&s->slots[1], s->default_slots,
> +               sizeof(WgCheckerSlot) * s->num_default_slots);
> +    } else if ((s->hw_bypass) ||
> +               ((worldguard_config != NULL) && worldguard_config->hw_bypass)) {
> +        /* HW bypass mode */
> +        uint32_t trustedwid = worldguard_config->trustedwid;
> +
> +        if (trustedwid == NO_TRUSTEDWID) {
> +            trustedwid = worldguard_config->nworlds - 1;
> +        }
> +
> +        s->slots[nslots].perm = WGC_PERM(trustedwid, P_READ | P_WRITE);
> +        s->slots[nslots].perm &= wgc_slot_perm_mask;
> +        s->slots[nslots].cfg = A_TOR;
> +    }
>   }
>   
>   static void riscv_wgchecker_class_init(ObjectClass *klass, void *data)
> @@ -596,6 +913,19 @@ DeviceState *riscv_wgchecker_create(hwaddr addr, uint32_t size,
>           qdev_prop_set_uint64(dev, name_offset, region_offset[i]);
>       }
>   
> +    if (num_default_slots > slot_count) {
> +        num_default_slots = slot_count;
> +    }
> +
> +    s->num_default_slots = num_default_slots;
> +    if (s->num_default_slots) {
> +        s->default_slots = g_new0(WgCheckerSlot, s->num_default_slots);
> +        memcpy(s->default_slots, default_slots,
> +               sizeof(WgCheckerSlot) * s->num_default_slots);
> +    } else {
> +        s->default_slots = NULL;
> +    }
> +
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
> diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
> index 1a910f4cf3..59ca6d16e7 100644
> --- a/hw/misc/riscv_worldguard.c
> +++ b/hw/misc/riscv_worldguard.c
> @@ -38,6 +38,9 @@
>    */
>   struct RISCVWorldGuardState *worldguard_config = NULL;
>   
> +/* perm field bitmask of wgChecker slot, it's depends on NWorld. */
> +uint64_t wgc_slot_perm_mask = 0;
> +
>   static Property riscv_worldguard_properties[] = {
>       DEFINE_PROP_UINT32("nworlds", RISCVWorldGuardState, nworlds, 0),
>   
> diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
> index 7b5aae866a..f53202524c 100644
> --- a/include/hw/misc/riscv_worldguard.h
> +++ b/include/hw/misc/riscv_worldguard.h
> @@ -45,6 +45,7 @@ struct RISCVWorldGuardState {
>   };
>   
>   extern struct RISCVWorldGuardState *worldguard_config;
> +extern uint64_t wgc_slot_perm_mask;
>   
>   DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
>                                        bool hw_bypass, bool tz_compat);
> @@ -86,9 +87,12 @@ struct WgCheckerRegion {
>   struct RISCVWgCheckerState {
>       /*< private >*/
>       SysBusDevice parent_obj;
> +    uint32_t num_default_slots;
> +    WgCheckerSlot *default_slots;
>   
>       /*< public >*/
>       MemoryRegion mmio;
> +    WgCheckerSlot *slots;
>       qemu_irq irq;
>   
>       /* error reg */


