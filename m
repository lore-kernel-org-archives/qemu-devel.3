Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440E5C79FB9
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4PEg-00047t-3a; Wed, 09 Sep 2026 16:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4PEf-00047d-6a
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4PEc-00053J-JS
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 16:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788986973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHiSepGinwiII0mvyeXa4Lpu4fO4fTRZi4IFC+jBTrQ=;
 b=OiyWhGyVylt6p0UsyZwwWu+s1ev6w2BQ5Zpw5gCxa9W+opDw+L5Q8GkPDkd0KijES6sNq1
 GGeZ7ddPWr5EkrD+2aCDyHTUxrch1I3COaHJDUiDkziUh1WBu1JkzdfBc1Erp0zF9ZHHUP
 H909SChdaLkTAy8OnhfgVN2Ex2MzpJQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-PXcWeoisPYmJz5FmFTOahw-1; Wed, 09 Sep 2026 16:49:32 -0400
X-MC-Unique: PXcWeoisPYmJz5FmFTOahw-1
X-Mimecast-MFC-AGG-ID: PXcWeoisPYmJz5FmFTOahw_1788986971
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so81577875e9.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788986971; x=1789591771; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iHiSepGinwiII0mvyeXa4Lpu4fO4fTRZi4IFC+jBTrQ=;
 b=YGlkN2yr6jkybV5UgXMTOMukO4VgdkAsxi3HS+N5dtPe8r0MVt0cTS9FLGAJLSRTU/
 8J0ESRYWeJcgJK2hCfNJ6NBBrWvJSmI9cNhTApxS3GeULNnlRLbHVxKcMvfsVTmsoEw7
 112Sl8LcKZv/N/C/ltzsTLw8yPIAQZx0GVud8a4rK5ATKeLUHYw6npIsZs43WqXAxzBk
 EdARXgucuEvSl8zO2pzw/w5ncwfGJ4EFO9SWYVhGa4h+eWp7txsaQ5tgbbQtw2SxZWn3
 wr2v5pLxvY58X4kJMp5lBiDIPlnhuHEBxBT43Bj3OmleshzdL+aeQ8ZVanaDfrAX+VSo
 rvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788986971; x=1789591771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iHiSepGinwiII0mvyeXa4Lpu4fO4fTRZi4IFC+jBTrQ=;
 b=GY41whKYh1DNH5RUjFZ2KcbrqcDKeIwQ8wwDwoqkarJScLuoDS9HjSSCTYTpP22l6B
 0hE14EUmbF/0COVicCFnvB2dRxHYhOYiNnRmTYaE7I1FhCwWSQY7MRSNsDHI2M+eTLkP
 9j+84aNO6PJnkJ29zvOq6I8yenuXiUHMJB/VpB05x9DS1EOzKI76kh2+ksiz0/Ar9WM6
 jZxj17/vglLZ6mRGq+L02tamPGWY1nuvEWni4U8313D1ABoUoRoSNoFyPtBSU+wtjHuC
 XS4s0oq4W4rWBmfd3EG5iFmOwQoczCWlN58XoxbbyxHg0wZg4Ms+FepHdeSuTTH9yeMh
 SBBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGSZtReEJxrpZu/5nSuA11vozwwbOtHLBnsHsPpqO2vNOR/NLLjP+I6iq4VBB1f/xs3U60rBclc0nY@nongnu.org
X-Gm-Message-State: AFuF++l0n8MfuYrb0y3jVsffABSgPgpg6pxHaxEot8Ig6ooylj6Ic4Vt
 7TsDt2jUJHXCuNpvVXMmr0D7vsNbANlV/+6zWz8JnnbEHUbOkiHu+3TcitC8TgP3BG9wcSEhJMG
 Esh/4NR+KSOrqXcLVWxUiEX0A8zoVepzlBt/ieiYFvkAj14bbtF6mvmWi
X-Gm-Gg: AYBFou0MRnM5ytJZ4TKGgtRHkwcoov7HDnH6YuiMdSEOJ2DQaVFeiWqXCXm8rUIjxPX
 8vGz/XhfGy4BeH8/6V3Tkz9/zrkhlQ9r6Yo8mY1bDN5BvYr0zimoVrC6NH2v5CgcenVy3wfm3Tl
 h2adHVgYxgmRtBmAC6EnZ0Zc5cuiTsHjFMkbctIcBzGBrt4PeJO0ti9bgihU9mhU/fsTDwnEezw
 8Jeh40IAjWe4NppOwwHO2h+zmm4dWQYhTQHMPPv6n84lYr12hj+rj0iX7845aLAvaFzP25brEPX
 fudK7cE8xP33nJqsfacZpCQlVHHknR6G2Zq1chsLXd5ZkJsfw58WkZRmEHxpv6qLjgol9B42GMH
 qyyC4DV5V2FNiTkLcjxjbzcU=
X-Received: by 2002:a05:600c:630a:b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49d2592c540mr64631805e9.12.1788986970639; 
 Wed, 09 Sep 2026 13:49:30 -0700 (PDT)
X-Received: by 2002:a05:600c:630a:b0:49c:f89b:f82 with SMTP id
 5b1f17b1804b1-49d2592c540mr64631285e9.12.1788986970075; 
 Wed, 09 Sep 2026 13:49:30 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bc5fsm16859975e9.3.2026.09.09.13.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 13:49:29 -0700 (PDT)
Date: Wed, 9 Sep 2026 16:49:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, imammedo@redhat.com,
 sunilvl@ventanamicro.com, jic23@kernel.org, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, junjie.cao@intel.com, guoren@kernel.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Message-ID: <20260909164855-mutt-send-email-mst@kernel.org>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907093735.2753-1-cp0613@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 07, 2026 at 05:37:27PM +0800, Chen Pei wrote:
> This series adds CXL support to the RISC-V virt machine, following the
> approach used by the ARM virt machine: CXL host bridges (pxb-cxl) are
> described as ACPI0016 devices, an ACPI0017 (CXLM) device is added to the
> DSDT with a _DEP on the CXL host bridges, and a CEDT table is built. A
> bios-tables test is added to pin down the generated ACPI tables.

ACPI things:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

pls merge in riscv tree.

> Changes since v5
> ----------------
>   - Rebased onto current master, over the gpex_pcie_init() move to
>     device-common.c: s->pci_bus is now assigned at the
>     riscv_gpex_pcie_init() call site in virt_machine_init().
>   - tests/qtest: switched to the renamed in-tree firmware blobs
>     pc-bios/edk2-riscv64-{code,vars}.fd (Junjie).  The goldens are
>     unchanged and still match with the updated edk2-stable202608 blob;
>     all riscv64 ACPI cases pass.
>   - hw/riscv/virt-acpi-build: the _DEP commit message now cites the
>     companion kernel commit bf5418a5fe63 ("ACPI: scan: Honor _DEP for
>     ACPI0016 PCI/CXL host bridge") alongside 3a59c3b772e5, both in
>     v7.2 (Junjie).
>   - Collected review tags: Junjie Cao's Reviewed-by/Tested-by on
>     patches 1, 2 and 6.  Michael S. Tsirkin acked the ACPI parts on
>     the v5 cover letter thread.
> 
> Changes since v4
> ----------------
>   - tests/qtest: DSDT.cxl regenerated against the in-tree
>     edk2-riscv-code.fd blob that the test boots (Junjie): the v4 golden
>     carried the window allocation of my local edk2-stable202602 build.
>     The 64-bit window is now 0x400100000..0x40010FFFF with the matching
>     PCI0 range shift; the AML fragment in the commit message is updated
>     accordingly.  CEDT.cxl is unchanged.
>   - hw/riscv/virt: pci_bus_add_fw_cfg_extra_pci_roots() moved out of
>     the cxl block (Junjie), so plain pxb-pcie expander bridges are also
>     advertised to firmware with cxl=off, in line with arm/virt, pc and
>     hppa.
>   - Collected review tags.
> 
> Changes since v3
> ----------------
>   - The CXL host bridge resource handling is reworked, following Junjie
>     Cao's suggestion (and Igor Mammedov's earlier "fix UEFI" direction):
>     instead of reserving a fixed 256 MiB carve-out and simulating the
>     firmware PCI initialization in QEMU, the machine now advertises the
>     pxb-cxl expander root buses to firmware via the etc/extra-pci-roots
>     fw_cfg file (pci_bus_add_fw_cfg_extra_pci_roots(), as arm/virt and
>     x86 do).  EDK2's PciBusDxe then enumerates behind the CXL host
>     bridge and assigns the root-port window and bus numbers, and
>     build_crs() emits a correct _CRS for the ACPI0016 host bridge.
>     This keeps the machine code minimal (a single call, no carve-out),
>     scales to multiple pxb-cxl host bridges, and lets firmware size the
>     window to what is actually behind the bridge.
>   - The bios-tables test is split into the staged flow documented in
>     bios-tables-test.c, and ordered the same way the riscv64 goldens were
>     originally added upstream (Sunil V L's commit cc3ba2422554 et al.):
>     the feature code comes first, then three consecutive commits -- empty
>     golden files + allowed-diff.h, the test code, and the populated golden
>     master binaries with an emptied allowed-diff.h.
> 
> Changes since v2
> ----------------
>   - hw/riscv/virt: The MMIO-window patch no longer touches the common
>     gpex code (Igor).  The gpex_cfg.cxl_mmio32 field and the is_cxl
>     static _CRS branch are dropped; the ACPI0016 _CRS now comes from the
>     generic build_crs() path.  Since EDK2 does not enumerate the pxb-cxl
>     expander bridge, riscv simulates the firmware PCI initialization
>     (reserved window + depth-first bridge bus numbers) and re-applies it
>     via a reset handler.
>   - hw/riscv/virt: Drops the machine-global window/bus-range synthesis
>     that did not scale past one pxb-cxl (Junjie).  The series targets a
>     single CXL host bridge for now, documented in the commit message and
>     a TODO.
>   - hw/riscv/virt: CXL host register region and FMW setup folded into a
>     single cxl_host_state_init() helper; redundant braces removed in
>     create_fdt_pcie() (Daniel).
>   - hw/riscv/virt-acpi-build: the _DEP commit message documents the
>     kernel-compatibility behaviour (Alistair).
>   - Carried review tags: Sunil V L's Reviewed-by on the _DEP patch and
>     Alistair Francis's Acked-by on the test.
> 
> Changes since v1
> ----------------
>   - hw/riscv/virt: PCIBus *bus renamed to PCIBus *pci_bus (Jonathan).
>   - hw/riscv/virt: Dropped outer if (s->pci_bus) guard around
>     cxl_hook_up_pxb_registers(); the function already handles a NULL
>     bus internally (Jonathan).
>   - hw/riscv/virt-acpi-build: All s->bus references updated to
>     s->pci_bus; iasl -d decompiled DSDT fragment added to commit
>     message.
>   - hw/riscv/virt,gpex: Commit message expanded with PCI-to-PCI Bridge
>     Spec §3.2.5.8/9/10 citations (Jonathan).
>   - Original patch 4 ("Map committed HDM decoder ranges as RAM for
>     direct DMA") dropped; superseded by Alireza Sanaee's v8 series [1],
>     which is now merged upstream and thus no longer a prerequisite.
>   - New patch 4: RISC-V ACPI bios-tables test for CXL, with golden AML
>     files generated and included.
> 
> [1] https://lore.kernel.org/qemu-devel/20260318171918.146-1-alireza.sanaee@huawei.com/
> 
> Test
> ----
> Built riscv64-softmmu and ran the new bios-tables test together with the
> existing riscv64 ACPI tests; all pass.
> 
> Also booted an RVA22 guest with EDK2 firmware, using pxb-cxl + cxl-rp +
> cxl-type3 + a CFMW: EDK2's PciBusDxe enumerates behind the CXL host
> bridge (advertised via etc/extra-pci-roots), the root port and Type3
> device show up (0000:0c:00.0 / 0000:0d:00.0), and 'cxl list' reports
> the memdev (4 GiB) and the CFMWS root decoder.
> 
> QEMU invocation (CXL-relevant options shown):
> 
>     qemu-system-riscv64 \
>         -M virt,aia=aplic-imsic,acpi=on,cxl=on \
>         -cpu rva22s64 -smp 2 -m 4G \
>         -object memory-backend-ram,id=vmem0,share=on,size=4G \
>         -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>         -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
>         -device cxl-type3,bus=rp0,volatile-memdev=vmem0 \
>         -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
>         ...
> 
> Verification (total system memory grows by 4 GiB after onlining):
> 
>     # cxl list
>     # cxl enable-memdev mem0
>     # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
>     # daxctl online-memory dax0.0
>     # free -h
> 
> Chen Pei (6):
>   hw/riscv/virt: Add CXL support to the RISC-V virt machine
>   hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for CXL host bridge
>     dependency
>   hw/riscv/virt: Advertise the CXL host bridge to firmware via
>     extra-pci-roots
>   tests/qtest: Prepare golden files for the RISC-V CXL ACPI test
>   tests/qtest: Add RISC-V ACPI bios tables test for CXL
>   tests/qtest: Update RISC-V CXL ACPI golden master binaries
> 
>  hw/riscv/Kconfig                      |   2 +
>  hw/riscv/virt-acpi-build.c            |  52 +++++++++++++++++++++++++
>  hw/riscv/virt.c                       |  56 +++++++++++++++++++++++++++++++---
>  include/hw/riscv/virt.h               |   3 ++
>  tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
>  tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
>  tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
>  7 files changed, 163 insertions(+), 4 deletions(-)
>  create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
>  create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl
> 
> -- 
> 2.50.1
> 


