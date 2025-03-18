Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 07:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuQwW-00081L-RJ; Tue, 18 Mar 2025 03:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQwC-0007wQ-I4; Tue, 18 Mar 2025 03:00:43 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuQw8-0002ak-TE; Tue, 18 Mar 2025 03:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742281229; x=1773817229;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AMunR9H9ot49jcjr4NFedITbJrotXvQVxm/6vLlBb0k=;
 b=MLZkEukY1kzKSbzbM3mouuyP20hCZKt5NYpwE7VoBQdn+eeN/o+3JRE8
 loTE7Zc31FE/KdM9QM/e+MGRxDBaD0hI/3ySMFxPXFQoodsc98xoKfQCZ
 sHDqhP8WoLkkuKiByqx9oPio8EUU089VwY6ZSyEtyFX5OACbOI/wMTNuP
 IlPGFrTNoU6LBLcgV1HVjq3+b+sI1K1p7/PtX3D76cUEhb1IUld96jxrN
 Yyhp9GKW0XOQubjRIAAQC6E5Ms0Af2pHwHq9/ScSAj3exVuDM8Q5izog/
 /2ZD14lqcVsdGZBcvVUy2UAq7q1ziYeZJGx6dVzN6U4GrQwKuRUHMWp1J g==;
X-CSE-ConnectionGUID: w9high/UTeKhRH3hK3HF3w==
X-CSE-MsgGUID: DgPuujX2They7SuxbuUp/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43537001"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="43537001"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 00:00:24 -0700
X-CSE-ConnectionGUID: 43j9xjvsQAand9rmtKINdA==
X-CSE-MsgGUID: 6je8HWxxStSXA8aO95GLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; d="scan'208";a="121903757"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 00:00:23 -0700
Date: Tue, 18 Mar 2025 15:20:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Subject: Re: [PATCH 13/17] rust/vmstate: Support vmstate_validate
Message-ID: <Z9kexLFNuyQjCffE@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-14-zhao1.liu@intel.com>
 <CABgObfauvyAbmt7GewurAEw9d+HanhjvDa1tT=S_4Oo9Huty0g@mail.gmail.com>
 <Z9kUdJUP0JrkcKMJ@intel.com>
 <CABgObfZgpYa6CohM7t=1mnoJh3mZ++QqzZw9gFCabiHL8wOoBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZgpYa6CohM7t=1mnoJh3mZ++QqzZw9gFCabiHL8wOoBg@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

> For now I would leave out a generic field-exists check, and keep the
> implementation of vmstate_validate as you did it in v1.
> 
> Once we look more in the builder concept we can think of adding also a
> VMStateField<T> (with a PhantomData<fn(&T) -> bool> inside) and add
> with_field_exists().

This makes sense!

Thanks,
Zhao


