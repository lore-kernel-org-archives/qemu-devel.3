Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E01AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0NU3-0007IO-7C; Thu, 03 Apr 2025 12:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0NTu-0007Hh-VW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u0NTq-0006a1-Ay
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 12:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743697908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjM4pClLZIU0ZSFwgs4qTMDFVSuFSu4RDYnKmKQYdrA=;
 b=Xaew5SWzgmkYOWw+iCBQw5J7poUywJpBlS8JRuG5hRsPRod/ejIt98AvR+c84LzGliSB3a
 xyAv7qEpzqngwGBLt8v4/LgL336HQ+nCffxpgMLOxqTTOFC8RVRLhOE3mKdLqE3oMudMBb
 lzY4hhQRx7R8IkR9DMPscyParwpFpgU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Z6a4sNL3Ofq-hVVwOo7Ngg-1; Thu, 03 Apr 2025 12:31:47 -0400
X-MC-Unique: Z6a4sNL3Ofq-hVVwOo7Ngg-1
X-Mimecast-MFC-AGG-ID: Z6a4sNL3Ofq-hVVwOo7Ngg_1743697906
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39c30f26e31so636374f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 09:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743697906; x=1744302706;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjM4pClLZIU0ZSFwgs4qTMDFVSuFSu4RDYnKmKQYdrA=;
 b=TeQnDbtvGnO6hw0EIUDIGGlHmycLggW6OkR50Yis0i+bLFdoz8ypK7ZWRjo8CRJIXG
 I5aXKRrYAxnfonb8ovG1KfRbwseRlVV+UWYAlQqaHmt1UowExBuCoyDd1jz2AIxAEmFU
 4kV3asfiN3dZXGqyXZwqczjwNKB1Hu6p3pAJcR+K7nKPPG0JJVttwyzvDv0nJCTK7ZO5
 qFXMSN9/1TSH00J74Ru0KXWZFkJ0vziaypCHkTshvW8hGdfIj62P1HTrrQxmG8f30cf7
 GOXHoTzqMQsJKAmqg+iDfISrkx1EtNNRHFdblGpiw6J1kjucEBUkIcyFHaDhv8oTj6X6
 RNhA==
X-Gm-Message-State: AOJu0YzBTQPDT6bvDIiVpUWLMh6BZ1XlI+GNA2kTLeHXAtBeaJ6lcN/R
 +u9gXdjxQEz85FoWb+jb9B5v6czzR+He3vjB7+eblbqfr6hJKjSAcP4SRsg22a5d7lEmxJxug/y
 jhrx9emT03+lGBGtCUAOoep5xjn49CQHwSBBIP/WKiPqpm7RgSxN3
X-Gm-Gg: ASbGncstFhbD8VuNHeRglbLxJOjBJvkk7KsV3lqWhA92VRAJ+UXWV0Li5S0x4Gc4Ev8
 cAv6PzWHSCfatSyF1lCy9+8aAu9JdwWxG5v4QjYO4rY8lA1/1jozl3mFT7xwQ9II0nkfHJc939Q
 VBrS56KYtHyHFcG6so+WgRI4dVl6WhRG4eqvq/E7tSyrqXQZSWQS1QEVirsMB7sDhnHB17Qcb1V
 Ikc1Q/1YhRxnGzHFOvBuFNQXaSm/nC5B/7M66NLeC1k7VB4Vv/GpZ/4TUwqh11mKpjtfDmQEnWF
 Nz/IG64gNQ==
X-Received: by 2002:a5d:64cd:0:b0:391:255a:748b with SMTP id
 ffacd0b85a97d-39c2f94bf88mr3080669f8f.39.1743697906146; 
 Thu, 03 Apr 2025 09:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxk0IEb4ppVWGkFhm5xgl7ZWMV5JERe3pWENQoMMsWhHZ3GRTlA6wxscgCc60ypXfT2R/LWg==
X-Received: by 2002:a5d:64cd:0:b0:391:255a:748b with SMTP id
 ffacd0b85a97d-39c2f94bf88mr3080621f8f.39.1743697905671; 
 Thu, 03 Apr 2025 09:31:45 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b6a1esm2243463f8f.45.2025.04.03.09.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 09:31:44 -0700 (PDT)
Date: Thu, 3 Apr 2025 12:31:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Udo Steinberg <udo@hypervisor.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH-for-10.0 v2 00/14] hw/arm: Tests & ACPI tables fixes for
 10.0
Message-ID: <20250403122948-mutt-send-email-mst@kernel.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Apr 03, 2025 at 05:18:15PM +0200, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> I tried to gather all the hw/arm/-related patches for
> the GitLab issues tagged for 10.0.
> 
> First, trivial ones fixing / disabling broken tests;
> then disable the VMapple machine (not sure about it);
> finally fix ACPI tables for '-M its=off' CLI option.
> 
> While polishing the series, I noticed MST mentioning
> the ACPI changes are likely too late:
> https://lore.kernel.org/qemu-devel/20250403100406-mutt-send-email-mst@kernel.org/
> I'll defer that jugement to Alex :)
> 
> Regards,
> 
> Phil.


Patches 1-4:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


The rest indeed seems late.


> Philippe Mathieu-Daudé (13):
>   tests/functional: Add a decorator for skipping tests on particular OS
>   tests/functional: Skip aarch64_replay test on macOS
>   tests/qtest: Skip Aarch64 VMapple machine
>   hw/arm: Do not build VMapple machine by default
>   hw/arm/virt: Remove pointless VirtMachineState::tcg_its field
>   hw/intc/gicv3_its: Do not check its_class_name() for NULL
>   hw/arm/virt: Simplify create_its()
>   hw/arm/virt-acpi: Factor its_enabled() helper out
>   qtest/bios-tables-test: Add test for -M virt,its=off
>   qtest/bios-tables-test: Whitelist aarch64/virt 'its_off' variant blobs
>   hw/arm/virt-acpi: Always build IORT table (even with GIC ITS disabled)
>   hw/arm/virt-acpi: Do not advertise disabled GIC ITS
>   qtest/bios-tables-test: Update aarch64/virt 'its_off' variant blobs
> 
> Pierrick Bouvier (1):
>   tests/functional/test_aarch64_rme_virt: fix sporadic failure
> 
>  configs/devices/aarch64-softmmu/default.mak |   1 +
>  include/hw/arm/virt.h                       |   1 -
>  include/hw/intc/arm_gicv3_its_common.h      |   2 +-
>  hw/arm/virt-acpi-build.c                    |  48 ++++++++++++--------
>  hw/arm/virt.c                               |  23 +++-------
>  tests/qtest/bios-tables-test.c              |  22 +++++++++
>  tests/qtest/libqtest.c                      |   1 +
>  tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 164 bytes
>  tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
>  tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 212 bytes
>  tests/functional/qemu_test/__init__.py      |   2 +-
>  tests/functional/qemu_test/decorators.py    |  15 +++++-
>  tests/functional/test_aarch64_replay.py     |   4 +-
>  tests/functional/test_aarch64_rme_virt.py   |   4 +-
>  14 files changed, 82 insertions(+), 41 deletions(-)
>  create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>  create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> 
> -- 
> 2.47.1


