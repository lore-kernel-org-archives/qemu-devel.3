Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939F4CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6s45-0004Fz-6t; Thu, 09 Oct 2025 10:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6s42-0004Fm-Sb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6s40-0005pQ-2L
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760021771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WVf/lRk+QaH8PpFgzq0sN1AEKQ2SmFmrUZpswuqW2b4=;
 b=fFF5j5BfffqnnbegEmTPBmZkpIc3a09KiCUR11caI1PXIU+mp85hdV/1i1BlvWaSTjquzw
 gOgsIs22ER97glSeeg9zfg3baumTlzhyinOaCgt6Qt6i2Bt7DPGfhUGOwXC8HvX2vs1NZB
 VdLCun7NTIuIfRCOugsfIlNJiQB6bYg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-6y7kGA5qPZ-CASnxbtKjNg-1; Thu,
 09 Oct 2025 10:56:07 -0400
X-MC-Unique: 6y7kGA5qPZ-CASnxbtKjNg-1
X-Mimecast-MFC-AGG-ID: 6y7kGA5qPZ-CASnxbtKjNg_1760021762
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9C88180057D; Thu,  9 Oct 2025 14:56:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99AD21800576; Thu,  9 Oct 2025 14:55:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C49D321E6A27; Thu, 09 Oct 2025 16:55:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: salil.mehta@opnsrc.net,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 mst@redhat.com,  salil.mehta@huawei.com,  maz@kernel.org,
 jean-philippe@linaro.org,  jonathan.cameron@huawei.com,
 lpieralisi@kernel.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  andrew.jones@linux.dev,  david@redhat.com,
 philmd@linaro.org,  eric.auger@redhat.com,  will@kernel.org,
 ardb@kernel.org,  oliver.upton@linux.dev,  pbonzini@redhat.com,
 gshan@redhat.com,  rafael@kernel.org,  borntraeger@linux.ibm.com,
 alex.bennee@linaro.org,  gustavo.romero@linaro.org,  npiggin@gmail.com,
 harshpb@linux.ibm.com,  linux@armlinux.org.uk,
 darren@os.amperecomputing.com,  ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com,  gankulkarni@os.amperecomputing.com,
 karl.heubaum@oracle.com,  miguel.luis@oracle.com,  zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com,  wangyanan55@huawei.com,
 wangzhou1@hisilicon.com,  linuxarm@huawei.com,  jiakernel2@gmail.com,
 maobibo@loongson.cn,  lixianglai@loongson.cn,  shahuang@redhat.com,
 zhao1.liu@intel.com,  devel@lists.libvirt.org
Subject: Re: [PATCH RFC V6 22/24] monitor,qdev: Introduce 'device_set' to
 change admin state of existing devices
In-Reply-To: <20251009145125.6583a24a@fedora> (Igor Mammedov's message of
 "Thu, 9 Oct 2025 14:51:25 +0200")
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-23-salil.mehta@opnsrc.net>
 <87plawh2sz.fsf@pond.sub.org> <20251009145125.6583a24a@fedora>
Date: Thu, 09 Oct 2025 16:55:54 +0200
Message-ID: <87wm54nmyt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Igor Mammedov <imammedo@redhat.com> writes:

> On Thu, 09 Oct 2025 10:55:40 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> salil.mehta@opnsrc.net writes:
>>=20
>> > From: Salil Mehta <salil.mehta@huawei.com>
>> >
>> > This patch adds a "device_set" interface for modifying properties of d=
evices
>> > that already exist in the guest topology. Unlike 'device_add'/'device_=
del'
>> > (hot-plug), 'device_set' does not create or destroy devices. It is int=
ended
>> > for guest-visible hot-add semantics where hardware is provisioned at b=
oot but
>> > logically enabled/disabled later via administrative policy.
>> >
>> > Compared to the existing 'qom-set' command, which is less intuitive an=
d works
>> > only with object IDs, device_set provides a more device-oriented inter=
face.
>> > It can be invoked at the QEMU prompt using natural device arguments, a=
nd the
>> > new '-deviceset' CLI option allows properties to be set at boot time, =
similar
>> > to how '-device' specifies device creation.=20=20
>>=20
>> Why can't we use -device?
>
> that's was my concern/suggestion in reply to cover letter
> (as a place to put high level review and what can be done for the next re=
vision)

Yes.

> (PS: It looks like I'm having email receiving issues (i.e. not getting fr=
om
> mail list my own emails that it bonces to me, so threading is all broken =
on
> my side and I'm might miss replies). But on positive side it looks like my
> replies reach the list and CCed just fine)

For what it's worth, your replies arrive fine here.

>> > While the initial implementation focuses on "admin-state" changes (e.g=
.,
>> > enable/disable a CPU already described by ACPI/DT), the interface is d=
esigned
>> > to be generic. In future, it could be used for other per-device set/un=
set
>> > style controls =E2=80=94 beyond administrative power-states =E2=80=94 =
provided the target
>> > device explicitly allows such changes. This enables fine-grained runti=
me
>> > control of device properties.=20=20
>>=20
>> Beware, designing a generic interface can be harder, sometimes much
>> harder, than designing a specialized one.
>>=20
>> device_add and qom-set are generic, and they have issues:
>>=20
>> * device_add effectively bypasses QAPI by using 'gen': false.
>>=20
>>   This bypasses QAPI's enforcement of documentation.  Property
>>   documentation is separate and poor.
>>=20
>>   It also defeats introspection with query-qmp-schema.  You need to
>>   resort to other means instead, say QOM introspection (which is a bag
>>   of design flaws on its own), then map from QOM to qdev.
>>=20
>> * device_add lets you specify any qdev property, even properties that
>>   are intended only for use by C code.
>>=20
>>   This results in accidental external interfaces.
>>=20
>>   We tend to name properties like "x-prop" to discourage external use,
>>   but I wouldn't bet my own money on us getting that always right.
>>   Moreover, there's beauties like "x-origin".
>>=20
>> * qom-set & friends effectively bypass QAPI by using type 'any'.
>>=20
>>   Again, the bypass results in poor documentation and a defeat of
>>   query-qmp-schema.
>>=20
>> * qom-set lets you mess with any QOM property with a setter callback.
>>=20
>>   Again, accidental external interfaces: most of these properties are
>>   not meant for use with qom-set.  For some, qom-set works, for some it
>>   silently does nothing, and for some it crashes.  A lot more dangerous
>>   than device_add.
>>=20
>>   The "x-" convention can't help here: some properties are intended for
>>   external use with object-add, but not with qom-set.
>>=20
>> We should avoid such issues in new interfaces.

[...]

>> > diff --git a/hmp-commands.hx b/hmp-commands.hx
>> > index d0e4f35a30..18056cf21d 100644
>> > --- a/hmp-commands.hx
>> > +++ b/hmp-commands.hx
>> > @@ -707,6 +707,36 @@ SRST
>> >    or a QOM object path.
>> >  ERST
>> >=20=20
>> > +{
>> > +    .name       =3D "device_set",
>> > +    .args_type  =3D "device:O",
>> > +    .params     =3D "driver[,prop=3Dvalue][,...]",
>> > +    .help       =3D "set/unset existing device property",
>> > +    .cmd        =3D hmp_device_set,
>> > +    .command_completion =3D device_set_completion,
>> > +},
>> > +
>> > +SRST
>> > +``device_set`` *driver[,prop=3Dvalue][,...]*
>> > +  Change the administrative power state of an existing device.
>> > +
>> > +  This command enables or disables a known device (e.g., CPU) using t=
he
>> > +  "device_set" interface. It does not hotplug or add a new device.
>> > +
>> > +  Depending on platform support (e.g., PSCI or ACPI), this may trigger
>> > +  corresponding operational changes =E2=80=94 such as powering down a=
 CPU or
>> > +  transitioning it to active use.
>> > +
>> > +  Administrative state:
>> > +    * *enabled*  =E2=80=94 Allows the guest to use the device (e.g., =
CPU_ON)
>> > +    * *disabled* =E2=80=94 Prevents guest use; device is powered off =
(e.g., CPU_OFF)
>> > +
>> > +  Note: The device must already exist (be declared during machine cre=
ation).
>> > +
>> > +  Example:
>> > +      (qemu) device_set host-arm-cpu,core-id=3D3,admin-state=3Ddisabl=
ed
>> > +ERST=20=20
>>=20
>> How exactly is the device selected?  You provide a clue above: 'can be
>> located by "id" or via driver+property match'.
>>=20
>> I assume by "id" is just like device_del, i.e. by qdev ID or QOM path.
>>=20
>> By "driver+property match" is not obvious.  Which of the arguments are
>> for matching, and which are for setting?
>>=20
>> If "id" is specified, is there any matching?
>>=20
>> The matching feature complicates this interface quite a bit.  I doubt
>> it's worth the complexity.  If you think it is, please split it off into
>> a separate patch.
>
> It's likely /me who to blame for asking to invent generic
> device-set QMP command.
> I see another application (beside ARM CPU power-on/off) for it,
> PCI devices to simulate powering on/off them at runtime without
> actually removing device.

I prefer generic commands over collecting ad hoc single-purpose
commands, too.  Getting the design right can be difficult.

> wrt command,
> I'd use only 'id' with it to identify target device
> (i.e. no template matching nor QMP path either).
> To enforce rule, what user hasn't named explicitly by providing 'id'
> isn't meant to be accessed/manged by user later on.=20

Works well, except when we need to access / manage onboard devices.
That's still an unsolved problem.

> potentially we can invent specialized power_set/get command as
> an alternative if it makes design easier.
> But then we would be spawning similar commands for other things,
> where as device-set would cover it all. But then I might be
> over-complicating things by suggesting a generic approach.=20

Unclear.

I feel it's best to start the design process with ensvisaged uses.  Can
you tell me a bit more about the uses you have in mind?

>> Next question.  Is there a way for management applications to detect
>> whether a certain device supports device_set for a certain property?
>
> is there some kind of QMP command to check what does a device support,
> or at least what properties it supports? Can we piggy-back on that?

Maybe.

QAPI schema introspection (query-qmp-schema) has been a success.  It has
a reasonably expressive type system, deprecation information, and hides
much implementation detail.  Sadly, it doesn't cover most of QOM and all
of qdev due to QAPI schema bypass.

QOM type introspection (qom-list-types and qom-list-properties) is weak.
You can retrieve a property's name and type.  The latter is seriously
underspecified, and somewhere between annoying and impossible to use
reliably.  Properties created in certain ways are not visible here.
These are rare.

QOM object introspection (qom-list) is the same for concrete objects
rather than types.

qdev introspection (device-list-properties) is like QOM type
introspection.  I'm not sure why it exists.  Use QOM type introspection
instead.

QOM introspection is servicable for checking whether a certain property
exists.  Examining a property's type is unadvisable.

>> Without that, what are management application supposed to do?  Hard-code
>> what works?  Run the command and see whether it fails?
>
> Adding libvirt list to discussion and possible ideas on what can be done =
here.
>
>> I understand right now the command supports just "admin-state" for a
>> certain set of devices, so hard-coding would be possible.  But every new
>> (device, property) pair then requires management application updates,
>> and the hard-coded information becomes version specific.  This will
>> become unworkable real quick.  Not good enough for a command designed to
>> be generic.

[...]


