Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D48D49211
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0fo-0005Za-FR; Mon, 18 Nov 2024 07:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1tD0fi-0005We-2Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:16:05 -0500
Received: from metis.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jlu@pengutronix.de>)
 id 1tD0fg-0000qw-2e
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:16:01 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <jlu@pengutronix.de>)
 id 1tD0fK-0001jL-Cx; Mon, 18 Nov 2024 13:15:38 +0100
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77])
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1tD0fJ-001ORb-39;
 Mon, 18 Nov 2024 13:15:37 +0100
Received: from localhost ([127.0.0.1])
 by ptz.office.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <jlu@pengutronix.de>) id 1tD0fJ-0069h9-2k;
 Mon, 18 Nov 2024 13:15:37 +0100
Message-ID: <dc456cff7aa40543ac245ccfd9bf504f3c114a9f.camel@pengutronix.de>
Subject: Re: backing storage for eMMC boot partitions
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Guenter Roeck
 <linux@roeck-us.net>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Thomas Huth
 <thuth@redhat.com>,  Joel Stanley <joel@jms.id.au>, qemu-block
 <qemu-block@nongnu.org>
Date: Mon, 18 Nov 2024 13:15:37 +0100
In-Reply-To: <7c8658ef-e61b-4a46-91cf-6dc26e78158c@kaod.org>
References: <20241017163247.711244-1-peter.maydell@linaro.org>
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
 <9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de>
 <7c8658ef-e61b-4a46-91cf-6dc26e78158c@kaod.org>
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

Hi,

On Mon, 2024-11-18 at 10:14 +0100, C=C3=A9dric Le Goater wrote:
> > > also boots from the emmc controller. How do I provide the
> > > bus and bus index ? "bus=3Dsdhci-bus.2" doesn't work for me.
> > > There is "sd-bus", but it does not have an index.
>=20
> Yes. Changes are required in the sdhci model and in the boards using
> it.
>=20
> > I've not really understood how to assemble more complex setups
> > using qemu's commandline when the board already creates some of the
> > devices.
>=20
> Yes. That's a "problem" to fix for emmc/sd devices. They should only
> be created when defaults_enabled(), just like the flash devices.

This is -nodefaults, right? The man-page for that says:
  -nodefaults
         Don't  create default devices. Normally, QEMU sets the de=E2=80=90
         fault devices like serial  port,  parallel  port,  virtual
         console,  monitor  device,  VGA adapter, floppy and CD-ROM
         drive and others. The -nodefaults option will disable  all
         those default devices.

That sounds like it would require explicit configuration of the devices
on the SoC (such as UARTs) as well? Having to specify them (perhaps
even with their MMIO addresses) doesn't seem convenient. :)

aspeed seems to only (or additionally?) skip creation of the flash
devices with -nodefaults.

Isn't there a way to configure only default devices as disabled? Or to
dynamically attach a user-created SD/eMMC device to an existing SD
controller?

In system/vl.c, I found 'default_sdcard', which is disabled in some
cases. I wasn't able to figure out how to use it or if it would help
for this use-case.

Jan

> > Perhaps C=C3=A9dric can explain how the different boot options are
> > configured for aspeed?
>=20
> See
> https://qemu.readthedocs.io/en/v9.1.0/system/arm/aspeed.html#boot-options
> and the avocado/functional tests for examples.
>=20
> The eMMC case is missing from the docs. Here is a proposal :
> https://lore.kernel.org/qemu-devel/20241118090648.187720-1-clg@redhat.com=
/
>=20
> Thanks,
>=20
> C.

