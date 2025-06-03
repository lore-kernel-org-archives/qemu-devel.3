Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0584C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 02:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHj6-0008FJ-7t; Mon, 02 Jun 2025 22:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMHj4-0008DS-L1; Mon, 02 Jun 2025 22:50:06 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uMHj2-0005d2-Vs; Mon, 02 Jun 2025 22:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748919005; x=1780455005;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6DKs1/I5PchoJEw0GlazbWfVZvAfP0+M4weEfhdWSqY=;
 b=SQk5bQt3eQbe7W6MmyVBs8U7TXOCmz40s/orcE1jxSgIuhAwf13MbcqL
 ATh0shfn8n0b8J3Aem2LN9kEvDXQfLrJN3FVqUCibIYfKz5x3QTwLia9z
 7I2gJRRRVJdmqWeRcGFIJx3I/erOHz9P0Nn5lh9OsPGTccOTgFKaAiTUY
 xLjwjwadMEuMA71nd2JdzLbRntciptwNQI+zucJUkgC0p1eiWPZZQeW6Z
 UxMmoQcUC4WGwRFIHKg8KnxDE4gH61T36Bj6TFi3yAlsJY2GN5wlZmIk6
 bllT5JKp4m5oXn1l1x/ynospkZnPOUDqPhiEr90OtVWMCerE+FpDQxecQ Q==;
X-CSE-ConnectionGUID: SiDy1CGdQB2zg1GmvSITcg==
X-CSE-MsgGUID: f7HSiC6dRIiQNDRk+Yg5Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51045942"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="51045942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 19:50:02 -0700
X-CSE-ConnectionGUID: Cqw/YlSfSM+KiD0lJVQizg==
X-CSE-MsgGUID: S1im2i0PQJSbLWTcGsFvIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="145690911"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 02 Jun 2025 19:50:01 -0700
Date: Tue, 3 Jun 2025 11:11:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/14] hpet: adjust VMState for consistency with Rust
 version
Message-ID: <aD5n0Q5wAgox+CQL@intel.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530080307.2055502-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On Fri, May 30, 2025 at 10:03:02AM +0200, Paolo Bonzini wrote:
> Date: Fri, 30 May 2025 10:03:02 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/14] hpet: adjust VMState for consistency with Rust
>  version
> X-Mailer: git-send-email 2.49.0
> 
> No functional change intended.
> 
> Suggested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/hpet.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


