Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E6CEB5969
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3ts-0004BS-2O; Wed, 11 Feb 2026 01:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq3tq-0004BE-Vr
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:40:35 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vq3tp-0005Fj-2r
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770792033; x=1802328033;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nXzL3tZmJdMNCot4ccFgJN/7KHWN1OSvjX1UPSr5o5U=;
 b=Ye/qJJ9AdzXrqxFpTaIofG7AJuAUMj+Cey7Y0vnvMsy/yOFo2CZJ1BQ9
 +f/xkVsEKicyZslULNvFkidA+Bb+fHGLpNha/xFn8EYQWQPjL00T4gX7J
 l6EDFLNQyKvuaPn4ALJyNwE9wtAh1eoP2Nw2XH4e1/bSwW0VNKFHAows0
 zS1GJyz4KXi1I5u2u2lX+ASSrp8CXXByqt0tGLG04P/Ag47B/hhzW8dku
 DkhxzbnltUhlHYcc7j0Lf88fwZbHvUgCs/Idp/aKaIo0qPuX1mWwsNXBC
 8WO0zxyOtdjAr9267urTAeEAOq0oTJKEgXTkC2ppGW5cQ6NCmrbgITshk w==;
X-CSE-ConnectionGUID: X/A8jYbCQTGnmSdl4+WIxA==
X-CSE-MsgGUID: a1n2tkn9SVW/xpCeTUDERg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="83372924"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83372924"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:40:30 -0800
X-CSE-ConnectionGUID: z3t+kpQcS1W9YZ9o4JtBdQ==
X-CSE-MsgGUID: dWbaOrupRra5+coQaNxhWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211256660"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 10 Feb 2026 22:40:26 -0800
Date: Wed, 11 Feb 2026 15:06:23 +0800
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
Message-ID: <aYwqb2MR+CjFfDtg@intel.com>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <aYsElqDoGXQ_xMBD@redhat.com> <aYtOh9guoiQocdjk@intel.com>
 <aYtRooiYCc8LzUUJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtRooiYCc8LzUUJ@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
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

> So the main thing that pushes us into using QOM for internal properties
> is the machine type compatibility code. eg where we bulk set stuff using
> 
>     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
>     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
> 
> That logic is all QOM based. Using QOM isn't our exclusive approach, as
> we have machine types sometimes setting object fields directly. eg
> 
>   static void pc_i440fx_machine_7_0_options(MachineClass *m)
>   {
>     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>     pc_i440fx_machine_7_1_options(m);
>     pcmc->enforce_amd_1tb_hole = false;
>     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
>     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
>   }
> 
> but that only works for properties against the machine type, not compat
> properties against devices, since we have no direct access to the other
> classes/instances.

Right, and setting fields directly is only possible for machine-level
state, not for device properties created dynamically during
realize/init. So QOM-based compat properties are indeed inescapable
for devices.

> If we want to be able to control hardware compat, without exposing
> something as a user facing tunable, then internal-only QOM props seems
> inescapable.

Agreed.

> I do still wonder if we genuinely need internal-only QOM props for
> machine type compat ?
> 
> Whether using a public 'x-' prefixed property or an internal only
> property, we're constrained by the need to retain the behaviour
> semantics for as long as the machine type exists. I don't see an
> internal only property giving us significantly more freedom here.
> We can already rename a 'x-' property however we want with no
> notice, as long as the machine type doesn't change behaviour.

Hmm, I think x- prefix is already semantically overloaded. Looking at
the current codebase, x- carries two very different meanings:

 - "unstable but user-facing feature" - e.g. x-vga, x-igd-opregion
   (documented in docs/igd-assign.rst with user-facing examples),
   x-migration-multifd-transfer (documented in
   docs/devel/vfio-migration.rst).

 - "internal compat switch to fix bug" - e.g. x-buggy-eim,
   x-pci-express-writeable-slt-bug.

These two categories have fundamentally different contracts - the
former should be settable by users, the latter should not. But today,
nothing prevents a user from writing something like:

"-device intel-iommu,x-buggy-eim=false"

QEMU will happily accept it.

An INTERNAL flag can reject this at property set time with a clear
error.

And management tools use qom-list-properties to discover settable
properties (though this series hasn't covered this but it's
possible) - they currently have no way to distinguish "x-vga"
(user-facing) from "x-pci-express-writeable-slt-bug" (internal
bug-compat). An INTERNAL flag could give a clean boundary for
introspection.

> I don't think it does. Code evolution is painful as long as the machine
> type using the prop needs to exist with fixed semantics, whether it is
> internal or public with x- prefix.

I agree the machine type lifetime constraint doesn't change.

But experimental x- or normal (external) properties are by default
exposed to users, allowing them to set values via -device or other
entry points. This effectively treats the property as an API.

Once it becomes an API, any modification to the property must consider
whether there are external dependencies. Just as with the series
(removing v2.6 & v2.7 PC machines) I referenced in cover letter,
justifying whether a property can be directly removed becomes very
complicated and unpredictable - some are definitely in use, while some
are merely "potentially" in use.

Let me take the recently added compatibility properties as another
example - they are all x86 CPU properties:
 * x-l1-cache-per-thread: it's useful for external user to tune L1
   cache topology (though now we have smp-cache, before smp-cache,
   it was useful).
 * x-consistent-cache: this actually is a fix and should be
   internal-only.

While both are compatibility properties and share the x- prefix,
their purposes differ, reflecting the confusion around x- prefix I
mentioned earlier. It's also expected that distinct strategies will
be required when genuinely considering the removal of these two
categories of properties in the future. :-(

So the advantage of distinguishing between internal and external
properties is that modifications or even removal of internal
properties can be done directly without worrying about external
consumers. External properties, as potential API objects, require
explicit deprecation before they can be dropped.

Although it doesn't directly help with modifying existing properties,
any newly added internal property won't increase such API concerns
going forward.

So I'm not positioning INTERNAL as a replacement for x- prefix -
rather, it complements x- by providing runtime enforcement, clean
introspection, and preventing accidental ABI commitment that a naming
convention alone cannot. x- remains appropriate for
unstable-but-user-facing features.

Thanks,
Zhao


