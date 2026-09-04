Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DBFC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2PCM-0007CW-HH; Fri, 04 Sep 2026 04:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2PCK-0007C3-TZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2PCI-0002Bx-Ql
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788510174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTWYsmhlqK4jGGpc9fyTbn0qE377YZhdPTMPKomSSWA=;
 b=fjwqhVcO+GLQAORn0Esd4x5DEW5qP2sZLhJ2/F+oY5/XXJ7uadqHOu7kOLORCparUig/vs
 6eg+lofQYRpYvhGzFee6+BDGtX65qcp0dJX8+3Z7QafOQEC4tGX/oc1M7np16Q7IER8XxO
 CS2frlpbXdMNMA8dxx6P4LASPlZ3m5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-56fWviNXMwarlDwUfAZQJQ-1; Fri,
 04 Sep 2026 04:22:50 -0400
X-MC-Unique: 56fWviNXMwarlDwUfAZQJQ-1
X-Mimecast-MFC-AGG-ID: 56fWviNXMwarlDwUfAZQJQ_1788510168
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33153180122D; Fri,  4 Sep 2026 08:22:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4867D18001D0; Fri,  4 Sep 2026 08:22:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CD5CD21E6A04; Fri, 04 Sep 2026 10:22:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,  qemu-devel@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  Kane Chen
 <kane_chen@aspeedtech.com>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,  qemu-arm@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Thomas Huth <th.huth+qemu@posteo.eu>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Emmanuel Blot
 <eblot@meta.com>
Subject: Re: Adding /machines/labels (was Re: [PATCH v2 18/25]
 tests/functional: add a pure-Python device-locator resolver)
In-Reply-To: <cb1b5ec3-d7ba-42fe-a8ab-da7c236b1660@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Thu, 3 Sep 2026 16:21:55 +0200")
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-18-1266926ba769@free.fr>
 <cb1b5ec3-d7ba-42fe-a8ab-da7c236b1660@kaod.org>
Date: Fri, 04 Sep 2026 10:22:42 +0200
Message-ID: <87a4pxh1d9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On 7/31/26 12:45, Emmanuel Blot wrote:
>> Add DeviceLocator, a helper that addresses a device by its position on
>> the bus -- bus, address, type or index -- rather than by a QOM path. A
>> QOM path locates a device under the object that owns it, by enumeration
>> order, and so says nothing about where the device actually sits in the
>> bus topology. From a QOM anchor DeviceLocator instead walks the bus and
>> device hierarchy, alternating bus and device hops, to reach the target.
>> It relies only on standard QOM queries over QMP, needing no custom
>> commands or changes to QEMU.
>
> Let's recap first :
>
> Several recent threads have touched the same topic: QOM
> composition-tree paths encode ownership, but developers and tests
> regularly need to identify devices by their position in the bus
> topology. The threads in question:
>
>   - "[PATCH v5 0/8] hw/sensor: Add new device emulation for TI ADC128D818=
" [1]
>   - "Call to clean up QOM onboard devices lacking a parent" [2]
>   - "[PATCH RFC 001/134] qom: Introduce object_new_child()" [3]
>   - "[PATCH RFC v2 0/137] qom: Make composition-tree parenting mandatory"=
 [4]
>   - "[PATCH v2 0/25] hw/arm: Facebook SanMiguel BMC and TMP75-family sens=
ors" [5]
>
>
> * The problem
>
> QEMU has two device hierarchies serving different purposes:
>
>   - The QOM composition tree describes parent/child ownership.  Every
>     object has exactly one parent. Paths look like:
>     /machine/soc/i2c-controller/child-device.
>   - The bus topology describes electrical connectivity (visible
>     through "info qtree"). A device sits on a bus at an address.

Yes.

*Composition* tree means the children are *components* of their parent.
At least that's the intended use.

The qtree predates QOM and is a bit of a relic.  Its design is too
simplistic to match electric reality: it's a *tree*, whereas real wires
form a *graph*.

Tree is fine for ordinary devices plugging into something a hardware
dude would recognize as a bus, say PCI or USB.

Caveat: as long as they plug into exactly one such thing; "multi-master
I2C" was mentiond as a counter-example.

Many (most?) of our devices are sysbus devices.  Sysbus is not a bus,
it's a cop out: it doesn't actually describe electrical connections
beyond "there are some to other parts of 'the system'".

And then there are funny devices like certain PCI VGA devices that plug
into a PCI but also bypass PCI for mapping their frame buffer.

I guess (the saner parts of) qtree may still provide some value.  I'm
curious: do people use it in programs?  Management applications in
particular.

QOM provides a mechanism that is suitable for modeling electrical
connections other than the ones to the parent: links.  These do form a
graph.

> Devices created without an explicit QOM parent fall into
> /machine/unattached/device[N], the "orphanage", with names that depend
> on enumeration order and are therefore unstable. Markus identified
> 380+ such devices across all QEMU machines [2]. Even with a stable QOM
> path, the path says nothing about where the device sits in the bus
> topology or what purpose it serves.

Yes, and that can be a problem.

> * Three approaches on the table
>
>   1. Mandatory QOM parenting (Graf [3][4] / Armbruster [2])
>      object_new_child() and per-bus creators enforce parenting at
>      creation time. Deletes the orphanage. Scope: 440 files, 137
>      patches.
>
>   2. Bus-child parenting (Blot [1], rejected)
>      i2c_slave_create_simple() would parent slaves to their bus,
>      named by hex address (e.g. /machine/i2c[0]/i2c-bus/0x6f).
>
>   3. DeviceLocator (Blot [5])
>      Pure-Python helper that resolves devices by bus-position
>      descriptors like:
>
>        /machine/soc::aspeed.i2c-ast2600[0]~i2c[9]~tmp75@0x4b
>
>      It walks the bus/device hierarchy using only qom-list/qom-get
>      over QMP, no QEMU code changes needed. 600 lines of python.
>
>
> * /machine/labels: DT-style alias container for QOM
>
> The idea: add a flat container /machine/labels under the machine, where
> board code registers link<> properties pointing to devices by
> purpose name. Like device tree /aliases (serial0  > /soc/uart@9000000).

This general idea has been sloshing around in my head for a long time, I
just haven't had a compelling reason to flesh it out.

> Container creation is one line in qemu_create_machine_containers().
> QMP introspection works today: qom-get /machine/labels/rtc returns the
> target's canonical path.
>
> A small helper is all that is needed:
>
>   void machine_add_label(const char *label, Object *target)
>   {
>       object_property_add_const_link(
>           machine_get_container("labels"), label, target);
>   }
>
> Board code registers one label per well-known device:
>
>   machine_add_label("rtc", OBJECT(dev));
>   machine_add_label("tmp75-bus9-0x4b", OBJECT(sensor));
>
> Tests resolve devices with a single QMP call instead of walking
> the bus hierarchy.  For the common case, functional tests targeting
> specific board devices (SanMiguel TMP75s, Catalina PCA9555s, Anacapa
> ADC128D818s), the board author already knows which devices matter.
>
> Thoughts?

To get the most value out of /machine/labels/, we'd want

* Documented naming conventions such as "/machine/label/serial0 always
  refers to the machine's first serial device"

* Reliability, i.e. if /machine/label/ exists, then
  /machine/label/serial0 exists unless the machine has no first serial
  device

* /machine/label/ to exist for the machines we actually care about :)

> Thanks,
>
> C.
>
> [1] https://lore.kernel.org/qemu-devel/20260701-i2c-adc128d818-anacapa-v5=
-6-fe8292d86b38@free.fr
> [2] https://lore.kernel.org/qemu-devel/87se5scipx.fsf@pond.sub.org
> [3] https://lore.kernel.org/qemu-devel/20260711223707.42139-1-graf@amazon=
.com
> [4] https://lore.kernel.org/qemu-devel/20260718213652.37673-1-graf@amazon=
.com
> [5] https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-=
0-1266926ba769@free.fr


