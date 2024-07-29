Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479CC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 19:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYVdV-0000ur-US; Mon, 29 Jul 2024 15:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYVdT-0000sv-Kh; Mon, 29 Jul 2024 15:02:19 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYVdP-0005MB-Vg; Mon, 29 Jul 2024 15:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722279735; x=1753815735;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Em4Cx7ysBDcwglDDDCxsem4w3ImK/8khDwLlDsD9x2s=;
 b=rP3lpd1vY/aK2ElPasDBeqt9kVKid0QRsx8eHHz4HFxgiQay3UU8BqS/
 /J4ZG5K//FFUXr9vAlDAjL3jB02Zra+yLbKIWCveY3Shf8IJnbHUZO+Sz
 KZyVlGH7DYt2gzq6aEQxqXiQS55N3xlLZDWafNHx15oT/My0x1SGfD5Nj g=;
X-CSE-ConnectionGUID: fvdMn4V7SXqxizEPr/CXWg==
X-CSE-MsgGUID: 5wGai6tsQfCW35g0k1qGMQ==
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 12:02:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMwC9csGjRiOSprYhpthhv6JOgSsUDCWBcCg8+u7WnHBA4/z8sDY+/4SkUS8kavO9ydZJNlf+Al5o8IolzP3hpY1LKOoOeRmz9czmbxbkKNqn7AvPFG975PCOH4tLf9Y+CbMC1A/uCqMZfSL7tcUHitoHmQI4IVXAddTj0FnwpVt5bsRnmE34AoG/Yb2IChLVrGTsa8CXvsLnh9vgN0HNR3MHbX1wG9tF7t60h9EKY34cJqB88MLPsaj8F+VYvy7kKpZUyorvK8ZrzGVXxthbvKN8XCebJbfZzbKpG/VCpS8HZ5zANbKlQ1p3SCL9MGTlLFERrtvOnxEQL7eg20wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TY5AN6yBGaCopoEWAQ7cZEseu2nId/4SHSdCh4757fE=;
 b=cXmEeeL0nd7kcQHdSjooEmR8ddLdI2kvHHPAk/j1lDzAOGap7ozsuBjOs6Mv2Sghqo7dWtCx+AMHxVKlQcy8VCY/LJK1iRdyHGOtekfSbQ6gDl6jBtFkUOmJVyyeR+CQotv6LDxBHz4V1DV4nLMBhN4gQPpxYFqf0sdxd8P6qAlK3jURnQaTlcmYOyxpDYAldjHgRo4zm/cdlTevXThGODjugRhjmqlE1ZwayBbGAkgM7z751b8UDin3BOjUOF6rAeIlz5yOYQ0g/jxiLWYFI5blYxOmmqi5b42HOdjo4n0VDw/RBwh8Y1NuTq7/ZBHb1jTntSyomIhXTkKH7NYfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.50) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TY5AN6yBGaCopoEWAQ7cZEseu2nId/4SHSdCh4757fE=;
 b=c33aLj3K6iLkTVZDhyjpYyTW/UZz8tNjlW2m0CtmsVcR/BkJ4uxG0V78ndxY3ENuJqGAahLy/2hZ6s3Q8fhvebQnERg44vZkzWA7Fxu1pSIGumRGViaKpp+DV/UIDa3Gc5guoVDk37vA1yb6WjEwlVFbHvFpjdjpoZKhX6USl/k=
Received: from SJ0PR13CA0118.namprd13.prod.outlook.com (2603:10b6:a03:2c5::33)
 by MW6PR20MB6645.namprd20.prod.outlook.com (2603:10b6:303:239::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 19:02:11 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::4b) by SJ0PR13CA0118.outlook.office365.com
 (2603:10b6:a03:2c5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.18 via Frontend
 Transport; Mon, 29 Jul 2024 19:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.50)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa001.seagate.com (192.55.16.50) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 19:02:09 +0000
X-CSE-ConnectionGUID: IErEXfHySx6wiVCbhRvHdA==
X-CSE-MsgGUID: gzzXzfCzRh64mawR75zuGA==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa001.seagate.com with ESMTP; 29 Jul 2024 12:02:03 -0700
X-CSE-ConnectionGUID: XsQu3/xgQxGRNsdssQlVtg==
X-CSE-MsgGUID: M9AWJm8bTDerOETgeMcK+Q==
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; d="scan'208";a="121679665"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 29 Jul 2024 12:01:54 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 berrange@redhat.com, alejandro.zeise@seagate.com
Subject: [PATCH v2 1/2] crypto: add support for accumulative hashing
Date: Mon, 29 Jul 2024 19:00:34 +0000
Message-Id: <20240729190035.3419649-2-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
References: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MW6PR20MB6645:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79cb02dc-e02c-44a9-f2bb-08dcb000f340
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k/onJAWJG4CzF0yiDVDMn+VNgpFWNWrbsQmKqjk7lux2kuU5JNIskp8BDaDH?=
 =?us-ascii?Q?+nKgqOHXWaPjjlCxBP+A5zi6M6xSIOjJbM34XvVmg2pb5UjY7JcJa1COxNYq?=
 =?us-ascii?Q?FdfVmxnD9GxTvVOtv25POJpomh6JXDr/3SmAtU/q1CZ7bvIlJaGLWASpXMk5?=
 =?us-ascii?Q?+2cuTNMV4DGm1tt56udLDFfp3j1Ze3bbmVhzuO8SS5dOGvP4i5/Q5+EDBp19?=
 =?us-ascii?Q?Mz7fj8SoDz+vFzR+HJc6pJSNxvjD6TVbWRcOYe7JaUOjdFsG51l2xeC/9UxT?=
 =?us-ascii?Q?a9MjnZe5F95tbh6g+ty3T2MOGgdb8T8EEtOtWA9nu5MF5P02J+wsDLWkmgSB?=
 =?us-ascii?Q?uE22OOikDWSm4KNNWRUZG3wNIc9I6j9ceSxVD+gRlj4YmXzuAM+I7SDW/lWN?=
 =?us-ascii?Q?j1OEeO7vXkLcUD0gBoChqf0+P9MO+v96y9COHueRA/bjGne/zbuK1/3vYQkj?=
 =?us-ascii?Q?RYaSDLLk0Aeky342G8pE3jxJbQW0qi/P8K6jmqsRLzyrz6dvsn/v1IEDf/lJ?=
 =?us-ascii?Q?Z2I3FBntxSU3Y9uIeEGwRULRtZytiYcewdRC6SV+goF50FsasnVKmyhDYkPt?=
 =?us-ascii?Q?gAozQdnKBRz41PNUT38lB3TlR1ik5u0CaWERbXfsjaei5yKQWaWPv5wHZFqu?=
 =?us-ascii?Q?5uH/8y9A7Dme2i5A5RYYCZhTMIT4s3J+iDCjxr26RCWBa9kFEr39V6OytmIC?=
 =?us-ascii?Q?TxkzuuhWz5/o6UKkXeu/zt91v3rXgxF0vb6MnMCWir33zljFLiJ82WjQdPF4?=
 =?us-ascii?Q?DawwqtQVlsmLtdBKtF7UxffCrjadQv/RjVYXy2YYyT5bB0Hnq531fuuus8Az?=
 =?us-ascii?Q?ibtKmn1vO2Bu/6ZtWQRw+b6WY/TWaavMHzDSfv9FXEO5p+i+NTonLYKXd4n4?=
 =?us-ascii?Q?n7XSCUsyK5N8liZAS+mkLsz66O4VkeVfIxMkmPkx3ASvjv69eU8A9cZRkSLD?=
 =?us-ascii?Q?7ppeMoLRuOqSYoEgkeq3sI8qHEN5GarS2/haA0wSgu42A2ke9LYPZLwZHCaK?=
 =?us-ascii?Q?LxHQODqtt9HFDAxhmfpWnpWo+McLOrILNChjFs1nL7lN+Rigv3vUpcIjF/77?=
 =?us-ascii?Q?MMbSqsd4B8zdCXc6aoU69rJDnfKNxX7vhYfvwUU0DYllq/tJUoL8HwXCKe+o?=
 =?us-ascii?Q?eNeh3b+jzpRwcZZ+yrV7cFvfQt1pBBThKWpQ2n60enn3gGpso9rBX4+X9093?=
 =?us-ascii?Q?acNVfFIGVgg55BnvTQFMjQ8Ky3nP/oLelYomAoGoRos4u1uLDiyGxzT8EPVb?=
 =?us-ascii?Q?/AQYkcY8wl6eKYY6JhAy/u86kulpIZytSUSCYRqKeOHWX6CsDOZdjBvcypTl?=
 =?us-ascii?Q?6fWsAyYlVDwyo9j0OqIxYAFJWKg5p48+sHg8aW6/kLE6sOtyY3djmbiP5qqa?=
 =?us-ascii?Q?64aFIzEssDf/99VX7VsvPEcDztt7ukV1a6AfwBdkSGwbawUHsy/ZKa88DUuN?=
 =?us-ascii?Q?Cm74Yqxk+kIVgN/IAlY3+Fs0eRvMqNxp?=
X-Forefront-Antispam-Report: CIP:192.55.16.50; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa001.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U0MIE8l9T1qHUDJgWAHYKcm171TNMmY4UH1TUFYjvI2vB5vGD1Kh/Xp20aJe25vRfRkJRCp1ZUPGZBYoypwm2y/skKKyANecXj8eXS2B8lzMWhiHFXJgNlh3h6oRw0rS7HfkksrgiXQozCBb03XIOM/XYi2SvudSOXb682MgU98aFTpXU3aWouPdddwKtzdCQHIiQ/SDNl585poy4SiQvvHkgkla4Y/ieKMy3wczW5iDZpqndb+hfkE/unNp57yu1b9Y33OL42TxUB0PFOnITNb6rU3+q4OvRnc0kiSkdDx5MNFtC1FmDJjOyXmccZUqBpnv2J5t1oDynHN7rdcmurkYv2+JpM84S/5Bb8rQV0rAQAGaEw77mHNYqmF0XUPFEvxrvkRye6zfO2/DGfFDdeShcJ1Lkd1G/fdN2GPuJfFI9n+BLuH2TeHVmtpFYOPp1+1iVA9MIiwINf67ewblPZJxcFa7k7ytdFFW4S4A9D7NRUF65aKfknCm/2HUUyldOB4KC6gfQC6+ObvTER04mLrTsYmYez39ti/6j8HdvF/ui7/9qcq+bT7IEZjt9OzWHo54r16MmzaIR91JeCQ4vsQghvszdxhL2HORxeyXJYTy9kjAKsPkAdGQ7vsjcbXT
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:02:09.9251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cb02dc-e02c-44a9-f2bb-08dcb000f340
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.50];
 Helo=[sgspzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6645
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
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

This change adds an accumulative hashing function
(qcrypto_hash_accumulate_bytesv) and implementation
for each of the crypto library backends that QEMU supports.

The QCrypto API did not support hashing in an accumulative mode.
As such, hardware hash modules (like the HACE from Aspeed's SoCs) are
unable to perform such operations correctly when the guest requires it.

The creation and freeing of each library's context is abstracted by
the qcrypto_hash_accumulate_new_ctx and qcrypto_hash_accumulate_free_ctx
functions.

Changes in V2:
* Fixed error checking bug in libgcrypt backend

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gcrypt.c  | 105 ++++++++++++++++++++++++++++++++++++++++++
 crypto/hash-glib.c    |  89 +++++++++++++++++++++++++++++++++++
 crypto/hash-gnutls.c  |  82 +++++++++++++++++++++++++++++++++
 crypto/hash-nettle.c  |  93 +++++++++++++++++++++++++++++++++++++
 crypto/hash.c         |  42 +++++++++++++++++
 crypto/hashpriv.h     |  11 +++++
 include/crypto/hash.h |  65 ++++++++++++++++++++++++++
 7 files changed, 487 insertions(+)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 829e48258d..6ef7e67711 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -110,7 +111,111 @@ qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
     return -1;
 }
 
+static
+int qcrypto_gcrypt_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
+                                           qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
+                                           Error **errp)
+{
+    int ret;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    ret = gcry_md_open((gcry_md_hd_t *) accumulate_ctx, qcrypto_hash_alg_map[alg], 0);
+
+    if (ret < 0) {
+        error_setg(errp,
+                   "Unable to initialize hash algorithm: %s",
+                   gcry_strerror(ret));
+        return -1;
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_gcrypt_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
+                                            Error **errp)
+{
+    if (hash_ctx != NULL) {
+        gcry_md_close((gcry_md_hd_t) hash_ctx);
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_gcrypt_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
+                                          qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
+                                          const struct iovec *iov,
+                                          size_t niov,
+                                          uint8_t **result,
+                                          size_t *resultlen,
+                                          Error **errp)
+{
+    int i, ret;
+    gcry_md_hd_t ctx_copy;
+    unsigned char *digest;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    for (i = 0; i < niov; i++) {
+        gcry_md_write((gcry_md_hd_t) accumulate_ctx, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    ret = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[alg]);
+    if (ret <= 0) {
+        error_setg(errp,
+                   "Unable to get hash length: %s",
+                   gcry_strerror(ret));
+        return -1;
+    }
+
+    if (*resultlen == 0) {
+        *resultlen = ret;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *resultlen, ret);
+        return -1;
+    }
+
+    /*
+     * Make a copy so we don't distort the main context
+     * by calculating the intermediate hash
+     */
+    ret = gcry_md_copy(&ctx_copy, (gcry_md_hd_t) accumulate_ctx);
+    if (ret) {
+        error_setg(errp, "Unable to make copy: %s", gcry_strerror(ret));
+        return -1;
+    }
+
+    digest = gcry_md_read(ctx_copy, 0);
+    if (!digest) {
+        error_setg(errp,
+                   "No digest produced");
+        return -1;
+    }
+    memcpy(*result, digest, *resultlen);
+    gcry_md_close(ctx_copy);
+
+    return 0;
+}
+
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
+    .hash_accumulate_bytesv = qcrypto_gcrypt_hash_accumulate_bytesv,
+    .accumulate_new_ctx = qcrypto_gcrypt_hash_accumulate_new_ctx,
+    .accumulate_free_ctx = qcrypto_gcrypt_hash_accumulate_free_ctx,
 };
diff --git a/crypto/hash-glib.c b/crypto/hash-glib.c
index 82de9db705..c0d1d72c88 100644
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
@@ -95,6 +96,94 @@ qcrypto_glib_hash_bytesv(QCryptoHashAlgorithm alg,
 }
 
 
+static
+int qcrypto_glib_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
+                                         qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
+                                         Error **errp)
+{
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    *accumulate_ctx = g_checksum_new(qcrypto_hash_alg_map[alg]);
+
+    return 0;
+}
+
+static
+int qcrypto_glib_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
+                                          Error **errp)
+{
+    if (hash_ctx != NULL) {
+        g_checksum_free((GChecksum *) hash_ctx);
+    }
+
+    return 0;
+}
+
+
+static
+int qcrypto_glib_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
+                                        qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
+                                        const struct iovec *iov,
+                                        size_t niov,
+                                        uint8_t **result,
+                                        size_t *resultlen,
+                                        Error **errp)
+{
+    int i, ret;
+    GChecksum *ctx_copy;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    for (i = 0; i < niov; i++) {
+        g_checksum_update((GChecksum *) accumulate_ctx, iov[i].iov_base, iov[i].iov_len);
+    }
+
+    ret = g_checksum_type_get_length(qcrypto_hash_alg_map[alg]);
+    if (ret < 0) {
+        error_setg(errp, "%s",
+                   "Unable to get hash length");
+        return -1;
+    }
+    if (*resultlen == 0) {
+        *resultlen = ret;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *resultlen, ret);
+        return -1;
+    }
+
+    /*
+    Make a copy so we don't distort the main context
+    by calculating the intermediate hash.
+    */
+    ctx_copy = g_checksum_copy((GChecksum *) accumulate_ctx);
+    if (ctx_copy == NULL) {
+        error_setg(errp, "Unable to make copy: %s", __func__);
+        return -1;
+    }
+
+    g_checksum_get_digest((GChecksum *) ctx_copy, *result, resultlen);
+    g_checksum_free(ctx_copy);
+
+    return 0;
+}
+
+
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_glib_hash_bytesv,
+    .hash_accumulate_bytesv = qcrypto_glib_hash_accumulate_bytesv,
+    .accumulate_new_ctx = qcrypto_glib_hash_accumulate_new_ctx,
+    .accumulate_free_ctx = qcrypto_glib_hash_accumulate_free_ctx,
 };
diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
index 17911ac5d1..9464893213 100644
--- a/crypto/hash-gnutls.c
+++ b/crypto/hash-gnutls.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2021 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -99,6 +100,87 @@ qcrypto_gnutls_hash_bytesv(QCryptoHashAlgorithm alg,
 }
 
 
+static
+int qcrypto_gnutls_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
+                                           qcrypto_hash_accumulate_ctx_t **hash_ctx,
+                                           Error **errp)
+{
+    int ret;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    ret = gnutls_hash_init((gnutls_hash_hd_t *) hash_ctx, qcrypto_hash_alg_map[alg]);
+    if (ret < 0) {
+        error_setg(errp,
+                   "Unable to initialize hash algorithm: %s",
+                   gnutls_strerror(ret));
+        return -1;
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_gnutls_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
+                                            Error **errp)
+{
+    if (hash_ctx != NULL) {
+        gnutls_hash_deinit((gnutls_hash_hd_t) hash_ctx, NULL);
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_gnutls_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
+                                          qcrypto_hash_accumulate_ctx_t *hash_ctx,
+                                          const struct iovec *iov,
+                                          size_t niov,
+                                          uint8_t **result,
+                                          size_t *resultlen,
+                                          Error **errp)
+{
+    int i, ret;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    ret = gnutls_hash_get_len(qcrypto_hash_alg_map[alg]);
+    if (*resultlen == 0) {
+        *resultlen = ret;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != ret) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %d",
+                   *resultlen, ret);
+        return -1;
+    }
+
+    for (i = 0; i < niov; i++) {
+        gnutls_hash((gnutls_hash_hd_t) hash_ctx,
+                    iov[i].iov_base, iov[i].iov_len);
+    }
+
+    /* Make a copy so we don't distort the main context */
+    gnutls_hash_hd_t copy = gnutls_hash_copy((gnutls_hash_hd_t) hash_ctx);
+    gnutls_hash_deinit(copy, *result);
+
+    return 0;
+}
+
+
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_gnutls_hash_bytesv,
+    .hash_accumulate_bytesv = qcrypto_gnutls_hash_accumulate_bytesv,
+    .accumulate_new_ctx = qcrypto_gnutls_hash_accumulate_new_ctx,
+    .accumulate_free_ctx = qcrypto_gnutls_hash_accumulate_free_ctx,
 };
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 1ca1a41062..e21d0c6cf9 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto hash algorithms
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2016 Red Hat, Inc.
  *
  * This library is free software; you can redistribute it and/or
@@ -155,7 +156,99 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
     return 0;
 }
 
+static
+int qcrypto_nettle_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
+                                           qcrypto_hash_accumulate_ctx_t **hash_ctx,
+                                           Error **errp)
+{
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    *((union qcrypto_hash_ctx **) hash_ctx) = g_malloc(sizeof(union qcrypto_hash_ctx));
+
+    qcrypto_hash_alg_map[alg].init(*((union qcrypto_hash_ctx **) accumulate_ctx));
+
+    return 0;
+}
+
+static
+int qcrypto_nettle_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *hash_ctx,
+                                            Error **errp)
+{
+    g_free((union qcrypto_hash_ctx *) hash_ctx);
+    return 0;
+}
+
+static
+int qcrypto_nettle_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
+                                          qcrypto_hash_accumulate_ctx_t *hash_ctx,
+                                          const struct iovec *iov,
+                                          size_t niov,
+                                          uint8_t **result,
+                                          size_t *resultlen,
+                                          Error **errp)
+{
+    union qcrypto_hash_ctx *ctx_copy;
+    int i;
+
+    if (!qcrypto_hash_supports(alg)) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+        return -1;
+    }
+
+    for (i = 0; i < niov; i++) {
+        /* Some versions of nettle have functions
+         * declared with 'int' instead of 'size_t'
+         * so to be safe avoid writing more than
+         * UINT_MAX bytes at a time
+         */
+        size_t len = iov[i].iov_len;
+        uint8_t *base = iov[i].iov_base;
+        while (len) {
+            size_t shortlen = MIN(len, UINT_MAX);
+            qcrypto_hash_alg_map[alg].write((union qcrypto_hash_ctx *) hash_ctx,
+                                            len, base);
+            len -= shortlen;
+            base += len;
+        }
+    }
+
+    if (*resultlen == 0) {
+        *resultlen = qcrypto_hash_alg_map[alg].len;
+        *result = g_new0(uint8_t, *resultlen);
+    } else if (*resultlen != qcrypto_hash_alg_map[alg].len) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than hash %zu",
+                   *resultlen, qcrypto_hash_alg_map[alg].len);
+        return -1;
+    }
+
+    /*
+    Make a copy so we don't distort the main context
+    by calculating the intermediate hash
+    */
+    ctx_copy = g_new(union qcrypto_hash_ctx, 1);
+    memcpy(ctx_copy, (union qcrypto_hash_ctx *) hash_ctx,
+           sizeof(union qcrypto_hash_ctx));
+
+    qcrypto_hash_alg_map[alg].result(ctx_copy,
+                                     *resultlen, *result);
+
+    g_free(ctx_copy);
+
+    return 0;
+}
+
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_nettle_hash_bytesv,
+    .hash_accumulate_bytesv = qcrypto_nettle_hash_accumulate_bytesv,
+    .accumulate_new_ctx = qcrypto_nettle_hash_accumulate_new_ctx,
+    .accumulate_free_ctx = qcrypto_nettle_hash_accumulate_free_ctx,
 };
diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..0d45ce1e1b 100644
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
@@ -77,6 +78,47 @@ int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
     return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
 }
 
+int qcrypto_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
+                                   qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
+                                   const struct iovec *iov,
+                                   size_t niov,
+                                   uint8_t **result,
+                                   size_t *resultlen,
+                                   Error **errp)
+{
+#ifdef CONFIG_AF_ALG
+    qemu_log_mask(LOG_UNIMP, "%s: AF_ALG support unimplemented.\n", __func__);
+    return 1;
+#else
+    return qcrypto_hash_lib_driver.hash_accumulate_bytesv(alg, accumulate_ctx,
+                                                          iov, niov, result,
+                                                          resultlen, NULL);
+#endif /* CONFIG_AF_ALG */
+}
+
+int qcrypto_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
+                                    qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
+                                    Error **errp)
+{
+#ifdef CONFIG_AF_ALG
+    qemu_log_mask(LOG_UNIMP, "%s: AF_ALG support unimplemented.\n", __func__);
+    return 1;
+#else
+    return qcrypto_hash_lib_driver.accumulate_new_ctx(alg, accumulate_ctx, errp);
+#endif /* CONFIG_AF_ALG */
+}
+
+int qcrypto_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
+                                     Error **errp)
+{
+#ifdef CONFIG_AF_ALG
+    qemu_log_mask(LOG_UNIMP, "%s: AF_ALG support unimplemented.\n", __func__);
+    return 1;
+#else
+    return qcrypto_hash_lib_driver.accumulate_free_ctx(accumulate_ctx, errp);
+#endif /* CONFIG_AF_ALG */
+}
+
 static const char hex[] = "0123456789abcdef";
 
 int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index cee26ccb47..49b3927208 100644
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
@@ -24,6 +25,16 @@ struct QCryptoHashDriver {
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp);
+    int (*hash_accumulate_bytesv)(QCryptoHashAlgorithm alg,
+                                  void *hash_ctx,
+                                  const struct iovec *iov,
+                                  size_t niov,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp);
+    int (*accumulate_new_ctx)(QCryptoHashAlgorithm alg, void **hash_ctx,
+                              Error **errp);
+    int (*accumulate_free_ctx)(void *hash_ctx, Error **errp);
 };
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 54d87aa2a1..fb8ae2d099 100644
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
@@ -25,6 +26,8 @@
 
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
+typedef void qcrypto_hash_accumulate_ctx_t;
+
 /**
  * qcrypto_hash_supports:
  * @alg: the hash algorithm
@@ -120,6 +123,68 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
                          char **digest,
                          Error **errp);
 
+/**
+ * qcrypto_hash_accumulate_bytesv:
+ * @alg: the hash algorithm
+ * @accumulate_ctx: pointer to the algorithm's context for further hash operations
+ * @iov: the array of memory regions to hash
+ * @niov: the length of @iov
+ * @result: pointer to hold output hash
+ * @resultlen: pointer to hold length of @result
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash across all the memory regions
+ * present in @iov using the existing hash context
+ * given in @accumulate_ctx. The @result pointer will be
+ * filled with raw bytes representing the computed
+ * hash, which will have length @resultlen. The
+ * memory pointer in @result must be released
+ * with a call to g_free() when no longer required.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_accumulate_bytesv(QCryptoHashAlgorithm alg,
+                                   qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
+                                   const struct iovec *iov,
+                                   size_t niov,
+                                   uint8_t **result,
+                                   size_t *resultlen,
+                                   Error **errp);
+
+/**
+ * qcrypto_hash_accumulate_new_ctx:
+ * @alg: the hash algorithm
+ * @accumulate_ctx: pointer to the pointer holding the algorithm's
+ *                  context for further hash operations. The pointer will
+ *                  be modified to point to the memory this function
+ *                  allocates to hold the context.
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Creates a new hashing context for the chosen algorithm for
+ * usage with qcrypto_hash_accumulate_bytesv().
+ * This is useful for when one has multiple inputs to compute a hash, but
+ * not all are available at a single point in time, making qcrypto_hash_bytesv()
+ * inadequate. The @accumulate_ctx pointer must be released with a call to
+ * qcrypto_hash_accumulate_free_ctx() once all hash operations are complete.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_accumulate_new_ctx(QCryptoHashAlgorithm alg,
+                                    qcrypto_hash_accumulate_ctx_t **accumulate_ctx,
+                                    Error **errp);
+
+/**
+ * qcrypto_hash_accumulate_free_ctx:
+ * @accumulate_ctx: pointer to the algorithm's context for further hash operations
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * frees a hashing context for the chosen algorithm.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int qcrypto_hash_accumulate_free_ctx(qcrypto_hash_accumulate_ctx_t *accumulate_ctx,
+                                     Error **errp);
+
 /**
  * qcrypto_hash_digest:
  * @alg: the hash algorithm
-- 
2.34.1


