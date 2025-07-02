Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80987C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrzg-0003dC-S2; Wed, 02 Jul 2025 03:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWrzd-0003cr-UH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:34:58 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uWrzR-00008D-E7
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751441685; x=1782977685;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rpddclMofJTIQr5ClowmnBKbZ/+347HhrvynyTKlS18=;
 b=bJ50EJBEQUbE2mVi6Ie8ZVf3EnFFrAXLJdpK2He3B8DQnuLUmmURQzMD
 ht8SAoXaJdUZQR8IIcH+NnhC72fFOWD3DrC4TlQ9S778huPfxoBOJYVqD
 jJ192cgZ7aehD+v0IdZNG/PvCljt3D6M89SzR0XAs4emUUtOX9DwnFk94
 jk/gu64/InYKu2npaBfK/fcq2X8pltvIYyp0DIsPJ6isek9ahHZYn777u
 nrWQMDmga2fayoiQg+dLbBwg2D5GXqVJ7vB3KGEcOswb2/oi251f08Frt
 LsW3otQhZYtyechK3AZ34GgW9lTXPxbjjhw8hVNBwBPOdL0zPMvhcARku g==;
X-CSE-ConnectionGUID: 7ZafqOB7RVqE8CvAOWM+6g==
X-CSE-MsgGUID: LvGIaqweTyqygOG+xDbwQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57533781"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="57533781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 00:34:42 -0700
X-CSE-ConnectionGUID: VoEs06xZRk2uGTC1dDfd6w==
X-CSE-MsgGUID: FxP0/NytQQuWhpJKtgJAaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="154482044"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 02 Jul 2025 00:34:39 -0700
Date: Wed, 2 Jul 2025 15:56:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dongli Zhang <dongli.zhang@oracle.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Like Xu <like.xu.linux@gmail.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [Regression] Re: [PULL 35/35] qom: reverse order of
 instance_post_init calls
Message-ID: <aGTmFGC9vZB2yEwv@intel.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
 <20250520110530.366202-36-pbonzini@redhat.com>
 <d429b6f5-b59c-4884-b18f-8db71cb8dc7b@oracle.com>
 <aFpocfTpBLB34N3l@intel.com> <aGKryLSGlFTMSKHv@intel.com>
 <690b5bca-4345-4ee9-a332-4c2e38532309@intel.com>
 <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31387ca1-4fa0-482e-8e11-e8857c10cb6c@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 0d35e95430fe..bf290262cbfe 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -9044,6 +9044,12 @@ static void x86_cpu_post_initfn(Object *obj)
> >               X86_CONFIDENTIAL_GUEST(current_machine->cgs), (CPU(obj)));
> >       }
> >   #endif
> > +
> > +    /*
> > +     * Re-apply the "feature[=foo]" from '-cpu' option since they might
> > +     * be overwritten by above
> > +     */
> > +    qdev_prop_set_globals(DEVICE(obj));
> >   }
> 
> This patch LGTM.

This solution will call qdev_prop_set_globals() twice. My concern is
that this masks the problem: previous x86 CPU assumptions about the
order of global property initialization break down...

Per the commit message of Paolo's commit:

"This is incorrect because the leaf class cannot observe property
values applied by the superclasses; for example, a compat property
will be set on a device *after* the class's post_init callback has
run."

X86 CPUs have the issue (e.g., "vendor" doesn't work) now because
they - as leaf class, don't care about the property values of
superclass - the DeviceState. If a property is just for initialization,
like "vendor", it should be placed in the instance_init() instead of
instance_post_init().

In addition, if other places handle it similarly, the device's
post_init seems pointless. :-(

Thanks,
Zhao


