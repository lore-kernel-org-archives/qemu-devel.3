Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CBEC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtUB-0006V6-MK; Thu, 11 Jul 2024 09:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtU9-0006NS-Uc
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtU7-0000ml-Rq
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720703117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2hv7wVB+poKjf0VlnbHz9P8tGP4VwBm/7gzQwhPtoU=;
 b=OWCJYmiCpY+V+0ZY/WBpMcdcIoUTbH+CXMe9ikl3ULn3i4Mk3O7zYN7YFjGqKiUuqGTSlK
 6iKhKl4Ufp+A4lSW596mHi1utme4rsq972hBiF4PC19H0pDTbeKIsgQAMrCeZK1uac2hC8
 TdiE8h4GoBRKLfsuvEEOE4xvs2fy4q8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-l5SgN2hxOReNrQHtE1SpTg-1; Thu, 11 Jul 2024 09:05:15 -0400
X-MC-Unique: l5SgN2hxOReNrQHtE1SpTg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367879e8395so446441f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703114; x=1721307914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2hv7wVB+poKjf0VlnbHz9P8tGP4VwBm/7gzQwhPtoU=;
 b=WqIXbL4VA25a7Yp4EOLoAS//4/3USDm2Tab1pe/VHs0D0dZPKqA00ROmkQQZZmJTJ4
 gmmDl9Cm+ODKJzcKb+23HoLJcIZCMO6VaIEITObR7W8+CH6KyuwPkfa6i0yHZi5e6q2s
 4TFS7RQLoOPyt7eIMfvwRHZVNoDGmkprlwHaiZd8Eh1r8jNwqxNiPbyPdfFOXzrswNLn
 QsMr7DX3BFikPojnJLHT8MjteJIg+hUZnye1HavwMHLliFVaBUkQnc/jG7CaWF5hBJvJ
 FrgGHQLS0un/KE0mTCOMvnt9JQPPZ4JIrV8pkLh2psyqjJ5sum7kj/9zW5NbKcRFdo0b
 zWVA==
X-Gm-Message-State: AOJu0Yz8ITEkQlya8kYiYIOq03BOqwP/OBwwdPNG/A2we0Xu65OPnmjF
 hEugcZ1qFLg6WFQZMkyRLxmWNhrgtVDV3U0EesEqBI4c8OlslZub82jd6gPbS5+VNp4whVwxwdV
 o1L5YFvpJi5OmN0kGi5ukGlEtjNoQSaEPIL1o/05gVqOvuvX9p6di
X-Received: by 2002:a5d:438f:0:b0:367:9765:b2ae with SMTP id
 ffacd0b85a97d-367ceadb47bmr5562387f8f.61.1720703114477; 
 Thu, 11 Jul 2024 06:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEArITGXVyaB9U617ti1IWv3IbybmfL+sLUEQzVCfzNj13QVgELRDcDz7RjH0GuZToCflFQYA==
X-Received: by 2002:a5d:438f:0:b0:367:9765:b2ae with SMTP id
 ffacd0b85a97d-367ceadb47bmr5562373f8f.61.1720703114091; 
 Thu, 11 Jul 2024 06:05:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab6d3sm7610151f8f.112.2024.07.11.06.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:05:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:05:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 wangyanan55@huawei.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 anisinha@redhat.com, qemu-arm@nongnu.org
Subject: Re: [PATCH] smbios: make memory device size configurable per Machine
Message-ID: <20240711150511.3a8f9013@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240711071054-mutt-send-email-mst@kernel.org>
References: <20240711074822.3384344-1-imammedo@redhat.com>
 <20240711071054-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 11 Jul 2024 07:13:27 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jul 11, 2024 at 09:48:22AM +0200, Igor Mammedov wrote:
> > Currently SMBIOS maximum memory device chunk is capped at 16Gb,
> > which is fine for the most cases (QEMU uses it to describe initial
> > RAM (type 17 SMBIOS table entries)).
> > However when starting guest with terabytes of RAM this leads to
> > too many memory device structures, which eventually upsets linux
> > kernel as it reserves only 64K for these entries and when that
> > border is crossed out it runs out of reserved memory.
> >=20
> > Instead of partitioning initial RAM on 16Gb chunks, use maximum
> > possible chunk size that SMBIOS spec allows[1]. Which lets
> > encode RAM in Mb units in uint32_t-1 field (upto 2047Tb).
> > As result initial RAM will generate only one type 17 structure
> > until host/guest reach ability to use more RAM in the future.
> >=20
> > Compat changes:
> > We can't unconditionally change chunk size as it will break
> > QEMU<->guest ABI (and migration). Thus introduce a new machine class
> > field that would let older versioned machines to use 16Gb chunks
> > while new machine type could use maximum possible chunk size.
> >=20
> > While it might seem to be risky to rise max entry size this much
> > (much beyond of what current physical RAM modules support),
> > I'd not expect it causing much issues, modulo uncovering bugs
> > in software running within guest. And those should be fixed
> > on guest side to handle SMBIOS spec properly, especially if
> > guest is expected to support so huge RAM configs.
> > In worst case, QEMU can reduce chunk size later if we would
> > care enough about introducing a workaround for some 'unfixable'
> > guest OS, either by fixing up the next machine type or
> > giving users a CLI option to customize it.
> >=20
> > 1) SMBIOS 3.1.0 7.18.5 Memory Device =E2=80=94 Extended Size
> >=20
> > PS:
> > * tested on 8Tb host with RHEL6 guest, which seems to parse
> >   type 17 SMBIOS table entries correctly (according to 'dmidecode').
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/boards.h |  4 ++++
> >  hw/arm/virt.c       |  1 +
> >  hw/core/machine.c   |  1 +
> >  hw/i386/pc_piix.c   |  1 +
> >  hw/i386/pc_q35.c    |  1 +
> >  hw/smbios/smbios.c  | 11 ++++++-----
> >  6 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index ef6f18f2c1..48ff6d8b93 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -237,6 +237,9 @@ typedef struct {
> >   *    purposes only.
> >   *    Applies only to default memory backend, i.e., explicit memory ba=
ckend
> >   *    wasn't used.
> > + * @smbios_memory_device_size:
> > + *    Default size of memory device,
> > + *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)" =20
>=20
> Maybe it would be better to just make this a boolean,
> and put the spec related logic in smbios.c ?
> WDYT?

Using bool here, seems awkward to me,
i.e. not clear semantics and compat handling would be
complicated as well.

And if we have to expose it someday to users,
it would be logical to make it machine property.
Given it's used not only by x86, having it as value
here lets each machine to customize if necessary
using well established pattern (incl. compat machinery)


> >   */
> >  struct MachineClass {
> >      /*< private >*/
> > @@ -304,6 +307,7 @@ struct MachineClass {
> >      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machin=
e);
> >      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx=
);
> >      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
> > +    uint64_t smbios_memory_device_size;
> >  };
> > =20
> >  /**
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index b0c68d66a3..719e83e6a1 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -3308,6 +3308,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
> >  static void virt_machine_9_0_options(MachineClass *mc)
> >  {
> >      virt_machine_9_1_options(mc);
> > +    mc->smbios_memory_device_size =3D 16 * GiB;
> >      compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_le=
n);
> >  }
> >  DEFINE_VIRT_MACHINE(9, 0)
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index bc38cad7f2..3cfdaec65d 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1004,6 +1004,7 @@ static void machine_class_init(ObjectClass *oc, v=
oid *data)
> >      /* Default 128 MB as guest ram size */
> >      mc->default_ram_size =3D 128 * MiB;
> >      mc->rom_file_has_mr =3D true;
> > +    mc->smbios_memory_device_size =3D 2047 * TiB;
> > =20
> >      /* numa node memory size aligned on 8MB by default.
> >       * On Linux, each node's border has to be 8MB aligned =20
>=20
>=20
>=20
> All these values really should be documented.
It's in commit message, but right I'll document value here
on respin so it would be easier for reader to see where it
comes from.

> And I feel=20
???

>=20
>=20
>=20
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 9445b07b4f..d9e69243b4 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -495,6 +495,7 @@ static void pc_i440fx_machine_9_0_options(MachineCl=
ass *m)
> >      pc_i440fx_machine_9_1_options(m);
> >      m->alias =3D NULL;
> >      m->is_default =3D false;
> > +    m->smbios_memory_device_size =3D 16 * GiB;
> > =20
> >      compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len=
);
> >      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len=
);
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 71d3c6d122..9d108b194e 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -374,6 +374,7 @@ static void pc_q35_machine_9_0_options(MachineClass=
 *m)
> >      PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pc_q35_machine_9_1_options(m);
> >      m->alias =3D NULL;
> > +    m->smbios_memory_device_size =3D 16 * GiB;
> >      compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len=
);
> >      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len=
);
> >      pcmc->isa_bios_alias =3D false;
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index 3b7703489d..a394514264 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -1093,6 +1093,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
> >                         Error **errp)
> >  {
> >      unsigned i, dimm_cnt, offset;
> > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> >      ERRP_GUARD();
> > =20
> >      assert(ep_type =3D=3D SMBIOS_ENTRY_POINT_TYPE_32 ||
> > @@ -1123,12 +1124,12 @@ static bool smbios_get_tables_ep(MachineState *=
ms,
> >      smbios_build_type_9_table(errp);
> >      smbios_build_type_11_table();
> > =20
> > -#define MAX_DIMM_SZ (16 * GiB)
> > -#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
> > -                                        : ((current_machine->ram_size =
- 1) % MAX_DIMM_SZ) + 1)
> > +#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? mc->smbios_memory_device_siz=
e \
> > +    : ((current_machine->ram_size - 1) % mc->smbios_memory_device_size=
) + 1)
> > =20
> > -    dimm_cnt =3D QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ)=
 /
> > -               MAX_DIMM_SZ;
> > +    dimm_cnt =3D QEMU_ALIGN_UP(current_machine->ram_size,
> > +                             mc->smbios_memory_device_size) /
> > +               mc->smbios_memory_device_size;
> > =20
> >      /*
> >       * The offset determines if we need to keep additional space betwe=
en
> > --=20
> > 2.43.0 =20
>=20


