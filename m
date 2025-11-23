Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C100CFC518
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNEDN-0004hy-Bm; Sun, 23 Nov 2025 12:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vNEDM-0004hW-5z; Sun, 23 Nov 2025 12:49:32 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <k.semichastnov@syntacore.com>)
 id 1vNEDJ-0007Lc-Rg; Sun, 23 Nov 2025 12:49:31 -0500
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id 9F1E91A0003;
 Sun, 23 Nov 2025 17:49:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com 9F1E91A0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1763920165; bh=BqGMEO3ZRK/1nq+PUd8jTQcfPJXuMyG5FYR+z2IDajA=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=kduH/eVyYrzhVJGm5pm6y6MnKkrYWv2nPkncR9jvsqD8AwJSPIY0B3zHPRHOi69o7
 QgeGjuOcKAqnjql4LTq1edeVXu9bIXLwk71WWJqyLC4X8x2UxHyycDxJaxlzqTOcHZ
 RVsIMYA3pgJGBYM6VPM1LCqi93sde4sKzDjIf2OJBejtKavd5cP2pKf2IPNrv889L2
 ata4ghVnlo0DtTdQb7P0Cq1k2Ppc6g5CdvZzm0jxGdjn2zStYqGPj6Zr4sdobF+/Yj
 5V1VHJCX5h9eiVNthobTKMLZLY6ylXjSd+fMa8EGZaBHYZSssI9LHrSUrubxrwpvsF
 Fbm/H8rE1jW5A==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Sun, 23 Nov 2025 17:49:20 +0000 (UTC)
Received: from [10.178.119.213] (10.178.119.213) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 23 Nov 2025 20:48:52 +0300
Message-ID: <ac068751-fd03-4eec-91ff-20cc30019e17@syntacore.com>
Date: Sun, 23 Nov 2025 20:49:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/18] hw/misc: riscv_worldguard: Add RISC-V WorldGuard
 global config
To: Jim Shu <jim.shu@sifive.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>
CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Michael Rolnik
 <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>, Song Gao
 <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom
 Tarasenko <atar4qemu@gmail.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, Max Filippov <jcmvbkbc@gmail.com>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, "open list:S390 TCG CPUs"
 <qemu-s390x@nongnu.org>
References: <20251021155548.584543-1-jim.shu@sifive.com>
 <20251021155548.584543-6-jim.shu@sifive.com>
Content-Language: en-US
From: Konstantin Semichastnov <k.semichastnov@syntacore.com>
In-Reply-To: <20251021155548.584543-6-jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.178.119.213]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/11/23 14:57:00 #27963761
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/11/23 16:56:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=k.semichastnov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/21/25 18:55, Jim Shu wrote:
> Add a device for RISCV WG global config, which contains the number of
> worlds, reset value, and trusted WID ... etc.
> 
> This global config is used by both CPU WG extension and wgChecker devices.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/misc/Kconfig                    |   3 +
>   hw/misc/meson.build                |   1 +
>   hw/misc/riscv_worldguard.c         | 182 +++++++++++++++++++++++++++++
>   include/hw/misc/riscv_worldguard.h |  56 +++++++++
>   4 files changed, 242 insertions(+)
>   create mode 100644 hw/misc/riscv_worldguard.c
>   create mode 100644 include/hw/misc/riscv_worldguard.h
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 4e35657468..bee8824868 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -235,4 +235,7 @@ config IOSB
>   config XLNX_VERSAL_TRNG
>       bool
>   
> +config RISCV_WORLDGUARD
> +    bool
> +
>   source macio/Kconfig
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index b1d8d8e5d2..200ccc96c0 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
>   system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
> +specific_ss.add(when: 'CONFIG_RISCV_WORLDGUARD', if_true: files('riscv_worldguard.c'))
>   
>   subdir('macio')
>   
> diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
> new file mode 100644
> index 0000000000..588c16ae9a
> --- /dev/null
> +++ b/hw/misc/riscv_worldguard.c
> @@ -0,0 +1,182 @@
> +/*
> + * RISC-V WorldGuard Device
> + *
> + * Copyright (c) 2022 SiFive, Inc.
> + *
> + * This provides WorldGuard global config.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "exec/hwaddr.h"
> +#include "hw/registerfields.h"
> +#include "hw/sysbus.h"
> +#include "hw/hw.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/riscv_worldguard.h"
> +#include "hw/core/cpu.h"
> +#include "target/riscv/cpu.h"
> +#include "trace.h"
> +
> +/*
> + * WorldGuard global config:
> + * List the global setting of WG, like num-of-worlds. It is unique in the machine.
> + * All CPUs with WG extension and wgChecker devices will use it.
> + */
> +struct RISCVWorldGuardState *worldguard_config;
> +
> +static Property riscv_worldguard_properties[] = {
Hi, I believe that this array should also be declared as "const", as 
otherwise it will not compile due to the call of 
device_class_set_props() on line 245. This is because 
device_class_set_props() expects a property array to be constant, as it 
checks for the last element to be non-null at compile time.

> +    DEFINE_PROP_UINT32("nworlds", RISCVWorldGuardState, nworlds, 0),
> +
> +    /* Only Trusted WID could access wgCheckers if it is enabled. */
> +    DEFINE_PROP_UINT32("trustedwid", RISCVWorldGuardState, trustedwid, NO_TRUSTEDWID),
> +
> +    /*
> +     * WG reset value is bypass mode in HW. All WG permission checkings are
> +     * pass by default, so SW could correctly run on the machine w/o any WG
> +     * programming.
> +     */
> +    DEFINE_PROP_BOOL("hw-bypass", RISCVWorldGuardState, hw_bypass, false),
> +
> +    /*
> +     * TrustZone compatible mode:
> +     * This mode is only supported in 2 worlds system. It converts WorldGuard
> +     * WID to TZ NS signal on the bus so WG could be cooperated with
> +     * TZ components. In QEMU, it converts WID to 'MemTxAttrs.secure' bit used
> +     * by TZ.
> +     */
> +    DEFINE_PROP_BOOL("tz-compat", RISCVWorldGuardState, tz_compat, false),
> +};
> +
> +/* WID to MemTxAttrs converter */
> +void wid_to_mem_attrs(MemTxAttrs *attrs, uint32_t wid)
> +{
> +    g_assert(wid < worldguard_config->nworlds);
> +
> +    attrs->unspecified = 0;
> +    if (worldguard_config->tz_compat) {
> +        attrs->secure = wid;
> +    } else {
> +        attrs->world_id = wid;
> +    }
> +}
> +
> +/* MemTxAttrs to WID converter */
> +uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
> +{
> +    if (attrs.unspecified) {
> +        if (worldguard_config->trustedwid != NO_TRUSTEDWID) {
> +            return worldguard_config->trustedwid;
> +        } else {
> +            return worldguard_config->nworlds - 1;
> +        }
> +    }
> +
> +    if (worldguard_config->tz_compat) {
> +        return attrs.secure;
> +    } else {
> +        return attrs.world_id;
> +    }
> +}
> +
> +bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
> +{
> +    uint32_t wid = mem_attrs_to_wid(attrs);
> +    uint32_t trustedwid = worldguard_config->trustedwid;
> +
> +    if ((trustedwid == NO_TRUSTEDWID) || (wid == trustedwid)) {
> +        return true;
> +    } else {
> +        /*
> +         * Only Trusted WID could access WG blocks if having it.
> +         * Access them from other WIDs will get failed.
> +         */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Invalid access to %s from non-trusted WID %d\n",
> +                      __func__, wgblock, wid);
> +
> +        return false;
> +    }
> +}
> +
> +static void riscv_worldguard_realize(DeviceState *dev, Error **errp)
> +{
> +    RISCVWorldGuardState *s = RISCV_WORLDGUARD(dev);
> +
> +    if (worldguard_config != NULL) {
> +        error_setg(errp, "Couldn't realize multiple global WorldGuard configs.");
> +        return;
> +    }
> +
> +    if ((s->nworlds) & (s->nworlds - 1)) {
> +        error_setg(errp, "Current implementation only support power-of-2 NWorld.");
> +        return;
> +    }
> +
> +    if ((s->trustedwid != NO_TRUSTEDWID) && (s->trustedwid >= s->nworlds)) {
> +        error_setg(errp, "Trusted WID must be less than the number of world.");
> +        return;
> +    }
> +
> +    if ((s->nworlds != 2) && (s->tz_compat)) {
> +        error_setg(errp, "Only 2 worlds system could use TrustZone compatible mode.");
> +        return;
> +    }
> +
> +    /* Register WG global config */
> +    worldguard_config = s;
> +
> +    /* Initialize global data for wgChecker */
> +    wgc_slot_perm_mask = MAKE_64BIT_MASK(0, 2 * worldguard_config->nworlds);
> +}
> +
> +static void riscv_worldguard_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, riscv_worldguard_properties);
> +    dc->user_creatable = true;
> +    dc->realize = riscv_worldguard_realize;
> +}
> +
> +static const TypeInfo riscv_worldguard_info = {
> +    .name          = TYPE_RISCV_WORLDGUARD,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(RISCVWorldGuardState),
> +    .class_init    = riscv_worldguard_class_init,
> +};
> +
> +/*
> + * Create WorldGuard global config
> + */
> +DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
> +                                     bool hw_bypass, bool tz_compat)
> +{
> +    DeviceState *dev = qdev_new(TYPE_RISCV_WORLDGUARD);
> +    qdev_prop_set_uint32(dev, "nworlds", nworlds);
> +    qdev_prop_set_uint32(dev, "trustedwid", trustedwid);
> +    qdev_prop_set_bit(dev, "hw-bypass", hw_bypass);
> +    qdev_prop_set_bit(dev, "tz-compat", tz_compat);
> +    qdev_realize(DEVICE(dev), NULL, &error_fatal);
> +    return dev;
> +}
> +
> +static void riscv_worldguard_register_types(void)
> +{
> +    type_register_static(&riscv_worldguard_info);
> +}
> +
> +type_init(riscv_worldguard_register_types)
> diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
> new file mode 100644
> index 0000000000..bb276e59b8
> --- /dev/null
> +++ b/include/hw/misc/riscv_worldguard.h
> @@ -0,0 +1,56 @@
> +/*
> + * RISC-V WorldGuard Devices
> + *
> + * Copyright (c) 2022 RISCV, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef HW_RISCV_WORLDGUARD_H
> +#define HW_RISCV_WORLDGUARD_H
> +
> +#include "qom/object.h"
> +#include "hw/sysbus.h"
> +#include "exec/hwaddr.h"
> +
> +#define TYPE_RISCV_WORLDGUARD "riscv.worldguard"
> +
> +#define NO_TRUSTEDWID           UINT32_MAX
> +
> +typedef struct RISCVWorldGuardState RISCVWorldGuardState;
> +DECLARE_INSTANCE_CHECKER(RISCVWorldGuardState, RISCV_WORLDGUARD,
> +                         TYPE_RISCV_WORLDGUARD)
> +
> +struct RISCVWorldGuardState {
> +    /*< private >*/
> +    DeviceState parent_obj;
> +
> +    /*< public >*/
> +
> +    /* Property */
> +    uint32_t nworlds;
> +    uint32_t trustedwid;
> +    bool hw_bypass;
> +    bool tz_compat;
> +};
> +
> +extern struct RISCVWorldGuardState *worldguard_config;
> +
> +DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
> +                                     bool hw_bypass, bool tz_compat);
> +
> +void wid_to_mem_attrs(MemTxAttrs *attrs, uint32_t wid);
> +uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
> +bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
> +
> +#endif


