Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04100C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 21:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reiP7-0002Cd-Aa; Mon, 26 Feb 2024 16:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aminier-21@enst.fr>)
 id 1reiP5-0002CA-71; Mon, 26 Feb 2024 16:20:51 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aminier-21@enst.fr>)
 id 1reiP3-0001TO-2Y; Mon, 26 Feb 2024 16:20:50 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 08F452055E;
 Mon, 26 Feb 2024 22:20:45 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 9g5ojEoZDx7I; Mon, 26 Feb 2024 22:20:44 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 121F7205AE;
 Mon, 26 Feb 2024 22:20:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 121F7205AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708982444;
 bh=oDDqEa7TVP+PicOhICN0EDwccbVAw447PBX5Y4cT60Q=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=2PRTloHwTiWaiIJh2GDwG6CRI0Bn1tL8bAYWr5eezuQcDDpGWO6KIuCvDEev1M9+d
 NoE+y3WmJUC+sEsM5drVMnC+7YiLCIAY0m+OhMXh8Hy/i+zRHKnWWcNq2k1hKkPWqp
 NVY0ppkc7rSwiuGT4gVFly6S8H4Khn84xtjgKyEQ=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id N-PxUIaM7lSc; Mon, 26 Feb 2024 22:20:43 +0100 (CET)
Received: from zmail-tp1.enst.fr (zmail-tp1.enst.fr [137.194.2.198])
 by zproxy4.enst.fr (Postfix) with ESMTP id D41BC2055E;
 Mon, 26 Feb 2024 22:20:42 +0100 (CET)
Date: Mon, 26 Feb 2024 22:20:42 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 qemu-arm <qemu-arm@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1283821622.11802412.1708982442539.JavaMail.zimbra@enst.fr>
In-Reply-To: <CAFEAcA_B=soMv78uDsDv-F5-0XQWDXfUr-i0iTUJHr0=VHmvkA@mail.gmail.com>
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
 <20240219200908.49551-7-arnaud.minier@telecom-paris.fr>
 <CAFEAcA_B=soMv78uDsDv-F5-0XQWDXfUr-i0iTUJHr0=VHmvkA@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] Add write protections to CR register
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:46.193.4.103]
X-Mailer: Zimbra 9.0.0_GA_4583 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_4583)
Thread-Topic: Add write protections to CR register
Thread-Index: ZdboMa7kkJkgiid2tTp9Nf5KMlm69A==
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=aminier-21@enst.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Thank you for the review and for the tips ! It really helps.
I will address the problems you have highlighted and will send a new versio=
n later this week.

Arnaud

----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Arnaud Minier" <arnaud.minier@telecom-paris.fr>
> Cc: "qemu-devel" <qemu-devel@nongnu.org>, "Thomas Huth" <thuth@redhat.com=
>, "Laurent Vivier" <lvivier@redhat.com>, "In=C3=A8s
> Varhol" <ines.varhol@telecom-paris.fr>, "Samuel Tardieu" <samuel.tardieu@=
telecom-paris.fr>, "qemu-arm"
> <qemu-arm@nongnu.org>, "Alistair Francis" <alistair@alistair23.me>, "Paol=
o Bonzini" <pbonzini@redhat.com>
> Sent: Friday, February 23, 2024 3:59:03 PM
> Subject: Re: [PATCH v5 6/8] Add write protections to CR register

> On Mon, 19 Feb 2024 at 20:16, Arnaud Minier
> <arnaud.minier@telecom-paris.fr> wrote:
>>
>> Add write protections for the fields in the CR register.
>> PLL configuration write protections (among others) have not
>> been handled yet. This is planned in a future patch set.
>=20
> Can you make sure you include a suitable prefix (eg
> "hw/misc/stm32l4x5_rcc: ") at the front of patch subjects, please?

Sorry. This will be done for the next version.

>=20
>>
>> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
>> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> ---
>>  hw/misc/stm32l4x5_rcc.c | 164 ++++++++++++++++++++++++++++------------
>>  1 file changed, 114 insertions(+), 50 deletions(-)
>>
>> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
>> index a3b192e61b..198c6238b6 100644
>> --- a/hw/misc/stm32l4x5_rcc.c
>> +++ b/hw/misc/stm32l4x5_rcc.c
>> @@ -346,9 +346,47 @@ static void rcc_update_irq(Stm32l4x5RccState *s)
>>      }
>>  }
>>
>> -static void rcc_update_cr_register(Stm32l4x5RccState *s)
>> +static void rcc_update_msi(Stm32l4x5RccState *s, uint32_t previous_valu=
e)
>> +{
>> +    uint32_t val;
>> +
>> +    static const uint32_t msirange[] =3D {
>> +        100000, 200000, 400000, 800000, 1000000, 2000000,
>> +        4000000, 8000000, 16000000, 24000000, 32000000, 48000000
>> +    };
>> +    /* MSIRANGE and MSIRGSEL */
>> +    val =3D extract32(s->cr, R_CR_MSIRGSEL_SHIFT, R_CR_MSIRGSEL_LENGTH)=
;
>=20
> registerfields.h provides macros for "extract a named field", so you
> can write this
>    val =3D FIELD_EX32(s->cr, CR, MSIRGSEL);

It seems really convenient ! Will use them !

>=20
>> +    if (val) {
>> +        /* MSIRGSEL is set, use the MSIRANGE field */
>> +        val =3D extract32(s->cr, R_CR_MSIRANGE_SHIFT, R_CR_MSIRANGE_LEN=
GTH);
>=20
> and these as val =3D extract32(s->cr, CR, MSIRANGE)
> and so on.
>=20
>> +    } else {
>> +        /* MSIRGSEL is not set, use the MSISRANGE field */
>> +        val =3D extract32(s->csr, R_CSR_MSISRANGE_SHIFT, R_CSR_MSISRANG=
E_LENGTH);
>> +    }
>> +
>> +    if (val < ARRAY_SIZE(msirange)) {
>> +        clock_update_hz(s->msi_rc, msirange[val]);
>> +    } else {
>> +        /*
>> +         * There is a hardware write protection if the value is out of =
bound.
>> +         * Restore the previous value.
>> +         */
>> +        s->cr =3D (s->cr & ~R_CSR_MSISRANGE_MASK) |
>> +                (previous_value & R_CSR_MSISRANGE_MASK);
>> +    }
>> +}
>> +
>=20
>> -    /* HSEON and update HSERDY */
>> +    /*
>> +     * HSEON and update HSERDY.
>> +     * HSEON cannot be reset if the HSE oscillator is used directly or
>> +     * indirectly as the system clock.
>> +     */
>>      val =3D extract32(s->cr, R_CR_HSEON_SHIFT, R_CR_HSEON_LENGTH);
>> -    s->cr =3D (s->cr & ~R_CR_HSERDY_MASK) |
>> -            (val << R_CR_HSERDY_SHIFT);
>> -    if (val) {
>> -        clock_update_hz(s->hse, s->hse_frequency);
>> -        if (s->cier & R_CIER_HSERDYIE_MASK) {
>> -            s->cifr |=3D R_CIFR_HSERDYF_MASK;
>> +    if (extract32(s->cfgr, R_CFGR_SWS_SHIFT, R_CFGR_SWS_LENGTH) !=3D 0b=
10 &&
>> +        current_pll_src !=3D RCC_CLOCK_MUX_SRC_HSE) {
>> +        s->cr =3D (s->cr & ~R_CR_HSERDY_MASK) |
>> +                (val << R_CR_HSERDY_SHIFT);
>> +        if (val) {
>> +            clock_update_hz(s->hse, s->hse_frequency);
>> +            if (s->cier & R_CIER_HSERDYIE_MASK) {
>> +                s->cifr |=3D R_CIFR_HSERDYF_MASK;
>> +            }
>> +        } else {
>> +            clock_update_hz(s->hse, 0);
>=20
> As I mentioned earlier, please avoid clock_update_hz() for
> clock calculations if possible.

This will be changed to use clock_update.

>=20
> thanks
> -- PMM

