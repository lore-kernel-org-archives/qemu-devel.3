Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4DCCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 14:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOz3x-0001UE-An; Mon, 18 May 2026 10:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wOz3v-0001Tq-26
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wOz3s-0007s9-Tn
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779114915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MgIlykHkGNF8bfeDDgS7KR+swoaarGo4n37t1LGEOU=;
 b=RBO1s2dIXyphcQk8tQ80BqZm9OFygm5v1OaP1fjqksbZVaviPhuFIQsw6aMJfU/iX/NaiI
 ecROqldJe8Yc2uyabrgXyXjoy7bcJkaBlMdmIydz1YuAKKUpxFqs++er/gpX7OxC2XY2KA
 3jQ3OPdAqytOyxU9xcNcQ72YVwjLbMI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-7C3b-CtWOUuv_AdtPb-yqQ-1; Mon, 18 May 2026 10:35:14 -0400
X-MC-Unique: 7C3b-CtWOUuv_AdtPb-yqQ-1
X-Mimecast-MFC-AGG-ID: 7C3b-CtWOUuv_AdtPb-yqQ_1779114910
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45e78dd7baaso1322510f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779114910; x=1779719710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MgIlykHkGNF8bfeDDgS7KR+swoaarGo4n37t1LGEOU=;
 b=lr92Zr4I9sgo7nmHAZUH4Ri/g/IoBA48yXPOAWuX1jjymmNfhux8UdvbMtjQKsCqdQ
 2/k2Ou75uWsZIZVezi36Jke5XXx+ONZ3GbveCYJhAXhLC9TjnxZ6iwW7r9WTSD3B6aaf
 ej1elTusMA49NEWvd6/7K8uLhSzX4QnK1haMJrjPtzdHtdzT3VqP1qdyOQM28znz92iH
 9b4tfDOBehw8lo+4XV/UYG5rE4RCpL+s7yxIkT23UacK//5APOoec6GdGhv9pWw2+lOw
 zEU778GVJoywG18gKDQsuYC/GmUEHz2Akqbd3EgdsSfHhuJMxupuH+LswhbUicTCaNn0
 HEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114910; x=1779719710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MgIlykHkGNF8bfeDDgS7KR+swoaarGo4n37t1LGEOU=;
 b=EqQOyBZtx6m0uUXl+Y8STqWYNQZMkKgEaggpI1ilkyCC6vMi9ySprGbLctBha2n2nz
 VE33D16208JBizHVpu33LPBdNYVu0HG2VYMxXTivDQJAQ6h+w3a+n3ZQ5r0cwCTPD5lw
 9LZN4r2EFh+zHndVNTzdDMw3/TJSXPQJtU6pe/PRHy4GCH6dRiAm2TYhoSOjPLGX1O8h
 Q3vmP+q64zHsMNClV4X8+ce2w+KiFVPrrVwwqruk2WhuIaRJhd+zEuiaiMM+jVhyXv1C
 n3hu/Y2ILWNAhzFynhf64rueGvxk0NIPcLgfmY1eH7sYbM+05+HmCuoN/VSdI686QlmG
 1C+g==
X-Gm-Message-State: AOJu0Yz6xZtq9RRVnXHqkmes/yUFvD8m55Y05onv3J4RF4/o+Vxk+/K8
 acU6Bpvgp+OTnDUIcnYxyR0cy558M6jalFqvaQ4tD2T+ZWsQhZWAHhzh49xyrPMqgnKctcuiQbO
 BROVnuPQDhDLQU4RB/xgizlOYZopVxsHUmOGxjRzjQgltotKqra6T1NY3Qy/rjPvXq/MtPRB/gA
 NBAehiapecKGDVjWOiQrdqKgAP49ZCdcuSmOBJk9Jr
X-Gm-Gg: Acq92OEvb/3f7KgOsf5NF8BQwq5ouYWGqeWGRWS21Ix79kEJacZNrhf12DFw73Q20SH
 nuFfHNSqqn15Gfc0lX0cLYqBXeO69KVr9YK2iatYe7ZjfT/iOW0IzTAL76pqYdumfEhmWtUsxAr
 3Xc4f1lYMN0slaKITEKE86Mnsw5oQgLKre7rEhhSmxHsCpcjNCcNJsJSP71TY1hwwNmIosebWex
 FqxjklCG+jQfOMeL1JuEtgmEQHttxrLZdpOJodPpbgl+ivUjkYojRQUsYtG9Xd1CGgvpz12ymN6
 2lrc/NiiKgF/OVj38Q6+VRIoDWPswD295t1MvOYNluGqi1G44moz4l2C714FUZcnMXzTaCZtCOA
 cCt1PKA==
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-48fe6329913mr188799715e9.31.1779114909740; 
 Mon, 18 May 2026 07:35:09 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-48fe6329913mr188798985e9.31.1779114909192; 
 Mon, 18 May 2026 07:35:09 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm37143726f8f.30.2026.05.18.07.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 07:35:08 -0700 (PDT)
Date: Mon, 18 May 2026 16:35:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 00/21] Introduce ACPI watchdog for Q35 and arm/virt
 boards
Message-ID: <20260518163507.7b794600@imammedo>
In-Reply-To: <20260512153057.1a353c3e@imammedo>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260428161215.49cc1c0f@imammedo>
 <20260512153057.1a353c3e@imammedo>
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

On Tue, 12 May 2026 15:30:57 +0200
Igor Mammedov <imammedo@redhat.com> wrote:


Peter,

could you take a look at ARM related patches,
I hope that I have addressed you concerns from v1.

> On Tue, 28 Apr 2026 16:12:15 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue,  3 Mar 2026 10:25:11 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > Changelog:
> > >   v2:
> > >      * ditch generic '-machine acpi-watchdog' option in favor of
> > >        board specific variants:
> > >            x86/q35:  -machine wdat={on|off}
> > >            arm/virt: -device sbsa_gwdt,wdat={on|off}
> > >      * arm/virt: add FDT and GTDT ACPI entries for GWDT when it's present
> > >        and hide GDTD one when WDAT is enabled.
> > >      * arm/virt: add test case for GTDT 
> > >      * [18-21] optional GWDT cleanup/fixes in handling WCV register update,
> > >        make QEMU behave according to spec (at least the way I read it and
> > >        it appears MS also read it that way). It fixes Windows 11 reboots when
> > >        GWDT is present (without WDAT). With that fixed it's up to MS to fix
> > >        their driver to set sane timeout as with the current one wdatchdog
> > >        will never trigger.    
> > 
> > given merge window should be open by now,
> > gentle ping  
> 
> 2 weeks later,
> yet another ping
> 
> >   
> > > Windows doesn't ship built-in TCO watchdog driver, and users are
> > > forced to install vendor specific driver(s) if such exists.
> > > However the OS provides a generic watchdog driver that uses
> > > ACPI WDAT table [1] to abstract actual hardware behind it.
> > > The same applies to ARM version of Windows.
> > > 
> > > This series adds
> > >  *  WDAT table tailored for TCO watchdog that Q35 already
> > >     has as part of ICH9 chipset and a knob to enable it.
> > >  *  SBSA GWDT to arm/virt machine with WDAT table tailored
> > >     for it and necessary tweaks to GWDT to make usable
> > >     with WDAT driver.
> > >     * in addition to WDAT, it also adds native variant
> > >       with GWDT described in FDT and DTDT
> > >       (broken on Windows/works on linux).
> > > 
> > > Guest OS WDAT support is present since Windows Vista and Linux since 2016[2].
> > > 
> > > One can test it launching VM with following options:
> > >   * x86:
> > >        -machine q35,wdat=on
> > >   * arm/virt:
> > >        -device sbsa_gwdt,wdat=on
> > > 
> > > to trace access to TCO registers one can add to CLI:
> > >     -trace "tco_*"
> > > to trace access to GWDT registers one can add to CLI:
> > >     -trace "sbsa_gwdt*"
> > > 
> > > To verify that guest uses WDAT (both Windows and Linux would use it if present),
> > >   * on linux make sure that watchdog service is configured/enabled
> > >     (use wdctl to check what watchdog device is in use) and then
> > >     trigger kernel panic with command:
> > >       echo c > /proc/sysrq-trigger
> > >   * on Windows kill svchost process, running cmd in admin mode:
> > >       taskkill /f /im svchost.exe
> > > 
> > > Tested with WS2025 & RHEL9.6 & Fedora 43 (aarch64)
> > > 
> > > git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2
> > > 
> > > 1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> > > 2) https://lwn.net/Articles/700524/
> > > 
> > > PS:
> > >  previous revision:
> > >   https://patchew.org/QEMU/20260206131438.1857182-1-imammedo@redhat.com/
> > > 
> > > Igor Mammedov (21):
> > >   acpi: add API to build WDAT instructions
> > >   x86: q35: add 'wdat' property
> > >   x86: q35: generate WDAT ACPI table
> > >   tests: acpi: x86/q35: whitelist new WDAT table
> > >   tests: acpi: x86/q35: add WDAT table test case
> > >   tests: acpi: x86/q35: update expected WDAT blob
> > >   arm: sbsa_gwdt: fixup default "clock-frequency"
> > >   arm: add tracing events to sbsa_gwdt
> > >   arm: virt: create sbsa_gwdt watchdog
> > >   arm: sbsa_gwdt: add 'wdat' option
> > >   arm: virt: add support for WDAT based watchdog
> > >   tests: acpi: arm/virt: whitelist new WDAT table
> > >   tests: acpi: arm/virt: add WDAT table test case
> > >   tests: acpi: arm/virt: update expected WDAT blob
> > >   tests: acpi: arm/virt: whitelist GTDT table
> > >   tests: acpi: arm/virt: add GTDT watchdog table test case
> > >   tests: acpi: arm/virt: update expected GTDT blob
> > >   sbsa_gwdt: reduce code ident
> > >   sbsa_gwdt: move all foo_REFRESH logic under REFRESH condition
> > >   sbsa_gwdt: reschedule timer on direct WCV load
> > >   sbsa_gwdt: limit compare_value to INT64_MAX
> > > 
> > >  include/hw/acpi/wdat-gwdt.h            |  19 ++++
> > >  include/hw/acpi/wdat-ich9.h            |  15 ++++
> > >  include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
> > >  include/hw/i386/pc.h                   |   1 +
> > >  include/hw/watchdog/sbsa_gwdt.h        |   1 +
> > >  hw/acpi/aml-build.c                    |  14 +++
> > >  hw/acpi/meson.build                    |   5 +-
> > >  hw/acpi/wdat-gwdt-stub.c               |  16 ++++
> > >  hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
> > >  hw/acpi/wdat-ich9-stub.c               |  15 ++++
> > >  hw/acpi/wdat-ich9.c                    |  90 +++++++++++++++++++
> > >  hw/arm/Kconfig                         |   1 +
> > >  hw/arm/virt-acpi-build.c               |  65 +++++++++++++-
> > >  hw/arm/virt.c                          |   2 +
> > >  hw/core/sysbus-fdt.c                   |  32 +++++++
> > >  hw/i386/acpi-build.c                   |  12 +++
> > >  hw/i386/pc_q35.c                       |  18 ++++
> > >  hw/watchdog/sbsa_gwdt.c                |  65 +++++++++-----
> > >  hw/watchdog/trace-events               |   9 ++
> > >  tests/data/acpi/aarch64/virt/GTDT.gwdt | Bin 0 -> 132 bytes
> > >  tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
> > >  tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
> > >  tests/qtest/bios-tables-test.c         |  54 +++++++++++
> > >  23 files changed, 618 insertions(+), 26 deletions(-)
> > >  create mode 100644 include/hw/acpi/wdat-gwdt.h
> > >  create mode 100644 include/hw/acpi/wdat-ich9.h
> > >  create mode 100644 include/hw/acpi/wdat.h
> > >  create mode 100644 hw/acpi/wdat-gwdt-stub.c
> > >  create mode 100644 hw/acpi/wdat-gwdt.c
> > >  create mode 100644 hw/acpi/wdat-ich9-stub.c
> > >  create mode 100644 hw/acpi/wdat-ich9.c
> > >  create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
> > >  create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
> > >  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
> > >     
> >   
> 


