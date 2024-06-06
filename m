Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42BAC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 03:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF3pf-00048G-RE; Wed, 05 Jun 2024 23:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF3p3-0003Yk-1n
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:54 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sF3op-0003n4-Ct
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 23:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717644580; x=1749180580;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kieskrHj+q6BXqVdHq/yeQgD6BfnrXRu3u4lTS6jM5g=;
 b=aV5kkPJeasFU1Xkq6aiDNLvMP7QoBeFZMDZpY9QkvVJ6axa71a2qSOEk
 393mNsjCyWXoqAaE4juNNTJ966YdIVdEocIHswixASbF0h7elBBlx0Kwt
 XY66b0th4nsgzrGNBAwOQThPjAbhADvMzruxd8n9Db08iWBk1rPBfnt7w
 iBsDYcsa4ZARSo7REhW8jPHiiurkZQb0b1zIXQINgNBFswG9JgqhXz4tG
 bHRTCLcXk1417YC11kCW4VmamoI3HEJGCUuyXxONj1RFqP4dBwKNjosQx
 qRqmDEdfmTxrZbTDrhuVFCCRBMNviHyuw7vIMZj59t42cKTkywMZfb7BA g==;
X-CSE-ConnectionGUID: 7qaVlHHJR1emOKd9AW0jaA==
X-CSE-MsgGUID: bweg2ToHQYWEMDFAEx796Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="36819469"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="36819469"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 20:29:37 -0700
X-CSE-ConnectionGUID: eQxjEImWR3m3Ee3xfQmFOA==
X-CSE-MsgGUID: ee9KFhYcR7WToYtuoarCxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="37826936"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 05 Jun 2024 20:29:35 -0700
Date: Thu, 6 Jun 2024 11:45:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, pankaj.gupta@amd.com
Subject: Re: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
Message-ID: <ZmEwvsAnh1lXNqhS@intel.com>
References: <20240605224409.2103109-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605224409.2103109-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jun 06, 2024 at 12:44:09AM +0200, Paolo Bonzini wrote:
> Date: Thu,  6 Jun 2024 00:44:09 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] target/i386: SEV: do not assume machine->cgs is SEV
> X-Mailer: git-send-email 2.45.1
> 
> There can be other confidential computing classes that are not derived
> from sev-common.  Avoid aborting when encountering them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/sev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 004c667ac14..97e15f8b7a9 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1710,7 +1710,9 @@ void sev_es_set_reset_vector(CPUState *cpu)
>  {
>      X86CPU *x86;
>      CPUX86State *env;
> -    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
> +    SevCommonState *sev_common = SEV_COMMON(
> +        object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON));

SEV_COMMON(object_dynamic_cast()) looks to be twice cast, we can just
force to do conversion with pointer type:

(SevCommonState *) object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON)

>      /* Only update if we have valid reset information */
>      if (!sev_common || !sev_common->reset_data_valid) {
> -- 
> 2.45.1
> 
> 

