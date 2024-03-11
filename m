Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC861C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkIq-0000mn-Oz; Mon, 11 Mar 2024 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFH-0005cx-15; Mon, 11 Mar 2024 14:19:31 -0400
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFE-0006tQ-Kd; Mon, 11 Mar 2024 14:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLneYR944S5O99G5ceP+FKpr07ZLWyGQ0orMYfQFZt5vkeB22l5/WTQ0KZqUt03lWH0fzhaCBzovTZbZsUn0vU70GWnEJXBAHcUoCJ0//FnCUj1XhcAneqN6nFTOaNCsFK57SiTq2NdnZiIWh+Q/CZWY3INybBBZxJA9BgGtrGZHvm0mlY9NDIN7grbyYP0ngbjmQv6KUnemFs9Ftb+EvhvfvPUH6OMpUieE05DJvZ9oGY//saSNtlyKpO/pnk2USuJpSyWu1hYjEd1eY280EA2AC5Fc16PrpoTjfCINH4JxOKdIJrVvnqcCmp1i2jkh+NN31As3pIcrmrMADgZTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZA0URoHsUhywR6ywaD8j5UnzK7wpMjQxTM49Xf27Mc=;
 b=HtMfSYwWL9Nx5nAFDgQ7nf8Wup8OArU0J5nWvPKLZGNuOm9TpkdM3udOrXX2z8gRHu805zLboQw2U5wJJUVhIF9Dvqg14vVnw6gLnYYTSc3FZN2khP7mPTOsuvizSyJNQDLGlbHBUuXzlJuIl9gsxmkfh2xAkbs+QnNC/9EOf58YyiI7eLElFElFYRmSCoECU+op1hc8ERW0YWNEUqtqNNulHF0eZ2Jh4MC+duT9vir3CzhD6IpBdjDAqbfTXt247GfmzUJFwRmyvc6thX4pmrEhUKg7vo2iM3x1CS349LP2ozDdrCCHQNwPKQDZR3tx+eZmle/Thbi2+3COIrE1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZA0URoHsUhywR6ywaD8j5UnzK7wpMjQxTM49Xf27Mc=;
 b=G9qlwowc1gmp2wFTw9NG2QsVwmyXtlLELt+4bTRRmoskQ1eF5yHe4Zp9sO/1ifUARH5WJvOb1A4UJOa+OjSW3Ttf+cYveKLjFoO7OMU+kNy7TUsRfdNvFGu0KFBA2UF5QHqsSfwC0cyHkJZGsrn4bdzmh4CU0rdOFqexQE6Y49m6qe5Lc23eCvEbn0OOyd8+HbNAR0kwfNGBILpExSU3yoWZGkJylBc24Bu+r1lzLXag+zkWKWuZh65wMQ9rxQfn8eSddl5+1Z4kABWgojByZI00nsPFegf/CE/DvFuHmG2mB/bi2xDuVHXbP15zA9yAJPwssi8Z11PHf8DeACBuNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by GVXPR08MB10762.eurprd08.prod.outlook.com (2603:10a6:150:152::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 18:19:09 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:09 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 17/22] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Date: Mon, 11 Mar 2024 19:18:45 +0100
Message-Id: <20240311181850.73013-18-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|GVXPR08MB10762:EE_
X-MS-Office365-Filtering-Correlation-Id: b362230c-b2b7-4009-7e9d-08dc41f7bed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3H0daYnxezn2jjd3wyIT02Lobd0eJntdPSMtAWc94RZ7LanaZ+57cJM2AmqADRkg1PbGyr4osVgUatZotlIYFtwk1TnFwEID1oFyzNu+7OThOEVnAGQ7g6/OymcnlE7waBhz4bipteGn/3fGPAnfNClcz0ZrGipDT99PBxYKd7Zjtf5ywBizl7cNG7WyACdHUvXKIAFReV9KgVbzw7df24WB/NtG5GHNIwTuvg+x6rpMkSMpCjg8ljvzjp5M1H+y3emWAMdLGQXvB+waYkGE4F/eZ3t6bZ29M5pR6XdoLnJvHr+LhoCjwArsPn+gJNIs5uKLVaud5vEmFt+f/R1N4cXFwAVVDDmcNMFYhG+JXWhF1eOpyRi9U2TN23Cbinasr08gSboRXX4sFMle8uh64autLK27Ow0oCkHqoAh4Phx0OC3+hal1hAdI+XI9bXTtKpqn2Jnl8CeIb+dTQbhnOGcPKq8cX+2s2A6XQPyT6mE0Vx5Kc5tzPr5rV7IskQECrOiTbuByRDECN2jL0YkrnL61NuZOVB088O87/w6EN06UzqwK2lF3cJDfJs+zfyivvI/rMJ5udQgea00Ax2q8lcnAFMdTpNBh/1ZHYmPmEXEIzVIitCsL5/vPzMWIFG9wwPEtF+N2laPvRuq22l61aPJZBnQfSkCQiFF6Dr9L5A9zX5mJbfSZuKlbSWcgtdqsXq4QjBPM83BgVl+Nucon0qS1UE8U0vMaLuF3jfeZ+Sg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OICP3bYuGFlRQVfr8a6syQu6UPITvoAMntBRmCaJgCPLZzrYoNkAROuCyPK1?=
 =?us-ascii?Q?IU0jw5xDr3sCXSzcBPZmrKzDxrAtWRASahNXvEY50JZaA1CylvpvJBP1oCgU?=
 =?us-ascii?Q?5dPxJRR+J5VsqyfYnMW7Xz+NQHUYF1XYg96tw/gZ8WlHuMOdF2mDTpRhIuuk?=
 =?us-ascii?Q?FAGmaNRbu0XXLViUVW2CUXKsxGk4QCbITKCG1FgUXJORyj4pU98U7NL3ntkK?=
 =?us-ascii?Q?HJcFLtcVn8Ap3JVlIObB10fVZEq4PzqnnmsC+RG+rkZTrlhFOjnBcJAQtMNX?=
 =?us-ascii?Q?728WCnTJo37fNjP1U2JCyDgw2aS0/SgL97wzJPjZhHM4zhBCz4IXXCezvEEJ?=
 =?us-ascii?Q?wWRGvYrfMGz47vOh+YaaQTOOd497qXzbNwYD/kjoJe/QxEUGhW4ZvhZtM3Jz?=
 =?us-ascii?Q?BaxyPAJetFP8HVGXtZuVkd/ELEgSREjCwWJU62LjhVqRmYXdk3cH7aPtN9nu?=
 =?us-ascii?Q?d9ou7tlkWAQb2Lbs+vIvIe68ZkNBDaFZLzMvAtozzYjs+EqTgXGrV64OYsQt?=
 =?us-ascii?Q?PxGNXjM9ZNflgf4T2CAzdH+zu98b1GR/jTrE+Te6l9VRVK3p6reKvhwVn261?=
 =?us-ascii?Q?gclTYfL3zbq9zU3vJAh7niXg1q86W8qhL8GFkcCVoZXiZRgOadEDdnGkVOQg?=
 =?us-ascii?Q?UtCfjLdAmdOmKgpqEK05XJVU3yochpDDIsHgSPDhkcf20S7Mw5g/3w6dFhJf?=
 =?us-ascii?Q?0DFEEyvHu+Q/EVOMz2bQrRJV7dMO9fkfvEe1MZ4lxgChGaBbDZf8kpKr0A+b?=
 =?us-ascii?Q?1B8PH1i7ZkIlc6LMsz+whCaORAKJ/eEJ9ejrnt+gtegA0udy8w9arNP/SUKu?=
 =?us-ascii?Q?gzWhyDm5DS34IsudHqBY7u9SL/kD5wL05QZ2dP2JSHDokuatReG18GNM8FJP?=
 =?us-ascii?Q?/xoFLHjlPKVFnFGvnminmg9kxC+ckM1usc65KvWGQgRKujLECqABc4HyJLxO?=
 =?us-ascii?Q?bEaOMm3sTW9rn4zXABpXz6i38/wRbFga55FDZC4seBIiVgKZSaXY7GvzHBp2?=
 =?us-ascii?Q?YD5p8Y+f0ptfu1bpD2DlMcHngGAL+wNTkDe3506QmmsCKMNNYt8pNBqms0iq?=
 =?us-ascii?Q?/PQkNFQgeQjo24NPY8A2YS08IxyRhueIpP8kDUIRmWMYSYJrvaFEhmvAIQts?=
 =?us-ascii?Q?uzX9d0eZZu8gNnMjhmohabYoybTOHxcYFz8NFS5Gb5ZHvMIWuDI699EbQgCf?=
 =?us-ascii?Q?os4kqbet/vr3xvBG7p/a3YRSju9mNirmVK03pQXtfs2J/Ev9rCllMm3cl2TM?=
 =?us-ascii?Q?unW/P9dEkaRGMe6NlJV0TfmhgBC2ULQB+WKF4Ew31ySHpl/LmeEmZ2rLfoWi?=
 =?us-ascii?Q?WfNnV6e+84NPhkvX0KtggOV/WWaO7VlwyBqMI6A0bklEKXSUR7nGfCwSebnw?=
 =?us-ascii?Q?uIZMMSLBY95LyrF6X46oCMvMVi0f5aFhlJClD2klJBrObEblC9lTmAmBeBD6?=
 =?us-ascii?Q?26pG08yqQxZzx4ndiIfpLFPFJge1axN9I2EXCKwcwYn1densSGCT59E2NZqp?=
 =?us-ascii?Q?USiIpBardOZbItVRHz5L7qYRMGmo7itBoeP7GWUcpBx8/tV2yWBkZzdN1+Jl?=
 =?us-ascii?Q?93G4I2C4EFj27at1EnS6myrYPb+BobcY4E1A9upc54MvlKNsCvbkFYB3FIDx?=
 =?us-ascii?Q?97cs1MfngKGjmMaSi+EkQlg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b362230c-b2b7-4009-7e9d-08dc41f7bed4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:09.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ef3BcFS53/R4QV8nua1/gCxnSafT1Hz4Er98Z+xv5zgo1E90yFes8dDxMMGmyP+y2/8TJfk2PPaa1j8Soc31FxnRdzaYPGFNML8fkSgnFXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10762
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let the function return a success code if a file size is not bigger than
image_end_offset. Thus we can decrease indents in the next code block.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index f51e35788e..5155b8ac48 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -778,7 +778,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t size, count;
     int ret;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -786,43 +786,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
         res->check_errors++;
         return size;
     }
+    if (size <= res->image_end_offset) {
+        return 0;
+    }
+
+    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
+    if (explicit) {
+        fprintf(stderr,
+                "%s space leaked at the end of the image %" PRId64 "\n",
+                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                size - res->image_end_offset);
+        res->leaks += count;
+    }
+    if (fix & BDRV_FIX_LEAKS) {
+        Error *local_err = NULL;
+
+        /*
+         * In order to really repair the image, we must shrink it.
+         * That means we have to pass exact=true.
+         */
+        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
+                               PREALLOC_MODE_OFF, 0, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            res->check_errors++;
+            return ret;
+        }
+        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+        parallels_free_used_bitmap(bs);
+        ret = parallels_fill_used_bitmap(bs);
+        if (ret == -ENOMEM) {
+            res->check_errors++;
+            return ret;
+        }
 
-    if (size > res->image_end_offset) {
-        int64_t count;
-        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
         if (explicit) {
-            fprintf(stderr,
-                    "%s space leaked at the end of the image %" PRId64 "\n",
-                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                    size - res->image_end_offset);
-            res->leaks += count;
-        }
-        if (fix & BDRV_FIX_LEAKS) {
-            Error *local_err = NULL;
-
-            /*
-             * In order to really repair the image, we must shrink it.
-             * That means we have to pass exact=true.
-             */
-            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                                   PREALLOC_MODE_OFF, 0, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-                res->check_errors++;
-                return ret;
-            }
-            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-            parallels_free_used_bitmap(bs);
-            ret = parallels_fill_used_bitmap(bs);
-            if (ret == -ENOMEM) {
-                res->check_errors++;
-                return ret;
-            }
-
-            if (explicit) {
-                res->leaks_fixed += count;
-            }
+            res->leaks_fixed += count;
         }
     }
 
-- 
2.40.1


