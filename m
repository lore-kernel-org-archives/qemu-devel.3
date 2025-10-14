Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A38CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aRI-0005wV-4F; Tue, 14 Oct 2025 04:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8aR6-0005un-AA; Tue, 14 Oct 2025 04:31:12 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8aQz-0004nP-I5; Tue, 14 Oct 2025 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760430665; x=1791966665;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AhvnL2S2fN+ldgYctCAEvmuShzWzaBmyk2G9FC1MiTI=;
 b=XdNy3RHnPontRquMFRKwYAqdSvYpa2H3ymAd9YBfAWsiujy4dnUE1QRI
 4mrCaP7rZ27f7yFghWd/BJL+fMPT/lLLuTxZ92ay81A1NCnLtLa0JnhLm
 z6UhGt0jIQ8tvfr3uY1mOhWktRpj66imAQ/60uxxGqyMLbiBUqkEe29Qc
 MilCnMMPFCjuxV6Po0IVF8xzV+EbTA4MT0IFABE0wvIJkn7Rh191Ze8HD
 krHtx/onWimL8niOiiHTnrmPKGLsYAdpgpOkTeSKliGFr4hhTF3XyjgCo
 1xaMtSo/8brSRX3k/5KjKwd9/eV+vwkN9gCyZ4/rsei6x0C4a7k7IAx1Q A==;
X-CSE-ConnectionGUID: H8Db4JPKTXS39v5nPnFXHg==
X-CSE-MsgGUID: gMOWFOWPQhmnz+04WMHg1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73927412"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="73927412"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:30:59 -0700
X-CSE-ConnectionGUID: qez4GtwfQJ2GUa3uituZfQ==
X-CSE-MsgGUID: +TzDXtmBSn203ZqOcYGlcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181384287"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2025 01:30:58 -0700
Date: Tue, 14 Oct 2025 16:53:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] rust: hpet: fix fw_cfg handling
Message-ID: <aO4PbwYHYJeRermA@intel.com>
References: <20251013165251.1004096-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013165251.1004096-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Oct 13, 2025 at 06:52:51PM +0200, Paolo Bonzini wrote:
> Date: Mon, 13 Oct 2025 18:52:51 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] rust: hpet: fix fw_cfg handling
> X-Mailer: git-send-email 2.51.0
> 
> HPET ids for fw_cfg are not assigned correctly, because there
> is a read but no write.  This is caught by nightly Rust as
> an unused-assignments warning, so fix it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/fw_cfg.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Oops, thanks for this fix.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


