Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2F6C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZMl-0003Uf-Gu; Fri, 21 Jun 2024 04:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKZMi-0003Sx-Qb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:11:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKZMg-0000pb-V3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:11:24 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d07464aa9so1588208a12.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957481; x=1719562281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJpl3WyDOG4SI7iSs7JhyIMcBCD6dm+TahYRm3Dos2E=;
 b=GcVbGvoOaeiFp6Z8LceUFQkaJVJ46YH8E2P1c2ASJ9EnLzuxa/wf9c1dtfGUU/bXu+
 WUnB3VN1gECJgn9EaDGyIoDTaQH0TqsElk2LPP/dGcriJxdXz425OvZO2RgjIijB/1ee
 PTcAb4fsnt4UbGhZ42qujuYUoElrfPcbB6XzJD1NwBvWU9IwR28hguzgZUp7qrfuYLRh
 pz91wQmRX181oZIsupjzl0pXcDv/LdsdUbmIF1ycqXhgff3RzxB44RAnsQGs7FWZeLqC
 4GoXy2yhAJH81SLJCeHGui6bBb9gPKF/cf1EGZuES0Ja/b9iB1MEePEBFhWyKZhx0ddQ
 gXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957481; x=1719562281;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJpl3WyDOG4SI7iSs7JhyIMcBCD6dm+TahYRm3Dos2E=;
 b=hBJOLd+SGJtNtsTmHLnSOr1g4kQOoR6pKYiQAUmi3B4iD0+zswCm0KxrZyfX4ofXBb
 bleZCQMU35hYAIyccrf91yRS4p8gbKYqVBjuqxhkTfJX9PMTJktPrSaAz17Gi1QjMhMF
 0xryTMp6r0s5s4kHnwL3+KtSWCx1WLiFzfInXEOu4SqVL7uoqoEY7FO74mSpz22UCOHC
 Z607BhqCnR8noE+NsbZyexQt36ZrrEY8RmRms375b0RMVm7uYkk1tEY2V3sb3z9t9EwA
 UxdbOlhv7atqol2dUaXdup4H4aSHDLzpwU7yNCGESj4Sa5HEa46vBFJHdQBYv3yfr0De
 TaUQ==
X-Gm-Message-State: AOJu0Yxm+TCnnivyr+5YKuGZH3yHHjNdeXWZ80NjtezL9Xc1iivVAVhg
 Qp+GXfyd8CTw2fWjaTFk9Z2VmxjlNyg3rAo6DqDchzUJuGf+P+r91fZ4CtQCrkV5IHsyaqVfhOa
 j
X-Google-Smtp-Source: AGHT+IGG8W5+AH53D7uqFrf5JnON+q8H6bp7Z+DOBrJfRV54AIpvGLoFTG1iKTueaZaIkNJcThZn4w==
X-Received: by 2002:a17:907:7ba8:b0:a6c:6fac:f1ff with SMTP id
 a640c23a62f3a-a6fab60968fmr638445966b.12.1718957480628; 
 Fri, 21 Jun 2024 01:11:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf56096csm56026266b.149.2024.06.21.01.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 01:11:17 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3EAE75F7A3;
 Fri, 21 Jun 2024 09:11:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v3 3/9] gdbstub: Add support for target-specific stubs
In-Reply-To: <20240617062849.3531745-4-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Mon, 17 Jun 2024 06:28:43 +0000")
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-4-gustavo.romero@linaro.org>
Date: Fri, 21 Jun 2024 09:11:16 +0100
Message-ID: <87ed8qhg0r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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
> This commit introduces gdb_extend_qsupported_features,
> gdb_extend_query_table, and gdb_extend_set_table functions as interfaces
> to extend the qSupported string, the query handler table, and the set
> handler table, allowing target-specific stub implementations.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  gdbstub/gdbstub.c          | 59 ++++++++++++++++++++++++++++++++++----
>  include/gdbstub/commands.h | 22 ++++++++++++++
>  2 files changed, 75 insertions(+), 6 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 9ff2f4177d..e69cc5131e 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1609,6 +1609,12 @@ static void handle_query_thread_extra(GArray *para=
ms, void *user_ctx)
>      gdb_put_strbuf();
>  }
>=20=20
> +static char *extended_qsupported_features;
> +void gdb_extend_qsupported_features(char *qsupported_features)
> +{

  /*
   * We don't support different sets of CPU gdb features on different
   * CPUs yet so assert things are the same.
   */

   g_assert(!extended_qsupported_features ||
   g_strcmp0(extended_qsupported_features, qsupported_features) =3D=3D 0)

> +    extended_qsupported_features =3D qsupported_features;
> +}
> +
>  static void handle_query_supported(GArray *params, void *user_ctx)
>  {
>      CPUClass *cc;
> @@ -1648,6 +1654,11 @@ static void handle_query_supported(GArray *params,=
 void *user_ctx)
>      }
>=20=20
>      g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiproc=
ess+");
> +
> +    if (extended_qsupported_features) {
> +        g_string_append(gdbserver_state.str_buf, extended_qsupported_fea=
tures);
> +    }
> +
>      gdb_put_strbuf();
>  }
>=20=20
> @@ -1729,6 +1740,14 @@ static const GdbCmdParseEntry gdb_gen_query_set_co=
mmon_table[] =3D {
>      },
>  };
>=20=20
> +static GdbCmdParseEntry *extended_query_table;
> +static int extended_query_table_size;
> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size)
> +{
> +    extended_query_table =3D table;
> +    extended_query_table_size =3D size;

Similar assert here.

> +}
> +
>  static const GdbCmdParseEntry gdb_gen_query_table[] =3D {
>      {
>          .handler =3D handle_query_curr_tid,
> @@ -1821,6 +1840,14 @@ static const GdbCmdParseEntry gdb_gen_query_table[=
] =3D {
>  #endif
>  };
>=20=20
> +static GdbCmdParseEntry *extended_set_table;
> +static int extended_set_table_size;
> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size)
> +{

ditto

> +    extended_set_table =3D table;
> +    extended_set_table_size =3D size;
> +}
> +
>  static const GdbCmdParseEntry gdb_gen_set_table[] =3D {
>      /* Order is important if has same prefix */
>      {
> @@ -1859,11 +1886,21 @@ static void handle_gen_query(GArray *params, void=
 *user_ctx)
>          return;
>      }
>=20=20
> -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> -                            gdb_gen_query_table,
> -                            ARRAY_SIZE(gdb_gen_query_table))) {
> -        gdb_put_packet("");
> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +                           gdb_gen_query_table,
> +                           ARRAY_SIZE(gdb_gen_query_table))) {
> +        return;
> +    }
> +
> +    if (extended_query_table &&
> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +                           extended_query_table,
> +                           extended_query_table_size)) {
> +        return;
>      }
> +
> +    /* Can't handle query, return Empty response. */
> +    gdb_put_packet("");
>  }
>=20=20
>  static void handle_gen_set(GArray *params, void *user_ctx)
> @@ -1878,11 +1915,21 @@ static void handle_gen_set(GArray *params, void *=
user_ctx)
>          return;
>      }
>=20=20
> -    if (!process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +    if (process_string_cmd(gdb_get_cmd_param(params, 0)->data,
>                             gdb_gen_set_table,
>                             ARRAY_SIZE(gdb_gen_set_table))) {
> -        gdb_put_packet("");
> +        return;
>      }
> +
> +    if (extended_set_table &&
> +        process_string_cmd(gdb_get_cmd_param(params, 0)->data,
> +                           extended_set_table,
> +                           extended_set_table_size)) {
> +        return;
> +    }
> +
> +    /* Can't handle set, return Empty response. */
> +    gdb_put_packet("");
>  }
>=20=20
>  static void handle_target_halt(GArray *params, void *user_ctx)
> diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
> index dd45c38472..2204c3ddbe 100644
> --- a/include/gdbstub/commands.h
> +++ b/include/gdbstub/commands.h
> @@ -71,4 +71,26 @@ typedef struct GdbCmdParseEntry {
>   */
>  int gdb_put_packet(const char *buf);
>=20=20
> +/**
> + * gdb_extend_query_table() - Extend query table.
> + * @table: The table with the additional query packet handlers.
> + * @size: The number of handlers to be added.
> + */
> +void gdb_extend_query_table(GdbCmdParseEntry *table, int size);
> +
> +/**
> + * gdb_extend_set_table() - Extend set table.
> + * @table: The table with the additional set packet handlers.
> + * @size: The number of handlers to be added.
> + */
> +void gdb_extend_set_table(GdbCmdParseEntry *table, int size);
> +
> +/**
> + * gdb_extend_qsupported_features() - Extend the qSupported features str=
ing.
> + * @qsupported_features: The additional qSupported feature(s) string. Th=
e string
> + * should start with a semicolon and, if there are more than one feature=
, the
> + * features should be separate by a semiocolon.
> + */
> +void gdb_extend_qsupported_features(char *qsupported_features);
> +
>  #endif /* GDBSTUB_COMMANDS_H */

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

