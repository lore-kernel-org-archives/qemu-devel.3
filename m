Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E15C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDQn-0002au-SB; Wed, 28 May 2025 05:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uKDQl-0002Zp-Tu; Wed, 28 May 2025 05:50:39 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uKDQj-0004u2-UQ; Wed, 28 May 2025 05:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1748425803; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JYV+J/UBxJb79t6mIF20Ab0yeUnnP+SPcUKbLktZHuqb1gAhvy50EGbrmUgumq8BlcLOU/mXD8EFo9KaYGpM8/Cy2/QlX7cpIZvvPTstkAEExC1/4S8DtMMPF9/1OSYGIqsRlj0IlS9IM44B0A7fiHOVHtb6GAYBM6pMjzMUUzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1748425803;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=pcnvZ6DV6S9UHv4gn1yNVYVdMQwWiU6SOJcaofoRUK8=; 
 b=hFNjEiiLSgtA5zFySbTSVOOw1BxA/5BdiuWak0rvqk4jgyNuwXU+ZH8fHEiiXuqMQpZdwBswa9XHipEgV+d5GlNiaMYbGyQwCbnfk2/rbwbkiM1OrKg0s5ULMq4L3qYghe9CxIrbkwMg0rIEvfVcUrAnuU2QYUPP5/sj+v/r+XQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748425803; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=pcnvZ6DV6S9UHv4gn1yNVYVdMQwWiU6SOJcaofoRUK8=;
 b=V4eLZVQGJWH9Mh+UQyL41l3JBpYZqDORuRm5q90zZuSU2d62mlNu8OYt953LKCbU
 fhDjm69ZjyPLGfwiz3smEFoiMFtiJqqqNJuA4FJVQGPV6v8IrPMI0cQZ7FaPCowqWK4
 eN6OFdCNL3GJxa8JUBDtQJgEP1UyA6b3XPDMD7jI=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1748425801779461.16107543205385;
 Wed, 28 May 2025 02:50:01 -0700 (PDT)
Date: Wed, 28 May 2025 17:50:01 +0800
From: Li Chen <me@linux.beauty>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
 "qemu-devel" <qemu-devel@nongnu.org>,
 "qemu-riscv""" <qemu-riscv@nongnu.org>
Message-ID: <197164c8016.ca5cc4652902988.7034689946931257388@linux.beauty>
In-Reply-To: <20250528080950.443075-1-me@linux.beauty>
References: <20250528080950.443075-1-me@linux.beauty>
Subject: Re: [PATCH v4 0/4] acpi: Add machine option to disable SPCR table
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series failed to send to qemu-devel/qemu-arm/qemu-riscv. I have reques=
ted assistance via this thread:=20
https://lore.kernel.org/qemu-devel/1971648603b.dce1f5d22901195.670202534654=
7333607@linux.beauty/T/#u

 ---- On Wed, 28 May 2025 16:09:36 +0800  Li Chen <me@linux.beauty> wrote -=
--=20
 > From: Li Chen <chenl311@chinatelecom.cn>
 >=20
 > This series introduces a new machine option, spcr=3Don|off, allowing use=
rs
 > to disable the ACPI SPCR (Serial Port Console Redirection) table.
 > By default, SPCR is enabled. Disabling it can help ensure that the guest=
's
 > console behavior is determined solely by kernel command-line parameters
 > on arch like arm64, avoiding unintended serial console configurations im=
posed
 > by firmware.
 >=20
 > Also add tests on AArch64 and RISC-V virt machines using TCG and UEFI bo=
ot.
 >=20
 > Changes since v3:=20
 > - Add Reviewed-by from  Sunil V L <sunilvl@ventanamicro.com> for patch 1=
, 3, and 4.
 > - rename enable_spcr to acpi_spcr_enabled as suggested by Philippe Mathi=
eu-Daud=C3=A9.
 > Changes since v2:
 > - Omit UART device from DSDT and SPCR construction if no serial device i=
s present,
 > as suggested by Philippe Mathieu-Daud=C3=A9.
 > - Add Reviewed-by from Gavin Shan <gshan@redhat.com> for the first patch=
 and fix style issue.
 >=20
 > Changes since v1:
 > - Add bios-tables-test for RISC-V and ARM as suggested by
 > - Add Acked-by from Michael S. Tsirkin for the first patch
 > - Add Reviewed-by from Bibo Mao for the first patch
 >=20
 > Li Chen (4):
 >   acpi: Add machine option to disable SPCR table
 >   tests/qtest/bios-tables-test: Add test for disabling SPCR on AArch64
 >   tests/qtest/bios-tables-test: Add test for disabling SPCR on RISC-V
 >   acpi/virt: suppress UART device & SPCR when guest has no serial
 >     hardware
 >=20
 >  hw/arm/virt-acpi-build.c       | 18 ++++++++-----
 >  hw/core/machine.c              | 22 ++++++++++++++++
 >  hw/loongarch/virt-acpi-build.c |  4 ++-
 >  hw/riscv/virt-acpi-build.c     | 10 ++++++--
 >  include/hw/boards.h            |  1 +
 >  include/system/system.h        |  2 ++
 >  qemu-options.hx                |  5 ++++
 >  system/vl.c                    |  5 ++++
 >  tests/qtest/bios-tables-test.c | 47 ++++++++++++++++++++++++++++++++--
 >  9 files changed, 103 insertions(+), 11 deletions(-)
 >=20
 > --=20
 > 2.49.0
 >=20
 >=20

Regards,
Li

