Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499ADE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCaF-0004gZ-Dv; Mon, 16 Dec 2024 10:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNCaC-0004fh-UH; Mon, 16 Dec 2024 10:00:29 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNCa9-0005pc-QT; Mon, 16 Dec 2024 10:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734361226; x=1765897226;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=086Y1CHpPXRWVrEoLoDYO6EwZohIB3GkPb4oaK0O9x8=;
 b=MaWksN7B5A5SaOG/7kTxzlpxucfVsJrXUKltvYKt0QlXv1wqvAQPyxGh
 hvJehmmokZHc3K7xnYF/tKDjqJX/Mw1TIkVGOG1bvjTF+LBS+j91Fg3vB
 Gki/viw2glkOpALVSzrinzRxSBNyOKK6mDFxIKXO6p6MHpUilRB9pmnwD
 Y/cVUo0gr86sP6JDdsDUrv2BuM/nzS97+I9hJxKiFFwBgfKTyGLhVzX00
 2ApFryirpvKu32lXJXIegssRl9HUEQxj5UIRQeMKO28UYI6gEpMVt84E5
 TYRkJCZ6k05MQQjcnfmZwT+q04YvH85NWYxQk/9Pr1layxjbqcdGxFgKN A==;
X-CSE-ConnectionGUID: GUoT7rpjS7+VkWAXE0ef6w==
X-CSE-MsgGUID: exqUfo6LQf63a97/dm1x1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52162491"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; d="scan'208";a="52162491"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2024 07:00:22 -0800
X-CSE-ConnectionGUID: MbtVzZJXRQ2JJyD2XtG+lw==
X-CSE-MsgGUID: 2tkSCOyZTuGEsVxGZlubNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="97669579"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Dec 2024 07:00:20 -0800
Date: Mon, 16 Dec 2024 23:18:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 23/26] rust: qom: add initial subset of methods on Object
Message-ID: <Z2BE4zgiyv0oFmPV@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-24-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-24-pbonzini@redhat.com>
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

On Mon, Dec 09, 2024 at 01:37:14PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:37:14 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 23/26] rust: qom: add initial subset of methods on Object
> X-Mailer: git-send-email 2.47.1
> 
> Add an example of implementing instance methods and converting the
> result back to a Rust type.  In this case the returned types are a
> string (actually a Cow<str>; but that's transparent as long as it derefs
> to &str) and a QOM class.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/prelude.rs |  1 +
>  rust/qemu-api/src/qom.rs     | 56 ++++++++++++++++++++++++++++++++++--
>  rust/qemu-api/tests/tests.rs | 12 ++++++++
>  3 files changed, 66 insertions(+), 3 deletions(-)
> 

Good example!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


