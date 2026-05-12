Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA80CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnDA-0006iI-81; Tue, 12 May 2026 09:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wMnCd-0006bc-Nc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wMnCZ-00082Q-5r
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778592662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TGpaXGbdxrL9XSTBvrmovfO+9XIeMta7Y4Ueu0qyDg=;
 b=MM0lnz6kk8SLHbyaspNW2jjYMyoDwvkRPWvYfqQs6kUZt1EBIwNMywc2gzpx++INO2zlY+
 VA4leZAoGnjfkp7dj8WyYtUfKyceIdFIClLmM7e/nnFubjs3R4jRxYYHond4LKLPLnMVe0
 WzO+lyGDpuISV0+aJTn2SOgp5F/5W0o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-rM7jOcy6MMebnxSW8YROJQ-1; Tue, 12 May 2026 09:31:01 -0400
X-MC-Unique: rM7jOcy6MMebnxSW8YROJQ-1
X-Mimecast-MFC-AGG-ID: rM7jOcy6MMebnxSW8YROJQ_1778592660
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48e51dc35a3so43607945e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778592660; x=1779197460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TGpaXGbdxrL9XSTBvrmovfO+9XIeMta7Y4Ueu0qyDg=;
 b=ZGdtHr0DoaLYZ54Q50eyfu2u2Jn5vnq9XsejBElabouy8mmThnxNHzXrrTkMd7vWMn
 KMBvpRF+knq7WbzR0yX/nOc/syJyLxHrFSP4uEbQWbOnKydiZ7kkYtDzU/BngY9fygUX
 kK+4MTdEkxqSG22n2INriYi/r041Z9FEBPDLW/cMSH4GW+WwPkIquQESQnwMmLHzjLmf
 9lDMak1eWoGpklGNRN+GEBqIaZFhwGWYxxsuYRhpkYEfystiJ91sAci8v17X03+E1HYx
 ojUQxTHPUT1s3L8MJPai6t6HHimFaTiuDHNp9ZWCdW0JXurZVaLr7moOs9ZeKhrc42Po
 QO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778592660; x=1779197460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+TGpaXGbdxrL9XSTBvrmovfO+9XIeMta7Y4Ueu0qyDg=;
 b=QaQrFsAVIOsxwPfFL35v7vYouzjg9UlH8uLK45TRvi+Y6F9Jd8T7G3tomp8J8tNyNz
 OHtTAmK8B3yTEsEfnE+p85ZEk2U73w2TlQvetKvEYXiI4z0sAgS6HuW+fcclSj1Lh1Qk
 3+40mc/ZLHPdV7BFrXR9LSSBOzO5gJAKuGs3Aw7J4srHM5pHI8HpzdSZKe6timAGgz2A
 0Yb+Rl5N7pSb++3b8jAHSRusoD1zJiFLZ2/wBtltiHSoxY2f89shstAN4d4f4G0fDPkR
 7h/GnClINHsdSbdb6QBnrxg9oVgbrghQLjNpqZbEUUKs/EF0ax8TaH03R9LXQIW6bH6a
 OxRw==
X-Gm-Message-State: AOJu0YwisZNoSz+o5uZy2hektN+f3z+IGeIEv+oGEFhTND2GmaJmY6kO
 iUc/OTkDYmZKIxRBE2pQkxV9xaky3RmswuNm2EuwhQ8itU2V9rdUwj6dU7dr9HiUOL6StYl3Jd0
 MnYRWp4N0WzarrYaZM7ew5LD4RHsNNpGDEHLQFCazW0HHnD/+bx0oLQbeY0p6Uf74wutUdjtj5q
 gHhHV66NkxoEwgvS0Fxzsf349c8IvGSaWmLmSesi8g
X-Gm-Gg: Acq92OFyFhpJ7A+xgQ1RzoZ6GqjcDtVXH2opve1i2op3jB2ycVQZ1zgxEo3+8r9KEF5
 l6lTzah/XXqGnfr01DCzmBojOFSvCeuM5Qrped7GRxsvFQFPgewpTBqNYyDkcaTT8STkN18Cbb9
 HlvUPCy5swTBwSLWAcm8hBn2By1NDQ0RpggGScUsYTsloFgvzW0tudTD+lZhSQQTA4uC3HuM/Rc
 FJcuXb/33YceqRiW6X65X6pZeVWhlQizPw3hQyPGznGf6ULox4ojewoceKp+obUChPr/8wJB8A6
 tLMHbU5k/OEJx+V1SPm3Dn33xAUHKH7e1pGG5aZEeFe3vX8i6Y4NWgr6TFic369b0prdvrNS880
 z48xqKw==
X-Received: by 2002:a05:600c:a30d:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48e51e08228mr316495355e9.3.1778592659746; 
 Tue, 12 May 2026 06:30:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a30d:b0:488:a2ac:a334 with SMTP id
 5b1f17b1804b1-48e51e08228mr316494985e9.3.1778592659176; 
 Tue, 12 May 2026 06:30:59 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e9052c9fesm101578855e9.1.2026.05.12.06.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:30:58 -0700 (PDT)
Date: Tue, 12 May 2026 15:30:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 00/21] Introduce ACPI watchdog for Q35 and arm/virt
 boards
Message-ID: <20260512153057.1a353c3e@imammedo>
In-Reply-To: <20260428161215.49cc1c0f@imammedo>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260428161215.49cc1c0f@imammedo>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 28 Apr 2026 16:12:15 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue,  3 Mar 2026 10:25:11 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > Changelog:
> >   v2:
> >      * ditch generic '-machine acpi-watchdog' option in favor of
> >        board specific variants:
> >            x86/q35:  -machine wdat={on|off}
> >            arm/virt: -device sbsa_gwdt,wdat={on|off}
> >      * arm/virt: add FDT and GTDT ACPI entries for GWDT when it's present
> >        and hide GDTD one when WDAT is enabled.
> >      * arm/virt: add test case for GTDT 
> >      * [18-21] optional GWDT cleanup/fixes in handling WCV register update,
> >        make QEMU behave according to spec (at least the way I read it and
> >        it appears MS also read it that way). It fixes Windows 11 reboots when
> >        GWDT is present (without WDAT). With that fixed it's up to MS to fix
> >        their driver to set sane timeout as with the current one wdatchdog
> >        will never trigger.  
> 
> given merge window should be open by now,
> gentle ping

2 weeks later,
yet another ping

> 
> > Windows doesn't ship built-in TCO watchdog driver, and users are
> > forced to install vendor specific driver(s) if such exists.
> > However the OS provides a generic watchdog driver that uses
> > ACPI WDAT table [1] to abstract actual hardware behind it.
> > The same applies to ARM version of Windows.
> > 
> > This series adds
> >  *  WDAT table tailored for TCO watchdog that Q35 already
> >     has as part of ICH9 chipset and a knob to enable it.
> >  *  SBSA GWDT to arm/virt machine with WDAT table tailored
> >     for it and necessary tweaks to GWDT to make usable
> >     with WDAT driver.
> >     * in addition to WDAT, it also adds native variant
> >       with GWDT described in FDT and DTDT
> >       (broken on Windows/works on linux).
> > 
> > Guest OS WDAT support is present since Windows Vista and Linux since 2016[2].
> > 
> > One can test it launching VM with following options:
> >   * x86:
> >        -machine q35,wdat=on
> >   * arm/virt:
> >        -device sbsa_gwdt,wdat=on
> > 
> > to trace access to TCO registers one can add to CLI:
> >     -trace "tco_*"
> > to trace access to GWDT registers one can add to CLI:
> >     -trace "sbsa_gwdt*"
> > 
> > To verify that guest uses WDAT (both Windows and Linux would use it if present),
> >   * on linux make sure that watchdog service is configured/enabled
> >     (use wdctl to check what watchdog device is in use) and then
> >     trigger kernel panic with command:
> >       echo c > /proc/sysrq-trigger
> >   * on Windows kill svchost process, running cmd in admin mode:
> >       taskkill /f /im svchost.exe
> > 
> > Tested with WS2025 & RHEL9.6 & Fedora 43 (aarch64)
> > 
> > git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2
> > 
> > 1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> > 2) https://lwn.net/Articles/700524/
> > 
> > PS:
> >  previous revision:
> >   https://patchew.org/QEMU/20260206131438.1857182-1-imammedo@redhat.com/
> > 
> > Igor Mammedov (21):
> >   acpi: add API to build WDAT instructions
> >   x86: q35: add 'wdat' property
> >   x86: q35: generate WDAT ACPI table
> >   tests: acpi: x86/q35: whitelist new WDAT table
> >   tests: acpi: x86/q35: add WDAT table test case
> >   tests: acpi: x86/q35: update expected WDAT blob
> >   arm: sbsa_gwdt: fixup default "clock-frequency"
> >   arm: add tracing events to sbsa_gwdt
> >   arm: virt: create sbsa_gwdt watchdog
> >   arm: sbsa_gwdt: add 'wdat' option
> >   arm: virt: add support for WDAT based watchdog
> >   tests: acpi: arm/virt: whitelist new WDAT table
> >   tests: acpi: arm/virt: add WDAT table test case
> >   tests: acpi: arm/virt: update expected WDAT blob
> >   tests: acpi: arm/virt: whitelist GTDT table
> >   tests: acpi: arm/virt: add GTDT watchdog table test case
> >   tests: acpi: arm/virt: update expected GTDT blob
> >   sbsa_gwdt: reduce code ident
> >   sbsa_gwdt: move all foo_REFRESH logic under REFRESH condition
> >   sbsa_gwdt: reschedule timer on direct WCV load
> >   sbsa_gwdt: limit compare_value to INT64_MAX
> > 
> >  include/hw/acpi/wdat-gwdt.h            |  19 ++++
> >  include/hw/acpi/wdat-ich9.h            |  15 ++++
> >  include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
> >  include/hw/i386/pc.h                   |   1 +
> >  include/hw/watchdog/sbsa_gwdt.h        |   1 +
> >  hw/acpi/aml-build.c                    |  14 +++
> >  hw/acpi/meson.build                    |   5 +-
> >  hw/acpi/wdat-gwdt-stub.c               |  16 ++++
> >  hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
> >  hw/acpi/wdat-ich9-stub.c               |  15 ++++
> >  hw/acpi/wdat-ich9.c                    |  90 +++++++++++++++++++
> >  hw/arm/Kconfig                         |   1 +
> >  hw/arm/virt-acpi-build.c               |  65 +++++++++++++-
> >  hw/arm/virt.c                          |   2 +
> >  hw/core/sysbus-fdt.c                   |  32 +++++++
> >  hw/i386/acpi-build.c                   |  12 +++
> >  hw/i386/pc_q35.c                       |  18 ++++
> >  hw/watchdog/sbsa_gwdt.c                |  65 +++++++++-----
> >  hw/watchdog/trace-events               |   9 ++
> >  tests/data/acpi/aarch64/virt/GTDT.gwdt | Bin 0 -> 132 bytes
> >  tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
> >  tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
> >  tests/qtest/bios-tables-test.c         |  54 +++++++++++
> >  23 files changed, 618 insertions(+), 26 deletions(-)
> >  create mode 100644 include/hw/acpi/wdat-gwdt.h
> >  create mode 100644 include/hw/acpi/wdat-ich9.h
> >  create mode 100644 include/hw/acpi/wdat.h
> >  create mode 100644 hw/acpi/wdat-gwdt-stub.c
> >  create mode 100644 hw/acpi/wdat-gwdt.c
> >  create mode 100644 hw/acpi/wdat-ich9-stub.c
> >  create mode 100644 hw/acpi/wdat-ich9.c
> >  create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
> >  create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
> >  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
> >   
> 


