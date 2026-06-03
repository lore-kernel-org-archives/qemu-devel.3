Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570D3CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUeud-0002os-Aj; Wed, 03 Jun 2026 02:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wUeuc-0002oH-2s
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wUeuZ-0001xv-Uc
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780467426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SK42V8DL8AiyUKt99gPwHBrxNb00Gv5X+Rl+2awU3sQ=;
 b=ZBIS3QAGQp7trZ2JPPL+61k2HvoEDdqzUtGNMxeP1sXgtuMf6nhRhxiFn1QeZr3xHFO/KY
 mOVsjP1K4doEP3rJqRIF07ekCEanjrtHq8qYOpSC8r4/KSqyarFsOSlhrnPEcKtsB32e+I
 4KJmzrZpp2qYHMnD294WAd2xglG0BRc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-IARhGy-CMXazNQBoTj32Pw-1; Wed, 03 Jun 2026 02:17:05 -0400
X-MC-Unique: IARhGy-CMXazNQBoTj32Pw-1
X-Mimecast-MFC-AGG-ID: IARhGy-CMXazNQBoTj32Pw_1780467424
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45ef2bd566bso2944564f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780467424; x=1781072224; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SK42V8DL8AiyUKt99gPwHBrxNb00Gv5X+Rl+2awU3sQ=;
 b=X93Roesly83WjF+/eyGmpOEM+hErAueFlEgVgtb3vWtVPm2oUWU61kI6eNC/XzAYkd
 vQZZH3ZSVkv9KlM9xiSFBeWXPLmv4RhbYnaWlLX/Aykj9EPKQLCHETNqUewj/cyf4C8A
 zzAZAAnu7fdONYp0Pao1hdtFt533b3hd0A9W3LMB6FSVgr33UN7C4bRBibFrsdgRAg1k
 KI1kqHi+D355Wr4+vrwfkA62FqlwMZ4F9DW8ixptuoo51Y+PGx6WGlX8biCOmLDVvM2y
 VCjjWQjr3iZIwQU4SI/TWwisAPwPwOir8tlRErG8TG3D48B/d+a0p+rti5GMyvAl95Dd
 o+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780467424; x=1781072224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SK42V8DL8AiyUKt99gPwHBrxNb00Gv5X+Rl+2awU3sQ=;
 b=IhIArfz1L4kEJsMATUTgDLj8qULvYEVkJEmX2n0Nt2bWT0L+TeseRHGZR8uKw/jm4Z
 07vhPm3BpN8Ju6B4u30HhQ2xDJN8jSvqY1UJ/sF7j0iyDgilon2djNUNxzkmLRqZLw4I
 JH/ark0cVG8HiOl9icWh6GwKoCdtYvlN/xbbpKEJdsv9OtgRJBvprLKYVxemYquYKcZX
 SvwZFpfc/IqIwOwwe0i/tp6K7nlcFgqoDDBvKKKXeN63CqAGyyVoM6YBoDMy2X/p6E8z
 FOPXHn9Taf4v88aBpjM+xbDVznBo26DQYPWuV3cCIscTDbfWCP99HciwBP/BFjYlncqk
 3hGA==
X-Gm-Message-State: AOJu0YztjV67VrR6704H7W9FCMQL7kPxHomfRmYYyxaKFzBZpXxtAHtv
 IwU4ioSTCjfaE699hsh7PTfY1SmNoc77X0R21gE0cFzXNZc8QvYt5Yf3cPHb5qQwxM7ehJl+gpk
 Y7R3ApaI+34cyA5UteXPqjVyuA8lLgnglL1JyGpfxqQrrB2vQI++JOMyu
X-Gm-Gg: Acq92OGhvD/wZ/+lJujIbvwF/mW1IxzBxouM7Ma0uWukMSBrMiuNm0r7joaHCLapSgf
 NMzIkr8uK4vKy0iOdGiNl+xUe9JJYoP6HKqaUIV7evn2ZZYkPT5UUt9KFPoTkgMtDsmsfFDZmj+
 bOIIOl43bR2fVrd2+cX428id13vknaq/BrtqklyM4oI2pktt4zVnDbZ5elBXbBJ+evdyX/Vgzdz
 jXy2InkBbLG4dREvpv3K/cVgSnJrigI5B3+q+E6gWN6XBqII3JjonIYEBE6vbTkAF4xfiGADmDT
 ed4+JqDZAm/C3vURqsDeIOlqMX+AimxLQT/b2GOydDzDnx/dE1nqYPonevGCnBHtCAUzGvIDdkU
 Ayx6XOTs+tLeGorL+powXFUnaR6goJiyVV3GejrJ8dNI/HFXxllI4UA==
X-Received: by 2002:adf:f484:0:b0:460:efd:c682 with SMTP id
 ffacd0b85a97d-460218271b6mr1911533f8f.24.1780467424027; 
 Tue, 02 Jun 2026 23:17:04 -0700 (PDT)
X-Received: by 2002:adf:f484:0:b0:460:efd:c682 with SMTP id
 ffacd0b85a97d-460218271b6mr1911481f8f.24.1780467423511; 
 Tue, 02 Jun 2026 23:17:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35f2e6sm4909136f8f.32.2026.06.02.23.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 23:17:03 -0700 (PDT)
Date: Wed, 3 Jun 2026 02:17:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 00/21] Introduce ACPI watchdog for Q35 and arm/virt
 boards
Message-ID: <20260603021642-mutt-send-email-mst@kernel.org>
References: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303092532.2410177-1-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 03, 2026 at 10:25:11AM +0100, Igor Mammedov wrote:
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

I picked the x86 patches for now.

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
> -- 
> 2.47.3


