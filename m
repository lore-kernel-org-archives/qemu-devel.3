Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B17C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 02:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuN0H-00012Y-8N; Mon, 17 Mar 2025 22:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuN0F-00012G-5V; Mon, 17 Mar 2025 22:48:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tuN0C-0004xb-V5; Mon, 17 Mar 2025 22:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742266105; x=1773802105;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cN4pvuAwlbTjc6wqHon250c+HfjPnt3z7q6s8ELgfs8=;
 b=ew+UzlASXaOLI75wk5GzctzJbyHCqvJ0O01HC1MWRQAUN8+ovLWVY++p
 uGyJekOrdDvykQHVFZqvJLQbCH562Z+nKkVInlgHYZFDnbAg0CltUVdh+
 wGgxIE7PS1PVW+PQK/RP+p1kL7MkaFCHw50WhmI2dwPB42WM7jJb0nknQ
 OfbmpqnWZTtKBvDcvNeqBk1Do8omv6STvq877DKggrtQ2dxSjp9ggbBmx
 4FHN2ZB7w8Pz3sgq9EZss8t7ZaxY8pMdm8NYP7w1/AIU9POBBvA6Wu27K
 uwRFmeQhE2Df1zIxH2Vl4NSiQ/akRqCP12uzUsRUrIiDaZmPf1VjOmEr1 g==;
X-CSE-ConnectionGUID: fT7CPgADS9G5gKnHZvAZ5A==
X-CSE-MsgGUID: FrrPson2S4ONem2ofXoU+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43298945"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="43298945"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 19:48:21 -0700
X-CSE-ConnectionGUID: mTio3OqPSNePLjF6VCQxRw==
X-CSE-MsgGUID: QKRZpqm6R+m4oejyHRK6Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="122295684"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 17 Mar 2025 19:48:20 -0700
Date: Tue, 18 Mar 2025 11:08:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 12/17] rust/vmstate: Support version field in vmstate
 macros
Message-ID: <Z9jjsd9Zw9QD7gab@intel.com>
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-13-zhao1.liu@intel.com>
 <CABgObfaqFHb8AkHLj8enX3NCSAUUOhP_pPZ6chbBR6rUk6826Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaqFHb8AkHLj8enX3NCSAUUOhP_pPZ6chbBR6rUk6826Q@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
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

On Mon, Mar 17, 2025 at 05:38:10PM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Mar 2025 17:38:10 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 12/17] rust/vmstate: Support version field in vmstate
>  macros
> 
> On Mon, Mar 17, 2025 at 3:52 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> > Add "version = *" in vmstate macros to help set version_id in
> > VMStateField.
> 
> Could it use a ".with_min_version(2)" annotation (or something similar) instead?
> 

Ah, thanks! I didn't realize there was already a with_version_id() and
didn't understand your design intent, so

vmstate_of!(FooC, ptr).with_version_id(2),

would have been good enough! There is no need to add this `version` field.

Regards,
Zhao


