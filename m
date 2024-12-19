Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25622E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOAAv-0002Fr-Ie; Thu, 19 Dec 2024 01:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOAAn-0002E3-Gj; Thu, 19 Dec 2024 01:38:14 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOAAl-0000gM-3v; Thu, 19 Dec 2024 01:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734590291; x=1766126291;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=SNJhP9iC0ljNESE7Y2IW1MN/Rwd9MUShgG+juLTvYWU=;
 b=EGY+VfDCc5TyoulnMEF0Xxr7CzOfjJhJL/2X59a4NKTc/oGeEFkYEdfq
 naOZtLAiCzDOA34tnSi9yKbY/B1Dyey+1wPeURqfUOp0AsOXlcaLRoVHI
 cFaL4/13zJ4F5IBCRE3h4OnRREgleTFZnZUj7qzTHHDXuBmZvWWKs8dfS
 aS401G31OgpO+gvAnPgmg0XuRlv/WN9gXojPS+++Fr+TYH4PkEaOm0gn1
 QNv4vfou3xOqtLjg6+T8rONtCbENCYG2Prl6wVWhc+ZYRKzEEkqsAe94t
 UHS6VHaF+3hA2oNKPsV8f1ev171VlwoCBZHN65qZ3qUkO++K6kQXRxQXj g==;
X-CSE-ConnectionGUID: 6GaU+ExSR4yUdIQwnNsWvA==
X-CSE-MsgGUID: BXtGPdPGQEW27RZB/Uhbxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="60472636"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="60472636"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 22:38:07 -0800
X-CSE-ConnectionGUID: sjH+kDzxQ0Gl8j3tgPne+Q==
X-CSE-MsgGUID: SS376XguQW+NJvHa/z8i/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="98157449"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 18 Dec 2024 22:36:40 -0800
Date: Thu, 19 Dec 2024 14:55:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 3/7] rust: pl011: always use reset() method on registers
Message-ID: <Z2PDWJo6G0DQ5uzl@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 12, 2024 at 06:22:00PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:22:00 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/7] rust: pl011: always use reset() method on registers
> X-Mailer: git-send-email 2.47.1
> 
> For CR, the ugly-ish "0.into()" idiom is already hidden within the
> Default trait.  Do not repeat it.
> 
> For FR, standardize on reset() being equivalent to "*self = Self::default()"
> and let reset_fifo toggle only the bits that are related to FIFOs.  This
> commit also reproduces C commit 02b1f7f6192 ("hw/char/pl011: Split RX/TX
> path of pl011_reset_fifo()", 2024-09-13).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 23 ++++++++++++++++-------
>  rust/hw/char/pl011/src/lib.rs    | 13 +++++--------
>  2 files changed, 21 insertions(+), 15 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


