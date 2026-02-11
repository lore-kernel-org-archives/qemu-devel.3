Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490BDEB596B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3xw-0005hw-3N; Wed, 11 Feb 2026 01:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq3xu-0005hW-HC
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:44:46 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq3xt-0005zz-12
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770792285; x=1802328285;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dOo0VUiS4zbvd3z/oSl5c3+7D2hivjxEr/3ORyGQiMI=;
 b=Os1KrnH0QCzXELAgmis6sV97d3mLCJ7DgGB641Dua+hXQzHTAQXFUiDx
 Oy2r/x9Y7ovnKtHA2m3P8wp/DhGh+4lmOZwZd0GzWdlb6gEQpgBYb6589
 0pqYE9+gVyWbgF3B4Sk8vREFCFVhqNFnNeb5/xOleuNqU2flBbpRSeeGN
 k0ADgVaJ1ybGyEJEbwGyTCoe3gBGWjz+AxODmdL2+YUjY7KYs4SE94CA4
 AW/4YA+7qoTfOpr5b6rmMLOuWsK9Lm1Qp3y3vMPsx1ecyt/ca+nH924od
 Vz5cJCkjsOIL/hU1BZlingywljk+1yhjzdXchyUoiR4fpzZ0+BeQEDF7d w==;
X-CSE-ConnectionGUID: k+wJ0je3RvSKuFYNwgcUBg==
X-CSE-MsgGUID: XfDKHeTIQrGG/mzhKjzNcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="82570916"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="82570916"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:44:42 -0800
X-CSE-ConnectionGUID: d1gusxO9QomwWg+qgaGyKg==
X-CSE-MsgGUID: DlI+4qpeRYS6Rzb5D97D+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216685147"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 10 Feb 2026 22:44:38 -0800
Date: Wed, 11 Feb 2026 15:10:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
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
Message-ID: <aYwrbNFugCtUg2M9@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYr9Xnt0Qq38dDhv@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYr9Xnt0Qq38dDhv@angien.pipo.sk>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 10, 2026 at 10:41:50AM +0100, Peter Krempa wrote:
> Date: Tue, 10 Feb 2026 10:41:50 +0100
> From: Peter Krempa <pkrempa@redhat.com>
> Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
>  properties accept flags
> 
> On Tue, Feb 10, 2026 at 11:23:41 +0800, Zhao Liu wrote:
> > Update qdev property interfaces (qdev_property_add_static() and
> > qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
> > This enables marking qdev properties with flags such as DEPRECATED or
> > INTERNAL.
> > 
> > To facilitate this at the definition level, extend the boolean and
> > uint8_t property macros (as the examples) to accept variable arguments
> > (VA_ARGS). This allows callers to optionally specify flags in the
> > property definition.
> > 
> > Example:
> > 
> > DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
> >                   .flags = OBJECT_PROPERTY_DEPRECATED),
> 
> Is there a plan to expose at least the _DEPRECATED property to be
> introspectable (e.g. via qom-list-properties or device-list-properties)
> ?
> 
> In libvirt we try to stay proactive about adapting to deprecations and
> this would allow our test-suite to detect deprecations programmaticaly
> similarly to how we detect deprecations via query-qmp-schema. Although
> with the current patchset there doesn't seem to be anything that libvirt
> would need to adapt to.

Yes, this is the thing not yet covered by the current Series. I think
the ultimate goal is to use the INTERNAL flag to filter properties that
should not be exposed to libvirt, and to check against the DEPRECATED
flag to make it possible to alert libvirt of their deprecated status.

Thanks,
Zhao


