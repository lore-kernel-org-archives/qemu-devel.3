Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70353C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjp-0006wL-Tl; Wed, 07 Aug 2024 15:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjU-00069r-GM; Wed, 07 Aug 2024 15:54:06 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjS-00020F-DB; Wed, 07 Aug 2024 15:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060442; x=1754596442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qpsGrkjv/brBkNKmbQ3HIqXroK+XrVabACXfWKqbepE=;
 b=phkkVXbgSDP59GMqCgt+M+sH1NoYKT8qVg8RbTWvSrxYZsjt0RSwjxyK
 j6YHTF9F5nQIiTJBTEtCRijVKe5GfdHw0+NntxIb5KYuAaNXv/R6EgsT0
 MDVsc2LMw450mKRvmW5Tbn5SBQ8pVPAX5WijdGyEYJHlDl1qSdqlPTi3g U=;
X-CSE-ConnectionGUID: XOLwI3LoQdClLqqLIDxrDw==
X-CSE-MsgGUID: N+986mi4T9iiZRz5bAK1pg==
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:54:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d695vZkC0lg162GClJEH21Ma8CC1sU2tLeCyvtpivWMaKh0hi1oByYXgMlB2nE8vw5DBEnfnTtxED5N0iubjIxqnsY44Z6wjmRbmrXEzA6mJu5511MzabnwtK4KRgbQAGU3j2ArJhDNgicxKrzjshnRirQ9t90dsKMOtTlhPiAHC9HCmnkvCJ+7aHhjae05YDbDkBVRMcX7ssIt+gMEstuCn4JKrJ27oHMSsmlI/WodhjBdwdM6GVlEQ80DYLu4/sBT4IuFIjlEUmW7g3Wt6BPhcdavfecSPp8PbNf5XEqjEBAn5QiB+M13PlEydC7cMMvPi1v+T+gZrgxNiiCiZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHlDCU97tON1GqarfQyenvIDyPbrpkWV8HDVeKVrOyg=;
 b=U9krQu8eglC5BENwDNZVXhWa17vB74/vn5ZSQQhNmlqANHdMmtPY+0nP2fShTVwn/24iEmVnXZLowaUlnGUGuYQ2jGBjJdO+83HFrUDWfmYuF2WUS2QElg64q2of9L1Z1ma3NaqPffJ8OMxyVDX7fXH/KSkIxw89oyC3m21mcDbOj9bvgMaZH8PObSxb5mSJEbuDCWPJ6W+Soma54CIyXH4WvufdZDnePfgEbm480IOoTQFrP7YLEnrwS0rPW3dP0oTS/uSqSRz/1ymUwh+M7mKowRfxm7No4wAbCTLe8fdDY64mQJZxr9SvNPh1IYDbNXo7s17YJTc5ultqvYLeUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHlDCU97tON1GqarfQyenvIDyPbrpkWV8HDVeKVrOyg=;
 b=EF6qNDoeilQpoXxMeTb4vwm20jCVSPiPATHVF0OeXd2j/8utHtUUWeli1qNJihTcctLimLDDm/b1LFj34vfQ9rsYYpNH0NLWSDugCweE/M2jojudaMLq1AlJO9LyPHFHDGKuvA3QkvGjMeNctGg9Akwk03SVG9KZ+uM7wAOzUJM=
Received: from BL1PR13CA0307.namprd13.prod.outlook.com (2603:10b6:208:2c1::12)
 by DS0PR20MB6704.namprd20.prod.outlook.com (2603:10b6:8:15f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 19:53:57 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::95) by BL1PR13CA0307.outlook.office365.com
 (2603:10b6:208:2c1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:53:55 +0000
X-CSE-ConnectionGUID: 3Uuh8wvMR6uDdQxyKtGZAw==
X-CSE-MsgGUID: iRjnwcitTMeLRNnhjQCPKg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:44 -0700
X-CSE-ConnectionGUID: U8azIIsMR92iYJ1hV4Gy1g==
X-CSE-MsgGUID: AwDkP1YTTniLvyezrEwWCg==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235466"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:37 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 07/15] crypto/hash: Implement and use new hash API
Date: Wed,  7 Aug 2024 19:51:14 +0000
Message-Id: <20240807195122.2827364-8-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS0PR20MB6704:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6bfaddfa-a16a-4bb7-84ba-08dcb71aac67
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7hLjS3WJdqhV4isQxEBKxfVFYqnoMvjq0vAnz3pF5g2t6D/Pr/yIhzbAoNbe?=
 =?us-ascii?Q?uGvVnYsx/ZXtDFiIY3dpKDJuvqOu3jJRRGsCqkVusslpLd7YkRENBMOTNUj+?=
 =?us-ascii?Q?mq6w1ZR6EHSTaxi3BdPBEM9rL77nYPUXEDUp4ZLt8iRF3YcC5KhU6JR7T60K?=
 =?us-ascii?Q?VCgRxPO8eqmZ4mXZsPtv8qsxWfJtYCRBg/KX6m74Y4VH+Yv8MUKKG2ZITz6U?=
 =?us-ascii?Q?+1rQTAcYfbmj7vAYPgRmfwenR1KB45MOh7ZCPJ0cxy2Y3I2ZIUHFHX1v6kwf?=
 =?us-ascii?Q?Ks8WXW0jkq+fLbe++iB8LEJ9bf5pGymdbzNybDRcmdQpYIK9hDDZ3t4e5b1c?=
 =?us-ascii?Q?84Od0MzoXYeEzCz4IdDziUBn9hL+NNLA6oRB9Z4wkgf1VEUlsVBEcf71e1Ve?=
 =?us-ascii?Q?8j1UsrPgfgWfIC+LzYVhUE1pyPgQuAihmSoCfh7jMbXa7lCVtQN0Ztp04mNE?=
 =?us-ascii?Q?D4B/oife3C9NBsvk7omUhT2Pvsz1K3gSG0TmDBQvF89a7Kz3ew613OFIIVBw?=
 =?us-ascii?Q?JyiMnjQuAXDB5KqIqqg7Gy6/TBoS2QydT/63AZyt6w62GqglFSxDdYtaCdi0?=
 =?us-ascii?Q?vmasRvOmLIx+xEFkiM1+wE/EXymjO5ATTLm+kZbYpxKnLIC3FIThx/Tmx5PD?=
 =?us-ascii?Q?CHPpVX82hrQz+hI8XKWLKOgn9lX8LJ+LZH9DFpT6hEqDs0T1U7cOQFybJtYM?=
 =?us-ascii?Q?MlpL2rdvqcvyZC9UxYkhYoskhN33zvDWsEGWCSuhCALvMIdHIqHuIxUGVHK8?=
 =?us-ascii?Q?dQut7wCrJlbW3tvXlDlc8dCYIb72T3OU6sbWsGjUz45OL6MmWMBcTwe92E8R?=
 =?us-ascii?Q?InTBCpEvNVIPPXjJb9Kj8m/WFueUxSV95k2T5sWYKGHR3mFE/mY4e5xDGbYu?=
 =?us-ascii?Q?JXSU7UNnTk0ldAT/NvkmygA819aODDtTTAoaKYyNNEwYsVWHT8P/UmcRJmed?=
 =?us-ascii?Q?y0rpYmNBJcPXwYhc4wT40IYlARvTvlDloZVOYJJpwQPx6tnCpSPqztCLXQge?=
 =?us-ascii?Q?EZCHfJhdmkiKEjMiq4tRwMDAXdjQb9ueCexJrBPSMy7xCnJZ4a/a3YQ5kFiX?=
 =?us-ascii?Q?A/jfix/7XR2UXmZozBuTochALp/U9q6MiWCOZ3rXTQyRFuOs5YPdI5cRk1hL?=
 =?us-ascii?Q?7elGtM6UTBSFhDwtORME5QoQ9Wj+4ug0eLIHtQRka1WChyvHRf6c6lJ1DSya?=
 =?us-ascii?Q?sKyy3XC7WfNX02O36Lpx2oDPfGrxMqbzD86NYamIZtScR40qq9m7/Gv2QTdC?=
 =?us-ascii?Q?Pdav9A2sAZ3k7PMcbAPBqVmxuvvGi4bABKsopE2j86AwN6p2xJLIop5UfwmE?=
 =?us-ascii?Q?uFToLXpA0lj1o8h7QIF5WT5JbNqQiJPvz1Fvx64mt7zAkoO4LHiPVVMHRkgF?=
 =?us-ascii?Q?y+E9MOFCy83ZToeT6+zCExOoC+df4JvEpSxWs4L09Qlqoj2vVD9b3R3TWkYf?=
 =?us-ascii?Q?RcJngP70+uuCAyNTx1KefiOGFb5Gbnrn?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gP04ZL8wmQd8BdbDuLFeRw/8SQjhR5X/WGsFIbh5aqCwFLCJgp8+c9tffJ6Xfzp0AMuWYHSrJ7impiT8EgY+EUY2I04eiJmNFaMRrLl+2ovvk9W3yXBOvGPBCHmPL+GVtewONAmjdxuTtg3RgfEe/Eyj/E2aw7EBT6BUByoiaFEppsVIh+0j5SbiJV8tVphBoCvhLcgLkWQ15elWejPWv3CMwo/F0mdICwX3/+xcCqZ4OGZgqaODHCOp/8cczAwsLrQchx//9QYLtb56+piqOoZAoxPrgY/lKsOFt2J/QKFAV4rTmg6H6JSTDibkfApjX1PelKomntUpzZJSTdGs/ZmmK0dK4v8hmRoIixfTKtVu2HdQS2DNXctxvhhi0PKkySteg1TxuH48v2MQ/R83U0DisdHhZKqIOL5JTyEtgG4ZEC4SxSZYMIa+hZbzkqel7XurmQ02BU8iDRE5XOHHX8EL94wzmg6W2pT74nwPPBIngoaw0iI4/D8n3b+JttJ2PIJ8kVgv7n0+v6rBJ3Qw0Mm3dXQ4nyAi3f4C6gQd+XghtRKG101zp1uwdEkqdRvFQeNx8y0PdcFjGtkvaRZi94iWB2+fblJb9e1QF3TEl3hbukC9kNJO4qB70uPIZNde
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:55.8015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfaddfa-a16a-4bb7-84ba-08dcb71aac67
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB6704
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

Changes the public hash API implementation to support accumulative hashing.

Implementations for the public functions are added to call the new
driver functions that implement context creation, updating,
finalization, and destruction.

Additionally changes the "shortcut" functions to use these 4 new core
functions.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash.c | 163 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 128 insertions(+), 35 deletions(-)

diff --git a/crypto/hash.c b/crypto/hash.c
index b0f8228bdc..f3c18cdd74 100644
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
@@ -45,23 +46,20 @@ int qcrypto_hash_bytesv(QCryptoHashAlgorithm alg,
                         size_t *resultlen,
                         Error **errp)
 {
-#ifdef CONFIG_AF_ALG
-    int ret;
-    /*
-     * TODO:
-     * Maybe we should treat some afalg errors as fatal
-     */
-    ret = qcrypto_hash_afalg_driver.hash_bytesv(alg, iov, niov,
-                                                result, resultlen,
-                                                NULL);
-    if (ret == 0) {
-        return ret;
+    int fail;
+    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
+
+    if (ctx) {
+        fail = qcrypto_hash_updatev(ctx, iov, niov, errp) ||
+               qcrypto_hash_finalize_bytes(ctx, result, resultlen, errp);
+
+        /* Ensure context is always freed regardless of error */
+        qcrypto_hash_free(ctx);
+    } else {
+        fail = -1;
     }
-#endif
 
-    return qcrypto_hash_lib_driver.hash_bytesv(alg, iov, niov,
-                                               result, resultlen,
-                                               errp);
+    return fail;
 }
 
 
@@ -77,30 +75,121 @@ int qcrypto_hash_bytes(QCryptoHashAlgorithm alg,
     return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
 }
 
-static const char hex[] = "0123456789abcdef";
-
-int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
+int qcrypto_hash_updatev(QCryptoHash *hash,
                          const struct iovec *iov,
                          size_t niov,
-                         char **digest,
                          Error **errp)
 {
+#ifdef CONFIG_AF_ALG
+    return qcrypto_hash_afalg_driver.hash_update(hash, iov, niov, errp);
+#else
+    return qcrypto_hash_lib_driver.hash_update(hash, iov, niov, errp);
+#endif /* CONFIG_AF_ALG */
+}
+
+int qcrypto_hash_update(QCryptoHash *hash,
+                        const char *buf,
+                        size_t len,
+                        Error **errp)
+{
+    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+
+    return qcrypto_hash_updatev(hash, &iov, 1, errp);
+}
+
+QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg, Error **errp)
+{
+#ifdef CONFIG_AF_ALG
+    return qcrypto_hash_afalg_driver.hash_new(alg, errp);
+#else
+    return qcrypto_hash_lib_driver.hash_new(alg, errp);
+#endif /* CONFIG_AF_ALG */
+}
+
+void qcrypto_hash_free(QCryptoHash *hash)
+{
+#ifdef CONFIG_AF_ALG
+    qcrypto_hash_afalg_driver.hash_free(hash);
+#else
+    qcrypto_hash_lib_driver.hash_free(hash);
+#endif /* CONFIG_AF_ALG */
+}
+
+int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
+                                uint8_t **result,
+                                size_t *result_len,
+                                Error **errp)
+{
+#ifdef CONFIG_AF_ALG
+    return qcrypto_hash_afalg_driver.hash_finalize(hash, result, result_len,
+                                                   errp);
+#else
+    return qcrypto_hash_lib_driver.hash_finalize(hash, result, result_len, errp);
+#endif /* CONFIG_AF_ALG */
+}
+
+static const char hex[] = "0123456789abcdef";
+
+int qcrypto_hash_finalize_digest(QCryptoHash *hash,
+                                 char **digest,
+                                 Error **errp)
+{
+    int ret;
     uint8_t *result = NULL;
     size_t resultlen = 0;
     size_t i;
 
-    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
-        return -1;
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
+    if (ret == 0) {
+        *digest = g_new0(char, (resultlen * 2) + 1);
+        for (i = 0 ; i < resultlen ; i++) {
+            (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
+            (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+        }
+        (*digest)[resultlen * 2] = '\0';
+        g_free(result);
+    }
+
+    return ret;
+}
+
+int qcrypto_hash_finalize_base64(QCryptoHash *hash,
+                                 char **base64,
+                                 Error **errp)
+{
+    int ret;
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen, errp);
+    if (ret == 0) {
+        *base64 = g_base64_encode(result, resultlen);
+        g_free(result);
     }
 
-    *digest = g_new0(char, (resultlen * 2) + 1);
-    for (i = 0 ; i < resultlen ; i++) {
-        (*digest)[(i * 2)] = hex[(result[i] >> 4) & 0xf];
-        (*digest)[(i * 2) + 1] = hex[result[i] & 0xf];
+    return ret;
+}
+
+int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
+                         const struct iovec *iov,
+                         size_t niov,
+                         char **digest,
+                         Error **errp)
+{
+    bool fail;
+    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
+
+    if (ctx) {
+        fail = qcrypto_hash_updatev(ctx, iov, niov, errp) ||
+               qcrypto_hash_finalize_digest(ctx, digest, errp);
+
+        /* Ensure context is always freed regardless of error */
+        qcrypto_hash_free(ctx);
+    } else {
+        fail = false;
     }
-    (*digest)[resultlen * 2] = '\0';
-    g_free(result);
-    return 0;
+
+    return fail;
 }
 
 int qcrypto_hash_digest(QCryptoHashAlgorithm alg,
@@ -120,16 +209,20 @@ int qcrypto_hash_base64v(QCryptoHashAlgorithm alg,
                          char **base64,
                          Error **errp)
 {
-    uint8_t *result = NULL;
-    size_t resultlen = 0;
+    bool fail;
+    QCryptoHash *ctx = qcrypto_hash_new(alg, errp);
+
+    if (ctx) {
+        fail = qcrypto_hash_updatev(ctx, iov, niov, errp) ||
+               qcrypto_hash_finalize_base64(ctx, base64, errp);
 
-    if (qcrypto_hash_bytesv(alg, iov, niov, &result, &resultlen, errp) < 0) {
-        return -1;
+        /* Ensure context is always freed regardless of error */
+        qcrypto_hash_free(ctx);
+    } else {
+        fail = 1;
     }
 
-    *base64 = g_base64_encode(result, resultlen);
-    g_free(result);
-    return 0;
+    return fail;
 }
 
 int qcrypto_hash_base64(QCryptoHashAlgorithm alg,
-- 
2.34.1


