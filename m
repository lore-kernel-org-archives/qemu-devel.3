Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710D2D29FB8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 09:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8buO-0004dJ-J2; Wed, 06 Nov 2024 04:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8buL-0004d8-L9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t8buI-0004HF-E2
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 04:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730883653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vh6P05MAOk8NavkMBAIVrsLjBrcddPO1rpJR4sRaYBc=;
 b=aMXc1vjkRFd0d6Xme8PXnwtRkO4RzkQwtyYffx9/NxRG2uwpS9wJhdQpiWfBAQ4DI5wh4U
 FyRAH6nSf6rjoawe9IG1CvZYb+SpMLi0o1WNJV1oVcheSJhJaspxIavR0TlPM6L5ZNVNYI
 u0tDRqdwi+4Vundv/wHk0gdeHKW5LoA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-aZQl1DDnMky3JBN1gv0LBw-1; Wed, 06 Nov 2024 04:00:50 -0500
X-MC-Unique: aZQl1DDnMky3JBN1gv0LBw-1
X-Mimecast-MFC-AGG-ID: aZQl1DDnMky3JBN1gv0LBw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4327bd6bd60so42367665e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 01:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730883649; x=1731488449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vh6P05MAOk8NavkMBAIVrsLjBrcddPO1rpJR4sRaYBc=;
 b=qyZ5488NrVDDsNiB3bairFJOvis8J+WST30kRttfGFLFjEME9NjFZDWL1dh2prTwye
 YVJr6oL7hy9wuDIbLXKNaSDngPekHbpmMVyW2HFqMV0OGxcEmmhltwWN8jmfss20ccYU
 Gh3CQU5cjGZqyXh19YblvKR/0CYmviLdB/LluMFqM9yhgY2yOpuTd4H0gb255irdzoP5
 RrJps2VSgE06wLaQ8yxUknTC1fESHxjRm21Umc0sAYhpaUPA5r9QSdyXy+j5JY2Z88Zb
 035ZGCY03jcGhcb1iOPD1yYR4H1/2feSdiBqcOFDlmdynz4bp5YaWsmNCJRfv+m+tlyU
 upHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhD4XufGiMbEjXVVGDJRAXexyWs6tOGHnU/dpG7yuk9e3H6C01gjLwdJV1M7FqyVlj03Iw/PUqDUm5@nongnu.org
X-Gm-Message-State: AOJu0YyqTbmdUsbHUWPXNCYqH8P0kn+M7xHUsCNvRyrCN5cOdR76BV9p
 YEeFp39acwulsR+lK9H6grjYmN1ZvzKmBIKP6J9GYyyyzxyGF3Ik4UFDnI5/P8ZxebCSOhXgadN
 //p0qcM9iJsAcPpOpJfqZmFao13JhjAjzOF0DK+DwUde24L5WWSG1
X-Received: by 2002:a05:600c:a085:b0:431:5187:28ef with SMTP id
 5b1f17b1804b1-4319ad2f3b4mr319525485e9.33.1730883649169; 
 Wed, 06 Nov 2024 01:00:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRgIcLa/xl1mdlUtlQuTosV8NsYhVjkqTQqD0y3oNrBKTdO0o9P+S+JHP5SFIU8wJc/1rB+Q==
X-Received: by 2002:a05:600c:a085:b0:431:5187:28ef with SMTP id
 5b1f17b1804b1-4319ad2f3b4mr319525145e9.33.1730883648706; 
 Wed, 06 Nov 2024 01:00:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6da939sm14736085e9.31.2024.11.06.01.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 01:00:48 -0800 (PST)
Date: Wed, 6 Nov 2024 10:00:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Ani
 Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1E?=
 =?UTF-8?B?YXVkw6k=?= <philmd@linaro.org>, "wangyanan (Y)"
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 60/65] hw/acpi: Update ACPI `_STA` method with QOM vCPU
 ACPI Hotplug states
Message-ID: <20241106100047.18901c9d@imammedo.users.ipa.redhat.com>
In-Reply-To: <e9fcaf7a356b46b195294173a0dbd68d@huawei.com>
References: <cover.1730754238.git.mst@redhat.com>
 <bf1ecc8dad6061914730a2a2d57af6b37c3a4f8d.1730754238.git.mst@redhat.com>
 <20241105135023.703f1e84@imammedo.users.ipa.redhat.com>
 <e9fcaf7a356b46b195294173a0dbd68d@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 5 Nov 2024 21:12:00 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> >  From: Igor Mammedov <imammedo@redhat.com>
> >  Sent: Tuesday, November 5, 2024 12:50 PM
> >  To: Michael S. Tsirkin <mst@redhat.com>
> >  Cc: qemu-devel@nongnu.org; Peter Maydell <peter.maydell@linaro.org>;
> >  Salil Mehta <salil.mehta@huawei.com>; Ani Sinha <anisinha@redhat.com>;
> >  Eduardo Habkost <eduardo@habkost.net>; Marcel Apfelbaum
> >  <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daud=C3=A9
> >  <philmd@linaro.org>; wangyanan (Y) <wangyanan55@huawei.com>; Zhao
> >  Liu <zhao1.liu@intel.com>
> >  Subject: Re: [PULL 60/65] hw/acpi: Update ACPI `_STA` method with QOM
> >  vCPU ACPI Hotplug states
> > =20
> >  On Mon, 4 Nov 2024 16:09:26 -0500
> >  "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   =20
> >  > From: Salil Mehta <salil.mehta@huawei.com>
> >  >
> >  > Reflect the QOM vCPUs ACPI CPU hotplug states in the `_STA.Present`
> >  > and and `_STA.Enabled` bits when the guest kernel evaluates the ACPI
> >  > `_STA` method during initialization, as well as when vCPUs are
> >  > hot-plugged or hot-unplugged. If the CPU is present then the its
> >  > `enabled` status can be fetched using architecture-specific code [1].
> >  >
> >  > Reference:
> >  > [1] Example implementation of architecture-specific hook to fetch CPU
> >  >     `enabled status
> >  >     Link:
> >  > https://github.com/salil- =20
> >  mehta/qemu/commit/c0b416b11e5af6505e558866f0e =20
> >  > b6c9f3709173e
> >  >
> >  > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> >  > Message-Id: <20241103102419.202225-4-salil.mehta@huawei.com>
> >  > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >  > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >  > ---
> >  >  include/hw/core/cpu.h |  1 +
> >  >  hw/acpi/cpu.c         | 38 ++++++++++++++++++++++++++++++++++----
> >  >  2 files changed, 35 insertions(+), 4 deletions(-)
> >  >
> >  > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h index
> >  > e7de77dc6d..db8a6fbc6e 100644
> >  > --- a/include/hw/core/cpu.h
> >  > +++ b/include/hw/core/cpu.h
> >  > @@ -159,6 +159,7 @@ struct CPUClass {
> >  >      void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
> >  >      int64_t (*get_arch_id)(CPUState *cpu);
> >  >      bool (*cpu_persistent_status)(CPUState *cpu);
> >  > +    bool (*cpu_enabled_status)(CPUState *cpu);
> >  >      void (*set_pc)(CPUState *cpu, vaddr value);
> >  >      vaddr (*get_pc)(CPUState *cpu);
> >  >      int (*gdb_read_register)(CPUState *cpu, GByteArray *buf, int
> >  > reg); diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c index
> >  > 9b03b4292e..23443f09a5 100644
> >  > --- a/hw/acpi/cpu.c
> >  > +++ b/hw/acpi/cpu.c
> >  > @@ -50,6 +50,18 @@ void acpi_cpu_ospm_status(CPUHotplugState =20
> >  *cpu_st, ACPIOSTInfoList ***list) =20
> >  >      }
> >  >  }
> >  >
> >  > +static bool check_cpu_enabled_status(DeviceState *dev) {
> >  > +    CPUClass *k =3D dev ? CPU_GET_CLASS(dev) : NULL;
> >  > +    CPUState *cpu =3D CPU(dev);
> >  > +
> >  > +    if (cpu && (!k->cpu_enabled_status || k->cpu_enabled_status(cpu=
))) =20
> >  { =20
> >  > +        return true;
> >  > +    }
> >  > +
> >  > +    return false;
> >  > +}
> >  > +
> >  >  static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned
> >  > size)  {
> >  >      uint64_t val =3D 0;
> >  > @@ -63,10 +75,11 @@ static uint64_t cpu_hotplug_rd(void *opaque, =20
> >  hwaddr addr, unsigned size) =20
> >  >      cdev =3D &cpu_st->devs[cpu_st->selector];
> >  >      switch (addr) {
> >  >      case ACPI_CPU_FLAGS_OFFSET_RW: /* pack and return is_* fields */
> >  > -        val |=3D cdev->cpu ? 1 : 0;
> >  > +        val |=3D check_cpu_enabled_status(DEVICE(cdev->cpu)) ? 1 : =
0;
> >  >          val |=3D cdev->is_inserting ? 2 : 0;
> >  >          val |=3D cdev->is_removing  ? 4 : 0;
> >  >          val |=3D cdev->fw_remove  ? 16 : 0;
> >  > +        val |=3D cdev->cpu ? 32 : 0;
> >  >          trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
> >  >          break;
> >  >      case ACPI_CPU_CMD_DATA_OFFSET_RW:
> >  > @@ -349,6 +362,7 @@ const VMStateDescription vmstate_cpu_hotplug =3D=
 =20
> >  { =20
> >  > #define CPU_REMOVE_EVENT  "CRMV"
> >  >  #define CPU_EJECT_EVENT   "CEJ0"
> >  >  #define CPU_FW_EJECT_EVENT "CEJF"
> >  > +#define CPU_PRESENT       "CPRS"
> >  >
> >  >  void build_cpus_aml(Aml *table, MachineState *machine, =20
> >  CPUHotplugFeatures opts, =20
> >  >                      build_madt_cpu_fn build_madt_cpu, hwaddr
> >  > base_addr, @@ -409,7 +423,9 @@ void build_cpus_aml(Aml *table, =20
> >  MachineState *machine, CPUHotplugFeatures opts, =20
> >  >          aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
> >  >          /* tell firmware to do device eject, write only */
> >  >          aml_append(field, aml_named_field(CPU_FW_EJECT_EVENT, 1));
> >  > -        aml_append(field, aml_reserved_field(3));
> >  > +        /* 1 if present, read only */
> >  > +        aml_append(field, aml_named_field(CPU_PRESENT, 1));
> >  > +        aml_append(field, aml_reserved_field(2));
> >  >          aml_append(field, aml_named_field(CPU_COMMAND, 8));
> >  >          aml_append(cpu_ctrl_dev, field);
> >  >
> >  > @@ -439,6 +455,7 @@ void build_cpus_aml(Aml *table, MachineState =20
> >  *machine, CPUHotplugFeatures opts, =20
> >  >          Aml *ctrl_lock =3D aml_name("%s.%s", cphp_res_path, CPU_LOC=
K);
> >  >          Aml *cpu_selector =3D aml_name("%s.%s", cphp_res_path, =20
> >  CPU_SELECTOR); =20
> >  >          Aml *is_enabled =3D aml_name("%s.%s", cphp_res_path,
> >  > CPU_ENABLED);
> >  > +        Aml *is_present =3D aml_name("%s.%s", cphp_res_path,
> >  > + CPU_PRESENT);
> >  >          Aml *cpu_cmd =3D aml_name("%s.%s", cphp_res_path, =20
> >  CPU_COMMAND); =20
> >  >          Aml *cpu_data =3D aml_name("%s.%s", cphp_res_path, CPU_DATA=
);
> >  >          Aml *ins_evt =3D aml_name("%s.%s", cphp_res_path,
> >  > CPU_INSERT_EVENT); @@ -467,13 +484,26 @@ void build_cpus_aml(Aml =20
> >  *table, MachineState *machine, CPUHotplugFeatures opts, =20
> >  >          {
> >  >              Aml *idx =3D aml_arg(0);
> >  >              Aml *sta =3D aml_local(0);
> >  > +            Aml *ifctx2;
> >  > +            Aml *else_ctx;
> >  >
> >  >              aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
> >  >              aml_append(method, aml_store(idx, cpu_selector));
> >  >              aml_append(method, aml_store(zero, sta));
> >  > -            ifctx =3D aml_if(aml_equal(is_enabled, one));
> >  > +            ifctx =3D aml_if(aml_equal(is_present, one)); =20
> > =20
> >  very likely this will break hotplug on after migration to older QEMU. =
=20
>=20
>=20
> The above are local variables and are not being migrated. These are not t=
he same
> as the earlier comment you provided here. I've removed those `is_present,=
enabled`
> states to address your earlier concerns:
> https://lore.kernel.org/qemu-devel/20241018163118.0ae01a84@imammedo.users=
.ipa.redhat.com/
>=20
> State-1: Possible State of ACPI _STA (without patches)
>=20
> _STA.Present =3D 0
> _STA.Enabled =3D 0
>=20
> _STA.Present =3D 1
> _STA.Enabled =3D 1
>=20
> State-2: Possible State of ACPI _STA (with patches)
>=20
> _STA.Present =3D 0
> _STA.Enabled =3D 0
>=20
> _STA.Present =3D 1
> _STA.Enabled =3D 1
>=20
> _STA.Present =3D 1
> _STA.Enabled =3D 0  [New return state which should not affect x86]
>=20
>=20
> State-1 is subset of State-2. If vCPU HP feature is off on the
> newer Qemu then, State-1 becomes proper subset of State-2.
> Later is also the state of the older Qemu?


here is AML change from the next patch:

-                If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
-                {
-                    Local0 =3D 0x0F
+                If ((\_SB.PCI0.PRES.CPRS =3D=3D One))
+                {

'enable check' branch is not taken unless presence is set.
However on old qemu there is no presence bit in register block
and it always 0, isn't it?

If above is true, the new _STA running on old QEMU after migration
will always return 0 and thus break x86 cphp.=20


+                    If ((\_SB.PCI0.PRES.CPEN =3D=3D One))
+                    {
+                        Local0 =3D 0x0F
+                    }
+                    Else
+                    {
+                        Local0 =3D 0x0D
+                    }
                 }

>=20
>=20
> >  >              {
> >  > -                aml_append(ifctx, aml_store(aml_int(0xF), sta));
> >  > +                ifctx2 =3D aml_if(aml_equal(is_enabled, one));
> >  > +                {
> >  > +                    /* cpu is present and enabled */
> >  > +                    aml_append(ifctx2, aml_store(aml_int(0xF), sta)=
);
> >  > +                }
> >  > +                aml_append(ifctx, ifctx2);
> >  > +                else_ctx =3D aml_else();
> >  > +                {
> >  > +                    /* cpu is present but disabled */
> >  > +                    aml_append(else_ctx, aml_store(aml_int(0xD), st=
a));
> >  > +                }
> >  > +                aml_append(ifctx, else_ctx);
> >  >              }
> >  >              aml_append(method, ifctx);
> >  >              aml_append(method, aml_release(ctrl_lock)); =20
> >   =20
>=20


