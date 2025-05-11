Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43403C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE70J-0003cy-F5; Sun, 11 May 2025 09:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE70I-0003cE-2q
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE70F-0002qd-Ts
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746971162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=++4BTrVLtU+bH/DduG/YVrNpWw/0yt4z9p0yidUBYL0=;
 b=SUzBbprDL87jVbtMS96UxwKPKsyAzQX2gAEVJGicZA2+jH7wejuOorbS6M7IOF8l84e+zX
 7hzcOUQqHpkbcv7RwySYXQrqY3VcUKOinPwo/s1Olbkzd7Ajalu/9sFRRE//FMin6n5W8A
 fWXRaMHoqXLQA4S37CvG/YPg9qQcxsQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-__R0xZ85OJi93mQWj93xxA-1; Sun, 11 May 2025 09:46:01 -0400
X-MC-Unique: __R0xZ85OJi93mQWj93xxA-1
X-Mimecast-MFC-AGG-ID: __R0xZ85OJi93mQWj93xxA_1746971160
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso24983955e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:46:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746971160; x=1747575960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++4BTrVLtU+bH/DduG/YVrNpWw/0yt4z9p0yidUBYL0=;
 b=pDU5qsk1+huk92cBwtHryrQCPlS8UDYLwIAOQABl7hZB5aL5PCdTrS/oHnf8+5Y0i7
 goq6wpVmzjjsnkdVHP/4hX4vtnas58Rgy8Z1OZc3IOWVN5e3iyOeblY2SYB0PKyDqLkP
 GOUqkFH4Tlh8xJW7vgfYb9uyNOksg/xVbE/5tBDcvdqfc3aKgejkXL+15OOFYF1bzU+A
 HhZZSHlAemo5roMAElwB88UfLJJNIHsmEawfYjbqQ5dM0zBwrDZ0IesvuaxbqPkApBwq
 zfxXZVimXLyTX1GzQGKZCq25Y6pOLU+JdSjat0LAInOUy+RzTubdPcgErmE4SpK+EVau
 GpNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWzV3eGM/cBDHXPUuSUb8phc8pGcwv6tSJW2L89CTDIEiqEc2IFM4T29a9S+Goy9LUOg6ksPGvGFIw@nongnu.org
X-Gm-Message-State: AOJu0YzibRpipIqeZt8BycNontNapUxkLHJjsexzTxGchPvxxDH7J2vl
 KVAe/7cTpOPvsQ7IQdKsYC582+6INq+9Jgqt6gbYqBUv3HP1e2P1sHBAupAb17wuWdQSseUpVh4
 V7NbCLF5MFrNubxwwlpDCpi/oFbm+gXBAtWMrteITemRVMUL13Gow
X-Gm-Gg: ASbGncvoqOGAmSOKQ+pW8Xt3aIUqFDZfzUh4f4QGvTBYl3RgAhBgOxu3yWU37EnG0fY
 ev2VzjSZ2anEqaiVxuKDcD9vYByNBLF34rk3rJ7jy8OfIk+3T9De2RhtdFn4tBZZBrswagut1tY
 l8v9Y6X2TxtlHXtsIQrRcHu61tqMGnW61Dtz/pwg3tcwB/QsDOF9JwVcdDShZV3JO9E8iR7oIlJ
 QPJavXtKOaqjADXYbWozs2grurHVRRvOUUMwkq4aiSpPbWbgBoNGWuZyxlCZF7dvsOjqyylxXwR
 D/9nTw==
X-Received: by 2002:a05:600c:8284:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-442d6d1fb3bmr91934495e9.10.1746971160230; 
 Sun, 11 May 2025 06:46:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1Snjzp8begn9I45ToiSojXxDwp/vHKoP5jUyb2OD3rmo2ILs2v5Bo4MPNzqnhClIlKlDtQ==
X-Received: by 2002:a05:600c:8284:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-442d6d1fb3bmr91934185e9.10.1746971159771; 
 Sun, 11 May 2025 06:45:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d685c2d7sm92530965e9.30.2025.05.11.06.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 06:45:59 -0700 (PDT)
Date: Sun, 11 May 2025 09:45:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/20] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250511094546-mutt-send-email-mst@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <20250511094343-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511094343-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, May 11, 2025 at 09:45:04AM -0400, Michael S. Tsirkin wrote:
> On Fri, Mar 07, 2025 at 08:14:29PM +0100, Mauro Carvalho Chehab wrote:
> > Hi Michael,
> > 
> > I'm sending v8 to avoid a merge conflict with v7 due to this
> > changeset:
> > 
> >    611f3bdb20f7 ("hw/acpi/ghes: Make  static")
> 
> 
> 
> Applied 1-13.
> Patch 14 needs to apply compat to 10.0 machine type as well.

Sorry i meant 1-11.

> 
> > As ghes_record_cper_errors() was written since the beginning
> > to be public and used by ghes-cper.c. It ended being meged
> > earlier because the error-injection series become too big,
> > so it was decided last year to split in two to make easier for
> > reviewers and maintainers to discuss.
> > 
> > Anyway, as mentioned on v7, I guess we're ready to merge this
> > series, as patches here have been thoughfully reviewed mainly 
> > by Igor and Jonathan over the last 5-6 months.
> > 
> > The only change from v7 is a minor editorial change at HEST doc
> > spec, and the addition of Igor and Jonathan's A-B/R-B.
> > 
> > This series change the way HEST table offsets are calculated,
> > making them identical to what an OSPM would do and allowing
> > multiple HEST entries without causing migration issues. It open
> > space to add HEST support for non-arm architectures, as now
> > the number and type of HEST notification entries are not
> > hardcoded at ghes.c. Instead, they're passed as a parameter
> > from the arch-dependent init code.
> > 
> > With such issue addressed, it adds a new notification type and
> > add support to inject errors via a Python script. The script
> > itself is at the final patch.
> > 
> > ---
> > v8:
> >   - added a patch to revert recently-added changeset causing a
> >     conflict with these. All remaining patches are identical.
> > 
> > v7:
> >   - minor editorial change at the patch updating HEST doc spec
> >    with the new workflow
> > 
> > v6:
> > - some minor nits addressed:
> >    - use GPA instead of offset;
> >    - merged two patches;
> >    - fixed a couple of long line coding style issues;
> >    - the HEST/DSDT diff inside a patch was changed to avoid troubles
> >      applying it.
> > 
> > v5:
> > - make checkpatch happier;
> > - HEST table is now tested;
> > - some changes at HEST spec documentation to align with code changes;
> > - extra care was taken with regards to git bisectability.
> > 
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
> > Mauro Carvalho Chehab (20):
> >   tests/acpi: virt: add an empty HEST file
> >   tests/qtest/bios-tables-test: extend to also check HEST table
> >   tests/acpi: virt: update HEST file with its current data
> >   Revert "hw/acpi/ghes: Make ghes_record_cper_errors() static"
> >   acpi/ghes: Cleanup the code which gets ghes ged state
> >   acpi/ghes: prepare to change the way HEST offsets are calculated
> >   acpi/ghes: add a firmware file with HEST address
> >   acpi/ghes: Use HEST table offsets when preparing GHES records
> >   acpi/ghes: don't hard-code the number of sources for HEST table
> >   acpi/ghes: add a notifier to notify when error data is ready
> >   acpi/generic_event_device: Update GHES migration to cover hest addr
> >   acpi/generic_event_device: add logic to detect if HEST addr is
> >     available
> >   acpi/generic_event_device: add an APEI error device
> >   tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
> >   arm/virt: Wire up a GED error device for ACPI / GHES
> >   qapi/acpi-hest: add an interface to do generic CPER error injection
> >   acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
> >   tests/acpi: virt: update HEST and DSDT tables
> >   docs: hest: add new "etc/acpi_table_hest_addr" and update workflow
> >   scripts/ghes_inject: add a script to generate GHES error inject
> > 
> >  MAINTAINERS                                   |  10 +
> >  docs/specs/acpi_hest_ghes.rst                 |  28 +-
> >  hw/acpi/Kconfig                               |   5 +
> >  hw/acpi/aml-build.c                           |  10 +
> >  hw/acpi/generic_event_device.c                |  44 ++
> >  hw/acpi/ghes-stub.c                           |   7 +-
> >  hw/acpi/ghes.c                                | 233 ++++--
> >  hw/acpi/ghes_cper.c                           |  38 +
> >  hw/acpi/ghes_cper_stub.c                      |  19 +
> >  hw/acpi/meson.build                           |   2 +
> >  hw/arm/virt-acpi-build.c                      |  35 +-
> >  hw/arm/virt.c                                 |  19 +-
> >  hw/core/machine.c                             |   2 +
> >  include/hw/acpi/acpi_dev_interface.h          |   1 +
> >  include/hw/acpi/aml-build.h                   |   2 +
> >  include/hw/acpi/generic_event_device.h        |   1 +
> >  include/hw/acpi/ghes.h                        |  51 +-
> >  include/hw/arm/virt.h                         |   2 +
> >  qapi/acpi-hest.json                           |  35 +
> >  qapi/meson.build                              |   1 +
> >  qapi/qapi-schema.json                         |   1 +
> >  scripts/arm_processor_error.py                | 476 ++++++++++++
> >  scripts/ghes_inject.py                        |  51 ++
> >  scripts/qmp_helper.py                         | 703 ++++++++++++++++++
> >  target/arm/kvm.c                              |   7 +-
> >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
> >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
> >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
> >  tests/data/acpi/aarch64/virt/HEST             | Bin 0 -> 224 bytes
> >  tests/qtest/bios-tables-test.c                |   2 +-
> >  32 files changed, 1695 insertions(+), 90 deletions(-)
> >  create mode 100644 hw/acpi/ghes_cper.c
> >  create mode 100644 hw/acpi/ghes_cper_stub.c
> >  create mode 100644 qapi/acpi-hest.json
> >  create mode 100644 scripts/arm_processor_error.py
> >  create mode 100755 scripts/ghes_inject.py
> >  create mode 100755 scripts/qmp_helper.py
> >  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> > 
> > -- 
> > 2.48.1
> > 


