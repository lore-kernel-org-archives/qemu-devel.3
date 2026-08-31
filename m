Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58AFC624D1
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11zs-00021i-TL; Mon, 31 Aug 2026 09:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x11zn-0001t7-1w; Mon, 31 Aug 2026 09:24:19 -0400
Received: from [115.124.30.118] (helo=out30-118.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1x11zd-0006pq-85; Mon, 31 Aug 2026 09:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788182635; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=qzSs9QVw+T76x5yniRTmHi/lUAOHwqXsoD/OC7tt2Mc=;
 b=MrPzk4eMix57seel3oH1yIqQd/UDGHPJxDIue6kB8NLQhXjng9IO2SnWkNh2CMVbfKfqh5juB6Gz/RoCv5M9i3xXQE+8uMimHgthfEnovSnpaUxR7L5hT8fZyC7LZvgGb9jp6T7Qp1rIRYXDhNjIutsuK3XQ6Hi5QFucnGQwoIw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=19; SR=0;
 TI=SMTPD_---0X9znfqW_1788182634; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9znfqW_1788182634 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 21:23:55 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: [PATCH v5 3/6] hw/riscv/virt: Advertise the CXL host bridge to
 firmware via extra-pci-roots
Date: Mon, 31 Aug 2026 21:23:34 +0800
Message-ID: <20260831132340.5345-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-1-cp0613@linux.alibaba.com>
References: <20260831132340.5345-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.118 (deferred)
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The pxb-cxl expander bridge presents as a class 0x0600 host bridge with
a type-0 header, so EDK2's PciBusDxe never recurses into it and never
assigns the CXL root port a memory window or bus numbers.  As a result
build_crs() produces an empty _CRS for the ACPI0016 host bridge and the
CXL devices behind it are not enumerated by the OS.

Advertise the pxb-cxl expander root buses to firmware via the
etc/extra-pci-roots fw_cfg file, the same way arm/virt and x86 do, by
calling pci_bus_add_fw_cfg_extra_pci_roots() from virt_machine_done().
EDK2's PciBusDxe then enumerates behind the CXL host bridge and assigns
the root-port window and bus numbers.  The ACPI tables are rebuilt when
the guest reads them (after that firmware enumeration), so build_crs()
then emits a correct _CRS for the ACPI0016 host bridge.

The call is made unconditionally, in line with arm/virt, pc and hppa,
so plain pxb-pcie expander bridges, which likewise depend on
etc/extra-pci-roots, are advertised as well; the generator simply
returns nothing when there is no expander root bus.

This approach also scales to multiple pxb-cxl host bridges (each gets
its own window from the shared aperture) and lets firmware size the
window to what is actually behind the bridge, rather than reserving a
fixed carve-out.

Verified by booting an RVA22 guest: the CXL root port and Type3 device
enumerate, and 'cxl enable-memdev' / 'cxl create-region' /
'daxctl online-memory' bring the CXL memory online as system RAM.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---

v5:
- Move pci_bus_add_fw_cfg_extra_pci_roots() out of the cxl block so
  plain pxb-pcie is advertised with cxl=off as well, in line with
  arm/virt, pc and hppa.

 hw/riscv/virt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e903551263..fb1941fe00 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1246,6 +1246,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
         cxl_fmws_link_targets(&error_fatal);
     }
 
+    /*
+     * Advertise the pxb/pxb-cxl expander root buses to firmware so that
+     * it enumerates behind them and assigns bus numbers and windows.  For
+     * the CXL host bridges, build_crs() then builds the ACPI0016 _CRS
+     * from the resulting state when the guest reads the ACPI tables.
+     * This is a no-op without any expander root bus.
+     */
+    pci_bus_add_fw_cfg_extra_pci_roots(s->fw_cfg, s->pci_bus, &error_abort);
+
     /*
      * An user provided dtb must include everything, including
      * dynamic sysbus devices. Our FDT needs to be finalized.
-- 
2.50.1


