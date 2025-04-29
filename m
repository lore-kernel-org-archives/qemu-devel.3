Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83933C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eLZ-0001DR-Gl; Tue, 29 Apr 2025 02:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9eLW-0001Cg-Vr
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:21:35 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9eLU-0006X3-Ai
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745907693; x=1777443693;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kTsWkTqPLJS+luZ6xyPrdcySFy7/NlrqRoFPk3n4AmM=;
 b=oIDwZ2R2+M6zNrfnLdWOW6yi+Q3FqzEOXtfIRwpG5BrahN2eJHX3NzWl
 QIyFJRRevCPuRKx2A2jMgsS3iNqnHuh/SgX1gHtfPNb64Om1t6BkXp8PZ
 jkK+3uxajx/dXGF+6Hw6eVq00b30gQpm9YmY+WlsepxKovne5BtNzJi4Q
 YfxcFDSqGqIJz2zhjui6wfjoXKU4qGwRgC4DtT9cnlEb2s8iqYzWK04Qr
 YiXhbvbcRrIEM1KYPCSur1UjPYPSy54MMJhMNQvpnMi0dJ0yJPsTvXBSS
 SAEpGNrbwFRwV1u+zj5E33ksP5hSxXQklxWo+OJ3LadlCf2/GKf/9T2a6 w==;
X-CSE-ConnectionGUID: 54lNZE2OQMOMAPnMV714iQ==
X-CSE-MsgGUID: 1Vp0Jj1RR2yJb1Qo+F3eMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58170811"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58170811"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:21:26 -0700
X-CSE-ConnectionGUID: +NWIIVICTginJAZbSpAVXw==
X-CSE-MsgGUID: 8DC/uAdgQyOxiOfoLaZz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133689672"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 28 Apr 2025 23:21:22 -0700
Date: Tue, 29 Apr 2025 14:42:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 32/55] i386/tdx: implement tdx_cpu_instance_init()
Message-ID: <aBB0zTH8gbc0xWul@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-33-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-33-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 01, 2025 at 09:01:42AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:42 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 32/55] i386/tdx: implement tdx_cpu_instance_init()
> X-Mailer: git-send-email 2.34.1
> 
> Currently, pmu is not supported for TDX by KVM.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> chanegs in v6:
>  - new patch;
> ---
>  target/i386/kvm/tdx.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


