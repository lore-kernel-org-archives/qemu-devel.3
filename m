Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87258E7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 23:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIysC-00022b-Fe; Wed, 04 Dec 2024 18:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIysA-00022E-TE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:33:34 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIys9-0000c6-1W
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 18:33:34 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fc41b4c78bso223611a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 15:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733355211; x=1733960011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfQYykK2/THiTd+2WBnIxlbpfsCXeKVB3GOSBiaRysI=;
 b=YYQsZgpk+CHceRZsWKBVaybPH7CDuFTYV9w3LlTvjoZZPmZbj7dg1AzWBJY4hz1WAu
 ArNVMDI0RqDvzVAoEovIkX7AJKWrOe9nq3M40k8nIzINNEmXBbHRpEqxP2J+JtBnoSkw
 6z9P7E+C21CTG+2H/OUApkNTaNSyfKcpAV10fKpVzvyFIXqW/RMARhLCE0E5RWRNxRIR
 M+fswSkqEO5pIVHJ86Eo8OcfMJU1WzNA9LjPzIfoZm1VJdynUsiDe7ewPksy9nQQnnif
 Y4U0Qyi7yrE+FfZrgN3Qs9xMS4FZdeOot9yDOPH8cDmXgMDMqCbhoGFs/q5DOfeKOd0T
 hcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733355211; x=1733960011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfQYykK2/THiTd+2WBnIxlbpfsCXeKVB3GOSBiaRysI=;
 b=A6nxpxBLfDpay8r0KPONsAMQ7bVIGrshS9GbgWnAo1/+p5Hr76sPlkW987uGGporzj
 sSWnxa0BxjSHf1UHGJtUotEROBhB2UZPZE/ppLpg+4rp7/uw1B2lgJDEkMYWs4nP7dvj
 aHNcTrpslnd94sOr9tKvMrQHJwpy2lbsrc5SKptG5MypTsVpJjf4Rx5WdNRXY4xRfqxs
 QgRUlnVdQlAEr3QnD4LsmXexjzJSTHNKRZbZPWDp9RM7FPMj2r3Gl5HB7M7VNzOPKgNr
 /Ap/qFbX36pdMUc6i9zu6a1exUdERwfDhR97dhXy1pDQy2//pJeqaQYj9JhQtoxF9J9+
 /iUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVac9ktWhwggU7yYiR3eDLTU6KHH1g3oEQkwgegsOEbBnyAEp4AF0iEXBv/JtxQJTbDWg6984ZFcQ1M@nongnu.org
X-Gm-Message-State: AOJu0YwKMx1PZHWUQ0gHenuARdXMp2zZYlgGztprsVWSyXXfe8Zy54v9
 wCzR08k56o9xAxf4cXBlZObykS0Yh0TJiwUv6oPvh6Dkd+05zNUHbAaSPWj6hFY=
X-Gm-Gg: ASbGncuC7ZKAr2n1H8pL/uJp6iM8VdQyaXmfRaAQuep5R9mKmGc6ct1e1EluFgAtngV
 wrQ01dhBOASPwZOSbqS8pr/2ra+iQJguCFihhLMzFSqpUkx4m2LiQqedWXcK0W77RRLjdmL/dgo
 fwXcnuOfIDsWBAECLN9ZYjVI+nvOwvPQ8wEFH2MTMARMqef+cMCC5IWh2IRO69wAO8yKgADhVMD
 swaMJ9UA/LwBw1xdDHqSms9xdDvQb803lPoe/iIzc4EgQuPT0RDKeyhg93SHymYLnr97e/HPnrV
 fvzFlfThPcHDoB0nMd2gkA==
X-Google-Smtp-Source: AGHT+IG7Shs7V4WExL2UlKybwY34g8mBS9y9cnkdkanxnXYHEeZvGX6PQKQjA1Y+I6YGWUqoDdYdLw==
X-Received: by 2002:a17:90b:1b0a:b0:2ef:316b:53fe with SMTP id
 98e67ed59e1d1-2ef316b61f7mr3573766a91.22.1733355211512; 
 Wed, 04 Dec 2024 15:33:31 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef45fa31f0sm119231a91.23.2024.12.04.15.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 15:33:31 -0800 (PST)
Message-ID: <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
Date: Wed, 4 Dec 2024 15:33:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 12/2/24 11:41, Julian Ganz wrote:
> We recently introduced plugin API for the registration of callbacks for
> discontinuity events, specifically for interrupts, exceptions and host
> call events. The callback receives, among other information, the VCPU
> index and the PC after the event. This change introduces a test plugin
> asserting that particular behaviour.
> ---
>   tests/tcg/plugins/discons.c   | 95 +++++++++++++++++++++++++++++++++++
>   tests/tcg/plugins/meson.build |  2 +-
>   2 files changed, 96 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/plugins/discons.c
> 
> diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
> new file mode 100644
> index 0000000000..54e52f563a
> --- /dev/null
> +++ b/tests/tcg/plugins/discons.c
> @@ -0,0 +1,95 @@
> +/*
> + * Copyright (C) 2024, Julian Ganz <neither@nut.email>
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */

Would be nice to include a description of the plugin here.

> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +struct cpu_state {
> +    uint64_t next_pc;
> +    bool has_next;
> +};
> +
> +static struct qemu_plugin_scoreboard *states;
> +
> +static bool abort_on_mismatch;
> +
> +static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                        enum qemu_plugin_discon_type type, uint64_t from_pc,
> +                        uint64_t to_pc)
> +{
> +    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
> +    state->next_pc = to_pc;
> +    state->has_next = true;
> +}
> +
> +static void insn_exec(unsigned int vcpu_index, void *userdata)
> +{
> +    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
> +    uint64_t pc = (uint64_t) userdata;
> +    GString* report;
> +
> +    if (state->has_next) {
> +        if (state->next_pc != pc) {
> +            report = g_string_new("Trap target PC mismatch\n");
> +            g_string_append_printf(report,
> +                                   "Expected:    %"PRIx64"\nEncountered: %"
> +                                   PRIx64"\n",
> +                                   state->next_pc, pc);
> +            qemu_plugin_outs(report->str);
> +            if (abort_on_mismatch) {
> +                g_abort();
> +            }
> +            g_string_free(report, true);
> +        }
> +        state->has_next = false;
> +    }
> +}

When booting an arm64 vm, I get this message:
Trap target PC mismatch
Expected:    23faf3a80
Encountered: 23faf3a84

 From what I understand, it means that the next_pc we have is incorrect.

> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t i;
> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
> +
> +    for (i = 0; i < n_insns; i++) {
> +        struct qemu_plugin_insn * insn = qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t pc = qemu_plugin_insn_vaddr(insn);
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
> +                                               QEMU_PLUGIN_CB_NO_REGS,
> +                                               (void*) pc);
> +    }
 > +}> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    int i;
> +
> +    for (i = 0; i < argc; i++) {
> +        char *opt = argv[i];
> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> +        if (g_strcmp0(tokens[0], "abort") == 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &abort_on_mismatch)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
> +                return -1;
> +            }
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    states = qemu_plugin_scoreboard_new(sizeof(struct cpu_state));
> +
> +    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
> +                                        vcpu_discon);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index f847849b1b..f057238da1 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -1,6 +1,6 @@
>   t = []
>   if get_option('plugins')
> -  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
> +  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'syscall']
>       if host_os == 'windows'
>         t += shared_module(i, files(i + '.c') + '../../../contrib/plugins/win32_linker.c',
>                           include_directories: '../../../include/qemu',


