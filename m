Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BB5E6C60F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 07:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIN8g-0006bC-Sz; Tue, 03 Dec 2024 02:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tIN8F-0006Qm-Vp; Tue, 03 Dec 2024 02:15:41 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tIN8D-0006vk-BR; Tue, 03 Dec 2024 02:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733210137; x=1764746137;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ozA8pvxK7Z3OttOaLFyMztzPGG0614j9/FWPg+mmF3A=;
 b=QjI0yuW1+fXUr3d9m7jdNemJS/Cwzb2MsiJ6Vz+zrG+EPcmSyKO9Z+0R
 NTeNCB2InJv/1lrRn9Te2Onx1U+pTObwPY9egGtAu0oywb3X9hTSRZEXY
 fJ91LFt7MG8tR7Py8lhe0IxTrrivqRfyJVc2HCzovD5Nn+3VYg+unYkX/
 jr8FIismnx/hPcUdZhqR8Xc1cZQnW7d7FFbZjhzbtmkGiQzLMMvxegPE5
 ex4V544fMKHMyS5TtJ+DISr5Om2GbGJk7l8995IsrTYyYAlIr+dMyNM32
 JY3qdbk7jMfcb1GoVQW5aAwyqnt6FhXX0vgXHP9EWtNAQEJbBjuGOKD5n A==;
X-CSE-ConnectionGUID: wFYkO5sRTPCM8NykvoodoQ==
X-CSE-MsgGUID: 0vs+Uo6+SkacTesDAqFpaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50933644"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="50933644"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2024 23:15:32 -0800
X-CSE-ConnectionGUID: XzjBPNCXSumMFBLvMifBLA==
X-CSE-MsgGUID: yB6p+8A3QaClp8uC3P1KuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; d="scan'208";a="93750981"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 23:15:30 -0800
Date: Tue, 3 Dec 2024 15:33:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, pbonzini@redhat.com,
 imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <Z060VQVV6ONK9Qd2@intel.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
 <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
 <a48fcd78-d1c4-4359-bc18-d04147a93f50@intel.com>
 <ZwyRsq4EIooifRvb@intel.com>
 <bbcfcbbd-1666-4e97-ae18-f47202d89009@intel.com>
 <ZxDS4L8vSr3HfFIh@intel.com>
 <b43557f7-49ff-43bb-8a8c-887b8220e1e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43557f7-49ff-43bb-8a8c-887b8220e1e8@intel.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

> However, back to the patch, I think we cannot change it as this patch
> directly. Instead, we need a compat_props for the changed behavior, because
> this isn't a bug fix and it introduces guest-visible differences.

This is a fix, not a new feature, so compat_props is not needed.

> For ancient Intel CPUs, EBX[23:16] did represent the number of Logical
> processor per package. I believe this should be the reason why QEMU
> implemented it as is:
> 
>   - on SDM version 013, EBX[23:16]: Number of logical processors per
> physical processor; two for the Pentium 4 processor supporting
> Hyper-Threading Technology.
> 
>   - on SDM version 015, it changed to: Number of initial APIC IDs reserved
> for this physical package. Normally, this is the number of logical
> processors per physical package.
> 
>   - on SDM version 016, it changed to: Maximum number of logical processors
> in this physical package.
> 
>   - finally, starting from SDM version 026, it changed to what reads now:
> Maximum number of addressable IDs for logical processors in this physical
> package.

And this is an architecturally defined CPUID, so SDM ensures backward
compatibility.

Regards,
Zhao


