Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8633FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb01O-00009c-Mi; Mon, 05 Aug 2024 11:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01M-0008TP-1q; Mon, 05 Aug 2024 11:53:16 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01K-0003rd-4B; Mon, 05 Aug 2024 11:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873194; x=1754409194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HaShWNvYIuqU6oggFyXFCD99FRibmZI1VM10rgstOpk=;
 b=kHw+m9uG07r/1R9Df8P444ZD9rSyAE1ZywKPYJzrY2IweRrLceODgraH
 dkKwfSoe7sIstWcbVu+DYj4TWda/7JwWz2ghsmSRt6YAF6aj733dtzn2/
 P6MziFNzocwDu+vtK8fw6VKjPWGHuRNSPfZj7WRl6BbESmJj2eVDkdLnJ M=;
X-CSE-ConnectionGUID: lYfj5XrHSDeRIiCqXcY8Kg==
X-CSE-MsgGUID: J9lbigWVR6ycLOM2wyNLqA==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+WqO/FDZEpLxw8vO/CSu06T7ys6pTIkv3yABTHt5hf/weWlUpUzIzD93mNxRv2x92uf+EtpArCcO6YsDOrTDNIgTdKx9UbyexQc6Gk8wDmEZLR92+QvLe3HUFAhyxAv7+QNXys8ClDeMYVqwKtX5pu4ApZHk0HN29LeokqZ3zkeLKN7+Cp234K3GfDnJEFMg50J2OyE5SqNlUpIrjSNERdbukcobuhurBxkgGzBrm7PUujdaefyy1tF6CHX1sYIpBROD0bZtFHNRR9kKSPcJ0fSq0qQtJi6IefbbWhPYGIDVg+G3yFPDJeWWeo87PdDS2O19tfjfPeSnDazusQ6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcxTJkFSmF4td/nDVFZ8Wot8FnhZLnRkYoyd25znfJo=;
 b=JW5HzoP4xZDT6TheDBXnuKlYmmh8Wt2cYLNIYziRXlioIKApZolobrFmi8dmUFbfe8eSfgViug52E84rwRNBr5s5FucqoIFxp8gQ1HIC8qXu4o5x3uPbIgRAE9loehXQQQBiyO5EuVZhvbVu/OmRIdpol1x9nJtMPql2FiOTwtSw0T3BIQSFRiw7tpZXW6d+aZq+DZIhg2U1fSLEHScEddbnlEreabAb86QTw6RLysdSPrFXNhAKFG+adFYirWasXlrSBobTXpuSPHQjk1f4NjCJe7197gMGcciIadbyvPR1r9QZaPH1HKlMrWZpN5gdSbe3HyZAm7vHQ0Io6S2x0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcxTJkFSmF4td/nDVFZ8Wot8FnhZLnRkYoyd25znfJo=;
 b=Fv2gQ61zind25sl1NkTyjbfYLLfbeB9W99vpTUg4XyBMwFO/aOuYbIjetGxsEr1oi27+tGWffE78Tsa0+4i+RRjR8jg2Fr2n/O4MCxYLk2c/abprEvPSBv5LYg3lU+1qsBIuKhdbLnGLJo6BVyt0YAv2ORoWc1GGLeQwOkwfBnM=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by IA0PR20MB6655.namprd20.prod.outlook.com (2603:10b6:208:492::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 15:53:09 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::3f) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:08 +0000
X-CSE-ConnectionGUID: OkF0lm8QSuGI8jQgUbIOkA==
X-CSE-MsgGUID: SOlFfA1bQjqkJOZy5JknIw==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:01 -0700
X-CSE-ConnectionGUID: xBqxuv8QR26MnhRTCgxepg==
X-CSE-MsgGUID: sWcv0xLaRvinbjTyInhr1g==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920689"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:01 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 05/12] crypto/hash-gcrypt: Implement new hash API
Date: Mon,  5 Aug 2024 15:50:40 +0000
Message-Id: <20240805155047.3151540-6-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|IA0PR20MB6655:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 336a3b22-70a4-4463-1f80-08dcb566b418
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EwTSwZNwcxOeArbK9yHdnaxlUTM05DHhK3YDm/ZVpFVMp5bjzYS8ilWRK/f3?=
 =?us-ascii?Q?PisOwadO0vo6QEx6UZ+plKk7gftkgAGzPBdQ2Qeq5BqGRJy1BrHd3GCwjulU?=
 =?us-ascii?Q?qgvJglWTQE4S87k5Vel2VVytTa5h8/30LgCtjdhHbuqe+Ig0c4bku5EVgUMU?=
 =?us-ascii?Q?FZhE4Enmk6guq6A8bkYc/JmoXGmTaPDrEf1MtbdNAvvzOYTRJ5uTLCI7uhlL?=
 =?us-ascii?Q?sJAZJY2+e0jv8QzJO3NOgGoXGf3GuSuNsGTxKhtd1y+Ni7rEEBJVSgVTP9TB?=
 =?us-ascii?Q?2UFF3jKPhiT/ijZwWMQaG7t51BExX/nt+p4Slm/on8bsLGsOTIBja1VOdsVZ?=
 =?us-ascii?Q?1B1uBuWtKiecD3DYilfRgbQoET+Yy4ane7HKNUNrklI1lm+Z7ufmQohNw2G4?=
 =?us-ascii?Q?apwnrHI58H0C9QkFkAkKomsnNQ9NrRQTm7jh/nFIxtmbaBz+yBeOKCiLdnzv?=
 =?us-ascii?Q?eH0R32GsUBAMWaeMlLNmXO9oV2ca/L5MmBfL1MoSg7+33ay/DkGyL6RT764p?=
 =?us-ascii?Q?7jtnUvEaB/n3JcF/feJGdd1Hff8yPfQiVgeciCKKhW4kLCIBRWexqakYZ3rZ?=
 =?us-ascii?Q?i0SVLkYcbhiZXS7Y8F0NFG9t9t45xp70Iza2jRrAmAtkooq2ZvUehjwwQQJs?=
 =?us-ascii?Q?aCopqZkYzAwntO6pxmKmzq6+6dZDYKhKK1fMJdP3+yl9I1qOZHW5zwfkyT0s?=
 =?us-ascii?Q?PzU98VVeVF4cyXRwwhWEeQnoBTNzlZ0hDmXksCM0JoU3qqkxf87CpwYC+osk?=
 =?us-ascii?Q?qr+PAMEOsod6QR0jRrl6PS6pyZ0VdDWDIIt1jJ9fcXHVknQcNebM3OrhPbpl?=
 =?us-ascii?Q?abcM9mmooH9NVZ9Yi6Am+LiQfAr0Xn04xI0P0z8sJFFAb1rHoMMo4jPsShmK?=
 =?us-ascii?Q?Yx8sI5TwVFx+UTgc44aNIWipgxjC+BI5k7dvNcXwYpuNshN3AMcTIdv/JGD7?=
 =?us-ascii?Q?jgcrGGM7Y43S8QxHDJ4xme1aGErEDjYVFw1lJj94fsvaHObqbkNoVSbhrIBC?=
 =?us-ascii?Q?nVYCxmchwB6ucEGUvYwkad6EIOuBqjE7glG8Rl9W+9hCMNfWhIlumYLYSQxF?=
 =?us-ascii?Q?pZXpD5A5zSIW/GjxSNW7ck3IXfi7fHjvQR2q0Lq7/8FkAhcLTFCsSHPWbhHs?=
 =?us-ascii?Q?JCMvC5FJBmkSRkhmMbBGAePABckfJ9KHEYKM01j3ofq18lVxjcH2+QsvUtT8?=
 =?us-ascii?Q?EgV5lTEoIwfmMvLI3kKgbeJXKh+cViz+hg19MfyfKp5AMP+9NC7+sSjrI8o2?=
 =?us-ascii?Q?uZXbyiFv+nrJzJDGKjcI/0lA41H0oOVWxk0p9UWrPndrqOxohBe2Nng0HQjl?=
 =?us-ascii?Q?hIFQDS8VANJpEwW5rAcw1nwoOZTdDMPYRdq6t0+3oduzpY2yyStizao1UMek?=
 =?us-ascii?Q?5zh5UETCYtmOvGWbUkGlYrV1ZwgKpoCx7y9GvoBnklnsg1BHtC+LB5MLNlFr?=
 =?us-ascii?Q?wAAB+o3+oPkC45jpDEIUYOxem1Ol4mZ9?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c7exhZCsqX1y8QmLhsjnW8o3ihoIsjX3b1kg79Frl/R1xLpXJjH000GpppwFyBAqaeOhnApzSYgp452nk83++QrBnTyf62mmNYFqqgf/eLhU08Ga/vVpFM9rB6eq1mmsBOjcNqPWoamqrj1o0p3WO18L4+0XcGuagzniNOwkD/ZV/q8Motoz6dHmCcfJnv34USmo2IgLBkxBgm+6Ze0SOXEBb2KG4BjCGY9cMpDiPm30I6kRnZQvIaNz2113w67OawflbHcqfRHlyVECRvLqXLClZbF5vNwO7h97BorWLvA1tYuTpOkNVDoynpny9iUyIv/jasZ6w0DIYiVStLwoPkPBhSXIF1J3OnsimHbRWy4poWllaKVnlYJCAdzioBsHbk2tzasyP1KDfvqH1yHCcErlxqS2LTdixkeNvRYPQzXAMqvoWOBN/7r1JE5SbBn/SdN7AdQ/Xn0GsKDT5irLHZwIhVrkReSBGtGFQerChdkoM8KjP+6tBYLySCbcBAdwMRizR0LdpaFpq+GxpzLFmI/od3qcWAYIIkm3Dv2ahLGoIuQ31FRkEYN4ouFqxwyT1cqmRolGCMKfYZH23K4F7n19i/+O9wbpgfoanajMnLGMtq6PhGNhcwN6IMhEi89M
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:08.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336a3b22-70a4-4463-1f80-08dcb566b418
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6655
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

Implements the new hashing API in the gcrypt hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gcrypt.c | 78 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 6378879072..830ae642b9 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -45,8 +45,86 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
+static
+QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgorithm alg, Error **errp)
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
+        hash->opaque = g_new(gcry_md_hd_t, 1);
+
+        gcry_md_open((gcry_md_hd_t *) hash->opaque, qcrypto_hash_alg_map[alg], 0);
+    }
+
+    return hash;
+}
+
+static
+int qcrypto_gcrypt_hash_free(QCryptoHash *hash)
+{
+    gcry_md_hd_t *ctx = hash->opaque;
+
+    if (ctx) {
+        gcry_md_close(*ctx);
+        g_free(ctx);
+    }
+
+    g_free(hash);
+
+    return 0;
+}
 
 
+static
+int qcrypto_gcrypt_hash_update(QCryptoHash *hash,
+                               const struct iovec *iov,
+                               size_t niov,
+                               Error **errp)
+{
+    gcry_md_hd_t *ctx = hash->opaque;
+
+    for (int i = 0; i < niov; i++) {
+        gcry_md_write(*ctx, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_gcrypt_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
+{
+    unsigned char *digest;
+    int ret = 0;
+    gcry_md_hd_t *ctx = hash->opaque;
+
+    *result_len = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[hash->alg]);
+    if (*result_len == 0) {
+        error_setg(errp, "%s",
+                   "Unable to get hash length");
+        ret = -1;
+    } else {
+        *result = g_new(uint8_t, *result_len);
+
+        /* Digest is freed by gcry_md_close(), copy it */
+        digest = gcry_md_read(*ctx, 0);
+        memcpy(*result, digest, *result_len);
+    }
+
+    return ret;
+}
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_new      = qcrypto_gcrypt_hash_new,
+    .hash_free     = qcrypto_gcrypt_hash_free,
+    .hash_update   = qcrypto_gcrypt_hash_update,
+    .hash_finalize = qcrypto_gcrypt_hash_finalize
 };
-- 
2.34.1


