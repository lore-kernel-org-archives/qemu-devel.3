Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B289EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 15:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7yHE-0005Zs-1G; Thu, 24 Apr 2025 11:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7yH9-0005Yx-4Q; Thu, 24 Apr 2025 11:14:07 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u7yH5-0008FA-J3; Thu, 24 Apr 2025 11:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745507644; x=1777043644;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wVEPg+cfudgIjOoKZg2o4CMPdWU7kLCH8cmSYnxtedE=;
 b=D7lxzN8cxB5Bd3W+oTGqsiQmHzupg98G/pZRGYYUBlUwgVxUfgyGYZ4S
 nksCS3Qj6559+Qra9glKqKgB7j/H0KLMXaj6vNG1bQPS/NiLWdBqtKc/i
 k6m4GtYGSOPgVR0bVM8unvISorQFb8KV5LrfQjotGlrjilDeORpvDXMaJ
 YDtOJ0aKs1xKJJ1eBH3vyqdOKYZWa1aNcy1izy1J0REA5ZCak8qSfucNF
 Bu2/BipfRz6F7vBVC8QuJ6SApAYPTss4WslFDnF46+olguBQgZtXZ4J0D
 WQnWsLE5XpAdmkqvLh9F8EkxGCtLVW+Y9W4FPsv6MlK/uHXMp+MojVi5A g==;
X-CSE-ConnectionGUID: US5vRjLuQG2Qte5gk6E+AA==
X-CSE-MsgGUID: goQskQYYSi2nkuW6a8Qp3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46862390"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="46862390"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 08:13:58 -0700
X-CSE-ConnectionGUID: DtSyRNrSQXisMdzPRaLvTQ==
X-CSE-MsgGUID: ACKkrOv0RtyU64ls1gCrQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; d="scan'208";a="169860765"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 24 Apr 2025 08:13:54 -0700
Date: Thu, 24 Apr 2025 23:34:49 +0800
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
Subject: Re: [PATCH 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <aApaGdY/kawZIp8N@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-2-zhao1.liu@intel.com>
 <87tt6d4usx.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt6d4usx.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> > diff --git a/qapi/kvm.json b/qapi/kvm.json
> > new file mode 100644
> > index 000000000000..1861d86a9726
> > --- /dev/null
> > +++ b/qapi/kvm.json
> > @@ -0,0 +1,84 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +#
> > +# Copyright (C) 2025 Intel Corporation.
> > +#
> > +# Author: Zhao Liu <zhao1.liu@intel.com>
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +##
> > +# == KVM
> > +##
> 
> There's KVM-specific stuff elsewhere in the schema.  Some if of it
> should probably be moved here.  Can you have a look?  This is not a
> demand; it's fine if you can't.  If you can: separate patch preceding
> this one to create kvm.json and move stuff there.

Sure! That's what I should have done, and I'll be back to follow up on
this discussion when I get something new.

> > +
> > +##
> > +# === PMU stuff (KVM related)
> 
> The KVM subsection contains just this subsubsection.  Awkward.  Can we
> do without this subsubsection now?  We can always add it later, when we
> have enough KVM stuff to warrant structuring it into subsubsections.

Thanks! I agree. As I commit to do above, if I find others about KVM,
we can add this subsection you suggested below :-).

> If we decide we want it:
> 
>    # === KVM performance monitor unit (PMU)

Good name.

> > +##
> > +
> > +##
> > +# @KvmPmuFilterAction:
> > +#
> > +# Actions that KVM PMU filter supports.
> > +#
> > +# @deny: disable the PMU event/counter in KVM PMU filter.
> > +#
> > +# @allow: enable the PMU event/counter in KVM PMU filter.
> > +#
> > +# Since 10.1
> > +##
> > +{ 'enum': 'KvmPmuFilterAction',
> > +  'data': ['allow', 'deny'] }
> > +
> > +##
> > +# @KvmPmuEventFormat:
> 
> Maybe KvmPmuFilterEventFormat?  Or is that too long?

For another 2 formats: 'x86-select-umask' and 'x86-masked-entry', their
enum value names already have 7 words:

 - KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK
 - KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY

With "Filter" in name,

 - KVM_PMU_FILTER_EVENT_FORMAT_X86_SELECT_UMASK
 - KVM_PMU_FILTER_EVENT_FORMAT_X86_MASKED_ENTRY

Look still okay. I'll rename it.

> > +#
> > +# Encoding formats of PMU event that QEMU/KVM supports.
> > +#
> > +# @raw: the encoded event code that KVM can directly consume.
> 
> Suggest
> 
>    # @raw: raw KVM PMU event code.

Concise. I agree.

> > +#
> > +# Since 10.1
> > +##
> > +{ 'enum': 'KvmPmuEventFormat',
> > +  'data': ['raw'] }
> > +
> > +##
> > +# @KvmPmuRawEvent:
> 
> Maybe KvmPmuFilterEventRaw?  Or is that too long?

KvmPmuFilterEventRaw is fine (not too long).

> > +#
> > +# Raw PMU event code.
> > +#
> > +# @code: the raw value that has been encoded, and QEMU could deliver
> > +#     to KVM directly.
> 
> Suggest
> 
>    ##
>    # @KvmPmuRawEvent
>    #
>    # @code: raw KVM PMU event code, to be passed verbatim to KVM.

Thanks for polishing it up, it looks much better.

> > +#
> > +# Since 10.1
> > +##
> > +{ 'struct': 'KvmPmuRawEvent',
> > +  'data': { 'code': 'uint64' } }
> > +
> > +##
> > +# @KvmPmuFilterEvent:
> > +#
> > +# PMU event filtered by KVM.
> 
> Suggest
> 
>    # A KVM PMU event specification.

Sure.

> > +#
> > +# @format: PMU event format.
> > +#
> > +# Since 10.1
> > +##
> > +{ 'union': 'KvmPmuFilterEvent',
> > +  'base': { 'format': 'KvmPmuEventFormat' },
> > +  'discriminator': 'format',
> > +  'data': { 'raw': 'KvmPmuRawEvent' } }
> > +
> > +##
> > +# @KvmPmuFilterProperties:
> > +#
> > +# Properties of KVM PMU Filter.
> > +#
> > +# @action: action that KVM PMU filter will take for selected PMU events.
> > +#
> > +# @events: list of selected PMU events.
> 
> Here's my try:
> 
>    # Properties of kvm-pmu-filter objects.  A kvm-pmu-filter object
>    # restricts the guest's access to the PMU with either an allowlist or
>    # a denylist.
>    #
>    # @action: whether @events is an allowlist or a denylist.
>    #
>    # @events: list of KVM PMU event specifications.

Thank you very much! Your description is very accurate.

Regards,
Zhao


