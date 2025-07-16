Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41740C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0YB-0004tI-HY; Wed, 16 Jul 2025 07:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0WQ-0003hq-UH; Wed, 16 Jul 2025 07:42:03 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uc0WK-00053m-2g; Wed, 16 Jul 2025 07:42:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1752666075; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YPz3XUJenBbCOxUgY2lWK4jOaAbYc7Dm3o3LABOpiA9N7JAy+0wPzgx6lCCgQLIxXnAy5iDvc2vYntPTAqVEcrYoGHIgYxHB0MB5bc2AxYWeL5MYs5iXmnYKTXc5R1QStuMUyvbh5PXMdVu2yk2cmpeG9jQ6SmoHB0XXSjq1AAE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752666075;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=l2q8W/CL92JSNVH2L0zrZaYc6bImsqR1lzhthb27ALM=; 
 b=h3DfWMsTB7iSzTbovjtVgloHtmvjoOQck+oYwU8qAJgdHoWurfUhj8i1KPNQzoFCIb9ycZLm+3uOJ3ZR4HqNVBu0RiWOFD52Or+bI2Q/pfeiypXsCXuigfloZ5YZFSdIDk8Qb7bD6ssMt5sXvVG2Aa0BeGKL94x2R7YuYkDByaA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752666075; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=l2q8W/CL92JSNVH2L0zrZaYc6bImsqR1lzhthb27ALM=;
 b=Fkk6ymZhHoxwr19s1MFHHY+rviCLLfQ+FLkWJtTSv7WulKpCiumUkLR6S2W1QPoT
 /sObr9uE5FKsDQcyH3hzD60O/+tyK8qQqYgVWgPibXqpgvMnKCLKgGsTgE6LX510R1g
 Dts4b2dWaEqvs69BpOmnrB2g2wg8+4aCaH4fdYvc=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1752666071850223.43906210923728;
 Wed, 16 Jul 2025 04:41:11 -0700 (PDT)
Date: Wed, 16 Jul 2025 19:41:11 +0800
From: Li Chen <me@linux.beauty>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Igor Mammedov" <imammedo@redhat.com>, "Ani Sinha" <anisinha@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?=22Philippe_Mathieu-Daud=C3=A9=22?= <philmd@linaro.org>,
 "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Song Gao" <gaosong@loongson.cn>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Sunil V L" <sunilvl@ventanamicro.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Weiwei Li" <liwei1518@gmail.com>, "qemu-arm" <qemu-arm@nongnu.org>,
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>,
 "Li Chen" <chenl311@chinatelecom.cn>
Message-ID: <1981309e2fa.31709fd32611761.5900055972026140740@linux.beauty>
In-Reply-To: <20250714144303-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250528105404.457729-5-me@linux.beauty>
 <20250714144303-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH REPOST v4 4/4] acpi/virt: suppress UART device & SPCR
 when guest has no serial hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.12; envelope-from=me@linux.beauty;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Michael,

Thanks for your kind review! All issues below have been fixed in v5:
https://lore.kernel.org/qemu-devel/20250716111959.404917-5-me@linux.beauty/=
T/#m696cee9a95646add1b74b866c3d6761aa4c5c762

 ---- On Tue, 15 Jul 2025 02:45:31 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Wed, May 28, 2025 at 06:53:38PM +0800, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > The virt machines always instantiate a PL011/16550 at UART0 and
 > > describe it in ACPI (DSDT device node plus optional SPCR table).  When
 > > the command line contains =E2=80=9C-serial none=E2=80=9D there is no b=
ackend attached to
 > > that UART, yet the guest still discovers it via ACPI and may try to us=
e
 > > it as a console, causing unexpected results.
 > >=20
 > > And also explicitly add "-serial stdio" in bios-tables-test.c to allow
 > > serial device creation, otherwise DSDT assert would get failure becaus=
e
 > > "-nodefaults" will not create uart device by default:
 > >=20
 > > ```
 > > stderr:
 > > acpi-test: Warning! DSDT binary file mismatch. Actual [aml:/tmp/aml-BM=
OL72], Expected [aml:tests/data/acpi/aarch64/virt/DSDT].
 > > See source file tests/qtest/bios-tables-test.c for instructions on how=
 to update expected files.
 > > acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-RNOL72.dsl, am=
l:/tmp/aml-BMOL72], Expected [asl:/tmp/asl-ZVQL72.dsl, aml:tests/data/acpi/=
aarch64/virt/DS
 > > DT].
 > > ```
 > >=20
 > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
 >=20
 >=20
 > will need to be rebased updating loongarch too, now.
 >=20
 >=20
 > > ---
 > >=20
 > > Notes:
 > >     Changes since v3: 1. Add Reviewed-by from Sunil V L <sunilvl@venta=
namicro.com>
 > >                       2. Explicitly add "-serial stdio" to pass DSDT a=
ssert
 > >=20
 > >  hw/arm/virt-acpi-build.c       | 15 +++++++++------
 > >  hw/riscv/virt-acpi-build.c     |  7 +++++--
 > >  include/system/system.h        |  2 ++
 > >  system/vl.c                    |  5 +++++
 > >  tests/qtest/bios-tables-test.c |  5 +++--
 > >  5 files changed, 24 insertions(+), 10 deletions(-)
 > >=20
 > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
 > > index d77d16cbd3..c26aedb1b1 100644
 > > --- a/hw/arm/virt-acpi-build.c
 > > +++ b/hw/arm/virt-acpi-build.c
 > > @@ -59,6 +59,7 @@
 > >  #include "hw/acpi/viot.h"
 > >  #include "hw/virtio/virtio-acpi.h"
 > >  #include "target/arm/multiprocessing.h"
 > > +#include "system/system.h"
 > > =20
 > >  #define ARM_SPI_BASE 32
 > > =20
 > > @@ -821,11 +822,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r, VirtMachineState *vms)
 > >       */
 > >      scope =3D aml_scope("\\_SB");
 > >      acpi_dsdt_add_cpus(scope, vms);
 > > -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
 > > -                       (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
 > > -    if (vms->second_ns_uart_present) {
 > > -        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
 > > -                           (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
 > > +    if (serial_exist()) {
 > > +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0],
 > > +                           (irqmap[VIRT_UART0] + ARM_SPI_BASE), 0);
 > > +        if (vms->second_ns_uart_present) {
 > > +            acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
 > > +                               (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1=
);
 > > +        }
 > >      }
 > >      if (vmc->acpi_expose_flash) {
 > >          acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
 > > @@ -937,7 +940,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBu=
ildTables *tables)
 > > =20
 > >      acpi_add_table(table_offsets, tables_blob);
 > > =20
 > > -    if (ms->acpi_spcr_enabled) {
 > > +    if (ms->acpi_spcr_enabled && serial_exist()) {
 > >          spcr_setup(tables_blob, tables->linker, vms);
 > >      }
 > > =20
 > > diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
 > > index ee1416d264..80bf3c3cec 100644
 > > --- a/hw/riscv/virt-acpi-build.c
 > > +++ b/hw/riscv/virt-acpi-build.c
 > > @@ -39,6 +39,7 @@
 > >  #include "qapi/error.h"
 > >  #include "qemu/error-report.h"
 > >  #include "system/reset.h"
 > > +#include "system/system.h"
 > > =20
 > >  #define ACPI_BUILD_TABLE_SIZE             0x20000
 > >  #define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
 > > @@ -474,7 +475,9 @@ static void build_dsdt(GArray *table_data,
 > >                                   memmap[VIRT_APLIC_S].size, "RSCV0002=
");
 > >      }
 > > =20
 > > -    acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
 > > +    if (serial_exist())
 > > +        acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);
 > > +
 >=20
 > coding style violation
 >=20
 > >      if (virt_is_iommu_sys_enabled(s)) {
 > >          acpi_dsdt_add_iommu_sys(scope, &memmap[VIRT_IOMMU_SYS], IOMMU=
_SYS_IRQ);
 > >      }
 > > @@ -895,7 +898,7 @@ static void virt_acpi_build(RISCVVirtState *s, Acp=
iBuildTables *tables)
 > > =20
 > >      acpi_add_table(table_offsets, tables_blob);
 > > =20
 > > -    if (ms->acpi_spcr_enabled) {
 > > +    if (ms->acpi_spcr_enabled && serial_exist()) {
 > >          spcr_setup(tables_blob, tables->linker, s);
 > >      }
 > > =20
 > > diff --git a/include/system/system.h b/include/system/system.h
 > > index a7effe7dfd..ca1af38432 100644
 > > --- a/include/system/system.h
 > > +++ b/include/system/system.h
 > > @@ -75,6 +75,8 @@ extern unsigned int nb_prom_envs;
 > >  /* Return the Chardev for serial port i, or NULL if none */
 > >  Chardev *serial_hd(int i);
 > > =20
 > > +bool serial_exist(void);
 > > +
 > >  /* parallel ports */
 > > =20
 > >  #define MAX_PARALLEL_PORTS 3
 > > diff --git a/system/vl.c b/system/vl.c
 > > index fd402b8ff8..e340ee3a95 100644
 > > --- a/system/vl.c
 > > +++ b/system/vl.c
 > > @@ -1485,6 +1485,11 @@ Chardev *serial_hd(int i)
 > >      return NULL;
 > >  }
 > > =20
 > > +bool serial_exist(void)
 > > +{
 > > +    return serial_hd(0) ? true : false;
 > > +}
 > > +
 >=20
 > serial_exists
 >=20
 >=20
 > >  static bool parallel_parse(const char *devname, Error **errp)
 > >  {
 > >      static int index =3D 0;
 > > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-=
test.c
 > > index 44de152a36..452566fa86 100644
 > > --- a/tests/qtest/bios-tables-test.c
 > > +++ b/tests/qtest/bios-tables-test.c
 > > @@ -824,10 +824,11 @@ static char *test_acpi_create_args(test_data *da=
ta, const char *params)
 > >          /*
 > >           * TODO: convert '-drive if=3Dpflash' to new syntax (see e337=
63be7cd3)
 > >           * when arm/virt boad starts to support it.
 > > +         * NOTE: Explicitly add "-serial stdio" to enable uart in DSD=
T.
 > >           */
 > >          if (data->cd) {
 > >              args =3D g_strdup_printf("-machine %s%s %s -accel tcg "
 > > -                "-nodefaults -nographic "
 > > +                "-nodefaults -serial stdio -nographic "
 > >                  "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly=
=3Don "
 > >                  "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=
=3Don -cdrom %s %s",
 > >                  data->machine, data->machine_param ?: "",
 > > @@ -835,7 +836,7 @@ static char *test_acpi_create_args(test_data *data=
, const char *params)
 > >                  data->uefi_fl1, data->uefi_fl2, data->cd, params ? pa=
rams : "");
 > >          } else {
 > >              args =3D g_strdup_printf("-machine %s%s %s -accel tcg "
 > > -                "-nodefaults -nographic "
 > > +                "-nodefaults -serial stdio -nographic "
 > >                  "-drive if=3Dpflash,format=3Draw,file=3D%s,readonly=
=3Don "
 > >                  "-drive if=3Dpflash,format=3Draw,file=3D%s,snapshot=
=3Don %s",
 > >                  data->machine, data->machine_param ?: "",
 >=20
 >=20
 >=20
 >=20
 > > --=20
 > > 2.49.0
 >=20
 >=20
Regards,

Li=E2=80=8B


