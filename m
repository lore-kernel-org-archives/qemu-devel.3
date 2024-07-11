Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A450C3DA47
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqdo-0003YH-Pa; Thu, 11 Jul 2024 06:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRqdm-0003Xh-L4
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:03:06 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRqdj-0002DQ-O3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:03:06 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a77e392f59fso90051566b.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720692182; x=1721296982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GVa4FCdrynVHdnPZrmO27Ip01jwMO+SUs4Y694PdCfw=;
 b=z41dCM/sEO5gqj2BqWnLxlLuBsRHYiUq9ssbc2bd013wTScZfQxYCzrf1R5Pi2cxmf
 AbdP9qxxwPiFHnEXhBr7J8Tt21G4fGCSTveXTTVcprSA9GtgiQFLeo/h5oAAdum3ihiw
 B1Hhadx7JnR3PK3QQwrnK9a1TnzQYzp46WWqTZcqXZbRblrawW1JD9B+zCWVY2yrPLDn
 w/VHI28SfmWKmTDecmjRZ+VWGSI7c/VIiAmrhxMvXVKKVYQsxck4GwV1W3zpv5CCIdFR
 DYHDZrmUst49P6sbYW908p4h8/sqDCCGnKv/kZwfcFz3CTT8g65bNu69m5ccpI4T1W6W
 wMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720692182; x=1721296982;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVa4FCdrynVHdnPZrmO27Ip01jwMO+SUs4Y694PdCfw=;
 b=vgct8zOAQWgxvyr7AqdqKiaFhMB3F8jlte2EXLvsPiHiXVKYRaCN+6TaNyWtdYkpjR
 ZsWzX1i3WBaCLaqBwhP096EXJditVCgH0CJ/xdhB+qGPFqRmZ4+WKiVbRVVfT8Jastyl
 6R2TeWrTDSrYvjgRYQVrFKvIxr3jRzNCYP4HYmNVt64yfm3YCameXFup/nNXGT3Hv21O
 aHLoU3TLI9ZXLFHtHjmbWIKo8Q/00xTC1MD47G1RqxQQpcz0AnPgMEOdpt1Ur6d7KJBZ
 ouCmh5RULzm71XSOM8FWBaMbD+bA1wAioOqTgHRCrBGyS0PdUQog6HHZfd/eJG+YYjOt
 bF9A==
X-Gm-Message-State: AOJu0YzTZCwYRHWEAMmJh67VHDUC5hmNnpPzAoUOvEwUxM/LrPkKNWlA
 /DRGzD3zdP7GEvw9Pd8W33zNZybVhgvByye6aTuOzy6CIAQNTSuQ5zu6vdg0QGs=
X-Google-Smtp-Source: AGHT+IG8Mhkj1E/Mrik6EzyDIBVY4K2KnCLZHTT/651jfPcsjMJN2E6E0u3+jraddW6GUJrAc/gzBw==
X-Received: by 2002:a17:907:7284:b0:a77:d1ea:ab36 with SMTP id
 a640c23a62f3a-a780b68a2d7mr644445966b.6.1720692181706; 
 Thu, 11 Jul 2024 03:03:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a85459fsm234538966b.160.2024.07.11.03.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 03:03:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 32D965F79A;
 Thu, 11 Jul 2024 11:03:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Simon Hamelin <simon.hamelin@grenoble-inp.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
In-Reply-To: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org> (Simon
 Hamelin's message of "Wed, 10 Jul 2024 14:08:55 +0200")
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
Date: Thu, 11 Jul 2024 11:03:00 +0100
Message-ID: <87jzhsqm97.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Simon Hamelin <simon.hamelin@grenoble-inp.org> writes:

> This new plugin allows to stop emulation using conditions on the
> emulation state. By setting this plugin arguments, it is possible
> to set an instruction count limit and/or trigger address(es) to stop at.
> The code returned at emulation exit can be customized.
>
> This plugin demonstrates how someone could stop QEMU execution.
> It could be used for research purposes to launch some code and
> deterministically stop it and understand where its execution flow went.
>
> Co-authored-by: Alexandre Iooss <erdnaxe@crans.org>
> Signed-off-by: Simon Hamelin <simon.hamelin@grenoble-inp.org>
> Signed-off-by: Alexandre Iooss <erdnaxe@crans.org>
> ---
> v2:
>   - use a scoreboard for counting instructions
>   - no longer hook each instruction to exit at given address
>   - add `exit_emulation` function for future use case such as stopping th=
e VM or triggering a gdbstub exception
>
>  contrib/plugins/Makefile      |   1 +
>  contrib/plugins/stoptrigger.c | 150 ++++++++++++++++++++++++++++++++++
>  docs/devel/tcg-plugins.rst    |  22 +++++
>  3 files changed, 173 insertions(+)
>  create mode 100644 contrib/plugins/stoptrigger.c
>
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index 449ead1130..98a89d5c40 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -28,6 +28,7 @@ NAMES +=3D hwprofile
>  NAMES +=3D cache
>  NAMES +=3D drcov
>  NAMES +=3D ips
> +NAMES +=3D stoptrigger
>=20=20
>  ifeq ($(CONFIG_WIN32),y)
>  SO_SUFFIX :=3D .dll
> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
> new file mode 100644
> index 0000000000..9c23f5854e
> --- /dev/null
> +++ b/contrib/plugins/stoptrigger.c
> @@ -0,0 +1,150 @@
> +/*
> + * Copyright (C) 2024, Simon Hamelin <simon.hamelin@grenoble-inp.org>
> + *
> + * Stop execution once a given address is reached or if the
> + * count of executed instructions reached a specified limit
> + *
> + * License: GNU GPL, version 2 or later.
> + *   See the COPYING file in the top-level directory.
> + */
> +

you are missing a glib.h include here

> +#include <assert.h>
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +/* Scoreboard to track executed instructions count */
> +typedef struct {
> +    uint64_t insn_count;
> +} InstructionsCount;
> +static struct qemu_plugin_scoreboard *insn_count_sb;
> +static qemu_plugin_u64 insn_count;
> +
> +static uint64_t icount;
> +static int icount_exit_code;
> +
> +static bool exit_on_icount;
> +static bool exit_on_address;
> +
> +/* Map trigger addresses to exit code */
> +static GHashTable *addrs_ht;
> +static GMutex addrs_ht_lock;
> +
> +static void exit_emulation(int return_code)
> +{
> +    exit(return_code);
> +}
> +
> +static void exit_icount_reached(unsigned int cpu_index, void *udata)
> +{
> +    qemu_plugin_outs("icount reached, exiting\n");
> +    exit_emulation(icount_exit_code);
> +}
> +
> +static void exit_address_reached(unsigned int cpu_index, void *udata)
> +{
> +    uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
> +    g_mutex_lock(&addrs_ht_lock);
> +    int exit_code =3D GPOINTER_TO_INT(
> +        g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
> +    g_mutex_unlock(&addrs_ht_lock);
> +    char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n",
> insn_vaddr);

Dont intermix variable declarations, put them at the top of the block.

> +    qemu_plugin_outs(msg);
> +    exit_emulation(exit_code);
> +}

How about something like:

  static void exit_emulation(int return_code, char *message)
  {
      qemu_plugin_outs(message);
      g_free(message);
      exit(return_code);
  }

  static void exit_icount_reached(unsigned int cpu_index, void *udata)
  {
      uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
      char *msg =3D g_strdup_printf("icount reached at 0x%" PRIx64 ", exiti=
ng\n", insn_vaddr);

      exit_emulation(icount_exit_code, msg);
  }

  static void exit_address_reached(unsigned int cpu_index, void *udata)
  {
      uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
      char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exiting\n", ins=
n_vaddr);
      int exit_code;

      g_mutex_lock(&addrs_ht_lock);
      exit_code =3D GPOINTER_TO_INT(
          g_hash_table_lookup(addrs_ht, GUINT_TO_POINTER(insn_vaddr)));
      g_mutex_unlock(&addrs_ht_lock);

      exit_emulation(exit_code, msg);
  }


> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    size_t tb_n =3D qemu_plugin_tb_n_insns(tb);
> +    for (size_t i =3D 0; i < tb_n; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);

might as well just cast it once:

        gpointer insn_vaddr =3D GUINT_TO_POINTER(qemu_plugin_insn_vaddr(ins=
n));


> +
> +        if (exit_on_icount) {
> +            /* Increment and check scoreboard for each instruction */
> +            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
> +            qemu_plugin_register_vcpu_insn_exec_cond_cb(
> +                insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
> +                QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);

Might be useful to report the PC at which you reach the icount boundary

> +        }
> +
> +        if (exit_on_address) {
> +            g_mutex_lock(&addrs_ht_lock);
> +            if (g_hash_table_contains(addrs_ht, GUINT_TO_POINTER(insn_va=
ddr))) {
> +                /* Exit triggered by address */
> +                qemu_plugin_register_vcpu_insn_exec_cb(
> +                    insn, exit_address_reached, QEMU_PLUGIN_CB_NO_REGS,
> +                    GUINT_TO_POINTER(insn_vaddr));
> +            }
> +            g_mutex_unlock(&addrs_ht_lock);
> +        }
> +    }
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_hash_table_destroy(addrs_ht);
> +    qemu_plugin_scoreboard_free(insn_count_sb);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int =
argc,
> +                                           char **argv)
> +{
> +    addrs_ht =3D g_hash_table_new(NULL, g_direct_equal);
> +
> +    insn_count_sb =3D qemu_plugin_scoreboard_new(sizeof(InstructionsCoun=
t));
> +    insn_count =3D qemu_plugin_scoreboard_u64_in_struct(
> +        insn_count_sb, InstructionsCount, insn_count);
> +
> +    for (int i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
> +        if (g_strcmp0(tokens[0], "icount") =3D=3D 0) {
> +            g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1], ":", 2=
);
> +            icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);



> +            if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D
> NULL) {

I don't think strstoull would even parse something with - in it so I
would just do:

  if (icount =3D=3D 0) {
     /* fail */
  }

> +                fprintf(stderr,
> +                        "icount parsing failed: '%s' must be a positive "
> +                        "integer\n",
> +                        icount_tokens[0]);
> +                return -1;
> +            }
> +            if (icount_tokens[1]) {
> +                icount_exit_code =3D g_ascii_strtoull(icount_tokens[1], =
NULL, 0);
> +            }
> +            exit_on_icount =3D true;
> +        } else if (g_strcmp0(tokens[0], "addr") =3D=3D 0) {
> +            g_auto(GStrv) addr_tokens =3D g_strsplit(tokens[1], ":", 2);
> +            uint64_t exit_addr =3D g_ascii_strtoull(addr_tokens[0], NULL=
, 0);
> +            int exit_code =3D 0;
> +            if (addr_tokens[1]) {
> +                exit_code =3D g_ascii_strtoull(addr_tokens[1], NULL, 0);
> +            }
> +            g_mutex_lock(&addrs_ht_lock);
> +            g_hash_table_insert(addrs_ht, GUINT_TO_POINTER(exit_addr),
> +                                GINT_TO_POINTER(exit_code));
> +            g_mutex_unlock(&addrs_ht_lock);
> +            exit_on_address =3D true;
> +        } else {
> +            fprintf(stderr, "option parsing failed: %s\n", opt);
> +            return -1;
> +        }
> +    }
> +
> +    if (!exit_on_icount && !exit_on_address) {
> +        fprintf(stderr, "'icount' or 'addr' argument missing\n");
> +        return -1;
> +    }
> +
> +    /* Register translation block and exit callbacks */
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +
> +    return 0;
> +}
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index f7d7b9e3a4..954623f9bf 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -642,6 +642,28 @@ The plugin has a number of arguments, all of them ar=
e optional:
>    configuration arguments implies ``l2=3Don``.
>    (default: N =3D 2097152 (2MB), B =3D 64, A =3D 16)
>=20=20
> +- contrib/plugins/stoptrigger.c
> +
> +The stoptrigger plugin allows to setup triggers to stop emulation.
> +It can be used for research purposes to launch some code and precisely s=
top it
> +and understand where its execution flow went.
> +
> +Two types of triggers can be configured: a count of instructions to stop=
 at,
> +or an address to stop at. Multiple triggers can be set at once.
> +
> +By default, QEMU will exit with return code 0. A custom return code can =
be
> +configured for each trigger using ``:CODE`` syntax.
> +
> +For example, to stop at the 20-th instruction with return code 41, at ad=
dress
> +0xd4 with return code 0 or at address 0xd8 with return code 42::
> +
> +  $ qemu-system-aarch64 $(QEMU_ARGS) \
> +    -plugin ./contrib/plugins/libstoptrigger.so,icount=3D20:41,addr=3D0x=
d4,addr=3D0xd8:42 -d plugin
> +
> +The plugin will log the reason of exit, for example::
> +
> +  0xd4 reached, exiting
> +
>  Plugin API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Otherwise it looks good to me. Unless you want to tackle additional exit
modes?

What is your current use case for this?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

