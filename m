Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B08D7497D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 08:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t64A2-0005Yb-A0; Wed, 30 Oct 2024 04:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t649z-0005YN-TQ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:34:36 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t649y-0000fo-Af
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 04:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730277274; x=1761813274;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9Ihsg8oFbMq0ncKwHOldqQ46Iz88NMCfu08fK6j4mRA=;
 b=AXkOEX1F3OXJnlEJ8YHZ/kkECC8ey1rsPGxQZAnicMJx779bFIsW9rxX
 PCgabMVwUKHMg/+1dFkeXs6x67xSu5lwMSkaZVhv4E64xiFOWNjRxOVAZ
 U8qJX9ouIGmk/n4Lm9NoQyf4iy4UAYC95j3broTPHYO21CYFxkVozuYvl
 3p/3GMb7uhC/vx20A5Fk6eEgNyszdVcjx4qTlLB8CCi8nv3h2+PHY/kEf
 lhd4axLfUjBoU5ROpp24q5g4aJ5Uw4dIHU8WNRPyxNWRRclXOQD19Hhxx
 crGHuvRAbjxk+FNdocS9jNO+/V4O9GxpdshD+dt+a2rsvgaCCYV3t8s3+ Q==;
X-CSE-ConnectionGUID: +5p1fzqsThCE1sOihnAwwg==
X-CSE-MsgGUID: FBvMzAPXTOCawzByG3BOMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="29412445"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="29412445"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2024 01:34:15 -0700
X-CSE-ConnectionGUID: Q8m+07GmSKahLZ56z73atQ==
X-CSE-MsgGUID: tEw/oOMtS5iBEzEKhgHrCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; d="scan'208";a="83053670"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 30 Oct 2024 01:34:14 -0700
Date: Wed, 30 Oct 2024 16:50:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tao1.su@linux.intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 5/8] target/i386: add CPUID.24 features for AVX10
Message-ID: <ZyHzWZOmOVhSnJ5Y@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

On Tue, Oct 29, 2024 at 04:18:55PM +0100, Paolo Bonzini wrote:
> Date: Tue, 29 Oct 2024 16:18:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/8] target/i386: add CPUID.24 features for AVX10
> X-Mailer: git-send-email 2.47.0
> 
> From: Tao Su <tao1.su@linux.intel.com>
> 
> Introduce features for the supported vector bit lengths.
> 
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> Link: https://lore.kernel.org/r/20241028024512.156724-3-tao1.su@linux.intel.com
> Link: https://lore.kernel.org/r/20241028024512.156724-4-tao1.su@linux.intel.com

You missed your Signed-of.

> ---
>  target/i386/cpu.h |  8 ++++++++
>  target/i386/cpu.c | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


