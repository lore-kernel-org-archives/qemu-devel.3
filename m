Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DC9E909D3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsO82-0004xD-0X; Tue, 17 Feb 2026 11:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsO80-0004wq-2y
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:40:48 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsO7t-0001q1-Mh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:40:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48375f10628so26237345e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771346438; x=1771951238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xBwGzdx8UveVGuUellThV6Gc7NaEzPH6oVnBSGn6uUo=;
 b=UHK+DdI8t4fbNm910QZa83lGPgcNtPgZGbWijFltNwvjV1X9NuTmSo0CqvNCTXveVX
 oGfKsmvCql3O+rJt9TN+CmwOzrg7loMqe1xQQHYENBZhq3D5v0mt3LQofEbjof0uqpsS
 ZWxT1/3Fj6QaDwSnlFbFTP9NtQxFrOqOdgbbuQukVv2mOSMWmU9Y64U3PzPpHFz83/Px
 RF+g4r+utpdlzcfPFrJYLCmrfOsI3ZpVanZpqDMM3fTplEmgIEMZ0QOuFjTnS/1MKWRp
 F1r9OvQH5s24gyaUmHG5SuPtYhM8kjpgu77RFGf93RpDEb7MOJYqQml7vSjLoDWk3w33
 u0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771346438; x=1771951238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBwGzdx8UveVGuUellThV6Gc7NaEzPH6oVnBSGn6uUo=;
 b=pvWvKuXNYt1JutfdaP1BC28TqF6jdVAkHhZJFWqxTsA57nDOZErFsDVomPJ/8xOHyk
 ptFAKDAVB2x5Krpk2hEDFKfcLQHxfBvTW86ybBoFFtocqVuLxJoYt4yL/2RMK/KZE0AP
 YC7jP6GvkNvctu73hluYpPem/w7u+XIybyw4fOFcqUmabBImg2XxudVxlLHU+O7ryKYD
 gTEIzNoqGha0rnKYkuJU1j7/BtH109wlS/dJ7e9rcESgQOsgJw7CcMMinHKqAY0eG52m
 XPSapKOz+DaxOYUEl7nTEZtPrhtCBencrliyLBYfSzErpYR6wxuGnkS8MiieiyRtf/1d
 NkNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXddgCCqhldpTRxAHTPs9b/xSmIDTrhojU/J1Tf+dt+fb4Thr5gxXfUqFJZ1RZHwlE81FDy3NJG54xN@nongnu.org
X-Gm-Message-State: AOJu0YxrhfMtBTnY/r1yx0ekNqkWrjHf33qxhGFtXbnkeX+OWp/qiuYH
 MdMnzUzbDQ2jVqCuXkgBC3JSmtUCPSJgR1BL2LY5/xsltIUkbwWOg6q8bLHcqU1xgFY=
X-Gm-Gg: AZuq6aJSKwyNqf6ZqZh3neiQXGeUvQJlEfnMMxaVOz0zPRnieX0EzWfa6mMHgBrW/9T
 Wse0pGwAjw8DASr6vt/GPGlmyIT1RdteHiBOYpjux7BjsbpcQRnPv4F8ebqTDvmZrTxpWD8BU86
 GribVmal+86mjc3aLXrYCq+2vEIIf8cMz1jeOO1voj9cBdsP2eM7hriqfwYySGomnqHp2R0JhaI
 BBuDX154YJcigc89m0QZ6fQ7PhgDapndHWiTGVhV+DshTRvieKpkgw1u5uM5qCg4ege2Vv7xvC4
 ykH/IG06uY7BamWOjGH6mUX4hzE17Pr+hdRsvDSL7qI8b7njRmuPk0/Bt8yHVXZt1SNV+nmQaFB
 CfOPzA6vGD0bF2+dm+8Vmq4ytw93JVu8vpQRMuAfI1gDHRsLLTK8cBtLQ3pv9ZZzQMjQxYbFcXc
 sYEb2falrLZ+Wn9bAmX2yPFXVT/+9hKUsi00NxXAExtQ2Hk1BkDQYyL5PX3OXyaYp5FiqLBEqK3
 Rsd
X-Received: by 2002:a05:600c:8b32:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-483739fc64fmr253310795e9.7.1771346438087; 
 Tue, 17 Feb 2026 08:40:38 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a36443sm111657725e9.21.2026.02.17.08.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 08:40:37 -0800 (PST)
Message-ID: <6807fb4b-3913-481e-a56e-d96d7910cbd4@linaro.org>
Date: Tue, 17 Feb 2026 17:40:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Qemu-devel] [PULL 07/32] PPC: Add support for Apple gdb in
 gdbstub
Content-Language: en-US
To: qemu-ppc@nongnu.org, Alexander Graf <agraf@csgraf.de>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-ppc <qemu-ppc@nongnu.org>
References: <1403869944-31927-1-git-send-email-agraf@suse.de>
 <1403869944-31927-8-git-send-email-agraf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1403869944-31927-8-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

(old patch merged as commit b3cad3abf6df07db165091343b912c2a5de63c26)

On 27/6/14 13:51, Alexander Graf wrote:
> The Apple gdbstub protocol is different from the normal gdbstub protocol
> used on PowerPC. Add support for the different variant, so that we can use
> Apple's gdb to debug guest code.
> 
> Keep in mind that the switch is a compile time option. We can't detect
> during runtime whether a gdb connecting to us is an upstream gdb or an
> Apple gdb.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>   target-ppc/cpu-qom.h        |   2 +
>   target-ppc/gdbstub.c        | 137 ++++++++++++++++++++++++++++++++++++++++++++
>   target-ppc/translate_init.c |   8 +++
>   3 files changed, 147 insertions(+)
> 
> diff --git a/target-ppc/cpu-qom.h b/target-ppc/cpu-qom.h
> index 13c7031..f1f0a52 100644
> --- a/target-ppc/cpu-qom.h
> +++ b/target-ppc/cpu-qom.h
> @@ -119,7 +119,9 @@ void ppc_cpu_dump_statistics(CPUState *cpu, FILE *f,
>                                fprintf_function cpu_fprintf, int flags);
>   hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
>   int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
>   int ppc64_cpu_write_elf64_qemunote(WriteCoreDumpFunction f,
>                                      CPUState *cpu, void *opaque);
>   int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target-ppc/translate_init.c b/target-ppc/translate_init.c
> index 85581c9..594f7ac 100644
> --- a/target-ppc/translate_init.c
> +++ b/target-ppc/translate_init.c
> @@ -34,6 +34,7 @@
>   //#define PPC_DUMP_CPU
>   //#define PPC_DEBUG_SPR
>   //#define PPC_DUMP_SPR_ACCESSES
> +/* #define USE_APPLE_GDB */

Effectively dead code :|

>   
>   /* For user-mode emulation, we don't emulate any IRQ controller */
>   #if defined(CONFIG_USER_ONLY)
> @@ -9667,6 +9668,13 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>   #endif
>   
>       cc->gdb_num_core_regs = 71;
> +
> +#ifdef USE_APPLE_GDB
> +    cc->gdb_read_register = ppc_cpu_gdb_read_register_apple;
> +    cc->gdb_write_register = ppc_cpu_gdb_write_register_apple;
> +    cc->gdb_num_core_regs = 71 + 32;
> +#endif
> +
>   #if defined(TARGET_PPC64)
>       cc->gdb_core_xml_file = "power64-core.xml";
>   #else
> diff --git a/target-ppc/gdbstub.c b/target-ppc/gdbstub.c
> index 381a3c7..694d303 100644
> --- a/target-ppc/gdbstub.c
> +++ b/target-ppc/gdbstub.c
> @@ -21,6 +21,31 @@
>   #include "qemu-common.h"
>   #include "exec/gdbstub.h"
>   
> +static int ppc_gdb_register_len_apple(int n)
> +{
> +    switch (n) {
> +    case 0 ... 31:
> +        /* gprs */
> +        return 8;
> +    case 32 ... 63:
> +        /* fprs */
> +        return 8;
> +    case 64 ... 95:
> +        return 16;
> +    case 64+32: /* nip */
> +    case 65+32: /* msr */
> +    case 67+32: /* lr */
> +    case 68+32: /* ctr */
> +    case 69+32: /* xer */
> +    case 70+32: /* fpscr */
> +        return 8;
> +    case 66+32: /* cr */
> +        return 4;
> +    default:
> +        return 0;
> +    }
> +}
> +
>   static int ppc_gdb_register_len(int n)
>   {
>       switch (n) {
> @@ -132,6 +157,65 @@ int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>       return r;
>   }
>   
> +int ppc_cpu_gdb_read_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    int r = ppc_gdb_register_len_apple(n);
> +
> +    if (!r) {
> +        return r;
> +    }
> +
> +    if (n < 32) {
> +        /* gprs */
> +        gdb_get_reg64(mem_buf, env->gpr[n]);
> +    } else if (n < 64) {
> +        /* fprs */
> +        stfq_p(mem_buf, env->fpr[n-32]);
> +    } else if (n < 96) {
> +        /* Altivec */
> +        stq_p(mem_buf, n - 64);
> +        stq_p(mem_buf + 8, 0);
> +    } else {
> +        switch (n) {
> +        case 64 + 32:
> +            gdb_get_reg64(mem_buf, env->nip);
> +            break;
> +        case 65 + 32:
> +            gdb_get_reg64(mem_buf, env->msr);
> +            break;
> +        case 66 + 32:
> +            {
> +                uint32_t cr = 0;
> +                int i;
> +                for (i = 0; i < 8; i++) {
> +                    cr |= env->crf[i] << (32 - ((i + 1) * 4));
> +                }
> +                gdb_get_reg32(mem_buf, cr);
> +                break;
> +            }
> +        case 67 + 32:
> +            gdb_get_reg64(mem_buf, env->lr);
> +            break;
> +        case 68 + 32:
> +            gdb_get_reg64(mem_buf, env->ctr);
> +            break;
> +        case 69 + 32:
> +            gdb_get_reg64(mem_buf, env->xer);
> +            break;
> +        case 70 + 32:
> +            gdb_get_reg64(mem_buf, env->fpscr);
> +            break;
> +        }
> +    }
> +    if (msr_le) {
> +        /* If cpu is in LE mode, convert memory contents to LE. */
> +        ppc_gdb_swap_register(mem_buf, n, r);
> +    }
> +    return r;
> +}
> +
>   int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       PowerPCCPU *cpu = POWERPC_CPU(cs);
> @@ -185,3 +269,56 @@ int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       }
>       return r;
>   }
> +int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    int r = ppc_gdb_register_len_apple(n);
> +
> +    if (!r) {
> +        return r;
> +    }
> +    if (msr_le) {
> +        /* If cpu is in LE mode, convert memory contents to LE. */
> +        ppc_gdb_swap_register(mem_buf, n, r);
> +    }
> +    if (n < 32) {
> +        /* gprs */
> +        env->gpr[n] = ldq_p(mem_buf);
> +    } else if (n < 64) {
> +        /* fprs */
> +        env->fpr[n-32] = ldfq_p(mem_buf);
> +    } else {
> +        switch (n) {
> +        case 64 + 32:
> +            env->nip = ldq_p(mem_buf);
> +            break;
> +        case 65 + 32:
> +            ppc_store_msr(env, ldq_p(mem_buf));
> +            break;
> +        case 66 + 32:
> +            {
> +                uint32_t cr = ldl_p(mem_buf);
> +                int i;
> +                for (i = 0; i < 8; i++) {
> +                    env->crf[i] = (cr >> (32 - ((i + 1) * 4))) & 0xF;
> +                }
> +                break;
> +            }
> +        case 67 + 32:
> +            env->lr = ldq_p(mem_buf);
> +            break;
> +        case 68 + 32:
> +            env->ctr = ldq_p(mem_buf);
> +            break;
> +        case 69 + 32:
> +            env->xer = ldq_p(mem_buf);
> +            break;
> +        case 70 + 32:
> +            /* fpscr */
> +            store_fpscr(env, ldq_p(mem_buf), 0xffffffff);
> +            break;
> +        }
> +    }
> +    return r;
> +}

