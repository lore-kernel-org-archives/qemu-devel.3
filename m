Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA39C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UpH-0000Iq-64; Fri, 04 Sep 2026 10:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2UpF-0000IH-QF
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x2UpD-0005Fu-Vx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788531807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlvAeZ5BVe+Clxx9SqJuL3MQ8UJUVicNHrhOy6P/WBQ=;
 b=LNxbKhlsQqe0dPBasaJmuaYXVbM4/1gLVSj43r3pyLHCki0S2Zt1Sm9qeXQIYMa+NXIecV
 3bYMW/40oT3qY3fOGP1KNQMJrTLtar3TeCmT+W2N+ISEgFozApR/NOH7DqZqYUxn/ekxnb
 eBG1LYNmYj5Q02aQYHIjiax/C2TVhCc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-Rvj7UMatOliI9XfRDjokeg-1; Fri, 04 Sep 2026 10:23:26 -0400
X-MC-Unique: Rvj7UMatOliI9XfRDjokeg-1
X-Mimecast-MFC-AGG-ID: Rvj7UMatOliI9XfRDjokeg_1788531805
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so14029495e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788531805; x=1789136605; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zlvAeZ5BVe+Clxx9SqJuL3MQ8UJUVicNHrhOy6P/WBQ=;
 b=WKNktx4aopQtlxq3r6Jf2XPjUKHNiI/39uxZBdXhn+22TSqUHjD6KQsjTdgIJC64JD
 cK+hMvX65xZfoQk0eN9vrjJo1kL+I4bS5FDm4Jshf+FuEPveuQHYeNe+iPPP/R6Z67rF
 thr7IqIu1huqOxHOMVH3/BwpvirjRTkuKY7BhivXwO9JPLZjh4t4rRYLPbcWyEID8aKP
 VHn1bTzxeZHFTxjYHq0Jydm3KfLkd10Y0I4JT0TPLD9uV2q74r5KFH29S2YJxoGpHVak
 yrO1ZRhXcVtt89uX8SG436kDgwsoPDcsYBJSA7qCvZbBa6wSntL9D7qu/roIaDzjMQ+N
 Vimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788531805; x=1789136605;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zlvAeZ5BVe+Clxx9SqJuL3MQ8UJUVicNHrhOy6P/WBQ=;
 b=msqvn6HgLgDOjchhyhC1wKkBMFjKF8FkbDUD0HeHfdhRV8YPBoGZufvyclGuBF+3gT
 GLZ8xMq69GP+XK0BWzyCe8ZR6rE0YoCOY/55ePkqbnAcWtT1SAsGfD3xklIp0nlflS9T
 swThuzYUS8u7Z+ARtHoX2whCP4F2xx7HiJ5ucmH12BGShrsOwsdWWWxkQ1BgNw0VkiLU
 U3h8fNDqO5kUhqOtEe7+Y91SpJ24VC3FrqzdYFKwhsI0Hfdwrd2PWX6PxjKHL/R3X6QS
 Ep8qPHIaVrBBFLwho7i3PudX+z+lIMJ39iIgOxAmOcChyLg4yzWbWdZogmcdyRCpqF+b
 4k+g==
X-Forwarded-Encrypted: i=1;
 AKwUvByMdcQV14hRgFPzIYIaWeM9OSw9FSwlyTGhdV4CGpyK6otSXgKkWeepufa1FsGS7l5yld75hnoEcu80@nongnu.org
X-Gm-Message-State: AFuF++neffg3u+R846dVa2AmUVn8CftFR1ijZYs/wHJauwfkH/RDHCzj
 HZWHnnoEXMuKVrl1EjRuStO1jx5GttDOQ7sFl6xeDd80MdgT74P5LwjsZnZrZR10G10TOnbzACU
 0bGlWo7vy3P0YqMXXNAmNkfX/Hz3bKSO4Du5ccd364RcQIHjvrsZqDuq7
X-Gm-Gg: AYBFou1TjZZzTfmOYMG6OB+nYTgsVNZBr1vWo4IW7uaa3WSW09tCCv1JbieFjwyZkiQ
 o0OoF6zwvLSy1WUaa6O3yd7I8XQ74ATuVK9vST1bkm8ioeTM2L+8/LWNTpmePeNeqq9GfpExrYl
 UeWNgPHG4701Hv2kBfdtZwHPN/zAQpgc14aIHZMlaVS5ove7+hzKrOlvEV2357CbhR+y9lKB78U
 8St3FU6Q3Hg71escLBN393NHVxB9JJAGmDMF9+oEKNHeC+iarJmFHTC9nH8xk4zGMWEcfu3FZCf
 sapo3cNzZRfkCc0v8XVO6sYyri4As35h1olzVK9hw7g3WgHpGICjh/gFsbSqvCSdubhD7AwyHS8
 EfhczoWSzCatbND5yXTiqGC8=
X-Received: by 2002:a05:6000:2388:b0:485:8a46:7054 with SMTP id
 ffacd0b85a97d-4858a46714amr4918035f8f.38.1788531802952; 
 Fri, 04 Sep 2026 07:23:22 -0700 (PDT)
X-Received: by 2002:a05:6000:2388:b0:485:8a46:7054 with SMTP id
 ffacd0b85a97d-4858a46714amr4917885f8f.38.1788531801396; 
 Fri, 04 Sep 2026 07:23:21 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883bbcddsm6608413f8f.20.2026.09.04.07.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:23:20 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, imammedo@redhat.com,
 sunilvl@ventanamicro.com, jic23@kernel.org, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, junjie.cao@intel.com, guoren@kernel.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 0/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Message-ID: <20260904074710-mutt-send-email-mst@kernel.org>
References: <20260831132340.5345-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831132340.5345-1-cp0613@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 31, 2026 at 09:23:31PM +0800, Chen Pei wrote:
> This series adds CXL support to the RISC-V virt machine, following the
> approach used by the ARM virt machine: CXL host bridges (pxb-cxl) are
> described as ACPI0016 devices, an ACPI0017 (CXLM) device is added to the
> DSDT with a _DEP on the CXL host bridges, and a CEDT table is built. A
> bios-tables test is added to pin down the generated ACPI tables.


I am guessing this will be merged by riscv maintainers?

acpi things

Acked-by: Michael S. Tsirkin <mst@redhat.com>

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
>  hw/riscv/virt.c                       |  46 ++++++++++++++++++++++
>  include/hw/riscv/virt.h               |   3 ++
>  tests/data/acpi/riscv64/virt/CEDT.cxl | Bin 0 -> 108 bytes
>  tests/data/acpi/riscv64/virt/DSDT.cxl | Bin 0 -> 6331 bytes
>  tests/qtest/bios-tables-test.c        |  54 ++++++++++++++++++++++++++
>  7 files changed, 157 insertions(+)
>  create mode 100644 tests/data/acpi/riscv64/virt/CEDT.cxl
>  create mode 100644 tests/data/acpi/riscv64/virt/DSDT.cxl
> 
> -- 
> 2.50.1


