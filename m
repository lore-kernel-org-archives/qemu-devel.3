Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D654CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJdZ-0008V0-Pt; Fri, 07 Nov 2025 05:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdX-0008UW-KO; Fri, 07 Nov 2025 05:24:07 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vHJdV-0000ql-Mc; Fri, 07 Nov 2025 05:24:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaqvuPRRZRWEtJjEPVxs51RKqBMo41I4K8g6CKxjkw3eS/ziClMdvhAx6sSMT1Q1LnadHIp2QCewl00DKydSCHFKR/6ig9+xDasDbnyGin36DM69eCqF5ZHMvc3ts1gNsItcSoQhnkUg2z08CLYIh51a0RMXyrEiucgxNS5BSp+s2oPqxJyyj3c4yd+qTWYIuAO8zEg55oT0GqYJhhCkk1W50Wo3jyNN103NSaN/fKbIlrkbBjUUtcvpA0RzVJpjXVSgOAYhGqgOMbJNHT43753lsw36d+JxJd/IzJp8pW/b95u03MFh1e992zZdr4ci8HRd8LvEBFYuHmTA8nYjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f3hruUVjU6JCunv0Eyj+ZhBLm0DUSbj7lcYlnJlWQk=;
 b=eJ1WFDFT+DQ533e6YeghJJPjTxxQ40C3zbZRzeYCAkOoZPfW08pFf4hCpIKDVm9FDziCL+6eURSEWbd7jzkR3VJZOtWqU++zyw/Do6gSLsVH3uA7aiB8xGmcuSEcv8FOZk3afdZuyLA5fwVbV27Pnd4R7knbBIwn+3WNNtETmphNQ+QT7ouzsjiGZNkFWTyJFblIjrxtFYPAX4xfrmT6WupZk1MsEakedU9wHgmOKsnDy5Rg+nZqxIHmYfX910H/9ujqxRf9qzzGX9NzylwRwU1m5s6eCLe45kbqigIHqlOlS95yLbd6ad+Jw9Ep0VjGVopeMMIF8AfVk80SFQmM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f3hruUVjU6JCunv0Eyj+ZhBLm0DUSbj7lcYlnJlWQk=;
 b=S+6udiS9Cyu/5FofZzD6uM3Yizc+5AirzXFVXFMUixp3FxilMNR+ZSYGCZNYTnenVkI8bIpnf+R5yv46L4wqcaVFV2Lk9x+FlmntSI9LTvRoYX4dEeADcveKYSjp8tRQKspP75Pjwac0uWp55kp1txULJU6xxq0AdQmMhPddpZk=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 7 Nov
 2025 10:23:58 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::5c) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 10:23:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:23:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:23:57 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:23:56 -0800
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 7 Nov 2025 02:23:55 -0800
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: [PATCH 1/9] target/riscv: drop unused include directive in
 time_helper.c
Date: Fri, 7 Nov 2025 11:23:27 +0100
Message-ID: <20251107102340.471141-2-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107102340.471141-1-luc.michel@amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: c73a118b-0286-4fd8-e1dd-08de1de7c30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ARhGWNRKRmHFKDrmh9/hLubyC6hjIe8yR8jn69XdJ+JUsUPA4MMaDgmvuJz?=
 =?us-ascii?Q?XwDcGdK2Yy3EyW1xIjijq87pZWYdfhvsqywBhS3XyfDE91egaTbxjw81Dp2w?=
 =?us-ascii?Q?dodGAqGR0/wRK2UWMZ0rPRhHCocha+aRCGQls+sDTV7LCSJMmFb8xTPiq3cp?=
 =?us-ascii?Q?rdcdIuHkb3tgCO40kulHqd9kBR9eoGx/7MmOgann/Y6/AX+KvOAwo7mGnIjy?=
 =?us-ascii?Q?KWNnvR1hMVq13FPyfGWwdfx4Xd5djKgMozAUM6JdK0mGRcdZsmuBLGpzIpZc?=
 =?us-ascii?Q?oPqUnR8isZfV1hKCRyJ68zrQXdJSdvdp5wisjPT+xnRu24srxiv1tdekqd95?=
 =?us-ascii?Q?QjK8oTgmFGYf9nWKGjej3GnLBDJ5y3r3/7MFjNZwzscLdTadfoJAqommU9n3?=
 =?us-ascii?Q?r3oDWVJ8q6EoCyXioNoqTtIdMycx4foTY4Z9k9e+Mu50XBCUHdCQiBdh3VOz?=
 =?us-ascii?Q?0iZVgmxFMlFUKTxUqANjXXyVZD3vBbCjRTJ2ddKwnbnTYZV1fM6tsrAdT1VE?=
 =?us-ascii?Q?fZbhxPXvrdkNHlZFswsoKocfOkyy+sW+nZVSayGUe42rCqTLkxsL9mpA+P+Z?=
 =?us-ascii?Q?NKv2xUPJ3NPU7VkbfqEEACRTn2Dn+7FAhXdZKQ0eUm2StzYOPhPbbCBOe+kc?=
 =?us-ascii?Q?DiuZKteEUcPdzbArYkAj3ZPbczh09yNDZKBUHl3suICwa1rXXzyuvFVi+XcS?=
 =?us-ascii?Q?n/aDIl1tiRaN33RzC+SyeEIQkQJcnj2ZqQbpGHUME/Gr3SlITug9I62xSVHF?=
 =?us-ascii?Q?7HYkrmDxyKSzLHy8+PebrA/kLyi9ylIpUsgqVvQGSDc3WlfnyTD8vvqObUNO?=
 =?us-ascii?Q?w+nZHL0ckr876ty1VklksIbYs/gdw5wreui2jEoSeLKo4BdJ5FRkXaW6Pv8f?=
 =?us-ascii?Q?C1IDQd7K9JnadHBKcHeWwUqGRzBS+OdZhe8k0OVtWIRwKattEYgtuw6AoLes?=
 =?us-ascii?Q?plAxmFrKu/sOE90p0TSaV4DzP+V/sKmFYumbIo9Imm0LjK7Ux86v8vcCGjJ7?=
 =?us-ascii?Q?gVdSTXJyvlx0ivkajJg8MxECF0+ugBG2Tyzvp+NfJbxnx0ne5rmYVAt8/312?=
 =?us-ascii?Q?JEfumwyFOzP8ZI2QA6NIoa9hYM/uJfEmZfZ9DvmbyM90bTWOiUoqBZU24EIA?=
 =?us-ascii?Q?e+nge2/cPgVSqsYdJWLcSIFjVrOjZzKlhA1PgpWa5VQQez9p/Z06SVmtA9EO?=
 =?us-ascii?Q?T6sPCTZf9WRGtjC2SUgPThKqzWb276v/6Di3qqTBlK/ma6WLoDKWFvCMT+Ic?=
 =?us-ascii?Q?Z39MipyEZweLekzdQdyQZy3apcAvVUN/KOvVqd7oQD6UU68Wx54xKxeJaD1c?=
 =?us-ascii?Q?OSUPjqE0hGRllxza7kJT03eDpJCSNsO35ZXtqmDH19xkd+XLhGtFuHyOdtGd?=
 =?us-ascii?Q?diqmyzdKrHSVRWBe11p3el74fr4DXutGdrH8PzZUGwwT1Z9cVyOSO57jGu3L?=
 =?us-ascii?Q?anHszBj5vUGhS2FVIljpwTYzRn8lxYERTtSPeI4PqvdyH+6C5y54wS7uHYNl?=
 =?us-ascii?Q?yz7fjLFyqgweYHcubR5+xQPOWWplAdpprCXoYHjiKuzOTOvL62TNSDId+vno?=
 =?us-ascii?Q?DiMQEG4MBt58IhHneRs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:23:57.8780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c73a118b-0286-4fd8-e1dd-08de1de7c30a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Drop the unused qemu/log.h include directive in time_helper.c

Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 target/riscv/time_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index 400e9173542..d2ec8a94166 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -15,11 +15,10 @@
  * You should have received a copy of the GNU General Public License along with
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
 #include "cpu_bits.h"
 #include "time_helper.h"
 #include "hw/intc/riscv_aclint.h"
 
 static void riscv_vstimer_cb(void *opaque)
-- 
2.51.0


