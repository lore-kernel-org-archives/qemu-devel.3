Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663D6C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwGV1-0006bD-Nk; Tue, 18 Aug 2026 05:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGUz-0006YW-R6; Tue, 18 Aug 2026 05:52:49 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wwGUy-0007Ga-Br; Tue, 18 Aug 2026 05:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787046768; x=1818582768;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f3YjCUHz/HQgR2eb8Nvf3nHJJ35ze1mcCMPnO/f/KNc=;
 b=ihQnSR6UV9CWT/R2EG4CpPQt6XBVpnqap3bV/Y7Vo+zTUqoJi34QW46y
 FRj3fh6Hv0w+D/nZWbZT/M9CE2yJNNreeZTKpeIVD1tls3SbF/HXUnhp7
 IU3ETorxd78SlxglfvVTYjlFuXAXKFAt0noXYWBpOK6je7oOKauD6DjQw
 pyRpn3HBQeMGlCw86QkmVov89gbTqTxNDCVL/gnoea1Fbf6SodL7mjKmJ
 Z8TcjYNYqi4hGglVMlZCl0YMt6K9a4q7SR6vZoWq2GzHq/VphcRU3k3S7
 fuUUq8BFUhos4WHHgevGL3eYSY5hqMEzHKUbO0l6yS1HAy1imudw3eCmO g==;
X-CSE-ConnectionGUID: Vz/suN7hRi22+EsUNhHYzQ==
X-CSE-MsgGUID: 8ZZStRF4RjqvUciP4B4Xlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110320627"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="110320627"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:52:04 -0700
X-CSE-ConnectionGUID: s4blOm2PT2u3t7YKdQAryQ==
X-CSE-MsgGUID: S1z7JpJITdurddZbhOGELA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="258975835"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:51:56 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, clg@redhat.com,
 cohuck@redhat.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/10] QEMU: CXL Type-2 device passthrough via vfio-pci
Date: Tue, 18 Aug 2026 17:51:50 +0800
Message-ID: <20260818095151.252195-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813130623.2499506-1-mhonap@nvidia.com>
References: <20260813130623.2499506-1-mhonap@nvidia.com>
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

On Thu, 13 Aug 2026 18:36:13 +0530, Manish Honap wrote:
> Base: master (post pull-9p-20260725), commit 6333226c2a.

The footer's base-commit is 055952c0aa (the pull-hex-20260812v2-1
merge) and that is where the series applies; this line looks stale.

On that base, cxl-test still passes 12/12 and bios-tables-test fails
two cases from the new pxb-cxl _DSM -- details on patch 10. Comments
on 6 and 7 as well.

Many thanks,
Junjie

