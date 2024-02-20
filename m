Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7082C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYpd-0006Qh-5V; Tue, 20 Feb 2024 17:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcYpb-0006Jx-CS
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:43:19 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rcYpZ-0006Vj-Dq
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:43:19 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-564372fb762so47339a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708468993; x=1709073793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTK+m10RJ63fhWgeGU2rnro1ZGMOe5siAMS1P2G0NKE=;
 b=SkM9fOQ4qlI/YA0mr04sWxAM16i7Ei8KxSui8heN32EsGvpbWOe1J0SR57f/xWvYCF
 nE5puF9UnwndbWPvtxwOC1LjtD3FbKJLxTmFn3ZC9HPoBu7XwzD3f4fsghnQbnBb77H7
 /fv7ozePqrk8rOvfh8GjM+pgB6b9CBtmFHEUal5J0LH7/Yt7W4fEHRVtjZbpjFUiDm+4
 3Si5M+JR/y6MoywjTdOiOhcUNlu13Hx9N5iOvhKxu421qlxms1ZcnJdU8v1ViMiARPGj
 /NakN+QnReonC+fIaHbl/e8mqpoh0PWkqrfdSwBHvY8Culg9p3k2TIR/Mt8k38vgoBy7
 2bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708468993; x=1709073793;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTK+m10RJ63fhWgeGU2rnro1ZGMOe5siAMS1P2G0NKE=;
 b=oaE8rq2opbZp1B9QM5h755GdKCYv9nt3WKLzbGfIdrQQtpumyFJ6Bx4qnXwwtcs5x0
 nsnJ0bvVWfjcqAAN5Q3P31qofrvMrIYhLzKARO/Ipn/GN0noMfkyxAbjt4xtmnuMma59
 nUy2W2GRpYKMFsH62XKDphVS2Bvr8KPzhBYd0+JTFBTcqnMtGgFG5bV7DOEgAUHxgps0
 xAJLSEpC9gNkKIX2YYjRfYWWXLT2amjC2e7Kv7PqXSBXCId7beaByROBEuF8bTBtFU4a
 n2XzqP22O7OzJ4dXNHHAaqtPgEOMko92DX7cadJjMj8+Vf9BbkZl368ZAxD9qWkuZ33w
 seqQ==
X-Gm-Message-State: AOJu0Yw9kK2Wpxx/p+fqvQqc8AyXeU71oIwKwFCQRELpdVyNc5/MgZjR
 h8CtuNsxB+CdT9Zgu/wQx2wJobj1tQB16wjNmDvCH35u7e1359TVWsUtNxUV
X-Google-Smtp-Source: AGHT+IHCu0o3Gu5t+4jUYyFv89oRzUTNBleaQBqnaElXJptEERFqVk4gnpNLl/Z3ADmcgu0BOyyiqQ==
X-Received: by 2002:aa7:df14:0:b0:564:6b09:92f6 with SMTP id
 c20-20020aa7df14000000b005646b0992f6mr4455359edy.18.1708468993097; 
 Tue, 20 Feb 2024 14:43:13 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-014-092-079.89.14.pool.telefonica.de.
 [89.14.92.79]) by smtp.gmail.com with ESMTPSA id
 x17-20020aa7cd91000000b005649df0654asm1731216edv.21.2024.02.20.14.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 14:43:12 -0800 (PST)
Date: Tue, 20 Feb 2024 22:43:10 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: philmd@linaro.org
Subject: Re: [PATCH] vl, pc: turn -no-fd-bootchk into a machine property
In-Reply-To: <20240220155352.416710-1-pbonzini@redhat.com>
References: <20240220155352.416710-1-pbonzini@redhat.com>
Message-ID: <8FECF57F-7897-4AF8-9AC1-46A927C0FEC0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 20=2E Februar 2024 15:53:52 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>Add a fd-bootchk property to PC machine types, so that -no-fd-bootchk
>returns an error if the machine does not support booting from floppies
>and checking for boot signatures therein=2E
>
>Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> include/hw/i386/pc=2Eh |  2 +-
> hw/i386/pc=2Ec         | 30 +++++++++++++++++++++++++-----
> system/globals=2Ec     |  1 -
> system/vl=2Ec          |  2 +-
> qemu-options=2Ehx      |  2 +-
> 5 files changed, 28 insertions(+), 9 deletions(-)
>
>diff --git a/include/hw/i386/pc=2Eh b/include/hw/i386/pc=2Eh
>index 02a0deedd3c=2E=2Ee5382a02e7a 100644
>--- a/include/hw/i386/pc=2Eh
>+++ b/include/hw/i386/pc=2Eh
>@@ -50,6 +50,7 @@ typedef struct PCMachineState {
>     bool hpet_enabled;
>     bool i8042_enabled;
>     bool default_bus_bypass_iommu;
>+    bool fd_bootchk;
>     uint64_t max_fw_size;
>=20
>     /* ACPI Memory hotplug IO base address */
>@@ -147,7 +148,6 @@ OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, P=
C_MACHINE)
> GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>=20
> /* pc=2Ec */
>-extern int fd_bootchk;
>=20
> void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
>=20
>diff --git a/hw/i386/pc=2Ec b/hw/i386/pc=2Ec
>index 28194014f82=2E=2E31f4bb25a3e 100644
>--- a/hw/i386/pc=2Ec
>+++ b/hw/i386/pc=2Ec
>@@ -399,8 +399,8 @@ static int boot_device2nibble(char boot_device)
>     return 0;
> }
>=20
>-static void set_boot_dev(MC146818RtcState *s, const char *boot_device,
>-                         Error **errp)
>+static void set_boot_dev(PCMachineState *pcms, MC146818RtcState *s,
>+                         const char *boot_device, Error **errp)
> {
> #define PC_MAX_BOOT_DEVICES 3
>     int nbds, bds[3] =3D { 0, };
>@@ -420,12 +420,14 @@ static void set_boot_dev(MC146818RtcState *s, const=
 char *boot_device,
>         }
>     }
>     mc146818rtc_set_cmos_data(s, 0x3d, (bds[1] << 4) | bds[0]);
>-    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | (fd_bootchk ? 0x0=
 : 0x1));
>+    mc146818rtc_set_cmos_data(s, 0x38, (bds[2] << 4) | !pcms->fd_bootchk=
);
> }
>=20
> static void pc_boot_set(void *opaque, const char *boot_device, Error **e=
rrp)
> {
>-    set_boot_dev(opaque, boot_device, errp);
>+    PCMachineState *pcms =3D PC_MACHINE(current_machine);
>+
>+    set_boot_dev(pcms, opaque, boot_device, errp);
> }
>=20
> static void pc_cmos_init_floppy(MC146818RtcState *rtc_state, ISADevice *=
floppy)
>@@ -617,6 +619,9 @@ void pc_cmos_init(PCMachineState *pcms,
>     mc146818rtc_set_cmos_data(s, 0x5c, val >> 8);
>     mc146818rtc_set_cmos_data(s, 0x5d, val >> 16);
>=20
>+    object_property_add_bool(obj, "fd-bootchk", pc_machine_get_fd_bootch=
k,
>+                             pc_machine_set_fd_bootchk);

Isn't it possible to turn this into a class property or add the property i=
n pc_machine_initfn()? Aggregating properties in one place seems more compr=
ehensible to me=2E

Note that I've submitted a series attempting to simplify initialization of=
 the PC machines which still waits for reviews: https://patchew=2Eorg/QEMU/=
20240208220349=2E4948-1-shentey@gmail=2Ecom/

Thanks,
Bernhard

>+
>     object_property_add_link(OBJECT(pcms), "rtc_state",
>                              TYPE_ISA_DEVICE,
>                              (Object **)&x86ms->rtc,
>@@ -625,7 +630,7 @@ void pc_cmos_init(PCMachineState *pcms,
>     object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
>                              &error_abort);
>=20
>-    set_boot_dev(s, MACHINE(pcms)->boot_config=2Eorder, &error_fatal);
>+    set_boot_dev(pcms, s, MACHINE(pcms)->boot_config=2Eorder, &error_fat=
al);
>=20
>     val =3D 0;
>     val |=3D 0x02; /* FPU is there */
>@@ -1559,6 +1564,20 @@ static void pc_machine_set_vmport(Object *obj, Vis=
itor *v, const char *name,
>     visit_type_OnOffAuto(v, name, &pcms->vmport, errp);
> }
>=20
>+static bool pc_machine_get_fd_bootchk(Object *obj, Error **errp)
>+{
>+    PCMachineState *pcms =3D PC_MACHINE(obj);
>+
>+    return pcms->fd_bootchk;
>+}
>+
>+static void pc_machine_set_fd_bootchk(Object *obj, bool value, Error **e=
rrp)
>+{
>+    PCMachineState *pcms =3D PC_MACHINE(obj);
>+
>+    pcms->fd_bootchk =3D value;
>+}
>+
> static bool pc_machine_get_smbus(Object *obj, Error **errp)
> {
>     PCMachineState *pcms =3D PC_MACHINE(obj);
>@@ -1747,6 +1766,7 @@ static void pc_machine_initfn(Object *obj)
> #ifdef CONFIG_HPET
>     pcms->hpet_enabled =3D true;
> #endif
>+    pcms->fd_bootchk =3D true;
>     pcms->default_bus_bypass_iommu =3D false;
>=20
>     pc_system_flash_create(pcms);
>diff --git a/system/globals=2Ec b/system/globals=2Ec
>index b6d4e72530e=2E=2E5d0046ba105 100644
>--- a/system/globals=2Ec
>+++ b/system/globals=2Ec
>@@ -41,7 +41,6 @@ int vga_interface_type =3D VGA_NONE;
> bool vga_interface_created;
> Chardev *parallel_hds[MAX_PARALLEL_PORTS];
> int win2k_install_hack;
>-int fd_bootchk =3D 1;
> int graphic_rotate;
> QEMUOptionRom option_rom[MAX_OPTION_ROMS];
> int nb_option_roms;
>diff --git a/system/vl=2Ec b/system/vl=2Ec
>index a82555ae155=2E=2E4627004304b 100644
>--- a/system/vl=2Ec
>+++ b/system/vl=2Ec
>@@ -2927,7 +2927,7 @@ void qemu_init(int argc, char **argv)
>                           optarg, FD_OPTS);
>                 break;
>             case QEMU_OPTION_no_fd_bootchk:
>-                fd_bootchk =3D 0;
>+                qdict_put_str(machine_opts_dict, "fd-bootchk", "off");
>                 break;
>             case QEMU_OPTION_netdev:
>                 default_net =3D 0;
>diff --git a/qemu-options=2Ehx b/qemu-options=2Ehx
>index 8547254dbf9=2E=2Ea9e0107b4f0 100644
>--- a/qemu-options=2Ehx
>+++ b/qemu-options=2Ehx
>@@ -2650,7 +2650,7 @@ DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
> SRST
> ``-no-fd-bootchk``
>     Disable boot signature checking for floppy disks in BIOS=2E May be
>-    needed to boot from old floppy disks=2E
>+    needed to boot from old floppy disks=2E  Synonym of ``-m fd-bootchk=
=3Doff``=2E
> ERST
>=20
> DEF("acpitable", HAS_ARG, QEMU_OPTION_acpitable,

