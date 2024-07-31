Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A3CC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 05:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ1mw-0002le-9Q; Wed, 31 Jul 2024 01:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZ1mu-0002fm-CR; Wed, 31 Jul 2024 01:22:12 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZ1ms-0002iW-2n; Wed, 31 Jul 2024 01:22:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4AB2ACE0D24;
 Wed, 31 Jul 2024 05:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97588C116B1;
 Wed, 31 Jul 2024 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722403324;
 bh=PQ0rvOL0SCooKEPFtRsKNPBkA8CYab0m/+Eba8BWVaI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Om+CYcFTpahto5bnDPvArAw4xmXCYoIk4U1Jmtec425rHsnaWgMYvgD82MgSTYkDf
 BrdnFzxHEMxOl6pUQ9mfGh9jkvFMpovc5zPzZZ3dkqNrnfOcRdH2mwdo2h7LY8Vk6B
 D9hyiRBhVIIfPtwyrNW9QP013xQi5EGOi+uKFEul0ZFE1X3AxpbVYpz5yTgbU/ahkl
 LLF5JOd0uW8iUhcv5JndGTFXURAgj2gluqcpjTRWEMc6pWrjNoHuqKxxcklJ9CMWh/
 Uel4AmJaZ5nnarALxL+JBnfm1OBeKKvaxD0GsrG5wNkWyWXBCZBPT1EqAoOB2aTtMq
 +5GKjHwcQHELQ==
Date: Wed, 31 Jul 2024 07:21:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Igor Mammedov
 <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240731072158.3aaf85ac@foz.lan>
In-Reply-To: <ZqigPgTl7quJ553J@intel.com>
References: <cover.1722259246.git.mchehab+huawei@kernel.org>
 <e994c3944d31775d62bbd017dec3adff50ddf269.1722259246.git.mchehab+huawei@kernel.org>
 <ZqigPgTl7quJ553J@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Tue, 30 Jul 2024 16:11:42 +0800
Zhao Liu <zhao1.liu@intel.com> escreveu:

> Hi Mauro,
>=20
> On Mon, Jul 29, 2024 at 03:21:06PM +0200, Mauro Carvalho Chehab wrote:
> > Date: Mon, 29 Jul 2024 15:21:06 +0200
> > From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Subject: [PATCH v4 2/6] arm/virt: Wire up GPIO error source for ACPI / =
GHES
> > X-Mailer: git-send-email 2.45.2
> >=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Creates a Generic Event Device (GED) as specified at
> > ACPI 6.5 specification at 18.3.2.7.2:
> > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event=
-notification-for-generic-error-sources
> > with HID PNP0C33.
> >=20
> > The PNP0C33 device is used to report hardware errors to
> > the bios via ACPI APEI Generic Hardware Error Source (GHES).
> >=20
> > It is aligned with Linux Kernel patch:
> > https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.hua=
ng@intel.com/
> >=20
> > [mchehab: use a define for the generic event pin number and do some cle=
anups]
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/arm/virt-acpi-build.c | 30 ++++++++++++++++++++++++++----
> >  hw/arm/virt.c            | 14 ++++++++++++--
> >  include/hw/arm/virt.h    |  1 +
> >  include/hw/boards.h      |  1 +
> >  4 files changed, 40 insertions(+), 6 deletions(-) =20
>=20
> [snip]
>=20
> > +static void virt_set_error(void)
> > +{
> > +    qemu_set_irq(qdev_get_gpio_in(gpio_error_dev, 0), 1);
> > +}
> > + =20
>=20
> [snip]
>=20
> > +    mc->generic_error_device_notify =3D virt_set_error; =20
>=20
> [snip]
>=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index 48ff6d8b93f7..991f99138e57 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -308,6 +308,7 @@ struct MachineClass {
> >      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx=
);
> >      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> >      uint64_t smbios_memory_device_size;
> > +    void (*generic_error_device_notify)(void); =20
>=20
> The name looks inconsistent with the style of other MachineClass virtual
> methods. What about the name like "notify_xxx"? And pls add the comment
> about this new method.
>=20
> BTW, I found this method is called in generic_error_device_notify() of
> Patch 6. And the mc->generic_error_device_notify() - as the virtual
> metchod of MachineClass looks just to implement a hook, and it doesn't
> seem to have anything to do with MachineClass/MachineState, so my
> question is why do we need to add this method to MachineClass?
>=20
> Could we maintain a notifier list in ghes.c and expose an interface
> to allow arm code register a notifier? This eliminates the need to add
> the =E2=80=9Cnotify=E2=80=9D method to MachineClass.

Makes sense. I'll change the logic to use this notifier list code inside
ghes.c, and drop generic_error_device_notify():

	NotifierList generic_error_notifiers =3D
	    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);

	/* Notify BIOS about an error via Generic Error Device - GED */
	static void generic_error_device_notify(void)
	{
	    notifier_list_notify(&generic_error_notifiers, NULL);
	}

Regards,
Mauro

