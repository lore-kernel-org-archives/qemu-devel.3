Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4ADEE3694
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYAF-00046W-Kg; Thu, 12 Feb 2026 09:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vqYAD-000467-QQ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:59:29 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vqYAB-0001Y8-EL
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770908368; x=1802444368;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hFjcu790FppMor5LTQsSd4mVnUdDU7Rc1NRQnccQZDA=;
 b=eerza1bvAqVQuW7QmN1fUuZzLJx0o8EP8o/l6G1eWro/MjZYpcArLHpG
 FO3GSoKFK3r+ciHL75GH11OZJaBFhJ3kMgRR+3o00q4MxGcWvHXhKkWMB
 f4ZrLJhurTHOiEmpdhZ3n9AzRGGmMICbfoa7cT0w5oRvErWwcKih2PHcV
 mfHYflF4a7lY+zk40akJ5ZF/vntuEtZJqgvuGaQSTHOTX40DJfdUKJqiP
 TRbaDNSu+gMJu5RyRfgKzs9ykPKOD4q+vGRjYaoJItlGwG9sa8q2oBOBs
 0K1JquOS+cbpOy05AWqTESUxKOh63+RL7/TqR+4OD9n8OAR9QoN2tA4mt Q==;
X-CSE-ConnectionGUID: GtBPc6sCQCaZvRDMdtQzBA==
X-CSE-MsgGUID: /gaxjUtcT4+ZlHvUlbIDsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72178545"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="72178545"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 06:59:23 -0800
X-CSE-ConnectionGUID: 0d9Mu4rpSdWp1VxtJ5wyrA==
X-CSE-MsgGUID: 5GLCvuBLSEW4CXd9pxEayA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212719861"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 12 Feb 2026 06:59:18 -0800
Date: Thu, 12 Feb 2026 23:25:17 +0800
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
Message-ID: <aY3w3RjzF8/SxPjg@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-15-zhao1.liu@intel.com>
 <aYsAuFNQQvwYiLPI@redhat.com> <aYwv/mcUBXy9kUYZ@intel.com>
 <aYy1R-JQjZ-Y38Am@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYy1R-JQjZ-Y38Am@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Feb 11, 2026 at 04:58:47PM +0000, Daniel P. Berrangé wrote:
> Date: Wed, 11 Feb 2026 16:58:47 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
>  properties accept flags
> 
> On Wed, Feb 11, 2026 at 03:30:06PM +0800, Zhao Liu wrote:
> > On Tue, Feb 10, 2026 at 09:56:08AM +0000, Daniel P. Berrangé wrote:
> > > Date: Tue, 10 Feb 2026 09:56:08 +0000
> > > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > > Subject: Re: [PATCH v2 14/21] hw/core/qdev-properties: allow qdev
> > >  properties accept flags
> > > 
> > > On Tue, Feb 10, 2026 at 11:23:41AM +0800, Zhao Liu wrote:
> > > > Update qdev property interfaces (qdev_property_add_static() and
> > > > qdev_class_add_property()) to accept and pass 'ObjectPropertyFlags'.
> > > > This enables marking qdev properties with flags such as DEPRECATED or
> > > > INTERNAL.
> > > > 
> > > > To facilitate this at the definition level, extend the boolean and
> > > > uint8_t property macros (as the examples) to accept variable arguments
> > > > (VA_ARGS). This allows callers to optionally specify flags in the
> > > > property definition.
> > > > 
> > > > Example:
> > > > 
> > > > DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
> > > >                   .flags = OBJECT_PROPERTY_DEPRECATED),
> > > 
> > > In other places where we track deprecation in QEMU, we have not used
> > > a boolean flag. Instead we have used a "const char *deprecation_note"
> > > internally, which lets us provide a user facing message, to be printed
> > > out in the warn_report, informing them what to do instead (either the
> > > feature is entirely removed, or there is a better alternative). IMHO
> > > we should be following the same pattern for properties, as it is much
> > > more user friendly than just printing a totally generic message
> > > "XXXX is deprecated, stop using it" 
> > 
> > Yes, rich deprecation hint is better. I think this still depends on
> > USER_SET - distinguish internal/external or not :-(.
> > 
> > Since when we mark a property as deprecated, its code remains in the
> > code tree, and internal calls should not trigger warnings. Deprecation
> > hints are intended to reminder external users.
> 
> This depends on where you put the deprecation check. IIUC, all the user
> facing codepaths for setting properties end up calling through
> object_set_properties_from_qdict, but internal codepaths don't use that.
>
> That method can check & emit the deprecation warnings, without us needing
> any explicit tracking of "user set" - the use context is derived from the
> codepath

Yeah, most property setting paths are covered by
object_set_properties_from_qdict() (I listes these cases in patch 12,
including the most common ones: -object/-device and their related HMP/QMP
commands).

But there're some corner cases which don't go through
object_set_properties_from_qdict(), e.g., -global/-accel/"qom-set", etc,
those were considerred in patch 9/11/13 (and sorry I should list all
cases affected in cover letter :(). These cases are where I find
things to be both trivial and tricky, so I manually check them and mark
them using USER_SET.

Therefore, I think the unified entry point for externally setting
properties resides at a lower level—specifically, is object_property_set(),
then we need to dientify when object_property_set() is called by
external user or not - that's how USER_SET works...(I feel like I'm back
where I started).

Thanks,
Zhao


