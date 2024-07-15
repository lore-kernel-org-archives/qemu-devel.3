Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FF8C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTH5U-0005ia-Bj; Mon, 15 Jul 2024 04:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sTH5T-0005hK-Bt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:29:35 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sTH5R-0000wU-MD
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:29:35 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4ef33a09a3aso1146889e0c.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721032172; x=1721636972; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hv54g6gba42jqoAKgHFmhKVxoYUDQSotxJr2nOEpnyc=;
 b=EFWwp/PVBVlV/+hpThNadb86zhqnfpVGXXURz5boQvIXTbdriXa6pl2gTaxS1kigZn
 HtxgwrKbaIHaEpcjXMVHZJugoT/wIlRldbjfedhD3OXZSyorzuA6aez/MEBggcPy2tpC
 lH/SrkyFOrU4rfinj0MoITThAUJgCBP3fNoelxKXzLnWX3CqIZ6pvAJVvAXWthwtnbXN
 P0p4EwZhwhUePXceX6lrZmik+rHf9Rz9xsQNk+QW9XuAs21/JHTc7Jysg+j1TtMEMGXY
 fdvDJfHfRBqNWVFGNLh4JuV/0uAA5tDA2QjZmPPOKeSpTDArGhPML1gldBePccIepG1Z
 xMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721032172; x=1721636972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hv54g6gba42jqoAKgHFmhKVxoYUDQSotxJr2nOEpnyc=;
 b=qsN/aj0AVwMM3rasJQg7NPD5TGJAwTUheR+6tWf/Bmuc7qifA/D/ZVyQGla59Iqyhv
 qQO2Gh0gvjQr6GCTkqLLp1DIkfJLQ1G2gXiLNpMhQNQEAyqe6TfE8yejCAvztMxj0sjf
 snlC75OWkl/196tb28WX2Z4x1pMjrE1hdAIIKMyC0Ez84T+K866zk3Pb3GYPzF4WqGXL
 ehBBniSnbA4s7PHhe33nQ2e76JNbhjm9CEVF1jA6WHaJOlDV16DTBhk5iJX0Yw8CTVmM
 NNN17wWW4nFVwYQ7n7QpDQbBrpDKoqXNaW7M62SCw+vvCRQ/RJXuh4QrjNZZTT2/GYUc
 fkjw==
X-Gm-Message-State: AOJu0YwkiAxKGnYs9JdDN3zCKgsW7AtZwUikIY1Y9C9XV9qPEKqC1CKv
 QcJvhm/dTXDG9y1Lg5YEUO8td31WmMQTnc2qWd8w56xv6AajyncDfEPVbSvfjKvFfMcdA2jZiGG
 VW65cTn8Q0YzriHay1WASaX/HCfM=
X-Google-Smtp-Source: AGHT+IHrPXtp0BV7NQibKFeGXzzNRrSTyzkifZJaqRgNVQwDS7pR/nmrok2cPrj7UkULSaSRKugnb1iX8KEdJ4598d8=
X-Received: by 2002:a05:6122:168e:b0:4ec:f7d0:e71c with SMTP id
 71dfb90a1353d-4f33f16e3bbmr16117308e0c.4.1721032172155; Mon, 15 Jul 2024
 01:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240704124834.81958-1-lvivier@redhat.com>
In-Reply-To: <20240704124834.81958-1-lvivier@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jul 2024 12:29:20 +0400
Message-ID: <CAJ+F1C+wctXTLYmqZwjsJYAPyBRg2RLhAX=AvCsr=odMnzdx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: update netdev stream/dgram man page
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000044bb83061d450759"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vk1-xa36.google.com
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

--00000000000044bb83061d450759
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 4:48=E2=80=AFPM Laurent Vivier <lvivier@redhat.com> =
wrote:

> Add the description of "-netdev stream" and "-netdev dgram" in the QEMU
> manpage.
>
> Add some examples on how to use them, including a way to use
> "-netdev stream" and "passt" in place of "-netdev user".
> ("passt" is a non privileged translation proxy between layer-2,
> like "-netdev stream", and layer-4 on host, like TCP, UDP,
> ICMP/ICMPv6 echo)
>
> v2:
>   - split patch
>   - update unix socket description with stream and datagram words.
>
> Laurent Vivier (4):
>   net: update netdev stream/dgram man page
>   net: update netdev stream man page with unix socket
>   net: update netdev dgram man page with unix socket
>   net: update netdev stream man page with the reconnect parameter
>
>  qemu-options.hx | 189 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 189 insertions(+)
>

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000044bb83061d450759
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 4, 2024 at 4:48=E2=80=AFP=
M Laurent Vivier &lt;<a href=3D"mailto:lvivier@redhat.com">lvivier@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Add the description of &quot;-netdev stream&quot; and &quot;-netdev dgram=
&quot; in the QEMU<br>
manpage.<br>
<br>
Add some examples on how to use them, including a way to use<br>
&quot;-netdev stream&quot; and &quot;passt&quot; in place of &quot;-netdev =
user&quot;.<br>
(&quot;passt&quot; is a non privileged translation proxy between layer-2,<b=
r>
like &quot;-netdev stream&quot;, and layer-4 on host, like TCP, UDP,<br>
ICMP/ICMPv6 echo)<br>
<br>
v2:<br>
=C2=A0 - split patch<br>
=C2=A0 - update unix socket description with stream and datagram words.<br>
<br>
Laurent Vivier (4):<br>
=C2=A0 net: update netdev stream/dgram man page<br>
=C2=A0 net: update netdev stream man page with unix socket<br>
=C2=A0 net: update netdev dgram man page with unix socket<br>
=C2=A0 net: update netdev stream man page with the reconnect parameter<br>
<br>
=C2=A0qemu-options.hx | 189 +++++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 189 insertions(+)<br></blockquote><div><br></div><div=
>Series:</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailt=
o:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><br=
></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr=
" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000044bb83061d450759--

