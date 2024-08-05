Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD89C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb01I-0008Eu-Eh; Mon, 05 Aug 2024 11:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01F-0008Bj-VM; Mon, 05 Aug 2024 11:53:10 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01C-0003pY-Dl; Mon, 05 Aug 2024 11:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873187; x=1754409187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BOMcdhRBx+MFyzW9CBapslGt3DO6QxFzCCuTSIRWGKo=;
 b=iqTMwAPBWwNPoy1il/COlHBMsKdQZbGxs0pN/+8mtaSzT7TcoFTLB9vi
 redQ+iDs5EKdzuH8WjxqgJa6Emdp2ck0PTnpxSP3OwSTBiylUVJNddHL5
 illtzj4QJZqFXlgQf5E7x5B/lRpbNRaQ7+ceqQQZZdfo/8DNCvPWVAMaE w=;
X-CSE-ConnectionGUID: 5zhk4DCDQO+c+R7+COU5WQ==
X-CSE-MsgGUID: dK8mxXLbRIOZcyLg3SuqCg==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPtRJogdr4+ysus0cgcV7ibX90xhQf4yHl5vogW6II5vxUnszoWGNNaos/T8WW3AsqPXePB7JHDVhfprxLXa8BJIxgMOdF9pbNPYp9rOLcfeI4uRHZ/aaDJcDtGYVsejgDH+Ud3mE9OpkZdD3kJDamDqlYPDjhFLdau0cznl6EgOdzwqO5E2QSD05JTwxsT7f5BIlNDvMJAaDNwp0+lOf88OAwUFsepxSiY41C65j11gE6MItWvLjh36OZ5Ht6jFKyexDX0WB0sbTKlvc3AsMNylmc0GVzduq9FlxqmDLuUc3Z8VSwDqToTDyYozVG64gDwjTfhuzIPMyKbae3rusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QnmxkisCJ3tPcdaBGlITNYpaZwMJE+YupEMRQOuu/c=;
 b=KtnT8awjHCWzAUwHiigdZvadeg20NZS+1PuxJMjB10ah2hwB7RiqXEoa7UkhzSOICmrl0VayedEHMMGn7EUL+X7A33dPq0Pt3A5kq9ZGYu5nskubXu5HrytRKg1wq9jprhnelQOm4Vu16uQ3pZKVQj+po0A9iqN13Q9r6CIzL8gsD1nwUB0LoV5KDnmtz1NIi+Qtxdv6kEk0FLpl4f4Inwe+ekY/U9Q6QCtn6N++P+oUKXCVQZ65thi3vGjiyyKzd5YwDNZZr6QTHtXEima3tIWq/5HUOk3RxtCUok2k/JIwLoZrH47OuPT/6ZABd9btBVOpvHqtHud3h6t+8Tt02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QnmxkisCJ3tPcdaBGlITNYpaZwMJE+YupEMRQOuu/c=;
 b=Bu3z7a08nU+PoBk4cnXx7LfpaOzoU8+uD9UkUCtt94VkFuHh5O4AWTYyUpOAcdv+WgBP5xHxS+RAvh3MDccR8ozNe1yewZ5kcxhHQHM3+7YITolEHXYxs+BYqVVQ76bnc9ESfU8aKLTNVwLaRE6XU8yPsO63dgjbRDQtXdUISdM=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by DM4PR20MB4579.namprd20.prod.outlook.com (2603:10b6:8:5e::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.26; Mon, 5 Aug 2024 15:52:58 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::2b) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 15:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:52:57 +0000
X-CSE-ConnectionGUID: VTfTjCF+Syy/Qnad6JJfVA==
X-CSE-MsgGUID: 9JYVQX2jTwuAFbGaXaTAAA==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:57:50 -0700
X-CSE-ConnectionGUID: 8AE/t9PjSWKZJ7uJpj9S2Q==
X-CSE-MsgGUID: cYiHsETSQGSMr1PgvrGyoA==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920684"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:52:50 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 03/12] crypto/hash-glib: Implement new hash API
Date: Mon,  5 Aug 2024 15:50:38 +0000
Message-Id: <20240805155047.3151540-4-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM4PR20MB4579:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 515dbe6d-c015-4137-3d71-08dcb566ada6
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wETu6vT2jRLlhfNfZruOZaQ4ttzS6WbOY8qsMAf2PLdvJcVFWia0J4EjJHFp?=
 =?us-ascii?Q?lzzn6JfVWuEFFELhS4T8e8G2Xz5Ek9QtgKbF4wxT3u87F9I3UG2hsulW3jnT?=
 =?us-ascii?Q?9nsvh0S8It1hXiDf5Mfqz4OAizWcDA3iyNhfbDvSbZ8KIdbqzP1kNMMtQJqe?=
 =?us-ascii?Q?EfsyPlBJig4k7uyp51s3PQWfMm7LR4y5dX/D4YKPh0Z+BjJjtEF5oH27KWPO?=
 =?us-ascii?Q?C9su8pQUUpo79qiMyh3ID/oaljQdXzjasCb/n4R1Bba2AF9eh9PNoTyPBvQF?=
 =?us-ascii?Q?i4oY7ntE75ed00dujern1aFeYWSH7/pl6ntuVoBsCRvOY675sQlUELkb4xwi?=
 =?us-ascii?Q?LvdVEjlDWPICNWMYRDXxfEzRztdttgz4gCWuUCw+BeWJYnnFCe6OaFiDtrSf?=
 =?us-ascii?Q?hWwnxZkXnhRG92H1PO7UDTMZt9hZ1FpupIYIhykO+YDJ6krDsExXHlkKF23i?=
 =?us-ascii?Q?pIihDKk+ZQKKga0Zu927KUJonjEPQ4vIFmIFLl600uOTsfxRqJQYsf9nFrfu?=
 =?us-ascii?Q?0BEdc4MaQOqwTeRh+HPK6lH0allXmlBbcrB3otSadeAlzOix5edvg1mL0Sjp?=
 =?us-ascii?Q?QkmXrRFjB+iQio8815cmb4C8jxmzQz6LhhSJoQdpIDm4wt2VR2qwUmvRA9Wi?=
 =?us-ascii?Q?JLJUsXY77MDJ7Xg3hvMZzAcEp/tQ3uqyPyf1Eyd5ITBkTIjko8aKRemCrk/v?=
 =?us-ascii?Q?Ws/cl+EGlkN/NCkdxmXaIsYg+bW3IkKCXeyfYvdLqCT+ZHawSdhnfVTKp76h?=
 =?us-ascii?Q?hh4V0C5QRDiPExF9ruaEbNW1IbZ+jvk2H0uSy3q7jUQs9TXcKefbJ3Qi9p3a?=
 =?us-ascii?Q?TYN+3jt1B4yRsT4UfLI+iHeKRflvxE8Veaw7kl4IIPpxjUZypOeSARBT/cCx?=
 =?us-ascii?Q?odSgg7xO6Qrp5b4bUw4XPRnmjVNAnt3khIl9uTij1pubjLv/YwpPNx9i8cnQ?=
 =?us-ascii?Q?832Z0zWitEiuRMS3ptZDpTTmbJ0ut1WjXVvxeJjr5VsCulaad5uBTjQNReFq?=
 =?us-ascii?Q?PVbnzyi2srBOtJwh/J2hXkk2BbWrzSGsvtO3qsSxA7TY+wIHRgT4JHa1+pjs?=
 =?us-ascii?Q?iwxTgT2AVBXOtRM5oALudLpcWkpSb6ZCCu2U2l+5lFuZ/4pqxL0VDDUOYge2?=
 =?us-ascii?Q?WnXNonHFU0l3u5xrxw/fVyqcwlYWb6InXa8tJy69REuQPEljwoOOfX/MGQOP?=
 =?us-ascii?Q?1JNEoV+//J315v28bVjGvZ626aJL73pUyc4OyNBLs21uGSezpBEWJ77ETWlf?=
 =?us-ascii?Q?bN0s7mMIdHQASwptXHIRnNm/oQA/MCrNgedgEg2kjKMEp3kkpD6Pr5hS2tto?=
 =?us-ascii?Q?sDIoq0M530Z05wEj67fZkWxXG3MB+CsuzUy1box3feywQGFQa0dhEVtlL7Ld?=
 =?us-ascii?Q?hRgaNtMiG8N3pA0KzGPH1bp5tRg/4/VVfKMxFzPxgYqzb3WjB8SuWDhqf8I0?=
 =?us-ascii?Q?7OXLXnqe2WA6kEEVFi0hRg/cpCY9SrEe?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hSgT2N54Q32TTIxk//TrvW75/nD8hB5IaiLdSPxl6BDAEdMcPtmZaQ2zwysz+Z6yVXYjL/KELBXBsOQF4a6rju5LT9fanVWRK0yiqbKkmhIxI87SHhFKI+ybwBeZAa++1fJpGc0MVco5LhGQlQfwCm8dU4HJxfcsRGoyODDDIcmqtJfKJUNpdpalL00PtJFrQnHlmfK7alaDV3PMBq9IJOIA5tI/8Um31RrHlIQxo10xAfX3OWJF20UGEWRhgOeL3tfCa6w8RL/1evUdztC1CN9wlXfZ9ab+lna5JVegH2LiefbeHQKaFO1tPGQjqpS6mr/LPFHKYdSk/rQXlwSAkHkeyKoyvNxOPw/DNAT5QyMVkDQJNZO4skvw4h4morhP6SUEo1I9clGs5byQqaK75j4w56q3IT44d5GvjjszXCKhk9leTTsjg8W/5NTVQRKQF0OGPDUlykHCqFsOcsSgW+NcZZCim5PXC8uqZ9UPtLHg+7awd2AkA3+PVFcGrLDsdtSFt2+AYdtmkB1AZ9WayYh9mI9KP6hapPXn9+WPHZABZpM3hF+bOax6nUCnOrd+ql+Hs/TAylxyimvqEELSeUNjS6N2YQ0mmBQeTBFIXFEhTjtuOk6zCQonQGQt3eSl
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:52:57.9724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515dbe6d-c015-4137-3d71-08dcb566ada6
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4579
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

Implements the new hashing API in the GLib hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-glib.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index ceaf346bf4..4f343e7d61 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -44,8 +44,83 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
+static
+QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgorithm alg,
+                                   Error **errp)
+{
+    QCryptoHash *hash = NULL;
 
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+    } else {
+        hash = g_new(QCryptoHash, 1);
+        hash->alg = alg;
+        hash->opaque = g_checksum_new(qcrypto_hash_alg_map[alg]);
+    }
 
-QCryptoHashDriver qcrypto_hash_lib_driver = {
+    return hash;
+}
+
+static
+int qcrypto_glib_hash_free(QCryptoHash *hash)
+{
+    if (hash->opaque) {
+        g_checksum_free((GChecksum *) hash->opaque);
+    }
+
+    g_free(hash);
+
+    return 0;
+}
+
+
+static
+int qcrypto_glib_hash_update(QCryptoHash *hash,
+                             const struct iovec *iov,
+                             size_t niov,
+                             Error **errp)
+{
+    GChecksum *ctx = hash->opaque;
 
+    for (int i = 0; i < niov; i++) {
+        g_checksum_update(ctx, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_glib_hash_finalize(QCryptoHash *hash,
+                               uint8_t **result,
+                               size_t *result_len,
+                               Error **errp)
+{
+    int ret;
+    GChecksum *ctx = hash->opaque;
+
+    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[hash->alg]);
+    printf("Hash length is %i\n", ret);
+    if (ret < 0) {
+        error_setg(errp, "%s",
+                   "Unable to get hash length");
+        *result_len = 0;
+        ret = -1;
+    } else {
+        *result_len = ret;
+        *result = g_new(uint8_t, *result_len);
+
+        g_checksum_get_digest(ctx, *result, result_len);
+        ret = 0;
+    }
+
+    return ret;
+}
+
+QCryptoHashDriver qcrypto_hash_lib_driver = {
+    .hash_new      = qcrypto_glib_hash_new,
+    .hash_free     = qcrypto_glib_hash_free,
+    .hash_update   = qcrypto_glib_hash_update,
+    .hash_finalize = qcrypto_glib_hash_finalize
 };
-- 
2.34.1


