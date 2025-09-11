Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808EFCAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uweFW-0003KH-PE; Thu, 11 Sep 2025 06:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uweFU-0003JW-EH
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:09:52 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uweFS-0007Fu-Ei
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757585390; x=1789121390;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SAgni/KfSWPOF3qch/YVPVcy2Ajgyr/k32z5Co3/S24=;
 b=PXnSBqFGE5tZIoWY4t9ioUlo1Web6Pwiv1DE3t6E+/ZlxiuJOlo6+vLu
 KgxNozM941kz7AZ3LUeK1QydI36AIlJ2j8QHyt+Awdc/7xQonmlbYw6YZ
 JUGn+HohA+QLBnQThXOqRr4Y13dor+c64kchZRVgDsQKIngNBgSg5iVK+
 oR44l0Gy5qoOxsIYYOnGyD5leIhJE4gBpu03KHs8EpulVv4gV6zWpLPAt
 0ogHH4qiLxtb6OyIkV5k8dwy5SzRv6wJpWDQIBQduHh3MYjyeazkIXFZV
 FcBWc1EMRtyuFYhiKay2sCa5+jxXvrM/IZW/fG9JNrXks0XiWYjEUln5k g==;
X-CSE-ConnectionGUID: adqX19+dQtK5FtUmi3ZvuQ==
X-CSE-MsgGUID: k0Ct/LYnQgW+bC60hUBnzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="71336226"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="71336226"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 03:09:48 -0700
X-CSE-ConnectionGUID: kufx1bdhQMuc2q1fAx2WXg==
X-CSE-MsgGUID: 6rnxFVmtReqbwNgknJkyeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; d="scan'208";a="173207566"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 11 Sep 2025 03:09:48 -0700
Date: Thu, 11 Sep 2025 18:31:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 15/33] rust: move Cell vmstate impl
Message-ID: <aMKlC9yG/JaNXUkt@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <20250908105005.2119297-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250908105005.2119297-16-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

On Mon, Sep 08, 2025 at 12:49:47PM +0200, Paolo Bonzini wrote:
> Date: Mon,  8 Sep 2025 12:49:47 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 15/33] rust: move Cell vmstate impl
> X-Mailer: git-send-email 2.51.0
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to split vmstate to a standalone crate next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Link: https://lore.kernel.org/r/20250827104147.717203-10-marcandre.lureau@redhat.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/cell.rs    |  6 +++++-
>  rust/qemu-api/src/vmstate.rs | 14 +++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


