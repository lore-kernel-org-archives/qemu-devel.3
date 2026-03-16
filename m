Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E1BF53D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CH0-0004gW-4a; Mon, 16 Mar 2026 14:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2CGk-0004am-U6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:02:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2CGg-0007vS-He
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:02:19 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so3221433a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 11:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684137; cv=none;
 d=google.com; s=arc-20240605;
 b=T7gk5KaM0xtq6apzFKICyqHMZgSjKbruLQEgrgWBiFFjzgOe2qSx3UaEbNY4flqoQZ
 JZAioDiqb4oXgREEPcXyq1bUQFEnRGy1/D72qUgbRotH6ajRquZ5V8P9QUhyeDLw7nDi
 HW7LgQnR2uI5Si7DzO4JkT0pWeLX0Ymo03j1zSeyag51Owf/rSZ+eSN8vxE4Z4/B1Wph
 z5v9QNdqWm4fRL93rGQt+PuWBYYEPJ3+8V2z4UX5ZVGzvKJLdsU4jNaKWFqvOtCcApWy
 8sR8VDVDRtxjp9HJXdH1cVWZVjkAkrb3L5QTmuK6Blm7w+VEN45YPtewlxC0eMKaqIlt
 iWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=efT0N9Z67tSiri23JlZtjrNRIwCF5xRsiMJxwYnklQs=;
 fh=claZy1AqjntwtCmvJ2bOH1jKm32TQ/sNLUpi8CfCki8=;
 b=Qzj24yKVba0NB/2c7oEA7rDOEhXIyQBVVW/ZYOKr6kUNic2LfvUsEfCI7INISBHL76
 XVcetkr9O8Yl25EyYl5T4ccwBJfIFFGsJrvxi9kAS1rRQpApl1BG6YcOjsUTCjbS3xIW
 QT3E9jymDuRsZh4nklsEwwnuL38YXgWXl8OA+TOwmWlkPm2fPMqufQ383C9st+7NgeDZ
 EQQs6PijQyry2e9bAP9G1Z0ZRyp6SWarrRjkY5KQaLiHTC3ZPimBaUWxFjLgiNadWwEo
 0AHwsab6Uz7FF9qaTCDOWp0dhaAZ1LwS1xTVZaT/3F4jjxzdanUklJ1M2wWWCC5R4d5h
 2yYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773684137; x=1774288937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=efT0N9Z67tSiri23JlZtjrNRIwCF5xRsiMJxwYnklQs=;
 b=fNltMLB0E/p5gzTkNXgqFs8+QdrEyj6kmDZweeDv0hLOwVBj49VtdnP4/kAHjGkRNU
 BVapVbqY2f1BgWpaNUfCLmKSSR5jccHyF9JWRqHIFijcmIbAHZt2sQ20MPqoA+w5dzGm
 bM7onMkL1x5gyI1gCzF3sXCppBvEq84kOGtSyhXJuzBcNvkXVB6pY2YSJnSpMW7Gh3Ml
 K01VtsRCgpuh7/NZuksMBQwzggNaoZm9dt6MKyC2Yg0v426GeZpl72pOLSCkLfDoQBvn
 ln5wvVdIo+igPsxKX1C+sEnOzYAr4V6THmwkwUiu/muijdT2l0TTCBwVpssgApHPuK+m
 cpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684137; x=1774288937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efT0N9Z67tSiri23JlZtjrNRIwCF5xRsiMJxwYnklQs=;
 b=BEaMVSFlukeEqvVI1RX92GIZYvV6u6F2ZoznVz6844Jx8dxaltfBBbGpXNe9v/fUbQ
 i/nsigzvVdCRN7BBpC85W2Z4VEs3kVhttt5qy3WFDk7bT8fmoA1sZfkLpa7Tv2QWDaVQ
 t4SXbmtHAvaxogz9ZCkzYhvZcySFCACFFCzBzGu9lsOyaRjzniwUwk0fPerC8yF9JKrO
 DFL44vPr+WP1V5epjvxkU5v4vGrmXg0L7gn8m8Who7ANAv1oaHJDgvejwUJL1jYobvby
 93uf4Lsktl8iuvNsvrYvVIlTcOm8uVXkqF9F5zyktbg8avkK6fnULfto8Kk5L4mMHNat
 G/fg==
X-Gm-Message-State: AOJu0Yyy+Wgb9psH7HDxXkRRfPuUM4XcU7BDcfBSWpp6/JFIUgd256wi
 RRuIUovCKWipy9C9Kc+97ekG6z/6a5Jcrd2RpF01zB5z/fsp1qqlxs5U4vVodvClzcChadGe7G0
 zoBEAe+2kDQi7MvopKJKzVinBnok78hs=
X-Gm-Gg: ATEYQzwj/rXReSUyoC5xOl9VPXecLqqORwdlpOCFMS3Mkrz+DIWkghq1rQr08Pnr+cd
 txUltBRc6XWy9QV+MXqF0qBdQeYP42d+v2AnvqflHrBi7nfobN4ZzhH4CEpUUd5WXBgCYtXnzya
 dStSdAaIOII2dh2ymLxeRtKyEeC6sCUzvzvvciSS816uSLZQNeq/o193egyG/+XQ2CkjwCsAyPH
 pzhE4xP5HTfGdFl2dNfmvLqd1KMO9aBRHznMKBXtKsm5wXwx95T4fNsQP9JuhrdagDhIEgBmyeu
 pJkQcb87e5qHogFl/H+2I9P87u6kRfiMUBMVkQ==
X-Received: by 2002:a17:90b:1dcb:b0:35b:a960:62cb with SMTP id
 98e67ed59e1d1-35ba9606566mr1692983a91.32.1773684136802; Mon, 16 Mar 2026
 11:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
 <20260311042019.1085030-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260311042019.1085030-3-brian.cain@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 12:02:05 -0600
X-Gm-Features: AaiRm51trO_ahNT-4GNU-GHYrO7_mHCmHaH9ZcnjbStMcqK20MC97DQVaLYkna8
Message-ID: <CAATN3NofEA_mFkDb7cTZbAEvTVXLas0ZkQjvBDVYhiK+ozQE7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] hw/hexagon: Add global register tracing
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eafd19064d2804ac"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pg1-x52f.google.com
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

--000000000000eafd19064d2804ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 10:20=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com>
wrote:

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  meson.build                    |  1 +
>  hw/hexagon/hexagon_globalreg.c | 73 ++++++++++++++++++++++++++++++++++
>  hw/hexagon/trace-events        |  3 ++
>  3 files changed, 77 insertions(+)
>  create mode 100644 hw/hexagon/trace-events
>
> diff --git a/meson.build b/meson.build
> index 7b4e5bc72b5..286edfb99dc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3633,6 +3633,7 @@ if have_system
>      'hw/display',
>      'hw/dma',
>      'hw/fsi',
> +    'hw/hexagon',
>      'hw/hyperv',
>      'hw/i2c',
>      'hw/i3c',
> diff --git a/hw/hexagon/hexagon_globalreg.c
> b/hw/hexagon/hexagon_globalreg.c
> index 5187b91dcae..a30c16cd7ba 100644
> --- a/hw/hexagon/hexagon_globalreg.c
> +++ b/hw/hexagon/hexagon_globalreg.c
> @@ -16,11 +16,82 @@
>  #include "target/hexagon/cpu.h"
>  #include "target/hexagon/hex_regs.h"
>  #include "qemu/log.h"
> +#include "trace/trace-hw_hexagon.h"
>  #include "qapi/error.h"
>
>  #define IMMUTABLE (~0)
>  #define INVALID_REG_VAL 0xdeadbeef
>
> +static const char *hex_sreg_names[] =3D {
> +    [HEX_SREG_SGP0] =3D "sgp0",
> +    [HEX_SREG_SGP1] =3D "sgp1",
> +    [HEX_SREG_STID] =3D "stid",
>

Why not use the array in cpu.c from an earlier patch?

--000000000000eafd19064d2804ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 10,=
 2026 at 10:20=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.q=
ualcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">Reviewed-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@li=
naro.org</a>&gt;<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0hw/hexagon/hexagon_globalreg.c | 73 +++++++++++++++++++++++++++++++++=
+<br>
=C2=A0hw/hexagon/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++<br>
=C2=A03 files changed, 77 insertions(+)<br>
=C2=A0create mode 100644 hw/hexagon/trace-events<br>
<br>
diff --git a/meson.build b/meson.build<br>
index 7b4e5bc72b5..286edfb99dc 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -3633,6 +3633,7 @@ if have_system<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/display&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/dma&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/fsi&#39;,<br>
+=C2=A0 =C2=A0 &#39;hw/hexagon&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/hyperv&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/i2c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;hw/i3c&#39;,<br>
diff --git a/hw/hexagon/hexagon_globalreg.c b/hw/hexagon/hexagon_globalreg.=
c<br>
index 5187b91dcae..a30c16cd7ba 100644<br>
--- a/hw/hexagon/hexagon_globalreg.c<br>
+++ b/hw/hexagon/hexagon_globalreg.c<br>
@@ -16,11 +16,82 @@<br>
=C2=A0#include &quot;target/hexagon/cpu.h&quot;<br>
=C2=A0#include &quot;target/hexagon/hex_regs.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
+#include &quot;trace/trace-hw_hexagon.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
<br>
=C2=A0#define IMMUTABLE (~0)<br>
=C2=A0#define INVALID_REG_VAL 0xdeadbeef<br>
<br>
+static const char *hex_sreg_names[] =3D {<br>
+=C2=A0 =C2=A0 [HEX_SREG_SGP0] =3D &quot;sgp0&quot;,<br>
+=C2=A0 =C2=A0 [HEX_SREG_SGP1] =3D &quot;sgp1&quot;,<br>
+=C2=A0 =C2=A0 [HEX_SREG_STID] =3D &quot;stid&quot;,<br></blockquote><div><=
br></div><div>Why not use the array in cpu.c from an earlier patch?=C2=A0</=
div></div></div>

--000000000000eafd19064d2804ac--

