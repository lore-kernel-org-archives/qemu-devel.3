Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E525C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 20:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehkp-0008DH-JN; Mon, 26 Feb 2024 15:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aminier-21@enst.fr>)
 id 1rehkj-0008AK-Dr; Mon, 26 Feb 2024 15:39:09 -0500
Received: from zproxy4.enst.fr ([137.194.2.223])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aminier-21@enst.fr>)
 id 1rehkZ-00035d-Bt; Mon, 26 Feb 2024 15:39:09 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 8115D20589;
 Mon, 26 Feb 2024 21:38:56 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 9WBpJiU_brWR; Mon, 26 Feb 2024 21:38:55 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 96C4C205A2;
 Mon, 26 Feb 2024 21:38:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 96C4C205A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1708979935;
 bh=HCeYBth8krepZlcIcrM/gCF1oQ3Ck2v+dYRDqiEDAN8=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=rHi9sv2cmlQad81cWaN5oKWWscLLhGgQ32sSPs7ZKrB9UXynhpfuREZ/pbE0O2orJ
 wF3O89CB8+BnAH/eo0cw+GTJIocp/Q8IiPM0iWB8B51RKeQYnC46m6xL/PXHizApXl
 dgpUHHiR3HG2eNLlGw4sRbyFY+bShCbQfxm99+LU=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id pCBU97WH5uFq; Mon, 26 Feb 2024 21:38:55 +0100 (CET)
Received: from zmail-tp1.enst.fr (zmail-tp1.enst.fr [137.194.2.198])
 by zproxy4.enst.fr (Postfix) with ESMTP id CFDD8205A5;
 Mon, 26 Feb 2024 21:38:54 +0100 (CET)
Date: Mon, 26 Feb 2024 21:38:54 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, 
 qemu-arm <qemu-arm@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Message-ID: <1729495377.11787593.1708979934438.JavaMail.zimbra@enst.fr>
In-Reply-To: <CAFEAcA_EVoayec6Qec4EoU6atXhG7fdqb+QtFEvSQge88xJNPg@mail.gmail.com>
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
 <20240219200908.49551-3-arnaud.minier@telecom-paris.fr>
 <CAFEAcA_EVoayec6Qec4EoU6atXhG7fdqb+QtFEvSQge88xJNPg@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] Add an internal clock multiplexer object
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [::ffff:46.193.4.103]
X-Mailer: Zimbra 9.0.0_GA_4583 (ZimbraWebClient - FF122 (Linux)/9.0.0_GA_4583)
Thread-Topic: Add an internal clock multiplexer object
Thread-Index: NrImc00nNVHxguUng59clwHQlfCEKQ==
Received-SPF: pass client-ip=137.194.2.223; envelope-from=aminier-21@enst.fr;
 helo=zproxy4.enst.fr
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

----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: "Arnaud Minier" <arnaud.minier@telecom-paris.fr>
> Cc: "qemu-devel" <qemu-devel@nongnu.org>, "Thomas Huth" <thuth@redhat.com=
>, "Laurent Vivier" <lvivier@redhat.com>, "In=C3=A8s
> Varhol" <ines.varhol@telecom-paris.fr>, "Samuel Tardieu" <samuel.tardieu@=
telecom-paris.fr>, "qemu-arm"
> <qemu-arm@nongnu.org>, "Alistair Francis" <alistair@alistair23.me>, "Paol=
o Bonzini" <pbonzini@redhat.com>, "Alistair
> Francis" <alistair.francis@wdc.com>
> Sent: Friday, February 23, 2024 3:44:59 PM
> Subject: Re: [PATCH v5 2/8] Add an internal clock multiplexer object

> On Mon, 19 Feb 2024 at 20:12, Arnaud Minier
> <arnaud.minier@telecom-paris.fr> wrote:
>>
>> This object is used to represent every multiplexer in the clock tree as
>> well as every clock output, every presecaler, frequency multiplier, etc.
>> This allows to use a generic approach for every component of the clock t=
ree
>> (except the PLLs).
>>
>> Wasn't sure about how to handle the reset and the migration so used the
>> same appproach as the BCM2835 CPRMAN.
>=20
> I think hw/misc/zynq_sclr.c is also probably a good model to look at.
>=20
> AIUI the way it works is:
> * input Clock objects must be migrated
> * output Clock objects do not need to be migrated
> * your reset needs to be a three-phase one:
>   - in the 'enter' method you reset register values (including
>     all the values that define oscillator frequencies, enable bits, etc)
>   - in the 'hold' method you compute the values for the output clocks
>     as if the input clock is disabled, and propagate them
>   - in the 'exit' method you compute the values for the output clocks
>     according to the value of the input clock, and propagate them
>=20

Thanks for the indication.
I have changed the way we handle the reset to have a three phase one.

>=20
>=20
>> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
>> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>> Acked-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>  hw/misc/stm32l4x5_rcc.c                   | 158 ++++++++++++++++++++++
>>  hw/misc/trace-events                      |   5 +
>>  include/hw/misc/stm32l4x5_rcc.h           | 119 ++++++++++++++++
>>  include/hw/misc/stm32l4x5_rcc_internals.h |  29 ++++
>>  4 files changed, 311 insertions(+)
>>
>> diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
>> index 38ca8aad7d..ed10832f88 100644
>> --- a/hw/misc/stm32l4x5_rcc.c
>> +++ b/hw/misc/stm32l4x5_rcc.c
>> @@ -36,6 +36,132 @@
>>  #define LSE_FRQ 32768ULL
>>  #define LSI_FRQ 32000ULL
>>
>> +static void clock_mux_update(RccClockMuxState *mux)
>> +{
>> +    uint64_t src_freq, old_freq, freq;
>> +
>> +    src_freq =3D clock_get_hz(mux->srcs[mux->src]);
>> +    old_freq =3D clock_get_hz(mux->out);
>=20
> You should try to avoid using clock_get_hz() and clock_update_hz()
> when doing clock calculations like this. There is inherently
> rounding involved if the clock isn't running at an exact number of Hz.
> It's best to use clock_get() and clock_set(), which work with
> the clock period specified in units of 2^-32ns.
>=20
>=20
>> +
>> +    if (!mux->enabled || !mux->divider) {
>> +        freq =3D 0;
>> +    } else {
>> +        freq =3D muldiv64(src_freq, mux->multiplier, mux->divider);
>=20
> Consider whether you can use the Clock's builtin period
> multiplier/divider (clock_set_mul_div()).

I have changed it to use the period and the builtin clock_set_mul_div() but=
 I had to discard
the check below that prevents a lot of spam in the logs due to no longer
having access to the children frequency without using muldiv64 again.
Any idea on how to keep a similar functionnality .

>=20
>> +    }
>> +
>> +    /* No change, early return to avoid log spam and useless propagatio=
n */
>> +    if (old_freq =3D=3D freq) {
>> +        return;
>> +    }
>> +
>> +    clock_update_hz(mux->out, freq);
>> +    trace_stm32l4x5_rcc_mux_update(mux->id, mux->src, src_freq, freq);
>> +}
>> +
>> +static void clock_mux_src_update(void *opaque, ClockEvent event)
>> +{
>> +    RccClockMuxState **backref =3D opaque;
>> +    RccClockMuxState *s =3D *backref;
>> +    /*
>> +     * The backref value is equal to:
>> +     * s->backref + (sizeof(RccClockMuxState *) * update_src).
>> +     * By subtracting we can get back the index of the updated clock.
>> +     */
>> +    const uint32_t update_src =3D backref - s->backref;
>> +    /* Only update if the clock that was updated is the current source*=
/
>> +    if (update_src =3D=3D s->src) {
>> +        clock_mux_update(s);
>> +    }
>> +}
>> +
>> +static void clock_mux_init(Object *obj)
>> +{
>> +    RccClockMuxState *s =3D RCC_CLOCK_MUX(obj);
>> +    size_t i;
>> +
>> +    for (i =3D 0; i < RCC_NUM_CLOCK_MUX_SRC; i++) {
>> +        char *name =3D g_strdup_printf("srcs[%zu]", i);
>> +        s->backref[i] =3D s;
>> +        s->srcs[i] =3D qdev_init_clock_in(DEVICE(s), name,
>> +                                        clock_mux_src_update,
>> +                                        &s->backref[i],
>> +                                        ClockUpdate);
>> +        g_free(name);
>> +    }
>> +
>> +    s->out =3D qdev_init_clock_out(DEVICE(s), "out");
>> +}
>> +
>> +static void clock_mux_reset_hold(Object *obj)
>> +{ }
>> +
>> +static const VMStateDescription clock_mux_vmstate =3D {
>> +    .name =3D TYPE_RCC_CLOCK_MUX,
>> +    .version_id =3D 1,
>> +    .minimum_version_id =3D 1,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_UINT32(id, RccClockMuxState),
>> +        VMSTATE_ARRAY_CLOCK(srcs, RccClockMuxState,
>> +                            RCC_NUM_CLOCK_MUX_SRC),
>> +        VMSTATE_CLOCK(out, RccClockMuxState),
>=20
> Output clocks don't need VMSTATE_CLOCK lines. (We trust
> the device on the other end to migrate its state as needed.)

Done. This line was removed.

>=20
>> +        VMSTATE_BOOL(enabled, RccClockMuxState),
>> +        VMSTATE_UINT32(src, RccClockMuxState),
>> +        VMSTATE_UINT32(multiplier, RccClockMuxState),
>> +        VMSTATE_UINT32(divider, RccClockMuxState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>=20
>=20
>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>> index 62a7599353..d5e471811c 100644
>> --- a/hw/misc/trace-events
>> +++ b/hw/misc/trace-events
>> @@ -177,6 +177,11 @@ stm32l4x5_exti_write(uint64_t addr, uint64_t data) =
"reg
>> write: addr: 0x%" PRIx64
>>  # stm32l4x5_rcc.c
>>  stm32l4x5_rcc_read(uint64_t addr, uint32_t data) "RCC: Read <0x%" PRIx6=
4 "> ->
>>  0x%" PRIx32 ""
>>  stm32l4x5_rcc_write(uint64_t addr, uint32_t data) "RCC: Write <0x%" PRI=
x64 "> <-
>>  0x%" PRIx32 ""
>> +stm32l4x5_rcc_mux_enable(uint32_t mux_id) "RCC: Mux %d enabled"
>> +stm32l4x5_rcc_mux_disable(uint32_t mux_id) "RCC: Mux %d disabled"
>> +stm32l4x5_rcc_mux_set_factor(uint32_t mux_id, uint32_t old_multiplier, =
uint32_t
>> new_multiplier, uint32_t old_divider, uint32_t new_divider) "RCC: Mux %d=
 factor
>> changed: multiplier (%u -> %u), divider (%u -> %u)"
>> +stm32l4x5_rcc_mux_set_src(uint32_t mux_id, uint32_t old_src, uint32_t n=
ew_src)
>> "RCC: Mux %d source changed: from %u to %u"
>> +stm32l4x5_rcc_mux_update(uint32_t mux_id, uint32_t src, uint64_t src_fr=
eq,
>> uint64_t new_freq) "RCC: Mux %d src %d update: src_freq %" PRIu64 " new_=
freq %"
>> PRIu64 ""
>=20
> You don't need the trailing "" in this kind of string
> concatenation with a PRIu64 or similar: adding the empty
> string on the end of a string has no effect.

The useless trailing "" have been removed for every commit of this patch se=
t.

>=20
> thanks
> -- PMM

Thanks for the review !

