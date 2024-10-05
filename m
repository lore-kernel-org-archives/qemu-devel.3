Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805E6CF8861
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 05:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swx61-0007zs-La; Sat, 05 Oct 2024 01:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swx5w-0007zW-Be
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 01:12:44 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swx5u-0003bm-1K
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 01:12:44 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71c702b2d50so2089382b3a.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728105160; x=1728709960;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r+dSGTdC8rEBKFvL7zeY9zRLUuqb60N8rzYF/bCzHGs=;
 b=N5alU9e1LKNDw1ZY/YyC5yVl3eFh3CgCpqry3d87Hm7gbZ7O2lXWrffhWfA84GN8Yn
 opvlM0KDLay6dV3bi2rW4oPh65B6HMI19nCj47G6drnbSbPgX++zsZ7ylvV65/HD+MKc
 453up/X/pXzs/z1EsO7ah1aI59ubWkvQwK+rFRJkyC8yrdUAN2Hqa7WekILPUoJhQJ0E
 ureX7cQJDQ78N79hvdQN5ZgbWjelimcEbo15BdPww/rHhi9x9M5yCEBZ2xaRgjtO5gTb
 5ndG1OlYIVuMPH33PYgBI6h3aOmOL0HEFlSsFaMsUFaJ41a26vLrvqiEO9jyvfATy3p7
 qK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728105160; x=1728709960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r+dSGTdC8rEBKFvL7zeY9zRLUuqb60N8rzYF/bCzHGs=;
 b=BH0WYFJPBajlJbHs6F/Kb6yONuWYCrj7w257pUFfZXx1NZkym7YGfeaKgIVezKvP1n
 vV8oYlKsc/vNRun9Py0d2vBjskUdQiUuRNkePuQxJQOrgmJV7onwn0C7IPLrULhuj0mX
 wkdskYRkSkNAl4WF38bZXQ3RBhF1EEFwKWsAWvWZqqw4afaj2KRl9NfQBkHfp8Dnoz8L
 iqc2YhHYY1FtIXq881EqGpHyMHWdsmp6MSoT5jLdhoYWrFVKPJnbAiJBwNQx5d7fKCYO
 k5YnVAuaaNmCl9v/DTEC2wJHSmy3mW8UcGD8XpGKpxUXHsx3fikZVC1hEEgPJmVJpu3f
 YaXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV63tdVlcY0HTYUHTDIEfltiSedz81gDd9rt4wET5Dbg/I4/RcY29ZtQEuscUfq6HWa9jB8LJ8z313S@nongnu.org
X-Gm-Message-State: AOJu0YzO6fXtO+sR8uHkyHbTeeoK38GqOJ9R/SzwUDzSs0XqYyW+frLl
 PA6y/YkMDaT8OeY2eLnd/bJKywtSx1S7dlmrzshfZmke5kaqsPqUFT8Iu4X2yqk=
X-Google-Smtp-Source: AGHT+IGSQksX9ZzZxV6EK+p08Obi5ZttbrGY3J8yXrrSfb9747snbv5gwC4zXudWF5NIbXdVQJ/rpw==
X-Received: by 2002:a05:6a00:3d51:b0:717:88eb:824d with SMTP id
 d2e1a72fcca58-71de23b6b35mr8315891b3a.7.1728105159964; 
 Fri, 04 Oct 2024 22:12:39 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d7cfa4sm744350b3a.196.2024.10.04.22.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 22:12:39 -0700 (PDT)
Message-ID: <7af710d1-e337-41b8-9328-0488fc20f438@daynix.com>
Date: Sat, 5 Oct 2024 14:12:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
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
 <20240928085727.56883-12-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240928085727.56883-12-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
>   hw/vmapple/Kconfig        |   3 +
>   hw/vmapple/bdif.c         | 245 ++++++++++++++++++++++++++++++++++++++
>   hw/vmapple/meson.build    |   1 +
>   hw/vmapple/trace-events   |   5 +
>   include/hw/vmapple/bdif.h |  31 +++++
>   5 files changed, 285 insertions(+)
>   create mode 100644 hw/vmapple/bdif.c
>   create mode 100644 include/hw/vmapple/bdif.h
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
> index 00000000000..36b5915ff30
> --- /dev/null
> +++ b/hw/vmapple/bdif.c
> @@ -0,0 +1,245 @@
> +/*
> + * VMApple Backdoor Interface
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vmapple/bdif.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/block/block.h"
> +#include "sysemu/block-backend.h"
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
> +typedef struct vblk_sector {

Please use VblkSector for the tag name too.

> +    uint32_t pad;
> +    uint32_t pad2;
> +    uint32_t sector;
> +    uint32_t pad3;
> +} VblkSector;
> +
> +typedef struct vblk_req_cmd {
> +    uint64_t addr;
> +    uint32_t len;
> +    uint32_t flags;
> +} VblkReqCmd;
> +
> +typedef struct vblk_req {
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
> +    uint64_t devid = (offset & REG_DEVID_MASK);

The parenthes in this line are unnecessary.

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
> +    if (req.data.len > (128 * 1024 * 1024)) {

Use MiB defined in: include/qemu/units.h
The parentheses on the right hand are also unnecessary.

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
> index 1c9a3326eb4..fc8e9cc5897 100644
> --- a/hw/vmapple/trace-events
> +++ b/hw/vmapple/trace-events
> @@ -19,3 +19,8 @@ aes_2_write_unknown(uint64_t offset) "offset=0x%"PRIx64
>   aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
>   aes_dump_data(const char *desc, const char *hex) "%s%s"
>   
> +# bdif.c
> +bdif_read(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
> +bdif_write(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
> +bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset, uint32_t len, int r) "dev=%s addr=0x%"PRIx64" off=0x%"PRIx64" size=0x%x r=%d"
> +
> diff --git a/include/hw/vmapple/bdif.h b/include/hw/vmapple/bdif.h
> new file mode 100644
> index 00000000000..65ee43457b9
> --- /dev/null
> +++ b/include/hw/vmapple/bdif.h
> @@ -0,0 +1,31 @@
> +/*
> + * VMApple Backdoor Interface
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_VMAPPLE_BDIF_H
> +#define HW_VMAPPLE_BDIF_H
> +
> +#include "hw/sysbus.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VMAPPLE_BDIF "vmapple-bdif"
> +OBJECT_DECLARE_SIMPLE_TYPE(VMAppleBdifState, VMAPPLE_BDIF)
> +
> +struct VMAppleBdifState {
> +    /* <private> */
> +    SysBusDevice parent_obj;
> +
> +    /* <public> */
> +    BlockBackend *aux;
> +    BlockBackend *root;
> +    MemoryRegion mmio;
> +};
> +
> +#define VMAPPLE_BDIF_SIZE 0x00200000

Please move VMAppleBdifState and VMAPPLE_BDIF_SIZE into: hw/vmapple/bdif.c
They are both private.

> +
> +#endif /* HW_VMAPPLE_BDIF_H */


