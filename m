Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CE4C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 16:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vibTV-0008Dq-9W; Wed, 21 Jan 2026 11:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vibT1-00081R-Vz
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:54:07 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vibSz-0004aD-Hw
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 11:54:02 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-5014acad6f2so115231cf.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 08:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014439; cv=none;
 d=google.com; s=arc-20240605;
 b=HYM7lakgFLdp/umQlUcqLKLXRSSksieCrHvXZ89Z+kP3PtRo/TaID/N46i8Ci9AhSB
 HtOylfqvOW38ppKe3IzgxAoj34C2hG8s0IiFxK661AJGaWQ1V3C93dW6R35djetfpqrp
 4PUS5HBqTYUdzwwhgRKTOVm84l6+U7sQxtn2+Q1S77YdVqD1cj9aKgt5aKGicWODUnhy
 R/HSDcEN/jgG20ZzPVS7WZoFnUr2k+G+MdI70PQQHBwReaG8uiQsdlIjuUPByrMD5PZX
 77IL40LZu5pth/8Wddl0XEujAjss+kDHbxzXrzjge/0hcu9u4PkUG5qbgoc4sAiNoB11
 LC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zVBXv97/W8tGi1TQadV2BmfMIlfNcnjKlrvG2zWQQpo=;
 fh=OkdQJehu1hb4ktnQdUsz+z8b81gDf7F26/Q1A558pGQ=;
 b=BbRmArQuJCLqVju4Lyiz4ut+XbuqpN59QEPEGwjpExLW0nfLRUoxXeuTJbDr5fJ1Nx
 hIphBfS98w0QpV7va1Z4aJ7gAGQLj090bi0sWA96SqRKtDJsMSWrepuav6TiHz84KbBY
 q8xbadmfXf949YOUBjLNZEUawkQu9en4M71b1yk1TceA1Qs2v2hX4D+Hsp3a32rcUnl1
 ATScEeGcvpY2jz5SPCrJZ4Nl5Pzh5hAwzv1P/sTrmOBpBgbHaHMsrElx2AxKfE3mqMz+
 UQZW+HDMIvofZ2DhW2VPMwytu2WdQEBnCLc4scZbRcyZ/vgjDOfqQUIY83gsMaAItjoZ
 f0cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1769014439; x=1769619239; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVBXv97/W8tGi1TQadV2BmfMIlfNcnjKlrvG2zWQQpo=;
 b=UW+E8ABvCoA5kYC3gxo3woGV76JyHGjav8SL/F7BaqBT0C72+JSnvvijoZTGkVro/7
 jYjRf69MXBPVkMdx7EnAyZbxzLikb/IOhgEdtoa2+Jkaqoko5gx3riv6HHfCfUI7Sz2u
 /oesFiN1XR7FLlyrn6Fx8yEulc1mgmAjRXdZzRR6tPtDXS66Mzmb6JvRg6G0zK6pSrXq
 GcODieJ+hfCfso9pxo0otl1qmUvRJTwMxpA96YYAjXxmzfAnu4B8ya2WEZHhd/y3osp6
 dIulTqpnhfhB0oGqWWBnYUNC35PdIsWSy4N2ar8kiLpPslzkem1yFuidtfQtET3634bj
 MN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769014439; x=1769619239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVBXv97/W8tGi1TQadV2BmfMIlfNcnjKlrvG2zWQQpo=;
 b=grjkonhrfaif+Hwyx/vCBE4e1WS8m2Cig90pVUz8ELZKiqHyfJFKEAv41XK3U8lz/3
 0nfvZ/ai+IhAW18KsgMZYIFLRkiPCZGagStJylv6yOv3fyzmwMQwqMyjwC7W3QrlKnbK
 MAldnN6bWmvpPp8oDgvW40HjLdlNj+aFBGxPBlrv0CZgbfbUM/XiS1qz/87vouPrrEe7
 LwyaRjS/Tn2sg701bzLyi8yJL8/sbxUQU4X1Lp1nwYXLi7tbgKBUpNhNsLZqOGsROB1W
 Vfry2cYzHSa1FN1SnV0ki8sM0w5FnfFiU8foMEMWBEbqL+q0gowmLnZYMUpz3kWRgWIF
 JgSQ==
X-Gm-Message-State: AOJu0Yy2spOIVErX5/SbJmwpCSC4VDB07Gb1/1LJRQVHbw9LCysZwRrO
 AmatPgns3yfcCMxkEl6XSHZKx1YWoLiTepGTcQD+XRYO2dXE/JEz6PCg/oac2pEIXzjPMPwfixs
 L7ie0zOMupBa6Op6SePQWO5YlftVhViEziP3g+K+t
X-Gm-Gg: AZuq6aLF9sBOvEGjRWYA16pMq9sZN9QxJDRbRh/Gv+bzvVILA1D8w4ZDPHTDPtxCFKS
 E5G8V9jur9W9IcWc21fEzZ07exHhQpBSrcNYJM+4d7UnHHaRnaHd2zolEoUzva0ol5R5oeIWSV8
 Hl63KtgQVdkjPpsI1Mvpxd9ZjRgn29S9x+N+eY1gudbd04kUeHDNGXMiFLDPq86V7LKlomBjWe1
 n2xi4V6RWxjqA+47eKEu1xWmnyyYGcbbFB+bdM1MP7Ptj5Iy1kn2XcYm+nKY92t5wTB9h7vKAjb
 TK966jcxQfwKoGqa/+8YW2TcEUB6LoNUWaZsHPXZ2dRQWPVSsv+6fymRKxljWGrHwGt5Gbj/UWt
 oIhRIYjowRadLUqsiD6gr
X-Received: by 2002:ac8:5a54:0:b0:4ff:bfdd:3f46 with SMTP id
 d75a77b69052e-502e1a9caf0mr10764851cf.15.1769014438997; Wed, 21 Jan 2026
 08:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20260120211116.1367476-1-nabihestefan@google.com>
 <98c165bb-3f39-4254-96f4-7965bba8fcf2@kaod.org>
In-Reply-To: <98c165bb-3f39-4254-96f4-7965bba8fcf2@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 21 Jan 2026 08:53:46 -0800
X-Gm-Features: AZwV_Qjg5CgB9KpdltIBMWSc1TH9TuPwv9maHpPYQ1QiQHbkSZZLVLCTvqugsIo
Message-ID: <CA+QoejUoZkY8UgA7u0_gd2+ydFbefrC61qm3C_jUrOcjyuvdHw@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/aspeed_i2c.c: Add a check for dma_read
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, steven_lee@aspeedtech.com,
 leetroy@gmail.com, jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, 
 joel@jms.id.au, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -177
X-Spam_score: -17.8
X-Spam_bar: -----------------
X-Spam_report: (-17.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.182,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 20, 2026 at 11:43=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:
>
> On 1/20/26 22:11, Nabih Estefan wrote:
> > If aspeed_i2c_dma_read fails in aspeed_i2c_bus_send currently, we get
> > stuck in an infinite retry loop. Add a check for the return value of
> > aspeed_i2c_dma_read that will break us out of said loop.
>
>
> Have you ever encountered this kind of problem ?

I did when testing the AST1700. In one of the patchsets we had the
DRAM memory initialized but not the address space (v5 has this fixed)
but it took me a while to figure out what was happening because
instead of failing a `i2cdump` or `i2cget` command, it would just
hang. Presumably it can only happen on misconfigured or failing
devices that have some address space issue, but since aspeed_i2c_dma
returns an error if its fails I figured checking it had no real
downside.

- Nabih

>
> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > ---
> >   hw/i2c/aspeed_i2c.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> > index 1b8ac561c3..3de72db652 100644
> > --- a/hw/i2c/aspeed_i2c.c
> > +++ b/hw/i2c/aspeed_i2c.c
> > @@ -272,7 +272,11 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
> >           }
> >           while (bus->regs[reg_dma_len]) {
> >               uint8_t data;
> > -            aspeed_i2c_dma_read(bus, &data);
> > +            ret =3D aspeed_i2c_dma_read(bus, &data);
> > +            /* Check that we were able to read the DMA */
> > +            if (ret) {
> > +                break;
> > +            }
> >               trace_aspeed_i2c_bus_send("DMA", bus->regs[reg_dma_len],
> >                                         bus->regs[reg_dma_len], data);
> >               ret =3D i2c_send(bus->bus, data);
>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>
>
> Thanks,
>
> C.

