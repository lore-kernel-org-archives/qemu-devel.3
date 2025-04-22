Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C23DC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7DLg-0004Ac-G4; Tue, 22 Apr 2025 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7CMb-0007Vs-Hj; Tue, 22 Apr 2025 08:04:33 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1u7CMY-0002RH-Rc; Tue, 22 Apr 2025 08:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1745323435; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bb456hvd633zPGzjN5yBea8aFb/RnFn/Jbq7I5I1nDoEY3NMWe2tP/tTKiaT25F9/jpZHoiCh74nZ9mfJT/m+EBsHaDrA5C5SPCstaIgbTSay/wERoBMkAcKNmd0ONqifutzJzV3h3tOJpERdtqE9FQAhuXivkg9DXlTc/nHzT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1745323435;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=VHkIm9+oGJBREU3SyojuKFjCcFay6mh7tQU94xDAjS8=; 
 b=Mc9YbK82muVMh1jmBt0g/DsKTPShgPWOj7ErAMHK9ekdrp6nPKPESONF+hBeqCZHXxiIKzSp48fblu7rVPGVqgqU3EteOJTEu0+Lg0d2l1ce8hwfY8REuGackKmOl9n6vh91IYVliv1tbvGholhxKP+d0bo9jpYzLVyLzyHLxyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745323435; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=VHkIm9+oGJBREU3SyojuKFjCcFay6mh7tQU94xDAjS8=;
 b=Oxub0mTVc6kbSJEBWrHX/qdjxmt1WjQ5mvjE0uSddoYPPY7x1rpxV/jHtWidKCZw
 KwsYtBSOhZ86WcaNFJ6uM3wgux4SbtAMg6AfGKoPY6VwSrT5NndFwVb4NajP3Ktginh
 vwzT2YYtvHzfnmbYZQsNQalhOEoGex3OCWYxs8cQ=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1745323433590387.1972510239689;
 Tue, 22 Apr 2025 05:03:53 -0700 (PDT)
Date: Tue, 22 Apr 2025 20:03:53 +0800
From: Li Chen <me@linux.beauty>
To: "Li Chen" <me@linux.beauty>, "Peter Maydell" <peter.maydell@linaro.org>,
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
 "qemu-devel" <qemu-devel@nongnu.org>, "qemu-riscv" <qemu-riscv@nongnu.org>
Message-ID: <1965d621e25.fafa759e911037.825810937022699867@linux.beauty>
In-Reply-To: 
Subject: [PATCH V2 0/3] acpi: Add machine option to disable SPCR table
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Received-SPF: pass client-ip=136.143.188.15; envelope-from=me@linux.beauty;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 22 Apr 2025 09:07:38 -0400
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

This series introduces a new machine option, spcr=3Don|off, allowing users
to disable the ACPI SPCR (Serial Port Console Redirection) table.
By default, SPCR is enabled. Disabling it can help ensure that the guest's
console behavior is determined solely by kernel command-line parameters
on arch like arm64, avoiding unintended serial console configurations impos=
ed
 by firmware.

Also add tests on AArch64 and RISC-V virt machines using TCG and UEFI boot.

Changes since v1:
- Add bios-tables-test for RISC-V and ARM as suggested by=20
- Add Acked-by from Michael S. Tsirkin for the first patch
- Add Reviewed-by from Bibo Mao for the first patch

Li Chen (3):
  acpi: Add machine option to disable SPCR table as suggested by Philippe M=
athieu-Daud=C3=A9
  tests/qtest/bios-tables-test: Add test for disabling SPCR on AArch64
  tests/qtest/bios-tables-test: Add test for disabling SPCR on RISC-V

 hw/arm/virt-acpi-build.c       |  5 +++-
 hw/core/machine.c              | 22 ++++++++++++++++++
 hw/loongarch/virt-acpi-build.c |  4 +++-
 hw/riscv/virt-acpi-build.c     |  5 +++-
 include/hw/boards.h            |  1 +
 qemu-options.hx                |  5 ++++
 tests/qtest/bios-tables-test.c | 42 ++++++++++++++++++++++++++++++++++
 7 files changed, 81 insertions(+), 3 deletions(-)

--=20
2.49.0



