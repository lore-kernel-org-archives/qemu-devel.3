Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7505E6FE41
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smdW0-00018g-9e; Fri, 06 Sep 2024 14:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVy-00011J-7b
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:16:58 -0400
Received: from mail-bn8nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2418::631]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smdVw-00064H-6T
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 14:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5foyXZZxfKe34y/ovDYN8qiR4QqWA4owtzRlT6ndkvWw22BWObHXtjqkU8ME0jR01/syrDXiOFS56VckXuTATwybdcY8V2J9ehsWXXzGC76/OWbfWRs+NI/6idGEkLm4KUHz8h5214ZSICu55KprkyqSx85g5TT9rcDqBZHgrJCngusa2Wc/mPyQJmJCOYGk5Kq/QeL+c2/CeLRFto57TO30n1KJotfDqFVRbUODov9ATYGaERbW0fR3zFaZJaa5iHl66ika/fDd4hv1JJIVfjxmmBWXZuEEMNceFZ0vLkT/hJkroYNEDcLQMs00REmOb2EUaIoVr2grxtrMQdbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRohHlSFaowl+i0cAx1OGSGa3pmFlFvezSizkGLvafU=;
 b=a+FwpOGsJ5O+jcEGjj5+RCKjqviI4lXnkj1rfDO6PY219nDJhcJAzXr0mFaprvbJ1jnz4VSMilrUrmb2rltA+W1EV86JxT/fX6uG+Pl3EY2SfCwsPer/YoFqd9b79X1M2YtA4Cp/YkWARTxuGhgbA7P/gx4GugPoJV+KCkEZXV6YUKxC1znQgzSwKFblTIbbt0dgyp9ciMysDSfYqKJBxL4EQ0HHtEJLsVpYMkQzRpDD5aNO/pepCDRbfViVztEP4PVKlBHrNuzkKEZwcs4p1uBDNoDVchZL65ZgE1LjyDwPINEHdOY/kEIYVquCnbia+tggmHZzjQKgdaxlAYmIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRohHlSFaowl+i0cAx1OGSGa3pmFlFvezSizkGLvafU=;
 b=ovNGBQAcijLEagZqlAgjAdM84v80EXvxyzUNkJuZHmwxmXxPVCUG1Txl6CHK+VEZy1nIjSBddEVu4fkZB+rOjk2TV4nETT45AKG3V4rpXSfmGRTOlq1ulRwqN4U9Zc/58kKEoHgwkMp/Ty2nT//Ku/BytrEliKDuUPTcC/gwnMo=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Fri, 6 Sep 2024 18:16:51 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::9f) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 18:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 18:16:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 13:16:50 -0500
Received: from xse-figlesia-l2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 6 Sep 2024 13:16:49 -0500
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: <qemu-devel@nongnu.org>
CC: <frasse.iglesias@gmail.com>, <alistair@alistair23.me>,
 <edgar.iglesias@gmail.com>, <peter.maydell@linaro.org>,
 <pisa@cmp.felk.cvut.cz>
Subject: [PATCH v1 2/3] MAINTAINERS: Update Xilinx Versal OSPI maintainer's
 email address
Date: Fri, 6 Sep 2024 20:16:44 +0200
Message-ID: <20240906181645.40359-3-francisco.iglesias@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906181645.40359-1-francisco.iglesias@amd.com>
References: <20240906181645.40359-1-francisco.iglesias@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: francisco.iglesias@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dd8399-b98b-4d61-f52e-08dccea01476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O7ZnZfXvWgnqRgNU6OzCBGxLdTELKIzkrLkjju2QEo0TNBVpdd40I8PFkAiH?=
 =?us-ascii?Q?X6ujJRgD77yjT9ZEAjCDeiddwTMWx/xAqhQSqf2TQ833pumyeqF2JYT0436j?=
 =?us-ascii?Q?csguoJlBPeoUnVCWml7Q1JWEjeJ5Vqc1rZsAnWbtVDzULZlabe0QnTvLDmhW?=
 =?us-ascii?Q?RgyL/TCYF5nf1BVZhWnMd95zGdj/kO82b8zdIh8aRXLVrfEaKyL+E+4C3eat?=
 =?us-ascii?Q?3RGxv/5uYF/SgeqXLxoBzwXLkuiDiuRVlxtcEWwXJFOxehXWo2n5vriFRrcw?=
 =?us-ascii?Q?JoWaTCCIU46gz06ksiQB/zbHQ7LaJhRH5UtMFI8Zz+jkYJqzM37JuZW47BA8?=
 =?us-ascii?Q?DZLCd3ChxIgKXxEhVU4kzhavzANMKcyl67LQ02fjRC+PEzwnmnkkTfRQ+QRa?=
 =?us-ascii?Q?6hkTUu/C/92M8mT//GSKlqbU3O34urVhZJv1AVKvm71uV0bwVMuDY5VqDlol?=
 =?us-ascii?Q?0p3JYkhXvD/hr717MeVphh8P2XDT/oY9w/HOVy8sqfE2ZEt5X4G+LYiAu6U1?=
 =?us-ascii?Q?2WLyKGXx+q9gjGB2J9dYW4JPb3nTGlpIL82yey8mEiaBAcSoNhRyaD8mg51k?=
 =?us-ascii?Q?as9hOozK9y2vfKKMFvk8pq8GwwOxtmbdAJWwu7cOXxQ4QgBM0ti22g+lNtnq?=
 =?us-ascii?Q?/oR1m0aPqoML6nZ+zpn7XYG6EltC88qMNzMtKrq5NIm0ALjR96ZDJxsLHUZC?=
 =?us-ascii?Q?TFZHBiC3W4biGMTuMh51e2fOm3hCnYeEFv2YRI5KXyha6Vg8QAMYj0w3V46X?=
 =?us-ascii?Q?eqz1DdBKju6HpKCdCccV31QF3nNfENqTJ46TXZEL7c/oW8RaF6uFmHACDu1K?=
 =?us-ascii?Q?H4UJEuKgVTGEWoxmcrFs+XF6LIn/4WGJZ2zIR5TtWA6jIfVec62luKsk+Gr+?=
 =?us-ascii?Q?ktcjoJIJCArrzrb02rBha9k4xZg6+cSTULELHwhkrvcDd3TcFfhwVdyYN8wS?=
 =?us-ascii?Q?/x/fZqkUAu2xktxBw+Ssg+VAwZ5NE8n9JOlgMklGxi2I4CDq5tAZsxb/V4cJ?=
 =?us-ascii?Q?qTGd3Kr/ONXPL/A0Kivjbkk9POa8UETLFyZ5wbaaN6KyuyMpxGLwyv3gMhbL?=
 =?us-ascii?Q?GVrb4JfNpST81XP6QGN5WG/1LWYHFBfO+2AX/uFHz9jmdMhQ67fI0hD5xw0/?=
 =?us-ascii?Q?3gJ2li8Ldb7oWyVG/F5M8/srgT1NSZfXMLCv9Gr3rsuaDboEelKPHpxncnQ2?=
 =?us-ascii?Q?BDg+KQdlk7+G8truQtikxuP/7Ky/8UoAKbPpl9lmi+ck0O1QT2SN3KyBHvRP?=
 =?us-ascii?Q?4w2q0lGtEEIwitSa3gBVekHhxGZBlSY5NHrY8QuvvibbXpnTpYkENUSlfZVV?=
 =?us-ascii?Q?l2MkVdo11ym81IhnGXZTRiHyXLpdpCawQHYn1TZHV+BBPkW0X3qxfooz72BS?=
 =?us-ascii?Q?5bVoP8HKz3ltMqSptnnFeLzAorbernNXw7NTpLiGhKqhgkq/qra/6ICVTwZO?=
 =?us-ascii?Q?I4v//PfCutRmxjEWuNc2BdaRQdHhE8d9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:16:51.2103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dd8399-b98b-4d61-f52e-08dccea01476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
Received-SPF: permerror client-ip=2a01:111:f403:2418::631;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update my xilinx.com email address to my amd.com address.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad957ca5e8..b03952f43e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1055,7 +1055,7 @@ F: include/hw/display/dpcd.h
 F: docs/system/arm/xlnx-versal-virt.rst
 
 Xilinx Versal OSPI
-M: Francisco Iglesias <francisco.iglesias@xilinx.com>
+M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/ssi/xlnx-versal-ospi.c
 F: include/hw/ssi/xlnx-versal-ospi.h
-- 
2.34.1


