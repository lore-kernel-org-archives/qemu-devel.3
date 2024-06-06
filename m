Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3A8C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFAuh-0006Zx-PX; Thu, 06 Jun 2024 07:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sFAug-0006Zg-JU; Thu, 06 Jun 2024 07:04:10 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sFAue-00084u-PO; Thu, 06 Jun 2024 07:04:10 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57a30b3a6cbso946937a12.1; 
 Thu, 06 Jun 2024 04:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717671847; x=1718276647; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=STTozLZIBEMevP5FO7VZu3tzLVa//G2nSrEQlFHlMBY=;
 b=PQiY2XIY02B7btsGLuxsTazbkUuidEjBZVDoZgerRBE9onVuW11019gerY35xUtCbK
 yQK1bPmdLjZ3kAS040iaeubKcshYxT73djip9DlzLKicazBCLZehMvq9Dxy1x/8t734G
 e7dRlfTU6vqMQXKN/vUHnxe4xNfFhWg9zUeIv7edmxg4nqp8PwLxdvQI3hZOVyGT3crK
 nx9eoOwy7l7kACoCs1eQxd5V7YxQk908tkLRyMxJ1nlslrb4u3PeqT3MtZWLw9/TKeTY
 129zxUZFzzJ3pbSP3C3JBUu9ma/Z0j24uLp6Y+mutInTVQAe1xDoyjNmqU05AsqTQ78v
 W+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717671847; x=1718276647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=STTozLZIBEMevP5FO7VZu3tzLVa//G2nSrEQlFHlMBY=;
 b=o/KapKZFMnl3kRRrVEwN+eVtZU5++MLyeI+n5me8eXyITYU9DG8UzelfzezoQYuMcX
 9CxPOnQeXqZwbtan7j8S4gogjYuFkb8l+ZnqFdCVkW5PWdlHl0FACOguj3mxWTeLvnFG
 AUlV4anHdtpRYut8Ix3KThtpLJDxFe8IWKpVW+CV16E5wdlkLbI/7Ew9V7GwDI0P76DD
 9Q+Ez3HC7r4sdeQMCedSofwz6EuiwYXs+BpHBJjsKJ89Nxv2FXpHa2laquKMeFkfZ5I3
 INFmrgeCzCF2PTs7sgJjYidY0ozgPFM8jIh3tBIX5G96dSSnT/JR+QclHpy3hSUwzi4R
 J3uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4fAG19cv5qhrMm0FUQK83/mfZLejzzwto/UWE8OPBu5R3NtWaC4wmCRcBKT769xwOiKy4S3ykRvnG8sLTTAJ8K9Czj5FBl/MNokQ+F0U0Xs8rtcsEodMK+z4=
X-Gm-Message-State: AOJu0YzBnoHIBzIAW8/nPcTya/wcN063mG42yAE+tvzIIIxMhXyOPSgR
 J2BKMasQhHFXdjnUmsDVElWdHJYMS/6CGnhpo9x2+o/vbZGoY3WwhP5ndOFw/3a+pdu6gn5CLBb
 4gnBBnVdO2OiX5vdRhcDUszPxxWg=
X-Google-Smtp-Source: AGHT+IEZxQxxLnSJuSZjgr7/zaiLkd6U5BC3oSmzGNbt8RJcaCi2jourhyY0YcFolCl6GE1Q2dRDQDcjkWipG7i4QOs=
X-Received: by 2002:a50:d716:0:b0:57a:2fd7:c2d1 with SMTP id
 4fb4d7f45d1cf-57a8bccb524mr2339254a12.40.1717671846563; Thu, 06 Jun 2024
 04:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240606095952.2133-1-andrew.yuan@jaguarmicro.com>
In-Reply-To: <20240606095952.2133-1-andrew.yuan@jaguarmicro.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 6 Jun 2024 13:03:54 +0200
Message-ID: <CAJy5ezqq51bJG4O9HA-Pv4sw9rYqGdFW-EezCRPfDbTx=9SwyQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net: cadence_gem: fix: type2_compare_x_word_0 error
To: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
Cc: luc.michel@amd.com, alistair@alistair23.me, peter.maydell@linaro.org, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000041586b061a36a4de"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000041586b061a36a4de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 12:00=E2=80=AFPM Andrew.Yuan <andrew.yuan@jaguarmicr=
o.com>
wrote:

>         In the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP
> Rev: R1p12 - Doc Rev: 1.3 User Guide, the specification for the
> type2_compare_x_word_0 register is as follows:
>         The byte stored in bits [23:16] is compared against the byte in
> the received frame from the selected offset+0, and the byte stored in bit=
s
> [31:24] is compared against the byte in
>         the received frame from the selected offset+1.
>
>         However, there is an implementation error in the cadence_gem mode=
l
> in qemu=EF=BC=9A
>         the byte stored in bits [31:24] is compared against the byte in
> the received frame from the selected offset+0
>
>         Now, the error code is as follows:
>         rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
>
>         and needs to be corrected to=EF=BC=9A
>         rx_cmp =3D rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
>
> Signed-off-by: Andrew.Yuan <andrew.yuan@jaguarmicro.com>
>


LGTM:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

At some point it would be nice to add the missing logic for the
DISABLE_MASK bit that
extends the compare range from 16 to 32-bits.

Cheers,
Edgar



> ---
>  hw/net/cadence_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index ec7bf562e5..9c73ded0d3 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -946,7 +946,7 @@ static int get_queue_from_screen(CadenceGEMState *s,
> uint8_t *rxbuf_ptr,
>                  break;
>              }
>
> -            rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> +            rx_cmp =3D rxbuf_ptr[offset + 1] << 8 | rxbuf_ptr[offset];
>              mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE)=
;
>              compare =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
> COMPARE_VALUE);
>
> --
> 2.37.0.windows.1
>
>

--00000000000041586b061a36a4de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Jun 6, 2024 at 12:00=E2=80=AFPM A=
ndrew.Yuan &lt;<a href=3D"mailto:andrew.yuan@jaguarmicro.com">andrew.yuan@j=
aguarmicro.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=A0 =C2=A0 =C2=A0 In the=
 Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev: R1p12 - Do=
c Rev: 1.3 User Guide, the specification for the type2_compare_x_word_0 reg=
ister is as follows:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 The byte stored in bits [23:16] is compared aga=
inst the byte in the received frame from the selected offset+0, and the byt=
e stored in bits [31:24] is compared against the byte in<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the received frame from the selected offset+1.<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 However, there is an implementation error in th=
e cadence_gem model in qemu=EF=BC=9A<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 the byte stored in bits [31:24] is compared aga=
inst the byte in the received frame from the selected offset+0<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Now, the error code is as follows:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D rxbuf_ptr[offset] &lt;&lt; 8 | rxbuf=
_ptr[offset];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 and needs to be corrected to=EF=BC=9A<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D rxbuf_ptr[offset + 1] &lt;&lt; 8 | r=
xbuf_ptr[offset];<br>
<br>
Signed-off-by: Andrew.Yuan &lt;<a href=3D"mailto:andrew.yuan@jaguarmicro.co=
m" target=3D"_blank">andrew.yuan@jaguarmicro.com</a>&gt;<br></blockquote><d=
iv><br></div><div><br></div><div>LGTM:</div><div>Reviewed-by: Edgar E. Igle=
sias &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</=
a>&gt;<br></div><div><br></div><div>At some point it would be nice to add t=
he missing logic for the DISABLE_MASK bit that</div><div>extends the compar=
e range from 16 to 32-bits.</div><div><br></div><div>Cheers,</div><div>Edga=
r=C2=A0</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
---<br>
=C2=A0hw/net/cadence_gem.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c<br>
index ec7bf562e5..9c73ded0d3 100644<br>
--- a/hw/net/cadence_gem.c<br>
+++ b/hw/net/cadence_gem.c<br>
@@ -946,7 +946,7 @@ static int get_queue_from_screen(CadenceGEMState *s, ui=
nt8_t *rxbuf_ptr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D rxbuf_ptr[offset] &lt=
;&lt; 8 | rxbuf_ptr[offset];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_cmp =3D rxbuf_ptr[offset + 1]=
 &lt;&lt; 8 | rxbuf_ptr[offset];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D FIELD_EX32(cr0, TY=
PE2_COMPARE_0_WORD_0, MASK_VALUE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compare =3D FIELD_EX32(cr0,=
 TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);<br>
<br>
-- <br>
2.37.0.windows.1<br>
<br>
</blockquote></div></div>

--00000000000041586b061a36a4de--

