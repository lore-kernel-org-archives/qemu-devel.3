Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE72E8B36B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnOXn-0003es-6w; Tue, 03 Feb 2026 17:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vnOXl-0003eL-NX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:06:45 -0500
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vnOXj-0008Cy-5T
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:06:45 -0500
Received: by mail-yw1-x1144.google.com with SMTP id
 00721157ae682-79456d5ebf9so62020567b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:06:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770156402; cv=none;
 d=google.com; s=arc-20240605;
 b=P8jWVmtxhpLQ2bmKu9hfpNy4xHDXq5Pu318xiSRxeQ/VUZvmVqSzF8lZVRpSogxnPX
 3GDtkShJRZRM8eXgKfxNrMgLRncMrGuykuKt3g2MnrCQR5gqSfcQ93H6XWENauRhk2Ae
 1iFZ/JKG0fgGJPRaORJ7KhVSRc+SLndTKejvf6sMq8O7XJPpTqmY/JsADsE0bva5kd7j
 SM7Rupg132HOrvtiO/4uwIf6+nCu9IIC2Xk/1sBSkN/H7lD7vmcRchJJg3FOdQnEXVB3
 FVKJopOK9s1sbtbB/DrDIRomf6zefwe7vE/r543Au78s5ZaodzuplLD6KFR+fXlO3FCR
 kvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=09qv1dQ3mV4EjW1PnTKZU4Ka0kSqROpxX43mwtQSHDA=;
 fh=AYIBa/IAJxDQ7q1RmpJq06RNFKUk01MOF94ysBy+Jsk=;
 b=aFxPqiyEwa92uCsvhxrTnxOM0Ldh4Ceh+DZ0Zcw7E1OddHuu8EnQ8DL0kEOjOD0DXf
 AXjXG/Yzf1tnwmppW+KO/LbkwR9KNs2yvo12JuDb6MslC0Q1Go6TJzBU4vK7mhs0Wb7P
 WFJKpaoMsLVNA8nH6LiwxNXGTykf0N0E0jeezD/loxoUr3jOe7PtnmK/do8BDpW7SEsM
 sRf+ZNA8G/pdx/ma5m/k/j+f3n5+2ZkRS5LB+hvLyKdO6vdEfX8BhZ7PaaDRzP/NL4v8
 sZJXnssXGaVURAy+geydFS6fdKGo3f2B8I4dHYllJiDg9cSMwgRCJKAdPtxziqFOTBuZ
 l9sg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770156402; x=1770761202; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09qv1dQ3mV4EjW1PnTKZU4Ka0kSqROpxX43mwtQSHDA=;
 b=GQ3KPHSgxuQglhaR6bSXnKQMuwAnWABIEY1jkkyOJDFVZQ01mSl1wt8+GdeTqnhOCg
 zQyOn+mNIzmDuY01BP2w1w8zjj+kfztZPpQiRCFjOSNT9PfhHxKwhNWvOGQb6zEgoNGf
 qb/mN4GCRapes/PtI3YLkmc8Te95eKa3W14HNIfqxP2o+jrTB/tA0XQZ/3kIqG1oZF9u
 76y+bgawtucMksDPMn0O6ASHxnVop1vHEiimMdyescYT1jAOmGK0liyk36eqzWNaSsBf
 kI2y7ba7+uZqzHWmnpRKl00yQVutmZdVWr23/aABM9JvVFStqLI136k20SX/1Luhtd5r
 9Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770156402; x=1770761202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=09qv1dQ3mV4EjW1PnTKZU4Ka0kSqROpxX43mwtQSHDA=;
 b=vjf4Sg1qpw/PmOPMEyCTumFU4eYIPq7x0fHqM0KLxGThdvBOjC31SAqb5OLCqbqRCe
 CIP9Uq7nj8y2RglZx5weovit2PQWLiN9n+isrLWqbY0jYoD8UstYJ5a3pFb+HCQxDnCj
 MWCzUaEK60u60U3++e//G16iHpiEKEaLpA9/dC/igiXG5tg3E/PaRlC2rKG8MLGFqJ2d
 seSBWJl3LwE9WbhoZQ5LSbaDTwIBOnSSGnTsHKC9G36bpjZwLqVr/tnqRH8RHb732KBd
 br4R+szFjxn0i4tR6BxW/2TLL+RzkKATfLZCPFBe1AgFxsmlj8sv15+SnjuevmptnaSo
 8kUg==
X-Gm-Message-State: AOJu0Yy2a9Rcdp+OndxjTE+tvpO8bGPNWhISctFAhe7d/uyaCuDopCC4
 /qIWJweshNz8LKrNz0xU+tCXQWGI+39+T2yKUnqHLPmFng6JAvtGkv/2O+DjAd54UzDpDbem839
 4xbSqv2PZ7UepVUzP7NBVWHqUG3Yr0LA=
X-Gm-Gg: AZuq6aLu09bPMQVjisMKwce9YxShuVP0U+9nUngL7KoWQUPCB8xg0Eq7F6ibs/98vu0
 6+nIXmqweZTkxU6E6NRydR+ielSihaNsB2lH/+81mmGuRcDxBQCRLspwjQFMBL1aF+ruG4HP3dP
 dTITU9RJm9Y6e1YVLLC04pBEKqp/P6N96J26ntJQQLgs6OVeYeDFVQTAS4DoPRf7Wib0To75V0v
 Xq+iZL2P+55qAW7H9QM1tH53k7z0Er7bXQSeI1tNS1XD5zXrF/hE6n4mb2gHazj5QzRHbI=
X-Received: by 2002:a05:690c:c50d:b0:794:c373:7230 with SMTP id
 00721157ae682-794fe6925c6mr9978927b3.23.1770156401662; Tue, 03 Feb 2026
 14:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
 <20260203115201.2387721-4-alex.bennee@linaro.org>
In-Reply-To: <20260203115201.2387721-4-alex.bennee@linaro.org>
From: Yodel Eldar <yodel.eldar@gmail.com>
Date: Tue, 3 Feb 2026 16:06:31 -0600
X-Gm-Features: AZwV_QigCPUmuFKMGMAk28tEGsoVdPmrj_v9SrwktMypBQ9wWmj8AwU3tn6yVSo
Message-ID: <CAHhgW4W4YZjWytqFpbEmhfh6cuZJdtCgqi945q5g42SWZDvEUg@mail.gmail.com>
Subject: Re: [PATCH 03/11] gdbstub: remove the need for goto cleanup
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1144;
 envelope-from=yodel.eldar@gmail.com; helo=mail-yw1-x1144.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi, Alex

On Tue, Feb 3, 2026 at 5:51=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> We already set a default error reply which we can only overwrite if we
> successfully follow the chain of checks. Initialise the variables as
> NULL and use that to gate the construction of the filled out
> stop/reply packet.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks for the patch: glad to see a goto gone.

> ---
>  gdbstub/gdbstub.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 1f8cd118924..d4db7ba30cc 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1413,36 +1413,32 @@ static void handle_v_cont(GArray *params, void *u=
ser_ctx)
>
>  static void handle_v_attach(GArray *params, void *user_ctx)
>  {
> -    GDBProcess *process;
> -    CPUState *cpu;
> +    GDBProcess *process =3D NULL;
> +    CPUState *cpu =3D NULL;
>
> +    /* Default error reply */
>      g_string_assign(gdbserver_state.str_buf, "E22");
> -    if (!params->len) {
> -        goto cleanup;
> -    }
> -
> -    process =3D gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul);
> -    if (!process) {
> -        goto cleanup;
> +    if (params->len) {
> +        process =3D gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul=
);
>      }
>
> -    cpu =3D gdb_get_first_cpu_in_process(process);
> -    if (!cpu) {
> -        goto cleanup;
> +    if (process) {
> +        cpu =3D gdb_get_first_cpu_in_process(process);
>      }
>
> -    process->attached =3D true;
> -    gdbserver_state.g_cpu =3D cpu;
> -    gdbserver_state.c_cpu =3D cpu;
> +    if (cpu) {
> +        process->attached =3D true;
> +        gdbserver_state.g_cpu =3D cpu;
> +        gdbserver_state.c_cpu =3D cpu;
>
>      if (gdbserver_state.allow_stop_reply) {
>          g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIG=
NAL_TRAP);
>          gdb_append_thread_id(cpu, gdbserver_state.str_buf);
>          g_string_append_c(gdbserver_state.str_buf, ';');
>          gdbserver_state.allow_stop_reply =3D false;
> -cleanup:
> -        gdb_put_strbuf();
>      }
> +
> +    gdb_put_strbuf();
>  }
>

The `cpu` gated block doesn't have a closing brace here thereby breaking
build, but it does in the next patch. Maybe a `git add -p` gone awry?

Also, would it make sense to move the `cpu` and the to-be nested block
below it into the `process` gated block to avoid the `cpu` check
whenever `process` is NULL?

Yodel

>  static void handle_v_kill(GArray *params, void *user_ctx)
> --
> 2.47.3
>
>

