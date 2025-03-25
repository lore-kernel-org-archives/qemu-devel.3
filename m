Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8539C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtWM-000322-QP; Mon, 24 Mar 2025 21:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1twtWJ-00031F-Cv; Mon, 24 Mar 2025 21:55:59 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1twtWH-0000iA-5x; Mon, 24 Mar 2025 21:55:59 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 969F5615EE;
 Tue, 25 Mar 2025 01:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEC6C4CEDD;
 Tue, 25 Mar 2025 01:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742867748;
 bh=z+Wk5IOn8VAQYfBz4WAglsmF7LsYJkY/3Dz5LBKsXM4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MB9dJaYHD69rttkB55fX1MpeO+qMHYheWWeLHl7gXSQ0SjdGHf5q33wucdlxtv7tt
 ZbmBY2kxkdK1SdyoVdFMfGE+/Bad7HIJEtmQ73dFTIcRhZOo3XURi1hXMjbVhnwy29
 PKD4Z7OvZ8WHYN1biIRho/k6kwBi608gYyUWgIdZwNB94oIPHGpzv1A7O+3Pi8asfj
 CJTi5d3iNDH9QVzY//nWqAEs6jA3wtEIhHcbgD57WD9oi8/CHTVdmTJyMgQwIewb5G
 AX24T8slszXJL5JDpTUiWns8RfVW7qJjwI+5C8J9GiHuTmHjZEDbSXa18mU2GB/qdn
 vCBmiSwDnTgcw==
Date: Tue, 25 Mar 2025 09:55:22 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Gavin Shan
 <gshan@redhat.com>, Ani Sinha <anisinha@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, John Snow
 <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/20] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250325095522.335112ba@sal.lan>
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Gentile ping.

Regards,
Mauro

Em Fri,  7 Mar 2025 20:14:29 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Hi Michael,
> 
> I'm sending v8 to avoid a merge conflict with v7 due to this
> changeset:
> 
>    611f3bdb20f7 ("hw/acpi/ghes: Make  static")
> 
> As ghes_record_cper_errors() was written since the beginning
> to be public and used by ghes-cper.c. It ended being meged
> earlier because the error-injection series become too big,
> so it was decided last year to split in two to make easier for
> reviewers and maintainers to discuss.
> 
> Anyway, as mentioned on v7, I guess we're ready to merge this
> series, as patches here have been thoughfully reviewed mainly 
> by Igor and Jonathan over the last 5-6 months.
> 
> The only change from v7 is a minor editorial change at HEST doc
> spec, and the addition of Igor and Jonathan's A-B/R-B.
> 
> This series change the way HEST table offsets are calculated,
> making them identical to what an OSPM would do and allowing
> multiple HEST entries without causing migration issues. It open
> space to add HEST support for non-arm architectures, as now
> the number and type of HEST notification entries are not
> hardcoded at ghes.c. Instead, they're passed as a parameter
> from the arch-dependent init code.
> 
> With such issue addressed, it adds a new notification type and
> add support to inject errors via a Python script. The script
> itself is at the final patch.
> 
> ---
> v8:
>   - added a patch to revert recently-added changeset causing a
>     conflict with these. All remaining patches are identical.
> 
> v7:
>   - minor editorial change at the patch updating HEST doc spec
>    with the new workflow
> 
> v6:
> - some minor nits addressed:
>    - use GPA instead of offset;
>    - merged two patches;
>    - fixed a couple of long line coding style issues;
>    - the HEST/DSDT diff inside a patch was changed to avoid troubles
>      applying it.
> 
> v5:
> - make checkpatch happier;
> - HEST table is now tested;
> - some changes at HEST spec documentation to align with code changes;
> - extra care was taken with regards to git bisectability.
> 
> v4:
> - added an extra comment for AcpiGhesState structure;
> - patches reordered;
> - no functional changes, just code shift between the patches in this series.
> 
> v3:
> - addressed more nits;
> - hest_add_le now points to the beginning of HEST table;
> - removed HEST from tests/data/acpi;
> - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> 
> v2: 
> - address some nits;
> - improved ags cleanup patch and removed ags.present field;
> - added some missing le*_to_cpu() calls;
> - update date at copyright for new files to 2024-2025;
> - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> - added HEST and DSDT tables after the changes to make check target happy.
>   (two patches: first one whitelisting such tables; second one removing from
>    whitelist and updating/adding such tables to tests/data/acpi)
> 
> Mauro Carvalho Chehab (20):
>   tests/acpi: virt: add an empty HEST file
>   tests/qtest/bios-tables-test: extend to also check HEST table
>   tests/acpi: virt: update HEST file with its current data
>   Revert "hw/acpi/ghes: Make ghes_record_cper_errors() static"
>   acpi/ghes: Cleanup the code which gets ghes ged state
>   acpi/ghes: prepare to change the way HEST offsets are calculated
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/ghes: don't hard-code the number of sources for HEST table
>   acpi/ghes: add a notifier to notify when error data is ready
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   acpi/generic_event_device: add an APEI error device
>   tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
>   arm/virt: Wire up a GED error device for ACPI / GHES
>   qapi/acpi-hest: add an interface to do generic CPER error injection
>   acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
>   tests/acpi: virt: update HEST and DSDT tables
>   docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
>   scripts/ghes_inject: add a script to generate GHES error inject
> 
>  MAINTAINERS                                   |  10 +
>  docs/specs/acpi_hest_ghes.rst                 |  28 +-
>  hw/acpi/Kconfig                               |   5 +
>  hw/acpi/aml-build.c                           |  10 +
>  hw/acpi/generic_event_device.c                |  44 ++
>  hw/acpi/ghes-stub.c                           |   7 +-
>  hw/acpi/ghes.c                                | 233 ++++--
>  hw/acpi/ghes_cper.c                           |  38 +
>  hw/acpi/ghes_cper_stub.c                      |  19 +
>  hw/acpi/meson.build                           |   2 +
>  hw/arm/virt-acpi-build.c                      |  35 +-
>  hw/arm/virt.c                                 |  19 +-
>  hw/core/machine.c                             |   2 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/aml-build.h                   |   2 +
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/acpi/ghes.h                        |  51 +-
>  include/hw/arm/virt.h                         |   2 +
>  qapi/acpi-hest.json                           |  35 +
>  qapi/meson.build                              |   1 +
>  qapi/qapi-schema.json                         |   1 +
>  scripts/arm_processor_error.py                | 476 ++++++++++++
>  scripts/ghes_inject.py                        |  51 ++
>  scripts/qmp_helper.py                         | 703 ++++++++++++++++++
>  target/arm/kvm.c                              |   7 +-
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
>  tests/data/acpi/aarch64/virt/HEST             | Bin 0 -> 224 bytes
>  tests/qtest/bios-tables-test.c                |   2 +-
>  32 files changed, 1695 insertions(+), 90 deletions(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100755 scripts/qmp_helper.py
>  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> 

