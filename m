Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD17DC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJiiT-0005G9-2A; Tue, 18 Jun 2024 19:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sJiiR-0005Ft-F9; Tue, 18 Jun 2024 19:58:19 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sJiiO-0004FL-IC; Tue, 18 Jun 2024 19:58:19 -0400
Received: from [192.168.68.112]
 (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5D5AB20127;
 Wed, 19 Jun 2024 07:58:01 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1718755084;
 bh=9W4PW0zYObPWa5VvdZ80quLsqvmKQ+u5HW4UxMKxKOc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=j+lt6iJsbEv5LIb73yh7jWH56TSu6s2/UJuREFIbcRWWPXGs6JIUIPlHF0Ph8UyHK
 u50MI57fcojYjqnH55HjN7BxAICo0jc+Svf+EOeR+9qNVYk9UEn3tpd7v3qnHCIPAc
 Gn7gj0OUvqX+Dv1Tx6Z+Bh/PpvC0YOuZjQCg0qnHzV43g4W8EtrKCCpMMmxmiDv/dQ
 Xf7wqAz+irUIVrkY2Kz8pKi+/BIAMBevhs5AoDs6tyAfFb00AIXCKKsnJBG2OWKBq6
 wGC9sgcESqcQZNGFND8R5LH+4h9FE1jOvcRNZCyDta+CFhdooo/jxaDuQ5JsOeyj0O
 Ph7CU76BgjIbA==
Message-ID: <bd15ab0597caad4564ca8f9498dfd3bbbe67df89.camel@codeconstruct.com.au>
Subject: Re: [PATCH] hw/gpio/aspeed: Add bounds checking for register table
 access
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Zheyu Ma <zheyuma97@gmail.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley
 <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Date: Wed, 19 Jun 2024 09:27:59 +0930
In-Reply-To: <20240618130928.3075494-1-zheyuma97@gmail.com>
References: <20240618130928.3075494-1-zheyuma97@gmail.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hello Zheyu Ma,

On Tue, 2024-06-18 at 15:09 +0200, Zheyu Ma wrote:
> Added bounds checking in the aspeed_gpio_read() and aspeed_gpio_write()
> functions to ensure the index idx is within the valid range of the
> reg_table array.
>=20
> The correct size of reg_table is determined dynamically based on whether
> it is aspeed_3_3v_gpios or aspeed_1_8v_gpios. If idx exceeds the
> size of reg_table, an error is logged, and the function returns.
>=20
> AddressSanitizer log indicating the issue:
>=20
> =3D=3D2602930=3D=3DERROR: AddressSanitizer: global-buffer-overflow on add=
ress 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e8=
8
> READ of size 2 at 0x55a5da29e128 thread T0
>     #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
>     #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:=
11
>     #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
>     #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:142=
6:16
>     #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459=
:9
>     #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:283=
6:18
>     #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
>     #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12

I'm mildly interested in what you were doing to trigger this. Certainly
we could do with a guard in the model to prevent it, but I'm curious
all the same.

>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/gpio/aspeed_gpio.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
> index c1781e2ba3..1441046f6c 100644
> --- a/hw/gpio/aspeed_gpio.c
> +++ b/hw/gpio/aspeed_gpio.c
> @@ -550,6 +550,7 @@ static uint64_t aspeed_gpio_read(void *opaque, hwaddr=
 offset, uint32_t size)
>      GPIOSets *set;
>      uint32_t value =3D 0;
>      uint64_t debounce_value;
> +    uint32_t reg_table_size;
> =20
>      idx =3D offset >> 2;
>      if (idx >=3D GPIO_DEBOUNCE_TIME_1 && idx <=3D GPIO_DEBOUNCE_TIME_3) =
{
> @@ -559,6 +560,18 @@ static uint64_t aspeed_gpio_read(void *opaque, hwadd=
r offset, uint32_t size)
>          return debounce_value;
>      }
> =20
> +    if (agc->reg_table =3D=3D aspeed_3_3v_gpios) {
> +        reg_table_size =3D GPIO_3_3V_REG_ARRAY_SIZE;
> +    } else {
> +        reg_table_size =3D GPIO_1_8V_REG_ARRAY_SIZE;
> +    }

I think I'd prefer we add reg_table_size as a member of AspeedGPIOClass
and initialise it at the same time as we initialise reg_table. I feel
it would help maintain safety in the face of future changes (i.e. if
another reg table were introduced). With that approach the hunk above
can be dropped.

> +
> +    if (idx >=3D reg_table_size) {

This condition would then become:

```
if (idx >=3D agc->reg_table_size) {
```

Thoughts?

Andrew

