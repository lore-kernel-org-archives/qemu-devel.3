Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208C6C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrUF6-0002vq-Eu; Wed, 05 Aug 2026 01:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wrUF4-0002vK-4K
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 01:32:38 -0400
Received: from mail-eastusazon11011032.outbound.protection.outlook.com
 ([52.101.52.32] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wrUF2-0007Xo-2S
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 01:32:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUIhDr0P2zEH7KJpJf3ZDHyc2k84JFqZ6awhZo/Er3VKiNWN1IGJMqTOwyklesbA8bbIKxY5ADhgr9qG3VadNK3ud0DR+o5AqRVt9qxNjbY6a+rEViEgQAhFWHFu2WQVFAoxMvw6uA6KPfXwh7CmdkWPeyb+mliseOaJ5rLmdH70347nNHQ74INjWQpYNuaYZP1vDDnK5rxaWr7gFnyUWH2BPWDiJvshSZ+bmKIDQQcvfsVD0h2W6Xud6IZbiu5cN0vuESC4vQwIm353myIsfapYX5m7XiWvFEy0E3nDJrDlK/gUn2Z10Ib47YN5FlGkeeI3Rz97B22dZ/Zs0PIHhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/X3j+vLBycBqra0d59r8vxbnNUi3Klkubhz67O4PTY=;
 b=XyEWQaRVR1u68A3e5OviNXFkEtg402ACHSm64CVNrAnI07E01ncctTrzQto/6XL1YnysXR2rWs+XeOxf9qqWVEErC8hmxasJ+lw1j6JCezNz/vlmt/QC/xGbaRbca94nvBrnMX1aNPUrL3Q7NFt6ew9dDSx65JHQY9vl7C8WorR3aoVTmA3X6hcbDL/FlK8k4TlWv6AeXub8EjZCbly85XJTMgzYDl9CEYjMxhBn9vnPPgmmy+8ruvEiw6vfOlExl7uV17xYnlN0FvULI82BaxtTxJuu/3J4lU5EYqHthBahthrmUQ5lMLUGmU7mkWvNxXrXMTH52xJIk6GQlb6Ctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/X3j+vLBycBqra0d59r8vxbnNUi3Klkubhz67O4PTY=;
 b=je5PJT27QMl0w0JKoAr8eAL8tjMi3WUAe3uWVX3fDK7RqD4GADAXyURUZAfWbesCZRsQJUnbczsKBlJjevkDuwgG3VFjV6yQxTJ31732joPkMtgw34xGyCt0wusLraEmU7GGPQMk+Fx40swkxWByS6GfFk4cvy3naWl4zsDj5K0=
Received: from MW4PR03CA0089.namprd03.prod.outlook.com (2603:10b6:303:b6::34)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 05:27:28 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::5f) by MW4PR03CA0089.outlook.office365.com
 (2603:10b6:303:b6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 05:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 05:27:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 00:27:26 -0500
Received: from xirengwts12.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 00:27:25 -0500
From: Neal Frager <neal.frager@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <anthony@xenproject.org>,
 <edgar.iglesias@gmail.com>, <xen-devel@lists.xenproject.org>,
 <stefano.stabellini@amd.com>, <micheal.saleab@amd.com>,
 <stewart.hildebrand@amd.com>, <john.ernberg@actia.se>,
 <matthew.l.weber3@boeing.com>, <vincent.stehle@arm.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade include-order
 assertion to warning
Date: Wed, 5 Aug 2026 06:27:22 +0100
Message-ID: <20260805052723.2823538-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bc0f2d-cca2-446a-818b-08def2b23d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|11063799006|13003099007|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: /Z3P7akN7im+GzxTWp5kAYnL6QyZsZVIz+otKjWhGN4R2w16LIhEReH5uNR9ylFsaJk0eFYoUByBaCShjyv0N9KzbJdjKC6AR2dLUPoocgBLJv7ULlc9e4NBpZ9jqxcZDJH0H9MUP0las13iP0fPvri+lf70uFfvvkESeLTN0JAVMCQmG5R5HoN45tOe2PChyULr2dQ0224CkDWrGqDVt/FSM5g/xjSQw5stAZqb64Z2MxS6KEbqmk2ErtHUYNbUwhxqoHduYxd6fMIhxRmOkqUuKusp2tkkUihpTc5zOGu8219LGathe24rifqnM/MDaUGtFH12VplOmJDvuoApTGQl6esVRP6ecuoJue18CSlWLrsT/YFrM7LgzntQPYCeu9dJo9B3WM6FJKFWXHDeWWVAf/nEOJzSQX2scX7MnrLSsxge4Q2PS5KX2CU6q5l/WytV8OhTTvb13UhzjHHoYfuScmZJQu6SupNHsZAOVdlYgy8wl0Ctdit69pGHD/G7i39c833OGt5IKEkaqyjMKrZL7eBF6mL6d8ePdntEbAExgaKVx+zdkX1i6VWyCo2VSKbOzZBfbse1f2SFPVArYnbw1Ju/yr+vTQhHSTallgldsZB4LNfseGGnlmA2JBE1Ep8RRBrwoACRx2eMpJontEpPkEkeZNOhZiCbFhiVbfDzgYiSWUayxwFrIlaRTEcLGnv8o5U4xgh/oP2GcEXyxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(11063799006)(13003099007)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1K/A2tkKp6+CpEoquoBIHfxeiKXkfVqGeCjGN/vbUqV5HAKBcHh3k2Y7FPCZZ3yHyOwpCKuoaEoI7IH3HzJb9op9h9gllhpnznz9x6hz6nb1OOJ0anUmCqKrR/cCcJc9GG2hpW8PsrLaRMBiWbXUnUwvzOE0/pqjhcg0nPurWcfr4efk39Doo8d/N3rxV0krmeqEpEzABSXGf6sF26+rS5gtME3mKjJXA+aiUnXQ41aGPj6EUNOE1qhRrLdGpGw6T7qO621E6vA9ZdFsvqcfgV93OjaaXL4QTRPjTsIDqTHYBmtaB894WongnuDCThZo3W9oN59ayNV/FiPZDX28zR6x/CghuvgJv3nSVzY42Cv1XDCfPOKMNxrmB2D0gpg+4OgIFfEiHjZ9uWMHrMJAUe56FGlFxiN9H33K0ufe+I6gTdzo0BVLzOestAF0cJQA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:27:27.5347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc0f2d-cca2-446a-818b-08def2b23d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
Received-SPF: permerror client-ip=52.101.52.32;
 envelope-from=neal.frager@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The -I$(XEN_ROOT)/tools/include added to QEMU's extra-cflags causes
__XEN_INTERFACE_VERSION__ to be defined before xen_native.h is included,
triggering an include-order assertion. Downgrade to a warning since the
version is consistent in cross-compile.
Ref: https://github.com/qemu/qemu/commit/e2abfe5ec6

Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
 include/hw/xen/xen_native.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 5caf91a616..3e1137efc1 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -2,7 +2,7 @@
 #define QEMU_HW_XEN_NATIVE_H
 
 #ifdef __XEN_INTERFACE_VERSION__
-#error In Xen native files, include xen_native.h before other Xen headers
+#warning In Xen native files, include xen_native.h before other Xen headers
 #endif
 
 /*
-- 
2.43.0


