Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C89CF9C71
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 00:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stFSX-0008U8-2t; Tue, 24 Sep 2024 20:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1stFSV-0008T8-BT; Tue, 24 Sep 2024 20:00:43 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1stFST-0003zt-HN; Tue, 24 Sep 2024 20:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1727222438;
 bh=jlzWUITownkYSxYBYJ9XWWY/bFQv87QCE81ZP+DBu/M=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=bjUZR+6eGRYYkYmshJcFphg7LJni+B98poN9Qw5T+Im4ke/ogwjUAXkEpOwVej86f
 MIrJuFgpYFnLVgkLdBeNZuEGvNuy7FoHTlJEwYRCAeJM9ylp+dtYxXM+fg7h2YrqDv
 zbNztaFKiR/I93ASsKJP5FeE92czIYbqSIYVC82fqpHjdwG5CHV+d9EofS2gVWa9VW
 nZB1SloPkVxPv/naq6QGsOnVU74t0LKNaJ9bRM9/vuLemNMEGh1Ay8nFXzX4vBURgr
 +VV35z2DFbvKJx+MZfUCn22+TfpJzj8yOZrMqeIm25V5Rc764fUWzulUF6THhNlwBP
 7KFQWQKJv/eIA==
Received: from [192.168.68.112]
 (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1867A65013;
 Wed, 25 Sep 2024 08:00:38 +0800 (AWST)
Message-ID: <622300963fae35522af6d90248bb93a6a4d91121.camel@codeconstruct.com.au>
Subject: Re: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Date: Wed, 25 Sep 2024 09:30:36 +0930
In-Reply-To: <SI2PR06MB504195FD5CE33E041514C46BFC682@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240923094206.1455783-1-jamin_lin@aspeedtech.com>
 <20240923094206.1455783-5-jamin_lin@aspeedtech.com>
 <e5d149765b338d4754054691cb83eacdf3e2642f.camel@codeconstruct.com.au>
 <SI2PR06MB50413C10FCB429361E467246FC682@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <SI2PR06MB504195FD5CE33E041514C46BFC682@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-09-24 at 06:48 +0000, Jamin Lin wrote:
> Hi Andrew,
>=20
> > Subject: RE: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
> >=20
> > Hi Andrew,
> >=20
> > > Subject: Re: [PATCH 4/5] hw/gpio/aspeed: Add AST2700 support
> > >=20
> > > Hi Jamin,
> > >=20
> > >=20
> > > > +    }
> > > > +    set->int_status &=3D ~group_value;
> > >=20
> > > This feels like it misbehaves in the face of multiple pending interru=
pts.
> > >=20
> > > For example, say we have an interrupt pending for GPIOA0, where the
> > > following statements are true:
> > >=20
> > >    set->int_status =3D=3D 0b01
> > >    s->pending =3D=3D 1
> > >=20
> > > Before it is acknowledged, an interrupt becomes pending for GPIOA1:
> > >=20
> > >    set->int_status =3D=3D 0b11
> > >    s->pending =3D=3D 2
> > >=20
> > > A write is issued to acknowledge the interrupt for GPIOA0. This cause=
s
> > > the following sequence:
> > >=20
> > >    group_value =3D=3D 0b11
> > >    cleared =3D=3D 2
> > >    s->pending =3D 0
> > >    set->int_status =3D=3D 0b00
> > >=20
> > > It seems the pending interrupt for GPIOA1 is lost?
> > >=20
> > Thanks for review and input.
> > I should check "int_status" bit of write data in write callback functio=
n. If 1 clear
> > status flag(group value), else should not change group value.
> > I am checking and testing this issue and will update to you or directly=
 resend
> > the new patch series.
>=20
> I appreciate your review and finding this issue.
> My changes as following.
> If you agree, I will add them in v2 patch.
> Thanks-Jamin
>=20
> static void aspeed_gpio_2700_write_control_reg(AspeedGPIOState *s,
>                                 uint32_t pin, uint32_t type, uint64_t dat=
a)
> {
> ---
>     /* interrupt status */
>     if (SHARED_FIELD_EX32(data, GPIO_CONTROL_INT_STATUS)) {
>         cleared =3D extract32(set->int_status, pin_idx, 1);
>         if (cleared) {
>             if (s->pending) {
>                 assert(s->pending >=3D cleared);
>                 s->pending -=3D cleared;
>             }
>             set->int_status =3D deposit32(set->int_status, pin_idx, 1, 0)=
;
>         }
>     }
> ----
> }

The logic is easier to follow. Not sure about calling the value
extracted from set->int_status 'cleared' though, seems confusing on
first pass. It would feel more appropriate if it were called 'pending'.
I think 'cleared' is derived from `SHARED_FIELD_EX32(data,
GPIO_CONTROL_INT_STATUS)`. Anyway, that's just some quibbling over
names.

>=20
> By the way, I found the same issue in "aspeed_gpio_write_index_mode" and =
my changes as following.
> If you agree this change, I will create a new patch in v2 patch series.
>=20
> static void aspeed_gpio_write_index_mode(void *opaque, hwaddr offset,
>                                                 uint64_t data, uint32_t s=
ize)
> {
> ---
>     case gpio_reg_idx_interrupt:
>         if (FIELD_EX32(data, GPIO_INDEX_REG, INT_STATUS)) {
>             cleared =3D extract32(set->int_status, pin_idx, 1);
>             if (cleared) {
>                 if (s->pending) {
>                     assert(s->pending >=3D cleared);
>                     s->pending -=3D cleared;
>                 }
>                 set->int_status =3D deposit32(set->int_status, pin_idx, 1=
, 0);
>             }
>         }
>         break;
> ---
> }

I'll take a look in v2.

Cheers,

Andrew


