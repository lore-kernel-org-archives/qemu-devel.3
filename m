Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5337EC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXzt-0001WK-BQ; Wed, 22 Jan 2025 05:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taXzm-0001Ri-6P; Wed, 22 Jan 2025 05:30:05 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taXzj-0004oO-UD; Wed, 22 Jan 2025 05:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737541800; x=1769077800;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1RrwgssKEK25K5PKpW3gE7SUjcQRKfYVJLxYPvUtzXs=;
 b=lr2YXheGk35ggB8PqkuBxd2DfP87ZbjYK5V9uB6+6EJ8AN5WJe6JGZYj
 63vUV3MYc4ow6IWJkhgl5QQnJSsYtotTDMp8G/8gLk5PiamcX/LYQ2cH/
 PtPvw8MD7b7K52LvKwZWw9L/41KX2oN5KjQ3BkSVtKNoA/AZcxymvNyoV
 N5Ib34xYDEaFN2iCwIQUCXum7Z1m8Hv9c1bgEKPJcHGLh++XUHSSkMFXW
 PzUnfrioHuCq2TUqVjjg5Jhe1ejI21IOp35yhnE7hP8DBS53WmzrBx0Zk
 wOfZrxoJv2jTOVcxQNK0jNv4gzaHCBxQw3UiJIl6pvbbWY58HPb72shay g==;
X-CSE-ConnectionGUID: iPJpMT1rSHCI5ZCusGHX3Q==
X-CSE-MsgGUID: ewDfMeX9R4u+WPGMVoV63w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38094458"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38094458"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 02:29:56 -0800
X-CSE-ConnectionGUID: kU6RKQHITXmGjFJ5tuFb2w==
X-CSE-MsgGUID: 8kHla6krQGmHLigG0NV5TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; d="scan'208";a="112128098"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 22 Jan 2025 02:29:55 -0800
Date: Wed, 22 Jan 2025 18:49:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: vmstate: implement VMState for non-leaf types
Message-ID: <Z5DNLaEkklbInqh9@intel.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
 <20250117090046.1045010-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117090046.1045010-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:00:38AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:00:38 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/10] rust: vmstate: implement VMState for non-leaf types
> X-Mailer: git-send-email 2.47.1
> 
> Arrays, pointers and cells use a VMStateField that is based on that
> for the inner type.  The implementation therefore delegates to the
> VMState implementation of the inner type.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/vmstate.rs | 79 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 1 deletion(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


