Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B009CD72343
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 07:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjBwl-00036K-JE; Fri, 23 Jan 2026 02:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjBwj-000340-HS
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vjBwd-00028X-CO
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 02:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769154653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNGHm0YuMws4XDLbRGVPtnot/rTPIwPQGLtcORIZjgE=;
 b=PPrK3VXv5ROHUJif2LVcteFfM1C+xLI3+PMyiSDlIoZisrv1USgOHoeq07p93bYwm1Wr2K
 NhOeCwIQFTvdRtzG2Nq7/zheokUWuxr2rTgz7IhVmw+xS4N1he6sVx0mKGeOu3l2YsLWFe
 XpmI5ntCXAb88tDCDAPoh5+IhiZJMgA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-OaGJ907FOAqAkJ-T9JL82g-1; Fri,
 23 Jan 2026 02:50:50 -0500
X-MC-Unique: OaGJ907FOAqAkJ-T9JL82g-1
X-Mimecast-MFC-AGG-ID: OaGJ907FOAqAkJ-T9JL82g_1769154648
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 685BC1800473; Fri, 23 Jan 2026 07:50:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D801A1954199; Fri, 23 Jan 2026 07:50:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 317F621E692D; Fri, 23 Jan 2026 08:50:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kane Chen
 <kane_chen@aspeedtech.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,  "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  <troy_lee@aspeedtech.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to
 customize bus naming
In-Reply-To: <cf5124a1-e4ed-444c-8221-29f625c281cd@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Thu, 22 Jan 2026 19:58:58 +0100")
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
 <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org>
 <877btdn0gv.fsf@pond.sub.org>
 <ba5b61db-64ad-495d-90f4-03e5553bf38e@kaod.org>
 <875x8win97.fsf@pond.sub.org>
 <62cc752e-fd06-48c9-9aa8-badbea8562dd@kaod.org>
 <87ms25er5x.fsf@pond.sub.org>
 <cf5124a1-e4ed-444c-8221-29f625c281cd@kaod.org>
Date: Fri, 23 Jan 2026 08:50:43 +0100
Message-ID: <87h5scday4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 1/22/26 14:02, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> On 1/20/26 11:36, Markus Armbruster wrote:
>>>> Cc: QOM/qdev maintainers
>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>
>>>>> Hello,
>>>>>
>>>>> On 1/19/26 15:25, Markus Armbruster wrote:
>>>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>>>
>>>>>>> On 1/15/26 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>> Hi,
>>>>>>>> Cc'ing Markus.
>>>>>>>> On 12/1/26 09:30, Kane Chen via qemu development wrote:
>>>>>>>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>>>>>>>
>>>>>>>>> Currently, the Aspeed I2C controller uses a static naming convent=
ion
>>>>>>>>> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
>>>>>>>>> object name conflicts in machine models that incorporate multiple=
 I2C
>>>>>>>>> controllers, such as an Aspeed SoC paired with an external IO exp=
ander
>>>>>>>>> or a co-processor like the AST1700.
>>>>>>>>>
>>>>>>>> Is this a side-effect of Problem 4: 'The /machine/unattached/ orph=
anage'
>>>>>>>> described here?
>>>>>>>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/
>>>>
>>>> No, but ...
>>>>
>>>>>>>> This problem isn't specific to I2C nor Aspeed.
>>>>
>>>> ... yes, indeed.  Details below.
>>>>
>>>>>>> See the discussion here :
>>>>>>>
>>>>>>>      https://lore.kernel.org/qemu-devel/006fa26f-6b84-4e82-b6e1-7d1=
353579441@kaod.org/
>>>>>>>
>>>>>>> The Aspeed SoC has 3*16 I2C buses attached on 3 different I2C
>>>>>>> controllers plus the I2C/I3C buses. We need to find a way to
>>>>>>> distinguish these groups at the QEMU machine level to be able
>>>>>>> to add devices on the right bus when using the command line.
>>>>>>>
>>>>>>> Suggestions welcome !
>>>>>>
>>>>>> Please show me how to start a QEMU with the 48 I2C mentioned above,
>>>>>> complete with output of "info qtree".
>>>>>
>>>>> Clone
>>>>>
>>>>>     https://github.com/legoater/qemu/commits/aspeed-11.0
>>>>>
>>>>> Download
>>>>>
>>>>>     https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.0=
8/ast2700-default-obmc.tar.gz
>>>>>
>>>>> And run :
>>>>>
>>>>>     qemu-system-aarch64 -M ast2700a1-evb -m 8G -smp 4 -net nic,macadd=
r=3D,netdev=3Dnet0 -netdev user,id=3Dnet0,hostfwd=3D::2207-:22 -drive file=
=3Dpath/to/ast2700-default/image-bmc,format=3Draw,if=3Dmtd -nographic -seri=
al mon:stdio -snapshot
>>>>>
>>>>> Today, to attach an I2C device on one of the Aspeed SoC I2C buses :
>>>>>
>>>>>     -device tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,id=3Dtmp-test
>>>>>
>>>>> The Aspeed SoC I2C bus names follow the "aspeed.i2c.bus.X" format.
>>>>> This is the model typename. The 2 new IO expander models attached
>>>>> to the Aspeed SoC have an extra 16 I2C buses each. These buses use
>>>>> an "ioexpX.Y" name, as proposed in the aspeed-next branch.
>>>>>
>>>>> Attaching a device to one of the IO expanders I2C buses would be :
>>>>>
>>>>>     -device tmp105,bus=3Dioexp0.1,address=3D0x4d,id=3Dtmp-test
>>>>>
>>>>> See the qtree below.
>>>>
>>>> Thank you!
>>>
>>> Thank you for taking the time of analyzing the code and history.
>>>
>>>> Machine ast2700a1-evb has QOM objects
>>>>
>>>>      /machine/soc/i2c/ (aspeed.i2c-ast2700)
>>>>        /bus[N] (aspeed.i2c.bus)    for N in 0..15
>>>>          /aspeed.i2c.bus.N (i2c-bus)
>>>>
>>>> in both master and aspeed-11.0.
>>>
>>> Yes, that doesn't change because I would prefer not to break the current
>>> user interface. The "i2c.X" bus name would have been a better choice.
>>> I didn't anticipated that 10y ago when I proposed this model.
>>=20
>> We make mistakes, we learn :)
>>=20
>>>> Object aspeed.i2c-ast2700 is a sysbus device that contains 16
>>>> aspeed.i2c.bus objects as children bus[N] for N in 0..15.  Each object
>>>> has a property "bus-id" with value N.
>>>>
>>>> Object aspeed.i2c.bus is a sysbus device that contains an i2c-bus obje=
ct
>>>> as child aspeed.i2c.bus.N.
>>>>
>>>> Aside: why parent TYPE_SYS_BUS_DEVICE, and not TYPE_DEVICE?  It doesn't
>>>> actually plug into a sysbus...
>>>
>>> The AspeedI2CBus model has a couple of MRs and an IRQ. I guess that's w=
hy.
>>=20
>> Sysbus was a questionable idea from the start.
>>=20
>> Qdev was built around the design assumption "each device plugs into a
>> bus provided by a device".  This isn't not how real hardware works, but
>> simplifications can be useful.  However, this one broke down right away:
>> most onboard devices and many other devices don't plug into a
>> recognizable bus.  To make the assumption work, Paul Brook invented the
>> catch all "system bus".  Various infrastructure was then tied to the
>> system bus over time, because it needed to be tied to something, system
>> bus is something, therefore it needed to be tied to the system bus.
>>=20
>> The design assumption is long gone.  We still create system bus devices
>> just to be able to use infrastructure.  Blerch.
>>=20
>> End of digression.
>>=20
>>>> Object i2c-bus is a qbus.
>>>>
>>>> In master, object aspeed.i2c.bus computes the child name by appending =
.N
>>>> to its own type name TYPE_ASPEED_I2C_BUS.
>>>>
>>>> In aspeed-11.0, it takes it from its property "bus-name".  The property
>>>> is set by its QOM parent aspeed.i2c-ast2700, and computed by appending
>>>> .N to the value of its property "bus-label".  It defaults the property
>>>> to TYPE_ASPEED_I2C_BUS.
>>>>
>>>> Since nothing sets this property in this case, we get the same child
>>>> name.
>>>>
>>>> aspeed-11.0 additionally has QOM objects
>>>>
>>>>      /machine/soc/ioexp[M] (aspeed.ast1700)    for M in 0..1
>>>>          /ioexp-i2c[0] (aspeed.i2c-ast2700)
>>>>            /bus[N] (aspeed.i2c.bus)    for N in 0..15
>>>>              /ioexpM.N (i2c-bus)
>>>>
>>>> Object aspeed.ast1700 is a sysbus device that contains an
>>>> aspeed.i2c-ast2700 as child "ioexp-i2c[0]".  It has a property
>>>> "board-idx" with value M.
>>>>
>>>> Aside: we only ever create one aspeed.i2c-ast2700 child.  Why [0]?
>>>
>>> Right. We can drop [*] in aspeed_ast1700_instance_init() - PATCH 15.
>>>
>>>> Aside^2: I tried to strangle the "[*]" feature in the crib, but failed.
>>>> Has been a minor thorn in my side ever since.
>>>>
>>>> aspeed.ast1700 set its child's (aspeed.i2c-ast2700) property "bus-labe=
l"
>>>> to "ioexpM".  This makes the child set the grandchild's (aspeed.i2c.bu=
s)
>>>> property "bus-name" to "ioexpM.N", which makes the grandchild name the
>>>> great-grandchild (i2c-bus) "ioexpM.N".
>>>>
>>>> This naming business is complicated, and I had a hard time ferreting it
>>>> out.  As far as I can tell, it's all in service of -device bus=3D...
>>>
>>> yes.
>>>
>>> That's why I regret not letting QEMU taking care of the naming with :
>>>
>>>     s->bus =3D i2c_init_bus(dev, NULL);
>>>
>>> This would break the user interface though. This is still an option.
>>=20
>> Since the devices providing these i2c buses have no qdev ID, these buses
>> would then be named i2c.N, where N counts up from 0.  I think.  See "Bus
>> names are defined as follows" below.
>>=20
>> Good enough?
>
> Good enough to avoid the bus naming conflict, not good enough
> to easily identify a bus in the machine topology and it's also
> breaking the user interface ... too many cons to be a good
> choice.

How is it breaking the user interface?

Mind, I didn't mean to propose changing existing bus names, i.e. the bus
names "aspeed.i2c.bus.N" of the i2c bus objects at
/machine/soc/i2c/bus[N]/aspeed.i2c_init_bus.N.  Only the bus names of
the new i2c bus objects at
/machine/soc/ioexp[M]/ioexp-i2c[0]/bus[N]/NEW-BUS-OBJECT.

>>>> Let's examine how that works.
>>>>
>>>> We want to be able to plug i2c devices into any of these 48 i2c buses
>>>> with -device / device_add.  To do that, we need to select a bus with t=
he
>>>> "bus" argument.
>>>>
>>>> In a world saner than the one we live in, the value of "bus" would be a
>>>> QOM path or qdev ID, where qdev ID is shorthand for the QOM path
>>>> /machine/peripheral/ID.
>>=20
>> Nonsense.
>>=20
>> "QOM path or qdev ID" is how the @id argument of device_del and
>> device_sync_config work.  A qdev ID resolves to a qdev.  Here, we need
>> to resolve to a qbus.
>>=20
>> Instead, "QOM path or qbus ID".  Except the concept "qbus ID" does not
>> exist.  All we have is qbus names, which aren't unique (we screwed that
>> up).
>>=20
>>>> For instance, the first i2c bus could then be selected with absolute Q=
OM
>>>> path "/machine/soc/i2c/bus[0]" or partial QOM paths "soc/i2c/bus[0]" or
>>>> "i2c/bus[0]".  Partial QOM paths are a convenience feature that is
>>>> virtually unknown (and possibly ill-advised): you can omit leading path
>>>> components as long as there's no ambiguity.
>>>>
>>>> However, in the world we live in, the value of bus is not a QOM path,
>>>> it's a path in the qtree.  Why?  qdev and -device / device_add predate
>>>> QOM.
>>>>
>>>> If the path starts with "/", it's anchored at the main system bus.
>>>>
>>>> Else, it's anchored at a bus whose name is the first path component.  =
If
>>>> there's more than one such bus, we pick the first one we find.  This is
>>>> a misfeature.
>>>>
>>>> Remaining path components, if any, pick a path in the qtree from that
>>>> anchor towards leaves.  Note that the child of a qbus is always a qdev,
>>>> and the child of a qdev always a qbus.
>>>>
>>>> This must ultimately resolve to a qbus of the appropriate type.
>>>>
>>>> Picking a qdev child of a qbus works like this:
>>>>
>>>> * If a child with a (user-specified) qdev ID equal to the path compone=
nt
>>>>   exists, pick it.  Since qdev IDs are unique, there can only be one.
>>>>
>>>> * Else, if children whose QOM type name equals the path component
>>>>   exists, pick the first one.
>>>>
>>>> * Else, if children whose qdev alias equals the path component exists,
>>>>   pick the first one.
>>>>
>>>> Picking the first one is again a misfeature.
>>>>
>>>> Picking a qbus child is simpler: we pick the first child whose bus name
>>>> equals the path component.
>>>>
>>>> Bus names are defined as follows:
>>>>
>>>> * Whatever creates the bus may set its name.
>>>>
>>>> * Else, if the qbus's parent qdev has an ID, the bus name is ID.N, whe=
re
>>>>   N counts up from 0 within that qdev.
>>>>
>>>> * Else, the bus name is TYPE.N, where TYPE is the parent qdev's QOM ty=
pe
>>>>   name, and N counts up from 0 within that bus class.
>>=20
>> The qbus's QOM type name, of course.
>>=20
>>>> The only case where this is actually works is picking the N-th bus chi=
ld
>>>> provided by a qdev with an ID: use bus=3DID.N (a partial tree path of =
just
>>>> one component).  Anything else is unfit for purpose, except in special
>>>> cases, e.g. when the machine can have just one device of a certain typ=
e.
>>>>
>>>> This mess is harmless for user-created devices: just specify the ID.
>>>> It's awful for onboard devices, which cannot have an ID.
>>>>
>>>> This is a qdev design flaw.  It's not specific to I2C or Aspeed, as
>>>> Philippe suspected.
>>>>
>>>> To illustrate it further, let's have a look at the qtree of machine
>>>> ast2700a1-evb.  Output of "info qtree" in master:
>>>>
>>>>      bus: main-system-bus
>>>>        type System
>>>>        [...]
>>>>        dev: aspeed.i2c.bus, id ""    for N in 0..15
>>>>          [...]
>>>>          bus: aspeed.i2c.bus.N
>>>>            type i2c-bus
>>>>            [...]
>>>>        In aspeed-11.0, we additionally have
>>>>
>>>>        dev: aspeed.i2c.bus, id ""    for M in 0..1, N in 0..15
>>>>          [...]
>>>>          bus: ioexpM.N
>>>>            type i2c-bus
>>>>            [...]
>>>>
>>>> The i2c-buses all have unique names: aspeed.i2c-bus.N and ioexpM.N.  We
>>>> can point to any of them with a partial qtree path of just one
>>>> component: bus=3DNAME where NAME is one of these unique names works, a=
nd
>>>> there is no ambiguity.
>>>>
>>>> The buses have unique names only because device code takes pains to ma=
ke
>>>> them configurable by parent devices, and the parent devices cooperate =
to
>>>> configure them so the resulting bus names are unique.
>>>>
>>>> This is a lot of complexity to work around this qdev design flaw for
>>>> just one special instance.
>>>>
>>>> Can we instead remedy the design flaw once and for all?
>>>>
>>>> Here't the obvious stupid idea: give -device / device_add the means to
>>>> pick a bus by QOM path.
>>>>
>>>> Thoughts?
>>>
>>> Could we support both methods ? I mean looking up the bus by the
>>> qtree name and by the QOM path ?
>>=20
>> We can't just change "bus".  Management applications and human users
>> rely on it.
>>=20
>> Except we might be able to break aspects that aren't actually used in
>> anger.  Is anyone using '/' in qtree paths in anger?  I sure hope nobody
>> does, because that way is madness.  But it's hard to be reasonably sure.
>
> Could we add a prefix to the bus name argument to signify a change of
> namespace for the lookup ? like 'qom:' or 'machine:' ?

Hmm.

The value of "bus" is a path in the qtree.  It either starts with '/'
(main system bus) or a bus name.  Recall that a bus name can be

* set by whatever creates the bus

* ID.N, where ID is the parent qdev's ID.

* TYPE.N, where TYPE is the bus's QOM type name.

TYPE.N start with "qom:" or "machine:", because QOM type names cannot
create ':' since commit b447378e121 (qom/object: Limit type names to
alphanumerical and some few special characters).

ID.N shouldn't start with "qom:" or "machine:", because

* Users cannot pick qdev IDs containing ':' since commit b560a9ab9be
  (qemu-option: Reject anti-social IDs).  Except they can, because we
  regressed in 9.2 I'll post a patch.

* Code should not pick such qdev IDs (but it totally could).

Likewise, code setting bus names containing ':' would be unwise (but it
totally could).

I'm not sure we want to rely on this particular house of cards.

As so often, the combination of ill-advised convenience features and
equally ill-advised loose syntax bites us in the butt.

>
> Thanks !
>
> C.
>
>> If we can break '/' in the value of "bus", we could overload "bus": make
>> it a QOM path or a qbus ID, similar to how device_del's @id is a QOM
>> path or a qdev ID.  We'd have to define "qbus ID".
>>=20
>> Instead, we could perhaps add an argument "parent" to specify the QOM
>> parent object, mutually exclusive with "bus".  For devices that plug
>> into a certain kind of bus, the parent object must be an instance of
>> that bus.
>>=20
>>> Thanks,
>>>
>>> C.
>>=20
>> You're welcome!


