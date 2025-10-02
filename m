Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2EDCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4DqP-0004c4-Hw; Thu, 02 Oct 2025 03:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4DqJ-0004Tf-NC; Thu, 02 Oct 2025 03:35:11 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v4Dq5-0008HB-83; Thu, 02 Oct 2025 03:35:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlEf3WWeQ/h2m7tXnkLkHZdBm67hZ/5FTQ4UA04Qu6h2QNzN1fHnAwOpYmZ+Uc2POSTqxFB4duWshqzbxSehyf9/jjH3cBz9/gnI49zBktpaxLHvjXuYU8dGv0y6tQkdyVcX8T1nylPh9GkMCGOzFZtrVFzwxIb9sQJS0pjjIeb2vMZPATwB2e56st22AvQVyHDhRzq26bG6UAgRkdq8E0PVkU5FJwnWCXDXbWla3uUj/LBG3Yyqj/0Avg8EJ6rtB/YDDGfh9qEFU4RA3FLN0zvjxPpNAw9ExRg/R0VmSeP8lyqr5orVlbBGitYAdax6xNyFoAp8Urjm7nZWcZWKcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMelwTkH0ReVAXnWxYM6l9gkyJyBrIJ2t58MbtxOWw0=;
 b=c9AwLAA+WNGe45O92zGG+5lNa0RYRRxAoFLFOHvYh0F/GfdQe7lfup17tPyGE0SvwTd3ZlV+Wbid0lw3gOrk8enD4hZ8JkuE5/kINEdar7eNzEgu7i2ckIc1hy+DU5okkwVT/I8VRnZC3iwjSPOc/oGokei7YIf0jUzOsppX0xzVWlY9ssRgfrizl3NmcnwbLPIxLGclKjx7cSR9QFk6Usgi8W/IbIMcOw9XXwZBjGXV18EFXrplptEgWnV9RBBmvt4/nBrw/v8BUOBg2iWJVZVtHbdY/GW/ruSOnzg+CGGBXBWv2PdqMjZXef9scuWhM0RywMQ75fELbeu+pZetEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMelwTkH0ReVAXnWxYM6l9gkyJyBrIJ2t58MbtxOWw0=;
 b=G0D7k+gXEsEZVk75xJDX3wh3vGtFDoRAmLhfYOJoL0v1thL3igvDoXAlAH2o0xlXLOuMaDT39XU0NaJ9FlWOC5x1vnJytbJ1xJad+mAfRApDBIchuOuU87lLTRpsq+/dd5hBPCkO+XFroI80wIOFcxdgyri3uJSIl+4Q7XjTKZc=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:34:40 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:303:dd:cafe::91) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Thu,
 2 Oct 2025 07:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 07:34:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:39 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 00:34:39 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 2 Oct 2025 00:34:37 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Vikram
 Garhwal" <vikram.garhwal@bytedance.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v2 4/7] hw/core/register: remove the `register_finalize_block'
 function
Date: Thu, 2 Oct 2025 09:34:13 +0200
Message-ID: <20251002073418.109375-5-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002073418.109375-1-luc.michel@amd.com>
References: <20251002073418.109375-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 3697c897-4480-4f88-7408-08de01862589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rVIiz5valujUDSVZ0QqfLoJLwxZGyFiAVqViyAjLGWTKWu3oeT9M/nuLSHDd?=
 =?us-ascii?Q?BpD+/v17LAOrPvL+8PkSPJoEw2ZuBRIhxO8H0BRzdOMsRAZIH1QGLpUntVxe?=
 =?us-ascii?Q?CyX1Or6ZxaBvJbBaA7hF7p4bSeG3psMwu76d0jDwjJSKwxKPO3veJOUwvBZ3?=
 =?us-ascii?Q?IlKgSreMfboj7O/WS8Qe88BZlhIW2TZe/XQs8KHN/KNSBV5afxUN7QvQVS33?=
 =?us-ascii?Q?MBYMJFUHa/J/HMfxwptdqGIyn3FII5fuhT60XWi2JVke5scvDSuMCU8nY2TO?=
 =?us-ascii?Q?vVuXWtMGfp/FPhhbIGgH7aTxpwTQf13YCy4WNIMpCZVQnldzFz9d0HsYPFom?=
 =?us-ascii?Q?2djQNpJh2ga4jY2QGKaongEfSYyV2M8iz+wKZJB9Pa4sxhqSDLZhtkULZ3xH?=
 =?us-ascii?Q?6IIgYpZ53m19f86JjLFPQcQXSimwpClyrPDJatD+VJyUNHhyE5GF+YEiW0Jy?=
 =?us-ascii?Q?hzyYOXLxtRVGEXGP8f1rjWw/bwaR5Ul5vby2pSk88Jlytpg37QppotPYOibh?=
 =?us-ascii?Q?TsDV4Tz0kqUCC3qNkFG4K6l+2LApxJzun8Ugwf7bpB+EIUzifmA9oADcVRgl?=
 =?us-ascii?Q?/Jn3VngdKjt/pr2jFoGS1GbmiRWEOPTQFHYHG3t1lv6ksejIX4uoJeYu5S2J?=
 =?us-ascii?Q?Ume1Tde97Ss3SIKhv0Wi67WS23DrcfdfXDfY+oIC32cSkSAQdkyx2jlRAkBS?=
 =?us-ascii?Q?TZd/jIWkbq6Mug210falrblN6KLfhaWGAJoeWGbKQMHC1pQ9ZE8GfEPs9xZ2?=
 =?us-ascii?Q?i1RPT0Sl+SQSi9IsOl55aq93u2tebAdgNjzIYYTA1yc9n5son/5ekN/Q7utJ?=
 =?us-ascii?Q?GbtX74w4kLkkTfDy7vWH2nsZ7FOCMyNDzA/vdeD+SZ0vI/xv/OnSLKLTeiOM?=
 =?us-ascii?Q?jrr80qAEgprYSDn0IqnJrMt/QyBRHW7iOwvsaRa0qgPJOjZlfiKv2+NlAFRI?=
 =?us-ascii?Q?lKNdKPfy1bqFG//NeY1ZSh6+DYzRpjOJfkDzzndGkxAuHwZdAIGHobZNEIql?=
 =?us-ascii?Q?w7YZeviC6V4MiXptoT/U3sShwRej/BmY6QVcGZjPtzPZBMUAh+FAzP++nOLH?=
 =?us-ascii?Q?7Rkw3gN+A3p3OkOTxYHZUvGrtt4XQxrO38cAPwAXeyfV0WWZWUp7Y16XfwgF?=
 =?us-ascii?Q?H9uSqQrap/vwC55gAG2wiXanR1RYBuw0ylY56HP4eUabROm495Hpn0NwXWRp?=
 =?us-ascii?Q?K2gl0jDDYLGioPnixPABJobL5A/SQhJnkucEhfUl02G/qseGnaSoFSDEd8wi?=
 =?us-ascii?Q?rF4npEgzRUTXhatiWHzmQ1g/A/f5qP1KeFKVWwb9d0wITwjN8FiN4OCOJL4U?=
 =?us-ascii?Q?/wQve6Z8PKCfUiq+A6IqaNs6ULQQJHpGRaC6RWDXwAoZiXrflkKSUiFFT3er?=
 =?us-ascii?Q?6QpIsN2Fhm+CqkHtzGNuP6bgxS/b5M+outx84Aq7fuxlkICh9MoI1itgercj?=
 =?us-ascii?Q?VR84W3KqC8uLk/tY9EgOHbLCnVfwIePq4hrMz+DoNEU5+srxA/IwRjOC/CAT?=
 =?us-ascii?Q?Ksg/clv+y43/eRUCj+GmzoID14DewLaa0kFraYrOEFljnv+WTuGC7fcgFNb/?=
 =?us-ascii?Q?ccRrfhEAO6ueazt89m4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 07:34:39.8944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3697c897-4480-4f88-7408-08de01862589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Luc.Michel@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, KHOP_HELO_FCRDNS=0.399, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This function is now unused. Drop it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 include/hw/register.h | 14 --------------
 hw/core/register.c    |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/include/hw/register.h b/include/hw/register.h
index 65c82600e06..7b0f4c8b7a6 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -207,20 +207,6 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
                                          uint64_t *data,
                                          const MemoryRegionOps *ops,
                                          bool debug_enabled,
                                          uint64_t memory_size);
 
-/**
- * This function should be called to cleanup the registers that were initialized
- * when calling register_init_block32(). This function should only be called
- * from the device's instance_finalize function.
- *
- * Any memory operations that the device performed that require cleanup (such
- * as creating subregions) need to be called before calling this function.
- *
- * @r_array: A structure containing all of the registers, as returned by
- *           register_init_block32()
- */
-
-void register_finalize_block(RegisterInfoArray *r_array);
-
 #endif
diff --git a/hw/core/register.c b/hw/core/register.c
index 70c33d97d8b..a4e12c81870 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -320,14 +320,10 @@ static void register_array_finalize(Object *obj)
     RegisterInfoArray *r_array = REGISTER_ARRAY(obj);
 
     g_free(r_array->r);
 }
 
-void register_finalize_block(RegisterInfoArray *r_array)
-{
-}
-
 static const TypeInfo register_array_info = {
     .name  = TYPE_REGISTER_ARRAY,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(RegisterInfoArray),
     .instance_finalize = register_array_finalize,
-- 
2.51.0


