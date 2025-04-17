Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17436C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 14:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Pul-0003ig-9U; Thu, 17 Apr 2025 10:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u5Puj-0003iL-0x
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 10:08:25 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com
 ([40.107.237.46] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u5Pug-0007f9-6G
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 10:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPob4JAq4EgHoiF0QHLEuFusVXinUQKScVRDj19UI72p4EjehVD6sLqbK2bZOog+5fx8FFy3Sl/XSV2LPQpajhe9A7c6xxuKosoglx3Pv2/sx38ND3xfmtt7gK1BBC+pgxWx4vwErHKENMy9UIZvnjHrrhsydhynBlysEIwVh8GsR8yfZbP9pB69WGCg4VjZIYRZIIrjtXwrxqvU4JhdX4Uv0DcIcZA0OeT1e6t44VvQMRy2Sdp0uon2ZEA9+kVPPg7hjd3dfZlLFcPfJLW+eSeW9o7LSvth7x2+U2try6aq/Fe1V6v8WZO6uRLVFELu4mGiPg7yyO5Z/5hpLW/AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc4Aru52Yqgmknv1Xv0hXTZ2qVCPs+dstaEtvBckR9g=;
 b=FobsSh4euvpkk87G17/ZXhEKGwCnNuBi2gxe8Uvbl+OlVKrTEV+XUSt29ZXFjShfadr01g7q0IkuEDubU8NuVKHqcBa8+Wth+83AHpZCLjRp4UKxncK5MfoVxzDWIHeZueoWQ18qIQCAHy/+Xwg+WIjE2ml2iGM4TUdYPUlahfUaE3PaGT5DlhSz6epUcgRcxCKhcNCHMKxatx0GXFM/DkJtGUyI2a/8gbfR8JgbgzB2ZslgQJiohc5S0+zCCBflZFfq6kC2hDXPdQo+hQa2Q0OHCWyVvwTJd2xytb9J8JywKxy6bKBVe7Wquq/jyDA0Ec1k2WirV0Ylu7aU5jxrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc4Aru52Yqgmknv1Xv0hXTZ2qVCPs+dstaEtvBckR9g=;
 b=Ii9ERP0TUQ0BxynY3wF80DUofYWaqHdN89wXFOXc65EXORAUIvSkyYmpu/QkAWQNtfiMN267waXJdyoepaD1kTjUJqXsmzuZYiod6w8chvZUGZdFx5rm6gJ4mC3WGh6KE1mo4MCcvUHb8pvB6tV+PMVn9HxRBfE2nDlWTfL7KxE=
Received: from SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 14:03:13 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::e3) by SJ0PR03CA0035.outlook.office365.com
 (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Thu,
 17 Apr 2025 14:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 14:03:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 09:03:10 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.0.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 17 Apr 2025 09:02:55 -0500
Message-ID: <174489857530.3753920.12348493900787935207@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d37338-b804-4945-4b22-08dd7db8978a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW1nRTNRMVRlMzNNVkt0TW8rbWlDVjZQZk1EZndTMjg0YS91TUc5NjNKUUVI?=
 =?utf-8?B?YXBkUWVuMDE1ajJhdzg0dC9oRnFYTCt6ZU9PNE1Sakk2WS9VdzIxcmViL1hI?=
 =?utf-8?B?VEl4c2dEbUo2NVU0UWIvREg1SS8yMTVNVDdLUkJuRjdHNXpsR1AyS3g0TXNK?=
 =?utf-8?B?U3lYZjRaVU1BVUtQem05R1NvTGY3dzlGNXRDRG1LYkxENHVyUEVmWXZSOUtl?=
 =?utf-8?B?S2dyY0ZWU2FwUk4xVHJEZ2hLS0VIc0REK3AwZjJFU2VBTGlkOFluU1RpNWZI?=
 =?utf-8?B?OXBjL0RJeWtlU2tjTDFFb3QwendQZnd4Ri9vZEdNcDdQOUVhTFVYMU9ORENT?=
 =?utf-8?B?OUlWM09UUlFSVkFiZjJqaWFPYjk1RkV4WHEvaDFYZDBjMFlNcENQOGExUjZH?=
 =?utf-8?B?ZmozQVBSN3c4bVBSZnplVE9pd2QwblVuSGlWZ21FaldIUFhmc1AxMmFyQkVh?=
 =?utf-8?B?VE1nUk00b29uMWNkYmtma0JWSXdTb3NOYnNwbkZVNnNKZ1VNMlQ4QzMxdnUr?=
 =?utf-8?B?NlE0dERBS3kydGExOTFnUDdlYWlpTkNCZEV2bnIrdk40amFJaHNJc0E5Z2gy?=
 =?utf-8?B?V2lLZko5TlBFbzV2R1YzeWtySVB3RTE0OEhwVkVmeVFUV2FFS0xiYUpDRGcw?=
 =?utf-8?B?ZU5SQ0pvUGh2WDExOXc4Z21YaTRpRDJxZzFCNmlKMlNhSU5mOUxKTGdIakZr?=
 =?utf-8?B?K05xYVp4Q2tyaGtLTnpMUXdqSGp6OW5Ralgwc29NRjI5eXNRMWxjeXQ3YUsy?=
 =?utf-8?B?UDNhUzNiM0JOOVZUZXpvMkRKVitvS0FCTnpFT0NzNmd3eEkxcExoaXBrUHJY?=
 =?utf-8?B?NkNobFFoRTNieXpDVUx6bjUya1VKVjNWeElsa2oyNEtsV2gwVzRpZStqZ2k0?=
 =?utf-8?B?M0oyejBoTzJxdzUvTHVhY3RHcHMwRExmcXVDR2libjFvOWJQV29La1RkaDJR?=
 =?utf-8?B?QzRHVlBOeEkvM0tjS3lFUTNxeHlGQlFtdFJrVWNUZEdXRUVXajVBT1lLVFJl?=
 =?utf-8?B?eGQ5VkJGcTVmQnRrOFhXYkxZRlpXSE1CRVI1NkZ3OGhaSkp0UUhvQ0VteFR4?=
 =?utf-8?B?WHVUVTFZeURkeXVFa3dVd0JEbm9PNkNDR1hxYTJtczl5YnZlandNMmpaYk9h?=
 =?utf-8?B?ZTJuTGVGL2RuQVpNNWI2Zm1nY2JkcjVHNnpyLy9oZ29hb3lsZWxMSzBxTmhj?=
 =?utf-8?B?OXhteVhFSFFObXdNcXQvcko4eDlWR1J2eFVSYVRNbzRlTElrUnJIbDlwSFBV?=
 =?utf-8?B?WVZxNVAxTmV3ajNFejZqOG81TXJibVkrUU5KejVPN2NjeXg1WnEyQjhBaDJH?=
 =?utf-8?B?SktTNzljVnJidGQ5dlpNbDlLaVhFNTBBZ0ZBRWNxT3B1ajJkblZjK2JZcWc1?=
 =?utf-8?B?Tit4dnh6RWpCRzd5Z1UxR1pCSnd4eUQyUXVUQU9INUc5ZXgvV3VWNXphUm5h?=
 =?utf-8?B?MW10S1BsMlJXcUZmZWFPSUpXZVFoQUwzZllMNHNmenhPSmpUTFVidDV2UG5q?=
 =?utf-8?B?d29VcFRoeUdGMlVWd21XVUp0QWJGcEZiOU8zMEtyUmxKQ2JLTS8wY3kwd3FS?=
 =?utf-8?B?NjZxR1ZqTGV2QXduRWZHZ3JCSXh4N25PNTYrcEZaeFNEU3RUWDk4MW83TFNl?=
 =?utf-8?B?UFIyazRxaEdOb2hkMmI0d1M3ZmdweWpDWUhkYjcvbnVYU2h6OXV4TGt5dm8z?=
 =?utf-8?B?QU5uMExQdDVFenVWeGk2ZVVWcElzd09nUmo0bGx2THNLQjE0NXFQdlZvays2?=
 =?utf-8?B?K0xKMW1vZHpiL1JoZlJsTmZlRTI5SldnbnJoeWcvdkdaeG53TmZqWXdzb29h?=
 =?utf-8?B?ZVp1aE9Kc1oya3p4Nm9vWXFjVE5WTUhNZHpQOThPUlNhTnBZcVJhWUlBQmxk?=
 =?utf-8?B?WEQzQ3creUFlZ0FTY1JWd1ByNjBjRGt1dFZKQXZDRFBPbUd4WUtyeWt4TGZw?=
 =?utf-8?B?c2N6WWtIRGE2eHc1RVlFWVpWZklQb2pjL1kzT0ZkMzlMci9aaEwxTzZ6T3hi?=
 =?utf-8?B?VnREK0xVUXJ3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:03:12.4793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d37338-b804-4945-4b22-08dd7db8978a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
Received-SPF: permerror client-ip=40.107.237.46;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
fifth release candidate for the QEMU 10.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.0.0-rc4.tar.xz
  http://download.qemu.org/qemu-10.0.0-rc4.tar.xz.sig

You can help improve the quality of the QEMU 10.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/15

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.0

Please add entries to the ChangeLog for the 10.0 release below:

  http://wiki.qemu.org/ChangeLog/10.0

Thank you to everyone involved!

Changes since rc3:

a9cd5bc639: Update version for v10.0.0-rc4 release (Stefan Hajnoczi)
e28fbd1c52: Revert "virtio-net: Copy received header to buffer" (Antoine Da=
mhet)
8bdd3a0308: tests/functional/test_aarch64_replay: reenable on macos (Pierri=
ck Bouvier)
fa3f3a33f3: system/main: transfer replay mutex ownership from main thread t=
o main loop thread (Pierrick Bouvier)
f3ca7ca222: docs: Document removal of 64-bit on 32-bit emulation (Richard H=
enderson)
b0b5af62ef: Fix objdump output parser in "nsis.py" (Arthur Sengileyev)
22e6d70294: docs: Fix some typos (found by codespell and typos) (Stefan Wei=
l via)
d832ff9d02: tests/tcg/plugins: add plugin to test reset and uninstall (Pier=
rick Bouvier)
c07cd110a1: plugins/loader: fix deadlock when resetting/uninstalling a plug=
in (Pierrick Bouvier)
9edb9c2a6a: tests/tcg: fix semihosting SYS_EXIT for aarch64 in boot.S (Alex=
 Benn=C3=A9e)

