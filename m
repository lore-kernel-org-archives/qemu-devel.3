Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5668FC071FD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxr2T-000069-0e; Fri, 19 Apr 2024 12:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxr2Q-00005u-Dz
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:24:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rxr2O-00055R-Ij
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:24:34 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so3295139a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713543871; x=1714148671; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThOdf3CEKVS76HfiU+v7D2UgrXRt1rmfNWDmDmqWuvY=;
 b=mMsFpFfmKRKu10JO+x3wYb6hC3d5pfHL9Mg5FVPdwLkjzF0VhmMSVRZh66W2D1arty
 KOQTNu3/Nwchjx3kauY05l7pp+DnvDMpF3+lu45UdSNZ1XT4oykddr7skMiiIbp44tEA
 15yVYAgHaDUi+X/E8P3z+mxOH2PlUa5Mw0rVfsZvdjULXa9B4flwUi9sPgTdB/qxoOOG
 CH5KnfSRBzqatya1AOrly4FbvSxEpDSJOZ7yGyC3ArxMd9xlR2OR/2pXgipV5QYTD/60
 739jolivR1QIVPyC+My7gMEuVBjQ6QnzpqhsrkGTsVqi8NwKGNqCpDE/Vsz7L5e3SIEq
 YxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713543871; x=1714148671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThOdf3CEKVS76HfiU+v7D2UgrXRt1rmfNWDmDmqWuvY=;
 b=HEDJb0rGhw3UP1AjyTIX/OyhOFRbphFmqmtk1VEK0V7QBRl30mxyX36+ehZ4dU8Gcv
 560D17gq3VyBqjKADVYSOFktfBrgS9gF8bDe5hjo0BJJqGYSkphGJqVZH+2mugVqLcgx
 Qloi421l9tQzQo4uMJCnIN9WiUHZOeg2dhyhb9D+bEcKjk7/Tk/KcZ8EV/MuPFMR9i2J
 s/19lS7lZ4LgCSmw5ZcCY9r+sxOQH0YWZ4sEKR0VjYJLKDGvAKVfytEiHdugOHuKUHTi
 qmbrdmlPxnqKdsclht7YQmeIQZ00XKzdOdxClp7HePpJ8Y5P3zkfBXZbS/WuRlMV2TLd
 owBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWocEP24Lb0AbCuCUnmQQWZkXEWIH/cjtow4RmTd7yzWrHnQpu4nAR0NSMwWbeo90DDK4XKqGKGrcBJ9BCwabnnT/I0VOI=
X-Gm-Message-State: AOJu0Yzt4w4QeoxqNPWulRfFOSZ98JBQP1U4DUrhBNcyFdLaGtmjDBYD
 QPe1zNQcNDRyx0naNhMB4MDx8phSjceKTkkWox8gD/W5fHOd+unsDIn5kje0aiE/hUrqDPmI61Q
 aaE5yTjMR3GWscdHbZJI1kX3bNTESVIE3I3qiMBE+pqk/sLz4
X-Google-Smtp-Source: AGHT+IF+NkntMuL4xFbpCPWgyeyJVzcCFTmduE/pSTE+ZCH57YXceVBSmvP6QXkmZS2QlcYMAASGFtOeZR+DZq3zA10=
X-Received: by 2002:a50:ccd7:0:b0:56e:edc:9837 with SMTP id
 b23-20020a50ccd7000000b0056e0edc9837mr2481210edj.35.1713543870869; Fri, 19
 Apr 2024 09:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
 <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
 <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
 <CAFEAcA9wcaptrL5LHWah0MeKP1CV-WbfwsS65kibLwJ4TpvjTg@mail.gmail.com>
 <CACqcpZDv8gjKhMygmAWkyfYqPH-NVz4RpPb8Q0tBTege_Gro4Q@mail.gmail.com>
In-Reply-To: <CACqcpZDv8gjKhMygmAWkyfYqPH-NVz4RpPb8Q0tBTege_Gro4Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Apr 2024 17:24:19 +0100
Message-ID: <CAFEAcA939C3jQ+=of1L1+iGybTuPDfoL0+dgshuuyd9AKhXnQA@mail.gmail.com>
Subject: Re: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
To: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, luc@lmichel.fr, damien.hedde@dahe.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 19 Apr 2024 at 17:09, Raphael Poggi
<raphael.poggi@lynxleap.co.uk> wrote:
>
> Hi Peter,
>
> Le ven. 19 avr. 2024 =C3=A0 16:08, Peter Maydell <peter.maydell@linaro.or=
g> a =C3=A9crit :
> >
> > On Thu, 18 Apr 2024 at 21:39, Raphael Poggi
> > <raphael.poggi@lynxleap.co.uk> wrote:
> > > There is an assert "assert(clk->source =3D=3D NULL);" in clock_propag=
ate().
> > > If I am not wrong, clk->source is set when the clock has a parent.
> >
> > I think that assertion is probably there because we didn't
> > originally have the idea of a clock having a multiplier/divider
> > setting. So the idea was that calling clock_propagate() on a
> > clock with a parent would always be wrong, because the only
> > reason for its period to change would be if the parent had
> > changed, and if the parent changes then clock_propagate()
> > should be called on the parent.
> >
> > We added mul/div later, and we (I) didn't think through all
> > the consequences. If you change the mul/div settings on
> > clockB in this example then you need to call clock_propagate()
> > on it, so we should remove that assert(). Then when you change
> > the mul/div on clockB you can directly clock_propagate(clockB),
> > and I don't think you need this patch at that point.
>
> Alright, that makes sense, is that OK if I send a patch removing the asse=
rt ?

Yes, please do.

-- PMM

