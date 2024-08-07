Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF12C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjH-0005kx-DK; Wed, 07 Aug 2024 15:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjD-0005dU-SH; Wed, 07 Aug 2024 15:53:47 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjB-0001yc-QY; Wed, 07 Aug 2024 15:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060425; x=1754596425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vjOlFVPALIkssHYKTfnPmxNBwSHHIulRzDZ5emEL0ck=;
 b=sCNW4lYQ4IXGYtWJIFhFHmU1lBao5zp2EaKXdDvwDmOjUkrwF8m+ubpy
 nGtGwJu69HgZpMX2ijhZKuk+yebz0LSD5ObJxZoJToxaY+sy7OOV9Cat6
 fADPXizmSuh36nheSjcx7JDQH+p3JxXKMyXYp1R78DRV867ZnAhFZSnbw E=;
X-CSE-ConnectionGUID: /eiPaWUGTHyNuSfaPxYwcw==
X-CSE-MsgGUID: ahFBn+G5SE6vToW+nso95w==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOd3I9vvITxEOcx+I199mDj7ML2rJ1FzbiA/KsUmJQhqAp6ksbcb2TLiCWJzXgAGITzQRsnK09zYTSU38gIuuk+nB5XRdvg1qmhKF9W2brPaaw0gfAwphbZd8UvcVJ3FD5AdlWDPTnrNVGbW+XrabNgnpZaNt3m96L4S/8S+fP5d6z9wN8C20ncqixyPBQVUekV6JXyjBtOw0WLqWDqQVUw+CIPdxaZktEGecuhwLWEB6Bz+sSyiSz1nFtSt4Qf4JvBhfpP6pSSaYr70IyZTzZa+MtRdhrFY/uYzDj+46yV6ovIq18RbwEo2/bqc13+LdIxBZ5FDOk9W2w9924XswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+nZCYWp6LcTEFnVK/Ik8oeBgOmXVjXjfWSQH5F7bNM=;
 b=gxD6+VwsQb6VVunH4iUjjh3mlFDL8Fqbf3qBjjc0FPPAlyt/6tbqat7fiAxu5iscn40HtET8ZDc9OTFkig4S7Nw0wHKBAKlN1jbmJa3fvKBZwEaAcjznxx7CuYl2TuuKV718Mi1WUgAhhKm5/HPAaVHBLgP6U2gJgmxYqsG9m84wnbR+s7C8RdP7rupUpPrr0o4io/XM8ClVThBFDAw6hfoo9YrfmO8KrEjMo/DroY10WGqO8tucT+3Ig9aFiyB6JHMdWAOw31/z0LIm8NLNp4pXOyn8z+NzILT9/fQmsOy+HlTCC3dsH/QUbo22V/6Ob86If1/W9CUH5xzMb+hTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+nZCYWp6LcTEFnVK/Ik8oeBgOmXVjXjfWSQH5F7bNM=;
 b=ZqA5rKpJtV2rJd6XsjiGZUI+BB8gT+hQUeWUWVeFDDXO+krqXgYnYFDWrjDmSn0AX90LSsXPuQsjf/T9hxtFwH06JEW580fy/v0y2KIh6qEhYl5yg6Rk/9eDJOz6Cw8OgzEjpLBcj0zZiSM5jP9BVdy2E63ena9V8262aXWmpxQ=
Received: from BL1PR13CA0310.namprd13.prod.outlook.com (2603:10b6:208:2c1::15)
 by SJ0PR20MB4536.namprd20.prod.outlook.com (2603:10b6:a03:3ef::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Wed, 7 Aug
 2024 19:53:40 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::da) by BL1PR13CA0310.outlook.office365.com
 (2603:10b6:208:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.9 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:53:38 +0000
X-CSE-ConnectionGUID: UdmeCrlrQDCUXnkfu5IuCQ==
X-CSE-MsgGUID: 3MdgpI4JRNejUMxF5oLOZA==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:29 -0700
X-CSE-ConnectionGUID: KGaNtEsKSp2PXicHKrVBOg==
X-CSE-MsgGUID: Tv68JOLTT2+Hgt3EHH5f1g==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235457"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:21 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 02/15] crypto/hash-glib: Implement new hash API
Date: Wed,  7 Aug 2024 19:51:09 +0000
Message-Id: <20240807195122.2827364-3-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SJ0PR20MB4536:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 56d16580-9172-4296-a834-08dcb71aa22d
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/1JqAmA6nm9Uyj55ZA+b63K68xCpc+EOhtk/OFAuIeokgZMXdIh1R8UZScf8?=
 =?us-ascii?Q?Odg/ap78ihVPM1K6B1yT53PCBN10Ke4CWIVplDh+1XnnquYIeGVS60ZOQ02f?=
 =?us-ascii?Q?rY6rDGQMNBTN48vTM4udzQUOhnnPeV442abmE5J7+DqBfBaqEs9p3l1M9gH+?=
 =?us-ascii?Q?zq1G4RRcrTXusWfqbx4AUvaTaCIVL7FFKi7VcHQqwguidf/OAl9nUZaccDwi?=
 =?us-ascii?Q?J7HqUmwH0I2ZYv9B8dVgxsd6kORn+kaX/nBr+H03iLQRNzP7c2vKXn+s+HZX?=
 =?us-ascii?Q?/rV9ZlqosvjqtkwK228jtwSObmsBeOb84XpTxU/fSs0YVxgUZfNaVcj+RAY/?=
 =?us-ascii?Q?8o3HyNWn1C1h30wABJrHJMftHjvnDZyvq1Z98A9Pf2sjB7PTLmfTLg47zkar?=
 =?us-ascii?Q?HjOvwkuYs1jOKKybbxmIXae/BZE6V3+9tMp7+m0nL0VrijWDbzOEmyldKQZE?=
 =?us-ascii?Q?nW5xbeM2LZPA1tBJNLcGvTs1QlS6NuvYap91tVDIt9gZ4xcd3q+mxO1XqeBf?=
 =?us-ascii?Q?H0t+kf2+AtqhZw9QgtcvBGjrCNIzmUYQKrx//iKPYG3K2KfY+qAuYFVCyO+5?=
 =?us-ascii?Q?3ccDih8QVAGTZ1DXExrIf5V4zXII5H5ragjZIMeBPQr7feyxFehtLqAEw8KG?=
 =?us-ascii?Q?WJlfjpZ0Pv5DoaVcmwhcNDj1r9S73YSzLFcmKKw2Cj9kkq82PQ03DiNvD6FD?=
 =?us-ascii?Q?K3Jd0IRtR1NH1sloGtjGqDPzI4IlQtJ+DTQm1QTHG50k+39ebpqSO1Scjt7f?=
 =?us-ascii?Q?V23JPJVBNlsqTTdST9SedTakejqj2bnnj4UQlK1Ox7/mSJ1r924tuhMIlLoS?=
 =?us-ascii?Q?3tyY8qWG8FpurdXlUeljyfk9NxcXy9dr7pTKU3Cs+afv9lbXRJLqzYtpHIvB?=
 =?us-ascii?Q?l1/e+WirOxeIhDk2jNLi8Zb6fZLjvdUlXsAIIpS+oVCSfdl3e6AnCdYlRehS?=
 =?us-ascii?Q?VjD11xt2jFE6R5Yj5NmkLPzDfaBZycStmmy88XKSspHdW21kFoLfthgdx/XV?=
 =?us-ascii?Q?Bxevp0JepmhKJvSopa0mSIVi2xM82SIVAmdSo4PX2BJy7hOGySyBUlrz4leO?=
 =?us-ascii?Q?1/d07Oq5ht9ir+butUI3NkUeUFslmbZ5QiHlEyU6Y5i/1Xg4Jm6vwCtNpzLw?=
 =?us-ascii?Q?t+Gzus7hgSyYC43/zF5vG6zb/tW/XxyxgS8akNwYUuaaRQAYXDU/gpJYqpFY?=
 =?us-ascii?Q?eOfkXN8i5v+OQ8Gq3FjkXiinMI5NBnFqBMPR+yT5HVafWXeGmglupFg5mnGb?=
 =?us-ascii?Q?PY71zk8zqLAESOIsODv5aLYuOgMG8Vq8/Fe8bC3O0jue+zZBrKfcdkJmtylO?=
 =?us-ascii?Q?Wvyoi/6Fqn/CvVIHLI7BPbw/bH057gnfJqWRvTiucOQAReJiyx3SRYoR0nYB?=
 =?us-ascii?Q?8+47pKOulHrxCSs7PCw/Lfmn7RKwO7v7C+Yv5X+mKsxccpRhJx0qSJiYPe5W?=
 =?us-ascii?Q?LjFCOKqI5mT3IVfF6xfgW5ApG5aQr9R1?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yiKe6yD8gVtjbRBpL5qpbNbUOCAv9xeKPc6X43bfUwYSWV6bNtN+YmZMJJx4KYk3C8MZV7OAkHB/ZXsT7LSa6RdPAls6SsWwXfiujXar9k8a++Hwh5JQczeQD31BXz1Sj7bnS2l/YQFihusfsjqFjtOFgA7iUGKKOGt5yuoxNSPxkr3N3uU9KZRmw4X74ukebtMfIwZvFheygCavEhUzxiOhTP33WgaJTGhlPlbNTSG2BY0UX5d9tT+k9ff5/jhttxx0vMnchIEtYDFhstOWi3uQ0B3sSnDiAb4r6zffr5qZ+rUPxQ0lV71QxPPiXdXwF25cW45w41tEaJEWXGbEFEmDLrNiD4UkFvRY9e+5Wk+euXIBB4/XZQn9sHp8N1IF8zuFw8jbQqd1G4edCs+8E6RogjS4kZaaxmZS4zkoPYZDyz3xmFzV9Uk8+7a0ZTw+dx7HC2IQlc/FzdGsAh0CRpYkjMPiklm78T0lGAixXL+XjttDmgzqC9jTyN4iEKDcUmNS8LoUApZ78yaGg8qhejqP3la3bJY3Z/hqDgi74NGlEHnzAKkMIQksCV7c/qDCrHIBZif8H6HCmRDfpKcbmgn8RoWtAaYZxjTfy6jsYDZ5Q3uaCIpzj2bnzZwci75M
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:38.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d16580-9172-4296-a834-08dcb71aa22d
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4536
Received-SPF: pass client-ip=139.138.35.140;
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

Implements the new hashing API in the GLib hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-glib.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 82de9db705..9f4490762a 100644
--- a/crypto/hash-glib.c
+++ b/crypto/hash-glib.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -95,6 +96,81 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
 }
 
 
+static
+QCryptoHash *qcrypto_glib_hash_new(QCryptoHashAlgorithm alg,
+                                   Error **errp)
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
+        hash->opaque = g_checksum_new(qcrypto_hash_alg_map[alg]);
+    }
+
+    return hash;
+}
+
+static
+void qcrypto_glib_hash_free(QCryptoHash *hash)
+{
+    if (hash->opaque) {
+        g_checksum_free((GChecksum *) hash->opaque);
+    }
+
+    g_free(hash);
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
+
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
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_glib_hash_bytesv,
+    .hash_new      = qcrypto_glib_hash_new,
+    .hash_update   = qcrypto_glib_hash_update,
+    .hash_finalize = qcrypto_glib_hash_finalize,
+    .hash_free     = qcrypto_glib_hash_free,
 };
-- 
2.34.1


