Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DEFC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMFt-0001Sn-SC; Tue, 20 Feb 2024 04:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rcMFs-0001SU-DX; Tue, 20 Feb 2024 04:17:36 -0500
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1rcMFq-0004LN-7w; Tue, 20 Feb 2024 04:17:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFUTHyTQP2dcSYCb1SvV3ijZ9grw9V8scxZpm0XXAD2iTqX2WhHzowZFcSEWh/s1JAzY1TGhWn9YKg7QK+NtRek/JBnG+VnUAZ6xa6G4wg605tLQwcSuBfGTQlpRWY4lJN6wtIU5DNhVHuZwgjjxqPOn2BBerbzpkIOdoQTpeViQQBcTvmaExbHEsHuM6VDeJEbvYIjOQE80V6HkhyHq+LU4oYazgJAlJAijH6rUCUywaF+462SJKgVJqaw/lG4pvY5pXIuebSctdHbGw78f3XmQXtMxlEErcPbCBJC9blhG22cdeJKn2pMcKhqQddFJvDVsgRgsLCPZwVQnCDiiww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkMOjYGwbM8JwIJAAyX7yMvEzDX+KLpy0ANZ7XB4HUk=;
 b=mSJUJPnVV1lmVsMCpzWsz25THgDElWFzblCGWF6D1szZ7zJoPrW7xkWfRwOz+1mHjbEMguHf7gKgoK9RHa7AKWlEBzoZtoBodYw+k0/ARsZMUj31gDkAbQgjda3JhdoJf7qr9vsGzQvKfPIPvCrgLIB+D9fEnOnrPc4x3782F5eYOTPPYC4uto3bmdX1+xO5pvUNRIO7Zmi1O0S1woa2RfyZ7v6emQ6LEnuYWjhR2obF+E2nDRlf1sT6zvVOPT3DojloK6UZnPR3CBUrEb7DeMHxGrKxTg1Fw9Cku58FqJpv/Ia1erlAaSFHmpb0FHfQLJVWJ/0PTP9jvIncHZ2UVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkMOjYGwbM8JwIJAAyX7yMvEzDX+KLpy0ANZ7XB4HUk=;
 b=HBc3pNTuiI/JbZtVrZDF5ZXj+G7k664TkkfapxI/8nAnoiKE6xD3jrK09hA5H8AW62i2QLwtjsLlmZ4iXroaN63ZkKs3pwHN5PL/R3Kb1ZXolsZTFWBLvNvDanGw9BBn+8UiJlEDYn7aqa8epYC1y7M1jG8s50+xWog/IThlnt0=
Received: from CY5P221CA0120.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::9) by
 CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.20; Tue, 20 Feb 2024 09:17:29 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::82) by CY5P221CA0120.outlook.office365.com
 (2603:10b6:930:1f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39 via Frontend
 Transport; Tue, 20 Feb 2024 09:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 09:17:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 20 Feb
 2024 03:17:28 -0600
Received: from xhdvaralaxm41-docker.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Tue, 20 Feb 2024 03:17:26 -0600
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias
 <frasse.iglesias@gmail.com>, <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 0/2] OSPI updates
Date: Tue, 20 Feb 2024 09:17:19 +0000
Message-ID: <20240220091721.82954-1-sai.pavan.boddu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bc85e9-c2e2-4da0-18c8-08dc31f4c2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1LeBHjWjIjkIdR18sWFeRn66PROM291Ot4gA7Gg55K5RPoilu2SrXtUKVRlE9RXli0E8STyCUbTkpjgKkSqXDAXB+EaPWW2FKIP9iEJmDXFbAhCiKCneigUhIW9+OrcqER+XdMY3HjP7XDu/7P0kBl4vy4b8KNejARtUHcLrz3w8CujyII9gnKudTZWGPC12f8d2aJC2tPrLpPEBtrBqtYdmCPVfwdjEDWSEk020x/QWMxkOliLScpEicvP3aN3Ome2v2wBgyG9wsnKPqM5tJ9aPv8BRskuIUd7aWd7gOQZgFBkbVZGpSqmIfhd7/+m7glf5l54ZDioDzfbBdAS8Ojo09MQyjNaPyybGzpWl5FuPcJwjJwEWOnOrCuUefv4eY7sdMPrYJx/TQtMXomqusMKSpKLZV6CJikhKb5ytATnEVIAbUee1KGhJbQvP2guHIUofUBIrPxhaw/FfwBsu1iFvsi9gnebxd0yD2WtYwth0UEkYMHox1RXZ4pYW9fCnVpwn7iKvSZaaRdclqG7AwQTczPINUvIDSJ8AJZaUl0GybtnByJA3Ua9fPzFQWZcZ6zu5xf102rcdtS/wtcI8kCzaEkVtLihoEL6ypAx52bIdWqfwWgxuq3Eo4Wm50JrcvT3vuolywNk1Hvr3dFKr7M2sK3J9/p6r09oY6b6VAc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:17:29.1822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bc85e9-c2e2-4da0-18c8-08dc31f4c2fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
Received-SPF: softfail client-ip=2a01:111:f403:2418::600;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 DKIMWL_WL_HIGH=-0.072, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add a new 2Gib octal flash mt35xu02gbba. Add an interface for versal
virt board to swap the default flash.

Changes for V2:
  Added type checks for provided flash part name.

Sai Pavan Boddu (2):
  block: m25p80: Add support of mt35xu02gbba
  arm: xlnx-versal-virt: Add machine property ospi-flash

 hw/block/m25p80_sfdp.h    |  1 +
 hw/arm/xlnx-versal-virt.c | 44 ++++++++++++++++++++++++++++++++++++++-
 hw/block/m25p80.c         |  3 +++
 hw/block/m25p80_sfdp.c    | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.25.1


