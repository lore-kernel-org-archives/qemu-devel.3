Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmk2-0008Gx-KF; Wed, 07 Aug 2024 15:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjd-0006Oc-RI; Wed, 07 Aug 2024 15:54:13 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjb-00021m-UH; Wed, 07 Aug 2024 15:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060451; x=1754596451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YbEzNHiuDkJ4qXMQl/HMyVIVFgH3J+Lg0cVIS4fWG2o=;
 b=ddCs6FbHKtlhcUFt48ChXJ9vNKggs9GMsaxduRCNCy/lM8Y8eFW/rJLS
 zvanO7Qvd2V7WhJ7WDvNcUcAxScIeOeKURh1yzm2FZVL4llMZwYKSMBbk
 EpP1kZYpJtN0GP9M/UL0KxXtGZqyxs6jCOSyvXrT6vmECBPMgwAvy2Ds9 Q=;
X-CSE-ConnectionGUID: GTOBjxhzQNqbavxTquRRaw==
X-CSE-MsgGUID: RMlICGRbSJmUIbGSRP7qyw==
Received: from mail-bn8nam04lp2042.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQRZsxW3v3ixY8CnnlJdCki+SJeJOaAitdry94yr7k/wJPnLEIVPp8Fg6LNU8NwX6KWbXG6VocN6NHCLlykzKCRnFR6N/pB5ggOrlRWhkOQqzqnZNw2GYon0EObmqe5015J58kbgkNWc9um2kxcMGXZiD2tGBJyngJp/2RL/8DQ4ivGVgzusvsCwvB5y4+kgTK1nTjUmoAl4HIRoVGQgov6ii4duVpXd8X6KO1InrnzZTiz89MiJwS95ZWGuBQJHrdeGEvw1cRh3Kc+pNsfhUXZsRrMBX6JZS7sTWpVo3TqEC38XWDc8NOJRySIPSubnLuzg4Nh6dnTPnl1cR4j0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5AwUhAILAw9BQ1PVVzvR0Hz4n9LEcT5O7KltMzlooYE=;
 b=jgel5j5yeItUeBmSvPGRAUPY61U1X63mEwK6MZFoeaLu6WY7dxwRqKKOcu2OVDC8V6xjck8G2r0ifrqty9Yw+rfoQfudwEbGFRbUYBVKp39ZbVR4vsDRH6llR4WRXusqnNSUxLhBGvSTXIQMJn/glx23v5UyV+ICQalR/7ZvHdxTkEcy2gOtthCz73txf07iMZ8ao+sWD4CBx3hKzjlIEayverRdf8AWu7Y7Fz+Sod2xC167rnsyTizjqHbMBN0fD5bw+XEvHRoK3qFTFTCryOmy7/0e9e44IEciB3KEz0Q2tI84gFzdfuKAM0424TaKtIJdYLjGoYZ7/LjAMnGUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AwUhAILAw9BQ1PVVzvR0Hz4n9LEcT5O7KltMzlooYE=;
 b=avohxFGFL8+Zp9F0ygo+RvtvNTamKQCgZdRZcIRTqaKMGSmCChkRrqCEESsr9vOE2bhou0v/VdgPgHWsymVdEDTM7Koj2JYV/FV9mYOsftbcR/gv6zCN63u2TZ15h04XItY8ZLJHrJuQ8sN5BQusve2SXRrb6CtlmTJx/OJ/Wxo=
Received: from SJ0PR03CA0064.namprd03.prod.outlook.com (2603:10b6:a03:331::9)
 by PH8PR20MB5169.namprd20.prod.outlook.com (2603:10b6:510:1c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 19:54:04 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::3d) by SJ0PR03CA0064.outlook.office365.com
 (2603:10b6:a03:331::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 19:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:54:02 +0000
X-CSE-ConnectionGUID: 3f4WIO3XQ028MHGEqelJYQ==
X-CSE-MsgGUID: tZYSQzeDRxSe0oqrYzVxzw==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:54 -0700
X-CSE-ConnectionGUID: yTHppNklSE+gTqv25Jrh8Q==
X-CSE-MsgGUID: q4AYlazGRzqE6/HeY9o/fw==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235483"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:46 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 10/15] crypto/hash-gcrypt: Remove old hash API functions
Date: Wed,  7 Aug 2024 19:51:17 +0000
Message-Id: <20240807195122.2827364-11-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH8PR20MB5169:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 977825ff-b97a-4d1c-b85d-08dcb71ab081
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pmxursPRdUghkQ4Sv5cBURZQesbID89xTtDzflBvAx0/MkbW23MWioaf1yN1?=
 =?us-ascii?Q?jmCUTzoA1q1euPkMcjwHg23Qd9xx3G31L3nSjNRGHNv3pobL1ckB6MDIIlan?=
 =?us-ascii?Q?hdkzHPEJTxLt2lcP9/aKCSCc3VVKq6Otj3KgTFFnt+NiNYen4ypAEXcAJJ5w?=
 =?us-ascii?Q?3QD4zLyiMGplU6n+zBbss98ykwJEq+OFCwRDJw88wScy5u7DLZc+Ya0bvC2K?=
 =?us-ascii?Q?yrO5HZ3YGUYCuc/AYGrjlqMhONcmwJRfg+4f21D5Bf6p3KpUKCym1bBvfqcu?=
 =?us-ascii?Q?yTNhi/kE/euodwFFBCwIMwPzD9cFjTQ5mIGIsN4hkBqj2yd98d1DH5rQbbrD?=
 =?us-ascii?Q?NharocDOzdnXOHOpabsS1VnoFsVrG+ySKmb4K/0UUbC15MM+AqN92TvgE2D9?=
 =?us-ascii?Q?eyLGILaAbVIiMv0Ad+EknrqomkXWcS95KAEtBNHvud9PVKqgBs6z7v8AX9Ma?=
 =?us-ascii?Q?8qLZ6kM7XgABir9hyZBm72NqFvjrlVbQjTxt9jG+UZvTper1FCLwJqWumvhg?=
 =?us-ascii?Q?AQrQZDLXjJOf1TbJu6uWk3qW0OqVbuVALFWJ/6SzHOpWV8oJVecx2coeOYfm?=
 =?us-ascii?Q?bNJBh+eqFHTCE8Sdchc7o3gQNEh9o8oG8W0/mLtgPVJteHYUSBNLxMR2d8nW?=
 =?us-ascii?Q?n0Ep7hIx077JqiMQoXjr2FE19VrpHXr8EqLf6ZLGNUrXThKdOxdwM9H6aEDE?=
 =?us-ascii?Q?JBhnrr+KL65fpKjr0w+ruXDLnhqMen+uhZsr5DFM5+LTF7KNuUiN2LS/lhGL?=
 =?us-ascii?Q?PHgDIO/cA++tE7LxMI3bwrhObauEpCzsXfpK9+NONMBwVPGp+Zh9bv7LatkJ?=
 =?us-ascii?Q?+S8848gpreZ4J30E2wpxISoCk0O3SSpByczBYWU2vg7IiVhpOsPQe6HydFkf?=
 =?us-ascii?Q?nkOeuelzfjjrrYjYDerXTU8k0+rgTRMYgKAhA6py4oINycRHJEIKvBKGTRwF?=
 =?us-ascii?Q?L/Hq9mFtl0OomKhXfi6ZfMZFndPm2AyAjVceFWth2eGo3ptZisstIEppkvHp?=
 =?us-ascii?Q?rzsVSHN5v2HKSPb7MFZRWl+hM1FBBKzfcFEqErj/hBqtw4c7yw7zy8+EouU7?=
 =?us-ascii?Q?XFVhvJX0Ljnk2RtBdCfCzGJwL/qh4hvczcfxy9sgGTcLqMfkLeufn+u/NyGu?=
 =?us-ascii?Q?4jObzxfW9da1BhZZMBhOhXO6KHgg2U2A/9YY75tf31HzQbN7NoiLmD0FKDXK?=
 =?us-ascii?Q?duHitUVU2Q9toVkV+Ph9FeOG7fjQUCzY8mYF0Jm5B4bAI/pMOgkLnAe/+hN8?=
 =?us-ascii?Q?FWpejg2lY2Jax58FcdexsmmA541YE6vGEEuflYGRhhSsh9Q4wu+fS1dfCD0q?=
 =?us-ascii?Q?x6xZqpgibif3XBYrO2HFDJZxsnzyVgB5wIVK7dWLhAKv8v1OQUya012jOAcp?=
 =?us-ascii?Q?SAd7/ICbWB0vQ9UK/2nqf12de8QBdvUYhTeiYZqviazhysuMPVWkbJX54lD6?=
 =?us-ascii?Q?Bhxk8+CAAUiPPI41mNPHxVzDqcylbQyy?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Trjq/RePdb7YH3R9xsgIDaxV0q5lXWHlHbnDkranvtOMyl3EhvAP4WMDAoXswWVtSp0+tK/xxR6E0Iw14bBf6WQjg8uqp6URc42JZp+6XdHqohMBvsGInV2f6gpL+nV2xXMSgcvXT3kNsRxb21eJJNz+HGWQmsCWtZu/A+wwO8b8iv1jhQHE/+GjYw7Ka5UNKeiq3epMRLOKYhgNCplWkMAaoRIfdLslUIXDGMD8vvO+0VWWCWSkPoOe2WHNMr+kY6qoRj2LufoWKGkJHaK3IxXLfU0VODEUJJY+G95tEgsT3LrzM7VmWtu4LRmOB6ITXpXaUH3Zqlnia4/Cj6uGrpP0rjFlYJmUW8N7j2BwYYB4rdiSg7fBQfxJv3TG9VmsaQfilMIA6a2VaPC4MKtKrw0GM7c3WDMWJsgjXcJaRT82HksMs2FhQKvtGt1hQD0Bfco+2PnE87fpxbNu0gaUDeC14jOBex5ICSaEnHVgFsWOL47Y/ayqzcMnXvm4zJf4G+BAJDq0Ce1jY3wN9iHWI7VN8yYsN+9nU2fDBpE+arkmc1uYeDnAlVH7qzN8BQpIe9w5O38l7WmdiwJpo3sOTEtDcQOX4AAC+SzKrQhlLmBegPOxGWSsVRFnRWWTdgMY
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:54:02.9498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977825ff-b97a-4d1c-b85d-08dcb71ab081
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5169
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

Removes old hash implemention in the gcrypt hash driver.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-gcrypt.c | 67 --------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index e05511cafa..7779ec8446 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -45,72 +45,6 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
     return false;
 }
 
-
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
-
 static
 QCryptoHash *qcrypto_gcrypt_hash_new(QCryptoHashAlgorithm alg, Error **errp)
 {
@@ -187,7 +121,6 @@ int qcrypto_gcrypt_hash_finalize(QCryptoHash *hash,
 }
 
 QCryptoHashDriver qcrypto_hash_lib_driver = {
-    .hash_bytesv = qcrypto_gcrypt_hash_bytesv,
     .hash_new      = qcrypto_gcrypt_hash_new,
     .hash_update   = qcrypto_gcrypt_hash_update,
     .hash_finalize = qcrypto_gcrypt_hash_finalize,
-- 
2.34.1


