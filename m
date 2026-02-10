Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5586EEA8126
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppFx-0001Zw-5r; Tue, 10 Feb 2026 10:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vppFs-0001Xp-E0
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:02:22 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vppFo-0005P3-Ry
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770735737; x=1802271737;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=nTZrERvkpTsAgZwuDHtDU2WqpoL1vl1nTAt28zrXgFs=;
 b=ko6mo0inW5j9z9vAtzWFKU/B3WTmvF1wHgSVayyUtpbh/q1Hd1fIqeZ4
 p8EI9cSz6/H70wMDthFX+k2PLfKZyTgsOaWMQ/OeAoszB5NM8tLDz1pAw
 GsUZjW+QSVH3mPgAHdtGguz3KHFZPib4+d4xWWkqhq3RwUivdU8yoLVFk
 C3LHjuq75whHwS8oFLYPFY/mGdlgcDHP7RpOrKocivKufquL/XAoQXS5r
 5bwna4JLUhwgJ1uDfJvpDcBnp9v9O5cYHLwhIIQ4TpRQpCGDG+wcoa6/O
 3B3HCpCDB9p2n1c9sy6rTcMLhC3TYmO7nsfvOwNFdHy+FzeNTnRG7Y4zD A==;
X-CSE-ConnectionGUID: hXfU8h+dRJW8Z+UMTbs4TA==
X-CSE-MsgGUID: bppdK0xBQcCrG+2+mMjd9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="74465422"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="74465422"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:02:13 -0800
X-CSE-ConnectionGUID: 0EBLHyVvS7C8Fg88g3mM7w==
X-CSE-MsgGUID: dOjHJKmuTkiY6GozYsbZiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216454117"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 10 Feb 2026 07:02:09 -0800
Date: Tue, 10 Feb 2026 23:28:07 +0800
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
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
Message-ID: <aYtOh9guoiQocdjk@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYsElqDoGXQ_xMBD@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

Hi Daniel,

On Tue, Feb 10, 2026 at 10:12:38AM +0000, Daniel P. Berrangé wrote:
> Date: Tue, 10 Feb 2026 10:12:38 +0000
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track
>  external user input
> 
> On Tue, Feb 10, 2026 at 11:23:27AM +0800, Zhao Liu wrote:
> > Hi,
> > 
> > This is the v2 trying to introduce property flags to detect user's
> > property setting (from CLI/QMP/HMP). I dropped RFC tag since previous
> > RFC v1 [1].
> 
> This says what the series is proposing, but IMHO what is more important
> here is explaining why this either desirable or appropriate to add as
> general facility in QOM.

Yes, sorry this cover letter I wrote is overly simplified.

This series tries to control the property access against external user.
USER_SET is the base to track external user's behavior, and DEPRECATED &
INTERNAL flags provide different levels of access control.

Though the DEPRECATED flag does not inherently restrict access, I think
such a warning also serves as a form of control.

The idea of restricting external access to properties is from previous
discussions [*] about internal properties.

[*]: How to mark internal properties:
     https://lore.kernel.org/qemu-devel/2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com/

Since that disscussion, currently all properties expected to be
"internal" have an “x-” prefix — while this approach can work, it clearly
confuses the original meaning of “x-”, which actually means "unstable".

Therefore, I think the optimal approach is to provide the capability to
restrict external access to the property — that is, to implement the
"true" internal property.

Based on this, it seems impossible to implement an internal property
without tracking user input in the QOM?

> The idea that code should take different action for a given fixed value,
> based on whether the value was set by the user, or left on the default,
> makes me very uncomfortable.
> 
> There have been a number of situations where something that was initially 
> a boolean flag, actually needed to be a tri-state instead, to provide
> semantics like "On", "Off", "Auto".
> 
> This "user set" flag could support such behaviour indirectly, but since
> "user set" is an internal concept we'd still be only exposing a boolean
> externally, while using a tri-state internally. That does not give the
> full flexibility of a tri-state, because internally if we wanted to
> have the default to be "yes", it offers no way for the mgmt app to
> put it back to "auto".
> 
> For properties that are not booleans, it is much less obvious to me
> whether we actually need a distinct "not set" concept at all.

USER_SET primarily serves the INTERNAL and DEPRECATED flags. However,
its another function is to indicates whether the external user has
touched the property.

But, Hmm, I think "auto" and USER_SET don't have conflict?

IIUC, "auto" means the user requests that QEMU make the decision itself.
However, just like my patch 19 cleanup of “lbr-fmt”, that property
explicitly requires users to provide a valid value. Even we have "auto"
for uint64, "auto" can't address this case.

Similarly, the x86 CPU's topology IDs (used for hotplug) - "thread-id"/
"core-id"/"module-id"..., also require the user to set valid and accurate
values; they cannot be replaced with "auto".

These existing cases all check user input for magic numbers. I hope to
simplify these existing logic using USER_SET.

> So overall, at a conceptual level, I don't think that QOM should care
> about /how/ a value came to be set. It should have no direct awareness
> of the "user input", rather it just represents the configuration of the
> system at a given point in time,  however that came to pass.

I also think the ideal situation is not to distinguish between external
and internal - however, exposing properties to external users makes code
evolution painful...

Thanks,
Zhao


