Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0455CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUBY-0006DF-M8; Tue, 02 Sep 2025 12:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1utUBF-00062t-UO
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:48:28 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1utUBB-0003Vk-Eo
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:48:25 -0400
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1utUAt-0001DK-15; Tue, 02 Sep 2025 18:48:03 +0200
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1utUAq-003QG6-16;
 Tue, 02 Sep 2025 18:48:00 +0200
Received: from localhost ([127.0.0.1] helo=[IPv6:::1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1utUAq-009SCg-0T;
 Tue, 02 Sep 2025 18:48:00 +0200
Message-ID: <a1463f9e36d8b3e6289859bec9a0a5a758709316.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair
 Francis <alistair@alistair23.me>, Alexander Bulekov <alxndr@bu.edu>
Date: Tue, 02 Sep 2025 18:47:59 +0200
In-Reply-To: <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
 <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
 <41d2e67e-3345-4720-b3aa-1051224025de@siemens.com>
 <21b6726a-1ceb-4782-a219-36f32cebb774@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2025-09-02 at 18:39 +0200, Jan Kiszka wrote:
> > > I expect us to be safe and able to deal with non-pow2 regions if we u=
se
> > > QEMUSGList from the "system/dma.h" API. But this is a rework nobody h=
ad
> > > time to do so far.
> >=20
> > We have to tell two things apart: partitions sizes on the one side and
> > backing storage sizes. The partitions sizes are (to my reading) clearly
> > defined in the spec, and the user partition (alone!) has to be power of
> > 2. The boot and RPMB partitions are multiples of 128K. The sum of them
> > all is nowhere limited to power of 2 or even only multiples of 128K.
> >=20
>=20
> Re-reading the part of the device capacity, the rules are more complex:
> =C2=A0- power of two up to 2 GB
> =C2=A0- multiple of 512 bytes beyond that
>=20
> So that power-of-two enforcement was and still is likely too strict.
>
> But I still see no indication, neither in the existing eMMC code of QEMU
> nor the spec, that the boot and RPMB partition sizes are included in that=
.

Correct. Non-power-of-two sizes are very common for real eMMCs. Taking a ra=
ndom
one from our lab:
[    1.220588] mmcblk1: mmc1:0001 S0J56X 14.8 GiB
[    1.228055]  mmcblk1: p1 p2 p3 p4
[    1.230375] mmcblk1boot0: mmc1:0001 S0J56X 31.5 MiB
[    1.233651] mmcblk1boot1: mmc1:0001 S0J56X 31.5 MiB
[    1.236682] mmcblk1rpmb: mmc1:0001 S0J56X 4.00 MiB, chardev (244:0)

For eMMCs using MLC NAND, you can also configure part of the user data area=
 to
be pSLC (pseudo single level cell), which changes the available capacity (a=
fter
a required power cycle).

Regards,
Jan


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

