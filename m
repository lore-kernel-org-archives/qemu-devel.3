Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E64BD3CCAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggWN-0007mn-Uc; Fri, 16 Jan 2026 04:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vggWM-0007mX-Rw
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:53:34 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vggWI-0000UK-0D
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:53:34 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso1093476f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 01:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768557208; x=1769162008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73BI44yiB6bZ8IXi7tZsKIlrvEbg6EvtJ1q/icvuCwo=;
 b=Oe3hxRoSxfNBIHZ72/EbxzLjdmEq9pdyH9YY/+St29hCQ/GSWKYY/GMsxdZ/eEEeab
 3P0UFlzcxQulCQBPNXzfsk4vA+8+vrUGHP8nbivXlPlOsfU5Z9uWYYSuaxcfNf+OhXbY
 orpYCcBDkRv45qTc3GZM32TPohus1O4C5J/4D5WA65Ydb3KslP4+sDsSegGndhDLn7G8
 uaCOrRRHlXwUCWtOhBL6RbCBJsbZMdcXjBqWFgL5Kv+gQCO25BPNIELACg7FADmw5z6l
 Rpru/et+DDUsp4aDPnEBFev1e45j6O5Ndid8sRA9F4mZIFXXddyBEgcAnaJr1hG8iUiE
 f1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768557208; x=1769162008;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73BI44yiB6bZ8IXi7tZsKIlrvEbg6EvtJ1q/icvuCwo=;
 b=DiUG1q02J1FKxAA+luMHJkV/qRCfAuwHL+l31zS+RebZwq/D7UzBX3u4gmFFMxY/GC
 48EHHlkHURC0s1ghbyJG08TDVcyBgvJsdz/oZ9b3ELfGMnhKwyZCgep3W9kAeBASSd8D
 cRdeODg7F03y2V/4PoVIF24tK9gD4I+nFi30KeTM3d5Nb/Ciw5u5cZRNI1TaSOpmxFwP
 oVkzuDasrgbiLh9usa2LM1ERbAZMtYD3VwE3oHUQXhCO+S/hsJcTajm3OMRhtUnvfhU/
 fIWIq/QH5Fm3mRZXMI/6qDemb5UnFA4lpNwMqcjuBUCKS9W0K1+KBg5Tuavmma4dxICq
 quSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo2bt2SkiI4GR8iHGwSKInumA446YpBxBHVi4AYU6zDjAyih6gMFqFne3nMmaYibENeWrPL9Ze2x1r@nongnu.org
X-Gm-Message-State: AOJu0YwZepKf3JLqRaFJbePlBRcXD3zWlIoOpGdief+xNEJNCebWfIGr
 gNY0ecbC2EOUW9STsMb+taad1idesUmku4DjuDywrimqQwT+5aZ/Dvpj
X-Gm-Gg: AY/fxX4R3f2rdHyRaB8Wbj+L98vIYf+pvxjM/GJYKY8m/Zbf7ldc6u2C6n7ZcZJ2Ogx
 WKjpwMjxLaXXgfKArzE9FnjyzUAIaPbFQxCRY0yNiwmzYYo1CDtnnxTQ1+x2A3OTNx2L5H0NjjF
 ashtUh8ZS4GnhmiyJHCKJ1wBOICDlRrDzhUuuU7826+sl8wgoNAWvj7SMvARFJ85EWm8hFn4/OH
 r8HIS+z/+81vSTTLC6+y+1zz/MLY1b0iSpLSMow0kJIcIXf01ILRGhwu75kWXbrS/kTOp+GZGd5
 31HAhEOve6v6hz6/+BNeaQdwgf4gIbjLOHRODLwVsTpN0kRXCUkE9JTyi8WnnlY5LyF9GzmYz3y
 K3+qWRi9Jl/BPSFt8KIoIQYtLWDEGavm5PIQ7rFS3MtBqjHbnruYH2vPV+w1pIhbk926L3LEC63
 /MmPM7HK1TQx/BUqpUst+lsRo9OGguK82jzCNd9wiR08htirDCpdsHDxBsAIFJResmfdEw5181N
 iROYV0xc473W4AoWlDj+j6EZkSFe8CkFTA=
X-Received: by 2002:a05:6000:2c08:b0:432:5b81:497 with SMTP id
 ffacd0b85a97d-4356a071b3bmr2794761f8f.58.1768557207117; 
 Fri, 16 Jan 2026 01:53:27 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2c88-c900-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:2c88:c900:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm4253194f8f.40.2026.01.16.01.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 01:53:26 -0800 (PST)
Date: Fri, 16 Jan 2026 09:53:24 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 3/6] hw/net/can/flexcan: NXP FlexCAN core emulation
In-Reply-To: <f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1e@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <11864d448c9aee3b81d016617e5fcf150ed232c5.1765826753.git.matyas.bobek@gmail.com>
 <f3cb3166-c3f8-4ed8-8c9a-cbf48b071d1e@gmail.com>
Message-ID: <E5AC1F6B-EC35-4454-87BF-B95D162456C2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 2=2E Januar 2026 14:53:42 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 15=2E Dezember 2025 20:03:12 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <mat=
yas=2Ebobek@gmail=2Ecom>:
>> This commit adds the FlexCAN2 emulator implementation and
>> plugs it into Meson and Kconfig=2E
>> FlexCAN2 version can be found in i=2EMX6 SoCs and others=2E
>>=20
>> More information about the implementation can be found in [1]=2E
>>=20
>> [1] http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-=
Bobek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>>=20
>> Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>> ---
>> MAINTAINERS               |    1 +
>> hw/net/Kconfig            |    5 +
>> hw/net/can/flexcan=2Ec      | 1469 ++++++++++++++++++++++++++++++++++++=
+
>> hw/net/can/flexcan_regs=2Eh |  188 +++++
>> hw/net/can/meson=2Ebuild    |    1 +
>> hw/net/can/trace-events   |   18 +
>> include/hw/net/flexcan=2Eh  |  153 ++++
>> 7 files changed, 1835 insertions(+)
>> create mode 100644 hw/net/can/flexcan=2Ec
>> create mode 100644 hw/net/can/flexcan_regs=2Eh
>> create mode 100644 include/hw/net/flexcan=2Eh
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 63e9ba521b=2E=2Ea0b152939b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2858,6 +2858,7 @@ W: https://canbus=2Epages=2Efel=2Ecvut=2Ecz/
>> F: net/can/*
>> F: hw/net/can/*
>> F: include/net/can_*=2Eh
>> +F: include/hw/net/flexcan=2Eh
>> F: docs/system/devices/can=2Erst
>>=20
>> OpenPIC interrupt controller
>> diff --git a/hw/net/Kconfig b/hw/net/Kconfig
>> index 2b513d6895=2E=2E160c311dcd 100644
>> --- a/hw/net/Kconfig
>> +++ b/hw/net/Kconfig
>> @@ -160,3 +160,8 @@ config CAN_CTUCANFD_PCI
>>     default y if PCI_DEVICES
>>     depends on PCI && CAN_CTUCANFD
>>     select CAN_BUS
>> +
>> +config CAN_FLEXCAN
>> +    bool
>> +    default y
>
>I think the "default y" isn't needed since CONFIG_FSL_IMX6 will select it=
=2E
>
>However, I need to add a "depends on IMX" to prevent linker errors=2E You=
 might be able to reproduce this by enabling other architectures than arm-s=
oftmmu=2E
>
>> +    select CAN_BUS
>> diff --git a/hw/net/can/flexcan=2Ec b/hw/net/can/flexcan=2Ec
>> new file mode 100644
>> index 0000000000=2E=2E1f50dd1d5b
>> --- /dev/null
>> +++ b/hw/net/can/flexcan=2Ec
>> @@ -0,0 +1,1469 @@
>> +/*
>> + * QEMU model of the NXP FLEXCAN device=2E
>> + *
>> + * This implementation is based on the following reference manual:
>> + * i=2EMX 6Dual/6Quad Applications Processor Reference Manual
>> + * Document Number: IMX6DQRM, Rev=2E 6, 05/2020
>> + *
>> + * Copyright (c) 2025 Matyas Bobek <matyas=2Ebobek@gmail=2Ecom>
>> + *
>> + * Based on CTU CAN FD emulation implemented by Jan Charvat=2E
>> + *
>> + * This code is licensed under the GPL version 2 or later=2E  See
>> + * the COPYING file in the top-level directory=2E
>> + *
>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> + */
>> +
>> +#include "qemu/osdep=2Eh"
>> +#include "qemu/log=2Eh"
>> +#include "hw/sysbus=2Eh"
>> +#include "qapi/error=2Eh"
>> +#include "hw/irq=2Eh"
>> +#include "migration/vmstate=2Eh"
>> +#include "net/can_emu=2Eh"
>> +#include "hw/qdev-properties=2Eh"
>> +#include "trace=2Eh"
>> +
>> +#include "hw/net/flexcan=2Eh"
>> +#include "flexcan_regs=2Eh"
>> +#include "qemu/timer=2Eh"
>> +
>> +#define USE(var) (void)var;
>> +
>> +#define DEBUG_FLEXCAN 1
>> +#ifndef DEBUG_FLEXCAN
>> +#define DEBUG_FLEXCAN 0
>> +#endif
>> +
>> +/*
>> + * Indicates MB w/ received frame has not been serviced yet
>> + * This is an emulator-only flag in position of unused (reserved) bit
>> + * of message buffer control register
>> + */
>> +#define FLEXCAN_MB_CNT_NOT_SRV          BIT(23)
>> +/**
>> + * if no MB is locked, FlexcanState=2Elocked_mb
>> + * is set to FLEXCAN_NO_MB_LOCKED
>> + */
>> +#define FLEXCAN_NO_MB_LOCKED            -1
>> +/**
>> + * if no frame is waiting in the SMB, FlexcanState=2Esmb_target_mbid
>> + * is set to FLEXCAN_SMB_EMPTY
>> + */
>> +#define FLEXCAN_SMB_EMPTY               -1
>> +/**
>> + * When the module is disabled or in freeze mode,
>> + * the timer is not running=2E That is indicated by setting
>> + * FlexcanState=2Etimer_start to FLEXCAN_TIMER_STOPPED=2E
>> + */
>> +#define FLEXCAN_TIMER_STOPPED           -1
>> +
>> +/**
>> + * defines the end of the memory space of the implemented registers
>> + *
>> + * also prevents addressing memory after FlexcanRegs end
>> + */
>> +#define FLEXCAN_ADDR_SPC_END offsetof(FlexcanRegs, _reserved6)
>> +QEMU_BUILD_BUG_ON(FLEXCAN_ADDR_SPC_END > sizeof(FlexcanRegs));
>> +
>> +/* These constants are returned by flexcan_fifo_rx() and flexcan_mb_rx=
(), */
>> +/* Retry the other receiving mechanism (ie=2E message bufer or mailbox=
)=2E */
>> +#define FLEXCAN_RX_SEARCH_RETRY 0
>> +/* The frame was received and stored=2E */
>> +#define FLEXCAN_RX_SEARCH_ACCEPT 1
>> +/* The frame was filtered out and dropped=2E */
>> +#define FLEXCAN_RX_SEARCH_DROPPED 2
>> +
>> +/*
>> + * These constants are returned by flexcan_mb_rx_check_mb()=2E
>> + * See flexcan_mb_rx_check_mb() kerneldoc for details=2E
>> + */
>> +#define FLEXCAN_CHECK_MB_NIL 0
>> +#define FLEXCAN_CHECK_MB_MATCH 3
>> +#define FLEXCAN_CHECK_MB_MATCH_NON_FREE 1
>> +#define FLEXCAN_CHECK_MB_MATCH_LOCKED 5
>> +
>> +static const FlexcanRegs flexcan_regs_write_mask =3D {
>> +    =2Emcr =3D 0xF6EB337F,
>> +    =2Ectrl =3D 0xFFFFFFFF,
>> +    =2Etimer =3D 0xFFFFFFFF,
>> +    =2Etcr =3D 0xFFFFFFFF,
>> +    =2Erxmgmask =3D 0xFFFFFFFF,
>> +    =2Erx14mask =3D 0xFFFFFFFF,
>> +    =2Erx15mask =3D 0xFFFFFFFF,
>> +    =2Eecr =3D 0xFFFFFFFF,
>> +    =2Eesr =3D 0xFFFFFFFF,
>> +    =2Eimask2 =3D 0xFFFFFFFF,
>> +    =2Eimask1 =3D 0xFFFFFFFF,
>> +    =2Eiflag2 =3D 0,
>> +    =2Eiflag1 =3D 0,
>> +    =2Ectrl2 =3D 0xFFFFFFFF,
>> +    =2Eesr2 =3D 0,
>> +    =2Eimeur =3D 0,
>> +    =2Elrfr =3D 0,
>> +    =2Ecrcr =3D 0,
>> +    =2Erxfgmask =3D 0xFFFFFFFF,
>> +    =2Erxfir =3D 0,
>> +    =2Ecbt =3D 0,
>> +    =2E_reserved2 =3D 0,
>> +    =2Edbg1 =3D 0,
>> +    =2Edbg2 =3D 0,
>> +    =2Embs =3D { [0 =2E=2E=2E 63] =3D {
>> +        =2Ecan_ctrl =3D 0xFFFFFFFF & ~FLEXCAN_MB_CNT_NOT_SRV,
>> +        =2Ecan_id =3D 0xFFFFFFFF,
>> +        =2Edata =3D { 0xFFFFFFFF, 0xFFFFFFFF },
>> +    } },
>> +    =2E_reserved4 =3D {0},
>> +    =2Erximr =3D { [0 =2E=2E=2E 63] =3D 0xFFFFFFFF },
>> +    =2E_reserved5 =3D {0},
>> +    =2Egfwr_mx6 =3D 0xFFFFFFFF,
>> +    =2E_reserved6 =3D {0},
>> +    =2E_reserved8 =3D {0},
>> +    =2Erx_smb0_raw =3D {0, 0, 0, 0},
>> +    =2Erx_smb1 =3D {0, 0, 0, 0},
>> +};
>> +static const FlexcanRegs flexcan_regs_reset_mask =3D {
>> +    =2Emcr =3D 0x80000000,
>> +    =2Ectrl =3D 0xFFFFFFFF,
>> +    =2Etimer =3D 0,
>> +    =2Etcr =3D 0,
>> +    =2Erxmgmask =3D 0xFFFFFFFF,
>> +    =2Erx14mask =3D 0xFFFFFFFF,
>> +    =2Erx15mask =3D 0xFFFFFFFF,
>> +    =2Eecr =3D 0,
>> +    =2Eesr =3D 0,
>> +    =2Eimask2 =3D 0,
>> +    =2Eimask1 =3D 0,
>> +    =2Eiflag2 =3D 0,
>> +    =2Eiflag1 =3D 0,
>> +    =2Ectrl2 =3D 0xFFFFFFFF,
>> +    =2Eesr2 =3D 0,
>> +    =2Eimeur =3D 0,
>> +    =2Elrfr =3D 0,
>> +    =2Ecrcr =3D 0,
>> +    =2Erxfgmask =3D 0xFFFFFFFF,
>> +    =2Erxfir =3D 0xFFFFFFFF,
>> +    =2Ecbt =3D 0,
>> +    =2E_reserved2 =3D 0,
>> +    =2Edbg1 =3D 0,
>> +    =2Edbg2 =3D 0,
>> +    =2Emb =3D {0xFFFFFFFF},
>> +    =2E_reserved4 =3D {0},
>> +    =2Erximr =3D {0xFFFFFFFF},
>> +    =2E_reserved5 =3D {0},
>> +    =2Egfwr_mx6 =3D 0,
>> +    =2E_reserved6 =3D {0},
>> +    =2E_reserved8 =3D {0},
>> +    =2Erx_smb0_raw =3D {0, 0, 0, 0},
>> +    =2Erx_smb1 =3D {0, 0, 0, 0},
>> +};
>> +
>> +#if DEBUG_FLEXCAN
>> +
>> +#define DPRINTF(fmt, args=2E=2E=2E) \
>> +    fprintf(stderr, "(%p)[%s]%s: " fmt , (void *)s, TYPE_CAN_FLEXCAN, =
\
>> +            __func__, ##args);
>> +
>> +#else /* DEBUG_FLEXCAN */
>> +
>> +#define DPRINTF(fmt, args=2E=2E=2E) do { } while (0)
>> +
>> +#endif /* DEBUG_FLEXCAN */
>
>Please no new DPRINTF=2E Use tracing and logging instead=2E
>
>> +
>> +#define FLEXCAN_DBG_BUF_LEN 16
>> +
>> +static const char *flexcan_dbg_mb_code_strs[16] =3D {
>> +    "INACTIVE_RX",
>> +    "FULL",
>> +    "EMPTY",
>> +    "OVERRUN",
>> +    "INACTIVE_TX",
>> +    "RANSWER",
>> +    "DATA",
>> +    "TANSWER"
>> +};
>> +
>> +/**
>> + * flexcan_dbg_mb_code() - Get the string representation of a mailbox =
code
>> + * @mb_ctrl: The mailbox control register value
>> + * @buf: The buffer to store the string representation
>> + *
>> + * Return: Either constant string or string formatted into @buf
>> + */
>> +static const char *flexcan_dbg_mb_code(uint32_t mb_ctrl, char *buf)
>> +{
>> +    uint32_t code =3D mb_ctrl & FLEXCAN_MB_CODE_MASK;
>> +    uint32_t code_idx =3D code >> 24;
>> +    if (code =3D=3D FLEXCAN_MB_CODE_TX_ABORT) {
>> +        return "ABORT";
>> +    }
>> +
>> +    const char *code_str =3D flexcan_dbg_mb_code_strs[code_idx >> 1];
>> +    if (code_idx & 1) {
>> +        g_snprintf(buf, FLEXCAN_DBG_BUF_LEN, "%s+BUSY", code_str);
>> +        return buf;
>> +    } else {
>> +        return code_str;
>> +    }
>> +}
>> +
>> +static const char *flexcan_dbg_reg_name_fixed(hwaddr addr)
>> +{
>> +    if (addr >=3D FLEXCAN_ADDR_SPC_END) {
>> +        return "OUT-OF-RANGE";
>> +    }
>> +
>> +    switch (addr) {
>> +    case offsetof(FlexcanRegs, mcr):
>> +        return "MCR";
>> +    case offsetof(FlexcanRegs, ctrl):
>> +        return "CTRL";
>> +    case offsetof(FlexcanRegs, timer):
>> +        return "TIMER";
>> +    case offsetof(FlexcanRegs, esr):
>> +        return "ESR";
>> +    case offsetof(FlexcanRegs, rxmgmask):
>> +        return "RXMGMASK";
>> +    case offsetof(FlexcanRegs, rx14mask):
>> +        return "RX14MASK";
>> +    case offsetof(FlexcanRegs, rx15mask):
>> +        return "RX15MASK";
>> +    case offsetof(FlexcanRegs, rxfgmask):
>> +        return "RXFGMASK";
>> +    case offsetof(FlexcanRegs, ecr):
>> +        return "ECR";
>> +    case offsetof(FlexcanRegs, ctrl2):
>> +        return "CTRL2";
>> +    case offsetof(FlexcanRegs, imask2):
>> +        return "IMASK2";
>> +    case offsetof(FlexcanRegs, imask1):
>> +        return "IMASK1";
>> +    case offsetof(FlexcanRegs, iflag2):
>> +        return "IFLAG2";
>> +    case offsetof(FlexcanRegs, iflag1):
>> +        return "IFLAG1";
>> +    }
>> +    return NULL;
>> +}
>> +
>> +static inline void flexcan_trace_mem_op(FlexcanState *s, hwaddr addr,
>> +                                        uint32_t value, int size, bool=
 is_wr)
>> +{
>> +    if (trace_event_get_state_backends(TRACE_FLEXCAN_MEM_OP)) {
>> +        const char *reg_name =3D "unknown";
>> +        char reg_name_buf[FLEXCAN_DBG_BUF_LEN] =3D { 0 };
>> +        const char *reg_name_fixed =3D flexcan_dbg_reg_name_fixed(addr=
);
>> +        const char *op_string =3D is_wr ? "write" : "read";
>> +
>> +        if (reg_name_fixed) {
>> +            reg_name =3D reg_name_fixed;
>> +        } else if (addr >=3D 0x80 && addr < 0x480) {
>> +            int mbidx =3D (addr - 0x80) / 16;
>> +            g_snprintf(reg_name_buf, sizeof(reg_name_buf), "MB%i", mbi=
dx);
>> +            reg_name =3D reg_name_buf;
>> +        } else if (addr >=3D 0x880 && addr < 0x9e0) {
>> +            int id =3D (addr - 0x880) / 4;
>> +            g_snprintf(reg_name_buf, sizeof(reg_name_buf), "RXIMR%i", =
id);
>> +            reg_name =3D reg_name_buf;
>> +        }
>> +
>> +        trace_flexcan_mem_op(s, op_string, value, addr, reg_name, size=
);
>
>Better use "DEVICE(s)->canonical_path" instead of the "s" parameter which=
 results in much more readable trace messages=2E This applies to all trace =
functions=2E
>
>> +    }
>> +}
>> +
>> +static const struct MemoryRegionOps flexcan_ops =3D {
>> +    =2Eread =3D flexcan_mem_read,
>> +    =2Ewrite =3D flexcan_mem_write,
>> +    =2Eendianness =3D DEVICE_NATIVE_ENDIAN,
>
>Please use DEVICE_LITTLE_ENDIAN for now since DEVICE_NATIVE_ENDIAN is dep=
recated, and checkpatch=2Epl actually flags it=2E While there may be big en=
dian variants of this IP core, we don't need to worry about these at the mo=
ment since this device model already depends on the IMX clock module=2E
>
>> +    =2Evalid =3D {
>> +        =2Emin_access_size =3D 1,
>> +        =2Emax_access_size =3D 4,
>> +        =2Eunaligned =3D true,
>> +        =2Eaccepts =3D flexcan_mem_accepts
>> +    },
>> +    =2Eimpl =3D {
>> +        =2Emin_access_size =3D 4,
>> +        =2Emax_access_size =3D 4,
>> +        =2Eunaligned =3D false
>> +    },
>> +};
>> +
>> +static int flexcan_mb_rx(FlexcanState *s, const qemu_can_frame *frame)=
;
>> +static void flexcan_mb_unlock(FlexcanState *s);
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Mailbox Utils =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
>> +
>> +/**
>> + * flexcan_mailbox_count() - Get number of enabled mailboxes
>> + * @s: FlexCAN device pointer
>> + *
>> + * Count is based on MCR[MAXMB] field=2E Note that some of those mailb=
oxes
>> + * might be part of queue or queue ID filters or ordinary message buff=
ers=2E
>> + */
>> +static inline int flexcan_enabled_mailbox_count(const FlexcanState *s)
>> +{
>> +    return (s->regs=2Emcr & FLEXCAN_MCR_MAXMB(UINT32_MAX)) + 1;
>> +}
>> +
>> +/**
>> + * flexcan_get_first_message_buffer() - Get pointer to first message b=
uffer
>> + * @s: FlexCAN device pointer
>> + *
>> + * In context of this function, message buffer means a mailbox which i=
s not
>> + * a queue element nor a queue filter=2E Note this function does not t=
ake
>> + * MCR[MAXMB] into account, meaning that the returned mailbox
>> + * might be disabled=2E
>> + */
>> +static FlexcanRegsMessageBuffer *flexcan_get_first_message_buffer(
>> +                                 FlexcanState *s)
>> +{
>> +    if (s->regs=2Emcr & FLEXCAN_MCR_FEN) {
>> +        int rffn =3D (s->regs=2Ectrl2 & FLEXCAN_CTRL2_RFFN(UINT32_MAX)=
) >> 24;
>> +        return s->regs=2Embs + 8 + 2 * rffn;
>> +    } else {
>> +        return s->regs=2Embs;
>> +    }
>> +}
>> +
>> +/**
>> + * flexcan_get_last_enabled_mailbox() - Get pointer to last enabled ma=
ilbox=2E
>> + * @s: FlexCAN device pointer
>> + *
>> + * When used with flexcan_get_first_message_buffer(), all mailboxes *p=
tr in
>> + * range `first_message_buffer() <=3D ptr <=3D last_enabled_mailbox` a=
re valid
>> + * message buffer mailboxes=2E
>> + *
>> + * Return: Last enabled mailbox in MCR[MAXMB] sense=2E The mailbox mig=
ht be
>> + * of any type=2E
>> + */
>> +static inline FlexcanRegsMessageBuffer *flexcan_get_last_enabled_mailb=
ox(
>> +                                 FlexcanState *s)
>> +{
>> +    return s->regs=2Embs + flexcan_enabled_mailbox_count(s);
>> +}
>> +
>> +/**
>> + * flexcan_get_first_filter_mailbox() - Get pointer to first queue fil=
ter=2E
>> + * @s: FlexCAN device pointer
>> + *
>> + * This function does not check if FIFO is enabled=2E
>> + *
>> + * Return: Pointer to first queue filter element=2E
>> + */
>> +static inline uint32_t *flexcan_get_first_filter_mailbox(FlexcanState =
*s)
>> +{
>> +    return (uint32_t *)(s->regs=2Embs + 6);
>> +}
>> +
>> +/**
>> + * flexcan_get_last_filter_mailbox() - Get pointer to last queue filte=
r=2E
>> + * @s: FlexCAN device pointer
>> + *
>> + * This function does not check if FIFO is enabled=2E
>> + * All words in range [flexcan_get_first_filter_mailbox(),
>> + * flexcan_get_last_filter_mailbox()] are queue filter elements, if qu=
eue
>> + * is enabled=2E
>> + *
>> + * Return: Pointer to last queue filter element=2E
>> + */
>> +static inline uint32_t *flexcan_get_last_filter_mailbox(FlexcanState *=
s)
>> +{
>> +    /* adding three to get pointer to the last word of the mailbox */
>> +    uint32_t *last_enabled_elem =3D
>> +        ((uint32_t *)flexcan_get_last_enabled_mailbox(s)) + 3;
>> +
>> +    int rffn =3D (s->regs=2Ectrl2 & FLEXCAN_CTRL2_RFFN(UINT32_MAX)) >>=
 24;
>> +    uint32_t *last_elem =3D (uint32_t *)(s->regs=2Embs + 8 + 2 * rffn)=
 - 1;
>> +
>> +    return MIN(last_elem, last_enabled_elem);
>> +}
>
>The above two functions seem to be unused=2E Please remove=2E
>
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Free-running Timer =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
>> +static inline int64_t flexcan_get_time(void)
>> +{
>> +    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +}
>> +
>> +/**
>> + * flexcan_get_bitrate() - Calculate CAN bitrate (in Hz)
>> + * @s: FlexCAN device pointer
>> + *
>> + * The bitrate is determined by FlexCAN configuration in CTRL1 registe=
r,
>> + * and CCM co
>> + */
>> +static uint32_t flexcan_get_bitrate(FlexcanState *s)
>> +{
>> +    uint32_t conf_presdiv =3D (s->regs=2Ectrl & FLEXCAN_CTRL_PRESDIV_M=
ASK) >> 24;
>> +    uint32_t conf_pseg1 =3D (s->regs=2Ectrl & FLEXCAN_CTRL_PSEG1_MASK)=
 >> 19;
>> +    uint32_t conf_pseg2 =3D (s->regs=2Ectrl & FLEXCAN_CTRL_PSEG2_MASK)=
 >> 16;
>> +    uint32_t conf_propseg =3D s->regs=2Ectrl & FLEXCAN_CTRL_PROPSEG_MA=
SK;
>> +
>> +    /* s_clock: CAN clock from CCM divivded by the prescaler */
>> +    assert(s->ccm);
>> +    uint32_t pe_freq =3D imx_ccm_get_clock_frequency(s->ccm, CLK_CAN);
>> +    uint32_t s_freq =3D pe_freq / (1 + conf_presdiv);
>> +
>> +    /* N of time quanta for segements */
>> +    uint32_t tseg1 =3D 2 + conf_pseg1 + conf_propseg;
>> +    uint32_t tseg2 =3D 1 + conf_pseg2;
>> +    uint32_t total_qpb =3D 1 + tseg1 + tseg2;
>> +
>> +    uint32_t bitrate =3D s_freq / total_qpb;
>> +
>> +    trace_flexcan_get_bitrate(s, pe_freq, 1 + conf_presdiv, s_freq, ts=
eg1,
>> +                              tseg2, total_qpb, bitrate);
>> +    return bitrate;
>> +}
>> +
>> +/**
>> + * int128_mul_6464() - Multiply two 64-bit integers into a 128-bit one
>> + */
>> +static Int128 int128_muls_6464(int64_t ai, int64_t bi)
>> +{
>> +    uint64_t l, h;
>> +
>> +    muls64(&l, &h, ai, bi);
>> +    return int128_make128(l, h);
>> +}
>> +
>> +/**
>> + * flexcan_get_timestamp() - Get current value of the 16-bit free-runn=
ing timer
>> + * @s: FlexCAN device pointer
>> + * @mk_unique: if true, make the timestamp unique by incrementing it i=
f needed
>> + */
>> +static uint32_t flexcan_get_timestamp(FlexcanState *s, bool mk_unique)
>> +{
>> +    if (s->timer_start =3D=3D FLEXCAN_TIMER_STOPPED) {
>> +        /* timer is not running, return last value */
>> +        trace_flexcan_get_timestamp(s, -1, 0, 0, 0, s->regs=2Etimer);
>> +        return s->regs=2Etimer;
>> +    }
>> +
>> +    int64_t current_time =3D flexcan_get_time();
>> +    int64_t elapsed_time_ns =3D current_time - s->timer_start;
>> +    int64_t elapsed_time_ms =3D elapsed_time_ns / 1000000;
>> +    if (elapsed_time_ns < 0) {
>> +        DPRINTF("timer overflow current_time=3D%li "
>> +                "timer_start=3D%li elapsed_time_ns=3D%li\n",
>> +                current_time, s->timer_start, elapsed_time_ns);
>> +        return 0xFFFF;
>> +    }
>> +
>> +    Int128 nanoseconds_in_second =3D int128_makes64(1000000000);
>> +    Int128 ncycles =3D int128_muls_6464(s->timer_freq, elapsed_time_ns=
);
>> +    Int128 cycles128 =3D int128_divs(ncycles, nanoseconds_in_second);
>> +    /* 64 bits hold for over 50k years at 10MHz */
>> +    uint64_t cycles =3D int128_getlo(cycles128);
>> +
>> +    uint32_t shift =3D 0;
>> +    if (mk_unique && cycles <=3D s->last_rx_timer_cycles) {
>> +        shift =3D 1;
>> +        cycles =3D s->last_rx_timer_cycles + shift;
>> +    }
>> +
>> +    s->last_rx_timer_cycles =3D cycles;
>> +    uint32_t rv =3D (uint32_t)cycles & 0xFFFF;
>> +
>> +    trace_flexcan_get_timestamp(s, elapsed_time_ms, s->timer_freq,
>> +                                cycles, shift, rv);
>> +    return rv;
>> +}
>> +
>> +/**
>> + * flexcan_timer_start() - Start the free-running timer
>> + * @s: FlexCAN device pointer
>> + *
>> + * This should be called when the module leaves freeze mode=2E
>> + */
>> +static void flexcan_timer_start(FlexcanState *s)
>> +{
>> +    if (s->timer_start !=3D FLEXCAN_TIMER_STOPPED) {
>> +        DPRINTF("module brought up, but timer is already running: "
>> +                "value=3D%" PRIu64 "\n", s->timer_start);
>> +    }
>> +    s->timer_freq =3D flexcan_get_bitrate(s);
>> +    s->timer_start =3D flexcan_get_time();
>> +    s->last_rx_timer_cycles =3D 0;
>> +
>> +    trace_flexcan_timer_start(s, s->timer_freq, s->regs=2Etimer);
>> +}
>> +
>> +/**
>> + * flexcan_timer_stop() - Stop the free-running timer
>> + * @s: FlexCAN device pointer
>> + *
>> + * This should be called when the module enters freeze mode=2E
>> + * Stores the current timestamp in the TIMER register=2E
>> + */
>> +static void flexcan_timer_stop(FlexcanState *s)
>> +{
>> +    s->regs=2Etimer =3D flexcan_get_timestamp(s, false);
>> +    s->timer_start =3D FLEXCAN_TIMER_STOPPED;
>> +
>> +    trace_flexcan_timer_stop(s, s->timer_freq, s->regs=2Etimer);
>> +}
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D IRQ handling =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
>> +/**
>> + * flexcan_irq_update() - Update qemu_irq line based on interrupt regi=
sters
>> + * @s: FlexCAN device pointer
>> + */
>> +static void flexcan_irq_update(FlexcanState *s)
>> +{
>> +    /* these are all interrupt sources from FlexCAN */
>> +    /* mailbox interrupt sources */
>> +    uint32_t mb_irqs1 =3D s->regs=2Eiflag1 & s->regs=2Eimask1;
>> +    uint32_t mb_irqs2 =3D s->regs=2Eiflag2 & s->regs=2Eimask2;
>> +
>> +    /**
>> +     * these interrupts aren't currently used and they can never be ra=
ised
>> +     *
>> +     * bool irq_wake_up =3D (s->regs=2Emcr & FLEXCAN_MCR_WAK_MSK) &&
>> +     *                    (s->regs=2Eecr & FLEXCAN_ESR_WAK_INT);
>> +     * bool irq_bus_off =3D (s->regs=2Ectrl & FLEXCAN_CTRL_BOFF_MSK) &=
&
>> +     *                    (s->regs=2Eecr & FLEXCAN_ESR_BOFF_INT);
>> +     * bool irq_error =3D (s->regs=2Ectrl & FLEXCAN_CTRL_ERR_MSK) &&
>> +     *                  (s->regs=2Eecr & FLEXCAN_ESR_ERR_INT);
>> +     * bool irq_tx_warn =3D (s->regs=2Ectrl & FLEXCAN_CTRL_TWRN_MSK) &=
&
>> +     *                    (s->regs=2Eecr & FLEXCAN_ESR_TWRN_INT);
>> +     * bool irq_rx_warn =3D (s->regs=2Ectrl & FLEXCAN_CTRL_RWRN_MSK) &=
&
>> +     *                    (s->regs=2Eecr & FLEXCAN_ESR_RWRN_INT);
>> +     */
>> +
>> +    int irq_setting =3D (mb_irqs1 | mb_irqs2) ? 1 : 0;
>> +    trace_flexcan_irq_update(s, mb_irqs1, mb_irqs2, irq_setting);
>> +
>> +    qemu_set_irq(s->irq, irq_setting);
>> +}
>> +
>> +/**
>> + * flexcan_irq_iflag_set() - Set IFLAG bit corresponding to MB mbidx
>> + * @s: FlexCAN device pointer
>> + * @mbidx: mailbox index
>> + */
>> +static void flexcan_irq_iflag_set(FlexcanState *s, int mbidx)
>> +{
>> +    if (mbidx < 32) {
>> +        s->regs=2Eiflag1 |=3D BIT(mbidx);
>> +    } else {
>> +        s->regs=2Eiflag2 |=3D BIT(mbidx - 32);
>> +    }
>> +}
>> +
>> +/**
>> + * flexcan_irq_iflag_clear() - Clear IFLAG bit corresponding to MB mbi=
dx
>> + * @s: FlexCAN device pointer
>> + * @mbidx: mailbox index
>> + */
>> +static void flexcan_irq_iflag_clear(FlexcanState *s, int mbidx)
>> +{
>> +    if (mbidx < 32) {
>> +        s->regs=2Eiflag1 &=3D ~BIT(mbidx);
>> +    } else {
>> +        s->regs=2Eiflag2 &=3D ~BIT(mbidx - 32);
>> +    }
>> +}
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D RESET =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 */
>> +static void flexcan_reset_local_state(FlexcanState *s)
>> +{
>> +    uint32_t *reset_mask =3D (uint32_t *)&flexcan_regs_reset_mask;
>> +    for (int i =3D 0; i < (sizeof(FlexcanRegs) / 4); i++) {
>> +        s->regs_raw[i] &=3D reset_mask[i];
>> +    }
>> +
>> +    s->regs=2Emcr |=3D 0x5980000F;
>> +    s->locked_mbidx =3D FLEXCAN_NO_MB_LOCKED;
>> +    s->smb_target_mbidx =3D FLEXCAN_SMB_EMPTY;
>> +    s->timer_start =3D FLEXCAN_TIMER_STOPPED;
>> +
>> +    trace_flexcan_reset(s);
>> +}
>> +
>> +static void flexcan_soft_reset(FlexcanState *s)
>> +{
>> +    if (s->regs=2Emcr & FLEXCAN_MCR_LPM_ACK) {
>> +        g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: invalid soft reset request in low-power mod=
e",
>> +                      path);
>
>Here you can also use "DEVICE(s)->canonical_path", eliminating the dynami=
c allocation and cleanup logic entirely=2E Same for other cases=2E
>
>> +    }
>> +
>> +    flexcan_reset_local_state(s);
>> +}
>> +
>> +static void flexcan_reset_enter(Object *obj, ResetType type)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +
>> +    memset(&s->regs, 0, sizeof(s->regs));
>> +    flexcan_reset_local_state(s);
>> +}
>> +
>> +static void flexcan_reset_hold(Object *obj, ResetType type)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +
>> +    flexcan_irq_update(s);
>> +}
>> +
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Operation mode control =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D */
>> +/**
>> + * flexcan_update_esr() - Update ESR based on mode and CAN bus connect=
ion state
>> + * @s: FlexCAN device pointer
>> + */
>> +static void flexcan_update_esr(FlexcanState *s)
>> +{
>> +    bool is_running =3D (s->regs=2Emcr & FLEXCAN_MCR_NOT_RDY) =3D=3D 0=
;
>> +    /* potentially, there could be other influences on ESR[SYNCH] */
>> +
>> +    if (is_running && s->canbus) {
>> +        s->regs=2Eesr |=3D FLEXCAN_ESR_SYNCH | FLEXCAN_ESR_IDLE;
>> +    } else {
>> +        s->regs=2Eesr &=3D ~(FLEXCAN_ESR_SYNCH | FLEXCAN_ESR_IDLE);
>> +    }
>> +}
>> +
>> +/**
>> + * flexcan_update_esr() - Process MCR write
>> + * @s: FlexCAN device pointer
>> + * @pv: previously set MCR value
>> + *
>> + * This function expects the new MCR value to be already written in s-=
>regs=2Emcr=2E
>> + */
>> +static void flexcan_set_mcr(FlexcanState *s, const uint32_t pv)
>> +{
>> +    uint32_t cv =3D s->regs=2Emcr;
>> +
>> +    /* -- module disable mode -- */
>> +    if (!(pv & FLEXCAN_MCR_MDIS) && (cv & FLEXCAN_MCR_MDIS)) {
>> +        /* transition to Module Disable mode */
>> +        cv |=3D FLEXCAN_MCR_LPM_ACK;
>> +    } else if ((pv & FLEXCAN_MCR_MDIS) && !(cv & FLEXCAN_MCR_MDIS)) {
>> +        /* transition from Module Disable mode */
>> +        cv &=3D ~FLEXCAN_MCR_LPM_ACK;
>> +    }
>> +
>> +    /* -- soft reset -- */
>> +    if (!(cv & FLEXCAN_MCR_LPM_ACK) && (cv & FLEXCAN_MCR_SOFTRST)) {
>> +        flexcan_soft_reset(s);
>> +        cv =3D s->regs=2Emcr;
>> +    }
>> +
>> +    /* -- freeze mode -- */
>> +    if (!(cv & FLEXCAN_MCR_LPM_ACK) &&
>> +        (cv & FLEXCAN_MCR_FRZ) &&
>> +        (cv & FLEXCAN_MCR_HALT)) {
>> +        cv |=3D FLEXCAN_MCR_FRZ_ACK;
>> +    } else {
>> +        cv &=3D ~FLEXCAN_MCR_FRZ_ACK;
>> +    }
>> +
>> +    /* -- fifo mode -- */
>> +    if (
>> +        ((pv & FLEXCAN_MCR_FEN) && !(cv & FLEXCAN_MCR_FEN)) ||
>> +        (!(pv & FLEXCAN_MCR_FEN) && (cv & FLEXCAN_MCR_FEN))
>> +    ) {
>> +        /* clear iflags used by fifo */
>> +        s->regs=2Eiflag1 &=3D ~(
>> +            FLEXCAN_IFLAG_RX_FIFO_AVAILABLE |
>> +            FLEXCAN_IFLAG_RX_FIFO_OVERFLOW |
>> +            FLEXCAN_IFLAG_RX_FIFO_WARN
>> +        );
>> +    }
>> +    if (!(pv & FLEXCAN_MCR_FEN) && (cv & FLEXCAN_MCR_FEN)) {
>> +        /* zero out fifo region, we rely on zeroed can_ctrl for empty =
slots */
>> +        memset(s->regs=2Embs, 0,
>> +               FLEXCAN_FIFO_DEPTH * sizeof(FlexcanRegsMessageBuffer));
>> +    }
>> +
>> +    /*
>> +     * assert NOT_RDY bit if in disable,
>> +     * stop (not implemented) or freeze mode
>> +     */
>> +    if ((cv & FLEXCAN_MCR_LPM_ACK) || (cv & FLEXCAN_MCR_FRZ_ACK)) {
>> +        cv |=3D FLEXCAN_MCR_NOT_RDY;
>> +    } else {
>> +        cv &=3D ~FLEXCAN_MCR_NOT_RDY;
>> +    }
>> +
>> +    if ((pv & FLEXCAN_MCR_NOT_RDY) && !(cv & FLEXCAN_MCR_NOT_RDY)) {
>> +        /* module went up, start the timer */
>> +        flexcan_timer_start(s);
>> +    } else if (!(pv & FLEXCAN_MCR_NOT_RDY) && (cv & FLEXCAN_MCR_NOT_RD=
Y)) {
>> +        /* module went down, store the current timer value */
>> +        flexcan_timer_stop(s);
>> +    }
>> +
>> +    s->regs=2Emcr =3D cv;
>> +    flexcan_update_esr(s);
>> +    trace_flexcan_set_mcr(
>> +        s,
>> +        cv & FLEXCAN_MCR_LPM_ACK ? "DISABLED" : "ENABLED",
>> +        (cv & FLEXCAN_MCR_FRZ_ACK || cv & FLEXCAN_MCR_LPM_ACK) ?
>> +            "FROZEN" : "RUNNING",
>> +        cv & FLEXCAN_MCR_FEN ? "FIFO" : "MAILBOX",
>> +        cv & FLEXCAN_MCR_NOT_RDY ? "NOT_RDY" : "RDY",
>> +        s->regs=2Eesr & FLEXCAN_ESR_SYNCH ? "SYNC" : "NOSYNC"
>> +    );
>> +}
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D TX =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>> +static void flexcan_transmit(FlexcanState *s, int mbidx)
>> +{
>> +    FlexcanRegsMessageBuffer *mb =3D &s->regs=2Embs[mbidx];
>> +    qemu_can_frame frame =3D {
>> +        =2Eflags =3D 0,
>> +    };
>> +
>> +    if ((s->regs=2Ectrl & FLEXCAN_CTRL_LOM) ||
>> +        (s->regs=2Emcr & FLEXCAN_MCR_NOT_RDY)) {
>> +        /* no transmiting in listen-only, freeze or low-power mode */
>> +        return;
>> +    }
>> +
>> +    if (mb->can_ctrl & FLEXCAN_MB_CNT_IDE) {
>> +        /* 29b ID stored in bits [0, 29) */
>> +        uint32_t id =3D mb->can_id & 0x1FFFFFFF;
>> +        frame=2Ecan_id =3D id | QEMU_CAN_EFF_FLAG;
>> +    } else {
>> +        /* 11b ID stored in bits [18, 29) */
>> +        uint32_t id =3D (mb->can_id & (0x7FF << 18)) >> 18;
>> +        frame=2Ecan_id =3D id;
>> +    }
>> +
>> +    frame=2Ecan_dlc =3D (mb->can_ctrl & (0xF << 16)) >> 16;
>> +
>> +    uint32_t *frame_data =3D (uint32_t *)&frame=2Edata;
>> +    for (int i =3D 0; i < 2; i++) {
>> +        stl_be_p(&frame_data[i], mb->data[i]);
>> +    }
>> +
>> +    if (!(s->regs=2Emcr & FLEXCAN_MCR_SRX_DIS)) {
>> +        /* self-reception */
>> +        flexcan_mb_rx(s, &frame);
>> +    }
>> +    if (!(s->regs=2Ectrl & FLEXCAN_CTRL_LPB)) {
>> +        /* send to bus if not in loopback mode */
>> +        if (s->canbus) {
>> +            can_bus_client_send(&s->bus_client, &frame, 1);
>> +        } else {
>> +            /* todo: raise error (no ack) */
>> +        }
>> +    }
>> +
>> +    uint32_t timestamp =3D flexcan_get_timestamp(s, true);
>> +    mb->can_ctrl &=3D ~(FLEXCAN_MB_CODE_MASK | FLEXCAN_MB_CNT_TIMESTAM=
P_MASK);
>> +    mb->can_ctrl |=3D FLEXCAN_MB_CODE_TX_INACTIVE |
>> +                    FLEXCAN_MB_CNT_TIMESTAMP(timestamp);
>> +
>> +    /* todo: compute the CRC */
>> +    s->regs=2Ecrcr =3D FLEXCAN_CRCR_TXCRC(0) | FLEXCAN_CRCR_MBCRC(mbid=
x);
>> +
>> +    flexcan_irq_iflag_set(s, mbidx);
>> +}
>> +
>> +static void flexcan_mb_write(FlexcanState *s, int mbid)
>> +{
>> +    FlexcanRegsMessageBuffer *mb =3D &s->regs=2Embs[mbid];
>> +
>> +    bool is_mailbox =3D (mb <=3D flexcan_get_last_enabled_mailbox(s)) =
&&
>> +                     (mb >=3D flexcan_get_first_message_buffer(s));
>> +
>> +    if (trace_event_get_state_backends(TRACE_FLEXCAN_MB_WRITE)) {
>> +        char code_str_buf[FLEXCAN_DBG_BUF_LEN] =3D { 0 };
>> +        const char *code_str =3D flexcan_dbg_mb_code(mb->can_ctrl, cod=
e_str_buf);
>> +        trace_flexcan_mb_write(s, mbid, code_str, is_mailbox, mb->can_=
ctrl,
>> +                               mb->can_id);
>> +    }
>> +
>> +    if (!is_mailbox) {
>> +        /**
>> +         * Disabled mailbox or mailbox in region of queue filters
>> +         * was updated=2E Either way there is nothing to do=2E
>> +         */
>> +        return;
>> +    }
>> +
>> +    /* any write to message buffer clears the not_serviced flag */
>> +    mb->can_ctrl &=3D ~FLEXCAN_MB_CNT_NOT_SRV;
>> +
>> +    /**
>> +     * todo: search for active tx mbs on transition from freeze/disabl=
e mode
>> +     */
>> +    switch (mb->can_ctrl & FLEXCAN_MB_CODE_MASK) {
>> +    case FLEXCAN_MB_CODE_TX_INACTIVE:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_INACTIVE:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_EMPTY:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_FULL:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_RANSWER:
>> +        break;
>> +
>> +    case FLEXCAN_MB_CODE_TX_DATA:
>> +        flexcan_transmit(s, mbid);
>> +        break;
>> +    case FLEXCAN_MB_CODE_TX_ABORT:
>> +        /*
>> +         * as transmission is instant, it can never be aborted
>> +         * we need to set CODE in C/S back to the previous code
>> +         */
>> +        mb->can_ctrl &=3D ~FLEXCAN_MB_CODE(1);
>> +        break;
>> +    case FLEXCAN_MB_CODE_TX_TANSWER:
>> +        break;
>> +    default:
>> +        /* prevent setting the busy bit */
>> +        mb->can_ctrl &=3D ~FLEXCAN_MB_CODE_RX_BUSY_BIT;
>> +        break;
>> +  }
>> +
>> +}
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D RX =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>> +static void flexcan_mb_move_in(FlexcanState *s, const qemu_can_frame *=
frame,
>> +                               FlexcanRegsMessageBuffer *target_mb)
>> +{
>> +    memset(target_mb, 0, sizeof(FlexcanRegsMessageBuffer));
>> +
>> +    uint32_t frame_len =3D frame->can_dlc;
>> +    if (frame_len > 8) {
>> +        frame_len =3D 8;
>> +    }
>> +    uint32_t *frame_data =3D (uint32_t *)&frame->data;
>> +    for (int i =3D 0; i < 2; i++) {
>> +        target_mb->data[i] =3D ldl_be_p(&frame_data[i]);
>> +    }
>> +
>> +    int timestamp =3D flexcan_get_timestamp(s, true);
>> +    uint32_t new_code =3D 0;
>> +
>> +    switch (target_mb->can_ctrl & FLEXCAN_MB_CODE_MASK) {
>> +    case FLEXCAN_MB_CODE_RX_FULL:
>> +    case FLEXCAN_MB_CODE_RX_OVERRUN:
>> +        if (target_mb->can_ctrl & FLEXCAN_MB_CNT_NOT_SRV) {
>> +            new_code =3D FLEXCAN_MB_CODE_RX_OVERRUN;
>> +        } else {
>> +            new_code =3D FLEXCAN_MB_CODE_RX_FULL;
>> +        }
>> +        break;
>> +    case FLEXCAN_MB_CODE_RX_RANSWER:
>> +        assert(s->regs=2Ectrl2 & FLEXCAN_CTRL2_RRS);
>> +        new_code =3D FLEXCAN_MB_CODE_TX_TANSWER;
>> +        break;
>> +    default:
>> +        new_code =3D FLEXCAN_MB_CODE_RX_FULL;
>> +    }
>> +
>> +    target_mb->can_ctrl =3D new_code
>> +        | FLEXCAN_MB_CNT_TIMESTAMP(timestamp)
>> +        | FLEXCAN_MB_CNT_LENGTH(frame_len)
>> +        | FLEXCAN_MB_CNT_NOT_SRV
>> +        | FLEXCAN_MB_CNT_SRR; /* always set for received frames */
>> +    if (frame->can_id & QEMU_CAN_RTR_FLAG) {
>> +        target_mb->can_ctrl |=3D FLEXCAN_MB_CNT_RTR;
>> +    }
>> +
>> +    if (frame->can_id & QEMU_CAN_EFF_FLAG) {
>> +        target_mb->can_ctrl |=3D FLEXCAN_MB_CNT_IDE;
>> +        target_mb->can_id |=3D frame->can_id & QEMU_CAN_EFF_MASK;
>> +    } else {
>> +        target_mb->can_id |=3D (frame->can_id & QEMU_CAN_SFF_MASK) << =
18;
>> +    }
>> +}
>> +static void flexcan_mb_lock(FlexcanState *s, int mbidx)
>> +{
>> +    FlexcanRegsMessageBuffer *mb =3D &s->regs=2Embs[mbidx];
>> +    if ((mb > flexcan_get_last_enabled_mailbox(s)) ||
>> +        (mb < flexcan_get_first_message_buffer(s))) {
>> +        return;
>> +    }
>> +    switch (mb->can_ctrl & FLEXCAN_MB_CODE_MASK) {
>> +    case FLEXCAN_MB_CODE_RX_FULL:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_OVERRUN:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_RANSWER:
>> +        /* continue */
>> +        trace_flexcan_mb_lock(s, mbidx, 1);
>> +        break;
>> +    default:
>> +        trace_flexcan_mb_lock(s, mbidx, 0);
>> +        return;
>> +    }
>> +
>> +    s->locked_mbidx =3D mbidx;
>> +}
>> +
>> +static void flexcan_mb_unlock(FlexcanState *s)
>> +{
>> +    if (s->locked_mbidx =3D=3D FLEXCAN_NO_MB_LOCKED) {
>> +        return;
>> +    }
>> +
>> +    int locked_mbidx =3D s->locked_mbidx;
>
>All variable declarations should be at the top of a block=2E I'm not sure=
 why but this is a common request, see e=2Eg=2E https://lore=2Ekernel=2Eorg=
/qemu-devel/20251230065711-mutt-send-email-mst@kernel=2Eorg/ =2E
>
>> +    assert(locked_mbidx >=3D 0 && locked_mbidx < FLEXCAN_MAILBOX_COUNT=
);
>> +    FlexcanRegsMessageBuffer *locked_mb =3D &s->regs=2Embs[locked_mbid=
x];
>> +    s->locked_mbidx =3D FLEXCAN_NO_MB_LOCKED;
>> +
>> +    if (locked_mb >=3D flexcan_get_first_message_buffer(s) &&
>> +        locked_mb <=3D flexcan_get_last_enabled_mailbox(s)
>> +    ) {
>> +        /* mark the message buffer as serviced */
>> +        locked_mb->can_ctrl &=3D ~FLEXCAN_MB_CNT_NOT_SRV;
>> +    }
>> +
>> +    /* try move in from SMB */
>> +    bool has_pending_frame =3D locked_mbidx =3D=3D s->smb_target_mbidx=
;
>> +    trace_flexcan_mb_unlock(s, locked_mbidx,
>> +                            has_pending_frame ? " PENDING FRAME IN SMB=
" : "");
>> +
>> +    /* todo: in low-power modes, this should be postponed until exit *=
/
>> +    if (has_pending_frame) {
>> +        FlexcanRegsMessageBuffer *target_mb =3D &s->regs=2Embs[locked_=
mbidx];
>> +        memcpy(target_mb, &s->regs=2Erx_smb0, sizeof(FlexcanRegsMessag=
eBuffer));
>> +
>> +        memset(&s->regs=2Erx_smb0, 0, sizeof(FlexcanRegsMessageBuffer)=
);
>> +        s->locked_mbidx =3D FLEXCAN_SMB_EMPTY;
>> +
>> +        flexcan_irq_iflag_set(s, locked_mbidx);
>> +    }
>> +}
>> +
>> +bool flexcan_can_receive(CanBusClientState *client)
>> +{
>> +    FlexcanState *s =3D container_of(client, FlexcanState, bus_client)=
;
>> +    return !(s->regs=2Emcr & FLEXCAN_MCR_NOT_RDY);
>> +}
>> +
>> +/* --------- RX FIFO ---------- */
>> +
>> +/**
>> + * flexcan_fifo_pop() - Pop message from FIFO and update IRQs
>> + * @s: FlexCAN device pointer
>> + *
>> + * Does not require the queue to be non-empty=2E
>> + */
>> +static void flexcan_fifo_pop(FlexcanState *s)
>> +{
>> +    if (s->regs=2Efifo=2Emb_back=2Ecan_ctrl !=3D 0) {
>> +        /* move queue elements forward */
>> +        memmove(&s->regs=2Efifo=2Emb_back, &s->regs=2Efifo=2Embs_queue=
[0],
>> +                sizeof(s->regs=2Efifo=2Embs_queue));
>> +
>> +        /* clear the first-in slot */
>> +        memset(&s->regs=2Embs[FLEXCAN_FIFO_DEPTH - 1], 0,
>> +               sizeof(FlexcanRegsMessageBuffer));
>> +
>> +        trace_flexcan_fifo_pop(s, 1, s->regs=2Efifo=2Emb_back=2Ecan_ct=
rl !=3D 0);
>> +    } else {
>> +        trace_flexcan_fifo_pop(s, 0, 0);
>> +    }
>> +
>> +    if (s->regs=2Efifo=2Emb_back=2Ecan_ctrl !=3D 0) {
>> +        flexcan_irq_iflag_set(s, I_FIFO_AVAILABLE);
>> +    } else {
>> +        flexcan_irq_iflag_clear(s, I_FIFO_AVAILABLE);
>> +    }
>> +}
>> +
>> +/**
>> + * flexcan_fifo_find_free_slot() - Find the first free slot in the FIF=
O
>> + * @s: FlexCAN device pointer
>> + *
>> + * Return: Pointer to the first free slot in the FIFO,
>> + *         or NULL if the queue is full=2E
>> + */
>> +static FlexcanRegsMessageBuffer *flexcan_fifo_find_free_slot(FlexcanSt=
ate *s)
>> +{
>> +    for (int i =3D 0; i < FLEXCAN_FIFO_DEPTH; i++) {
>> +        FlexcanRegsMessageBuffer *mb =3D &s->regs=2Embs[i];
>> +        if (mb->can_ctrl =3D=3D 0) {
>> +            return mb;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +/**
>> + * flexcan_fifo_push() - Update FIFO IRQs after frame move-in
>> + * @s: FlexCAN device pointer
>> + * @slot: Target FIFO slot
>> + *
>> + * The usage is as follows:
>> + * 1=2E Get free slot pointer using flexcan_fifo_find_free_slot()
>> + * 2=2E Move the frame in if not NULL
>> + * 3=2E Call flexcan_fifo_push() regardless of the NULL pointer
>> + */
>> +static void flexcan_fifo_push(FlexcanState *s, FlexcanRegsMessageBuffe=
r *slot)
>> +{
>> +    if (slot) {
>> +        int n_occupied =3D slot - s->regs=2Embs;
>> +        if (n_occupied =3D=3D 4) { /* 4 means the 5th slot was filled =
in */
>> +            /*
>> +             * fifo occupancy increased from 4 to 5,
>> +             * raising FIFO_WARN interrupt
>> +             */
>> +            flexcan_irq_iflag_set(s, I_FIFO_WARN);
>> +        }
>> +        flexcan_irq_iflag_set(s, I_FIFO_AVAILABLE);
>> +
>> +        trace_flexcan_fifo_push(s, n_occupied);
>> +    } else {
>> +        flexcan_irq_iflag_set(s, I_FIFO_OVERFLOW);
>> +
>> +        trace_flexcan_fifo_push(s, -1);
>> +    }
>> +}
>> +
>> +static int flexcan_fifo_rx(FlexcanState *s, const qemu_can_frame *buf)
>> +{
>> +    /* todo: filtering=2E return FLEXCAN_FIFO_RX_RETRY if filtered out=
 */
>> +    if ((s->regs=2Emcr & FLEXCAN_MCR_IDAM_MASK) =3D=3D FLEXCAN_MCR_IDA=
M_D) {
>> +        /* all frames rejected */
>> +        return FLEXCAN_RX_SEARCH_RETRY;
>> +    }
>> +
>> +    /* push message to queue if not full */
>> +    FlexcanRegsMessageBuffer *slot =3D flexcan_fifo_find_free_slot(s);
>> +    if (slot) {
>> +        flexcan_mb_move_in(s, buf, slot);
>> +    }
>> +    flexcan_fifo_push(s, slot);
>> +
>> +    return slot ? FLEXCAN_RX_SEARCH_ACCEPT : FLEXCAN_RX_SEARCH_DROPPED=
;
>> +}
>> +
>> +/* --------- RX message buffer ---------- */
>> +
>> +/**
>> + * flexcan_mb_rx_check_mb() - Check if a message buffer matches a rece=
ived frame
>> + * @s: FlexCAN device pointer
>> + * @buf: Frame to be received from CAN subsystem
>> + * @mbid: Target mailbox index=2E The mailbox must be a valid message =
buffer=2E
>> + *
>> + * Return: FLEXCAN_CHECK_MB_NIL if the message buffer does not match=
=2E
>> + *         FLEXCAN_CHECK_MB_MATCH if the message buffer matches the re=
ceived
>> + *                                frame and is free-to-receive,
>> + *         FLEXCAN_CHECK_MB_MATCH_LOCKED if the message buffer matches=
,
>> + *                                       but is locked,
>> + *         FLEXCAN_CHECK_MB_MATCH_NON_FREE if the message buffer match=
es,
>> + *                                         but is not free-to-receive
>> + *                                         for some other reason=2E
>> + */
>> +static int flexcan_mb_rx_check_mb(FlexcanState *s, const qemu_can_fram=
e *buf,
>> +                                  int mbid)
>> +{
>> +    FlexcanRegsMessageBuffer *mb =3D &s->regs=2Embs[mbid];
>> +    const bool is_rtr =3D !!(buf->can_id & QEMU_CAN_RTR_FLAG);
>> +    const bool is_serviced =3D !(mb->can_ctrl & FLEXCAN_MB_CNT_NOT_SRV=
);
>> +    const bool is_locked =3D s->locked_mbidx =3D=3D mbid;
>> +
>> +    bool is_free_to_receive =3D false;
>> +    bool is_matched =3D false;
>> +
>> +    switch (mb->can_ctrl & FLEXCAN_MB_CODE_MASK) {
>> +    case FLEXCAN_MB_CODE_RX_RANSWER:
>> +        if (is_rtr && !(s->regs=2Ectrl2 & FLEXCAN_CTRL2_RRS)) {
>> +            /* todo: do the actual matching/filtering and RTR answer *=
/
>> +            is_matched =3D true;
>> +        }
>> +        break;
>> +    case FLEXCAN_MB_CODE_RX_FULL:
>> +        QEMU_FALLTHROUGH;
>> +    case FLEXCAN_MB_CODE_RX_OVERRUN:
>> +        is_free_to_receive =3D is_serviced;
>> +        /* todo: do the actual matching/filtering */
>> +        is_matched =3D true;
>> +        break;
>> +    case FLEXCAN_MB_CODE_RX_EMPTY:
>> +        is_free_to_receive =3D true;
>> +        /* todo: do the actual matching/filtering */
>> +        is_matched =3D true;
>> +        break;
>> +    default:
>> +    break;
>> +    }
>> +
>> +    if (trace_event_get_state_backends(TRACE_FLEXCAN_MB_RX_CHECK_MB)) =
{
>> +        char code_str_buf[FLEXCAN_DBG_BUF_LEN] =3D { 0 };
>> +        const char *code_str =3D flexcan_dbg_mb_code(mb->can_ctrl, cod=
e_str_buf);
>> +        trace_flexcan_mb_rx_check_mb(s, mbid, code_str, is_matched,
>> +                                     is_free_to_receive, is_serviced,
>> +                                     is_locked);
>> +    }
>> +
>> +    if (is_matched && is_free_to_receive && !is_locked) {
>> +        return FLEXCAN_CHECK_MB_MATCH;
>> +    } else if (is_matched && !is_locked) {
>> +        return FLEXCAN_CHECK_MB_MATCH_NON_FREE;
>> +    } else if (is_matched) {
>> +        return FLEXCAN_CHECK_MB_MATCH_LOCKED;
>> +    } else {
>> +        return FLEXCAN_CHECK_MB_NIL;
>> +    }
>> +}
>> +static int flexcan_mb_rx(FlexcanState *s, const qemu_can_frame *buf)
>> +{
>> +    int last_not_free_to_receive_mbid =3D -1;
>> +    bool last_not_free_to_receive_locked =3D false;
>> +
>> +    FlexcanRegsMessageBuffer *first_mb =3D flexcan_get_first_message_b=
uffer(s);
>> +    FlexcanRegsMessageBuffer *last_mb =3D flexcan_get_last_enabled_mai=
lbox(s);
>> +    for (FlexcanRegsMessageBuffer *mb =3D first_mb;
>> +         mb <=3D last_mb; mb++) {
>> +        int mbid =3D mb - s->regs=2Embs;
>> +        int r =3D flexcan_mb_rx_check_mb(s, buf, mbid);
>> +        if (r =3D=3D FLEXCAN_CHECK_MB_MATCH) {
>> +            flexcan_mb_move_in(s, buf, mb);
>> +            flexcan_irq_iflag_set(s, mbid);
>> +            return FLEXCAN_RX_SEARCH_ACCEPT;
>> +        } else if (r =3D=3D FLEXCAN_CHECK_MB_MATCH_NON_FREE) {
>> +            last_not_free_to_receive_mbid =3D mbid;
>> +            last_not_free_to_receive_locked =3D false;
>> +        } else if (r =3D=3D FLEXCAN_CHECK_MB_MATCH_LOCKED) {
>> +            /*
>> +             * message buffer is locked,
>> +             * we can move in the message after it's unlocked
>> +             */
>> +            last_not_free_to_receive_mbid =3D mbid;
>> +            last_not_free_to_receive_locked =3D true;
>> +        }
>> +    }
>> +
>> +    if (last_not_free_to_receive_mbid >=3D -1) {
>> +        if (last_not_free_to_receive_locked) {
>> +            /*
>> +             * copy to temporary mailbox (SMB)
>> +             * it will be moved in when the mailbox is unlocked
>> +             */
>> +            s->regs=2Erx_smb0=2Ecan_ctrl =3D
>> +                s->regs=2Embs[last_not_free_to_receive_mbid]=2Ecan_id;
>> +            flexcan_mb_move_in(s, buf, &s->regs=2Erx_smb0);
>> +            s->smb_target_mbidx =3D last_not_free_to_receive_mbid;
>> +            return FLEXCAN_RX_SEARCH_ACCEPT;
>> +        } else if (s->regs=2Emcr & FLEXCAN_MCR_IRMQ) {
>> +            flexcan_mb_move_in(s, buf,
>> +                               &s->regs=2Embs[last_not_free_to_receive=
_mbid]);
>> +            flexcan_irq_iflag_set(s, last_not_free_to_receive_mbid);
>> +            return FLEXCAN_RX_SEARCH_ACCEPT;
>> +        }
>> +    }
>> +
>> +    return FLEXCAN_RX_SEARCH_RETRY;
>> +}
>> +
>> +ssize_t flexcan_receive(CanBusClientState *client, const qemu_can_fram=
e *frames,
>> +                        size_t frames_cnt)
>> +{
>> +    FlexcanState *s =3D container_of(client, FlexcanState, bus_client)=
;
>> +    trace_flexcan_receive(s, frames_cnt);
>> +
>> +    if (frames_cnt <=3D 0) {
>> +        g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Error in the data received=
=2E\n",
>> +                      path);
>> +        return 0;
>> +    }
>> +
>> +    /* clear the SMB, as it would be overriden in hardware */
>> +    memset(&s->regs=2Erx_smb0, 0, sizeof(FlexcanRegsMessageBuffer));
>> +    s->smb_target_mbidx =3D FLEXCAN_SMB_EMPTY;
>> +
>> +    for (size_t i =3D 0; i < frames_cnt; i++) {
>> +        int r;
>> +        const qemu_can_frame *frame =3D &frames[i];
>> +        if (frame->can_id & QEMU_CAN_ERR_FLAG) {
>> +            /* todo: error frame handling */
>> +            continue;
>> +        } else if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
>> +            /* CAN FD supported only in later FlexCAN version */
>> +            continue;
>> +        }
>> +
>> +        /* todo: this order logic is not complete and needs further wo=
rk */
>> +        if (s->regs=2Emcr & FLEXCAN_MCR_FEN &&
>> +            s->regs=2Ectrl2 & FLEXCAN_CTRL2_MRP) {
>> +            r =3D flexcan_mb_rx(s, frame);
>> +            if (r !=3D FLEXCAN_RX_SEARCH_RETRY) {
>> +                continue;
>> +            }
>> +            flexcan_fifo_rx(s, frame);
>
>Why not invert the condition and move the call inside the if statement, e=
liminating the "continue;"?
>
>> +        } else if (s->regs=2Emcr & FLEXCAN_MCR_FEN) {
>> +            r =3D flexcan_fifo_rx(s, frame);
>> +            if (r !=3D FLEXCAN_RX_SEARCH_RETRY) {
>> +                continue;
>> +            }
>> +            flexcan_mb_rx(s, frame);
>
>Same here=2E
>
>> +        } else {
>> +            flexcan_mb_rx(s, frame);
>> +        }
>> +    }
>> +
>> +    flexcan_irq_update(s);
>> +    return 1;
>> +}
>> +
>> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D I/O handling =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D */
>> +static void flexcan_reg_write(FlexcanState *s, hwaddr addr, uint32_t v=
al)
>> +{
>> +    uint32_t write_mask =3D ((const uint32_t *)
>> +        &flexcan_regs_write_mask)[addr / 4];
>> +    uint32_t old_value =3D s->regs_raw[addr / 4];
>> +
>> +    /*
>> +     * 0 for bits that can "only be written in Freeze mode as it is bl=
ocked
>> +     * by hardware in other modes"
>> +     */
>> +    const uint32_t freeze_mask_mcr =3D 0xDF54CC80;
>> +    const uint32_t freeze_mask_ctrl1 =3D 0x0000E740;
>> +
>> +    switch (addr) {
>> +    case offsetof(FlexcanRegs, mcr):
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +            write_mask &=3D freeze_mask_mcr;
>> +        }
>> +        s->regs=2Emcr =3D (val & write_mask) | (old_value & ~write_mas=
k);
>> +        flexcan_set_mcr(s, old_value);
>> +        break;
>> +    case offsetof(FlexcanRegs, ctrl):
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +            write_mask &=3D freeze_mask_ctrl1;
>> +        }
>> +        s->regs=2Ectrl =3D (val & write_mask) | (old_value & ~write_ma=
sk);
>> +        break;
>> +    case offsetof(FlexcanRegs, iflag1):
>> +        s->regs=2Eiflag1 &=3D ~val;
>> +        if ((s->regs=2Emcr & FLEXCAN_MCR_FEN) &&
>> +            (val & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE)) {
>> +            flexcan_fifo_pop(s);
>> +        }
>> +        break;
>> +    case offsetof(FlexcanRegs, iflag2):
>> +        s->regs=2Eiflag2 &=3D ~val;
>> +        break;
>> +    case offsetof(FlexcanRegs, ctrl2):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, ecr):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rxmgmask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rx14mask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rx15mask):
>> +        QEMU_FALLTHROUGH;
>> +    case offsetof(FlexcanRegs, rxfgmask):
>> +        /* these registers can only be written in freeze mode */
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +            break;
>> +        }
>> +        QEMU_FALLTHROUGH;
>> +    default:
>> +        /* RXIMRn can only be written in freeze mode */
>> +        if (!(s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK) &&
>> +            addr >=3D offsetof(FlexcanRegs, rximr) &&
>> +            addr < offsetof(FlexcanRegs, _reserved5)) {
>> +            break;
>> +        }
>
>I think it should be possible to eliminate this if statement by adding an=
other case before the default:
>    "case offsetof(FlexcanRegs, rximr[0]) =2E=2E=2E offsetof(FlexcanRegs,=
 rximr[63]):"
>
>> +
>> +        s->regs_raw[addr / 4] =3D (val & write_mask) | (old_value & ~w=
rite_mask);
>> +
>> +        if (addr >=3D offsetof(FlexcanRegs, mb) &&
>> +            addr < offsetof(FlexcanRegs, _reserved4)) {
>> +            /* access to mailbox */
>> +            int mbid =3D (addr - offsetof(FlexcanRegs, mb)) /
>> +                            sizeof(FlexcanRegsMessageBuffer);
>> +
>> +            if (s->locked_mbidx =3D=3D mbid) {
>> +                flexcan_mb_unlock(s);
>> +            }
>> +
>> +            /* check for invalid writes into FIFO region */
>> +            if (s->regs=2Emcr & FLEXCAN_MCR_FEN && mbid < FLEXCAN_FIFO=
_DEPTH) {
>> +                g_autofree char *path =3D object_get_canonical_path(OB=
JECT(s));
>> +                qemu_log_mask(LOG_GUEST_ERROR,
>> +                              "%s: Invalid write to Rx-FIFO structure"=
, path);
>> +                return;
>> +            }
>> +
>> +            /* run mailbox processing function on write to control wor=
d */
>> +            if ((addr & 0xF) =3D=3D 0) {
>> +                flexcan_mb_write(s, mbid);
>> +            }
>> +        }
>> +        break;
>> +    }
>> +
>> +    flexcan_irq_update(s);
>> +}
>> +
>> +void flexcan_mem_write(void *obj, hwaddr addr, uint64_t val, unsigned =
size)
>
>The convention in QEMU is usually to name these void pointers "opaque"=2E=
 The name "obj" suggests a QOM Object * and is therefore midleading=2E Plea=
se rename to "opaque"=2E
>
>Same for the other flexcan_ops callbacks=2E
>
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>
>C actually handles void pointers special, so you don't need to cast here=
=2E
>
>Same for the other flexcan_ops callbacks=2E
>
>> +    flexcan_trace_mem_op(s, addr, val, size, true);
>> +
>> +    if (addr < FLEXCAN_ADDR_SPC_END) {
>> +        flexcan_reg_write(s, addr, (uint32_t)val);
>> +    } else {
>> +        DPRINTF("warn: write outside of defined address space\n");
>> +    }
>> +}
>> +uint64_t flexcan_mem_read(void *obj, hwaddr addr, unsigned size)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +
>> +    if (addr < FLEXCAN_ADDR_SPC_END) {
>> +        uint32_t rv =3D s->regs_raw[addr >> 2];
>> +
>> +        if (addr >=3D offsetof(FlexcanRegs, mb) &&
>> +            addr < offsetof(FlexcanRegs, _reserved4)) {
>> +            /* reading from mailbox */
>> +            hwaddr offset =3D addr - offsetof(FlexcanRegs, mb);
>> +            int mbid =3D offset / sizeof(FlexcanRegsMessageBuffer);
>> +
>> +            if (addr % 16 =3D=3D 0 && s->locked_mbidx !=3D mbid) {
>> +                /* reading control word locks the mailbox */
>> +                flexcan_mb_unlock(s);
>> +                flexcan_mb_lock(s, mbid);
>> +                flexcan_irq_update(s);
>> +                rv =3D s->regs=2Embs[mbid]=2Ecan_ctrl & ~FLEXCAN_MB_CN=
T_NOT_SRV;
>> +            }
>> +        } else if (addr =3D=3D offsetof(FlexcanRegs, timer)) {
>> +            flexcan_mb_unlock(s);
>> +            flexcan_irq_update(s);
>> +            rv =3D flexcan_get_timestamp(s, false);
>> +        }
>> +
>> +        flexcan_trace_mem_op(s, addr, rv, size, false);
>> +        return rv;
>> +    } else {
>> +        g_autofree char *path =3D object_get_canonical_path(OBJECT(s))=
;
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Invalid write outside valid I/O space", pat=
h);
>> +
>> +        flexcan_trace_mem_op(s, addr, 0, size, false);
>> +        return 0;
>> +    }
>> +}
>> +bool flexcan_mem_accepts(void *obj, hwaddr addr,
>> +                                unsigned size, bool is_write,
>> +                                MemTxAttrs attrs)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +
>> +    if ((s->regs=2Ectrl2 & FLEXCAN_CTRL2_WRMFRZ) &&
>> +        (s->regs=2Emcr & FLEXCAN_MCR_FRZ_ACK)) {
>> +        /* unrestricted access to FlexCAN memory in freeze mode */
>> +        return true;
>> +    } else if (attrs=2Euser && (s->regs=2Emcr & FLEXCAN_MCR_SUPV)) {
>> +        goto denied;
>> +    } else if (is_write && attrs=2Euser && addr < 4) {
>> +        /* illegal user write to MCR */
>> +        goto denied;
>> +    } else if (addr >=3D FLEXCAN_ADDR_SPC_END) {
>> +        /* illegal write to non-existent register */
>> +        goto denied;
>> +    }
>
>The gotos can be avoided by turning the comments into guest error logs an=
d returning early=2E Bonus points for avoiding else after return for readab=
ility reasons: https://clang=2Ellvm=2Eorg/extra/clang-tidy/checks/readabili=
ty/else-after-return=2Ehtml
>
>> +
>> +    return true;
>> +denied:
>> +    trace_flexcan_mem_accepts(s, addr, size, is_write, !attrs=2Euser);
>> +    return false;
>> +}
>> +
>> +static CanBusClientInfo flexcan_bus_client_info =3D {
>> +    =2Ecan_receive =3D flexcan_can_receive,
>> +    =2Ereceive =3D flexcan_receive,
>> +};
>> +
>> +static int flexcan_connect_to_bus(FlexcanState *s, CanBusState *bus)
>> +{
>> +    s->bus_client=2Einfo =3D &flexcan_bus_client_info;
>> +
>> +    if (can_bus_insert_client(bus, &s->bus_client) < 0) {
>> +        return -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +void flexcan_init(Object *obj)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(obj);
>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>> +
>> +    USE(s);
>> +    USE(sbd);
>
>No unused variables, please=2E And no "USE" macros which basically circum=
vent compiler warnings that are there for a purpose=2E
>
>To avoid an empty method, you could actually perform the initialization o=
f s->iomem here instead of in the realize method=2E This would also prepare=
 for adding flexcan 3 support (see below)=2E
>
>> +}
>> +
>> +static void flexcan_realize(DeviceState *dev, Error **errp)
>> +{
>> +    FlexcanState *s =3D CAN_FLEXCAN(dev);
>> +
>> +    if (s->canbus) {
>> +        if (flexcan_connect_to_bus(s, s->canbus) < 0) {
>> +            g_autofree char *path =3D object_get_canonical_path(OBJECT=
(s));
>> +
>> +            error_setg(errp, "%s: flexcan_connect_to_bus"
>> +                        " failed=2E", path);
>> +            return;
>> +        }
>> +    }
>> +
>> +    flexcan_reset_local_state(s);
>
>QEMU's reset logic will invoke this method automatically before starting =
the machine, rendering this call redundant=2E Please remove=2E
>
>> +
>> +    memory_region_init_io(
>> +        &s->iomem, OBJECT(dev), &flexcan_ops, s, TYPE_CAN_FLEXCAN, 0x4=
000
>
>Instead of passing 0x4000 (which likely contains SoC-specific padding) as=
 the size, you could pass FLEXCAN_ADDR_SPC_END instead=2E This avoids quite=
 a few error cases in the code since you can eliminate all bounds checks ag=
ainst FLEXCAN_ADDR_SPC_END=2E In fact, you could eliminate FLEXCAN_ADDR_SPC=
_END entirely and pass "offsetof(FlexcanRegs, _reserved6)" as the size dire=
ctly=2E If you then initialize s->iomem in the init method, like suggested =
above, we could later add a flexcan3 init method with a different size, kee=
ping code churn at a minimum=2E See my imx8mp-flexcan branch as a working e=
xample=2E
>
>> +    );
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>> +    sysbus_init_irq(SYS_BUS_DEVICE(SYS_BUS_DEVICE(dev)), &s->irq);
>> +}
>> +
>> +static const VMStateDescription vmstate_can =3D {
>> +    =2Ename =3D TYPE_CAN_FLEXCAN,
>> +    =2Eversion_id =3D 1,
>> +    =2Eminimum_version_id =3D 1,
>> +    =2Efields =3D (const VMStateField[]) {
>> +        VMSTATE_INT64(timer_start, FlexcanState),
>> +        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, sizeof(FlexcanReg=
s) / 4),
>> +        VMSTATE_INT32(locked_mbidx, FlexcanState),
>> +        VMSTATE_INT32(smb_target_mbidx, FlexcanState),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>> +static const Property flexcan_properties[] =3D {
>> +    DEFINE_PROP_LINK("canbus", FlexcanState, canbus, TYPE_CAN_BUS,
>> +                     CanBusState *),
>> +};
>> +
>> +static void flexcan_class_init(ObjectClass *klass, const void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>> +
>> +    rc->phases=2Eenter =3D flexcan_reset_enter;
>> +    rc->phases=2Ehold =3D flexcan_reset_hold;
>> +    dc->realize =3D &flexcan_realize;
>> +    device_class_set_props(dc, flexcan_properties);
>> +    dc->vmsd =3D &vmstate_can;
>> +    dc->desc =3D "i=2EMX FLEXCAN Controller";
>> +}
>> +
>> +static const TypeInfo flexcan_info =3D {
>> +    =2Ename          =3D TYPE_CAN_FLEXCAN,
>> +    =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>> +    =2Einstance_size =3D sizeof(FlexcanState),
>> +    =2Eclass_init    =3D flexcan_class_init,
>> +    =2Einstance_init =3D flexcan_init,
>> +};
>> +
>> +static void can_register_types(void)
>> +{
>> +    type_register_static(&flexcan_info);
>> +}
>> +type_init(can_register_types)
>> diff --git a/hw/net/can/flexcan_regs=2Eh b/hw/net/can/flexcan_regs=2Eh
>> new file mode 100644
>> index 0000000000=2E=2E8e976b2c9e
>> --- /dev/null
>> +++ b/hw/net/can/flexcan_regs=2Eh
>> @@ -0,0 +1,188 @@
>> +/*
>> + * Field bitmasks and register structs definitions for FlexCAN
>> + *
>> + * This implementation is based on the following datasheet:
>> + * i=2EMX 6Dual/6Quad Applications Processor Reference Manual
>> + * Document Number: IMX6DQRM, Rev=2E 6, 05/2020
>> + *
>> + * Copyright (c) 2025 Matyas Bobek <matyas=2Ebobek@gmail=2Ecom>
>> + *
>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> + */
>> +#include "qemu/bitops=2Eh"
>> +
>> +#ifndef HW_CAN_FLEXCAN_REGS_H
>> +#define HW_CAN_FLEXCAN_REGS_H
>> +
>> +#define FLEXCAN_GENMASK(h, l) (((~(uint32_t)0) >> (31 - (h) + (l))) <<=
 (l))
>> +
>> +/* FLEXCAN module configuration register (CANMCR) bits */
>> +#define FLEXCAN_MCR_MDIS                BIT(31)
>> +#define FLEXCAN_MCR_FRZ                 BIT(30)
>> +#define FLEXCAN_MCR_FEN                 BIT(29)
>> +#define FLEXCAN_MCR_HALT                BIT(28)
>> +#define FLEXCAN_MCR_NOT_RDY             BIT(27)
>> +#define FLEXCAN_MCR_WAK_MSK             BIT(26)
>> +#define FLEXCAN_MCR_SOFTRST             BIT(25)
>> +#define FLEXCAN_MCR_FRZ_ACK             BIT(24)
>> +#define FLEXCAN_MCR_SUPV                BIT(23)
>> +#define FLEXCAN_MCR_SLF_WAK             BIT(22)
>> +#define FLEXCAN_MCR_WRN_EN              BIT(21)
>> +#define FLEXCAN_MCR_LPM_ACK             BIT(20)
>> +#define FLEXCAN_MCR_WAK_SRC             BIT(19)
>> +#define FLEXCAN_MCR_DOZE                BIT(18)
>> +#define FLEXCAN_MCR_SRX_DIS             BIT(17)
>> +#define FLEXCAN_MCR_IRMQ                BIT(16)
>> +#define FLEXCAN_MCR_LPRIO_EN            BIT(13)
>> +#define FLEXCAN_MCR_AEN                 BIT(12)
>> +#define FLEXCAN_MCR_FDEN                BIT(11)
>> +#define FLEXCAN_MCR_MAXMB(x)            ((x) & 0x7f)
>> +#define FLEXCAN_MCR_IDAM_A              (0x0 << 8)
>> +#define FLEXCAN_MCR_IDAM_B              (0x1 << 8)
>> +#define FLEXCAN_MCR_IDAM_C              (0x2 << 8)
>> +#define FLEXCAN_MCR_IDAM_D              (0x3 << 8)
>> +#define FLEXCAN_MCR_IDAM_MASK           (0x3 << 8)
>> +
>> +/* FLEXCAN control register (CANCTRL) bits */
>> +#define FLEXCAN_CTRL_PRESDIV(x)         (((x) & 0xFF) << 24)
>> +#define FLEXCAN_CTRL_PRESDIV_MASK       FLEXCAN_CTRL_PRESDIV(UINT32_MA=
X)
>> +#define FLEXCAN_CTRL_RJW(x)             (((x) & 0x03) << 22)
>> +#define FLEXCAN_CTRL_RJW_MASK           FLEXCAN_CTRL_RJW(UINT32_MAX)
>> +#define FLEXCAN_CTRL_PSEG1(x)           (((x) & 0x07) << 19)
>> +#define FLEXCAN_CTRL_PSEG1_MASK         FLEXCAN_CTRL_PSEG1(UINT32_MAX)
>> +#define FLEXCAN_CTRL_PSEG2(x)           (((x) & 0x07) << 16)
>> +#define FLEXCAN_CTRL_PSEG2_MASK         FLEXCAN_CTRL_PSEG2(UINT32_MAX)
>> +#define FLEXCAN_CTRL_BOFF_MSK           BIT(15)
>> +#define FLEXCAN_CTRL_ERR_MSK            BIT(14)
>> +#define FLEXCAN_CTRL_CLK_SRC            BIT(13)
>> +#define FLEXCAN_CTRL_LPB                BIT(12)
>> +#define FLEXCAN_CTRL_TWRN_MSK           BIT(11)
>> +#define FLEXCAN_CTRL_RWRN_MSK           BIT(10)
>> +#define FLEXCAN_CTRL_SMP                BIT(7)
>> +#define FLEXCAN_CTRL_BOFF_REC           BIT(6)
>> +#define FLEXCAN_CTRL_TSYN               BIT(5)
>> +#define FLEXCAN_CTRL_LBUF               BIT(4)
>> +#define FLEXCAN_CTRL_LOM                BIT(3)
>> +#define FLEXCAN_CTRL_PROPSEG(x)         ((x) & 0x07)
>> +#define FLEXCAN_CTRL_PROPSEG_MASK       FLEXCAN_CTRL_PROPSEG(UINT32_MA=
X)
>> +#define FLEXCAN_CTRL_ERR_BUS            (FLEXCAN_CTRL_ERR_MSK)
>> +#define FLEXCAN_CTRL_ERR_STATE \
>> +        (FLEXCAN_CTRL_TWRN_MSK | FLEXCAN_CTRL_RWRN_MSK | \
>> +         FLEXCAN_CTRL_BOFF_MSK)
>> +#define FLEXCAN_CTRL_ERR_ALL \
>> +        (FLEXCAN_CTRL_ERR_BUS | FLEXCAN_CTRL_ERR_STATE)
>> +
>> +/* FLEXCAN control register 2 (CTRL2) bits */
>> +#define FLEXCAN_CTRL2_ECRWRE            BIT(29)
>> +#define FLEXCAN_CTRL2_WRMFRZ            BIT(28)
>> +#define FLEXCAN_CTRL2_RFFN(x)           (((x) & 0x0f) << 24)
>> +#define FLEXCAN_CTRL2_TASD(x)           (((x) & 0x1f) << 19)
>> +#define FLEXCAN_CTRL2_MRP               BIT(18)
>> +#define FLEXCAN_CTRL2_RRS               BIT(17)
>> +#define FLEXCAN_CTRL2_EACEN             BIT(16)
>> +#define FLEXCAN_CTRL2_ISOCANFDEN        BIT(12)
>> +
>> +/* FLEXCAN memory error control register (MECR) bits */
>> +#define FLEXCAN_MECR_ECRWRDIS           BIT(31)
>> +#define FLEXCAN_MECR_HANCEI_MSK         BIT(19)
>> +#define FLEXCAN_MECR_FANCEI_MSK         BIT(18)
>> +#define FLEXCAN_MECR_CEI_MSK            BIT(16)
>> +#define FLEXCAN_MECR_HAERRIE            BIT(15)
>> +#define FLEXCAN_MECR_FAERRIE            BIT(14)
>> +#define FLEXCAN_MECR_EXTERRIE           BIT(13)
>> +#define FLEXCAN_MECR_RERRDIS            BIT(9)
>> +#define FLEXCAN_MECR_ECCDIS             BIT(8)
>> +#define FLEXCAN_MECR_NCEFAFRZ           BIT(7)
>> +
>> +/* FLEXCAN error and status register (ESR) bits */
>> +#define FLEXCAN_ESR_SYNCH               BIT(18)
>> +#define FLEXCAN_ESR_TWRN_INT            BIT(17)
>> +#define FLEXCAN_ESR_RWRN_INT            BIT(16)
>> +#define FLEXCAN_ESR_BIT1_ERR            BIT(15)
>> +#define FLEXCAN_ESR_BIT0_ERR            BIT(14)
>> +#define FLEXCAN_ESR_ACK_ERR             BIT(13)
>> +#define FLEXCAN_ESR_CRC_ERR             BIT(12)
>> +#define FLEXCAN_ESR_FRM_ERR             BIT(11)
>> +#define FLEXCAN_ESR_STF_ERR             BIT(10)
>> +#define FLEXCAN_ESR_TX_WRN              BIT(9)
>> +#define FLEXCAN_ESR_RX_WRN              BIT(8)
>> +#define FLEXCAN_ESR_IDLE                BIT(7)
>> +#define FLEXCAN_ESR_BOFF_INT            BIT(2)
>> +#define FLEXCAN_ESR_ERR_INT             BIT(1)
>> +#define FLEXCAN_ESR_WAK_INT             BIT(0)
>> +
>> +/* FLEXCAN Bit Timing register (CBT) bits */
>> +#define FLEXCAN_CBT_BTF                 BIT(31)
>> +#define FLEXCAN_CBT_EPRESDIV_MASK       FLEXCAN_GENMASK(30, 21)
>> +#define FLEXCAN_CBT_ERJW_MASK           FLEXCAN_GENMASK(20, 16)
>> +#define FLEXCAN_CBT_EPROPSEG_MASK       FLEXCAN_GENMASK(15, 10)
>> +#define FLEXCAN_CBT_EPSEG1_MASK         FLEXCAN_GENMASK(9, 5)
>> +#define FLEXCAN_CBT_EPSEG2_MASK         FLEXCAN_GENMASK(4, 0)
>> +
>> +/* FLEXCAN FD control register (FDCTRL) bits */
>> +#define FLEXCAN_FDCTRL_FDRATE           BIT(31)
>> +#define FLEXCAN_FDCTRL_MBDSR1           FLEXCAN_GENMASK(20, 19)
>> +#define FLEXCAN_FDCTRL_MBDSR0           FLEXCAN_GENMASK(17, 16)
>> +#define FLEXCAN_FDCTRL_MBDSR_8          0x0
>> +#define FLEXCAN_FDCTRL_MBDSR_12         0x1
>> +#define FLEXCAN_FDCTRL_MBDSR_32         0x2
>> +#define FLEXCAN_FDCTRL_MBDSR_64         0x3
>> +#define FLEXCAN_FDCTRL_TDCEN            BIT(15)
>> +#define FLEXCAN_FDCTRL_TDCFAIL          BIT(14)
>> +#define FLEXCAN_FDCTRL_TDCOFF           FLEXCAN_GENMASK(12, 8)
>> +#define FLEXCAN_FDCTRL_TDCVAL           FLEXCAN_GENMASK(5, 0)
>> +
>> +/* FLEXCAN FD Bit Timing register (FDCBT) bits */
>> +#define FLEXCAN_FDCBT_FPRESDIV_MASK     FLEXCAN_GENMASK(29, 20)
>> +#define FLEXCAN_FDCBT_FRJW_MASK         FLEXCAN_GENMASK(18, 16)
>> +#define FLEXCAN_FDCBT_FPROPSEG_MASK     FLEXCAN_GENMASK(14, 10)
>> +#define FLEXCAN_FDCBT_FPSEG1_MASK       FLEXCAN_GENMASK(7, 5)
>> +#define FLEXCAN_FDCBT_FPSEG2_MASK       FLEXCAN_GENMASK(2, 0)
>> +
>> +/* FLEXCAN CRC Register (CRCR) bits */
>> +#define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
>> +#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MAS=
K) << 16)
>> +#define FLEXCAN_CRCR_TXCRC_MASK         FLEXCAN_GENMASK(14, 0)
>> +#define FLEXCAN_CRCR_TXCRC(x)           ((x) & FLEXCAN_CRCR_TXCRC_MASK=
)
>> +
>> +/* FLEXCAN interrupt flag register (IFLAG) bits */
>> +/* Errata ERR005829 step7: Reserve first valid MB */
>> +#define I_FIFO_OVERFLOW  7
>> +#define I_FIFO_WARN      6
>> +#define I_FIFO_AVAILABLE 5
>> +
>> +#define FLEXCAN_TX_MB_RESERVED_RX_FIFO  8
>> +#define FLEXCAN_TX_MB_RESERVED_RX_MAILBOX       0
>> +#define FLEXCAN_RX_MB_RX_MAILBOX_FIRST  (FLEXCAN_TX_MB_RESERVED_RX_MAI=
LBOX + 1)
>> +#define FLEXCAN_IFLAG_MB(x)             BIT_ULL(x)
>> +#define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW  BIT(I_FIFO_OVERFLOW)
>> +#define FLEXCAN_IFLAG_RX_FIFO_WARN      BIT(I_FIFO_WARN)
>> +#define FLEXCAN_IFLAG_RX_FIFO_AVAILABLE BIT(I_FIFO_AVAILABLE)
>> +
>> +/* FLEXCAN message buffers */
>> +#define FLEXCAN_MB_CODE_RX_BUSY_BIT     (0x1 << 24)
>> +#define FLEXCAN_MB_CODE_RX_INACTIVE     (0x0 << 24)
>> +#define FLEXCAN_MB_CODE_RX_EMPTY        (0x4 << 24)
>> +#define FLEXCAN_MB_CODE_RX_FULL         (0x2 << 24)
>> +#define FLEXCAN_MB_CODE_RX_OVERRUN      (0x6 << 24)
>> +#define FLEXCAN_MB_CODE_RX_RANSWER      (0xa << 24)
>> +
>> +#define FLEXCAN_MB_CODE_TX_INACTIVE     (0x8 << 24)
>> +#define FLEXCAN_MB_CODE_TX_ABORT        (0x9 << 24)
>> +#define FLEXCAN_MB_CODE_TX_DATA         (0xc << 24)
>> +#define FLEXCAN_MB_CODE_TX_TANSWER      (0xe << 24)
>> +
>> +#define FLEXCAN_MB_CODE(x)              (((x) & 0xF) << 24)
>> +#define FLEXCAN_MB_CODE_MASK            FLEXCAN_MB_CODE(UINT32_MAX)
>> +
>> +#define FLEXCAN_MB_CNT_EDL              BIT(31)
>> +#define FLEXCAN_MB_CNT_BRS              BIT(30)
>> +#define FLEXCAN_MB_CNT_ESI              BIT(29)
>> +#define FLEXCAN_MB_CNT_SRR              BIT(22)
>> +#define FLEXCAN_MB_CNT_IDE              BIT(21)
>> +#define FLEXCAN_MB_CNT_RTR              BIT(20)
>> +#define FLEXCAN_MB_CNT_LENGTH(x)        (((x) & 0xF) << 16)
>> +#define FLEXCAN_MB_CNT_TIMESTAMP(x)     ((x) & 0xFFFF)
>> +#define FLEXCAN_MB_CNT_TIMESTAMP_MASK   FLEXCAN_MB_CNT_TIMESTAMP(UINT3=
2_MAX)
>> +
>> +#endif
>> diff --git a/hw/net/can/meson=2Ebuild b/hw/net/can/meson=2Ebuild
>> index 7382344628=2E=2E401afde2e4 100644
>> --- a/hw/net/can/meson=2Ebuild
>> +++ b/hw/net/can/meson=2Ebuild
>> @@ -6,3 +6,4 @@ system_ss=2Eadd(when: 'CONFIG_CAN_CTUCANFD', if_true: f=
iles('ctucan_core=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan=
_pci=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp=
-can=2Ec'))
>> system_ss=2Eadd(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal=
-canfd=2Ec'))
>> +system_ss=2Eadd(when: 'CONFIG_CAN_FLEXCAN', if_true: files('flexcan=2E=
c'))
>> diff --git a/hw/net/can/trace-events b/hw/net/can/trace-events
>> index de64ac1b31=2E=2E83f574e81c 100644
>> --- a/hw/net/can/trace-events
>> +++ b/hw/net/can/trace-events
>> @@ -1,3 +1,21 @@
>> +# flexcan=2Ec
>> +flexcan_irq_update(void *inst, uint32_t mb_irqs1, uint32_t mb_irqs2, i=
nt setting) "%p: irqs1 0x%08x irqs2 0x%08x request %i"
>> +flexcan_set_mcr(void* inst, const char *enabled, const char *freeze, c=
onst char *fifo, const char *rdy, const char *sync) "%p: %s %s %s %s %s"
>> +flexcan_mb_write(void *inst, int mbidx, const char *code, int is_mailb=
ox, uint32_t ctrl, uint32_t id) "%p: mbidx %i code %s is_mailbox %i ctrl 0x=
%08x id 0x%08x"
>> +flexcan_mb_lock(void *inst, int mbidx, int had_rx_code) "%p: mbidx %i =
had_rx_code %i"
>> +flexcan_mb_unlock(void *inst, int mbidx, const char *pending_frame) "%=
p: mbidx %i%s"
>> +flexcan_fifo_pop(void *inst, int non_empty_before, int non_empty_after=
) "%p: non_empty before %i non_empty_after %i"
>> +flexcan_fifo_push(void *inst, int n_occupied) "%p: n_slots_occupied %i=
"
>> +flexcan_reset(void* inst) "%p: resetting"
>> +flexcan_mem_op(void *inst, const char *op, uint32_t v, int offset, con=
st char *reg_name, int size) "%p: %s 0x%08x at offset %i register %s size %=
i"
>> +flexcan_mem_accepts(void *inst, int offset, int size, int is_write, in=
t is_supv) "%p: denied access: offset %i size %i is_write %i is_supv %i"
>> +flexcan_get_timestamp(void *inst, int64_t time_elapsed_ms, uint32_t bi=
trate, uint64_t cycles, uint32_t shift, uint32_t timestamp) "%p: time_elaps=
ed %" PRIi64 "ms bitrate %ub/s cycles %" PRIu64 " shift %u timestamp 0x%04x=
"
>> +flexcan_get_bitrate(void *inst, uint32_t pe_freq, uint32_t prediv, uin=
t32_t s_freq, uint32_t tseg1, uint32_t tseg2, uint32_t quata_per_bit, uint3=
2_t bitrate) "%p: pe_freq %uHz prescaler %u s_freq %uHz tseg1 %uq tseg2 %uq=
 total %uq/b bitrate %ub/s"
>> +flexcan_timer_start(void *inst, uint32_t bitrate, uint32_t value) "%p:=
 bitrate %ub/s value 0x%04x"
>> +flexcan_timer_stop(void *inst, uint32_t bitrate, uint32_t value) "%p: =
bitrate %ub/s value 0x%04x"
>> +flexcan_mb_rx_check_mb(void *inst, int mbidx, const char *code, int is=
_matched, int is_ftr, int is_serviced, int is_locked) "%p: checking mb %i c=
ode %s is_matched %i is_free_to_receive %i is_serviced %i is_locked %i"
>> +flexcan_receive(void *inst, size_t n_frames) "%p: received %zu frames"
>> +
>> # xlnx-zynqmp-can=2Ec
>> xlnx_can_update_irq(uint32_t isr, uint32_t ier, uint32_t irq) "ISR: 0x%=
08x IER: 0x%08x IRQ: 0x%08x"
>> xlnx_can_reset(uint32_t val) "Resetting controller with value =3D 0x%08=
x"
>> diff --git a/include/hw/net/flexcan=2Eh b/include/hw/net/flexcan=2Eh
>> new file mode 100644
>> index 0000000000=2E=2Eeceb6a7920
>> --- /dev/null
>> +++ b/include/hw/net/flexcan=2Eh
>> @@ -0,0 +1,153 @@
>> +/*
>> + * QEMU model of the NXP FLEXCAN device=2E
>> + *
>> + * Copyright (c) 2025 Matyas Bobek <matyas=2Ebobek@gmail=2Ecom>
>> + *
>> + * Based on CTU CAN FD emulation implemented by Jan Charvat=2E
>> + *
>> + * This code is licensed under the GPL version 2 or later=2E  See
>> + * the COPYING file in the top-level directory=2E
>> + *
>> + * SPDX-License-Identifier: GPL-2=2E0-or-later
>> + */
>> +
>> +#ifndef HW_CAN_FLEXCAN_H
>> +#define HW_CAN_FLEXCAN_H
>> +
>> +#include "hw/sysbus=2Eh"
>> +#include "exec/hwaddr=2Eh"
>> +#include "net/can_emu=2Eh"
>> +#include "qom/object=2Eh"
>> +#include "hw/misc/imx_ccm=2Eh"
>> +
>> +#define FLEXCAN_FIFO_DEPTH 6
>> +#define FLEXCAN_MAILBOX_COUNT 64
>> +
>> +/* view of single message buffer registers */
>> +typedef struct FlexcanRegsMessageBuffer {
>> +    uint32_t can_ctrl;
>> +    uint32_t can_id;
>> +    uint32_t data[2];
>> +} FlexcanRegsMessageBuffer;
>> +
>> +/* RX FIFO view of message buffer registers */
>> +typedef struct FlexcanRegsRXFifo {
>> +    /* 6 message buffer deep queue, queue back first */
>> +    FlexcanRegsMessageBuffer mb_back;
>> +    FlexcanRegsMessageBuffer mbs_queue[5];
>> +
>> +    /* number of filter elements depends on ctrl2 | FLEXCAN_CTRL2_RFFN=
 */
>> +    uint32_t                 filter_table_els[128];
>> +} FlexcanRegsRXFifo;
>> +
>
>The following structure looks like being based on Linux=2E Does this affe=
ct the copyright of this file?
>
>Shall we reuse constants like FLEXCAN_MAILBOX_COUNT and FLEXCAN_FIFO_DEPT=
H in the structure definition? Up to you=2E
>
>> +/* Structure of the hardware registers */
>> +typedef struct FlexcanRegs {
>> +    uint32_t mcr;                /* 0x00 */
>> +    uint32_t ctrl;               /* 0x04 - not affected by soft reset =
*/
>> +    uint32_t timer;              /* 0x08 */
>> +    uint32_t tcr;                /* 0x0C */
>> +    uint32_t rxmgmask;           /* 0x10 - not affected by soft reset =
*/
>> +    uint32_t rx14mask;           /* 0x14 - not affected by soft reset =
*/
>> +    uint32_t rx15mask;           /* 0x18 - not affected by soft reset =
*/
>> +    uint32_t ecr;                /* 0x1C */
>> +    uint32_t esr;                /* 0x20 */
>> +    uint32_t imask2;             /* 0x24 */
>> +    uint32_t imask1;             /* 0x28 */
>> +    uint32_t iflag2;             /* 0x2C */
>> +    uint32_t iflag1;             /* 0x30 */
>> +    union {                      /* 0x34 */
>> +        uint32_t gfwr_mx28;      /* MX28, MX53 */
>> +        uint32_t ctrl2;          /* MX6, VF610 - not affected by soft =
reset */
>> +    };
>> +    uint32_t esr2;               /* 0x38 */
>> +    uint32_t imeur;              /* 0x3C, unused */
>> +    uint32_t lrfr;               /* 0x40, unused */
>> +    uint32_t crcr;               /* 0x44 */
>> +    uint32_t rxfgmask;           /* 0x48 */
>> +    uint32_t rxfir;              /* 0x4C - not affected by soft reset =
*/
>> +    uint32_t cbt;                /* 0x50, unused - not affected by sof=
t reset */
>> +    uint32_t _reserved2;         /* 0x54 */
>> +    uint32_t dbg1;               /* 0x58, unused */
>> +    uint32_t dbg2;               /* 0x5C, unused */
>> +    uint32_t _reserved3[8];      /* 0x60 */
>> +    union {                      /* 0x80 - not affected by soft reset =
*/
>> +        uint32_t mb[256];
>> +        FlexcanRegsMessageBuffer mbs[64];
>> +        FlexcanRegsRXFifo fifo;
>> +    };
>> +    uint32_t _reserved4[256];    /* 0x480 */
>> +    uint32_t rximr[64];          /* 0x880 - not affected by soft reset=
 */
>> +    uint32_t _reserved5[24];     /* 0x980 */
>> +    uint32_t gfwr_mx6;           /* 0x9E0 - MX6 */
>> +
>> +    /* the rest is unused except for SMB */
>> +    uint32_t _reserved6[39];     /* 0x9E4 */
>> +    uint32_t _rxfir[6];          /* 0xA80 */
>> +    uint32_t _reserved8[2];      /* 0xA98 */
>> +    uint32_t _rxmgmask;          /* 0xAA0 */
>> +    uint32_t _rxfgmask;          /* 0xAA4 */
>> +    uint32_t _rx14mask;          /* 0xAA8 */
>> +    uint32_t _rx15mask;          /* 0xAAC */
>> +    uint32_t tx_smb[4];          /* 0xAB0 */
>> +    union {                      /* 0xAC0, used for SMB emulation */
>> +        uint32_t rx_smb0_raw[4];
>> +        FlexcanRegsMessageBuffer rx_smb0;
>> +    };
>> +    uint32_t rx_smb1[4];         /* 0xAD0 */
>> +    uint32_t mecr;               /* 0xAE0 */
>> +    uint32_t erriar;             /* 0xAE4 */
>> +    uint32_t erridpr;            /* 0xAE8 */
>> +    uint32_t errippr;            /* 0xAEC */
>> +    uint32_t rerrar;             /* 0xAF0 */
>> +    uint32_t rerrdr;             /* 0xAF4 */
>> +    uint32_t rerrsynr;           /* 0xAF8 */
>> +    uint32_t errsr;              /* 0xAFC */
>> +    uint32_t _reserved7[64];     /* 0xB00 */
>> +    uint32_t fdctrl;             /* 0xC00 - not affected by soft reset=
 */
>> +    uint32_t fdcbt;              /* 0xC04 - not affected by soft reset=
 */
>> +    uint32_t fdcrc;              /* 0xC08 */
>> +    uint32_t _reserved9[199];    /* 0xC0C */
>> +    uint32_t tx_smb_fd[18];      /* 0xF28 */
>> +    uint32_t rx_smb0_fd[18];     /* 0xF70 */
>> +    uint32_t rx_smb1_fd[18];     /* 0xFB8 */
>> +} FlexcanRegs;
>> +
>> +typedef struct FlexcanState {
>> +    SysBusDevice        parent_obj;
>
>Let's add a blank line here to visually separate the base class=2E
>
>> +    MemoryRegion        iomem;
>> +    IMXCCMState        *ccm;
>> +    qemu_irq            irq;
>> +
>> +    CanBusState        *canbus;
>> +    CanBusClientState   bus_client;
>> +
>> +    union {
>> +        FlexcanRegs     regs;
>> +        uint32_t        regs_raw[sizeof(FlexcanRegs) / 4];
>> +    };
>> +    int64_t             timer_start;
>> +    uint64_t            last_rx_timer_cycles;
>> +    int32_t             locked_mbidx;
>> +    int32_t             smb_target_mbidx;
>> +    uint32_t            timer_freq;
>> +} FlexcanState;
>> +
>> +#define TYPE_CAN_FLEXCAN "flexcan"
>> +
>> +OBJECT_DECLARE_SIMPLE_TYPE(FlexcanState, CAN_FLEXCAN);
>
>The folling symbols=2E=2E=2E
>
>> +
>> +void flexcan_init(Object *obj);
>> +void flexcan_hardware_reset(FlexcanState *s);
>> +
>> +bool flexcan_can_receive(CanBusClientState *s);
>> +ssize_t flexcan_receive(CanBusClientState *s, const qemu_can_frame *fr=
ames,
>> +                        size_t frames_cnt);
>> +
>> +void flexcan_mem_write(void *obj, hwaddr addr, uint64_t val, unsigned =
size);
>> +uint64_t flexcan_mem_read(void *obj, hwaddr addr, unsigned size);
>> +bool flexcan_mem_accepts(void *obj, hwaddr addr, unsigned size, bool i=
s_write,
>> +                         MemTxAttrs attrs);
>> +
>> +extern const VMStateDescription vmstate_flexcan;
>
>=2E=2E=2E aren't used outside the =2Ec file, so please keep them private=
=2E You may need to move the "flexcan_ops" definition in the =2Ec file furt=
her down to avoid forward declarations=2E
>
>Quite a lot of comments from my side, I hope you don'f feel intimidated! =
I'm looking forward to seeing FlexCAN support upstreamed=2E If you have any=
 questions please feel free to ask=2E

Ping

Any help needed?

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>> +
>> +#endif

