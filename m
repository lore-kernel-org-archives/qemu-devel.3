Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3954C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4mX-0007Sq-4T; Mon, 03 Jun 2024 06:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sE4mV-0007SK-Q9; Mon, 03 Jun 2024 06:19:11 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sE4mT-0002Kd-J3; Mon, 03 Jun 2024 06:19:11 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so7260358a12.0; 
 Mon, 03 Jun 2024 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717409946; x=1718014746; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=23lg4niCLpouQl9oZZ4W9GefWlftzip5Spi8jpU1ZJE=;
 b=l9tdsu86m0/osfAedfJRI7GjfHPgn8w4vjN/bUk/xWDrh8BKyEUHsp4WE390EmE9sa
 HhHfUNHToCgEKIPfqELJA+x0fYCLv4Q4Q9xMoBvzsSYbf1gh+lZG3AlWuGNBULU38bG8
 9rB1ihlO4OxNcrUbF0nJ9Kvo2bsu6flLMkfKZ5RlbG8WZMLSrAM1i7V57i4CcszxJ+L5
 d5hZmaNXOFNOGD5ON7tOTgQQAdp6HxbKQmm30fcZi7M1FlAmjtODlvezqiaRFeriyRxZ
 Nt/6zn+nrQBjhx99B8VQIFE0AKKQIOL6Lws/g1RJnZg74ZV9PePgPH4T+k99FEIuoIri
 merQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717409946; x=1718014746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=23lg4niCLpouQl9oZZ4W9GefWlftzip5Spi8jpU1ZJE=;
 b=A403cafPySa3Jg0qQ35npzUOMPoM1qbANF0IpD0Occ3C1maUNeJyg06gcE2THf9mik
 B3geTlIdMPZKNEoAhfiFjTA07nCKPo064WoMO0XgG04nWbmBt34/GbKHHCSNiQ9DX5Te
 uI9zhDZtuLBQwEHYaZNTQubYx+LYaYMfR+7ERRaAZ3DcL5jYnBFXhj+agBP7jJvUoJ9l
 7Gdo22gbvWplZqQZ5rNE34Ny8YVsNkn/UAHHIGYT/OULdzSdH3UlY2gkntJejtI47B8e
 zIN7kCBwPUlJHpLZ7J/WzmWQbzicc0tyWUxEmm2HkWkK1RF8BACFdfY8ZH5EuzyS93Ke
 yTig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKlonpF4KtVt4g7jkIIyWIlPX38A/qAsYYpO9c/1NAe1QCVHYOqMiAK3C7Q+n13PRNjnPyI+moMb2uVRMh/ySJymA9JMaef81vCfyLdtYa9zAysnHgw4db4nQ=
X-Gm-Message-State: AOJu0Yx6pUBTJZgcEmU0KsxwOB73sTfa5klgQkOPcZ/EfnnNdUC+vzwX
 7UVasI80BLmGBkrOHfVdHDHgpf8uCet5EOou8DAMananZJ5uriMVPgcLKlOo5cI1Pk3VbRnB0nz
 lyy/YmPn+DQhqou5wB2b/ohezybI=
X-Google-Smtp-Source: AGHT+IHs+tCX0+txTq4TlzNuD26Gl/B8Qr3dNZDcjXl47WSU5aYwe+b8rZQ8yr0DXlNJUZ0WqT9oDqB+BAvryIqHaT4=
X-Received: by 2002:a50:cd9a:0:b0:578:5c1e:45e5 with SMTP id
 4fb4d7f45d1cf-57a363b66eemr8045749a12.9.1717409945372; Mon, 03 Jun 2024
 03:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240603055248.3928469-1-fea.wang@sifive.com>
 <20240603055248.3928469-2-fea.wang@sifive.com>
In-Reply-To: <20240603055248.3928469-2-fea.wang@sifive.com>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Mon, 3 Jun 2024 12:18:52 +0200
Message-ID: <CAJy5ezr-_xnjXqtZnqaWSagMD8pGgU2bDUD0TsHxfkYvQYeHpw@mail.gmail.com>
Subject: Re: [PATCH 1/4] hw/dma: Enhance error handling in loading description
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ba4de90619f9a9e9"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52a.google.com
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

--000000000000ba4de90619f9a9e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 7:47=E2=80=AFAM Fea.Wang <fea.wang@sifive.com> wrote=
:

> Loading a description from memory may cause a bus-error. In this
> case, the DMA should stop working, set the error flag, and return
> the error value.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
>


Hi Fea,

I've got a couple of small comments:


---
>  hw/dma/xilinx_axidma.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 0ae056ed06..4b475e5484 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -71,8 +71,10 @@ enum {
>  enum {
>      DMASR_HALTED =3D 1,
>      DMASR_IDLE  =3D 2,
> +    DMASR_SLVERR =3D 1 << 5,
>

We should also add DMASR_DECERR =3D 1 << 6


>      DMASR_IOC_IRQ  =3D 1 << 12,
>      DMASR_DLY_IRQ  =3D 1 << 13,
> +    DMASR_ERR_IRQ  =3D 1 << 14,
>
>      DMASR_IRQ_MASK =3D 7 << 12
>  };
> @@ -190,17 +192,27 @@ static inline int streamid_from_addr(hwaddr addr)
>      return sid;
>  }
>
> -static void stream_desc_load(struct Stream *s, hwaddr addr)
> +static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)
>  {
>      struct SDesc *d =3D &s->desc;
>
> -    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d,
> sizeof *d);
> +    MemTxResult result =3D address_space_read(&s->dma->as,
> +                                            addr, MEMTXATTRS_UNSPECIFIED=
,
> +                                            d, sizeof *d);
> +    if (result !=3D MEMTX_OK) {
> +        s->regs[R_DMACR] &=3D ~DMACR_RUNSTOP;
> +        s->regs[R_DMASR] |=3D DMASR_HALTED;
> +        s->regs[R_DMASR] |=3D DMASR_SLVERR;
>

... and map MEMTX_DECODE_ERROR to DMASR_DECERR and everything else to
SLVERR, for example:
if (result =3D=3D MEMTX_DECODE_ERROR) {
    s->regs[R_DMASR] |=3D DMASR_DECERR;
} else {
    s->regs[R_DMASR] |=3D DMASR_SLVERR;
}


> +        s->regs[R_DMASR] |=3D DMASR_ERR_IRQ;
> +        return result;
> +    }
>
>      /* Convert from LE into host endianness.  */
>      d->buffer_address =3D le64_to_cpu(d->buffer_address);
>      d->nxtdesc =3D le64_to_cpu(d->nxtdesc);
>      d->control =3D le32_to_cpu(d->control);
>      d->status =3D le32_to_cpu(d->status);
> +    return result;
>  }
>
>  static void stream_desc_store(struct Stream *s, hwaddr addr)
> --
> 2.34.1
>
>

--000000000000ba4de90619f9a9e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Jun 3, 2024 at 7:47=E2=80=AFAM Fe=
a.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com">fea.wang@sifive.com</a>&g=
t; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Loading a description from memory may cause a bus-erro=
r. In this<br>
case, the DMA should stop working, set the error flag, and return<br>
the error value.<br>
<br>
Signed-off-by: Fea.Wang &lt;<a href=3D"mailto:fea.wang@sifive.com" target=
=3D"_blank">fea.wang@sifive.com</a>&gt;<br></blockquote><div><br></div><div=
><br></div><div>Hi Fea,</div><div><br></div><div>I&#39;ve got a couple of s=
mall comments:</div><div>=C2=A0</div><div><br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
---<br>
=C2=A0hw/dma/xilinx_axidma.c | 16 ++++++++++++++--<br>
=C2=A01 file changed, 14 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c<br>
index 0ae056ed06..4b475e5484 100644<br>
--- a/hw/dma/xilinx_axidma.c<br>
+++ b/hw/dma/xilinx_axidma.c<br>
@@ -71,8 +71,10 @@ enum {<br>
=C2=A0enum {<br>
=C2=A0 =C2=A0 =C2=A0DMASR_HALTED =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0DMASR_IDLE=C2=A0 =3D 2,<br>
+=C2=A0 =C2=A0 DMASR_SLVERR =3D 1 &lt;&lt; 5,<br></blockquote><div><br></di=
v><div>We should also add DMASR_DECERR =3D 1 &lt;&lt; 6</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0DMASR_IOC_IRQ=C2=A0 =3D 1 &lt;&lt; 12,<br>
=C2=A0 =C2=A0 =C2=A0DMASR_DLY_IRQ=C2=A0 =3D 1 &lt;&lt; 13,<br>
+=C2=A0 =C2=A0 DMASR_ERR_IRQ=C2=A0 =3D 1 &lt;&lt; 14,<br>
<br>
=C2=A0 =C2=A0 =C2=A0DMASR_IRQ_MASK =3D 7 &lt;&lt; 12<br>
=C2=A0};<br>
@@ -190,17 +192,27 @@ static inline int streamid_from_addr(hwaddr addr)<br>
=C2=A0 =C2=A0 =C2=A0return sid;<br>
=C2=A0}<br>
<br>
-static void stream_desc_load(struct Stream *s, hwaddr addr)<br>
+static MemTxResult stream_desc_load(struct Stream *s, hwaddr addr)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct SDesc *d =3D &amp;s-&gt;desc;<br>
<br>
-=C2=A0 =C2=A0 address_space_read(&amp;s-&gt;dma-&gt;as, addr, MEMTXATTRS_U=
NSPECIFIED, d, sizeof *d);<br>
+=C2=A0 =C2=A0 MemTxResult result =3D address_space_read(&amp;s-&gt;dma-&gt=
;as,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 addr, MEMTXATTRS_UNSPECIFIED,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 d, sizeof *d);<br>
+=C2=A0 =C2=A0 if (result !=3D MEMTX_OK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMACR] &amp;=3D ~DMACR_RUNSTOP;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_HALTED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_SLVERR;<br></bl=
ockquote><div><br></div><div>... and map MEMTX_DECODE_ERROR to DMASR_DECERR=
 and everything else to SLVERR, for example:</div><div>if (result =3D=3D ME=
MTX_DECODE_ERROR) {</div><div>=C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_=
DECERR;</div><div>} else {<br><div>=C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D D=
MASR_SLVERR;</div></div><div>}</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[R_DMASR] |=3D DMASR_ERR_IRQ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Convert from LE into host endianness.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;buffer_address =3D le64_to_cpu(d-&gt;buffer_addre=
ss);<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;nxtdesc =3D le64_to_cpu(d-&gt;nxtdesc);<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;control =3D le32_to_cpu(d-&gt;control);<br>
=C2=A0 =C2=A0 =C2=A0d-&gt;status =3D le32_to_cpu(d-&gt;status);<br>
+=C2=A0 =C2=A0 return result;<br>
=C2=A0}<br>
<br>
=C2=A0static void stream_desc_store(struct Stream *s, hwaddr addr)<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000ba4de90619f9a9e9--

