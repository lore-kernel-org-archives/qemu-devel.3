Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C492DD5A6DC
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 03:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFmfJ-0008Tc-Vv; Mon, 25 Nov 2024 22:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFmfH-0008Sv-Pn; Mon, 25 Nov 2024 22:55:03 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFmfG-0006ur-BJ; Mon, 25 Nov 2024 22:55:03 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e5f6e44727so2923646b6e.0; 
 Mon, 25 Nov 2024 19:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732593300; x=1733198100; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Mmqcbtlt+klpWyRG3GmFv/UEI56uqJChQEwlSl6sC4=;
 b=fNuZO2Kmi9v/rrP14hjtQMglN//fnJKu5/bndQUCeVPFK00m1rfF77pNnFWLP2M/fC
 eVS2HAFAegEm2ekF9BFw5MDqiRks4fw4iz1JkmXLmoNNbWsK7B3Dcc7IFBAHoRxOyDyw
 KSFQO/2RgIEoYFasxbVJWi705ZP1RIDTol91eL+Qe5kwaLN8cZuHpODhvGjNjhrinxbW
 O7fbwq4mLMktjLJ8Yu1o6b4rNJ3DagguIy7XJP4yzZU+Hh8T8h3Z7giGn8YFtLC1DBw9
 iV43U3Nir8gBrAC21df/a6IuFtGJqxQb+SOwjeY3mYhPJxTsclJY/kRxyO9RG88iTWqw
 fS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732593300; x=1733198100;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Mmqcbtlt+klpWyRG3GmFv/UEI56uqJChQEwlSl6sC4=;
 b=RWGuP+x7i1BZYBIYuWYoe2+1ztWTSaBeKunoENk0PNqjKiw6fMEW5+T0lpxPemcrS+
 CcQX2L5hyZed270x0HBPN7KJOjj2PmXxEiKyH5wS4NutYfWp8Ul9tywI0ylNObTO91YZ
 kZHu3IjhsYndBJxjJQa65kj4weG54zzGgKUptxVb+aVVVEbuFnI9MfDnyWRbudLeI3/3
 4iY2OjS+KV1nV6woMg9EN+QjxRAthXWstg0o5hQaNxE290frW4FfDDPzbBrha043Yf6T
 NtcnoOhV2RiEOwPMgHbuZ3GMDnr9VOOLKEJKjiilRCWE7+sd9UC7oBKMWLrawMOKy2/d
 2s2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo+ETbF1TpG52++H+hzwF4eId9U2AV/QDDBT1Ni72RxFLc1yl7m8zzo2Q66m/WyNl2aiyv8R1ZKg==@nongnu.org
X-Gm-Message-State: AOJu0Yyzrm3dRhETOIpUFHGNMJwXn2v9horsy5A7ysvUvpVCFl2VrCEs
 bwMtV12GKBr/nPZ4Rp3ZoFhc40dYtqET9cPxYs7NfgN/THU9M+pr
X-Gm-Gg: ASbGncuQtz3xDu1P56Ip6w3w+HCSLaY470AOi7680MBUPMkSrJAUTHzsIcfdp3eSGr+
 tbbXTzbq+xiDo8woz6LLgtB4YzsnCjqak6TeWXSTYRU5DPht5v9UXMZla3I/EiKzNQ3LAKnNwPQ
 VjeKah5aO4BYQfjFkQHdHcOJw3FrUx5fGdROuWxoVN+kytqdP1tKAT3mo6tXSxM9KC4K2pqIazw
 1OXRl715lmeC+6gAxkEOwagGMKfVYB/xmEq0Y+h
X-Google-Smtp-Source: AGHT+IGfuPlt/h4AyqihR8hpan3zRg1bkQBev6NNsEKTL6O9b2bZmge8b/p2sadgpD+G4sMYiphViQ==
X-Received: by 2002:a05:6808:2228:b0:3e6:5b89:de24 with SMTP id
 5614622812f47-3e91581c659mr13046010b6e.11.1732593300312; 
 Mon, 25 Nov 2024 19:55:00 -0800 (PST)
Received: from localhost ([1.146.45.41]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724df8b04f2sm7433267b3a.66.2024.11.25.19.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 19:54:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Nov 2024 13:54:53 +1000
Message-Id: <D5VT2APZ0C4M.2BNQ7AT62V693@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Chalapathi V" <chalapathi.v@linux.ibm.com>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Glenn Miles"
 <milesg@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/pnv: Add xscom- prefix to pervasive-control
 region name
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-ppc@nongnu.org>, "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas"
 <farosas@suse.de>
X-Mailer: aerc 0.18.2
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-5-npiggin@gmail.com>
 <03d94b2b-4653-4401-a33d-8581ec022ced@linaro.org>
In-Reply-To: <03d94b2b-4653-4401-a33d-8581ec022ced@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Nov 26, 2024 at 5:28 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>
> On 25/11/24 14:20, Nicholas Piggin wrote:
> > By convention, xscom regions get a xscom- prefix.
> >=20
> > Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet mod=
el")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/pnv_nest_pervasive.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/pnv_nest_pervasive.c b/hw/ppc/pnv_nest_pervasive.c
> > index 77476753a4..780fa69dde 100644
> > --- a/hw/ppc/pnv_nest_pervasive.c
> > +++ b/hw/ppc/pnv_nest_pervasive.c
> > @@ -177,7 +177,7 @@ static void pnv_nest_pervasive_realize(DeviceState =
*dev, Error **errp)
> >       pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
> >                             OBJECT(nest_pervasive),
> >                             &pnv_nest_pervasive_control_xscom_ops,
> > -                          nest_pervasive, "pervasive-control",
> > +                          nest_pervasive, "xscom-pervasive-control",
>
> Could this break migration stream? Or only RAM regions need to
> have a stable name? I don't remember, but try be be cautions with
> such cosmetic change just before the release ;)

Hey Phil,

Thanks for always somehow being across everything :)

For the powernv machine we are okay since we don't support migration
at all. It's on the wishlist, but at the moment we have lots of
hardware models that don't provide vmstate. So I think we are okay.

Thanks,
Nick

