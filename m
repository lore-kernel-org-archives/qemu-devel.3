Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7ABD767D8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 16:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6XyJ-0000Lg-PO; Thu, 31 Oct 2024 12:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6Xy7-0000Ji-OT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:24:23 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t6Xy0-00024G-Oa
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 12:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730391853; x=1761927853;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SaMSW5dqKpu1S/+h0T6Umguv0j6pHee0GJQFILgnvbc=;
 b=KbIiXrZkaWpxHgImTd2JEbiMZnNW7S8MpylArx+DpDfM0FOQHqNHxF/V
 XrhX7tEXp5RjHDPmkkLzvW9DWtZQYrZ2FnJU9WnDFmVVZma6FSGXapZ84
 FLfEj+lmRzPXMUOWAXlnz1ErMy5j+ZzMS/XyYdu9g8hyJe/f1bLL9DJe7
 XLyrJd1R2jta+mWsf8pOMSiS+tRrcNpqt+qZBZYS2bexxab+SlZEwKoQV
 uggyVTVqpPRmz2Siph46Z6J50Nb9ND/eKNEz5LUKJH6Fe90bilmuSYAEQ
 W9V3cO2tk6a9dPpktgL1MXV7bW6j3X8Mzi0ja1NHscRAhcyLjZw93+e1U g==;
X-CSE-ConnectionGUID: yMCkz/t3Q+GsSEoaFSnvqg==
X-CSE-MsgGUID: 8oFj9pP8Rsajz+pSkL+OLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30258925"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="30258925"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2024 09:24:08 -0700
X-CSE-ConnectionGUID: ae4nvHklSYS0LYth8nlHxQ==
X-CSE-MsgGUID: XTlmUYvnTsGG4cmd50YCpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; d="scan'208";a="86606598"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 31 Oct 2024 09:24:07 -0700
Date: Fri, 1 Nov 2024 00:41:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: Re: [PATCH v3 00/23] rust: fix CI + allow older versions of rustc
 and bindgen
Message-ID: <ZyOzVYpqHYx8O6Yc@intel.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

> This series can be found at branch rust-next of my git repository
> (https://gitlab.com/bonzini/qemu.git), which also helps with the
> problems in applying patch 8.  Everything up to commit f6a46d2a4eb
> ("rust: do not use TYPE_CHARDEV unnecessarily", 2024-10-25) will be
> my next pull request, which I will send early next week (to give
> people some more days to complain).
> 
> Paolo
> 
> Supersedes: <20241022100956.196657-1-pbonzini@redhat.com>
> 
> CI: https://gitlab.com/bonzini/qemu/-/pipelines/1512732399

Compiled with v1.63 and ran "make check" on my x86 platform.

Everything looks good!

Tested-by: Zhao Liu <zhao1.liu@intel.com>


