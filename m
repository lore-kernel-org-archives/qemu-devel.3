Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681DFE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5g-0006gA-IM; Mon, 29 Dec 2025 14:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4o-0004zP-Aq
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:57 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4m-0000PB-Vf
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:46 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3868321cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037124; cv=none;
 d=google.com; s=arc-20240605;
 b=FfooHnTqUX1oSShkePd5/4y32JA1Mrg/c0hqgqJe0IgDtrxNu3pPXZ72Z5Giim83nD
 1BsUQSAVCSXsupUtIaoYqbf0Tp4sgKydrNfQjayIqHPhdWKclP8tmbVFPc4Rg6yunZZW
 WhqIQXq+9sABlrFE95/f4n2vzkbszEJKiLr8g/A7v+x06VGlqDoEOeTV943fygovdaIo
 Z/HcQ0+/2+STzCVdUEhMBGLsQtez/51gc6vfGfr4QCaC+FTs0Gifj+eAv7XmVZcnzNe+
 j+853IEDQbeuGrbF1YGpb/woWt9W/I3+Zdwfa9eSEBtlQB2F+DwJ4gTY1OURO/Xo3dsD
 TetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TjKf2F5ulFPO+H27YnF74bzMVix26xHFciWmteYvCJ8=;
 fh=y4LdpoCOt1xL1JNSAOpf53utTdlQAFxIKpkZGdPlhn0=;
 b=XOV03vr7hcotSWYVSbcZ8raSHXDA9AvygYT1sGumOiyFalabR8p8k3KHl49uZ7MkMq
 pakHWQXlmo8EIIm5okBIY8gBnk4DyLU06bOyG+HaSOe7JYtt2mBt83il7VwVv9JTbgWI
 MFdeY/EtEJxRcSyxPHwMmuwQoygpQGzXXjx6MN8OIOVb0eii0ZtyrhZjANtNH2IOZV0Y
 QuJwVBga5/T/eIlcSTwnZH16uiHAjo7BqVHgng9XgxqOE6qt177tXFuInfjbErk1s1hD
 eYGUfyGdiO9DTDrAgdn0btPoyToLsEyF3X0d4cK1YICABwmAPJ68NafQ3K6JyqMj7QYY
 oYdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037124; x=1767641924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjKf2F5ulFPO+H27YnF74bzMVix26xHFciWmteYvCJ8=;
 b=lqe0/RZRXQ6H+UizkIjAxW0LpaGSYLzKGDjQ6/E8d6pGv1C9U7I4Vikz7nOw206sAa
 G8DYY8Q89d9p2GNaAOqlr48+jmiebIPcIqAJBgqkkDqS/cc2qtagQkfFowaSclTds7sM
 tAAqmUdGK8gawrICRi6473SluCDMSyLA89yZ/d3VHLizIs/hY1XKLg3x7pApMrA/x1FR
 f5xYbykZD2+8gbqs46qy/AxlKHiDNA6N8YnOh4PAGaiE2bXO/Q39/zyUbAcNhd3OaxNJ
 T+Xla7arxD/0dW+Ey8cvMZ1AyDzQ4SHa0Rz/q+/HBd4n58CdU9nG6eGaUjqPJ/EFDUee
 GaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037124; x=1767641924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjKf2F5ulFPO+H27YnF74bzMVix26xHFciWmteYvCJ8=;
 b=S8cFjWSMYqRf4/nfhCn8a9lfXWW2QeKFMyKIq+vDci5D1Y65dFFFsKWuMpFlqg5tIk
 Arxg9PEKCYX4CM2c+d3swm8QCg4Duq/QD/Lq2l2+2Bt9qDWdt2cUybQByqpYfQ9/8jBN
 MiAeQgC0UZCSjC5iZjB1f8cc8Sujwg9j3uLC4ovyl3+DKVtbH98HXgNCYkTlOzteKvQ+
 0YU/WJHrL7YbZlT+2lusw2vJC5uUUxMNsxZUSPf4JPAZvg+LIg0JVMvWg+YUbxdTm8bf
 Dvx/bKs4If/Xsll5It8VoskcEIYvHelM1G6pQHvVXN2Kl/DfdmJTS2bt9U+Rq5XA+lSt
 XWyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVeaFt3MUm++pbc4WZira9pIePVd/l2uuAEJa+gaqw7ZrigW/Yq7Bb7GylHDD/pykIm3LmO6H1xUqG@nongnu.org
X-Gm-Message-State: AOJu0Ywxk/e+0MTNLDo5A4LMDtC0POjYfVm7lm6lXTaezxionhPBuIHF
 w3c8vAX4GhcGaDrPJGGIXDvAonlicluxQ2GGwBw3bdJTgMj84CAVJJGFjP4VBu6kabcK/xoLuzO
 L6nKm9sIWe9J9bSMPcetu58ToLFGHL0c2x94TSVG7
X-Gm-Gg: AY/fxX5TQh8LFg+zp8lD1V9/s0HPnJ7cx5W6Tgf+iM/gwYva0jCqSmjzci4hPJ6cfVG
 RxKNOuNpgIhAB9WTj9A6OYb6OQE6xWXmhGwC/0rcMoWFjf0leCXCIelezCPpBUHJcCoF3K2MyD1
 MtHg2Uy4TGBcFAzPB+SSJJASx1FaAauidTw74UobgwcyJvdJAyN8mbtus6hHzH+6f7CHpDJg4h7
 CRe2mS6yumGJKBb+uAKbYcj2ej/xTzzqxI3ftFxi5NGWY51vr8VcX8UKauURRjA/h+dQU7ZGRUy
 zIv6kykhE3xMnZBcgA35NdRK1A==
X-Google-Smtp-Source: AGHT+IGPk2F+0ZlqQ6FyuiPXDvTXxNn5HD5/vYJk2ILuWsUH20DkcoIJl6NjEF9QLO8cz9N3KNvZTAblzX2g54rrHp0=
X-Received: by 2002:ac8:6216:0:b0:4f4:e645:2b6 with SMTP id
 d75a77b69052e-4f5fb649f7amr16613031cf.2.1767037123749; Mon, 29 Dec 2025
 11:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-20-kane_chen@aspeedtech.com>
 <cf900ae1-e631-46ef-9552-2860a5b25ae6@kaod.org>
In-Reply-To: <cf900ae1-e631-46ef-9552-2860a5b25ae6@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:32 -0800
X-Gm-Features: AQt7F2rw3SDKVve6HL4JYOSyEqLT378lZmW8Be883PN0QIJx6I2_Q5p0bQ5ZEh4
Message-ID: <CA+QoejVxYxWKXhErGRrybso2gBNxPZOdp89C0q9_Pfti=fsMyA@mail.gmail.com>
Subject: Re: [PATCH v4 19/19] hw/arm/aspeed: Enable AST1700 IO expander support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Dec 24, 2025 at 2:43=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 12/24/25 02:41, Kane Chen via wrote:
> > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >
> > Set ioexp_num to 2 to enable AST1700 IO expander support.
> >
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> > ---
> >   hw/arm/aspeed_ast27x0.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> > index 0807481162..2eb857b8e0 100644
> > --- a/hw/arm/aspeed_ast27x0.c
> > +++ b/hw/arm/aspeed_ast27x0.c
> > @@ -1260,7 +1260,7 @@ static void aspeed_soc_ast2700a1_class_init(Objec=
tClass *oc, const void *data)
> >       sc->macs_num     =3D 3;
> >       sc->uarts_num    =3D 13;
> >       sc->num_cpus     =3D 4;
> > -    sc->ioexp_num    =3D 0;
> > +    sc->ioexp_num    =3D 2;
> >       sc->uarts_base   =3D ASPEED_DEV_UART0;
> >       sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;
> >       sc->memmap       =3D aspeed_soc_ast2700_memmap;
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

>
> Thanks,
>
> C.

