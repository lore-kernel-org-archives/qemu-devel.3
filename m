Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403B0C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 07:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPG7u-0000LJ-Vn; Wed, 11 Jun 2025 03:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uPG7j-0000FF-OF; Wed, 11 Jun 2025 03:43:51 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@linux.beauty>)
 id 1uPG7h-0004yA-Jl; Wed, 11 Jun 2025 03:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1749627784; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gb/WbGgwbpzeKpANmFR4LYPZaFyhbGcEAhP9JWZ2VyP7uPI8DiV9iQextsIdbZSX78FtSXjfQl3AIeGu/8FnlH2JOaE2HuH2ZMgUbNoVD2suAO2xc7hNHfVXokGr6B8r1D9r51Hi1eXvX77UTwuPLhdRC8C5oKnvkJCgbYGMuZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1749627784;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3Uwhm8oxCUHFLAbGIqSbi6COCmFeWALYd7Q4GoMM1e4=; 
 b=V5L/xL6gVL7OEn1jSevleaiuVjUeLajtqZGG2X5GVcLQm+giHvc0KzIqeUyiMo5/cFjAswTaTTxJ6qPc0flG+URrfx9BAOw3gSlW9SEWYZSCfY3yNx2FJp7dxcGlnLhcy82nH+bT8+zz4noZeouJDJEE+6Hvl4tEwasX4+PpYmI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=linux.beauty;
 spf=pass  smtp.mailfrom=me@linux.beauty;
 dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749627784; 
 s=zmail; d=linux.beauty; i=me@linux.beauty;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=3Uwhm8oxCUHFLAbGIqSbi6COCmFeWALYd7Q4GoMM1e4=;
 b=O0XBIcI9XdX6U4DsdreDOQKykGI8qmCrsT6WGEQwVbNhlzikgf4XU3PQEAiM/Ws/
 GNTBP38TRIZHaZny9zqzYdSLdtuhJVrvHkaGVg386WQAVdQtuyKm42bTcJrrnuuL0Ft
 wb90ItabmhP0ilP+Hu1wL9CJu6eBPuuvWQNzwpd8=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1749627781743457.84030402502935;
 Wed, 11 Jun 2025 00:43:01 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:43:01 +0800
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
Message-ID: <1975df14254.befbf0eb40991.3434588463284220379@linux.beauty>
In-Reply-To: <20250530081034-mutt-send-email-mst@kernel.org>
References: <20250528105404.457729-1-me@linux.beauty>
 <20250530081034-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH REPOST v4 0/4] acpi: Add machine option to disable SPCR
 table
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

 ---- On Fri, 30 May 2025 20:10:52 +0800  Michael S. Tsirkin <mst@redhat.co=
m> wrote ---=20
 > On Wed, May 28, 2025 at 06:53:34PM +0800, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > (REPOST because the previous post failed to send to qemu-devel/qemu-ri=
scv/qemu-arm,
 > >  see https://lore.kernel.org/qemu-devel/1971648603b.dce1f5d22901195.67=
02025346547333607@linux.beauty/T/#u)
 > >=20
 > > This series introduces a new machine option, spcr=3Don|off, allowing u=
sers
 > > to disable the ACPI SPCR (Serial Port Console Redirection) table.
 > > By default, SPCR is enabled. Disabling it can help ensure that the gue=
st's
 > > console behavior is determined solely by kernel command-line parameter=
s
 > > on arch like arm64, avoiding unintended serial console configurations =
imposed
 > > by firmware.
 > >=20
 > > Also add tests on AArch64 and RISC-V virt machines using TCG and UEFI =
boot.
 > >=20
 > > Changes since v3:
 > > - Add Reviewed-by from Sunil V L <sunilvl@ventanamicro.com> for patch =
1, 3, and 4.
 > > - rename enable_spcr to acpi_spcr_enabled as suggested by Philippe Mat=
hieu-Daud=C3=A9.
 > > Changes since v2:
 > > - Omit UART device from DSDT and SPCR construction if no serial device=
 is present,
 > > as suggested by Philippe Mathieu-Daud=C3=A9.
 > > - Add Reviewed-by from Gavin Shan <gshan@redhat.com> for the first pat=
ch and fix style issue.
 > >=20
 > > Changes since v1:
 > > - Add bios-tables-test for RISC-V and ARM as suggested by
 > > - Add Acked-by from Michael S. Tsirkin for the first patch
 > > - Add Reviewed-by from Bibo Mao for the first patch
 > >=20
 > > Li Chen (4):
 > >   acpi: Add machine option to disable SPCR table
 > >   tests/qtest/bios-tables-test: Add test for disabling SPCR on AArch64
 > >   tests/qtest/bios-tables-test: Add test for disabling SPCR on RISC-V
 > >   acpi/virt: suppress UART device & SPCR when guest has no serial
 > >     hardware
 >=20
 > Who's merging this?
=20
Sorry for the late reply.

If I understand correctly, you are asking who can merge this series?

Per get_maintainer result:

firstlove@archlinux ~/p/qemu (spcr)> ./scripts/get_maintainer.pl *.patch
./scripts/get_maintainer.pl: file 'v4-0000-cover-letter.patch' doesn't appe=
ar to be a patch.  Add -f to options?
Peter Maydell <peter.maydell@linaro.org> (maintainer:Virt)
Shannon Zhao <shannon.zhaosl@gmail.com> (maintainer:ARM ACPI Subsystem)

I think Peter Maydell and Shannon Zhao would be the appropriate maintainers=
 to merge it.

If this is not what you meant, please correct me.

Regards,
Li

