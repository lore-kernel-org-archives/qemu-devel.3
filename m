Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA26C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NSm-00021H-S2; Fri, 04 Sep 2026 02:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x2NSm-00020O-1V; Fri, 04 Sep 2026 02:31:48 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x2NSk-000636-Ky; Fri, 04 Sep 2026 02:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788503507; x=1820039507;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yJz0hmZ3jXnW+3e70x7bossu4Qz0K/22Q4P/UCuWfMU=;
 b=Dvy/rdBVIoLIRVNpF+g2C6n7enlgfRo2I7MuIVduH0AIt6zVsDJ59YQK
 TLiRgmZLyb+OS3PvuDt7xGdXlTqSR6deUvGXZuiykde2Ez7Re9WbR76E5
 TFde9FzLNufBw3lOrr/lIGaTcTFDvAA/9HzWCLpZxukHjmCCrW8tHKAjY
 S2pIvJV2nqH5x9hui8CgPeXWE4UwEBZe25NIZj2s+hsCRZ3Y+LF5jfo3n
 bG0ftBxbB4TXzmCcbqiVdDvj6ax0Q/gllMxl4RBv6Z6GvBLkTJak6dObB
 Dohm6AnJdNqQ7v2LMnnUa1qR7F/BWvhcKGy3CYXWvef9OrV3nBdZioRyF g==;
X-CSE-ConnectionGUID: e3Xb1HXiREaxoFNG6eROPQ==
X-CSE-MsgGUID: ykNovcd9TqinCGBoqu69Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="89053536"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="89053536"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 23:31:44 -0700
X-CSE-ConnectionGUID: nYq0w4UjT6CUQyNTv8GS3w==
X-CSE-MsgGUID: UZGknod0QUmMZu+qNK6HxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="263755465"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 23:31:39 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 5/6] tests/qtest: Add RISC-V ACPI bios tables test for
 CXL
Date: Fri,  4 Sep 2026 14:31:30 +0800
Message-ID: <20260904063131.452351-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831132340.5345-6-cp0613@linux.alibaba.com>
References: <20260831132340.5345-6-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=junjie.cao@intel.com;
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

On Mon, 31 Aug 2026 21:23:36 +0800, Chen Pei wrote:
> +        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",

master renamed these to edk2-riscv64-{code,vars}.fd since v4
(2e0eeac953, in the 1 Sep firmware pull), so on 99e54ab5e7 this case
does not get QEMU up: "Could not open 'pc-bios/edk2-riscv-code.fd'".
riscv-to-apply.next has not picked up the rename yet; v6 still wants
the new names.

Many thanks,
Junjie

