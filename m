Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA1DCFA745
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 05:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swaw0-0000yt-6S; Fri, 04 Oct 2024 01:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swavz-0000yP-8C
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 01:32:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swavw-0007gM-6J
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 01:32:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b95359440so15255995ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728019974; x=1728624774;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0Lp2TYdcaW+3AAR5Ylegl65MEfxyrg5UfbnhfL4AJo=;
 b=r/1eWPrLAYwwvwYjyou+dKR7Eg5EaP3HVBYRnwpyENeWSsf2FjFuRfqfynTXBYHfu6
 cyJzrtcyuNudnVm7sVLhs6uqYMfoP0yOUMT7jBltriD5VdjyGRl+J7aqjuDx3C/3wTde
 lgL0+L+TDNlkAHEvRgltYTTbGEqBA5RHYYmk5ksfaOB8HFS1LryUlHRV7xo8BiVzkVm5
 C0LKuSebDSrH7eLaRWnTA/dnwUHk9sTTsyJEl5P1rnCS3eFF7HT0FYxSdVZSeWvp6Kpc
 DKnQNxseJeJWc5Fm/i8IkhywH3G6O9sZWzyjKNjDVVybFEW9ReHw7KhoD8l08/zhrnAZ
 Gq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728019974; x=1728624774;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0Lp2TYdcaW+3AAR5Ylegl65MEfxyrg5UfbnhfL4AJo=;
 b=K5oALB96adaqiGn5vH2d+6mOO0R7UIviyWTGr+WkRF9lBirCWQLSxWHAfNqtaBQD6q
 sXD2SJIA+bgGILGc7dSm1N303iEGQfdgrCKVMOYU2J5MAKA6OfX8RlWDz01gORLjiBXV
 Z4dDyyVoy/3cn/NAeYe0DY61/HuuawI/S3B+AZxUnFrbFrw69ORQDSnxFCZZQLcm5/3a
 3v2sO1jzimBEUUEQBf/uYuJgakfiEOm2CEhE0683lFQ9y3Pqz9RkEsgoK6hmee7EYUiX
 a/thQrBooMsa+qDN39MQvD+GS25JZWIECAtzW6w0DxeEMjyfQ6I1XVGQjjo+iWkxwqFF
 hVrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc+2ehlEoYWnvfAf6BReD7jSST9/B0d3mtWkHXqOKmV8wDtzMIC1nigv/EDTZAu0nYwKavHVu6eB3G@nongnu.org
X-Gm-Message-State: AOJu0YzvcULEH9+MBjdg1ElN1pc8wlkNz3eHdFJP//8sy3F9D9TWuT7T
 t338rwWe/0SvkFoG7okLdTQWh7DXeBk+uVOzut+kqiQbsnGxtC/gPuJHB5dDYxU=
X-Google-Smtp-Source: AGHT+IE1XxdpSruYyssf/o/K5ceQnAkiiCDhLYWUVun2NJWBMn2//RTFja9+kkgt+SmXBFRltoNCmQ==
X-Received: by 2002:a17:903:2447:b0:20b:bdbf:da82 with SMTP id
 d9443c01a7336-20bfde554famr25917325ad.9.1728019974450; 
 Thu, 03 Oct 2024 22:32:54 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20bef70712esm17173045ad.265.2024.10.03.22.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 22:32:53 -0700 (PDT)
Message-ID: <6f0e5a6a-ea1b-48ae-b3d5-6a68cc0366d2@daynix.com>
Date: Fri, 4 Oct 2024 14:32:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] hw/vmapple/aes: Introduce aes engine
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20240928085727.56883-1-phil@philjordan.eu>
 <20240928085727.56883-11-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-11-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/09/28 17:57, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> VMApple contains an "aes" engine device that it uses to encrypt and
> decrypt its nvram. It has trivial hard coded keys it uses for that
> purpose.
> 
> Add device emulation for this device model.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> ---
> v3:
> 
>   * Rebased on latest upstream and fixed minor breakages.
>   * Replaced legacy device reset method with Resettable method
> 
>   hw/vmapple/Kconfig      |   2 +
>   hw/vmapple/aes.c        | 584 ++++++++++++++++++++++++++++++++++++++++
>   hw/vmapple/meson.build  |   1 +
>   hw/vmapple/trace-events |  19 ++
>   4 files changed, 606 insertions(+)
>   create mode 100644 hw/vmapple/aes.c
> 
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index 8b137891791..a73504d5999 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -1 +1,3 @@
> +config VMAPPLE_AES
> +    bool
>   
> diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
> new file mode 100644
> index 00000000000..074fbdd9c36
> --- /dev/null
> +++ b/hw/vmapple/aes.c
> @@ -0,0 +1,584 @@
> +/*
> + * QEMU Apple AES device emulation
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +#include "hw/sysbus.h"
> +#include "crypto/hash.h"
> +#include "crypto/aes.h"
> +#include "crypto/cipher.h"
> +
> +#define TYPE_AES          "apple-aes"
> +#define MAX_FIFO_SIZE     9
> +
> +#define CMD_KEY           0x1
> +#define CMD_KEY_CONTEXT_SHIFT    27
> +#define CMD_KEY_CONTEXT_MASK     (0x1 << CMD_KEY_CONTEXT_SHIFT)
> +#define CMD_KEY_SELECT_SHIFT     24
> +#define CMD_KEY_SELECT_MASK      (0x7 << CMD_KEY_SELECT_SHIFT)
> +#define CMD_KEY_KEY_LEN_SHIFT    22
> +#define CMD_KEY_KEY_LEN_MASK     (0x3 << CMD_KEY_KEY_LEN_SHIFT)
> +#define CMD_KEY_ENCRYPT_SHIFT    20
> +#define CMD_KEY_ENCRYPT_MASK     (0x1 << CMD_KEY_ENCRYPT_SHIFT)
> +#define CMD_KEY_BLOCK_MODE_SHIFT 16
> +#define CMD_KEY_BLOCK_MODE_MASK  (0x3 << CMD_KEY_BLOCK_MODE_SHIFT)
> +#define CMD_IV            0x2
> +#define CMD_IV_CONTEXT_SHIFT     26
> +#define CMD_IV_CONTEXT_MASK      (0x3 << CMD_KEY_CONTEXT_SHIFT)
> +#define CMD_DSB           0x3
> +#define CMD_SKG           0x4
> +#define CMD_DATA          0x5
> +#define CMD_DATA_KEY_CTX_SHIFT   27
> +#define CMD_DATA_KEY_CTX_MASK    (0x1 << CMD_DATA_KEY_CTX_SHIFT)
> +#define CMD_DATA_IV_CTX_SHIFT    25
> +#define CMD_DATA_IV_CTX_MASK     (0x3 << CMD_DATA_IV_CTX_SHIFT)
> +#define CMD_DATA_LEN_MASK        0xffffff
> +#define CMD_STORE_IV      0x6
> +#define CMD_STORE_IV_ADDR_MASK   0xffffff
> +#define CMD_WRITE_REG     0x7
> +#define CMD_FLAG          0x8
> +#define CMD_FLAG_STOP_MASK       BIT(26)
> +#define CMD_FLAG_RAISE_IRQ_MASK  BIT(27)
> +#define CMD_FLAG_INFO_MASK       0xff
> +#define CMD_MAX           0x10
> +
> +#define CMD_SHIFT         28
> +
> +#define REG_STATUS            0xc
> +#define REG_STATUS_DMA_READ_RUNNING     BIT(0)
> +#define REG_STATUS_DMA_READ_PENDING     BIT(1)
> +#define REG_STATUS_DMA_WRITE_RUNNING    BIT(2)
> +#define REG_STATUS_DMA_WRITE_PENDING    BIT(3)
> +#define REG_STATUS_BUSY                 BIT(4)
> +#define REG_STATUS_EXECUTING            BIT(5)
> +#define REG_STATUS_READY                BIT(6)
> +#define REG_STATUS_TEXT_DPA_SEEDED      BIT(7)
> +#define REG_STATUS_UNWRAP_DPA_SEEDED    BIT(8)
> +
> +#define REG_IRQ_STATUS        0x18
> +#define REG_IRQ_STATUS_INVALID_CMD      BIT(2)
> +#define REG_IRQ_STATUS_FLAG             BIT(5)
> +#define REG_IRQ_ENABLE        0x1c
> +#define REG_WATERMARK         0x20
> +#define REG_Q_STATUS          0x24
> +#define REG_FLAG_INFO         0x30
> +#define REG_FIFO              0x200
> +
> +static const uint32_t key_lens[4] = {

I suggest deriving the size from CMD_KEY_KEY_LEN_MASK.

> +    [0] = 16,
> +    [1] = 24,
> +    [2] = 32,
> +    [3] = 64,
> +};
> +
> +struct key {

Please add typedef.

> +    uint32_t key_len;
> +    uint32_t key[8];
> +};
> +
> +struct iv {
> +    uint32_t iv[4];
> +};
> +
> +struct context {
> +    struct key key;
> +    struct iv iv;
> +};
> +
> +static struct key builtin_keys[7] = {
 > +    [1] = {> +        .key_len = 32,
> +        .key = { 0x1 },
> +    },
> +    [2] = {
> +        .key_len = 32,
> +        .key = { 0x2 },
> +    },
> +    [3] = {
> +        .key_len = 32,
> +        .key = { 0x3 },
> +    }
> +};
> +
> +typedef struct AESState {
> +    /* Private */

This private/public comments are unnecessary; this struct can be 
referenced only from this file and all members are automatically private.

> +    SysBusDevice parent_obj;
> +
> +    /* Public */
> +    qemu_irq irq;
> +    MemoryRegion iomem1;
> +    MemoryRegion iomem2;
> +
> +    uint32_t status;
> +    uint32_t q_status;
> +    uint32_t irq_status;
> +    uint32_t irq_enable;
> +    uint32_t watermark;
> +    uint32_t flag_info;
> +    uint32_t fifo[MAX_FIFO_SIZE];
> +    uint32_t fifo_idx;
> +    struct key key[2];
> +    struct iv iv[4];
> +    bool is_encrypt;
> +    QCryptoCipherMode block_mode;
> +} AESState;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AESState, AES)
> +
> +static void aes_update_irq(AESState *s)
> +{
> +    qemu_set_irq(s->irq, !!(s->irq_status & s->irq_enable));
> +}
> +
> +static uint64_t aes1_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    AESState *s = opaque;
> +    uint64_t res = 0;
> +
> +    switch (offset) {
> +    case REG_STATUS:
> +        res = s->status;
> +        break;
> +    case REG_IRQ_STATUS:
> +        res = s->irq_status;
> +        break;
> +    case REG_IRQ_ENABLE:
> +        res = s->irq_enable;
> +        break;
> +    case REG_WATERMARK:
> +        res = s->watermark;
> +        break;
> +    case REG_Q_STATUS:
> +        res = s->q_status;
> +        break;
> +    case REG_FLAG_INFO:
> +        res = s->flag_info;
> +        break;
> +
> +    default:
> +        trace_aes_read_unknown(offset);

Use: LOG_UNIMP

> +        break;
> +    }
> +
> +    trace_aes_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void fifo_append(AESState *s, uint64_t val)
> +{
> +    if (s->fifo_idx == MAX_FIFO_SIZE) {
> +        /* Exceeded the FIFO. Bail out */
> +        return;
> +    }
> +
> +    s->fifo[s->fifo_idx++] = val;
> +}
> +
> +static bool has_payload(AESState *s, uint32_t elems)
> +{
> +    return s->fifo_idx >= (elems + 1);
> +}
> +
> +static bool cmd_key(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t key_select = (cmd & CMD_KEY_SELECT_MASK) >> CMD_KEY_SELECT_SHIFT;
> +    uint32_t ctxt = (cmd & CMD_KEY_CONTEXT_MASK) >> CMD_KEY_CONTEXT_SHIFT;
> +    uint32_t key_len;
> +
> +    switch ((cmd & CMD_KEY_BLOCK_MODE_MASK) >> CMD_KEY_BLOCK_MODE_SHIFT) {
> +    case 0:
> +        s->block_mode = QCRYPTO_CIPHER_MODE_ECB;
> +        break;
> +    case 1:
> +        s->block_mode = QCRYPTO_CIPHER_MODE_CBC;
> +        break;
> +    default:
> +        return false;
> +    }
> +
> +    s->is_encrypt = !!((cmd & CMD_KEY_ENCRYPT_MASK) >> CMD_KEY_ENCRYPT_SHIFT);

CMD_KEY_ENCRYPT_SHIFT is unnecessary as in case of 
CMD_FLAG_RAISE_IRQ_MASK. "!!" is also unnecessary; it will be implicitly 
casted into bool.

> +    key_len = key_lens[((cmd & CMD_KEY_KEY_LEN_MASK) >> CMD_KEY_KEY_LEN_SHIFT)];
> +
> +    if (key_select) {
> +        trace_aes_cmd_key_select_builtin(ctxt, key_select,
> +                                         s->is_encrypt ? "en" : "de",
> +                                         QCryptoCipherMode_str(s->block_mode));
> +        s->key[ctxt] = builtin_keys[key_select];

I guess this should be: builtin_keys[key_select - 1]

> +    } else {
> +        trace_aes_cmd_key_select_new(ctxt, key_len,
> +                                     s->is_encrypt ? "en" : "de",
> +                                     QCryptoCipherMode_str(s->block_mode));
> +        if (key_len > sizeof(s->key[ctxt].key)) {
> +            return false;
> +        }
> +        if (!has_payload(s, key_len / sizeof(uint32_t))) {
> +            /* wait for payload */
> +            return false;
> +        }
> +        memcpy(&s->key[ctxt].key, &s->fifo[1], key_len);
> +        s->key[ctxt].key_len = key_len;
> +    }
> +
> +    return true;
> +}
> +
> +static bool cmd_iv(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t ctxt = (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SHIFT;
> +
> +    if (!has_payload(s, 4)) {
> +        /* wait for payload */
> +        return false;
> +    }
> +    memcpy(&s->iv[ctxt].iv, &s->fifo[1], sizeof(s->iv[ctxt].iv));
> +    trace_aes_cmd_iv(ctxt, s->fifo[1], s->fifo[2], s->fifo[3], s->fifo[4]);
> +
> +    return true;
> +}
> +
> +static char hexdigit2str(uint8_t val)
> +{
> +    g_assert(val < 0x10);
> +    if (val >= 0xa) {
> +        return 'a' + (val - 0xa);
> +    } else {
> +        return '0' + val;
> +    }
> +}
> +
> +static void dump_data(const char *desc, const void *p, size_t len)
> +{
> +    char *hex = alloca((len * 2) + 1);

Don't use alloca(); use a fixed-length array instead.

> +    const uint8_t *data = p;
> +    char *hexp = hex;
> +    size_t i;
> +
> +    if (len > 0x1000) {
> +        /* Too large buffer, let's bail out */
> +        return;
> +    }
> +
> +    for (i = 0; i < len; i++) {
> +        uint8_t val = data[i];
> +        *(hexp++) = hexdigit2str(val >> 4);
> +        *(hexp++) = hexdigit2str(val & 0xf);
> +    }
> +    *hexp = '\0';

Let's move this to: util/hexdump.c

> +
> +    trace_aes_dump_data(desc, hex);
> +}
> +
> +static bool cmd_data(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t ctxt_iv = 0;
> +    uint32_t ctxt_key = (cmd & CMD_DATA_KEY_CTX_MASK) >> CMD_DATA_KEY_CTX_SHIFT;
> +    uint32_t len = cmd & CMD_DATA_LEN_MASK;
> +    uint64_t src_addr = s->fifo[2];
> +    uint64_t dst_addr = s->fifo[3];
> +    QCryptoCipherAlgo alg;
> +    QCryptoCipher *cipher;
> +    char *src;
> +    char *dst;
> +
> +    src_addr |= ((uint64_t)s->fifo[1] << 16) & 0xffff00000000ULL;
> +    dst_addr |= ((uint64_t)s->fifo[1] << 32) & 0xffff00000000ULL;
> +
> +    trace_aes_cmd_data(ctxt_key, ctxt_iv, src_addr, dst_addr, len);
> +
> +    if (!has_payload(s, 3)) {
> +        /* wait for payload */
> +        trace_aes_cmd_data_error("No payload");

Use: LOG_GUEST_ERROR

> +        return false;
> +    }
> +
> +    if (ctxt_key >= ARRAY_SIZE(s->key) ||
> +        ctxt_iv >= ARRAY_SIZE(s->iv)) {
> +        /* Invalid input */
> +        trace_aes_cmd_data_error("Invalid key or iv");
> +        return false;
> +    }
> +
> +    src = g_malloc0(len);
> +    dst = g_malloc0(len);
> +
> +    cpu_physical_memory_read(src_addr, src, len);

Use: dma_memory_read()

> +
> +    dump_data("cmd_data(): src_data=", src, len);
> +
> +    switch (s->key[ctxt_key].key_len) {
> +    case 128 / 8:
> +        alg = QCRYPTO_CIPHER_ALGO_AES_128;
> +        break;
> +    case 192 / 8:
> +        alg = QCRYPTO_CIPHER_ALGO_AES_192;
> +        break;
> +    case 256 / 8:
> +        alg = QCRYPTO_CIPHER_ALGO_AES_256;
> +        break;
> +    default:
> +        trace_aes_cmd_data_error("Invalid key len");
> +        goto err_free;

Use g_autoptr instead of goto and g_free().

> +    }
> +    cipher = qcrypto_cipher_new(alg, s->block_mode,
> +                                (void *)s->key[ctxt_key].key,
> +                                s->key[ctxt_key].key_len, NULL);
> +    g_assert(cipher != NULL);
Handle this error as you do for qcrypto_cipher_setiv(), 
qcrypto_cipher_encrypt() and qcrypto_cipher_decrypt().

> +    if (s->block_mode != QCRYPTO_CIPHER_MODE_ECB) {
> +        if (qcrypto_cipher_setiv(cipher, (void *)s->iv[ctxt_iv].iv,
> +                                 sizeof(s->iv[ctxt_iv].iv), NULL) != 0) {
> +            trace_aes_cmd_data_error("Failed to set IV");
> +            goto err_free_cipher;
> +        }
> +    }
> +    if (s->is_encrypt) {
> +        if (qcrypto_cipher_encrypt(cipher, src, dst, len, NULL) != 0) {
> +            trace_aes_cmd_data_error("Encrypt failed");
> +            goto err_free_cipher;
> +        }
> +    } else {
> +        if (qcrypto_cipher_decrypt(cipher, src, dst, len, NULL) != 0) {
> +            trace_aes_cmd_data_error("Decrypt failed");
> +            goto err_free_cipher;
> +        }
> +    }
> +    qcrypto_cipher_free(cipher);
> +
> +    dump_data("cmd_data(): dst_data=", dst, len);
> +    cpu_physical_memory_write(dst_addr, dst, len);
> +    g_free(src);
> +    g_free(dst);
> +
> +    return true;
> +
> +err_free_cipher:
> +    qcrypto_cipher_free(cipher);
> +err_free:
> +    g_free(src);
> +    g_free(dst);
> +    return false;
> +}
> +
> +static bool cmd_store_iv(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t ctxt = (cmd & CMD_IV_CONTEXT_MASK) >> CMD_IV_CONTEXT_SHIFT;
> +    uint64_t addr = s->fifo[1];
> +
> +    if (!has_payload(s, 1)) {
> +        /* wait for payload */

Add a log as it's done for cmd_data().

> +        return false;
> +    }
> +
> +    if (ctxt >= ARRAY_SIZE(s->iv)) {
> +        /* Invalid context selected */
> +        return false;
> +    }
> +
> +    addr |= ((uint64_t)cmd << 32) & 0xff00000000ULL;
> +    cpu_physical_memory_write(addr, &s->iv[ctxt].iv, sizeof(s->iv[ctxt].iv));
> +
> +    trace_aes_cmd_store_iv(ctxt, addr, s->iv[ctxt].iv[0], s->iv[ctxt].iv[1],
> +                           s->iv[ctxt].iv[2], s->iv[ctxt].iv[3]);
> +
> +    return true;
> +}
> +
> +static bool cmd_flag(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0];
> +    uint32_t raise_irq = cmd & CMD_FLAG_RAISE_IRQ_MASK;
> +
> +    /* We always process data when it's coming in, so fire an IRQ immediately */
> +    if (raise_irq) {
> +        s->irq_status |= REG_IRQ_STATUS_FLAG;
> +    }
> +
> +    s->flag_info = cmd & CMD_FLAG_INFO_MASK;
> +
> +    trace_aes_cmd_flag(!!raise_irq, s->flag_info);
> +
> +    return true;
> +}
> +
> +static void fifo_process(AESState *s)
> +{
> +    uint32_t cmd = s->fifo[0] >> CMD_SHIFT;
> +    bool success = false;
> +
> +    if (!s->fifo_idx) {
> +        return;
> +    }
> +
> +    switch (cmd) {
> +    case CMD_KEY:
> +        success = cmd_key(s);
> +        break;
> +    case CMD_IV:
> +        success = cmd_iv(s);
> +        break;
> +    case CMD_DATA:
> +        success = cmd_data(s);
> +        break;
> +    case CMD_STORE_IV:
> +        success = cmd_store_iv(s);
> +        break;
> +    case CMD_FLAG:
> +        success = cmd_flag(s);
> +        break;
> +    default:
> +        s->irq_status |= REG_IRQ_STATUS_INVALID_CMD;
> +        break;
> +    }
> +
> +    if (success) {
> +        s->fifo_idx = 0;
> +    }
> +
> +    trace_aes_fifo_process(cmd, success ? 1 : 0);
> +}
> +
> +static void aes1_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    AESState *s = opaque;
> +
> +    trace_aes_write(offset, val);
> +
> +    switch (offset) {
> +    case REG_IRQ_STATUS:
> +        s->irq_status &= ~val;
> +        break;
> +    case REG_IRQ_ENABLE:
> +        s->irq_enable = val;
> +        break;
> +    case REG_FIFO:
> +        fifo_append(s, val);
> +        fifo_process(s);
> +        break;
> +    default:
> +        trace_aes_write_unknown(offset);
> +        return;
> +    }
> +
> +    aes_update_irq(s);
> +}
> +
> +static const MemoryRegionOps aes1_ops = {
> +    .read = aes1_read,
> +    .write = aes1_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static uint64_t aes2_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t res = 0;
> +
> +    switch (offset) {
> +    case 0:
> +        res = 0;
> +        break;
> +    default:
> +        trace_aes_2_read_unknown(offset);
> +        break;
> +    }
> +
> +    trace_aes_2_read(offset, res);
> +
> +    return res;
> +}
> +
> +static void aes2_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
> +{
> +    trace_aes_2_write(offset, val);
> +
> +    switch (offset) {
> +    default:
> +        trace_aes_2_write_unknown(offset);
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps aes2_ops = {
> +    .read = aes2_read,
> +    .write = aes2_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aes_reset(Object *obj, ResetType type)
> +{
> +    AESState *s = AES(obj);
> +
> +    s->status = 0x3f80;
> +    s->q_status = 2;
> +    s->irq_status = 0;
> +    s->irq_enable = 0;
> +    s->watermark = 0;
> +}
> +
> +static void aes_init(Object *obj)
> +{
> +    AESState *s = AES(obj);
> +
> +    memory_region_init_io(&s->iomem1, obj, &aes1_ops, s, TYPE_AES, 0x4000);
> +    memory_region_init_io(&s->iomem2, obj, &aes2_ops, s, TYPE_AES, 0x4000);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem1);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem2);
> +    sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
> +}
> +
> +static void aes_realize(DeviceState *dev, Error **errp)
> +{
> +}

This shouldn't be necessary.

> +
> +static void aes_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    rc->phases.hold = aes_reset;
> +    dc->realize = aes_realize;
> +}
> +
> +static const TypeInfo aes_info = {
> +    .name          = TYPE_AES,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(AESState),
> +    .class_init    = aes_class_init,
> +    .instance_init = aes_init,
> +};
> +
> +static void aes_register_types(void)
> +{
> +    type_register_static(&aes_info);
> +}
> +
> +type_init(aes_register_types)
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index e69de29bb2d..bcd4dcb28d2 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -0,0 +1 @@
> +system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> index 9ccc5790487..1c9a3326eb4 100644
> --- a/hw/vmapple/trace-events
> +++ b/hw/vmapple/trace-events
> @@ -1,2 +1,21 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
> +# aes.c
> +aes_read_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +aes_cmd_key_select_builtin(uint32_t ctx, uint32_t key_id, const char *direction, const char *cipher) "[%d] Selecting builtin key %d to %scrypt with %s"
> +aes_cmd_key_select_new(uint32_t ctx, uint32_t key_len, const char *direction, const char *cipher) "[%d] Selecting new key size=%d to %scrypt with %s"
> +aes_cmd_iv(uint32_t ctx, uint32_t iv0, uint32_t iv1, uint32_t iv2, uint32_t iv3) "[%d] 0x%08x 0x%08x 0x%08x 0x%08x"
> +aes_cmd_data(uint32_t key, uint32_t iv, uint64_t src, uint64_t dst, uint32_t len) "[key=%d iv=%d] src=0x%"PRIx64" dst=0x%"PRIx64" len=0x%x"
> +aes_cmd_data_error(const char *reason) "reason=%s"
> +aes_cmd_store_iv(uint32_t ctx, uint64_t addr, uint32_t iv0, uint32_t iv1, uint32_t iv2, uint32_t iv3) "[%d] addr=0x%"PRIx64"x -> 0x%08x 0x%08x 0x%08x 0x%08x"
> +aes_cmd_flag(uint32_t raise, uint32_t flag_info) "raise=%d flag_info=0x%x"
> +aes_fifo_process(uint32_t cmd, uint32_t success) "cmd=%d success=%d"
> +aes_write_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +aes_2_read_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_2_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
> +aes_2_write_unknown(uint64_t offset) "offset=0x%"PRIx64
> +aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
> +aes_dump_data(const char *desc, const char *hex) "%s%s"
> +


