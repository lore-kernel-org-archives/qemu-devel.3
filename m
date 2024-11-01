Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89F8E6F061
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 14:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6sQm-0007js-Nh; Fri, 01 Nov 2024 10:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t6sQf-0007c5-8j
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:15:11 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1t6sQc-0008M9-Bn
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 10:15:08 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1t6sQF-0007mN-JD; Fri, 01 Nov 2024 15:14:43 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t6sQD-001WYz-1S;
 Fri, 01 Nov 2024 15:14:41 +0100
Received: from localhost ([127.0.0.1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1t6sQC-00BEXF-2F;
 Fri, 01 Nov 2024 15:14:41 +0100
Message-ID: <9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de>
Subject: backing storage for eMMC boot partitions
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>, =?ISO-8859-1?Q?C=E9dric?= Le Goater	
 <clg@kaod.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>,  Joel Stanley <joel@jms.id.au>, qemu-block
 <qemu-block@nongnu.org>
Date: Fri, 01 Nov 2024 15:14:40 +0100
In-Reply-To: <b6641b83-33dc-46f8-b61b-fbdb9ab9bc40@roeck-us.net>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
 <a65a224e-4f54-436d-b555-734a8926d941@roeck-us.net>
 <aa7755a2-e6fa-4d23-bcac-a630e6da98db@linaro.org>
 <d9f18091-aee1-4b32-ba72-e1028fe433c9@roeck-us.net>
 <5262a33d-d0c5-452b-9869-f8f482b1c857@linaro.org>
 <07664ec3-6b46-4b27-9d8c-9e2ff34c9dbe@kaod.org>
 <600baa43c3dd3547338934717cfb57c5e12b0d23.camel@pengutronix.de>
 <84c32f2d-7d9a-4e5a-8b67-1f954dd493f6@roeck-us.net>
 <b67f302a11a679c3fdb02318eb9ef0be559d14ce.camel@pengutronix.de>
 <53cbb597-e7f2-4742-bf85-928c704ddbcf@linaro.org>
 <443f1b0c-8184-4bf4-9f68-c23d7de3bc36@roeck-us.net>
 <1bce4c22-9281-44c5-8acb-860881dc271c@kaod.org>
 <c27fbed6-596e-4ce7-a6ca-6d12d7205e99@roeck-us.net>
 <86fa6e68-5861-4d4d-941f-95b278074eb6@kaod.org>
 <1c917e4a-de50-45b9-ac9c-eb04d51401a2@roeck-us.net>
 <00997cca-6f4a-4b99-9616-2af6a25cd4fb@kaod.org>
 <4246f82b-597c-4a5d-9a55-18a584e7d8c7@roeck-us.net>
 <670fa7bf052d8f292f9bd25c330c8d7bdba02770.camel@pengutronix.de>
 <b6641b83-33dc-46f8-b61b-fbdb9ab9bc40@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: qemu-devel@nongnu.org
Received-SPF: pass client-ip=2a0a:edc0:2:b01:1d::104;
 envelope-from=jlu@pengutronix.de; helo=metis.whiteo.stw.pengutronix.de
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 2024-10-29 at 07:40 -0700, Guenter Roeck wrote:
> On 10/28/24 01:41, Jan L=C3=BCbbe wrote:
> > On Sun, 2024-10-27 at 20:32 -0700, Guenter Roeck wrote:
> > > On 10/27/24 15:26, C=C3=A9dric Le Goater wrote:
> > > > On 10/27/24 23:11, Guenter Roeck wrote:
> > > > > On 10/27/24 14:13, C=C3=A9dric Le Goater wrote:
> > > > > > On 10/26/24 17:32, Guenter Roeck wrote:
> > > > > > > On 10/26/24 03:02, C=C3=A9dric Le Goater wrote:
> > > > > > > [ ... ]
> > > > > > >=20
> > > > > > > >=20
> > > > > > > Works for me, though, and it is much better than mandating th=
e existence
> > > > > > > of boot partitions.
> > > > > >=20
> > > > > > Yes. However, if the emmc device was user creatable, we could u=
se :
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 -blockdev node-name=3Demmc0,driver=3Dfile,fi=
lename=3Dmmc-ast2600-evb-noboot.raw \
> > > > > > =C2=A0=C2=A0=C2=A0 -device emmc,bus=3Dsdhci-bus.2,drive=3Demmc0
> > > > > >=20
> > > > > > and with boot partitions:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0 -M boot-emmc=3Dtrue \
> > > > > > =C2=A0=C2=A0=C2=A0 -blockdev node-name=3Demmc0,driver=3Dfile,fi=
lename=3Dmmc-ast2600-evb.raw \
> > > > > > =C2=A0=C2=A0=C2=A0 -device emmc,bus=3Dsdhci-bus.2,drive=3Demmc0=
,boot-partition-size=3D1048576,boot-config=3D8
> > > > > >=20
> > > > > > The above would be my preferred approach if acceptable. The "sd=
-bus"
> > > > > > bus identifier should be changed in other machines tough.
> > > > >=20
> > > > > No real preference here, though my understanding is that emmc dev=
ices
> > > > > are by definition built-in, and that is what emmc_class_init() sa=
ys as well.
> > > > > Also, there does not seem to be an sdhci-bus, only sd-bus, and th=
at does
> > > > > not support any index values. That may be just my lack of knowled=
ge, though.
> > > >=20
> > > > No, you are right. On a real ast2600-evb, the eMMC device is indeed
> > > > soldered on the board. But, for testing purposes, it is sometime
> > > > interesting to add some flexibility in the machine definition and
> > > > in the modeling too. This avoids "hard-coding" default devices in
> > > > the machines and lets the user define its own variant models using
> > > > the QEMU command line.
> > >=20
> > > I would agree, but I had a number of my patches rejected because whil=
e
> > > they would be useful for testing they would not accurately reflect th=
e
> > > hardware. So nowadays I gave up even trying to upstream such changes.
> >=20
> > My patch to make eMMCs user creatable [1] was applied to target-
> > arm.next by Peter Maydell [2] last week.
> >=20
>=20
> That works for me with
>=20
> drivecmd=3D"-drive file=3D${ROOTFS},format=3Draw,if=3Dnone,id=3Dd0"
> drivecmd+=3D" -device emmc,drive=3Dd0"
>=20
> but unless I am missing something
>=20
> drivecmd=3D"-drive file=3D${ROOTFS},format=3Draw,if=3Dnone,id=3Dd0"
> drivecmd+=3D" -device sd-card,drive=3Dd0"
>=20
> also boots from the emmc controller. How do I provide the
> bus and bus index ? "bus=3Dsdhci-bus.2" doesn't work for me.
> There is "sd-bus", but it does not have an index.

I've not really understood how to assemble more complex setups using
qemu's commandline when the board already creates some of the devices.=C2=
=A0

Perhaps C=C3=A9dric can explain how the different boot options are
configured for aspeed?

I see three cases:
1. specify the blockdev driver and options in the simple case where the
board already creates the SD or eMMC device
2. specify some custom options for the eMMC
3. create a custom eMMC config on a generic machine via sdhci-pci


Case 1 is probably most common. The user has chosen a board and just
wants to boot a rootfs image and doesn't care about boot partitions or
anything else eMMC-specific.


Some users may want to emulate an eMMC with boot partitions, as that
allows them to emulate their physical boards more closely (case 2).
Note that eMMC boot partitions are usually *not* used for storing a
Linux kernel, but for the bootloader (including things like u-boot, TF-
A, OP-TEE, ...). The ROM-code on many SoCs supports loading directly
from eMMC boot partitions. One of the two boot partitions can be
activated with an atomic eMMC EXT CSD register write, allowing atomic
bootloader updates. I think this case was the motivation for C=C3=A9dric's
eea55625df83 ("aspeed: Introduce a AspeedSoCClass 'boot_from_emmc'
handler").

These users are likely fine with assembling a backing file consisting
of e.g.
- bootloader image (boot0) @ offset 0MiB
- empty space for bootloader updates (boot1) @ offset 1MiB
- partitioned disk image (rootfs, ...) @ offset 2MiB
to get the same setup as their real hardware.


Case 3 is what I want to use the eMMC emulator for: Test eMMC-specific
functionality in Linux userspace, specifically the boot partition
update backend for RAUC, in a CI setup. To improve performance and
because we don't need to emulate any specific board for CI, we use an
x86 guest (q35). As it has PCIe, the easiest way to add the necessary
eMMC emulation is to use sdhci-pci. That was the motivation behind my
patch "hw/sd/sdcard: Allow user creation of eMMCs" [1].

For that case, having one backing file for boot partitions + main area
is fine as well.


If we wanted more flexibility via separate backing files per eMMC
partitions, it might work similar to NVMe Namespaces [2]. For me, that
seems like a lot of complexity a very niche case like eMMC boot
partitions.


Potential future features such as more eMMC data partitions, RPMB
support or separate backing files could be support in QEMU by new eMCC
device options or even additional devices (following the NVMe
approach), without breaking backwards compatibility.

So it seems to me, that C=C3=A9dric's approach of enabling boot partitions
in hw/arm/aspeed.c only when configured to boot from them via the "hw-
strap1" property should solve cases 1 and 2 without introducing
backwards compatibility issues. Case 3 has explicit configuration (if a
boot partition is emulated), so shouldn't be a problem either.


Thanks,
Jan

[1] https://lore.kernel.org/qemu-devel/20241015135649.4189256-1-jlu@pengutr=
onix.de/T/
[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#additional=
-namespaces

--=20
Pengutronix e.K.                        |                             |
Steuerwalder Str. 21                    | https://www.pengutronix.de/ |
31137 Hildesheim, Germany               | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686        | Fax:   +49-5121-206917-5555 |



