Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5DAC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 14:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWdOH-0007MT-Ro; Wed, 24 Jul 2024 10:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWdOF-0007Kd-DO; Wed, 24 Jul 2024 10:54:51 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWdOC-0005WT-Re; Wed, 24 Jul 2024 10:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721832889; x=1753368889;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nhEKDuTNwPMDwruusMMbK1Dm5j0cygvuqJe3rM266dI=;
 b=PtPqeffwaEUFWuACVlHCZbT9q+1vgiT8Ety7iA3SlkK/baVQbagSCxzx
 XSk5vcuNOkJwnN2TYJul12MJW9cFkFuR4WgRDLT/5MAywJxWi7P3P+lrR
 liDbq/06ef7Xfol0CJT/W5HeYzK2j9vXb5uGU3l5OYX5OLwl9VqNB4Tqx
 ESZG8DBBcIO47uLtt2enastdf5r4WBN2wwC3SEoTTz0S2KQxVhoeFlXva
 sGTOLsJbAzDCHo/UvqKhWdyFEXKHYIlYunT4NUc4uZgLaDnVBTDSkcZDd
 FUdEEIZrGBtIfd6UbDO3+f5OWvtmONqeg9ujmuVsI5BuPk0UmsgDq8KJL A==;
X-CSE-ConnectionGUID: 7p0CC7XLS3mAiyjN8qlW1A==
X-CSE-MsgGUID: 4knbuwtXTEeU/8pKmaQ0jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="44941943"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="44941943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2024 07:54:45 -0700
X-CSE-ConnectionGUID: SQlBHtnfSNazf+k8B1Ve8g==
X-CSE-MsgGUID: gsHTaE3GT0aVEU/MKedVwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; d="scan'208";a="57749094"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 24 Jul 2024 07:54:40 -0700
Date: Wed, 24 Jul 2024 23:10:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ++/vQ==?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
Message-ID: <ZqEZYEAkMhqBRtbx@intel.com>
References: <20240704031603.1744546-1-zhao1.liu@intel.com>
 <20240704031603.1744546-3-zhao1.liu@intel.com>
 <87wmld361y.fsf@pond.sub.org> <Zp5tBHBoeXZy44ys@intel.com>
 <87h6cfowei.fsf@pond.sub.org> <ZqD31Oj5P0uDMs-I@redhat.com>
 <ZqEJlmR3U6g8zq0z@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqEJlmR3U6g8zq0z@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

Hi Daniel,

On Wed, Jul 24, 2024 at 10:03:02PM +0800, Zhao Liu wrote:
> Date: Wed, 24 Jul 2024 22:03:02 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
> 
> On Wed, Jul 24, 2024 at 01:47:16PM +0100, Daniel P. Berrang? wrote:
> > Date: Wed, 24 Jul 2024 13:47:16 +0100
> > From: "Daniel P. Berrang?" <berrange@redhat.com>
> > Subject: Re: [PATCH 2/8] qapi/qom: Introduce smp-cache object
> > 
> > On Wed, Jul 24, 2024 at 01:35:17PM +0200, Markus Armbruster wrote:
> > > Zhao Liu <zhao1.liu@intel.com> writes:
> > > 
> > > > Hi Markus,
> > > >> SmpCachesProperties and SmpCacheProperties would put the singular
> > > >> vs. plural where it belongs.  Sounds a bit awkward to me, though.
> > > >> Naming is hard.
> > > >
> > > > For SmpCachesProperties, it's easy to overlook the first "s".
> > > >
> > > >> Other ideas, anybody?
> > > >
> > > > Maybe SmpCacheOptions or SmpCachesPropertyWrapper?
> > > 
> > > I wonder why we have a single QOM object to configure all caches, and
> > > not one QOM object per cache.
> > 
> > Previous versions of this series were augmenting the existing
> > -smp command line.
> 
> Ah, yes, since -smp, as a sugar option of -machine, doesn't support
> JSON. In -smp, we need to use keyval's style to configure as:
> 
> -smp caches.0.name=l1i,caches.0.topo=core
> 
> I think JSON is the more elegant way to go, so I chose -object.

I may have to retract this assertion considering more issues, I could
fall back to -smp and support it in keyval format, I think it's also ok
for me if you also like keyval format, sorry for my repetition, we can
discuss this in this thread:

https://lore.kernel.org/qemu-devel/20240704031603.1744546-1-zhao1.liu@intel.com/T/#m8adba8ba14ebac0c9935fbf45983cc71e53ccf45

Thanks,
Zhao



