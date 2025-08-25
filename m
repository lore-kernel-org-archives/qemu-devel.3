Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90568CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSjR-0007FD-Sh; Mon, 25 Aug 2025 04:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqSjQ-0007Dx-37
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:39:12 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uqSjK-0002SN-2d
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756111146; x=1787647146;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GDxET9Yp7oaB/P42wGmos9DXGJ+MmUvr/BvNv4odSx0=;
 b=eefvZl9t80xhNrV9OTtNVKJ2tk3xUKebx2abXfXmwI+3z1jyXEgeVm6C
 cZU+K2qoDBXdcAE95ZqdKP+OwCTQa8DUinXdajFcWCRdmM1iJIpRHI4HY
 Lq82fwSOPSKKbv/orStSYnxEhIkPm/sWrdFUVIowM1EPvaJXKnIagtLRF
 y2qFVMPbyRIllypG3/ZEEXH7J4fSfyV71fjViw5qGEoB4aX3ew0Umjxj1
 wrF1BBdCYMSchV34qUybgcT1dhJYnjUCfOMw6ee970ykVlhjs13Rq1Shy
 iIJeKVYHuCnmHP2KqYLy7PVseoOp6SUWknUbFyNv8ZGERcqipVR3N1el8 Q==;
X-CSE-ConnectionGUID: pg9Tk5ytTZG7iw6naMBjKw==
X-CSE-MsgGUID: FZBmk+obRgW6MFPcstJmtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="69029101"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="69029101"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 01:38:58 -0700
X-CSE-ConnectionGUID: gHWMqCMZQ1ayhRMHCeyPTA==
X-CSE-MsgGUID: +8wGIC0MQ025lD7wYc6tSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="169427614"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 25 Aug 2025 01:38:56 -0700
Date: Mon, 25 Aug 2025 17:00:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, tanishdesai37@gmail.com, stefanha@redhat.com,
 berrange@redhat.com, mads@ynddal.dk
Subject: Re: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
 to ftrace.c
Message-ID: <aKwmOgPPcu3fUOuH@intel.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822122655.1353197-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
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

On Fri, Aug 22, 2025 at 02:26:44PM +0200, Paolo Bonzini wrote:
> Date: Fri, 22 Aug 2025 14:26:44 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
>  to ftrace.c
> X-Mailer: git-send-email 2.50.1
> 
> This simplifies the Python code and reduces the size of the tracepoints.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tracetool/ftrace.h            | 28 ++++++----------------------
>  trace/ftrace.h                      |  1 +
>  trace/ftrace.c                      | 15 +++++++++++++++
>  scripts/tracetool/backend/ftrace.py | 12 ++----------
>  4 files changed, 24 insertions(+), 32 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


