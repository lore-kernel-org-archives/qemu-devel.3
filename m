Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0097DFD9E19
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjSk-0003Ia-47; Thu, 26 Feb 2026 17:04:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vvjRx-0002ZP-U7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:24 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vvjRu-0001uc-3F
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:11 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4398f8e2837so1145152f8f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772143387; x=1772748187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJqefZarmSpkloNs/DyvVPHufqYwdRWZLXNt17FEpiI=;
 b=L4dV2MKux57nl8Ez6Z5RzxdkzVV6aLVmtfYlvf6+jW7Yo+B+x2lXXPywC1+5kDxRTS
 46ttlvG8lshYSC6hUluww8Qv4CivgRTlHp/DYECC8PtFTqY+Mkzat7K4BHvIOeghZwrF
 rZ83eG0UmQusYO8n0jJQfJf+isjEDFqCl3I5r+JhdqCw2Q2wg04iBGoNByIijv0WgB4Y
 byVyxli/OOEwJ7JOUpWsB8YvTLgRRBYeRRxl/9ONDwF4gBHUJfk64S9wJr9odE5hSfPn
 7w/jmdogBeYqd29B2mUoINys0POBK1r1e3HFQW95KTtQvpaJvCZ8MlA/dYyuGUc3UUts
 +h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143387; x=1772748187;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UJqefZarmSpkloNs/DyvVPHufqYwdRWZLXNt17FEpiI=;
 b=G7jRVoy+iWiYfiBBUHYxDDpP4UjW0N249/R+o9Nmv4ur3tIM9qCAc0RDWZiF+CXgHV
 4bqKnca2VdYYg3NSY0PyR8n43grOyYRhxJjxj6JY2aY0l31vy/NFrKJhfmg+ks5BUmoT
 MA2cuYQ8zOHsIPWEduMjZ+JI68G6YBXBFMHKHvrNaugeaGcDRG4tr9tCLDKf7Kj/oo3W
 e7LjCxgnmX5Ww0OgE4wUqvJ/fKGlPkHmVw1p5MsW0jfou+MDSMUuiJ1I8zA1trCsDfbU
 1dNo4ScWV4SwLdXnSV9pspxk/aK9o1CQfvR6yK3KIs/VZpgfOhJ7+5vyZ8pdti6quNYh
 vyPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqvWmyE+r6sWpTuPR+PWtUonhH9+fSQfPzLXGyElVovf0b806AsGZUix8B1C9A/1pkZOrG3A4OY5GC@nongnu.org
X-Gm-Message-State: AOJu0Yyjt5ZS2xbpK2OFovUtu7tfcxMnafeFdccngtYM1G7M6X4mqDtw
 iVjG7AsH/QOq50aKWQRQC97KmH7u2GNlyXMkQi104T8ad+173/+9dqIj
X-Gm-Gg: ATEYQzyeFGhFFyBnwcOep5ajxI2FBuzeKK5qpMrVk445ApIPJlTLA7ehzjCEjah/D5/
 t3Al7i32gySx0MiYo73vzU3LYn49DlniPvzyfxuMoH1tss3BCpOtkZYEOCYcRrAcWn++5nKofyq
 IRWTvI2dNhb1v+ldmPQ++F/RRZ6GhCBzHv9JySlKYAbCX6V8QUA7CPhJqREVZbN9oH9q7x/uqd6
 nWHu77NN+vlyLzPXdVRwQMyPteaOra1DAVeNCVElj6TJEawB0O2YaEvhRe1oXAGvj0oNIDVQYhS
 pSbcsqiIh205w0IaxjsRMQOJJCkaUjZ6dGgz69JD+FAozDAGhAN938I4UIZDS+eHdEpzFuOWjig
 10kRAMgZPQ1gdzX/AtclXsWEk2ro3bkVFYJLBrmo/Dw4Ed3naBB5XJTCpFk3NaJ2hnY+8ZHlggr
 l6HoeIzzjNdPwhZRsZyAm3psHbqLdV4Oyi+C/K5dlGmuQ3b6a3W6qbHV+cm8uIEX2mllbT5C7ym
 plugNKqgaHHzqB3jE+TlFhRX6DBBdFsoe5ub4P4cWlF0Dg=
X-Received: by 2002:a05:6000:144d:b0:435:bcbe:d104 with SMTP id
 ffacd0b85a97d-4399de1f29fmr703889f8f.34.1772143386556; 
 Thu, 26 Feb 2026 14:03:06 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-2de3-af00-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:2de3:af00:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c764546sm2419923f8f.29.2026.02.26.14.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:03:05 -0800 (PST)
Date: Thu, 26 Feb 2026 22:03:05 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_hw/core=3A_Avoid_attaching_qde?=
 =?US-ASCII?Q?vs_to_/machine/unattached_if_they_have_a_bus?=
In-Reply-To: <0fef1895-b8dd-4091-a4af-6bcb5a974e32@linaro.org>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
 <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
 <0fef1895-b8dd-4091-a4af-6bcb5a974e32@linaro.org>
Message-ID: <DCBCB187-152E-4122-BA69-2CB25984B168@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
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



Am 25=2E Februar 2026 05:55:21 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>+Bernhard
>
>On 24/2/26 13:22, Mark Cave-Ayland wrote:
>> On 24/02/2026 11:10, Peter Maydell wrote:
>>=20
>>> On Tue, 24 Feb 2026 at 09:48, Daniel P=2E Berrang=C3=A9 <berrange@redh=
at=2Ecom> wrote:
>>>> IMHO, it is slightly more subtle - people believe they are already
>>>> adding children=2E
>>>>=20
>>>> Consider this code=2E
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 port92 =3D isa_create_simple(isa_bus, TYPE_P=
ORT92);
>>>>=20
>>>> my reading of that is that I'm creating a "port92" device that is a
>>>> child of "isa_bus"=2E Why would I need to tell QEMU that it is a chil=
d
>>>> for a second time ?
>>>>=20
>>>> If I trace calls through isa_create_simple I get to a call to:
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0 qdev_realize_and_unref(dev, parent, errp);
>>>>=20
>>>> and once I again I'm left wondering why I would need to tell
>>>> QEMU 'dev' is a child of 'parent' a second time=2E
>>>>=20
>>>> Of course I know the answer=2E We need to give a name for the
>>>> child and it isn't trivial to "do the right thing" to invent
>>>> an automatic name=2E
>>>>=20
>>>> Still, overall I'm inclined to largely blame our API designs for
>>>> not guiding people into doing the right thing=2E
>>>>=20
>>>>=20
>>>> Picking another random unattached set of objects "smbus-eeprom"
>>>> I again find they've being created with qdev_realize_and_unref=2E
>>>>=20
>>>> Pick another unattached device 'i8259_init_chip', and again
>>>> we end up calling into qdev_realize_and_unref()
>>>>=20
>>>>=20
>>>> It feels like qdev_realize_and_unref() is a common point of
>>>> blame in unattached devices=2E IMHO it ought to be taking a
>>>> "const char *name" parameter=2E
>>>=20
>>> I think that is because this is the function that is used
>>> in older code that predates the "everything should be in
>>> the QOM tree" model=2E Newer code doesn't use it, I think;
>>> and it's not surprising that old pre-QOM code doesn't do
>>> anything to put objects into the QOM tree=2E
>>>=20
>>> The two patterns are:
>>>=20
>>> =C2=A0 dev =3D qdev_new(=2E=2E=2E);
>>> =C2=A0 =2E=2E=2E
>>> =C2=A0 qdev_realize_and_unref(dev, bus, errp);
>>>=20
>>> and
>>>=20
>>> =C2=A0 object_initialize_child(=2E=2E=2E);
>>> =C2=A0 =2E=2E=2E
>>> =C2=A0 qdev_realize(dev, bus, errp);
>>>=20
>>> This also is somewhat tangled up with the question of whether you want=
:
>>>=20
>>> =C2=A0 * call a function which allocates memory and initializes it
>>> =C2=A0=C2=A0=C2=A0 with an object of this type
>>> =C2=A0 * I have the memory here, init the object in-place
>>>=20
>>> If we could come to a definite conclusion on what we want then
>>> we would probably be in a better position to try to enforce it=2E
>
>I recall a previous discussion where we said in-place allocation
>does not scale with dynamic machines (data driven config), and IIRC
>Bernhard said by switching to dynamic heap allocation we'd use more
>QOM cast macros and lose compiler safety type checks=2E Can't find it
>now in the archives=2E

It was probably this comment about type safety which was unrelated to heap=
 allocations: https://lore=2Ekernel=2Eorg/qemu-devel/49C85A05-2BE5-4D9B-A08=
A-B93039669BD8@gmail=2Ecom/

Best regards,
Bernhard

>
>We have some model declension where we allocate in-place $MAX members
>and expose a QOM property to initialize up to that number (or worst,
>de-initialize and unparent what is left!) in the DeviceRealize handler=2E
>Not "in-place" could simplify this=2E
>
>> Exactly this! I think what tends to happen is that we get stuck in situ=
ations where someone suggests an improvement, but then we get hung up tryin=
g to work out the corner-cases where it doesn't work and then things don't =
progress=2E
>>=20
>> The approach I believe we need to take is to work out what we want the =
API and QOM tree to look like first, and then work backwards from there=2E
>>=20
>> I tend to be in agreement with Akihiko's argument that we want to depre=
cate in-place initialisation with object_initialize_child() and simply use =
refcounting everywhere because then we don't hit any lifcycle issues if som=
ething retains a reference to the internal object (memory regions!)=2E
>>=20
>> The questions I think we need to answer as a starting point:
>>=20
>>  =C2=A0 1=2E Which API shall we converge on: qdev or QOM? Can we come u=
p with a
>>  =C2=A0=C2=A0=C2=A0=C2=A0 code sample(s) showing what we want object/de=
vice initialisation to
>>  =C2=A0=C2=A0=C2=A0=C2=A0 look lie? Longer term can we unify the QOM an=
d qdev trees?
>>=20
>>  =C2=A0 2=2E Should we convert to use external object allocation with
>>  =C2=A0=C2=A0=C2=A0=C2=A0 refcounting?
>>=20
>>  =C2=A0 3=2E How do we handle memory regions? With Akihiko's recent ref=
count
>>  =C2=A0=C2=A0=C2=A0=C2=A0 fixes then Zoltan's memory region changes cou=
ld work: I don't agree
>>  =C2=A0=C2=A0=C2=A0=C2=A0 with the motivation of simplifying devices as=
 I think it's i)
>>  =C2=A0=C2=A0=C2=A0=C2=A0 subjective and ii) harder to debug if we lose=
 the pointer to the
>>  =C2=A0=C2=A0=C2=A0=C2=A0 memory region, but I can see how it fixes the=
 RCU-thread doing an
>>  =C2=A0=C2=A0=C2=A0=C2=A0 unref after the owner device has already been=
 destroyed issue=2E
>>=20
>> As several people have already pointed out in this thread, we do have a=
 poor track record of API conversions but the introduction of memory region=
s shows how this can be done successfully=2E
>>=20
>> Given that we already have multiple ways of doing the same thing, I ten=
d to lean against not introducing yet-another-API unless we can come up wit=
h a long-term strategy for its use=2E In particular this causes problems in=
 review where e=2Eg=2E one reviewer may want to use QOM to setup a device w=
hilst another may want to use qdev which is confusing for everyone, includi=
ng the code submitter=2E
>>=20
>> If we can at least get an answer to 1) then I'd be willing to have a go=
 at writing some kind of specification document and put it out for feedback=
=2E=2E=2E
>>=20
>>=20
>> ATB,
>>=20
>> Mark=2E
>>=20
>>=20
>

