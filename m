Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03BD74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 03:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5zT0-0003mN-CZ; Tue, 29 Oct 2024 23:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5zSx-0003lv-UU
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:33:52 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5zSv-000373-BS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730259229; x=1761795229;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vj083Zi6n+Z84b6DtfTG/RDIrqN14QpAbExOTQeiB6I=;
 b=MekMkCejF4vpb0J/6do6zw5e32pw57iPzd6/kn/0S1bhtc0D281D1Trz
 KVvLJ6BcJqdZgOtoUheuA3yIm4pF+JfARVPkVXU3+9RXBEisq/4REWkPY
 nbC0omFRSIfVNl7zz0YEb4Stx3IXeqZcxujdEd1NV9YIPOoUf+w8hzYzS
 gLORvbVV76D7+afZY8UWGTuADMOqwT5vHIcuLJ75QSaJKrBrDkw8VkYSo
 42MrWwqsrXmvXfxTWva73uRaHsex9MFizFhaO//yk2MpXQIz8epR64pjI
 PhH0G1mq23Z8RbzEJLlHM1gZV1cmkmGAIMCnhYRVGKNYkPsZiBziI3v0A g==;
X-CSE-ConnectionGUID: ANuHBzcXQKmi99MuEhJbjw==
X-CSE-MsgGUID: Rq/v44NcSAu1jrNvniJeFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33867741"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="33867741"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 20:33:43 -0700
X-CSE-ConnectionGUID: wVvrJ8SHR5yetpfrVSoZCQ==
X-CSE-MsgGUID: ViL0M3BTSWOfN9OeuLdp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; d="scan'208";a="87312093"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 29 Oct 2024 20:33:42 -0700
Date: Wed, 30 Oct 2024 11:50:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tao1.su@linux.intel.com, xiaoyao.li@intel.com
Subject: Re: [PATCH 2/8] target/i386: do not rely on ExtSaveArea for
 accelerator-supported XCR0 bits
Message-ID: <ZyGs6YTRpKtwWG/x@intel.com>
References: <20241029151858.550269-1-pbonzini@redhat.com>
 <20241029151858.550269-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151858.550269-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Oct 29, 2024 at 04:18:52PM +0100, Paolo Bonzini wrote:
> Date: Tue, 29 Oct 2024 16:18:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/8] target/i386: do not rely on ExtSaveArea for
>  accelerator-supported XCR0 bits
> X-Mailer: git-send-email 2.47.0
> 
> Right now, QEMU is using the "feature" and "bits" fields of ExtSaveArea
> to query the accelerator for the support status of extended save areas.
> This is a problem for AVX10, which attaches two feature bits (AVX512F
> and AVX10) to the same extended save states.
> 
> To keep the AVX10 hacks to the minimum, limit usage of esa->features
> and esa->bits.  Instead, just query the accelerator for the 0xD leaf.
> Do it in common code and clear esa->size if an extended save state is
> unsupported.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c         | 33 +++++++++++++++++++++++++++++++--
>  target/i386/kvm/kvm-cpu.c |  4 ----
>  2 files changed, 31 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


