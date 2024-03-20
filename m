Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC10C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 22:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn4CU-0004SS-JO; Wed, 20 Mar 2024 18:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rn4CT-0004SG-Bk
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:14:21 -0400
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:240a::601]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rn4CR-0002si-Lj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:14:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4attzgMUxbAVDmuKbUTNtWa9+esL6bBq6lOj0H1DW9OxFx46qHaJu3cO0SB6NPKkWqTEzsPK04ceIPinUARJ1z6koN2tnZj81Rcto0NPdCtZOOMo/jvkTIH3+TSNNbCBTKiYr+BwScrI1WUAXKtZgCJmvJ515EwDDc0ft+tBxI0MKI4PiTfWJW7fg8OkcpM7sVlGzAIltVI+y9ilCTq0jqHKlNzCM9LdUHy5Duqij5G1Uk3tE93qdmHyD1UpJ7G/JxsLu2vUOQ6YyRk4Lp06n+P0exOh1ge0FogySN/7W1hnbN3jzrqz+FylvY5luj0q6dfmx5edgsN0/3lFGFDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfJpkaWiE9Zajrue0+NeSDmzjxKOAoll3giI6yc1q8M=;
 b=MOtgOmvhInACEgLxqqeo7P/yEX/8iOBaqxb8cHLB/yr+1zLyL0fyObe/aj+O7PuuhwbF71s+SIdMY1kCWDLFmuk8zG+BS/mVWR5MTInQkp8gHxGJfr8EHUvW8jBwEl0QU/o0Q1qvtmKxOGBHVwD6GhznSvublUGsG7HxKTm9SL+RIK6U+6+uXvWssc4SRVElCGBQCduN2KJ6vpQbI0mk2LmpLgJTQznadAmcHLtOs8NwtA+XptmoCdyYGmYcHMcibnHUCdxtrfwOfM92brtFWAzIR9uWOrywvh72A8CHj6nvS5H+dBOeELI7240QIA6xNgTwIltQYNutOsvDTTxD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfJpkaWiE9Zajrue0+NeSDmzjxKOAoll3giI6yc1q8M=;
 b=42321Fny6Nw8fy2io2zT4qDupa5427Zk1hdIDDeOKRztyMIceXMF6j81Z0FsCn3mZbiM90uaxwBtXgy8aYXG0tDN51v6LrDYftbAl+R2hp3zWOT4LtOzZkRvXxOoWSEvfcl/U5QFs3c81y4r8IBloqVQhu3oEdfof/8us811t4I=
Received: from BL1PR13CA0217.namprd13.prod.outlook.com (2603:10b6:208:2bf::12)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 22:14:14 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::73) by BL1PR13CA0217.outlook.office365.com
 (2603:10b6:208:2bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Wed, 20 Mar 2024 22:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 22:14:14 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 17:14:13 -0500
Date: Wed, 20 Mar 2024 17:11:01 -0500
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Tom Lendacky
 <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 "Xiaoyao Li" <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 23/49] i386/sev: Add a sev_snp_enabled() helper
Message-ID: <20240320221101.a4ailz2zepezq53j@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-24-michael.roth@amd.com>
 <ZfrX_SkgXPF1FbCp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfrX_SkgXPF1FbCp@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc6890d-a323-494e-b0fb-08dc492b13bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iklfg7wj6PXJo4zHggD6y/Hg2L2VgJvoijPtviRXDO/ULRxqxgwBxvAbY7eHW5NGEBCjo8xOWIyCrRo8AU0HhinpCsiMFCdL1YNdkNGnnDSrmUm6bXX1bTVYDTYBJYzWTNqbUJDnoP94HW9siPWIG0RZA010qCQUmiYTrbJtuaS66XYktUW66ELcQ0whftiJoOf41ivQq+b+OvfsW7fBo0XsfLfck2GkMeKQ6BYYtDa8dtmakccjsgGMfdi/gJcN+p2MTKoQmvApO7wPRLP1VcQUfvvFGKYrFPVG/vnO9vaAqPtFd0KewI/G0XpWAPQ4cP71bk+LGYOm8848YILVrlKkJaKa0GLGHmyPZ5l7GGbASaabPfqTIYO6Q6qep1Mgsrs4wJylAj/bTlWu42/pmrZsDgzrkZLp6Vmou7mmQLoCzI/5Fj6SW+4yo6s0Nmz+NDDLw4deJ6sq2mkORLnSpDM5OW9BTTA70ppPKaNrkkYLMjZ2Xr0FUkte929RnMuJUxibaTZ+TdKBv2k/EVVsZW2kRcmTeWAHxBV2LJ960TYqRphCRCW9OSgml+nlYJN/9JJyv6MM6EGm6NQeD0TUdUz2g9p7/UqQQrIsM5lryUr1Ca7ZWXeR0Nfvp2tr6Z098JZxVuCnotKIhPWCJC1lNvhNSV1n8BbV1b3N8WcD7Gmla1c8VzkWxsYqXX1wvloCCOzMkBSqaHVsrDMcOQDNQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 22:14:14.3075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc6890d-a323-494e-b0fb-08dc492b13bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195
Received-SPF: permerror client-ip=2a01:111:f403:240a::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 20, 2024 at 12:35:09PM +0000, Daniel P. Berrangé wrote:
> On Wed, Mar 20, 2024 at 03:39:19AM -0500, Michael Roth wrote:
> > Add a simple helper to check if the current guest type is SNP. Also have
> > SNP-enabled imply that SEV-ES is enabled as well, and fix up any places
> > where the sev_es_enabled() check is expecting a pure/non-SNP guest.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  target/i386/sev.c | 13 ++++++++++++-
> >  target/i386/sev.h |  2 ++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 7e6dab642a..2eb13ba639 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> 
> 
> > @@ -933,7 +942,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> >                           __func__);
> >              goto err;
> >          }
> > +    }
> >  
> > +    if (sev_es_enabled() && !sev_snp_enabled()) {
> >          if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
> >              error_report("%s: guest policy requires SEV-ES, but "
> >                           "host SEV-ES support unavailable",
> 
> Opps, pre-existing bug here - this method has an 'Error **errp'
> parameter, so should be using 'error_report'.
> 
> There are several more examples of this in this method that
> predate your patch series.  Can you put a patch at the start
> of this series that fixes them before introducing SNP.

Sure, will add a pre-patch to fix up all the pre-existing issues
you've noted.

-Mike

> 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

