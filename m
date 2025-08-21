Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E386CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up4zA-0002Pw-E1; Thu, 21 Aug 2025 09:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4z1-00026y-It; Thu, 21 Aug 2025 09:05:36 -0400
Received: from mail-bn1nam02on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61d]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4yu-0003E1-Pn; Thu, 21 Aug 2025 09:05:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1ea7vJXJnP0+CMuL0PO00Quw1+HkSF1XNrxViBbIqdKkuT/lfyJ8ZzQSS7E4vst9zUQ8/yQWi3DQkx1VXsXK002z+b9VuIbHszKOproARe0nla8fcXgwaf+uW0UbN6Ya31/6NWJ+IyjoaetDHvT7T0rBlca5IyyCcrYBT5NALlIdPD6H2YUVrQHdSj3PToEOJ5bA/iwXMQcdJ5MnF/a3SU0DlVL6BG0l9c9bLmnb3MCVE1Wz5GCSqKe7J62X7Re+BjSZLJHJ+hvgbE4W5QdlTKI432juugX3VVJMbcc7oGKCnoE35j3VozX2C6Gnc6A6y2ouOqn82LRORODSYfXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=nadDQdSDwNIfYr+PiP3sP+JtOKuvVOrwf2Bow29nCX175xJ9Qn1vsa2ISE2EJykhQDnF4xi5TTqWyXs7+zX20KObn6pwGczSnSNmC2Jko1y2Lpo7m6ICGSSkqI0evwwr94C59X3JOuwq5r5XFyw8/hliDEkoKpHRnjCk3S/sHxt2OvIld21cDFEwCOZFq3d6W7DJspj8IvO7+WsSZ8vOPJ5hWx2fMcTNwpAqn7zE0r7st46IN7G83Hqueb/OSIYMfFRAiFdy406/zrT80ERii4vQWzhj/sHOygsDKNbEr9sGa07ZQM7WUzvoK/lOyze90PCsrZp4R458YMExw0BLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBlpqEA3wqODgHWKPG4DGJ7QeWvSNPNqcZZuv1kj/NQ=;
 b=AmTXLHu686xZWmCJHIg4oqPVmKs60MfeXCicBTJrixwET+fPpKgg8KbFgyrqRv18YrHi6VZPZwnPXZxdW6QxtjZcENzbL+0g3a4gpqOODqYsKkJJLdss2cHjmvbfp1bkoZCi0qGp6sz+LYPjKcdSASJNvF/zyLdB62GbGY1QiIw=
Received: from DM6PR08CA0002.namprd08.prod.outlook.com (2603:10b6:5:80::15) by
 IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.15; Thu, 21 Aug 2025 13:05:18 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:80:cafe::64) by DM6PR08CA0002.outlook.office365.com
 (2603:10b6:5:80::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 13:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:04:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 06:04:59 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:04:57 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 30/47] hw/misc/xlnx-versal-crl: remove unnecessary include
 directives
Date: Thu, 21 Aug 2025 15:03:29 +0200
Message-ID: <20250821130354.125971-31-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 204ab607-276d-421c-4c7f-08dde0b36012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9JD4SqmyqOJ06vzezk1jutmcv0dU3Y1vcvR+lVFJn7tqqvateRvzuZqTEmdh?=
 =?us-ascii?Q?A4miQQqcAKFi3/ma7+82yAwNVZ7DyZtFl9qhBunY9rrvicUbWGImqH7l7hlT?=
 =?us-ascii?Q?74LEGTIJuvSeHL2R6eJp9AE/v5BP0HSk1iTdn0i2yh9m5fFf5s+RmXx/EAqQ?=
 =?us-ascii?Q?bgG6pa2f1Lx3pnTTdNGKdds0/PWF6QXZgcG3T0BwRr7Gx1Rg0gvkbrd6x7Vm?=
 =?us-ascii?Q?1BDEUbBzv1mFf21KryebnvIYUfE7sVYA0RF+72C3BpyrMpWOxOZ00NEcIEBy?=
 =?us-ascii?Q?dQCSO/Db93jDZmBBOXuQgPp63H4X0akO/GxMbsreu9LfMhO6T1FyM8HvhCNQ?=
 =?us-ascii?Q?kk6zDqAa7tZV3CUa2WP87jBcCz6jWzdqJpNvvhnkfxahBj+TAPSDMZ+0iqik?=
 =?us-ascii?Q?ezEBL1evQpdJEoRqt1zT0F58FG7SMI9Hn8Y8c/4/KcCsSJyyU+rOK1ILNZFf?=
 =?us-ascii?Q?xFrHyZ3rMqmJC+uudLRo6i/BsaJQtlpwIgBtvVKu3h70aH+sDN/3mzm6zU6u?=
 =?us-ascii?Q?+25bSVymNzNAWxxMg0D0vE80qhOOa2VfJXW+VIay1sLIGta4uCshKbSczpoN?=
 =?us-ascii?Q?CfhZHurB308U9JUiPKQLtYXb65HWsfOYy7p+ChX7PBP9ClDKGYyyTRqRX4TG?=
 =?us-ascii?Q?DC67muYMCv+JwbugSAStjhTktlG9IuNevQPJANZiF2lHMGBIcyMA58ZjXyht?=
 =?us-ascii?Q?lkeBCLawazQ3RoRIa3vAlxbHmM3B6+tvCfU6yPp0AYwYSgFWczSdjkY8rKK4?=
 =?us-ascii?Q?8MCtMVQJes0V2j3NUwPMBIb6plHgaXFibfLKQTi8eArD1VoQijVnyc59RxXB?=
 =?us-ascii?Q?iXC+n6Bzlfga9ApVhF6vS+hHUiLDQNY/5WVXPvZsRYUDfHTBJoBA9WRjUOAU?=
 =?us-ascii?Q?xHYyF65R0VErk8g+AecYkx2+1FoKQSS8O4q7XnVFaHYwlwG2wa8z2OO7uf4G?=
 =?us-ascii?Q?mDtxeS+0D/RP1eYrFhn4HRxxmTUXusGOfAOX6hRKj+A+xeABE9rLZXdKUFRD?=
 =?us-ascii?Q?KOlvc1zpJl/db2QdG9RtZ5v8CFiB5Wd9ROoSVCxruHcuFpxHNCkFPlsdggte?=
 =?us-ascii?Q?NUtmOK7bOdymnHRR00DxaMXZovbcTjNr51LNgOB867gWEQMa1s6rf75Yx5U3?=
 =?us-ascii?Q?P5yk6H4q3l5C59LM/klZ6EBjP8SvuihD/050yaIDh8MY/bdRB6lEi2TrkNWZ?=
 =?us-ascii?Q?NY4lrnVGQ54qYx9hI9gKs8pBME71ks5jCgOm3C05+oSYM4kB1zs0o4ZzSNBi?=
 =?us-ascii?Q?FCw7aqfg2eJD71eUGisLNHVBTag0Ksv17Xv8RUWV7uoy4fBXUbdl15hJwPdS?=
 =?us-ascii?Q?SUlKzJ5V6uzOp+F4BmOTa2G3FTW/v2ftbU/FTlCGXBfCh1EAgzgNGmewNUb4?=
 =?us-ascii?Q?Ot+XckshV0+b7wtlVvisn/fwV5R8E62P4Ql1ReBisQBfczEmKmy8Eu7xLG38?=
 =?us-ascii?Q?iC8GQxKqEwzI7F506RhUxOy/UBYiJWA5uFIbfTqb1hpuTZ+MnS4fAF+egvaI?=
 =?us-ascii?Q?SbsxdVuPERTtRX6JXtj/yfG7wY8yIB0QF/SV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:17.1251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204ab607-276d-421c-4c7f-08dde0b36012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
Received-SPF: permerror client-ip=2a01:111:f403:2407::61d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

Drop unused include directives from xlnx-versal-crl.c

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/misc/xlnx-versal-crl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 08ff2fcc24f..f288545967a 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -1,18 +1,15 @@
 /*
  * QEMU model of the Clock-Reset-LPD (CRL).
  *
- * Copyright (c) 2022 Advanced Micro Devices, Inc.
+ * Copyright (c) 2022-2025 Advanced Micro Devices, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Written by Edgar E. Iglesias <edgar.iglesias@amd.com>
  */
 
 #include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/log.h"
-#include "qemu/bitops.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/register.h"
-- 
2.50.1


