Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C629C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzkz-0004rN-3y; Tue, 28 May 2024 12:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBzkw-0004nT-F5
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:32:58 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sBzkt-0003oe-S2
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:32:58 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-529c0d5001eso139422e87.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716913974; x=1717518774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5hsirNsn/aqEcu5qPIsgiPP2+FUTu1Z2LdkAkipPhTE=;
 b=V20iYFwm5Ql+Gep24hfsJDEkuJC0b5quaSJzTfRCEclDjnkr8ysRk5GI8JARF2lSrF
 MH6Z05oXvJjpwkSSqiHRrfwbWPM27a05ldD6BZQ61qENujbFljqMIhzNV6ReQZsh4Tss
 buND79tJZQP/XUSH8iO6i2BF7Mq7+wEfP6ZVwg9GCdXtuKKsxlgSJtU7geO/ql91q336
 gqNEPjYncCopi+bh1Qc5q5FIHDcncD/HemSXen6rt8WST15eLyAoClCCfUBiKAZAjusj
 abp85AAcW61378E8iK9f+NyIlAMAkYqb/bTxeVjXXrwl4MCJHgObKQFqCSin9pP4sgxg
 xISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716913974; x=1717518774;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5hsirNsn/aqEcu5qPIsgiPP2+FUTu1Z2LdkAkipPhTE=;
 b=YkDcm1TXrL69svai4Op7ZnSCRRcagNL2ayUUFdTAYLxF3YyBG+hA5guQp88bSP1Iih
 uprltoPqSb7fj3kasmR2eNs4uHT5rw6r1eVkFMFsPRXrw3ZRuNIqE7fZcYfpuCsQsCcf
 Tqlr4KRa54ENikqQHdViJVjSB7gCmKuSA5THr1IujwE0lkN5jhkaCAFhy82z4lmT8bW9
 vV90n/qvvosLfo+qAf7v+BNMHWkfwjZIEu47GDx79db7PavfbIsZrPJcG91UYnQAKzCF
 8UP0zUNEDG0eexZmhMeFgdLQhqxCMVlDac5X3LAu5da5JOKo4F/xtpA6x4YgFs6hLO3j
 54Tg==
X-Gm-Message-State: AOJu0YxbQFePq83B/BBE53scgLBDfuScnqXMucAHzAlKT/MXFwUl6nrx
 kCvRnx0oKRYmpicZB2UqVKk0itl57b5Fo5FdXUuTaFAsjuzHNA2hNg/IQO9kVFk=
X-Google-Smtp-Source: AGHT+IHqEOQN1wHkIianWsj5Ivcr2ueTgHwh+CCk8tJQsmVo95NMkVl+xfkxDVID2H2y1JXsEArIog==
X-Received: by 2002:a05:6512:b9e:b0:529:b79f:ab1d with SMTP id
 2adb3069b0e04-529b79face8mr2801856e87.22.1716913973837; 
 Tue, 28 May 2024 09:32:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c81734csm626267966b.45.2024.05.28.09.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 09:32:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D09B75F88D;
 Tue, 28 May 2024 17:32:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH 1/4] gdbstub: Add support for target-specific stubs
In-Reply-To: <20240515173132.2462201-2-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Wed, 15 May 2024 17:31:29 +0000")
References: <20240515173132.2462201-1-gustavo.romero@linaro.org>
 <20240515173132.2462201-2-gustavo.romero@linaro.org>
Date: Tue, 28 May 2024 17:32:52 +0100
Message-ID: <87h6ehgamj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12e.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Currently, it's not possible to have stubs specific to a given target,
> even though there are GDB features which are target-specific, like, for
> instance, memory tagging.
>
> This commit introduces set_query_supported_arch,
> set_gdb_gen_query_table_arch, and set_gdb_gen_set_table_arch functions
> as interfaces to extend the qSupported string, the query handler table,
> and set handler table per target, so allowing target-specific stub
> implementation.

Subsystem functions exposed to the wider QEMU should be prefixed by the
subsystem name (e.g. gdb_*).

> Besides that, it moves GdbCmdParseEntry struct, its related types, and
> gdb_put_packet to include/exec/gdbstub.h so they are also available in
> the target-specific stubs.

Generally I'm trying to reduce the amount of stuff that gets dumped in
here because it is included widely and if your not careful you start
winding yourself into knots.

Could we put the command specific stuff into include/gdbstub/commands.h
and only include it when needed?

In general I think we could make the series a little more granular:

  - move GdbCmdParseEntry into headers
  - clean-up process_string_cmd
  - introduce new gdb_ APIs

That will reduce the size of the individual patches and make review a
bit easier.

>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  gdbstub/gdbstub.c      | 108 +++++++++++++++++++++++------------------
>  gdbstub/internals.h    |  22 ---------
>  gdbstub/syscalls.c     |   1 +
>  include/exec/gdbstub.h |  86 +++++++++++++++++++++++++++++++-
>  4 files changed, 147 insertions(+), 70 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b3574997ea..4996530fde 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -920,43 +920,6 @@ static int cmd_parse_params(const char *data, const =
char *schema,
>      return 0;
>  }
>=20=20
> -typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
> -
> -/*
> - * cmd_startswith -> cmd is compared using startswith
> - *
> - * allow_stop_reply -> true iff the gdbstub can respond to this command =
with a
> - *   "stop reply" packet. The list of commands that accept such response=
 is
> - *   defined at the GDB Remote Serial Protocol documentation. see:
> - *   https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#S=
top-Reply-Packets.
> - *
> - * schema definitions:
> - * Each schema parameter entry consists of 2 chars,
> - * the first char represents the parameter type handling
> - * the second char represents the delimiter for the next parameter
> - *
> - * Currently supported schema types:
> - * 'l' -> unsigned long (stored in .val_ul)
> - * 'L' -> unsigned long long (stored in .val_ull)
> - * 's' -> string (stored in .data)
> - * 'o' -> single char (stored in .opcode)
> - * 't' -> thread id (stored in .thread_id)
> - * '?' -> skip according to delimiter
> - *
> - * Currently supported delimiters:
> - * '?' -> Stop at any delimiter (",;:=3D\0")
> - * '0' -> Stop at "\0"
> - * '.' -> Skip 1 char unless reached "\0"
> - * Any other value is treated as the delimiter value itself
> - */
> -typedef struct GdbCmdParseEntry {
> -    GdbCmdHandler handler;
> -    const char *cmd;
> -    bool cmd_startswith;
> -    const char *schema;
> -    bool allow_stop_reply;
> -} GdbCmdParseEntry;
> -
>  static inline int startswith(const char *string, const char *pattern)
>  {
>    return !strncmp(string, pattern, strlen(pattern));
> @@ -1645,6 +1608,13 @@ static void handle_query_thread_extra(GArray *para=
ms, void *user_ctx)
>      gdb_put_strbuf();
>  }
>=20=20
> +/* Arch-specific qSupported */
> +char *query_supported_arch =3D NULL;

This should be static.

> +void set_query_supported_arch(char *query_supported)
> +{
> +    query_supported_arch =3D query_supported;
> +}
> +

Maybe gdb_extended_qsupported_features?

>  static void handle_query_supported(GArray *params, void *user_ctx)
>  {
>      CPUClass *cc;
> @@ -1684,6 +1654,11 @@ static void handle_query_supported(GArray *params,=
 void *user_ctx)
>      }
>=20=20
>      g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiproc=
ess+");
> +
> +    if (query_supported_arch) {
> +        g_string_append(gdbserver_state.str_buf, query_supported_arch);
> +    }
> +
>      gdb_put_strbuf();
>  }
>=20=20
> @@ -1765,6 +1740,16 @@ static const GdbCmdParseEntry gdb_gen_query_set_co=
mmon_table[] =3D {
>      },
>  };
>=20=20
> +
> +/* Arch-specific query table */
> +static GdbCmdParseEntry *gdb_gen_query_table_arch =3D NULL ;
> +static int gdb_gen_query_table_arch_size =3D 0;

For local statics you don't need prefixes if this saves on variables
getting too large. Also you don't need init to NULL/0 for statics.

> +void set_gdb_gen_query_table_arch(GdbCmdParseEntry  *table, int size)
> +{
> +    gdb_gen_query_table_arch =3D table;
> +    gdb_gen_query_table_arch_size =3D size;
> +}
> +
>  static const GdbCmdParseEntry gdb_gen_query_table[] =3D {
>      {
>          .handler =3D handle_query_curr_tid,
> @@ -1857,6 +1842,15 @@ static const GdbCmdParseEntry gdb_gen_query_table[=
] =3D {
>  #endif
>  };
>=20=20
> +/* Arch-specific set table */
> +static GdbCmdParseEntry *gdb_gen_set_table_arch =3D NULL;
> +static int gdb_gen_set_table_arch_size =3D 0;
> +void set_gdb_gen_set_table_arch(GdbCmdParseEntry *table, int size)
> +{
> +    gdb_gen_set_table_arch =3D table;
> +    gdb_gen_set_table_arch_size =3D size;
> +}
> +
>  static const GdbCmdParseEntry gdb_gen_set_table[] =3D {
>      /* Order is important if has same prefix */
>      {
> @@ -1889,17 +1883,27 @@ static void handle_gen_query(GArray *params, void=
 *user_ctx)
>          return;
>      }
>=20=20
> -    if (!process_string_cmd(get_param(params, 0)->data,
> -                            gdb_gen_query_set_common_table,
> -                            ARRAY_SIZE(gdb_gen_query_set_common_table)))=
 {
> +    if (process_string_cmd(get_param(params, 0)->data,
> +                           gdb_gen_query_set_common_table,
> +                           ARRAY_SIZE(gdb_gen_query_set_common_table)) =
=3D=3D 0) {
>          return;
>      }

I think changing the process_string_cmd to return bool on success could
be a pre-cursor patch.

>=20=20
>      if (process_string_cmd(get_param(params, 0)->data,
>                             gdb_gen_query_table,
> -                           ARRAY_SIZE(gdb_gen_query_table))) {
> -        gdb_put_packet("");
> +                           ARRAY_SIZE(gdb_gen_query_table)) =3D=3D 0) {
> +        return;
>      }
> +
> +    if (gdb_gen_query_table_arch &&
> +        process_string_cmd(get_param(params, 0)->data,
> +                           gdb_gen_query_table_arch,
> +                           gdb_gen_query_table_arch_size) =3D=3D 0) {
> +        return;
> +    }
> +
> +    /* Can't handle query, return Empty response. */
> +    gdb_put_packet("");
>  }
>=20=20
<snip>
> diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
> index 02e3a8f74c..ee9a16495e 100644
> --- a/gdbstub/syscalls.c
> +++ b/gdbstub/syscalls.c
> @@ -18,6 +18,7 @@
>  #include "gdbstub/syscalls.h"
>  #include "trace.h"
>  #include "internals.h"
> +#include "exec/gdbstub.h"

This looks like a stray - it would be clearer once split out anyway.

>=20=20
>  /* Syscall specific state */
>  typedef struct {
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index eb14b91139..7bf189d7f3 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -144,4 +144,88 @@ void gdb_set_stop_cpu(CPUState *cpu);
>  /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>  extern const GDBFeature gdb_static_features[];
>=20=20
> -#endif
> +typedef void (*GdbCmdHandler)(GArray *params, void *user_ctx);
> +
> +typedef enum GDBThreadIdKind {
> +    GDB_ONE_THREAD =3D 0,
> +    GDB_ALL_THREADS,     /* One process, all threads */
> +    GDB_ALL_PROCESSES,
> +    GDB_READ_THREAD_ERR
> +} GDBThreadIdKind;
> +
> +typedef union GdbCmdVariant {
> +    const char *data;
> +    uint8_t opcode;
> +    unsigned long val_ul;
> +    unsigned long long val_ull;
> +    struct {
> +        GDBThreadIdKind kind;
> +        uint32_t pid;
> +        uint32_t tid;
> +    } thread_id;
> +} GdbCmdVariant;
> +
> +#define get_param(p, i)    (&g_array_index(p, GdbCmdVariant, i))

This will need renaming if its public outside of gdbstub. gdb_get_cmd_param?

> +
> +/*

If this is moving to a public API could you kdoc the description when
you move it please?

> + * cmd_startswith -> cmd is compared using startswith
> + *
> + * allow_stop_reply -> true iff the gdbstub can respond to this command =
with a
> + *   "stop reply" packet. The list of commands that accept such response=
 is
> + *   defined at the GDB Remote Serial Protocol documentation. see:
> + *   https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#S=
top-Reply-Packets.
> + *
> + * schema definitions:
> + * Each schema parameter entry consists of 2 chars,
> + * the first char represents the parameter type handling
> + * the second char represents the delimiter for the next parameter
> + *
> + * Currently supported schema types:
> + * 'l' -> unsigned long (stored in .val_ul)
> + * 'L' -> unsigned long long (stored in .val_ull)
> + * 's' -> string (stored in .data)
> + * 'o' -> single char (stored in .opcode)
> + * 't' -> thread id (stored in .thread_id)
> + * '?' -> skip according to delimiter
> + *
> + * Currently supported delimiters:
> + * '?' -> Stop at any delimiter (",;:=3D\0")
> + * '0' -> Stop at "\0"
> + * '.' -> Skip 1 char unless reached "\0"
> + * Any other value is treated as the delimiter value itself
> + */
> +typedef struct GdbCmdParseEntry {
> +    GdbCmdHandler handler;
> +    const char *cmd;
> +    bool cmd_startswith;
> +    const char *schema;
> +    bool allow_stop_reply;
> +} GdbCmdParseEntry;
> +
> +#define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
> +
> +/**
> + * set_gdb_gen_query_table_arch() - set a table to handle arch-specific =
query
> + * packets
> + */
> +void set_gdb_gen_query_table_arch(GdbCmdParseEntry *table, int size);
> +
> +/**
> + * set_gdb_gen_set_table_arch() - set a table to handle arch-specific set
> + * packets
> + */
> +void set_gdb_gen_set_table_arch(GdbCmdParseEntry *, int size);
> +
> +/**
> + * set_query_supported_arch() - set arch-specific features in qSupported
> + * features
> + */
> +void set_query_supported_arch(char *);
> +
> +/**
> + * gdb_put_packet() - put string into gdb server's buffer so it is sent
> + * to the client
> + */
> +int gdb_put_packet(const char *buf);
> +
> +#endif /* GDBSTUB_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

