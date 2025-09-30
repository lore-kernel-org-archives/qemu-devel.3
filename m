Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D9ECAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 06:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Tu5-0003ig-B7; Tue, 30 Sep 2025 02:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3Tu3-0003iU-QR; Tue, 30 Sep 2025 02:31:59 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v3Ttx-00069K-R4; Tue, 30 Sep 2025 02:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759213914; x=1790749914;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O5owFz/MQ387OAW+TowHaeopSVUSE+lMtMn6tPzEfTQ=;
 b=b5JDsBZwjYxm7Q8ZiLkeMmUA0wfZ4jSF0lEV/461MsBAoAiJsx/qYbn9
 Pt8OBHUGMKMb6UtitLiKUL9thr/gdUuNFv+po446tXgNFGL1WANDgAH95
 dF50u06+LqSpJXufINw006xLj48HLIGSDpjgHUC9SlpqCizE9tu//VjnJ
 a6COCW9qA67YbhpX8uCKYl+QMmM+7ortRE3qkYcUdOXRE5AQoOmqj6gEn
 fXq1IDDskdqNTLFaWhQCY7C0P18784G6kkAKFHVli9Z2AYcrcduhiY0fE
 zQ88XuMidHPXq1gGKYxhWFZiSAD8zBNZ2AaaEIepgqj+G2Zwcbd4TWGky Q==;
X-CSE-ConnectionGUID: 0ZvJGfPlQ2ijX3pwTuA54A==
X-CSE-MsgGUID: 9rAlXlNYRG6qNDkB7ciqcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="72080620"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="72080620"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 23:31:42 -0700
X-CSE-ConnectionGUID: gXLjhCjCTwigije1QhppOA==
X-CSE-MsgGUID: JzaaNO8FRCiTOxRQq2SPIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; d="scan'208";a="178032530"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 29 Sep 2025 23:31:41 -0700
Date: Tue, 30 Sep 2025 14:53:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 7/7] rust: migration: implement ToMigrationState as part
 of impl_vmstate_bitsized
Message-ID: <aNt+dY5bFEOfZPIs@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

On Sat, Sep 20, 2025 at 04:29:58PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:58 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 7/7] rust: migration: implement ToMigrationState as part of
>  impl_vmstate_bitsized
> X-Mailer: git-send-email 2.51.0
> 
> This is most likely desirable, and is the easiest way to migrate
> a bit-sized value without peeking at the innards of the bilge crate.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


