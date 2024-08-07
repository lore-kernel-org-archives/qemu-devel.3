Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980B8C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjb-0006HA-5b; Wed, 07 Aug 2024 15:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjF-0005jo-QG; Wed, 07 Aug 2024 15:53:51 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjE-0001yD-5D; Wed, 07 Aug 2024 15:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060428; x=1754596428;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dVAAJNGuu3wCMT1tbnINnXtWktD09JxN+M/icRJCpWU=;
 b=Tg6dPrAS5XfN84bOnWP6SAXH8b8/AoFSH5kg/2XM4AAUpvVzRLlL8Sb9
 pdm9THarb1WgvkhJqIInfW6Sge6WEYhhWStSsyGNLnc3Q3rAzdL3DyTQt
 F20TwSCT2yA6E8jY3E5DbevqpCoIfyNHUXmosWEVhtO5Qcvji+E00/FzX U=;
X-CSE-ConnectionGUID: JX5Y9N+XRTCV9Ljz4X2CSw==
X-CSE-MsgGUID: R897MPz1TGiP0TMYLyCyZg==
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMavNLmLuANpF1INu7rzbxfKGIX5kOhtxM1Po0fTb1T+K9H3mfEC2+hywo/oTaYu/nYA4EQ3aHrvGTXw7CdsrjruJRuEjMRI9KVE6FCp9SGNbBIXVukVETWq0oWk7OpbkKz7LsjNYImNTQ3YS/13hMGTjXix92S+3+QSGyOCp9+kmjWKpjWzLr3uZCoVDnJNhKE36qDKFoz5e7vlyJygWOwcEtgPYYpizHgCoFbO/dzmvXmR/O7jyC8fKh3eh5N0wjJx0si9PxG7/iNBr0pSvgmLf1kltfcbsbB/FM2msvNYKLvgCHhg0uW0lmYIg8lXKW42fkKzou3QBzFkFUNrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pJAr7bJw3o8CypqtrR8n0/poOCIe5m+NKgZ/RgkOFw=;
 b=OiNQFQU19eR6lHPgcSPtBh7ASq3Y3xfPK8sEaIZqpS36fo/cwhrTNZvWqHTY0kM4+0jFQW/PsVIbqt8nyrFDRmeuUdlYtawi39Vp1eXRPsc1IDCIVbr+LI6Tc5jKCS5smagEdTIbM8GBEBvxSWUjD5bkEZ8i4I7MBSuxd0BwdmeFeP433TW1qpPcPDOLG55jRT4bBDOPEymemqI9DxWWpqN5xJRGURnU+QsxWWd2pZcdi3rkw+aKOZ8nZDOoOlzR6DX57Oln+3I8pblkMQxGKAoVD1p+4lV/knnl04F2GWA3iZYsYR93XTRTMBGLY0QGj9WOpG28FK7iKYZ04Dg7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pJAr7bJw3o8CypqtrR8n0/poOCIe5m+NKgZ/RgkOFw=;
 b=bWMrHVgCvPJpfgDp2iX93urmzE37FeHEh4QiiC+RPbUYe5SWN2BKpM+jGKOglgvjP8F2mbXl7Ywkp64ONIRL1dNjUqkI8ifAV5zr+HH09M+FrCifA5rS8hFKl6fNgdFKApEsmuRNFEK7vfc174m9lVAQ3fnvyrjioMRMuZDhHSA=
Received: from PH7P221CA0060.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::16)
 by PH8PR20MB5290.namprd20.prod.outlook.com (2603:10b6:510:1ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 19:53:44 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::95) by PH7P221CA0060.outlook.office365.com
 (2603:10b6:510:33c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:53:43 +0000
X-CSE-ConnectionGUID: eu3q7q8lRrSUlhOiwPmBkg==
X-CSE-MsgGUID: atTk3cZxQ0SEeXTdVJAu/g==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:32 -0700
X-CSE-ConnectionGUID: w60W210jRxau09DJraI+2A==
X-CSE-MsgGUID: PPO1bAamRe+uQp+GGKatwg==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235460"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:24 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 03/15] crypto/hash-gcrypt: Implement new hash API
Date: Wed,  7 Aug 2024 19:51:10 +0000
Message-Id: <20240807195122.2827364-4-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|PH8PR20MB5290:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 36d4e859-433d-4ebc-a071-08dcb71aa4a6
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mLnNr26YIDgo9gpSnFI98n2Nola9bL8dt8D262ewPV46mW9JQgh0Wug1/gfi?=
 =?us-ascii?Q?SY9pkfeinAWzbT6Fs+9yBMP3oMTY9Tf4nZ9bBNJ6PY1rC1B3MLUlGOyb/rSl?=
 =?us-ascii?Q?qp7SHeNPYpJ+vEs2c7dYgDP251eRAvXUwGiX9miTC7+zF5ERJHt3f1g9soN0?=
 =?us-ascii?Q?HRIqr/8wWhbVqQBOjiJknf7DrHts0G+NwXkot6VmnfEI6DPQSF6AdNXMU7vi?=
 =?us-ascii?Q?tUElEGb/D8FdoMko5C3+tuVF2VpnszxsCks6s3LCvFmyqRLHmI1UC7yUGQ7f?=
 =?us-ascii?Q?fyUlRRxLSKoFdrcfJ1YHPlC/dtum+CAPnF5h+voXktrytsEgK7i1tZ3PRbOU?=
 =?us-ascii?Q?P71tf9WmVCObs1tN4wV4BGOeGCuOsud1j/Tk6YLgphiYcFLIZ9mU9u59I4eH?=
 =?us-ascii?Q?7aH8hgZz/M+3U+aHoNCBV+0miHuy+Ybk5H4ud0qcQY67XJdO0dLoqGDgwbOw?=
 =?us-ascii?Q?bCprTbf/WpKNyBMFZzSNa9Sye+5Cb6YcsupUYb6jKQch1C71OgtdoFruw3yr?=
 =?us-ascii?Q?jEeNM81YsXIQbpEx6dYjrPXPhNZtZmRc6XD2DREh9cz6cLUmYGMIqNnxS6o6?=
 =?us-ascii?Q?274qFqTbrbPXWmuRRaX1Clh3cQZz2jaAk4h4UHikGgtq/fcw/j/ja5Zme4Ms?=
 =?us-ascii?Q?n7970zRNteXa5MQVz3tAFpz1q2NdXcpKmhMZNzqXEJYZYRX4mgj4InCl4Mcj?=
 =?us-ascii?Q?9BhpSyGD9aIwA1C2BTnIcK3bZxVFFDf0jXtqFPZGl5ain5115HlfbklXgn75?=
 =?us-ascii?Q?KS7mpUsiodXnt2zB4MMKzkODdlptMnFoN5/nbRrtl9C77/rOtUunzmFpTlj9?=
 =?us-ascii?Q?jZfbbE73lO5kOyCXcd2lv1IAkJNbv74emy3EPUMUU/v5TIp08L6wdBwJK4WE?=
 =?us-ascii?Q?sWKLpDtFTsoc5sOkOXRxqFhaan8RNIYAwTmfsXl1v7AgnGATgqZKkv050oT3?=
 =?us-ascii?Q?6MN5mAegpBbSuFqFfbF/5fmrBFyc/T/2VbZrjMIfcJRubjb5EOeSwMDcRxZ4?=
 =?us-ascii?Q?tnBhA/PziqRmF2aup4uzI3uk+98lFULODJv1yfzG071U/SMRV3dHu+Ld9jXA?=
 =?us-ascii?Q?DjHLmPpM3pn1iG6B27a7VimWXiS1uyy1PZ+icm8ayXkxWj41ODiT/UHfeOK1?=
 =?us-ascii?Q?WBkRChw5JXwVbLZNB6quVGPdGc1P4V16Mu46K14REQ/p8hVw24NAAjVyEqEn?=
 =?us-ascii?Q?74w4hnlIU7qR4iBEHRiShT5bJmVNjC5jSg0NRszOqYw3Yb9lZZpH00WvNS1h?=
 =?us-ascii?Q?NVscNzNjg65Cs+0jPH8Kz/04Iyfl0JcPmr9Xm7owPPKoeWB3GvO7s0VgafNM?=
 =?us-ascii?Q?pKf8xOMWooZe49D1csCsvOfKKgc8onT1TDttSNquwZZTlL51Ar4aZaj81sPB?=
 =?us-ascii?Q?XfNt2NQ+eAV6RSjmeHubwA4y4znou8GjHIeoGdMNQ6QeBoFbybx0rq/jGFFs?=
 =?us-ascii?Q?Aw1WUeOfuNlt3ooxYb1vTquUqE5loDbm?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iv7+HMgqG/crZFqLxRdsCfUGwqxN0UH8dTCN8gnEU2aQNHVsxu+Nbel01IIrmT40zAHbEqw/95MKiBcrVdzlpd0DdTpKYgrYAT+tcylS1vSdu9d05nBM2Dtqphc5G5/Ad/ai8mUIlDnHDMsc9wS7JqH5ZH8BGxQuiPLCEi5UPds9k19xqb2x0My4iYUHEJC+MKhkmRxMzb3PGZlTTba+G6WmFKcpDhKn/KuysWsKZNf5aCg53U76S/KeBekei+j76v207jbGDKNYB//mKg25opTWwwfhVwKwUroAdO7sKKNUhvAN9cUrmYEypa5gUCD6+hyFFBo3X0KgbDvQd98JtudgPBi5xGsZDNW5hLRPE1tXs7nrEd4dYzop29iCVKeMCfj4PC+LBZe643Gib90QvQ/Z9g+IrYzh8j0z5GBLLoTKof8IC6HjXHJTSJvliiyuQ9NLx/V9yx7eWuTw1xtpGLNQsG42mcyGuFrMkq/cAqGdNH4oZR0uU7pS3a6naJRQQclX/LD2oMhT9liMvY1oc/4mqYxomaDPbXja8p0fIX5y92NRaHlOKLNzI/ZQLSRQaPDR17HF3oN2P6J4CTcYP6I08cBfJuxpZ9MC0TJmcQjZeNzyjxPBvc5eJNBtQGZw
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:43.1840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d4e859-433d-4ebc-a071-08dcb71aa4a6
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5290
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

Implements the new hashing API in the gcrypt hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gcrypt.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 829e48258d..e05511cafa 100644
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
@@ -110,7 +111,85 @@ qcrypto_gcrypt_hash_bytesv(QCryptoHashAlgorithm alg,
     return -1;
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
+void qcrypto_gcrypt_hash_free(QCryptoHash *hash)
+{
+    gcry_md_hd_t *ctx = hash->opaque;
+
+    if (ctx) {
+        gcry_md_close(*ctx);
+        g_free(ctx);
+    }
+
+    g_free(hash);
+}
+
+
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
     .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
+    .hash_new      = qcrypto_gcrypt_hash_new,
+    .hash_update   = qcrypto_gcrypt_hash_update,
+    .hash_finalize = qcrypto_gcrypt_hash_finalize,
+    .hash_free     = qcrypto_gcrypt_hash_free,
 };
-- 
2.34.1


