Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F25FF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjCS-0008SU-KG; Tue, 28 Apr 2026 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wHjCQ-0008Rx-Cf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wHjCN-0002Ke-Cy
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777385642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMgaMMRHBTfcJuhrkBN4N6UBYrSouh7MkAX9cEmU3Lk=;
 b=Wi5Yrx/+8X0Q6/arZQKnh4b6zhBDFuT1l3x8vwR1H1pMguGLO/4OYeoUR/+GpP9y73KeTr
 UhoR99NhHvKriROONENUiT2DYtRhKE8+yLd9NOnoj9Iwbn19Jn5UfEgv23gaC3KDkRXMFQ
 Q8oBtexSdoP8LyNV4M8/trYJyL+BLS0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-Vd7s1sRKNeCVuDZ4sgQbHg-1; Tue, 28 Apr 2026 10:12:23 -0400
X-MC-Unique: Vd7s1sRKNeCVuDZ4sgQbHg-1
X-Mimecast-MFC-AGG-ID: Vd7s1sRKNeCVuDZ4sgQbHg_1777385542
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-696307c7f2eso2336941eaf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777385542; x=1777990342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMgaMMRHBTfcJuhrkBN4N6UBYrSouh7MkAX9cEmU3Lk=;
 b=igi5+hxvCSmelGP2L+MieNEHXUi3yIUqcH5TV9p5DhDfuPZz/P6QPLXB/7KBka9eNR
 FsoQga2GMqxZhERcBHix/1+OvHCrDV7vFS9zpDBiGGu7Zt5ENfLy5Rdvf0Ae3JDIATcf
 dYz3J9gQmff/tQ6vrV1V41gouvcZOnUoJXBR4Z/ffhO5GT1MdLB8R7XP+ZZiyM+cR2Ug
 l4zrNXo0XP7zDMwE6u5xqGL+6WHLHoeNaHYFTBkjiBLBu4byExrhJNVtxuSoJMbwh+/c
 v1VOqT1EjmaVkSkwpKm9Q0qD+6+AC2gwJ9ZSuls3MUYlNG9X/fMQ0XiiVBU2zhYjOrPx
 kuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777385542; x=1777990342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GMgaMMRHBTfcJuhrkBN4N6UBYrSouh7MkAX9cEmU3Lk=;
 b=Vlr0H7WbF8deR+EzlDog4ClYtvV7bXNVWHy40q6+hBJ0jCJF4xonQe8cDZEIKSq8Mx
 upEG/2ogYj8r0BX27Oi6xOuCllph91fcCEvPmx3S8L1F9a/R4BfJ7OejIjzv33N0yd+c
 sm2Jj8q9QRGuxm2lluoYx8C1kcyehTE+ePCh1RQpPleZ5afxKmAqF9Y8LaSdjBZkx+GE
 8inHvDZ2wA+VmE4ZCLD8g2RvmOvW+SAxJv7NJ/55aIQ7DOHJmdDM2TcwFXN64IrYg0BG
 Zy85UyhurET1N7Ncu8pqtjz5EopU7P39jDo7XHnIEZpbt6Ld/slNJ0nnYr8CD93du4g6
 tw2g==
X-Gm-Message-State: AOJu0Yymz3nLA4+frHwu08bYw+fPgVuPOJaSzb69ZL7d8O3lKDwHegr1
 T/rRFZsb8bZJgTm87jUNUhfltoXJQ9d9/40+cLDxZrLFodmdJx64qx1N60+AvpyMdB66b3pA4yo
 vS5TNGCrRc+HjwZ4HDKFKiXE+M3LU4QetdFfr12ilESZM5GBFKPc4DC9rJ6ZTQMEgVDJcw3QJLO
 hTQ6PsqNvxFRaUw7Rj4EgmkUZn8KMGS2464R/jUgzW
X-Gm-Gg: AeBDietjiHTMlf1c2MdC8ZnB+bQ0OpXDpU1iOGOfQOTeRXtCmw5Y122AX2j5ZZ/zSLa
 nGHxctEYgXZvV9iS6c4q6s6law+k9JP5rZ7ttWLMmcUwIqbwgJuziwPkkHoSqG31OWPbrp0+GHF
 u44R1KCF+GEywDYaY/4xO0np+JhQ4tQEtgt3cPUgv+B84ZqgfuKh8n0Iypf91bpNiAHh3pNUK19
 UBjODqj8PxC1pGDjke9mOAM2gmOV5JUTIRl3sE5UwN1z/j1LQnxfg2sDToF4mka5pUyuLimM5Gb
 bbEGoIkk33AKJBe5jyL/so7Q9nDbTp5hjcqVNtDjDItby8XyJStKi6SGPSN03Ioy6BVSe/pT2j3
 N8mMp9LUBWptkmUIz
X-Received: by 2002:a05:6820:215:b0:67e:1b8b:862c with SMTP id
 006d021491bc7-6965c9115e4mr1537582eaf.0.1777385542020; 
 Tue, 28 Apr 2026 07:12:22 -0700 (PDT)
X-Received: by 2002:a05:6820:215:b0:67e:1b8b:862c with SMTP id
 006d021491bc7-6965c9115e4mr1537548eaf.0.1777385541466; 
 Tue, 28 Apr 2026 07:12:21 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5100db4d0d6sm18457251cf.24.2026.04.28.07.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:12:20 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:12:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 00/21] Introduce ACPI watchdog for Q35 and arm/virt
 boards
Message-ID: <20260428161215.49cc1c0f@imammedo>
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  3 Mar 2026 10:25:11 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> Changelog:
>   v2:
>      * ditch generic '-machine acpi-watchdog' option in favor of
>        board specific variants:
>            x86/q35:  -machine wdat={on|off}
>            arm/virt: -device sbsa_gwdt,wdat={on|off}
>      * arm/virt: add FDT and GTDT ACPI entries for GWDT when it's present
>        and hide GDTD one when WDAT is enabled.
>      * arm/virt: add test case for GTDT 
>      * [18-21] optional GWDT cleanup/fixes in handling WCV register update,
>        make QEMU behave according to spec (at least the way I read it and
>        it appears MS also read it that way). It fixes Windows 11 reboots when
>        GWDT is present (without WDAT). With that fixed it's up to MS to fix
>        their driver to set sane timeout as with the current one wdatchdog
>        will never trigger.

given merge window should be open by now,
gentle ping

> Windows doesn't ship built-in TCO watchdog driver, and users are
> forced to install vendor specific driver(s) if such exists.
> However the OS provides a generic watchdog driver that uses
> ACPI WDAT table [1] to abstract actual hardware behind it.
> The same applies to ARM version of Windows.
> 
> This series adds
>  *  WDAT table tailored for TCO watchdog that Q35 already
>     has as part of ICH9 chipset and a knob to enable it.
>  *  SBSA GWDT to arm/virt machine with WDAT table tailored
>     for it and necessary tweaks to GWDT to make usable
>     with WDAT driver.
>     * in addition to WDAT, it also adds native variant
>       with GWDT described in FDT and DTDT
>       (broken on Windows/works on linux).
> 
> Guest OS WDAT support is present since Windows Vista and Linux since 2016[2].
> 
> One can test it launching VM with following options:
>   * x86:
>        -machine q35,wdat=on
>   * arm/virt:
>        -device sbsa_gwdt,wdat=on
> 
> to trace access to TCO registers one can add to CLI:
>     -trace "tco_*"
> to trace access to GWDT registers one can add to CLI:
>     -trace "sbsa_gwdt*"
> 
> To verify that guest uses WDAT (both Windows and Linux would use it if present),
>   * on linux make sure that watchdog service is configured/enabled
>     (use wdctl to check what watchdog device is in use) and then
>     trigger kernel panic with command:
>       echo c > /proc/sysrq-trigger
>   * on Windows kill svchost process, running cmd in admin mode:
>       taskkill /f /im svchost.exe
> 
> Tested with WS2025 & RHEL9.6 & Fedora 43 (aarch64)
> 
> git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2
> 
> 1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> 2) https://lwn.net/Articles/700524/
> 
> PS:
>  previous revision:
>   https://patchew.org/QEMU/20260206131438.1857182-1-imammedo@redhat.com/
> 
> Igor Mammedov (21):
>   acpi: add API to build WDAT instructions
>   x86: q35: add 'wdat' property
>   x86: q35: generate WDAT ACPI table
>   tests: acpi: x86/q35: whitelist new WDAT table
>   tests: acpi: x86/q35: add WDAT table test case
>   tests: acpi: x86/q35: update expected WDAT blob
>   arm: sbsa_gwdt: fixup default "clock-frequency"
>   arm: add tracing events to sbsa_gwdt
>   arm: virt: create sbsa_gwdt watchdog
>   arm: sbsa_gwdt: add 'wdat' option
>   arm: virt: add support for WDAT based watchdog
>   tests: acpi: arm/virt: whitelist new WDAT table
>   tests: acpi: arm/virt: add WDAT table test case
>   tests: acpi: arm/virt: update expected WDAT blob
>   tests: acpi: arm/virt: whitelist GTDT table
>   tests: acpi: arm/virt: add GTDT watchdog table test case
>   tests: acpi: arm/virt: update expected GTDT blob
>   sbsa_gwdt: reduce code ident
>   sbsa_gwdt: move all foo_REFRESH logic under REFRESH condition
>   sbsa_gwdt: reschedule timer on direct WCV load
>   sbsa_gwdt: limit compare_value to INT64_MAX
> 
>  include/hw/acpi/wdat-gwdt.h            |  19 ++++
>  include/hw/acpi/wdat-ich9.h            |  15 ++++
>  include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
>  include/hw/i386/pc.h                   |   1 +
>  include/hw/watchdog/sbsa_gwdt.h        |   1 +
>  hw/acpi/aml-build.c                    |  14 +++
>  hw/acpi/meson.build                    |   5 +-
>  hw/acpi/wdat-gwdt-stub.c               |  16 ++++
>  hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
>  hw/acpi/wdat-ich9-stub.c               |  15 ++++
>  hw/acpi/wdat-ich9.c                    |  90 +++++++++++++++++++
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/virt-acpi-build.c               |  65 +++++++++++++-
>  hw/arm/virt.c                          |   2 +
>  hw/core/sysbus-fdt.c                   |  32 +++++++
>  hw/i386/acpi-build.c                   |  12 +++
>  hw/i386/pc_q35.c                       |  18 ++++
>  hw/watchdog/sbsa_gwdt.c                |  65 +++++++++-----
>  hw/watchdog/trace-events               |   9 ++
>  tests/data/acpi/aarch64/virt/GTDT.gwdt | Bin 0 -> 132 bytes
>  tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
>  tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
>  tests/qtest/bios-tables-test.c         |  54 +++++++++++
>  23 files changed, 618 insertions(+), 26 deletions(-)
>  create mode 100644 include/hw/acpi/wdat-gwdt.h
>  create mode 100644 include/hw/acpi/wdat-ich9.h
>  create mode 100644 include/hw/acpi/wdat.h
>  create mode 100644 hw/acpi/wdat-gwdt-stub.c
>  create mode 100644 hw/acpi/wdat-gwdt.c
>  create mode 100644 hw/acpi/wdat-ich9-stub.c
>  create mode 100644 hw/acpi/wdat-ich9.c
>  create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
>  create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
>  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
> 


