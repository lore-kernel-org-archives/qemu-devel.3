Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45BECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9L-0003Zj-RB; Sat, 30 Aug 2025 11:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uru2c-0008Qz-SU; Fri, 29 Aug 2025 04:01:04 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uru2a-0000Ab-4q; Fri, 29 Aug 2025 04:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756454457; x=1787990457;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wHq5pNeo8OzARHa76q54XoHKWaxLkg+xaQ0N8DZj1Xc=;
 b=K3znGgQTZ/IMz/72RqyK55zrDWBSGOHka5RwXBTrnXsPaRR97ZKIjoHc
 QJ6NWvuTTv2cn8xWuR6B4GUFVYeq2zxkYuQoQs1VJZeO/BUzUL8ZwIGpk
 nIZuDoSKIDtANlv2NMvdzKOJn8Pz8wncGtXEJF0JuV8+p0bda0e67/O0w
 vdOGCSgQPWe1JsG2sKYb6bBjNUP7vfD7XQj3mdckVx4ll9UvbG7WS7jJe
 kglspzB1XSevm1BJsaZmla+Xo6H7c97ZILYaVHW+nkas5WYVLW/PwC8+l
 dqw0s4XwapXrEMTMqhXxdIqHJBYzMJEPFJb5pJsljbrgk7gBsJqzYtWLR g==;
X-CSE-ConnectionGUID: bLR94VzCQGOal9lpbC6MVQ==
X-CSE-MsgGUID: 8dbjL009SZSAmrWvLbWLOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70105374"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="70105374"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 01:00:49 -0700
X-CSE-ConnectionGUID: lCXL1VGCSJCUAwf9N5AcsQ==
X-CSE-MsgGUID: dvhpzZAYQoaHbJeQ0ojqiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="174701969"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 29 Aug 2025 01:00:48 -0700
Date: Fri, 29 Aug 2025 16:22:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 09/22] rust: move Cell vmstate impl
Message-ID: <aLFjSgdHHa2PE+Sp@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-10-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-10-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:31PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:31 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 09/22] rust: move Cell vmstate impl
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This will allow to split vmstate to a standalone crate next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  rust/qemu-api/src/cell.rs    |  5 ++++-
>  rust/qemu-api/src/vmstate.rs | 16 +++++++---------
>  2 files changed, 11 insertions(+), 10 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


