Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8426CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Sep 2025 16:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0NCe-0007cD-Sl; Sun, 21 Sep 2025 12:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0NCa-0007ZY-4c
 for qemu-devel@nongnu.org; Sun, 21 Sep 2025 12:46:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0NCW-0002B7-Mt
 for qemu-devel@nongnu.org; Sun, 21 Sep 2025 12:46:15 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3fc36b99e92so223417f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Sep 2025 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758473168; x=1759077968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVGDlSmG6zGb/AaIt76y03xYi35itpvxy4k3AzB9qi0=;
 b=F1X4EU76UuOd1Jzryt+AdSUtnMdMD8IiEL3oPWhzHw4hlztxL2NMjIQPbOx5xjmEsm
 hiQInqqt1G+6RE8NiMxDbgmU4tO7+yqy9k/ykkLI29XcEoQJOt+B26aUc/XrZprzZLm2
 DPx1/sPSdmLyxQ8jQjY24JGTt+rhQH9cKsnNaX4ZVQu097UbH7jNSmXd14e2OsP6RpKb
 xHFAcH9RsoJh7bkNzLNd3XG+N4BEl3N32NFg6qDxyAuiSByajhjpDnGXLlc495if7HPI
 awdsCkbSH7h0puTpj34lveALom2M18bgHFrIFwDWdh3xLzXW0AV4s1Fx/6lvgLEoyCT4
 cIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758473168; x=1759077968;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CVGDlSmG6zGb/AaIt76y03xYi35itpvxy4k3AzB9qi0=;
 b=C+09aiOlNNp/z2xZfr3Dd5B6Rbjl6pXGy7AMGcqGNuhmmtbBNWuskAdiBNbenmpeZp
 FjQsgAoSHoV8U0/O8vZ/6kAWU+MCb605v+42CbgUpThfigNwJJBJoAWwRIh66Cu8zjq9
 agZVgMvoAsHEuEpobRUiBGVF4aWjSb2MFzcAsus9sRji/RL4m+OxFxqeUc3kGZXPXj/H
 TnbqDTyJ/DLOS8zQh2FG3S6ckQ7zBMW42N5X95LiqA/Zyto21H8FRLSouyz8GAr+hWsg
 pp4iJA/bLiH+Dgoi+8qh+DBt1+sTt3uLm1dlW93NaDDw6jpulbljeQsbHXA6y/ckRo1z
 8/xA==
X-Gm-Message-State: AOJu0Yx7eIULVxLcTKtOmwDyWt8YvXI8qmysvJpSGU0eVE+MODiivM4h
 tVnzA1Wxu8nwcp1xMv0KQmRf5AbWNPprck/sHOhr0rrqnK8T7QJX1qVD8aN0SdS5dGE=
X-Gm-Gg: ASbGncuq60YitQog1c/e0C2/mVF7d2TcKIV3vfCAeSeYMD0MXc2Ji/be01KQpTz08Hh
 LR6jYZmz+5VW6CSmSXefvpmcZhyi66yKsJs9K1gs1i94PWv5WdH/NCFS5TPKG0A6cn7H96MGYp/
 VD+YvonJCI7Dmbx0/tdvw9mWS5PjWDW7LU93798SUrQ1wmX97IRkZNXidQrg94sMnNxCHpFRK83
 BoelkLbQ+hFghlJCFsOcmbUYD9ZDN72R/VzOMNC1Y5pkE8/+HSobU4kwJuBg2VPzP8zAQOyJHcV
 3XUFZtAEbnAk3Ric/18+/7N8yPL1WgB06xA2HunEQu9IBYY90bEgYcywymh1xDZqtJ9D/G34M0L
 LUkaJBhXk2G5HHU8b+JdU9K8=
X-Google-Smtp-Source: AGHT+IGMpYT4j8HK1iv03/C2yhhFKAAwytpd4vkao9Pp+l/L+mKAupOEJXjj0rW2kCEi9VqikxMupQ==
X-Received: by 2002:a05:6000:420d:b0:3e9:d9bd:504f with SMTP id
 ffacd0b85a97d-3ee1acd872cmr11366970f8f.21.1758473167748; 
 Sun, 21 Sep 2025 09:46:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f61703b206sm6133953f8f.6.2025.09.21.09.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 09:46:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A2465F87D;
 Sun, 21 Sep 2025 17:46:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH v6 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
In-Reply-To: <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
 (Julian Ganz's message of "Thu, 4 Sep 2025 22:48:58 +0200")
References: <cover.1757018626.git.neither@nut.email>
 <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Sun, 21 Sep 2025 17:46:05 +0100
Message-ID: <87segf69f6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Julian Ganz <neither@nut.email> writes:

> We recently introduced plugin API for the registration of callbacks for
> discontinuity events, specifically for interrupts, exceptions and host
> call events. The callback receives various bits of information,
> including the VCPU index and PCs.
>
> This change introduces a test plugin asserting the correctness of that
> behaviour in cases where this is possible with reasonable effort.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>  tests/tcg/plugins/discons.c   | 210 ++++++++++++++++++++++++++++++++++
>  tests/tcg/plugins/meson.build |   2 +-
>  2 files changed, 211 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/plugins/discons.c
>
> diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
> new file mode 100644
> index 0000000000..f185e3948b
> --- /dev/null
> +++ b/tests/tcg/plugins/discons.c
> @@ -0,0 +1,210 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (C) 2025, Julian Ganz <neither@nut.email>
> + *
> + * This plugin exercises the discontinuity plugin API and asserts some
> + * of its behaviour regarding reported program counters.
> + */
> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +struct cpu_state {
> +    uint64_t last_pc;
> +    uint64_t from_pc;
> +    uint64_t next_pc;
> +    uint64_t has_from;
> +    bool has_next;
> +    enum qemu_plugin_discon_type next_type;
> +};
> +
> +struct insn_data {
> +    uint64_t addr;
> +    uint64_t next_pc;
> +    bool next_valid;
> +};
> +
> +static struct qemu_plugin_scoreboard *states;
> +
> +static qemu_plugin_u64 last_pc;
> +static qemu_plugin_u64 from_pc;
> +static qemu_plugin_u64 has_from;
> +
> +static bool abort_on_mismatch;
> +static bool trace_all_insns;
> +
> +static bool addr_eq(uint64_t a, uint64_t b)
> +{
> +    if (a =3D=3D b) {
> +        return true;
> +    }
> +
> +    uint64_t a_hw;
> +    uint64_t b_hw;
> +    if (!qemu_plugin_translate_vaddr(a, &a_hw) ||
> +        !qemu_plugin_translate_vaddr(b, &b_hw))
> +    {
> +        return false;
> +    }
> +
> +    return a_hw =3D=3D b_hw;
> +}
> +
> +static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
> +                            enum qemu_plugin_discon_type type, uint64_t =
last,
> +                            uint64_t expected, uint64_t encountered)
> +{
> +    GString *report;

This could be:

  g_autoptr(GString) buf =3D g_string_new(NULL);

> +    const char *discon_type_name =3D "unknown";
> +
> +    if (addr_eq(expected, encountered)) {
> +        return;
> +    }
> +
> +    switch (type) {
> +    case QEMU_PLUGIN_DISCON_INTERRUPT:
> +        discon_type_name =3D "interrupt";
> +        break;
> +    case QEMU_PLUGIN_DISCON_EXCEPTION:
> +        discon_type_name =3D "exception";
> +        break;
> +    case QEMU_PLUGIN_DISCON_HOSTCALL:
> +        discon_type_name =3D "hostcall";
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    report =3D g_string_new(NULL);
> +    g_string_append_printf(report,
> +                           "Discon %s PC mismatch on VCPU %d\nExpected: =
     %"
> +                           PRIx64"\nEncountered:   %"PRIx64"\nExecuted L=
ast: %"
> +                           PRIx64"\nEvent type:    %s\n",
> +                           pc_name, vcpu_index, expected, encountered, l=
ast,
> +                           discon_type_name);
> +    qemu_plugin_outs(report->str);

I think we might want to flush here because

> +    if (abort_on_mismatch) {
> +        g_abort();
> +    }

This is firing on:

  =F0=9F=95=9917:35:50 alex@draig:tests/tcg/i386-linux-user  on =EE=82=A0 r=
eview/tcg-discon-v6 [$!?]=20
  =E2=9E=9C  make run-plugin-catch-syscalls-with-libdiscons.so V=3D1
  timeout -s KILL --foreground 120  env QEMU=3D/home/alex/lsrc/qemu.git/bui=
lds/sanitisers/qemu-i386 /home/alex/lsrc/qemu.git/builds/sanitisers/qemu-i3=
86  -plugin ../plugins/libdiscons.so -d plugin -D catch-syscalls-with-libdi=
scons.so.pout catch-syscalls >  run-plugin-catch-syscalls-with-libdiscons.s=
o.out
  Aborted
  make: *** [Makefile:226: run-plugin-catch-syscalls-with-libdiscons.so] Er=
ror 134
  =F0=9F=95=9917:35:52 alex@draig:tests/tcg/i386-linux-user  on =EE=82=A0 r=
eview/tcg-discon-v6 [$!?] [=F0=9F=94=B4 USAGE]=20
  =E2=9C=97

although it never gets to the point of reporting what failed:

  Thread 1 "qemu-i386" hit Breakpoint 1, __GI_abort () at ./stdlib/abort.c:=
72
  warning: 72     ./stdlib/abort.c: No such file or directory
  (gdb) bt
  #0  __GI_abort () at ./stdlib/abort.c:72
  #1  0x00007ffff630874d in report_mismatch (pc_name=3D0x7ffff630a220 "targ=
et", vcpu_index=3D0, type=3DQEMU_PLUGIN_DISCON_EXCEPTION, last=3D134574955,=
 expected=3D134574953,=20
      encountered=3D134574955) at ../../tests/tcg/plugins/discons.c:89
  #2  0x00007ffff6308c0d in insn_exec (vcpu_index=3D0, userdata=3D0x0) at .=
./../tests/tcg/plugins/discons.c:132
  #3  0x00007fffea431114 in code_gen_buffer ()
  #4  0x000055555577b0a6 in cpu_tb_exec (cpu=3D0x529000005200, itb=3D0x7fff=
ea431000 <code_gen_buffer+200659>, tb_exit=3D0x7ffff49c9530) at ../../accel=
/tcg/cpu-exec.c:438
  #5  0x000055555577c92f in cpu_loop_exec_tb (cpu=3D0x529000005200, tb=3D0x=
7fffea431000 <code_gen_buffer+200659>, pc=3D134574955, last_tb=3D0x7ffff49c=
9540, tb_exit=3D0x7ffff49c9530)
      at ../../accel/tcg/cpu-exec.c:871
  #6  0x000055555577d151 in cpu_exec_loop (cpu=3D0x529000005200, sc=3D0x7ff=
ff483a740) at ../../accel/tcg/cpu-exec.c:981
  #7  0x000055555577d2fe in cpu_exec_setjmp (cpu=3D0x529000005200, sc=3D0x7=
ffff483a740) at ../../accel/tcg/cpu-exec.c:998
  #8  0x000055555577d4c8 in cpu_exec (cpu=3D0x529000005200) at ../../accel/=
tcg/cpu-exec.c:1024
  #9  0x00005555557bfc83 in cpu_loop (env=3D0x529000007dd0) at ../../linux-=
user/i386/cpu_loop.c:215
  #10 0x00005555558ee3e1 in main (argc=3D4, argv=3D0x7fffffffe688, envp=3D0=
x7fffffffe6b0) at ../../linux-user/main.c:1038
  (gdb) f 1
  #1  0x00007ffff630874d in report_mismatch (pc_name=3D0x7ffff630a220 "targ=
et", vcpu_index=3D0, type=3DQEMU_PLUGIN_DISCON_EXCEPTION, last=3D134574955,=
 expected=3D134574953,=20
      encountered=3D134574955) at ../../tests/tcg/plugins/discons.c:89
  89              g_abort();
  (gdb) p report
  $1 =3D (GString *) 0x50300002bf00
  (gdb) p report->Str
  There is no member named Str.
  (gdb) p report->str
  $2 =3D (gchar *) 0x51100001fbc0 "Discon target PC mismatch on VCPU 0\nExp=
ected:      8057369\nEncountered:   805736b\nExecuted Last: 805736b\nEvent =
type:    exception\n"
  (gdb)=20

I think this is where it is going wrong:

  IN: _dl_early_allocate
  0x0805736b:  89 c2                    movl     %eax, %edx
  0x0805736d:  8d 1c 28                 leal     (%eax, %ebp), %ebx
  0x08057370:  89 c8                    movl     %ecx, %eax
  0x08057372:  cd 80                    int      $0x80

> +    g_string_free(report, true);

so we could drop this... or..


> +}
> +
> +static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
> +                        enum qemu_plugin_discon_type type, uint64_t from=
_pc,
> +                        uint64_t to_pc)
> +{
> +    struct cpu_state *state =3D qemu_plugin_scoreboard_find(states, vcpu=
_index);
> +
> +    if (type =3D=3D QEMU_PLUGIN_DISCON_EXCEPTION &&
> +        addr_eq(state->last_pc, from_pc))
> +    {
> +        /*
> +         * For some types of exceptions, insn_exec will be called for the
> +         * instruction that caused the exception. This is valid behaviou=
r and
> +         * does not need to be reported.
> +         */
> +    } else if (state->has_next) {
> +        /*
> +         * We may encounter discontinuity chains without any instructions
> +         * being executed in between.
> +         */
> +        report_mismatch("source", vcpu_index, type, state->last_pc,
> +                        state->next_pc, from_pc);
> +    } else if (state->has_from) {
> +        report_mismatch("source", vcpu_index, type, state->last_pc,
> +                        state->from_pc, from_pc);
> +    }
> +
> +    state->has_from =3D false;
> +
> +    state->next_pc =3D to_pc;
> +    state->next_type =3D type;
> +    state->has_next =3D true;
> +}
> +
> +static void insn_exec(unsigned int vcpu_index, void *userdata)
> +{
> +    struct cpu_state *state =3D qemu_plugin_scoreboard_find(states, vcpu=
_index);
> +
> +    if (state->has_next) {
> +        report_mismatch("target", vcpu_index, state->next_type, state->l=
ast_pc,
> +                        state->next_pc, state->last_pc);
> +        state->has_next =3D false;
> +    }
> +
> +    if (trace_all_insns) {
> +        g_autoptr(GString) report =3D g_string_new(NULL);
> +        g_string_append_printf(report, "Exec insn at %"PRIx64" on VCPU %=
d\n",
> +                               state->last_pc, vcpu_index);
> +        qemu_plugin_outs(report->str);
> +    }
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t n_insns =3D qemu_plugin_tb_n_insns(tb);
> +    for (size_t i =3D 0; i < n_insns; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t pc =3D qemu_plugin_insn_vaddr(insn);
> +        uint64_t next_pc =3D pc + qemu_plugin_insn_size(insn);
> +        uint64_t has_next =3D (i + 1) < n_insns;
> +
> +        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> +                                                            QEMU_PLUGIN_=
INLINE_STORE_U64,
> +                                                            last_pc, pc);
> +        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> +                                                            QEMU_PLUGIN_=
INLINE_STORE_U64,
> +                                                            from_pc, nex=
t_pc);
> +        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> +                                                            QEMU_PLUGIN_=
INLINE_STORE_U64,
> +                                                            has_from, ha=
s_next);
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
> +                                               QEMU_PLUGIN_CB_NO_REGS, N=
ULL);
> +    }
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info,
> +                                           int argc, char **argv)
> +{
> +    /* Set defaults */
> +    abort_on_mismatch =3D true;
> +    trace_all_insns =3D false;
> +
> +    for (int i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
> +        if (g_strcmp0(tokens[0], "abort") =3D=3D 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
> +                                        &abort_on_mismatch)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
> +                return -1;
> +            }
> +        } else if (g_strcmp0(tokens[0], "trace-all") =3D=3D 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
> +                                        &trace_all_insns)) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
> +                return -1;
> +            }
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    states =3D qemu_plugin_scoreboard_new(sizeof(struct cpu_state));
> +    last_pc =3D qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_=
state,
> +                                                   last_pc);
> +    from_pc =3D qemu_plugin_scoreboard_u64_in_struct(states, struct cpu_=
state,
> +                                                   from_pc);
> +    has_from =3D qemu_plugin_scoreboard_u64_in_struct(states, struct cpu=
_state,
> +                                                    has_from);
> +
> +    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
> +                                        vcpu_discon);
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
> index 61a007d9e7..561584159e 100644
> --- a/tests/tcg/plugins/meson.build
> +++ b/tests/tcg/plugins/meson.build
> @@ -1,6 +1,6 @@
>  t =3D []
>  if get_option('plugins')
> -  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall=
', 'patch']
> +  foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset=
', 'syscall', 'patch']
>      if host_os =3D=3D 'windows'
>        t +=3D shared_module(i, files(i + '.c') + '../../../contrib/plugin=
s/win32_linker.c',
>                          include_directories: '../../../include/qemu',

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

