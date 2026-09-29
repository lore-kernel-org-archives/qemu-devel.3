Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7729CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBheX-0006HB-Fr; Tue, 29 Sep 2026 19:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBheV-0006Gl-1e
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:54:27 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBheS-0007jn-PI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D02sCsJX0WHVIuPoYTYs21+1gGnpVH//oK0+WeymCsPzGyOFB4kWVzRdn5TBvRWoVWrMVlB9oEaao/VB4i4a7eUh93nJCvL5Jj5xAWxwDZTiWe1JJQckCEoePOcPZtJNeZq3lkgVYLYpRRHYk5aAHYuR2jJswWtMMme97zSVBFqd91FpmjMrAajO6SNJd8SJj0mBIktPaoXyrnbXmZbXdH3ZMgNdAB9VoOJygLp4j9OQOMi6ysqkM8dkrssM5Bg8Y8MCdavJAG979yXL+aqHv5Ydbp7d4Yr24vg0rj6VTMcx3Uu9/Cmy3WJiiil/XikucmON61ogkA/vfsF1O2uDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A8m9yWD0AABiRINqVstfpvp8WtKr3gfBToBDBt8iSQ=;
 b=tDA1iSzKXp6RGIasTvBBsd4lEgQzb7MEOpRmRZnb4zfrpmQG/CFAhofQpWLGlK6pw6bNHwMRL1IpIjaBKaOf2bqrTRGea7abOOZYzqZzkYFeLDc7PGFxErB7zArBLDjiqtLuLRvj7MsY/APjyF/ABu3MtzixjLCLV5t2t1xhSMTzcqfzLl5lQEG1iCdP8VtsObMGdT73bCg+WycQH11UAUK+BrG+3KWTOZYKazMGTEZczbn8P2sSjvHvLjykjyLlmtdhL499y7XrFHdWXbL3He0Ud5TyWAbd3xWbJckx1YaWJUDKT/N2VSDCxLo33r0qEXilYHjjBd7894ryY4afvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A8m9yWD0AABiRINqVstfpvp8WtKr3gfBToBDBt8iSQ=;
 b=VBC5CCsXdTwiBrfyLxBVrU7FsA/SM+6G0tJEtKe9QV1bXn0REb8xaJRft3PmBxwwf64pEltn2f5JkBluE4ExnsKHUwa//hXpnZWNsqsAW+QxDv/p2gvCU0pkHdxVblUEcM9ANU7i6pKDggNTFjuJQ3yY/4PV29t7s9SmFKeqzIM=
Received: from BN9PR03CA0937.namprd03.prod.outlook.com (2603:10b6:408:108::12)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 23:54:16 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::6a) by BN9PR03CA0937.outlook.office365.com
 (2603:10b6:408:108::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 23:54:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:54:13 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:54:10 -0500
Date: Tue, 29 Sep 2026 18:48:40 -0500
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <david@kernel.org>, <pbonzini@redhat.com>,
 <peterx@redhat.com>, <xiaoyao.li@intel.com>, <berrange@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v6 10/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <buuswjj6cz2svakgxfyvo7d4f2goaqpb7elajrq3ocvepatopr@qmdpnm7bzbrp>
References: <20260925015700.1260501-1-michael.roth@amd.com>
 <20260925015700.1260501-11-michael.roth@amd.com>
 <87fqytkj41.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87fqytkj41.fsf@pond.sub.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa00286-9997-495a-f4ed-08df1e84f68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|22082099003|4143699003|10067099003|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: ayL8etQxVnSBXWb0+jH/s8eCB5hzYdlzQkO3cWejeSWh63K0WKnTAgucWdpPM4MmNJoX3fbTwQL58PwCwVLVU3BrQZumi5QqKGILJ2lPjm1rXYtscYs/aEUPCXVszmy5K4FsgJEV4ARMZHYxmMZkrfLu9tchRp1HS9IRz+1rxzEDkY18tL8nOCeJRIGPo0Sk4B2ZqvfDWkJsQ8MB2jhbEHmheBpJTaqVyy0ADHv2cb/RbLQA2itBfMcSEoVPcmJYnq4CDD11yp4feRuif/oPKqnq1OnNwaQbg5F+I1cbeAtObuXerSzek47falREtqvpN8xZRk7QggKMIZarMuznUlB5npIscMpTPUQUCzUAITgkbJNIjKkjcBUnxDSvMaOJilsg25Z2cdBiezTgkfmcK/58+RDocrF0mSB9uupqN18sSa4KkvdENSUWxni1YA911uuq7VkSYDCUPK/1+ExB3I7HxqJV6223nrogPyQT/8ns++G395z2k+7zy2qdvdYqbKwdDEE46Oo2XV+WB7N6eHMRSa0HtIZvA2arMc7ZPcGcTx8GY/EncjznQzwjC8dBq+YhRoF9n5vYjyaus+6FFMhTZ//dw/fqOrOO81QFGTr0bwMqiPClnrOVyufmC13bzgSEsGbRqSAwo5WYnUPF5F7U7CHpOzkB+aw39kss/9lCWm7By+w8vG+SToLH9xJ86wDYn1oFw4q/55sBx2RsMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IfcIFAqMdzmfaSG2lz33mN1JaEums1s0pqK1LE30aeTc/6lvDoXvL1KU3tka1g69oIoESs2FGxeWoIrFC8SoSfv8AsWqcYh78Gtta3RnLNh3MgtFLtFTiWP8rvSJzE6PAm05l5ha6NQdbL0lRC/3aN3BikbcE3WU5Ofo8HSkx6VoRJCk8EWLG7RSS5BVLLrNAdKqkpcv3k/2bzvaPeAH2DNhHrZgaRQe+qjzADcxjz9gWx29HHlH2/Rfx/IlFKOTQju5/WE9UfPTjPZIqauYn6IDlnW4oXSXwtoTVGA4dANCuoN+lhvjY9NkDZloJZphLa2+dq++/ZW6HlXlZ62wiBCprbyUzcM4/ulql2RKootRpbZZSTN5Hhe7cCxscjg/IW/6Onfsi/uTFZO/ZKMiC+yY7rYGOpYGKK59V7iJjJ3sfenYG1QBbB1u0dJk507W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:54:13.0541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa00286-9997-495a-f4ed-08df1e84f68e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Michael.Roth@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Mon, Sep 28, 2026 at 08:03:42AM +0200, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > Host backends supports guest-memfd now by detecting whether it's a
> > confidential VM.  There's no way to choose it yet from the memory level to
> > use it fully shared.  If we use guest-memfd, it so far always implies we
> > need two layers of memory backends, while the guest-memfd only provides the
> > private set of pages.
> >
> > This patch introduces a way so that QEMU can consume guest memfd as the
> > only source of memory to back the object (aka, fully shared).
> >
> > To use the fully shared guest-memfd, one can add a memfd object with:
> >
> >   -object memory-backend-memfd,x-guest-memfd=on,share=on
> >
> > Note that share=on is required with fully shared guest_memfd.
> >
> > Since guest-memfd is not yet a drop-in replacement for memfd (e.g. lack
> > of hugepage support), the option is tagged as experimental for now so
> > that it can be made available for early enablement/testing without
> > causing any surprises for other users.
> >
> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > guest-memfd may return negative but not -1.
> >
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: David Hildenbrand <david@kernel.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > [mdr: add accompanying guest-memfd doc, mark as experimental]
> > Co-developed-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> 
> [...]
> 
> > diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
> > new file mode 100644
> > index 0000000000..f7cef19283
> > --- /dev/null
> > +++ b/docs/system/guest-memfd.rst
> > @@ -0,0 +1,60 @@
> > +.. _guest-memfd:
> > +
> > +guest-memfd support
> > +===================
> > +
> > +Recent kernels allow for the creation of a guest-memfd file
> > +descriptor, which can be used to back VMs in a similar manner as a
> > +memfd file descriptor, but is intended specifically for this purpose
> > +and allows for closer coordination between KVM and the management of
> > +this memory to enable more advanced/VM-specific use-cases.
> > +
> > +Initially this additional functionality centered around providing a
> > +common/centralized place for managing kernel-side memory handing
> > +requirements for various Confidential Guest architectures. (For more
> > +on Confidential Guests, see :ref:`confidential-guest-support`).
> > +
> > +guest_memfd has since evolved to become a more general-purpose way to
> > +allocate/manage guest memory and potentially allow for things like
> > +providing additional memory isolation within the kernel[1] and support
> > +for persisting a guest's state across kexec to allow for live-updating
> > +the host kernel with minimal guest downtime[2].
> > +
> > +Usage
> > +-----
> > +
> > +For Confidential Guests, guest-memfd is currently utilized internally
> > +by QEMU to handle private guest memory, independently of whatever
> > +memory backend the user has configured for normal/non-private/shared
> > +guest memory. To avoid doubling memory, QEMU discards memory in
> > +response to the guest converting GPA ranges between shared/private.
> > +(e.g. if GPA X is converted from private to shared, the guest-memfd FD
> > +offset corresponding to GPA x will be truncated since the memory will
> > +be provided by the memory backend the user configured for shared
> > +memory, and vice-versa). This is handled automatically/internally for
> > +Confidential Guests that rely on this handling and is not directly
> > +exposed by QEMU command-line options.
> > +
> > +For non-Confidential guests, guest-memfd can be used in a manner that
> > +is somewhat interchangeable with a normal memfd. Currently, this is
> > +handled by using the same memory-backend implementation as memfd, but
> > +with an additional 'x-guest-memfd=on' option. E.g.::
> > +
> > +    qemu ... \
> > +      -object memory-backend-memfd,id=ID,size=SIZE,share=on,x-guest-memfd=on
> > +
> > +Note that the share=on option is required for guest-memfd, since it
> > +does not support anonymous memory allocations or COW-like semantics.
> > +
> > +Also note that there are a couple of limitations in using guest_memfd
> > +in this way compared to a normal memfd, which is why the option is
> > +exposed as an experimental for the time being:
> > +
> > + * guest_memfd does not currently support the hugetlb=on option
> > + * guest_memfd does not currently support Transparent Huge Pages
> > +
> > +References
> > +----------
> > +
> > +- `[1] directmap removal <https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/>`__
> > +- `[2] LUO <https://lore.kernel.org/kvm/20260728121138.1103610-1-tarunsahu@google.com/>`__
> 
> This is helpful, thanks.
> 
> > diff --git a/docs/system/index.rst b/docs/system/index.rst
> > index 4509630fa4..060850a739 100644
> > --- a/docs/system/index.rst
> > +++ b/docs/system/index.rst
> > @@ -44,3 +44,4 @@ or Hypervisor.Framework.
> >     vm-templating
> >     sriov
> >     qemu-colo
> > +   guest-memfd
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 5895c97750..602b17ad83 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -780,13 +780,18 @@
> >  # @seal: if true, create a sealed-file, which will block further
> >  #     resizing of the memory (default: true)
> >  #
> > +# @x-guest-memfd: if 'on', use guest-memfd to back the memory region.
> > +#     See the "guest-memfd" QEMU documentation for more details.
> 
> Can you make this a link?  Try :doc:`/system/guest-memfd`.

That works, thanks.

> 
> > +#     (default: auto, since: 11.2)
> 
> What does 'auto' mean?

I've added some documentation for this in v7.

> 
> > +#
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'MemoryBackendMemfdProperties',
> >    'base': 'MemoryBackendProperties',
> >    'data': { '*hugetlb': 'bool',
> >              '*hugetlbsize': 'size',
> > -            '*seal': 'bool' },
> > +            '*seal': 'bool',
> > +            '*x-guest-memfd': 'OnOffAuto' },
> 
> You forgot to mark the member unstable.  Use
>  
>                { 'name': 'x-guest-memfd', 'features': [ 'unstable' ] }
> 
> This will make the generator demand documentation.  Add this
> 
>    # Features:
>    #
>    # @unstable: Member @x-guest-memfd is experimental.
> 
> between the member descriptions and "Since:".
> 
> The 'x-' name prefix is fine, but not required; the feature is the sole
> source of truth.  The prefix can serve as an additional signal to human
> users.  Drawback: you have to rename when the member becomes stable.  Up
> to you.

Thanks, I'd somehow missed that 'unstable' features deprecated the old school
"x-" stuff. Hopefully I got it right in v7 :) Based on Peter's recommendation
I went with 'guest-memfd'.

Thanks,

Mike

> 
> >    'if': 'CONFIG_LINUX' }
> >  
> >  ##
> 

