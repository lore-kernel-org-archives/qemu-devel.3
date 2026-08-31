Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C7FC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11G3-0000xO-Bs; Mon, 31 Aug 2026 08:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x11Fv-0000wp-R5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:36:57 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x11Fs-0006tU-K7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 08:36:55 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2530cabcf4so526172166b.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 05:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788179810; cv=none;
 d=google.com; s=arc-20260327;
 b=WgdnmIp5N7XyT+iTdLHQjhDLjJRR9rftIlmzeSpU454MGvFmykjjVtKo+XYzm75UNq
 I2zg15M9xIBW/GwnqM4boSiwMMMkz6hEePug85XdUa9ejRDMOYZjbjeujVFDd7YpunSh
 MCFXp5vfVEr4aJgoUxeyHGsqFFYdKLLWDiWxZifvKprgmgFg+MB2bk7ukSRg1Anjt2q6
 YVjMWbAZwJLMz3FBSNmfO63jpqTWZNfauPJyFK4YNW90pb+bbgjNAixLEM9U9ulEMxdn
 tNuFFrOUyriVhXkEdDUIU0IUzl26UIX68DKZY8xjdKImTe75KW62uHqck53nPASuj1hN
 sufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3UBkBfAl8cEShHMKCt7pFQls35m2H8UkKRiRlglJXFA=;
 fh=dLrxXhNFLYOe0h//qW0yf246b4AxzSerEDHU468ijm8=;
 b=O6y2Oe6sAIz+z64mzo6ALVeoJB5nR9qwnLf57w69/PEIvEeOTLeSwdLR+Ni8bZf09m
 PuDNh6c4ZpfWd2l3YvP4VK0bihUt+zVfo3SGh1Ai+35pRT0lycLstjYE0ax94KJey9w/
 06wb4DT4k3n6OXSL+jsa2fDXErUKmj3siMFbZAHT1F5WIXF+Z+PWmsw8nMsOIKjAZ4JC
 d3ZmO0IQIc5w7iQF0wEpDx+na4Yr3Xdto/mUDVowvd99rsLTIpQf43QaXvNtjghDuLDZ
 lfv8DifkMc9QusvK7B0ksPJV/lb8rFVqnRfXHqbwlrgNDFNWgdJI1/PFG3BCDStOVhRm
 tkIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788179810; x=1788784610; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3UBkBfAl8cEShHMKCt7pFQls35m2H8UkKRiRlglJXFA=;
 b=X/NCs0vVQtXQ1zWCeQXuaIJuuaTuZzrUdKkU8RPYBjFfyl/EfXZM3ROmzKU0skPVuO
 aRuS4UxMW8tYlhSStE7aJma+Qw4XMPk7tpxmxWEfZagC7tOML8ZRm0RadzRuaaCVkL92
 wNhnGyrC0g7+i3FaN/PTLSX64J/iRPapaZPHBS3hNiwCYbZ86feQS25qJWqdh5AXIMKm
 H7AJv+88tCySf7DIqrnFaw80x1slxzwHLHLqjNJPFEYGivOTZll25Ephbr1xS8FC4K89
 G7K8iikf1kBvb7y4PEE4C5qiHB/X2l6zvI8WtB8tAQB/4fQ4Phee/Ajavanbel57Pusa
 Cmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788179810; x=1788784610;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3UBkBfAl8cEShHMKCt7pFQls35m2H8UkKRiRlglJXFA=;
 b=bMI0UPLPm4ZDcxLfkdOC85gXcb6goA7DhVmk55i+S1wmc3Rn87h4nz/vBNYuC+0iA4
 qpgcc0Y8wVnqe7mqBBTatdHJYOGNEqFKGs9SBrsnMw8qmBEmuhd0oDeY5mHfPG2EWPey
 R62fJO6CcVA+8v8iGzjnKjQXaicEw5tO+MdfEULWwitmX0TXGriDftP9X3MQFj7PHIvd
 jTRimen5f98VW2qwQkBRxU+62oZGNBL6RZEthIzjoKoUXRjjcHQ93Uc0S3W7zhqgIyRC
 bf7pcLArfhi57QTFjNaNza08AdUlQJqjCyJpfmbWT2BndLTUSR8KLtp0js/t7zkk+SQ+
 /FfQ==
X-Gm-Message-State: AFuF++nsb2YqWc5wMdWkEhP0fyYMQE+zdxlsbQo8+53fsG9glxEVYZwM
 3pYixJ+4+wCVLuTEs+GA4HvBuH8P+ad8DvkFgxgGggvRwCsZLEaurwnTGxIIykw+DnO+O7YjnUT
 tp9tVqdrQl2uGHw/h2twY7Ib3hlg/9L8=
X-Gm-Gg: AR+sD11CcZplmqYPXX7mHVjLNR5PEnu05q+zhVMf42F7nKOOoWgXZ3rQaJl1g3F+er9
 uyWF5tx2XN/dm1vFxLaEw8PBHS/VZhv7IETCX+9tczzQKIw/Xtso9W6iIi+8T0WkmJlfyBl8J/2
 xiKGT1fm99rOEsTkYs00TGFcQlSGq8qdqimGGszaKAzzmgV9pUfiQKWQofHMvHoXeWtMauWtU4l
 BVqJDZl6It5D/sbGU0WmnMe35fwjUkpwQRyKHp3xgvMfC/rOIqyUDMzCQuBqd7qUZ+kYr7kOi5x
 MI/BkKkNIP+piFVe9o5In1IIhQg6joUX4UfMwCY1Fipl
X-Received: by 2002:a17:906:c006:b0:c25:5f21:6544 with SMTP id
 a640c23a62f3a-c25b3cb9706mr11516666b.11.1788179809817; Mon, 31 Aug 2026
 05:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-23-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-23-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 31 Aug 2026 20:36:36 +0800
X-Gm-Features: AcwNN1WP8NvhPzxOvvFXUwg7-LBr7CKMqsd1Y6BRu3RQusdvH3OG3KcTRhbGPoo
Message-ID: <CAE2XoE_HU9RO-pQVmrAv76k-oJshpNEgNE64fWb7AN+-eySvdg@mail.gmail.com>
Subject: Re: [PATCH 22/47] hw/riscv: remove machines-qom.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005bd91f065a570ea6"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000005bd91f065a570ea6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The changes to DEFINE_MACHINE_* is too much and redundant

They can be simplified by preserving DEFINE_MACHINE_RISCV32
DEFINE_MACHINE_RISCV64 DEFINE_MACHINE_RISCV32_64, along with ARM related
macros.

For example: for riscv we can do this, we can do the same for arm and other
arch when use  DEFINE_MACHINE_*.

Pierrick

I've reworked the commits at
https://github.com/lygstate/qemu/tree/s11.1-riscv-arm-tmp1.0.1, you can
check the commits there, I do not post patches to mail-list to avoid review
burden.

/*
 * QOM type definitions for riscv32 / riscv64 machines
 *
 *  Copyright (c) rev.ng Labs Srl.
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#ifndef HW_RISCV_MACHINES_QOM_H
#define HW_RISCV_MACHINES_QOM_H

#include "hw/core/boards.h"
#include "qemu/target-info.h"

/*
 * Helper macros for defining machines available in qemu-system-riscv32,
 * qemu-system-riscv64, or both.
 */

#define DEFINE_MACHINE_RISCV32(namestr, machine_initfn) \
        DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, \
                                machine_initfn, false, target_riscv32, \
                                NULL)

#define DEFINE_MACHINE_RISCV64(namestr, machine_initfn) \
        DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, \
                                machine_initfn, false, target_riscv64, \
                                NULL)

#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn) \
        DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, \
                                machine_initfn, false, target_base_riscv, \
                                NULL)

#endif


On Sat, Aug 29, 2026 at 7:04=E2=80=AFAM Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  hw/core/null-machine.c          |  1 -
>  hw/riscv/boston-aia.c           |  1 -
>  hw/riscv/k230.c                 |  1 -
>  hw/riscv/microblaze-v-generic.c |  1 -
>  hw/riscv/microchip_pfsoc.c      |  1 -
>  hw/riscv/opentitan.c            |  1 -
>  hw/riscv/shakti_c.c             |  1 -
>  hw/riscv/sifive_e.c             |  1 -
>  hw/riscv/sifive_u.c             |  1 -
>  hw/riscv/spike.c                |  1 -
>  hw/riscv/tt_atlantis.c          |  1 -
>  hw/riscv/virt.c                 |  1 -
>  hw/riscv/xiangshan_kmh.c        |  1 -
>  include/hw/riscv/machines-qom.h | 14 --------------
>  target-info-qom.c               |  1 -
>  target/riscv/machine.c          |  1 -
>  16 files changed, 29 deletions(-)
>  delete mode 100644 include/hw/riscv/machines-qom.h
>
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 2f008c4a702..60254913019 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -16,7 +16,6 @@
>  #include "hw/core/boards.h"
>  #include "system/address-spaces.h"
>  #include "hw/core/cpu.h"
> -#include "hw/riscv/machines-qom.h"
>
>  static void machine_none_init(MachineState *mch)
>  {
> diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
> index 30eff10bc5f..b90da096ea8 100644
> --- a/hw/riscv/boston-aia.c
> +++ b/hw/riscv/boston-aia.c
> @@ -18,7 +18,6 @@
>  #include "hw/ide/ahci-pci.h"
>  #include "hw/core/loader.h"
>  #include "hw/riscv/cps.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/pci-host/xilinx-pcie.h"
>  #include "hw/core/qdev-properties.h"
>  #include "qapi/error.h"
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 72d50d369a9..34905bb1702 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -26,7 +26,6 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/riscv/k230.h"
>  #include "hw/riscv/boot.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/sifive_plic.h"
>  #include "hw/char/serial-mm.h"
> diff --git a/hw/riscv/microblaze-v-generic.c
b/hw/riscv/microblaze-v-generic.c
> index 503e8e08992..b0494b1ac50 100644
> --- a/hw/riscv/microblaze-v-generic.c
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -25,7 +25,6 @@
>  #include "system/address-spaces.h"
>  #include "hw/char/xilinx_uartlite.h"
>  #include "hw/misc/unimp.h"
> -#include "hw/riscv/machines-qom.h"
>
>  #define LMB_BRAM_SIZE (128 * KiB)
>  #define MEMORY_BASEADDR 0x80000000
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 42d4fc39734..60bb96da016 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -49,7 +49,6 @@
>  #include "hw/misc/unimp.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/riscv/microchip_pfsoc.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/sifive_plic.h"
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index c58d8993303..8cd660dd415 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -26,7 +26,6 @@
>  #include "hw/core/boards.h"
>  #include "hw/misc/unimp.h"
>  #include "hw/riscv/boot.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "qemu/units.h"
>  #include "system/system.h"
>  #include "system/address-spaces.h"
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index 9fd7856dc24..a205a213324 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -19,7 +19,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/core/boards.h"
>  #include "hw/riscv/shakti_c.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/intc/sifive_plic.h"
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index ede7cb52f00..1acfea49668 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -40,7 +40,6 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_e.h"
>  #include "hw/riscv/boot.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/char/sifive_uart.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/sifive_plic.h"
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 08687cfc363..997ee91aa0e 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -51,7 +51,6 @@
>  #include "hw/riscv/riscv_hart.h"
>  #include "hw/riscv/sifive_u.h"
>  #include "hw/riscv/boot.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/riscv/fdt-common.h"
>  #include "hw/char/sifive_uart.h"
>  #include "hw/intc/riscv_aclint.h"
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 3786de4b0b7..e36fe996b09 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -34,7 +34,6 @@
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/fdt-common.h"
>  #include "hw/riscv/numa.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/char/riscv_htif.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "chardev/char.h"
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 5e155726abf..7d02868b222 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -20,7 +20,6 @@
>
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/fdt-common.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/riscv/riscv_hart.h"
>
>  #include "hw/char/serial-mm.h"
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d2ae321a376..dd396410178 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -36,7 +36,6 @@
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/fdt-common.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "hw/riscv/numa.h"
>  #include "kvm/kvm_riscv.h"
>  #include "hw/firmware/smbios.h"
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index e02624b62b4..247a0b5d1f2 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -41,7 +41,6 @@
>  #include "hw/riscv/boot.h"
>  #include "hw/riscv/xiangshan_kmh.h"
>  #include "hw/riscv/riscv_hart.h"
> -#include "hw/riscv/machines-qom.h"
>  #include "system/system.h"
>
>  static const MemMapEntry xiangshan_kmh_memmap[] =3D {
> diff --git a/include/hw/riscv/machines-qom.h
b/include/hw/riscv/machines-qom.h
> deleted file mode 100644
> index 79d212eeb7d..00000000000
> --- a/include/hw/riscv/machines-qom.h
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -/*
> - * QOM type definitions for riscv32 / riscv64 machines
> - *
> - *  Copyright (c) rev.ng Labs Srl.
> - *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#ifndef HW_RISCV_MACHINES_QOM_H
> -#define HW_RISCV_MACHINES_QOM_H
> -
> -#include "hw/core/boards.h"
> -
> -#endif
> diff --git a/target-info-qom.c b/target-info-qom.c
> index f98d3d7698e..6965e4d1169 100644
> --- a/target-info-qom.c
> +++ b/target-info-qom.c
> @@ -12,7 +12,6 @@
>  #include "qemu/target-info-impl.h"
>  #include "qemu/target-info-init.h"
>  #include "qemu/target-info-qom.h"
> -#include "hw/riscv/machines-qom.h"
>
>  static void target_info_qom_class_init(ObjectClass *oc, const void *
data)
>  {
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 22a918cec95..c3f5a255099 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -24,7 +24,6 @@
>  #include "migration/cpu.h"
>  #include "exec/icount.h"
>  #include "target/riscv/tcg/debug.h"
> -#include "hw/riscv/machines-qom.h"
>  #ifdef CONFIG_KVM
>  #include "kvm/kvm_riscv.h"
>  #endif
> --
> 2.43.0
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000005bd91f065a570ea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The changes to DEFINE_MACHINE_* is too much and redundant<=
br><br>They can be simplified by preserving DEFINE_MACHINE_RISCV32 DEFINE_M=
ACHINE_RISCV64 DEFINE_MACHINE_RISCV32_64, along with ARM related macros.<br=
><br><div>For example: for riscv we can do this, we can do the same for arm=
 and other arch when use=C2=A0

DEFINE_MACHINE_*.</div><div><br></div><div>Pierrick</div><div><br></div><di=
v>I&#39;ve reworked the commits at <a href=3D"https://github.com/lygstate/q=
emu/tree/s11.1-riscv-arm-tmp1.0.1">https://github.com/lygstate/qemu/tree/s1=
1.1-riscv-arm-tmp1.0.1</a>, you can check the commits there, I do not post =
patches to mail-list to avoid review burden.<br><div><br>/*<br>=C2=A0* QOM =
type definitions for riscv32 / riscv64 machines<br>=C2=A0*<br>=C2=A0* =C2=
=A0Copyright (c) rev.ng Labs Srl.<br>=C2=A0*<br>=C2=A0* SPDX-License-Identi=
fier: GPL-2.0-or-later<br>=C2=A0*/<br><br>#ifndef HW_RISCV_MACHINES_QOM_H<b=
r>#define HW_RISCV_MACHINES_QOM_H<br><br>#include &quot;hw/core/boards.h&qu=
ot;<br>#include &quot;qemu/target-info.h&quot;<br><br>/*<br>=C2=A0* Helper =
macros for defining machines available in qemu-system-riscv32,<br>=C2=A0* q=
emu-system-riscv64, or both.<br>=C2=A0*/<br><br>#define DEFINE_MACHINE_RISC=
V32(namestr, machine_initfn) \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFINE_MACHIN=
E_EXTENDED(namestr, MACHINE, MachineState, \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 machine_initfn, false, target_riscv32, \<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL)<br><br>#define DEFINE_MACHINE_RISCV64(namestr, mach=
ine_initfn) \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFINE_MACHINE_EXTENDED(namest=
r, MACHINE, MachineState, \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machi=
ne_initfn, false, target_riscv64, \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL)<br><br>#define DEFINE_MACHINE_RISCV32_64(namestr, machine_initfn)=
 \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEFINE_MACHINE_EXTENDED(namestr, MACHINE,=
 MachineState, \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_initfn, fa=
lse, target_base_riscv, \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL)<br=
><br>#endif<br><br><br>On Sat, Aug 29, 2026 at 7:04=E2=80=AFAM Pierrick Bou=
vier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouv=
ier@oss.qualcomm.com</a>&gt; wrote:<br>&gt;<br>&gt; Signed-off-by: Pierrick=
 Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.=
bouvier@oss.qualcomm.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0hw/core/null-mac=
hine.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 -<br>&gt; =C2=A0hw/riscv=
/boston-aia.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0=
hw/riscv/k230.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A01 -<br>&gt; =C2=A0hw/riscv/microblaze-v-generic.c | =C2=A01 -<br>&gt;=
 =C2=A0hw/riscv/microchip_pfsoc.c =C2=A0 =C2=A0 =C2=A0| =C2=A01 -<br>&gt; =
=C2=A0hw/riscv/opentitan.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A01 -<br>&gt; =C2=A0hw/riscv/shakti_c.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0hw/riscv/sifive_e.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0hw/riscv/sifive_u.c =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0hw/riscv/spike=
.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 -<br>&g=
t; =C2=A0hw/riscv/tt_atlantis.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01=
 -<br>&gt; =C2=A0hw/riscv/virt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0hw/riscv/xiangshan_kmh.c =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A01 -<br>&gt; =C2=A0include/hw/riscv/machines-qom.h =
| 14 --------------<br>&gt; =C2=A0target-info-qom.c =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 -<br>&gt; =C2=A0target/riscv/machine.=
c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 -<br>&gt; =C2=A016 files chan=
ged, 29 deletions(-)<br>&gt; =C2=A0delete mode 100644 include/hw/riscv/mach=
ines-qom.h<br>&gt;<br>&gt; diff --git a/hw/core/null-machine.c b/hw/core/nu=
ll-machine.c<br>&gt; index 2f008c4a702..60254913019 100644<br>&gt; --- a/hw=
/core/null-machine.c<br>&gt; +++ b/hw/core/null-machine.c<br>&gt; @@ -16,7 =
+16,6 @@<br>&gt; =C2=A0#include &quot;hw/core/boards.h&quot;<br>&gt; =C2=A0=
#include &quot;system/address-spaces.h&quot;<br>&gt; =C2=A0#include &quot;h=
w/core/cpu.h&quot;<br>&gt; -#include &quot;hw/riscv/machines-qom.h&quot;<br=
>&gt;<br>&gt; =C2=A0static void machine_none_init(MachineState *mch)<br>&gt=
; =C2=A0{<br>&gt; diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.=
c<br>&gt; index 30eff10bc5f..b90da096ea8 100644<br>&gt; --- a/hw/riscv/bost=
on-aia.c<br>&gt; +++ b/hw/riscv/boston-aia.c<br>&gt; @@ -18,7 +18,6 @@<br>&=
gt; =C2=A0#include &quot;hw/ide/ahci-pci.h&quot;<br>&gt; =C2=A0#include &qu=
ot;hw/core/loader.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/cps.h&quot;=
<br>&gt; -#include &quot;hw/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#inclu=
de &quot;hw/pci-host/xilinx-pcie.h&quot;<br>&gt; =C2=A0#include &quot;hw/co=
re/qdev-properties.h&quot;<br>&gt; =C2=A0#include &quot;qapi/error.h&quot;<=
br>&gt; diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c<br>&gt; index 72d50d=
369a9..34905bb1702 100644<br>&gt; --- a/hw/riscv/k230.c<br>&gt; +++ b/hw/ri=
scv/k230.c<br>&gt; @@ -26,7 +26,6 @@<br>&gt; =C2=A0#include &quot;hw/core/s=
ysbus.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/k230.h&quot;<br>&gt; =
=C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; -#include &quot;hw/riscv=
/machines-qom.h&quot;<br>&gt; =C2=A0#include &quot;hw/intc/riscv_aclint.h&q=
uot;<br>&gt; =C2=A0#include &quot;hw/intc/sifive_plic.h&quot;<br>&gt; =C2=
=A0#include &quot;hw/char/serial-mm.h&quot;<br>&gt; diff --git a/hw/riscv/m=
icroblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c<br>&gt; index 503e8=
e08992..b0494b1ac50 100644<br>&gt; --- a/hw/riscv/microblaze-v-generic.c<br=
>&gt; +++ b/hw/riscv/microblaze-v-generic.c<br>&gt; @@ -25,7 +25,6 @@<br>&g=
t; =C2=A0#include &quot;system/address-spaces.h&quot;<br>&gt; =C2=A0#includ=
e &quot;hw/char/xilinx_uartlite.h&quot;<br>&gt; =C2=A0#include &quot;hw/mis=
c/unimp.h&quot;<br>&gt; -#include &quot;hw/riscv/machines-qom.h&quot;<br>&g=
t;<br>&gt; =C2=A0#define LMB_BRAM_SIZE (128 * KiB)<br>&gt; =C2=A0#define ME=
MORY_BASEADDR 0x80000000<br>&gt; diff --git a/hw/riscv/microchip_pfsoc.c b/=
hw/riscv/microchip_pfsoc.c<br>&gt; index 42d4fc39734..60bb96da016 100644<br=
>&gt; --- a/hw/riscv/microchip_pfsoc.c<br>&gt; +++ b/hw/riscv/microchip_pfs=
oc.c<br>&gt; @@ -49,7 +49,6 @@<br>&gt; =C2=A0#include &quot;hw/misc/unimp.h=
&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; =C2=A0#in=
clude &quot;hw/riscv/riscv_hart.h&quot;<br>&gt; -#include &quot;hw/riscv/ma=
chines-qom.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/microchip_pfsoc.h&=
quot;<br>&gt; =C2=A0#include &quot;hw/intc/riscv_aclint.h&quot;<br>&gt; =C2=
=A0#include &quot;hw/intc/sifive_plic.h&quot;<br>&gt; diff --git a/hw/riscv=
/opentitan.c b/hw/riscv/opentitan.c<br>&gt; index c58d8993303..8cd660dd415 =
100644<br>&gt; --- a/hw/riscv/opentitan.c<br>&gt; +++ b/hw/riscv/opentitan.=
c<br>&gt; @@ -26,7 +26,6 @@<br>&gt; =C2=A0#include &quot;hw/core/boards.h&q=
uot;<br>&gt; =C2=A0#include &quot;hw/misc/unimp.h&quot;<br>&gt; =C2=A0#incl=
ude &quot;hw/riscv/boot.h&quot;<br>&gt; -#include &quot;hw/riscv/machines-q=
om.h&quot;<br>&gt; =C2=A0#include &quot;qemu/units.h&quot;<br>&gt; =C2=A0#i=
nclude &quot;system/system.h&quot;<br>&gt; =C2=A0#include &quot;system/addr=
ess-spaces.h&quot;<br>&gt; diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shak=
ti_c.c<br>&gt; index 9fd7856dc24..a205a213324 100644<br>&gt; --- a/hw/riscv=
/shakti_c.c<br>&gt; +++ b/hw/riscv/shakti_c.c<br>&gt; @@ -19,7 +19,6 @@<br>=
&gt; =C2=A0#include &quot;qemu/osdep.h&quot;<br>&gt; =C2=A0#include &quot;h=
w/core/boards.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/shakti_c.h&quot=
;<br>&gt; -#include &quot;hw/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#incl=
ude &quot;qapi/error.h&quot;<br>&gt; =C2=A0#include &quot;qemu/error-report=
.h&quot;<br>&gt; =C2=A0#include &quot;hw/intc/sifive_plic.h&quot;<br>&gt; d=
iff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c<br>&gt; index ede7cb5=
2f00..1acfea49668 100644<br>&gt; --- a/hw/riscv/sifive_e.c<br>&gt; +++ b/hw=
/riscv/sifive_e.c<br>&gt; @@ -40,7 +40,6 @@<br>&gt; =C2=A0#include &quot;hw=
/riscv/riscv_hart.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/sifive_e.h&=
quot;<br>&gt; =C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; -#include =
&quot;hw/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#include &quot;hw/char/si=
five_uart.h&quot;<br>&gt; =C2=A0#include &quot;hw/intc/riscv_aclint.h&quot;=
<br>&gt; =C2=A0#include &quot;hw/intc/sifive_plic.h&quot;<br>&gt; diff --gi=
t a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c<br>&gt; index 08687cfc363..99=
7ee91aa0e 100644<br>&gt; --- a/hw/riscv/sifive_u.c<br>&gt; +++ b/hw/riscv/s=
ifive_u.c<br>&gt; @@ -51,7 +51,6 @@<br>&gt; =C2=A0#include &quot;hw/riscv/r=
iscv_hart.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/sifive_u.h&quot;<br=
>&gt; =C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; -#include &quot;hw=
/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/fdt-commo=
n.h&quot;<br>&gt; =C2=A0#include &quot;hw/char/sifive_uart.h&quot;<br>&gt; =
=C2=A0#include &quot;hw/intc/riscv_aclint.h&quot;<br>&gt; diff --git a/hw/r=
iscv/spike.c b/hw/riscv/spike.c<br>&gt; index 3786de4b0b7..e36fe996b09 1006=
44<br>&gt; --- a/hw/riscv/spike.c<br>&gt; +++ b/hw/riscv/spike.c<br>&gt; @@=
 -34,7 +34,6 @@<br>&gt; =C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; =
=C2=A0#include &quot;hw/riscv/fdt-common.h&quot;<br>&gt; =C2=A0#include &qu=
ot;hw/riscv/numa.h&quot;<br>&gt; -#include &quot;hw/riscv/machines-qom.h&qu=
ot;<br>&gt; =C2=A0#include &quot;hw/char/riscv_htif.h&quot;<br>&gt; =C2=A0#=
include &quot;hw/intc/riscv_aclint.h&quot;<br>&gt; =C2=A0#include &quot;cha=
rdev/char.h&quot;<br>&gt; diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt=
_atlantis.c<br>&gt; index 5e155726abf..7d02868b222 100644<br>&gt; --- a/hw/=
riscv/tt_atlantis.c<br>&gt; +++ b/hw/riscv/tt_atlantis.c<br>&gt; @@ -20,7 +=
20,6 @@<br>&gt;<br>&gt; =C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; =
=C2=A0#include &quot;hw/riscv/fdt-common.h&quot;<br>&gt; -#include &quot;hw=
/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/riscv_har=
t.h&quot;<br>&gt;<br>&gt; =C2=A0#include &quot;hw/char/serial-mm.h&quot;<br=
>&gt; diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c<br>&gt; index d2ae321a=
376..dd396410178 100644<br>&gt; --- a/hw/riscv/virt.c<br>&gt; +++ b/hw/risc=
v/virt.c<br>&gt; @@ -36,7 +36,6 @@<br>&gt; =C2=A0#include &quot;hw/riscv/vi=
rt.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/boot.h&quot;<br>&gt; =C2=
=A0#include &quot;hw/riscv/fdt-common.h&quot;<br>&gt; -#include &quot;hw/ri=
scv/machines-qom.h&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/numa.h&quot;=
<br>&gt; =C2=A0#include &quot;kvm/kvm_riscv.h&quot;<br>&gt; =C2=A0#include =
&quot;hw/firmware/smbios.h&quot;<br>&gt; diff --git a/hw/riscv/xiangshan_km=
h.c b/hw/riscv/xiangshan_kmh.c<br>&gt; index e02624b62b4..247a0b5d1f2 10064=
4<br>&gt; --- a/hw/riscv/xiangshan_kmh.c<br>&gt; +++ b/hw/riscv/xiangshan_k=
mh.c<br>&gt; @@ -41,7 +41,6 @@<br>&gt; =C2=A0#include &quot;hw/riscv/boot.h=
&quot;<br>&gt; =C2=A0#include &quot;hw/riscv/xiangshan_kmh.h&quot;<br>&gt; =
=C2=A0#include &quot;hw/riscv/riscv_hart.h&quot;<br>&gt; -#include &quot;hw=
/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#include &quot;system/system.h&qu=
ot;<br>&gt;<br>&gt; =C2=A0static const MemMapEntry xiangshan_kmh_memmap[] =
=3D {<br>&gt; diff --git a/include/hw/riscv/machines-qom.h b/include/hw/ris=
cv/machines-qom.h<br>&gt; deleted file mode 100644<br>&gt; index 79d212eeb7=
d..00000000000<br>&gt; --- a/include/hw/riscv/machines-qom.h<br>&gt; +++ /d=
ev/null<br>&gt; @@ -1,14 +0,0 @@<br>&gt; -/*<br>&gt; - * QOM type definitio=
ns for riscv32 / riscv64 machines<br>&gt; - *<br>&gt; - * =C2=A0Copyright (=
c) rev.ng Labs Srl.<br>&gt; - *<br>&gt; - * SPDX-License-Identifier: GPL-2.=
0-or-later<br>&gt; - */<br>&gt; -<br>&gt; -#ifndef HW_RISCV_MACHINES_QOM_H<=
br>&gt; -#define HW_RISCV_MACHINES_QOM_H<br>&gt; -<br>&gt; -#include &quot;=
hw/core/boards.h&quot;<br>&gt; -<br>&gt; -#endif<br>&gt; diff --git a/targe=
t-info-qom.c b/target-info-qom.c<br>&gt; index f98d3d7698e..6965e4d1169 100=
644<br>&gt; --- a/target-info-qom.c<br>&gt; +++ b/target-info-qom.c<br>&gt;=
 @@ -12,7 +12,6 @@<br>&gt; =C2=A0#include &quot;qemu/target-info-impl.h&quo=
t;<br>&gt; =C2=A0#include &quot;qemu/target-info-init.h&quot;<br>&gt; =C2=
=A0#include &quot;qemu/target-info-qom.h&quot;<br>&gt; -#include &quot;hw/r=
iscv/machines-qom.h&quot;<br>&gt;<br>&gt; =C2=A0static void target_info_qom=
_class_init(ObjectClass *oc, const void * data)<br>&gt; =C2=A0{<br>&gt; dif=
f --git a/target/riscv/machine.c b/target/riscv/machine.c<br>&gt; index 22a=
918cec95..c3f5a255099 100644<br>&gt; --- a/target/riscv/machine.c<br>&gt; +=
++ b/target/riscv/machine.c<br>&gt; @@ -24,7 +24,6 @@<br>&gt; =C2=A0#includ=
e &quot;migration/cpu.h&quot;<br>&gt; =C2=A0#include &quot;exec/icount.h&qu=
ot;<br>&gt; =C2=A0#include &quot;target/riscv/tcg/debug.h&quot;<br>&gt; -#i=
nclude &quot;hw/riscv/machines-qom.h&quot;<br>&gt; =C2=A0#ifdef CONFIG_KVM<=
br>&gt; =C2=A0#include &quot;kvm/kvm_riscv.h&quot;<br>&gt; =C2=A0#endif<br>=
&gt; --<br>&gt; 2.43.0<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=
=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div></di=
v>

--0000000000005bd91f065a570ea6--

