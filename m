Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED17C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJ5v-0001HM-5k; Fri, 24 Jan 2025 07:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbJ5r-00012V-3E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:47:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbJ5o-0004wu-45
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737722842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUFa3BHRM1lCZt1AxF1frfdVKD8rPIbxarCScvHGYqE=;
 b=iUirqGiQ4ffZWIms3xBWDCcG3xV9lwf8Z+X+0p0WKWwbtdzrSQZzp3mdcV0u1wi9n7jEaz
 pwSrqJiKuKyZpaBs2K481fCFQNmGhABYoUm+kvrMCLja4ZeAFjsNLEIJE1THcVbiENAzsY
 /cz4+xB+xQvO2/DjByRtA0b7FhJ1KfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-IiFBhCYaPJOpKDpYkkmdZA-1; Fri, 24 Jan 2025 07:47:21 -0500
X-MC-Unique: IiFBhCYaPJOpKDpYkkmdZA-1
X-Mimecast-MFC-AGG-ID: IiFBhCYaPJOpKDpYkkmdZA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so11505935e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737722840; x=1738327640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUFa3BHRM1lCZt1AxF1frfdVKD8rPIbxarCScvHGYqE=;
 b=uR6fy5nrqVyZRONuxKsQI1ur/tr/rB7wkuvTb03EoSlV/JoNjlBc1btDfA/UHPuzh5
 kv392OeTpeZ4ATxRYSZBnmEQ1KpYnSM8+QfNDSy+iJjwxVID69L7ALaGclR+nVfAiLfS
 Z7DqhsbgOmq1ZFkigiyn+RmZeawvbR4uVmmVDreCVN+HZ6HhXtsbnHeIBBd+VEvJ89EW
 MaV6QqMTHQ3rEjrXqWgB4UHJcAMKEw3oXqWcyKwhnIlovLU7PN48/eetrO6DLLdP8ORW
 Nhmy1KYAU3r+uWTfxhIXjKdWoaR3MduEgnzUGLlqqOwUE4wQzaWfbl9BTHlqCQKt9VF6
 qefg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnPrwLmblQMvIcBR1JfP8kCgs/MmqD/NE1Ro9l9qwHk9gBaNYE4LEJLx+BLPH7tKSWjIfZdQhkfuF9@nongnu.org
X-Gm-Message-State: AOJu0YzbBtoxL8SqwiT8d/jlIhhja0169qn9tyt1vNAss/xVRJVCQp1c
 7aT63BQ6jGPdpD+97batbAlrEXv2o/ysy7xKyeATosELIoVaER7O9emk1KQW+6JsQiYGK7m/mwN
 /flX7yf3+wcHeucBz//xX5m50aYDo4IqweuQqm91MWZ2zTCcSIraL
X-Gm-Gg: ASbGncvTHATOMshDtALkUq2nSAl34kgIcT7NrpZ+0LaWATVZfsAi3O3+aTVI+ai9SKs
 aqxkmtpEXTsOSQuZ4hsLBryM5zwlpbWtlAsRNXCadzip71GiArVSUzpgzUJVi8sq8SuAKPSzoP5
 Gnn90Jy8NF7ssUUjcUPnmHsVcNB9mPPhMgDaqrFwQ8+GqXlbc8iny6aaKqHzUBzWbZEDNBh6RPv
 vOWtGkKLsqKkQ3eatSoPTiE8QkkooZJq86vHf6Zxu4/14YCdDJEyUB0RPRQ9X9XNSlEOxVWSKXX
 uEa5yh4wl+ZlVJYelRk/VVK8sY361gJ8kEsg4HDtlQ==
X-Received: by 2002:a5d:64c9:0:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-38bf57bbfa5mr29250411f8f.48.1737722840132; 
 Fri, 24 Jan 2025 04:47:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIa/qJYb53I8CRY29wjjcU5tWAwqCN40ac1gjQdm+m09Yx/dchLdoDyW0UVw2aF0l1aHWnfw==
X-Received: by 2002:a5d:64c9:0:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-38bf57bbfa5mr29250366f8f.48.1737722839737; 
 Fri, 24 Jan 2025 04:47:19 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c402esm2610633f8f.97.2025.01.24.04.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 04:47:19 -0800 (PST)
Date: Fri, 24 Jan 2025 13:47:18 +0100
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
Subject: Re: [PATCH 00/11] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250124134718.3e228b0b@imammedo.users.ipa.redhat.com>
In-Reply-To: <cover.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 22 Jan 2025 16:46:17 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that the ghes preparation patches were merged, let's add support
> for error injection.
> 
> I'm opting to fold two patch series into one here:
> 
> 1. https://lore.kernel.org/qemu-devel/20250113130854.848688-1-mchehab+huawei@kernel.org/
> 
> It is the first 5 patches containing changes to the math used to calculate offsets at HEST
> table and hardware_error firmware file, together with its migration code. Migration tested
> with both latest QEMU released kernel and upstream, on both directions.
> 
> There were no changes on this series since last submission, except for a conflict
> resolution at the migration table, due to upstream changes.
> 
> For more details, se the post of my previous submission.
> 
> 2. It follows 6 patches from:
> 	https://lore.kernel.org/qemu-devel/cover.1726293808.git.mchehab+huawei@kernel.org/
>     containing the error injection code and script.
> 
>    They add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
>    to inject ARM Processor Error records.
> 
> PS.: If I'm counting well, this is the 18th version of this series rebase.

the series is more or less in good shape,
it requires a few fixups here and there, so I'd expect to to be ready on
the next respin.

I'm done with this round of review.

PS:
the moment you'd start changing ACPI tables you need, 1st whitelist
affected tables and then update expected blobs with new content.
see comment at the beginning of tests/qtest/bios-tables-test.c

if you haven't done above 'make check-qtest' would fail,
and if it didn't that likely means a missing test case
(in that case please add one) 

> 
> Mauro Carvalho Chehab (11):
>   acpi/ghes: Prepare to support multiple sources on ghes
>   acpi/ghes: add a firmware file with HEST address
>   acpi/ghes: Use HEST table offsets when preparing GHES records
>   acpi/generic_event_device: Update GHES migration to cover hest addr
>   acpi/generic_event_device: add logic to detect if HEST addr is
>     available
>   acpi/ghes: add a notifier to notify when error data is ready
>   acpi/ghes: Cleanup the code which gets ghes ged state
>   acpi/generic_event_device: add an APEI error device
>   arm/virt: Wire up a GED error device for ACPI / GHES
>   qapi/acpi-hest: add an interface to do generic CPER error injection
>   scripts/ghes_inject: add a script to generate GHES error inject
> 
>  MAINTAINERS                            |  10 +
>  hw/acpi/Kconfig                        |   5 +
>  hw/acpi/aml-build.c                    |  10 +
>  hw/acpi/generic_event_device.c         |  38 ++
>  hw/acpi/ghes-stub.c                    |   4 +-
>  hw/acpi/ghes.c                         | 184 +++++--
>  hw/acpi/ghes_cper.c                    |  32 ++
>  hw/acpi/ghes_cper_stub.c               |  19 +
>  hw/acpi/meson.build                    |   2 +
>  hw/arm/virt-acpi-build.c               |  35 +-
>  hw/arm/virt.c                          |  19 +-
>  hw/core/machine.c                      |   2 +
>  include/hw/acpi/acpi_dev_interface.h   |   1 +
>  include/hw/acpi/aml-build.h            |   2 +
>  include/hw/acpi/generic_event_device.h |   1 +
>  include/hw/acpi/ghes.h                 |  36 +-
>  include/hw/arm/virt.h                  |   2 +
>  qapi/acpi-hest.json                    |  35 ++
>  qapi/meson.build                       |   1 +
>  qapi/qapi-schema.json                  |   1 +
>  scripts/arm_processor_error.py         | 377 +++++++++++++
>  scripts/ghes_inject.py                 |  51 ++
>  scripts/qmp_helper.py                  | 702 +++++++++++++++++++++++++
>  target/arm/kvm.c                       |   2 +-
>  24 files changed, 1517 insertions(+), 54 deletions(-)
>  create mode 100644 hw/acpi/ghes_cper.c
>  create mode 100644 hw/acpi/ghes_cper_stub.c
>  create mode 100644 qapi/acpi-hest.json
>  create mode 100644 scripts/arm_processor_error.py
>  create mode 100755 scripts/ghes_inject.py
>  create mode 100644 scripts/qmp_helper.py
> 


