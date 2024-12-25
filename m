Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200CDE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQTtA-0000sS-Oe; Wed, 25 Dec 2024 11:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQTt0-0000o1-Hr
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 11:05:31 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tQTsy-0003FP-M4
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 11:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735142725; x=1766678725;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MqyU+27pwlXSBvnuutTwj6YWg2/VCNLkQ/9XrOtfWvM=;
 b=dnvANYAQfnhyg2SO5086Nua7XGSrxuhQ6ZonIExRQjLYZEbAro7Wj+Y+
 P84VeW9zv1z2yDh7LIBJ3pcBawuHtJe6y4QXfrOdSIzcQKQI2RksS32W+
 VjhXHJIZb4+hZfmmtksG8W3pG2F8DLtHedZhYR0Bc/o4MLskdW5YNZHbw
 0kYXnu8mC8QSWKhRihAtKMWuapQPDujb1pVphFfP6EUXlIuLEDLid3Dbc
 0EtEJZn+LZORKy/jVCKUA0uYu2djsn42FoqgMwgdUnbL3heXXFVmEzht+
 +VHsSaBtz7J5C1DNP0E4FP3l8MztMhn2HUTkyDLPGcWpvvrZjWsDRqgbc Q==;
X-CSE-ConnectionGUID: qjQQlTAeTBqkeXppS2xmFA==
X-CSE-MsgGUID: bjIfhr+CSn6m8b8Wrq3IWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="46959980"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; d="scan'208";a="46959980"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2024 08:05:19 -0800
X-CSE-ConnectionGUID: DAlXFKNITGytsFC4Nkhi8g==
X-CSE-MsgGUID: xFViuVhGRVCcd2HsdhmCOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="104374566"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 25 Dec 2024 08:05:18 -0800
Date: Thu, 26 Dec 2024 00:24:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com
Subject: Re: [PATCH 02/12] rust: add a utility module for compile-time type
 checks
Message-ID: <Z2wxoWmmalIPqysd@intel.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
 <20241220142955.652636-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220142955.652636-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On Fri, Dec 20, 2024 at 03:29:44PM +0100, Paolo Bonzini wrote:
> Date: Fri, 20 Dec 2024 15:29:44 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/12] rust: add a utility module for compile-time type
>  checks
> X-Mailer: git-send-email 2.47.1
> 
> It is relatively common in the low-level qemu_api code to assert that
> a field of a struct has a specific type; for example, it can be used
> to ensure that the fields match what the qemu_api and C code expects
> for safety.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/meson.build       |  1 +
>  rust/qemu-api/src/assertions.rs | 90 +++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs        |  1 +
>  3 files changed, 92 insertions(+)
>  create mode 100644 rust/qemu-api/src/assertions.rs
> 

Very useful! Previously I found qdev property macro lacks such type
check, but I falied to think of a good way to implement type_check in
Rust, and glad to see the correct approach! Besides qdev property, I
think vmstate also needs this.

And I think we can make the examples as the unit tests.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


