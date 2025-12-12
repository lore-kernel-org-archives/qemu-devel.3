Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C76D41D74
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 02:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTsTi-0003o4-8P; Thu, 11 Dec 2025 21:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTsTZ-0003mm-U6; Thu, 11 Dec 2025 21:01:47 -0500
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1vTsTW-0004wy-7X; Thu, 11 Dec 2025 21:01:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765504870; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=P48HZelYdJWeUFMQeDXJL2lVXV9Q+9N/E8KRFCG5NpRfCPY8D3PndHFe/GBF1cZyIAARhMO2HXkG5rUX15IQ/9hhru5hXwDiJ+/vZ8giFo5ivzyrJ9MZcv+ULDauKW1bLZ1Rv88Mh6/ZG/KoCuhPdFw8LVFx6497xXEXULudvgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765504870;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BI+pRZalyp2ms+WUxMoxZBRwrpuWT8mgLszFwAfR1Sk=; 
 b=UIJuCnm0x5vArBdkp8mT9AJrGfpcpin5ToFw4KT2S/mxdomCwhc1ICi40PCGMA/m8YCNp2htZBX4jTe+BIQVr9FC8z5zVEWrxrevNbrAeAP1XiOwn+ISD3iL/hqd3qIeuaZWoi4KrM/vmTRF0jqXcy6zGBYUsk6tw8qWXuyM2hw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765504870; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=BI+pRZalyp2ms+WUxMoxZBRwrpuWT8mgLszFwAfR1Sk=;
 b=LidtcTkZRo9iMEzWuMyzm6eOTHIfOq49BTrZRM2LHwqqmcdSKSLo6LdWKlO4f3UK
 hD1/G5gpjR8nNqSIH6E7YbBsz+9KBZpwmaOz8LrHjmvkhrxTfawtbhBxJ7do1v9MstY
 JqeYZGkjeKSn/PBSsKkX3S5byNq8lhPDgIIfHD8w=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1765504868751451.3864020804491;
 Thu, 11 Dec 2025 18:01:08 -0800 (PST)
Date: Fri, 12 Dec 2025 10:01:08 +0800
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
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <19b104a617e.133b3feb891309.6986511857690603518@linux.beauty>
In-Reply-To: <20251211080811-mutt-send-email-mst@kernel.org>
References: <20251211102025.873506-1-me@linux.beauty>
 <20251211080811-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest
 has no serial hardware
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

Hi Michael,

 ---- On Thu, 11 Dec 2025 21:10:18 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Thu, Dec 11, 2025 at 06:20:25PM +0800, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > virt machines always instantiate a PL011/16550 UART at slot 0 and desc=
ribe
 > > it in ACPI (DSDT and optional SPCR table). When the command line disab=
les
 > > the serial backend (e.g. "-serial none"), the guest still sees the UAR=
T as
 > > a preferred console even though it is not usable.
 > >=20
 > > Teach the virt ACPI code to omit the UART device and SPCR when there i=
s no
 > > serial backend attached. This matches the hardware that the guest can
 > > actually use and avoids confusing firmware or OS code that relies on S=
PCR.
 > >=20
 > > The bios-tables-test qtests rely on an ACPI UART node and SPCR entry f=
or
 > > UEFI-based virt machines. To keep those tests working we create a UART
 > > with a "null" chardev backend instead. This preserves the ACPI tables
 > > while discarding the firmware's serial output so it does not corrupt t=
he
 > > TAP stdout stream.
 > >=20
 > > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
 > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
 > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
 >=20
 > This bothers me:
 > won't this mean number of serial devices changes silently?  So for
 > example, if you install a guest, see that 1st serial device is broken,
 > configure it with 2nd one as a work around, now with your change there
 > is no second one so guest will be broken?
 >=20
 >=20
 > I seems safer to have compat machinery around and avoid
 > changing this for old machine types.
=20
Thanks for pointing this out, you=E2=80=99re right that changing the number=
 of serial=20
devices that the guest sees is risky for existing machine types.

For v7 I=E2=80=99m planning to take a more conservative approach and only g=
ate SPCR
on the presence of a backend for the primary UART, while  keeping the ACPI
UART devices in DSDT unchanged.=20
Concretely:
- virt ACPI DSDT will continue to unconditionally describe the UART(s) as b=
efore,
   so the guest-visible UART topology doesn=E2=80=99t change for existing v=
irt-* machines.
- We only call spcr_setup() when there is a backend attached to UART0 (e.g.=
 serial_hd(0) !=3D NULL),
  so SPCR doesn=E2=80=99t point at a completely unusable console when the u=
ser passes -serial none.

In particular, for a command line like -serial none -serial pty, this means=
 SPCR would not be present
(rather than silently switching it to UART1/pty). My reasoning is that, for=
 existing virt machines,
SPCR is meant to describe =E2=80=9Cthe board=E2=80=99s primary console (UAR=
T0)=E2=80=9D, not =E2=80=9Cthe first UART that happens
to have a host backend=E2=80=9D, and changing that interpretation feels lik=
e it would need compat machinery
and a new machine type.

The qtests already force -serial null for the UEFI-based virt tests, so the=
y will still exercise the SPCR path.

Would this behaviour be acceptable for you, or would you prefer that I go f=
urther and also add a compat
flag/new machine type where SPCR can follow =E2=80=9Cthe first UART with a =
backend=E2=80=9D while old virt-* machines
keep the current UART/SPCR semantics?

Regards,
Li=E2=80=8B


