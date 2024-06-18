Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CFAC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMP-0000rE-9y; Tue, 18 Jun 2024 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbM8-0000R0-VF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:54 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbM4-0007oL-Cx
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:46 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2e72224c395so57289171fa.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726801; x=1719331601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cymkwF82VC/Hy5B+jHzMH3ViY4En2eCo0AZnv/UEfWU=;
 b=k2LffBknCEN6MRBQ/V2+LE+k9V9WZ5Ln8KkUNt7ioDXXuGumqcrhrlCfOo9Bdzq2wQ
 AmGm4cPw+0mgnqRoU7ryfSj9BAm9EQXxAjWp8v+XnQ0ffdanbszDCEtCIs/AEzf0TDEP
 AYO9SUtkPnvwX8rq2e/qyGixmfFTgUOAIlFMNzgMN1Xpdcjq1YaIHU2lXIkp0KuOufmC
 hNpeGTFSS6Lo4bub888hPECPsI0Fi6UUemyjklMcIze66ZrNWCxg3o0rKJeHFpdRITgr
 Fwfh/UNM5MKxrGalufVdGcCTc5RtIaiQ4oohQWVAnUlRqveYJywNbkJG/Q57N36goywn
 YFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726801; x=1719331601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cymkwF82VC/Hy5B+jHzMH3ViY4En2eCo0AZnv/UEfWU=;
 b=dVKbaFYfTjIINtXYuUiGOsa1PMWiWxapeezcMQEiUuVCbOyo7D0kL+RuMFRILCSkJL
 f6KrxLa3gvZU+svQnSohbbSvRuSOXaBQtD5sNXBkqOFBC7Xn52B8KtiFAQrXnBmY9Cgm
 ykwxicGon1NSzot2Qeyfc4PdNZehyc6Xioy/oVHEuRX98eBFVd45vdX//ZJURDNPjEai
 ThzsLor4+WsYfxSMrevjm+i/cNUq53U/V9cng5UyHH/Ng/4nllo10Jp+RVfNWZ3jKgtq
 37giuNudKwpdaXqUxS9uk0EjhpGopLiRgM2rt9T4kX+KQY5Lb0ce1oZGedhqCR7zZ/H+
 f2rg==
X-Gm-Message-State: AOJu0YwWjnS55aoazIpxo3WLN+EtwBkyF8ov6noDypw7+mEf5Wx2ab03
 Jl1EMQFEC1yDbNG8DAXnYnpTuqXTgEqtKpVWXiJyS5ZFrjfj4oOnoXinEQaB/DwaA8L/mihDxA1
 m
X-Google-Smtp-Source: AGHT+IFKAoGNogGpNjpAo+JW0uHYhVDI+R3d7vs+O4HPt8Z3SR6nKmGJOLr3N3oe5tUpBjZPbKpH3g==
X-Received: by 2002:a05:651c:91:b0:2ec:22c0:66e6 with SMTP id
 38308e7fff4ca-2ec3ce9b78cmr2086891fa.7.1718726800962; 
 Tue, 18 Jun 2024 09:06:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422869d4f2esm231014525e9.0.2024.06.18.09.06.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 62/76] hw/intc: Remove loongarch_ipi.c
Date: Tue, 18 Jun 2024 18:00:24 +0200
Message-ID: <20240618160039.36108-63-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

It was missed out in previous commit.

Fixes: b4a12dfc2132 ("hw/intc/loongarch_ipi: Rename as loongson_ipi")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongarch_ipi.c | 347 ----------------------------------------
 1 file changed, 347 deletions(-)
 delete mode 100644 hw/intc/loongarch_ipi.c

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
deleted file mode 100644
index 44b3b9c138..0000000000
--- a/hw/intc/loongarch_ipi.c
+++ /dev/null
@@ -1,347 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * LoongArch ipi interrupt support
- *
- * Copyright (C) 2021 Loongson Technology Corporation Limited
- */
-
-#include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
-#include "hw/intc/loongarch_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "migration/vmstate.h"
-#include "target/loongarch/cpu.h"
-#include "trace.h"
-
-static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
-                                       uint64_t *data,
-                                       unsigned size, MemTxAttrs attrs)
-{
-    IPICore *s;
-    LoongArchIPI *ipi = opaque;
-    uint64_t ret = 0;
-    int index = 0;
-
-    s = &ipi->cpu[attrs.requester_id];
-    addr &= 0xff;
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        ret = s->status;
-        break;
-    case CORE_EN_OFF:
-        ret = s->en;
-        break;
-    case CORE_SET_OFF:
-        ret = 0;
-        break;
-    case CORE_CLEAR_OFF:
-        ret = 0;
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        ret = s->buf[index];
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid read: %x", (uint32_t)addr);
-        break;
-    }
-
-    trace_loongarch_ipi_read(size, (uint64_t)addr, ret);
-    *data = ret;
-    return MEMTX_OK;
-}
-
-static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
-                          MemTxAttrs attrs)
-{
-    int i, mask = 0, data = 0;
-
-    /*
-     * bit 27-30 is mask for byte writing,
-     * if the mask is 0, we need not to do anything.
-     */
-    if ((val >> 27) & 0xf) {
-        data = address_space_ldl(env->address_space_iocsr, addr,
-                                 attrs, NULL);
-        for (i = 0; i < 4; i++) {
-            /* get mask for byte writing */
-            if (val & (0x1 << (27 + i))) {
-                mask |= 0xff << (i * 8);
-            }
-        }
-    }
-
-    data &= mask;
-    data |= (val >> 32) & ~mask;
-    address_space_stl(env->address_space_iocsr, addr,
-                      data, attrs, NULL);
-}
-
-static int archid_cmp(const void *a, const void *b)
-{
-   CPUArchId *archid_a = (CPUArchId *)a;
-   CPUArchId *archid_b = (CPUArchId *)b;
-
-   return archid_a->arch_id - archid_b->arch_id;
-}
-
-static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
-        archid_cmp);
-
-    return found_cpu;
-}
-
-static CPUState *ipi_getcpu(int arch_id)
-{
-    MachineState *machine = MACHINE(qdev_get_machine());
-    CPUArchId *archid;
-
-    archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
-        return CPU(archid->cpu);
-    }
-
-    return NULL;
-}
-
-static MemTxResult mail_send(uint64_t val, MemTxAttrs attrs)
-{
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = SMP_IPI_MAILBOX + CORE_BUF_20 + (val & 0x1c);
-    attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
-}
-
-static MemTxResult any_send(uint64_t val, MemTxAttrs attrs)
-{
-    uint32_t cpuid;
-    hwaddr addr;
-    CPUState *cs;
-
-    cpuid = extract32(val, 16, 10);
-    cs = ipi_getcpu(cpuid);
-    if (cs == NULL) {
-        return MEMTX_DECODE_ERROR;
-    }
-
-    /* override requester_id */
-    addr = val & 0xffff;
-    attrs.requester_id = cs->cpu_index;
-    send_ipi_data(&LOONGARCH_CPU(cs)->env, val, addr, attrs);
-    return MEMTX_OK;
-}
-
-static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
-{
-    LoongArchIPI *ipi = opaque;
-    IPICore *s;
-    int index = 0;
-    uint32_t cpuid;
-    uint8_t vector;
-    CPUState *cs;
-
-    s = &ipi->cpu[attrs.requester_id];
-    addr &= 0xff;
-    trace_loongarch_ipi_write(size, (uint64_t)addr, val);
-    switch (addr) {
-    case CORE_STATUS_OFF:
-        qemu_log_mask(LOG_GUEST_ERROR, "can not be written");
-        break;
-    case CORE_EN_OFF:
-        s->en = val;
-        break;
-    case CORE_SET_OFF:
-        s->status |= val;
-        if (s->status != 0 && (s->status & s->en) != 0) {
-            qemu_irq_raise(s->irq);
-        }
-        break;
-    case CORE_CLEAR_OFF:
-        s->status &= ~val;
-        if (s->status == 0 && s->en != 0) {
-            qemu_irq_lower(s->irq);
-        }
-        break;
-    case CORE_BUF_20 ... CORE_BUF_38 + 4:
-        index = (addr - CORE_BUF_20) >> 2;
-        s->buf[index] = val;
-        break;
-    case IOCSR_IPI_SEND:
-        cpuid = extract32(val, 16, 10);
-        /* IPI status vector */
-        vector = extract8(val, 0, 5);
-        cs = ipi_getcpu(cpuid);
-        if (cs == NULL) {
-            return MEMTX_DECODE_ERROR;
-        }
-
-        /* override requester_id */
-        attrs.requester_id = cs->cpu_index;
-        loongarch_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "invalid write: %x", (uint32_t)addr);
-        break;
-    }
-
-    return MEMTX_OK;
-}
-
-static const MemoryRegionOps loongarch_ipi_ops = {
-    .read_with_attrs = loongarch_ipi_readl,
-    .write_with_attrs = loongarch_ipi_writel,
-    .impl.min_access_size = 4,
-    .impl.max_access_size = 4,
-    .valid.min_access_size = 4,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-/* mail send and any send only support writeq */
-static MemTxResult loongarch_ipi_writeq(void *opaque, hwaddr addr, uint64_t val,
-                                        unsigned size, MemTxAttrs attrs)
-{
-    MemTxResult ret = MEMTX_OK;
-
-    addr &= 0xfff;
-    switch (addr) {
-    case MAIL_SEND_OFFSET:
-        ret = mail_send(val, attrs);
-        break;
-    case ANY_SEND_OFFSET:
-        ret = any_send(val, attrs);
-        break;
-    default:
-       break;
-    }
-
-    return ret;
-}
-
-static const MemoryRegionOps loongarch_ipi64_ops = {
-    .write_with_attrs = loongarch_ipi_writeq,
-    .impl.min_access_size = 8,
-    .impl.max_access_size = 8,
-    .valid.min_access_size = 8,
-    .valid.max_access_size = 8,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
-{
-    LoongArchIPI *s = LOONGARCH_IPI(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-
-    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongarch_ipi_ops,
-                          s, "loongarch_ipi_iocsr", 0x48);
-
-    /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
-    s->ipi_iocsr_mem.disable_reentrancy_guard = true;
-
-    sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
-
-    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
-                          &loongarch_ipi64_ops,
-                          s, "loongarch_ipi64_iocsr", 0x118);
-    sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-
-    s->cpu = g_new0(IPICore, s->num_cpu);
-    if (s->cpu == NULL) {
-        error_setg(errp, "Memory allocation for ExtIOICore faile");
-        return;
-    }
-
-    for (i = 0; i < s->num_cpu; i++) {
-        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
-    }
-}
-
-static const VMStateDescription vmstate_ipi_core = {
-    .name = "ipi-single",
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(status, IPICore),
-        VMSTATE_UINT32(en, IPICore),
-        VMSTATE_UINT32(set, IPICore),
-        VMSTATE_UINT32(clear, IPICore),
-        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_loongarch_ipi = {
-    .name = TYPE_LOONGARCH_IPI,
-    .version_id = 2,
-    .minimum_version_id = 2,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, num_cpu,
-                         vmstate_ipi_core, IPICore),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static Property ipi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = loongarch_ipi_realize;
-    device_class_set_props(dc, ipi_properties);
-    dc->vmsd = &vmstate_loongarch_ipi;
-}
-
-static void loongarch_ipi_finalize(Object *obj)
-{
-    LoongArchIPI *s = LOONGARCH_IPI(obj);
-
-    g_free(s->cpu);
-}
-
-static const TypeInfo loongarch_ipi_info = {
-    .name          = TYPE_LOONGARCH_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongArchIPI),
-    .class_init    = loongarch_ipi_class_init,
-    .instance_finalize = loongarch_ipi_finalize,
-};
-
-static void loongarch_ipi_register_types(void)
-{
-    type_register_static(&loongarch_ipi_info);
-}
-
-type_init(loongarch_ipi_register_types)
-- 
2.41.0


