Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C294C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 13:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWcLJ-0002Oj-P7; Wed, 24 Jul 2024 09:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWcLE-0002Ix-0M; Wed, 24 Jul 2024 09:47:43 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWcLA-0001l0-3T; Wed, 24 Jul 2024 09:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721828856; x=1753364856;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=sxKpAl9rrbQ4Xx0Hyr/S+ZMPf6W0x+OqB+PPtAp9ArA=;
 b=bn5VXaGJC4wz6hVrYXziL3E/bcGDYqjCMYTSZryhtHE0EbBeEywxRIAv
 Zo5M2SXjJlQ1UYCdDh6XTU1+q3jtQYcmlPt6jpMlJHjSlSrnrqtf28ehh
 kMyXdEh54frAnvunJe2dK6VlQgJHJxUCf1KbcIaf5J5l/cGWPIh6Y2OPe
 mQQTcuGyxqlJexPMfNqPRAiMKm9dUj5e2/IXZjkaGVjuOiefN9l8YQVH5
 duyFYNcL+jKhvtr513hrLXa/eV0BSwildXGqBTPPxz0rOOsny4q75d92I
 hnj0Iw195UJRykimwM0R01M1TuoTxkyyXpuBGt0SGqLXi7g+vD0dkiM2b g==;
X-CSE-ConnectionGUID: Zbdz78JmRzuvT3m4kL22Fg==
X-CSE-MsgGUID: lwtqDF1xTDKwN71EIHgZ4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="19635301"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="19635301"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 06:47:23 -0700
X-CSE-ConnectionGUID: KcuozMCYQ2qc1TLMylTygw==
X-CSE-MsgGUID: SiPTLhqxQVi/C+OLS4Jj6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="52816196"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 24 Jul 2024 06:47:18 -0700
Date: Wed, 24 Jul 2024 22:03:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
Message-ID: <ZqEJlmR3U6g8zq0z@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
 <87wmld361y.fsf@pond.sub.org> <Zp5tBHBoeXZy44ys@intel.com>
 <87h6cfowei.fsf@pond.sub.org> <ZqD31Oj5P0uDMs-I@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqD31Oj5P0uDMs-I@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Jul 24, 2024 at 01:47:16PM +0100, Daniel P. Berrangé wrote:
> Date: Wed, 24 Jul 2024 13:47:16 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
> 
> On Wed, Jul 24, 2024 at 01:35:17PM +0200, Markus Armbruster wrote:
> > Zhao Liu <zhao1.liu@intel.com> writes:
> > 
> > > Hi Markus,
> > >> SmpCachesProperties and SmpCacheProperties would put the singular
> > >> vs. plural where it belongs.  Sounds a bit awkward to me, though.
> > >> Naming is hard.
> > >
> > > For SmpCachesProperties, it's easy to overlook the first "s".
> > >
> > >> Other ideas, anybody?
> > >
> > > Maybe SmpCacheOptions or SmpCachesPropertyWrapper?
> > 
> > I wonder why we have a single QOM object to configure all caches, and
> > not one QOM object per cache.
> 
> Previous versions of this series were augmenting the existing
> -smp command line.

Ah, yes, since -smp, as a sugar option of -machine, doesn't support
JSON. In -smp, we need to use keyval's style to configure as:

-smp caches.0.name=l1i,caches.0.topo=core

I think JSON is the more elegant way to go, so I chose -object.

> Now the design has switched to use -object,
> I agree that it'd be simplest to just have one -object flag
> added per cache level we want to defnie.
> 

OK.

Thanks,
Zhao


