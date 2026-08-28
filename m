Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D21EC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztTL-0005jg-OV; Fri, 28 Aug 2026 06:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wztTJ-0005jG-5p; Fri, 28 Aug 2026 06:06:05 -0400
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cp0613@linux.alibaba.com>)
 id 1wztTD-0007aL-AK; Fri, 28 Aug 2026 06:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787911536; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=V/bY+2BGacHBQaSONjdxFGv1T988RUVBXyN1mtK2tK0=;
 b=hv9O5lL+cHA/R5op/YV4uVmkmQnzfa06T/cA44Uwe+0SAMhnoT3kjc6I/bFESeZiKU15z1x4d6sBluJg0E8h5vTn7ABT1RzY+TDH0xgmXzCOa11PDAXPGK65MDrWawwu2MMxp4rTDtC5HyZ7t1RKYL7VNpIAiUbLF4uvkgm9ZV8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=cp0613@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0X9m7gsE_1787911520; 
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com
 fp:SMTPD_---0X9m7gsE_1787911520 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 28 Aug 2026 18:05:35 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] hw/riscv/virt: Provide a 32-bit MMIO window for CXL
 host bridges
Date: Fri, 28 Aug 2026 18:05:18 +0800
Message-ID: <20260828172602.300003-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827193716.200002-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-4-cp0613@linux.alibaba.com>
 <20260826133754.355453-1-junjie.cao@intel.com>
 <20260827193716.200002-1-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=cp0613@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
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

Hi Junjie,

Following up on my earlier note -- I have done the rework and the
end-to-end verification you flagged.

Reworked along the extra-pci-roots line: riscv virt now calls
pci_bus_add_fw_cfg_extra_pci_roots() to advertise the pxb-cxl expander
root bus, and EDK2's PciBusDxe enumerates behind it and assigns the
root-port window and bus numbers.  build_crs() then emits a correct
_CRS for the ACPI0016 host bridge.  The regenerated DSDT shows the
firmware-assigned window (DWordMemory 0x40400000-0x405FFFFF, a
QWordMemory, and WordBusNumber [0x0C-0x0D]), and as you noted it scales
to multiple pxb-cxl (each gets its own window from the shared aperture).

Verified end-to-end on a booting RVA22 guest:

  # cxl list                      -> mem0 (4 GiB), port1, root0
  # cxl enable-memdev mem0        -> enabled 1 mem
  # cxl create-region -d decoder0.0 -w 1 mem0 -> region0 committed
  # daxctl online-memory dax0.0   -> onlined memory for 1 device
  # free -h                       -> 3.8Gi -> 7.8Gi (+4 GiB)

I will send the respun series shortly.

Thanks again,
Pei

