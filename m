Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A7AC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnOzz-0005o1-U4; Thu, 21 Mar 2024 16:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rnOzy-0005ns-K1
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:26:50 -0400
Received: from mail-sn1nam02on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::62e]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rnOzv-0000Fw-GK
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 16:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSEc60a2wSEZjPgoQMZzo5It8u5+gX96PI5a1BrmqTi9zbAG9zfAt5BA+aR4LolrwgnAWbk2KwQjmGvyqyvf2W50n2+mB/d/TLvCU0S38KJzYLMjwPhjD3hWhx7CILCznzsZnuo8AOo+5srfnTZSZKfRq4+kjjilZz31rO5/E49Rflgt5CFNT1pofg7+KqwYt25NSpHAYbV6EpcIQ+1T53fzWMY2xyNgCYcqShqq+ylpWr19jkVlVSwUT/vJPa1p8OqOJXdfJLPngg6CYU1EebapDghS+4+vKaMBVFvUZBNOIJcNpSth+/TfBCwzS+IP/lWBFHklUP/HACuPgsDSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Rqk07KNoqw0cqixffWZBlIRt0nRcrCu0I3UuzlLo8=;
 b=FIc5Qyd7mTtGuvslZTAG2XDxhW783IKznW/IV5NokKaJ6ELKQQ3lsV4eRyUdIb2erA6rqKQ71BrsFXBBdi2mXoEnv4EKaWlxPa8VOb2VftcvmmCqibz7StIdgGxbbij7d0mF/991z85PTsd7Qm/63Z2i6JHuQJqwDkdiwAy1Cy0NAGMJy+2MDi5ID/UAsSFinLAFxzM84PWtfnB8EtLnGlsO+GDH08/c9ajLocLtoRSVnrthfRiZWyLGJxH17MGpF3Go223EglCrRNixvsvDD53RGa6feRWNjg1LXD0WeMosBFEA5TMcGbTU/Zjju3vKJOc2CMWJDLVSw8u24eBcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Rqk07KNoqw0cqixffWZBlIRt0nRcrCu0I3UuzlLo8=;
 b=GsJ3XSaxAQm5/TtZ5YT68GFoQmRw/nDuOFwaA3uNEYASZvwNEc4J5hIPqAhEAOwvIt+Y8Z3gNQSyoYlBBMc1riZbk4uJYTustPRbf3nwxKKq9fSTdMKUCXm30jp1UpwcumKkw52btHHijR0cg/PW7Z78df1Dp/CYmPyMCuBkKbk=
Received: from DM6PR10CA0013.namprd10.prod.outlook.com (2603:10b6:5:60::26) by
 CY8PR12MB7339.namprd12.prod.outlook.com (2603:10b6:930:51::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Thu, 21 Mar 2024 20:26:40 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::1e) by DM6PR10CA0013.outlook.office365.com
 (2603:10b6:5:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 21 Mar 2024 20:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 20:26:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 21 Mar
 2024 15:26:38 -0500
Date: Thu, 21 Mar 2024 15:24:03 -0500
From: Michael Roth <michael.roth@amd.com>
To: David Hildenbrand <david@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Tom Lendacky
 <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel
 =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 11/49] physmem: Introduce
 ram_block_discard_guest_memfd_range()
Message-ID: <20240321202403.doucffgy33qywjox@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-12-michael.roth@amd.com>
 <750e7d5c-cc8b-4794-a7ef-b104c28729fa@redhat.com>
 <20240320173802.bygfnr3ppltkoiq4@amd.com>
 <48cafaf1-83df-40f3-905a-472cb5f9256e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <48cafaf1-83df-40f3-905a-472cb5f9256e@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CY8PR12MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: f27b2d94-6442-4b2c-3c39-08dc49e5373a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R4k6dt/YmbTL4plZfQ4Yozyyj6uVs2TTMo5Ncqn67yXpGzY62eujykTLxRqFwwF/BAs72YRT4FrioC7tRkXV/7v9iOXOeMeURMW7ckYBPNAdJkJ+lneqXAZ7paVnsbV1twTxK/FH8SvVvIUN4KlzSjtPawoexXOzJfUxbArtKwgjTObMfIa5Yt52M1/JoCucK4A/CArJOm3b4DXn/Xd0UL9UdpkzMbaM59iVD+7UCmoJM0QWdY+ewHRhzzUxLr8mPUMwBsCVJBiUL1pHvPbjUEXakZ23O+/abn61xExt2nsPydClbcPRnNMnqME+HF3AjC1DQhlhR+QkT8FXBZmxjnC5AQjgDymiv93MjtTjfn72sj2gSXLByfsXOoeiURLTyc7YEzNd3tAlSK/Dd8Ecfiana8h92/dPe0QjjKFgXSfJ8vpXdNcbvJ913Q4LO+elQjVjuF26yhOqcZRRpfAiYhGV1QA1MaqqoRHCgbx7mOz03P/Ilw3MSfv2hgVzH96WKEkDB/qy8ARdp34Ou38Dwb/7ksH8w+EJ2TQapH/9FbXxbxqWh/8sP2YrAXGzC/oFDFhsmxD9rUplj2FhlvOGuQVavPNP4b4xWsr5e0eLwwscGExy5GSWpW9jXgFTZVjU/AEwcFToSOLi4ny6FyVOL+rKYrgk3Ai4hRPPLJrXcsrSDxnrOddclaxQg3Og/Mi0beYpJYHPjg0SW1JsceGgm4HFhs0M4UrDOY1II/qMcQVfkEZIQ9+Hosizc13ovpO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 20:26:39.9857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f27b2d94-6442-4b2c-3c39-08dc49e5373a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7339
Received-SPF: permerror client-ip=2a01:111:f400:7ea9::62e;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
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

On Wed, Mar 20, 2024 at 09:04:52PM +0100, David Hildenbrand wrote:
> On 20.03.24 18:38, Michael Roth wrote:
> > On Wed, Mar 20, 2024 at 10:37:14AM +0100, David Hildenbrand wrote:
> > > On 20.03.24 09:39, Michael Roth wrote:
> > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > 
> > > > When memory page is converted from private to shared, the original
> > > > private memory is back'ed by guest_memfd. Introduce
> > > > ram_block_discard_guest_memfd_range() for discarding memory in
> > > > guest_memfd.
> > > > 
> > > > Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
> > > > Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > 
> > > "Co-developed-by"
> > > 
> > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > > 
> > > Your SOB should go here.
> > > 
> > > > ---
> > > > Changes in v5:
> > > > - Collect Reviewed-by from David;
> > > > 
> > > > Changes in in v4:
> > > > - Drop ram_block_convert_range() and open code its implementation in the
> > > >     next Patch.
> > > > 
> > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > 
> > > I only received 3 patches from this series, and now I am confused: changelog
> > > talks about v5 and this is "PATCH v3"
> > > 
> > > Please make sure to send at least the cover letter along (I might not need
> > > the other 46 patches :D ).
> > 
> > Sorry for the confusion, you got auto-Cc'd by git, which is good, but
> > not sure there's a good way to make sure everyone gets a copy of the
> > cover letter. I could see how it would help useful to potential
> > reviewers though. I'll try to come up with a script for it and take that
> > approach in the future.
> 
> A script shared with me in the past to achieve that in most cases:
> 
> $ cat cc-cmd.sh
> #!/bin/bash
> 
> if [[ $1 == *gitsendemail.msg* || $1 == *cover-letter* ]]; then
>         grep ': .* <.*@.*>' -h *.patch | sed 's/^.*: //' | sort | uniq
> fi
> 
> 
> And attach to "git send-email ... *.patch": --cc-cmd=./cc-cmd.sh

That should do the trick nicely. Thanks!

-Mike

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

