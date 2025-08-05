Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E9BC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 10:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujEWl-0003aJ-UZ; Tue, 05 Aug 2025 06:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujEWi-0003TY-GV
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:04:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ujEWe-0000ZE-9P
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 06:04:11 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-458baf449cbso27973525e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754388245; x=1754993045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLeGtuUn/LFpGztLwdke3Ya5tWeTspA/1FlvMIwhcI4=;
 b=xFSL3BUaMV6HSIupsOsYGN3504EtsRIhOlyFIc1ArpNa8lkgFaZvTzOm6NHHpUKR3r
 yC994w4mIkGBi+6wx7cGuDDa4BF6/uEwdwIESEkQa8vIX5v8PB+W039kilzq/8QrAcZk
 iD10Wc8unTkLiMt6uGungOhbd/C9Hx0yFd1V0KE7FtOV5/MMu7wVZk1UHRZV5UgxHf3a
 IXn2hv8vVxYZNdYUHjrZ2sg9By9Wt3tdWQlZtdy7WPgV6N7GarmQYHL6HJNQw28ttjlW
 OhJmpvoTZuy48pkq4NXZEKYfuJDka16R4uKsLlSXqsHZpuSBQym+pZCgw9bHFdTkpK8+
 ffQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754388245; x=1754993045;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iLeGtuUn/LFpGztLwdke3Ya5tWeTspA/1FlvMIwhcI4=;
 b=YcwIy+ifrXthyiThNEaIWgym1aGqcpshqyFx4Yx1+mTaEkcuz4p3aVmwqqDtQ+42px
 nbwUVA5kQkpJwSB8r1OsYf+ZDBSSm+kPTfJ2/iJbE6/J4jVXrkBwPnTpuLINwEgrQU6M
 wFG/cc/5b8+KsnUFBSyKoe5jQKuBgJwO+VOfafsTdDViYK5CPNI16Cirdensp1yEZZJ9
 intm2WRSEwkyV5SNL/w5ngaoCu8HFNuNcSJg+nhoX4/0tz3gpVPOOFu01PVmeQBAiZZx
 IWjYfnNjajcsht77dAIr9oU8cnM2fsJg+dSi8ecpXIzIYjWZXQ7Hn6uzo8gZHgK6Ye2L
 vmtA==
X-Gm-Message-State: AOJu0YxhSmbD2j6VW5lhZ9/wXjfDu4FE3RMNhBm6Q5Y1I5DR6Db9As7Y
 g7dKlMEga/fiOKYvJwRyHviXg92s0B91vEI0in28xSAl7gA9aRCAv+sZnrZHDpdnTGs=
X-Gm-Gg: ASbGncs8nN5UFHORFsqCvD4tnH81BDlXscI68gePtQQbxecn8h7HrO8jgvwvXpG6PzY
 kgIzrYP4GcS0IAvplJNdHa32sExw5NRYjYxhVIDEqaA7R5m4euS+u1GE+VCfqedVhc9vQLBQF5Q
 7jhFFYntBGnyv+NxvGs4ScopZF4ayarHgp4L5LB12bgoLVC6uM4j3DbIMwvqWNRrjecAzGFSyHC
 eW6ZNPBbJhHwECNQNfvEhscb4JWETjmnYDGgIscHpiatZ6BMcXLt2PEWZpuRzvvSVwHsgLJeeTj
 lJywsMoZkQBB7+KXr1TMgNtPjgrV6dLCTRT7ixaxEqLAOjI9tkdmDiZsODF1UHrH11O7BKq1JPh
 wIDNanatNNGvdDcHwzlnXyhWABiO/B0IUIw==
X-Google-Smtp-Source: AGHT+IFXBbn0dnbN3rgeYfjxe7NeOCLVOa5b/v4ltJIEZfO9ndI07j8wqp5izUf01f3r/baX8+lRmg==
X-Received: by 2002:a05:600c:4f41:b0:458:caec:a741 with SMTP id
 5b1f17b1804b1-458cb577bc3mr66294875e9.24.1754388245273; 
 Tue, 05 Aug 2025 03:04:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3bf970sm18472151f8f.25.2025.08.05.03.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 03:04:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 615575F7E9;
 Tue, 05 Aug 2025 11:04:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 rowan Hart <rowanbhart@gmail.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 1/7] contrib/plugins/uftrace: new uftrace plugin
In-Reply-To: <20250724204527.3175839-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 24 Jul 2025 13:45:20 -0700")
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
 <20250724204527.3175839-2-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 05 Aug 2025 11:04:03 +0100
Message-ID: <871ppq5bl8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> This plugin generates a binary trace compatible with:
> https://github.com/namhyung/uftrace
>
> It tracks frame pointer during execution, detecting function
> calls/returns and works in system and user mode.
>
> It's implemented for aarch64 only (adding other architecture should
> be trivial, especially x86_64 that share the same stack layout).
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  contrib/plugins/uftrace.c   | 630
> ++++++++++++++++++++++++++++++++++++

Is it possible to break this down into smaller commits to ease review? I
appreciate it takes a bit until you have something working but this is a
relatively big plugin.

Anyway some thoughts bellow.

>  contrib/plugins/meson.build |   3 +-
>  2 files changed, 632 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/plugins/uftrace.c
>
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> new file mode 100644
> index 00000000000..4ca6d3fd68d
> --- /dev/null
> +++ b/contrib/plugins/uftrace.c
> @@ -0,0 +1,630 @@
> +/*
> + * Copyright (C) 2025, Pierrick Bouvier <pierrick.bouvier@linaro.org>
> + *
> + * Generates a trace compatible with uftrace (similar to uftrace record).
> + * https://github.com/namhyung/uftrace
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <qemu-plugin.h>
> +#include <glib.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +typedef struct {
> +    GArray *s;
> +} callstack;
> +
> +typedef struct {
> +    uint64_t pc;
> +    uint64_t frame_pointer;
> +} callstack_entry;
> +
> +typedef struct {
> +    GArray *t;
> +    GString *path;
> +    GString *name;

Do these actually build over time or could they just be g_strdup'ed
strings? Could you infact use g_intern_string to save memory by only
having one canonical reference? You wouldn't free them until the end
though.

> +    uint32_t id;
> +} trace;
> +
> +typedef struct Cpu Cpu;
> +
> +typedef struct {
> +    void (*init)(Cpu *cpu);
> +    void (*end)(Cpu *cpu);
> +    uint64_t (*get_frame_pointer)(Cpu *cpu);
> +    bool (*does_insn_modify_frame_pointer)(const char *disas);
> +} CpuOps;
> +
> +typedef struct Cpu {
> +    uint64_t insn_count;
> +    trace *trace;
> +    callstack *cs;
> +    GArray *callstacks; /* callstack *callstacks[] */
> +    GArray *traces; /* trace *traces [] */
> +    GByteArray *buf;
> +    CpuOps ops;
> +    void *arch;
> +} Cpu;
> +
> +typedef struct {
> +    struct qemu_plugin_register *reg_fp;
> +} Aarch64Cpu;
> +
> +typedef struct {
> +    uint64_t timestamp;
> +    uint64_t data;
> +} uftrace_entry;

The typedefs are inconsistent in naming style. QEMU style says typenames
should use CamelCase.

> +
> +enum uftrace_record_type {
> +    UFTRACE_ENTRY,
> +    UFTRACE_EXIT,
> +    UFTRACE_LOST,
> +    UFTRACE_EVENT
> +};
> +
> +static struct qemu_plugin_scoreboard *score;
> +static CpuOps arch_ops;
> +
> +static void uftrace_write_map(bool system_emulation)
> +{
> +    const char *path =3D "./uftrace.data/sid-0.map";
> +
> +    if (system_emulation && access(path, F_OK) =3D=3D 0) {
> +        /* do not erase existing map in system emulation, as a custom on=
e might
> +         * already have been generated by uftrace_symbols.py */
> +        return;
> +    }
> +
> +    FILE *sid_map =3D fopen(path, "w");
> +    g_assert(sid_map);

I'm not sure an assert is the correct way to deal with a possible error
condition here.

> +
> +    if (system_emulation) {
> +        fprintf(sid_map,
> +                "# map stack on highest address possible, to prevent uft=
race\n"
> +                "# from considering any kernel address\n");
> +        fprintf(sid_map,
> +          "ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]\n");
> +    } else {
> +        /* in user mode, copy /proc/self/maps instead */
> +        FILE *self_map =3D fopen("/proc/self/maps", "r");
> +        g_assert(self_map);
> +        for (;;) {
> +            int c =3D fgetc(self_map);
> +            if (c =3D=3D EOF) {
> +                break;
> +            }
> +            fputc(c, sid_map);
> +        }
> +        fclose(self_map);
> +    }
> +    fclose(sid_map);
> +}
> +
> +static void uftrace_write_task(const GArray *traces)
> +{
> +    FILE *task =3D fopen("./uftrace.data/task.txt", "w");
> +    g_assert(task);

ditto

> +    for (int i =3D 0; i < traces->len; ++i) {
> +        trace *t =3D g_array_index(traces, trace*, i);
> +        fprintf(task, "SESS timestamp=3D0.0 pid=3D%"PRIu32" sid=3D0 exen=
ame=3D\"%s\"\n",
> +                t->id, t->name->str);
> +        fprintf(task, "TASK timestamp=3D0.0 tid=3D%"PRIu32" pid=3D%"PRIu=
32"\n",
> +                t->id, t->id);
> +    }
> +    fclose(task);
> +}
> +
> +static void uftrace_write_info(const GArray *traces)
> +{
> +    g_autoptr(GString) taskinfo_tids =3D g_string_new("taskinfo:tids=3D"=
);
> +    for (int i =3D 0; i < traces->len; ++i) {
> +        trace *t =3D g_array_index(traces, trace*, i);
> +        const char *delim =3D i > 0 ? "," : "";
> +        g_string_append_printf(taskinfo_tids, "%s%"PRIu32, delim, t->id);
> +    }
> +
> +    g_autoptr(GString) taskinfo_nr_tid =3D g_string_new("taskinfo:nr_tid=
=3D");
> +    g_string_append_printf(taskinfo_nr_tid, "%d", traces->len);
> +
> +    FILE *info =3D fopen("./uftrace.data/info", "w");
> +    g_assert(info);
> +    /*
> +     * $ uftrace dump --debug
> +     * uftrace file header: magic         =3D 4674726163652100
> +     * uftrace file header: version       =3D 4
> +     * uftrace file header: header size   =3D 40
> +     * uftrace file header: endian        =3D 1 (little)
> +     * ftrace file header: class          =3D 2 (64 bit)
> +     * uftrace file header: features      =3D 0x1263 (PLTHOOK | ...
> +     * uftrace file header: info          =3D 0x7bff (EXE_NAME | ...
> +     *  <0000000000000000>: 46 74 72 61 63 65 21 00  04 00 00 00 28 00 0=
1 02
> +     *  <0000000000000010>: 63 12 00 00 00 00 00 00  ff 7b 00 00 00 00 0=
0 00
> +     *  <0000000000000020>: 00 04 00 00 00 00 00 00
> +     */
> +    const uint8_t header[] =3D {0x46, 0x74, 0x72, 0x61, 0x63, 0x65, 0x21=
, 0x00,
> +                              0x04, 0x00, 0x00, 0x00, 0x28, 0x00, 0x01, =
0x02,
> +                              0x63, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> +                              0xff, 0x7b, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00,
> +                              0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x00};
> +    fwrite(header, sizeof(header), 1, info);
> +    const char *info_data[] =3D {
> +        "exename:from_qemu",
> +        "build_id:0123456789abcdef0123456789abcdef01234567",
> +        "exit_status:0",
> +        "cmdline:uftrace record qemu",
> +        "cpuinfo:lines=3D2",
> +        "cpuinfo:nr_cpus=3D1 / 1 (online/possible)",
> +        "cpuinfo:desc=3DIntel 8086",
> +        "meminfo:1.0 / 1.0 GB (free / total)",
> +        "osinfo:lines=3D3",
> +        "osinfo:kernel=3DLinux 6.12.33",
> +        "osinfo:hostname=3Dpc",
> +        "osinfo:distro=3D\"Debian GNU/Linux 13 (trixie)\"",
> +        "taskinfo:lines=3D2",

This seems all rather like a dump from a developer machine. Should we be
filling this out with either the local host setup or even the guest
details (at least for CPU type etc)?

> +        taskinfo_nr_tid->str,
> +        taskinfo_tids->str,
> +        "usageinfo:lines=3D6",
> +        "usageinfo:systime=3D0.000000",
> +        "usageinfo:usrtime=3D0.000000",
> +        "usageinfo:ctxsw=3D0 / 0 (voluntary / involuntary)",
> +        "usageinfo:maxrss=3D8016",
> +        "usageinfo:pagefault=3D0 / 0 (major / minor)",
> +        "usageinfo:iops=3D0 / 0 (read / write)",
> +        "loadinfo:0.0 / 0.0 / 0.0",
> +        "record_date:Mon Jan  1 00:00:00 2025",
> +        "elapsed_time:1000000000000.0 sec",
> +        "pattern_type:regex",
> +        "uftrace_version:v0.17 ( x86_64 dwarf python3 luajit tui perf sc=
hed dynamic kernel )",
> +        "utc_offset:1751552954",
> +        0};
> +    const char **info_data_it =3D info_data;
> +    while (*(info_data_it)) {
> +        fprintf(info, "%s\n", *info_data_it);
> +        ++info_data_it;
> +    }
> +    fclose(info);
> +}
> +
> +static callstack *callstack_new(void)
> +{
> +    callstack *cs =3D g_malloc0(sizeof(callstack));

g_new0(callstack, 1)?

> +    cs->s =3D g_array_new(false, false, sizeof(callstack_entry));
> +    return cs;
> +}
> +
> +static void callstack_free(callstack *cs)
> +{
> +    g_array_free(cs->s, true);
> +    cs->s =3D NULL;
> +    g_free(cs);
> +}
> +
> +static size_t callstack_depth(const callstack *cs)
> +{
> +    return cs->s->len;
> +}
> +
> +static size_t callstack_empty(const callstack *cs)
> +{
> +    return callstack_depth(cs) =3D=3D 0;
> +}
> +
> +static void callstack_clear(callstack *cs)
> +{
> +    g_array_set_size(cs->s, 0);
> +}
> +
> +static const callstack_entry *callstack_at(const callstack *cs, size_t d=
epth)
> +{
> +    g_assert(depth > 0);
> +    g_assert(depth <=3D callstack_depth(cs));
> +    return &g_array_index(cs->s, callstack_entry, depth - 1);
> +}
> +
> +static callstack_entry callstack_top(const callstack *cs)
> +{
> +    if (callstack_depth(cs) >=3D 1) {
> +        return *callstack_at(cs, callstack_depth(cs));
> +    }
> +    return (callstack_entry){};
> +}
> +
> +static callstack_entry callstack_caller(const callstack *cs)
> +{
> +    if (callstack_depth(cs) >=3D 2) {
> +        return *callstack_at(cs, callstack_depth(cs) - 1);
> +    }
> +    return (callstack_entry){};
> +}
> +
> +static void callstack_push(callstack *cs, callstack_entry e)
> +{
> +    g_array_append_val(cs->s, e);
> +}
> +
> +static callstack_entry callstack_pop(callstack *cs)
> +{
> +    g_assert(!callstack_empty(cs));
> +    callstack_entry e =3D callstack_top(cs);
> +    g_array_set_size(cs->s, callstack_depth(cs) - 1);
> +    return e;
> +}
> +
> +static trace *trace_new(uint32_t id, GString *name)
> +{
> +    trace *t =3D g_malloc0(sizeof(trace));

g_new0()

> +    t->t =3D g_array_new(false, false, sizeof(uftrace_entry));
> +    t->path =3D g_string_new(NULL);
> +    g_string_append_printf(t->path, "./uftrace.data/%"PRIu32".dat", id);
> +    t->name =3D g_string_new(name->str);
> +    t->id =3D id;
> +    return t;
> +}
> +
> +static void trace_free(trace *t)
> +{
> +    g_assert(t->t->len =3D=3D 0);
> +    g_array_free(t->t, true);
> +    t->t =3D NULL;
> +    g_string_free(t->path, true);
> +    t->path =3D NULL;
> +    g_string_free(t->name, true);
> +    t->name =3D NULL;
> +    g_free(t);
> +}
> +
> +static void trace_flush(trace *t, bool append)
> +{
> +    int create_dir =3D g_mkdir_with_parents("./uftrace.data",
> +                                          S_IRWXU | S_IRWXG | S_IRWXO);
> +    g_assert(create_dir =3D=3D 0);
> +    FILE *dat =3D fopen(t->path->str, append ? "a" : "w");
> +    g_assert(dat);
> +    GArray *data =3D t->t;
> +    if (data->len) {
> +        fwrite(data->data, data->len, sizeof(uftrace_entry), dat);
> +    }
> +    fclose(dat);
> +    g_array_set_size(data, 0);
> +}
> +
> +static void trace_add_entry(trace *t, uint64_t timestamp, uint64_t pc,
> +                            size_t depth, enum uftrace_record_type type)
> +{
> +    /* libmcount/record.c:record_event */
> +    const uint64_t record_magic =3D 0x5;
> +    uint64_t data =3D type | record_magic << 3;
> +    data +=3D depth << 6;
> +    data +=3D pc << 16;
> +    uftrace_entry e =3D {.timestamp =3D timestamp, .data =3D data};
> +    g_array_append_val(t->t, e);
> +    if (t->t->len * sizeof(uftrace_entry) > 32 * 1024 * 1024) {

A good candidate for:

  #define MiB     (INT64_C(1) << 20)

like units.h and then having > (32 * MiB)

> +        /* flush every 32 MB */
> +        trace_flush(t, true);
> +    }
> +}
> +
> +static void trace_enter_function(trace *t, uint64_t timestamp,
> +                                 uint64_t pc, size_t depth)
> +{
> +    trace_add_entry(t, timestamp, pc, depth, UFTRACE_ENTRY);
> +}
> +
> +static void trace_exit_function(trace *t, uint64_t timestamp,
> +                                uint64_t pc, size_t depth)
> +{
> +    trace_add_entry(t, timestamp, pc, depth, UFTRACE_EXIT);
> +}
> +
> +static void trace_enter_stack(trace *t, callstack *cs, uint64_t timestam=
p)
> +{
> +    for (size_t depth =3D 1; depth <=3D callstack_depth(cs); ++depth) {
> +        trace_enter_function(t, timestamp, callstack_at(cs, depth)->pc, =
depth);
> +    }
> +}
> +
> +static void trace_exit_stack(trace *t, callstack *cs, uint64_t timestamp)
> +{
> +    for (size_t depth =3D callstack_depth(cs); depth > 0; --depth) {
> +        trace_exit_function(t, timestamp, callstack_at(cs, depth)->pc, d=
epth);
> +    }
> +}
> +
> +static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_registe=
r *reg)
> +{
> +    GByteArray *buf =3D cpu->buf;
> +    g_byte_array_set_size(buf, 0);
> +    size_t sz =3D qemu_plugin_read_register(reg, buf);
> +    g_assert(sz =3D=3D 8);
> +    g_assert(buf->len =3D=3D 8);
> +    return *((uint64_t *) buf->data);
> +}
> +
> +static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
> +{
> +    g_assert(addr);
> +    GByteArray *buf =3D cpu->buf;
> +    g_byte_array_set_size(buf, 0);
> +    bool read =3D qemu_plugin_read_memory_vaddr(addr, buf, 8);
> +    if (!read) {
> +        return 0;
> +    }
> +    g_assert(buf->len =3D=3D 8);
> +    return *((uint64_t *) buf->data);
> +}
> +

A little comment about what we are doing here would be useful.

> +static void cpu_unwind_stack(Cpu *cpu, uint64_t frame_pointer, uint64_t =
pc)
> +{
> +    g_assert(callstack_empty(cpu->cs));
> +
> +    #define UNWIND_STACK_MAX_DEPTH 1024
> +    callstack_entry unwind[UNWIND_STACK_MAX_DEPTH];
> +    size_t depth =3D 0;
> +    do {
> +        /* check we don't have an infinite stack */
> +        for (size_t i =3D 0; i < depth; ++i) {
> +            if (frame_pointer =3D=3D unwind[i].frame_pointer) {
> +                break;
> +            }
> +        }
> +        callstack_entry e =3D {.frame_pointer =3D frame_pointer, .pc =3D=
 pc};
> +        unwind[depth] =3D e;
> +        depth++;
> +        if (frame_pointer) {
> +            frame_pointer =3D cpu_read_memory64(cpu, frame_pointer);
> +        }
> +        pc =3D cpu_read_memory64(cpu, frame_pointer + 8); /* read previo=
us lr */
> +    } while (frame_pointer && pc && depth < UNWIND_STACK_MAX_DEPTH);
> +    #undef UNWIND_STACK_MAX_DEPTH
> +
> +    /* push it from bottom to top */
> +    while (depth) {
> +        callstack_push(cpu->cs, unwind[depth - 1]);
> +        --depth;
> +    }
> +}
> +
> +static uint64_t cpu_get_timestamp(const Cpu *cpu)
> +{
> +    return cpu->insn_count;
> +}
> +
> +static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
> +{
> +    Aarch64Cpu *cpu =3D cpu_->arch;
> +    return cpu_read_register64(cpu_, cpu->reg_fp);
> +}
> +
> +static void aarch64_init(Cpu *cpu_)
> +{
> +    Aarch64Cpu *cpu =3D g_malloc0(sizeof(Aarch64Cpu));
> +    cpu_->arch =3D cpu;
> +    g_autoptr(GArray) regs =3D qemu_plugin_get_registers();
> +    for (int i =3D 0; i < regs->len; ++i) {
> +        qemu_plugin_reg_descriptor *reg;
> +        reg =3D &g_array_index(regs, qemu_plugin_reg_descriptor, i);
> +        if (!strcmp(reg->name, "x29")) {
> +            cpu->reg_fp =3D reg->handle;
> +        }
> +    }

It doesn't seem aarch64_init/Aarch64Cpu is very aarch64 specific, you could=
 easily
make a table indexed by info->target_name or allow the user to specific
the fpreg via an arg.

> +    if (!cpu->reg_fp) {
> +        fprintf(stderr, "uftrace plugin: frame pointer register (x29) is=
 not "
> +                        "available. Please use an AArch64 cpu (or -cpu m=
ax).\n");
> +        g_abort();
> +    }
> +}
> +
> +static void aarch64_end(Cpu *cpu)
> +{
> +    g_free(cpu->arch);
> +}
> +
> +static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
> +{
> +    /*
> +     * Check if current instruction concerns fp register "x29".
> +     * We add a prefix space to make sure we don't match addresses dump
> +     * in disassembly.
> +     */
> +    return strstr(disas, " x29");

there was another fix in another plugin to handle /t as a potential
terminator.

> +}
> +
> +static CpuOps aarch64_ops =3D {
> +    .init =3D aarch64_init,
> +    .end =3D aarch64_end,
> +    .get_frame_pointer =3D aarch64_get_frame_pointer,
> +    .does_insn_modify_frame_pointer =3D
> aarch64_does_insn_modify_frame_pointer,

arguably does_insn_modify_frame_pointer is the only specialised handler
you need for ops although maybe even then you could save the text of the
register when you setup so you can have a common helper when frame
pointers are explicit in the assembly.

> +};
> +
> +static void track_callstack(unsigned int cpu_index, void *udata)
> +{
> +    uint64_t pc =3D (uintptr_t) udata;
> +    Cpu *cpu =3D qemu_plugin_scoreboard_find(score, cpu_index);
> +    uint64_t timestamp =3D cpu_get_timestamp(cpu);
> +    callstack *cs =3D cpu->cs;
> +    trace *t =3D cpu->trace;
> +
> +    uint64_t fp =3D cpu->ops.get_frame_pointer(cpu);
> +    if (!fp && callstack_empty(cs)) {
> +        /*
> +         * We simply push current pc. Note that we won't detect symbol c=
hange as
> +         * long as a proper call does not happen.
> +         */
> +        callstack_push(cs, (callstack_entry){.frame_pointer =3D fp,
> +                                               .pc =3D pc});
> +        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
> +        return;
> +    }
> +
> +    callstack_entry top =3D callstack_top(cs);
> +    if (fp =3D=3D top.frame_pointer) {
> +        /* same function */
> +        return;
> +    }
> +
> +    callstack_entry caller =3D callstack_caller(cs);
> +    if (fp =3D=3D caller.frame_pointer) {
> +        /* return */
> +        callstack_entry e =3D callstack_pop(cs);
> +        trace_exit_function(t, timestamp, e.pc, callstack_depth(cs));
> +        return;
> +    }
> +
> +    uint64_t caller_fp =3D fp ? cpu_read_memory64(cpu, fp) : 0;
> +    if (caller_fp =3D=3D top.frame_pointer) {
> +        /* call */
> +        callstack_push(cs, (callstack_entry){.frame_pointer =3D fp,
> +                .pc =3D pc});
> +        trace_enter_function(t, timestamp, pc, callstack_depth(cs));
> +        return;
> +    }
> +
> +    /* discontinuity, exit current stack and unwind new one */
> +    trace_exit_stack(t, cs, timestamp);
> +    callstack_clear(cs);
> +
> +    cpu_unwind_stack(cpu, fp, pc);
> +    trace_enter_stack(t, cs, timestamp);
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> +
> +    qemu_plugin_u64 insn_count =3D qemu_plugin_scoreboard_u64_in_struct(
> +                                      score, Cpu, insn_count);
> +
> +    /*
> +     * We instrument all instructions following one that might have upda=
ted
> +     * the frame pointer. We always instrument first instruction in bloc=
k, as
> +     * last executed instruction, in previous tb, may have modified it.
> +     */
> +    bool instrument_insn =3D true;
> +    for (int i =3D 0; i < n_insns; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> +        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
> +
> +        if (instrument_insn) {
> +            uintptr_t pc =3D qemu_plugin_insn_vaddr(insn);
> +            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
> +                                                   QEMU_PLUGIN_CB_R_REGS,
> +                                                   (void *) pc);
> +            instrument_insn =3D false;
> +        }
> +
> +        char *disas =3D qemu_plugin_insn_disas(insn);
> +        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
> +            instrument_insn =3D true;
> +        }
> +    }
> +}
> +
> +static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    Cpu *cpu =3D qemu_plugin_scoreboard_find(score, vcpu_index);
> +    cpu->ops =3D arch_ops;
> +
> +    cpu->ops.init(cpu);
> +    cpu->buf =3D g_byte_array_new();
> +    cpu->callstacks =3D g_array_new(0, 0, sizeof(callstack *));
> +    cpu->traces =3D g_array_new(0, 0, sizeof(trace *));
> +
> +    g_assert(vcpu_index < 1000);

Seems arbitrary?

  ./qemu-aarch64 -plugin ./contrib/plugins/libuftrace.so ./tests/tcg/aarch6=
4-linux-user/threadcount 1001
  **
  ERROR:../../contrib/plugins/uftrace.c:878:vcpu_init: assertion failed: (v=
cpu_index < 1000)
  Bail out! ERROR:../../contrib/plugins/uftrace.c:878:vcpu_init: assertion =
failed: (vcpu_index < 1000)
  fish: Job 1, './qemu-aarch64 -plugin ./contri=E2=80=A6' terminated by sig=
nal SIGABRT (Abort)

> +    uint32_t trace_id =3D 1000 * 1000 + vcpu_index * 1000;
> +
> +    g_autoptr(GString) trace_name =3D g_string_new(NULL);
> +    g_string_append_printf(trace_name, "cpu%u", vcpu_index);

g_strdup_printf would work just as well here.

> +    trace *t =3D trace_new(trace_id, trace_name);
> +    g_array_append_val(cpu->traces, t);
> +    callstack *cs =3D callstack_new();
> +    g_array_append_val(cpu->callstacks, cs);
> +    /* create/truncate trace file */
> +    trace_flush(t, false);
> +
> +    cpu->cs =3D cs;
> +    cpu->trace =3D t;
> +}
> +
> +static void vcpu_end(unsigned int vcpu_index)
> +{
> +    Cpu *cpu =3D qemu_plugin_scoreboard_find(score, vcpu_index);
> +    g_byte_array_free(cpu->buf, true);
> +
> +    for (size_t i =3D 0; i < cpu->traces->len; ++i) {
> +        trace *t =3D g_array_index(cpu->traces, trace*, i);
> +        trace_free(t);
> +    }
> +
> +    for (size_t i =3D 0; i < cpu->callstacks->len; ++i) {
> +        callstack *cs =3D g_array_index(cpu->callstacks, callstack*, i);
> +        callstack_free(cs);
> +    }
> +
> +    g_array_free(cpu->traces, true);
> +    g_array_free(cpu->callstacks, true);
> +    memset(cpu, 0, sizeof(Cpu));
> +}
> +
> +static void at_exit(qemu_plugin_id_t id, void *data)
> +{
> +    bool system_emulation =3D (bool) data;
> +    g_autoptr(GArray) traces =3D g_array_new(0, 0, sizeof(trace *));
> +
> +    /* exit last active stacks */
> +    for (size_t i =3D 0; i < qemu_plugin_num_vcpus(); ++i) {
> +        Cpu *cpu =3D qemu_plugin_scoreboard_find(score, i);
> +        uint64_t timestamp =3D cpu_get_timestamp(cpu);
> +        if (trace_sample) {
> +            cpu_trace_last_sample(cpu, timestamp);
> +        }
> +        trace_exit_stack(cpu->trace, cpu->cs, timestamp);
> +        callstack_clear(cpu->cs);
> +    }
> +
> +    for (size_t i =3D 0; i < qemu_plugin_num_vcpus(); ++i) {
> +        Cpu *cpu =3D qemu_plugin_scoreboard_find(score, i);
> +        for (size_t j =3D 0; j < cpu->traces->len; ++j) {
> +            trace *t =3D g_array_index(cpu->traces, trace*, j);
> +            trace_flush(t, true);
> +            g_array_append_val(traces, t);
> +        }
> +    }
> +
> +    uftrace_write_map(system_emulation);
> +    uftrace_write_info(traces);
> +    uftrace_write_task(traces);
> +
> +    for (size_t i =3D 0; i < qemu_plugin_num_vcpus(); ++i) {
> +        vcpu_end(i);
> +    }
> +
> +    qemu_plugin_scoreboard_free(score);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    if (!strcmp(info->target_name, "aarch64")) {
> +        arch_ops =3D aarch64_ops;
> +    } else {
> +        fprintf(stderr, "plugin uftrace: %s target is not supported\n",
> +                info->target_name);
> +        return 1;
> +    }
> +
> +    score =3D qemu_plugin_scoreboard_new(sizeof(Cpu));
> +    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_em=
ulation);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +
> +    return 0;
> +}
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 1876bc78438..7eb3629c95d 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -1,5 +1,6 @@
>  contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotbl=
ocks',
> -                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigge=
r']
> +                   'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigge=
r',
> +                   'uftrace']
>  if host_os !=3D 'windows'
>    # lockstep uses socket.h
>    contrib_plugins +=3D 'lockstep'

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

