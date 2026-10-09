Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4FCA5FED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF4ji-0007hn-1U; Fri, 09 Oct 2026 03:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1xF4jb-0007gy-Si
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:09:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1xF4jX-0006ks-UN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 03:09:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e8246b13cbso9411415ad.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1791529769; x=1792134569; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=I74h8b9ot9KYn9HZMB8CMOqmHhf4HmjQEg53yZne/j0=;
 b=Cq2CwHMRHY4+Ta4S+n+i+UkEg5l9fnIVOYz6LTf+ag3VDmvBVRQ4hLq0BOwN5Vx3A3
 hJ2QkduNyClhyz/gLf+RZDTj5652RTpAFLxHFRq2ecKM6dy2LH6+a1Cll1DNprk1vMG7
 SjMvbSN6jNnuZE2XOtA0UbsVJEqv4pklG9ea7E6uB2eD39m5bG0Xpq3oVnzo5/LaFm5m
 4zAbgtfWHLvqcMnWHChf8ZznAokHiunaJQQI7WEIK9vw7wRsmLOxjFqOGrs3mbJYNZek
 LwuE7jFXfnyndIJW6l08cLHtai9/T9+vSUgL5+NF+fc1CRkfl12B3lqI/0B+YLvPhkmd
 Q1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529769; x=1792134569;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I74h8b9ot9KYn9HZMB8CMOqmHhf4HmjQEg53yZne/j0=;
 b=y7da/P9ajjVOfQJB9ou4fh4EsVIIuE9WL9yOVBvE9qRrYyu2YaImyew6eJQlX+d7hn
 nJBMaeSdi67ZsjlfgG3dkIhH1pin0BIJ0D/Gmtcc5TlIODnqjMchtE8T85NJrjpJ+LLi
 k6YEhe8lQ4QMKjZqwPmz5Mkia+FEgQMLgeAGPVLuOw05AN082j+lIIifDGYbBL4bFoO1
 VOOEYfMETU6W1bvnHnmYMZerkd8ztU1XsAK7bvBMbX1aux2aBVdUF+0h/jUv2b0zzpcQ
 012VQHKPo+vVGgJBkxuzLiUVB3So7667EIlJf05oHMiP1EwNcZJHdPA0WcY0CqF6jQmC
 iRjA==
X-Gm-Message-State: AFq9FYK8g/8C24nVsCMmj7S9N+tiqyRg5NNpyc+tbF0dE0yBADZh/tw5
 m0zgoSKU16TGn4Tnkf6ACM00/lzvDLHuiBAHyk9iUyk04ZjT4lqdanSmrofsSZAxX6Q=
X-Gm-Gg: AYBFou3SgXqD1zJiSCMFxIB2gwQRmGKL9B9HWjZehdVD2axSgOnl/EIo2utEU7f8OPL
 PRHl4ZtFBoxndMSoxERbypIXTjp28StZ98FbMvjwjGuHvP8OXXYNPS+N96KxDAbF0xSET7kVLRp
 DejmW48huzYOKp9ZtMMPEQ2y0DahB4OPYnA/v3OXbHlldQoG3NcZovYIz8eryVYoBAfzbM83Chv
 NSn72E0IwFghIjW/PjAc9xmNpLSkQe59Fifkmg7uS5wORgmfAKVLwyW+AEYkHOSGav0Qwexm6Ef
 Q6ocWinK5z9zErXiSKrFZKTrwY/eQCHRRJhIxxcq10N+ztRm04wNwaymVZgGOciWlvGkG6MzFka
 LD4K9PncmZ0/vxyaqvhP8+46Aa3MNHYRo4jWsp5KhhAz5T9Ateaici8eo8xH89cENPssP2GJUT3
 Bec1hveu0WJw8QkKFZ+/zpwZmVlrxbqvJdDQbImivfhkJ3PLPuHdqiOboMNCg6aRxT211v/L2HO
 XOfIcuzXGf6miyc2yr7AO4Tyw==
X-Received: by 2002:a17:903:41c3:b0:2e8:18ca:5f33 with SMTP id
 d9443c01a7336-2e842ab21f0mr9448555ad.28.1791529768403; 
 Fri, 09 Oct 2026 00:09:28 -0700 (PDT)
Received: from smtpclient.apple ([114.94.228.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e74asm4422805ad.29.2026.10.09.00.09.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 09 Oct 2026 00:09:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [External] [PATCH] target/riscv/kvm: Use the host AIA MSI ID limit
From: Qingwei Hu <qingwei.hu@bytedance.com>
In-Reply-To: <797fa41f-4f74-4228-ac9e-26955b0b32d2@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:09:11 +0800
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, sunilvl@ventanamicro.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 yongxuan.wang@sifive.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <258D1AC5-4877-49AA-8C9B-3BCBC4580AF2@bytedance.com>
References: <20260922122215.1619439-1-qingwei.hu@bytedance.com>
 <797fa41f-4f74-4228-ac9e-26955b0b32d2@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,

Apologies for the delayed reply; I overlooked your email. Thanks for
catching the non-KVM build issue. I missed updating kvm-stub.c.

Stefan's patchset also covers hosts that support only 63 guest interrupt
identities and includes the corresponding non-KVM stub changes. We are
coordinating on his series, and I have already provided review feedback.

I may follow up with additional changes on top of his series to allow
configuring more than 255 MSI IDs when the host supports it.

Best regards,
Qingwei Hu

> On Sep 26, 2026, at 03:38, Daniel Henrique Barboza =
<daniel.barboza@oss.qualcomm.com> wrote:
>=20
> Hello,
>=20
> If we try to build this patch in a non-KVM enviroment we'll have this =
error:
>=20
> FAILED: libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o
> cc -m64 -Ilibstubs_riscv.a.p -I. -I.. -I../common-user/host/x86_64 =
-I../linux-user/include/host/x86_64 -I../linux-user/include =
-Itarget/riscv -I../target/riscv -Iqapi -Itrace -Iui -Iui/shader =
-I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include =
-fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O0 =
-g -mcx16 -msse2 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 =
-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv =
-ftrivial-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr =
-fstack-protector-strong -Wempty-body -Wendif-labels =
-Wexpansion-to-defined -Wformat-overflow=3D2 -Wformat-security =
-Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthrough=3D2 -Winit-self =
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs =
-Wold-style-declaration -Wold-style-definition -Wredundant-decls =
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla =
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi =
-Wno-shift-negative-value -isystem =
/local/mnt/workspace/qemu/linux-headers -isystem linux-headers -iquote . =
-iquote /local/mnt/workspace/qemu -iquote =
/local/mnt/workspace/qemu/include -iquote =
/local/mnt/workspace/qemu/host/include/x86_64 -iquote =
/local/mnt/workspace/qemu/host/include/generic -iquote =
/local/mnt/workspace/qemu/tcg/x86_64 -pthread -fPIE -DCPU_DEFS_H =
-DCOMPILING_SYSTEM_VS_USER -DCONFIG_SOFTMMU -MD -MQ =
libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o -MF =
libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o.d -o =
libstubs_riscv.a.p/target_riscv_kvm_kvm-stub.c.o -c =
../target/riscv/kvm/kvm-stub.c
> ../target/riscv/kvm/kvm-stub.c:12:6: error: conflicting types for =
=E2=80=98kvm_riscv_aia_create=E2=80=99; have =E2=80=98void(MachineState =
*, uint64_t,  uint64_t,  uint64_t,  uint64_t,  uint64_t,  uint64_t)=E2=80=99=
 {aka =E2=80=98void(MachineState *, long unsigned int,  long unsigned =
int,  long unsigned int,  long unsigned int, long unsigned int,  long =
unsigned int)=E2=80=99}
>   12 | void kvm_riscv_aia_create(MachineState *machine, uint64_t =
group_shift,
>      |      ^~~~~~~~~~~~~~~~~~~~
> In file included from ../target/riscv/kvm/kvm-stub.c:10:
> /local/mnt/workspace/qemu/target/riscv/kvm/kvm_riscv.h:26:5: note: =
previous declaration of =E2=80=98kvm_riscv_aia_create=E2=80=99 with type
> int(uint64_t,  uint32_t *)=E2=80=99 {aka =E2=80=98int(long unsigned =
int,  unsigned int *)=E2=80=99}
>   26 | int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t =
*aia_msi_num);
>      |     ^~~~~~~~~~~~~~~~~~~~
> [1958/3154] Compiling C object =
libqemu-riscv64-softmmu.a.p/target_riscv_tcg_debug.c.o
>=20
>=20
> The reason is, down there ...
>=20
>=20
> On 9/22/2026 9:22 AM, Qingwei Hu wrote:
>> KVM initializes CONFIG_IDS to the number of guest MSI IDs supported =
by
>> the host. The virt machine currently overwrites it with the fixed
>> VIRT_IRQCHIP_NUM_MSIS value of 255, which can be inconsistent with =
the
>> host-supported guest MSI ID count.
>> Create the KVM AIA device before realizing the per-socket IMSICs and
>> read the host-provided CONFIG_IDS value. Use it to configure the QEMU
>> IMSIC devices and the guest-visible DT and ACPI descriptions. =
Complete
>> the remaining KVM AIA setup after all vCPUs have been created, as the
>> IMSIC address configuration depends on them.
>> Keep VIRT_IRQCHIP_NUM_MSIS as the default for non-KVM machines.
>> Fixes: 9634ef7eda5f ("target/riscv: Create an KVM AIA irqchip")
>> Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
>> ---
>>  hw/riscv/virt-acpi-build.c   |  4 +--
>>  hw/riscv/virt.c              | 28 ++++++++++++-----
>>  include/hw/riscv/virt.h      |  1 +
>>  target/riscv/kvm/kvm-cpu.c   | 59 =
+++++++++++++++++++++++-------------
>>  target/riscv/kvm/kvm_riscv.h |  9 +++---
>>  5 files changed, 66 insertions(+), 35 deletions(-)
>> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
>> index 8e516ec114..0ebfa10a02 100644
>> --- a/hw/riscv/virt-acpi-build.c
>> +++ b/hw/riscv/virt-acpi-build.c
>> @@ -576,9 +576,9 @@ static void build_madt(GArray *table_data,
>>          build_append_int_noprefix(table_data, 0, 1);        /* =
Reserved */
>>          build_append_int_noprefix(table_data, 0, 4);        /* Flags =
*/
>>          /* Number of supervisor mode Interrupt Identities */
>> -        build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_MSIS, =
2);
>> +        build_append_int_noprefix(table_data, s->num_msis, 2);
>>          /* Number of guest mode Interrupt Identities */
>> -        build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_MSIS, =
2);
>> +        build_append_int_noprefix(table_data, s->num_msis, 2);
>>          /* Guest Index Bits */
>>          build_append_int_noprefix(table_data, guest_index_bits, 1);
>>          /* Hart Index Bits */
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index d4b501802f..ba0e74ce83 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -277,7 +277,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>>              .imsic_m_base =3D !kvm_enabled() ? =
s->memmap[VIRT_IMSIC_M].base : 0,
>>              .imsic_s_base =3D s->memmap[VIRT_IMSIC_S].base,
>>              .imsic_group_max_size =3D VIRT_IMSIC_GROUP_MAX_SIZE,
>> -            .irqchip_num_msis =3D VIRT_IRQCHIP_NUM_MSIS,
>> +            .irqchip_num_msis =3D s->num_msis,
>>              .aia_guests =3D s->aia_guests
>>          };
>>  @@ -718,6 +718,7 @@ static void virt_machine_init(MachineState =
*machine)
>>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
>>      int i, base_hartid, hart_count;
>>      int socket_count =3D riscv_socket_count(machine);
>> +    int aia_fd =3D -1;
>>        s->memmap =3D virt_memmap;
>>  @@ -733,6 +734,16 @@ static void virt_machine_init(MachineState =
*machine)
>>          exit(1);
>>      }
>>  +    /*
>> +     * Create the KVM AIA device and query the host MSI ID count =
before
>> +     * realizing the per-socket IMSICs. Complete AIA initialization =
after
>> +     * all vCPUs have been created.
>> +     */
>> +    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) =
{
>> +        aia_fd =3D kvm_riscv_aia_create(VIRT_IRQCHIP_NUM_SOURCES,
>> +                                      &s->num_msis);
>> +    }
>> +
>>      /* Initialize sockets */
>>      mmio_irqchip =3D virtio_irqchip =3D pcie_irqchip =3D NULL;
>>      for (i =3D 0; i < socket_count; i++) {
>> @@ -826,7 +837,7 @@ static void virt_machine_init(MachineState =
*machine)
>>                                               =
&s->memmap[VIRT_IMSIC_M],
>>                                               =
&s->memmap[VIRT_IMSIC_S],
>>                                               i, base_hartid, =
hart_count,
>> -                                             VIRT_IRQCHIP_NUM_MSIS,
>> +                                             s->num_msis,
>>                                               =
VIRT_IRQCHIP_NUM_PRIO_BITS);
>>          }
>>  @@ -845,12 +856,12 @@ static void virt_machine_init(MachineState =
*machine)
>>          }
>>      }
>>  -    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) =
{
>> -        kvm_riscv_aia_create(machine, IMSIC_MMIO_GROUP_MIN_SHIFT,
>> -                             VIRT_IRQCHIP_NUM_SOURCES, =
VIRT_IRQCHIP_NUM_MSIS,
>> -                             s->memmap[VIRT_APLIC_S].base,
>> -                             s->memmap[VIRT_IMSIC_S].base,
>> -                             s->aia_guests);
>=20
> This call of kvm_riscv_aia_create(), even when guarded with a =
kvm_enabled(), needs to be
> visible to the compiler in a TCG only build.  We have a kvm-stub.c =
file that declares it
> like so:
>=20
> void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                          uint64_t aia_irq_num, uint64_t aia_msi_num,
>                          uint64_t aplic_base, uint64_t imsic_base,
>                          uint64_t guest_num)
> {
>    g_assert_not_reached();
> }
>=20
> Thus changing kvm_riscv_aia_create() requires a change in its kvm-stub =
as well.
>=20
>> +    if (aia_fd >=3D 0) {
>> +        kvm_riscv_aia_init(machine, aia_fd, =
IMSIC_MMIO_GROUP_MIN_SHIFT,
>> +                           VIRT_IRQCHIP_NUM_SOURCES,
>> +                           s->memmap[VIRT_APLIC_S].base,
>> +                           s->memmap[VIRT_IMSIC_S].base,
>> +                           s->aia_guests);
>>      }
>=20
> And a similar thing is needed here for kvm_riscv_aia_init(). We need a =
kvm-stub entry and it
> needs to be guarded with kvm_enabled() as well.
>=20
> We need something like this diff:
>=20
> $ git diff
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ba0e74ce83..4df8d7d441 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -856,7 +856,7 @@ static void virt_machine_init(MachineState =
*machine)
>         }
>     }
>=20
> -    if (aia_fd >=3D 0) {
> +    if (kvm_enabled() && aia_fd >=3D 0) {
>         kvm_riscv_aia_init(machine, aia_fd, =
IMSIC_MMIO_GROUP_MIN_SHIFT,
>                            VIRT_IRQCHIP_NUM_SOURCES,
>                            s->memmap[VIRT_APLIC_S].base,
> diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
> index 64e39c96d8..b7e6504f5f 100644
> --- a/target/riscv/kvm/kvm-stub.c
> +++ b/target/riscv/kvm/kvm-stub.c
> @@ -9,10 +9,15 @@
> #include "qemu/osdep.h"
> #include "target/riscv/kvm/kvm_riscv.h"
>=20
> -void kvm_riscv_aia_create(MachineState *machine, uint64_t =
group_shift,
> -                          uint64_t aia_irq_num, uint64_t aia_msi_num,
> -                          uint64_t aplic_base, uint64_t imsic_base,
> -                          uint64_t guest_num)
> +int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t *aia_msi_num)
> +{
> +    g_assert_not_reached();
> +}
> +
> +void kvm_riscv_aia_init(MachineState *machine, int aia_fd,
> +                        uint64_t group_shift, uint64_t aia_irq_num,
> +                        uint64_t aplic_base, uint64_t imsic_base,
> +                        uint64_t guest_num)
> {
>     g_assert_not_reached();
> }
>=20
>=20
> Code LGTM otherwise.  Booted a KVM aia guest and play with it a little =
bit
> without any hicups.
>=20
>=20
> Thanks,
> Daniel
> >
>>      if (riscv_is_32bit(&s->soc[0])) {
>> @@ -972,6 +983,7 @@ static void virt_machine_instance_init(Object =
*obj)
>>      s->acpi =3D ON_OFF_AUTO_AUTO;
>>      s->iommu_sys =3D ON_OFF_AUTO_AUTO;
>>      s->num_sources =3D VIRT_IRQCHIP_NUM_SOURCES;
>> +    s->num_msis =3D VIRT_IRQCHIP_NUM_MSIS;
>>  }
>>    static char *virt_get_aia_guests(Object *obj, Error **errp)
>> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
>> index e516898f9a..f64a2a3448 100644
>> --- a/include/hw/riscv/virt.h
>> +++ b/include/hw/riscv/virt.h
>> @@ -66,6 +66,7 @@ struct RISCVVirtState {
>>      OnOffAuto iommu_sys;
>>      uint16_t pci_iommu_bdf;
>>      uint16_t num_sources;
>> +    uint32_t num_msis;
>>  };
>>    enum {
>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>> index 68e1501b21..02af4e7723 100644
>> --- a/target/riscv/kvm/kvm-cpu.c
>> +++ b/target/riscv/kvm/kvm-cpu.c
>> @@ -1859,19 +1859,11 @@ void kvm_arch_accel_class_init(ObjectClass =
*oc)
>>                                      "auto");
>>  }
>>  -void kvm_riscv_aia_create(MachineState *machine, uint64_t =
group_shift,
>> -                          uint64_t aia_irq_num, uint64_t =
aia_msi_num,
>> -                          uint64_t aplic_base, uint64_t imsic_base,
>> -                          uint64_t guest_num)
>> +int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t =
*aia_msi_num)
>>  {
>> -    int ret, i;
>> -    int aia_fd =3D -1;
>> +    int ret;
>> +    int aia_fd;
>>      uint64_t default_aia_mode;
>> -    uint64_t socket_count =3D riscv_socket_count(machine);
>> -    uint64_t max_hart_per_socket =3D 0;
>> -    uint64_t socket, base_hart, hart_count, socket_imsic_base, =
imsic_addr;
>> -    uint64_t socket_bits, hart_bits, guest_bits;
>> -    uint64_t max_group_id;
>>        aia_fd =3D kvm_create_device(kvm_state, =
KVM_DEV_TYPE_RISCV_AIA, false);
>>  @@ -1903,6 +1895,41 @@ void kvm_riscv_aia_create(MachineState =
*machine, uint64_t group_shift,
>>          }
>>      }
>>  +    /*
>> +     * Get the maximum MSI ID supported by the host from the =
CONFIG_IDS
>> +     * attribute and use it for the guest-visible interrupt =
controller
>> +     * configuration.
>> +     */
>> +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>> +                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
>> +                            aia_msi_num, false, NULL);
>> +    if (ret < 0) {
>> +        error_report("KVM AIA: failed to get number of MSI IDs");
>> +        exit(1);
>> +    }
>> +
>> +    if (!kvm_kernel_irqchip_split() && *aia_msi_num < aia_irq_num) {
>> +        error_report("KVM AIA: host supports only %" PRIu32 " MSI =
IDs, "
>> +                     "but the virt machine requires at least %" =
PRIu64,
>> +                     *aia_msi_num, aia_irq_num);
>> +        exit(1);
>> +    }
>> +
>> +    return aia_fd;
>> +}
>> +
>> +void kvm_riscv_aia_init(MachineState *machine, int aia_fd,
>> +                        uint64_t group_shift, uint64_t aia_irq_num,
>> +                        uint64_t aplic_base, uint64_t imsic_base,
>> +                        uint64_t guest_num)
>> +{
>> +    int ret, i;
>> +    uint64_t socket_count =3D riscv_socket_count(machine);
>> +    uint64_t max_hart_per_socket =3D 0;
>> +    uint64_t socket, base_hart, hart_count, socket_imsic_base, =
imsic_addr;
>> +    uint64_t socket_bits, hart_bits, guest_bits;
>> +    uint64_t max_group_id;
>> +
>>      /*
>>       * Skip APLIC creation in KVM if we're running split mode.
>>       * This is done by leaving KVM_DEV_RISCV_AIA_CONFIG_SRCS
>> @@ -1927,15 +1954,6 @@ void kvm_riscv_aia_create(MachineState =
*machine, uint64_t group_shift,
>>          }
>>       }
>>  -    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>> -                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
>> -                            &aia_msi_num, true, NULL);
>> -    if (ret < 0) {
>> -        error_report("KVM AIA: failed to set number of msi");
>> -        exit(1);
>> -    }
>> -
>> -
>>      if (socket_count > 1) {
>>          max_group_id =3D socket_count - 1;
>>          socket_bits =3D find_last_bit(&max_group_id, BITS_PER_LONG) =
+ 1;
>> @@ -1987,7 +2005,6 @@ void kvm_riscv_aia_create(MachineState =
*machine, uint64_t group_shift,
>>          }
>>      }
>>  -
>>      if (max_hart_per_socket > 1) {
>>          max_hart_per_socket--;
>>          hart_bits =3D find_last_bit(&max_hart_per_socket, =
BITS_PER_LONG) + 1;
>> diff --git a/target/riscv/kvm/kvm_riscv.h =
b/target/riscv/kvm/kvm_riscv.h
>> index 61eaa12443..1499fb4487 100644
>> --- a/target/riscv/kvm/kvm_riscv.h
>> +++ b/target/riscv/kvm/kvm_riscv.h
>> @@ -23,10 +23,11 @@
>>    void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
>>  void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
>> -void kvm_riscv_aia_create(MachineState *machine, uint64_t =
group_shift,
>> -                          uint64_t aia_irq_num, uint64_t =
aia_msi_num,
>> -                          uint64_t aplic_base, uint64_t imsic_base,
>> -                          uint64_t guest_num);
>> +int kvm_riscv_aia_create(uint64_t aia_irq_num, uint32_t =
*aia_msi_num);
>> +void kvm_riscv_aia_init(MachineState *machine, int aia_fd,
>> +                        uint64_t group_shift, uint64_t aia_irq_num,
>> +                        uint64_t aplic_base, uint64_t imsic_base,
>> +                        uint64_t guest_num);
>>  void riscv_kvm_aplic_request(void *opaque, int irq, int level);
>>  bool kvm_riscv_has_mp_state(void);
>>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);



