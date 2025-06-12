Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9F8C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 10:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPesv-0002jt-7k; Thu, 12 Jun 2025 06:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPesq-0002e3-Ei; Thu, 12 Jun 2025 06:10:09 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPeso-00056I-9X; Thu, 12 Jun 2025 06:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749723006; x=1781259006;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fHYaDxdXliQaiVrsmIZ+1J1h37qR2uhP4a8EVXYux28=;
 b=fq4RB4KboT0GL4YIjeZ8ny6lmT2c+y0Df1+OW9yTz7lPfSW8eG+NA86Y
 cPFJCYLI6ACnwCwTGLwLfK3BnViXdvb4BSBTXC6S781YZLBIImkwB2rio
 KnBxCCxaLdkb790dFmWhEVjuBicl/ZtxzAtFOWwT9HFLQ1TLVDm4cMLdW
 w8IXkCoB8zP8zWBRjtbjlwdluntkbpnXvu4Mmf4aqxqb14/GqpT/25oX+
 NkAfqf9rYRMAfzJ25hqsKEbIEK80xPkOC0HTXEWSDkPPl4eTUtxIItiIB
 D3Gvjr3/2YBJ9FYw3/ozZIzQVoWr5k5BTdtgEX+zauGx6EiB3IkTs1yV5 g==;
X-CSE-ConnectionGUID: 6dW5vWkWQWKS1VV3vqyGsQ==
X-CSE-MsgGUID: 2ki6bZWbQYqbiu/dScO3RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51809717"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="51809717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 03:10:02 -0700
X-CSE-ConnectionGUID: 6BOsLbt+TS+G283zqcXeoA==
X-CSE-MsgGUID: yLpA4M7vQrOiBXP/nDRdFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152239947"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 12 Jun 2025 03:10:00 -0700
Date: Thu, 12 Jun 2025 18:31:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
Message-ID: <aEqsdKNmS3+NSSGm@intel.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-5-pbonzini@redhat.com>
 <aEqcGiGmZiMoIhY5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqcGiGmZiMoIhY5@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

> > -impl<'a, T> ParentInit<'a, T> {
> > +impl<'init, T> ParentInit<'init, T> {
> >      #[inline]
> > -    pub fn with(obj: &'a mut MaybeUninit<T>, f: impl FnOnce(ParentInit<'a, T>)) {
> > -        let parent_init = ParentInit(obj);
> > +    pub fn with(obj: &'init mut MaybeUninit<T>, f: impl for<'id> FnOnce(ParentInit<'id, T>)) {
> > +        let parent_init = ParentInit(obj, PhantomData);
> 
> I think it's also valuable to add the similar comment as GhostToken did,
> mentioning this `f` can't reture ParentInit itself.

My bad, I forgot there's no returned value...

> >          f(parent_init)
> >      }
> >  }

