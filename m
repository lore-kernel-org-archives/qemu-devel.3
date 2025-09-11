Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8063CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe9Y-0007xa-GH; Thu, 11 Sep 2025 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe9O-0007tA-MM
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:03:36 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwe9J-0006br-VV
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757585011; x=1789121011;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=NTztpCsq8ICjkamyapKG6GBkGVZ39ow9MP2+Bh9RNzw=;
 b=MEleaGwUfh/L+0oOwe3IY4CyEDKsyU7IJfpZrz9m09ZjeeTmicDQWVz1
 RR6AgMMh8HV0Gp0NCn5K6aMHcOK702DosNB15enYUWQYLEcRwvnEGQOkm
 yaOc9vhT8npCKhxywhd6mBc/qBmyqfOHtk+W2Mxdy/hw6wRSP4yKzX0ca
 EtE5/kE28vNs4kxKzQ9UR/4M3ps/747bCHYcr47iaGjaYRS8NVtICdYii
 tFa+8Nw2b9BF5K6pkMaVAcha7FDpY1UDNCVj4YsY0DyirU9qxWerytYOb
 4UE20wpPN5d4ECX66xuWE5D1BbaX3c+2EUax2c5ba5Kz7OIZKlhfw9aCZ w==;
X-CSE-ConnectionGUID: Nm6yuipwTAGzmdLTxYVtsQ==
X-CSE-MsgGUID: BPFlKU13T7u1dJWS5OuXpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="77364472"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="77364472"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:03:25 -0700
X-CSE-ConnectionGUID: 6aYbBevsQ0eIm2vVVQbdWg==
X-CSE-MsgGUID: J0AvASkMT9antOzWqzx3ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="204647399"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 11 Sep 2025 03:03:23 -0700
Date: Thu, 11 Sep 2025 18:25:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 13/33] rust: move vmstate_clock!() to qdev module
Message-ID: <aMKji+uSq+M7tFeg@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-14-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Sep 08, 2025 at 12:49:45PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:45 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 13/33] rust: move vmstate_clock!() to qdev module
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to split vmstate to a standalone crate next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-8-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/qdev.rs    |  3 +++
>  rust/qemu-api/src/vmstate.rs | 14 ++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


