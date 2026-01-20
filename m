Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0786D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 10:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi96m-0006Nh-AG; Tue, 20 Jan 2026 05:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vi96i-0006L3-Tz
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:37:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vi96g-0007s8-E2
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 05:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768905424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rqZPS2TZSZeJEkRjXzAkbq2CuVva/I1N1UzXpNu3k4=;
 b=X20YzFCeTYIq2nxzlQuUD3h6+1Dv6fAVLl3fip0sn4kh7CV+xtEJetNqnX6WQz/fk+z2f+
 GK2r/fi2qDskb6GwcWapf91cBfdFjx/fg1JvFST6cZei2iQcsy/UmTEULXu4HWwKoSe06+
 v4ur/sIGhXkFFktajOO6y8SXAdPUzwo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-EDH7FiJbPXyqFVarrKaqJg-1; Tue,
 20 Jan 2026 05:37:00 -0500
X-MC-Unique: EDH7FiJbPXyqFVarrKaqJg-1
X-Mimecast-MFC-AGG-ID: EDH7FiJbPXyqFVarrKaqJg_1768905418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFD8718005B4; Tue, 20 Jan 2026 10:36:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 981F018008FF; Tue, 20 Jan 2026 10:36:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1CA821E692D; Tue, 20 Jan 2026 11:36:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Kane Chen
 <kane_chen@aspeedtech.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,  Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  Andrew Jeffery
 <andrew@codeconstruct.com.au>,  Joel Stanley <joel@jms.id.au>,  "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>,  "open list:All patches CC here"
 <qemu-devel@nongnu.org>,  <troy_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Daniel P. Berrange
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v1 0/1] hw/i2c/aspeed: Introduce 'bus-label' to
 customize bus naming
In-Reply-To: <ba5b61db-64ad-495d-90f4-03e5553bf38e@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 19 Jan 2026 18:38:50 +0100")
References: <20260112083054.4151945-1-kane_chen@aspeedtech.com>
 <5e72f6d4-6914-4797-85f6-6131af0d1349@linaro.org>
 <7b67c00a-2bf3-4a25-aae4-9d4dd932486a@kaod.org>
 <877btdn0gv.fsf@pond.sub.org>
 <ba5b61db-64ad-495d-90f4-03e5553bf38e@kaod.org>
Date: Tue, 20 Jan 2026 11:36:52 +0100
Message-ID: <875x8win97.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Cc: QOM/qdev maintainers

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Hello,
>
> On 1/19/26 15:25, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>=20
>>> On 1/15/26 20:47, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Hi,
>>>> Cc'ing Markus.
>>>> On 12/1/26 09:30, Kane Chen via qemu development wrote:
>>>>> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>>>>>
>>>>> Currently, the Aspeed I2C controller uses a static naming convention
>>>>> for its buses (e.g., "aspeed.i2c.bus.0"). This approach leads to
>>>>> object name conflicts in machine models that incorporate multiple I2C
>>>>> controllers, such as an Aspeed SoC paired with an external IO expander
>>>>> or a co-processor like the AST1700.
>>>>>
>>>> Is this a side-effect of Problem 4: 'The /machine/unattached/ orphanag=
e'
>>>> described here?
>>>> https://lore.kernel.org/qemu-devel/87o7d1i7ky.fsf@pond.sub.org/

No, but ...

>>>> This problem isn't specific to I2C nor Aspeed.

... yes, indeed.  Details below.

>>> See the discussion here :
>>>
>>>    https://lore.kernel.org/qemu-devel/006fa26f-6b84-4e82-b6e1-7d1353579=
441@kaod.org/
>>>
>>> The Aspeed SoC has 3*16 I2C buses attached on 3 different I2C
>>> controllers plus the I2C/I3C buses. We need to find a way to
>>> distinguish these groups at the QEMU machine level to be able
>>> to add devices on the right bus when using the command line.
>>>
>>> Suggestions welcome !
>>
>> Please show me how to start a QEMU with the 48 I2C mentioned above,
>> complete with output of "info qtree".
>
> Clone
>
>   https://github.com/legoater/qemu/commits/aspeed-11.0
>
> Download
>
>   https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.08/ast2=
700-default-obmc.tar.gz
>
> And run :
>
>   qemu-system-aarch64 -M ast2700a1-evb -m 8G -smp 4 -net nic,macaddr=3D,n=
etdev=3Dnet0 -netdev user,id=3Dnet0,hostfwd=3D::2207-:22 -drive file=3Dpath=
/to/ast2700-default/image-bmc,format=3Draw,if=3Dmtd -nographic -serial mon:=
stdio -snapshot
>
> Today, to attach an I2C device on one of the Aspeed SoC I2C buses :
>
>   -device tmp105,bus=3Daspeed.i2c.bus.1,address=3D0x4d,id=3Dtmp-test
>
> The Aspeed SoC I2C bus names follow the "aspeed.i2c.bus.X" format.
> This is the model typename. The 2 new IO expander models attached
> to the Aspeed SoC have an extra 16 I2C buses each. These buses use
> an "ioexpX.Y" name, as proposed in the aspeed-next branch.
>
> Attaching a device to one of the IO expanders I2C buses would be :
>
>   -device tmp105,bus=3Dioexp0.1,address=3D0x4d,id=3Dtmp-test
>
> See the qtree below.

Thank you!

Machine ast2700a1-evb has QOM objects

    /machine/soc/i2c/ (aspeed.i2c-ast2700)
      /bus[N] (aspeed.i2c.bus)    for N in 0..15
        /aspeed.i2c.bus.N (i2c-bus)

in both master and aspeed-11.0.

Object aspeed.i2c-ast2700 is a sysbus device that contains 16
aspeed.i2c.bus objects as children bus[N] for N in 0..15.  Each object
has a property "bus-id" with value N.

Object aspeed.i2c.bus is a sysbus device that contains an i2c-bus object
as child aspeed.i2c.bus.N.

Aside: why parent TYPE_SYS_BUS_DEVICE, and not TYPE_DEVICE?  It doesn't
actually plug into a sysbus...

Object i2c-bus is a qbus.

In master, object aspeed.i2c.bus computes the child name by appending .N
to its own type name TYPE_ASPEED_I2C_BUS.

In aspeed-11.0, it takes it from its property "bus-name".  The property
is set by its QOM parent aspeed.i2c-ast2700, and computed by appending
.N to the value of its property "bus-label".  It defaults the property
to TYPE_ASPEED_I2C_BUS.

Since nothing sets this property in this case, we get the same child
name.

aspeed-11.0 additionally has QOM objects

    /machine/soc/ioexp[M] (aspeed.ast1700)    for M in 0..1
        /ioexp-i2c[0] (aspeed.i2c-ast2700)
          /bus[N] (aspeed.i2c.bus)    for N in 0..15
            /ioexpM.N (i2c-bus)

Object aspeed.ast1700 is a sysbus device that contains an
aspeed.i2c-ast2700 as child "ioexp-i2c[0]".  It has a property
"board-idx" with value M.

Aside: we only ever create one aspeed.i2c-ast2700 child.  Why [0]?

Aside^2: I tried to strangle the "[*]" feature in the crib, but failed.
Has been a minor thorn in my side ever since.

aspeed.ast1700 set its child's (aspeed.i2c-ast2700) property "bus-label"
to "ioexpM".  This makes the child set the grandchild's (aspeed.i2c.bus)
property "bus-name" to "ioexpM.N", which makes the grandchild name the
great-grandchild (i2c-bus) "ioexpM.N".

This naming business is complicated, and I had a hard time ferreting it
out.  As far as I can tell, it's all in service of -device bus=3D...
Let's examine how that works.

We want to be able to plug i2c devices into any of these 48 i2c buses
with -device / device_add.  To do that, we need to select a bus with the
"bus" argument.

In a world saner than the one we live in, the value of "bus" would be a
QOM path or qdev ID, where qdev ID is shorthand for the QOM path
/machine/peripheral/ID.

For instance, the first i2c bus could then be selected with absolute QOM
path "/machine/soc/i2c/bus[0]" or partial QOM paths "soc/i2c/bus[0]" or
"i2c/bus[0]".  Partial QOM paths are a convenience feature that is
virtually unknown (and possibly ill-advised): you can omit leading path
components as long as there's no ambiguity.

However, in the world we live in, the value of bus is not a QOM path,
it's a path in the qtree.  Why?  qdev and -device / device_add predate
QOM.

If the path starts with "/", it's anchored at the main system bus.

Else, it's anchored at a bus whose name is the first path component.  If
there's more than one such bus, we pick the first one we find.  This is
a misfeature.

Remaining path components, if any, pick a path in the qtree from that
anchor towards leaves.  Note that the child of a qbus is always a qdev,
and the child of a qdev always a qbus.

This must ultimately resolve to a qbus of the appropriate type.

Picking a qdev child of a qbus works like this:

* If a child with a (user-specified) qdev ID equal to the path component
  exists, pick it.  Since qdev IDs are unique, there can only be one.

* Else, if children whose QOM type name equals the path component
  exists, pick the first one.

* Else, if children whose qdev alias equals the path component exists,
  pick the first one.

Picking the first one is again a misfeature.

Picking a qbus child is simpler: we pick the first child whose bus name
equals the path component.

Bus names are defined as follows:

* Whatever creates the bus may set its name.

* Else, if the qbus's parent qdev has an ID, the bus name is ID.N, where
  N counts up from 0 within that qdev.

* Else, the bus name is TYPE.N, where TYPE is the parent qdev's QOM type
  name, and N counts up from 0 within that bus class.

The only case where this is actually works is picking the N-th bus child
provided by a qdev with an ID: use bus=3DID.N (a partial tree path of just
one component).  Anything else is unfit for purpose, except in special
cases, e.g. when the machine can have just one device of a certain type.

This mess is harmless for user-created devices: just specify the ID.
It's awful for onboard devices, which cannot have an ID.

This is a qdev design flaw.  It's not specific to I2C or Aspeed, as
Philippe suspected.

To illustrate it further, let's have a look at the qtree of machine
ast2700a1-evb.  Output of "info qtree" in master:

    bus: main-system-bus
      type System
      [...]
      dev: aspeed.i2c.bus, id ""    for N in 0..15
        [...]
        bus: aspeed.i2c.bus.N
          type i2c-bus
          [...]
=20=20=20=20=20=20
In aspeed-11.0, we additionally have

      dev: aspeed.i2c.bus, id ""    for M in 0..1, N in 0..15
        [...]
        bus: ioexpM.N
          type i2c-bus
          [...]

The i2c-buses all have unique names: aspeed.i2c-bus.N and ioexpM.N.  We
can point to any of them with a partial qtree path of just one
component: bus=3DNAME where NAME is one of these unique names works, and
there is no ambiguity.

The buses have unique names only because device code takes pains to make
them configurable by parent devices, and the parent devices cooperate to
configure them so the resulting bus names are unique.

This is a lot of complexity to work around this qdev design flaw for
just one special instance.

Can we instead remedy the design flaw once and for all?

Here't the obvious stupid idea: give -device / device_add the means to
pick a bus by QOM path.

Thoughts?


