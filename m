Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B9C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjd-0006NX-MB; Wed, 07 Aug 2024 15:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjL-00062n-1p; Wed, 07 Aug 2024 15:53:55 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjI-0001zW-Rk; Wed, 07 Aug 2024 15:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060432; x=1754596432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YjKf7Lb5HNnoCYoS/OWX/q/6C/xI5bJaqrwoYEESEQs=;
 b=T23m/LBT3tJ7eoqnLjj4QuESZaVaRSe4x6K/NyGNt86kAEGxSfW2OCz9
 Krz+Fxfxz1rlU2foslOqwnn2P32hlTNnVt+nmv3eLj2TWxUnjwF4mDqSs
 CJGjElLqZKyxy8rWeqsnVxltu1sS2lyUX5PkzVONuaLZSLUc/7/Qb7/dT c=;
X-CSE-ConnectionGUID: nrXrSAWUS7ipIaIfcUxeaQ==
X-CSE-MsgGUID: 4d8DMiPdSX2Fom0SW3tymw==
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJcyC6g93L1n4lMCl+o+4zGCHLasqSt3+1zGosgOzlc268KhxcIuLcKsJVYtXOMhirMUooi8oRtGJWcETZZe/wypyRGpVvnqggLWRQuYWBh3zEDAZD012f49EsAyfSnZhvutJ7QXv2EoTUtWo89iMPGSUnjQ6XM7kQYH9Fc2WTXnhSTtmR4ZbrBw1AIw4Xt7u8KzaQ5TwgXL8PUGysI8qkaLYuF7WSaJUovOgJAZjAHCLhSzqie13rBFxm6ncxS5fFUxDHQPjgHnZZK4giXYqPKrfAGOayJt5X8SMvM0esC3p58gSzJ9KTEsqqAdP54YX+6JhpKAu+FuNn3ho0hb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3RnYV04r6B5RuGvt2z65dnkgQrcnz3Vx2CpYuAXC6A=;
 b=M4CzlE5KqHygzcinvo9OYAHn0ByZYP+9p0DikHWIZFrjYfXqZTGrxNjD04i/W051bdN3i/oaNRLmhmnFXJHSLFIEU4U8bc3A5EV2SMgPDfNmnOR8RI5st1glsLmhcpj3wqim+tW0+TpHkE5RTXpGRxT/ml2iw0q3tvZiPFOHyUV+iAVSELm+lnWjdEV37LmBKUcq1uzJB0fqsk47EHUM0ykNpoF76hH/4oNhNhyS3XhxKz5EtoxkFWCtKcqWuxZ4daJoiaYjJuDJ1xXeNP41U2OpIY2mMRkNoZDAvxmxLqozweDy3iNJKGqDQJh3DJsY8fbo24Q3bRL9ut3sbus2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3RnYV04r6B5RuGvt2z65dnkgQrcnz3Vx2CpYuAXC6A=;
 b=JtU94gFrx3Pi4X4s39rCveUZ2ovF7kCvClfdRtU1T0Muj00sXjGu3J8cqWqW50F82nQGo3sNCIfKjxRlkrXmpfBKU04uueT8lXmxfueIK4cY4DK7AiEys20mKWv7woegmC4ZaLKgE9ktDkYlRN6b24lQNBnmMDjWzyiGzYMDCX8=
Received: from PH7P221CA0050.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::13)
 by IA0PR20MB5705.namprd20.prod.outlook.com (2603:10b6:208:437::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 19:53:46 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::7e) by PH7P221CA0050.outlook.office365.com
 (2603:10b6:510:33c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:53:45 +0000
X-CSE-ConnectionGUID: /CLtTEd0Q4q5tYeupSFpFA==
X-CSE-MsgGUID: owwYrivVT2W5UCFmcpVuJA==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:35 -0700
X-CSE-ConnectionGUID: ih0ivkyORp6tH6hEQSyg1Q==
X-CSE-MsgGUID: zQWcNA6TTNmQq2bMg/QpWg==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235461"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:27 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 04/15] crypto/hash-gnutls: Implement new hash API
Date: Wed,  7 Aug 2024 19:51:11 +0000
Message-Id: <20240807195122.2827364-5-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA0PR20MB5705:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ad819205-7fde-4f46-3052-08dcb71aa5da
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W3Qy4IF8q1l6NgGc4C0HnDyc4LUbhunQ3JINrEy2PYE4Qxo9K6DoYWgkzrhR?=
 =?us-ascii?Q?F14ShknfbTOUSMUy7gIqvgbiwFiYCL7SIrdffcT7Z1zF2UY28L0cOgi1zpoT?=
 =?us-ascii?Q?Zqr9SWGqmiDMHUjv5cgPXc1iXMk0ppbiP7yASGdF3rpU8METC8bK7nbMl+ye?=
 =?us-ascii?Q?+3c978dfq654PoLYdTpLRVGHnNvbmkmDR8vahQcuVmTp/QNBjv7Mtghy6q7B?=
 =?us-ascii?Q?K4NEBTlk9RcrXFCfRvLJK45GVor+hO/Hfhv3FeUitKxMRKnkT3v1sE+u7kzF?=
 =?us-ascii?Q?qUrDgzEWqbeX1xXAbbUs0Gewqt7JMBXd1C07Wfdv7YBo2gJUoB8PJMDoVczX?=
 =?us-ascii?Q?6JQdmL3p1bGS32SRwBJof28VySN4jusRooFtEit+whqRkt3GINq734cAmNTM?=
 =?us-ascii?Q?6E6qHnzsdB7JeEmnqpnd8Wo1b2D9ntat00yCkdHT53Pdmhe01usNJIE9/Ce0?=
 =?us-ascii?Q?4mN/zWfPswZ6wCPLk89ordiscTmYTZoh4U1j/bh5PVy1CUMihfS4HrTpQq3s?=
 =?us-ascii?Q?1kTPzphCC/PyT81FNcsfgimKTjPAZ4M6EzoamBJ3xX94HhMrw5Zp/AEdSAec?=
 =?us-ascii?Q?R2O2dXXad0tw686xMQWSg3pYCmfIQBm1dG4uvWkcnSUebq+MJa1397/lNGhC?=
 =?us-ascii?Q?ssrJkdJL3FA+EIToyGiqd0QKQOnQQaHiqIyB2MB0d9Pirhb7kMEf32rxGe1q?=
 =?us-ascii?Q?RlYx7sb2qlFoBeCgCnGczs5KKuQdNTH4yJhVnDz61aiD3XJ3UNit60ssJNfZ?=
 =?us-ascii?Q?m7Buwm+5uU1PzbWtLavU/OZi/cnzTHdxYzIkbBYPbn5JL00sfctR4WS++8gb?=
 =?us-ascii?Q?xre94w3fOE3+BDN36pX44/p0fyx7fMagOINCB3Mp4SJqAsNl40XiJew7LfdT?=
 =?us-ascii?Q?nhBDwRcde9/F15hHfgUVXL1YKZo2Bem5OqJgYWZJdBLQEphZwRzHn+I3YowB?=
 =?us-ascii?Q?UJ99tpFZgIsRbDmn3r/HmKGNWAXrI6vgp0U19eF3TBR6rlx5VzoU2dCH8JxJ?=
 =?us-ascii?Q?YC9FjupIceR6snuPYBChGx3NCnMCJiQiT3l6x2uTxXvmuX+F53obbmq2+yct?=
 =?us-ascii?Q?X3xAgasxTYD+HM69itBcSYC7BWuo29pxdNTgJOTqDVg+eGmAyswV7FmIidCR?=
 =?us-ascii?Q?P1iYAqPHJLoxx0mvTHCDqHUI4brf/w/0XoDa038tYss3jLhV5R+5WI+xqA5X?=
 =?us-ascii?Q?wpcua1WHywZrGATPELOwzGIN2Xe7Pq5sSacwYffS8tq/p6NuDAi57gEzaCZ+?=
 =?us-ascii?Q?9DzfotHH9VYkytqVTACWZq7CYV1svEXgI5fEEJxQGof2nsNml+RSHnFMTfly?=
 =?us-ascii?Q?MAsT6fjC8RpujIFQJyDoKq6Y8iuGuPo8pxSPnYPw9cbu82DAVDaABS3VD0pi?=
 =?us-ascii?Q?UuYipUERZHGIu5Vt0qV8XLtG6pWOjxf3VULKSaxUlvN4XcNdHFqlAjbAOElO?=
 =?us-ascii?Q?Qv8hvuRS6Ck2hFvr6iKuO1W9YoUb82uD?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f+kBmVMu2+SXjv2pXOmq2YPaCGvvAgGZKylZpxHVX/nAop4OxKtuzwaXvn7I79q87YahM9qesZVLu4A3CZ/nPvXInAxqwP/WT+XI3IG+ZjDD2VdLeUDQIXxL9oHVyV/IhRfrW7QaXFLdNDSdazrL6sAxhJxgtbsXlk06mL7ecpUjlhdfOd9oxPNnVG6a05juuB5YhYdv9kYxNRBbG2/IPcGY/JPFkZRwyRTQ8o5rr8Kc0267x5uMm6g6ZO8CXn8GaXEwrKlPnCTTJRB3BNCIj+DS4S46GgOviXweAJ6k4ohArIOvR3f8EV3+wA3z+3UgPTX3NdMr387N9SIzVdj2EYVWnJ/hYoFT7CWpyj1Pj8X0+X69ICnnR+PE81DlcytkrQI0xGRRRCRrYymt2els+zYviIcCf3TIXf2WJjj7w2Sz7R4afPLmtbgcWNWFMoVUuUjI5frO7xJ+Wutr8GD86zYQk0BL1KxxuGKdHnpHjzfj3lBbz38BR7AEnttgcEJJYBscaWh3tRd2/OrcBO8+xJq2grmsKmym9LDCph9SfdxGS+0jlIJX645r7q/llNSomP+ZO+IcD+F/hSC1VNKe/NuVcoJIEnvmtUU0s47GI5Jftuz55nCkGGrB99T1YrrG
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:45.0121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad819205-7fde-4f46-3052-08dcb71aa5da
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5705
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

Implements the new hashing API in the gnutls hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gnutls.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/crypto/hash-gnutls.c b/crypto/hash-gnutls.c
index 17911ac5d1..15fc630a11 100644
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
@@ -98,7 +99,79 @@ qcrypto_gnutls_hash_bytesv(QCryptoHashAlgorithm alg,
     return 0;
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
+void qcrypto_gnutls_hash_free(QCryptoHash *hash)
+{
+    gnutls_hash_hd_t *ctx = hash->opaque;
+
+    g_free(ctx);
+    g_free(hash);
+}
+
+
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
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_gnutls_hash_bytesv,
+    .hash_new      = qcrypto_gnutls_hash_new,
+    .hash_update   = qcrypto_gnutls_hash_update,
+    .hash_finalize = qcrypto_gnutls_hash_finalize,
+    .hash_free     = qcrypto_gnutls_hash_free,
 };
-- 
2.34.1


