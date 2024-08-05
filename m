Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B03C52D71
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb01N-0008Ue-8u; Mon, 05 Aug 2024 11:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01J-0008Ix-D0; Mon, 05 Aug 2024 11:53:13 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01G-0003qW-H8; Mon, 05 Aug 2024 11:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873190; x=1754409190;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lFiy+n3NJhJIy0urdSThUoEGyqVFZkQWwKRP0mj1ccg=;
 b=jZ8u1JrUJrWBLzs8QKysg9+OMf11R71BMoy8JUn4DR0FpMSMMSgv6YK0
 yp3yDNSQUw63CZIxKPSmQnc6KXdr/o+v9KME91D8+/0ABeOLzFeF8vzNc
 sVRWv4PJQpgmhvDzks2YGWw34u5REM+93yM2x/kOb8QBmXIxcvzVb9rNW Q=;
X-CSE-ConnectionGUID: O+GVTX0wRc2MwsD86jEIyw==
X-CSE-MsgGUID: pXapT5BiRZqtUScycUtQlg==
Received: from mail-bn7nam10lp2046.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.46])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn5YSKtXVz6cgWwUtIgICphL/eFgfemVwX40jFd+Own5VtSJg6fT5S0XD63BMnxpEwxmw1ItbGBXq2Eqe5DZC7R+HvEXbhOtA8qDLqevFWJNeQCRdUKmm2og4oTE2bVO+Ujm8W4QS1OpWOeXDMD7T8R7QH5j1lSkck2/bZWnDCXtapnGsoiwuCeee3LOsl7MqllZpyF1fbCvcPMk7kerhm6FZoh2tFnkwUa5OXvpWx4fyawku5/0Ub0cPKMvKjKszuWWQFi2gbbDjHzaPaq1TOBznQqfh0KPVChx5xfUHk9tCnDUXjJFUVjcrRXXe9tUlqhD92h9QSh0GFDRYI4saQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV0Vq6RIUYCjcnt5AzzAxj0H6gviNmO3a23VaMUJcPg=;
 b=Oo6GsCwfyWybJuG0dFTQJ6AIoJ8/lgel5qyiSIx9WoUT3E3vPWAmBgmg0nzHRg6m+xOXAG1yZIluV7wBXqyjIRqaSLUx+ZoF1BlRq1Pi76oJbvk5b8QdfItENVhLerDbqi2ZF/T+fpp/8/70qTbj4v6q2fSq2Nehv+5YuT0RdB1T+vv1YxQZegALcobk3WM4P+7vc3qra+v/2VPdloLOjP+2wBK62fSW+wYSmz2NdQO8t8Yyg83B8AdtNfvK8YCtMBECxOlxzNVI0GdF87ipRaeJ2wUM+FH70lZPFiFTNNn11lgnuTG9/JZVK4t/UcaJGuq5zzh7gU/wA4T0wLmVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV0Vq6RIUYCjcnt5AzzAxj0H6gviNmO3a23VaMUJcPg=;
 b=GgHjPfmuDh9huL1SiG2zjlyYCoihVhftFixA//kp/QmrYEl/ylSj8JBe+3rctVwROtzaAtVicDQtCZ5xmw+o8PXMzvCow3rjROT0pWpO3cvXLN0AriIpXin9Vqs8FbdCSACIbNGr4jdy8+zPw3QjELFxzmpByUrnOldb0UBB6Rs=
Received: from MW4PR04CA0387.namprd04.prod.outlook.com (2603:10b6:303:81::32)
 by BY1PR20MB7408.namprd20.prod.outlook.com (2603:10b6:a03:4a6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Mon, 5 Aug
 2024 15:53:04 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::45) by MW4PR04CA0387.outlook.office365.com
 (2603:10b6:303:81::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:03 +0000
X-CSE-ConnectionGUID: lqlldCstQl6yiSjehbOhYg==
X-CSE-MsgGUID: DoXft9U7Sj20++d+ihy7Hw==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:57:55 -0700
X-CSE-ConnectionGUID: KefhWED3S1i5Y5WYRvbkKg==
X-CSE-MsgGUID: otTftMa1T8a4TRZWXYardg==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920686"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:52:55 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 04/12] crypto/hash-gcrypt: Remove old hash API
 implementation
Date: Mon,  5 Aug 2024 15:50:39 +0000
Message-Id: <20240805155047.3151540-5-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|BY1PR20MB7408:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: da73d2d4-452d-40b9-66ed-08dcb566b0da
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JT2vGaG+AD6VdyKi5/2ID66KlRy8vRPsM0acPS/Y5eG/7Lzkwf/JHtfh5nTT?=
 =?us-ascii?Q?B0RvVj1kS5eRknQV3oojyMP6e/uMzWHxpwbUuLi1GYKTBR/kLx5/p+lfUipK?=
 =?us-ascii?Q?i9Dce3J5pUhzRXIcOCx4XXdLlq/PblLlzE5ufOL9hnnuxyWOvnQJrngCOEi1?=
 =?us-ascii?Q?+NHHyId8VnQkewgmtBkhY0NJd4fYbir8FTyr/fECPzBxURE5xsI3W1KqRae4?=
 =?us-ascii?Q?v49OvlNRDCsKUfBqwy5OVxmu0JvxLNceLT/vNtMb682XmWwr9E0VnCA6R7eH?=
 =?us-ascii?Q?r20ahlzZRsSBaaYUYyteJtpjsHg3yzIaVO3JqyW0F2penbxs/4Bqj6HiNV8s?=
 =?us-ascii?Q?IANVkr7yjn/QjU26z7YtOQf0RgHg9R9pZTnv3OOTiyqxqopqrTLUcQ1qvDOt?=
 =?us-ascii?Q?oXIdVZA0eFVv58mQtmqx6pcjPwnJDW7rmBAebbgfKFjKTHRxnkxBhyLwy2C7?=
 =?us-ascii?Q?9gGRijaIMEQhEaUMEREllIrr7dXGpg/q1P6ThHUkVAQp3VhCLtaIp3jrbE/Z?=
 =?us-ascii?Q?4bBrq/2raKIHv1zTfa1rm3dF5kAhLFRY/seNB/AHWm+DMvmuFhAAmnKZJtcm?=
 =?us-ascii?Q?Us9cusGe52ZvjE3SbzQzkww0PhRxt1GyG36brXEGaJ9VaduWPY2DvsOtHr1o?=
 =?us-ascii?Q?gKrDM8ZDVji94jbyzhUE+GOpZH0gxwFGZgHcCvRojLSSgc0/dUgIJSx0CyYe?=
 =?us-ascii?Q?mueGBE9kOHLZBkGRTpEuryjZCav8o32ntnOHiKcj9Is/yyo8oeiD5f2TD+xy?=
 =?us-ascii?Q?g5eQlljqNyAyLAcWloV4RTSaghu+w7APDa5OUjpMur9bdxlsUP53I5Hngfms?=
 =?us-ascii?Q?j2AQORIp/5YvC92yFT8kkEmQpdjnBw6Ab8cnFLYddQ6THExA8HaiUOmqAgpq?=
 =?us-ascii?Q?NVdQ4k8s2vzVMePrfXAQGGaigbvBsV5q5Y21xzXf4j2cv3xc+++L6FDjiJ7m?=
 =?us-ascii?Q?AE1RotbBl0C3y1rvdusrr0bj2EtP8wW+pWhzm8ZdVP59Jnien8y/gkPc6qAe?=
 =?us-ascii?Q?fJg/cikDbtckfOhYEpdUiwhmapMV8aJfGhOsCIJKZPRpnm7xynEgck6vQ1aQ?=
 =?us-ascii?Q?U6kSyo8ml53VDr+Pe1mVpNovvuCtKmxtSMiKQcZKZCuQRqy4BZq7w2VfGWLj?=
 =?us-ascii?Q?irJNqajmPzpFYDyxjMMNokANXnq3y9Y4sQkJcmM32maGpxMyBTrOvmrEt1Rz?=
 =?us-ascii?Q?C/gczx11cg/gdhIOBI+uxYapemF4LSJHkdH+EBTDvii2tmeaKlzJFSsbbSLT?=
 =?us-ascii?Q?IyyTzwWo7nahTkhprlxYnrkTa0GS3JSzqCj2X1DsFUjQMmY8u3kvNRYOfq4B?=
 =?us-ascii?Q?8YCvAjUQwhRpjJZ6ELItlb8c4eHM6tpg1Tvu7jDg9iJE6JM9Lsfv5qYNCbLI?=
 =?us-ascii?Q?CXxYM7COx4eb/yltIHF4IGFmifqG23Z0dsVX3Vo/V+S24PPXbfYbPHyJ3B0m?=
 =?us-ascii?Q?2c6gcbBelg/LXg/58CICz9H8YPGycGkl?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fZ9qUPhWMjXvwzfcK8gCrTO2vv6zXrsiEAjs9XalZxf4LTzJ3k1cyupZCZM7J0hn4lFR0Q5hl825AVU2ZOOZ5PHWb3s6w9D49MIZ2fL9XPnI2DtvKZ44pQvU6vYkdr2+Ym0o36RHldgVlyT+Dko7wRVwqbe1fadcaIuDFN8mBlUSfZUDpOpGipm+po0CJZG4mmMMFY/UjiSMc/4oprN+uxLpMagYia1lPv6Cq7xGBTCXK8Zm9BDAA/IJZkeg4lozOFOQqO5uipGkn72t9tu/taS4YQj5zE174XrN+HomBmLkiK9ItwY4BEqkEKJdhR5I9WA/TkwffMjOGe9aP9K5quJK/VdyTys5cUXOOYpDN0qOzB5uKT5/l+jTYkzp26n5G5SKHC5dv72mlDm23bxNLheSHDh+iCo+zNSKDdW7xJu/J0sPtltWUnQpqtCeqLzGtr1LkiOAB0er7gzJg5Nh/LGfqS+hmyjQBjM+7BWZxjowdhI+m748yegGxHcVqNlD5fdeZD+QsO4fpP3jjlEPjFoZD0hk7ohRvUKvHKHSiMCYjTatRt6Hrfx4dSUFH1RBjWhi34ibr2dHGCNVyKT7kUtGUZoUUqfwgid5u5+VoUE678jwPCPugU3RLX9ROzlU
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:03.3943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da73d2d4-452d-40b9-66ed-08dcb566b0da
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR20MB7408
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

Removes old implemention in the gcrypt hash driver. Will
be replaced with a new implementation in accordance
with the accumulative hashing changes in the patch series.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gcrypt.c | 66 +-------------------------------------------
 1 file changed, 1 insertion(+), 65 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 829e48258d..6378879072 100644
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
@@ -45,72 +46,7 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
 }
 
 
-static int
-qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
-                           const struct iovec *iov,
-                           size_t niov,
-                           uint8_t **result,
-                           size_t *resultlen,
-                           Error **errp)
-{
-    int i, ret;
-    gcry_md_hd_t md;
-    unsigned char *digest;
-
-    if (!qcrypto_hash_supports(alg)) {
-        error_setg(errp,
-                   "Unknown hash algorithm %d",
-                   alg);
-        return -1;
-    }
-
-    ret = gcry_md_open(&md, qcrypto_hash_alg_map[alg], 0);
-
-    if (ret < 0) {
-        error_setg(errp,
-                   "Unable to initialize hash algorithm: %s",
-                   gcry_strerror(ret));
-        return -1;
-    }
-
-    for (i = 0; i < niov; i++) {
-        gcry_md_write(md, iov[i].iov_base, iov[i].iov_len);
-    }
-
-    ret = gcry_md_get_algo_dlen(qcrypto_hash_alg_map[alg]);
-    if (ret <= 0) {
-        error_setg(errp,
-                   "Unable to get hash length: %s",
-                   gcry_strerror(ret));
-        goto error;
-    }
-    if (*resultlen == 0) {
-        *resultlen = ret;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != ret) {
-        error_setg(errp,
-                   "Result buffer size %zu is smaller than hash %d",
-                   *resultlen, ret);
-        goto error;
-    }
-
-    digest = gcry_md_read(md, 0);
-    if (!digest) {
-        error_setg(errp,
-                   "No digest produced");
-        goto error;
-    }
-    memcpy(*result, digest, *resultlen);
-
-    gcry_md_close(md);
-    return 0;
-
- error:
-    gcry_md_close(md);
-    return -1;
-}
 
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
 };
-- 
2.34.1


