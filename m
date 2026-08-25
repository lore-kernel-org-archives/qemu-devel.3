Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD06C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wytyq-0002GD-5R; Tue, 25 Aug 2026 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wytyo-0002G3-7L
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:26:30 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wytym-0000sL-6c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:26:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgOtr9gnbaHkAcA/0eM+bzPYEbkiVfkiiPdoVNvHTX6+9LUB5l+X64GFb8U058/GmfkigMC/mpeTSGRSsjLOdEnjLBCxtcluO/qYVvd1EFogl/ersrwO5Fd4+rxcPvbyXc0x/ewLBMLnt8T/s28Wr88ozvy4NgbuhvGrV+/80COhfXHWEHTTnyeZ2QjIDPR4N6EkqhS9T0rxk7g89ZFqOLv81PaL5D2RG2G4a8WLNohzlz3yNfeQwwxA0UrO6ks1hkP4nEpPbQED5sqlljdR0Sk52JluM9UOv8BJ+hp/A0SOwWelsJI8viBlma28gz3hGla1NqTJdISt+fHtxuGdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNEyf+myGjSxr9LiSllR1ebT1osv+8kADJL7lKilb40=;
 b=Q5/lqvYDq5IGDPAWEfGbj/EqkzAhTYufzaMIKo+rWy12ub6yJ05hlQB5gElSNpfHC0IHxhb5S7MmXYGSGrucjyZEUIsEhwZhf4QqQ97bNZYgi+jFb6fYbn9p7u4azxbYuLzgu1snnoSWWL8qcP3HgSd0gX0OnyVHPW9FsI/Y7cM3j0M+tZj9mFvvX88YmUYuw2t71fSNRHI/8N7Cy1Uld27PUeU1hpF3HNtNn1DOLU7b6aZPD6KLd9DlcxOfjfj7o/CThBRy63RzeFf7tC5zlRk4K6tK+nkr4L4hrYhZ1SN/1x1vuaR2BTTu0bdXIHFGVc3UJlp62YEwVqWQ/D4Vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNEyf+myGjSxr9LiSllR1ebT1osv+8kADJL7lKilb40=;
 b=49V4PUxgRAQ7TekiLtnZnag0nf6Zg4emOC+/7D/9iRL20TPhluvoc6PNePa9HEd+FJbBrmAWmSK1BYI173Ix2V6Wg43RJT1Jfx6HnMYbXZ4YZG7MyyQlf7HafypZsokwl1KkXgAHwOtmxgl6GGpmaZKzT5eCeHCkXeas0dTq1ZM=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 16:26:15 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::85) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 16:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:26:14 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:26:13 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <babu.moger@amd.com>, "Ben
 Cheatham" <Benjamin.Cheatham@amd.com>
Subject: [PATCH v2 0/4] Add Support for AMD EPYC Zen 6 CPU Model
Date: Tue, 25 Aug 2026 11:25:40 -0500
Message-ID: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 533830d9-8545-44db-9b97-08df02c5950e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 0BOjSdlUiHb6XdT/i3uNKQnUMIUjWkcyBqt+3wP6tP/aR7xqUFPLJOFFD+J8JBisckt8J3f9fzC0OtwsuhhxhaCWIBYPUrZ1AmA2Bd8SznLdet9LDSl/8wnNNU1SyQ5XU+2rKF3fLyT60Bucm3CJZyDaWH8oxhVYlCjm3UvY+JGrmBawUsVrE7mxBhi4jFMLcoOOvwxth9M6DTVnON+edw1zVLGl8pBSCV2ddbeCa5w/bi4tyqcjdtoyzp9KmuOlxcBGJSrQRub6S2oTe4reTcb2kQovuIou62hDm3NyK7j+grAGl+7oYF5+lxrC1+xyI8NY8WBVlLfG0uo+FJpLI2H4s/tQJh2ubqw/KHKHEj0TXyQu2BS220Q3E+b4PDdzNjWppqVym28uKjGR+DMKGzyYYnk7AZDucWaPPihmX1EIV8rKjiUiJwXYpqzRJhDdIowXRROUU0V2PNjNT31GsqvEWk3inyy4XZXdOAb/dtZEPllFwzve53KUtUv/ERZkfDypN2mZ5byfN9gwOuFJ+xIiPXzx1U+J42qcX3j4ha/r4gJRJ2SuB6frvWm7/TLc5EDBiDJ5kXIPZD45cboEWi2vNEnt5RnnyKJaljZbdWm77GKPNeqKyzUCkr+OWn5GjslX4KhNrCihviZaettwboHI3/Z8TI9QINOkFAODdz09/ycZXs+OzxKr0Zlm26g0myaPKSJrUKlaZVE5IgcfTA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(3023799007)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B8HfeLDOdQwE3oak56pHOMxq5sHYDZgCqQGGWoEaMtUSzUzj5a/iu9jcbZyJy0xDhGTu+xe+cyFgpUW7XIXjmxcIm7x0FK9c0rtwal0SpBkQoXMcHpRB3gFBYobRxOMzgjegS+/DBIcgEWJHK7yHWsEPlVtMcNNxnnWH0bHVM7084u7s27pAguL1TqCBnckcBX3X92THMlcqn2c+NGYw+I50KiKaE5XNCk1VYu6k24mZwEi1HW10N6ZTwTSZggZEHBHCtLC0dKPbMi4HasQhdQcEqpJ0NkwDJze1IZLaX6+2VDt4JZNxBchwzxX1i9IIl0WgUSOJpcwUZAAasps9OMeG3N8SWVpP1kKgvwsR1ikO0wbEPOKYO5Ey3jPWJ/GbylasjxpnQ6alfGG2VSlTo1vnNu6QQk37hGHRRXxzTumVkpBJ/7zn2nBISkrzXjZL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:26:14.1191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 533830d9-8545-44db-9b97-08df02c5950e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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

v2 Changes:
- Remove SRSO_NO bit (not supported on release hardware)
- Rebase on master (fd7ab698c921e2e97aa1b1d5b719d42103a2dd58)

This series adds support for AMD's upcoming EPYC Zen 6 CPU models
(EPYC-Venice). The first four patches add support for the EPYC-Venice
model while the last patch adds the actual model.

The EPYC-Venice model is based on the EPYC-Turin model feature set with
the following feature additions:

	ERAPS, TSC Adjustment, and Shadow Stack

and support for the following instructions:

	AVX512 FP16, AVX512 IFMA, AVX NE-Convert, AVX VNNI Int8, and
	AVX512 BMM instructions

as well as new cache values.

Some of these features (ERAPS) were only just recently merged into the
Linux kernel. It's recommended to use a v7.0+ kernel to leverage the
full support of the model.

Amit Shah (1):
  target/i386: Add getting RAPSIZE for ERAPS enabled guests

Ben Cheatham (2):
  target/i386: Update RAPSIZE definition
  target/i386: Add EPYC-Venice CPU model

Nikunj A Dadhania (1):
  target/i386: Add AVX512 Bit Matrix Multiply (BMM) support

 target/i386/cpu.c | 151 +++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |   9 ++-
 2 files changed, 155 insertions(+), 5 deletions(-)

-- 
2.53.0


