Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D624AC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 09:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tchYZ-00065j-JM; Tue, 28 Jan 2025 04:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tchYS-00064O-7v; Tue, 28 Jan 2025 04:06:46 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tchYN-000814-Pm; Tue, 28 Jan 2025 04:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738055200; x=1769591200;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=svtEERmO0y/WUJqzqzMGiKh6vDD28jhLrj06Mv458Ns=;
 b=nWz4BStWQqWIGNyRWA5H0UHLb2g5jFu5GxdJ2GtPH7Xj+7HzYmF+r8N6
 95mwbwrNKUm0tPTL2qebYKDXDTMy4kLW3VgbmvtyJv6XssATUfryzrLsE
 6c12iCNCW4z1cb5Z1PJc2efp/NbmpTpXVihwnJa8T56rfY4ydu0wcCzTx
 FLdk2Z8jw+AqCtMzmanTV+COKgV3vErz9Pc6vmLW2W5y3IKC6QjDJOZRg
 j4G9KLUqFvXInp/sQQ4kCiAr1iixwvDqy7PV2t11ymk1ovnDespbmnBsG
 aRfS/Nv0PmbAZhiVtD1+gpaKrVFFrDEYtlLI0/eQiSL7e+pF4rz4K6N1E w==;
X-CSE-ConnectionGUID: EvW37kJMQqeq3DBLTAgfjA==
X-CSE-MsgGUID: q2PmtiusSHK/pU0r221m6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="37733141"
X-IronPort-AV: E=Sophos;i="6.13,240,1732608000"; d="scan'208";a="37733141"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2025 01:06:35 -0800
X-CSE-ConnectionGUID: VdeX3PHHQ7KJEtMRXcaFKA==
X-CSE-MsgGUID: yGmw4x6ORRGfGtebLB79DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112682506"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 28 Jan 2025 01:06:34 -0800
Date: Tue, 28 Jan 2025 17:25:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/10] rust: qdev: switch from legacy reset to Resettable
Message-ID: <Z5iip55RwMTs8lNT@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-9-pbonzini@redhat.com>
 <Z5dgn5MQNGEa5lry@intel.com>
 <CABgObfY1LqB=9KOH0NOxdu+2gF4K+Xg9JqHWLfS9jpnN6Hp6wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfY1LqB=9KOH0NOxdu+2gF4K+Xg9JqHWLfS9jpnN6Hp6wQ@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> For now I prefer to make things homogeneous... this way if someone has
> to copy the code into a wrapper for a new interface they don't have to
> wonder about small differences.

Yes.

> (This by the way will also be a reason to use function pointers for
> character devices as well, instead of the trait approach that I used
> in https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html).
> 

Got it.

Thanks,
Zhao


