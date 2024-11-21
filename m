Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0E4D78799
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAYq-0000Mw-N5; Thu, 21 Nov 2024 12:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tEAY5-00088V-Rr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:01:01 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tEAY2-0000Jo-8Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:00:57 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2124ccf03edso11600735ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732208448; x=1732813248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYSrbz3A0mkLFtVvFWFnfQVYhODhz3n84ZtiAmX5puI=;
 b=IWY8InQEOPlk18SfBUPiYBBeV4ZNbM9W6m/EvKMheucKsbiiM0oix6hru3LbCzuZyv
 v7UknKV5lD8Bu73OFAPHU2HD1tuYfgyHdTtyvZmc2HrBSSjp8+P/r3ezfWG0z4sO8SBc
 2Hj8YtlMjAQ0qu6PicAuUKG3S7c2UbE1vad4o294EBeZRArNV6pNWS8K4KzWT/vr+SSb
 kg/+gRoRRZxqnsyCB4PzqNpqZKX8J8lYCe4YkexbhIFKBo16C525oTV7qx3scb0JXJAc
 5xEUKPMY8gvhshJmTKv0fVbhhg5mfzJCmHGBUzyBHlRL7SZGEI8J2VOTqDZtjjbYecBy
 kv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208448; x=1732813248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYSrbz3A0mkLFtVvFWFnfQVYhODhz3n84ZtiAmX5puI=;
 b=ow03ATM2lHQWjNaff6u/DL3dQpsGOuKo6LKb/5u0RT2vYKRO90jncXjFpxGEm8A7n6
 l5CvZ0lYPHKtpUXlpQsVFaT6XjQky1g+ZHgBisbII1u6QIOwMrkbPUaaQdSpbKxTrj66
 UV88ozpSLuRWsZAhdKEfnHIaGoikoNL95yHNPaNdsJlfsTVYyCPVESuZTVWI9m+67fIp
 LofuZZR5FJXZACk44QLp50VLT9cLHlif5WnXFMAf3iO86wKVebP8r6K3Hk9sT4zXIHMh
 DmEee9y2lzCmB4aeC1QL6U/vKSIm12H2lUvU+1HE/lxl6ASNLmRmzN1udgA30o3TR0yJ
 xx6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk8NiRBaLSTGwP65+yWF4abUVx4yhnIkLEwTRIsyH5yik5NzclFOrcGGcWxEvvAlJcjedxprwuuazY@nongnu.org
X-Gm-Message-State: AOJu0YwFTSfg1jDB5c/0VuHvlIq9FnjhGvFR/9IqESMH06+gjhFrwv04
 6OmI3HTscsifpz9WEf/J9sZlgR5tCMVFBtWygBb9NZGXdUwol/Nwq3p6jpWbeTI=
X-Gm-Gg: ASbGncu9T5+BizAXWCiOm/WVVyyJK3mwJrbC/yP1Ax51E4C8HdOBgLB1uoQD71M/R5A
 zmP4WH+U4EsvYgFgNcnme9RZepAjpmRmkQZj5znJGSgRSX2wE7uastra+/UsZqr3BufEtJKqMeQ
 hT42iiwjUrxY4aw4o742jwgSx4YNaPzCymHU+F9OwufrKepCkz6e3mJm17gMZaI3hjBKg8VCLTd
 4UPCGd8ooyHXybgMECfyuUwocTn5XBPj/KpgJT18h0hy4PpgCu1EiACFVN7O/I=
X-Google-Smtp-Source: AGHT+IFScoHz9mctHeWsu5y8cNzjZv3YGUkjK7SKV/536tlGBU+i7rDcaySv4JsXnZOwfY5upaP2Sw==
X-Received: by 2002:a17:903:188:b0:20b:fd73:32bb with SMTP id
 d9443c01a7336-2126a33ed85mr94439165ad.2.1732208445600; 
 Thu, 21 Nov 2024 09:00:45 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129db87e0asm582545ad.42.2024.11.21.09.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 09:00:45 -0800 (PST)
Message-ID: <45b666bc-abb9-4fa9-b29b-c48839a4e36c@ventanamicro.com>
Date: Thu, 21 Nov 2024 14:00:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 1/2] target/riscv: Add RISC-V CSR qtest support
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
References: <20241120072712.65302-1-ivan.klokov@syntacore.com>
 <20241120072712.65302-2-ivan.klokov@syntacore.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241120072712.65302-2-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 11/20/24 4:27 AM, Ivan Klokov wrote:
> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv_hart.c  | 55 ++++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/libqtest.c | 27 +++++++++++++++++++++
>   tests/qtest/libqtest.h | 14 +++++++++++
>   3 files changed, 96 insertions(+)
> 
> diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> index 613ea2aaa0..22cc8ae31f 100644
> --- a/hw/riscv/riscv_hart.c
> +++ b/hw/riscv/riscv_hart.c
> @@ -21,6 +21,8 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/module.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/qtest.h"
>   #include "sysemu/reset.h"
>   #include "hw/sysbus.h"
>   #include "target/riscv/cpu.h"
> @@ -42,6 +44,55 @@ static void riscv_harts_cpu_reset(void *opaque)
>       cpu_reset(CPU(cpu));
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(cpu_by_arch_id(cpu_num));
> +    CPURISCVState *env = &cpu->env;
> +
> +    int ret = RISCV_EXCP_NONE;
> +    if (strcmp(cmd, "get_csr") == 0) {
> +        ret = riscv_csrr(env, csrno, (target_ulong *)val);
> +    } else if (strcmp(cmd, "set_csr") == 0) {
> +        ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
> +                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
> +    }
> +
> +    g_assert(ret == RISCV_EXCP_NONE);
> +}
> +
> +static bool csr_qtest_callback(CharBackend *chr, gchar **words)
> +{
> +    if (strcmp(words[0], "csr") == 0) {
> +
> +        uint64_t cpu;
> +        uint64_t val;
> +        int rc, csr;
> +
> +        rc = qemu_strtou64(words[2], NULL, 0, &cpu);
> +        g_assert(rc == 0);
> +        rc = qemu_strtoi(words[3], NULL, 0, &csr);
> +        g_assert(rc == 0);
> +        rc = qemu_strtou64(words[4], NULL, 0, &val);
> +        g_assert(rc == 0);
> +        csr_call(words[1], cpu, csr, &val);
> +
> +        qtest_send_prefix(chr);
> +        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
> +
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void riscv_cpu_register_csr_qtest_callback(void)
> +{
> +    static GOnce once;
> +    g_once(&once, (GThreadFunc)qtest_set_command_cb, csr_qtest_callback);
> +}
> +#endif
> +
>   static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
>                                  char *cpu_type, Error **errp)
>   {
> @@ -59,6 +110,10 @@ static void riscv_harts_realize(DeviceState *dev, Error **errp)
>   
>       s->harts = g_new0(RISCVCPU, s->num_harts);
>   
> +#ifndef CONFIG_USER_ONLY
> +    riscv_cpu_register_csr_qtest_callback();
> +#endif
> +
>       for (n = 0; n < s->num_harts; n++) {
>           if (!riscv_hart_realize(s, n, s->cpu_type, errp)) {
>               return;
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 817fd7aac5..43bfa496e9 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1202,6 +1202,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>       return 0;
>   }
>   
> +static void qtest_rsp_csr(QTestState *s, uint64_t *val)
> +{
> +    gchar **args;
> +    uint64_t ret;
> +    int rc;
> +
> +    args = qtest_rsp_args(s, 3);
> +
> +    rc = qemu_strtou64(args[1], NULL, 16, &ret);
> +    g_assert(rc == 0);
> +    rc = qemu_strtou64(args[2], NULL, 16, val);
> +    g_assert(rc == 0);
> +
> +    g_strfreev(args);
> +}
> +
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         uint64_t *val)
> +{
> +    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
> +                    name, cpu, csr, *val);
> +
> +    qtest_rsp_csr(s, val);
> +    return 0;
> +}
> +
>   void qtest_add_func(const char *str, void (*fn)(void))
>   {
>       gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index beb96b18eb..b516a16bd4 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -575,6 +575,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>                            uint32_t nargs, uint64_t args,
>                            uint32_t nret, uint64_t ret);
>   
> +/**
> + * qtest_csr_call:
> + * @s: #QTestState instance to operate on.
> + * @name: name of the command to call.
> + * @cpu: hart number.
> + * @csr: CSR number.
> + * @val: Value for reading/writing.
> + *
> + * Call an RISC-V CSR read/write function
> + */
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         unsigned long *val);
> +
>   /**
>    * qtest_bufread:
>    * @s: #QTestState instance to operate on.


