Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C9FC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNj3-0003RU-5K; Tue, 20 May 2025 10:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHNj1-0003Qp-GA
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:13:47 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHNiz-0000Mm-BI
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:13:47 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad5574b59c0so512113966b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747750420; x=1748355220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbOdAnV4DJqwjOe/8JB8ZpRI9wG7oTdNA6cqFcJGHH4=;
 b=Jn2jWj2yQZW3bjvRcaS+Ohp51lQIOIJChFLdEbwU414NFTN8q73vj4ZZ7szV6LXdY5
 o59i6BPQNJAhsNJyfwDFZUlIBce70iPioN1doCbFSr/u7jVEHw8kIGyxjjBcapJhqytq
 /Gqeqgv41zw9+0jZ1AkcEek6KNXMQLcOUyS0Kxb3R5HEvlZn3gyvdHi1AOdfhT9fiD8S
 AQe1z0ASzXAdWUCa0B/o0EfbQuC1K2jMMlzFpomGCZuEmmUoHvlfA+F6tM7f7h1aV9gA
 jnhNRH0hzUPS8xZsQ4fwfTOXYTe1vVqD063vYv2W2K7GkPe5Ry1qSw7+gOWG5rB1N1OI
 3pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747750420; x=1748355220;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZbOdAnV4DJqwjOe/8JB8ZpRI9wG7oTdNA6cqFcJGHH4=;
 b=KJXQQ1id1WmnxZNx63AiXY8F6LD51cvxzlobZvu8y6kGX0KNVMVy6cTN3f7IDRrNAK
 OM2wJRrGdI+e7Vkyfob5uL59HQ6gMvUWG/kH+XCMEcUoiSILAFbPspmZkIY34RGjEi5o
 EPikVV4XflKkmtLou1O3EuZEzZ68OXIjaKlTfjCpBTrWQdcjWCRphxJPmciZ85jKJv87
 sCsrlCazZkcfYGhQCWHqU5QRv63HXYTgULc2H8UqCZArerM3e+sTLj+egRbXdyPzuKdI
 O67eUJUCBtHKH91ra9M2mGP/7a4uMKS5oZCHZ1faHBDjc8a3my/OjFEbwHu573UK2mKL
 5z9g==
X-Gm-Message-State: AOJu0YwYJT5ESs0ZrvtJify13CMWAA2vqJntNpriE7VcN618kZw0Kv03
 xTEz7B89OJw+/UCH/XYY1+zmC257+cCMiWAXUbBrhfPinWKtBIwjpr8S+XMOe8Ta570=
X-Gm-Gg: ASbGncvUJugJVObOiHSFZ1xj0Ak4DK6Qs4ssdGIbLIgYkeY+RmR50WIAZ1IBTtTO5nd
 YboM0LTw6+dUMpIBoup3L4zz773iw3ZG+wAs9Fb/aasv77Jig7yHNTDuZlDprp8YO4qCwvTBbkD
 LOhhNep5xXHVK3aBQk837K8mCMefTpbxCguOerYb9lvj6WXriIFTrB03TeC/HRJMGKwOyySmnGg
 E+3x1x/wHd2SYDlPmXAz2Oz4L3WtVUmH8EwrcRQBGHi+asZ5Bm/nDJ89n/+b01BNcY8sb222vVt
 qIbfVdKFos8XvTBU7z6xIkE5hRRRdOHWuygFn13MIc4S+U1uUSQG
X-Google-Smtp-Source: AGHT+IGM2urb2qKprERsuxasc/aSR9b2MHRd1i8Ji00f5DXuS60rwsJLcC1ZLdC7WqddbjLv01xYQQ==
X-Received: by 2002:a17:907:7205:b0:ad2:2dc9:e3d3 with SMTP id
 a640c23a62f3a-ad536ffc80dmr1938827766b.57.1747750419518; 
 Tue, 20 May 2025 07:13:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4382d7sm730837466b.117.2025.05.20.07.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 07:13:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B8335F7A5;
 Tue, 20 May 2025 15:13:38 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: steffen_hirschmann@web.de
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Alexandre Iooss
 <erdnaxe@crans.org>
Subject: Re: [PATCH RFC 1/1] TCG insn.c: Implement counting specific addresses
In-Reply-To: <20250430105937.191814-2-steffen_hirschmann@web.de> (steffen
 hirschmann's message of "Wed, 30 Apr 2025 12:59:37 +0200")
References: <20250430105937.191814-1-steffen_hirschmann@web.de>
 <20250430105937.191814-2-steffen_hirschmann@web.de>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 20 May 2025 15:13:38 +0100
Message-ID: <875xhvbca5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

steffen_hirschmann@web.de writes:

> From: Steffen Hirschmann <steffen_hirschmann@web.de>
>
> This commit implements counting of executed instruction within certain
> virtual address ranges via libinsn.so

This seems reasonable. Do you have any specific use cases where this
information is useful?

> Signed-off-by: Steffen Hirschmann <steffen_hirschmann@web.de>
> ---
>  docs/about/emulation.rst |  2 +
>  tests/tcg/plugins/insn.c | 89 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
>
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index a72591ee4d..1fd122bc50 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -336,6 +336,8 @@ Behaviour can be tweaked with the following arguments:
>      - Give a summary of the instruction sizes for the execution
>    * - match=3D<string>
>      - Only instrument instructions matching the string prefix
> +  * - vaddr=3D<start>+<count>
> +    - Counts executed instructions in this virtual address range. <start=
> and <count> must be in base 16
>=20=20
>  The ``match`` option will show some basic stats including how many
>  instructions have executed since the last execution. For
> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
> index 0c723cb9ed..c6d5b07d05 100644
> --- a/tests/tcg/plugins/insn.c
> +++ b/tests/tcg/plugins/insn.c
> @@ -48,6 +48,14 @@ static GHashTable *match_insn_records;
>  static GMutex match_hash_lock;
>=20=20
>=20=20
> +typedef struct {
> +    uint64_t start;
> +    uint64_t end;
> +    qemu_plugin_u64 hits; /* Number of insn executed in this range */
> +} VaddrRange;
> +
> +static GArray *vaddr_ranges;
> +
>  static Instruction * get_insn_record(const char *disas, uint64_t vaddr, =
Match *m)
>  {
>      g_autofree char *str_hash =3D g_strdup_printf("%"PRIx64" %s", vaddr,=
 disas);
> @@ -187,6 +195,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struc=
t qemu_plugin_tb *tb)
>              }
>              g_free(insn_disas);
>          }
> +
> +        for (int j =3D 0; j < vaddr_ranges->len; j++) {
> +            VaddrRange *var =3D &g_array_index(vaddr_ranges, VaddrRange,=
 j);
> +            uint64_t vaddr =3D qemu_plugin_insn_vaddr(insn);
> +            if (var->start <=3D vaddr && vaddr < var->end) {
> +                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                    insn, QEMU_PLUGIN_INLINE_ADD_U64, var->hits, 1);
> +            }
> +        }
>      }
>  }
>=20=20
> @@ -246,6 +263,19 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>=20=20
>      g_array_free(matches, TRUE);
>      g_array_free(sizes, TRUE);
> +
> +    for (i =3D 0; i < vaddr_ranges->len; ++i) {
> +        VaddrRange *var =3D &g_array_index(vaddr_ranges, VaddrRange, i);
> +        uint64_t hits =3D qemu_plugin_u64_sum(var->hits);
> +
> +        g_string_printf(out, "Vaddr range [0x%08lx, 0x%08lx): %"PRId64" =
hits\n",
> +                        var->start, var->end, hits);
> +        qemu_plugin_outs(out->str);
> +        qemu_plugin_scoreboard_free(var->hits.score);
> +    }
> +
> +
> +    g_array_free(vaddr_ranges, TRUE);
>  }
>=20=20
>=20=20
> @@ -258,6 +288,48 @@ static void parse_match(char *match)
>      g_array_append_val(matches, new_match);
>  }
>=20=20
> +static void parse_vaddr(const char *arg)
> +{
> +    char *vaddr =3D g_strdup(arg);

We can make this:

   g_autofree char *vaddr =3D g_strdup(arg);

to save the g_free() later.

> +    char *saveptr, *token1, *token2;
> +    uint64_t start, len, end;
> +    token1 =3D strtok_r(vaddr, "+", &saveptr);
> +    token2 =3D strtok_r(NULL, "+", &saveptr);
> +    if (!token1 || !token2) {
> +        fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base 16!=
)\n");
> +        exit(1);
> +    }

rather than manually messing about with strtok_r how about:

  uint64_t start =3D 0, len =3D 0;
  g_auto(GStrv) tokens =3D g_strsplit(vaddr, "+", 2);

  if (tokens[0] && tokens[2]) {
     start =3D g_ascii_strtoull(tokens[0], NULL, 16);
     len =3D g_ascii_strtoull(tokens[1], NULL, 16);
  }

  if ((start =3D=3D 0 || start =3D=3D GUINT64_MAX) ||
      (len =3D=3D 0 || len =3D=3D GUINT64_MAX)) {
     fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base 16!)\n");
     return false;
  }

Alternatively we already export qemu_plugin_bool_parse() so maybe we
could consider re-factoring qemu_set_dfilter_ranges() to extract the
parser and make it available as a helper?

> +
> +    start =3D g_ascii_strtoull(token1, NULL, 16);
> +    len =3D g_ascii_strtoull(token2, NULL, 16);
> +    end =3D start + len;
> +
> +    g_free(vaddr);

see above

> +
> +    if (start =3D=3D 0 || end =3D=3D 0) {
> +        fprintf(stderr, "vaddr usage: vaddr=3Dstart+count (both base 16!=
)\n");
> +        exit(1);

exit is rude for a plugin, we should fall back to QEMU by returning -1

> +    }
> +
> +    if (UINT64_MAX - start < len) {
> +        fprintf(stderr, "integer overflow in vaddr end address calculati=
on."
> +                        " Specified vaddr=3Dstart+count incorrect.\n");
> +        exit(1);
> +    }
> +
> +    g_autoptr(GString) out =3D g_string_new(NULL);
> +    g_string_printf(out, "Registering new Vaddr range"
> +                        " start=3D0x%08lx len=3D0x%08lx end=3D0x%08lx\n"=
, start, len, end);
> +    qemu_plugin_outs(out->str);

Keep variable declarations at the top of a block, that said do we need
to echo here?

> +
> +    VaddrRange new_vaddrrange =3D {
> +        .start =3D start,
> +        .end =3D end,
> +        .hits =3D qemu_plugin_scoreboard_u64(
> +            qemu_plugin_scoreboard_new(sizeof(uint64_t))) };
> +    g_array_append_val(vaddr_ranges, new_vaddrrange);
> +}
> +
>  QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                             const qemu_info_t *info,
>                                             int argc, char **argv)
> @@ -265,6 +337,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
>      matches =3D g_array_new(false, true, sizeof(Match));
>      /* null terminated so 0 is not a special case */
>      sizes =3D g_array_new(true, true, sizeof(unsigned long));
> +    vaddr_ranges =3D g_array_new(false, true, sizeof(VaddrRange));
>=20=20
>      for (int i =3D 0; i < argc; i++) {
>          char *opt =3D argv[i];
> @@ -281,6 +354,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugi=
n_id_t id,
>              }
>          } else if (g_strcmp0(tokens[0], "match") =3D=3D 0) {
>              parse_match(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "vaddr") =3D=3D 0) {
> +            parse_vaddr(tokens[1]);
>          } else if (g_strcmp0(tokens[0], "trace") =3D=3D 0) {
>              if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace)=
) {
>                  fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
> @@ -292,6 +367,20 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>          }
>      }
>=20=20
> +    /* Check for invalid parameter combinations */
> +    if (vaddr_ranges->len > 0) {
> +        if (matches->len > 0) {
> +            fprintf(stderr, "match=3D... and vaddr=3D... are incompatibl=
e."
> +                            " Use only one of them.\n");
> +            return -1;
> +        }
> +
> +        if (!do_inline) {
> +            fprintf(stderr, "vaddr=3D... is only supported in conjunctio=
n with inline.\n");
> +            return -1;
> +        }
> +    }
> +
>      insn_count =3D qemu_plugin_scoreboard_u64(
>          qemu_plugin_scoreboard_new(sizeof(uint64_t)));

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

