Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDDDD6ACFE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 13:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWE8P-0003Fx-Tn; Thu, 18 Dec 2025 08:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vWE8N-0003FC-SL
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:33:35 -0500
Received: from mail-southcentralusazon11011039.outbound.protection.outlook.com
 ([40.93.194.39] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vWE8L-0006PQ-TR
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 08:33:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKARYS70tpI5kBF/c2Ii3lsQVmmUoSz7u0wfzyMU9eon6Yf79u8KsIz9tm4ER9ccgSHQhZoj+hUVGsrOLGzC31XNGNCAMQBYZt5Ad3vtClewXsakXRUuMQHCf9ZGhSXPL4nHTvVE4jRtKNYCD16XArC1X0bOjqTD745/FiYxPv8rbHzVjKnD7rGaxE5EPB7N0Mx/WmImiGQDvljG6RcUmg2tvhzhB8AfLFpohXHY2C1WZqqnfK4Cnjs2l0wgGuyMFhPfQ9n+BNoBE0HECX0qS04wMl49rWiXfMySaiVQYkBr/PNeVKdbeS+LhbydsnN3FE45lfcgSadprXB2Ef0w+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK0Bgke43ryObP7uZd5aU1McM0lsKWnvaz/ZjI01hR8=;
 b=r/ME3wuXslTQbalRk77WDK8BEJ+EGHnVQTlLJ+iYIax425lgrIWzWHYJHwJy60Ty3J0dG6HrzlbOVgmLSr5oOagLnxGOKoNM09TBPItgFHb1pQJXc3i4FhQmHd4OY9v6TOrRUrA2dI1mnGUeTCXDdTdZRsuB3uTJgCsp64vXGCvRLh++W3NeHlmqM4s1oP5QJfUAnmMLGQBybyZcBZ8vTMmJFhansG05uyFsMe35ABYzyzCRIl8ZFgjllHSYOloI9pEZfyUW07+/pBdLf9oHFIDT9Deaz7q1HAfMr/5oj5Uk+ju+Y1OOVTUwJJURMSNplC75gqv8uIv+ZMJhi88W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK0Bgke43ryObP7uZd5aU1McM0lsKWnvaz/ZjI01hR8=;
 b=llvi/z1fmcImOg2Gq1H7jVT6Y5Gm4qM9vUWm+e0h8uJTTevFIP8Z3oY3C+dMknBU5vOeF+UP5BJwrn0dpVqiE8RJvKC8IOLzVsD2H3mzhXwRVB3dtE1XKwQmaOAc6g1zP1Hg2OwPS1ho0DoRm7okpuwayiydWH6EkrXVkDyefqc=
Received: from SA0PR11CA0127.namprd11.prod.outlook.com (2603:10b6:806:131::12)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 13:28:25 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::cb) by SA0PR11CA0127.outlook.office365.com
 (2603:10b6:806:131::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 13:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 13:28:23 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 07:28:22 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.2.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 18 Dec 2025 07:28:05 -0600
Message-ID: <176606448528.3817911.3342486802813319897@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4563bd-3f50-4abd-7f9d-08de3e39518a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V24wWEtIWTRqZC94bitRTjJCY3B3ZjNkVnhYdGg3RlhBUHNyUzBpVER0ODZY?=
 =?utf-8?B?aTlrS3AyQnZGYS9jak1RUlBacUQyN3czdHYzVjdTd0h0eld1aHU3eWozaDND?=
 =?utf-8?B?MTEwN0F3dWZqV3c4dE1aSWFjVkJjaFl5S3pkVDNJUGI3cy90OUMzclRPdEdi?=
 =?utf-8?B?UlNRdFhtS0lCSWJ4bElqMlNVeVQxZFE1T0JuTVNLZWt2M2htZWJEYmV5VmxG?=
 =?utf-8?B?Mk1TV3F5Yi8rN1ZuWmUyenhhbTNzVzE1aVFOaEpLTWhPd3ZiSUJXTXlYelNG?=
 =?utf-8?B?NDcrTXJsOGtwZGZ0NUt6Y3p2NXNvUEttbktmNlVjSDIvVU82L0hOWDhrWFdi?=
 =?utf-8?B?aDVja3FhZ0JyVDFSSUtvTVdBeU0zdWVNQXBVYzVSNUp1aTRKMk45UFpOcDU1?=
 =?utf-8?B?NmJXR2JWR1hBVTdaM05NVGtqbHJ2aFJkZFJBL3FibTBrWlNjQ3o2Wi9jd1Zy?=
 =?utf-8?B?Nzc4cy93WEtZZlRhazZwMXJ3cURqRUIxT28zK01PYTEybmZibkh1eUdIem44?=
 =?utf-8?B?NjFpMXBqRG4zWGwrb1V6N2I0WWFyelE2NXA5MDJxZTAwN2RsdE5ueEdKc3Z3?=
 =?utf-8?B?dUR2OFE5d1J5b3orWVpnYWN0bmJGZi9GSjUvNG5vTE9KT3E0bVo1QjNYQkkz?=
 =?utf-8?B?TVRTVnBHSk9CRVhPOVZTSWFJS2x4Mm83TWVwRkNlSnplVm95MVVLSkhoSXdO?=
 =?utf-8?B?M3ovSTczbERUaWRyV1JwRWxOUXNnRGtaTnVtaHk1czVCN0xvaHVnRWhPV0J4?=
 =?utf-8?B?MTdDYlV0ZXU0alNOUTZoUDJPRGhucFpnQ1ltOTJscUlNcG1VMFRYU2drZWxX?=
 =?utf-8?B?NXg1MmJzWitabkdMZ241eU1sMUhPRk5ZSHpMTDYwa284eWpuRmxFSHk4VGxq?=
 =?utf-8?B?cFRpdnh0UFlSdW5FQk5KMnZqQzVGZG1namN0cmhrZTcwNDg4M3h6STJNLytZ?=
 =?utf-8?B?UTJucTJNRzlveXhtQzhqUW51N3JpTGswQUMvQitqV3dUQWh4MjZhM094TWR5?=
 =?utf-8?B?WUxQSUtwbElkYkJKRUFFWnB2T0gvVy9IMnNqKzlJUy9WQ2VXVEFWeGhoNjE4?=
 =?utf-8?B?QmQ5cnNzcmNSWG03RzNHQUc2TGNyNEdTWnlhRWlDWWVCbVN1dWFNdjg3blpB?=
 =?utf-8?B?VXVpdWhBbUJ0VWg3VUF4b0hwRDdNaVFOb1NHRFlCcXgwMnhiSUs0SWpud3Fw?=
 =?utf-8?B?UXEzZ3lhYzNuVkRCWmJRYXdXNkZsQWdCcnllRlFLdU41ZTBxVFJRYmdYeVpk?=
 =?utf-8?B?Z1ZMTzh6TloraDc1YWl4Q2V1TDQyUXVPRlU1UzcxaVVWMk9BM3ExUEZ1eDVi?=
 =?utf-8?B?aHQwcUI5S3dWT3ZiN0dXMFY2N3dVNGRmeG9zNWpiREl1dUwvTjBPRTVISlBO?=
 =?utf-8?B?VTljTU5LVVZhN016OHZYNllhbzdSSnROcVNpL1UwRnpWUld4RVltdll2aEpD?=
 =?utf-8?B?QVhiblRMeHpFT216RGxHTG13NStBUTNPdGI4UGxJTng3MVc5OUE1RzNocGJh?=
 =?utf-8?B?cndtcExHcnFVT05ycUlzTXFoVy83dGVNTDQ4UHRyTVNBWUdYblFmb1g5aU4v?=
 =?utf-8?B?WFFvcHBEMkNiREp4cUhFTTB1alVCMk9Va3BVdUhhRW1seG1pSjJXODB0MjBV?=
 =?utf-8?B?UmR1ejNnRUJNWU1iMnVqUndmL2JOWVRaTWZRTW12cDJlT0gwYURWK0RZb01L?=
 =?utf-8?B?THNEWDNPUW4zN1dCbWpURGVRUE9BSHJ3MjlNNW56bkpRaTN0SHB0akJDaDVB?=
 =?utf-8?B?ZGFvbWllN2NETkN6bGlJK2lKSFR5c203dDI3eHd6UzEvRnFldlBTNlVMNHcz?=
 =?utf-8?B?dFVkQVFqbUNrWmkzNVVSZVRzc3RqM0l0STRsdVJQN3lZUDdPYWJFcFZrR1NP?=
 =?utf-8?B?dWcxZFc5N040SDI0WGZIRmRaWE5sSDFWM1RkSmFOYzlBYWxpUWF6czZ4OWxD?=
 =?utf-8?B?dUhQRldibm5LdjV5Z0t2dUhvem00eU9vOTJNK1A5VkZsWlgyOTlsclptNFNN?=
 =?utf-8?B?Q3BUWGdNMGVMd2J4WHJCdkRCQm1vUTZkek9GNU11MzNWQmFiaXE3dlFlVXRa?=
 =?utf-8?Q?8uOOMR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 13:28:23.4673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4563bd-3f50-4abd-7f9d-08de3e39518a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
Received-SPF: permerror client-ip=40.93.194.39;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
fifth release candidate for the QEMU 10.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.2.0-rc4.tar.xz
  http://download.qemu.org/qemu-10.2.0-rc4.tar.xz.sig

You can help improve the quality of the QEMU 10.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/17

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.2

Please add entries to the ChangeLog for the 10.2 release below:

  http://wiki.qemu.org/ChangeLog/10.2

Thank you to everyone involved!

Changes since rc3:

bb7fc1543f: Update version for v10.2.0-rc4 release (Richard Henderson)
00829ae384: qdev: fix error handling in set_uint64_checkmask (Zesen Liu)
d7e1df7699: gdbstub: Fix const qualifier build errors with recent glibc (C=
=C3=A9dric Le Goater)
dfe87815ba: monitor: Fix const qualifier build errors with recent glibc (C=
=C3=A9dric Le Goater)
e37a0d514a: tests/vhost-user-bridge.c: Fix const qualifier build errors wit=
h recent glibc (C=C3=A9dric Le Goater)
2f5c96d534: i386: Fix const qualifier build errors with recent glibc (C=C3=
=A9dric Le Goater)
307bc43095: block: Fix BDS use after free during shutdown (Kevin Wolf)
b002acacc1: Revert "nvme: Fix coroutine waking" (Hanna Czenczek)
ab0065e36a: tests/qemu-iotests: Fix check for existing file in _require_dis=
k_usage() (Thomas Huth)

