Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBBEC3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 00:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEdSe-0008EX-HF; Mon, 12 May 2025 20:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEdSc-0008EH-O9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:25:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEdSa-0003Dz-Nk
 for qemu-devel@nongnu.org; Mon, 12 May 2025 20:25:30 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b239763eeddso3158384a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747095926; x=1747700726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=alnSTY1IP8VPrlw0VN3FMRTgS+Ijz3Rk+FY2NcG6Iaw=;
 b=UvPwRsA/lZYUb8nOj9/0fggM9KdxnmSmJ/hEMpY31Us8TAvJGZEz6qunkLAOxL2i93
 Als4NL7cxnNRvmUPx9b7nA43SnOap1vd/KuGCd4D/yQR7M1P8lyXSMnBj7PEwVngLXWG
 wiiPjzMi1nN5NRcsI4AJdMR7KfUR2T886Z/aNxzIdFx5kQX7RaC8mdZetUg7xnL/U4Oh
 fTLkbUyiQkdhRp92HvfDSUf1mO81Fb8Ky+bz+XuvlKZbCMYGrwy5AWxvdlH/JE5NTBY2
 Za5IcqlbAghZumwUYt+OYjJpMvbAA79n+h6fAB7Xwz5UdVHLr15DvlS3tH/2CpYoQy2G
 95Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747095926; x=1747700726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=alnSTY1IP8VPrlw0VN3FMRTgS+Ijz3Rk+FY2NcG6Iaw=;
 b=rHqBCwNmL3QWO/6E+6GJfukBemXpJ4ApTYaYIDh3jA+wvmjjB58Zi2OLHpYpFM8SMo
 jl2TVEsDmr9cw/vVRwepcX++gFyZEx2ffgKXeMB9d2maIGxaxs7bmOWcvLz8MkJQaHaY
 lg/W3V15zLP6FMAnjGu8PMWvzan2yKs91EbyA6YIpLneAqqSzmWz+NMzR8r1wGUiWW4f
 kViWZ0rTijiGYhiX27YsRI2moQJ3gR8hmrvQWY2TBpB9l/DD6Pu4DcQm9BTx7jqQVXrP
 mKUyI0ckK+CN5AbFI6nyIceSdIOSfW6oteFoyuzT3XOIWtfPJ1QUUbEoqmwbsyQXJvtG
 sKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMqWOWKWE1NQoveuC4U9AsYQj0EDA8F0snfzOiHoQ8RiEUk4rykfeAg+8jjhalOJjAzinUKVZvcpsB@nongnu.org
X-Gm-Message-State: AOJu0YxEq9ULyljY8unvVYO8AHVKCAwl0iwMUuME9rHS+NujbfRceII4
 XY6IJJeB/YIgYNOCSYA6vXNMmtiuFo8AG593gVs/+oyTNwGXc0NkIUn3ALuf5sY=
X-Gm-Gg: ASbGncufwSxxTlKassb8dqjE9064+f37N/sUurBTTsTfxvgpNS9XECzkP/usxSoKETB
 pFnMbLqwWgnPpbEGGWAFhvVHy4Q8zai+4tLXa9h0jsZn4LtwmZtSxnSNPBHFsCVbhSNE2xax1N3
 WKzE2fggwreP0WB68JZ6SMtJcsd8PaF8TwKWzF8za3O4P3pYeGxSfwzOtknxq/D6d+ECHo31hUt
 YhMDhHnPMFVSJ9VjqdfSm0EVcI6HGP5Imfw7AB7a/OKfrwc50JYjgBu7+wOAQjEOm/KaNsCr+VU
 JeBBzvSl3UojrHd+9nOOcrnmYB0nmP8pqv5/ypZhzn8w4O2lF6CKBngGEAzhXB+K
X-Google-Smtp-Source: AGHT+IG/5i0lNs/TJHFN33mRH7K/O8cW5lmEkzfXsn2VKjNLEDmz9ibbmBCeHZ6JFP7AfU3z74kpag==
X-Received: by 2002:a17:903:3baf:b0:224:18bb:44c2 with SMTP id
 d9443c01a7336-22fc8b0faeamr175670745ad.6.1747095926269; 
 Mon, 12 May 2025 17:25:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc8290110sm69410805ad.198.2025.05.12.17.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 17:25:25 -0700 (PDT)
Message-ID: <53632928-0367-44cf-a93e-6ba14bb85458@linaro.org>
Date: Mon, 12 May 2025 17:25:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/23] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1746968215.git.neither@nut.email>
 <e212e53b98c264366458654493e2fa2e2cdecdcc.1746968215.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e212e53b98c264366458654493e2fa2e2cdecdcc.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 5/11/25 6:14 AM, Julian Ganz wrote:
> We recently introduced plugin API for the registration of callbacks for
> discontinuity events, specifically for interrupts, exceptions and host
> call events. The callback receives various bits of information,
> including the VCPU index and PCs.
> 
> This change introduces a test plugin asserting the correctness of that
> behaviour in cases where this is possible with reasonable effort. Since
> instruction PCs are recorded at translation blocks translation time and
> a TB may be used in multiple processes running in distinct virtual
> memory, the plugin allows comparing not full addresses but a subset of
> address bits via the `compare-addr-bits` option.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   tests/tcg/plugins/discons.c   | 219 ++++++++++++++++++++++++++++++++++
>   tests/tcg/plugins/meson.build |   2 +-
>   2 files changed, 220 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/plugins/discons.c
> 

[...]

> +static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                        enum qemu_plugin_discon_type type, uint64_t from_pc,
> +                        uint64_t to_pc)
> +{
> +    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
> +
> +    switch (type) {
> +    case QEMU_PLUGIN_DISCON_EXCEPTION:
> +        /*
> +         * For some types of exceptions, insn_exec will be called for the
> +         * instruction that caused the exception.
> +         */
> +        if (addr_eq(state->last_pc, from_pc)) {
> +            break;
> +        }
> +        __attribute__((fallthrough));

It's a bit hard to follow the codepath with the switch and the 
fallthrough. Maybe we can simply use an empty if for that.

if (type == QEMU_PLUGIN_DISCON_EXCEPTION &&
     addr_eq(state->last_pc, from_pc))
{
   /*
    * For some types of exceptions, insn_exec will be called for the
    * instruction that caused the exception, so we don't report this
    * case.
    */
} else if (state->has_next) {
   ...
} else if (state->has_from) {
   ...
}

...
set state
...

> +    default:
> +        if (state->has_next) {
> +            /*
> +             * We may encounter discontinuity chains without any instructions
> +             * being executed in between.
> +             */
> +            report_mismatch("source", vcpu_index, type, state->last_pc,
> +                            state->next_pc, from_pc);
> +        } else if (state->has_from) {
> +            report_mismatch("source", vcpu_index, type, state->last_pc,
> +                            state->from_pc, from_pc);
> +        }
> +    }
> +
> +    state->has_from = false;
> +
> +    state->next_pc = to_pc;
> +    state->next_type = type;
> +    state->has_next = true;
> +}
> +
> +static void insn_exec(unsigned int vcpu_index, void *userdata)
> +{
> +    struct cpu_state *state = qemu_plugin_scoreboard_find(states, vcpu_index);
> +    struct insn_data* insn = (struct insn_data *) userdata;
> +
> +    state->last_pc = insn->addr;
> +    state->has_last = true;
> +
> +    if (insn->next_valid) {
> +        state->from_pc = insn->next_pc;
> +    }
> +    state->has_from = insn->next_valid;
> +
> +    if (state->has_next) {
> +        report_mismatch("target", vcpu_index, state->next_type, state->last_pc,
> +                        state->next_pc, insn->addr);
> +        state->has_next = false;
> +    }
> +
> +    if (trace_all_insns) {
> +        g_autoptr(GString) report = g_string_new(NULL);
> +        g_string_append_printf(report, "Exec insn at %"PRIx64" on VCPU %d\n",
> +                               insn->addr, vcpu_index);
> +        qemu_plugin_outs(report->str);
> +    }
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t i;
> +    size_t n_insns = qemu_plugin_tb_n_insns(tb);
> +    struct insn_data *udata = calloc(n_insns, sizeof(struct insn_data));
> +

With this, for every TB translated, we'll perform an allocation, and 
then lose track of the pointer. It's usually a pain to pass this kind of 
"dynamic" information through udata.

A more elegant solution is to perform a QEMU_PLUGIN_INLINE_STORE_U64 to 
store this information under a new cpu_state.current_insn field directly.
Callbacks are installed in the order you register them, so by storing 
information inline *before* the insn_exec callback, it will work as 
expected, as cpu_static.current_insn will be already updated.
You can find some other plugins which use this trick.

> +    for (i = 0; i < n_insns; i++) {

Feel free to declare i in the loop directly.

> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t pc = qemu_plugin_insn_vaddr(insn);
> +        udata[i].addr = pc;
> +        udata[i].next_pc = pc + qemu_plugin_insn_size(insn);
> +        udata[i].next_valid = true;
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
> +                                               QEMU_PLUGIN_CB_NO_REGS,
> +                                               &udata[i]);
> +    }
> +
> +    udata[n_insns - 1].next_valid = false;
> +}

[...]

Otherwise, the logic of the plugin is ok for me.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

