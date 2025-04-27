Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A4C369D5
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Apr 2025 07:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8w54-0005i5-Tf; Sun, 27 Apr 2025 03:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8w51-0005hQ-Em; Sun, 27 Apr 2025 03:05:35 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8w4x-0005nw-UM; Sun, 27 Apr 2025 03:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745737532; x=1777273532;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/VAXcw1oJpNq80iCbs63zP5UG4yX37TNo7LthnbGVBo=;
 b=WPycwxgB746nkyfhq7oZ97mJE0UngqJuCp9pjZe8F9enW8zJlH5E3U3l
 I8eqs3fHA1B3XLhoFSw1UKG4PZgQ6Gqyp0qWodmQXCjw2bS66wdUOgM7H
 YOb7pBnbqHxU495hNiUXtfv2mm0p9IlavuYr/bPZizR5h/St8uty7T/Dw
 NBt9cMNblD23iMlYvPn7PdN8UtmyyyKqoa0yLSSjB/4/N4SAYyvV1IlDI
 oHuRw2g3okRd9JqjXNN6MlWB5uRkF/pZIkNo5XWQ6NVxon2wZdmTRDARI
 Nyf718FSNdNmMXcMPT6oulxmzFlhmCuMraBsoL3AcuopeYrFJCo5h+jAV w==;
X-CSE-ConnectionGUID: gJV9MrDkSDCkkw3G+EZXuw==
X-CSE-MsgGUID: uB1B60kaQdO+GLOf6tI5Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="47255469"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="47255469"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2025 00:05:28 -0700
X-CSE-ConnectionGUID: rVl3Mel3THqiZcQli6WIqg==
X-CSE-MsgGUID: kb1BB0dSQ0S5A+G0fWVAEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; d="scan'208";a="156475720"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 27 Apr 2025 00:05:23 -0700
Date: Sun, 27 Apr 2025 15:26:20 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Alexander Graf <agraf@csgraf.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <aA3cHIcKmt3vdkVk@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <878qo8yu5u.fsf@pond.sub.org> <Z/iUiEXZj52CbduB@intel.com>
 <87frifxqgk.fsf@pond.sub.org> <Z/i3+l3uQ3dTjnHT@intel.com>
 <87fri8o70b.fsf@pond.sub.org> <aAnbLhBXMFAxE2vT@intel.com>
 <fa6f20a9-3d7a-4c2d-94e5-c20dbaf4303e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6f20a9-3d7a-4c2d-94e5-c20dbaf4303e@linaro.org>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.738,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Philip and Markus,

Let's discuss how to handle compilation for different architectures as
well as different accelerators here.

> > And "raw" format as a lower level format can be used for other arches
> > (e.g., ARM).
> 
> Since you provide the ability to use a raw format, are we sure other
> accelerators will never be interested in such PMU filtering?
> 
> I'm pretty sure HVF could benefit of it (whether we implement it there
> is another story).

Nice to know it could benefit more cases.

> What do you think about adding this as a generic accelerator feature.

I can implement pmu-filter directly at the "accel" level.

> If a particular accel doesn't support it and we ask to filter, we simply
> report an error.

One of the main issues is how to organize the QAPI scheme:

First we have a "qapi/accelerator.json" like current implementation to
provide:

##
# = Accelerators
##

Then we should have a "qapi/accelerator-target.json" (which will follows
qapi/accelerator.json in qapi-schema.json, just like machine.json &
machine-target.json), and place all pmu-filter related things in this
file with specify the compilation condition, for example:

{ 'struct': 'KvmPmuFilterProperties',
  'data': { 'action': 'KvmPmuFilterAction',
            '*x86-fixed-counter': 'uint32',
            '*events': ['KvmPmuFilterEvent'] },
  'if': 'CONFIG_KVM' }

In the future, this could be expanded to: 'if': { 'any': [ 'CONFIG_HVF', 'CONFIG_KVM' ] }.

I understand that there is no way to specify the architecture here,
because it is not possible to specify a combination case like
"TARGET_I386 & CONFIG_KVM", "TARGET_ARM & CONFIG_KVM", "TARGET_ARM & CONFIG_HVF"
(please educate me if such "if" condition be implemented in QAPI :-)).

So, I will put the arch-specific format check in pmu-filter.c by adding
arch macros as I mentioned in this reply:

https://lore.kernel.org/qemu-devel/aA3TeaYG9mNMdEiW@intel.com/

And there'll need accel-specific format check (for example, maksed-entry
is KVM specific, and it is not defined in x86 spec). I can check the
accel-specific format in the `check` hook of
object_class_property_add_link(), which links the pmu-filter object to
accelerator.

Do you like this idea?

Thanks,
Zhao



