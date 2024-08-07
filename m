Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB295C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmk6-0000SM-Kb; Wed, 07 Aug 2024 15:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjv-0007b4-MA; Wed, 07 Aug 2024 15:54:32 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjq-000253-4t; Wed, 07 Aug 2024 15:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060465; x=1754596465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O+OqjXrMvDkAUAcoI1m/S0g+sJk27W24oSjCDoLqcXg=;
 b=b5QXuXAJLT6V8C9MpkB+JrTW3jPpRmdvzhht9UikuflVacakLBUk63w0
 EWX3C+3ofmR1CXPjBHjPTbFgN7FaLbNdcgHNUQvYfnlyzDkum82BjkCDJ
 YQCy09zALcVwsa5neLYvQ10HKc3JiS/mB9DgwwgoNhtfXxHeTtfzsYWGA 8=;
X-CSE-ConnectionGUID: HK+h7TAaRlCw7+Zk1U1T1w==
X-CSE-MsgGUID: ikLbm4G1Sa2MJAwLILTWGw==
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grmWufpbEtG4aHRk9HTFr9crEV9MSaDRRumcQbLftBLHVDAif4QLBMELrMo5bCjdyPQj0VH1lo244MsaA2kVvRFU4B7txQjSsY8OS9w8fuqEH/Lettcyp6VALtqyj6kNUnPoB12ZLp2htsDV7qj4NiHlaPH/knLoJS3s7098FfMePiOGFJ+WrMrEy4snsnSDahmuGMVed9mk3J/i2Bn+teXObdJowcYamWXWKJ0NAJuKNDOnBsxl3gHOgocMUotqzYEzzoY39vCdgFHAOb6G2FNFKWJuf9ZUbesxj28m63ZBuVOogBrJifj6CrABlqrDOVbWZAwQ1Tx+XxO80Wx5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CuQjX8BnT0MeuB8+NHkURD4hB203gVgYeGf/V4joUk=;
 b=W9bDsqW+yZs1j4yMibD6BTG5UhOGut1khizCrYx4ampf6LqLInzDSPh3epKiiM9vwqa9rTGTezUef+nE6K9mrt+gBz/XBPwFdny1nygp5caaZDSc7tDcokoWTSlBlejUxFS+87uwC2/09HhPjyoUjtL4ljO49QX4cgREJEnMmf6horO+0WXfIGOPxREU16tAAnrgWDgNmAo9IkDB6f26GQI1kcJH4owqNHAmgCPrSPKdPVD4zeRREqtS48tgl9eEcDyT1qEa4X+aybqtEFfrtyvhXcaL1CLp3iMiqNA+VV6w5Ed4rCssgwQYOoYfFxrkuyZgkfWUcMegP7CHmFE0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CuQjX8BnT0MeuB8+NHkURD4hB203gVgYeGf/V4joUk=;
 b=ety3z2cAwcCTAKiXE0Ds+nvZvIoPEnZf2nM5L9xguggCk3raQo685HmunovT5Z5w8ginoTrsoTsX1tByZK5drLPPRnwP3cnzzm22uRyzVJH1pnuwCAgWZGWvjj+/LCLxZKuRlEN/w9aFwWLrmI2n+n8guHAdVCvwsXWFaG/PTZs=
Received: from CH0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:610:e6::35)
 by MN0PR20MB4619.namprd20.prod.outlook.com (2603:10b6:208:376::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 19:54:20 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8e) by CH0PR03CA0300.outlook.office365.com
 (2603:10b6:610:e6::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30 via Frontend
 Transport; Wed, 7 Aug 2024 19:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:54:19 +0000
X-CSE-ConnectionGUID: MA3YoTJVSQW+RBqC6d7ZDA==
X-CSE-MsgGUID: Ad3TXAdaTdm2nu0bJg0nag==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:54:09 -0700
X-CSE-ConnectionGUID: wAah1hMBRm6SuLT/L5tv3g==
X-CSE-MsgGUID: fw9CsB6OQZiqcUadVORl/Q==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235496"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:54:01 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 15/15] hw/misc/aspeed_hace: Fix SG Accumulative hashing
Date: Wed,  7 Aug 2024 19:51:22 +0000
Message-Id: <20240807195122.2827364-16-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|MN0PR20MB4619:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d76e519-37cd-49d0-68b9-08dcb71aba92
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YUvWIYijOao6K+3COV/l/ulqIQJ8vDr91asaCevdjjX/MfTAYCmrUMxgPXeK?=
 =?us-ascii?Q?c50dZ/CERi8URpkVjqF3oYP0BcY4bKwtSiiWatGUtdDzhWtdD7TmVyN/4OMX?=
 =?us-ascii?Q?skgV2Qmw7Tv96i8xh3N0I3j0f8mS+TbD5sb0nt9uia5zBqipA+Qho2+ZK1FY?=
 =?us-ascii?Q?vivroVIjSVnRmqQnuHEj2IuIiHwB0kMZqtc8QPBhNJVR2znDGOzl6x23Lp1A?=
 =?us-ascii?Q?mMpUDFg/V7nwv0N7yqwjpU+RPevIA2KsLvUBGJptbYNOUOVeavPDHhkB0LEe?=
 =?us-ascii?Q?+K9/8rMM8/xanlmXdMfepV7bj3+bci4z41QCc5UOt5VT2IWs7JbHp2yC870t?=
 =?us-ascii?Q?IMdVkcM3AjkRhnbrkjnHuc/eRUVV0kZeVR6h0D3tLcAfPzZnYAx8pik+Ym0l?=
 =?us-ascii?Q?U9vn15lXUpnLui7UJ3B4G5fhUCoNP7L+fjIHJW7JrBwHfLvLUXB1yoZrgGOn?=
 =?us-ascii?Q?4ZmBfVnKp+ikHjXYav7SinzqosGIyPSc9yD/Naduq/q1cx2kbN5+ra5F+icS?=
 =?us-ascii?Q?sEoRfsGInX5saONjRH+2j5kNJUeiy/odK+mHWmq3lDAlK75bE0DFWtxHkE38?=
 =?us-ascii?Q?s+bBt8J72pSSZ5cIk2ucTtSZ+XZMGVYT3ztHEPN2BYAcAA239z4pbEqRMXHL?=
 =?us-ascii?Q?MS2LauDrcqVSMLJzEE1P/l2vhnTX8kyrkwpcbTthSmlsMPuLPdJspLPow6vH?=
 =?us-ascii?Q?BFYYxqu2GjG3c66JCIjIFp7McWAarkNXJCGXgiTFwOvlGq/yVexyU16EtyWQ?=
 =?us-ascii?Q?YWYUQi5x0kRk51nCCPmsbwFD4jCzSGssBWJIGrkpyhON8mPgJ+0ii63zMEZh?=
 =?us-ascii?Q?SUZ19FRIv4FsBEGYmlaVgKnECPCWOxLcu7Twt5kdcya03Qa/DGmdOrGP+a5F?=
 =?us-ascii?Q?BJWRZDXEs3v4KYqLEA9wvf17q9rV8vkeK5l6oapU9mmR1yUqZIVltRV5rkAy?=
 =?us-ascii?Q?YwNx4oSv8d6LcG8mPw87h2PEzQ0kA84x+E45PRe6mrzTEvUnWCTSliKmPp/a?=
 =?us-ascii?Q?onOMsU5W22Md9gAMr+ELZs8U9S3532oDN4HL3NPaxCbFL8ugnDbLAP0aQhl6?=
 =?us-ascii?Q?ogIAqXxmNCH1mr2PTj5IL7EyXKVBj96myXBW0AfcIfz0G3TFcbLAFKkRtHq6?=
 =?us-ascii?Q?tUZMGLjQkYqxdSMjMgoapsJXJkqUnLM6fFbPLdYYiZTD2SWbOtuOmJxSvd0b?=
 =?us-ascii?Q?j36gKSMU4U5TkQeCsvK6LTFfO366p2n1f49O5335eQJVNBGATuJ2R92vurCj?=
 =?us-ascii?Q?TYs1bXfYlU3RVaOfYGvmSGmnTsSOKHzodu4t2to5/ZEsulXoGF/NetYXUFUf?=
 =?us-ascii?Q?4XSDuOe8qAw6bUKlPU/+oBARjAaJ2vhYvK7gawGMLEunOFHSShqWD5bGWXNc?=
 =?us-ascii?Q?f8t5EKtI7MrBhZ6z/zv69KsZzr0f?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o3gsAe19qixpbaB335jrDy/3YT//nOGgUqYlMHVUthx4Aq6TNpXjNEkhQzLicTrx8v7j0Z8MIpTCmgvCKo4G0vvlMZZ0T1xuPHtk6uwb4pYKqbsDINW83u/ZpwcM/ogqPPlvMNTiLnZum5x9JEg1vFStj6R1fOLU/kaI1o8v8Bbm2pOUrwwpQ4PT0YDpt1MVXocV/0YODlUFcsQ3xBPwHqb4l6PVnRgFau4njbMVugHXfpNcal2n6vRlh52KThB/WK+kEkiU+KK1e823L6mkNJSE7ciUL9SRpNYoC9Qu1dg0OsHLnzRrPQvcxxT9EPuxr3blkNtQXcdR8abqyu9g7e/aGR6YsEOevkMnCECl/8dMg84JD9/sUx4I/KJ79x5N2u756opSXKaISHpyh9swgEKJ+6KEYyswgmOxgcWGpuOcjsES+nSQeTKZ0Zxb8puxSy/4T8xjLrNjj33cTOZYjPNLzzWBDA+Rf7UotoIqsgx6p1DQ/jhBtJI8W1HretAr58XhYV79vfT8Hia22qiM+Z47ga7Vb/G2Qix6G5gGuOCvISgLukxiLaJC6xSC2jffoV+jboWrI5mVTza+4ZxJORGKoFOvZ0DDSDB3JYJOn1Ri463ONr3nCCYB/x8aZ2uV
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:19.6645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d76e519-37cd-49d0-68b9-08dcb71aba92
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4619
Received-SPF: pass client-ip=216.71.153.94;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
 hw/misc/aspeed_hace.c         | 94 +++++++++++++++++++----------------
 include/hw/misc/aspeed_hace.h |  4 ++
 2 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index c06c04ddc6..4247403d45 100644
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
 
@@ -226,8 +205,15 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
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
@@ -252,20 +238,35 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
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
+        if (qcrypto_hash_updatev(s->hash_ctx, iov, i, NULL) < 0) {
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
+            qcrypto_hash_free(s->hash_ctx);
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
@@ -397,6 +398,11 @@ static void aspeed_hace_reset(DeviceState *dev)
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


