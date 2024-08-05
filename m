Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F012C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb01c-0000jm-FK; Mon, 05 Aug 2024 11:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01a-0000gp-Jm; Mon, 05 Aug 2024 11:53:30 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01X-0003sn-33; Mon, 05 Aug 2024 11:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873207; x=1754409207;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bRs0liTPBFA6qYQWf1OelMarrTkexSqqEHIrgbX4WR0=;
 b=O0rCYy/izasajE1k5oHhx5TNEuS5OMwq8M5joyEsNSM/Yid0MpHSBjaU
 zDFj4kBk3ERgOmMAsva/Uv0fB3KOzsL0mxoMYuGue5mnV9r7M0XkDaW/0
 wnuFIrMAYrn4sYRUXrY23NLpatSzSYN7XTxth6TSWRDCHYk71Y3Psl+GI 0=;
X-CSE-ConnectionGUID: YSpsXEktTuqRx8hEc726mw==
X-CSE-MsgGUID: YK9TPRrAS06tSmE6MzXHJw==
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdABMpPRL1UKMVokiyIGZQuFKKj54VcqmluN722N40qPIZIyxrtRTAkDB7joJ11cvfuxmA4z/jvVLQ0yVs6diMRFbkM45pPWfiEknz89t1Gf48Ym/lOtyo1+RM+GrDqqdQgEyt9ogCUS4rZzmJPe3HyREnXbBxiyTw3z9I037OBphT7SgnkKnyVLF4gEWkfu8N+xuVoy6zyXGDKyN6Y30qlVZP1N8vXkxX6djxPwBzEWeplaAX9Y+yHqbFAcnZuZqgZPvw3uPmShN17quZsx1kLHfamjAAhKThWiy6R9jfstNtYr2jZAozR1x5Maics6aNzyBc+1EosGeW8oVmwrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOYvdr86AJGApb+tVJ4SvGt/cR/kaTrtmhtw4SGXa3s=;
 b=AFySbXzKN5oGpQXnz4BvpZHj19lh/3JOqo9J5OpE8xjCv58n8rtlV9iMe/7mJZYDzP/KGehibUdZAsB3AJRoHiidI33LSOVFPLwi59tdGo9BpBN/JrSYhsFQK+mPnDr2G/1qvFsMD9XrbJOCKbyCBB3hhzuWCPUxHsrPbvAmXksWjSmvlqwC6oRSPLokINHpu73FfhtF2qtPJ95gyQrKue5gyTr601KGga+p6WY9/tkUhqWXSwcLGv9kRsehVXzMnNvLidMZJnPkQIANG0t6/StKSBSw/dxDLMYu9wD0UZar7yBlt3BvbA4SX615FOrdKGV4g16LVZPvummpNoliYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOYvdr86AJGApb+tVJ4SvGt/cR/kaTrtmhtw4SGXa3s=;
 b=XSbHuf9gMF8GiLKlPZ95ovdB7g5R4LnlTv5HUmwPwnW3LLuYPCJbxwzIeL4iem9LD31nuLkryDVyzggwVku2kj0I40vuzL2vGDMvTrTwLXCoiOp8sRP1zZUAdlFyGxdKwsRWKTtjrpVCpdYT+EEMunVmxxMl4NaMZXSkKeKYMAM=
Received: from MW4PR04CA0386.namprd04.prod.outlook.com (2603:10b6:303:81::31)
 by BY1PR20MB6383.namprd20.prod.outlook.com (2603:10b6:a03:534::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Mon, 5 Aug
 2024 15:53:20 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::8b) by MW4PR04CA0386.outlook.office365.com
 (2603:10b6:303:81::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:19 +0000
X-CSE-ConnectionGUID: djF8FtbNR7+DFiqIU/lJsA==
X-CSE-MsgGUID: 3OR42Mp6T9uWS9pw6+Bv+Q==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:11 -0700
X-CSE-ConnectionGUID: g3RVv88rT1mOrtJqh3TA7g==
X-CSE-MsgGUID: aaHg/7FgQJKf0sWe6y/vxA==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920697"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:11 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] crypto/hash-gnutls: Implement new hash API
Date: Mon,  5 Aug 2024 15:50:42 +0000
Message-Id: <20240805155047.3151540-8-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY1PR20MB6383:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50acf748-ad41-4433-bb0f-08dcb566ba8e
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p/Bzjteci5YMhP9YLrWe0WKCf+fsqtHmwAJTMYWHmo8DwjLBzAm3F1edUuf3?=
 =?us-ascii?Q?1aOZcCtGfh+T/yQi/7l4YsPa4pD5QOWOxvWOA9/+nMmIdWHtg9d0yQKfgxXL?=
 =?us-ascii?Q?sJW3TuTNHeeKrKBq4I+u9C/iHVomzgcM3xUJo3W++RxRbnVJwHTkhc/MjZc7?=
 =?us-ascii?Q?Os//CNY4aAcwd3cXBETnudfblxSDTvw5iahJHbFsnOMysXK3Y5uYfL1DG1ob?=
 =?us-ascii?Q?Ekwc0ogIgjlhV25QH1qJAx8npU8JURWuxoAo+Si6QZSVqfafe0strDoRAGZR?=
 =?us-ascii?Q?/pEYH6ql1hgdqd/KXlNaqNTHRq9WB9UX26jyHNdE/5hDhGcoQrfxAMxkHx52?=
 =?us-ascii?Q?snvinjon2JIAbZqT8JVSNFQ+AJ6gqgHx8h9p9MPB6jyYZ2hLrlAvxsSvFOFR?=
 =?us-ascii?Q?IaI2/BjVFJ3x5Z3JeqWhKd+pK4ipqjTyDEE3rWpP3vUSIcIrFQqGket2ZVt2?=
 =?us-ascii?Q?LlQKQ+LfD92hlNg8Ldf2zuu68+lFUlZTn7v0zcvheLNqxGmnQ/46APkXnIkA?=
 =?us-ascii?Q?ulDMOCtUtDK3CIJ0/5ycX2yZzfTA7oSQXCMorCyRosGWJyeofU/Y5l+vB5KB?=
 =?us-ascii?Q?wckNHThvvB22q2HXZot1rVKlXzqOE3PM9AInghbEN39QbLGFd2ztA0Q8aR04?=
 =?us-ascii?Q?4cpc/OAF6HAIxhPGS5g2uMYdGAQYXFw6HWng2hf16ZsbfgKTlHuoWi7e7UNf?=
 =?us-ascii?Q?J3mUjBB3HyyqDJA97wivCnlD7Fc0T8UOI9G+iGlLU1pj57rao9Oxb+i3GO08?=
 =?us-ascii?Q?3PNLzbHJjb8/HJAwgIBugEUkrRxc3ybEESTBYQF6J5NfJwvlXzZnJo62gSQh?=
 =?us-ascii?Q?t2Kmcs7Ztdvndmk9ToXonp9UzsokszNocjX0wOfGLHwmc12UjnLygNnCktA7?=
 =?us-ascii?Q?q9KmH1/wK1SdeyBEOjwfkMKEv9lrru3RaEXZkecrcXTbmtyRmchKFjimvJJ8?=
 =?us-ascii?Q?WkrKXUmGqBftY7GzgNgAOiMpLXmgXUm7JhXyMHXpD4kZy+KEqPdr94orhQ9Y?=
 =?us-ascii?Q?FusuAjXQk1AIRiz7DLRDCIWovVsGrUbesSqc6JpLPSAe6yWOlUU42SntVDOO?=
 =?us-ascii?Q?7/S5Srg2WSyxQrjzB1y3KfFJ6cx4uKhQ5P7tehwOT1p7jsFLOkym1Z5AjeFF?=
 =?us-ascii?Q?0zGOicNOaj1i6ZCKWbulU4znea5yLD2N2JyOUq/FIrHlZKYAemTgSenvL2EE?=
 =?us-ascii?Q?6bScIzwEyPOwohh2ti5YJ/GkGGxOsGsywHs3mZ3myOOgMtxxMnK27DbVCf5/?=
 =?us-ascii?Q?WSZBm+xQIT5Vw6NGuv5GPNV8D8e6iqoVI46RlxXDbRlqQEAeLwSQU+rB5uYZ?=
 =?us-ascii?Q?mbSxNI2KfvpEKt1XcLH33r8dEL+p6pKbURvWsAAhrrzILALx3AM04PkEdJQ4?=
 =?us-ascii?Q?+1h9RbwfQ53ShE16mKsqyDjUlCXPZLn2ctOJG1qN8wspsEbPt9unBq8FFVNS?=
 =?us-ascii?Q?6thYpJTi5KT5oeNklHVD6EWpODH/3JCi?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: suuTQjUPpxbi6SUHnFt/ALcQjrqaQsEeXBjU2U0vvAWwR/PexRrX2QtcMhwjS8smFxc0ufOEQ3SJ+X+OiW775EaanG8YRgTfuMzQTuCPVLexDTDuzbJPQtkc3hVQ9Dt0imFcYb/ZmNAefY+ZFTRNVsVr4iK71iSeOoMJ43zJ5RyBnEJ12ERykjQLJQdmNH5yzov3ML4RbSGWBIHP7AJS9gyiy6w4GO3WuRngeJJWYJIbviLr3OiYlgUlIhCx9R44LC8Ft2RZkX3mMMzThMM5SaGdA4G7lybg6E50b9H0sZd4SZ3Y0CZAGWW5LsHwvt7hCbd8R41LQvlj7mdVNgD9tmD4bRz+cuHXbko85ygOSpjsBdDK0lwIcVZP99VDVCOh1IjNrgjVFgEFi7fIPAXJDQGelIY68SMPEEK92zAeKB7Ety6hziaNleneAa4U5V4/Vj9ifnZePJ0waB05SRGjpf24hWUvRdzUAgxya6W7up1/0X0edbmBo+NjMktd7h9DLlHlLIJzS1kCdYg4/cjv6mW8LBG9SuLpQi4kJ1RJpyWbOpGhqeHo5EYDlE7d806yqptCXaYpqI1XX9QNOxlh5RbylRsO7NGIGXB2wu0loBlb03Qbofs5mhfDvqpevMk9
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:19.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50acf748-ad41-4433-bb0f-08dcb566ba8e
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB6383
Received-SPF: pass client-ip=139.138.35.140;
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

Implements the new hashing API in the gnutls hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gnutls.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
index 84ce7073f5..a2ccd257c7 100644
--- a/crypto/hash-gnutls.c
+++ b/crypto/hash-gnutls.c
@@ -53,8 +53,81 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
+static
+QCryptoHash *qcrypto_gnutls_hash_new(QCryptoHashAlgorithm alg, Error **errp)
+{
+    QCryptoHash *hash = NULL;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+    } else {
+        hash = g_new(QCryptoHash, 1);
+        hash->alg = alg;
+        hash->opaque = g_new(gnutls_hash_hd_t, 1);
+
+        gnutls_hash_init(hash->opaque, qcrypto_hash_alg_map[alg]);
+    }
+
+    return hash;
+}
+
+static
+int qcrypto_gnutls_hash_free(QCryptoHash *hash)
+{
+    gnutls_hash_hd_t *ctx = hash->opaque;
+
+    g_free(ctx);
+    g_free(hash);
+
+    return 0;
+}
 
 
+static
+int qcrypto_gnutls_hash_update(QCryptoHash *hash,
+                               const struct iovec *iov,
+                               size_t niov,
+                               Error **errp)
+{
+    int fail = 0;
+    gnutls_hash_hd_t *ctx = hash->opaque;
+
+    for (int i = 0; i < niov; i++) {
+        fail = gnutls_hash(*ctx, iov[i].iov_base, iov[i].iov_len) || fail;
+    }
+
+    return fail;
+}
+
+static
+int qcrypto_gnutls_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
+{
+    int ret = 0;
+    gnutls_hash_hd_t *ctx = hash->opaque;
+
+    *result_len = gnutls_hash_get_len(qcrypto_hash_alg_map[hash->alg]);
+    if (*result_len == 0) {
+        error_setg(errp, "%s",
+                   "Unable to get hash length");
+        ret = -1;
+    } else {
+        *result = g_new(uint8_t, *result_len);
+
+        gnutls_hash_deinit(*ctx, *result);
+    }
+
+    return ret;
+}
+
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_new      = qcrypto_gnutls_hash_new,
+    .hash_free     = qcrypto_gnutls_hash_free,
+    .hash_update   = qcrypto_gnutls_hash_update,
+    .hash_finalize = qcrypto_gnutls_hash_finalize
 };
-- 
2.34.1


