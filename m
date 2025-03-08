Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D93C28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 01:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqjEI-0006Xp-0t; Fri, 07 Mar 2025 20:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqjEB-0006XW-Be
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:43:47 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tqjE9-0001w9-Fv
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 20:43:47 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-474f0c1e1c6so27957551cf.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 17:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741398224; x=1742003024; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xhz6WZ9FCufB9jRauNiHNRx4XVeOsfnEVae5XzfVdFo=;
 b=fZnL3IESCE+AO6lZyeG/sC24+j0VnTzz99HxFW19rxU6bU5Ga97NXVnwVEJfBkW3z4
 jZ18pdmJACfPcjjE49XT/E4tm/L0PglFX6tr/b8t4K2GyL6eFR+X6f0Eg0Z9N12rD/zC
 yawW3HxL40uub9kJgyswZY1TxJCJzdfQDhT5vrxR6xcuhQDtgEzR854l5UpgzFvVLaDl
 Fa79gzNwHEWr8RtG7y2hKm/+lunUHh1k3pRZqPCxldJl6JK/A2Aqy2Un7UGJrr2uewrQ
 WLbvVzV2pwgQrBARuat9x6bAFdDtjxZSa68Zp+I9TW8F1lnGw8A6EZF4P5/CiAU1C43b
 Qklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741398224; x=1742003024;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhz6WZ9FCufB9jRauNiHNRx4XVeOsfnEVae5XzfVdFo=;
 b=BEQiUFGQTFdHGeH2Yw7Ciy+wCvapqFc+SmKTF6RDV4sSCGnGT9dMulNt8nHyXMntSZ
 g74XyQ4MOv2EfUO6PSknxMbuaDADVrTJHidMF4jnw12MWsEB54YJvfSMNzYbSdOsbDaF
 SmBlQPHBLrHZ298Mab8V4tuh0pfYrmt5v6L0JHfQESQk6GO5yvi3TTHOtXKXJdKFX3We
 dnHrcf6Eyr7u1fU62wC/9xTH72v9jE8JFB9Ibj7+uNEDC6OA/SXEXZbOaAEtglJqg7rQ
 2g5u8UvhFPVXDdEIgmadrjcdBx3TWb+gekp/lcUWQNxWXzKpJIv64JSKrRrOBfZ3LMWT
 mpkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTtmvIYRLG4TIri0bDBeG5vDMBeXiEZ6QCjWUWAKp+Enbkeq5o93UNnhrTYm3XPxKmvPLaDKvefZcO@nongnu.org
X-Gm-Message-State: AOJu0YwNuUTJZOKBqnniKIqsWvoVWOi6MAakp9yQx/Usv1P9fvZZ3vVt
 OIWh0NeGe4wSv0EhcY7zuZ0DHOkMxhdmAyHuRQOGPIEOZd5+n10a
X-Gm-Gg: ASbGncuE/xsOK00NqP/NkxfENPo5y/RaQC4p5dXOjXATaDJdYQBGB/UIr+SDDBk6pln
 nif27oZOEWU4eY1SceKbX1/AZHgZWPGgz64brMJt1jzOgsb5XgyKQtT6Vzu7zFr1VShZa7vp/9e
 xFQhQQvHWrNA79YBVUUu5d29a+fYBcBnbu3RrlrcUA6jCXB+PpCHzdV6hAGhSia62gyFU0p8mC1
 hz7HS5f1PvOP/GeTPBnXZDoXzh4gxg8XHZ0XWeMuJ/hyClIWPBWey+ed7BClnqhhOW17DMREmEo
 IchxbvJTSROYQ8c/O//a/yZ56OTqPvTyYSczfGr8UKiFIJSGFQz4dhpogQ6IGHjrtD7PaiIngQ=
 =
X-Google-Smtp-Source: AGHT+IFfj5X+23f+CCzRBRbWb1MBU1B0jBiedWjf1jk4VPNeSUcNoGfYB7s1xEpdrI3OXLMftWiXfw==
X-Received: by 2002:a05:622a:1993:b0:475:1712:2a78 with SMTP id
 d75a77b69052e-476109501f3mr83943021cf.11.1741398223939; 
 Fri, 07 Mar 2025 17:43:43 -0800 (PST)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:8188:4e08:c1e3:fcd4])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4751d96b98csm26919611cf.24.2025.03.07.17.43.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Mar 2025 17:43:42 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-23-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-23-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 22/38] target/hexagon: Add sysemu TCG overrides
Date: Fri, 7 Mar 2025 19:43:41 -0600
Message-ID: <030901db8fcb$8611d410$92357c30$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgGO+dj5tPBdInA=
X-Antivirus: Norton (VPS 250307-8, 3/7/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x832.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 22/38] target/hexagon: Add sysemu TCG overrides
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Define TCG overrides for setprio(), crswap(,sgp{0,1,1:0}).
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h  | 32 ++++++++++++++++++++++++++++
> target/hexagon/gen_tcg_sys.h | 41
> ++++++++++++++++++++++++++++++++++++
>  target/hexagon/helper.h      |  1 +
>  target/hexagon/cpu_helper.c  | 36 +++++++++++++++++++++++++++++++
>  target/hexagon/genptr.c      |  4 ++++
>  target/hexagon/op_helper.c   |  7 ++++++
>  target/hexagon/hex_common.py |  2 ++
>  target/hexagon/meson.build   | 14 ++++++------
>  8 files changed, 131 insertions(+), 6 deletions(-)  create mode 100644
> target/hexagon/cpu_helper.h  create mode 100644
> target/hexagon/gen_tcg_sys.h  create mode 100644
> target/hexagon/cpu_helper.c
> 
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> new file mode 100644 index 0000000000..194bcbf451
> --- /dev/null
> +++ b/target/hexagon/cpu_helper.h
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#ifndef HEXAGON_CPU_HELPER_H
> +#define HEXAGON_CPU_HELPER_H
> +
> +static inline void arch_set_thread_reg(CPUHexagonState *env, uint32_t
> reg,
> +                                       uint32_t val) {
> +    g_assert(reg < TOTAL_PER_THREAD_REGS);
> +    g_assert_not_reached();
> +}
> +
> +static inline uint32_t arch_get_thread_reg(CPUHexagonState *env,
> +uint32_t reg) {
> +    g_assert(reg < TOTAL_PER_THREAD_REGS);
> +    g_assert_not_reached();
> +}
> +
> +static inline void arch_set_system_reg(CPUHexagonState *env, uint32_t
> reg,
> +                                       uint32_t val) {
> +    g_assert_not_reached();
> +}
> +
> +uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);
> +
> +#endif
> +
> diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
> new file mode 100644 index 0000000000..362703ab45
> --- /dev/null
> +++ b/target/hexagon/gen_tcg_sys.h
> @@ -0,0 +1,41 @@
> +/*
> + * Copyright(c) 2022-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#ifndef HEXAGON_GEN_TCG_SYS_H
> +#define HEXAGON_GEN_TCG_SYS_H
> +
> +#define fGEN_TCG_Y2_setprio(SHORTCODE) \
> +    gen_helper_setprio(tcg_env, PtV, RsV)
> +
> +#define fGEN_TCG_Y2_crswap0(SHORTCODE) \
> +    do { \
> +        TCGv tmp = tcg_temp_new(); \
> +        tcg_gen_mov_tl(tmp, RxV); \
> +        tcg_gen_mov_tl(RxV, hex_t_sreg[HEX_SREG_SGP0]); \
> +        tcg_gen_mov_tl(ctx->t_sreg_new_value[HEX_SREG_SGP0], tmp); \
> +    } while (0)
> +
> +#define fGEN_TCG_Y4_crswap1(SHORTCODE) \
> +    do { \
> +        TCGv tmp = tcg_temp_new(); \
> +        tcg_gen_mov_tl(tmp, RxV); \
> +        tcg_gen_mov_tl(RxV, hex_t_sreg[HEX_SREG_SGP1]); \
> +        tcg_gen_mov_tl(ctx->t_sreg_new_value[HEX_SREG_SGP1], tmp); \
> +    } while (0)
> +
> +#define fGEN_TCG_Y4_crswap10(SHORTCODE) \
> +    do { \
> +        g_assert_not_reached(); \
> +        TCGv_i64 tmp = tcg_temp_new_i64(); \
> +        tcg_gen_mov_i64(tmp, RxxV); \
> +        tcg_gen_concat_i32_i64(RxxV, \
> +                               hex_t_sreg[HEX_SREG_SGP0], \
> +                               hex_t_sreg[HEX_SREG_SGP1]); \
> +        tcg_gen_extrl_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP0],
> tmp); \
> +        tcg_gen_extrh_i64_i32(ctx->t_sreg_new_value[HEX_SREG_SGP1],
> tmp); \
> +    } while (0)
> +
> +#endif
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h index
> fddbd99a19..146f4f02e4 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -115,4 +115,5 @@ DEF_HELPER_2(greg_read, i32, env, i32)
> DEF_HELPER_2(greg_read_pair, i64, env, i32)  DEF_HELPER_3(sreg_write,
> void, env, i32, i32)  DEF_HELPER_3(sreg_write_pair, void, env, i32, i64)
> +DEF_HELPER_3(setprio, void, env, i32, i32)
>  #endif
> diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
> new file mode 100644 index 0000000000..6e4bc85580
> --- /dev/null
> +++ b/target/hexagon/cpu_helper.c
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright(c) 2019-2025 Qualcomm Innovation Center, Inc. All Rights
> Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later  */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "cpu_helper.h"
> +#include "system/cpus.h"
> +#ifdef CONFIG_USER_ONLY
> +#include "qemu.h"
> +#include "exec/helper-proto.h"
> +#else
> +#include "hw/boards.h"
> +#include "hw/hexagon/hexagon.h"
> +#endif
> +#include "exec/exec-all.h"
> +#include "exec/cpu_ldst.h"
> +#include "qemu/log.h"
> +#include "tcg/tcg-op.h"
> +#include "internal.h"
> +#include "macros.h"
> +#include "sys_macros.h"
> +#include "arch.h"
> +
> +
> +#ifndef CONFIG_USER_ONLY
> +
> +uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg) {
> +    g_assert_not_reached();
> +}

This should be a static inline in cpu_helper.h.
That means you could postpone the introduction of this new file.

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



