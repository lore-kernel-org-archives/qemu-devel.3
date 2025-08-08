Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19462C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 17:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQt2-00083Z-UG; Fri, 08 Aug 2025 13:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQt1-00082p-KS
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:28:11 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQsz-0004Wz-PA
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 13:28:11 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-31f017262d9so2000793a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754674088; x=1755278888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bt0YmC+LVIpa/vI1OUxdKrDuHHBI/syGkJEznSRfivU=;
 b=C+yHwClObdJF2vKAJda3gbg2V9/XC15gZPFvCcWKvmz4x3wQ9MwnFWFYFA5ZGW0HZM
 KF1OYx413YCT8771rxanwGNfVGc6/g/ntOdTqvt8Gn21qCj7bMWCqiKlT9DJMNjpyDWs
 h0qD24dTHs/9YxJ61R7FA4bHSvK+liuLeV9g+fHAp80t+n/aRV02dW5me8nWi8+bvwU4
 FCKr2FXbpVs8TRu0R8hw9egFMCgOqXO3+gzFLRIMgKifTGWHJXJ7vevyWjPclZalNLhR
 P0GLNBxMt3TciBE6NxsOdWI8+3hRj6Y8B6vBPeCKHMmp0rDMLuO4SLLuPsR/S8VHME+H
 vcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754674088; x=1755278888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt0YmC+LVIpa/vI1OUxdKrDuHHBI/syGkJEznSRfivU=;
 b=BgbhcyeJQO7HU/um2OzEht1/DnuD4R6eEZQvD55vMioYyk17Xo8Kek8Y6VbOa/9lDu
 MUu1lPA5Fy/UTlULTJbVW1bflup10pkXa9OjXuTd6KxKiJTrjyO1BH0q9KfomVJ8+C7t
 P3iU3v+xvQO+M3JZnZfBpWZthVfDebODuhRHCnTDtQyuLws+FbMl7N+V6zh34XAGHLtn
 HAFaBMiqdQGwn9+uaFvxGgRiM8+bM1ZGezgEyWGTO8CdgLvSff4HTcaRgBiUcSPQVNtn
 y75DyS4GTDlTZiqT0m5ool+FoyVYOrljjhmuGFVtWr5I9XbLlWMqP3wPs3IrGHsTx9GY
 6F1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBOv50rbxoLqnqpg3hMHAo/v7MR4kjvI4y1TXt6YVDz2rWgccbDa0al+826vcaqEcXzBc0B4A7Bmiw@nongnu.org
X-Gm-Message-State: AOJu0Ywgx3MWk2eKFEzNMHneyBD0YIYMW+Z2vkasST+jBKg1zU0ySsJ3
 KkXj9NxU6tb08GQr6ODxP0DoK3pPOPXFkYPR8w260SLq5jBBXyDP2hweL91aZyEo27o=
X-Gm-Gg: ASbGncvykSJbIt7PQMRNKp0BhHZ1MuFb5wEDRuB8eGaEkJIitbMJTD1YEZPjSumzHYf
 +BmouGBZ3X9gUqnpmx58ncz0g+eVwYPpWok6MkUr4IPPk5ZBnVNTmPvkvXDwZbEwRQdaGutsKe1
 Us++gdDiJf++jXmhVuk0j59ccuHzH/7rFG7Vldz3YAxmGzUWYZF55ctPsVMUqPST1CLlHc1KBI3
 TbVb3qpejoJc4nfKyL4tU+5Kfv1Wq7zHpdShH9KU1v0EjI/y4Sgjm5qOgJze+Tu5JYG9yOMb1J2
 /JhZ5cxnFRjU/wFy0DCU6blFC6R3pKTRn/MFCbZuddSiVSz2MMOYJDtGKdmziIuHZ19XDMxeEcJ
 dZEOY6q9741Bl8gAW4+ShHyAbLNhuNDCgHo8=
X-Google-Smtp-Source: AGHT+IG7wxZVDQWd5oN++JVpq1muxlOEC7B9542LpFBDQjQZ4BcjOeDlbFMFwnU/gmoZppJLeB2r7g==
X-Received: by 2002:a17:90b:2685:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-321839d6666mr5942665a91.5.1754674087918; 
 Fri, 08 Aug 2025 10:28:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da6141sm25462613a91.1.2025.08.08.10.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 10:28:07 -0700 (PDT)
Message-ID: <b92e7af8-c15c-4fc7-ade8-603d30568202@linaro.org>
Date: Fri, 8 Aug 2025 10:28:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] contrib/plugins/uftrace: skeleton file
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-2-pierrick.bouvier@linaro.org>
 <t0o24e.37nl0tbfod6ih@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o24e.37nl0tbfod6ih@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/8/25 1:14 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We define a scoreboard that will hold our data per cpu. As well, we
>> define a buffer per cpu that will be used to read registers and memories
>> in a thread-safe way.
>>
>> For now, we just instrument all instructions with an empty callback.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c   | 74 +++++++++++++++++++++++++++++++++++++
>> contrib/plugins/meson.build |  3 +-
>> 2 files changed, 76 insertions(+), 1 deletion(-)
>> create mode 100644 contrib/plugins/uftrace.c
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> new file mode 100644
>> index 00000000000..d60c1077496
>> --- /dev/null
>> +++ b/contrib/plugins/uftrace.c
>> @@ -0,0 +1,74 @@
>> +/*
>> + * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> + *
>> + * Generates a trace compatible with uftrace (similar to uftrace record).
>> + * https://github.com/namhyung/uftrace
>> + *
>> + * See docs/about/emulation.rst|Uftrace for details and examples.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <qemu-plugin.h>
>> +#include <glib.h>
>> +
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>> +
>> +typedef struct Cpu {
>> +    GByteArray *buf;
>> +} Cpu;
>> +
>> +static struct qemu_plugin_scoreboard *score;
>> +
>> +static void track_callstack(unsigned int cpu_index, void *udata)
>> +{
>> +}
>> +
>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> +{
>> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
>> +
>> +    for (int i = 0; i < n_insns; i++) {
> 
> s/int i/size_t i/
> 
>> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> 
> This can return NULL,
> 
>> +
>> +        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
> 
> And this would lead to a NULL dereference (it performs insn->vaddr
> access)
> 
>> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
>> +                QEMU_PLUGIN_CB_R_REGS,
>> +                (void *) pc);
> 
> Hm indentation got broken here, should be
> 
> 
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
> +                                               QEMU_PLUGIN_CB_R_REGS,
> +                                               (void *)pc);
> 
>> +
>> +    }
>> +}
>> +
>> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>> +{
>> +    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>> +    cpu->buf = g_byte_array_new();
>> +}
>> +
>> +static void vcpu_end(unsigned int vcpu_index)
>> +{
>> +    Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>> +    g_byte_array_free(cpu->buf, true);
>> +    memset(cpu, 0, sizeof(Cpu));
> 
> Nitpick, cpu->buf = NULL; is easier to understand (suggestion)
>

Looking at this twice, it does not scale with other commits, which will 
free other members. That's why there was a memset in the first place.
Sorry, I rebuilt intermediate commits by reverting various parts, so it 
may result in suck quirks.

>> +}
>> +
>> +static void at_exit(qemu_plugin_id_t id, void *data)
>> +{
>> +    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>> +        vcpu_end(i);
>> +    }
>> +
>> +    qemu_plugin_scoreboard_free(score);
>> +}
>> +
>> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>> +                                           const qemu_info_t *info,
>> +                                           int argc, char **argv)
>> +{
>> +    score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> +    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>> +
>> +    return 0;
>> +}
>> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
>> index 1876bc78438..7eb3629c95d 100644
>> --- a/contrib/plugins/meson.build
>> +++ b/contrib/plugins/meson.build
>> @@ -1,5 +1,6 @@
>> contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
>> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']
>> +                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
>> +                   'uftrace']
>> if host_os != 'windows'
>>    # lockstep uses socket.h
>>    contrib_plugins += 'lockstep'
>> -- 
>> 2.47.2
>>
> 
> If no other comments rise for this patch, you can add my r-b after
> fixing the NULL check:
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


