Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3ACC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmje-0006T5-PU; Wed, 07 Aug 2024 15:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjR-00069R-OM; Wed, 07 Aug 2024 15:54:04 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjQ-00020F-1U; Wed, 07 Aug 2024 15:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060440; x=1754596440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wFngXoaQuGn4s3FeIagsUX6hWXWVLyyuiAg0wps8lnE=;
 b=fNDXMGfpEXFz/Bu2dpZYl5IDUTO/O2Hbrsc21iir1O8+AKQLwbGgYakc
 xUauuPvILKHBS/RvCveZHHQx06punxS+N2jLlo2AAocpXAiWF1FTbw1+G
 K6vBTWzU2vEJumHU/tFx7TOKtz6LUM/Hx56HXTy5pZtPgFzeR4GiQCURW Q=;
X-CSE-ConnectionGUID: Ym7bDOooT5qF0dWQkjXNBw==
X-CSE-MsgGUID: cnUvE5bKSZuK+alR+HU+ng==
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYGKeJQqdvO/oIrMwfj/aviUGp6lQJ4/ViOc3WcMJQOAzoNmyrXdzMWNSYLxLoeIQBrg0G5kAyDq+QYu0biiFgh1FL/AmevjiVcnDmXV4f1AbwweFPWG7CzvVfvMpbe/+4ZN8YX27uFW+MT/v+g1uX7lPnljWibcnWJkP/T3eTEmSFcoZyyOrZD0h+hUU2oh/dz4GF9aFUal1em494gBSEA/gcTV+H8XKyDH9QMTcsyU5grH3kokE6cpSs0xk3A+Vr/RB0cOQgPvgjwExYp82py7gP8hVsc3oyJD342v/uZce6+Y9FnfwNv1f86k/VRQTtQePX6w9y19lQdp733f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oHJxYbVq3Jaa8ysFVqP5C5coc3kndp0VQoVR/Z0uPk=;
 b=xadS51GZRqme8FzKtak54oT+If6YKKwCSidVPTVNvg9kZ0ERPs2J/huqLnuAFBWlLZ4tMZ24IzlXAF6hKNJ3m+5Z4BftrjfZO1H4X4Rt84Utir6DcYULfahGhD9ae1Gc7AKZeDgpYrA6Gt037mh13jMn7jjgxOrCj/t2N0eK+5R3wm8wJw9ZIDaKCev9E01KEFJeQ8A8AQJwg7gWfm/GaNBYa/PkRqh4jdsb4jvoPwP4aQB5LHUIhbGJOWzT/HdW0L63pgaWG1hOETZQ7dHX1n3W1pTpPjikbGHkmmlM+sentrzYaI/fAjKlghVdZ2uJQ7+1L5FhZr210C4Piau7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oHJxYbVq3Jaa8ysFVqP5C5coc3kndp0VQoVR/Z0uPk=;
 b=HcZul61pDqn/EcasVqUUpC1NOzoRN9rkpW69vvSZIwssrT+6dWPOKWQNnkmvf60/AhHsReIbw7sWDkcQxzLO6MzmRyCzYtWIEDoxJLbwwCpmay5SxEpdltX1ZpLFPG4GFQ1DVlst9+umEDl2sRTqOJ0VkUwp0QbBJKz7opJlwFQ=
Received: from CYZPR20CA0015.namprd20.prod.outlook.com (2603:10b6:930:a2::9)
 by SN7PR20MB5168.namprd20.prod.outlook.com (2603:10b6:806:268::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 7 Aug
 2024 19:53:50 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::c0) by CYZPR20CA0015.outlook.office365.com
 (2603:10b6:930:a2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:53:49 +0000
X-CSE-ConnectionGUID: mlvOW7KrQEKTxy2G+DyxFg==
X-CSE-MsgGUID: 5LmfYA3WSluhZfjM/tumMg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:38 -0700
X-CSE-ConnectionGUID: PtEkdHm1SpWNtFkCEteQoA==
X-CSE-MsgGUID: YySMiv3BQ0eQCyinItx21g==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235462"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:31 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 05/15] crypto/hash-nettle: Implement new hash API
Date: Wed,  7 Aug 2024 19:51:12 +0000
Message-Id: <20240807195122.2827364-6-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|SN7PR20MB5168:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b3a846d-9d05-463d-5e63-08dcb71aa841
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e18aHgCeopBFYc6EottaA/vB25OpR3TsO7cK3To7Bn1H0RjYzb7tS1eDfYdM?=
 =?us-ascii?Q?zhB/Lb+Q6GR2/RXV19uSwVosomPPAHuJukDKSTdkiMY997YNH3LrI2/+NNQl?=
 =?us-ascii?Q?47ibMsQP75518HhBoZzPFT0DvFSSAfd6w72Ty6mWllEtYu1kK15q6Qba0mZC?=
 =?us-ascii?Q?x4Luye7G/c9TWYor1FyiAo7OThlWYwEuVqeH8VN+syRpwG/hpKUcc6UQCSPH?=
 =?us-ascii?Q?PKVi8pqcDuuIW6dfBTdh9kZOSzuq6JeD/Q7dWCG2TJuzOJ1LF6eTZ5ScrQAO?=
 =?us-ascii?Q?KrGLoDaHZocg5V7HNJRN0TqVx3HlzN2ohRW3B2/Wjobe0bdnX/j1Ih+KAFrN?=
 =?us-ascii?Q?RumDV+2aRKTN5XTMdmGKSpJu5NJu0+9tJshpWK9LtE2l0hpP1JBeZFjk04QD?=
 =?us-ascii?Q?qj0aZckU5/TwFS05UEslyx7EsrdKn4k2adRfxWDjdfaEItH2cSOATNzERhxr?=
 =?us-ascii?Q?+2aZbpmVhFffbLsTk6s6oGWfDeSwyJaj2alRS0w6xz+2CHcF3Cma7XUpGGkG?=
 =?us-ascii?Q?xK659dumj9Gm4qI6fQAhqgjX4bTA8CbZb/yHGUxhauKUP4ixGHegLpN70toN?=
 =?us-ascii?Q?rVEFI/9vMSHBoFXmnIPiGlcS3rmwkyeunead1kpy8NdMmNwWOld1mCiuQxbo?=
 =?us-ascii?Q?Z7HaeUo+yRvXYFfzvaTU7v8ZIpGbjdUFStDUpYSd0xBFyyKSnwE524//Hdfd?=
 =?us-ascii?Q?glSP6ygcW+w/6/uL2WCST+KcdJgENvlMSEqEAWfjs8SKUH/ZrEY3T7H03puQ?=
 =?us-ascii?Q?vSxn8WH52LXnSty/iyTUZgHawJEnyElNS91o5iBDU6mq7qDOojc2F0ekSYxU?=
 =?us-ascii?Q?bEoDJ/B1X2kZVkqrnwzL5rPqGTwfvWN6VGLeLXqxVzJXa8t8QcfD/Lxa25W9?=
 =?us-ascii?Q?w6nAeWPX1qqzWMcCS3CvqepVr8CLPgCWMHgm+XozK1enR+HYHfZr5KHmgJPh?=
 =?us-ascii?Q?hftbAtUQ0qagjNU2FW47jQMRx7vd9IXEWhGbyYvhwctrYsghoRxBba4oIUJi?=
 =?us-ascii?Q?/+r0G3Ch+AiIrJ+/37dI5RxdboNMG4bg97AkT4hFGvBmQDORuiFoxkm9nlNH?=
 =?us-ascii?Q?L8dv4uKj3yGt6YVvF4GvaYnWXGdw3amH7oCPqB1ACTws2SuEIbdLREQiVg9N?=
 =?us-ascii?Q?gdhzHfHoXbdwKRWB1sMB5y77FGB1Qyk/SVGKqv0syOJ7adC+cEo1IEgJ9tEt?=
 =?us-ascii?Q?uX84R5YLZp6t03k/piIriYFjBGszgraeSNcsKML4TY7lFy6ol9klNe4K/wtm?=
 =?us-ascii?Q?oporgoBILYAw7MUl0zT0j3i354YPnDGMvP4LfICInPtNJ/sHrYgfjLnSWrOf?=
 =?us-ascii?Q?LuyufqLSq1bR0J/lVeAEugdnpNSWQDNLA4DimerGyh7oYg2GDCekvf/YTBt4?=
 =?us-ascii?Q?M7YamvcXHww2Uwleqgmb2KeIk9vmkbiax1PZ3yMiuwNwpfYc2CYMZ/7tgV1b?=
 =?us-ascii?Q?5DZl4SuxdEu+tf0PI8rJCHyk47aFK3FX?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jZWZYyk+vvgfOgrVEQVSwlhkflvSmMtogAJ4WKXnkuDaruHFSAwcSj7HX0x8TpCRq1YkhctRGMajSnzXsRIisb8YFj5n0X9Z6shTonAURhO4LGe93rfw24QcqFasFzuTg7oApZrnDnvXjB9Neo6Tmb1JIDiOt91mVQPUzFqGnkOXqWZZQ3G1i0ljMJ2RI0BdlZD6CHkkGKgNfp7lQpOPwsI3E/OjnHzVQAcOkNY2qeyIc94vykiSa3TTbhaqLTqKlZp4cJ9oh+Z6s2YtwiqWgHF66QvCRnXtLd+cK3k/6gaenZd8HfjSSENuDDH3E5u2munBIYKV82QHSMoBfTquuHGabiBGp+5R+D3nO8cQ5YZ61hoNIXCdcjiQtdolIhWBTpzOd7lTjpVqVlgkvMr0SwuA+YV2+SCxIQKX/vyQip7OYgKBk9SlKOgWAJ3Ynm1i3YkJeNC2JngNABGxlKuhgWukFfHZNV+J4fwNf18ZkoYjyD6rX8ICIlT807s387+H6XVtOa6A9e+jFAh7wJSo2SWjpnP5MB07QQnoVTHrgndSC3G3OlS72cfg1fFtN0H2TYNjretVPsgcPud+Er10lCIyERJA2j9h9TKYVPjosx52n1ER3qDq45dv0YR1DQ/L
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:49.2156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3a846d-9d05-463d-5e63-08dcb71aa841
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5168
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

Implements the new hashing API in the nettle hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-nettle.c | 77 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index 1ca1a41062..894c7b4fc3 100644
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
@@ -155,7 +156,83 @@ qcrypto_nettle_hash_bytesv(QCryptoHashAlgorithm alg,
     return 0;
 }
 
+static
+QCryptoHash *qcrypto_nettle_hash_new(QCryptoHashAlgorithm alg, Error **errp)
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
+        hash->opaque = g_new(union qcrypto_hash_ctx, 1);
+
+        qcrypto_hash_alg_map[alg].init(hash->opaque);
+    }
+
+    return hash;
+}
+
+static
+void qcrypto_nettle_hash_free(QCryptoHash *hash)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    g_free(ctx);
+    g_free(hash);
+}
+
+static
+int qcrypto_nettle_hash_update(QCryptoHash *hash,
+                               const struct iovec *iov,
+                               size_t niov,
+                               Error **errp)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    for (int i = 0; i < niov; i++) {
+        /*
+         * Some versions of nettle have functions
+         * declared with 'int' instead of 'size_t'
+         * so to be safe avoid writing more than
+         * UINT_MAX bytes at a time
+         */
+        size_t len = iov[i].iov_len;
+        uint8_t *base = iov[i].iov_base;
+        while (len) {
+            size_t shortlen = MIN(len, UINT_MAX);
+            qcrypto_hash_alg_map[hash->alg].write(ctx, len, base);
+            len -= shortlen;
+            base += len;
+        }
+    }
+
+    return 0;
+}
+
+static
+int qcrypto_nettle_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    *result_len = qcrypto_hash_alg_map[hash->alg].len;
+    *result = g_new(uint8_t, *result_len);
+
+    qcrypto_hash_alg_map[hash->alg].result(ctx, *result_len, *result);
+
+    return 0;
+}
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
     .hash_bytesv = qcrypto_nettle_hash_bytesv,
+    .hash_new      = qcrypto_nettle_hash_new,
+    .hash_update   = qcrypto_nettle_hash_update,
+    .hash_finalize = qcrypto_nettle_hash_finalize,
+    .hash_free     = qcrypto_nettle_hash_free,
 };
-- 
2.34.1


