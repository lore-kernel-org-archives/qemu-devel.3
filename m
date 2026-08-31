Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731FFC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0veK-0003IP-EC; Mon, 31 Aug 2026 02:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0veH-0003Hr-RI; Mon, 31 Aug 2026 02:37:41 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x0veG-0003hR-9s; Mon, 31 Aug 2026 02:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788158260; x=1819694260;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iSuHeRUKaoDL/U57MojllZSXRQszx6z8M4lOxElppBE=;
 b=TMX6VseigimwXssCoVWt8LBxnssDq1Pyu3A2pasWfr/QsNPJkV/JY0dr
 4CySQ7y/qHTGstRVBMicr0dVBmZBN6OToN8l7BtY5ODuypVHuIjwsWo6B
 rZab8+HJT4eXYenFq/BsycoK/jJSRTj+Q+CA08BqySfCNTD7o46Z8cOHC
 J8Zqp4/Xi7L6A5/mWqYigEyeC+ItSOXWElGWyAG5w/0PTDhY3h63OmHs4
 kyvC9FP1rEI9B/baKSNKINTKTriYoU8V/zAMvVTGwyksKEWPhn7Z8NHaN
 YzACBhFfejqXrIv6Bwa67tqi22q03YFgS53QeukBPw8mI8iPUqTkXVOu2 w==;
X-CSE-ConnectionGUID: efAgzu0jSFu0tF6u7wnSBQ==
X-CSE-MsgGUID: 3Q4fphu7S1OgKm8CSNNTNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88759405"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="88759405"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:37:36 -0700
X-CSE-ConnectionGUID: 2AxHrilYR7+95DI6YHkiGg==
X-CSE-MsgGUID: WkrBKzV6RYCliPPLO2a4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="298617335"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2026 23:37:32 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 3/6] hw/riscv/virt: Advertise the CXL host bridge to
 firmware via extra-pci-roots
Date: Mon, 31 Aug 2026 14:37:22 +0800
Message-ID: <20260831063723.409036-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828151317.815-4-cp0613@linux.alibaba.com>
References: <20260828151317.815-4-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Chen Pei,

On Fri, 28 Aug 2026 23:13:02 +0800, Chen Pei wrote:
> +        pci_bus_add_fw_cfg_extra_pci_roots(s->fw_cfg, s->pci_bus,
> +                                           &error_abort);
>      }

On the in-tree edk2 the qtest topology gets PC0C 0x40400000-0x405FFFFF
and bus [0x0C,0x0D] out of build_crs(), and two pxb-cxl (bus_nr 12 and
200) get 0x40000000 and 0x40200000 for their root ports' windows, so
the v3 TODO goes with it and the riscv side is down to this one call.
Your RVA22 run covers the guest side, the memory actually coming
online.

Reviewed-by: Junjie Cao <junjie.cao@intel.com>
Tested-by: Junjie Cao <junjie.cao@intel.com>

One optional thing about placement: select PXB in 1/6 also brings
plain pxb-pcie to riscv virt, and that one needs the same fw_cfg file
with cxl=off -- as posted, a pxb-pcie with cxl=off is never populated
by the firmware. arm/virt, pc and hppa make the call unconditionally,
and the generator returns nothing without an expander root bus, so it
can sit outside the cxl block. Moved here: the pxb-pcie case
enumerates with cxl=off and the four riscv64 ACPI cases still pass.
Here or as a follow-up, your call.

Many thanks,
Junjie

