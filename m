Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F88FF36BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 04:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB3nu-0008EH-W0; Fri, 10 Apr 2026 00:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wB3nt-0008Dv-NC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 00:49:13 -0400
Received: from mail-northcentralusazon11012026.outbound.protection.outlook.com
 ([40.107.200.26] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wB3nr-0001rk-BV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 00:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA3kyKg2+7y4EKyqbuZzwrKZVM2Q2MatJ2bDEKYNoqjJhdDds7c1dqKBw7h3ONE7Mc11BAvjv8Q8tPO+sVoWzw9rB3l2ND4gCfEADCKT+cN39X2w8b9QfApIIUDirwicvztnLYIwKnturTA5ajKEoHn+FpZn3kbcnrQw1YShzF+aTGrOm8ZCDs54kxWbr/sVZDPBLxJrD7IHOWGhLJoMqUUq1dzdoF3nlofdxLTAxuoClZeDWuzjIXwKvTeGJwlMsjfw8h13/YADhQRTLZWA0py75zit/chN6BuIEbqhvk+ruwUQ+kyab+H0hu3jYOb/m+BPhroL5eTbByckaEp7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVXrEkKFBlEPdH3NnBMpvP/UgYAtSogqLHLUWPRoLvQ=;
 b=deXR0lMkEVo5uVdBIAkiJyJMRLNWvLTLJJ+F47Cve/x60o9ZEbtdL2+9bnhx6ggdw0eTsSlwEbIxLRjTqsfhYdsvCHyR9nADxc+eC42Y8LtPrgNXyH/dPH7vD5S0D6nB/1u7LuMJn0NaPdYHzT545hKQos0GZmdseGvr1QSVAo5cLmHHUYSCACB6i6ZAWAyk+Ah9egLRWSyoS5q7XznGnmogcZbIRl98YxKCz+OXHCmTmKFVAp+juxYRjvS2hOzh9MJCHnqKS0UPxlTFT0UQcKPky/WQWzwbwxCffwbyl98Zd6ijM6TK6Nbd/dZGX381yQtVyx8VlVlcEOslIaU3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVXrEkKFBlEPdH3NnBMpvP/UgYAtSogqLHLUWPRoLvQ=;
 b=e8xYl0do/lLwdLH54g96YCpHc5VSTk5PQ4H4At2B6kHPLpNLIlp3IQ6JJxTNaNu2CQB+JtQmiL23skeeeCg9qqcZQDR/U+qqPzZ9y0QilwRbxkbGdnBbnmIUDd6XDNKvCnolz+DhhbHel1WPAoceeEJSarjtAozQ5BCvIevgwJg=
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 04:44:03 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::f0) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 04:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 04:44:02 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 23:44:01 -0500
Date: Thu, 9 Apr 2026 23:43:42 -0500
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Subject: [ANNOUNCE] QEMU 11.0.0-rc3 is now available
Message-ID: <o3rq6wvjn4hantt3eniwctu7xshqhifiwbibtjjepmdskpv5z7@26stv36tybrd>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bf8f620-f87d-4fd6-36f9-08de96bbca14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JLGKKeakDBWDkzoDf4rbmS8rh4VK0BeGxdMK9kvRf5K5GM18UnUdvHKcWnQI+ViGeMsJp11vfE7bflo3OKh5VVhMEvfHx9JC7c2nCSzfdCRXjC1oGfgN3OTUr9M5cV6vm8tEGJKO2wnLPCym/+IFw0Z9rqH7q7jZA8vQlx4FDMK1lfsrOBGaVsE6AcYTJEpsIF3lRxkjWwGYEkXKdszRb3W9BqyoCvKlgt1lin0sa7pQTv+SknpInnNndqNjNWbhNY89pmQwPHVRmmbLxqeSiICqLrZlkBpiAEFXOjHfC8wznzSjEENkmhcyEKuQ6Qr+i0s9bXcR4c7IV2uiLNj4/GV311ejQLTE9IQAq+qgk1Eq8yPwh9AQGI94lA2oR6eoRW5l00twnLOvXSZFxQOxaEkonegr1zB0lKpCYN9+p7lYU/L5NhyANjP4FhIOWGRDldzd8NpynQBP6RTNEUUdl8thTxu0+awIcfQCYebsRt94VdsvbZ4X8H7tmNVToKrjnwEQJT4zs/5IzMSihkbB0rUk2VfvG8vHZ09tffvv2aRMGYZr9TMtPIbSoJvEC9DLUT29lLSV/PKNpjzaIFW4TAVb2n9XlqjaN1U533tsbkOmmYeqr7YYlaJ2J3xzPQa3M5Y9HLrla2xHEz4xsWCTuL8fxepbk5coVkBFpdjocLDX7j/FYm11KHG2bz9hsN0Dbvt6Z/IY+gdLl1QsfwmJ177YDZmoN8xxAp08/NdIB2A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uq6lR7RXNJZ3UV778+GQWEWtO/aGyVJliYthqsmsnJMRSS6EbV9Y46+XIRENvbJSK9wJGICJ7QHNq7MdXhHF1ycghX0CMXgpt4jyKpUlNbmYLpRxKS4ANS5405XXD+THZKevkYn9LjCtYGHhnq4qoYumnAI8JgJx/dr5h/ODtAv+kxBdoSRqBfGOG8i7pcTIk2gSsySU3b1x//CUdu7fZx6q1lZ6i9is9h+ok/JEBjytp5IZcS8NWVVZ98yWBNN1guHjlv7dCrhO0bC8GdsM8YkFsq5R0SAOd/+ldIO9HfLWnomj5SXAODJJlQg/S/2+veS8G6Lr/bjxAqbfxMw93UpNHdwAYWr5baUIr8rtOxp/aEtG2kpTE1wp7fxVrExw4wnIpC75rlITwma+XG9FwNWtHxRkkIJ5QhjTVjxt0CGA116Pawy1Z8zyRHN3kQub
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 04:44:02.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf8f620-f87d-4fd6-36f9-08de96bbca14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493
Received-SPF: permerror client-ip=40.107.200.26;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 11.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.0.0-rc3.tar.xz
  http://download.qemu.org/qemu-11.0.0-rc3.tar.xz.sig

A note from the maintainer:

  There are a few patches which didn't quite make it into this rc,
  so the plan is to tag an rc4 next week, with final release hopefully
  the week after that.

You can help improve the quality of the QEMU 11.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/18

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.0

Please add entries to the ChangeLog for the 11.0 release below:

  http://wiki.qemu.org/ChangeLog/11.0

Thank you to everyone involved!

Changes since rc2:

becd22fdc2: Update version for v11.0.0-rc3 release (Peter Maydell)
4e6fb62fb0: qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config (Dietmar Maurer)
a34f546c5f: ati-vga: Fix check for overflowing vram (BALATON Zoltan)
c75b41f21f: hw/timer: ibex_timer: Update IRQs after writing CTRL (Alistair Francis)
1c3bc5ea56: ati-vga: Fix pitch and offset registers mask (BALATON Zoltan)
af74c9e46b: hw/uefi: fix heap overflow (CVE-2026-5744) (Gerd Hoffmann)
7997130293: virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare (Paolo Bonzini)
4e4832dd72: util/readline: Fix out-of-bounds access in readline_insert_char(). (Nguyen Dinh Phi)
17fbf3e18c: util: fix missing aio_wait sym in qemu guest agent only build (Daniel P. Berrangé)
cf634dfcd8: Allow building qemu tools on 32-bit hosts (Helge Deller)
992e01e838: ati-vga: Do not crash on 24 bits per pixel (BALATON Zoltan)
f4813f444a: ati-vga: Update mode on CRTC_PITCH change (BALATON Zoltan)
4bbe831f1e: ati-vga: Fix setting CRTC_OFFSET (BALATON Zoltan)
9b3faf0d49: hw/arm/omap_sx1: map CS3 at the correct base (GuoHan Zhao)
26f21f6e17: cirrus-vga: Make frame buffer endianness little endian by default (BALATON Zoltan)
8108793f67: docs/about/removed-features: Replace 'since' -> 'removed in' (Philippe Mathieu-Daudé)
8a9fa9ec99: docs/system: remove extraneous sentence (Alex Bennée)
566594f108: target/arm: fix fault_s1ns for stage 2 faults (Alex Bennée)
276b060a74: util/meson.build: do not add cpuinfo-$arch to util_ss for 32bit CPUs (Michael Tokarev)
84771c64a5: target/arm: do_ats_write(): avoid assertion when ptw failed (Peter Maydell)


