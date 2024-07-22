Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48495C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0TP-00031W-A5; Mon, 22 Jul 2024 17:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sVzTd-0001K4-Pa; Mon, 22 Jul 2024 16:17:45 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sVzTa-0004Go-ST; Mon, 22 Jul 2024 16:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1721679462; x=1753215462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HcUuw+icoo0008bSRPacTksyT0NcjJCze2BAR5lYBXo=;
 b=gDemCB1mmDQNYm0tJhByNWJkpwlNq/h/yvbgB8vgt/AvL2nEsi7ss2j9
 hQ636JT/p+tAaVBcntbriHE1jtsWW26IBpWyWmiciOp7VOGaE4ZIj2sl7
 hzdUzX8kNTwB1An5udNYlBApED0hf/0upPHzvV2rTDR4++IzPujop+JQr A=;
X-CSE-ConnectionGUID: vy1gQDy6Rr6ya0+mNQVoFA==
X-CSE-MsgGUID: ms+lTn7OTx+2+BWujKNORA==
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzcA/TuHY0Dhnvm4A/7ar/JznW3TpLP7d2e3FBr+VVxiaEOziOFcL/cHxGlcoOAOB53vRqqqg0BWCa0/qR//tfJ24dzIuKYVfA5BFiexuhtje68VmrhyMilR36QhUnIBmHGw13uszlGQKmVYBotndw/vu+QNer36OzIg4Cp9D+4MD3OVELb+jrCnpossccptJ5uFYjz66zzJHpM+OdJUo6oK4gculcDj//QsS2wmi7ypyjtv5tsf3oRhpNhsr/axMtzruT1atsHLRuSp46HwCltodUQqVytLGIOdXvVBf5LWVlDc0ikDgvXIp7kQjbCwx7/RwXjqBxXPK67P5/r7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPjwk7K4d/BIvuI+pwRCRXYJRpmFZjiyx0aGmR9uihI=;
 b=Kdo0G6z3GfHysqhYA114ruj4q9OVUWDd31+vge/EcregyIl0umgHcxO9F0z01Xj1wMausno6BB5HVYSTv6G2kNU8VYr63Mr29jIvr2sVWlTQorYH5OGs33VmTCORow/NkP+dyvvfjBOc18LalP+pOdJkhE7okbtuVvUdEkDjVFV8+sEGwsJOkZrPaxHpo0YoL9YtB0pfD9kgW9rEgfROXqxroUOBU968Ghf10H14LVCoZZWaTfUCOERnkMm8VlJtHnTa1k0Fw9QpwDdmo5eMQACYv0S2lO2btZKKEBNxdsZ4kwiUBzqQxVFkGsMbyGUWbGOCj7GYs3Ue4gIURtnngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.50) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPjwk7K4d/BIvuI+pwRCRXYJRpmFZjiyx0aGmR9uihI=;
 b=KhuZIclkFtRDds/WInHE4tFO3TgJp5ombAc1k1tv4S5qaIoiZpIo4dTa7PuOUiQQIJNdJkWVFcGeFumzBL+2FCWBi7Ta8OFbeZGZBlnnlNVlEIBOOxkmix9hUP4WTisGXYNSLr/NBDSHawBOZ6vFMY1YMlS2uM5b7PQ6qvysGH8=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by CH3PR20MB6672.namprd20.prod.outlook.com (2603:10b6:610:177::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 20:17:36 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5a) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Mon, 22 Jul 2024 20:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.50)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa001.seagate.com (192.55.16.50) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 20:17:35 +0000
X-CSE-ConnectionGUID: nto+/IHjTP+cle2IUN7H/A==
X-CSE-MsgGUID: /H+ST2iNQLapuyeCUTHZJA==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa001.seagate.com with ESMTP; 22 Jul 2024 13:10:37 -0700
X-CSE-ConnectionGUID: WqGuiaFAT36SwsXZNAtDvw==
X-CSE-MsgGUID: ax3ZWDaQSLCT5k1k1lATOA==
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="121301628"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.11])
 by sgspiesaa002.seagate.com with ESMTP; 22 Jul 2024 13:17:30 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, alejandro.zeise@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH 1/2] crypto: add support for accumulative hashing
Date: Mon, 22 Jul 2024 20:15:23 +0000
Message-Id: <20240722201524.822730-2-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722201524.822730-1-alejandro.zeise@seagate.com>
References: <20240722201524.822730-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH3PR20MB6672:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5be1881c-9bb4-406d-77c1-08dcaa8b53b2
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sx2CECdG8WrNYBg8edtHbEZLiDDg55w396/ZkIOAuGxnIQIhNiUmvXQkle4K?=
 =?us-ascii?Q?M54BDrpZG4VEt9uPQGhQ1tcOYfXKBNiuShRg/zJR89vSD53/IZanr+V/IWTO?=
 =?us-ascii?Q?VVEsrhQYWVUmdOekHG6MXDNEEU5jI7DxWSyo/WXAJykyzXdqvDXcU5m3h11l?=
 =?us-ascii?Q?ycOsIHAnyGvf4m8vzXfDkNbCeiwlFp0iylMQ6ba1JQOSRMDVCB+XlTdj7xm9?=
 =?us-ascii?Q?lb0RQ3hMpOLV4hS/8yM2rAkShizlcX0Kb/4FXPxmFghRxT535nbHw5kQcnoE?=
 =?us-ascii?Q?PtQJesSlth974Z2r4yoaipnbiAuAF1GEICz7KoQTbwXcnWiJouEJcgAnSmeF?=
 =?us-ascii?Q?TYtWNTCwDhZLSJjpigj8Z65NAbScVOXM8jBNLozO9m7qUvY0i130T2j2nMfn?=
 =?us-ascii?Q?XGNUp75vOLY0T+0pSvPsdnD7aBrFSR58PXdhAdcvbD2ngQygbBOqB0gRgjbA?=
 =?us-ascii?Q?2r3Y3bVkzbsas/+6FpEF1y002Zk4iFGi0I9AY5iiSJzv8sjkAM3IQC1PlZOV?=
 =?us-ascii?Q?8TUaspV8B37/oPGtxNeqLLxKjlwPaL/ZkAxReIDfkNrrU+gjWFE4ysZNROhi?=
 =?us-ascii?Q?H0ctJL7/xrO4/xGdredDXg/bicerZ82/mE0vcJJmh+9AxISysItdNx6u95Lw?=
 =?us-ascii?Q?z4Ea8z5drY4mzfCTJual2gdpJwnGmxo3TOQBbMDfu6Tzik/v1VQJQ3REawD2?=
 =?us-ascii?Q?hXPdJrQgM+CnyVEwHOcHqyjwnPF1FZ9WNweUbQRWicsekOcuE9sVNP4p421X?=
 =?us-ascii?Q?lujX4FGEDOZgcl87pHaJ9nmSYD2V57U3n4fzpar183Vos4VEcG8QolOHOiPH?=
 =?us-ascii?Q?RLSM1yxuNIP3j1MYbbWoj4L1OTTG282TcbEfdm9fcwSFTfscPde+s+4DmHuY?=
 =?us-ascii?Q?AfYWjnjsticbx5YQnSQMs61OVYc0cXi6BEX0ujBrhZneLSn0B3woLv5Xp5JN?=
 =?us-ascii?Q?6WXminfeHPmd74K+I7zVqnAvL3AK0+XsnrNdBAcjW+Nd0PwbR3JMswq2vBlm?=
 =?us-ascii?Q?sn/osUAinknvVsyH7Jr78SlhN8JbNk4XStXTqIDx3Q3/DDqWe5T0X5WfzDz+?=
 =?us-ascii?Q?HZp2LCa91fchKAZez7S14raa2WP+QCyDSnL7IQHPaQ+s9G4eLDQwM2n8EPPx?=
 =?us-ascii?Q?N0Zb9H6KVUU5IKjyI83TKo2bjNDGLGvinPYrTZm/gV1ZlmYuwQvvTf+NDu+Z?=
 =?us-ascii?Q?u/hxSimlNFv/D771Swdr2NKrzeTRt8T64o6ARzh1FdgH164rCLHW0TcQGk7K?=
 =?us-ascii?Q?f5kHEXm85y2ep9Sx3ZvN8c28lk5G/HmEoMatPPrnj34qJyIO4gR5F8MoU0gA?=
 =?us-ascii?Q?PODq0MBw0+LlBxzn7uRa1S98LGxlGgaYYYiW9XLcb5s4hgPU1CQJpLJE7Ubm?=
 =?us-ascii?Q?WL6AYQ9A2xKCwJXP9Jebn2SfHWDajpAVKwlOX/omlqfcFzBhFlkygf4Lj2nu?=
 =?us-ascii?Q?aKc5DrLjZNYDwzpejXLbiuoOIjcuYga1?=
X-Forefront-Antispam-Report: CIP:192.55.16.50; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa001.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KAdmtucNVHTkOf2PBimWTN0YhhKfPORn1HKuOrkEQf0ODpvFKaspn4khZXmt20aYDPGftp1NYCz/3q9PVCG+hwPznTi48Lm3C2+ZmAVJsSkReIA1hjb+cWMumAByICipmGR6FCJaudjZQbXBlOD71KMQIMUPWLyf2gFt+TUpTw2wPNCB+/VM7DbifRL8pUZhaL3fjcioP3KmmNhocfGtSWlZRxTwZnzwJ3FVaw4DA8L6foOG+FX8kXPcnzCn3MnQcQNCaTuQTdAlT8qIcDesE47knSS8/lRJDkWZKUqiPrVZCzQ3S4fUVP6N6diA8okyOnQKFnrwCs/xa0hMRRa4yOWpDY1cNnhkjhn/bHLTX0RobGoUbls+qSMnjMiSqptBjW3QxLYxGms2y/I2w6lHPFJEq1GjjZeZdg37YBUXt4t7wuEM6p7qtb/nKsjjmcZM9P7btAWftp20QbnBWuWo1qLW+0jOBQKelShJsn2wgcWTYqOLvkTK2UKmujCw8sCqecLyWiHX62huljAlxJSaTc2m4XBCZ15z3a5/bhGAjxJMQoGi//AUJkMZ+H6ys89iN7GraBitde/1VwCulOl9fcAa1zCQUkwcjFqNSO8beGXkEkfJ5R8LbxbsRzEHkeOR
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 20:17:35.4273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be1881c-9bb4-406d-77c1-08dcaa8b53b2
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.50];
 Helo=[sgspzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB6672
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Jul 2024 17:21:20 -0400
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
+    if (ret <= 0) {
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


