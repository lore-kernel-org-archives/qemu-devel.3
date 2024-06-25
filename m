Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D18EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 02:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGLO-0006PV-51; Tue, 25 Jun 2024 20:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sMGL7-0006OX-Vj
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:16:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1sMGKT-0002MZ-5C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:16:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-363bbd51050so4821392f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1719360897; x=1719965697; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QtlLaNBH/RbSlotEEbZpY7+zgKvTQho2Lbmamu2yflA=;
 b=BS3Y1qJHp/nJihnZ8HO3KL+uw39//qfAFK5Mw4B29eCXH9SOFR/IqmH4YDGfXwfJXt
 sEVC30/xzF3BKjtNnwCkl6uAQcnALYXxKaq1T5OBmDpUOeyeBvo1X12MKHI1mBz90+ZP
 wG8Pg1Rw13hKsQOtMwN1effM94VNym3wXfLn48+VUP/CGmqiIUXbf/21Y98A86gFWoOq
 X+zsPGh3kq380hNGSqAwYVGAPt5EDSx+v7WGJ/sB+ndQgN4xyQuJGpOguAKWReCcifY4
 g94D3rvrzoVAM5cRNEjloPIhD2L2RwY3P+6tX+EFzPIWg0VBsNXa2vd6zBIjtUD9e2cI
 zNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719360897; x=1719965697;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtlLaNBH/RbSlotEEbZpY7+zgKvTQho2Lbmamu2yflA=;
 b=wZC0KOJHDWWgdo37/8mZartgLU0sN7MJrgp11kvLCAR/sIdd5+BdJqJhz5ubOk7FH1
 zvUr3kTCpXLPH3kHH4amx+o56V8REJ/skjq3DIPv11l8qlnRMrWspUKiZbPuXFjMV0oe
 9m/B8GOTndS2wNt5wfqpGNk+T3pWFwfKi+Tl/AI2du4yJSikSlrHPpavO6vQDIMfBpI7
 OanlicvMrr2agzgdnkHsXKcsYopoI9jR3pj1BbSiVJLiwy4IWkM+RQA8nVy629vvzHmO
 sqYeN2KbBxZyCor/DUnj7adb2zOBJhTXAWVIuXF3NoZtGmm+Ul+Y1fsoiEFC6rB5kZM0
 atfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlkJ89GbDHig7RGwTEofvGihNi2VH1T41tQjvzDzQYDWYeAxKDGy6+AFjesCNTtCEzj3KkwtiTLx4JHv0swD3zr3lf3J0=
X-Gm-Message-State: AOJu0YzttXTokaf6hD+ARottvrO+x5DDswu/nxdBbD/88OAIMULjt93Z
 4Y5tZtybKmPVBsBvl1HzWTc8uoam1/0hzuQBBS4jrcf0gPo1yzO0fWJcDRpbPMqIvfAkm0xvwE/
 k1A2kXH2AbA3KJleKk84EEGCugmpwtpf/TotyfgIyF5PxMfpBGKk=
X-Google-Smtp-Source: AGHT+IGaQr2CmTJfMRAb0ZDgxI2m4hNF68Clz4thlMBXZ5rgoJuH0Kauotj6gBDpYBrxNr2/o80KX/xUDYR9VvS2Iko=
X-Received: by 2002:a17:907:c086:b0:a72:7a8c:9885 with SMTP id
 a640c23a62f3a-a727a8c99e1mr213620466b.63.1719359484007; Tue, 25 Jun 2024
 16:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240529234241.205053-1-salil.mehta@huawei.com>
 <20240602180241-mutt-send-email-mst@kernel.org>
 <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240605160327.3c71f4ab@imammedo.users.ipa.redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Wed, 26 Jun 2024 00:51:12 +0100
Message-ID: <CAJ7pxeYehVhPWfbEqRMMSCVHk31JQhtQhRSM_4e1WqBhqv0UHQ@mail.gmail.com>
Subject: Re: [PATCH V12 0/8] Add architecture agnostic code to support vCPU
 Hotplug
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, maz@kernel.org, jean-philippe@linaro.org, 
 jonathan.cameron@huawei.com, lpieralisi@kernel.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com, 
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev, 
 pbonzini@redhat.com, will@kernel.org, gshan@redhat.com, rafael@kernel.org, 
 alex.bennee@linaro.org, linux@armlinux.org.uk, darren@os.amperecomputing.com, 
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
 karl.heubaum@oracle.com, miguel.luis@oracle.com, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com, 
 maobibo@loongson.cn, lixianglai@loongson.cn, npiggin@gmail.com, 
 harshpb@linux.ibm.com, linuxarm@huawei.com
Content-Type: multipart/alternative; boundary="000000000000492ba6061bbf9379"
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--000000000000492ba6061bbf9379
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Igor,

On Wed, Jun 5, 2024 at 3:03=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:

> On Sun, 2 Jun 2024 18:03:05 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Thu, May 30, 2024 at 12:42:33AM +0100, Salil Mehta wrote:
> > > Virtual CPU hotplug support is being added across various
> architectures[1][3].
> > > This series adds various code bits common across all architectures:
> > >
> > > 1. vCPU creation and Parking code refactor [Patch 1]
> > > 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> > > 3. ACPI CPUs AML code change [Patch 4,5]
> > > 4. Helper functions to support unrealization of CPU objects [Patch 6,=
7]
> > > 5. Docs [Patch 8]
> > >
> > >
> > > Repository:
> > >
> > > [*] https://github.com/salil-mehta/qemu.git
> virt-cpuhp-armv8/rfc-v3.arch.agnostic.v12
> > >
> > > NOTE: This series is meant to work in conjunction with Architecture
> specific patch-set.
> > > For ARM, this will work in combination of the architecture specific
> part based on
> > > RFC V2 [1]. This architecture specific patch-set RFC V3 shall be
> floated soon and is
> > > present at below location
> > >
> > > [*]
> https://github.com/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v3-rc1
> > >
> >
> >
> > Igor plan to take a look?
>
> Yep, I plan to review it
>

A gentle reminder on this.

Thanks
Salil.


>
> >
> > > Revision History:
> > >
> > > Patch-set  V11 -> V12
> > > 1. Addressed Harsh Prateek Bora's (IBM) comment
> > >    - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu protoype header/
> > > 2. Added Zhao Liu's (Intel) Tested-by for whole series
> > >    - Qtest does not breaks on Intel platforms now.
> > > 3. Added Zhao Liu's (Intel) Reviewed-by for [PATCH V11 {1/8 - 3/8}]
> > > Link: https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/
> > > Link:
> https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78fa5edee@l=
inux.ibm.com/
> > >
> > > Patch-set  V10 -> V11
> > > 1. Addressed Nicholas Piggin's (IBM) comment
> > >    - moved the traces in kvm_unpark_vcpu and kvm_create_vcpu at the e=
nd
> > >    - Added the Reviewed-by Tag for [PATCH V10 1/8]
> > > 2.  Addressed Alex Benn=C3=A9e's (Linaro) comments
> > >    - Added a note explaining dependency of the [PATCH V10 7/8] on Arc=
h
> specific patch-set
> > > Link:
> https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com/
> > > Link:
> https://lore.kernel.org/qemu-devel/87frubi402.fsf@draig.linaro.org/
> > >
> > > Patch-set  V9 -> V10
> > > 1. Addressed Nicholas Piggin's (IBM) & Philippe Mathieu-Daud=C3=A9 (L=
inaro)
> comments
> > >    - carved out kvm_unpark_vcpu and added its trace
> > >    - Widened the scope of the kvm_unpark_vcpu so that it can be used
> by generic framework
> > >      being thought out
> > > Link:
> https://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta@hu=
awei.com/
> > > Link:
> https://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a36b63a@l=
inaro.org/
> > >
> > > Patch-set  V8 -> V9
> > > 1. Addressed Vishnu Pajjuri's (Ampere) comments
> > >    - Added kvm_fd to trace in kvm_create_vcpu
> > >    - Some clean ups: arch vcpu-id and sbd variable
> > >    - Added the missed initialization of cpu->gdb_num_regs
> > > 2. Addressed the commnet from Zhao Liu (Intel)
> > >    - Make initialization of CPU Hotplug state conditional
> (possible_cpu_arch_ids!=3DNULL)
> > > Link:
> https://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.mehta@hua=
wei.com/
> > >
> > > Patch-set V7 -> V8
> > > 1. Rebased and Fixed the conflicts
> > >
> > > Patch-set  V6 -> V7
> > > 1. Addressed Alex Benn=C3=A9e's comments
> > >    - Updated the docs
> > > 2. Addressed Igor Mammedov's comments
> > >    - Merged patches [Patch V6 3/9] & [Patch V6 7/9] with [Patch V6 4/=
9]
> > >    - Updated commit-log of [Patch V6 1/9] and [Patch V6 5/9]
> > > 3. Added Shaoqin Huang's Reviewed-by tags for whole series.
> > > Link:
> https://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.mehta@hua=
wei.com/
> > >
> > > Patch-set  V5 -> V6
> > > 1. Addressed Gavin Shan's comments
> > >    - Fixed the assert() ranges of address spaces
> > >    - Rebased the patch-set to latest changes in the qemu.git
> > >    - Added Reviewed-by tags for patches {8,9}
> > > 2. Addressed Jonathan Cameron's comments
> > >    - Updated commit-log for [Patch V5 1/9] with mention of trace even=
ts
> > >    - Added Reviewed-by tags for patches {1,5}
> > > 3. Added Tested-by tags from Xianglai Li
> > > 4. Fixed checkpatch.pl error "Qemu -> QEMU" in [Patch V5 1/9]
> > > Link:
> https://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@hua=
wei.com/
> > >
> > > Patch-set  V4 -> V5
> > > 1. Addressed Gavin Shan's comments
> > >    - Fixed the trace events print string for
> kvm_{create,get,park,destroy}_vcpu
> > >    - Added Reviewed-by tag for patch {1}
> > > 2. Added Shaoqin Huang's Reviewed-by tags for Patches {2,3}
> > > 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set
> > > 4. Dropped the ARM specific [Patch V4 10/10]
> > > Link:
> https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@hua=
wei.com/
> > >
> > > Patch-set  V3 -> V4
> > > 1. Addressed David Hilderbrand's comments
> > >    - Fixed the wrong doc comment of kvm_park_vcpu API prototype
> > >    - Added Reviewed-by tags for patches {2,4}
> > > Link:
> https://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@hua=
wei.com/
> > >
> > > Patch-set  V2 -> V3
> > > 1. Addressed Jonathan Cameron's comments
> > >    - Fixed 'vcpu-id' type wrongly changed from 'unsigned long' to
> 'integer'
> > >    - Removed unnecessary use of variable 'vcpu_id' in kvm_park_vcpu
> > >    - Updated [Patch V2 3/10] commit-log with details of
> ACPI_CPU_SCAN_METHOD macro
> > >    - Updated [Patch V2 5/10] commit-log with details of conditional
> event handler method
> > >    - Added Reviewed-by tags for patches {2,3,4,6,7}
> > > 2. Addressed Gavin Shan's comments
> > >    - Remove unnecessary use of variable 'vcpu_id' in kvm_par_vcpu
> > >    - Fixed return value in kvm_get_vcpu from -1 to -ENOENT
> > >    - Reset the value of 'gdb_num_g_regs' in
> gdb_unregister_coprocessor_all
> > >    - Fixed the kvm_{create,park}_vcpu prototypes docs
> > >    - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,10}
> > > 3. Addressed one earlier missed comment by Alex Benn=C3=A9e in RFC V1
> > >    - Added traces instead of DPRINTF in the newly added and some
> existing functions
> > > Link:
> https://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huaw=
ei.com/
> > >
> > > Patch-set V1 -> V2
> > > 1. Addressed Alex Benn=C3=A9e's comments
> > >    - Refactored the kvm_create_vcpu logic to get rid of goto
> > >    - Added the docs for kvm_{create,park}_vcpu prototypes
> > >    - Splitted the gdbstub and AddressSpace destruction change into
> separate patches
> > >    - Added Reviewed-by tags for patches {2,10}
> > > Link:
> https://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@hua=
wei.com/
> > >
> > > References:
> > >
> > > [1]
> https://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@hua=
wei.com/
> > > [2]
> https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> > > [3]
> https://lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongs=
on.cn/
> > >
> > >
> > >
> > > Salil Mehta (8):
> > >   accel/kvm: Extract common KVM vCPU {creation,parking} code
> > >   hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header
> file
> > >   hw/acpi: Update ACPI GED framework to support vCPU Hotplug
> > >   hw/acpi: Update GED _EVT method AML with CPU scan
> > >   hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
> > >   physmem: Add helper function to destroy CPU AddressSpace
> > >   gdbstub: Add helper function to unregister GDB register space
> > >   docs/specs/acpi_hw_reduced_hotplug: Add the CPU Hotplug Event Bit
> > >
> > >  accel/kvm/kvm-all.c                    | 95 +++++++++++++++++-------=
--
> > >  accel/kvm/kvm-cpus.h                   | 23 +++++++
> > >  accel/kvm/trace-events                 |  5 +-
> > >  docs/specs/acpi_hw_reduced_hotplug.rst |  3 +-
> > >  gdbstub/gdbstub.c                      | 13 ++++
> > >  hw/acpi/acpi-cpu-hotplug-stub.c        |  6 ++
> > >  hw/acpi/cpu.c                          | 33 ++++++---
> > >  hw/acpi/generic_event_device.c         | 21 ++++++
> > >  hw/core/cpu-common.c                   |  1 -
> > >  hw/i386/acpi-build.c                   |  3 +-
> > >  include/exec/cpu-common.h              |  8 +++
> > >  include/exec/gdbstub.h                 |  6 ++
> > >  include/hw/acpi/cpu.h                  |  5 +-
> > >  include/hw/acpi/cpu_hotplug.h          |  4 ++
> > >  include/hw/acpi/generic_event_device.h |  4 ++
> > >  include/hw/core/cpu.h                  |  1 +
> > >  system/physmem.c                       | 29 ++++++++
> > >  17 files changed, 212 insertions(+), 48 deletions(-)
> > >
> > > --
> > > 2.34.1
> >
>
>

--000000000000492ba6061bbf9379
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Igor,<br></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 5, 2024 at 3:03=
=E2=80=AFPM Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imamme=
do@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">On Sun, 2 Jun 2024 18:03:05 -0400<br>
&quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.com" target=
=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
<br>
&gt; On Thu, May 30, 2024 at 12:42:33AM +0100, Salil Mehta wrote:<br>
&gt; &gt; Virtual CPU hotplug support is being added across various archite=
ctures[1][3].<br>
&gt; &gt; This series adds various code bits common across all architecture=
s:<br>
&gt; &gt; <br>
&gt; &gt; 1. vCPU creation and Parking code refactor [Patch 1]<br>
&gt; &gt; 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]<=
br>
&gt; &gt; 3. ACPI CPUs AML code change [Patch 4,5]<br>
&gt; &gt; 4. Helper functions to support unrealization of CPU objects [Patc=
h 6,7]<br>
&gt; &gt; 5. Docs [Patch 8]<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Repository:<br>
&gt; &gt; <br>
&gt; &gt; [*] <a href=3D"https://github.com/salil-mehta/qemu.git" rel=3D"no=
referrer" target=3D"_blank">https://github.com/salil-mehta/qemu.git</a> vir=
t-cpuhp-armv8/rfc-v3.arch.agnostic.v12<br>
&gt; &gt; <br>
&gt; &gt; NOTE: This series is meant to work in conjunction with Architectu=
re specific patch-set.<br>
&gt; &gt; For ARM, this will work in combination of the architecture specif=
ic part based on<br>
&gt; &gt; RFC V2 [1]. This architecture specific patch-set RFC V3 shall be =
floated soon and is<br>
&gt; &gt; present at below location<br>
&gt; &gt; <br>
&gt; &gt; [*] <a href=3D"https://github.com/salil-mehta/qemu/tree/virt-cpuh=
p-armv8/rfc-v3-rc1" rel=3D"noreferrer" target=3D"_blank">https://github.com=
/salil-mehta/qemu/tree/virt-cpuhp-armv8/rfc-v3-rc1</a><br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; <br>
&gt; <br>
&gt; Igor plan to take a look?<br>
<br>
Yep, I plan to review it<br></blockquote><div><br></div><div>A gentle remin=
der on this.</div><div><br></div><div>Thanks</div><div>Salil.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; &gt; Revision History:<br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V11 -&gt; V12<br>
&gt; &gt; 1. Addressed Harsh Prateek Bora&#39;s (IBM) comment<br>
&gt; &gt;=C2=A0 =C2=A0 - Changed @cpu to @vcpu_id in the kvm_unpark_vcpu pr=
otoype header/<br>
&gt; &gt; 2. Added Zhao Liu&#39;s (Intel) Tested-by for whole series<br>
&gt; &gt;=C2=A0 =C2=A0 - Qtest does not breaks on Intel platforms now.<br>
&gt; &gt; 3. Added Zhao Liu&#39;s (Intel) Reviewed-by for [PATCH V11 {1/8 -=
 3/8}]<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/ZlRSPuJGBgyEU=
W6w@intel.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/qemu-devel/ZlRSPuJGBgyEUW6w@intel.com/</a><br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/a5f3d78e-cfed=
-441f-9c56-e3e78fa5edee@linux.ibm.com/" rel=3D"noreferrer" target=3D"_blank=
">https://lore.kernel.org/qemu-devel/a5f3d78e-cfed-441f-9c56-e3e78fa5edee@l=
inux.ibm.com/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V10 -&gt; V11<br>
&gt; &gt; 1. Addressed Nicholas Piggin&#39;s (IBM) comment<br>
&gt; &gt;=C2=A0 =C2=A0 - moved the traces in kvm_unpark_vcpu and kvm_create=
_vcpu at the end<br>
&gt; &gt;=C2=A0 =C2=A0 - Added the Reviewed-by Tag for [PATCH V10 1/8]<br>
&gt; &gt; 2.=C2=A0 Addressed Alex Benn=C3=A9e&#39;s (Linaro) comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Added a note explaining dependency of the [PATCH V=
10 7/8] on Arch specific patch-set<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/D1FS5GOOFWWK.=
2PNRIVL0V6DBL@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://lore=
.kernel.org/qemu-devel/D1FS5GOOFWWK.2PNRIVL0V6DBL@gmail.com/</a> <br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/87frubi402.fs=
f@draig.linaro.org/" rel=3D"noreferrer" target=3D"_blank">https://lore.kern=
el.org/qemu-devel/87frubi402.fsf@draig.linaro.org/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V9 -&gt; V10<br>
&gt; &gt; 1. Addressed Nicholas Piggin&#39;s (IBM) &amp; Philippe Mathieu-D=
aud=C3=A9 (Linaro) comments<br>
&gt; &gt;=C2=A0 =C2=A0 - carved out kvm_unpark_vcpu and added its trace<br>
&gt; &gt;=C2=A0 =C2=A0 - Widened the scope of the kvm_unpark_vcpu so that i=
t can be used by generic framework<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 being thought out<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2024051921062=
0.228342-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lore.kernel.org/qemu-devel/20240519210620.228342-1-salil.mehta@huawei=
.com/</a><br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/e94b0e14-efee=
-4050-9c9f-08382a36b63a@linaro.org/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lore.kernel.org/qemu-devel/e94b0e14-efee-4050-9c9f-08382a36b63a@lina=
ro.org/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V8 -&gt; V9<br>
&gt; &gt; 1. Addressed Vishnu Pajjuri&#39;s (Ampere) comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Added kvm_fd to trace in kvm_create_vcpu<br>
&gt; &gt;=C2=A0 =C2=A0 - Some clean ups: arch vcpu-id and sbd variable<br>
&gt; &gt;=C2=A0 =C2=A0 - Added the missed initialization of cpu-&gt;gdb_num=
_regs<br>
&gt; &gt; 2. Addressed the commnet from Zhao Liu (Intel)<br>
&gt; &gt;=C2=A0 =C2=A0 - Make initialization of CPU Hotplug state condition=
al (possible_cpu_arch_ids!=3DNULL)<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2024031202000=
0.12992-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20240312020000.12992-1-salil.mehta@huawei.c=
om/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set V7 -&gt; V8<br>
&gt; &gt; 1. Rebased and Fixed the conflicts<br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V6 -&gt; V7<br>
&gt; &gt; 1. Addressed Alex Benn=C3=A9e&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Updated the docs<br>
&gt; &gt; 2. Addressed Igor Mammedov&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Merged patches [Patch V6 3/9] &amp; [Patch V6 7/9]=
 with [Patch V6 4/9]<br>
&gt; &gt;=C2=A0 =C2=A0 - Updated commit-log of [Patch V6 1/9] and [Patch V6=
 5/9]=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; 3. Added Shaoqin Huang&#39;s Reviewed-by tags for whole series.<b=
r>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2023101310512=
9.25648-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20231013105129.25648-1-salil.mehta@huawei.c=
om/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V5 -&gt; V6<br>
&gt; &gt; 1. Addressed Gavin Shan&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Fixed the assert() ranges of address spaces<br>
&gt; &gt;=C2=A0 =C2=A0 - Rebased the patch-set to latest changes in the qem=
u.git<br>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tags for patches {8,9}<br>
&gt; &gt; 2. Addressed Jonathan Cameron&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Updated commit-log for [Patch V5 1/9] with mention=
 of trace events<br>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tags for patches {1,5}<br>
&gt; &gt; 3. Added Tested-by tags from Xianglai Li<br>
&gt; &gt; 4. Fixed <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" targ=
et=3D"_blank">checkpatch.pl</a> error &quot;Qemu -&gt; QEMU&quot; in [Patch=
 V5 1/9] <br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2023101119435=
5.15628-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20231011194355.15628-1-salil.mehta@huawei.c=
om/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V4 -&gt; V5<br>
&gt; &gt; 1. Addressed Gavin Shan&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Fixed the trace events print string for kvm_{creat=
e,get,park,destroy}_vcpu<br>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tag for patch {1}<br>
&gt; &gt; 2. Added Shaoqin Huang&#39;s Reviewed-by tags for Patches {2,3}<b=
r>
&gt; &gt; 3. Added Tested-by Tag from Vishnu Pajjuri to the patch-set<br>
&gt; &gt; 4. Dropped the ARM specific [Patch V4 10/10]<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2023100920360=
1.17584-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.c=
om/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V3 -&gt; V4<br>
&gt; &gt; 1. Addressed David Hilderbrand&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Fixed the wrong doc comment of kvm_park_vcpu API p=
rototype<br>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tags for patches {2,4}<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2023100911281=
2.10612-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20231009112812.10612-1-salil.mehta@huawei.c=
om/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set=C2=A0 V2 -&gt; V3<br>
&gt; &gt; 1. Addressed Jonathan Cameron&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Fixed &#39;vcpu-id&#39; type wrongly changed from =
&#39;unsigned long&#39; to &#39;integer&#39;<br>
&gt; &gt;=C2=A0 =C2=A0 - Removed unnecessary use of variable &#39;vcpu_id&#=
39; in kvm_park_vcpu<br>
&gt; &gt;=C2=A0 =C2=A0 - Updated [Patch V2 3/10] commit-log with details of=
 ACPI_CPU_SCAN_METHOD macro<br>
&gt; &gt;=C2=A0 =C2=A0 - Updated [Patch V2 5/10] commit-log with details of=
 conditional event handler method<br>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tags for patches {2,3,4,6,7}<br>
&gt; &gt; 2. Addressed Gavin Shan&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Remove unnecessary use of variable &#39;vcpu_id&#3=
9; in kvm_par_vcpu<br>
&gt; &gt;=C2=A0 =C2=A0 - Fixed return value in kvm_get_vcpu from -1 to -ENO=
ENT<br>
&gt; &gt;=C2=A0 =C2=A0 - Reset the value of &#39;gdb_num_g_regs&#39; in gdb=
_unregister_coprocessor_all<br>
&gt; &gt;=C2=A0 =C2=A0 - Fixed the kvm_{create,park}_vcpu prototypes docs<b=
r>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tags for patches {2,3,4,5,6,7,9,=
10}<br>
&gt; &gt; 3. Addressed one earlier missed comment by Alex Benn=C3=A9e in RF=
C V1<br>
&gt; &gt;=C2=A0 =C2=A0 - Added traces instead of DPRINTF in the newly added=
 and some existing functions<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2023093000193=
3.2660-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">http=
s://lore.kernel.org/qemu-devel/20230930001933.2660-1-salil.mehta@huawei.com=
/</a><br>
&gt; &gt; <br>
&gt; &gt; Patch-set V1 -&gt; V2<br>
&gt; &gt; 1. Addressed Alex Benn=C3=A9e&#39;s comments<br>
&gt; &gt;=C2=A0 =C2=A0 - Refactored the kvm_create_vcpu logic to get rid of=
 goto<br>
&gt; &gt;=C2=A0 =C2=A0 - Added the docs for kvm_{create,park}_vcpu prototyp=
es<br>
&gt; &gt;=C2=A0 =C2=A0 - Splitted the gdbstub and AddressSpace destruction =
change into separate patches<br>
&gt; &gt;=C2=A0 =C2=A0 - Added Reviewed-by tags for patches {2,10}<br>
&gt; &gt; Link: <a href=3D"https://lore.kernel.org/qemu-devel/2023092912430=
4.13672-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">htt=
ps://lore.kernel.org/qemu-devel/20230929124304.13672-1-salil.mehta@huawei.c=
om/</a><br>
&gt; &gt; <br>
&gt; &gt; References:<br>
&gt; &gt; <br>
&gt; &gt; [1] <a href=3D"https://lore.kernel.org/qemu-devel/20230926100436.=
28284-1-salil.mehta@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https=
://lore.kernel.org/qemu-devel/20230926100436.28284-1-salil.mehta@huawei.com=
/</a><br>
&gt; &gt; [2] <a href=3D"https://lore.kernel.org/all/20230913163823.7880-1-=
james.morse@arm.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.ker=
nel.org/all/20230913163823.7880-1-james.morse@arm.com/</a><br>
&gt; &gt; [3] <a href=3D"https://lore.kernel.org/qemu-devel/cover.169569770=
1.git.lixianglai@loongson.cn/" rel=3D"noreferrer" target=3D"_blank">https:/=
/lore.kernel.org/qemu-devel/cover.1695697701.git.lixianglai@loongson.cn/</a=
><br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Salil Mehta (8):<br>
&gt; &gt;=C2=A0 =C2=A0accel/kvm: Extract common KVM vCPU {creation,parking}=
 code<br>
&gt; &gt;=C2=A0 =C2=A0hw/acpi: Move CPU ctrl-dev MMIO region len macro to c=
ommon header file<br>
&gt; &gt;=C2=A0 =C2=A0hw/acpi: Update ACPI GED framework to support vCPU Ho=
tplug<br>
&gt; &gt;=C2=A0 =C2=A0hw/acpi: Update GED _EVT method AML with CPU scan<br>
&gt; &gt;=C2=A0 =C2=A0hw/acpi: Update CPUs AML with cpu-(ctrl)dev change<br=
>
&gt; &gt;=C2=A0 =C2=A0physmem: Add helper function to destroy CPU AddressSp=
ace<br>
&gt; &gt;=C2=A0 =C2=A0gdbstub: Add helper function to unregister GDB regist=
er space<br>
&gt; &gt;=C2=A0 =C2=A0docs/specs/acpi_hw_reduced_hotplug: Add the CPU Hotpl=
ug Event Bit<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 accel/kvm/kvm-all.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 95 +++++++++++++++++---------<br>
&gt; &gt;=C2=A0 accel/kvm/kvm-cpus.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 23 +++++++<br>
&gt; &gt;=C2=A0 accel/kvm/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
&gt; &gt;=C2=A0 docs/specs/acpi_hw_reduced_hotplug.rst |=C2=A0 3 +-<br>
&gt; &gt;=C2=A0 gdbstub/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 13 ++++<br>
&gt; &gt;=C2=A0 hw/acpi/acpi-cpu-hotplug-stub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 6 ++<br>
&gt; &gt;=C2=A0 hw/acpi/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 33 ++++++---<br>
&gt; &gt;=C2=A0 hw/acpi/generic_event_device.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 21 ++++++<br>
&gt; &gt;=C2=A0 hw/core/cpu-common.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 -<br>
&gt; &gt;=C2=A0 hw/i386/acpi-build.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +-<br>
&gt; &gt;=C2=A0 include/exec/cpu-common.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 8 +++<br>
&gt; &gt;=C2=A0 include/exec/gdbstub.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++<br>
&gt; &gt;=C2=A0 include/hw/acpi/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
&gt; &gt;=C2=A0 include/hw/acpi/cpu_hotplug.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++<br>
&gt; &gt;=C2=A0 include/hw/acpi/generic_event_device.h |=C2=A0 4 ++<br>
&gt; &gt;=C2=A0 include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt; &gt;=C2=A0 system/physmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 29 ++++++++<br>
&gt; &gt;=C2=A0 17 files changed, 212 insertions(+), 48 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; -- <br>
&gt; &gt; 2.34.1=C2=A0 <br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000492ba6061bbf9379--

