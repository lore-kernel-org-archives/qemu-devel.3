Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C73C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ckj-0003LF-Am; Tue, 15 Apr 2025 05:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4ckg-0003Ka-Gb; Tue, 15 Apr 2025 05:38:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4ckd-0003lt-IW; Tue, 15 Apr 2025 05:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744709923; x=1776245923;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=DIFM4eqQu01Zbc5fSSrZIkWVfd0JHiP4PmzdSxbGFGs=;
 b=IvLc5FqSMt8/JGUfj2qc3roBSft+tW/2AdbPKqC7f62t+0Ws/GuIS4RG
 Dk2+dsyUMTUJGfVddMi1Q3mLVP1XQ3rBtOiCcoNkeB48EfX4qe8r7QBVi
 a6+GsrP+EQHx2fQbzLjMXUdnSpf804bzziZjm2sqTMm9L9qCKGrIov/z6
 cAJGSUiwSgMSK2wWS2DjwoqnNIgvYjAMw82V3n/w15cV+NiefswQSHvdg
 VxNg/5uPgvbNNFKiGMuFeZ6NhF/tiZMP+5KMyIyzM2I9JpqMV/I+Rcur/
 rQGGhDVWvrFBobT+7Tn/JNIg5c+rKvKhyWZZtbouolD0TnQ6JLJWFVHKr A==;
X-CSE-ConnectionGUID: eUcyMgZ7SFyhvoiUcqvqUw==
X-CSE-MsgGUID: 91W0/XR2TJKVCPVNrTXSHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="56847394"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="56847394"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 02:38:39 -0700
X-CSE-ConnectionGUID: Kqa946dMR6KG/menuDGeCw==
X-CSE-MsgGUID: Fn+ryVDoRseBGNiN5UVZNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="161113285"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 15 Apr 2025 02:38:35 -0700
Date: Tue, 15 Apr 2025 17:59:27 +0800
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
Subject: Re: [PATCH 0/5] accel/kvm: Support KVM PMU filter
Message-ID: <Z/4t/zxQzp4Wxdm9@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <21f3fedd-274e-4e81-87f8-369deefa8c1a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f3fedd-274e-4e81-87f8-369deefa8c1a@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Apr 15, 2025 at 03:49:59PM +0800, Shaoqin Huang wrote:
> Date: Tue, 15 Apr 2025 15:49:59 +0800
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: Re: [PATCH 0/5] accel/kvm: Support KVM PMU filter
> 
> Hi Zhao,
> 
> I've added some code and test it on ARM64, it works very well.
> 
> And after reviewing the code, it looks good to me.
> 
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

Thank you Shaoqin for your support!

Regards,
Zhao


