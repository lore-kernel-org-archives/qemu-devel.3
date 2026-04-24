Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B6FF34C45
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 03:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG6vx-00087c-1Q; Thu, 23 Apr 2026 23:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wG6vu-00086i-Ks
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 23:10:22 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wG6vr-0006TY-OG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 23:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777000218; x=1808536218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FP+1M2908530Ppg5X4haoT4mMFSatVymR3/GK8nXJKE=;
 b=ajEWsw7q4RhjmU7VXSoxaeLRbxNdNl4rWEfSMq0e01ZrDT4IE/Db3JRo
 vwx9k0Fk5xMtbOiCiozhnVPExC7GxvZ8Y/+9gWIEPp+LQfsvnawwT4m3x
 W7ik1iHx1hNLhSFXYYjTd22t4MnOMiSafPzxohDKOuXv3Kt6BIr2GW9Ey
 0r8l2Q1D697jo1Wq2CZKZUowZDlCaVoLfF0hDJF2DDmImxUU98+ZJRvpU
 xz/wCPcJWEisFwcqeAptFyJOGa21k8U6rPLRtjJfB5DSzBOLdxw8fOPvw
 m5Lsx+rAZhxE3RYBiRgmvo3Ql2nLkeDYBSVFp73Cg3xk7sGvfrZQY4LRl w==;
X-CSE-ConnectionGUID: k4MuffwuRR65nXpeJTdWgQ==
X-CSE-MsgGUID: YQRuzV6oSQi/Fd9z/YgJxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77960701"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="77960701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 20:10:13 -0700
X-CSE-ConnectionGUID: kzZzzat6ROyMK/KfXqIm1w==
X-CSE-MsgGUID: NHMlJkquRgqmTDkJGTrYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; d="scan'208";a="237186077"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 20:10:11 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@bull.com, zhenzhong.duan@intel.com,
 junjie.cao@intel.com
Subject: Re: [PATCH 1/2] intel_iommu: Replace assert(size == 4) with guest
 error in MMIO handlers
Date: Fri, 24 Apr 2026 11:09:35 +0800
Message-ID: <20260424030935.2664678-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1c4b67db-447f-408e-a6b4-c477894f1a59@linaro.org>
References: <20260420170523.17908-1-junjie.cao@intel.com>
 <1c4b67db-447f-408e-a6b4-c477894f1a59@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

Thanks to Philippe for the suggestion - this direction makes the
overall logic much cleaner.

I have drafted v2 locally: raising .impl.min_access_size from 4 to 8
so that the handler always sees size == 8, which eliminates all 25
assert(size == 4) call sites and every size-based branch.  The low
half of each 64-bit register pair now uses vtd_set_quad(), while the
_HI cases stay with vtd_set_long(); for 32-bit registers, the wmask
ensures that zero-extended 8-byte writes cannot clobber adjacent
registers.  The default branch falls back to vtd_set_long() where an
8-byte access would exceed the register file.

Currently replaying all 24 fuzzer-found crash inputs, will also run an
8-hour generic-fuzz, and testing with a qtest that sweeps every 
4-byte-aligned offset with 8-byte reads and writes.  Will send v2 
once everything checks out.

Feedback is very welcome, whether on this thread or on v2.

Many thanks,
Junjie

