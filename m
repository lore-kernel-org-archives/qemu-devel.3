Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8C8D29FAF
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 07:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8aU6-0005GW-5M; Wed, 06 Nov 2024 02:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8aU1-0005Fd-8Q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:29:41 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t8aTy-0002KH-Lw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 02:29:41 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e4244fdc6so5021022b3a.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 23:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730878177; x=1731482977;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZX5f6qMwlEaVhbs7Wdry6Zm7tkN9RbvjCdThR/wiCmc=;
 b=0pu+ki4WNZ+orwIfvL8cCd5vbDmjV2jVhBUBBiEP6BDx8uy0djph93dsbaWfM7a1Va
 QyDMe7ZM2nobi4sn7E0cCcPziYJRHlOVluyGC1dRkpLsBoK8TsBMLJPw/jEHiFGEmZin
 vhX8pUe6Ugyr0M897G/FUm8vc4IeYgtvx+rO+TSKw/sOUjNcarJeD0mskmZletuvsDnv
 TC1wMNZttz6ibAdsf2ucvbgFxgih4qz8ChEyJ+1A3BXy1cXT+U6de2lGC1PWYI47Mpn/
 xWR4EJdMATlNUThrUauJCdCZp6NA9u0cFNU72kg1WKxe6WDf6GGVcyy/99Mnvy8H21VN
 ELdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730878177; x=1731482977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZX5f6qMwlEaVhbs7Wdry6Zm7tkN9RbvjCdThR/wiCmc=;
 b=ruX+X/M6LG4ivqCMbs9zv6XKdOoCukrPRe26JY0xfWX+6v2MFAkj8XcmaOrLoz65jQ
 SrPDy+iuDA014rrESUC8lqy21FSrPyoNik7NWB7+nPUFrN99s6inPttGppdIwGZLXnb6
 0FZaNYpmzIJVoER8C2Rr3flC2FdsLSHLSIQYKZflQ2GhoUOWLoBg4RpANN6PHY6xI28w
 OqheiQMwo19hhCfLgIaJeKmCT7TlZKLCHynmBnbfl1MR1ghV3ld9sJuxKMmZ51jGnEWZ
 bZG303+U40qbK1eB8GhAslnfa4nrACHovTR5GlMCzkmmX+H0xve4CZ/+jsUvsDAjZdDi
 Imvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwQctIdEZGP2hDc06jhbh20XAPbeHSwhq2BsRW20xA6P72ge1YRTRz8fM4FXGMvXxXtVo9m6wnYoW3@nongnu.org
X-Gm-Message-State: AOJu0YzsjlngK98FKSGB4ANx/RSxUMO0yMclknfXv1ocHhMgTmY5j+8m
 ykl+EwVKHEEavthYgh/T0z7bvqa0VOSuosqahXzubmkitQYcJKkVJcyS2iUxlnM=
X-Google-Smtp-Source: AGHT+IF9Dh3asJV2ooSjaPcHRnImV0NWpejbmaHjX3+SIWkcYCeuAn4rLS+U6aL3cJfUzaAPo05pIA==
X-Received: by 2002:a05:6a21:999a:b0:1db:eb85:e518 with SMTP id
 adf61e73a8af0-1dbeb85e530mr8395604637.34.1730878177043; 
 Tue, 05 Nov 2024 23:29:37 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a580662sm764116a91.24.2024.11.05.23.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 23:29:36 -0800 (PST)
Message-ID: <501f93f5-720a-4434-ba4e-004b80f82068@daynix.com>
Date: Wed, 6 Nov 2024 16:29:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241105153022.91101-1-phil@philjordan.eu>
 <20241105153022.91101-12-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241105153022.91101-12-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

On 2024/11/06 0:30, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> The VMApple machine exposes AUX and ROOT block devices (as well as USB OTG
> emulation) via virtio-pci as well as a special, simple backdoor platform
> device.
> 
> This patch implements this backdoor platform device to the best of my
> understanding. I left out any USB OTG parts; they're only needed for
> guest recovery and I don't understand the protocol yet.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
> 
> v4:
> 
>   * Moved most header code to .c, rest to vmapple.h
>   * Better compliance with coding, naming, and formatting conventions.
> 
>   hw/vmapple/Kconfig           |   3 +
>   hw/vmapple/bdif.c            | 261 +++++++++++++++++++++++++++++++++++
>   hw/vmapple/meson.build       |   1 +
>   hw/vmapple/trace-events      |   5 +
>   include/hw/vmapple/vmapple.h |   2 +
>   5 files changed, 272 insertions(+)
>   create mode 100644 hw/vmapple/bdif.c
> 
> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> index a73504d5999..68f88876eb9 100644
> --- a/hw/vmapple/Kconfig
> +++ b/hw/vmapple/Kconfig
> @@ -1,3 +1,6 @@
>   config VMAPPLE_AES
>       bool
>   
> +config VMAPPLE_BDIF
> +    bool
> +
> diff --git a/hw/vmapple/bdif.c b/hw/vmapple/bdif.c
> new file mode 100644
> index 00000000000..7c7a277665a
> --- /dev/null
> +++ b/hw/vmapple/bdif.c
> @@ -0,0 +1,261 @@
> +/*
> + * VMApple Backdoor Interface
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "trace.h"
> +#include "hw/vmapple/vmapple.h"
> +#include "hw/sysbus.h"
> +#include "hw/block/block.h"
> +#include "qapi/error.h"
> +#include "sysemu/block-backend.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleBdifState, VMAPPLE_BDIF)
> +
> +struct VMAppleBdifState {
> +    SysBusDevice parent_obj;
> +
> +    BlockBackend *aux;
> +    BlockBackend *root;
> +    MemoryRegion mmio;
> +};
> +
> +#define VMAPPLE_BDIF_SIZE   0x00200000
> +
> +#define REG_DEVID_MASK      0xffff0000
> +#define DEVID_ROOT          0x00000000
> +#define DEVID_AUX           0x00010000
> +#define DEVID_USB           0x00100000
> +
> +#define REG_STATUS          0x0
> +#define REG_STATUS_ACTIVE     BIT(0)
> +#define REG_CFG             0x4
> +#define REG_CFG_ACTIVE        BIT(1)
> +#define REG_UNK1            0x8
> +#define REG_BUSY            0x10
> +#define REG_BUSY_READY        BIT(0)
> +#define REG_UNK2            0x400
> +#define REG_CMD             0x408
> +#define REG_NEXT_DEVICE     0x420
> +#define REG_UNK3            0x434
> +
> +typedef struct VblkSector {
> +    uint32_t pad;
> +    uint32_t pad2;
> +    uint32_t sector;
> +    uint32_t pad3;
> +} VblkSector;
> +
> +typedef struct VblkReqCmd {
> +    uint64_t addr;
> +    uint32_t len;
> +    uint32_t flags;
> +} VblkReqCmd;
> +
> +typedef struct VblkReq {
> +    VblkReqCmd sector;
> +    VblkReqCmd data;
> +    VblkReqCmd retval;
> +} VblkReq;
> +
> +#define VBLK_DATA_FLAGS_READ  0x00030001
> +#define VBLK_DATA_FLAGS_WRITE 0x00010001
> +
> +#define VBLK_RET_SUCCESS  0
> +#define VBLK_RET_FAILED   1
> +
> +static uint64_t bdif_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    uint64_t ret = -1;
> +    uint64_t devid = offset & REG_DEVID_MASK;
> +
> +    switch (offset & ~REG_DEVID_MASK) {
> +    case REG_STATUS:
> +        ret = REG_STATUS_ACTIVE;
> +        break;
> +    case REG_CFG:
> +        ret = REG_CFG_ACTIVE;
> +        break;
> +    case REG_UNK1:
> +        ret = 0x420;
> +        break;
> +    case REG_BUSY:
> +        ret = REG_BUSY_READY;
> +        break;
> +    case REG_UNK2:
> +        ret = 0x1;
> +        break;
> +    case REG_UNK3:
> +        ret = 0x0;
> +        break;
> +    case REG_NEXT_DEVICE:
> +        switch (devid) {
> +        case DEVID_ROOT:
> +            ret = 0x8000000;
> +            break;
> +        case DEVID_AUX:
> +            ret = 0x10000;
> +            break;
> +        }
> +        break;
> +    }
> +
> +    trace_bdif_read(offset, size, ret);
> +    return ret;
> +}
> +
> +static void le2cpu_sector(VblkSector *sector)
> +{
> +    sector->sector = le32_to_cpu(sector->sector);
> +}
> +
> +static void le2cpu_reqcmd(VblkReqCmd *cmd)
> +{
> +    cmd->addr = le64_to_cpu(cmd->addr);
> +    cmd->len = le32_to_cpu(cmd->len);
> +    cmd->flags = le32_to_cpu(cmd->flags);
> +}
> +
> +static void le2cpu_req(VblkReq *req)
> +{
> +    le2cpu_reqcmd(&req->sector);
> +    le2cpu_reqcmd(&req->data);
> +    le2cpu_reqcmd(&req->retval);
> +}
> +
> +static void vblk_cmd(uint64_t devid, BlockBackend *blk, uint64_t value,
> +                     uint64_t static_off)
> +{
> +    VblkReq req;
> +    VblkSector sector;
> +    uint64_t off = 0;
> +    char *buf = NULL;
> +    uint8_t ret = VBLK_RET_FAILED;
> +    int r;
> +
> +    cpu_physical_memory_read(value, &req, sizeof(req));

dma_memory_read() and similar should be used for DMA unless there is a 
reason to do otherwise.

> +    le2cpu_req(&req);
> +
> +    if (req.sector.len != sizeof(sector)) {
> +        ret = VBLK_RET_FAILED;
> +        goto out;
> +    }
> +
> +    /* Read the vblk command */
> +    cpu_physical_memory_read(req.sector.addr, &sector, sizeof(sector));
> +    le2cpu_sector(&sector);
> +
> +    off = sector.sector * 512ULL + static_off;
> +
> +    /* Sanity check that we're not allocating bogus sizes */
> +    if (req.data.len > 128 * MiB) {
> +        goto out;
> +    }
> +
> +    buf = g_malloc0(req.data.len);
> +    switch (req.data.flags) {
> +    case VBLK_DATA_FLAGS_READ:
> +        r = blk_pread(blk, off, req.data.len, buf, 0);
> +        trace_bdif_vblk_read(devid == DEVID_AUX ? "aux" : "root",
> +                             req.data.addr, off, req.data.len, r);
> +        if (r < 0) {
> +            goto out;
> +        }
> +        cpu_physical_memory_write(req.data.addr, buf, req.data.len);
> +        ret = VBLK_RET_SUCCESS;
> +        break;
> +    case VBLK_DATA_FLAGS_WRITE:
> +        /* Not needed, iBoot only reads */
> +        break;
> +    default:
> +        break;
> +    }
> +
> +out:
> +    g_free(buf);
> +    cpu_physical_memory_write(req.retval.addr, &ret, 1);
> +}
> +
> +static void bdif_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned size)
> +{
> +    VMAppleBdifState *s = opaque;
> +    uint64_t devid = (offset & REG_DEVID_MASK);
> +
> +    trace_bdif_write(offset, size, value);
> +
> +    switch (offset & ~REG_DEVID_MASK) {
> +    case REG_CMD:
> +        switch (devid) {
> +        case DEVID_ROOT:
> +            vblk_cmd(devid, s->root, value, 0x0);
> +            break;
> +        case DEVID_AUX:
> +            vblk_cmd(devid, s->aux, value, 0x0);
> +            break;
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps bdif_ops = {
> +    .read = bdif_read,
> +    .write = bdif_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +    },
> +    .impl = {
> +        .min_access_size = 1,
> +        .max_access_size = 8,
> +    },
> +};
> +
> +static void bdif_init(Object *obj)
> +{
> +    VMAppleBdifState *s = VMAPPLE_BDIF(obj);
> +
> +    memory_region_init_io(&s->mmio, obj, &bdif_ops, obj,
> +                         "VMApple Backdoor Interface", VMAPPLE_BDIF_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +}
> +
> +static Property bdif_properties[] = {
> +    DEFINE_PROP_DRIVE("aux", VMAppleBdifState, aux),
> +    DEFINE_PROP_DRIVE("root", VMAppleBdifState, root),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void bdif_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "VMApple Backdoor Interface";
> +    device_class_set_props(dc, bdif_properties);
> +}
> +
> +static const TypeInfo bdif_info = {
> +    .name          = TYPE_VMAPPLE_BDIF,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(VMAppleBdifState),
> +    .instance_init = bdif_init,
> +    .class_init    = bdif_class_init,
> +};
> +
> +static void bdif_register_types(void)
> +{
> +    type_register_static(&bdif_info);
> +}
> +
> +type_init(bdif_register_types)
> diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
> index bcd4dcb28d2..d4624713deb 100644
> --- a/hw/vmapple/meson.build
> +++ b/hw/vmapple/meson.build
> @@ -1 +1,2 @@
>   system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
> +system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
> diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
> index fbbef40eac0..824f6595d35 100644
> --- a/hw/vmapple/trace-events
> +++ b/hw/vmapple/trace-events
> @@ -14,3 +14,8 @@ aes_2_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
>   aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
>   aes_dump_data(const char *desc, const char *hex) "%s%s"
>   
> +# bdif.c
> +bdif_read(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
> +bdif_write(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
> +bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset, uint32_t len, int r) "dev=%s addr=0x%"PRIx64" off=0x%"PRIx64" size=0x%x r=%d"
> +
> diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple/vmapple.h
> index 6762b6c869f..9090e9c5ac8 100644
> --- a/include/hw/vmapple/vmapple.h
> +++ b/include/hw/vmapple/vmapple.h
> @@ -14,4 +14,6 @@
>   
>   #define TYPE_APPLE_AES "apple-aes"
>   
> +#define TYPE_VMAPPLE_BDIF "vmapple-bdif"
> +
>   #endif /* HW_VMAPPLE_VMAPPLE_H */


