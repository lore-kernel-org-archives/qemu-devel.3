Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3728C5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGVz-0007uC-Hz; Tue, 18 Aug 2026 05:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGVv-0007hm-4b; Tue, 18 Aug 2026 05:53:47 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGVt-0007RY-Hd; Tue, 18 Aug 2026 05:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787046826; x=1818582826;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4tKzRBHNuiiXS6U3nIlJrlS4L4QeqHHvuI6rLdfU2zk=;
 b=bEHa2Hhb6T9O/yl8Hgf4RKSLy6YL7fKJrGnGINJxk9QqY3cyckATx10Y
 oB3M7eNiD7nLpWxLbPr5qLCpgJeYnC3xvGLtItx4kz7KWOaZd+I6xoW+u
 aq9dyBVCC7NHWXt6g1L34e4jwvalzIxO9vtY17QpFR1bbCLH7Z+Dsvuqm
 f/OegNNQSakFqbjk+wI6ZID4krZlTLr3mXOt/ekojPHB+AIS9wBi/XC1Q
 Ogvhr9Pej6VIq7lM9p9DP81xe+pwCaki1evC/1gEkglCH5MmmwlDQFQd+
 lsJwnlPRd8vJMxSNQzRz+gbzmXSHyH/41bnMsjo3LQgIFzSwJuBaubu69 w==;
X-CSE-ConnectionGUID: 6zCbntPOTOemZHBfbYvuXA==
X-CSE-MsgGUID: rojGgJ1fTKmK7FuUbz9Snw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110321032"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="110321032"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:53:27 -0700
X-CSE-ConnectionGUID: lg5iqsyqRmWCp/hy1nCJwQ==
X-CSE-MsgGUID: gYx06Zo/Sgm6UJ3OdoHZ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="258977063"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:53:20 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, clg@redhat.com,
 cohuck@redhat.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Date: Tue, 18 Aug 2026 17:53:17 +0800
Message-ID: <20260818095318.252248-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813130623.2499506-11-mhonap@nvidia.com>
References: <20260813130623.2499506-11-mhonap@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Hi Manish,

On Thu, 13 Aug 2026 18:36:23 +0530, Manish Honap wrote:
> -void build_cxl_osc_method(Aml *dev)
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
>  {
>      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>      aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
>      aml_append(dev, __build_cxl_osc_method());
> +    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));

This is the bios-tables refresh the cover lists as pending:
/x86_64/acpi/q35/cxl and /x86_64/acpi/q35/acpihmat-genericx both hit
the all_tables_match assertion with a DSDT mismatch, and the asl diff
is exactly this _DSM under the pxb-cxl device (12638 -> 12684 bytes on
the acpihmat-generic-x variant). The g_assert aborts the test binary,
so a full run only reports the first case.

With preserve_config=false the method advertises no functions and
returns a zero buffer for every function, so the x86 half of the
change is dead AML plus golden-table churn. Append the _DSM only when
preserve_config is set: the x86 tables stay untouched and the pending
refresh drops out. Otherwise the usual three-patch bios-tables update
needs to ride in this series.

aarch64/virt has no CXL golden files, so nothing catches the arm side
either way.

Many thanks,
Junjie

