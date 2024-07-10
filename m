Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B16C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRTBC-0003Sw-Qf; Wed, 10 Jul 2024 05:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRTBA-0003RX-Ji
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:00:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRTB8-0003nr-HJ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:00:00 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77e392f59fso467681266b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720601997; x=1721206797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lcI2dBBsPvSO/lJmKgRrL+54h/2oCtXfFEY9Dy62S6E=;
 b=KMqJ+Nb2uZkpo/u+4osvKxZPVtz4oOJPEeitKkKCbqvYLbKP/2SpfUJeJHs2b8A8A1
 8P3petpVJP74YvKsrjsCBdy8kKHjMvRBQE5FH6uJuye3gwV8DbUp/nMTfNhU0UrVHM3n
 J3h1osJdGOsyYIAC3qhgzqAtrq8l8F0PIynnFMony5d2owWyQRGuBKEnkPNDMaRCRJNz
 AKXYy8ML318bgtvNsKyAkkJbCpTFjkZyhM9Y+VwmTGn3jJWkGulxTcys3MtUUIZoGf1O
 j89jFprkBRf3BLrk7NFGf1eBJzC6zalAjQnLQ5lXAPa3Sto8s9njEs8eRMO7tAMATAN8
 418g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720601997; x=1721206797;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lcI2dBBsPvSO/lJmKgRrL+54h/2oCtXfFEY9Dy62S6E=;
 b=g6oIPIDE3zx760sdwcYLczROEivoxw6uqtExES6gDLsk+lUFBfnUH5i7F+mgcon4hu
 gr/jKB+2/oq2Rzn5bhsNJeitX8cfYlX9e0pp6PQPoPwqZO/M5ZWsMl2oGa0opUJ7InJ/
 QegBbPDcZ7roPBh3MEFJhvqPNtPIY1Gxz4mvm4XTYz0ziF0LqhZxxlx+X3yRyXcPpdA5
 HEdoY8Xdlp9PYUgUaSr3a2TjGJfkFAlWpSdVLLjnHhiWLZYLXcPTBAV2pMbfQ+B+nSuK
 vtBbcTyLpDKwU4rMUBGlDIKkM8mHKQiy6xhS5k7Xzbyl9jxPSD7mf6GseZSt6CUcIo/u
 BK3w==
X-Gm-Message-State: AOJu0Yx2+hb//zauaQv83mwrljbh+pOMQlDGbmAT2TUdbfs5YDAFtJtO
 jenecJJdpbnOiu8NHKQqZLGx400wBZQLt/PKxKhni3O0T9/0ydShjoAQU+i3dYo=
X-Google-Smtp-Source: AGHT+IG4CIbuJOBiOrD42KnHTPM7bUJdPo6NIUOgQStjoBl0zNKZN3EEh/5tz2y6eSY+M5sbWV+Zpw==
X-Received: by 2002:a17:906:4a0e:b0:a77:c95e:9b1a with SMTP id
 a640c23a62f3a-a780b6b1dadmr326317266b.19.1720601996290; 
 Wed, 10 Jul 2024 01:59:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a86f604sm141856366b.207.2024.07.10.01.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:59:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EC675F881;
 Wed, 10 Jul 2024 09:59:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Simon Hamelin <simon.hamelin@grenoble-inp.org>
Cc: qemu-devel@nongnu.org,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] plugins/stoptrigger: TCG plugin to stop execution under
 conditions
In-Reply-To: <20240709134031.85954-1-simon.hamelin@grenoble-inp.org> (Simon
 Hamelin's message of "Tue, 9 Jul 2024 15:40:06 +0200")
References: <20240709134031.85954-1-simon.hamelin@grenoble-inp.org>
Date: Wed, 10 Jul 2024 09:59:55 +0100
Message-ID: <87sewhr59w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
>  contrib/plugins/Makefile      |   1 +
>  contrib/plugins/stoptrigger.c | 125 ++++++++++++++++++++++++++++++++++
>  docs/devel/tcg-plugins.rst    |  22 ++++++
>  3 files changed, 148 insertions(+)
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
> index 0000000000..26b8a78f08
> --- /dev/null
> +++ b/contrib/plugins/stoptrigger.c
> @@ -0,0 +1,125 @@
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
> +#include <assert.h>
> +#include <inttypes.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +static uint64_t icount;
> +static int icount_exit_code;
> +static uint64_t executed_instructions;
> +
> +static bool exit_on_icount;
> +static bool exit_on_address;
> +
> +/* Map trigger addresses to exit code */
> +static GHashTable *addrs_ht;
> +static GMutex addrs_ht_lock;
> +
> +static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
> +{
> +    executed_instructions++;
> +
> +    if (exit_on_icount && executed_instructions > icount) {
> +        /* We shouldn't execute more instructions than specified */
> +        g_assert(executed_instructions =3D=3D icount + 1);
> +        qemu_plugin_outs("icount reached, exiting\n");
> +        exit(icount_exit_code);
> +    }

This would be trivially convertible to a scoreboard, with a counter
increment + conditional call back to helper which would be a lot more
efficient.

> +
> +    if (exit_on_address) {
> +        uint64_t insn_vaddr =3D GPOINTER_TO_UINT(udata);
> +        g_mutex_lock(&addrs_ht_lock);
> +        if (g_hash_table_contains(addrs_ht,
> GUINT_TO_POINTER(insn_vaddr))) {

We know the vaddr at runtime so couldn't we just plant the helper there?

> +            /* Exit triggered by address */
> +            int exit_code =3D GPOINTER_TO_INT(g_hash_table_lookup(addrs_=
ht,
> +                                            GUINT_TO_POINTER(insn_vaddr)=
));
> +            char *msg =3D g_strdup_printf("0x%" PRIx64 " reached, exitin=
g\n",
> +                                        insn_vaddr);
> +            qemu_plugin_outs(msg);
> +            exit(exit_code);

I thing you should split the exit code into a helper so we can have a
common "do something" point for the stoptrigger.

> +        }
> +        g_mutex_unlock(&addrs_ht_lock);
> +    }
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> +{
> +    /* Register vcpu_insn_exec callback on each instruction */
> +    size_t tb_n =3D qemu_plugin_tb_n_insns(tb);
> +    for (size_t i =3D 0; i < tb_n; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> +        uint64_t insn_vaddr =3D qemu_plugin_insn_vaddr(insn);
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
> +                                               QEMU_PLUGIN_CB_NO_REGS,
> +                                               GUINT_TO_POINTER(insn_vad=
dr));
> +    }
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    g_hash_table_destroy(addrs_ht);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int =
argc,
> +                                           char **argv)
> +{
> +    addrs_ht =3D g_hash_table_new(NULL, g_direct_equal);
> +
> +    for (int i =3D 0; i < argc; i++) {
> +        char *opt =3D argv[i];
> +        g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
> +        if (g_strcmp0(tokens[0], "icount") =3D=3D 0) {
> +            g_auto(GStrv) icount_tokens =3D g_strsplit(tokens[1], ":", 2=
);
> +            icount =3D g_ascii_strtoull(icount_tokens[0], NULL, 0);
> +            if (icount < 1 || g_strrstr(icount_tokens[0], "-") !=3D NULL=
) {
> +                fprintf(stderr, "icount parsing failed: '%s' must be a "
> +                        "positive integer\n", icount_tokens[0]);
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

So I can see this being useful for general testing of "did the code get
to this point". However would it be worth considering other cases like
simply stopping the VM or triggering a gdbstub exception?

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

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

