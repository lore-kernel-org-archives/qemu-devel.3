Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5FCCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urIfs-0004al-N2; Wed, 27 Aug 2025 12:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1urIfq-0004a3-87
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:06:58 -0400
Received: from mail-mw2nam04on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:240a::60e]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1urIfm-0007iU-Ul
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8Tt6ImqytEatHpggcmptivCbNAssW65yWJQA4AZebgRSEIXjsY9UeRAknPzzmYbBbwSazZgygIGJT0R5dL4gj9BvXwjNhClw89KlLLAAHkHLbyLKQAdv6HYgWMRib3479tMF83koy5x4+OfaowZLWXSKwuSycwOx4EuxkvF5WSC8w6EN8ACvLSFFswH8CApDlZUnok1iSSMRkgOFMqBxeBKI8X0voHii/WXFTrt4Par4MHpIOON4e1YQwc1zcGAYh1K6g5jKVgQoFWdTd+41rRY/W2mCCnIKepAFlBd7leDtJIWpgfftqDp6hjP79VdNZNibdc/1/q3gknkVN1xaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0jHTs+OgwpIjOcyUahbDp7ZPCCSgr3DD056DpuPfc8=;
 b=JmkXt91vqTOMzZOz+bgt883bpkd2tzI4GEvEBoDWzC4s3JNsTy7y8THWsRY+91UUJgLyuarbTm9vV3d/lIQFirTUtwGkTuoNKGBbxHIteGNNmH5wZw7CMfOOeXaDMSfS2imqWYM96fD/0iVpAFUGl3/w7esE94aU+Sy9/ajJdWWA6wEucDws1xczeylWOdsfKl9EpobfG/wzDa8DJnBdUlp7iBc8RBJ/rVO11B8jNWChDCmIUr2nSqn1MHmx3wFbVb7SA6cA1uVZ3hPVLUo8RV48sY8fed6EGcgvCOsvkSPR878XmsZhOm1UJSIpq3Vncmd8oJQPYkTiAFiSzZoYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0jHTs+OgwpIjOcyUahbDp7ZPCCSgr3DD056DpuPfc8=;
 b=FM9rhSEk9f4pF1tyXsCMn+qhgna0cctp5lQjaP9HvesRVQVINVfwCnBNj5dqFMqiNbx1nFwpy4ov3/brkNM47BHxXfnBF2RWhWn0H0iCVMvZFGTCj6zBb+ln/A+5bRY046k57VCwgqL6hP2W6bdXW4ioxPynSN0/1CzF6aMbvEk=
Received: from SA9PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:20::6)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 16:06:49 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::f9) by SA9PR03CA0001.outlook.office365.com
 (2603:10b6:806:20::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.14 via Frontend Transport; Wed,
 27 Aug 2025 16:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 16:06:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 27 Aug
 2025 11:06:47 -0500
Date: Wed, 27 Aug 2025 10:45:35 -0500
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
CC: Xiaoyao Li <xiaoyao.li@intel.com>, <qemu-devel@nongnu.org>, Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [ANNOUNCE] QEMU 10.1.0 is now available
Message-ID: <20250827154535.sqeanvqc4bz3ccf5@amd.com>
References: <175625036608.469964.4138433906168641553@amd.com>
 <4b53880f-cef2-421c-bdd2-5c963c316958@intel.com>
 <aK7Yl4c9ARijYz0S@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK7Yl4c9ARijYz0S@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 163ee735-088e-4e10-4f4e-08dde583ba63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?jw0qy1u/XwnbNtTtavuzUl7t/VjFoN0iebPaFBbgOHr1vjPAl4/CGoYH4e?=
 =?iso-8859-1?Q?3/Dfp/tYiGgZBvNy9k1XEksS4d7CZEHVNT8pdtzpe/1iu6rhWziSLTlsUk?=
 =?iso-8859-1?Q?Ewa7nbdA9q6fnnZpliXuttpgDv8SntC8CWvkX1ZS+jpwW9lzrld+Zl3ymU?=
 =?iso-8859-1?Q?i6pAz6g/kj62X62anhqTzlr4JNsO7LyxtpmoIpV7l1gLb3nwe3UZB+KxoP?=
 =?iso-8859-1?Q?TWu0VzbtH9hfwQaGm3jWw7PHV7qm7Gt8dSSA/6zGHLI8JdDwv4RIGV452i?=
 =?iso-8859-1?Q?lf1I2jBtss0Mv5ordv4jD1NftSikRgfTlvvyy9OzYQm8ar143zoMDCZgHH?=
 =?iso-8859-1?Q?dEuYiPskOrEbTyNRjihfz3XSi61+D3DBMUTpgF00j6MgIA2tssOJwaxq1/?=
 =?iso-8859-1?Q?h7LAKd4SkxPHmvoDHNTwy1hFmyOMBwq4GYYnGbxirK69FRuSzv1zhBiZRi?=
 =?iso-8859-1?Q?kXLhNuC4h8otyKjqrhYwkuwiBeKsnaV6wSHhoDAJonN0l0xILNxNUOQIXM?=
 =?iso-8859-1?Q?wRjS2wrr0K56CpUkM7uzP8/cNo20cw7bfzngZhu7iu7eg+7ErkoNN5dr4X?=
 =?iso-8859-1?Q?Os68sg+r7+xt7ck5D/uvxurGkFjD9VElUGOw70kAJeUbimqkDnip3rdz+k?=
 =?iso-8859-1?Q?a8z9Eod7lgSLYWvHy0Itrh8v2h/xMtkbMuPD/U+MNG+5DcMeBfdkHIBIZB?=
 =?iso-8859-1?Q?HLELbl4q5cVfxVkt92jFXtd3OKZW+Hb/Yx/gHXMSSV+2+1/RV9UmhAsplK?=
 =?iso-8859-1?Q?phYx/Ps6YTD6Cu0rs32zooEpidk9tfvM9da7e5AXNkepp4OPUXFiU0F9Do?=
 =?iso-8859-1?Q?8X9oHp4kW7HodOw+uavGeLBz6t/RNGaP5juRvN3iNfaQe3ZdKupWHxxB4O?=
 =?iso-8859-1?Q?b0tE+ZhzzSLNTmFf/Eb/SHO9iPFSGP/5Ltclu2sTnOHkMG5q6AZE1DtOgb?=
 =?iso-8859-1?Q?thNvywWkEbaCmm6Gusiidg0RweHSkrTbyGqsjKhf782oVJjvdfI6nOQymV?=
 =?iso-8859-1?Q?gbSiNpEWlZEpHCUahYjlHYJtag4TxB0CRguaWKNhET3FisZqUa8qSFpEa2?=
 =?iso-8859-1?Q?7Xm9MPHNTThhwxh5PBNPi8e1++7M7Tutjdth9LYe0fHXICRQqgMj1+Plwc?=
 =?iso-8859-1?Q?bROslDiPou4lF8OaPedxrFPUd9C8grSDBQAvR4atU0TWTEDRvMlyp4UgmJ?=
 =?iso-8859-1?Q?S1zobTBEWvOK9e5JALEHDXeD3oS+7rQAY82ip0pP7TRQyDoRzLTqGK90LI?=
 =?iso-8859-1?Q?ukcIXhM8YdeoNExOm+JhqXA6MQDkj6ix4BkMSrkGLNuljLSh4ITWvnoRlE?=
 =?iso-8859-1?Q?qGV7Gek6OXrZEEufSsLmeyPMSBBCTl/4N8nUu7sxPy3CXyz0oQoMHsFXWG?=
 =?iso-8859-1?Q?SduFC68krVCCq9ZpOEq1S9/VrAOTi6PMv8NaR4IvwZR9y+q2FoDv7j5ATy?=
 =?iso-8859-1?Q?qLqWsIgfv5qhsESNZ58FMfEciFDE8uZvqsPF/K6LLXxGtbh68QpB2Y3BYf?=
 =?iso-8859-1?Q?b9o/Bf/GDLAlXPhgatQ1RBhzCakcmFAMS+yNYS/fsBUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:06:48.6348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 163ee735-088e-4e10-4f4e-08dde583ba63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
Received-SPF: permerror client-ip=2a01:111:f403:240a::60e;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Aug 27, 2025 at 11:06:15AM +0100, Daniel P. Berrangé wrote:
> On Wed, Aug 27, 2025 at 09:40:29AM +0800, Xiaoyao Li wrote:
> > On 8/27/2025 7:19 AM, Michael Roth wrote:
> > >   * x86: Support for initializing confidential TDX or SEV-SNP virtual
> > >     machines using the IGVM file format
> > 
> > Can IGVM really work for TDX?
> 
> I doubt it. Early versions of the IGVM patches had some TDX code in them,
> but this was all removed since QEMU lacked TDX support, and I don't see
> any TDX references re-added to the IGVM code in QEMU that was merged.

That's unfortunate. I'd pulled that from https://wiki.qemu.org/ChangeLog/10.1
but looking through the code I indeed only see SEV enablement, so maybe that
changelog entry was out of sync with what actually went upstream.

The ship has sailed on the announcement email obviously but I'll fix it up in
the blog post at least.

-Mike

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

