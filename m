Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFAC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjb-0006Gq-3B; Wed, 07 Aug 2024 15:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjE-0005ex-Ll; Wed, 07 Aug 2024 15:53:48 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjC-0001yf-IH; Wed, 07 Aug 2024 15:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060426; x=1754596426;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zdWvZiQ2tMfktnVKXQ0Tl2aID5JYCZH/MvaD3wcKjRA=;
 b=KtpRmzzwBJefiusPQIADovuLtqK2zZD4tdUP5sdHq4xbWhn8KguGu+NU
 rXF25XnPr3TthUMBxJ0OpqFWjb+N8ngknd6a1LYhS3p+Y1fxNGeXNneWd
 FdyiFB7TkobUAFhLG6GOtxYBGECGsMotsWY3Tx+EVDk9COsEZouI3MJrK Y=;
X-CSE-ConnectionGUID: qZ7lrKY4S3GsY9Hp6br2bg==
X-CSE-MsgGUID: Dg0AOGL5SJ6NYEtBcmIddg==
Received: from mail-bn7nam10lp2048.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.48])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNhc8jQMirEiNT/8qtY/vnIc3YYMtpvptbu3D8j1Kw//POSgw6SvQyNDYVIvOEDPWenLDUWrNnTtZzS7K6JKeZfdqHLfnhMUwLO8KrNdGeKMPdGO/Vy/LQ4D60IXVBdsKNLcPj76y6EYKuHnW0DfMFqipHtfS1Dh+1L4w4RboMyZo6Q4VaMM3npMwCt86Zan0tc+QEI2M/zC8dxlGMC3pCNShqXtqtI0zysbU9Zp3vB5or3igYBefpmlZQOTn+iueaYk3pCPzii4qxH3J5Lmy28dHJ8sr8oNPsazcfIdhj1IzBden5l1/NUFn0WpNDsh0wNiB4Y34bUpBFAdJFK3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71KrmaK9PliYhf4f1sEYgPUR70gIFqKV+iAYQMen2Ac=;
 b=wIPsdvig0Ad0Aq0hRYvsec83ipFX/as2qVn8c3rIYhQJRtRdqwMRYvyhf00nVIjjm7gK46vKEW0IJjjvt2YvOVp39pAYk9MttpHJi/bOsG3wpJB6/qi627icEp8koKzxI5WfT+7u1f2CVdog8orXLzltp+HMW4brF8oku+SRBMi1iqxcDAVw9AyYMUvGren1AnVx4pcI2EKQTO9fhZqgyEoiu+zVvvd9ViG64iN5YnXoTwRAELaLutXeJcivILqpO2G064JdKVD0B/gww+VBhIddSSHcrJDaOZvHv+Z70/Nhr1ienVV3Uw6tipouLL7OtZ1ni7GMwwJfZ/v+W10aCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71KrmaK9PliYhf4f1sEYgPUR70gIFqKV+iAYQMen2Ac=;
 b=MGS4m55caydU9kVlCpH0AsjaJhfCfCaxrreGB+LXdLs/wHOMaj1N/sVXZOkFv+q8ZlIva49pxEUHGNS7IkELP7RbO97WIlyNgQUn0eR7EFerTCUivlj12QqzrtdCdm3YBek7jC0jk43GKJPzetrf+AZFNRcg16oZF7r3pZ/uThQ=
Received: from CY5P221CA0140.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::7) by
 DM4PR20MB4704.namprd20.prod.outlook.com (2603:10b6:8:b0::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Wed, 7 Aug 2024 19:53:38 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:6a:cafe::cc) by CY5P221CA0140.outlook.office365.com
 (2603:10b6:930:6a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:53:37 +0000
X-CSE-ConnectionGUID: 8R/NuabFTECa1zTf5v82qw==
X-CSE-MsgGUID: 5M8vDSmER6GdyeXva+5wOg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:26 -0700
X-CSE-ConnectionGUID: UGRo2tFQT8qmrhEg3P0kYg==
X-CSE-MsgGUID: FMOWw2NGRras9opR991xTA==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235455"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:18 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 01/15] crypto: accumulative hashing API
Date: Wed,  7 Aug 2024 19:51:08 +0000
Message-Id: <20240807195122.2827364-2-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM4PR20MB4704:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f76c3b41-f22b-46fb-3767-08dcb71aa11f
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jLyWezq5IXz+xUxY3sAfxIfXZn1t49w9dGHloSLdOcm8WgV1pMKqy1bAQJKl?=
 =?us-ascii?Q?SXdb/XzoeXJ14IsZ9rMfwsQQDdreuNWkEGrJCEw8MVayaORq9UM5l0qlXMUv?=
 =?us-ascii?Q?+Jt5aeIF6mSRrbhXB52PwUxPUhu2gYbYfJTODoTwvSwfq45Bk6np8rBlHw0l?=
 =?us-ascii?Q?r9ZY3lJwG7wOOUvw2XPM07Gd/zCXCNXW6kilGFTu6lIDE7XQvYdehZj+DMwG?=
 =?us-ascii?Q?7jG14sH+a4XMLO6NPBocSkcY835qEK8S/EDbWeGjChEKH0MpR/PQMHVIsTQf?=
 =?us-ascii?Q?yyioWdPmu7a72SIv0+uLpEhu9yrGxotNZ6a7nrjok3PYkbcvstsAYaDMoPes?=
 =?us-ascii?Q?m9WUX2ld/xyXqg5IoO3At2fa+lxtIvXWdi9EVyXo/0kFeLFXlXA5i4oh+5gf?=
 =?us-ascii?Q?BHA5h8/fmdnmMMriYFFBh0xK/zdaiN52dQO09gFn48sM7vChMz4YRXd/MPwg?=
 =?us-ascii?Q?bdWCIasYTG9qRHe6pcqO87F/UEUMEPMXcJaCAAJDSDvFVYg7WTOgZ2jLFyXf?=
 =?us-ascii?Q?QzIvP47IHzir3SDDGeec0kfeSdqwLAs45hOqdmDm2IySPd3W00Hod7m47aRR?=
 =?us-ascii?Q?6w57ckZ7cEuIgQG9ogQ8Ce6bwVQCaplhFU+luUjaCvK4lqG/GKtkMTMS0HhB?=
 =?us-ascii?Q?3ChG1PsYJgVegfO4+fJebVkM6dI4jyaUFbYVlvQK4g7PBPVCRYCp4FxIqMz0?=
 =?us-ascii?Q?VjPd/ya7hZg0KjakuJ9YyP1CAuTHopdOtwEhywR/+YA2VlkZJD7aPxQ9cjzE?=
 =?us-ascii?Q?pkpDccLW7PzjQUWiNXJpyxAAW6Xx4evNWpcKamR7cjkKhffu34S0NeFIkM3O?=
 =?us-ascii?Q?IhitxevqnzNfr44+u9Zy7TlHrGy7mEF/oQe8xe8na96HYJYY00vwFtuuMPGa?=
 =?us-ascii?Q?6DPee2ZFw8q7WXV7WZQHnTpliEaz2QRGwZd61hfQzGFMNKWTRlIqzRRDdqyq?=
 =?us-ascii?Q?HsE+++zx6H3V/ShY/xtMSpr6DIFj/WgZD3JLcDRVmUxAJ7kp63JxcbQVnlhY?=
 =?us-ascii?Q?feXoBIWrmwpkxLdzYiYyS7POrcAVmzgCbDh2WVB5yveG5t97Z7cSt/CcfaHV?=
 =?us-ascii?Q?OIDoSu5LWKvz/U5AVl7KnYjbuzhewNeO9wxj2q96Pfp8I0nt9yoWdV3cpxKB?=
 =?us-ascii?Q?Qgcht/DjWgXRcWlJ4de/69W/cRcRVHd85nJIHnqXXAqnPVPyMZGbRBB+GuJz?=
 =?us-ascii?Q?+mtOqewo0kZjgAYd/E9VOAivCm+tR8/9c6ti+IadcXRik1uNuJRPr0epwdYS?=
 =?us-ascii?Q?1Sf3/mwUd0/8uRcKI4ioawSgzVZZBLG3KuqWNJZ9J18VGvmWE870ZaHzRaQr?=
 =?us-ascii?Q?+hYRtPgVybCeHmZTfbiVt2FoEY188a9MEoGLsgIO+nDuFPRWv5jBrVrsFN/7?=
 =?us-ascii?Q?1JNsG55JU9MdkxP68Pmf/MPADA3YdABBZoald0VaR5ZqQx0bLqVfL+Xiji+y?=
 =?us-ascii?Q?pwvvdhPJq3bOy/YsUmFVPbE9YXG6ExU3?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K6E9bHzJFpTZ/Z5uJBkH5YOauCsrZ0zEfdOvIddzXxhhgexWbYQkLQ9ePAvGRxQUifrYGjvGYhz1OfHyhqh2EKcvbgs2nQo+ER126+m7na4higZHC7uheyjrQLji19Dtr5glZlRHn/ByIXHnq90OZWPGTptEX0tlrMA0xsUfBd+5sWbMSTtbLfrReR9Ud2/MBqongo6JHdcebdBTuU+EKsbx4ZA+o+fFAnJ/WfHNKr8ygWvulvtGc8y3d0SQ1CUrOixBJvAWh8S6syV+Y40tYjdc0npxLBce+HTobkGPKKIGDsEtsRCes9543vFY3NwLk2P+JcpWNGdHSSEZcTAt5WLdFf1JgOusQMFS8iuFGZTbY+1AhAl4DJ0YCLkc6ievrORDsq54BI6xxTp02BjWjA4gVbXIedykmKpvO7ezdWLDz5SduaXdehdnWXOmKCeLxommx9NXP/KKsGk4L7Wz6blyqpmq4g4Bob8pm2FgK8N7YueJVOg2HMdnTU3FVkEeekD+TXLAdiRxjT5TylGuUztEEwLmCCjbotZbCkDgsNNFkYrDvKZo3vBg4R6ykrk2jrDKnZX2Euw5W7fLYbKa6NWMgqHVGEMR6OtP+I4HmjnRDymNaEXzy5OmIRgWb3Cj
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:37.0759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76c3b41-f22b-46fb-3767-08dcb71aa11f
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB4704
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

Changes the hash API to support accumulative hashing.
Hash objects are created with "qcrypto_hash_new",
updated with data with "qcrypto_hash_update", and
the hash obtained with "qcrypto_hash_finalize".

These changes bring the hashing API more in line with the
hmac API.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hashpriv.h     |  13 +++++
 include/crypto/hash.h | 119 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/crypto/hashpriv.h b/crypto/hashpriv.h
index cee26ccb47..02f17ee99f 100644
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
@@ -15,6 +16,8 @@
 #ifndef QCRYPTO_HASHPRIV_H
 #define QCRYPTO_HASHPRIV_H
 
+#include "crypto/hash.h"
+
 typedef struct QCryptoHashDriver QCryptoHashDriver;
 
 struct QCryptoHashDriver {
@@ -24,6 +27,16 @@ struct QCryptoHashDriver {
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp);
+    QCryptoHash *(*hash_new)(QCryptoHashAlgorithm alg, Error **errp);
+    int (*hash_update)(QCryptoHash *hash,
+                       const struct iovec *iov,
+                       size_t niov,
+                       Error **errp);
+    int (*hash_finalize)(QCryptoHash *hash,
+                         uint8_t **result,
+                         size_t *resultlen,
+                         Error **errp);
+    void (*hash_free)(QCryptoHash *hash);
 };
 
 extern QCryptoHashDriver qcrypto_hash_lib_driver;
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 54d87aa2a1..6d7222867e 100644
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
@@ -25,6 +26,13 @@
 
 /* See also "QCryptoHashAlgorithm" defined in qapi/crypto.json */
 
+typedef struct QCryptoHash QCryptoHash;
+struct QCryptoHash {
+    QCryptoHashAlgorithm alg;
+    void *opaque;
+    void *driver;
+};
+
 /**
  * qcrypto_hash_supports:
  * @alg: the hash algorithm
@@ -120,6 +128,117 @@ int qcrypto_hash_digestv(QCryptoHashAlgorithm alg,
                          char **digest,
                          Error **errp);
 
+/**
+ * qcrypto_hash_updatev:
+ * @hash: hash object from qcrypto_hash_new
+ * @iov: the array of memory regions to hash
+ * @niov: the length of @iov
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Updates the given hash object with all the memory regions
+ * present in @iov.
+ *
+ * Returns: 0 on success, non-zero on error
+ */
+int qcrypto_hash_updatev(QCryptoHash *hash,
+                         const struct iovec *iov,
+                         size_t niov,
+                         Error **errp);
+/**
+ * qcrypto_hash_update:
+ * @hash: hash object from qcrypto_hash_new
+ * @buf: the memory region to hash
+ * @len: the length of @buf
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Updates the given hash object with the data from
+ * the given buffer.
+ *
+ * Returns: 0 on success, non-zero on error
+ */
+int qcrypto_hash_update(QCryptoHash *hash,
+                        const char *buf,
+                        size_t len,
+                        Error **errp);
+
+/**
+ * qcrypto_hash_finalize_digest:
+ * @hash: the hash object to finalize
+ * @digest: pointer to hold output hash
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have its data updated from the qcrypto_hash_update function.
+ * The @digest pointer will be filled with the printable hex digest of the
+ * computed hash, which will be terminated by '\0'. The memory pointer
+ * in @digest must be released with a call to g_free() when
+ * no longer required.
+ *
+ * Returns: 0 on success, non-zero on error
+ */
+int qcrypto_hash_finalize_digest(QCryptoHash *hash,
+                                 char **digest,
+                                 Error **errp);
+
+/**
+ * qcrypto_hash_finalize_base64:
+ * @hash_ctx: hash object to finalize
+ * @base64: pointer to store the hash result in
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have it's data updated from the qcrypto_hash_update function.
+ * The @base64 pointer will be filled with the base64 encoding of the computed
+ * hash, which will be terminated by '\0'. The memory pointer in @base64
+ * must be released with a call to g_free() when no longer required.
+ *
+ * Returns: 0 on success, non-zero on error
+ */
+int qcrypto_hash_finalize_base64(QCryptoHash *hash,
+                                 char **base64,
+                                 Error **errp);
+
+/**
+ * qcrypto_hash_finalize_bytes:
+ * @hash_ctx: hash object to finalize
+ * @result: pointer to store the hash result in
+ * @result_len: Pointer to store the length of the result in
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Computes the hash from the given hash object. Hash object
+ * is expected to have it's data updated from the qcrypto_hash_update function.
+ * The memory pointer in @result must be released with a call to g_free()
+ * when no longer required.
+ *
+ * Returns: 0 on success, non-zero on error
+ */
+int qcrypto_hash_finalize_bytes(QCryptoHash *hash,
+                                uint8_t **result,
+                                size_t *result_len,
+                                Error **errp);
+
+/**
+ * qcrypto_hash_new:
+ * @alg: the hash algorithm
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Creates a new hashing context for the chosen algorithm for
+ * usage with qcrypto_hash_update.
+ *
+ * Returns: New hash object with the given algorithm, or NULL on error.
+ */
+QCryptoHash *qcrypto_hash_new(QCryptoHashAlgorithm alg, Error **errp);
+
+/**
+ * qcrypto_hash_free:
+ * @hash: hash object to free
+ *
+ * Frees a hashing context for the chosen algorithm.
+ */
+void qcrypto_hash_free(QCryptoHash *hash);
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHash, qcrypto_hash_free)
+
 /**
  * qcrypto_hash_digest:
  * @alg: the hash algorithm
-- 
2.34.1


