Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE46ACDD1D6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMe5-00031C-3d; Mon, 30 Sep 2024 16:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1svMe1-0002nz-2A
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:05:21 -0400
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1svMdz-0005IX-3s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:05:20 -0400
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=[127.0.0.1])
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1svMdt-00061J-9h; Mon, 30 Sep 2024 22:05:13 +0200
Message-ID: <d6e9f2f8d7185e90e7b80dff7b222fd99c899903.camel@pengutronix.de>
Subject: Re: [PATCH] hw/sd/sdcard: Fix handling of disabled boot partitions
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
Date: Mon, 30 Sep 2024 22:01:58 +0200
In-Reply-To: <CAFEAcA-_=vrtqVPUdu02ryUtdH5MwifEnHgeQVq=V4Z2Jp_dUg@mail.gmail.com>
References: <20240906164834.130257-1-jlu@pengutronix.de>
 <CAFEAcA-_=vrtqVPUdu02ryUtdH5MwifEnHgeQVq=V4Z2Jp_dUg@mail.gmail.com>
Organization: Pengutronix
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
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
Reply-To: jlu@pengutronix.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2024-09-30 at 15:18 +0100, Peter Maydell wrote:
> On Fri, 6 Sept 2024 at 17:51, Jan Luebbe <jlu@pengutronix.de> wrote:
> >=20
> > The enable bits in the EXT_CSD_PART_CONFIG ext_csd register do *not*
> > specify whether the boot partitions exist, but whether they are enabled
> > for booting. Existence of the boot partitions is specified by a
> > EXT_CSD_BOOT_MULT !=3D 0.
> >=20
> > Currently, in the case of boot-partition-size=3D1M and boot-config=3D0,
> > Linux detects boot partitions of 1M. But as sd_bootpart_offset always
> > returns 0, all reads/writes are mapped to the same offset in the backin=
g
> > file.
> >=20
> > Fix this bug by calculating the offset independent of which partition i=
s
> > enabled for booting.
>=20
> Looking at the spec this change seems correct to me.
>=20
> Can you elaborate on when users might run into this bug?
> As far as I can see only aspeed.c sets boot-partition-size,
> and when it does so it also sets boot-config to 8. Or are
> we fixing this for the benefit of future board types?

I stumbled across this when trying to use the eMMC emulation for the RAUC t=
est
suite (with some unrelated local hacks, which I still need to clean up for
submission) [1]. Future boards would be affected as well.

One other possible issue would be disabling the boot partition by using 'mm=
c
bootpart enable 0 0 /dev/mmcblk0' (or similar) from Linux. The layout of th=
e
backing file shouldn't change in that case.

Regards,
Jan

[1] https://github.com/rauc/rauc/tree/master/test
--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

