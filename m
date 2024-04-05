Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E3ACD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjAm-0003bJ-NW; Fri, 05 Apr 2024 09:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rsjAg-0003Xh-Ex
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:59:54 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rsjAe-0004rM-Lv
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:59:54 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56dc9955091so2454005a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712321990; x=1712926790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=giUczErZxtr8hbv/hm7d+hqkRN/tMwHk/LvbimoucyQ=;
 b=OTGXyG5Qr4GjSXGBx6tQRc1DAtfwZs6UXg0kk3raSfnyv/cskc9bsN9BBE2hFji9Zd
 qVhAz+IYjAueaZnDq2+Ye1/mCf15J5EkHYKYeF81hP3j2CBsYaJ/tw94r4sK9Y/ReAMT
 aVtp2fUpOE7p+qmYSHiGO62qpWe8SxERDnsElOfDlmyfN0XX+vvvHLIVI5kw5CMktEir
 QGiHXs9bBhmnDV9gs/SVyf2L5Re5ol6Ez7PHoDI9YBzcIajcfkFqEaZW2qSIcd7CCJva
 +kk2UQBAQhnymWZGzmLafxZ/WjnPYtHKYwESBPF9BICCww416U27zYn7qt96nMQGITFN
 6Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321990; x=1712926790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=giUczErZxtr8hbv/hm7d+hqkRN/tMwHk/LvbimoucyQ=;
 b=hNXDchIt51fy71Qp7BQIf0q5X+SDoIr1aA3xM6oxU29hrTmvoN0P7G1iuUIkv9uCRU
 7ImjdRTCweqn1xGvdL57xRlIKimoCtcQt7oaLJAhlkdJ8e4mRhwU2k5ZuZetWVdJuio1
 22hxFwmZzT5UyX3auhreEqQhmO13cnSegRIjtmJiFtbYqrWylIQY84woNpYPhj92ZHWb
 cLfSu5IFM0/yCk0ZK1da/WHgLTpczQItK+2dM47IM4BYBJpPVxIfyQAS5LE3e41HnBLa
 baoVR5j3UFDpz4wLcpGTGOEfERO/go1X3flYKzspW0VZWYud6yD1B6KJutW/HYkuZBgb
 5eHQ==
X-Gm-Message-State: AOJu0YxUuAxtvLxjwb9lYmxq1qIVslP+hkPOz3wPCKrTTIsKdClVI9CX
 PL51QTHeX0mQkINjULRl7w01f3uQ73m825WFEFHlOu9JBCNzHZNrnXa99SKDiGlWjXbNmznjz44
 AXnuN0w+h+WhitOu1hamIxAGt6zfHjW06xSfPi19s
X-Google-Smtp-Source: AGHT+IERu1jAEzC/iAbguAk7xkh8UaB8kTPA/z/NnKUb6u4Ir185x8JgHSd1NKYvdSJaH78NAvoXREK+mm90jaHZtxY=
X-Received: by 2002:a50:955a:0:b0:565:bb25:bb7a with SMTP id
 v26-20020a50955a000000b00565bb25bb7amr1179764eda.24.1712321990111; Fri, 05
 Apr 2024 05:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-25-richard.henderson@linaro.org>
In-Reply-To: <20240405102459.462551-25-richard.henderson@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Fri, 5 Apr 2024 14:59:38 +0200
Message-ID: <CAJy5ezqpJ0cOU0KOaPqpyKFObRj6u3_1KL6nFM1MEB+mUGkPcQ@mail.gmail.com>
Subject: Re: [PATCH 24/32] target/microblaze: Use translator_ldl
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f639d606155907a9"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f639d606155907a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 12:25=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> ---
>  target/microblaze/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.=
c
> index be3ff76f78..11d84bc514 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -24,7 +24,6 @@
>  #include "tcg/tcg-op.h"
>  #include "exec/helper-proto.h"
>  #include "exec/helper-gen.h"
> -#include "exec/cpu_ldst.h"
>  #include "exec/translator.h"
>  #include "qemu/qemu-print.h"
>
> @@ -1640,7 +1639,7 @@ static void mb_tr_translate_insn(DisasContextBase
> *dcb, CPUState *cs)
>
>      dc->tb_flags_to_set =3D 0;
>
> -    ir =3D cpu_ldl_code(cpu_env(cs), dc->base.pc_next);
> +    ir =3D translator_ldl(cpu_env(cs), &dc->base, dc->base.pc_next);
>      if (!decode(dc, ir)) {
>          trap_illegal(dc, true);
>      }
> --
> 2.34.1
>
>

--000000000000f639d606155907a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Fri, Apr 5, 2024 at 12:25=E2=80=AFPM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Cc: Edgar E. Iglesias &lt;=
<a href=3D"mailto:edgar.iglesias@gmail.com" target=3D"_blank">edgar.iglesia=
s@gmail.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br></block=
quote><div><br></div><div>Reviewed-by: Edgar E. Iglesias &lt;<a href=3D"mai=
lto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&gt;<br></div><div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0target/microblaze/translate.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c<=
br>
index be3ff76f78..11d84bc514 100644<br>
--- a/target/microblaze/translate.c<br>
+++ b/target/microblaze/translate.c<br>
@@ -24,7 +24,6 @@<br>
=C2=A0#include &quot;tcg/tcg-op.h&quot;<br>
=C2=A0#include &quot;exec/helper-proto.h&quot;<br>
=C2=A0#include &quot;exec/helper-gen.h&quot;<br>
-#include &quot;exec/cpu_ldst.h&quot;<br>
=C2=A0#include &quot;exec/translator.h&quot;<br>
=C2=A0#include &quot;qemu/qemu-print.h&quot;<br>
<br>
@@ -1640,7 +1639,7 @@ static void mb_tr_translate_insn(DisasContextBase *dc=
b, CPUState *cs)<br>
<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;tb_flags_to_set =3D 0;<br>
<br>
-=C2=A0 =C2=A0 ir =3D cpu_ldl_code(cpu_env(cs), dc-&gt;base.pc_next);<br>
+=C2=A0 =C2=A0 ir =3D translator_ldl(cpu_env(cs), &amp;dc-&gt;base, dc-&gt;=
base.pc_next);<br>
=C2=A0 =C2=A0 =C2=A0if (!decode(dc, ir)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trap_illegal(dc, true);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000f639d606155907a9--

