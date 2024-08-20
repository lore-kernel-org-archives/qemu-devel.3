Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119F4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 20:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgVXD-0007Pb-Lh; Tue, 20 Aug 2024 16:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgVX9-0007Oy-Ou
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 16:32:52 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgVX6-0000ya-BZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 16:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail; t=1724185962; x=1724445162;
 bh=2PvUiMANptUeXLHVWFHa/bLZk1w4sBCQ2a/9IREl7Kg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=zTSR0kQrf4HawVYjOF7OidhlXevPdSfNGvFEqSlNySg9FvuAENo3FD0Dx5Pp/JV3+
 yzmkx8ZE9L8Qrn9zn61VqBhC8pNm6d38x7xdOcMURTgU9G3qvMxK8tb2NYxegkVPNO
 w7ZLPsHmFQ/5IP/20ioVXjiegbz/0c76BE4npkOhrqXcfyuZzqDYq/OiMjlQrpZq3y
 RozO/dvvGZLOVAQTNQb0/vg+Y18g2hL+MfwhDHCrm+jWR9esUEC2mu0Ym4NP71Braj
 ftcwuQJytMEiyZDPNrb+eyx7sqBhEjN21KIi/dvnOtmf1eIdtUk/Ixes404pL6g7T2
 rUVWiPiLgFtoQ==
Date: Tue, 20 Aug 2024 20:32:37 +0000
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PULL 18/20] hw/i386/pc: Unify vmport=auto handling
Message-ID: <l60k6IPuP5TW4SNWI9iSNbMRiENiDl10oJROwImn9NsILTP6M-CVvIV42wUG8RYSdW_o6xdPhhr27Cqc0_2MgvZaBRn2B2poF6CYMGtn3Rc=@szczek.dev>
In-Reply-To: <ee5b8c9e-09fe-4b28-86fb-c6859085f988@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
 <20240819225116.17928-19-philmd@linaro.org>
 <ee5b8c9e-09fe-4b28-86fb-c6859085f988@linaro.org>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 903f74d87fe4db478837255d0d41178f1201b47b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.22; envelope-from=kamil@szczek.dev;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tuesday, August 20th, 2024 at 21:48, Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org> wrote:
>=20
>=20
> Hi Kamil,
>=20
> On 20/8/24 00:51, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> > From: Kamil Szcz=C4=99k kamil@szczek.dev
> >=20
> > The code which translates vmport=3Dauto to on/off is currently separate
> > for each PC machine variant, while being functionally equivalent.
> > This moves the translation into a shared initialization function, while
> > also tightening the enum assertion.
> >=20
> > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > Reviewed-by: Bernhard Beschow shentey@gmail.com
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 philmd@linaro.org
> > Message-ID: v8pz1uwgIYWkidgZK-o8H-qJvnSyl0641XVmNO43Qls307AA3QRPuad_py6=
xGe0JAxB6yDEe76oZ8tau_n-2Y6sJBCKzCujNbEUUFhd-ahI=3D@szczek.dev
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 philmd@linaro.org
> > ---
> > hw/i386/pc.c | 5 +++++
> > hw/i386/pc_piix.c | 5 -----
> > hw/i386/pc_q35.c | 5 -----
> > 3 files changed, 5 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index c74931d577..72229a24ff 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1217,6 +1217,11 @@ void pc_basic_device_init(struct PCMachineState =
*pcms,
> > isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
> > }
> >=20
> > + assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);
>=20
>=20
> Coverity reported:
>=20
> > CID 1559533: Integer handling issues (CONSTANT_EXPRESSION_RESULT)
> > "pcms->vmport >=3D 0" is always true regardless of the values of
> > its operands. This occurs as the logical first operand of "&&".
>=20
> QAPI enums are unsigned because they start at 0, see:
> https://www.qemu.org/docs/master/devel/qapi-code-gen.html#enumeration-typ=
es
>=20
> The generated C enumeration constants have values 0, 1, =E2=80=A6, N-1
> (in QAPI schema order), where N is the number of values. There
> is an additional enumeration constant PREFIX__MAX with value N.

Oh, and here I thought I was being smart with modifying this assert :D

>=20
> Could you post a patch to address this issue?
>=20

Will do shortly. Although, I've looked around the codebase and found a few =
more instances of this pattern.

"assert\(.*>=3D *0.*__MAX" yields the following results:

job.c
> assert(s1 >=3D 0 && s1 < JOB_STATUS__MAX);
> assert(verb >=3D 0 && verb < JOB_VERB__MAX);

blkdebug.c
> assert((int)event >=3D 0 && event < BLKDBG__MAX);

pc.c
> assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);

options.c
> assert(mode >=3D 0 && mode < MIG_MODE__MAX);

savevm.c
> assert(capability >=3D 0 && capability < MIGRATION_CAPABILITY__MAX);

Does coverity also complain about those? If so, should I address all of the=
m or keep it minimal?

Also, just as a test I added a single line of code before the assert:

pcms->vmport =3D -1;

And, to my surprise, it compiled successfully without any warning and as ex=
pected, aborted on the assert:

qemu-system-x86_64: ../hw/i386/pc.c:1225: pc_basic_device_init: Assertion '=
pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX' failed.

Is this expected behavior?

> Thanks,
>=20
> Phil.
>=20
> > + if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > + pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > + }
> > +
> > /* Super I/O */
> > pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
> > pcms->vmport !=3D ON_OFF_AUTO_ON);
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index d9e69243b4..347afa4c37 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -310,11 +310,6 @@ static void pc_init1(MachineState *machine, const =
char *pci_type)
> >=20
> > pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
> >=20
> > - assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > - if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > - }
> > -
> > /* init basic PC hardware */
> > pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
> > !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 9d108b194e..f2d8edfa84 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -276,11 +276,6 @@ static void pc_q35_init(MachineState *machine)
> > x86_register_ferr_irq(x86ms->gsi[13]);
> > }
> >=20
> > - assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > - if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > - pcms->vmport =3D ON_OFF_AUTO_ON;
> > - }
> > -
> > /* init basic PC hardware */
> > pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, !mc->no_flo=
ppy,
> > 0xff0104);

