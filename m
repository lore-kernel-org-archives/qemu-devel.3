Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793D1C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIZY-0004ep-KM; Wed, 26 Feb 2025 09:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnIZU-0004dg-3H; Wed, 26 Feb 2025 09:39:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tnIZM-0002vt-5w; Wed, 26 Feb 2025 09:39:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1BF255C4AED;
 Wed, 26 Feb 2025 14:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874B6C4CED6;
 Wed, 26 Feb 2025 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740580765;
 bh=PdfgDdLgn0IJXw0MEyFZqSpfBoy/QCZjj2OrYc2BhaM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EiuZnVdusmYzHSdb6I2fJJTx0wjQMJJg1KQ9ZIZRPuOpsCK1VdUgYWLRZXpmIEERt
 dvBG/PAIjDhM7kgaXkpcR4WImK8YNiJ41KRMU49S4fd7BbQ0fUM9iJ6xjW0pfTLuWY
 HODM8YlZNXTNOMQXlAOdTfNpf4wddkm1CFTDThQfZRcY3OoZLhjwD5vKuW7QRlDcSq
 p4rsWYtAxlrZpjIpsI/1jds7nbpNzIlc7dT9/gYQmJSTolV1U4lEEjTfGf5xqn1Kls
 3PkN+nw6fH8SreM5/DOar8Jm7cpHRyhk7FQ4F4kQn2C0+Q63isaM/DAhMNbgDLdNF1
 a1GPIvWh0D1DA==
Date: Wed, 26 Feb 2025 15:39:13 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250226153913.27255b1e@sal.lan>
In-Reply-To: <20250226151656.10665bc9@imammedo.users.ipa.redhat.com>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <20250226151656.10665bc9@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Wed, 26 Feb 2025 15:16:56 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 21 Feb 2025 15:35:09 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Now that the ghes preparation patches were merged, let's add support
> > for error injection.
> > 
> > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > table and hardware_error firmware file, together with its migration code. Migration tested
> > with both latest QEMU released kernel and upstream, on both directions.
> > 
> > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> >    to inject ARM Processor Error records.  
> 
> please, run ./scripts/checkpatch on patches before submitting them.
> as it stands now series cannot be merged due to failing checkpatch

Weird... checkpatch is at pre-commit hook, as recommended at QEMU 
documentation. It is actually a little harder to manage this way, as it 
sometimes cause troubles with binary files.

Anyway, I'll run it by hand before sending the next version.

> 
> > 
> > ---
> > v4:
> > - added an extra comment for AcpiGhesState structure;
> > - patches reordered;
> > - no functional changes, just code shift between the patches in this series.
> > 
> > v3:
> > - addressed more nits;
> > - hest_add_le now points to the beginning of HEST table;
> > - removed HEST from tests/data/acpi;
> > - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> > 
> > v2: 
> > - address some nits;
> > - improved ags cleanup patch and removed ags.present field;
> > - added some missing le*_to_cpu() calls;
> > - update date at copyright for new files to 2024-2025;
> > - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> > - added HEST and DSDT tables after the changes to make check target happy.
> >   (two patches: first one whitelisting such tables; second one removing from
> >    whitelist and updating/adding such tables to tests/data/acpi)
> > 
> > 
> > 
> > Mauro Carvalho Chehab (14):
> >   acpi/ghes: prepare to change the way HEST offsets are calculated
> >   acpi/ghes: add a firmware file with HEST address
> >   acpi/ghes: Use HEST table offsets when preparing GHES records
> >   acpi/ghes: don't hard-code the number of sources for HEST table
> >   acpi/ghes: add a notifier to notify when error data is ready
> >   acpi/ghes: create an ancillary acpi_ghes_get_state() function
> >   acpi/generic_event_device: Update GHES migration to cover hest addr
> >   acpi/generic_event_device: add logic to detect if HEST addr is
> >     available
> >   acpi/generic_event_device: add an APEI error device
> >   tests/acpi: virt: allow acpi table changes for a new table: HEST
> >   arm/virt: Wire up a GED error device for ACPI / GHES
> >   tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
> >   qapi/acpi-hest: add an interface to do generic CPER error injection
> >   scripts/ghes_inject: add a script to generate GHES error inject
> > 
> >  MAINTAINERS                                   |  10 +
> >  hw/acpi/Kconfig                               |   5 +
> >  hw/acpi/aml-build.c                           |  10 +
> >  hw/acpi/generic_event_device.c                |  43 ++
> >  hw/acpi/ghes-stub.c                           |   7 +-
> >  hw/acpi/ghes.c                                | 231 ++++--
> >  hw/acpi/ghes_cper.c                           |  38 +
> >  hw/acpi/ghes_cper_stub.c                      |  19 +
> >  hw/acpi/meson.build                           |   2 +
> >  hw/arm/virt-acpi-build.c                      |  37 +-
> >  hw/arm/virt.c                                 |  19 +-
> >  hw/core/machine.c                             |   2 +
> >  include/hw/acpi/acpi_dev_interface.h          |   1 +
> >  include/hw/acpi/aml-build.h                   |   2 +
> >  include/hw/acpi/generic_event_device.h        |   1 +
> >  include/hw/acpi/ghes.h                        |  54 +-
> >  include/hw/arm/virt.h                         |   2 +
> >  qapi/acpi-hest.json                           |  35 +
> >  qapi/meson.build                              |   1 +
> >  qapi/qapi-schema.json                         |   1 +
> >  scripts/arm_processor_error.py                | 476 ++++++++++++
> >  scripts/ghes_inject.py                        |  51 ++
> >  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
> >  target/arm/kvm.c                              |   7 +-
> >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
> >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
> >  29 files changed, 1677 insertions(+), 79 deletions(-)
> >  create mode 100644 hw/acpi/ghes_cper.c
> >  create mode 100644 hw/acpi/ghes_cper_stub.c
> >  create mode 100644 qapi/acpi-hest.json
> >  create mode 100644 scripts/arm_processor_error.py
> >  create mode 100755 scripts/ghes_inject.py
> >  create mode 100755 scripts/qmp_helper.py
> >   
> 

