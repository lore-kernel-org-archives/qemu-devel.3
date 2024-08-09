Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E4DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scGLw-0001uB-Ge; Thu, 08 Aug 2024 23:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scGLt-0001tZ-TI
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:31:41 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1scGLr-0005oC-Sk
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723174300; x=1754710300;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=QbIpNfktatoMKfhHmUxdgliPiGkZXFxrwtj6S+VVZq4=;
 b=OIeOluWTKJHa4v57ChqzCv6PF8WnLPg6FyoL/y/+aXvuvyOOYE9LfWwE
 4Y4hJgIkSZcFkKCRjfJmDzCiH3EQvFfWzukLPKyQXXWNbb9+wRsf+ujt7
 zFQNdcANl2UevvG4+dBHJ/6qj7jdqg9LQjC7sZP10NZXk+dMeWVsL9k/8
 YmQvmCX8/+3Ai+JcEVFRTm6FCG82rWgoCcDubphEnd818DpTvQMeet9Dc
 CFCte1u8ov9HrbmQadKXAxUhfbfWGWZrIc9LRmD/M2/Xwot1R6ST0teWO
 ei+v86zk7YCfewNzSBg50a+XjmCRjJm5xCK59vK12Tj1+1gsIq+adF4A4 g==;
X-CSE-ConnectionGUID: CMb9/9iyQvO17ufEEJZrag==
X-CSE-MsgGUID: aD+nlyHRTvCtuI3vsX8f3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24241470"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="24241470"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 20:31:34 -0700
X-CSE-ConnectionGUID: godCJc7XRHS2btiuARrLCg==
X-CSE-MsgGUID: UhUcV34ESiuv/lizDRBXaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; d="scan'208";a="88311121"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 08 Aug 2024 20:31:31 -0700
Date: Fri, 9 Aug 2024 11:47:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v2 4/4] target/i386: Update CMPLegacy handling for
 Zhaoxin CPUs
Message-ID: <ZrWRSXIPYwEkpXK/@intel.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-5-ewanhai-oc@zhaoxin.com>
 <ZrSeMfpBm8NrXRWK@intel.com>
 <236c8032-6e17-4002-86e1-4483b55977f7@zhaoxin.com>
 <ZrWLgN1L280h75QF@intel.com>
 <d37a0bb1-23c3-4226-87c9-da73f4b59d72@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d37a0bb1-23c3-4226-87c9-da73f4b59d72@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, Aug 08, 2024 at 11:25:45PM -0400, Ewan Hai wrote:

[snip]

> Thank you for your suggestion; the changes will indeed make it clearer.
> I have a question: since you¡¯ve already added your reviewed-by tag to
> the first three patches, if I want to modify these descriptions, should
> I submit a v3 patchset containing all four patches, or should I only send a
> new patch titled "target/i386: Mask CMPLegacy bit in CPUID[0x80000001].ecx
> for Zhaoxin/Centaur CPUs"?

The v3 should contain all 4 patches, and you can add my R/b tag in the
first three patches.


