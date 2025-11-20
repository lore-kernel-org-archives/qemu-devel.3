Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88A6CF884A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3Jz-0006WC-09; Thu, 20 Nov 2025 06:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Jx-0006VR-7I
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:59:29 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Ju-0003TX-Bm
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:59:28 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so548866a34.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763639965; x=1764244765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwKMvDY8297hr9uPqK/3BBxH5Upv5LgYn4pXQ9ZWDpA=;
 b=iaIoaAnmbsqvZHXxJUY93nGYFKny0Yuiv9o29BDmJooBE9J7fBHKIGpyJll09zmW3Q
 Z+sozR6D0bTGxkfF7hF5Oed6whygUg9ntJXLF7igTlUIASLvNyMZuz/a2v22RDJwgTKB
 O/aojw3oJa190NQYOKKUjIefyhHYI34SzdHTd9RHseiZTa2c8Es/B90cFntS4iZumTJD
 mppuDUwSpM84cRn8FcgEUUXhX+gGK6g+Ck3mOiSy6CMSFhFkwSf1xMwQgQ4i6aKO/U3t
 RJUgidWZFEmB6HZi5EUTDpx2lG1eTHW9oJBsUYUb07l6E0HJY7rJq5KsRiiQFWNkWfRH
 uRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763639965; x=1764244765;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BwKMvDY8297hr9uPqK/3BBxH5Upv5LgYn4pXQ9ZWDpA=;
 b=conDAyMHQxScvh/I+54DCC3q/ITwRDb3YUQbHvNBj7lolOKU0LMZAxIs4H2OnZaej0
 s9fZ9/6f3GJipvJtlnHcPlJv6xLzPXj4Itez0+4HCNflOeMqJoMHlfx4Y93+eYoRfe1G
 BeupLQ5ulVcGcuBQzcuNO34e7p1IhNiOHnFEU2F9HR9xQCWvUZ80835luUHRCWfOz4+g
 WYVP6hWHjFD/WsVAam1Y362MFmo61JZpBJB2PfA1YT5iaReE9UVjuAMFbpK300yngSsc
 mPES6emYSVrNNnGhXwZbWdbeOCJ99qx4O44Qy5kxMzwjc9MOQdBx8Xy8rl0yADpBwN+w
 iTYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7CXxU83QCcjVcE//FsA32LCTJ3zq2BZlHHGKglisB3ZfM5krNflcU5HFae4WftJySNLuLWPQOrCVG@nongnu.org
X-Gm-Message-State: AOJu0Yyhc9zbLan3L+avgnWohX4g+FmRpS6t+kSBWdaz5CkgaI4BIKbW
 ewI4sTkLTEnFxpZYFczN0VB29YLMAZbbZlSuFhYC6jqpMv0XH6EZo8BJsuniXxJyCNY=
X-Gm-Gg: ASbGnctZhMltlbWwL57YnP6BU451tbU4bdxfOmXcVEVYr1VtD4vbYelBj4yth9fIfik
 n7BYPFkQY+7DfszifrFnN1qxeOoeobDv7ujPTzsHbbza2ONn2oWmk/UopN/EDbfRJTXEqgDz3dC
 BZrS/tdSrjVhWZws1HX570qP8UtZsQWJ79wdtvRULucaMhuU7ZhDXyr5jNT+A2569gzYyLSVf6/
 QaRG74Ija7hynfQ6XHwbt9uBrNtDiDU6Ox6JdBNHysKP5JrwdN+7lbOGmIYpnoF0wIS/59iqVBE
 QEYkXzRSyx+QWUNXCImfpXJKOLAYpXwwSjhpIDTgeKD87JW+fWvJMcq9kk57sgjIxaw1tGJAN2l
 e2/bQyV+cAvlwKyCij0yGHF8vjZAUjqUQgIkN+pctcvpuMA+UOKz72b5/wkj3pec9Bj+/c/dpWF
 +F5uJ+phQHV/wz4cQdxSSmV1iQw3k=
X-Google-Smtp-Source: AGHT+IHx1l8t/uOlVBUL45bt6MO6wfOe3CXRPGjbGY2pDPVF5MxAP9pa0cIKItQXqgXknSy/gICoiQ==
X-Received: by 2002:a05:6830:8485:b0:7c7:586e:8e76 with SMTP id
 46e09a7af769-7c78f4208e3mr715003a34.28.1763639965063; 
 Thu, 20 Nov 2025 03:59:25 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d428edfsm913265a34.31.2025.11.20.03.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 03:59:22 -0800 (PST)
Message-ID: <0699f702-d65b-4ab3-89ac-0c27b9330b6e@ventanamicro.com>
Date: Thu, 20 Nov 2025 08:59:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hw/riscv: define capabilities of CBQRI controllers
To: Drew Fustini <fustini@kernel.org>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>, =?UTF-8?Q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Atish Patra <atish.patra@linux.dev>, Vasudevan Srinivasan
 <vasu@rivosinc.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@ventanamicro.com>, yunhui cui <cuiyunhui@bytedance.com>,
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-2-3392fc760e48@kernel.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119-riscv-ssqosid-cbqri-v1-2-3392fc760e48@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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



On 11/19/25 9:42 PM, Drew Fustini wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> Define structs to represent the hardware capabilities of capacity and
> bandwidth controllers according to the RISC-V Capacity and Bandwidth QoS
> Register Interface (CBQRI).
> 
> Link: https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> [fustini: add fields introduced in the ratified spec: cunits, rpfx, p]
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   MAINTAINERS              |  7 ++++
>   include/hw/riscv/cbqri.h | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 96 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38325e0617c4..7afe80f1b17c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -357,6 +357,13 @@ F: target/riscv/XVentanaCondOps.decode
>   F: target/riscv/insn_trans/trans_xventanacondops.c.inc
>   F: disas/riscv-xventana*
>   
> +RISC-V QoS (Ssqosid ext and CBQRI spec)
> +M: Nicolas Pitre <npitre@baylibre.com>
> +M: Drew Fustini <fustini@kernel.org>
> +L: qemu-riscv@nongnu.org
> +S: Supported
> +F: include/hw/riscv/cbqri.h
> +
>   RENESAS RX CPUs
>   R: Yoshinori Sato <yoshinori.sato@nifty.com>
>   S: Orphan
> diff --git a/include/hw/riscv/cbqri.h b/include/hw/riscv/cbqri.h
> new file mode 100644
> index 000000000000..1b4c69779c0e
> --- /dev/null
> +++ b/include/hw/riscv/cbqri.h
> @@ -0,0 +1,89 @@
> +/*
> + * RISC-V Capacity and Bandwidth QoS Register Interface
> + * URL: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> + *
> + * Copyright (c) 2023 BayLibre SAS
> + * SPDX-License-Identifier: GPL-2.0-or-later
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
> +#ifndef HW_RISCV_CBQRI_H
> +#define HW_RISCV_CBQRI_H
> +
> +#include "qemu/typedefs.h"
> +
> +#define RISCV_CBQRI_VERSION_MAJOR   0
> +#define RISCV_CBQRI_VERSION_MINOR   1
> +
> +#define TYPE_RISCV_CBQRI_CC         "riscv.cbqri.capacity"
> +#define TYPE_RISCV_CBQRI_BC         "riscv.cbqri.bandwidth"
> +
> +/* Capacity Controller hardware capabilities */
> +typedef struct RiscvCbqriCapacityCaps {
> +    uint16_t nb_mcids;
> +    uint16_t nb_rcids;
> +
> +    uint16_t ncblks;
> +    bool cunits:1;
> +
> +    bool rpfx:1;
> +    uint8_t p;
> +
> +    bool supports_at_data:1;
> +    bool supports_at_code:1;
> +
> +    bool supports_alloc_op_config_limit:1;
> +    bool supports_alloc_op_read_limit:1;
> +    bool supports_alloc_op_flush_rcid:1;
> +
> +    bool supports_mon_op_config_event:1;
> +    bool supports_mon_op_read_counter:1;
> +
> +    bool supports_mon_evt_id_none:1;
> +    bool supports_mon_evt_id_occupancy:1;
> +} RiscvCbqriCapacityCaps;
> +
> +/* Bandwidth Controller hardware capabilities */
> +typedef struct RiscvCbqriBandwidthCaps {
> +    uint16_t nb_mcids;
> +    uint16_t nb_rcids;
> +
> +    uint16_t nbwblks;
> +    uint16_t mrbwb;
> +
> +    bool rpfx:1;
> +    uint8_t p;
> +
> +    bool supports_at_data:1;
> +    bool supports_at_code:1;
> +
> +    bool supports_alloc_op_config_limit:1;
> +    bool supports_alloc_op_read_limit:1;
> +
> +    bool supports_mon_op_config_event:1;
> +    bool supports_mon_op_read_counter:1;
> +
> +    bool supports_mon_evt_id_none:1;
> +    bool supports_mon_evt_id_rdwr_count:1;
> +    bool supports_mon_evt_id_rdonly_count:1;
> +    bool supports_mon_evt_id_wronly_count:1;
> +} RiscvCbqriBandwidthCaps;
> +
> +DeviceState *riscv_cbqri_cc_create(hwaddr addr,
> +                                   const RiscvCbqriCapacityCaps *caps,
> +                                   const char *target_name);
> +DeviceState *riscv_cbqri_bc_create(hwaddr addr,
> +                                   const RiscvCbqriBandwidthCaps *caps,
> +                                   const char *target_name);
> +#endif
> 


