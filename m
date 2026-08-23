Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAC6C5DF97
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 15:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyAVk-0001g4-BQ; Sun, 23 Aug 2026 11:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyAVh-0001fs-QM
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:53:27 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyAVf-0006G7-AA
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 11:53:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+Ss4PM6eVQzB9CmTUh26ABr+gghfQgaBuSsZy7YEjth+krSBk/me3IyAB5XsKvTMCZiYVUZ093FvB5mWTUmQEtbP0Qo27taVb63Ytw57cV9lDCj663hMYtqglVoSAXiNJYelA0KihXbuY7IhMZoSS6aaddM72m02V1JELFp512wo/Kh0o8eRnchjr1wVPGRTuuQwiSyc1O5Fb8Q84YeDT4+QufkZHzsAx5HvsbELQGm4o6Lv29ljrw3PbRKiD3yG/sXUpaKmFfQ9KUfasHFfO2AiJwVnw/eEb4BAhqtuQJ39dwsYRY0gU9pftXJZ6h6de2Vy7yymNFTfuckFOMpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA5yq0RGJGK7h294Wryl2wcFVNF4t6WXHA9pvbv1qmo=;
 b=uRN8Hne22PB9HenZdgDdnNa5SWJ2LVmMt7HGx176MukBmc2oR90dWMioAZ7KvFbfirrBBL4E5RBhcJtOw7nek8ugK8OKHXH+ev0UjrVwsMV1ptNrhBXVXGP89AaWVNGdlNkvUCfCtkogydR5oZv5Cny9KBb0TXNmzTLcIbhhBuPeIckoBxzggAtVMs1PtGovnE+CSEegJVwFyoZsktbk1cwUtlz8T0Zxkjb9PxUDU/kqpSehffeFgMOMH/jPMB/6xhovxLOjQ5UwXo+fHrf8Wvnu4i8SradnCLHU3oaCeuHUC0WPww/YvUmDR336cAvtcxNrRVxdvHNZpToBexjG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA5yq0RGJGK7h294Wryl2wcFVNF4t6WXHA9pvbv1qmo=;
 b=nJC+hspd3QLnnRIS03g2beHjZzd/Ka4R7bAHNAocMWD4H01k+aA4A3fEWwujTnFC3hOYsE+J9lUTuU9DLWOiNKqUDxwi1wRZMvw50/eOcuWkfSjq6LYJD3T0lJpDWu6c901qoZqd0zszxEjXiCJCXI3vOOw6ZApTXXIFNRJsX2E=
Received: from DS7PR05CA0088.namprd05.prod.outlook.com (2603:10b6:8:56::14) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Sun, 23 Aug 2026 15:53:10 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::73) by DS7PR05CA0088.outlook.office365.com
 (2603:10b6:8:56::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Sun, 23
 Aug 2026 15:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 15:53:09 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 10:53:09 -0500
Date: Sun, 23 Aug 2026 10:52:13 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, <jmarcin@redhat.com>, <david@kernel.org>,
 <pbonzini@redhat.com>, <chenyi.qiang@intel.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
Subject: Re: [PATCH v4 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <3fwr25hmoz7yicoh3o3x3ldeweapn2tbn4dnji67hgrnz7l5bh@rs7gqotxraef>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <aoheMqE-RnH8sQ82@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoheMqE-RnH8sQ82@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: a66b62b7-fa56-43a9-0a4d-08df012ea15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|7416014|1800799024|376014|36860700016|13003099007|18002099003|22082099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ZGYaecGNOkRmQPywbhPaf5O1ITCMbkZjkPHeEUvQatGJVSe46iVTcJCBjY8p1b7J1kN1rucmZfbycm51C8qSmudnw3YciY5T+9wqEvQnVOFo7c5feA4Ndr9F/5jUFGjQ0xcQGhVXn8rOXUcC3wnyKuboT/odole/EbmvTFwUoixts1phZi2Hy3s8sgKVP8bZbkImDFNUgzzfyJwneVUJjNOxtCFL0EnhE9sdEO+Gyf5VBEaYaXA2l2MsXLR4iqXPkOLDop7PRER5GR4YwwUxYOJgMaXXtGZNBPIhOWOJ/6Sil0z785fusknexB52lSi4R6J4cYrVEXmof8sw5v+hvYKqZlvK+AiJIU+Xu4emGnjW9mPYFIkYCC1o1gBmMSkjMdwPlloiUidyb1XBt56SAkSRV4PKEYNvEIb8GqOKsZhoN9b7O5aaJLF9YCvIxHh1OHtR9weoGGRrKqvdvmPmDAtweFrB+9cnWP+q2rE10xaW28VxJbtG+tE0cItgaX4pIsGR9UNaaBZuhW7Zp8V15u/+OidpnSc2b2iC52n7F81l5JThMBH7eH5SHN/0gh9vDiHm9X60KPsaUKb2biTKViY8Dhwq6eINVH1IeOsr0e3UjmqnAJiAq+XV3vv1GlfB4hyuUAG5fTFsjgwyBMTqZcDbDAnqd8WPtnSC36+/a3zhJmb0zeL9cUk9oaQioBs63OdBgAh9fXaF68lbQGrIDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(7416014)(1800799024)(376014)(36860700016)(13003099007)(18002099003)(22082099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3UYpocN0xlHluXpdZZbbDEdRVnNE4RpFjBHwbXLymRwTw4qX5OYcoFzvcDal+cMuKjuMijNp2Z6BhdMIGipQiG0X9qCwrvj7ipDD/SaTxP+2PXFWUgQYan32BKhoXf605k0LtsqrhLaZrh+9s7jFACGrNWnQrDQj7CAcfH3fG4b/RUciUYwjobqC3SP20IGzQAb0GsMvdZFx1pKKHLQrCJo+FdckQ80U0EziOCRnUwbRTeRvhwSnSQFKXR7ZdU0NPxwcSUsXyWL+RyQ6rdNcGvmweyqMLvqeWV1rYt6nKKykrQviEmyP8XXtY0Sfn3IO4g56SgJdwz4k35PfiqH8x0Kiikuf9uy9xiS2d0aC8nhhln/jqZAtAp9smKaIMJDLvpGdHV3ZNk8AggAwawFUySAkhhG0zYa3ML9DO+ti3SErxtKSDzphpfKmrLe59zCE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 15:53:09.6457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66b62b7-fa56-43a9-0a4d-08df012ea15d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Michael.Roth@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

On Fri, Aug 21, 2026 at 10:18:26AM -0400, Peter Xu wrote:
> On Wed, Aug 12, 2026 at 03:16:38PM -0500, Michael Roth wrote:
> > v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> > v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> > v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> > v4:
> > - Picked up v3 series from Peter Xu and rebased on 11.1.0
> > - Collected pending Reviewed-by's
> > - Per-patch changes:
> >   [01/12] Fix blank space (Xiaoyao)
> >           Fix commit message typos
> >   [02/12] Drop duplicated error-handling for capability checks
> >   [05/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
> >   [07/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
> >   [08/12] Disallow 'seal' and 'hugetlb' options based on guest-memfd=on
> >           Fix minor typo in comment
> >   [11/12] Fix up typo in g_test_skip() reason
> >           Pending: Move kvm_guest_memfd_init_shared_supported() to
> >             migration-util.c (Fabiano)
> > 
> > This patchset is also available at:
> > 
> >   https://github.com/amdese/qemu/commits/gmem-shared-mem-v4
> > 
> > and is based on top of v11.1.0
> 
> Should I just pick this up?  I'll touch up the commit log that Phil
> requested.  Objections welcomed before next week.

Hi Peter,

No objection here, although I'll be posting new version of the in-place
conversion support later this week (~Wed-ish) and was planning to an
updated version of this series roughly the same time so which ever way
is best for you.

If you do post one though there's also the missing 'return false' and
dropping the seal=off enforcement that Daniel noticed before we started
talking about introspection fun.

Thanks!

-Mike

> 
> -- 
> Peter Xu
> 

