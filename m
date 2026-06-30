Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA041C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaZa-00038T-6M; Tue, 30 Jun 2026 11:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSz-0002Bb-HF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:42 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1weaSx-0007m8-EO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afJSUp7qjUE87GMMOhA5y8IIEuokiTGov79ZcF3wkUZHROfOdOUz1pk98GjfxRzZ3sOvo2KdCR35zvCaTCyqXT9TKVXkjphPe/CpQOnVPLwOxXOR5/EUOlkSI21zaPLa14bDbiWfbL0gLuu8ZNKHITDVBWGjsGAfWImqZkRr/7oZg72mdKJUWFg5uFwp+RRABrry/zpQVJl1sPxStqV44c8aZ6jH2/AuibEhuhb0CTQ+fO0acS4pgV+iMX+NEx17V/jzP8ww7jMqk0kDyenLgz3/Iqfem7NACoYdRqHjspddblUkQzKFQp9q/hcf4+l96gPOe4XKGIfRf+2pG/jVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZczNUJqTj6LmWpq0VUzFmszshSwq6PW2ePVn4sxwXSs=;
 b=FefTn8iSEwWvlYSmLo/ruas+LK3gvydwMqfIL6tRtfGu/dbwUas6Tq2W4jITTATp1E1OOdRhyaNldpJ1HC8YGwh9BeMKTp6Ur9jMn3oovb2XA226QSkbGusyOdaCLDMdbqwG5+ChhjEoBbciXROTs/QynRQ8P1aSHOCKG11j1Cdz6XPp6gTN39AXuXCK21/StPTjjMMolKkvFjn8MKzvpwItFaGkzJABTUgkWW9Vv4ez2BwkC5qTwbkJAkVDNyDCD7ViyMW0dLTFMHLyafg+X/ixTnts2uo0wHj1ZOqKYMPs55QsE8YavTHgVlUPHHP9oCBFUzdg8Y6GZH8LY9c8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZczNUJqTj6LmWpq0VUzFmszshSwq6PW2ePVn4sxwXSs=;
 b=O8/LtTAg0RpJNZy1wp1nm/qPjRMkxcSiueI6UW06n5ukUi/ysAJxY4aANuw530ZMYRw5quJHBNbBRfam8W0cJUo/mnl7EB5Lp0sRRWsZBtt285hBdFkvz5WzybdvUh4/38+9DoHF1sLV/1KG+vXMB1VgMQqK1zGWDjdLDOFFJNg=
Received: from CH2PR15CA0021.namprd15.prod.outlook.com (2603:10b6:610:51::31)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:33:31 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::43) by CH2PR15CA0021.outlook.office365.com
 (2603:10b6:610:51::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 15:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 15:33:30 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 10:33:30 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <babu.moger@amd.com>, Ben Cheatham <Benjamin.Cheatham@amd.com>
Subject: [PATCH 0/4] Add Support for AMD EPYC Zen 6 CPU Model
Date: Tue, 30 Jun 2026 10:33:11 -0500
Message-ID: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a80be0-cd65-4470-a254-08ded6bcf067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jrLjY8gZ7xDWn5OXW2SzMsc7yrK9R3K78ksJtUqlF/KelAVNsnr7o19DjX1lswSmFetwFLt0/fRpjtgQv1Io3bi1fI1o/MP2I/ZZLMKOxNPNoX6xcuUgOUA1eYDKLB/ZBoC2hqY8gVCCIVqVDv7YplAUAQy72iyBPPTuBF2Ks+aL4Ync0lJTMWvsE0FDWJRqkuv2MMT/MfxRto5TMs+Dcn1vAd1U4lsgJlBzQ45YHOcW+ACySh1EDNdCirGF6cQ7r8rxlnEfWKnw67xNeSi+CrcPGtsXxmHNNEEYw6jyLOte3ixF5NfMq7z/2Wowmzr2VbV+E4CnVOLmw3q96hLe2r2BFfYV5AeSJ+xxZ55AzcC5P2rdkPgfoHaFYU/XyH8F7dZGT2qaYTAdMakLJ9N+eZpmY/XYMv+Zx1V6oql403EjCr5jr7FFscDajcbBYeBH4SFGh9FmwEFUvPU92S7RbIt+a/FfN/L2N1Iz4QTj0lqUKhWl6bmcggzdk1wyK8xxlNkru+9jmojD/1j22NXLP+TsvVVYe6/Wr0vvCE6iC1dDoW0ooZVKxpydlI+LzASUQFeCkmMBYLAyTiWszAeM+Tdq2byD+GLJVqmijhlFwGxbLqnM6VLA/1kb/9JFWj4jp+WkRkL8JrgR3bQ1CpVJde6bj0aTNlSapGRevt6A+nmgGI04O7Fzrxc8znMtw9mcqkH+eIqhb+zEV8tubIJwwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UgYtkUgYHoAlDAXq0Ah+15PteyBFNnrDs1kIS9FLFENJV8geFIIVZ7Ov4M/grfHz9Q5VV6N3HC/W/YPU2ptzFAOOFMilzZO5jFP5tekpR12U56fH4TS5J5xUBgqByWKAiPLRWoNVQW0Jiuv7lrLRX+mdu19NosL51dOUoEwpasw3DjdenkKABqKCSt5YOSag+lzZeKMjmaMd3CmakQUSRdE8WCcfqk8AlyLbefIjyW+d/o+dqrCxN+yM+Ils+dnK1XEzZCiJGLM5NrIBrJSHXKe0+22TtRdSRLY4gdm8EdvdpKKLymlNAhRFjjw7AAA4MV2t3o0nfQ+yjmMeHRNYRciMRRle5x5Y0gXyYq8++G9EbE9BcB+iVRZeepCXfNZWHzx99zA+6FU+mYFJ+GMKT0NITfING1CKyWlJnF7foCsVfpv+BpIQzU08FoqFziJE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:33:30.8377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a80be0-cd65-4470-a254-08ded6bcf067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:40:28 -0400
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

This series adds support for AMD's upcoming EPYC Zen 6 CPU models
(EPYC-Venice). The first four patches add support for the EPYC-Venice
model while the last patch adds the actual model.

The EPYC-Venice model is based on the EPYC-Turin model feature set with
the following feature additions:

	ERAPS, TSC Adjustment, Shadow Stack, and SRSO_NO vulnerability fix

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

 target/i386/cpu.c | 152 +++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |   9 ++-
 2 files changed, 156 insertions(+), 5 deletions(-)

base-commit: 10a9fa0065a3cd3dcf12e2eae6b8caaac6ecdec7
-- 
2.53.0


