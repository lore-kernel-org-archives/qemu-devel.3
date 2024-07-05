Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3508EC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPfm4-0000Ep-4a; Fri, 05 Jul 2024 06:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfm2-0000EM-Ng
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:02:38 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPfm1-0003R8-2B
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:02:38 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a77c9c5d68bso63096466b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720173755; x=1720778555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xpghvKJ3CS5b+n5sfRES7MRyE9Haf74z2Qv8jnQiWQ=;
 b=pk808ZhH38oJeeWe6hoiEPhVI15pKqRse7lA25Pol397IGlUt7jAS0yOiTKpzGSinh
 o60wlBr2iC258uNFDPQLFr7GyEarNj+9g6zouJx1r+uFj50gq8ZDpQkIVQdXOP7AGbD8
 Im33+iVJ3kG0TIHz+ykdjLj1mcZheE5YtLs7fRrN1S/1iBdIEEGq4V0foX9ZQNlTvhjH
 qe9lbj3rHJZjsilnc08f7FkxCG8Sl/iMe/62npHX9UI6K9DXk2fnvJYad2MZal9+ZtHY
 FAPbjNJcu/jsrk8CDmzZVU0IyDT21giPv7swCjSQayq6fu6KLK3bpTksL9iOm7pKtnga
 67wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720173755; x=1720778555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xpghvKJ3CS5b+n5sfRES7MRyE9Haf74z2Qv8jnQiWQ=;
 b=usLyBillA3MQouWG595ndql8NHxwAW5tiFXqAXhCPoJWAVz6x5l8ZKSMGZpo94pqFk
 w4IFV8JLin2OmC6tV85bLT4sK1v1RKyNrvmnpAuxQ3ZE0AVBOaQou/ECDdwAMrj1Z8qP
 EHGqqg+upOmyuU8RZS+UjdH7w8FMSyA1Sz8wBPMKFc3ffTX+D/pOHjsm+ukyHvqfxoH1
 vk3eXMWxtHg9fI857toNlJPWv6ijY7ZcpzrCJEdtUarlV1kTx1esvZ0N73YNA5SMhDT+
 0RqbFmK5cwYYafZzVVNRo2tsQ1ni99c9FgvNU90wvzppRCBul0BtM43KU9Dqlal7n1xx
 Rp2g==
X-Gm-Message-State: AOJu0YzGzerbMANs9jIZ3v2+OOoFseDb7MCZjBoEeoi1pjF/Y4WGC9t9
 pD090OTq1q7Ipdfl9OLNO4hvz5WAs2XBk+W+sQrq08rNDMWfI0XpBIfNy7TYiXia4aL9CFAcqcS
 nivpXtdz6kAW0XY4AJCW1O4DT3+GVb0THb416zg==
X-Google-Smtp-Source: AGHT+IGaZpaQnZQQgDoQbq5AB9VHE+OwI2XeGoJ4tld6AWQ6zZWJX8SBK/idsekr1yrmed46wFQSZomYTBSnBZWr8Js=
X-Received: by 2002:a17:906:2983:b0:a6f:5150:b805 with SMTP id
 a640c23a62f3a-a77ba48324amr254099966b.33.1720173754975; Fri, 05 Jul 2024
 03:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240705084047.857176-1-alex.bennee@linaro.org>
 <20240705084047.857176-22-alex.bennee@linaro.org>
In-Reply-To: <20240705084047.857176-22-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Jul 2024 13:02:18 +0300
Message-ID: <CAAjaMXajPROJp=aQnMqHC7X49sFba1wpMgi=EDxJ5z3zua59HQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/40] test/plugin: make insn plugin less noisy by
 default
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, 
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

On Fri, 5 Jul 2024 at 11:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> While the match functionality is useful lets make the verbosity
> optional while we are actually running.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/plugin/insn.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index 5e0aa03223..524f9ddde8 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -20,6 +20,7 @@ static qemu_plugin_u64 insn_count;
>
>  static bool do_inline;
>  static bool do_size;
> +static bool do_trace;
>  static GArray *sizes;
>
>  typedef struct {
> @@ -73,30 +74,30 @@ static void vcpu_insn_matched_exec_before(unsigned in=
t cpu_index, void *udata)
>      MatchCount *match =3D qemu_plugin_scoreboard_find(insn_match->counts=
,
>                                                      cpu_index);
>
> -    g_autoptr(GString) ts =3D g_string_new("");
> -
>      insn->hits++;
> -    g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
> -                           insn->vaddr, insn->disas, insn->hits);
>
>      uint64_t icount =3D qemu_plugin_u64_get(insn_count, cpu_index);
>      uint64_t delta =3D icount - match->last_hit;
>
>      match->hits++;
>      match->total_delta +=3D delta;
> -
> -    g_string_append_printf(ts,
> -                           " , cpu %u,"
> -                           " %"PRId64" match hits,"
> -                           " =CE=94+%"PRId64 " since last match,"
> -                           " %"PRId64 " avg insns/match\n",
> -                           cpu_index,
> -                           match->hits, delta,
> -                           match->total_delta / match->hits);
> -
>      match->last_hit =3D icount;
>
> -    qemu_plugin_outs(ts->str);
> +    if (do_trace) {
> +        g_autoptr(GString) ts =3D g_string_new("");
> +        g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits=
",
> +                               insn->vaddr, insn->disas, insn->hits);
> +        g_string_append_printf(ts,
> +                               " , cpu %u,"
> +                               " %"PRId64" match hits,"
> +                               " =CE=94+%"PRId64 " since last match,"
> +                               " %"PRId64 " avg insns/match\n",
> +                               cpu_index,
> +                               match->hits, delta,
> +                               match->total_delta / match->hits);
> +
> +        qemu_plugin_outs(ts->str);
> +    }
>  }
>
>  static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb=
)
> @@ -216,6 +217,11 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>              }
>          } else if (g_strcmp0(tokens[0], "match") =3D=3D 0) {
>              parse_match(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "trace") =3D=3D 0) {
> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_trace)=
) {
> +                fprintf(stderr, "boolean argument parsing failed: %s\n",=
 opt);
> +                return -1;
> +            }
>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", opt);
>              return -1;
> --
> 2.39.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

