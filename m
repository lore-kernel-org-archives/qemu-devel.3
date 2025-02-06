Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE4CC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 14:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2ct-0007D3-N9; Thu, 06 Feb 2025 09:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tg2cr-0007CP-Oi; Thu, 06 Feb 2025 09:13:05 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tg2cq-0000XT-2g; Thu, 06 Feb 2025 09:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738851184; x=1770387184;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZMq35FrhEk5mDeRr7RJiv16EUshbu3LSB2bSHyn92zU=;
 b=Uo64PkpQ7zqyoSU0n0xIaqvJ8Ok3fYmCdGCKFAybi1kA408iBB9k7FlT
 uHttiiVmlytgkOpu818UdslK17cwQjCyjWXQ/zsA5qxnrrU//RR7PKDeA
 HS4rmsME9u4XzlLLwUJir3HhmnGfylEQI+AW451RKUI5e5xnRzfqwTD/2
 DqXLayw7yqGTLaq7AadKsYTv3ByAWZZZocVck2Kb8DUll2WUB5/mJKM1a
 cXzBPbhXcwBJ4kvlULs27+piY8MeI2pz5HS7t+a66bCuyWCk9WhK5TkXC
 WYDDmtK+LgMhgXljfd4krvIloOMi9hDH2hhQrjyU3Gm2ipRls8xGRKttr w==;
X-CSE-ConnectionGUID: GGwQEYDEQlSZ99vYrWYkaA==
X-CSE-MsgGUID: mnZ60J+MRJKRirxt//I3/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38686407"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="38686407"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 06:13:01 -0800
X-CSE-ConnectionGUID: dGmgrJBGSfyPuxx/edfiyg==
X-CSE-MsgGUID: 4Ek+cwODRZqo7tx2bSyBtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="116180151"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 06 Feb 2025 06:12:57 -0800
Date: Thu, 6 Feb 2025 22:32:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <Z6TH+ZyLg/6pgKId@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-2-zhao1.liu@intel.com>
 <871pwc3dyw.fsf@pond.sub.org> <Z6SMxlWhHgronott@intel.com>
 <87h657p8z0.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h657p8z0.fsf@pond.sub.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
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

> Let's ignore how to place it for now, and focus on where we would *like*
> to place it.
> 
> Is it related to anything other than ObjectType / ObjectOptions in the
> QMP reference manual?

Yes!

> I guess qapi/kvm.json is for KVM-specific stuff in general, not just the
> KVM PMU filter.  Should we have a section for accelerator-specific
> stuff, with subsections for the various accelerators?
> 
> [...]

If we consider the accelerator from a top-down perspective, I understand
that we need to add accelerator.json, kvm.json, and kvm-pmu-filter.json.

The first two files are just to include subsections without any additional
content. Is this overkill? Could we just add a single kvm-pmu-filter.json
(I also considered this name, thinking that kvm might need to add more
things in the future)?

Of course, I lack experience with the file organization here. If you think
the three-level sections (accelerator.json, kvm.json, and kvm-pmu-filter.json)
is necessary, I am happy to try this way. :-)



