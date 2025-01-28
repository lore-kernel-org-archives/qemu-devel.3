Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85AFC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjnC-0008Hm-7Z; Tue, 28 Jan 2025 06:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tcjn9-0008FH-Gy; Tue, 28 Jan 2025 06:30:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tcjn7-0008Jj-C5; Tue, 28 Jan 2025 06:30:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 87DF75C5B2D;
 Tue, 28 Jan 2025 11:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C942C4CED3;
 Tue, 28 Jan 2025 11:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738063797;
 bh=HtBGi7YGzaS/LF0lwzhNy8DAMFo2XB5Zw5gl+KQ8Q8s=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ulelSqIgHDdWFTk/bLAHEPBurJE6kNBiCTdV/TGX1fHYUFOB1/k5v3JYoGIuibSEo
 4XmPYi/Q58xn9tBoqVvSLjivDrxnwR5lG2qFzlBZ2O13tCLToykB490ubJ/sUWKUk/
 AIXHZR/VfXC4bIpgo1RtLtKw3uhbw0wweScYOhWRhq34+6naq20dm6P5kwX2TqWao/
 o9F512xrHUOFQuH03zhbNVLi2tTX5kxH9jfLEJueT/Rd6Lp69rtof7kk6mYh2udLo8
 GP81GkMhJK7iSZLQ7t8iwF0JMwe4ufpbjt5OvEFv7WBP3RM7BNW54cFs03kBzGRTxu
 MdhhfmOgwdXMw==
Date: Tue, 28 Jan 2025 12:29:51 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] acpi/generic_event_device: add logic to detect if
 HEST addr is available
Message-ID: <20250128122951.6bd52b89@foz.lan>
In-Reply-To: <20250124112346.4751ccf2@imammedo.users.ipa.redhat.com>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <556c19c1f3fa907c6cc13b62e060f6baa6faf2cf.1737560101.git.mchehab+huawei@kernel.org>
 <20250124112346.4751ccf2@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Em Fri, 24 Jan 2025 11:23:46 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 22 Jan 2025 16:46:22 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > Create a new property (x-has-hest-addr) and use it to detect if
> > the GHES table offsets can be calculated from the HEST address
> > (qemu 9.2 and upper) or via the legacy way via an offset obtained =20
>=20
> 10.0 by now
>=20
> > from the hardware_errors firmware file.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/generic_event_device.c |  1 +
> >  hw/acpi/ghes.c                 | 28 +++++++++++++++++++++-------
> >  hw/arm/virt-acpi-build.c       | 30 ++++++++++++++++++++++++++----
> >  hw/core/machine.c              |  2 ++
> >  include/hw/acpi/ghes.h         |  1 +
> >  5 files changed, 51 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_dev=
ice.c
> > index 5346cae573b7..fe537ed05c66 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev,=
 AcpiEventStatusBits ev)
> > =20
> >  static const Property acpi_ged_properties[] =3D {
> >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_=
lookup, true), =20
>=20
> s/hest_lookup/use_hest_addr/
>=20
> >  };
> > =20
> >  static const VMStateDescription vmstate_memhp_state =3D {
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index b46b563bcaf8..86c97f60d6a0 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -359,6 +359,8 @@ void acpi_build_hest(GArray *table_data, GArray *ha=
rdware_errors,
> >  {
> >      AcpiTable table =3D { .sig =3D "HEST", .rev =3D 1,
> >                          .oem_id =3D oem_id, .oem_table_id =3D oem_tabl=
e_id };
> > +    AcpiGedState *acpi_ged_state;
> > +    AcpiGhesState *ags =3D NULL;
> >      int i;
> > =20
> >      build_ghes_error_table(hardware_errors, linker, num_sources);
> > @@ -379,10 +381,20 @@ void acpi_build_hest(GArray *table_data, GArray *=
hardware_errors,
> >       * tell firmware to write into GPA the address of HEST via fw_cfg,
> >       * once initialized.
> >       */
> > -    bios_linker_loader_write_pointer(linker,
> > -                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> > -                                     sizeof(uint64_t),
> > -                                     ACPI_BUILD_TABLE_FILE, hest_offse=
t);
> > +
> > +    acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TYPE_ACPI=
_GED,
> > +                                                       NULL)); =20
>=20
> the caller, already did lookup,
> just pass hest_lookup as an argument and use it here

for all the above: OK.

> > +    if (!acpi_ged_state) {
> > +        return;
> > +    }
> > +
> > +    ags =3D &acpi_ged_state->ghes_state;
> > +    if (ags->hest_lookup) {
> > +        bios_linker_loader_write_pointer(linker,
> > +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> > +                                         sizeof(uint64_t),
> > +                                         ACPI_BUILD_TABLE_FILE, hest_o=
ffset);
> > +    }
> >  }
> > =20
> >  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > @@ -396,8 +408,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCf=
gState *s,
> >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, =
NULL,
> >          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false); =
=20
>=20
> btw shouldn't we disable hw_error_le if hest_lookup is active?

Despite not being used, we still need the fw_cfg logic to recalculate the=20
table offsets, solving the bios_linker stuff.

At the tests I did, not having a callback causes some fw_cfg issue when QEMU
tries to load the firmware or tries to update it.

> > =20
> > -    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> > -        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> > +    if (ags && ags->hest_lookup) { =20
>=20
> why bother with 'ags &&' if we don't do it hw_error_le?

Legacy stuff. I'll drop "ags &&".

>=20
>=20
> > +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, =
NULL,
> > +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), fal=
se);
> > +    }
> > =20
> >      ags->present =3D true;
> >  }
> > @@ -512,7 +526,7 @@ void ghes_record_cper_errors(const void *cper, size=
_t len,
> >      }
> >      ags =3D &acpi_ged_state->ghes_state;
> > =20
> > -    if (!ags->hest_addr_le) {
> > +    if (!ags->hest_lookup) { =20
> why? !ags->hest_addr_le is sufficient

Either checking for "hest_addr_le" or for "use_hest_addr" would
equally work, assuming that address =3D=3D 0 is invalid. I opted to use
the latest one because you requested on a previous review, and also
because it makes clearer that this comes from the migration logic,
which dictates what kind of lookup should be done.

=46rom my side, either way works fine. What do you prefer?

>=20
> >          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> >                               &cper_addr, &read_ack_register_addr);
> >      } else {
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 3d411787fc37..ada5d08cfbe7 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -897,6 +897,10 @@ static const AcpiNotificationSourceId hest_ghes_no=
tify[] =3D {
> >      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> >  };
> > =20
> > +static const AcpiNotificationSourceId hest_ghes_notify_9_2[] =3D {
> > +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> > +};
> > +
> >  static
> >  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >  {
> > @@ -950,10 +954,28 @@ void virt_acpi_build(VirtMachineState *vms, AcpiB=
uildTables *tables)
> >      build_dbg2(tables_blob, tables->linker, vms);
> > =20
> >      if (vms->ras) {
> > -        acpi_add_table(table_offsets, tables_blob);
> > -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->=
linker,
> > -                        hest_ghes_notify, ARRAY_SIZE(hest_ghes_notify),
> > -                        vms->oem_id, vms->oem_table_id);
> > +        AcpiGhesState *ags;
> > +        AcpiGedState *acpi_ged_state;
> > +
> > +        acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TYPE_=
ACPI_GED,
> > +                                                       NULL));
> > +        if (acpi_ged_state) {
> > +            ags =3D &acpi_ged_state->ghes_state;
> > +
> > +            acpi_add_table(table_offsets, tables_blob);
> > +
> > +            if (!ags->hest_lookup) {
> > +                acpi_build_hest(tables_blob, tables->hardware_errors,
> > +                                tables->linker, hest_ghes_notify_9_2,
> > +                                ARRAY_SIZE(hest_ghes_notify_9_2),
> > +                                vms->oem_id, vms->oem_table_id);
> > +            } else {
> > +                acpi_build_hest(tables_blob, tables->hardware_errors,
> > +                                tables->linker, hest_ghes_notify,
> > +                                ARRAY_SIZE(hest_ghes_notify),
> > +                                vms->oem_id, vms->oem_table_id);
> > +            }
> > +        }
> >      }
> > =20
> >      if (ms->numa_state->num_nodes > 0) {
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index c23b39949649..0d0cde481954 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -34,10 +34,12 @@
> >  #include "hw/virtio/virtio-pci.h"
> >  #include "hw/virtio/virtio-net.h"
> >  #include "hw/virtio/virtio-iommu.h"
> > +#include "hw/acpi/generic_event_device.h"
> >  #include "audio/audio.h"
> > =20
> >  GlobalProperty hw_compat_9_2[] =3D {
> >      {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
> > +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> >  };
> >  const size_t hw_compat_9_2_len =3D G_N_ELEMENTS(hw_compat_9_2);
> > =20
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 237721fec0a2..164ed8b0f9a3 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
> >      uint64_t hest_addr_le;
> >      uint64_t hw_error_le;
> >      bool present; /* True if GHES is present at all on this board */ =
=20
>                         and perhaps reformulate this as well
>=20
> > +    bool hest_lookup; /* True if HEST address is present */ =20
>                                  if device should use HEST addr for error=
 source lookup=20
>=20
> >  } AcpiGhesState;
> > =20
> >  /* =20
>=20



Thanks,
Mauro

