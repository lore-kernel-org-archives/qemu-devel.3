Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA41CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8DrF-0005Ep-N9; Mon, 13 Oct 2025 04:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8DrD-0005Ef-63
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:24:39 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Dr2-0005mk-8x
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760343868; x=1791879868;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oxgvhgVoPtHZMpDYailTSQQZcdtz8VN1CZ8coz0zUOQ=;
 b=QJW1jD4KaASwMRcLe27MWRmBW0GVSaTZp1NWeF+fYhPvi78TUdVMmeQu
 NC18yfDpdGOuUytnUyUYwLN0KpVxFMDitvCtGArQB0rB745qZLdRIztEv
 ntAaEZ5KgnucpovP61SHjNGW2zCujB0TzOgrE+k0zG37NZbOWijKAOqGK
 OUEhR0PFI5VHbdqwVbLBYMG/KhOyKTMJjXYVVosUdZubn/drCovlkPkmH
 jpEW2ycPfJ+AlgPLtwgWlMM82tIGFhKgOe0BTIC8S7ykJx5ZqjnIZ/s2x
 pqFZNHG4eODLZAw6oWR+Po3c7KNFA0bwCf44b6n7Rh73EPy87h8ArrDHv w==;
X-CSE-ConnectionGUID: R96Wyya5QnaN2AXxoPMF+Q==
X-CSE-MsgGUID: uJ5yzg6wR0KBpS8vJiR5HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73161346"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="73161346"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 01:24:05 -0700
X-CSE-ConnectionGUID: EV5EGpO8Q96EYojDUwLzcg==
X-CSE-MsgGUID: DVqocWuoSAmhWDcMveoWwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="181217045"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 13 Oct 2025 01:24:04 -0700
Date: Mon, 13 Oct 2025 16:46:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/11] rust: migration: do not store raw pointers into
 VMStateSubsectionsWrapper
Message-ID: <aOy8UPCK/SErNMjt@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Oct 01, 2025 at 09:52:02AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:02 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/11] rust: migration: do not store raw pointers into
>  VMStateSubsectionsWrapper
> X-Mailer: git-send-email 2.51.0
> 
> Raw pointers were used to insert a NULL one at the end of the array.
> However, Option<&...> has the same layout and does not remove Sync
> from the type of the array.
> 
> As an extra benefit, this enables validation of the terminator of the
> subsection array, because is_null() in const context would not be stable
> until Rust 1.84.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


