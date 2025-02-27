Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8098C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnabh-00038e-8k; Thu, 27 Feb 2025 04:55:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnabf-00035P-6p
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnabd-0003yD-0y
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740650099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sM37GoCBrelHpecugQ7DvbegVqt19Ri+N9wNIK8C7vQ=;
 b=M8GuJKX3sDHIaSPqAS44CoCvvNXVTIilEeRydVo0fBwrrc7bzJEZc1KOp7xe1xHj4SfIPu
 MAUTdIl2h1vkJBnsDrekNKxJ2pIZKsQeoMOuyXvXyS0Pnfrfu4yhVPIskA7ewP7kqYENHv
 1/bEm5ae9YFDeAlg3dXVLpBHm9wjJQQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7trqlyPBNwKLVWzyxwY3mA-1; Thu, 27 Feb 2025 04:54:58 -0500
X-MC-Unique: 7trqlyPBNwKLVWzyxwY3mA-1
X-Mimecast-MFC-AGG-ID: 7trqlyPBNwKLVWzyxwY3mA_1740650097
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so3763575e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 01:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740650097; x=1741254897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM37GoCBrelHpecugQ7DvbegVqt19Ri+N9wNIK8C7vQ=;
 b=OpBYzuY0r61q6OVrUp1fh2/p51CXVkactOhrO2j+GQb2ZWbltciK4c+iPYu1rySrmK
 80ToQPBuX9oMmchvL0h5wiZ8YD5Ug8r4PJIDYT6F2BfYuNx4fkMo40ePuoCLIEJkktSw
 t/oX0pI4DMlA0zouKpsDE6fxv6S8tRyKJsYubcxIwzs2GnmiV630nM3dfMWprwfK5A5P
 xu+iLuckIbvQ0CWFwYpj9vKtWVzcXmOq+qul7QiV31C3duKnpEEcYOKt2UbMQHsqMsmy
 XFUWu5hAqMncxcO80kC7ivWU1nXtSXk3HeM8ZFOxBLKREexUGVD7X6ldEyEWJmZz5N6g
 kklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZt41JHS56ERdZc9hYCQ2QhzlYtRuJHdpxFahBpT18UyE3ZxtdPUKork+sEMirdTY1PAILRFipGYPn@nongnu.org
X-Gm-Message-State: AOJu0Yy7RwmXkZlOuRDcdCTghK1pwduDoE2UC0PEB98Hm+yidlXqlJvS
 PAo4YvapM4/AUV9nGkRDEnHR34bi53KtGfla7mZLplkpaLKPBqi2KUEGcX2NOPR7waUDa92n4rQ
 EcL0/AJfDx+8fA/Ecnkw+vjePs0NWntb7a/Qa1C6lesEMbF+px1gX
X-Gm-Gg: ASbGncvsq/jqxUZUs9RkK0gFpEbDz5iU6lFsIrbBZU0I3t9gAoXSm95eoc34Pt/CV5t
 b8aHa123GSoUyKNP8y8xKDAAazoLMOBqDWBqmJRuCr50e2mmhltQo9N2k4p+CjvhcXxN9DF0SrO
 e/dacm4Ru+LT+xObU/wsbgH+YRaO1eBUdMi+CwE8UoRtMs7KEfZZK9wX5wHtmtP9H14RfXEBqxt
 iEEPclqvVEoMjV1SQCQdOzy1sskzRr4b71NaGaDIXPdk0CV/ygVb0B2pi8NufA2+2wpvK6QxpKO
 TR1loowi0qNsgwyF0pZNkBBF7LxGFM3llS9cMRSCp3Rp22ENsRSe8Mf35L2E52Y=
X-Received: by 2002:a05:600c:b97:b0:43b:8198:f6fc with SMTP id
 5b1f17b1804b1-43b8198f8efmr17562025e9.11.1740650096851; 
 Thu, 27 Feb 2025 01:54:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIPu5VQ/hiL8z8t1cKtb2pjMgTWX7upe4WwktQRFRpTNjOGTmG0PLGgfQJU7qJUE349QFvTg==
X-Received: by 2002:a05:600c:b97:b0:43b:8198:f6fc with SMTP id
 5b1f17b1804b1-43b8198f8efmr17561605e9.11.1740650096489; 
 Thu, 27 Feb 2025 01:54:56 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b73718e2asm17268555e9.21.2025.02.27.01.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 01:54:55 -0800 (PST)
Date: Thu, 27 Feb 2025 10:54:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Message-ID: <20250227105454.69e3d459@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, 21 Feb 2025 15:35:09 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that the ghes preparation patches were merged, let's add support
> for error injection.
> 
> On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> table and hardware_error firmware file, together with its migration code. Migration tested
> with both latest QEMU released kernel and upstream, on both directions.
> 
> The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
>    to inject ARM Processor Error records.
> 
> ---
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
> 
> 
> Mauro Carvalho Chehab (14):
>   acpi/ghes: prepare to change the way HEST offsets are calculated
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/ghes: don't hard-code the number of sources for HEST table
>   acpi/ghes: add a notifier to notify when error data is ready
>   acpi/ghes: create an ancillary acpi_ghes_get_state() function
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   acpi/generic_event_device: add an APEI error device
>   tests/acpi: virt: allow acpi table changes for a new table: HEST
>   arm/virt: Wire up a GED error device for ACPI / GHES
>   tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
>   qapi/acpi-hest: add an interface to do generic CPER error injection
>   scripts/ghes_inject: add a script to generate GHES error inject
> 
>  MAINTAINERS                                   |  10 +
>  hw/acpi/Kconfig                               |   5 +
>  hw/acpi/aml-build.c                           |  10 +
>  hw/acpi/generic_event_device.c                |  43 ++
>  hw/acpi/ghes-stub.c                           |   7 +-
>  hw/acpi/ghes.c                                | 231 ++++--
>  hw/acpi/ghes_cper.c                           |  38 +
>  hw/acpi/ghes_cper_stub.c                      |  19 +
>  hw/acpi/meson.build                           |   2 +
>  hw/arm/virt-acpi-build.c                      |  37 +-
>  hw/arm/virt.c                                 |  19 +-
>  hw/core/machine.c                             |   2 +
>  include/hw/acpi/acpi_dev_interface.h          |   1 +
>  include/hw/acpi/aml-build.h                   |   2 +
>  include/hw/acpi/generic_event_device.h        |   1 +
>  include/hw/acpi/ghes.h                        |  54 +-
>  include/hw/arm/virt.h                         |   2 +
>  qapi/acpi-hest.json                           |  35 +
>  qapi/meson.build                              |   1 +
>  qapi/qapi-schema.json                         |   1 +
>  scripts/arm_processor_error.py                | 476 ++++++++++++
>  scripts/ghes_inject.py                        |  51 ++
>  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
>  target/arm/kvm.c                              |   7 +-
>  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
>  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
>  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
>  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
>  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
>  29 files changed, 1677 insertions(+), 79 deletions(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100755 scripts/qmp_helper.py
> 

once you enable, ras in tests as 1st patches and fixup minor issues
please try to do patch by patch compile/bios-tables-test testing, to avoid
unnecessary respin in case at table change crept in somewhere unnoticed. 


