Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E890BCCFA15
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 04:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stfmB-0000CB-CI; Thu, 26 Sep 2024 00:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1stfm9-000082-0V; Thu, 26 Sep 2024 00:06:45 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1stfm5-0005yQ-VG; Thu, 26 Sep 2024 00:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1727323590;
 bh=AwjHvTMNDuVr5eQ2V3HiI+0UovJyD2/N/4ItkGP5phw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=FfpfbmE6VFQXdc1RI0EEKBYj1jrJjNUZTJP3n4aH3BCIGoCDbOUD4j+auIPS1MSZM
 exgSsQSHvif3vMmsGgfNUd/Eq+Z2upBMRYeHXLCurqee3S53xwPSwYm6I42GERvO1y
 BEOgKRfr8/Yg9qBZ859Vumc428bzQ93XuvAZIyG0GBzrN6CAjAUezI2XLYggCcPXl/
 X++gxsncQA/7iAcTSQu5RTWSlGteaXudXIMMawFpGLotoqdH4rMm4C7O3+0lWJeggs
 43Wlu1p5sbJUr9RhEl2m9bthZlgmdR1hJeM1Y7u0xNDxZWsrZ21vcp6nUV8V6OGxQC
 YRL2P1E6tii4g==
Received: from [192.168.68.112]
 (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 43EA66508E;
 Thu, 26 Sep 2024 12:06:28 +0800 (AWST)
Message-ID: <2fc6fc4954ff4a769c5ebd4562ce37280fd87c07.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 4/6] hw/gpio/aspeed: Fix clear incorrect interrupt
 status for GPIO index mode
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Joel Stanley
 <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
Date: Thu, 26 Sep 2024 13:36:25 +0930
In-Reply-To: <20240925033454.4117445-5-jamin_lin@aspeedtech.com>
References: <20240925033454.4117445-1-jamin_lin@aspeedtech.com>
 <20240925033454.4117445-5-jamin_lin@aspeedtech.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Jamin,

On Wed, 2024-09-25 at 11:34 +0800, Jamin Lin wrote:
> The interrupt status field is W1C, where a set bit on read indicates an
> interrupt is pending. If the bit extracted from data is set it should
> clear the corresponding bit in group_value. However, if the extracted
> bit is clear then the value of the corresponding bit in group_value
> should be unchanged.
>=20
> SHARED_FIELD_EX32() extracts the interrupt status bit from the write
> (data). group_value is set to the set's interrupt status, which means
> that for any pin with an interrupt pending, the corresponding bit is
> set. The deposit32() call updates the bit at pin_idx in the group,
> using the value extracted from the write (data).
>=20
> The result is that if multiple interrupt status bits
> were pending and the write was acknowledging specific one bit,
> then the all interrupt status bits will be cleared.
> However, it is index mode and should only clear the corresponding bit.
>=20
> For example, say we have an interrupt pending for GPIOA0, where the
> following statements are true:
>=20
>    set->int_status =3D=3D 0b01
>    s->pending =3D=3D 1
>=20
> Before it is acknowledged, an interrupt becomes pending for GPIOA1:
>=20
>    set->int_status =3D=3D 0b11
>    s->pending =3D=3D 2
>=20
> A write is issued to acknowledge the interrupt for GPIOA0. This causes
> the following sequence:
>=20
>    reg_value =3D=3D 0b11
>    pending =3D=3D 2
>    s->pending =3D 0

Note that I had a typo in my reply that prompted this patch, this was
meant to be:

    s->pending =3D=3D 0

>    set->int_status =3D=3D 0b00
>=20
> It should only clear bit 0 in index mode and the correct result
> should be as following.
>=20
>    set->int_status =3D=3D 0b11
>    s->pending =3D=3D 2
>=20
>    pending =3D=3D 1
>    s->pending =3D 1

Same typo here now :)

    s->pending =3D=3D 1

>    set->int_status =3D=3D 0b10
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/gpio/aspeed_gpio.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index 6e6ab48b56..58ae63e3c1 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -642,7 +642,7 @@ static void aspeed_gpio_write_index_mode(void *opaque=
, hwaddr offset,
>      uint32_t pin_idx =3D reg_idx_number % ASPEED_GPIOS_PER_SET;
>      uint32_t group_idx =3D pin_idx / GPIOS_PER_GROUP;
>      uint32_t reg_value =3D 0;
> -    uint32_t cleared;
> +    uint32_t pending =3D 0;
> =20
>      set =3D &s->sets[set_idx];
>      props =3D &agc->props[set_idx];
> @@ -705,15 +705,16 @@ static void aspeed_gpio_write_index_mode(void *opaq=
ue, hwaddr offset,
>          set->int_sens_2 =3D update_value_control_source(set, set->int_se=
ns_2,
>                                                        reg_value);
>          /* set interrupt status */
> -        reg_value =3D set->int_status;
> -        reg_value =3D deposit32(reg_value, pin_idx, 1,
> -                              FIELD_EX32(data, GPIO_INDEX_REG, INT_STATU=
S));
> -        cleared =3D ctpop32(reg_value & set->int_status);
> -        if (s->pending && cleared) {
> -            assert(s->pending >=3D cleared);
> -            s->pending -=3D cleared;
> +        if (FIELD_EX32(data, GPIO_INDEX_REG, INT_STATUS)) {
> +            pending =3D extract32(set->int_status, pin_idx, 1);
> +            if (pending) {
> +                if (s->pending) {
> +                    assert(s->pending >=3D pending);
> +                    s->pending -=3D pending;
> +                }
> +                set->int_status =3D deposit32(set->int_status, pin_idx, =
1, 0);
> +            }

So I think we can get away without the nested conditionals?

   if (FIELD_EX32(data, GPIO_INDEX_REG, INT_STATUS)) {
       /* pending is either 1 or 0 for a 1-bit field */
       pending =3D extract32(set->int_status, pin_idx, 1);
      =20
       /*
        * The assert is effectively a compressed form of
        *
        *     assert((s->pending =3D=3D 0 && pending =3D=3D 0) ||
        *            (s->pending >=3D 1));
        *
        * This seems reasonable.
        *
        * Another way to write it is:
        *
        *     assert(!pending || s->pending));
        */
       assert(s->pending >=3D pending);
  =20
       /* No change to s->pending if pending is 0 */
       s->pending -=3D pending;
  =20
       /*
        * The write acknowledged the interrupt regardless of whether it
        * was pending or not. The post-condition is that it mustn't be
        * pending. Unconditionally clear the status bit.
        */
       s->int_status =3D deposit32(set->int_status, pin_idx, 1, 0);
   }
  =20
Thoughts?

Up to you whether you keep the comments if the idea makes sense and you
choose to adopt it.

Andrew

