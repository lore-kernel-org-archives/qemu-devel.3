Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07268C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5LqE-0004cZ-Io; Fri, 10 May 2024 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5LqC-0004cK-5E
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:42:56 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5Lq9-0008E7-Ae
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715330573; x=1746866573;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sa7AR0RstN6oWsrnQV5UAsgJ3i8k9WX5KJQ7NBC8fvk=;
 b=JPZF05LN+XImBOFkS2oj5Lvvbry4LECWpxNZK6m1J0GFYRjhJUbAjPQ2
 onhY5QtDwdh2GWZ9ZkeeYtfW/bJU7rXRxXxqKAG2RMjlueX4Q2MHziiD9
 sMePQDtb2bUYLsXsDWcHU64xdaaycPL235f5gtlAY0lkcDBAIhU1OUNk/
 1Yrxs184Dq/IvtBTJlNjv74wmq3ae91LE+Vw1MeL+ISwWWg1gwb9LHRaw
 ft2owXqVazW8+QYqzWnqxxI5RSKZxtIc/QluE+mio4YEX7hmoCwYaw6o4
 J4rnz7ObshiOsmalZjs3gnXXaejTS5uzB3VLEgwNgLNyigDnncl+5phgl w==;
X-CSE-ConnectionGUID: NP0HE/eWS9uXaQWDxngqPA==
X-CSE-MsgGUID: 2WYitLJeR/2k86A/T5SQQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28785175"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="28785175"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 01:42:50 -0700
X-CSE-ConnectionGUID: mNNTswHeRneZNk1Cg/eBpg==
X-CSE-MsgGUID: mFgovlJoQ0uf2861sMOPfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; d="scan'208";a="29563009"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 10 May 2024 01:42:48 -0700
Date: Fri, 10 May 2024 16:57:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386: move prefetch and multi-byte UD/NOP to new
 decoder
Message-ID: <Zj3hXeGn4XFS4iwC@intel.com>
References: <20240509153755.143456-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509153755.143456-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Thu, May 09, 2024 at 05:37:55PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 17:37:55 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: move prefetch and multi-byte UD/NOP to new
>  decoder
> X-Mailer: git-send-email 2.45.0
> 
> These are trivial to add, and moving them to the new decoder fixes some
> corner cases: raising #UD instead of an instruction fetch page fault for
> the undefined opcodes, and incorrectly rejecting 0F 18 prefetches with
> register operands (which are treated as reserved NOPs).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/tcg/decode-new.h     |  1 +
>  target/i386/tcg/translate.c      | 30 ------------------------------
>  target/i386/tcg/decode-new.c.inc | 24 +++++++++++++++++++++---
>  target/i386/tcg/emit.c.inc       |  5 +++++
>  4 files changed, 27 insertions(+), 33 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


