Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D38C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWD37-0006vt-Bt; Mon, 30 Jun 2025 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD31-0006v6-NE
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:51:43 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uWD2w-00089Q-H0
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 07:51:43 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6ff16e97d1eso38819556d6.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1751284296; x=1751889096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IR9MOyileOpl61YR6TqsESXsTuFiW8XDLZj+AZisMqI=;
 b=TiPg/O5vYcPM0Zet46o8rzYbVXvwwgY6PVVvuh0Xt32Th66StRHLAlqzm0IUaSyYYq
 O0lLT48vqkysKvL9ti4vpdE/PZxH1fAyzxbPSPD6rc04xI3IClbz4W/Yge18klbTFB+d
 IwVFNV+BuZaunljEyUO4GBDrXln8lP8y2r55UkKdm0Rb8wI4Qz7cNwLVZJEMUV3QlM9R
 t5SAwhaOMH6M5zwfmzYPr8dEdJpIF57o/39ZIXP7l7WFUCVJ8VE/Y+kusQwJoBC+4zyT
 HzIjyr7B3C9SfL9w2idBDHxG35gU5i6WgSC9E7757Q27iAAaGYsthGq3D3/ZiJ7SqnVs
 q/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751284296; x=1751889096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IR9MOyileOpl61YR6TqsESXsTuFiW8XDLZj+AZisMqI=;
 b=WEwY7X+6hABBHE5Bt1rSYc+tEayUzUVpqcwDtdj24YguspU0JX6iLliR1IF08Flc23
 nryqkhvZtvVt3qQB409R8aejsHV26RIo8E1cx6v8Pta5sff87XGEnnU0ktEFUeUmO+1t
 ZGCTvv8/aLs1NVZld7L2AlOFpx9ayV5Jy2SQUdPNk6IrIvqSSsrWsNr9gDjjV+5cIkKW
 q4sDqc+CzZ2l+z4Ps7SyIKGIW4ZFipPxI7GPsn843n83pyxBrmwpFVgN1TKE3q1inhjT
 c3HLmRi/2dKFkodViVzG3/4I5lG/2kT+l0tUQlmz4nWUQ7l57jt7kTOHGGfPUA5wwImC
 +cZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdnhTkCoJLJRhkA9EeireqQw/oV2Q2d+VKFTxF2rY0IFRsz/6H8OULfiD34B4KxGf5mRR9CG79VsKB@nongnu.org
X-Gm-Message-State: AOJu0YwWt8AuKHn0UN0mRIlTLXQGD7j/QNWtDsk3dOi40uJi6g/5+7to
 uRVo1NAZ+gbKNw+22snjQmB73kHcLcGbzUsIiK6KEH2rZnWDkpm5IHTGpiUHUe0HQQIOdgeVRtH
 k7CqA
X-Gm-Gg: ASbGncsSAlSz3oiBr3shQEzOMnnKlpHQ/nD1FGHPIwtAssR3mClXS6unvT1kBjARbTh
 6Q7SX/EfsqUIiu6WnSF1t1l6sSIleWUEtFzjpHFoFZ9iMAXQX5qfh5h40utyNXvuU0i5F7vkDZH
 db9+0u5V/4QRZ/QBD/SCtuFYUqjoIAdeu7yvUj+mz3O6PnUPYG+G/W97PE9Mqmyyi1n8uWcu4+5
 6ZJ8w5+itKgMXT6hhsTakZBv/72/gOUJ4PF561sr4Ln5JUjqehy6mUVzLi8ezwhSzCamIuT+qrJ
 Y2aK0iuhw2cCw70iUh54fBlWcGrG8IepL6B4cwJSbpEp2RSsxJmaba/frtO5IKx4BV5Bkh+yRIe
 AJIYwpVDFTA==
X-Google-Smtp-Source: AGHT+IFr4/4o9fXy2YTDH4V6ebMhh2f109GC/7RRmNb+xpgwxqLG/uYQwc6W9jgmGMw/2ne1DmwVMA==
X-Received: by 2002:a05:6214:c26:b0:6fb:265:a2c3 with SMTP id
 6a1803df08f44-7009ec17fcbmr173967556d6.17.1751284295646; 
 Mon, 30 Jun 2025 04:51:35 -0700 (PDT)
Received: from [192.168.68.110] ([179.93.20.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd77324d5esm65728456d6.124.2025.06.30.04.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 04:51:34 -0700 (PDT)
Message-ID: <b0d9cef1-cd35-4568-ab9e-4c179f93cb1c@ventanamicro.com>
Date: Mon, 30 Jun 2025 08:51:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] target/riscv: Add MIPS P8700 CSRs
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
References: <20250625141732.59084-1-djordje.todorovic@htecgroup.com>
 <20250625141732.59084-5-djordje.todorovic@htecgroup.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250625141732.59084-5-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qv1-xf29.google.com
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



On 6/25/25 11:18 AM, Djordje Todorovic wrote:
> Define MIPS CSRs used for P8700 CPU.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.c       |   3 +
>   target/riscv/cpu.h       |   3 +
>   target/riscv/meson.build |   1 +
>   target/riscv/mips_csr.c  | 226 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 233 insertions(+)
>   create mode 100644 target/riscv/mips_csr.c
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 672e30378e..9a11a994c4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3180,6 +3180,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>           .cfg.ext_zbb = true,
>           .cfg.marchid = 0x8000000000000201,
>           .cfg.mvendorid = MIPS_VENDOR_ID,
> +#ifndef CONFIG_USER_ONLY
> +        .custom_csrs = mips_csr_list,
> +#endif
>       ),
>   
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fba0b0506b..ed10709a65 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -972,5 +972,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>   /* In th_csr.c */
>   extern const RISCVCSR th_csr_list[];
>   
> +/* Implemented in mips_csr.c */
> +extern const RISCVCSR mips_csr_list[];
> +
>   const char *priv_spec_to_str(int priv_version);
>   #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index a4bd61e52a..fbb6c8fb45 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -32,6 +32,7 @@ riscv_system_ss.add(files(
>     'debug.c',
>     'monitor.c',
>     'machine.c',
> +  'mips_csr.c',
>     'pmu.c',
>     'th_csr.c',
>     'time_helper.c',
> diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
> new file mode 100644
> index 0000000000..759d5e6a67
> --- /dev/null
> +++ b/target/riscv/mips_csr.c
> @@ -0,0 +1,226 @@
> +/*
> + * MIPS-specific CSRs.
> + *
> + * Copyright (c) 2025 MIPS
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
> +#include "cpu.h"
> +#include "cpu_vendorid.h"
> +
> +/* Static MIPS CSR state storage */
> +static struct {
> +    uint64_t tvec;
> +    uint64_t config[12];
> +    uint64_t pmacfg[16];  /* Fixed: was 15, should be 16 */
> +} mips_csr_state;
> +
> +/* MIPS CSR */
> +#define CSR_MIPSTVEC        0x7c0
> +#define CSR_MIPSCONFIG0     0x7d0
> +#define CSR_MIPSCONFIG1     0x7d1
> +#define CSR_MIPSCONFIG2     0x7d2
> +#define CSR_MIPSCONFIG3     0x7d3
> +#define CSR_MIPSCONFIG4     0x7d4
> +#define CSR_MIPSCONFIG5     0x7d5
> +#define CSR_MIPSCONFIG6     0x7d6
> +#define CSR_MIPSCONFIG7     0x7d7
> +#define CSR_MIPSCONFIG8     0x7d8
> +#define CSR_MIPSCONFIG9     0x7d9
> +#define CSR_MIPSCONFIG10    0x7da
> +#define CSR_MIPSCONFIG11    0x7db
> +#define CSR_MIPSPMACFG0     0x7e0
> +#define CSR_MIPSPMACFG1     0x7e1
> +#define CSR_MIPSPMACFG2     0x7e2
> +#define CSR_MIPSPMACFG3     0x7e3
> +#define CSR_MIPSPMACFG4     0x7e4
> +#define CSR_MIPSPMACFG5     0x7e5
> +#define CSR_MIPSPMACFG6     0x7e6
> +#define CSR_MIPSPMACFG7     0x7e7
> +#define CSR_MIPSPMACFG8     0x7e8
> +#define CSR_MIPSPMACFG9     0x7e9
> +#define CSR_MIPSPMACFG10    0x7ea
> +#define CSR_MIPSPMACFG11    0x7eb
> +#define CSR_MIPSPMACFG12    0x7ec
> +#define CSR_MIPSPMACFG13    0x7ed
> +#define CSR_MIPSPMACFG14    0x7ee
> +#define CSR_MIPSPMACFG15    0x7ef
> +
> +static RISCVException any(CPURISCVState *env, int csrno)
> +{
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
> +                                    target_ulong *val)
> +{
> +    *val = mips_csr_state.tvec;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
> +                                     target_ulong val, uintptr_t ra)
> +{
> +    mips_csr_state.tvec = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
> +{
> +    *val = mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
> +                                       target_ulong val, uintptr_t ra)
> +{
> +    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
> +                                      target_ulong *val)
> +{
> +    *val = mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
> +    return RISCV_EXCP_NONE;
> +}
> +
> +static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
> +                                       target_ulong val, uintptr_t ra)
> +{
> +    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] = val;
> +    return RISCV_EXCP_NONE;
> +}
> +
> +const RISCVCSR mips_csr_list[] = {
> +    {
> +        .csrno = CSR_MIPSTVEC,
> +        .csr_ops = { "mipstvec", any, read_mipstvec, write_mipstvec }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG0,
> +        .csr_ops = { "mipsconfig0", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG1,
> +        .csr_ops = { "mipsconfig1", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG2,
> +        .csr_ops = { "mipsconfig2", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG3,
> +        .csr_ops = { "mipsconfig3", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG4,
> +        .csr_ops = { "mipsconfig4", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG5,
> +        .csr_ops = { "mipsconfig5", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG6,
> +        .csr_ops = { "mipsconfig6", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG7,
> +        .csr_ops = { "mipsconfig7", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG8,
> +        .csr_ops = { "mipsconfig8", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG9,
> +        .csr_ops = { "mipsconfig9", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG10,
> +        .csr_ops = { "mipsconfig10", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSCONFIG11,
> +        .csr_ops = { "mipsconfig11", any, read_mipsconfig, write_mipsconfig }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG0,
> +        .csr_ops = { "mipspmacfg0", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG1,
> +        .csr_ops = { "mipspmacfg1", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG2,
> +        .csr_ops = { "mipspmacfg2", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG3,
> +        .csr_ops = { "mipspmacfg3", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG4,
> +        .csr_ops = { "mipspmacfg4", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG5,
> +        .csr_ops = { "mipspmacfg5", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG6,
> +        .csr_ops = { "mipspmacfg6", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG7,
> +        .csr_ops = { "mipspmacfg7", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG8,
> +        .csr_ops = { "mipspmacfg8", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG9,
> +        .csr_ops = { "mipspmacfg9", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG10,
> +        .csr_ops = { "mipspmacfg10", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG11,
> +        .csr_ops = { "mipspmacfg11", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG12,
> +        .csr_ops = { "mipspmacfg12", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG13,
> +        .csr_ops = { "mipspmacfg13", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG14,
> +        .csr_ops = { "mipspmacfg14", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    {
> +        .csrno = CSR_MIPSPMACFG15,
> +        .csr_ops = { "mipspmacfg15", any, read_mipspmacfg, write_mipspmacfg }
> +    },
> +    { },
> +};


