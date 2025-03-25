Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF797C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txCyv-0000T2-9c; Tue, 25 Mar 2025 18:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txCys-0000Sb-Fq
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:42:46 -0400
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f403:2413::626]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1txCyq-0006sA-0a
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRcxyX/BnaZlW74LTdOoD8eM73FpRojB0KOYLzpg58Wbjokx8vYZXEfnD/eJPjqn3Houi5vA269NbQPa8c6NNExytQA10k9JNeLoTy+PX8KzEAWsD++SVDjULw0sLk9adI3olP39XTRQd6G1+1ubKjLSX9pQlWL0cqJyR7iFGWH2P2di/ROTNdTXIGZLImVIM2ffSEP1CMvtlD2GgygOCRIKZqYXqlHnRJQyxgP03g+YqQ5EA92Ccn5+qLlG59WtqEU1dE//djLCVuXa2Dwl8rYLHtDn3bxlmd3uHksEZ0pKeASIvoV/2k70ra/+oiy4QgTCF8v3ttjzj5A6ohbb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzLIkYh6WwAViSMwS0RtH/G5N9FUDr0nTyawyeWK7zk=;
 b=Lz2XT2rYstRvbymX7RvFRzaBheE0+VrLUjHy73mQZslRKWsyvko4lU1Qh7k9eeisHPuC/wC+fP1IwYctIjG7xod94rWa7q2bWvXy1awEfFTN0hZVB7MMED+TptZjWzUiqWQwrz18glAWjr76NxkXGZIHteklaWPi1cNkD2RT1WBBkGatdgxEdNuY3sY0qBCYFxKk1jRssyGtdoW6EK7u16ySEp2dqTLpzsAjRFtrkuiIfiLaY1DDLkQXJfvfMKEEdXimenliRFvPSem7uQq+j0oD+/IKA4O3Gmlrs4sjDf/sds1Zyx2RcA/+BM5yDVARKa7Mv0O5TWS/lbGYFB0zvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzLIkYh6WwAViSMwS0RtH/G5N9FUDr0nTyawyeWK7zk=;
 b=OjhJvU17Hdl7/ePKewbFGAp9zM1gMC5o8S7S0cFH2XjlKz69X44o2wDbVVhmquFnOAGGXnPraxJO0JPmvuvubltPSPMB3pUbcSPSLH0FWqRc4YGF1V5woiuLQO7pMEB3s4yUzNkKb3phITKHTHYeU/jlE3ecw8AYV6jaLBZTm9s=
Received: from BN8PR15CA0066.namprd15.prod.outlook.com (2603:10b6:408:80::43)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 25 Mar
 2025 22:42:37 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::f4) by BN8PR15CA0066.outlook.office365.com
 (2603:10b6:408:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 22:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Tue, 25 Mar 2025 22:42:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 17:42:37 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <174238612063.1594466.4005439602392444073@amd.com>
References: <174238612063.1594466.4005439602392444073@amd.com>
Subject: Re: [ANNOUNCE] QEMU 10.0.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 25 Mar 2025 17:42:21 -0500
Message-ID: <174294254171.2082190.17846262388651328027@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d0f54a-a43b-4fc6-9e59-08dd6bee57c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YytZN3FxYmNCVHY0S21aK2EzTzhFaktmUkE3OVF1WVl1YU1jZzFqN3NRd01l?=
 =?utf-8?B?T05iL0wyaVlYdjBlcmxPQW1YU2RxdVhBS2xVUUplZTFlWThaTFAzcnFUQ3du?=
 =?utf-8?B?eWM5SUJ6TEFTWWlXV0pmSzAxWk52eVF5eHM3N3RvMnlQaFNlZ0tMZTNTejB6?=
 =?utf-8?B?MTNSZ1k0VXM5OWZwZ2tzb3VCVGthREEwNGg2SExlQUNFTGJ0UC9BVHE5UW5y?=
 =?utf-8?B?OTcyYVlvdjNadVZTUXhLUlNuNmliNXdHSUhCZXNLL3RaanpMT2wrOCtoTlRU?=
 =?utf-8?B?ZmZTaEZJWUdnOG1TMDhLWEtkWUFtZGVGUWpDMzFuWUM3ZmpFTXJIREgxNnJ0?=
 =?utf-8?B?TVNkTFJVMzh5Umx4SWdMYzE4RHh5YXBrc2R2V0JZbXBKU0IrRDNPNVdRcEEz?=
 =?utf-8?B?SE16MmFDMVRvdjByeWlLSEhTMDRNQkFWRmZlSG1aWlMySm1XeloyMlFoZDE3?=
 =?utf-8?B?WEtlZE56RURqQUZXelFqZDdVc1UyUXpNM0ZKZFIzTExXUHhzTTA5MC9IQVRQ?=
 =?utf-8?B?alBoajFNTFI4NVQyMFNUYnFidThTYjZ1WlBtMEVkazRhMmJVMUdRRmY3VHJO?=
 =?utf-8?B?VDBIdTNMUHZabDZqcndZdVhwTXMrZzVJemxpaVJLdTN1TkJ1OE9zbWVON1Nw?=
 =?utf-8?B?cUNaUW04RVBYaERsVFY3Z3VoeGpNWTBnVEVzSFRIZTZLZmxnUTZUNFZjTlZI?=
 =?utf-8?B?RkpDSGZBNElxcWlZL3NYeHFLdmZrVXdteG9VS0lmZUI2Q1d6MkR1TWtoa3NX?=
 =?utf-8?B?RWNNVDQvckV3SjRWYjlHZDZSMmUvd05xVW4wSXpLak94ZGVYOEkyY3AyN1FB?=
 =?utf-8?B?UXVPdFBnZHArN3lPWEQraVoxL216VGFTM2htRGZ1Z25BMWdvOEFGcVZHSVkz?=
 =?utf-8?B?Q1hreGlxMTRlZzRzMllMWUpET1FWb2pYcmFjL0tpSTQ3dDluZmJZTVduNEY2?=
 =?utf-8?B?QlNBdWxhclgrWFkxdUlqN2ZmUkEvTmY3eUw3R3JIRTZFY1JYOWZOWGsxMGhs?=
 =?utf-8?B?dFZCVmdoR3l3TlZ6Y1c3aWt2Nncrcm1HS2lId2VHNy83eGQ3R1lzWVhIdkRt?=
 =?utf-8?B?b296QTBSSVp4akJJYUxkNkV1T1F6WTRpUDdxcEN3OEsybGVRR1NodDllQ3FM?=
 =?utf-8?B?eXdOb001SVFNUWpDS1BMUEQ3cUNMb0k0NllwWWNra3hMZnVKOWt0dzc3OGtk?=
 =?utf-8?B?NEhCYkpXMWkvODdzM25qTURmTnV3QXpIdEVTbUR2Z05qd2ljdkd5S0F0a3pH?=
 =?utf-8?B?RGxjQS9VRlJyblFNS0l3NzdFdzg2dDhDRFRJaGZ6bUhvNDBjazRMeGRBRFVT?=
 =?utf-8?B?UTI0NHN6c3ozQ2FBaTl3RWNlR0llR1U5MU5CaUpWZTlIa2ZHWHR5OUp1UVk1?=
 =?utf-8?B?RThiUHVUbjZhcXdUZE9aY2s2Q055TkNXY2wzRENrUHUzcm1RVEF4YmlpYlRu?=
 =?utf-8?B?S0szZnBkaTR4NjdPc0dNaURQV0hEcmxYQ3lCVGQxK25naUdkUDNXdEN5YVFx?=
 =?utf-8?B?NWV1RnpKb01YdXRabFJta1JqdEo5VVBjRE9YemZ1ZzEwVmRxbzB0emgrQzZ5?=
 =?utf-8?B?c25obHRQQnMvTktxUGNqWnkwNkZ5NERRcVR4R0FRUytOWklIUmFmNkFTVU5K?=
 =?utf-8?B?c05RUUNiZk9INzczRjU3UnZ6RUpsSTUyTVdqR0dmUVBDUjNhTXJ3RTRjbVBN?=
 =?utf-8?B?YkpCS3ZoOWpnSm9kdHlUWm9ZNlN4bTBBQWRUMUJGTm1LYWZsT0t4R2NWZ21x?=
 =?utf-8?B?RkFjMlZUeXJHekxUaGRRYklrTkVteUVBOXhub3ZXMHNVNVlyNzBlSWxZc1Aw?=
 =?utf-8?B?YXNSS2dlakFQcFZxZGppaVF3KzBoeTYwNkx2UXZieWxhRm5wa1pWTml4L3Fp?=
 =?utf-8?B?ZmJLS3pOQ2FuVUk2aHBKa2MrL2tLT1A0SFJLWlBNdSthYldrU3AraVQ2cS9M?=
 =?utf-8?Q?hWfnJI1+KHQcxYWieNEW5W5rsg+KREsW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 22:42:37.5060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d0f54a-a43b-4fc6-9e59-08dd6bee57c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
Received-SPF: permerror client-ip=2a01:111:f403:2413::626;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

Quoting Michael Roth (2025-03-19 07:08:40)
> Hello,
>=20
> On behalf of the QEMU Team, I'd like to announce the availability of the
> first release candidate for the QEMU 10.0 release. This release is meant
> for testing purposes and should not be used in a production environment.
>=20
>   http://download.qemu.org/qemu-10.0.0-rc0.tar.xz
>   http://download.qemu.org/qemu-10.0.0-rc0.tar.xz.sig
>=20
> You can help improve the quality of the QEMU 10.0 release by testing this
> release and reporting bugs using our GitLab issue tracker:
>=20
>   https://gitlab.com/qemu-project/qemu/-/milestones/15
>=20
> The release plan, as well a documented known issues for release
> candidates, are available at:
>=20
>   http://wiki.qemu.org/Planning/10.0
>=20
> Please add entries to the ChangeLog for the 10.0 release below:
>=20
>   http://wiki.qemu.org/ChangeLog/10.0
>=20
> Thank you to everyone involved!

Sorry for the delay on this announcement email. Apparently this got stuck
in my mailer queue and just got sent out today instead of last week as
intended.

-Mike

