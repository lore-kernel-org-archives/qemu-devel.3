Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671A3C88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x56UB-0000rX-L0; Fri, 11 Sep 2026 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x56Tv-0000qp-0u
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:00:16 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x56Tr-0007Nx-61
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 15:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6o4rdKySVvj/gwHujam10Lh6WN8vfeNRzo8qhVzwwQdMFYlm/4dClbQ+ggjmruuzQH5eQ+3nnHKUdPEpRgjUkoo5y8tjPxq6mp/WnP/1wdkZ4l1MnA9cl/98fPtBwMkiHtcbKxngTqXVEzl+9dokFu8Kix9DR2398gk8VwhA0NK1lyDQT2uVHGYIL79Zjb+QONqxpoFDksW2u2GNdIzk6DPO63p944a49A4NSGeJfjyM1bScHBu6obS4fs39jETjZP2pRxtA4rmqVIN7Wwsh4/6CSZzHUQGfObcvR+boifyf9+7vjD/KgLtSbJ0OtuP7/BIEGCl7wg/g/oPyRwPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNKY9Y+tGOOu5KQJWPsbz+UlBJFQ1yGZORQfwA/Igc4=;
 b=lp1nM/QsB+vOR+dHcp2OAqrMoyrw5p0O4Y8yxCCncvob7gQB1cxaWsANnRptVdWjYIlzDR4BdZqug3PjOgmYMwnUAD+T6HfnPS89Le1q9i8Kgu9ArXjxAnPvnZ0SMsndltMJqdcq/uh3TP1QXjfJGyc9+f5qEt+3PhpEK8cKOWUFKbVF9EGCHDszvor1xTcGPnIRfmSMAQ6KAAwcv6lnooSuMtdAY4sXsmNRAZpFnqF0iWV0Vo9DX9KvJ81DyvxCZfw7f1SjlRWQwwuivyVJsWQWRqaOSBOeJGXratSJncoVTS6g58Nfkd64sUXWnBp07P4FNARBGJoV4zqIYiHusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNKY9Y+tGOOu5KQJWPsbz+UlBJFQ1yGZORQfwA/Igc4=;
 b=vYMJ+ejRRz0w6qy9yZ4ANDEPrtKmwCihMIEQXTE0LOZGIH1X8BMy1SIMn3Ojn3svUiR0pmCDQJUXlyA5ftd6be5MgvpH4dDLkud9nbhyS1InYg4pQ7Kql9WxtA7zNbjnN7he+Qu7HJvKolt2RpFSOrVUm8+iU9W4OyejnWk8D1k=
Received: from SJ0PR03CA0158.namprd03.prod.outlook.com (2603:10b6:a03:338::13)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 19:00:00 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::6e) by SJ0PR03CA0158.outlook.office365.com
 (2603:10b6:a03:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Fri,
 11 Sep 2026 18:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 18:59:59 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 13:59:58 -0500
Date: Fri, 11 Sep 2026 12:22:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <pbonzini@redhat.com>,
 <berrange@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 07/19] accel/kvm: Add CGS option to control in-place
 conversion support
Message-ID: <sudqwq5bnygtkqc2cio6rq5khrfi252jcs6jq6i3uzblgtvgq7@3upjx5k5bp7s>
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-8-michael.roth@amd.com>
 <878q5bosi3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878q5bosi3.fsf@pond.sub.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: c672ce8d-0cdf-47a6-a56a-08df1036e0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TCz/LvHlbyPU8+ozo9KTzCdMxK4nsgNlPyon2GC9cMYO562vt8QlM0Yp1NB7AGaq+ej/YGSahyWq4Lo5u8da2fASkqqR7fHPpv5+vJu7I84Xdig/IAS0ypMkn532uDALEsG38yxGSoemeSODljdaDzuRiSDtrFDkMxhF8+QHqfVfzuFex2YgTvBKVGBuCo2ViEZUKErsV3d3HnFQDLU41M4Q5UVb4BK1gOkrDLpEuwmLuvb9QZXetKPvmsDaWqaTUO1fLFJjKojx9tvBWGg6Yv0vyNBbFXvbN+eR+dLLE00HeVcQATEsZ9lG0bkr0HJb7KWTcBDZbWjPPfdDIV6vMt+YQEb0uJ5km9pjJZZqfmCjROwIf648MqS4dZ3+GmxyrNl0zNbKZl8NbUahgO4uUMVM0jBB1hLBxKb4dmWDsH87NvGMFBuPCJ+LxveHPEVz+PU+r8O2N/N/o+AO72WIhPdr5iKA93v6T29mCybk+nBlUUPmRc2SSneZp0iJZ744Mw5QKEKEOcb5FXMObog38vunPWphRT94R65oZHeYXvshdIPkj9jPpcbC1vXH2azTQwdKSHD7y67WtlnXK80K/oV8j+PcTESd1quVf9L8zRinN1go7tbmbddoaOflO5oKzS3xydmyuE+Je8RyGU/uI0G1gFv5EzY2s/H6KDvrZqL3Xp1RELGaQitrcEC5bJTYqPnFFOUGUZdIAcyFZOQXEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xmSKXmlX3rRxHmZncnTewPL6A+8jpu/HQsfA4Iy9lg1qmifL4Lifna1zPLWoW76jT0CzD07sSe0X/B2ZNIfit+L81M3Y+2aWTTb4tG5bDaKcdN5TisN/okXiiu7rL89WkP+QA0tFmu1i8HDmpQpZiz6IxS4KQVTg0C5N8oUS2LToSEqQm3fcBPM6zksu1esde4rDPHE4mJAhiXtKXMYuH+mIZaHSM8S+qPOoVPC0B0nYmFEDKmrqwJfLrev0EMhr9e807sxfRo2YQsLRj6nPwXbq6Me80OMpevdagvDZz/YoHD5sAsLzGHzO/y8u6DAXzsqts4xEFx2QM3+srl+r97m106NO0NlanRqRp9S/3HEGzYdn3ANACMDMypRGCz4MN0W8ULRFyl2e27OdBZI5waLmRnmbkuGdh9knQd7UhyLAV1ww/yuHos9x8xJBZJ6n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 18:59:59.1647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c672ce8d-0cdf-47a6-a56a-08df1036e0a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=Michael.Roth@amd.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 09, 2026 at 08:20:36AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > For confidential guests, guest_memfd is currently used only for private
> > guest memory, and normal guest memory comes from the configured memory
> > backend just as it does for a non-confidential guest. It is now possible
> > to use the same physical memory to back a particular GPA regardless of
> > whether it is in a shared or private state. This avoids the need to
> > rely on discarding memory between shared/private conversions (to avoid
> > doubled memory usage), and is intended to be the primary mode of using
> > guest_memfd for confidential guests moving forward, and future features
> > like hugepage support will likely require it.
> >
> > Add an option to enable this support. Since ConfidentialGuestSupport is
> > already used to track some guest_memfd-related functionality (e.g.
> > whether it is required for the configured machine), similarly introduce
> > this option as a property of ConfidentialGuestSupport.
> >
> > Also add the KVM-specific checks to enable this support, but leave the
> > option disabled until other required changes are implemented for
> > CGS variants that intend to make use of KVM's in-place conversion
> > support.
> >
> > While technically the convert-in-place option could be introduced as an
> > SEV-specific option, it is a given that TDX will also be introducing
> > in-place conversion support based on the same guest_memfd kernel
> > infrastructure, so introduce it via a new
> > ConfidentialGuestSupportProperties base class that other confidential VM
> > implementations can utilized for common options.
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> [...]
> 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 909add4299..20d6fefb04 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1005,6 +1005,21 @@
> >    'if': 'CONFIG_IGVM',
> >    'data': { 'file': 'str' } }
> >  
> > +##
> > +# @ConfidentialGuestSupportProperties:
> > +#
> > +# Properties for ConfidentialGuestSupport base class.
> > +#
> > +# @convert-in-place: If true, the same physical pages are reused
> > +#     when memory is converted between shared and private states.
> > +#     If false (default), separate allocations are used depending
> > +#     on whether the page is private or shared.
> 
> Any guidance on when to enable @convert-in-place?

A lot of it boils down to more Confidential Compute architectures
now requiring it for new features (hugepage support and SEV-TIO will
require it for instance). convert-in-place=true maps more closely to
a normal VM, and not having more complicated memory management
requirements avoids additional complications up the stack (like
accounting for instances where memory usage might balloon passed
expected resource limits due to needing to management multiple
memory allocations for a given GPA range).

convert-in-place=false will likely become a legacy path unless other
use-case arise, but they'd probably need to be super-duper useful
to warrant enabling new things on top of it going forward.

I'll try to work something along that line into the guest-memfd.rst
I proposed for Peter's series and add/reference that as part of this
patch.

> 
> > +#
> > +# Since: 11.2
> > +##
> > +{ 'struct': 'ConfidentialGuestSupportProperties',
> > +  'data': { '*convert-in-place': 'bool' } }
> > +
> >  ##
> >  # @SevCommonProperties:
> >  #
> > @@ -1033,6 +1048,7 @@
> >  # Since: 9.1
> >  ##
> >  { 'struct': 'SevCommonProperties',
> > +  'base': 'ConfidentialGuestSupportProperties',
> >    'data': { '*sev-device': 'str',
> >              '*cbitpos': 'uint32',
> >              'reduced-phys-bits': 'uint32',
> 
> Can you explain why you put @convert-in-place into a new base type
> instead of right here?
> 

I tried to touch on this as part of the commit message, but I don't think I
explained the rationale very well and I'm now second-guessing myself.

As part of this patch, a 'allow_convert_in_place' field is added to
ConfidentialGuestSupport, which is similar to the 'require_guest_memfd'
ConfidentialGuestSupport member in that it's configuring policy around the
usage of guest_memfd for Confidential machine instances. They also both
need to be ordered soon enough that they initialized in time for the related
KVM capability checks in kvm_init(), so another reason to place it there.

From there my thinking was that the 'convert-in-place' property exposed on the
command-line would basically just set true/false based on whether the
'allow_convert_in_place' CGS value is set, and that that pattern would be the
same for TDX, who AFAIK are fully onboard with switching over to
convert-in-place=true as well, so I added the common base properties where other
archs could just subclass it expose the same feature.

But thinking more on some discoverability thing Daniel mentioned, that makes it
potentially problematic if more common features get added, and *then* another
CGS implementation wants to subclass the common QOM properties for 1
option/feature (e.g. @convert_in_place) but not some other option/features
that's since been added.

So keeping it as an architecture-defined property is probably the better call.
It's only a trivial amount of code duplication and some archs will just have it
always on anyway where it doesn't even make sense to expose it.

So I'll plan to take that approach for the next spin.

Thanks,

Mike

