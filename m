Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA25C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl0HX-0003OV-71; Thu, 20 Feb 2025 01:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl0HU-0003Ns-47; Thu, 20 Feb 2025 01:43:32 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tl0HR-0007WB-SZ; Thu, 20 Feb 2025 01:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740033810; x=1771569810;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NChFlqfCyzGxdKj/Z9oiy1ByxT6ay36/gSVcf8MGFhU=;
 b=lc0lwpAviYYfJw6AX1zBGiyIjnHO8gZOTHPGBluXdRxRFINJqaHs/2Yd
 PtBpuLtbFZERKIS8jlNbFkPQdKL7CNDGNI/j5iWvg2E6MNRB4C9FZE5z/
 nEFpyDjonxKk7g3nGHcQqLP5gIy7Ipkb506DLymmHINli95G6b1w5LQQj
 VZAwwq+qX6ujvVy944+sVy9h3P5v2Rcug2Z6SKzTZsSt81vN21MoQHIJv
 W+sWfPnGczAL6hmN9+iP10b8OdY9AZfUltjRkBM8ru4zEog8ww+3e/EUe
 ofkVIglWS5kbBV3wu5ZxhXf3FXAxxvfVwRqAlaWJXdoCGqZvFUw/Gq/Fg g==;
X-CSE-ConnectionGUID: Zz6Mb8czQjyrSGst26wECg==
X-CSE-MsgGUID: y5bGdzobTauQK3rLMG7r0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44576553"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="44576553"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 22:43:26 -0800
X-CSE-ConnectionGUID: ag86H22yRJq35pBqSz7i8g==
X-CSE-MsgGUID: WuGmwYLETVWPIwk2LZTwxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="114800698"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 19 Feb 2025 22:43:24 -0800
Date: Thu, 20 Feb 2025 15:02:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 10/11] bochs-rs: Add bochs block driver
 reimplementation in Rust
Message-ID: <Z7bToy7ECaSVIV4V@intel.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-11-kwolf@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> +use crate::driver::{block_driver, BdrvChild, BlockDriver, Mapping, MappingTarget, Request};
> +use crate::SizedIoBuffer;
> +use qemu_api::bindings;

it's better to list all items from bindings here, which helps in understanding
which parts will need a wrapper added later.

> +use qemu_api::errno::Errno;
> +use qemu_api::futures::qemu_run_future;
> +use std::cmp::min;
> +use std::io::{self, Error, ErrorKind};
> +use std::mem::MaybeUninit;
> +use std::ptr;
> +use std::sync::Arc;

nit: we can fix style by "cargo +nightly fmt" with latest toolchain.

> +impl BlockDriver for BochsImage {

...

> +    async fn map(&self, req: &Request) -> io::Result<Mapping> {

v1.63 doesn't support async fn in trait, do we have to involve
async_trait crate?

Regards,
Zhao


