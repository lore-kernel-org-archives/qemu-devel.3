Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06670E674BF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 09:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6npb-0000ae-TV; Fri, 01 Nov 2024 05:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t6npY-0000aV-JU
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 05:20:32 -0400
Received: from mail-sh0chn02on2072a.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::72a]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t6npV-0000ce-B4
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 05:20:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqfmENop3DhxXtk0tVndvc2Mz5RU2mm0W8uOP0Q5v6yK9QudZq0/X4weN6BeA/45zxsFVzU1CP4m+uCD3EVtmxUVIDAPoh/N4OPj8VP4Kdp64Mo62VrWLtVW44bcLNsS9PxXmPDoLe+FxUgJouuV5tEVHvb9Ay0nui4B7nC+uq6XYxnivNkzaQ6Jiv5z7ckwDx5PesV+b//aKU5KxDiPr/1DzhdnuJCnc0/S8x5S9IpSj/6Y2r3BRPKGyOgES0YNCQd4/wcPDCk8olMgu20RFld58iNeuD0ZOsZJUVb4ZsiaUW01+4o7mv8D3E1KXOOKL+KEJ1D3kVo5u0WUPcCuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHc+2ZexFmesMjJ/++g41KaYjEsRpcM5YOOO0I5hzto=;
 b=Us765OU6B9l0eJGXffqCt9DgyWnID/VjAD9jNCc8JIG/Fh8MEgpgPWPmHQmr2H8aKySP8HNkvcz0Quk/OuVyrqMVIjsTipaSmceBj/BMxaBffWRcuCsoT2T0A2Du/kHhQiP1h+OU1K8X3LReX8N2zAR+LlE852e+HS5DPC9PRx0vK75PZ3wqc5EY1Bza+3nsLXtLHw7u4vujZEwaTt9sDd7ajLegWt8uQDalYT2p07dQwnHUzgg5h68mEGUTcHP7p33gasrtb5ZE+PvfBPMILsaGHestn8Lgt8luGgWln0u7lcqGBZq5stmr7rz2n4xVR3wqmHxFLTfEA+VN3t5QZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1093.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 1 Nov
 2024 09:00:56 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::7c03:71ed:a774:fa31]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::7c03:71ed:a774:fa31%3])
 with mapi id 15.20.8093.027; Fri, 1 Nov 2024 09:00:55 +0000
From: "demin.han" <demin.han@starfivetech.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Subject: [PATCH] plugins: add plugin API to get args passed to binary
Date: Fri,  1 Nov 2024 17:00:32 +0800
Message-ID: <20241101090032.1413255-1-demin.han@starfivetech.com>
X-Mailer: git-send-email 2.46.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0014.CHNPR01.prod.partner.outlook.cn
 (10.43.34.154) To ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn (10.2.2.45)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1093:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d22845-f7bc-4691-3cd3-08dcfa53b1ea
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: 0GeXNZZsImkTn1T7XDwCjcGW+gdYj+ravwhhehaeTpBJBx0XI5GVINH3STtnQldAihIT8S7jKAGwvVkDsscIdAGxgfnk+MsqtvohZoOB05AqIvLb26hMZ39KfAy2jqDpD13lyTJVgkU76+4Kw27EbFAKKb7iu1c+jVbevtpn/u3aU+KQbAKO5YKB3220hIK8ZuvllxWpQuLAR7wY5VfQuWFIDgI66vvqGSjzGHjTxPpL34E84aXNoEM8TS9LtGxOYuAYIRzbgndqKPmRL6nqk5X5rJbcbj7fgk89rSPb8T7fga2C/pKE3tOLP3MiFHn2RJq+eHM+CUkmBwLECPX07LYlPr0VSA1LOn8aHuvr0thG/wuiX+/If75lIbeQIjqVbHdqrQKJl9xohADtuIdnatuVFCq3jDDDl/Wru/CfjJFxX6A1+Mvi8Qx0io5EOMUL94Thaf8pCim4mcJv/b66tXhhRkLQPcvOa/bIPJxRLWrLI3/HJ+JWhW5IByGXcCKqqEvJoYJCAnWB+CD1XPi3ec5hWqI14I05VxXJa4b6iHoK96719tcUDaLlsmcCfdrZ8w7DveI93V4HLwHQIwyWPn05C6UOiH47UMqn+m4rqraiftmMeza3b90PB1Bon4NI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29PE8hydMiS9YboR9+Olx6MvqBiFHGvoFwbQuBlEtHeb+Q7U6uVTbrUUjYDu?=
 =?us-ascii?Q?HkjdxrbyfrZrtHYjo/7HQqPDkxalNZcIfgvlD+YzSBUmjE9cuHqXRhaSMPG0?=
 =?us-ascii?Q?JtNyyV9aZVCJWPRrjiYJpMcrpkyosbKMPm9Dfjgzc79/c1sY/9Q6jagzLc44?=
 =?us-ascii?Q?7/QVlrJyFmI0c8KEMM0k15JqnagHH2Tgs0HdeszgFWV88s2WToxLaJgm7TaS?=
 =?us-ascii?Q?4+mDU3RaI/iFBBKix8w5n7xHLK6hvDNd+i9NIY9q4FQELRcheHS9+x1/3kbF?=
 =?us-ascii?Q?Y9k9OQWKmaI3AXC34Lgz1heJf5+DFWO9F5iLuLNH96XD3yEs1ppRmP7vr8GF?=
 =?us-ascii?Q?MWjk8uyFm0o68xmC3zfC47wuv8nM0FY7Wf/2BP3wJRDZ4T+4pVA5gF5Gc9T8?=
 =?us-ascii?Q?jiIAi4zKY70gASprfbToOYPN782ApfFBOCkU8IApsp3nqyvsjxMeWWjLUgVo?=
 =?us-ascii?Q?1hQ4+GIxeC3LQgiwrfv4cHIeJZ0xLokZYdvxAAZZpNiEjJn5SQLpaeUR2TdI?=
 =?us-ascii?Q?YYIqh7BWVBTxUluF+guznmb89lJ2dV1gOP/TwT6jAzlQfxJFLLgdPj3RJhHW?=
 =?us-ascii?Q?GoVpnUm6vkQh3gj8yGaS02xg1CUVzcJCwIyg/NeppzHUwhHMUNc2o3j0Uaqj?=
 =?us-ascii?Q?8KdDUFKL2lwCdhLstYK/0Toc8unyirxP4qSZqbSROxPvoPgDbQWFLrmOJo/D?=
 =?us-ascii?Q?P9O/mlIJBqFEFJAcDnUtyC9bCj5QK9F1kwL7FbSbyVSINXYNX/piIZbBEqul?=
 =?us-ascii?Q?5aooegmg6XtceiKbGD7Axma0w6domtqLUqdIuXvDDFkAzlugunoqW0m1WS6k?=
 =?us-ascii?Q?SjO3+Yi15K59tsa9S4E/UKXIJSN3isXfMyYu/5KxVHYFXCIaxllrHWCPWRI8?=
 =?us-ascii?Q?4SI8XOaOyh2N9FNyafZsqNVB9mD/5MYGo68e9gg0pSdFluHtFls+kUkFjM15?=
 =?us-ascii?Q?L4Y5uJfFNBDpL25FmMlyhztNfFTg8ZTVOrlptWjPy9UB+TitNi9vPpj0EJ6t?=
 =?us-ascii?Q?MCeXWrdPhZaD33w+Dn88LxeqHUsgHlLnhX+1Vt9hnEPiHsBT180aHepXk2tq?=
 =?us-ascii?Q?gJgoxDDrgRkJ+YI9pit759dWy5xwn7vzA9Wy+K7Nbu7+yG+x+cK2i2od5Qu+?=
 =?us-ascii?Q?ObJ7KmJVM1AQhQT2/iiAS2isaQmDkPTE4EITQHFFcnrvWepg0eLH7fsX0sOQ?=
 =?us-ascii?Q?nWaYzipojDPjX4G6uSw1KQRgF6od3h7Nfc+Q754wYvELYMQ7e7t+gQuzAmMb?=
 =?us-ascii?Q?p4pwQOKldCeucKbEyHlU2vhVhyX7dJ+ex8varPuva8THzsHv7hxEI6G9hSIR?=
 =?us-ascii?Q?iKYQ7h4o+LSrPFK/t6GPb/5/crEr0GexQkunynqsvhSsLfrMjDy6FHm9ZAWe?=
 =?us-ascii?Q?PQw9ZfN5d1wVtk7hbAAGVRSQB0/vwixoGhvhyjLelNMyEupdiNF6sYFz5iQd?=
 =?us-ascii?Q?C/2S3068PZttlmgvO6Ci6OFxM1WoGkGMRgljg0cQDXKvJYMHZiZ+U8h79ULU?=
 =?us-ascii?Q?YvWGYsWdh4dfp/o1eeIxD+GpCRX4LMAX5BTP4auY5SYMqyLtpV/DR+b0Uke5?=
 =?us-ascii?Q?qFJqqZ6ZBomiF/j9RVUb6DiurO6Com4pNWkzCHseIZYrCzT/+J5+AIVMpFAi?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d22845-f7bc-4691-3cd3-08dcfa53b1ea
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:00:55.9633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q8ep04FYiIPqENF3+fdN0aynYLxJP2kzRSyl4T6H0PqAtojUUltL2UsXBNNrH2l3LkJEbZcsiqgvZ5mP8xHb5fj0C/fxjL9XvJpm+lqLxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1093
Received-SPF: pass client-ip=2406:e500:4420:2::72a;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Why we need args?
When plugin outputs log files, only binary path can't distinguish multiple
runs if the binary passed with different args.
This is bad for CI using plugin.

Signed-off-by: demin.han <demin.han@starfivetech.com>
---
 include/qemu/qemu-plugin.h   | 11 +++++++++++
 plugins/api.c                | 16 ++++++++++++++++
 plugins/qemu-plugins.symbols |  1 +
 3 files changed, 28 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 622c9a0232..daf75c9f5a 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -837,6 +837,17 @@ bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);
 QEMU_PLUGIN_API
 const char *qemu_plugin_path_to_binary(void);
 
+/**
+ * qemu_plugin_argv_to_binary() - argv to binary file being executed
+ *
+ * Return a string array representing the argv to the binary. For user-mode
+ * this is the main executable's argv. For system emulation we currently
+ * return NULL. The user should g_free() the string array once no longer
+ * needed.
+ */
+QEMU_PLUGIN_API
+const char **qemu_plugin_argv_to_binary(void);
+
 /**
  * qemu_plugin_start_code() - returns start of text segment
  *
diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de..fa2735db03 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -485,6 +485,22 @@ const char *qemu_plugin_path_to_binary(void)
     return path;
 }
 
+const char **qemu_plugin_argv_to_binary(void)
+{
+    const char **argv = NULL;
+#ifdef CONFIG_USER_ONLY
+    int i, argc;
+    TaskState *ts = get_task_state(current_cpu);
+    argc = ts->bprm->argc;
+    argv = g_malloc(sizeof(char *) * (argc + 1));
+    for (i = 0; i < argc; ++i) {
+        argv[i] = g_strdup(ts->bprm->argv[i]);
+    }
+    argv[argc] = NULL;
+#endif
+    return argv;
+}
+
 uint64_t qemu_plugin_start_code(void)
 {
     uint64_t start = 0;
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 032661f9ea..532582effe 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -1,4 +1,5 @@
 {
+  qemu_plugin_argv_to_binary;
   qemu_plugin_bool_parse;
   qemu_plugin_end_code;
   qemu_plugin_entry_code;
-- 
2.46.1


