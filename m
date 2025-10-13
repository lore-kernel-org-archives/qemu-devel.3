Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ACDCCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 07:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8D0J-0002Wt-Md; Mon, 13 Oct 2025 03:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8D0I-0002We-Gi; Mon, 13 Oct 2025 03:29:58 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8D07-0006Mm-E6; Mon, 13 Oct 2025 03:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760340588; x=1791876588;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=duKsoeMc9BrJ7V+LRwtnFy8daBHA/fhFKBIXtC62Ycs=;
 b=PjcSUiohzlO1ESPWIUgXXlwNGVua4o1jZm+l7E6McNYI/u6q2k0+sKHx
 0pyL2YsGxUbPWyKzsf1bGR6MQUYIH9kGVEc9yOXYj6uqB2FY1b7dyvren
 JBCDYHPunkaLLNq0giicXqTgAMQbgnMBwzXioh7XWBc9ss8x+ULIUARD2
 bH0+en2WUBJByjjzoPAL8rYJO/DU6qiaizApS/cdjnkDeR21nMN0tbyjd
 SI0q7xSMJicBjnQD5vHCv9is1Lwq/7VMGd2PQdpXDrULxtWf96+eqRZru
 EvT+FZ5+Vi7X6z1Ou5ncd3khMkYkQLMj5KTCuYNGhqwrpJb7g1DK3KAfa g==;
X-CSE-ConnectionGUID: Tvt95e6gQv+Ttc3th/odFg==
X-CSE-MsgGUID: vIHS3VI2Qxiv4o5R8ISflw==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="66128627"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="66128627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 00:29:42 -0700
X-CSE-ConnectionGUID: uNXuHw0yTbuzpukauWfU1g==
X-CSE-MsgGUID: 6a80yIQwQcuWO8i3TcARLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="186817572"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 13 Oct 2025 00:29:40 -0700
Date: Mon, 13 Oct 2025 15:51:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com,
 marcandre.lureau@redhat.com
Subject: Re: [PATCH 01/14] qobject: make refcount atomic
Message-ID: <aOyvkPbEb3nnDC2A@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001080051.1043944-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001080051.1043944-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 10:00:38AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 10:00:38 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 01/14] qobject: make refcount atomic
> X-Mailer: git-send-email 2.51.0
> 
> The Rust bindings for QObject will only share a complete
> object and treat it as immutable from that point on.  With
> that constraint, it is trivial to make QObjects thread-safe
> just by making reference count operations atomic.  Do the
> same when the C code adds or removes references.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qobject/qobject.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


