Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1CFC982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 09:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8DdQ-0005SO-UT; Sun, 20 Sep 2026 05:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8DdH-0005QB-1o; Sun, 20 Sep 2026 05:14:49 -0400
Received: from mgamail.intel.com ([192.198.163.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8DdE-000392-8s; Sun, 20 Sep 2026 05:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789895685; x=1821431685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wQEzCUSivGHJ8c3rd7iLCcihTRKZrEeJA/Gr+Ea5/sI=;
 b=GWkqV/iHB7kCG5BLZyew+JHDr80IX5lczd3QoKYCzcgW8vlFSn6J7VXF
 s4OjXywUIwRPYW8B6je3HKhgq+nhyKjNbcGH+nn2FGS5QDWrWKgJw6t5p
 HMh7qt6kiSZbO0y6/MIDf3LR0QieybEbWSA1ljecGRK0p7v1RtGr4UMlF
 Spz/0ew1kMKqBj5XOqIVueTs/KxBoqOu0Xj1VKf1W++/RDD7AeMT9MdYw
 2X/NNdRrJd93vVAtJq3DhPkVMIErII5VFn6p3hU8/ES24okpHVzy7imot
 bDGerwtW2B+aGOzxmkGCEvPg6Y67mJ+Vx00C/PWiqL7GBLsdrxfd402/7 g==;
X-CSE-ConnectionGUID: vSTSdE8JRzqxfUjixVrkJw==
X-CSE-MsgGUID: T0AoOxQfSSGTL9FMWlZ6kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="905972"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="905972"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 02:14:42 -0700
X-CSE-ConnectionGUID: 86mLZJSiR/W+KT04aN9mQA==
X-CSE-MsgGUID: Zmx9090hSaSO9by6HGQ/Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="271357757"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 02:14:36 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, clg@redhat.com,
 cohuck@redhat.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org,
 skolothumtho@nvidia.com
Subject: Re: [PATCH v2 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Date: Sun, 20 Sep 2026 17:14:29 +0800
Message-ID: <20260920091429.717003-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916184412.3825713-11-mhonap@nvidia.com>
References: <20260916184412.3825713-11-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.5; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, 17 Sep 2026 00:14:12 +0530, Manish Honap wrote:
> under preserve_config, the _DSM. Gate the _DSM on preserve_config: x86 q35
> passes false as it does not use the accelerated SMMU, so it emits no _DSM
> and its ACPI tables stay byte for byte what they were.

Confirmed: on 28e7aad522 plus the series bios-tables-test passes on
x86_64 (q35/cxl and q35/acpihmat-genericx, the v1 failures, included),
aarch64, riscv64 and loongarch64.

accel=on is out of reach under TCG, so I forced preserve_config on virt
locally and booted an arm64 guest (7.3-rc1 based, defconfig) with a
cxl-type3 behind a cxl-rp.  With this patch Linux keeps the firmware
BARs and bridge window under the pxb-cxl; on 09/10 with the same hack
it releases and reassigns them.  No ACPI errors either way.

Tested-by: Junjie Cao <junjie.cao@intel.com>

08/10 still says the x86 bridge "still emits the ``_DSM`` method, but
its function 0 returns an empty support mask"; that was v1.

Junjie

