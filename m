Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC86BC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvSyY-0007Gn-E7; Thu, 20 Mar 2025 23:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvSyW-0007Fr-AM; Thu, 20 Mar 2025 23:23:12 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tvSyT-0001p1-5F; Thu, 20 Mar 2025 23:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742527389; x=1774063389;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VW905S5AtEa+aqLunlCnNTDg/VfBoD1PewmutLdb2ys=;
 b=byipzbQuVRgfemBYTM9z+GRLDhsScLaCJnIrKfROjXwc/Qt1LaY2koER
 xD03xqp1GVh2pHO+JcVrSLN3LJDa8n0y6QXk0xjHAgBhBkgLu2LKG8vKr
 tTPY3LzKv5wBCU8Wkd0yaXx519M3frxh+S1ehmj+2tM0b4SeOm77msl2+
 L76k3E4FJ0nlC7LMfKBwuKKBCa27SuVcegU+L/tPsp6oppAlhtnn2ZfGN
 Bc71Wyg3/IrI370JAwZjfGiSlZKYW53KzvTQ/d+vgCUSo85tBp76XeRN/
 MgoMHFkHrxsi22q7UgdDHM3FC/P2qkWSHv6HDyJGhHkimHVgwQb3U6d6O Q==;
X-CSE-ConnectionGUID: yvOqtbflRF2t4qCsVukOAQ==
X-CSE-MsgGUID: 5ua2EPnfRmqiBPb3I/64Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43973089"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="43973089"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 20:23:06 -0700
X-CSE-ConnectionGUID: zOxVwuLWQFi4cQC1qFTZ9g==
X-CSE-MsgGUID: PRbIxo2HQ6KErz7zyEbsEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; d="scan'208";a="128114389"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 20 Mar 2025 20:23:03 -0700
Date: Fri, 21 Mar 2025 11:43:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 0/5] accel/kvm: Support KVM PMU filter
Message-ID: <Z9zgVKtZyEx3MKuf@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <2fe2a98d-f70f-4996-b04e-d81f66d5863f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe2a98d-f70f-4996-b04e-d81f66d5863f@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

Hi Shaoqin,

Thank you very much for testing!

> I tried your series on ARM64, but it reports error at compile time, here is
> the error output:
> 
> qapi/kvm.json:59:Unexpected indentation.

I guess this is caused by my invalid format and sphinx complains that,
as Markus figured out :-(

What about the following change?

diff --git a/qapi/kvm.json b/qapi/kvm.json
index 31447dfeffb0..b383dfd9a788 100644
--- a/qapi/kvm.json
+++ b/qapi/kvm.json
@@ -54,11 +54,6 @@
 ##
 # @KVMPMUX86DefalutEvent:
 #
-# x86 PMU event encoding with select and umask.
-# raw_event = ((select & 0xf00UL) << 24) | \
-#              (select) & 0xff) | \
-#              ((umask) & 0xff) << 8)
-#
 # @select: x86 PMU event select field, which is a 12-bit unsigned
 #     number.
 #

> While I compiled it on x86, everything is ok. Could you please check why it
> failed on ARM64?

Maybe your Arm64 environment doesn't have sphinx_rtd_theme?

You can check it by:

python3 -m pip show sphinx_rtd_theme

> By the mean time, I will review and test this series.

Thank you again! I also plan to refresh v3, in maybe 1 or 2 weeks.

Best Regards,
Zhao



