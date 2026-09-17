Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3907C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Aha-0000rj-3y; Thu, 17 Sep 2026 07:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x756X-0007ak-48
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:56:17 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Baorui.Liu@amd.com>)
 id 1x756V-0007Zw-AL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 01:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cs2HNuBL3c6dVcZ2/X8Vy4fwRWdtZ0JVb5Szmam/IzOaLGfZt+z/hoRcfKjDGr24+9c0pzs0hge5ELIMMTg3+rUPCK5l8DqVDNuzVOINCO0KfOzENz/2u5Lwc5ojgOPKdVrmSQvQWdXeb2iOMygmnO1lUHocFqk+5VW9euEldZvERe2l0IycSUcASdI9RHynj//t8pXwy5eYCB+YPkyAa8uCp56Be39uPjIHUzmtZs5CPIMCi8VsfCFGbbyFPqlBuISsb552/umPCLiGbLatqOE8t97Mr7FzmYwycWpROaLWY0nR4hH5QkduNe0OmIBMYPNCweqxi52wCMGDsvAgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF+6TjHLTASDJ2k4snq/t4XokJGES40bhmPzulxd2JY=;
 b=D9GSCX3v4FpPMMgWSvFb5lRtnOvNK7VjgZGOVFNDeaVbIqvcH3WLRe6NtzjeTPmKsWKNv/L2d/u9tr+hWePXTwqs3qXV3y735s32y3Us/BE7InfyiGD9B8QbHNSY/3YQOYk8N1jF1vzv/VpPtNImSZTx4+Hj5A+2OQLpTpesjGpJs4pRLkQzvmbCVEOA2ctZT7egZnqJC2QOvWOhna4jk843dv1xyjYCUbkujW7j4iVxXV6Y02a84HZ9aKstkq1cgVzyaF02GThC+80RmkzOAyKzDBS1vCnmhtOKe8YGsf70JtpJfniGS25096y5CAfclg2ayVXCiQTKsUvu2X9hIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF+6TjHLTASDJ2k4snq/t4XokJGES40bhmPzulxd2JY=;
 b=AIzLWJ0ToNQe4+OqshOYC/vy43vaEMAHey+ofmMI+ni91gTbk0LX9q/M6oJ6y7T/Lti4woTNgssfuQKPduvNhiwSe846JQZmlkVCqFsYIVKZyD+EC02e63laVSE4Fmu7ohLrssc/8exBfW6lZIkNRzlZbraiTQXuFwwh5bB5C3w=
Received: from CH0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:610:e5::21)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 05:54:39 +0000
Received: from LV8PEPF00000060.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::98) by CH0PR03CA0256.outlook.office365.com
 (2603:10b6:610:e5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 05:54:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000060.mail.protection.outlook.com (10.167.245.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 05:54:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 00:54:37 -0500
Received: from localhost.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 00:54:36 -0500
From: Baorui.Liu <baorliu@amd.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Meng Zhang <Meng.Zhang@amd.com>,
 Baorui.Liu <baorliu@amd.com>
Subject: [RFC PATCH 1/3] standard-headers: add experimental VIRTIO_ID_CPUFREQ
Date: Thu, 17 Sep 2026 13:54:15 +0800
Message-ID: <20260917055417.495-2-baorliu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917055417.495-1-baorliu@amd.com>
References: <20260917055417.495-1-baorliu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000060:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f52465c-18e3-424e-e3da-08df148028f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: n5Qz7Sh1ROPRwwHYnDd9hNc9+wsev6sv2y7HbaJgBQoOBFVh2xP+aNOjUu6ldm8wsKo3vkaTU73x/PWkZkH27OMaKyy8BR84nObbiVe6gxXgaBb761xhhVPq0B8p7jgW7JwsJcZx4VfzndNIKNRmbE1TesSb6YWVzCYzc2kc9ynwLmNgpIp73OItZLTMdYIKB1/2oPk+9qA4RDBEIxFwOZlQKu6zVvPTNKm4fkKKT4E+xc+2FO3znVYIFr6MyyyxxrD83VmebBKZ3SessfRkdUWvf81xnUHE3uNl6GbyJam7OzRBqHRrruef3clqxffNcSo5ff85djyTbxj0878vKUJteaAUlBckqKeusjMVHyIUQGms9jja/5StM3HVlV/TQ3aY9B75/WmusDrxziv+clP86wWCNVgpWJaQlXSxiQUiqDioodBf6Deq+njYz2rcMCqVkFx+r9ABto61CUUjmJcWqYAv94sHAFC3HyFctB/wWQ6XiV2IR5q9Jt31Wkua/ngwUkmk7+9qZmGYRgF35Mu9w5sV0nlw7WtG8vWu5RqP+a8WU0mDSS/RNwT9ZYffMkNOyEMlUASfPxkb+M80pt6tNIXoBc4nrdGtgEW1ghhM0u9D0QSe5VVbqck9WYFlSc1w0wUSYl6XO72I/5zZ4YulnjVN3f1eNnV+tJ/dldK/T7aRc49t3D7J83DaCQH/+WAHA8g5Kll2Yx17+DVUzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rw7O6jyLwTu40xgeYrw1H0oOdHYL2olg7M1XvAuX/xnl7UHyGArAwxHASFMNneTo6mYXa1dhAbwSIliMrh0aST+UnMDNZtfCUsinjrs3Atvfmp9ycKy4X95q/9xTwMWejOQ7gPLLrwH/0dQ5SEPsl+63G/MxzAxppQIXsRf57AKIejWONrOWXHqmqOHFvZ0Z8W99vrpz2yBTmI/hmclF/HvHiSmKATeldAFnMT9IEBYm0D/GQ9DXOGf5vnQFgIOH0m2oE/J3/x2UqzC0FQHnONW52jV5XFX2VAb7OG8oen23ILfEdrsuEoeNCcaRSPaBiPBJNuUmNJvY/w2dqyd22OuwXGBOu7qWOwXxjf88qeec2me1Mp1BMD6/MrJfWcy0c5iCFRDQVASJvgxHFOoKBig13siCfz95edf97QL0rb6sV1Gps51ibDQH3LsVyzIp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 05:54:38.4780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f52465c-18e3-424e-e3da-08df148028f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000060.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=Baorui.Liu@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:54:51 -0400
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

Virtio device ID 42 is not yet assigned by the virtio specification
or Linux. Define it locally so the Xen virtio-cpufreq backend can
match the guest frontend.

This is not generated by scripts/update-linux-headers.sh.

Signed-off-by: Meng Zhang <Meng.Zhang@amd.com>
Signed-off-by: Baorui.Liu <baorliu@amd.com>
---
 include/standard-headers/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index f9056af0c6..dde5a1914f 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_CPUFREQ		42 /* virtio cpufreq (experimental) */
 #define VIRTIO_ID_SPI			45 /* virtio spi */
 #define VIRTIO_ID_MEDIA			48 /* virtio media */
 
-- 
2.34.1


