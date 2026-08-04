Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03D6C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrGuV-0006h0-SR; Tue, 04 Aug 2026 11:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuU-0006go-QY
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:30 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wrGuT-0004oi-B4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQmPZE2toQ0Xmf4aOhXQx9lHf6VBKUdonnsnYn5OoqmnpNksCODJb6pD12342mxGUraV0LZbUJkwH63OjwEStCO0p7ifxX0P7uvycMMe83eZBnd29BClwLPtYy5NURneKDHdls3iBB6GM6AVpE0s4j/zjsXWO2IYLx+ge8rmaY0pEXq5HJEU1QiZgWItwO/ah2UbQe+JLT/WL3Vv7YzO/pbey0vg/mr+xaCmDzONpKK4RmXyDyBOc14eQC/qgy3dzgqJQzhEqCPt6Sxg7HZVwPrmYtVjcmu9E6A2AM3nG7C61lba9z4CWNYGmbGSpLo4yOlep2q6qUal+2Em8AYAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XCSWAGKsaxlEe8xd6WIhc02r3cmsLbUTexZDW7dqLQ=;
 b=OpRuGA2mt+I9CqXDvAOsrjR8IXURzj6LYnyF672tu8q8GKVUOmoxZtXLVHPNfpKTYBc8DYAZReZ+DFW8WlNGPymORBaulFMpHMoBAItcnXu+/EmHtg+LoXomN8n2WvNzxohZHJad5knPtS/xMNfXtlIRVWDRzjMMNMumM+tl0hDEX0E+vqxKt0wjO6zlS0I8AMegPBdlGg9slZgyxC7SQL8NFJsXs0inYp0QREMwYIfy1DrYgO1AmSjo0TklW01cBwtcLagLFuaPy/OXaQ+eM+vKof8dcVVxYj9+WbX7Tn01MHPZMR2yubhdlmF3Kt7U3gTx9G8UiCzpkJwNIQGQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XCSWAGKsaxlEe8xd6WIhc02r3cmsLbUTexZDW7dqLQ=;
 b=hm90Ie7Nm2PrEnilvPUTsySgtmLkXQR6aG3vWu3g9CeFg58Q7SmtBAHjurrjNdn5YBxlcg1sU+qtwA0XZ11bhoCESuVZL0+y8SedDoXM+Zo6ztpW+xoJ9jor/Nz4iX9+49TqxDl2wFtsGICTNgxt5D+ggEXkJAq2yIJA7TWwk236BtreNaU63Ye3RV/+ud5Q3xX2DX0N/iojyvnPBIhl7Bo9kY75NxMLQzemUX7zu7icVVfujwYxfjfZLuJ2zifAA1KI6d/F1sISlhfnuMaiN7WknOMrVhKz6AAZC+oENFZUQ1sO73Puv9clUKJR/Yw3xqeZ3rNSnzJA/mlsrBOHLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB11713.eurprd08.prod.outlook.com
 (2603:10a6:150:2be::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 15:17:53 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 15:17:53 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 1/9] scripts/qemugdb: coroutine: Fix selected frame leak on
 error path
Date: Tue,  4 Aug 2026 18:17:35 +0300
Message-ID: <20260804151743.937694-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0148.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::32) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB11713:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b6fc6e-1fe6-4135-4f88-08def23b8dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|52116014|1800799024|38350700014|6133799003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pBns4caygOloFCmZBIFXR4Gv4nhhMgIjWi542WQQALBodX2wDEFkXzq0GrAF9a1v1dDR+U1TfeYn/7EivdThXhAdLsTG8Fla+AfhMslKSTW1tDLlRkmB+HaCPV+rAgLWNAZt+foC+g6hLYRu2kKBCnBEQi29nsVrGN7XWf6A3Nxx7k8yj+C5LRhCBREREoE/UnABM9bKN4AFYPtErCoPj7U+5+fDKfJoVxgWVBq2FHBNH1xdINKnLkr+RduhbdahEA9u9SmilYnB88N6EqEO7J6JDjGtURCMNag4fHPCOl5bogMh8+7C6J1Yh4AMRYCWEgObn5ZaR8yYfZIfKQFnCjF2KJR+VRoPgs75rO1tIn823dytqx/rDeeqaj8HHj+2xk3CrOLU3Twaoqd80tmt02vQ9OnR7vWMYFO+zYAzZbgPwLrQiPGLGPXeCLGMhsSCEC4qreEu+057aWcBLRH7KKizuKAg82jrL3CxlJmfOmc5tHyRGKrKegTBu1N2bS7P29h/5tudQu2GLT/hJaW8NcTsaOPX+VSuxWu5tlM/m+QTzDhUveyx0fnhPeHZ+XPyxnppcrSpd77cwUkgBtwsKQu1TwEdb0mL2uyAr17A484RU22obWr/TzyowCRKvZtpg1oHSFWoDMBYarI/4sp2FQhVnYj/7YTABZGhzTFn/0/H0y1ueNAVZHcZFWeK8rhDEGXef6r+/aMVE3BY9Yys5LqBSGQFREW1YqQ8MRWGOTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(52116014)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QqIKsOKp55/+ohQ13entcLbOm6ZPHj09699/ZKGocECeNltIgyKc5NBGOuT9?=
 =?us-ascii?Q?LI49yjWUAYs+Yt986KVY0eNKlSqm8436itAEBHxgOIK7+r30F4jsfz2zrCWj?=
 =?us-ascii?Q?/cRreXSOlkknKvMrux8/HHbRxTmULFvwfSs9cxQcdV2gSIY2AYRb71kEefk3?=
 =?us-ascii?Q?Y9mriM7RYW0QAzpt9PTX7CTBVs+vCuKMF7lK7UOOzUw7dqiLJPuNpJ8G7Zcl?=
 =?us-ascii?Q?CGKvXv4CWT+HDpHQ2kT1CYA+QAP+hbpGbV3CNoYxa2e86z3Ibyic3aK/gLLf?=
 =?us-ascii?Q?+7MhgbUAOPdXS0an7Axr1Adit6jlCiel/WCEHSG0NQNWPGCA0T7mZ53DfWgO?=
 =?us-ascii?Q?1qaYVObxmMPBNoMnYZ/2EYPgxWV22Akw1kqLhrX/jwd5qGMc8/eB26QLjeE3?=
 =?us-ascii?Q?nkGd0Gr72lREsFS441d2EclTmYnzfbmKOCaYXcfJwfmXdo42VtZ5daBrvjKh?=
 =?us-ascii?Q?ErKVXmP2VX5oaMIg2r1TlfauPJQyzL8lRcgEtP4XX6A+iUcniJqDIAittuqs?=
 =?us-ascii?Q?+1VOpGeW0AlNO92mO0nehrM2bn0noJ2b+XwPthuxserDk9i4wP6Vq+pjXFnC?=
 =?us-ascii?Q?bUPstuLzs8MA/BpJBFysBdpbVdT6IrLEszUWFwoJ/922HpeXjh6vyah6d/XO?=
 =?us-ascii?Q?htxBYTKNVbiaimdqXBh1+6YwzOXrBtTLdtbBjz0J8gzgTW9mZr+sktCaRwJ6?=
 =?us-ascii?Q?+gJ+pV0yJx4qxGQXh87uWbVPrczXnHzw7/SvDHCRK3OgYkhsXCsQAR8BwXB7?=
 =?us-ascii?Q?0YxJWQO2HNyviWvk/efSxXQuEAKbupCLRD6vPBXi3IWNYTs5pSpPgh9xzQwf?=
 =?us-ascii?Q?FeNd2T0z0M7f/6xDNyAROW2e+PPnTuEvy2iVP2kxiOosj6d0veaaXRVBgsXF?=
 =?us-ascii?Q?vXRVYUwAe9t9r7mjTPI2ADToHMjQ3zMOO4o8+uRS6vLHFMca/bzn8sOGeSY9?=
 =?us-ascii?Q?7sdFMremz/r9O1oRM2s4MqWU1DhNenvjsZ5osnYt1kw1gBbJCJPF3ZPFlVgh?=
 =?us-ascii?Q?9wlJKi5+3pAJSLBhFnQrndt/yfegp80mJTIrX46Q1SsoDDzkcdqEbu1lUVZt?=
 =?us-ascii?Q?Fvo1fX2vgN5Ai4oSvqizjWk4cHgqjp+h0pvnqPE3WmKdy6aRfzBemplnCkGp?=
 =?us-ascii?Q?6QIARW3r/l2wVxoxHI5WpkWExv0xgsaRQq79A89rmg7gJ0DFusS2kxwEZJBV?=
 =?us-ascii?Q?f3LUWifpnDj/FenFhFmLLT1kDW7vxhqdzO0hISP9GqfjAsmM+++hpoLz8Sxg?=
 =?us-ascii?Q?QYpa0un0LCZZQMR6TNwJ6veBDd5F3Wp9ohxpFqMAovtW+8t341IcbUNZAGpU?=
 =?us-ascii?Q?iD5N1v2mQ+RJ9xAnSPglcgH2s+n2w6FFF44GPQ5arkI+kxrcWP1hUpv4kf8m?=
 =?us-ascii?Q?uEGgKSro/yh2AC+hcBPdaCBIfq/e6iwlyQUoaEqh9bEsxY4Ncl5rTkMokRvC?=
 =?us-ascii?Q?I/+zywbnRctkk8L2uedcHBvoblxLlqJtQskK7GvZiB5vVKDynHgNNMwfVvZT?=
 =?us-ascii?Q?Ym27W/Nwycvs7nFnaNm2mUF5wEo9S4npZo/70w2JvOw2tpoEdv5t9y9rZZnL?=
 =?us-ascii?Q?TzUUhULBncwfjXrlKifoKUSFJexkMz24xb6W6JFfkt6H4TDuhvA+MWGbR1BM?=
 =?us-ascii?Q?Zo3BtcPw6vSb4RxiAV4GTa9O2R8DiVYmkw6WrMmWCcfTcJojBwUuH6wlzEAw?=
 =?us-ascii?Q?Ky/T50hvHCLOOR8rAx8OXG7g9ASDmRRNnCa5+eUUiRNAq+KajGLba67jatih?=
 =?us-ascii?Q?MILWEyEYirDY2Lbnef7nwcXxDshkoqY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b6fc6e-1fe6-4135-4f88-08def23b8dd9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:17:53.2286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljuLDnwrOf67VdqRuToqfL174fsY4zHq+w7n0BdAvj3SXfRgOyeNgAqOmpt/U9rPHef2ZuLMnkCirydWp5WWQ4Vx0iwN7MDTqExzLoecvpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11713
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Currently, whenever gdb.execute() fails and throws an exception,
previously selected frame gets leaked.  I.e.:

  (gdb) frame N
  (gdb) qemu bt # throws exception
  (gdb) frame   # shows 0, not N

As a fix, wrap gdb.execute() commands in try/finally, so that selected
frame gets restored no matter what.

Fixes: 4cbf8efc5b89 ("scripts/gdb: fix 'qemu coroutine' when users selects a non topmost stack frame")
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 scripts/qemugdb/coroutine.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 29f57ae84ed..d1e6722d14d 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -265,18 +265,21 @@ def dump_backtrace_live(regs):
     selected_frame = gdb.selected_frame()
     gdb.newest_frame().select()
 
-    for i in regs:
-        old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
-
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, regs[i]))
-
-    gdb.execute('bt')
+    try:
+        for i in regs:
+            old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
 
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, old[i]))
+        for i in regs:
+            gdb.execute('set $%s = %s' % (i, regs[i]))
 
-    selected_frame.select()
+        gdb.execute('bt')
+    finally:
+        try:
+            for i in old:
+                gdb.execute('set $%s = %s' % (i, old[i]))
+        finally:
+            # restore previously selected frame in any case
+            selected_frame.select()
 
 def bt_jmpbuf(jmpbuf, detailed=False):
     '''Backtrace a jmpbuf'''
-- 
2.47.1


