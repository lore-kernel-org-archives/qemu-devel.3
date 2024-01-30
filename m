Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE846C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 14:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpTE-0007PX-S2; Tue, 30 Jan 2024 09:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUpTC-0007PP-Cs
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:52:14 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUpT9-0006UI-2P
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 09:52:13 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e7065b692so43716315e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 06:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706626329; x=1707231129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOZ9Mi7SDU2h16lwqlsOcDlswIFI3eIvOwkPcyrfvX0=;
 b=AHlD3ksrLKlVfKe95RHlVyicaB8jqHZ7T2lC91g0GtdrcAnK6epl/Kk4ChT+wIx4nq
 6VjAv/5cpZkS4xEQcTZBBRUVPv9yYxA8rS0VgShVIRWx2h0pmVXvuH60P4RHh5yZICs0
 Hcv5AcxevwXp9rNgFbY1Ha3xJCmzrpSQIghSCVrTJKxP8gsNG6NfnU9uBW3Se+WAfUbU
 WdpS2/DAASMP7KV6qttG9bxmMYt6M1Cz2/BG6FY/kqr+l14RNSf96G3+AM2TRThSqGOB
 3vbNsJq9EPm16mWIkI8WQXoRPP6e1hnl3hXmeZry0LrvIAVAGrCj4C2WiSWv+IV4eGZL
 G/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706626329; x=1707231129;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yOZ9Mi7SDU2h16lwqlsOcDlswIFI3eIvOwkPcyrfvX0=;
 b=K9duCPBIgA8/mzlTma64OV8/mFmnv2fblIeO22FP4ScYUQxTHOXiCplnQyvW8wvLMH
 MHVx83PBWx28SbFKxPf52pv3+Ug5DpGBDcG5G9Snb1rQwJSAeNmih/S9gnkpwhB37WNa
 btohw/bBTPbHUrKkgjLjO7usdcV0jxaRx0qbRXLaj2zuubDJsqBUwJKslYtYJtjlRqkw
 KlmOSh7IPF7s0jJGcLRfckLEpDSmEdG+2drpXtu+FQAKVqyMW/8RBUg5THuAvF2LAdNz
 W2douQkQnCZpWYmV3/5AHNO77ZWvyBTGhPVSsQLRp/EmziIQHzyKp+bGtlNI9slL0SEn
 V1Mg==
X-Gm-Message-State: AOJu0YytdB3nsR668Deu3te4AhZ3Ng52jmeTftl3fbHUbxqqMT54kFvE
 nlRseH5kl4Tor0OT0N1L7SsohuQ+wHTrKxQdVHH1CwN+/FLxVTMlBAvJfVcgEa8=
X-Google-Smtp-Source: AGHT+IEAR2zpUravpchuq5d5xFAeL+hMh26wasxw6RvSYQtJnvi+VvzP5DLe9FCt8bRj/yz6Sr7/Xg==
X-Received: by 2002:a05:600c:4745:b0:40e:3d82:2394 with SMTP id
 w5-20020a05600c474500b0040e3d822394mr8380655wmo.19.1706626328896; 
 Tue, 30 Jan 2024 06:52:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f18-20020a05600c4e9200b0040ec7f249dfsm13296029wmq.14.2024.01.30.06.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:52:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EE4F5F9D3;
 Tue, 30 Jan 2024 14:52:08 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 05/14] tests/plugin: add test plugin for inline
 operations
In-Reply-To: <cb6735d1-6e30-4ff4-87a9-fb0e548e61af@linaro.org> (Pierrick
 Bouvier's message of "Tue, 30 Jan 2024 11:49:40 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-6-pierrick.bouvier@linaro.org>
 <874jf0rsfz.fsf@draig.linaro.org>
 <cb6735d1-6e30-4ff4-87a9-fb0e548e61af@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 14:52:08 +0000
Message-ID: <87h6iuoovb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/26/24 20:05, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> For now, it simply performs instruction, bb and mem count, and ensure
>>> that inline vs callback versions have the same result. Later, we'll
>>> extend it when new inline operations are added.
>>>
>>> Use existing plugins to test everything works is a bit cumbersome, as
>>> different events are treated in different plugins. Thus, this new one.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   tests/plugin/inline.c    | 182 +++++++++++++++++++++++++++++++++++++++
>>>   tests/plugin/meson.build |   2 +-
>>>   2 files changed, 183 insertions(+), 1 deletion(-)
>>>   create mode 100644 tests/plugin/inline.c
>>>
>>> diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
>>> new file mode 100644
>>> index 00000000000..28d1c3b1e48
>>> --- /dev/null
>>> +++ b/tests/plugin/inline.c
>>> @@ -0,0 +1,182 @@
>>> +/*
>>> + * Copyright (C) 2023, Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> + *
>>> + * Demonstrates and tests usage of inline ops.
>>> + *
>>> + * License: GNU GPL, version 2 or later.
>>> + *   See the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#include <glib.h>
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +
>>> +#include <qemu-plugin.h>
>>> +
>>> +typedef struct {
>>> +    uint64_t count_tb;
>>> +    uint64_t count_tb_inline;
>>> +    uint64_t count_insn;
>>> +    uint64_t count_insn_inline;
>>> +    uint64_t count_mem;
>>> +    uint64_t count_mem_inline;
>>> +} CPUCount;
>> I wonder if there is any way to enforce the structures being an
>> array of
>> 64 bit counts? I do worry the compiler might want day decide to do
>> something silly but legal leading to confusion.
>> I guess qemu_plugin_scoreboard_new could:
>>    g_assert((element_size % sizeof(uint64_t)) =3D=3D 0)
>>=20
>
> Given explaination on patch [02/14], do you see more that CPUCount
> could hold any type, and qemu_plugin_u64 allows to target a specific
> member in it?
>
> In general, qemu plugin runtime simply is given an offset and total
> size of the struct, so a compiled plugin can have any
> optimization/padding on this struct without this affecting the result.
>
>> ?
>>=20
>>> +static qemu_plugin_u64_t count_tb;
>>> +static qemu_plugin_u64_t count_tb_inline;
>>> +static qemu_plugin_u64_t count_insn;
>>> +static qemu_plugin_u64_t count_insn_inline;
>>> +static qemu_plugin_u64_t count_mem;
>>> +static qemu_plugin_u64_t count_mem_inline;
>> Can't this just be a non scoreboard instance of CPUCount?
>>=20
>
> We could always use:
> CPUCount* count =3D qemu_plugin_scoreboard_get(score, i);
> count->count_tb++;

I thought these where globals protected by a lock? I wasn't suggesting
hiding the abstraction behind the scoreboard API.

>
> However, the part where we sum all values would now need some glue
> code, which is longer and more error prone than having those
> definition here (and declaration in install function).
>
>>> +
>>> +static uint64_t global_count_tb;
>>> +static uint64_t global_count_insn;
>>> +static uint64_t global_count_mem;
>>> +static unsigned int max_cpu_index;
>>> +static GMutex tb_lock;
>>> +static GMutex insn_lock;
>>> +static GMutex mem_lock;
>>> +
>>> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>>> +
>>> +static void stats_insn(void)
>>> +{
>>> +    const uint64_t expected =3D global_count_insn;
>>> +    const uint64_t per_vcpu =3D qemu_plugin_u64_sum(count_insn);
>>> +    const uint64_t inl_per_vcpu =3D
>>> +        qemu_plugin_u64_sum(count_insn_inline);
>>> +    printf("insn: %" PRIu64 "\n", expected);
>>> +    printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>> +    printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>>> +    g_assert(expected > 0);
>>> +    g_assert(per_vcpu =3D=3D expected);
>>> +    g_assert(inl_per_vcpu =3D=3D expected);
>>> +}
>>> +
>>> +static void stats_tb(void)
>>> +{
>>> +    const uint64_t expected =3D global_count_tb;
>>> +    const uint64_t per_vcpu =3D qemu_plugin_u64_sum(count_tb);
>>> +    const uint64_t inl_per_vcpu =3D
>>> +        qemu_plugin_u64_sum(count_tb_inline);
>>> +    printf("tb: %" PRIu64 "\n", expected);
>>> +    printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>> +    printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>>> +    g_assert(expected > 0);
>>> +    g_assert(per_vcpu =3D=3D expected);
>>> +    g_assert(inl_per_vcpu =3D=3D expected);
>>> +}
>>> +
>>> +static void stats_mem(void)
>>> +{
>>> +    const uint64_t expected =3D global_count_mem;
>>> +    const uint64_t per_vcpu =3D qemu_plugin_u64_sum(count_mem);
>>> +    const uint64_t inl_per_vcpu =3D
>>> +        qemu_plugin_u64_sum(count_mem_inline);
>>> +    printf("mem: %" PRIu64 "\n", expected);
>>> +    printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
>>> +    printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
>>> +    g_assert(expected > 0);
>>> +    g_assert(per_vcpu =3D=3D expected);
>>> +    g_assert(inl_per_vcpu =3D=3D expected);
>>> +}
>>> +
>>> +static void plugin_exit(qemu_plugin_id_t id, void *udata)
>>> +{
>>> +    const unsigned int num_cpus =3D qemu_plugin_scoreboard_size(counts=
);
>>> +    g_assert(num_cpus =3D=3D max_cpu_index + 1);
>>> +
>>> +    for (int i =3D 0; i < num_cpus ; ++i) {
>>> +        const uint64_t tb =3D *qemu_plugin_u64_get(count_tb, i);
>>> +        const uint64_t tb_inline =3D *qemu_plugin_u64_get(count_tb_inl=
ine, i);
>>> +        const uint64_t insn =3D *qemu_plugin_u64_get(count_insn, i);
>>> +        const uint64_t insn_inline =3D *qemu_plugin_u64_get(count_insn=
_inline, i);
>>> +        const uint64_t mem =3D *qemu_plugin_u64_get(count_mem, i);
>>> +        const uint64_t mem_inline =3D *qemu_plugin_u64_get(count_mem_i=
nline, i);
>>> +        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64 ") | "
>>> +               "insn (%" PRIu64 ", %" PRIu64 ") | "
>>> +               "mem (%" PRIu64 ", %" PRIu64 ")"
>>> +               "\n",
>>> +               i, tb, tb_inline, insn, insn_inline, mem, mem_inline);
>>> +        g_assert(tb =3D=3D tb_inline);
>>> +        g_assert(insn =3D=3D insn_inline);
>>> +        g_assert(mem =3D=3D mem_inline);
>>> +    }
>>> +
>>> +    stats_tb();
>>> +    stats_insn();
>>> +    stats_mem();
>>> +
>>> +    qemu_plugin_scoreboard_free(counts);
>>> +}
>>> +
>>> +static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
>>> +{
>>> +    (*qemu_plugin_u64_get(count_tb, cpu_index))++;
>>> +    g_mutex_lock(&tb_lock);
>>> +    max_cpu_index =3D MAX(max_cpu_index, cpu_index);
>>> +    global_count_tb++;
>>> +    g_mutex_unlock(&tb_lock);
>>> +}
>>> +
>>> +static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
>>> +{
>>> +    (*qemu_plugin_u64_get(count_insn, cpu_index))++;
>>> +    g_mutex_lock(&insn_lock);
>>> +    global_count_insn++;
>>> +    g_mutex_unlock(&insn_lock);
>>> +}
>>> +
>>> +static void vcpu_mem_access(unsigned int cpu_index,
>>> +                            qemu_plugin_meminfo_t info,
>>> +                            uint64_t vaddr,
>>> +                            void *userdata)
>>> +{
>>> +    (*qemu_plugin_u64_get(count_mem, cpu_index))++;
>>> +    g_mutex_lock(&mem_lock);
>>> +    global_count_mem++;
>>> +    g_mutex_unlock(&mem_lock);
>>> +}
>>> +
>>> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *=
tb)
>>> +{
>>> +    qemu_plugin_register_vcpu_tb_exec_cb(
>>> +        tb, vcpu_tb_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
>>> +    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>>> +        tb, QEMU_PLUGIN_INLINE_ADD_U64, count_tb_inline, 1);
>>> +
>>> +    for (int idx =3D 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
>>> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, =
idx);
>>> +        qemu_plugin_register_vcpu_insn_exec_cb(
>>> +            insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, 0);
>>> +        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>>> +            insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
>>> +        qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
>>> +                                         QEMU_PLUGIN_CB_NO_REGS,
>>> +                                         QEMU_PLUGIN_MEM_RW, 0);
>>> +        qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>>> +            insn, QEMU_PLUGIN_MEM_RW,
>>> +            QEMU_PLUGIN_INLINE_ADD_U64,
>>> +            count_mem_inline, 1);
>>> +    }
>>> +}
>>> +
>>> +QEMU_PLUGIN_EXPORT
>>> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>>> +                        int argc, char **argv)
>>> +{
>>> +    counts =3D qemu_plugin_scoreboard_new(sizeof(CPUCount));
>>> +    count_tb =3D qemu_plugin_u64_struct(counts, CPUCount, count_tb);
>>> +    count_insn =3D qemu_plugin_u64_struct(counts, CPUCount, count_insn=
);
>>> +    count_mem =3D qemu_plugin_u64_struct(counts, CPUCount, count_mem);
>>> +    count_tb_inline =3D qemu_plugin_u64_struct(counts, CPUCount, count=
_tb_inline);
>>> +    count_insn_inline =3D
>>> +        qemu_plugin_u64_struct(counts, CPUCount, count_insn_inline);
>>> +    count_mem_inline =3D
>>> +        qemu_plugin_u64_struct(counts, CPUCount, count_mem_inline);
>>> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>>> +
>>> +    return 0;
>>> +}
>>> diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
>>> index e18183aaeda..9eece5bab51 100644
>>> --- a/tests/plugin/meson.build
>>> +++ b/tests/plugin/meson.build
>>> @@ -1,6 +1,6 @@
>>>   t =3D []
>>>   if get_option('plugins')
>>> -  foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
>>> +  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
>>>       if host_os =3D=3D 'windows'
>>>         t +=3D shared_module(i, files(i + '.c') + '../../contrib/plugin=
s/win32_linker.c',
>>>                           include_directories: '../../include/qemu',
>> Otherwise:
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

