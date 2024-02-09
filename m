Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF1AC4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 07:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYLfj-0003e7-Cx; Fri, 09 Feb 2024 02:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rYLff-0003dp-LO
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 02:51:40 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rYLfd-0000ws-5B
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 02:51:39 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4197543c009006; Thu, 8 Feb 2024 23:51:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=iqYpFnN3Fn7
 C62ex7X7qfqywoidasIyUJYpT3rsEfhs=; b=oGDVK85Xs/aAjEaCoXYxsD7yJnM
 C3l4zZV4OLjYwIDANjOpmKa/mHb+PwVqMDWChwl2RjiX7qDA/mBT22eAL1SW5tZK
 yYoB3VGCrzwrCQsbiYVkT1sjUZg5q9lmocIOagSmNDobd3yf6fiLHqKr1GR+zfva
 0B1A1yutVrhy/YI3z/vrttp76L4Xb3XDX39086TovW23XRRrPRrltOs4TRAjGxrs
 nms7cnOOTHplL8yfiYwwOoGfxgXC5r8BMpn/DnGHZlhgnrp0NRcIHQUHz0xf8RTv
 7l8vlAYb/2utOHT/991K/ppgv/Hx2stHEledleU2VK0eliMK1W/UzC6Tzrg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3w1nehm97b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Feb 2024 23:51:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5u7cB44QPimUMfEG/0R1MLE2AgCXu/YQIUTk+dU3AXOymF1utPFAUIS29vHG4fHac+/7aQN+jBm9jp7Cc5fVSSZKvB0QDXpmFMQEaoWfAtofcNeknVD8nMf316E1wWKzgOG3zK0kHvh62E5MNMu0Jj5aRnEj/hdDslBCNmiVqiRkTehnKUCA6EViOLCskeYy3JQfHNaFAIDX1vAk/qWhXlaXzMH99jxjlhV/U4q/JbwyvDhBgHcBtfZRuMOaUsQNjRHIjIsR+L9X99DdjZ5aQ2m/cNfBw+9WV33cGqmDg3pvr6Wq+iVJxmVRmXyHvWDnicHttCJKmEmLrKp1bDmBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqYpFnN3Fn7C62ex7X7qfqywoidasIyUJYpT3rsEfhs=;
 b=XWZFaez43qoEtdAafW3TJ5IzvF8sVgrT4Q10swrJB4h3fOyj2y9LR3y3ajdsRNaEC2JkfPeCDno9Tmb6NxYst3fJHTtpmiKmFgXx1b9ZU+cwuW9ka5HTgSY+biJ6KPjNGKfw82DTyhek8Car2+2UFl83+fdc5e76vK2cAImgaAsz0PBj5Cxr9Oetrp9l1vIbKE/dJmwanfjDgjJJqcLk+t/3Z1JoD2SWRiBWlVTpRDsAORkRFk7UhXXS2qQBrWRNEvX1OzNQwekjS7OHXdI88N+eK5bo5wf+sp2seHO5BNRh4NWS17IwNbpApyPp2uDbIDBrzV1/zLsZkrGXdACgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqYpFnN3Fn7C62ex7X7qfqywoidasIyUJYpT3rsEfhs=;
 b=rFLq2zgo7Db0ZwmwBwwMUp4rg18lVoBuSoKq9+e3LRlatpQV64Pdpm1Y5yMEAEMDwWgpaEiEMHlo6Jyvl7WhnpggMeq5FDEszKxKu2fchznKFDu+fUod+aSZbEDRHEHfOX4oV1K4zL8oNVMOk8NarDqCiaiT1ZUHp++VtQSWCs9Qjx1Tsh4btvkCheUSS4a5EDfOg01cMttBHG6uUmHNOUVTzj8u/wZ92EETn8qd/s2zVH2f7qmFw2pBCfBSXjqevleRI9qM0n/Tu+VSAeESuN9gkqKnpoXRd+KvigqKlJox8t7F0OLxGjDtOSDqQf/XX2xKenYOC267puFP5hNygg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB7776.namprd02.prod.outlook.com (2603:10b6:a03:325::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 07:51:31 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 07:51:31 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH] qtest: migration: Add failure test for 'uri' and 'channels'
 combination in 'migrate' QAPI
Date: Fri,  9 Feb 2024 07:51:28 +0000
Message-Id: <20240209075128.226237-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0103.namprd07.prod.outlook.com
 (2603:10b6:510:4::18) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: acba2429-bc7d-4e8b-c0a1-08dc2943ee14
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /CH3wWLSo8npU7pSBhtL8IRYHBZvEfPTz470lF0ve2je8S4Gw/UKB8PqQYm2G5oIOREz+8KHaa39Ax2OmHz2/NEedbda3uecrbTtM/Ng7UXLDGojvQrDV7p/CcN9uW9ZEeXrsXTuR5a7gx7+ul7uC+tZu6UcMkw36fLBNFpqE+hAbzNNC2s1kJ6BaxK6aRSJqwAl/wI9EenJhOirgQWpws3QPwJBB4kR37RqloBHHxPm8Ar5gh/muFgdowKvSMw+0VbK33P1edWAJDWYZwx4LhO6pry5Peu+pLcLrKrqn6LFqiF2XTGLbyljqEHUE8/ROlcJTLn1PikRBJJ7SpJq5bbZLUiGz5KFYiuB+kghUJfr1FWz/YKcimFEE+wUISfm2zTUP/XvhX/1ty4oMWFKnMUl5TsXiyujm2mMQuc2zSLn6hOduFG8cnGZm1bwp8agof/wqMgb+mZA4ea0gqILo5gkerxEARQIjaH19ghUivF29ehIuGYdd/MZmkBtU1fAlN0rIBO2CnZMfzEjyCv/LjM5VY9APfu3GJ0WIZtW30JywSxf/XxJ9FMKSLzeJGuz5337kVMUlQB+9xl+oy+zNdFFYR8zvseJo/ApFuML2pUw0nzPJMrEsI1EnZKurLAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(8936002)(44832011)(41300700001)(5660300002)(2906002)(4326008)(8676002)(66476007)(66556008)(66946007)(36756003)(38350700005)(316002)(6916009)(6486002)(478600001)(107886003)(6512007)(6666004)(1076003)(2616005)(83380400001)(86362001)(52116002)(26005)(38100700002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TVKKIT/1GZPN4jIr2zlfR9w86EVDJr4oivmer6W8GMCmhooyL2f+gn004rk?=
 =?us-ascii?Q?Cg/WjKyfrwhQ5v00bRNWtnhR3SEkN/xXSiZQZoysRrw3gkA+Op+BwKzWXWkn?=
 =?us-ascii?Q?RltTRgwwDHEcTf4csvHzMWJFFGUpes/lBskokvVXmw/Un5LylkFGeLSXCwI7?=
 =?us-ascii?Q?tieqmmsyewqOUXIYE5DpKfLfiUNL83Hk5nSZjzSvuQ53kOu84dTEDtWQepzB?=
 =?us-ascii?Q?Hq9qKqXmKKs30p5TEFWhRSSVbnEZ4lmICzsFo77P0BmpHVz1DpW5WSv88dXr?=
 =?us-ascii?Q?dvEEveNtGPxaBJTRX48wD979NOoeBahD1iO3ygXwSt5/18RlIcnQC2CULNai?=
 =?us-ascii?Q?vI6ebIsVg75tdx6lRZ9RLGBMardTyIdgp6eKUf3n90mbb+vJKeybgO/qBr4N?=
 =?us-ascii?Q?P9uuvJpqSI1tpqoliiPCGuoVcNjrBa3Dc1c9bYMjVi60FE6UzTOYczPXBmaU?=
 =?us-ascii?Q?q80w4ByivHSRLxKpdCh1bO6+pyN3A2t2UKk81LLvOi/4Yrs33u7meyUFSY8Q?=
 =?us-ascii?Q?zuxmIH+gehw+12uev/uKmKaxm876O3wX8Z6qK2V/Ow7cZnTQQJ6hJtbgVZaF?=
 =?us-ascii?Q?lDD7W5RZB5BIsaaYgNLD//pGFxMIS9yDNOLPVbOXozwolb5FTXMNkNb43fin?=
 =?us-ascii?Q?ioWsZSJonhPUJNbifyiHaTz69Gc/8NSPk/JdO4AWQg9XxZ7U/8ADbUy5ZPm6?=
 =?us-ascii?Q?x89GyWUlARe1G9G51X3twUnVZnen0wIrtuD6h+g6Bw3vp4vezYcP990hDcog?=
 =?us-ascii?Q?oAtZf6IPfxON1pFbUj4WYXQIXMzg2QAFeRza1m/6N9BzgA8abYxMkOwAPt4e?=
 =?us-ascii?Q?I3nE5uio5QOA2DIwqbsTs3zkx8L9jQVrT7QLfasufuc/ASP1xWHx+5mWp94k?=
 =?us-ascii?Q?dDu0OBVioEFlmdU4cnPMVi6jfQEwqMSMprH46clR5Go1oYOKa1314ySKeIM/?=
 =?us-ascii?Q?9kUSKg6lMSrfL0L78mxjNKtQIF2q+0UD+aNGcg1gB+AQ2/1JAvihy3fE8aGv?=
 =?us-ascii?Q?s/YeLpo3qSQhRSWIQtK6yRPc8gg5Cy2w9sqhcYO0LszFBybDi9CMQ6uum7H1?=
 =?us-ascii?Q?hqJzZlRj36X1WkhKuL9tQ9XqZ/0bO5mpMCEc818tWQbL7UjjTkeFMc1IFrUJ?=
 =?us-ascii?Q?GX9ViVIB4KlN7c1jMZv8RucXSUy91UHmPm6+L/zVG92Td0GjN4laAjVIgwDN?=
 =?us-ascii?Q?00RWzTIu8/mMrrU9+lw8FOuxDR1u0f0umFv77K75wwcUPjm8VQha25L/acF0?=
 =?us-ascii?Q?0BKGaPOn1w4ecPk5DtcNAUjxoB+xCAlzIM1cSd1j7jJCPFX9WISgAutf3u94?=
 =?us-ascii?Q?IA1PZsvm3XSuoVVL2Wu4jlLbQJnaktkA2csKKrbIQcNptcxoFy1Rc7KHjr+Z?=
 =?us-ascii?Q?xP4pVrcGJZXkjq71ImokYq6QUUWqaCS+NXUHeXOemSq02rHY1Of9Df/X6si+?=
 =?us-ascii?Q?gkVSOqH/1jfqxzAPfBKTa1UbpEcDJGSBiKs0jsGuddDU2e9fg1yXYjMnjlVZ?=
 =?us-ascii?Q?JdGRn0+6w1NdhrnmPycvrcNCKWxPjVKDGkTxg8aVq3j2NWBgleyMXRh/OmVP?=
 =?us-ascii?Q?6LF/rAfjd0hapgnq630zlbjqcWi0hPCrGdOo+852NcgWBKro7In5qeuS8WM/?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acba2429-bc7d-4e8b-c0a1-08dc2943ee14
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 07:51:31.4764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs5I8+YvcsZwlSkL4iG7E27hqtYlkSNCrE3w52fEytYixAII4zFC5NGSIJxB0dgh6t7tvgLWQ1e0emXXdWJ54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7776
X-Proofpoint-ORIG-GUID: 7KyUjQ6Go8UhaL08ay2KuoxbRsxbfsqJ
X-Proofpoint-GUID: 7KyUjQ6Go8UhaL08ay2KuoxbRsxbfsqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ensure failure occurs while adding validation test for 'uri' and 'channels' arguments
used simultaneously in the 'migrate' QAPI command.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-helpers.c | 14 ++++++--
 tests/qtest/migration-helpers.h |  5 +--
 tests/qtest/migration-test.c    | 60 +++++++++++++++++++++++++++++++--
 3 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..2dbb01e413 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -43,7 +43,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -52,8 +53,15 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        g_assert(!qdict_haskey(args, "uri"));
+        qdict_put_str(args, "uri", uri);
+    }
+
+    if (channels) {
+        g_assert(!qdict_haskey(args, "channels"));
+        qdict_put_str(args, "channels", channels);
+    }
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..d49e289c51 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -32,8 +32,9 @@ G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d3066e119f..3aaffc2667 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
+#include "migration/migration.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "qapi/qapi-visit-sockets.h"
@@ -1773,7 +1774,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -1869,7 +1870,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -2508,6 +2509,59 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args, bool should_fail)
+{
+    g_autofree const char *uri = "127.0.0.1:0";
+    g_autofree const char *channels = "{"
+               "   'channels': [ { 'channel-type': 'main',"
+               "                   'addr': { 'transport': 'socket',"
+               "                             'type': 'inet',"
+               "                             'host': '127.0.0.1',"
+               "                             'port': '0' } } ] }";
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    if (args->result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, uri, channels, "{}");
+        goto finish;
+    }
+
+    migrate_qmp(from, uri, "{}");
+
+    if (should_fail) {
+        qtest_set_expected_status(to, EXIT_FAILURE);
+        wait_for_migration_fail(from, false);
+    } else {
+        wait_for_migration_complete(from);
+    }
+
+finish:
+    test_migrate_end(from, to, args->result == MIG_TEST_QMP_ERROR);
+}
+
+static void
+test_validate_uri_channel_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .result = MIG_TEST_QMP_ERROR,
+    };
+
+    do_test_validate_uri_channel(&args, true);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3536,6 +3590,8 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add("/migration/validate_uuid_dst_not_set",
                        test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri_channel_both_set",
+                       test_validate_uri_channel_both_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.22.3


