Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A520C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKZ5D-0005jW-TL; Thu, 29 May 2025 04:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKZ5B-0005ge-F8; Thu, 29 May 2025 04:57:49 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKZ58-0007Md-UR; Thu, 29 May 2025 04:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748509067; x=1780045067;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9B8J58l7V57FlpKuN5IzOc9MBLik5oRzVmUMTCD2JpU=;
 b=UOh12rHQk/xz3eIWg9zkw2NzkF+tkvi8PCAhGlVjGj3G3JXhAAxw/AdK
 boWLMybJBLcKQrZV+FpoEByE92blaYUPVBIl+HIlfoyR7PstrU0p3EXh3
 W0yxfX9l/Wh/jFHmeXVdHZrrjqi8ZubaVInJRgKK+y7DyuRo+icXQ5pFh
 8TFAeimj+X6YIkotGERuM7sMlrF+CHDp4FN5qaKgHTVHrgJskAZ3J1S0i
 +1o/ngOle9A8DbOaUhy24UVuaRbXmWAnJjcDyF5YJ/BLIqUsBnMv53l2Q
 T9T9HotwKsasxyBPXlKKkcrCLs4ILCCI8YNcrM+1/ZLYMg7E3eU8G+aPw g==;
X-CSE-ConnectionGUID: XS/ekoJGQ5euhMYSytrCtA==
X-CSE-MsgGUID: YqK/13OYSIWa+cwDubFpFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50259039"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50259039"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:57:44 -0700
X-CSE-ConnectionGUID: qFDC97o2RjOnD3iwBi9T8g==
X-CSE-MsgGUID: 2pJTPAHoRBSKOhI9toH+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="143485944"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 29 May 2025 01:57:43 -0700
Date: Thu, 29 May 2025 17:18:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/12] rust: qdev: support returning errors from realize
Message-ID: <aDgmfYwKVk9zG2BY@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

On Mon, May 26, 2025 at 04:24:51PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:51 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/12] rust: qdev: support returning errors from realize
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  5 +++--
>  rust/hw/timer/hpet/src/hpet.rs   |  5 +++--
>  rust/qemu-api/src/qdev.rs        | 10 ++++++----
>  3 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


