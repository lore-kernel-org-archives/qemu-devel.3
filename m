Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F78C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 11:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rndQB-0005CG-5g; Fri, 22 Mar 2024 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rndQ7-0005Bw-Ea
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:50:49 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rndQ4-0007XE-4V
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 07:50:46 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso3640746a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 04:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711108239; x=1711713039; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ensAXljaHg7KfpjfX/dLLUQdCVh99xLqF2mZKyVqav8=;
 b=fEINF1od1CwFxkRhGYVplCf8TbbRpoKFv8yhGgzovVELeDI7dhGZax4XUuBdFHQIJ0
 7J/JDwoAxt1pyJkWCMJEuFJMP/Yy7TxU/UbnY8BuSU2aYQd0JycaUVe7lxxKnQaxfZhP
 wDtJax9o1YeT2ucnkLIynn2kWK/3KE/zqzOCVslmZm4hgZXh7mLK6Q5ENz2t53eC9ehh
 DTI3aH2PQkgoWUTBSuEuAJnal+7qexdhKw9GKZx8AFZAZsAklVBV+61UXhr0UEDn2PAp
 RwAi7Mnk293ikrLD/PQ+Q9bqlFbc9Mgr2GQG6zAj2gFNBv0OMyKAcThcX+TPsb7DsP0b
 n/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711108239; x=1711713039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ensAXljaHg7KfpjfX/dLLUQdCVh99xLqF2mZKyVqav8=;
 b=Kva9vzukENljiMxEGE0uHXL9W4juHeSARW7bt8BmdYdDpyq7C7oAp+yRvmkEOYJcK8
 8/MsvvtmRr7HbNNvSnHNu9N9JQQcXP8gdEJpbCiotuW6LZwtlMLz9q1B3471Tyobro4b
 eSNTDNZVvrLKKENp+9g1gEekLuPc47wgI9QA0jwAi5zoPMMUauez2VSu7UjqNREXr6Z0
 72zL2MdaeQ2wk2lnghV7ab6ZkAhJgWNR2mWCRV/RFEXZG+IBCUlQwt6YTzglfHAncHLE
 SIotZltv5NkQgDETbX/QYOkZrAF8MrTlJKFCO7jpQzgPXZKoyr+D3jDGyHE1v0cYUjHa
 qrtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR2Z1uvO4BEuxtMd8E1C3qdF8PlVf6e08VSsXZuSFcNNzUEDR7y742oMlTv9TQZDACdP+r5sIj3IAxbS/Y8hSbgo8j7XA=
X-Gm-Message-State: AOJu0YzFBIt2k/apGEG2WH3Ycag4qearpOPAFk0AjOvFqXpS0JGYH/W8
 SK733GtEOjx4l9pVdj9BOqxtSxko/J7ONBRhLp6LDXIzlY8R0Cg+csXbx4BFwo6Sf8aTb4WlK9H
 zTq1nU8Wh2zbfk77cD184GfsQWA22P0EB8R1gUg==
X-Google-Smtp-Source: AGHT+IHSw3WaU0Ajux9aASXBJHKXXDDFDS8WcKaL0SL/XEvY6I78+nAs9Z11vWZqNtDIGINGAY2Kz29eDFhBxhUeZIk=
X-Received: by 2002:a50:baaf:0:b0:567:f475:6c6b with SMTP id
 x44-20020a50baaf000000b00567f4756c6bmr1615351ede.8.1711108239408; Fri, 22 Mar
 2024 04:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 11:50:28 +0000
Message-ID: <CAFEAcA_7E62a4QJtQRk0AHw0hjNaReB1zyGXNjFM1EMAK-unOg@mail.gmail.com>
Subject: Re: [PATCH] contrib/plugins/execlog: Fix compiler warning
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com, 
 pierrick.bouvier@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 20 Mar 2024 at 02:05, Yao Xingtao via <qemu-devel@nongnu.org> wrote=
:
>
> 1. The g_pattern_match_string() is deprecated when glib2 version >=3D 2.7=
0.
>    Use g_pattern_spec_match_string() instead to avoid this problem.
>
> 2. The type of second parameter in g_ptr_array_add() is
>    'gpointer' {aka 'void *'}, but the type of reg->name is 'const char*'.
>    Cast the type of reg->name to 'gpointer' to avoid this problem.
>
> compiler warning message:
> /root/qemu/contrib/plugins/execlog.c:330:17: warning: =E2=80=98g_pattern_=
match_string=E2=80=99
> is deprecated: Use 'g_pattern_spec_match_string'
> instead [-Wdeprecated-declarations]
>   330 |                 if (g_pattern_match_string(pat, rd->name) ||
>       |                 ^~
> In file included from /usr/include/glib-2.0/glib.h:67,
>                  from /root/qemu/contrib/plugins/execlog.c:9:
> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
>    57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> /root/qemu/contrib/plugins/execlog.c:331:21: warning: =E2=80=98g_pattern_=
match_string=E2=80=99
> is deprecated: Use 'g_pattern_spec_match_string'
> instead [-Wdeprecated-declarations]
>   331 |                     g_pattern_match_string(pat, rd_lower)) {
>       |                     ^~~~~~~~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
>    57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
>       |               ^~~~~~~~~~~~~~~~~~~~~~
> /root/qemu/contrib/plugins/execlog.c:339:63: warning: passing argument 2 =
of
> =E2=80=98g_ptr_array_add=E2=80=99 discards =E2=80=98const=E2=80=99 qualif=
ier from pointer target type
> [-Wdiscarded-qualifiers]
>   339 |                             g_ptr_array_add(all_reg_names, reg->n=
ame);
>       |                                                            ~~~^~~=
~~~
> In file included from /usr/include/glib-2.0/glib.h:33:
> /usr/include/glib-2.0/glib/garray.h:198:62: note: expected
> =E2=80=98gpointer=E2=80=99 {aka =E2=80=98void *=E2=80=99} but argument is=
 of type =E2=80=98const char *=E2=80=99
>   198 |                                            gpointer          data=
);
>       |                                            ~~~~~~~~~~~~~~~~~~^~~~
>

Hi; thanks for this patch.

This fixes a bug reported in the bug tracker so we should put

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2210

in the commit message just above your signed-off-by tag.


> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  contrib/plugins/execlog.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index a1dfd59ab7..41f6774116 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -327,8 +327,13 @@ static GPtrArray *registers_init(int vcpu_index)
>              for (int p =3D 0; p < rmatches->len; p++) {
>                  g_autoptr(GPatternSpec) pat =3D g_pattern_spec_new(rmatc=
hes->pdata[p]);
>                  g_autofree gchar *rd_lower =3D g_utf8_strdown(rd->name, =
-1);
> +#if GLIB_VERSION_MAX_ALLOWED < G_ENCODE_VERSION(2, 70)

Elsewhere we do glib version checks with

#if GLIB_CHECK_VERSION(2, 70, 0)
    code for 2.70.0 and up;
#else
    code for older versions
#endif

so I think we should probably do that here too.

>                  if (g_pattern_match_string(pat, rd->name) ||
>                      g_pattern_match_string(pat, rd_lower)) {
> +#else
> +                if (g_pattern_spec_match_string(pat, rd->name) ||
> +                    g_pattern_spec_match_string(pat, rd_lower)) {
> +#endif

Rather than putting this ifdef in the middle of this function,
I think it would be easier to read if we abstract out a function
which does the pattern matching and whose body calls the right
glib function depending on glib version. We generally call these
functions the same as the glib function but with a _qemu suffix
(compare the ones in include/glib-compat.h), so here that would
be g_pattern_spec_match_string_qemu().

>                      Register *reg =3D init_vcpu_register(rd);
>                      g_ptr_array_add(registers, reg);
>
> @@ -336,7 +341,7 @@ static GPtrArray *registers_init(int vcpu_index)
>                      if (disas_assist) {
>                          g_mutex_lock(&add_reg_name_lock);
>                          if (!g_ptr_array_find(all_reg_names, reg->name, =
NULL)) {
> -                            g_ptr_array_add(all_reg_names, reg->name);
> +                            g_ptr_array_add(all_reg_names, (gpointer)reg=
->name);
>                          }
>                          g_mutex_unlock(&add_reg_name_lock);
>                      }

thanks
-- PMM

