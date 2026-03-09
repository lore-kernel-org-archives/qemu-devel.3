Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6940FF3C24A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaLu-0007cX-B2; Mon, 09 Mar 2026 09:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzaLk-0007Ll-TL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:45 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vzaLh-0008FG-41
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773061721; x=1804597721;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=gjWa/6Zn7gu/PE25Kg8S0txoY7y+19Rcf8HIy2Whxrk=;
 b=hCGT5+K7IFUVZfFvLJovSnkWzXJjlRfIiGDDbAG5Vy4kn0NuVjAD0idr
 L2doEB3cjWxu8/wv5dZlY9Om3ex19FqztBzq1fpEUTNoXbYlVMizY4s5+
 0TEGa0VHU8M+s7y0e2GA/bXw1tYV5N+Ml5m1symHN/WnHUSvgnnKgv+75
 xuD3xPAfNziu3Hjp7hlQPJHeD6aKe1qqkEsLPb0UhkxvkqpRmym8R6n/B
 Yq+ZAvs2EzSaYsTWFZ+aIgj/I18xfvL9gZAjUOezryz53GtV4ahC4InDk
 KLZmS665vTQ+5mdw0v/1+aQj5A9k5tfciAN69njI+FICbF4mszzDKmJD3 Q==;
X-CSE-ConnectionGUID: iX/avDeqSHe1JenvMeKlgA==
X-CSE-MsgGUID: A+oK/wuXT5SjSJP4J+ZY3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="96701244"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="96701244"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:08:36 -0700
X-CSE-ConnectionGUID: Nh16+b3FSVizfVtPJTIbog==
X-CSE-MsgGUID: YJhnVgqOSMG7taxJY7qQEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="245713507"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Mar 2026 06:08:32 -0700
Date: Mon, 9 Mar 2026 21:34:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev properties
 accept flags
Message-ID: <aa7Mckq/8cgwZwkB@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com> <aY3w3RjzF8/SxPjg@intel.com>
 <aY309kPru8ELO5_N@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY309kPru8ELO5_N@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(Sorry for the long silence — just returned from vacation.)

> > Yeah, most property setting paths are covered by
> > object_set_properties_from_qdict() (I listes these cases in patch 12,
> > including the most common ones: -object/-device and their related HMP/QMP
> > commands).
> > 
> > But there're some corner cases which don't go through
> > object_set_properties_from_qdict(), e.g., -global/-accel/"qom-set", etc,
> > those were considerred in patch 9/11/13 (and sorry I should list all
> > cases affected in cover letter :(). These cases are where I find
> > things to be both trivial and tricky, so I manually check them and mark
> > them using USER_SET.
> > 
> > Therefore, I think the unified entry point for externally setting
> > properties resides at a lower level—specifically, is object_property_set(),
> > then we need to dientify when object_property_set() is called by
> > external user or not - that's how USER_SET works...(I feel like I'm back
> > where I started).
> 
> There's a significant different there.  Emitting deprecation messages
> in the API entry points tied to user data is a clear purpose, not
> open to abuse. Recording the difference between user set & internally
> set against the object instance persistently is an open ended purpose
> and based on what we've seen in QEMU in the past, that is highly likely
> to be mis-used.
>
> The idea of supporting deprecations on properties is definitely
> something we should do, but I really dn't want to see that expressed
> via the 'user set' mechanism from this series.

Thank you for your explanation. In practice, as the alternative to
USER_SET, I understand we identify the specific API entry points (including
object_set_properties_from_qdict and others) and trigger the warning
directly within those functions / code path, may I ask if this
understanding is right?

The current API entry points are somewhat fragmented; perhaps we should
consider whether further unification is possible.

Regards,
Zhao


