Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D163C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKYTd-00049G-3U; Thu, 29 May 2025 04:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKYTU-00048x-Vf; Thu, 29 May 2025 04:18:53 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKYTT-0003LG-0a; Thu, 29 May 2025 04:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748506731; x=1780042731;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=C/nexojcTe7uHbvjxWgehErvKjWU1QW8iPN7loyIIcw=;
 b=nUHMxDzfGgmGSyWb2lNn0F0RtHZcUJZv5HMqEQiME+nqaEsH0Q6Mjouj
 C+YCrih5kxylsFynW5IAHLNOyvfkHbC3JI3yAm24h6yRIkUU0d3rQH0kK
 uoqgWBMBnOv03XnOGo+V1jlQuXmtBxj+XuoDIroES5BCW6D0uvUcbjdDE
 YpGDvEqcvcWbuCVw1I3JmFkwsmwRxXILoUkacJOk7YzfO5PABWXBu0nM8
 PljkKu7hl/R3Xu1LP50YacL+WPwaJpR33NQ3akXiLarACQiRKw1PL3GVl
 MTe/7pgH6QKf5xiwadFBt8ymFhvscWHFifbxmIALuwpKTsN1fv6TzGgyD g==;
X-CSE-ConnectionGUID: CMomnTPnQuSP/unh347uoQ==
X-CSE-MsgGUID: iryhsolhTU+7t/fbgbFfEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="61218309"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="61218309"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:18:47 -0700
X-CSE-ConnectionGUID: 922KB3qYSrGaxbTxUhkf8Q==
X-CSE-MsgGUID: MBOMIGy7RM2vT9nzYfv/Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="166654277"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 29 May 2025 01:18:46 -0700
Date: Thu, 29 May 2025 16:39:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/12] hpet: return errors from realize if properties are
 incorrect
Message-ID: <aDgdXLrpOqGN3ZPo@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Mon, May 26, 2025 at 04:24:53PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:53 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/12] hpet: return errors from realize if properties are
>  incorrect
> X-Mailer: git-send-email 2.49.0
> 
> Do not silently adjust num_timers, and fail if intcap is 0.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/hpet.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


