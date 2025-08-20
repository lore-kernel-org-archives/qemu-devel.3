Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA4CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 19:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoook-0006ca-3C; Wed, 20 Aug 2025 15:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1uoooh-0006Zx-Q6
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 15:49:51 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com
 ([40.107.243.72] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1uoood-0000sY-SE
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 15:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpl7Er6R8mZqllS7lSMLgg/etNewl1J1AQBPwEw2MCuslNgEt1P2hjBVvA8GX36xvUVSFKS82TXxv0EXnF9pcyIadr3oyRrlQyLlX6XI70cGhmzzqu8O384KSsy6iMsCPXggi0mNhb2SDEpx2QSBIzKxDE/EcTeCvTRxsVbz2nolpGgS68IFjAg6wREmCXugsomQPvvldnUFr4YW0UM3b8POL2OPyPFCP9alQXbp9NX0CkxX+R0CMoUPXDmBtK5esiR+TlMlax9Q0wzmQpapvZ1jiIdl22yzzd3iioX3TGMI9Qfs1x/cAhMjhRmKhxkL3jSLaM5Sv68W2A28IBOIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBq6OlmmuGd/roUJ+6FsRaPZ5L9exjQdA6Tf5HZUSow=;
 b=Gux8gm2UVmEnulD8wGRQ1leCkqaFWTccC/CfqUizOtlw1nO7VxNwMEnGxYHZiCQGmWFFqLk7kjJXsnKbubK4t4CbkiYG640HkKzsKMnlmPAZZVXdON0oZ7gGadqdNETyjvjHrMjCRlfRkJTQZjVOH23KXfBOepRKCc6sevsHCSY7Ki6I+unMQIviNYdfeu6YDFp27Vl8uznuyecN8w6YlmtggOr5e3nlwFlqoALxalOVAAjTNI6JcBwXDqGxEB7F37bbHMyOnNuQH6GN9Yx6o1LjJ+66GsPPGd6rDVZi8NiAkAxgh9p8trFMIT0TUqY5g3Y7d9w/4SWnsXGREjvubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBq6OlmmuGd/roUJ+6FsRaPZ5L9exjQdA6Tf5HZUSow=;
 b=wxYyojFW+fzGaCtBz1oswyZDj9YqLsRI4T2pPqjUvUzTsedLrDtN7OdvhwyRWnEFvRpJLlpJqpSmEDTh/6XvcBViu5D0k46lPKaL/BvT82feyJ3hZk6CO7b37hgYHbN3Uj+xpgXxdkZKiX9w6sOjIR1AnwSxzzQQndWwX7Mp+m4=
Received: from DM5PR08CA0033.namprd08.prod.outlook.com (2603:10b6:4:60::22) by
 SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 19:44:38 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::71) by DM5PR08CA0033.outlook.office365.com
 (2603:10b6:4:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 19:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 19:44:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 14:44:37 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.1.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 20 Aug 2025 14:42:18 -0500
Message-ID: <175571893859.41801.10552877216758241885@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3158088f-52f7-42c4-337b-08dde021ff5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy9ZN3NZc28vMTlBejY0cGk0OXFCZ0RYdE1LK2NiQmdvQkJ2cjJaV2ZseWVu?=
 =?utf-8?B?YitiMmVWN21XRWFKYzFQS0NUVENRSTJ2UktYdmJ3NjgzSkVJbSthSU1acmRY?=
 =?utf-8?B?N3FGYTV4Unc3Ymc4cmJXbUxNQTcrQnJuSkN2ZGdueldpek5vdGYxNGJjS0lJ?=
 =?utf-8?B?R2hRaDJ4TDFGRFBxVE52M2lSQ0wrTjNRMlpjREErSzlKbU4yTER2U1pPa21u?=
 =?utf-8?B?UFg5eHdHRW95d2hRNkI3aEdieWFzakFHOHVzOHBxbmNNak9nU0NHM2twbnFU?=
 =?utf-8?B?aUVSbkJxRHVHUk9rN3dZaStvUXBUYTcxS3puUERFUFFFeE4rODFZV2lGK1pj?=
 =?utf-8?B?elVjdjY0aHlQcU80dFlrVkJrK1FYUXhYYXRHZTRqSGtTcy9XNEJqbG9KMEdn?=
 =?utf-8?B?MnNrTW9SdEx5U0VmT0ZPaWN2VDhIeGo5eHB2d1dUb0xybllqSE5udlErT2Zq?=
 =?utf-8?B?Yk45R1FzY3E5emUzMTBIWXMvMW9LSSt1YkgwZWpXa3p5RXhRbDQybkpXNE5y?=
 =?utf-8?B?NjhRTjRzd1UvT1AxVzFjVGxSU2NTbTdyVUs0cnhzQUlucGFJRUhuVlUzdFFx?=
 =?utf-8?B?K3g2OUM1eXpGOFlpekFnM0xDVnpxK1FCdTV2RHNkcEkwZU1LUU5jVU1zRVdz?=
 =?utf-8?B?dktrMkhpK2tCR0hyM0V0OXZ6ZElFc2xBWmRLOUY5RHZVNVN1Q3FJUTdoL2JH?=
 =?utf-8?B?OUthajh1ZUY2dG1FRW1XRG41aDhScDcwajZMN0hFSCtsSWNjYi82Z1dSU3pi?=
 =?utf-8?B?ZDZoRkY2aHo0T0xLNDU3U2RWN0NsckppRmdYcDRKOXhhN1JuSm13T3hCSjlo?=
 =?utf-8?B?aFg1SDVpays4b0M1TGZhTVZ4aWZjUWdPdEs1aldQY09uQnYvQXdVdnlLVHpN?=
 =?utf-8?B?NE5aL0hEUmw0OHY4QjRSRWNwUmV0bVE0dmlWY1FqK0Q3a0VCdkliRVA4Q05m?=
 =?utf-8?B?enFKa29QVEl5VFROYkNlZjRkQlY3VWhyOE4xNUN6cWU5UHMyNEtKKzRlbEhl?=
 =?utf-8?B?akZZaHgyUGpBSmhxVU1MNlNDMVk0aUNaWHV2bU1memkrNy9YeFFKVFpBdXI3?=
 =?utf-8?B?NjE3amtQdVVncForemMwWCsvWEN5YjlsVkZHTkRQS0hpaFdjZGswSEpobDJR?=
 =?utf-8?B?emNIcWdzUzlMTk5OZzMzck8wd2NtQ3pXeVBJWUI0K0RwdUdmV0RwejFNVkZv?=
 =?utf-8?B?VExnVEsyTGNUVzh6NWl6UWNvc1Uwek90MlhTUS9mbnpJRENNeVluN0pKbmhG?=
 =?utf-8?B?NVl6YXFHcGJVZ01TTWNsNDZLMXp2OHExYnJ3em9EYzVNZlUyOXpHamR1aHla?=
 =?utf-8?B?bmtDeElwOU90VUVIbjBTNTVrR2xpdUZyNzZQdENNaDlpcXE1T2hpOVJKWGFJ?=
 =?utf-8?B?NkM0ZUpWam5jUzNTVkwyeWxLMnFUWDUyaVY1VHJCd09BOGZxWlNINVdzYzRH?=
 =?utf-8?B?MVZES3dTbVluYVNoL2NKRzF2WGxyZEFzY1JqR3JHM1grVjhtanArVUpBOEsw?=
 =?utf-8?B?VDQ3QzRERkZmYVVNak9TQXdUcXpkckFmd01CWVFQWC9XVXplWXAzV3IySVRC?=
 =?utf-8?B?YUp5VlpXVHIyUzFQT01makdXTTRnYWJHMkIrOE8reVlpNmlrMEMwTEZMWWlk?=
 =?utf-8?B?Z2RSc2RSM1lzM3lmNFUwSGJBUHU0K2hCdmtMNGU3OEx5eCtFTWt3M0ZVTlgv?=
 =?utf-8?B?cDNwYmxqdXdSbHNRQUtTTlBaWFpscWhKb2ZVdktjTlVBRjJtd29Ga243MkZO?=
 =?utf-8?B?NHNvcjkwUDUvK3ZiWCtCalBGdDkzdy8xbThDTkRTNmZVOFFxMHhSMEFWWC8y?=
 =?utf-8?B?ZHRGM1dhTHFqS2NGVlJWSzg4M2wxVTg3UzJLY2ZxTlV5V1d1RzdWaWhYb3gy?=
 =?utf-8?B?d0szaTNwdzJZQVdUeWxNcWh5T05sR0FTZlM4ZzUvNUwrUElxSFFJdlBMMUpv?=
 =?utf-8?B?WWgwR2NxQWVBZUtjemFaSjFvakdObWU1TjlSQnZWQ21ZTDJaNHBxTUs2Um9y?=
 =?utf-8?B?eDJrUUoxOTNnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 19:44:37.8513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3158088f-52f7-42c4-337b-08dde021ff5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
Received-SPF: permerror client-ip=40.107.243.72;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 10.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.1.0-rc4.tar.xz
  http://download.qemu.org/qemu-10.1.0-rc4.tar.xz.sig

You can help improve the quality of the QEMU 10.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/16

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.1

Please add entries to the ChangeLog for the 10.1 release below:

  http://wiki.qemu.org/ChangeLog/10.1

Thank you to everyone involved!

Changes since rc3:

88f72048d2: Update version for the v10.1.0-rc4 release (Stefan Hajnoczi)
faaaf017d5: Revert "i386/cpu: Warn about why CPUID_EXT_PDCM is not availabl=
e" (Paolo Bonzini)
040237436f: hw/uefi: open json file in binary mode (Gerd Hoffmann)
fc8ee8fe58: hw/uefi: check access for first variable (Gerd Hoffmann)
88e5a28d5a: hw/uefi: return success for notifications (Gerd Hoffmann)
f757d9d90d: hw/uefi: clear uefi-vars buffer in uefi_vars_write callback (Ma=
uro Matteo Cascella)

