Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B817C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb014-0007fS-OV; Mon, 05 Aug 2024 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb013-0007aX-Es; Mon, 05 Aug 2024 11:52:57 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb010-0003nI-R9; Mon, 05 Aug 2024 11:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873174; x=1754409174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mLxDUVpOD72dMtrEN1LwWCo/uWnU7WeHsiIaFqrm2VU=;
 b=pqeyBpT7nIC7OvoDsHqoBAzHTP1UcSYy0IWy0YR9yZwYfdqH6/bhj8mr
 SCYaUVa2peeaLpN+HFfKey6BVlq729xygtqdPLBgM2nqj4EiEnulIzWjr
 GxF0GNOYh23GumwJ90na42oZ5pFKAjslCNzpQhRCtMFuAIFBXL26r8G6h 4=;
X-CSE-ConnectionGUID: Km7AlsdSTn+NLKtccXh1pg==
X-CSE-MsgGUID: VMG18DEOR7+HcNTLXvnlYg==
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiuxVWEsRSRqGkE01BDc2J73SzAbfZu0NcWtibfltwwodipPWKeWWi+4ScLp2bqwXLH9GPS6S7UzMyw/T2kzDfH8IgpNcx3zNYhakvoddvq3bBnb0hfWJzPdkFWzoaRVw52LxPwbEFo/ytnlMek1L8faBhsVsSV8qwXCuu2gG7xeveS2NXpFaznuzt5emC1OwnhbPCG7MXCrQKmeBXg6iogEwMgS2Bz2lt5l/VGurgDBSGSdLGnJH/JolyPsD/s5mooX15VRLSQw3NECQsVSP8WdlZQFr322w2CfPpt41ltZ1PaVDSvxhKaZblPFyhEpsw+xXPgukZ5LcMhR9KRGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGKj/vm5VdsgbSXJTTkUy/L/9ssTMA5Zoz3FbIxWQeU=;
 b=Gss10H1LLe5XTThKdJDakRor9GUDrSc2Flbzk0hnpnAh/Hy5AjExBRrvFO81pcvw4aYus/R6CBclNWo7Ynf8aIjRRCcZWI/+K8RAcsYfb6xALOWbut6gE2C8JB0f859oEtZXlrNTYv3pXgU66OyAY6Y7ziAf+gM1MJnQ+ZyF24McpwIurmoZtb1QgHmNvfWPt8Fy/TmNFh9C11Iy5011h9CxqFYh0fsdnN38cjyqHzUgg7ejq99woLz1Z9dh/GA+WtSffPR6bZpIsBUdOJLb0nA+kx3nNk+C/vSArF5lBG9ZeBDlZYV2b+awZV+rrK/W1NduPspYxGB/plP6lu1oXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGKj/vm5VdsgbSXJTTkUy/L/9ssTMA5Zoz3FbIxWQeU=;
 b=NG/uEC5W7Y5qtOH1bRBemI4fssDZ2uND8h1Wg/rQFWt2D6ZcLkn9FPzmL3fzQ6JJAFkDt4yiC+i0J7ZXFPsq3R0KocUAYM230BYpdl0tKqarZgtMYK12Skn2pmHSmAqTTckpAvjN5MJbkCRiIRjMjaOylITQfu8KiJw1eB54GJY=
Received: from MW4PR04CA0365.namprd04.prod.outlook.com (2603:10b6:303:81::10)
 by MN0PR20MB7481.namprd20.prod.outlook.com (2603:10b6:208:4c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 15:52:47 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::ea) by MW4PR04CA0365.outlook.office365.com
 (2603:10b6:303:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 15:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:52:47 +0000
X-CSE-ConnectionGUID: lKM39m3kTKuySbtufaDxjA==
X-CSE-MsgGUID: LN3HHDwJRnKnpRC2X81ddg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:57:39 -0700
X-CSE-ConnectionGUID: b23P30nHQkC1FwhDesi6Ag==
X-CSE-MsgGUID: fkLDhRTkThi4OgAnEDZTww==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920678"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:52:39 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] crypto: accumulative hashing API
Date: Mon,  5 Aug 2024 15:50:36 +0000
Message-Id: <20240805155047.3151540-2-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN0PR20MB7481:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6315083b-6ac8-4d34-4e43-08dcb566a721
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9Uw8RZBvN/KwxmYwevbM7st+RehenRBuOA/VnM6HTcD2JW4poyUhe4enBrTR?=
 =?us-ascii?Q?ZwRKFe4V/Man2lkULpJmwumjV1vb7emSo11oRDK4obVcsCRhE7P3QZ1gb9O/?=
 =?us-ascii?Q?Z6sLPP1hVTvJ0i2A3LqfpQFcZC1X1EBb9KeqjpLwSjHuYDuR98FTXM/KEMSn?=
 =?us-ascii?Q?9m5vPqMi4BN32aOVm3MV86LqDeIRx3Lmf9SDdVB7KJiSBIwpVa9etxUqiLxo?=
 =?us-ascii?Q?iN18d5D2kQSO/3KCyropXBE/BHg5o2sPto+XjrJzzLYkwUgwAtmToJFKd7Zs?=
 =?us-ascii?Q?yrCAA6PBWEDIddM2P7q2tSIlJy04KhDaf2Cgsn27Vc2wXTLoLCbgGkyQ8wVg?=
 =?us-ascii?Q?jfI4+BYU64nJq/P/i8mmixnEfyqnhOi5tvHChNsg2SvVECwJa0nDLVvLzMy0?=
 =?us-ascii?Q?5K4ycdageZXHte0mUpTi/PvhXf0bDWgMV1e3kZWmAsfTZKXTJW+Snmdgwguh?=
 =?us-ascii?Q?uoVheGAPjpBD+vIR0qtNKMbSrer66sUI4PojRUt+nYRGSYlCYzlH4vVnKYQn?=
 =?us-ascii?Q?BQ4WL4aI8L9oBfU2kV4U9X8qIjagiujU5k0jytswiqhfAjfFlCl1VP7h8Q7P?=
 =?us-ascii?Q?kCuk5SJvTZCiTMikFG5AAMGRDrCveRWRDXU4RwbBi74GGVPlmVxcAuyzjrla?=
 =?us-ascii?Q?2OLkgW36LCCQCPhjx4VwWxSoyRACM/SDyMgJiAFm0mdjdF+79xw4uwWpLmjk?=
 =?us-ascii?Q?LftOXhMJy8v1gyFmR7ttpHcmjwx4icqnlRARRLTAAd1YDoFxg9tf0VuHMGBC?=
 =?us-ascii?Q?KWyvrzZ9zRR/Ug0+h+UIJHkpXmHhAa4+yoMoldt9F7eur+X0vxJ4pameYWbb?=
 =?us-ascii?Q?EZE8K105HCbKUv4hziU1YEjiFnvPiQjq7Mv8uKc0vvq8QPh1q6Wta79com3u?=
 =?us-ascii?Q?ellnA5YCfYtZd0jPi09SA6ehIUavzf6DfiVx3fd4zL1uy18I6Gj2KY46RlBJ?=
 =?us-ascii?Q?pFfbuibUo/tR9vp60sLrqj4PONJWlOgCJ9HmbqdX5/C4Yfn7BZXakDFomRT7?=
 =?us-ascii?Q?vQhRopcKRcQ58AEVV4q9O9x8bUYgzO9P8Jh3veVQfmx1CPM+RTlbegVDDxgg?=
 =?us-ascii?Q?K+Rln0D7Tj49I/x7leVLpbHdjlH3J58s5ajAbl7vDM4D6/qPOecGg+oH0ARU?=
 =?us-ascii?Q?Zt6Ms3gkL9scJepuvXq3iufpbU5+W7T0M2h7yBXq3MVQydkgD6fDd3xcl9f+?=
 =?us-ascii?Q?4VKEtX/rViAyh4knr/T7e5jsVn2Flj2zbodD+znpQSBmN9woctU2QLVb5sFU?=
 =?us-ascii?Q?djhzzkUOWf6In7PhMhwU9OQ1eWOydfXpJKgz/RbSvfbrwNuYY8OFbCoKj7Ea?=
 =?us-ascii?Q?HFgsNwYrSTC4HxIg/a7IGe4vqvvlXCy+WCi/z8//YPdYcxXRu2gFjtC5BpXf?=
 =?us-ascii?Q?D6KIXp+VbgY/xbfMeklgkRBgU2jD3fZ6RyoNhe90zaD/PT5qxd403c/I0RRz?=
 =?us-ascii?Q?oATBIkM9GlgF9Nc3XsS0UmoBWPGDudQA?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5hXara1XEAA92fxccxJEFXCv0AoHPaIt6CHfuafjbFzoS54qN/8HlDpZZAnz0gzMCbavh7sleBqm/22luWJS8aHystNFjAFqkbF/3yCv4lwif7HF1jjlxaIev2fKH0hvvqIuJEKHB9spawkCkCqMGDDpAQ2t3HXijOVD1K5gNUUSGmtrGqt5qJHyyf47NFYnPoeg7QeqX8luapS/c7MT1BxRqK6bsUHi1ns/JeYeXz+2sqSvvB4PiXqEDOMJFrk7u3D1G+S3OQLUNe1uUj00C6CvGHPVL0lwnGwgRw/m/TbiFvXr0myPgJs/agywhyf3ddHR3VApmcirQAxPYY1KzCD4Bhl9zU4aTcyNqC34mZF+iYb79csG/K89RbJMtWMyx0WLGMpLvR4/hMq7bOzmP1mY4p8bNFqX297jWxN+Sn4zaQXBbwthLzc9/poEV735ogeMLpJ166kaBrGF8eIsuS5lObKLI1u59lMsuigwPfUbdnJT1351R8i49uvWB+5b+ripAFKeAal0N3ADtGZz+mKnKSb3PgXtNAvcX7hjCrIsP7Jf98q9XJYRcQAleO6sREYSnyjhNKw4CKfvatgDu+GEKeXRqiPbms8SVYFYH40dW8W+IzInLy0vw1r9gkBs
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:52:47.1287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6315083b-6ac8-4d34-4e43-08dcb566a721
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7481
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Changes the hash API to support accumulative hashing.
Hash objects are created with "qcrypto_hash_new",
updated with data with "qcrypto_hash_update", and
the hash obtained with "qcrypto_hash_finalize".

These changes bring the hashing API more in line with the
hmac API.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash.c         | 136 +++++++++++++++++++++++++++++++-----------
 crypto/hashpriv.h     |  19 ++++--
 include/crypto/hash.h | 106 ++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 41 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..5c60973bde 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2015 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -45,23 +46,20 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
                         size_t *resultlen,
                         Error **errp)
 {
-#ifdef CONFIG_AF_ALG
-    int ret;
-    /*
-     * TODO:
-     * Maybe we should treat some afalg errors as fatal
-     */
-    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
-                                                result, resultlen,
-                                                NULL);
-    if (ret == 0) {
-        return ret;
+    int fail;
+    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
+
+    if (ctx) {
+        fail = qcrypto_hash_update(ctx, iov, niov, errp) ||
+               qcrypto_hash_finalize_bytes(ctx, result, resultlen, errp);
+
+        /* Ensure context is always freed regardless of error */
+        fail = qcrypto_hash_free(ctx) || fail;
+    } else {
+        fail = -1;
     }
-#endif
 
-    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
-                                               result, resultlen,
-                                               errp);
+    return fail;
 }
 
 
@@ -77,30 +75,94 @@ int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
     return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
 }
 
+int qcrypto_hash_update(QCryptoHash *hash,
+                        const struct iovec *iov,
+                        size_t niov,
+                        Error **errp)
+{
+    return qcrypto_hash_lib_driver.hash_update(hash, iov, niov, errp);
+}
+
+QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg, Error **errp)
+{
+    return qcrypto_hash_lib_driver.hash_new(alg, errp);
+}
+
+int qcrypto_hash_free(QCryptoHash *hash)
+{
+    return qcrypto_hash_lib_driver.hash_free(hash);
+}
+
+int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
+                                uint8_t **result,
+                                size_t *result_len,
+                                Error **errp)
+{
+    return qcrypto_hash_lib_driver.hash_finalize(hash, result, result_len, errp);
+}
+
 static const char hex[] = "0123456789abcdef";
 
+int qcrypto_hash_finalize_digest(QCryptoHash *hash,
+                                 char **digest,
+                                 Error **errp)
+{
+    int ret;
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+    size_t i;
+
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
+    if (ret == 0) {
+        *digest = g_new0(char, (resultlen * 2) + 1);
+        for (i = 0 ; i < resultlen ; i++) {
+            (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
+            (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+        }
+        (*digest)[resultlen * 2] = '\0';
+        g_free(result);
+    }
+
+    return ret;
+}
+
+int qcrypto_hash_finalize_base64(QCryptoHash *hash,
+                                 char **base64,
+                                 Error **errp)
+{
+    int ret;
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
+    if (ret == 0) {
+        *base64 = g_base64_encode(result, resultlen);
+        g_free(result);
+    }
+
+    return ret;
+}
+
 int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
                          const struct iovec *iov,
                          size_t niov,
                          char **digest,
                          Error **errp)
 {
-    uint8_t *result = NULL;
-    size_t resultlen = 0;
-    size_t i;
+    bool fail;
+    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
 
-    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
-        return -1;
-    }
+    if (ctx) {
+        fail = qcrypto_hash_update(ctx, iov, niov, errp) ||
+               qcrypto_hash_finalize_digest(ctx, digest, errp);
 
-    *digest = g_new0(char, (resultlen * 2) + 1);
-    for (i = 0 ; i < resultlen ; i++) {
-        (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
-        (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+        /* Ensure context is always freed regardless of error */
+        fail = qcrypto_hash_free(ctx) || fail;
+    } else {
+        fail = false;
     }
-    (*digest)[resultlen * 2] = '\0';
-    g_free(result);
-    return 0;
+
+    return fail;
 }
 
 int qcrypto_hash_digest(QCryptoHashAlgorithm alg,
@@ -120,16 +182,20 @@ int qcrypto_hash_base64v(QCryptoHashAlgorithm alg,
                          char **base64,
                          Error **errp)
 {
-    uint8_t *result = NULL;
-    size_t resultlen = 0;
+    bool fail;
+    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
+
+    if (ctx) {
+        fail = qcrypto_hash_update(ctx, iov, niov, errp) ||
+               qcrypto_hash_finalize_base64(ctx, base64, errp);
 
-    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
-        return -1;
+        /* Ensure context is always freed regardless of error */
+        fail = qcrypto_hash_free(ctx) || fail;
+    } else {
+        fail = 1;
     }
 
-    *base64 = g_base64_encode(result, resultlen);
-    g_free(result);
-    return 0;
+    return fail;
 }
 
 int qcrypto_hash_base64(QCryptoHashAlgorithm alg,
diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index cee26ccb47..8a7d80619e 100644
--- a/crypto/hashpriv.h
+++ b/crypto/hashpriv.h
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash driver supports
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
  *
  * Authors:
@@ -15,15 +16,21 @@
 #ifndef QCRYPTO_HASHPRIV_H
 #define QCRYPTO_HASHPRIV_H
 
+#include "crypto/hash.h"
+
 typedef struct QCryptoHashDriver QCryptoHashDriver;
 
 struct QCryptoHashDriver {
-    int (*hash_bytesv)(QCryptoHashAlgorithm alg,
-                       const struct iovec *iov,
-                       size_t niov,
-                       uint8_t **result,
-                       size_t *resultlen,
-                       Error **errp);
+   QCryptoHash *(*hash_new)(QCryptoHashAlgorithm alg, Error **errp);
+   int (*hash_update)(QCryptoHash *hash,
+                      const struct iovec *iov,
+                      size_t niov,
+                      Error **errp);
+   int (*hash_finalize)(QCryptoHash *hash,
+                        uint8_t **result,
+                        size_t *resultlen,
+                        Error **errp);
+   int (*hash_free)(QCryptoHash *hash);
 };
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 54d87aa2a1..96d080eeb5 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2015 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -25,6 +26,13 @@
 
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
+typedef struct QCryptoHash QCryptoHash;
+struct QCryptoHash {
+    QCryptoHashAlgorithm alg;
+    void *opaque;
+    void *driver;
+};
+
 /**
  * qcrypto_hash_supports:
  * @alg: the hash algorithm
@@ -120,6 +128,102 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
                          char **digest,
                          Error **errp);
 
+/**
+ * qcrypto_hash_update:
+ * @hash: hash object from qcrypto_hash_new
+ * @iov: the array of memory regions to hash
+ * @niov: the length of @iov
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Updates the given hash object with all the memory regions
+ * present in @iov.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_update(QCryptoHash *hash,
+                        const struct iovec *iov,
+                        size_t niov,
+                        Error **errp);
+
+/**
+ * qcrypto_hash_finalize_digest:
+ * @hash: the hash object to finalize
+ * @digest: pointer to hold output hash
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have its data updated from the qcrypto_hash_update function.
+ * The @digest pointer will be filled with the printable hex digest of the
+ * computed hash, which will be terminated by '\0'. The memory pointer
+ * in @digest must be released with a call to g_free() when
+ * no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_finalize_digest(QCryptoHash *hash,
+                                 char **digest,
+                                 Error **errp);
+
+/**
+ * qcrypto_hash_finalize_base64:
+ * @hash_ctx: hash object to finalize
+ * @base64: pointer to store the hash result in
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have it's data updated from the qcrypto_hash_update function.
+ * The @base64 pointer will be filled with the base64 encoding of the computed
+ * hash, which will be terminated by '\0'. The memory pointer in @base64
+ * must be released with a call to g_free() when no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_finalize_base64(QCryptoHash *hash,
+                                 char **base64,
+                                 Error **errp);
+
+/**
+ * qcrypto_hash_finalize_bytes:
+ * @hash_ctx: hash object to finalize
+ * @result: pointer to store the hash result in
+ * @result_len: Pointer to store the length of the result in
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have it's data updated from the qcrypto_hash_update function.
+ * The memory pointer in @result must be released with a call to g_free()
+ * when no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
+                                uint8_t **result,
+                                size_t *result_len,
+                                Error **errp);
+
+/**
+ * qcrypto_hash_new:
+ * @alg: the hash algorithm
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Creates a new hashing context for the chosen algorithm for
+ * usage with qcrypto_hash_update.
+ *
+ * Returns: New hash object with the given algorithm
+ */
+QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg,
+                              Error **errp);
+
+/**
+ * qcrypto_hash_free:
+ * @hash: hash object to free
+ *
+ * Frees a hashing context for the chosen algorithm.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_free(QCryptoHash *hash);
+
 /**
  * qcrypto_hash_digest:
  * @alg: the hash algorithm
-- 
2.34.1


