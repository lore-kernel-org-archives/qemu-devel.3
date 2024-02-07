Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B759C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 06:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXbmr-0000PQ-FV; Wed, 07 Feb 2024 01:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXbmp-0000G4-8R
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:51:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXbmn-0006Te-9v
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 01:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707288715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HF5y9eSByAFiyVqZywtQLU54hyzU1gc1R7olA1k3F78=;
 b=d13HNeNTD4YlaZjVNSi9sXr8qQ5aPYvc2ekodlc3sPhyGVvzfwWxYdJtKK4+HekL1DZsbI
 AS0TDSWdRftctIow/aFVBQYyh/WHrbfMKzMLlYMLlEPrTyLv4oQDtMmUng27AaB2VBxUbo
 pkNn1H5SWTMjo/UZ1zlEcI4+wtu6S80=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-loRVEkj3MlqGn77NWJgoVQ-1; Wed, 07 Feb 2024 01:51:54 -0500
X-MC-Unique: loRVEkj3MlqGn77NWJgoVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF22785A58C;
 Wed,  7 Feb 2024 06:51:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63A99400D6D2;
 Wed,  7 Feb 2024 06:51:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5D54221E66D0; Wed,  7 Feb 2024 07:51:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Michael S
 . Tsirkin" <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/intc: Handle the error of IOAPICCommonClass.realize()
In-Reply-To: <ZbsPRB4OM027fbMA@intel.com> (Zhao Liu's message of "Thu, 1 Feb
 2024 11:25:56 +0800")
References: <20240131142902.115964-1-zhao1.liu@linux.intel.com>
 <cdb1c6cd-0095-4787-a740-17b42e061548@linaro.org>
 <ZbsPRB4OM027fbMA@intel.com>
Date: Wed, 07 Feb 2024 07:51:52 +0100
Message-ID: <875xz0ojg7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Zhao Liu <zhao1.liu@linux.intel.com> writes:

> Hi Philippe,
>
> On Wed, Jan 31, 2024 at 05:48:24PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Date: Wed, 31 Jan 2024 17:48:24 +0100
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Subject: Re: [PATCH] hw/intc: Handle the error of  IOAPICCommonClass.rea=
lize()
>>=20
>> Hi Zhao,
>>=20
>> On 31/1/24 15:29, Zhao Liu wrote:
>> > From: Zhao Liu <zhao1.liu@intel.com>
>> >=20
>> > IOAPICCommonClass implements its own private realize(), and this priva=
te
>> > realize() allows error.
>> >=20
>> > Therefore, return directly if IOAPICCommonClass.realize() meets error.
>> >=20
>> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> > ---
>> >   hw/intc/ioapic_common.c | 3 +++
>> >   1 file changed, 3 insertions(+)
>> >=20
>> > diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
>> > index cb9bf6214608..3772863377c2 100644
>> > --- a/hw/intc/ioapic_common.c
>> > +++ b/hw/intc/ioapic_common.c
>> > @@ -162,6 +162,9 @@ static void ioapic_common_realize(DeviceState *dev=
, Error **errp)
>> >      info =3D IOAPIC_COMMON_GET_CLASS(s);
>> >      info->realize(dev, errp);
>> > +    if (*errp) {
>> > +        return;
>> > +    }

This is wrong, although it'll work in practice.

It's wrong, because dereferencing @errp requires ERRP_GUARD().
qapi/error.h:

 * =3D Why, when and how to use ERRP_GUARD() =3D
 *
 * Without ERRP_GUARD(), use of the @errp parameter is restricted:
 * - It must not be dereferenced, because it may be null.
 * - It should not be passed to error_prepend() or
 *   error_append_hint(), because that doesn't work with &error_fatal.
 * ERRP_GUARD() lifts these restrictions.
 *
 * To use ERRP_GUARD(), add it right at the beginning of the function.
 * @errp can then be used without worrying about the argument being
 * NULL or &error_fatal.
 *
 * Using it when it's not needed is safe, but please avoid cluttering
 * the source with useless code.

It'll work anyway, because the caller never passes null.

Obvious fix:

diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
index cb9bf62146..280404cba5 100644
--- a/hw/intc/ioapic_common.c
+++ b/hw/intc/ioapic_common.c
@@ -152,6 +152,7 @@ static int ioapic_dispatch_post_load(void *opaque, int =
version_id)
=20
 static void ioapic_common_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     IOAPICCommonState *s =3D IOAPIC_COMMON(dev);
     IOAPICCommonClass *info;
=20
>> Could be clearer to deviate from DeviceRealize and let the
>> handler return a boolean:
>>=20
>> -- >8 --
>> diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
>> index 37b8565539..9664bb3e00 100644
>> --- a/hw/intc/ioapic_internal.h
>> +++ b/hw/intc/ioapic_internal.h
>> @@ -92,3 +92,3 @@ struct IOAPICCommonClass {
>>=20
>> -    DeviceRealize realize;
>> +    bool (*realize)(DeviceState *dev, Error **errp);

qapi.error.h advises:

 * - Whenever practical, also return a value that indicates success /
 *   failure.  This can make the error checking more concise, and can
 *   avoid useless error object creation and destruction.  Note that
 *   we still have many functions returning void.  We recommend
 *   =E2=80=A2 bool-valued functions return true on success / false on fail=
ure,
 *   =E2=80=A2 pointer-valued functions return non-null / null pointer, and
 *   =E2=80=A2 integer-valued functions return non-negative / negative.

The patch then becomes

          info =3D IOAPIC_COMMON_GET_CLASS(s);
     -    info->realize(dev, errp);
     +    if (!info->realize(dev, errp) {
     +        return;
     +    }

DeviceClass and BusClass callbacks realize, unrealize ignore this
advice: they return void.  Why?

Following the advice makes calls easier to read, but the callees have to
do a tiny bit of extra work: return something.  Good trade when we have
at least as many callers as callees.

But these callbacks have many more callees: many devices implement them,
but only a few places call.  Changing them to return something looked
like more trouble than it's worth, so we didn't.

> What about I change the name of this interface?
>
> Maybe ioapic_realize(), to distinguish it from DeviceClass.realize().

I wouldn't bother.

>>      DeviceUnrealize unrealize;
>
> Additionally, if I change the pattern of realize(), should I also avoid
> the DeviceUnrealize macro for symmetry's sake and just declare a similar
> function pointer as you said?
>
> Further, do you think it's necessary to introduce InternalRealize and
> InternalUnrealize macros for qdev

You mean typedefs?

>                          for qdev to wrap these special realize/unrealize
> to differentiate them from normal DeviceRealize/DeviceUnrealize?
>
> Because I found that this pattern of realize() (i.e. registering the
> realize() of the child class in the parent class instead of DeviceClass,
> and then calling the registered realize() in parent realize()) is also
> widely used in many cases:
>
> * xen_block_realize()
> * virtser_port_device_realize()
> * x86_iommu_realize()
> * virtio_input_device_realize()
> * apic_common_realize()
> * pc_dimm_realize()
> * virtio_device_realize()
> ...

Yes.

When a subtype overrides a supertype's method, it often makes sense to
have the subtype's method call the supertype's method.

> I'm not quite sure if this is a generic way to use it, although it looks
> like it could easily be confused with DeviceClass.realize().

Did I answer your question?  I'm not sure :)

>> diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
>> index 409d0c8c76..96747ef2b8 100644
>> --- a/hw/i386/kvm/ioapic.c
>> +++ b/hw/i386/kvm/ioapic.c
>> @@ -121,3 +121,3 @@ static void kvm_ioapic_set_irq(void *opaque, int irq,
>> int level)
>>=20
>> -static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
>> +static bool kvm_ioapic_realize(DeviceState *dev, Error **errp)
>>  {
>> @@ -133,2 +133,4 @@ static void kvm_ioapic_realize(DeviceState *dev, Err=
or
>> **errp)
>>      qdev_init_gpio_in(dev, kvm_ioapic_set_irq, IOAPIC_NUM_PINS);
>> +
>> +    return true;
>>  }
>> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
>> index cb9bf62146..beab65be04 100644
>> --- a/hw/intc/ioapic_common.c
>> +++ b/hw/intc/ioapic_common.c
>> @@ -163,3 +163,5 @@ static void ioapic_common_realize(DeviceState *dev,
>> Error **errp)
>>      info =3D IOAPIC_COMMON_GET_CLASS(s);
>> -    info->realize(dev, errp);
>> +    if (!info->realize(dev, errp)) {
>> +        return;
>> +    }
>>=20
>> ---
>>=20
>> What do you think?
>
> I'm OK with the change here, but not sure if the return of private
> realize() should be changed elsewhere as well.

I think I'd add the missing ERRP_GUARD() and call it a day.


