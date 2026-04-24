Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12614FED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGM4G-0001cV-0B; Fri, 24 Apr 2026 15:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wGM4B-0001cD-CF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wGM49-0007K5-BQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777058392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fme7Re0tUdd7zJHew5ETUNjGbn9SLTVL9THQHj5+EMY=;
 b=ZZzFpscvFmISfa3OWp8MGxLlG4xt6gMIUa7D/zYhFBTerkVroLsa23l/Bv/o/vixxuedtV
 4Zr8mwaGbJ8mCbdZCoIVaasrLRwJRHZOS15y8+l1BgNPaj5w0U+nl+RoOjejQKZ766Dkl+
 rRniX1cvUl1U9xiUX+CWO+fspNhAr6Y=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-bw8w_yPePLG-Fy9HogOPZw-1; Fri, 24 Apr 2026 15:19:50 -0400
X-MC-Unique: bw8w_yPePLG-Fy9HogOPZw-1
X-Mimecast-MFC-AGG-ID: bw8w_yPePLG-Fy9HogOPZw_1777058390
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-651cc9f2261so9305610d50.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777058390; cv=none;
 d=google.com; s=arc-20240605;
 b=KRYAtPYRV8FHk6Scjme7cPNm2+RpbhNGkYD/V8xee0Yzxq/3STkIwfQArBbsMHd1qE
 KTvH3sDmBTwok580U9mEtwiknQASBUbFTmUcyxeARUUrbpEdevObDg9u4CifLKbVnQmt
 I2+7Kp5Bt6olDwJVD9pofpyYQrJARb6zFuyzj9shiPt3zB4VQIpyqcKmdHVsNF7ULDX9
 HedVjnEegfh58l+aXBgTF9X/Ufp+vyCwjuAlD1Qve4dCu3pJUsIUUxlko67c167p0L5g
 FfsW7ari2euZLW2ENNALRE6ZcV74dYHIfD5xKq3yAu1va1FCywGbVa43Yv5NfWkY+RKl
 XdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fme7Re0tUdd7zJHew5ETUNjGbn9SLTVL9THQHj5+EMY=;
 fh=+N1d5JofghfB4SW3WjJa94ctJpff3UbYfiomCLmY+To=;
 b=bjz4uIms5wWMrRrNz0RGt2ZtCtbJMV++w+Mcc2Fx9cfj8VhMBfPQp9+moAZEHXdoNf
 wIcDmMc7KRMvLDO3iN/DMVpzZcI0CMbvrrptWww2qZ2/0FVYT7c9taPee3BcWT7TMm6n
 OYj2CAbPiuqtcL4QUrGHogm9gU0pj4qkVbBGT+Zr5Slkd3bF3znLEyTJ04AAxBpX8rjG
 4fHDeXAGXhnSbF56eRIDaMLTkzHvggHpnjfhi4QU+B8NnCjSarV8YpTIbvU3oLMr7vv7
 qE4/sDSn8TkiXXdKzUi7PVyIEQLoib9lbvV6W1dWbBfYKcIu+PNA3kangMmlONpjNE9j
 GToA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777058390; x=1777663190; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fme7Re0tUdd7zJHew5ETUNjGbn9SLTVL9THQHj5+EMY=;
 b=pn6cOEzAuP7+/lpWrZmpPfjrVSmvoAt+dW9k+Y3TE1YHP/aU21Ro+4PuUAAzGWmxIj
 tN3jtNZenlWFBsRw5g1lGMdIt+UtYg0TspyYzQsHWrGfAkAAplWamxatFOyh7xjh45S7
 BlXiHzgUib5TwvT9/rrccYbj8hcl8Y0OY/KhdohYaBEOyyLYzzCS+vEuQerobT+fo0jc
 Ev4WRQdoyfBAioKyb2XUApmcpCIjhwp+i8eCv8lTfPYZ76n5epnaPQeC8jCIEHEdOWx3
 f0NvUvldSsgQem6TDfPTj7Bwx76Te64ZGRrkYFLMFruO+AM6WQpFNUkeKs9sJ0h4F3+i
 y0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058390; x=1777663190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fme7Re0tUdd7zJHew5ETUNjGbn9SLTVL9THQHj5+EMY=;
 b=E6KMs/tT50XwWbukEMg4VNBy/2hrV6rLTXllXchR+fUOhzbkPbgW3RI1TtiWvitMFa
 5tifK6/WD5mGMo5gb0BJ+wlZAF74kfEsIiRJKsMzAPiHE0KLL45bCo6+4xM46Q4Rq/a/
 il0FVxfavK/ArSghJ5flnf0DrGF02ZHL7L11i+pItxPrv4EioYOCHzgEEp8jp5238ajV
 81ciimA5ROT2tfW0jW6te9vkjbQoPvR/8M9YYlAy1b3UR3K0sQ+wkSTARNBT8KdSVMh5
 stRg8xv0mAwEIsFBpFxOo8qT9oRh/1nuexwRIwaFIUYiXvY8Tp5eiMEiu8dAhI/rALRo
 cPXg==
X-Gm-Message-State: AOJu0YxC6cXiZ40orTPSZuGTz3pUv0PjVr+ZXVjZpX0Cj0JnqU6Cce2H
 JIlj0AIymYysZjWGPWMclQ4JlWs5kAXVLk7Q94gWR/JxhVmLey15Z/Pf1RnlyCgCz+OiGn6k7dX
 1UJvByuSjlYBkfNYZeFdPs12iQH6RA0TB+spVpzdQk5UFXVLq9+YksAk59xw1ZK0tV9VhhgGz0v
 gP9Lfo0MiTuX5Bc7UC/dkrPGQLzQnZX4V3m1b1ajA=
X-Gm-Gg: AeBDievT5jbzzToQE/in6IaoHH6eHhVv0MoEdm7q8NYC+tLdIrnyh7r5z1ROHySI//C
 6+YgGnBVln2Pgx2/WwWrfTUrrPWLmebi64wSO/U5BKsv8KzXnh27o7Y8iBXpChltGNAYzV7IVaa
 vVjuM5zviE7qLXX2vUE640ZWjLWWT9kUAeWqfkqf9cn4q2rYIOLDoYUPMierFwtH2hA7J5na1T6
 aRzVFDyflBnMX3DNGXyd3p7iaVZd7+rjEorB1u22BerYMC3
X-Received: by 2002:a05:690e:1504:b0:650:1a8b:3df7 with SMTP id
 956f58d0204a3-6531082edd9mr28632418d50.23.1777058390130; 
 Fri, 24 Apr 2026 12:19:50 -0700 (PDT)
X-Received: by 2002:a05:690e:1504:b0:650:1a8b:3df7 with SMTP id
 956f58d0204a3-6531082edd9mr28632397d50.23.1777058389709; Fri, 24 Apr 2026
 12:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260423220022.2180059-1-jsnow@redhat.com>
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 24 Apr 2026 15:19:38 -0400
X-Gm-Features: AQROBzDMa_zuajsy2vMKsHteTA29yD_ZlZ3l_c6YG3HvTHpgNrnwd2Wpng7Q5ek
Message-ID: <CAFn=p-YvfpOm17VgeTmR=e+H+aRjZ8H1C5cV4kx3BZdiZmfVwA@mail.gmail.com>
Subject: Re: [PATCH 00/12] qapi: add formal "intro" section
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000010b0df065039a691"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--00000000000010b0df065039a691
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026, 6:00=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

> Hiya, this is a series that explores a potential syntax for a
> designated "Intro" section. Markus knows why I want this, but for
> everyone else: a designated "Introduction" section is useful for the
> desired "inliner" feature for the new QAPI doc system. Commits explain
> a bit more. This is prep work and doesn't really change anything
> tangibly except source code syntax for the QAPI docs.
>
> It is designed so that this conversion can happen incrementally with
> no actual difference to the rendered manuals, so each QAPI module can
> be converted one at a time for easier review and merging in an
> arbitrary order.
>
> This series demonstrates conversion of just four modules; if I'm given
> a thumbs up, I will convert the rest of QAPI, one module (or
> maintainer stanza) per patch like how I handled adding
> cross-references.
>
> John Snow (12):
>   tests/qapi: generate output in source order
>   qapi/docs: remove unused QAPIDoc subsection members
>   qapi/docs: make remaining subsection members "private"
>   qapi/docs: add "Intro" section
>   qapi/docs: adjust stub member insertion algorithm
>   qapi/docs: remove implicit Plain section
>   qapi/docs: add "Intro" section parsing
>   qapi/docs: Add rendering for INTRO sections
>   qapi: convert intro sections for accelerator.json
>   qapi: convert intro sections for acpi-hest.json
>   qapi: convert intro sections for acpi.json
>   qapi: convert intro sections for audio.json
>
>  docs/devel/qapi-code-gen.rst            |  17 +-
>  docs/sphinx/qapidoc.py                  |  52 +++---
>  qapi/accelerator.json                   |  24 +--
>  qapi/acpi-hest.json                     |   5 +-
>  qapi/acpi.json                          |  23 +--
>  qapi/audio.json                         | 112 ++++---------
>  .editorconfig                           |   1 +
>

Whoops, that snuck in by accident. Ignore! I needed some help doing the
line wraps in qapi :)

 scripts/qapi/parser.py                  | 204 ++++++++++++++----------
>  tests/qapi-schema/doc-good.out          |  30 ++--
>  tests/qapi-schema/doc-missing-colon.err |   2 +-
>  tests/qapi-schema/test-qapi.py          |  15 +-
>  11 files changed, 239 insertions(+), 246 deletions(-)
>
> --
> 2.53.0
>
>
>

--00000000000010b0df065039a691
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 23, 2026, 6:00=E2=80=
=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hiya, this is a series=
 that explores a potential syntax for a<br>
designated &quot;Intro&quot; section. Markus knows why I want this, but for=
<br>
everyone else: a designated &quot;Introduction&quot; section is useful for =
the<br>
desired &quot;inliner&quot; feature for the new QAPI doc system. Commits ex=
plain<br>
a bit more. This is prep work and doesn&#39;t really change anything<br>
tangibly except source code syntax for the QAPI docs.<br>
<br>
It is designed so that this conversion can happen incrementally with<br>
no actual difference to the rendered manuals, so each QAPI module can<br>
be converted one at a time for easier review and merging in an<br>
arbitrary order.<br>
<br>
This series demonstrates conversion of just four modules; if I&#39;m given<=
br>
a thumbs up, I will convert the rest of QAPI, one module (or<br>
maintainer stanza) per patch like how I handled adding<br>
cross-references.<br>
<br>
John Snow (12):<br>
=C2=A0 tests/qapi: generate output in source order<br>
=C2=A0 qapi/docs: remove unused QAPIDoc subsection members<br>
=C2=A0 qapi/docs: make remaining subsection members &quot;private&quot;<br>
=C2=A0 qapi/docs: add &quot;Intro&quot; section<br>
=C2=A0 qapi/docs: adjust stub member insertion algorithm<br>
=C2=A0 qapi/docs: remove implicit Plain section<br>
=C2=A0 qapi/docs: add &quot;Intro&quot; section parsing<br>
=C2=A0 qapi/docs: Add rendering for INTRO sections<br>
=C2=A0 qapi: convert intro sections for accelerator.json<br>
=C2=A0 qapi: convert intro sections for acpi-hest.json<br>
=C2=A0 qapi: convert intro sections for acpi.json<br>
=C2=A0 qapi: convert intro sections for audio.json<br>
<br>
=C2=A0docs/devel/qapi-code-gen.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 17 +-<br>
=C2=A0docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 52 +++---<br>
=C2=A0qapi/accelerator.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 24 +--<br>
=C2=A0qapi/acpi-hest.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0qapi/acpi.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 23 +--<br>
=C2=A0qapi/audio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 112 ++++---------<br>
=C2=A0.editorconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Whoops, that snuc=
k in by accident. Ignore! I needed some help doing the line wraps in qapi :=
)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0scripts/qapi/parser.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 204 ++++++++++++++----------<br>
=C2=A0tests/qapi-schema/doc-good.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 30 ++--<br>
=C2=A0tests/qapi-schema/doc-missing-colon.err |=C2=A0 =C2=A02 +-<br>
=C2=A0tests/qapi-schema/test-qapi.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 15 +-<br>
=C2=A011 files changed, 239 insertions(+), 246 deletions(-)<br>
<br>
-- <br>
2.53.0<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000010b0df065039a691--


