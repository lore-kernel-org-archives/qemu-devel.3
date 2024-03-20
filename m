Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8D7CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 22:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn4Cp-0004e6-57; Wed, 20 Mar 2024 18:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rn4Cn-0004dc-RE
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:14:41 -0400
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2408::600]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rn4Cm-0002te-2E
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:14:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIYswS++TQT8wKiz1dcRtx0QYt+NKNZStqzDCYZTlpuMCmkD6trvpDMVts8BKNuyiuhSnfHaQiK/e3bZz3b5kNy8ldAFiAeWsdFeGIpYrKBuWnYcqxKpRAghQcdFvYtY2Aes5oaDvShRQz6cP5SDByvkQDBfBwNMxUeNAZJ3dkBGI/S1YScSlqDjNP67miwF1iWtLIhv/F5oEYmpKXXQz++U0DVWYS2Tih4/Ak0DVcsLtaiMRgJtd7mnyvI4CDsLnLS51vdkQzPAS2prSalLDQNUiWwyI4KMUpwpnQ1IJkX5XAPyjl19qk2oac0jWHSUC67a7mOJKMz87/U4oJkg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4nDCye8BmsaDu9v1gfNUR0YQsqnfqiNV+HHQmJvF9I=;
 b=EW/kbBGO39GEWkHOuzxM1wvpFahoa14mkeFTBPbINmrN3H/52/ywe2xhGSZ/NsRkpNRXD8l6Lh5pEJ6bE24sJnO9OijmT0h2uWWlBBgSzlGeId3ftj3iGUUAhLtWNxIVbp95PSdNtjM0FgqCWh1IuCwxZsBSvQtTksINYvxegXLhq8q0BxJrKJp5QD+QYRK+YBA7KB0OCQkwWEu9DHwUJby93rL9tlrXr64DQJsiWBMYxcpZKHq6ZnOBy4777qwi3Zfx/5Mn2a0uxHW8iMOldFBoTGNW2rhF7S0zLiQHWkV4IfVLFIfr0wPyjjnevDCY3UJHqbxwjSJUwx7wxJGPeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4nDCye8BmsaDu9v1gfNUR0YQsqnfqiNV+HHQmJvF9I=;
 b=CuhwcK3HjTNrMPPysDTr1hmnXz/t6Z9XLpc3/B6/i9HGmqmCNC0pWp6U18YRVOnpMyRBI/xpUuGac8I/lJoEOyidzctlytQUTjKla2Db6PFyeovzgrVMzelqkH7oaD2IDtFBAh0gzAtIcMXTusO6fU9aU0Iwuwlf7BkoPY04VNQ=
Received: from BL1PR13CA0266.namprd13.prod.outlook.com (2603:10b6:208:2ba::31)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 22:14:36 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::c6) by BL1PR13CA0266.outlook.office365.com
 (2603:10b6:208:2ba::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 22:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 22:14:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 17:14:34 -0500
Date: Wed, 20 Mar 2024 17:14:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Tom Lendacky
 <thomas.lendacky@amd.com>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 25/49] i386/sev: Skip RAMBlock notifiers for SNP
Message-ID: <20240320221410.fdfuzjpzzwaeqjaw@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-26-michael.roth@amd.com>
 <7727f1f2-2a30-45d2-85a9-db22ec5a9be5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7727f1f2-2a30-45d2-85a9-db22ec5a9be5@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 89783dbc-e6e8-4b2b-ee40-08dc492b2012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ehZAhFvygcbrllg+zqqYIBpgPoj5C82dufRHN7pyVm0NuEAq3GwnlJpumq5IvhL75uB7A13U6HTb6WufH9xuniNbYJmcnMFK/PjZpuVjgVzZFEkcdBRucntlyEnBUKnOqO/+qe3LJecDhDt69dzOWBB8Auyq/QMbpvT6wccU55TGtZmqnyXsZH3d+xxGUvIbZS/LOEgnyyQ4jaqcS1jlb7r7dNp7b89McVD8bNbMdl3BbCOZBsxYdhQ0L9cr6EZ6GW1zNA35IdejkIB1RwAaFz4bEvtytMoNy71kWnNJEwj6tHUqQJMLy51I06/uONoamzzooYduAgoWe6bAl2LzhTeCC2v39t1IjgvJA6ufg9lcsnUdHG1CTZUFGLDNGJsCntI2dTpnaWmlLUCWynyvL6jh109I7lRE4g38nvq2tE3vFXdv6XLEddp4b3Nv4ZmPq8Znkb47jgymSAcAgQGppnAmRIenINz2bp1kioxILYe2sAvMThYtUGPyYf1Ql4biNkDY/UqOF4SgrNxUbjEzkN5jgtjgRw6hXL3iK4vBwbWbEaqk/M/8NeXk848Sxx4vxHh1XUJNq1+G5gd2A+9Cy2r9e9bQ3TMhIYxwNhYLAoUA4ddb8XZNE7ULYHMC7oZflX9V06ZRg+e81oU4rmOk9dMYHDBxs26tXv9ioWqY99qpi/OFSaaVBP07P0jglJBHMYGAgLsbaiyWPBQb3zyEOSv5ftfCTWRTxy55FboDC1xCSjWIsF6WlHTGmhqvFs1Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 22:14:34.9831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89783dbc-e6e8-4b2b-ee40-08dc492b2012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
Received-SPF: permerror client-ip=2a01:111:f403:2408::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 10:46:29AM +0100, Paolo Bonzini wrote:
> On 3/20/24 09:39, Michael Roth wrote:
> > SEV uses these notifiers to register/pin pages prior to guest use, since
> > they could potentially be used for private memory where page migration
> > is not supported. But SNP only uses guest_memfd-provided pages for
> > private memory, which has its own kernel-internal mechanisms for
> > registering/pinning memory.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >   target/i386/sev.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 61af312a11..774262d834 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -982,7 +982,15 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> >           goto err;
> >       }
> > -    ram_block_notifier_add(&sev_ram_notifier);
> > +    if (!sev_snp_enabled()) {
> > +        /*
> > +         * SEV uses these notifiers to register/pin pages prior to guest use,
> > +         * but SNP relies on guest_memfd for private pages, which has it's
> > +         * own internal mechanisms for registering/pinning private memory.
> > +         */
> > +        ram_block_notifier_add(&sev_ram_notifier);
> > +    }
> > +
> >       qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
> >       qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
> 
> These three lines can be done in any order, so I suggest removing
> ram_block_notifier_add + qemu_add_machine_init_done_notifier from the
> sev-common implementation of kvm_init (let's call it sev_common_kvm_init);
> and add an override in sev-guest that calls them if sev_common_kvm_init()
> succeeds.
> 
> (treat this as a review for 25/26/29).

Makes sense. Will split out the common bits of sev_kvm_init() and use
class methods for initialization specific to sev-guest and
sev-snp-guest.

-Mike

> 
> Paolo
> 

