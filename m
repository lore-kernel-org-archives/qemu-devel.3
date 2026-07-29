Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59E2C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3X2-0003Xq-73; Wed, 29 Jul 2026 08:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wp3Wp-0003XW-U7; Wed, 29 Jul 2026 08:36:56 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wp3Wk-0007K1-2c; Wed, 29 Jul 2026 08:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1785328579; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=jKlcdBnFuHgRxrT49QtoTVmYgMs7rTqDYQgsQRVgtko=;
 b=yrC8hcqvn3Nkg8nYirUUimLRMMKsFZV4+b9yVySNwpADg1vvo/7f0/113yUkfXToMXYbkqe2RdxErCRmTVvliAeuvpH0TUdf5hdrt88VwTFD83YASn/JlIdAMuBXhQ2iv5nw0ibF0dFHgxuYJOjcB7CZzbKupFRTmmPN+b7jTYg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R871e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0X82AQ0a_1785328573; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X82AQ0a_1785328573 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 29 Jul 2026 20:36:17 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com,
 alison.schofield@intel.com, mst@redhat.com, guoren@kernel.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,
 gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Wed, 29 Jul 2026 20:36:10 +0800
Message-ID: <20260729122505.200000-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727110615.3e523125@imammedo>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
 <20260618093827.3507-4-cp0613@linux.alibaba.com>
 <20260727110615.3e523125@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=cp0613@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Hi Igor,

Thanks for the review.

On Mon, 27 Jul 2026 11:06:15 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> I kind of dislike (basically riscv specific hack) in generic code.
> well, correct way to tackle this is
>  1: fix UEFI to perform required initialization.

I agree this is not a clean solution, and I acknowledge the concern
about putting riscv-specific behavior into the shared gpex code.

I did try the "fix UEFI" direction first. With the current EDK2
(edk2-stable202602, the same FdtPciHostBridgeLib/PciBusDxe used by
both aarch64 and riscv virt), I booted a riscv virt machine with
pxb-cxl and dumped the ECAM config space after the firmware finished
enumeration:

  - pxb-cxl (1b36:000b) on bus 0: class 0x0600 (host bridge),
    header type 0, memory/prefetchable window registers all zero;
  - cxl-rp on bus 12: memory window base > limit (empty, reset value);
  - cxl-type3 on bus 13: entire config space reads 0xffffffff,
    i.e. the firmware never enumerated behind the CXL host bridge.

The root cause is that PciBusDxe only recurses into devices for which
IS_PCI_BRIDGE() is true (header layout 1), while pxb-cxl presents
header type 0 and class 0x0600, so the firmware neither assigns it a
secondary bus number nor any MMIO window. FdtPciHostBridgeLib likewise
only consumes the single "pci-host-ecam-generic" node describing PCI0
and has no knowledge of the expander bridge. As a result build_crs()
genuinely returns an empty set on riscv today - this is not a timing
artifact.

> if you have to put a hack into QEMU, make it work with current build_crs()
> and localize 'proper simulated initialization' in riscv codebase
> (i.e. do not spread it to common codebase). But before doing it see (#1 not=
e).

Understood. Since #1 (a UEFI that performs the initialization) is not
available on riscv at the moment, the static window is currently the
only path that makes CXL host bridge _CRS usable here.

For what it is worth, this is consistent with how CXL is being handled
on the ARM side. The sbsa-ref enablement (Yuquan Wang, RFC up to v7,
"hw/arm/sbsa-ref: Support CXL Host Bridge & CFMW" [1], plus the
matching edk2-platforms RFC [2]) deliberately carves out exclusive
static MMIO32/MMIO64 and bus-number ranges for the CXL host bridge and
builds static ACPI tables, explicitly noting that it "doesn't need to
communicate CXL contents via DT to edk2". Jonathan Cameron's arm/virt
approach instead relies on EDK2 performing the enumeration and QEMU
reading the result back via build_crs(), but that depends on a recent
EDK2 with expander-bridge support that we do not have on riscv yet;
his earlier DT-binding RFC for expander bridges [3] also notes that on
the DT path QEMU has to allocate the windows itself.

[1] https://lore.kernel.org/all/20250807111037.241118-1-wangyuquan1236@phytium.com.cn/
[2] https://op-lists.linaro.org/archives/list/asa-dev@op-lists.linaro.org/thread/EPPN4R6KLGKYLWPOZUBWJG5HCXAAO3SQ/
[3] https://lore.kernel.org/all/20230421165037.2506-1-Jonathan.Cameron@huawei.com/

Given that, my tentative plan for v3 is to keep the static-window
approach for now but address your objection by localizing it: drop the
cxl_mmio32 field and the is_cxl branch from the common gpex code, and
instead simulate the initialization in riscv virt code so that the
existing build_crs() path produces the correct _CRS (i.e. have riscv
pre-populate the bridge window registers / range set the way a
firmware would), keeping the common codebase untouched.

Before I rework it that way, I would appreciate any suggestions you
may have on this approach.

Thanks,
Pei

