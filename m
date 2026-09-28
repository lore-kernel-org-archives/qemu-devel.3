Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E1CC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6BR-0006gi-KC; Mon, 28 Sep 2026 03:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB6BL-0006gO-OE
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:53:53 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1xB6BJ-00061m-5r
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790582029; x=1822118029;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xA7nwaJDHq9H4sSKEgPCA+PJZbKyEZ5Tp44zVQvVMdE=;
 b=PzS73wsMIuatzj/83+ew2kbM3YxsvdmGnZP6/l6lI9hgvtTD/Gw5/lqA
 gbiTTh4Hcvg0n7mXkQDHx3STtRxeixGDGXcAUXH5kcdoxhBztxtPFf2+Q
 XyYEw7DRJT3gI2qv5Dx9upGJvrIyscAAR3N8xa64QApdtxj7hgqI+Ae/e
 A3dQKeaA+RouqdVs6utPAuXwJmIHrXl57/WDxuX3j0Vm9de8ixKS2obKv
 Viy82jw0fZGle2VuV6c8TbqcOtNqlkxlJqtCxIFuZSd7gzSno4hA06J4l
 do6TXbY9Qw+J2ceXQ0taQXHgVPkoMaM0MpU+490Bz1GmwiyBsGxiSMPOM g==;
X-CSE-ConnectionGUID: JxP/5YpTT32qGtbGqPW91w==
X-CSE-MsgGUID: sx1f2SaIQZq5A9LQOrVvQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141593"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90141593"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 00:53:44 -0700
X-CSE-ConnectionGUID: 01nOPtPeQwWDlZe9TpPO6g==
X-CSE-MsgGUID: Ztaxe2JzTqy7xm5xYgIAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="275025327"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
 by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:53:43 -0700
Date: Mon, 28 Sep 2026 15:53:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386/tcg: fix REPScalar with memory operand
Message-ID: <arodBkeurt7h/80o@intel.com>
References: <20260923124749.273446-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923124749.273446-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 23, 2026 at 02:47:49PM +0200, Paolo Bonzini wrote:
> Date: Wed, 23 Sep 2026 14:47:49 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386/tcg: fix REPScalar with memory operand
> X-Mailer: git-send-email 2.55.0
> 
> By the time validate_vex() runs, e->s2 is not used anymore and
> decode->op[2].ot has already been filled in by decode_size().
> So it's the latter that has to be adjusted, just like before
> commit b7d4ec4832d ("target/i386/tcg: move VEX validation early",
> 2026-08-26).
> 
> Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
> Reported-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/tcg/decode-new.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


