Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB569C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 00:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZK70-0003vc-P2; Wed, 31 Jul 2024 20:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sZK6z-0003tq-6q
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:56:09 -0400
Received: from mail-bn8nam04on2068.outbound.protection.outlook.com
 ([40.107.100.68] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sZK6v-0000kv-ND
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:56:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GkLYVD/3bkIVGJCtyxK+9+suBkUvYvA3mxnnYv0bbhpW2HhwyT1R/GY72QaeeoVftIFwMjDqUzlYGgsC7C/UojtSmlbHXSbN9lf74V1nVBKSsZcyuZrn9N0wgTaK5jF1XA2eAnUy9mv1LjTu2jX7Qh4IlLSliNwu4MK7NiClifI4dlqYWFAoF+EIFOowjMgnF+odv9g3DHFnI6VfFS0BrVnYigwK+fgiP+2Z9Bz5PdsAcLjGiTlxHZ2T6t5nbwP1p6Jdjz6lE8C+CrfI1r4v8hnNMGtPNt0SmxYBebffKfGeBYk4MzMuxiLKF4C/dYJv68evZSqIfCmEmx5Y8TimFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9qmaG6bGZg0bW3/umFuf8rHt///Om69FEjXVti6lcs=;
 b=brv3wECiqQYABqRg5XaC4r6K4oruVb9/vs7AnuhnAzDWpghd+oi1lpuN+YZ1gsP0TOKMCrb71IwXIfuZCoDmvauvBswgzf7ApDkV+iTcMgT4aB3/urltnZLLSEXSS1O6oxNTP3EXINdXVE0TSnRnSMUi35AJpDDTB1fkSgxYWqhdjftxZh7R2V4bPBN7rT6exwVM9douImdCWxYOrTOypTazSEUHIaN/A/y2mBUUE2gsct3bwjvSLKc9c1LNdBBJu85H1uSIdThtQKi0ojmot9y3aSPMXObDaW8SmxAj9BCM9XuWsqp1uWStaTUrU8Lm+vRb18QLyOXfYt2MUhBPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9qmaG6bGZg0bW3/umFuf8rHt///Om69FEjXVti6lcs=;
 b=f7TkLfRPWzkwLZzXpA7PHELJ1Bpl0bEuQsSQDdr6kKSN4WTPWggG7urvfOMZnf7Jkqj1NLAf+2k8SATfAuK5CTXbCkgWE6uOIQKqAIyu3fslz1gu2cF87Gt++noS40mPJ+EyPn08ieBIApUMEKirBx2k8pibF+EkYzC21X+Wh+w=
Received: from BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 00:50:59 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8b) by BL1PR13CA0214.outlook.office365.com
 (2603:10b6:208:2bf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.6 via Frontend
 Transport; Thu, 1 Aug 2024 00:50:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.0 via Frontend Transport; Thu, 1 Aug 2024 00:50:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 19:50:58 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.1.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 31 Jul 2024 19:50:43 -0500
Message-ID: <172247344337.1219390.18413731063633350226@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb3a6c8-5f58-4640-90af-08dcb1c4028a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkNqanA2dU5kUElRbEZmTkFQaHM4ZVNhd2V6VEsvQVVkL0ZzYUlBVE1xdnZy?=
 =?utf-8?B?Ky8wdG9JZzA5WXMwR3VxNkoydzRVTmFhL1VITlg1alo5d1JhWGFsc1ovU0Ir?=
 =?utf-8?B?ckxMcXlsSm1MazYrNWtSWnFYMTZReTBhTUFuaEdJRVgrRk5xSHNOdXkvYVdk?=
 =?utf-8?B?MXNscUJsLzJEQmhBZERZOEJmTUFiWUlnQTFRT1FuT3pxQStoRUJCcGdra1Y2?=
 =?utf-8?B?Yk5qSzl4YmQ3cDJGVGZ0WnJudHJ1NUwya1g5VWhxeVB6eGgzNGtkTytua0pv?=
 =?utf-8?B?TXhGOWRGUUk0Y3FMa043ZU92RTMyM3crcnp5dmk3ZW0wcDVIM1JkbWF6L0E1?=
 =?utf-8?B?R3M5S1VVeDFueUl4VzZZSVRrUlM1NnlWV2ZLRm95K1BkaVprU1FZQnBKR1Jp?=
 =?utf-8?B?N3dzRjhaQkpzRnJEQnU2TTdjaDZDb0pLZHZnNUJnQU5nNCtEOUFLL1QyUzFR?=
 =?utf-8?B?TFduM1NZQ3BValhMRlR0V3cvVHJnR1VPYStnV3hVcnhpRG83Uk9Zc3c4ZmhP?=
 =?utf-8?B?L0VBNXNYMUZ4MGVMVXlJN0ZoMDJNMm5yUHkxK2cwUGNvLzZvdW1mMDJDR0Y2?=
 =?utf-8?B?bnVjQ3VQK3RxV0RmY1ZkbEdlUDFFUERuakp6cFhJaFlhZjhkanY2aTBPT3k0?=
 =?utf-8?B?ek94VVV1d1hkWXUydlRtMHVaL284MDZtZnhiWDRlUStCNkRyZ1Q0algwdzdT?=
 =?utf-8?B?WUlzRkYrSTFlQzFjc0czUFlxZm1Gc3Z1OEFyNjJTNWRwaGs0MEJJQXQ4d1lx?=
 =?utf-8?B?YXBVQnFQWnlBTTJDTW15bXZuL1pLTUpwWjU1Y2NUV0N6UE1pMitBTEQ1Q3lt?=
 =?utf-8?B?VFdWTzVReEV5T0VnTFRxMnhOL0ZTVHJWREorbXhtaW9hL0hVQmVDRGdpUnNB?=
 =?utf-8?B?ek5aVnFuVGoyNXpldG9OaGhzdU1ZUk9UT3lKRXI5TmZiL3AzQ2FCZlczSWE1?=
 =?utf-8?B?V1ZwdzhaRUpTRG5lOTMrRGgvS0VGWTVpeVF2ejM0UlhreTZGdUF5SFpDMVBM?=
 =?utf-8?B?NzJOMUtqbUV5UUVuTkFnaGwzMlVxRFdQSkVIL29pMHdHV1dIeWdNVzdBMjJm?=
 =?utf-8?B?S2YvejRUMzA3VFBVZmp0L21TMmJ5VnJNeDJwSHU4bUMxYVVxT2xtWXA0NTFW?=
 =?utf-8?B?dmtqeWtobGxEdksyZHRGNzhtWmJkekcxTHdyU1JyRmh6YkQzZWJpWE9oR2lL?=
 =?utf-8?B?WHRrMDR5L1Fhcit5VWpoQUgrTmlUMW53S2dSRWdzZ2o2MWZHcWxjblBQUlpB?=
 =?utf-8?B?UnpVQnFPV1JEajRHeVVDYzBLcnV6aFMvaThVQTRKUnZuSFF2enBWRWhXN1cw?=
 =?utf-8?B?a244Qy85YTRRZXBRTEUzcTR6WWpBSDV2N00vNEM5ZXNxNzltWmRtMzBXMWww?=
 =?utf-8?B?RWhSWFNQbTMvWm5tQ3kwNzNXTEdtc2k3NWpPb3FIaG1xS1MxTHBGNzJwYzl1?=
 =?utf-8?B?elQ1bFdXMDVzUTMxOTNRZmorYlNXYjcxZzhpUzFiU21sQzdnclNYK0ZoT09H?=
 =?utf-8?B?U0FXcGpvWVVDa3YvN2phNHE3Sm9WdG94NGF0L2pNZDFDcFRnUk5IeU9WOEQ5?=
 =?utf-8?B?andkY0tnK2VVODhRSTgvUTA4a1dpTC9uRCtrOERQWXVqSFZFc1NERkRsQUNV?=
 =?utf-8?B?d1haQXhyRDNuQld3djZNZ2M5Yy9TdkNLeVVEeUFqZlovZHFzRW1iMnIrY0JX?=
 =?utf-8?B?RFRQM0lMY0hyWWNkamJ0TUc0eUpFbjNGZ0VBTFYyb2VpREJVL1hlbHVzTHky?=
 =?utf-8?B?VjFaSHI3QnYyZHQ3a0NBQlF4T1Q4NU1hU2lDeFo5V0lnZGhkUGcvMURaWkdQ?=
 =?utf-8?B?RW9EQXN6TUgzdFhaNnN6dzFySjZnUXFINEpCYks5WENSTnNXdTZEZVBiVVZM?=
 =?utf-8?Q?6Erb2aPdi2BIR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 00:50:59.2547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb3a6c8-5f58-4640-90af-08dcb1c4028a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071
Received-SPF: permerror client-ip=40.107.100.68;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 9.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.1.0-rc0.tar.xz
  http://download.qemu.org/qemu-9.1.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 9.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/13

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.1

Please add entries to the ChangeLog for the 9.1 release below:

  http://wiki.qemu.org/ChangeLog/9.1

Thank you to everyone involved!

