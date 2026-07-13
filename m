Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B3FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJdb-0001uJ-C1; Mon, 13 Jul 2026 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wjJdY-0001tN-Vp
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:36:09 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wjJdT-0002jg-QY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:36:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-474560436c3so42921f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783960561; x=1784565361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wk00qo1fLNaaYGMb+b8ToX3Yvuzp7fU7XUNGCnAHxK0=;
 b=FV1wM7Z1CclVRXPFdsUMx/BP8szWbNWYOIhhtBci9Dyjc3q2B4HdOxYJIBX0rk3qcM
 qZxvZMkxNhCyOb145p90GcLnalaE5Qz08xHvJuLDJU4a4nKKVvZ6qrwDkNua3kPbkVCw
 uEpPYmjbUK6cajstR3C9HOiDsrHt7Kj+N45YV9mHm4MjmheKr0Naw5384WDcl5mdc9Bu
 CQS+IYBljIVhqVpKHPsoU2vPJpWw5wYOv4v10o6JAmukzQ3G8BA44kZ5jgRx2iDBLorS
 NByf05zMWmQEC0WQF9nKECWAZ0qahM1FUu7FYyR5aRYCVVhqHB3ucGiGi8yyaEDi1u/Y
 WXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783960561; x=1784565361;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wk00qo1fLNaaYGMb+b8ToX3Yvuzp7fU7XUNGCnAHxK0=;
 b=R6qlgLQOxQCHVth6CeyhlaSr7RktuktvmqRBRCHu4dofacnNpJOmJyNcMWDIHuDc/6
 P3pJAZ5d4ckodXENk1P/MBS2EtTOPkEpRtiJtWKqh5VD3UsiC3gpVKXOYpopGqUjBWjV
 XBJV0grtZfSlECA4S3vGxsdiI8bbzzLXjEg+rGMY5bMok4eu9ETG/OfwZL/JUezkU0dZ
 V+bbtx3rnJ5UZnGxPjxz8ivfqMltEbrYHmGGr+peRGbchDowNM+oYPnSUm/HNwuEmSM2
 3JJ3icXWds2Q9frtyiPPn20t82P9bbkeD310E5hW7i22QrvIRYFuGmg5B5tlNPg/vn2l
 c+Vg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRzTIezst0uflH4Ev55FGGgh+azl7VMkZE+YQDF46IV8D2MzTu+It4JDFS4jgnljiWeiIBSR3LDMVi@nongnu.org
X-Gm-Message-State: AOJu0YyxPjQ1nBkOr8gqyZc5eFScYqk837mT53z6sFRv9gxqpBTEZ1IO
 9jl4OrPCWWkscSICkuX20Ahxl4CMHo/A0t6tpNamJp9M2SrrSZmq5QdW
X-Gm-Gg: AfdE7ckKTRnibL0fwu2fiWmcVymMnfdnEEfdar6LkK14nFkVpdXXqe4VIeCvjZ4PP2F
 u7iMy2fbFrIRd8SEl/Di2UCTG2+VsrBJdj4lVeHEUHKKjVjWu+z3L/eMjA7qg5TxdB6voUZNVXP
 6QIxq/CUXm0rp6QlvW3TyruJOzSCJjiRUVr5zewSivXXVXJtHq6T/en2tS8I+FC7siJFyCItnC2
 rhhfJpDK0QBj8/1zKhLgHpp07EQDZBypzHo8CZHwG8XQmgyfEwuqiWqcr7zeQ1e4+tCB31LfxIv
 x3wgHsgWiblSHTmtFngHsOSnD7ZOoOCF5uqMivdeJfkAu6FaZKk4Cs2Nz5kJVdBl1zUkoQK8OMZ
 ss3+hylDNalgbjkaJrAapul5Qbab8+5Wbi+5wY+FsIFqsMg1fYBA5dF1dtZ7QISVSmOPJKfmx1V
 HstFFMFtKkTweeDDIdK5tLj4gNueTBYYk7zCD7jgCz2UwrlRg=
X-Received: by 2002:a05:6000:22c9:b0:47d:fc45:8587 with SMTP id
 ffacd0b85a97d-47f2da5c00amr10782462f8f.0.1783960560903; 
 Mon, 13 Jul 2026 09:36:00 -0700 (PDT)
Received: from ehlo.thunderbird.net (p5b3df423.dip0.t-ipconnect.de.
 [91.61.244.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a940sm547691f8f.12.2026.07.13.09.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 09:36:00 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:35:55 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
CC: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?ISO-8859-1?Q?Cl=E9ment_Chigot?= <chigot@adacore.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Jan Kiszka <jan.kiszka@web.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jared Rossi <jrossi@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>,
 =?ISO-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_129/134=5D_hw=3A_Parent_?=
 =?US-ASCII?Q?board-created_CPUs_under_the_machine?=
In-Reply-To: <20260711223707.42139-130-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-130-graf@amazon.com>
Message-ID: <79577E32-B242-44A5-8CE0-62D93E561B30@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



Am 11=2E Juli 2026 22:37:02 UTC schrieb Alexander Graf <graf@amazon=2Ecom>=
:
>A number of boards create CPUs via object_new(cpu_type) followed
>by property setting and qdev_realize(NULL), rather than through
>cpu_create()=2E  These CPUs currently fall into /machine/unattached
>via the device_set_realized() fallback=2E  Parent them explicitly
>under the machine (or the CPS/SoC container that owns them) as
>"cpu[*]", matching the naming convention used by cpu_create()=2E
>
>The subsequent object_unref() and qdev_realize_and_unref() calls
>are converted to plain qdev_realize() (or dropped) since the
>parent's child<> property now holds the reference=2E  Error paths
>switch to object_unparent()=2E
>
>The transient introspection object_new() in hw/arm/virt=2Ec
>machvirt_init() (probing pa_bits) is deliberately left as-is;
>it is unref'd immediately without being realized=2E
>
>  hw/arm:       integratorcp mps3r realview sbsa-ref versatilepb
>                vexpress virt xilinx-zynq
>  hw/hexagon:   hexagon_dsp virt
>  hw/i386:      x86-common xen-pvh
>  hw/loongarch: virt
>  hw/mips:      cps
>  hw/ppc:       e500 spapr (cpu-core)
>  hw/riscv:     cps microblaze-v-generic
>  hw/s390x:     s390-virtio-ccw
>  hw/sparc:     leon3 sun4m
>  hw/sparc64:   sparc64
>
>Assisted-by: Kiro
>Signed-off-by: Alexander Graf <graf@amazon=2Ecom>

For e500 where migration compatibility is not an issue:

Acked-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/arm/integratorcp=2Ec           |  3 ++-
> hw/arm/mps3r=2Ec                  |  4 ++--
> hw/arm/realview=2Ec               |  3 ++-
> hw/arm/sbsa-ref=2Ec               |  4 ++--
> hw/arm/versatilepb=2Ec            |  3 ++-
> hw/arm/vexpress=2Ec               |  3 ++-
> hw/arm/virt=2Ec                   |  4 ++--
> hw/arm/xilinx_zynq=2Ec            |  3 ++-
> hw/hexagon/hexagon_dsp=2Ec        |  5 +++--
> hw/hexagon/virt=2Ec               |  5 +++--
> hw/i386/x86-common=2Ec            |  9 ++++-----
> hw/i386/xen/xen-pvh=2Ec           |  5 ++---
> hw/loongarch/virt=2Ec             |  5 +++--
> hw/mips/cps=2Ec                   |  5 +++--
> hw/ppc/e500=2Ec                   |  5 +++--
> hw/ppc/spapr=2Ec                  |  4 ++--
> hw/riscv/cps=2Ec                  |  5 +++--
> hw/riscv/microblaze-v-generic=2Ec |  3 ++-
> hw/s390x/s390-virtio-ccw=2Ec      | 16 +++++++---------
> hw/sparc/leon3=2Ec                |  3 ++-
> hw/sparc/sun4m=2Ec                |  5 +++--
> hw/sparc64/sparc64=2Ec            |  3 ++-
> 22 files changed, 58 insertions(+), 47 deletions(-)
>
>diff --git a/hw/arm/integratorcp=2Ec b/hw/arm/integratorcp=2Ec
>index 81c0bce8f9=2E=2E30a6a940c5 100644
>--- a/hw/arm/integratorcp=2Ec
>+++ b/hw/arm/integratorcp=2Ec
>@@ -598,7 +598,8 @@ static void integratorcp_init(MachineState *machine)
>     DriveInfo *dinfo;
>     int i;
>=20
>-    cpuobj =3D object_new(machine->cpu_type);
>+    cpuobj =3D object_new_child(OBJECT(machine), "cpu[0]",
>+                                        machine->cpu_type);
>=20
>     /* By default ARM1176 CPUs have EL3 enabled=2E  This board does not
>      * currently support EL3 so the CPU EL3 property is disabled before
>diff --git a/hw/arm/mps3r=2Ec b/hw/arm/mps3r=2Ec
>index d6c29c1172=2E=2Edd434eaefd 100644
>--- a/hw/arm/mps3r=2Ec
>+++ b/hw/arm/mps3r=2Ec
>@@ -388,13 +388,13 @@ static void mps3r_common_init(MachineState *machine=
)
>         memory_region_add_subregion_overlap(&mms->cpu_sysmem[i], 0,
>                                             &mms->sysmem_alias[i], -1);
>=20
>-        mms->cpu[i] =3D object_new(machine->cpu_type);
>+        mms->cpu[i] =3D object_new_child(OBJECT(mms), "cpu[*]",
>+                                        machine->cpu_type);
>         object_property_set_link(mms->cpu[i], "memory",
>                                  OBJECT(&mms->cpu_sysmem[i]), &error_abo=
rt);
>         object_property_set_int(mms->cpu[i], "reset-cbar",
>                                 PERIPHBASE, &error_abort);
>         qdev_realize(DEVICE(mms->cpu[i]), NULL, &error_fatal);
>-        object_unref(mms->cpu[i]);
>=20
>         /* Per-CPU RAM */
>         memory_region_init_ram(&mms->cpu_ram[i], OBJECT(mms), ramname,
>diff --git a/hw/arm/realview=2Ec b/hw/arm/realview=2Ec
>index 99591e7d80=2E=2Ef938367131 100644
>--- a/hw/arm/realview=2Ec
>+++ b/hw/arm/realview=2Ec
>@@ -119,7 +119,8 @@ static void realview_init(MachineState *machine,
>     }
>=20
>     for (n =3D 0; n < smp_cpus; n++) {
>-        Object *cpuobj =3D object_new(machine->cpu_type);
>+        Object *cpuobj =3D object_new_child(OBJECT(machine), "cpu[*]",
>+                                        machine->cpu_type);
>=20
>         /* By default A9,A15 and ARM1176 CPUs have EL3 enabled=2E  This =
board
>          * does not currently support EL3 so the CPU EL3 property is dis=
abled
>diff --git a/hw/arm/sbsa-ref=2Ec b/hw/arm/sbsa-ref=2Ec
>index c9adc972c1=2E=2E3b759d9209 100644
>--- a/hw/arm/sbsa-ref=2Ec
>+++ b/hw/arm/sbsa-ref=2Ec
>@@ -783,7 +783,8 @@ static void sbsa_ref_init(MachineState *machine)
>             break;
>         }
>=20
>-        cpuobj =3D object_new(possible_cpus->cpus[n]=2Etype);
>+        cpuobj =3D object_new_child(OBJECT(sms), "cpu[*]",
>+                                        possible_cpus->cpus[n]=2Etype);
>         object_property_set_int(cpuobj, "mp-affinity",
>                                 possible_cpus->cpus[n]=2Earch_id, NULL);
>=20
>@@ -808,7 +809,6 @@ static void sbsa_ref_init(MachineState *machine)
>                                  OBJECT(secure_sysmem), &error_abort);
>=20
>         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>-        object_unref(cpuobj);
>     }
>=20
>     memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_MEM]=2Ebase=
,
>diff --git a/hw/arm/versatilepb=2Ec b/hw/arm/versatilepb=2Ec
>index f68c4765c6=2E=2E8d93fff207 100644
>--- a/hw/arm/versatilepb=2Ec
>+++ b/hw/arm/versatilepb=2Ec
>@@ -208,7 +208,8 @@ static void versatile_init(MachineState *machine, int=
 board_id)
>         exit(1);
>     }
>=20
>-    cpuobj =3D object_new(machine->cpu_type);
>+    cpuobj =3D object_new_child(OBJECT(machine), "cpu[0]",
>+                                        machine->cpu_type);
>=20
>     /* By default ARM1176 CPUs have EL3 enabled=2E  This board does not
>      * currently support EL3 so the CPU EL3 property is disabled before
>diff --git a/hw/arm/vexpress=2Ec b/hw/arm/vexpress=2Ec
>index f877ccf330=2E=2E986525b9ce 100644
>--- a/hw/arm/vexpress=2Ec
>+++ b/hw/arm/vexpress=2Ec
>@@ -219,7 +219,8 @@ static void init_cpus(MachineState *ms, const char *c=
pu_type,
>=20
>     /* Create the actual CPUs */
>     for (n =3D 0; n < smp_cpus; n++) {
>-        Object *cpuobj =3D object_new(cpu_type);
>+        Object *cpuobj =3D object_new_child(qdev_get_machine(), "cpu[*]"=
,
>+                                        cpu_type);
>=20
>         if (!secure) {
>             object_property_set_bool(cpuobj, "has_el3", false, NULL);
>diff --git a/hw/arm/virt=2Ec b/hw/arm/virt=2Ec
>index f2249a0b72=2E=2E95e087d692 100644
>--- a/hw/arm/virt=2Ec
>+++ b/hw/arm/virt=2Ec
>@@ -3039,7 +3039,8 @@ static void machvirt_init(MachineState *machine)
>             break;
>         }
>=20
>-        cpuobj =3D object_new(possible_cpus->cpus[n]=2Etype);
>+        cpuobj =3D object_new_child(OBJECT(vms), "cpu[*]",
>+                                  possible_cpus->cpus[n]=2Etype);
>         object_property_set_int(cpuobj, "mp-affinity",
>                                 possible_cpus->cpus[n]=2Earch_id, NULL);
>=20
>@@ -3139,7 +3140,6 @@ static void machvirt_init(MachineState *machine)
>         }
>=20
>         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>-        object_unref(cpuobj);
>     }
>=20
>     /* Now we've created the CPUs we can see if they have the hypvirt ti=
mer */
>diff --git a/hw/arm/xilinx_zynq=2Ec b/hw/arm/xilinx_zynq=2Ec
>index 441289e63f=2E=2Ea2dcdd422d 100644
>--- a/hw/arm/xilinx_zynq=2Ec
>+++ b/hw/arm/xilinx_zynq=2Ec
>@@ -222,7 +222,8 @@ static void zynq_init(MachineState *machine)
>     }
>=20
>     for (n =3D 0; n < smp_cpus; n++) {
>-        Object *cpuobj =3D object_new(machine->cpu_type);
>+        Object *cpuobj =3D object_new_child(OBJECT(machine), "cpu[*]",
>+                                        machine->cpu_type);
>=20
>         object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
>                                 &error_fatal);
>diff --git a/hw/hexagon/hexagon_dsp=2Ec b/hw/hexagon/hexagon_dsp=2Ec
>index 53dfe6741e=2E=2Ed78a987dca 100644
>--- a/hw/hexagon/hexagon_dsp=2Ec
>+++ b/hw/hexagon/hexagon_dsp=2Ec
>@@ -143,7 +143,8 @@ static void hexagon_common_init(MachineState *machine=
, Rev_t rev,
>     sysbus_realize(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
>=20
>     for (int i =3D 0; i < machine->smp=2Ecpus; i++) {
>-        HexagonCPU *cpu =3D HEXAGON_CPU(object_new(machine->cpu_type));
>+        HexagonCPU *cpu =3D HEXAGON_CPU(object_new_child(OBJECT(machine)=
, "cpu[*]",
>+                                        machine->cpu_type));
>         qemu_register_reset(do_cpu_reset, cpu);
>=20
>         /*
>@@ -158,7 +159,7 @@ static void hexagon_common_init(MachineState *machine=
, Rev_t rev,
>                                  OBJECT(glob_regs_dev), &error_fatal);
>         object_property_set_link(OBJECT(cpu), "tlb",
>                                  OBJECT(tlb_dev), &error_fatal);
>-        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>+        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>     }
>=20
>     rom_add_blob_fixed_as("config_table=2Erom", &m_cfg->cfgtable,
>diff --git a/hw/hexagon/virt=2Ec b/hw/hexagon/virt=2Ec
>index fb23cda19f=2E=2E48f1e35dd3 100644
>--- a/hw/hexagon/virt=2Ec
>+++ b/hw/hexagon/virt=2Ec
>@@ -280,7 +280,8 @@ static void virt_init(MachineState *ms)
>=20
>     cpu0 =3D NULL;
>     for (int i =3D 0; i < ms->smp=2Ecpus; i++) {
>-        HexagonCPU *cpu =3D HEXAGON_CPU(object_new(ms->cpu_type));
>+        HexagonCPU *cpu =3D HEXAGON_CPU(object_new_child(OBJECT(ms), "cp=
u[*]",
>+                                        ms->cpu_type));
>         qemu_register_reset(do_cpu_reset, cpu);
>=20
>         if (i =3D=3D 0) {
>@@ -300,7 +301,7 @@ static void virt_init(MachineState *ms)
>         object_property_set_link(OBJECT(cpu), "tlb",
>                                  OBJECT(tlb_dev), &error_fatal);
>=20
>-        qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
>+        qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>     }
>     fdt_add_cpu_nodes(vms);
>     clk_phandle =3D fdt_add_clocks(vms);
>diff --git a/hw/i386/x86-common=2Ec b/hw/i386/x86-common=2Ec
>index 151a67ee5f=2E=2E5bbfee737e 100644
>--- a/hw/i386/x86-common=2Ec
>+++ b/hw/i386/x86-common=2Ec
>@@ -55,15 +55,14 @@ static size_t pvh_start_addr;
>=20
> static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error *=
*errp)
> {
>-    Object *cpu =3D object_new(MACHINE(x86ms)->cpu_type);
>+    Object *cpu =3D object_new_child(OBJECT(x86ms), "cpu[*]",
>+                                        MACHINE(x86ms)->cpu_type);
>=20
>     if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
>-        goto out;
>+        object_unparent(cpu);
>+        return;
>     }
>     qdev_realize(DEVICE(cpu), NULL, errp);
>-
>-out:
>-    object_unref(cpu);
> }
>=20
> void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>diff --git a/hw/i386/xen/xen-pvh=2Ec b/hw/i386/xen/xen-pvh=2Ec
>index ab90c83a83=2E=2E7aef48ad61 100644
>--- a/hw/i386/xen/xen-pvh=2Ec
>+++ b/hw/i386/xen/xen-pvh=2Ec
>@@ -29,12 +29,11 @@ struct XenPVHx86State {
> static DeviceState *xen_pvh_cpu_new(MachineState *ms,
>                                     int64_t apic_id)
> {
>-    Object *cpu =3D object_new(ms->cpu_type);
>+    Object *cpu =3D object_new_child(OBJECT(ms), "cpu[*]",
>+                                        ms->cpu_type);
>=20
>-    object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
>     object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
>     qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>-    object_unref(cpu);
>=20
>     return DEVICE(cpu);
> }
>diff --git a/hw/loongarch/virt=2Ec b/hw/loongarch/virt=2Ec
>index 580ef0bb3e=2E=2Eb749aafdbe 100644
>--- a/hw/loongarch/virt=2Ec
>+++ b/hw/loongarch/virt=2Ec
>@@ -948,13 +948,14 @@ static void virt_init(MachineState *machine)
>     /* Init CPUs */
>     mc->possible_cpu_arch_ids(machine);
>     for (i =3D 0; i < machine->smp=2Ecpus; i++) {
>-        cpuobj =3D object_new(machine->cpu_type);
>+        cpuobj =3D object_new_child(OBJECT(machine), "cpu[*]",
>+                                        machine->cpu_type);
>         if (cpuobj =3D=3D NULL) {
>             error_report("Fail to create object with type %s ",
>                          machine->cpu_type);
>             exit(EXIT_FAILURE);
>         }
>-        qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
>+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>     }
>     virt_check_dmsi(machine);
>     fw_cfg_add_memory(machine);
>diff --git a/hw/mips/cps=2Ec b/hw/mips/cps=2Ec
>index 620ee972f8=2E=2Eb997608373 100644
>--- a/hw/mips/cps=2Ec
>+++ b/hw/mips/cps=2Ec
>@@ -74,7 +74,8 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>     }
>=20
>     for (int i =3D 0; i < s->num_vp; i++) {
>-        MIPSCPU *cpu =3D MIPS_CPU(object_new(s->cpu_type));
>+        MIPSCPU *cpu =3D MIPS_CPU(object_new_child(OBJECT(s), "cpu[*]",
>+                                        s->cpu_type));
>         CPUMIPSState *env =3D &cpu->env;
>=20
>         object_property_set_bool(OBJECT(cpu), "big-endian", s->cpu_is_bi=
gendian,
>@@ -87,7 +88,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>         /* All cores use the same clock tree */
>         qdev_connect_clock_in(DEVICE(cpu), "clk-in", s->clock);
>=20
>-        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
>+        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>             return;
>         }
>=20
>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>index f3917c0755=2E=2Ea0eb25e956 100644
>--- a/hw/ppc/e500=2Ec
>+++ b/hw/ppc/e500=2Ec
>@@ -941,7 +941,8 @@ void ppce500_init(MachineState *machine)
>         PowerPCCPU *cpu;
>         CPUState *cs;
>=20
>-        cpu =3D POWERPC_CPU(object_new(machine->cpu_type));
>+        cpu =3D POWERPC_CPU(object_new_child(OBJECT(machine), "cpu[*]",
>+                                        machine->cpu_type));
>         env =3D &cpu->env;
>         cs =3D CPU(cpu);
>=20
>@@ -956,7 +957,7 @@ void ppce500_init(MachineState *machine)
>          */
>         object_property_set_bool(OBJECT(cs), "start-powered-off", i !=3D=
 0,
>                                  &error_abort);
>-        qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
>+        qdev_realize(DEVICE(cs), NULL, &error_fatal);
>=20
>         if (!firstenv) {
>             firstenv =3D env;
>diff --git a/hw/ppc/spapr=2Ec b/hw/ppc/spapr=2Ec
>index 9b6b5e7257=2E=2Ee6c1b7f0b1 100644
>--- a/hw/ppc/spapr=2Ec
>+++ b/hw/ppc/spapr=2Ec
>@@ -2776,7 +2776,8 @@ static void spapr_init_cpus(SpaprMachineState *spap=
r)
>         }
>=20
>         if (i < boot_cores_nr) {
>-            Object *core  =3D object_new(type);
>+            Object *core  =3D object_new_child(OBJECT(spapr), "cpu-core[=
*]",
>+                                        type);
>             int nr_threads =3D smp_threads;
>=20
>             /* Handle the partially filled core for older machine types =
*/
>@@ -2790,7 +2791,6 @@ static void spapr_init_cpus(SpaprMachineState *spap=
r)
>                                     &error_fatal);
>             qdev_realize(DEVICE(core), NULL, &error_fatal);
>=20
>-            object_unref(core);
>         }
>     }
> }
>diff --git a/hw/riscv/cps=2Ec b/hw/riscv/cps=2Ec
>index b6b30e05e1=2E=2E2bf506b61a 100644
>--- a/hw/riscv/cps=2Ec
>+++ b/hw/riscv/cps=2Ec
>@@ -63,13 +63,14 @@ static void riscv_cps_realize(DeviceState *dev, Error=
 **errp)
>     int harts_in_cluster =3D s->num_hart * s->num_core;
>     int num_of_clusters =3D s->num_vp / harts_in_cluster;
>     for (i =3D 0; i < s->num_vp; i++) {
>-        cpu =3D RISCV_CPU(object_new(s->cpu_type));
>+        cpu =3D RISCV_CPU(object_new_child(OBJECT(s), "cpu[*]",
>+                                        s->cpu_type));
>=20
>         /* All VPs are halted on reset=2E Leave powering up to CPC=2E */
>         object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
>                                  &error_abort);
>=20
>-        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
>+        if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>             return;
>         }
>=20
>diff --git a/hw/riscv/microblaze-v-generic=2Ec b/hw/riscv/microblaze-v-ge=
neric=2Ec
>index 0a83932405=2E=2Ef97ce402e6 100644
>--- a/hw/riscv/microblaze-v-generic=2Ec
>+++ b/hw/riscv/microblaze-v-generic=2Ec
>@@ -65,7 +65,8 @@ static void mb_v_generic_init(MachineState *machine)
>     qemu_irq irq[32];
>     MemoryRegion *sysmem =3D get_system_memory();
>=20
>-    cpu =3D RISCV_CPU(object_new(machine->cpu_type));
>+    cpu =3D RISCV_CPU(object_new_child(OBJECT(machine), "cpu[0]",
>+                                        machine->cpu_type));
>     object_property_set_bool(OBJECT(cpu), "h", false, NULL);
>     object_property_set_bool(OBJECT(cpu), "d", false, NULL);
>     qdev_realize(DEVICE(cpu), NULL, &error_abort);
>diff --git a/hw/s390x/s390-virtio-ccw=2Ec b/hw/s390x/s390-virtio-ccw=2Ec
>index 037cb6eb5e=2E=2E0625d4a8df 100644
>--- a/hw/s390x/s390-virtio-ccw=2Ec
>+++ b/hw/s390x/s390-virtio-ccw=2Ec
>@@ -56,20 +56,18 @@ static Error *pv_mig_blocker;
> static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
>                               Error **errp)
> {
>-    S390CPU *cpu =3D S390_CPU(object_new(typename));
>-    S390CPU *ret =3D NULL;
>+    S390CPU *cpu =3D S390_CPU(object_new_child(qdev_get_machine(), "cpu[=
*]",
>+                                        typename));
>=20
>     if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, errp))=
 {
>-        goto out;
>+        object_unparent(OBJECT(cpu));
>+        return NULL;
>     }
>     if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
>-        goto out;
>+        object_unparent(OBJECT(cpu));
>+        return NULL;
>     }
>-    ret =3D cpu;
>-
>-out:
>-    object_unref(OBJECT(cpu));
>-    return ret;
>+    return cpu;
> }
>=20
> static void s390_init_cpus(MachineState *machine)
>diff --git a/hw/sparc/leon3=2Ec b/hw/sparc/leon3=2Ec
>index f9ef2758e1=2E=2Ea2781bcc32 100644
>--- a/hw/sparc/leon3=2Ec
>+++ b/hw/sparc/leon3=2Ec
>@@ -278,7 +278,8 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
>=20
>     for (i =3D 0; i < machine->smp=2Ecpus; i++) {
>         /* Init CPU */
>-        cpu =3D SPARC_CPU(object_new(machine->cpu_type));
>+        cpu =3D SPARC_CPU(object_new_child(OBJECT(machine), "cpu[*]",
>+                                        machine->cpu_type));
>         qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu=
", 1);
>         qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1)=
;
>         qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>diff --git a/hw/sparc/sun4m=2Ec b/hw/sparc/sun4m=2Ec
>index 51f5468a02=2E=2E1ae9d834ca 100644
>--- a/hw/sparc/sun4m=2Ec
>+++ b/hw/sparc/sun4m=2Ec
>@@ -787,7 +787,8 @@ static DeviceState *cpu_devinit(const char *cpu_type,=
 unsigned int id,
>     CPUSPARCState *env;
>     DeviceState *cpudev;
>=20
>-    cpu =3D SPARC_CPU(object_new(cpu_type));
>+    cpu =3D SPARC_CPU(object_new_child(qdev_get_machine(), "cpu[*]",
>+                                        cpu_type));
>     env =3D &cpu->env;
>     cpudev =3D DEVICE(cpu);
>=20
>@@ -795,7 +796,7 @@ static DeviceState *cpu_devinit(const char *cpu_type,=
 unsigned int id,
>     object_property_set_bool(OBJECT(cpu), "start-powered-off", id !=3D 0=
,
>                              &error_abort);
>     qdev_init_gpio_in_named(cpudev, cpu_set_irq, "pil", MAX_PILS);
>-    qdev_realize_and_unref(cpudev, NULL, &error_fatal);
>+    qdev_realize(cpudev, NULL, &error_fatal);
>     cpu_sparc_set_id(env, id);
>     env->prom_addr =3D prom_addr;
>     return cpudev;
>diff --git a/hw/sparc64/sparc64=2Ec b/hw/sparc64/sparc64=2Ec
>index 16f4aa052b=2E=2E9092c4193e 100644
>--- a/hw/sparc64/sparc64=2Ec
>+++ b/hw/sparc64/sparc64=2Ec
>@@ -272,7 +272,8 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, u=
int64_t prom_addr)
>     uint32_t  stick_frequency =3D 100 * 1000000;
>     uint32_t hstick_frequency =3D 100 * 1000000;
>=20
>-    cpu =3D SPARC_CPU(object_new(cpu_type));
>+    cpu =3D SPARC_CPU(object_new_child(qdev_get_machine(), "cpu[0]",
>+                                        cpu_type));
>     qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
>                             "ivec-irq", IVEC_MAX);
>     qdev_realize(DEVICE(cpu), NULL, &error_fatal);

