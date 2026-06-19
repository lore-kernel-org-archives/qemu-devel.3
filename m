Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72489CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWm7-0005Mc-PY; Fri, 19 Jun 2026 06:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1waWm6-0005MM-8u
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1waWm1-0001BN-6M
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781866111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVm5vVmGIbcBHr2idmmVDbtXaxhF6smWpo0QcqzwyPI=;
 b=SxjEBfZo+6P75qUUKoWdwpfqJon5Fv94BdtRcR+79AZruYfmzQNajkj7W32w/ZlgUHHPVO
 AzTdffsGY+jwF//PmfDAzwXoRINCv7vQvv4QhCtQJXH9jaj7kVVa+GNiPlh5lsJBAxF5PP
 oymenuoaiLqHZ9VORTKYVFTZ/dGWaHs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-0GV88h5fMUqMWdFxLoMSig-1; Fri, 19 Jun 2026 06:48:30 -0400
X-MC-Unique: 0GV88h5fMUqMWdFxLoMSig-1
X-Mimecast-MFC-AGG-ID: 0GV88h5fMUqMWdFxLoMSig_1781866109
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-461a5d02540so1321415f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781866109; x=1782470909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVm5vVmGIbcBHr2idmmVDbtXaxhF6smWpo0QcqzwyPI=;
 b=maYVkxlx+9O5prF5Ag6muEH7/blHE+o9LnyQi4jO1/EVr6zA3MM8JRrW1ZrwX44hYo
 X11D6K2J2oJWg1myqU/dD9ZxKEgANf2GUrrIhAq635p+nYHnJ4Z46ulmSv7N51rZ9R4B
 rmETBMDOaR9SL5HeU6IzZNNZRecjIIMPPrRgPREHISOy9akTeNIYSX3V7jiP2fHLGD/T
 Z+/bhquTeR1VD3Rxs6lkDK+VXf/nDsm3eDMTZcdqUY62/cQMvgJwC7TN9JcCsQhfVwFt
 aBCMDgVUlybm894buyzz/Xbsj9JX2911h2jInCMRhuR8RyuRqnbLBPNl3sug+Z4MV0Zn
 yScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781866109; x=1782470909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EVm5vVmGIbcBHr2idmmVDbtXaxhF6smWpo0QcqzwyPI=;
 b=OcRhWsiIglW89sec8I2zEHYzwQqsdkbsIhKA2kD2feCqqoioFSj2IUilejKn0Pdro7
 4Vids+y2X8hjRaQh9n5OTjAsQAa8+aeHr1y68Lch0ynRraphYkP75HFOjhVEbMdNzFRK
 jjrjw0Wgg6ub2MC7XDW12u9hyawkBJhuZFaVi5a4t5nf3UNmpRvUxKjmFBc6lsy6cFP2
 0PhXy3AmUlBphTzkl98dQdrBeunUVjdacuqWue2/lBSZP8JQRYCma21ZBm/PCe+zbVkK
 qXsntvquD1OEXuFN0kc3PmIaFL4COHm/BBeL5a+IoBG3KwHuzEBKybw1CbibG+AgtYCy
 nVqA==
X-Gm-Message-State: AOJu0YyT+pJtnUmb0xL0XSEv/kjGCXBDZqSvI8dnMiucoRqC0pacD+s7
 0uszfJa8y9n34BeHIQIGaM1dDKbcA1xnGWdIiy6OSmFnnq6pffwXaGdBWSwR4rlwHsmvAVHq33r
 BhBzSxEkPLlqwjHA+/6dpscsegHcB6LNfa7TBIa/45JaPHQO0uLuqRIVi
X-Gm-Gg: AfdE7cnDaS6ZYuBDoi1nsvk5uFO/mVQavKumt7waJ3GlcT7DzRf4nt2bvWLCoHp++V9
 3PQToLPConWqahh0AGy4eRuU32soIrGdy2gn+933c0zyCQDWC0varNEYDuQs9Pim2bUTMXj445I
 NCz4ChnmD50a1lrq7BAsP1epELm+ZsKdwfTzncNegClzobwKJXbGks9h/JTYvc4Z8gmWrq1GG4f
 MPh7fCE9l/SIOnqQv6obB5fY2Q71pHeTV/yBliSH97cA0JAyjouyonYS9Hkmm1fMo5CpOMad9iv
 e/yiS8IbEcT3fQFW4TPGki3Z/jRwNjNAuDldfNtSpvVU3HIMhUcoFa6/Fdehm4bscI0uQTI=
X-Received: by 2002:a05:6000:23ca:b0:460:3234:293d with SMTP id
 ffacd0b85a97d-465091bc9demr3794315f8f.40.1781866108676; 
 Fri, 19 Jun 2026 03:48:28 -0700 (PDT)
X-Received: by 2002:a05:6000:23ca:b0:460:3234:293d with SMTP id
 ffacd0b85a97d-465091bc9demr3794261f8f.40.1781866108169; 
 Fri, 19 Jun 2026 03:48:28 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a253sm7082977f8f.23.2026.06.19.03.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 03:48:27 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:48:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 11/21] arm: virt: add support for WDAT based watchdog
Message-ID: <20260619124825.420e57f8@imammedo>
In-Reply-To: <94f63b27-59b2-4f65-99dc-ec3a88780e0c@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-12-imammedo@redhat.com>
 <94f63b27-59b2-4f65-99dc-ec3a88780e0c@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 8 Jun 2026 19:07:20 +0200
Eric Auger <eauger@redhat.com> wrote:

> On 3/3/26 10:25 AM, Igor Mammedov wrote:
> > And generate WDAT table tailored for sbsa_gwdt and disable
> > watchdog entry in GTDT ACPI table if WDAT is enabled,
> > since they are mutualy exclusive due to different
> > timer resolution of sbsa_gwdt.
> >=20
> > To enable use "-device sbsa-gwdt,wdat=3Don" option
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/acpi/wdat-gwdt.h | 19 ++++++++
> >  hw/acpi/meson.build         |  2 +
> >  hw/acpi/wdat-gwdt-stub.c    | 16 +++++++
> >  hw/acpi/wdat-gwdt.c         | 92 +++++++++++++++++++++++++++++++++++++
> >  hw/arm/virt-acpi-build.c    | 58 +++++++++++++++++------
> >  5 files changed, 172 insertions(+), 15 deletions(-)
> >  create mode 100644 include/hw/acpi/wdat-gwdt.h
> >  create mode 100644 hw/acpi/wdat-gwdt-stub.c
> >  create mode 100644 hw/acpi/wdat-gwdt.c
> >=20
> > diff --git a/include/hw/acpi/wdat-gwdt.h b/include/hw/acpi/wdat-gwdt.h
> > new file mode 100644
> > index 0000000000..42339e031e
> > --- /dev/null
> > +++ b/include/hw/acpi/wdat-gwdt.h
> > @@ -0,0 +1,19 @@
> > +/*
> > + * GWDT Watchdog Action Table (WDAT) definition
> > + *
> > + * Copyright Red Hat, Inc. 2026
> > + * Author(s): Igor Mammedov <imammedo@redhat.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#ifndef QEMU_HW_ACPI_WDAT_GWDT_H
> > +#define QEMU_HW_ACPI_WDAT_GWDT_H
> > +
> > +#include "hw/acpi/aml-build.h"
> > +#include "hw/watchdog/sbsa_gwdt.h"
> > +
> > +void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const cha=
r *oem_id,
> > +                     const char *oem_table_id, uint64_t rbase, uint64_=
t cbase,
> > +                     uint64_t freq);
> > +
> > +#endif /* QEMU_HW_ACPI_WDAT_GWDT_H */
> > diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> > index 22290ca835..189bbb0257 100644
> > --- a/hw/acpi/meson.build
> > +++ b/hw/acpi/meson.build
> > @@ -28,12 +28,14 @@ acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: file=
s('ich9.c', 'ich9_tco.c', 'ic
> >  acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
> >  acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: f=
iles('ipmi-stub.c'))
> >  acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
> > +acpi_ss.add(when: 'CONFIG_WDT_SBSA', if_true: files('wdat-gwdt.c'))
> >  if have_tpm
> >    acpi_ss.add(files('tpm.c'))
> >  endif
> >  system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml=
-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
> >  system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bri=
dge-stub.c'))
> >  system_ss.add(when: 'CONFIG_ACPI_ICH9', if_false: files('wdat-ich9-stu=
b.c'))
> > +system_ss.add(when: 'CONFIG_WDT_SBSA', if_false: files('wdat-gwdt-stub=
.c'))
> >  system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
> >  system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
> >  system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stu=
b.c'))
> > diff --git a/hw/acpi/wdat-gwdt-stub.c b/hw/acpi/wdat-gwdt-stub.c
> > new file mode 100644
> > index 0000000000..4d43783f70
> > --- /dev/null
> > +++ b/hw/acpi/wdat-gwdt-stub.c
> > @@ -0,0 +1,16 @@
> > +/*
> > + * Copyright Red Hat, Inc. 2026
> > + * Author(s): Igor Mammedov <imammedo@redhat.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/acpi/wdat-gwdt.h"
> > +
> > +void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const cha=
r *oem_id,
> > +                     const char *oem_table_id, uint64_t rbase, uint64_=
t cbase,
> > +                     uint64_t freq)
> > +{
> > +    g_assert_not_reached();
> > +}
> > diff --git a/hw/acpi/wdat-gwdt.c b/hw/acpi/wdat-gwdt.c
> > new file mode 100644
> > index 0000000000..226ba3f01e
> > --- /dev/null
> > +++ b/hw/acpi/wdat-gwdt.c
> > @@ -0,0 +1,92 @@
> > +/*
> > + * SBSA GWDT Watchdog Action Table (WDAT)
> > + *
> > + * Copyright Red Hat, Inc. 2026
> > + * Author(s): Igor Mammedov <imammedo@redhat.com>
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/acpi/aml-build.h"
> > +#include "hw/acpi/wdat-gwdt.h"
> > +#include "hw/acpi/wdat.h"
> > +#include "hw/watchdog/sbsa_gwdt.h"
> > +
> > +#define GWDT_REG(base, reg_offset, reg_width) { \
> > +                 .space_id =3D AML_AS_SYSTEM_MEMORY, \
> > +                 .address =3D base + reg_offset, .bit_width =3D reg_wi=
dth, \
> > +                 .access_width =3D AML_DWORD_ACC };
> > +
> > +/*
> > + *   "Hardware Watchdog Timers Design=C2=A0Specification"
> > + *       https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> > + */
> > +void build_gwdt_wdat(GArray *table_data, BIOSLinker *linker, const cha=
r *oem_id,
> > +                     const char *oem_table_id, uint64_t rbase, uint64_=
t cbase,
> > +                     uint64_t freq)
> > +{
> > +    AcpiTable table =3D { .sig =3D "WDAT", .rev =3D 1, .oem_id =3D oem=
_id,
> > +                        .oem_table_id =3D oem_table_id };
> > +
> > +    struct AcpiGenericAddress wrr =3D  GWDT_REG(rbase, 0x0, 32);
> > +    struct AcpiGenericAddress wor_l =3D  GWDT_REG(cbase, SBSA_GWDT_WOR=
, 32);
> > +    struct AcpiGenericAddress wcs =3D  GWDT_REG(cbase, SBSA_GWDT_WCS, =
32);
> > +
> > +    acpi_table_begin(&table, table_data);
> > +    build_append_int_noprefix(table_data, 0x20, 4); /* Watchdog Header=
 Length */ =20
> you can add a comment that 0xff must be set for following 3 fields as
> not a PCI device.
> > +    build_append_int_noprefix(table_data, 0xff, 2); /* PCI Segment */
> > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Bus Number =
*/
> > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Device Numb=
er */
> > +    build_append_int_noprefix(table_data, 0xff, 1); /* PCI Function Nu=
mber */
> > +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> > +    /*
> > +     * WDAT spec suports only 1KHz or more coarse watchdog timer,
> > +     * Set resolution to minimum supported 1ms.
> > +     * Before starting watchdog Windows set countdown value to 5min.
> > +     */
> > +    g_assert(freq <=3D 1000);
> > +    build_append_int_noprefix(table_data, 1, 4);/* Timer Period, ms */=
 =20
> it is a bit weird to hardcode the freq while it is passed as parameter.
> Why don't you propagate it in the table?
> > +    /*
> > +     * Needs to be more than 4min, otherwise Windows 11 won't start wa=
tchdog. =20
> spec says:
> "
> The time-out period before the WDT fires is recommended to be at least 5
> minutes and is required to be less than 4,294,967,296 count intervals.
> "
> where does the 4 min come from?

it documents (empirical) lower Windows limit vs recommended one,
so later on someone wouldn't step on that same rake.

> > +     * Set max to limits to arbitrary max 10min and min to 5sec.
> > +     */
> > +    build_append_int_noprefix(table_data, 600 * freq, 4);/* Maximum Co=
unt */ =20
> spec says this is in count interval and not in ms, no?

yep, and that's what it is here (or maybe I misread question)

> > +    build_append_int_noprefix(table_data, 5 * freq, 4);  /* Minimum Co=
unt */ =20
> same
> > +    /*
> > +     * WATCHDOG_ENABLED =20
> and stopped in sleep state?
> > +     */
> > +    build_append_int_noprefix(table_data, 0x81, 1); /* Watchdog Flags =
*/
> > +    build_append_int_noprefix(table_data, 0, 3);    /* Reserved */
> > +    /*
> > +     * watchdog instruction entries
> > +     */
> > +    build_append_int_noprefix(table_data, 8, 4);
> > +    /* Action table */
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_RUNNING_STATE,
> > +        WDAT_INS_READ_VALUE,
> > +        wcs, 0x1, 0x1);
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_RESET,
> > +        WDAT_INS_WRITE_VALUE,
> > +        wrr, 0x1, 0x7); =20
> why 0x7? where did you get that mask value from
>=20
> in DEN0094E_BSA_1.2.pdf
>=20
> "0x000-0x003 WRR Watchdog refresh register. A write to this location
> causes the watchdog to refresh and start a new
> watch period. A read has no effect and returns 0."
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_COUNTDOWN_PERIOD,
> > +        WDAT_INS_WRITE_COUNTDOWN,
> > +        wor_l, 0, 0xffffffff); =20
> How does the above intrustuction work? How the countdown period is
> passed? what does the 0 mean in that case?

the countdown period comes from the OS at runtime, not from the WDAT table,
the value here is ignored.


>=20
> I would rather group instructions on wcs and then instructions using wor
> or wrr
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_RUNNING_STATE,
> > +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> > +        wcs, 1, 0x00000001);
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_STOPPED_STATE,
> > +        WDAT_INS_READ_VALUE,
> > +        wcs, 0x0, 0x00000001);
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_STOPPED_STATE,
> > +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> > +        wcs, 0x0, 0x00000001);
> > +    build_append_wdat_ins(table_data, WDAT_ACTION_QUERY_WATCHDOG_STATU=
S,
> > +        WDAT_INS_READ_VALUE,
> > +        wcs, 0x4, 0x00000004); =20
> reflects the status of WS1 only (and not WS0). Can you explain why this
> is what we want?
spec says:

  "Determines if the current boot was caused by the watchdog firing.
  The boot status is required to be set if the watchdog fired and caused a =
reboot."

WS1 is the event we are after, WS0 is not that by any means.

> > +    build_append_wdat_ins(table_data, WDAT_ACTION_SET_WATCHDOG_STATUS,
> > +        WDAT_INS_WRITE_VALUE | WDAT_INS_PRESERVE_REGISTER,
> > +        wrr, 0x4, 0x4); =20
>=20
> > +
> > +    acpi_table_end(linker, &table);
> > +}
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 9c14b1d4d5..e9670b1a2b 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -65,6 +65,7 @@
> >  #include "target/arm/cpu.h"
> >  #include "target/arm/multiprocessing.h"
> >  #include "hw/watchdog/sbsa_gwdt.h"
> > +#include "hw/acpi/wdat-gwdt.h"
> > =20
> >  #define ARM_SPI_BASE 32
> > =20
> > @@ -849,12 +850,25 @@ build_srat(GArray *table_data, BIOSLinker *linker=
, VirtMachineState *vms)
> >      acpi_table_end(linker, &table);
> >  }
> > =20
> > +static void virt_get_wdt_options(VirtMachineState *vms, Object *wdt,
> > +                                 hwaddr *rbase, hwaddr *cbase, int *ir=
q)
> > +{
> > +    PlatformBusDevice *pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_=
dev);
> > +    SysBusDevice *sd =3D SYS_BUS_DEVICE(wdt);
> > +    hwaddr mmio_base =3D vms->memmap[VIRT_PLATFORM_BUS].base;
> > +    *rbase =3D mmio_base + platform_bus_get_mmio_addr(pbus, sd, 0);
> > +    *cbase =3D mmio_base + platform_bus_get_mmio_addr(pbus, sd, 1);
> > +    *irq =3D ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> > +           platform_bus_get_irqn(pbus, sd, 0);
> > +}
> > +
> >  /*
> >   * ACPI spec, Revision 6.5
> >   * 5.2.25 Generic Timer Description Table (GTDT)
> >   */
> >  static void
> > -build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *v=
ms)
> > +build_gtdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *v=
ms,
> > +           Object *wdt, bool add_watchdog)
> >  {
> >      /*
> >       * Table 5-117 Flag Definitions
> > @@ -865,7 +879,6 @@ build_gtdt(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
> >      AcpiTable table =3D { .sig =3D "GTDT", .rev =3D 3, .oem_id =3D vms=
->oem_id,
> >                          .oem_table_id =3D vms->oem_table_id };
> >      uint32_t gtdt_start =3D table_data->len;
> > -    Object *wdt =3D object_resolve_type_unambiguous(TYPE_WDT_SBSA, NUL=
L);
> > =20
> >      acpi_table_begin(&table, table_data);
> > =20
> > @@ -898,12 +911,12 @@ build_gtdt(GArray *table_data, BIOSLinker *linker=
, VirtMachineState *vms)
> >      build_append_int_noprefix(table_data, 0xFFFFFFFFFFFFFFFF, 8);
> > =20
> >      /* Platform Timer Count */
> > -    build_append_int_noprefix(table_data,  wdt ? 1 : 0, 4);
> > +    build_append_int_noprefix(table_data,  add_watchdog ? 1 : 0, 4);
> >      /* Platform Timer Offset */
> >      build_append_int_noprefix(table_data,
> > -        wdt ? (table_data->len - gtdt_start) +
> > -              4 + 4 + 4 /* len of this & following 2 fields to skip */
> > -            : 0, 4);
> > +        add_watchdog ? (table_data->len - gtdt_start) + =20
> this patch is big. You could easily move the add_wathdog +
> virt_get_wdt_options() helper in a different patch

I'll split off acpi part (wdat table itself) into as a preceding patch
(albeit without  immediate user ) and remainder in the second patch
would use it.
Should make it easier to follow.

> > +                       4 + 4 + 4 /* len of this & following 2 fields t=
o skip */
> > +                     : 0, 4);
> > =20
> >      if (vms->ns_el2_virt_timer_irq) {
> >          /* Virtual EL2 Timer GSIV */
> > @@ -916,14 +929,10 @@ build_gtdt(GArray *table_data, BIOSLinker *linker=
, VirtMachineState *vms)
> >      }
> > =20
> >      /* ACPI 6.5 spec: 5.2.25.2 ARM Generic Watchdog Structure (Table 5=
-124) */
> > -    if (wdt) {
> > -        PlatformBusDevice *pbus =3D PLATFORM_BUS_DEVICE(vms->platform_=
bus_dev);
> > -        SysBusDevice *sd =3D SYS_BUS_DEVICE(wdt);
> > -        hwaddr mmio_base =3D vms->memmap[VIRT_PLATFORM_BUS].base;
> > -        hwaddr rbase =3D mmio_base + platform_bus_get_mmio_addr(pbus, =
sd, 0);
> > -        hwaddr cbase =3D mmio_base + platform_bus_get_mmio_addr(pbus, =
sd, 1);
> > -        int irq =3D ARM_SPI_BASE + vms->irqmap[VIRT_PLATFORM_BUS] +
> > -                  platform_bus_get_irqn(pbus, sd, 0);
> > +    if (add_watchdog) {
> > +        int irq;
> > +        hwaddr rbase, cbase;
> > +        virt_get_wdt_options(vms, wdt, &rbase, &cbase, &irq);
> > =20
> >          build_append_int_noprefix(table_data, 1 /* Type: Watchdog GT *=
/, 1);
> >          build_append_int_noprefix(table_data, 28 /* Length */, 2);
> > @@ -1282,8 +1291,14 @@ void virt_acpi_build(VirtMachineState *vms, Acpi=
BuildTables *tables)
> >      VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> >      GArray *table_offsets;
> >      unsigned dsdt, xsdt;
> > +    bool has_wdat =3D false;
> >      GArray *tables_blob =3D tables->table_data;
> >      MachineState *ms =3D MACHINE(vms);
> > +    Object *wdt =3D object_resolve_type_unambiguous(TYPE_WDT_SBSA, NUL=
L);
> > +
> > +    if (wdt) {
> > +        has_wdat =3D object_property_get_bool(wdt, "wdat", &error_abor=
t);
> > +    }
> > =20
> >      table_offsets =3D g_array_new(false, true /* clear */,
> >                                          sizeof(uint32_t));
> > @@ -1303,6 +1318,19 @@ void virt_acpi_build(VirtMachineState *vms, Acpi=
BuildTables *tables)
> >      acpi_add_table(table_offsets, tables_blob);
> >      build_madt(tables_blob, tables->linker, vms);
> > =20
> > +    acpi_add_table(table_offsets, tables_blob);
> > +    if (wdt && has_wdat) {
> > +        int irq;
> > +        hwaddr rbase, cbase;
> > +        uint64_t freq =3D object_property_get_uint(wdt, "clock-frequen=
cy",
> > +                                                 &error_abort);
> > +        virt_get_wdt_options(vms, wdt, &rbase, &cbase, &irq);
> > +
> > +        build_gwdt_wdat(tables_blob, tables->linker,
> > +                        vms->oem_id, vms->oem_table_id,
> > +                        rbase, cbase, freq);
> > +    }
> > +
> >      if (!vmc->no_cpu_topology) {
> >          acpi_add_table(table_offsets, tables_blob);
> >          build_pptt(tables_blob, tables->linker, ms,
> > @@ -1310,7 +1338,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiB=
uildTables *tables)
> >      }
> > =20
> >      acpi_add_table(table_offsets, tables_blob);
> > -    build_gtdt(tables_blob, tables->linker, vms);
> > +    build_gtdt(tables_blob, tables->linker, vms, wdt, wdt && !has_wdat=
);
> > =20
> >      acpi_add_table(table_offsets, tables_blob);
> >      { =20
> Thanks
>=20
> Eric
>=20


