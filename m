Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D78C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb02T-0004m6-9Y; Mon, 05 Aug 2024 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01z-0002O4-5w; Mon, 05 Aug 2024 11:53:55 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01v-0003zt-St; Mon, 05 Aug 2024 11:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873231; x=1754409231;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=saA95osssa8AeMH7Yu9KKleRexPwEpxUkGPRk/wFjpM=;
 b=pARDEpSQ3q+EkoCiQhQtVkiLNEuVbllztt1thVSmcHToXOsThNSSMCDz
 tLe9+EU6JDsnhlruUz5kk2nv/H8aeAvHw9HJSe1a1GSKYSdGELWHyxFcb
 rVKVHaWHOqVwkF8Z3rjhsw9KyzFTg9QMuOuGhJiLf77tqNVO49gJ1yaWH A=;
X-CSE-ConnectionGUID: dIZ8+kPbQ2GVk/7MmFmnoA==
X-CSE-MsgGUID: pHxfDycmSLauNL+8ke+8BQ==
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO
 NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7Iri8qW5Uj8tmaKAJiYd7mkMFPrLMiUMkkT6xFJpQkwQSe1hr2/rA4HTrmW+FoRortLrz656zj9XlHxlb7TTqBo/P/46SQqdL4vVthfcAZjD0ArpmrKgA1bmXsPJ/Hjqs8R+BVfT5/XgPST0OMnQXENUGHFNBfdD3ho/SFEJljHXLToH5yU38i+UZyuWAq59QMUBEIJrpM/esVjIMWMu+0pT+dttvyiw0+Oq3V8tBG6UcyuawzfUBVCaPJ9z27tabhiuQM/JDPSmxvzAKSy3qt8swX10sBMvXBWp4sBr4NE6lEvDoDyMjjBPrfMKAh2QiPt0iCAsJusIayuy6NK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I25AJqAsM94Uq8gEkIofuhgDPg0ApU6468m0GKyke+k=;
 b=iaGuHO0gGABEJPcAdRpADwTnvny1azNpj82O3IMBHpAcYe4RFYVHhjI3bBD1DacaJL38MXUn2423BUQVOeVJOepOP+KSvHvcfq+OAXslmOu+CG0G77JQ24TMWKvv+LikwvOplVz9X7HP95SLSw5ZrwI+hCHAzK+8Hkgh2T/qcmXwfLLBOfPRmM5eypX9rJi/dy+5vlwS5kh1wps2uFi3yqn15/IcsxkAfbj1SJN9zq5/rPD/Bn6SlWEHAICwMOpF3VvyXNwfzPhJDX6zG9DGULRJjadvou5FOKiTzBaPXE9wY8hW3O6eEgkshDJok7B75mRbxvPJgAXqLzUckxXyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I25AJqAsM94Uq8gEkIofuhgDPg0ApU6468m0GKyke+k=;
 b=V7fjS7PW0d3N2PMdOuTAStyHW33AD+ZExTSSOIWvLsXP/jxqYYhoLzy0nznUpCXswtFXpL0slhYX14Ht7bCgD5pQFXnPKQtL7Wr9pSHy6RE2dglHVYEKWw/CYYP8qFQoCElUeMcrQvIFm5L01kh6FEbNHPfOp7f9j8HFw03bWuc=
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by MW5PR20MB4523.namprd20.prod.outlook.com (2603:10b6:303:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:53:47 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::3) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:46 +0000
X-CSE-ConnectionGUID: 1vnnKV2aSBuHEyE+rgBLXQ==
X-CSE-MsgGUID: vKbHVfTDSqSVFHEvXSmQOg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:39 -0700
X-CSE-ConnectionGUID: d0sgbfWyRQ6aM/V2TTjQGA==
X-CSE-MsgGUID: KA3r4+R5TpObQkYavaqjNA==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920710"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:39 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 12/12] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Date: Mon,  5 Aug 2024 15:50:47 +0000
Message-Id: <20240805155047.3151540-13-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MW5PR20MB4523:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9a6ae526-9fc9-4902-d8b7-08dcb566caa1
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0xFj/iTna5S+S89pMxV9DUv3VGWMkFM9D/JSmYPjoQqnyfhEgEmEOZB7vDYt?=
 =?us-ascii?Q?2hI/+oPFJVQyKvM6OE9yfVJxcVvpk1YZoNsqqA6N1VJuqYtr2Skn862qzFo/?=
 =?us-ascii?Q?4ELJbJa9/A6He/WTYEHBgWqoj6nciK4iK94pctpxI0lIe2YFWTbdnNU4kOzl?=
 =?us-ascii?Q?/YQijH/z50PUS87CYwirMsahH+hGUB3VdEJgqV7jaMhJDDPo7wbpNO4Vmruz?=
 =?us-ascii?Q?6FTQv5JRh6c7Iii5E7AkqefxtwFATqFxZN6P9/AOPgybLwQFPKSl/JMZ9W2w?=
 =?us-ascii?Q?IjY3bzsSUG/rL2BchBJVpeAOpQHVYZ2aD9tzSiRwORXf31zngcffffkBs5XT?=
 =?us-ascii?Q?GyPP7JtB45NKdV/vv4BcI6wVBaJyg78qDMBTbsDCrKZ+hafjSM4nQTFXD5w3?=
 =?us-ascii?Q?Q0U+zmr701aPpIoruLZqaxVEvTVTEjLZW597nRmOmSkNNv7AMG36rJ7dQHNI?=
 =?us-ascii?Q?fg1qgUvmKJxFH47CeLvs68A25zCSo87qzVQe3OHrEUEm/JsCBOjMQgnpZNqa?=
 =?us-ascii?Q?jrq7eaUrVO9GokwV6sEpYeQH180XpKgslL4VeU9UQOM1ViFUDGKiXGBeNRxL?=
 =?us-ascii?Q?jTf4sBD90yYY77P5G/a2T2KjEo0vwh8UCDITLmGOSfGIdyHZwmD7HS4XQuVk?=
 =?us-ascii?Q?WHlqfzxV60N4oq4BwA5gLUswv7KCguvDGYk3x1E/hEJ3RPiRgkhwWpiK7JsJ?=
 =?us-ascii?Q?x/kWTx+w1PZ4tHKwHH0WR1ZOl8VMaicXZ10qJyQmXS46jNBrDVUAu/u/KlMd?=
 =?us-ascii?Q?GinFEgZ6QHDklrq+Yh1BLz2EEZVAs/3FfRRkFiu1rVIQBDu0TNiDLkTVKewC?=
 =?us-ascii?Q?pycaD3lryg+GhqGtmvcABuCRSjhjSt53VLu9iIlIP1n/sbJJSXrqwML/QGGV?=
 =?us-ascii?Q?s2oULEBN1y1/rmuMxw9wnxjUN9dPUZMXKwptuJciGG/smj9Gd2J2aqURJnhQ?=
 =?us-ascii?Q?YdukQBtauMMZMp725K6l+Z71g4/xJq8guT7895kUX0g8zt+VR96sCMzPcdxM?=
 =?us-ascii?Q?wQuqrkrT+4QFLFXWFhfa9e4SsSK+X040WAP97On+1QGo3Iq7W/MU40mb5S72?=
 =?us-ascii?Q?+pOdRofkXSNVWcXbp0awBJZZjJJkBD71UwRp1zD8ZFaMulIipMgmcCRSK+FE?=
 =?us-ascii?Q?PKEIZ5iOgLf4jbgDotEcVHMuiQlufXKGb8MJWtI5txww+MoghVeYK2qrSYO5?=
 =?us-ascii?Q?QiQV0Fiq5aLCWeeeQuGtQ44Y6YJ1ipFA03yVVYpQ7LSKEGRIc1eY1p5yFTMX?=
 =?us-ascii?Q?MDgb4Cw1bPf+qgLGBOf2JeC1YmKqlgqVml/QleRLzMKho61MqB1j63EBhTsl?=
 =?us-ascii?Q?JYHtbYaT9dX/zDsawUm+H0GaZJDu54Q/mgodnQgN5Pi2av8ara5cEosEOkDx?=
 =?us-ascii?Q?UhpXPUT46h7Rq+9Pm4j0lED2o33mE8IvgULzzWLO7KwlsI2KwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5L//RX8ZtDkX4rLtxgeN9tpyUJxrhYf77Kp6Beyy0HtyD1WQETmx07eOGzMWDjLO7Ypa8V2X5c4NJ2xeqYPBK54jEiNWfBbv5c0Q/c7gJe2nOaDS4C0X71+O4hZqU8H+lD5H0tcK0mb71vhRGh0pJtODnOjXwnhlEiN0eqQtdWT6NXvCb+RA/vcqABf6s1kmqEuethRo2YP/kguV7iJtjGYnP16FKkQ7j7IUEjUPGQWZ9kieCVlzmXQ7Irxfw+AH8HxHTuyamdkjX0P72MNvCC2Y8G2SxpjERS28Sb+i+sCB5B+U7xvAhDLDvU26ouohcCRHOQHdHrqoEtxOCKYLs/6KsFJMLmzJWV5gNVpxrB8g56ezN9tFsTs/K/qhfpp4RcCYkTH5G1dfJ1zRFiSk7TfgJ2drFzoarzCFyYcSrb9MPrL0IYwtqDye0i2Qs91t7+iB6nLebiwqsIIRgDlSELL3tFACBPTrUhz226NbFAFCOblWeBhtEAmOXNmABIb1edPDkfc4xMrfNueEpXU61YV1bQVk3jLSGfkSnLwMWLoBLhsD4t78+1Ig4GAbgLQxVonNUs1V7Ke6vm2IpXbhDnpVdpV+fW/2WwoKqGlWNGSg4iXdJlRdzOyy3yGdVSjf
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:46.7695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6ae526-9fc9-4902-d8b7-08dcb566caa1
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR20MB4523
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

Make the Aspeed HACE module use the new qcrypto accumulative hashing functions
when in scatter-gather accumulative mode. A hash context will maintain a
"running-hash" as each scatter-gather chunk is received.

Previously each scatter-gather "chunk" was cached
so the hash could be computed once the final chunk was received.
However, the cache was a shallow copy, so once the guest overwrote the
memory provided to HACE the final hash would not be correct.

Possibly related to: https://gitlab.com/qemu-project/qemu/-/issues/1121
Buglink: https://github.com/openbmc/qemu/issues/36

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 hw/misc/aspeed_hace.c         | 92 ++++++++++++++++++-----------------
 include/hw/misc/aspeed_hace.h |  4 ++
 2 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c06c04ddc6..5077204ee6 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -1,6 +1,7 @@
 /*
  * ASPEED Hash and Crypto Engine
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2021 IBM Corp.
  *
  * Joel Stanley <joel@jms.id.au>
@@ -151,50 +152,28 @@ static int reconstruct_iov(AspeedHACEState *s, struct iovec *iov, int id,
     return iov_count;
 }
 
-/**
- * Generate iov for accumulative mode.
- *
- * @param s             aspeed hace state object
- * @param iov           iov of the current request
- * @param id            index of the current iov
- * @param req_len       length of the current request
- *
- * @return count of iov
- */
-static int gen_acc_mode_iov(AspeedHACEState *s, struct iovec *iov, int id,
-                            hwaddr *req_len)
-{
-    uint32_t pad_offset;
-    uint32_t total_msg_len;
-    s->total_req_len += *req_len;
-
-    if (has_padding(s, &iov[id], *req_len, &total_msg_len, &pad_offset)) {
-        if (s->iov_count) {
-            return reconstruct_iov(s, iov, id, &pad_offset);
-        }
-
-        *req_len -= s->total_req_len - total_msg_len;
-        s->total_req_len = 0;
-        iov[id].iov_len = *req_len;
-    } else {
-        s->iov_cache[s->iov_count].iov_base = iov->iov_base;
-        s->iov_cache[s->iov_count].iov_len = *req_len;
-        ++s->iov_count;
-    }
-
-    return id + 1;
-}
-
 static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                               bool acc_mode)
 {
     struct iovec iov[ASPEED_HACE_MAX_SG];
+    uint32_t total_msg_len;
+    uint32_t pad_offset;
     g_autofree uint8_t *digest_buf = NULL;
     size_t digest_len = 0;
-    int niov = 0;
+    bool sg_acc_mode_final_request = false;
     int i;
     void *haddr;
 
+    if (acc_mode && s->hash_ctx == NULL) {
+        s->hash_ctx = qcrypto_hash_new(algo, NULL);
+        if (s->hash_ctx == NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: qcrypto failed to create hash context\n",
+                          __func__);
+            return;
+        }
+    }
+
     if (sg_mode) {
         uint32_t len = 0;
 
@@ -226,8 +203,15 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
             }
             iov[i].iov_base = haddr;
             if (acc_mode) {
-                niov = gen_acc_mode_iov(s, iov, i, &plen);
-
+                s->total_req_len += plen;
+
+                if (has_padding(s, &iov[i], plen, &total_msg_len, &pad_offset)) {
+                    /* Padding being present indicates the final request */
+                    sg_acc_mode_final_request = true;
+                    iov[i].iov_len = pad_offset;
+                } else {
+                    iov[i].iov_len = plen;
+                }
             } else {
                 iov[i].iov_len = plen;
             }
@@ -252,20 +236,38 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
              * required to check whether cache is empty. If no, we should
              * combine cached iov and the current iov.
              */
-            uint32_t total_msg_len;
-            uint32_t pad_offset;
             s->total_req_len += len;
             if (has_padding(s, iov, len, &total_msg_len, &pad_offset)) {
-                niov = reconstruct_iov(s, iov, 0, &pad_offset);
+                i = reconstruct_iov(s, iov, 0, &pad_offset);
             }
         }
     }
 
-    if (niov) {
-        i = niov;
-    }
+    if (acc_mode) {
+        if (qcrypto_hash_update(s->hash_ctx, iov, i, NULL) < 0) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: qcrypto hash update failed\n", __func__);
+            return;
+        }
+
+        if (sg_acc_mode_final_request) {
+            if (qcrypto_hash_finalize_bytes(s->hash_ctx, &digest_buf,
+                                            &digest_len, NULL)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: qcrypto failed to finalize hash\n", __func__);
+            }
 
-    if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf, &digest_len, NULL) < 0) {
+            if (qcrypto_hash_free(s->hash_ctx)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: qcrypto failed to free context\n", __func__);
+            }
+
+            s->hash_ctx = NULL;
+            s->iov_count = 0;
+            s->total_req_len = 0;
+        }
+    } else if (qcrypto_hash_bytesv(algo, iov, i, &digest_buf,
+                                   &digest_len, NULL) < 0) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: qcrypto failed\n", __func__);
         return;
     }
@@ -397,6 +396,11 @@ static void aspeed_hace_reset(DeviceState *dev)
 {
     struct AspeedHACEState *s = ASPEED_HACE(dev);
 
+    if (s->hash_ctx != NULL) {
+        qcrypto_hash_free(s->hash_ctx);
+        s->hash_ctx = NULL;
+    }
+
     memset(s->regs, 0, sizeof(s->regs));
     s->iov_count = 0;
     s->total_req_len = 0;
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h
index ecb1b67de8..4af9919195 100644
--- a/include/hw/misc/aspeed_hace.h
+++ b/include/hw/misc/aspeed_hace.h
@@ -1,6 +1,7 @@
 /*
  * ASPEED Hash and Crypto Engine
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2021 IBM Corp.
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
@@ -10,6 +11,7 @@
 #define ASPEED_HACE_H
 
 #include "hw/sysbus.h"
+#include "crypto/hash.h"
 
 #define TYPE_ASPEED_HACE "aspeed.hace"
 #define TYPE_ASPEED_AST2400_HACE TYPE_ASPEED_HACE "-ast2400"
@@ -35,6 +37,8 @@ struct AspeedHACEState {
 
     MemoryRegion *dram_mr;
     AddressSpace dram_as;
+
+    QCryptoHash *hash_ctx;
 };
 
 
-- 
2.34.1


