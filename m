Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8919C982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 09:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8DdL-0005Qb-DR; Sun, 20 Sep 2026 05:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8Dd6-0005OO-DR; Sun, 20 Sep 2026 05:14:36 -0400
Received: from mgamail.intel.com ([192.198.163.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1x8Dcu-00034B-Nu; Sun, 20 Sep 2026 05:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789895665; x=1821431665;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v2rtAa7OnoLGt7yC9nrc7236Ndj29tw5GLmsPQj3eMw=;
 b=bcm+Nn7bcA0PiBCT3jxjlfyGjyvL4LbJ7wf3QXIAjeyQFFyH/ZVITZY5
 zXNjuRyn68G+pIgxnkleIFtk02cgCcfJduMRrby7e/sZQZSd4Yg5aacCc
 edcyzMtG0K6SsOznF1TZH5DEMh5od/rw5MdxYkYkN0+T6UCOtBMKLDFco
 NmISkWiEDgA1tfAasoI1dhXF1ie827WvWgYhxYD7qVTMskK2z2mXfNLJK
 y2umqqoLuH9JTcptipWaCvk6qvR+YEWQyXdojF/NLOwi4Q1xoZY0j5TQQ
 olAgwWDEESJ/wGInq4lxcdyY0ubAqQbvARhS2Wwf+/L8BnVZhmSz3ktHg g==;
X-CSE-ConnectionGUID: cCAFZ/cIRL6GdUxeO1R5aA==
X-CSE-MsgGUID: twKwbfhtR3afDWYJAUTtDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="905944"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="905944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 02:14:18 -0700
X-CSE-ConnectionGUID: B+ViNU7pTSSOhzNDpcDBEw==
X-CSE-MsgGUID: hekfD3bbTq+2qIGMHzRWvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; d="scan'208";a="271357721"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 02:14:12 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Manish Honap <mhonap@nvidia.com>
Cc: alex@shazbot.org, ankita@nvidia.com, jic23@kernel.org,
 dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, eric.auger@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, clg@redhat.com,
 cohuck@redhat.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 07/10] hw/vfio/pci: Map the CXL memory on the guest
 decoder commit
Date: Sun, 20 Sep 2026 17:14:03 +0800
Message-ID: <20260920091403.716987-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916184412.3825713-8-mhonap@nvidia.com>
References: <20260916184412.3825713-8-mhonap@nvidia.com>
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

On Thu, 17 Sep 2026 00:14:09 +0530, Manish Honap wrote:
> +     * Record the base the guest programs into a decoder so the commit handler
> +     * can reject a base other than the device's CFMWS window. The base low
[...]
> +        vdev->cxl.guest_base_lo = (uint32_t)data & VFIO_CXL_HDM_BASE_LOW_MASK;
> +        vdev->cxl.guest_base_written = true;

This answered my v1 question for the kernel v4 FSM model.  With v5
(20/27) the kernel gives a live read-only view and leaves any write
virtualization to the VMM, and what QEMU shows the guest is a
committed, locked decoder at the window base.  A locked decoder
ignores a base write, but here it is recorded, and if it differs from
the window base the next rescan unmaps while reads still return
Committed at the window base.  That is the mismatch the check was
meant to prevent.  A current Linux guest never writes a locked
decoder, so it won't trip this.

Is the guest-written base still meant to matter in this model?  If
not, guest_base_{lo,hi,written} can go.

> +     * The kernel runs the lock-on-commit FSM in the write above, so the
> +     * committed state is settled by now; a control write on any decoder can

Stale now that the kernel no longer acts on the write?

Junjie

