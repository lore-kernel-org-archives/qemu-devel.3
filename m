Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D13FE7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Ys-00031j-8r; Wed, 18 Dec 2024 17:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tO2Yj-000307-Fr
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:25 -0500
Received: from mail-dm6nam11on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2415::624]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tO2Yg-0001t3-Py
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOPGfQDg81wUOM6pPJxswEvgUhhqauCoP84Fp/VkYh3idQYI2YySAtNYbdr3heZUVkpZeis6cYnfD0TrzvBJ6W7I6mq7VKfAcnFbwUrzEQUMQTR2EhSI4A49FzpV5UCWYYRUQvkdOQA/qJI+j9meC6fN35coDfHElPyRQc/0BfL00nRt6drnWjpqIPbUhtTBMK7UV2YSs4BMUKf28FoZuMjGhaFEQ6EmUcBfFrix74YZNmy40EhynUPUz42iaI49muQ6XZnImRXDIvrzOiWmP8QIQoYeSqUfTPtnCMWBXuX9WjP4I239aqLkp0NbAtQQgqnzdcRNAh+aToDpNnAqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzRUx43/pQzb0PPL+y+7BOy/p7SkCX4E5bvR8i4vk9o=;
 b=Qy0vqelDyiGFDgFSWB/b59QdVCueiByar86qfna7sC6WXUb5GP6LvRgLE/eiz8xIzD+awrJWT9Z4/qdRu6Sf8wNDuzF6mXbeIG+jX26lHwllnVjXJb4PfqnlAZDRd3w41lQ14UUUOrO2GQOCp3YDGkHvOlPccE+z8TxPy86WOcN0Sjodw/Go2q8zkbATNr0uDpNPhZ4EENhgPqdmHTby2I6IJJMlz/LEr5uDFAQd+DPGjOklCx0XBRjfyjArq4F0KgPuTYfR0JocPpESKfI6h0GNNvpDIr4UwBUu0gjSqgPgSnYWmEs2C4sjzZ/fiuYbeREitgpcgvqLxtj15mHCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzRUx43/pQzb0PPL+y+7BOy/p7SkCX4E5bvR8i4vk9o=;
 b=fplIfvm9pgOnxRFCVhb9zZNHuaC9BeVvOabLMs4PMRHLTJeJhdQF6OoEz4PcVQZVLcq9mQzPOjSNWoHicnwiAsb/3P5tF8vXI3flIBKW98nueeU0rZt+58NHV76GfPC/5TsezKcroz3ecmSeZvl8sX3MqZhF7728JGQ6Ygv5gcQ=
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 22:30:09 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::bd) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 22:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 22:30:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 16:30:06 -0600
Date: Wed, 18 Dec 2024 16:14:44 -0600
From: Michael Roth <michael.roth@amd.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <eduardo@habkost.net>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Message-ID: <20241218221444.guswafcjvsbyiuoa@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
 <878qscrj6y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <878qscrj6y.fsf@pond.sub.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b48512-dad2-4e7d-14be-08dd1fb3876a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zq4FpWvxKRK5ecp49tpeyHt5ROsdTj2sm0QB+L4XzXe6wvjJ9ZzbzaZMhD2E?=
 =?us-ascii?Q?jVkjoIj4J2FB2s2voZyC1ONugzTASm9I/ucT/vua8LqJljKnaAHeCuKiBxy/?=
 =?us-ascii?Q?l0LD46JI+ezemuwNfWKtv73ppXPY8IoTQVqsD+iSW2dkwKs8q6a8nbLXBgZ3?=
 =?us-ascii?Q?wHb7LkudD4K3WFcGm145E5Jl9hSN7PVQEwKExH5wLV2MTysH7FXvgu+Lzywv?=
 =?us-ascii?Q?3848kkOg1rYl/sR/RYqV/Wap/29nYYZZeKcpilRpO13lbcplwZjXwPVdFC27?=
 =?us-ascii?Q?c84r0I1/pwb6Smvvm57l6JT60pD8nofdVKGhhfcAXXBqGnmDGMwYRdso1yHW?=
 =?us-ascii?Q?ajcdW6vrxXV8tbJcGAEv5pSslxMaP7dsWKIse4A1mx8RAycBv4/JEu9v+QPS?=
 =?us-ascii?Q?jqZ/KWKCvHrzZcySoMdQ59J2DmduR0sLvET8KwpjYeqKbfSbe21lItLVbp12?=
 =?us-ascii?Q?leEvhRz3gyI09GA/nlYi94w21/VbPAhgwQewLtfyxLBQvePt8EILPCn/iD6L?=
 =?us-ascii?Q?IYBF+/S1d9bcGaEte0un3OIgZA0vVwu7mdGIhvkL850BXlSNoWpy+ZZsEH11?=
 =?us-ascii?Q?/rkartHI/MpETuUZjuc2w7tflnylzTOBoUMbun82NmHyeo1SL5+8msNYU3hw?=
 =?us-ascii?Q?kjc/ZnY1XzivzEeydwXD4EnRh4jGnXy6qNVdjT1dhe1udRpvrynnPyZoPVvg?=
 =?us-ascii?Q?H8JHJdkJQHrJ5nc1w1zaLygqn2/yy5Z11Q+kfJ4tNVO2LD6Q9veIsHwwvp14?=
 =?us-ascii?Q?ehSyAqZ4UwhEMMYb+E229brF2G6Lb4hp4kbNXc8s4qqvVvvO90cHMYdKUaeJ?=
 =?us-ascii?Q?oVFkQk4ak8eVgrQ/qJs6HQmDaRTFhuSQjxzga99WFc1BQPVO5hoXrrl4O4CW?=
 =?us-ascii?Q?EztK2M77c3CQbOshw8wC4PTkjsZ4TYFRVOtXh/Ozgu5DGjmOKrjQSqfFLJLL?=
 =?us-ascii?Q?v5/xdVoF6++ewo7d92hubm3Ddb7vWyqn0b/2r+76uA918hGaLuIt4bwsVqOj?=
 =?us-ascii?Q?0MO/q7207HzLQ3AqUX4kPvaTVMDv+QzexKlPYk4qpmb+flQUj6IT0rtrToTw?=
 =?us-ascii?Q?B6iQyXROu80tIhZUouLPleCQbJTk17JqvltbReynp3YeIwan2xjxqI9SD76b?=
 =?us-ascii?Q?WawHywck989TGkf7YPN31NsqSMGdsPlciRsfJngpQvH/hb6XDkuYmTDyEwqA?=
 =?us-ascii?Q?OCj/LCXIpjH7Ud91/tJyqyeAE9LSBJ7Z2Ez2SlUXa5jmL8Me8O51+m0+1nFD?=
 =?us-ascii?Q?FxsUp6bB4/PXcXhCcQQeFiMBQJXUGAdun3RKwse7y74SOu7HFoqr+XOgmk3g?=
 =?us-ascii?Q?xvnPl88xqI7i9zvChEAIjXJvry+YYQgWF6N9c3E9pu+/Y/CpBoT3KLcDnXJf?=
 =?us-ascii?Q?V2dDO1lObvsCbBEN3nPDAoJM+ARmYetdAi/pyJikeTbWit33kZf/gz/qXKVO?=
 =?us-ascii?Q?2qJPqNkFjIYazzPcvsF4Bwl2MJMzU2K8yClZYE9uprNyXMD3l90hMPaKIdTg?=
 =?us-ascii?Q?KjfNMWVfVvL8J0g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 22:30:08.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b48512-dad2-4e7d-14be-08dd1fb3876a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
Received-SPF: permerror client-ip=2a01:111:f403:2415::624;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 18, 2024 at 06:32:05PM +0100, Markus Armbruster wrote:
> Michael Roth <michael.roth@amd.com> writes:
> 
> > The GHCB specification[1] defines a VMGEXIT-based Guest Request
> > hypercall to allow an SNP guest to issue encrypted requests directly to
> > SNP firmware to do things like query the attestation report for the
> > guest. These are generally handled purely in the kernel.
> >
> > In some some cases, it's useful for the host to be able to additionally
> > supply the certificate chain for the signing key that SNP firmware uses
> > to sign these attestation reports. To allow for this, the GHCB
> > specification defines an Extended Guest Request where this certificate
> > data can be provided in a special format described in the GHCB spec.
> > This certificate data may be global or guest-specific depending on how
> > the guest was configured. Rather than providing interfaces to manage
> > these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> > to request the certificate contents from userspace. Implement support
> > for that here.
> >
> > To synchronize delivery of the certificates to the guest in a way where
> > they will not be rendered invalid by updates to SNP firmware or
> > attestation singing/endorsement keys by management tools outside the
> > purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> > obtain a shared/read lock on the certificate file prior to delivering
> > them back to KVM. Only after this will the attestation report be
> > retrieved from firmware and bundled with the certificate data, so QEMU
> > must continue to hold the file lock until KVM confirms that the
> > attestation report has been retrieved/bundled. This confirmation is done
> > by way of the kvm_immediate_exit callback infrastructure that was
> > introduced in a previous patch.
> 
> The "management tools outside the purview of QEMU" will all obtain the
> same kind of file lock?

Yes, this is meant for a cooperative environment where the cloud provider
has opted to provide guest certificates in this manner and needs a way
to synchronize guest attestation requests with other parts of their
stack handling management duties like updating firmware/endorsement
keys/etc. which might occur between the time a certificate is fetched
and the time the attestation report is generated by firmware.

The idea is to provide a path of least resistance using a common
framework like filesystem locks, then heavily suggest that approach on
the kernel documentation side, so that tools purposely or naturally opt
to use this mechanism rather than every service provider coming up with
some separate thing that they'll need to work into some custom QEMU/VMM
to solve the same problem.

Of course, userspace is free to implement their own completely separate
mechanism for handling all this and completely ignore file-locking. But
QEMU is only trying to play nice with this above-mentioned reference
implementation and cooperative management tools, and not trying to
profess to provide any sort of synchronization for cases where those
sorts of management-level updates are performed without utilizing this
reference implementation for synchronization.

I should have touched on this in the schema documentation. I'll make
sure to add that in the next spin.

> 
> > [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
> >     https://www.amd.com/en/developer/sev.html
> >
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  qapi/qom.json                 |  23 +++-
> >  target/i386/kvm/kvm.c         |  10 ++
> >  target/i386/sev-sysemu-stub.c |   5 +
> >  target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
> >  target/i386/sev.h             |   2 +
> >  5 files changed, 288 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 28ce24cd8d..6eaf0e7721 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1034,6 +1034,25 @@
> >  #     firmware.  Set this to true to disable the use of VCEK.
> >  #     (default: false) (since: 9.1)
> >  #
> > +# @certs-path: Path to certificate data that can be passed to guests via
> > +#              SNP Extended Guest Requests. File should be in the format
> > +#              described in the GHCB specification. (default: none)
> > +#              (since: 10.0)
> 
> I prefer "filename" to "path".  We have many kinds of paths: pathnames
> (denoting files), QOM paths (denoting objects), qdev paths, search
> paths, ...  With "filename", your readers immediately know what you're
> talking about.
> 
> SevGuestProperties has a member 'dh-cert-file'.  Whether that's related
> to your file I can't tell from its documentation.
> 
> > +#
> > +# @certs-timeout: Max time in milliseconds to wait to obtain a read lock
> 
> Please don't abbreviate "Maximum" here.
> 
> Confident millisecond granularity will suffice forever?

I believe so.

There will likely be some form of rate-limiting added to KVM along the lines
of this patch, with proposals on the order of 2 requests per second for guest
requests to avoid DoS'ing each other:

  https://lore.kernel.org/all/20230119213426.379312-1-dionnaglaze@google.com/

I believe guest kernels already voluntarily limit themselves to
something similar before retrying requests.

So the only case I can think of where a sub-1ms interval would be
desired would be cases where the guest has very aggressive soft-lockup
detection settings, in which case we might as well just set the timeout
to 0 and not busy-wait at all, which should be allowed for here.
(There's more documentation in the related handling in
target/i386/sev.c, but in such cases the guest will get an EAGAIN and
generally retry the request later).

> 
> > +#                 on the certificate file specified by @certs-path. This
> > +#                 is not a cumulative value and only affects how long
> > +#                 QEMU waits before returning execution to the vCPU and
> > +#                 informing the guest of the timeout, so the guest can
> > +#                 still continuing retrying for as long as it likes
> > +#                 (which will be about 60 seconds for linux guests at
> > +#                 the time of this writing). If the guest-side timeout
> > +#                 is insufficient, set this higher to allow more time to
> > +#                 fetch the certificate. If the guest-side timeout is
> > +#                 sufficient, set this lower to reduce the likelihood of
> > +#                 soft lockups in the guest.
> > +#                 (default: 100) (since: 10.0)
> > +#
> >  # Since: 9.1
> >  ##
> 
> Please format like
> 
>    # @certs-path: Path to certificate data that can be passed to guests
>    #     via SNP Extended Guest Requests.  File should be in the format
>    #     described in the GHCB specification.
>    #     (default: none) (since: 10.0)
>    #
>    # @certs-timeout: Max time in milliseconds to wait to obtain a read
>    #     lock on the certificate file specified by @certs-path.  This is
>    #     not a cumulative value and only affects how long QEMU waits
>    #     before returning execution to the vCPU and informing the guest
>    #     of the timeout, so the guest can still continuing retrying for
>    #     as long as it likes (which will be about 60 seconds for linux
>    #     guests at the time of this writing).  If the guest-side timeout
>    #     is insufficient, set this higher to allow more time to fetch the
>    #     certificate.  If the guest-side timeout is sufficient, set this
>    #     lower to reduce the likelihood of soft lockups in the guest.
>    #     (default: 100) (since: 10.0)
> 
> to blend in with commit a937b6aa739 (qapi: Reformat doc comments to
> conform to current conventions).

Will do!

-Mike

> 
> >  { 'struct': 'SevSnpGuestProperties',
> > @@ -1045,7 +1064,9 @@
> >              '*id-auth': 'str',
> >              '*author-key-enabled': 'bool',
> >              '*host-data': 'str',
> > -            '*vcek-disabled': 'bool' } }
> > +            '*vcek-disabled': 'bool',
> > +            '*certs-path': 'str',
> > +            '*certs-timeout': 'uint32' } }
> >  
> >  ##
> >  # @ThreadContextProperties:
> 
> [...]
> 

