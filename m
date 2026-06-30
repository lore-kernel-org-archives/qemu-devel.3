Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0024AC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 16:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1webX0-0001Gz-54; Tue, 30 Jun 2026 12:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1webWp-0001FG-5I
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:41:44 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1webWj-0006rf-MF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 12:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD27JlVMzq88moPsCtOAEG5NdBXNNyt6PpLsELr3gwNgyTeBZRKxzS2xAihuRDDc78WA8tlvn8a+74Tk6K1bZO8IZyVx6YCcrwJaquCqGYduu7TZFWC7vVaqQyK3wLtmWGjxaypHKxJWc6swHMaga+ZixHJIDCSNhsNvTNFMltLslZ1/B0IjZOZ94L1ght4Ug51gtwmfsqNIFO1RHfO9Wj4B7yQZcz59BaZhSW2Ti2ZkWae9WjSJiwoxgSs6eO08mQglPzt27c2FzyO7iWJQEKG2KbGD3FKXa1ATyNUIVUCZwh+g3okXOzLdfCfRrEWFfczavoDza/v6X4EO4AdaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dklOuC2ftE5OFsOnWTLF6/yt0cxDUfYCC0gkwN70gWk=;
 b=k00bQ10UzMTN1uO93gRNuxQczdN/9Kyipk1bQIdWa8PsHgPBY7HfY9m/xg2wHEqJSCqV3D0yzZ9/hdeGp7NnjtxjF+IzEJmlYCkirzTc8MT82HtLexG6tH4s0LsZchWHhe1IImE2cdVKYfKH3vaMh1HY/U3VtQDem6e6tOxBWrb5uN//GWI7el1dJ0RXSb+ANQSGR/z8utDxkIpw6ZsAhBRldFx10GgDtUmFu7sMXG9zAXkgPobKeJNwXnvh8M9+R5rmkhopKpJcmmjNIEUrM4XJQETCZiWOQId1Mop0vkMTN/yl70G3AroA6xcTOaMpHL0sveloGV1pww/VA8dt/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dklOuC2ftE5OFsOnWTLF6/yt0cxDUfYCC0gkwN70gWk=;
 b=BSx2gsMBPGd4aWr2IJ7pi32ZeiBfu1PfaQbdCEg0WHEPNT15xU1SuiYr0e71IeITAlKRegoF38agpovy6XHrPHOCM/8GaYtlfRyT+Tk2V3ILmFKFbaMUutaAKf9R5t3dU1O1vTEEzkjgo6WC+oMyP03ToH1nzzWVkioJT0G/KhU=
Received: from SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 16:41:24 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::af) by SJ0PR05CA0131.outlook.office365.com
 (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 16:41:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 16:41:23 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 11:41:20 -0500
Received: from [10.254.61.72] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 09:38:49 -0700
Message-ID: <c745aa4c-cf0c-4a14-ad82-c4a53749d85b@amd.com>
Date: Tue, 30 Jun 2026 11:38:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/i386: Add getting RAPSIZE for ERAPS enabled
 guests
To: "Shah, Amit" <Amit.Shah@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Moger, Babu" <Babu.Moger@amd.com>
References: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
 <20260630153315.1585-4-Benjamin.Cheatham@amd.com>
 <90c30873c4bd0c2a8b0da82c6571e17c6272cef3.camel@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <90c30873c4bd0c2a8b0da82c6571e17c6272cef3.camel@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a9a913-f544-4d2f-22f3-08ded6c66bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 26ELxvCf+IklTHZMDVlKSSA+YhhcNOGhrsEDzLgjdehOvXUFsijC2BlKlcIOZC8cCrkeGr0TgJK0uc6151wzwUe2xuEzgVefsLdCDaQ5WuDBVGVR+QVliSwwYdZQ/afD/VugxhGV967Us9al/S/tb+4yCJA5UIUo0EkiPjAP9oZ/4vn3SH8dkR7zI+ykxwgBqKqodeB4e0yNNbl7N1dq/qA58HBGKFc/+XlT1fh0PiaYSNT1go0DlzGEmlaquhU2tOzI0UVehf/k7SbGHyzilpeI+2w7d4f0MsXRsf5s0qPXlS5h0M4kqRaRIFiU0/bf3vkgXF3Z+sSc5TYWpmCs8Cst2s+tMHCgwpo2bvTmo8Ah0plD4fo8E1LHyLOWm83C+pWR1OLbXWl3MRZAhCxS+G6mDfoffZB6l3vE9DdIfqzUbtbdd6CnsBqGDp1O3BwD60nQNphdGai+7sDWlntDLqxZn+xbAiEqz4GhME9oWcnIBkNLOcHz8pfx5SQuZna5JeWCJNZGvDemlZrn82aYGQ/nhL6PqXX4c1nIzPvfUjJGr8k7NR/RMI4VhEUancpKEpftErUVS/sKVHNtl5ArEEUZh2/5vHpUERs1Ee0wMTwvauQQJPehI64ht0uYv7LOYYvSGWRIsLHc1FaohhfeyRjghdM0Yt8pJMcBojsQNoC2f2aQsf0a5AtufZLxSeqBVHG+vGuc1Xycmwlr8SI+FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hpDdwdImabBUMAPmNYG2j1Vm3V40i2Hzls4/Jpt2HjChwC5D1BA7VlFfjKcSxpu0YSQ+JiUIb9d56MpYBtCzerdk3lYn3NIUHFNgPWr/Qu+2wRKdZ7aSCwduELMZo6ikY/3Ipdc4fyUEalQz/mxnGgNH+r2Z06yZi5xJPIr1l9oQnA0qRw+NX2Y4Iezo3Pfb/Y4SqWoVIBuyzLlNNHtFbAGVKHDdcUZqMDmo4/tvhUfp5TmYyf+mA8m2/qAzJfuCatlqKzU9xIQ6FLpiS354lMLOpK+trmv08IrCSVT9YjwZ4MpYZOK30FHjSTgnN+6EWE6A5wpesekhMWgRMPNEuemQAhEo0OHXGOREDHB8LMO5evL79MgNHEtSlEMCsc95Ii3hp4B2Q6nI/ORMEYaReBkkrDsaMtjtEPLXd73E1aAdEGGvF0vS5jn0vv5NMEP8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 16:41:23.2385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a9a913-f544-4d2f-22f3-08ded6c66bcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/30/2026 11:07 AM, Shah, Amit wrote:
> On Tue, 2026-06-30 at 10:33 -0500, Ben Cheatham wrote:
>> From: Amit Shah <amit.shah@amd.com>
>>
>> Newer AMD CPUs have the ERAPS (Enhanced Return Address Predictor
>> Security) cpuid bit. When this bit is available, the size of the RSB
>> is
>> indicated in EBX bits 16:23 of the same function. Allow the guest to
>> use
>> these features when kvm is enabled and are available on the host.
>>
>> NOTE: The commit description is from a patch made by Amit while the
>> actual changes are a subset of that patch, hence my Co-developed-by.
>> Amit, let me know if the attribution looks good to you.
> 
> Looks good, thanks.  BTW you can move this blurb below the --- lines so
> that it doesn't show up in the commit log.
> 

Good point, will do.

Thanks,
Ben

