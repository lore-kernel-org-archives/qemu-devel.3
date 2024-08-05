Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA8CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb02R-0004Lf-MI; Mon, 05 Aug 2024 11:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01r-0001rz-R5; Mon, 05 Aug 2024 11:53:49 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01p-0003xv-Dq; Mon, 05 Aug 2024 11:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873226; x=1754409226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=q8V4nZTWpLeJ6mnlkkch+mcRbWAOhaEqX9oQWzkg3rc=;
 b=GNUZ6h0YSy6sxgFJ4NRwaftTNNdTpMO0+3LwdBZdos1/jDxJhJo2r5Ok
 rgmjXuwiKa6cjYPBiKSrSni0baUW0cllO9LRlcrrpyKAvAMZnHDqIpkVz
 Td8RF8J2kQkSo30aq7XaoTBa1wAIcOvbv+SiYlMQdE4zhNG2QwOoY17Md o=;
X-CSE-ConnectionGUID: EQQ0XoOpTniAfQ0NZjI/5A==
X-CSE-MsgGUID: DRPD1NFkQU6I7n3JHmvHmQ==
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0/zc6mcGyKBDHecgYQEiHo6C7L7etwpSPfCuhEDwRTe5d3pRRUOpy2hYce4+k/hxWMQ5d8QSDvnWuvV09jgWd7fTbbGIJ0BnFzP/xZXFaM3I0uYbWt2Rcc+qQmCkm/0ZHaHMHqrUm+qPDxh+Iy5ZWWfYLbZ4h8EquJ8TTXbDHsuapzl/qCaPB4tVNjfM1UwxCyrpIBYC1zS2j8fYXU05Ait5vFEsRFD1jNe7wJROJmNn96estmTQYSVeH5CJHEd8bV8KelArcHJt5FkUqAh5d7Vv1ScNmUk/v+ER8cIKAOXNvnXTeqdUVyZkJB2Jg/QZ/xJnFkjwOhozhJ3FE/3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6RNsShmzT8hf/U8O5y5PIS9KvRt7INqxfDhrBJ28V4=;
 b=sDC1ZOskeYJ1WmfnrskVOFV/a9gOT9BT8JCZ2iATY3YvjJnsnuMhx8gua37I1YrV5Qxxpggh3pUuXFo0F++u2wLg0tl55iVyIpzbN9HWlCqHI016a6HhtNRoZJH3ZBRqgMib3RYoRteQYxtc4UEZ94sLgwpA2Ys8T0IEAXwnJfaukX7Y8x7ZYh8yNoKVVeHIVjm38Y9jxYHtvl1F1Rf4nFKaCTsuuB38j1PibRILbF+hyxd50JEDeqRS9spp1rN+kHf57he0DGJNNrywDfY1mnrg8jL/fMMwCqxK4a8St4Htsb16qIeNDd3VASljA3pn+aRv7LJ2uX1WGOiM93SSxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6RNsShmzT8hf/U8O5y5PIS9KvRt7INqxfDhrBJ28V4=;
 b=bihWPPjXfbDOOQknNICAPpxzcGkY6/OgNw4/nMSZ0Bf0nDXhHIArXfiZ+DIUqzAwmYRbuvgMKzKGouunnT67Gqf1Yxe02K6SdvI0/xfqc/Ewk95dO0+N9y22mSYvouLgiZZeTNSzIySA5S1EaT76Io0lgVvYaCH31OfiX0zKqD8=
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by LV8PR20MB7182.namprd20.prod.outlook.com (2603:10b6:408:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 15:53:37 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::50) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:35 +0000
X-CSE-ConnectionGUID: +elo7vlkTYWnCb5xY9RZXg==
X-CSE-MsgGUID: PYEgSyy1TNmRDDylaO6W3g==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:28 -0700
X-CSE-ConnectionGUID: foNXdDyqQ6i6HeyAvR3W4g==
X-CSE-MsgGUID: +bnd2LqgTsehuxFmvDKFOw==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920704"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:28 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] crypto/hash-afalg: Update to new API
Date: Mon,  5 Aug 2024 15:50:45 +0000
Message-Id: <20240805155047.3151540-11-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV8PR20MB7182:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04be3bc5-fc8b-43cf-8589-08dcb566c439
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s+rrfnuMxQx4Q/9w7p+YUn5FumtJ4TC6YQFSn0Kpu42qz0hGKVCyp58vzlr4?=
 =?us-ascii?Q?yzJkv/IDsFSZbGFR5O/IvRl7zVk/gE6OM/Tbr6DsS5Gx6bV9b5s+IChPMwId?=
 =?us-ascii?Q?nNg9au5K7EUDUYb3b3rEnTWo6Zeai50mcoJor3bVtX0xFPbSyMJ9qYKYrDAh?=
 =?us-ascii?Q?SJbW9XmmWt40znkRQ3uZwUjzf+XZYsWHu9/aj58J251ydk7ZDOLqgOrwOAxV?=
 =?us-ascii?Q?g4AM17XjQnc+RL7qbiLHDCoho9HGMIC9TEDxpX9smuHI1bcuxN9LxMOY3v29?=
 =?us-ascii?Q?QClNMfnil1sfLinoIhwZ69c1OLhyNl4dekgVHzDloL54w/AqtCEoG9ZC+jXK?=
 =?us-ascii?Q?yUnUGFJmPMvU8S3FhIEhuwsJwcwBmu7Kg+GI7oYkG3+rjdeNkQb2ogW0Nepq?=
 =?us-ascii?Q?DIk3HhjlW7a3BijubDWiTFsGJyB/IvJsRDawRB/J7QhMALB30R7QZG077JpG?=
 =?us-ascii?Q?dqR8VkRiJg0CTMMMF8r7J3RTBUtONLzIHMf2MjaksD9sXd8y8NMHBiM95cKL?=
 =?us-ascii?Q?H6FlISPV56y6ndu6aKilesdXHX8qhEqi73NXbd2bwk2p1Aev1C5kBEPwrFJV?=
 =?us-ascii?Q?4tQ/Yen+sz6Kzs15CYaebkTTlqIIH6NmBpeUQse6QGc0GBhdl6HxMu7fcC9H?=
 =?us-ascii?Q?dpNwvV3gwCgG0EDK2mRT4ts6+26CwVf+gOvMdTP27O0IXIjqV5Ynp0Z00HQ9?=
 =?us-ascii?Q?YD1MZAkd4J/bM8eOszBWp5daSNFN1Nc+V/o8+mv3rk0WBLsIPFwPhfpFgR+i?=
 =?us-ascii?Q?XU8Q6s1ZRhErxY3VfJAjZQypw5MdfqsQ+iIF7tCM1E1XRf+sbwpT7sys3HR9?=
 =?us-ascii?Q?fEvEg5DOhZwODEIrv6WRfw0TTY6PaXuHozYLhrN5u/Qz+Joi7T8syNCy6XOB?=
 =?us-ascii?Q?/4wHmaI/STaJNwk8hTNk8s3VU3hTf8bx/S/YjBv+f1lDQICI/XkrHl/ZeR1B?=
 =?us-ascii?Q?UwI4H9tQgZro4hj/fLOHPfAj2qlUBp/jrm64jJpbFXo9q7zZQzEGLGeI4nFu?=
 =?us-ascii?Q?Bld1H3WVK1e7r7x8wN+3DjedzPTac5HX+srqsGWEraJJvduS9BzonstfUIOt?=
 =?us-ascii?Q?p88p+Oz+NYGENEW/WPkGuUmmKvl3kkmWBO2jWufAQus7oSwkhF0CghkCwDhC?=
 =?us-ascii?Q?zCO+YZJQ3+bAFvoFwFhk2ieMIVrDcK39513pPU9Mv8S/sC4lywAUzFVHxOKz?=
 =?us-ascii?Q?EUa1+vRBJ2uY4FpHfFRFX8jwmyGefZWk/lYeEni2b42u1PozoG7iqth1OhL+?=
 =?us-ascii?Q?QqNzyB86+RItlh+R7k0cYrpS6dj+jbcglI6lQdNNVhNm6psxFhR/DUCotHgj?=
 =?us-ascii?Q?VESpa8mGZPfy6Ef3H6HV1REMqhWwR3eK0BRwYBJCmdbbThyke7vi5vbSDzUW?=
 =?us-ascii?Q?FA0WT8KokJmnOvk3ZbpIaIINtjOY0Jy+MHmF8YA0SoR1830pmpTxZopbG1HG?=
 =?us-ascii?Q?ki+mpk2m+r25KRg2kFzKhEUAAPPrBASF?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v2i3Ci0Ae+0cpy2zQwemuuvitngZRDVJnSg33zhEELRG1ZDS2Tqq290Dad8TvU3x23XInBBn4rzv7zgTpglfjuvF5Skj4KNAyg3CYk9ghP2ieWOOFbLfT+8UMD88qB9GAbXM/XYIblwChAI8nG1X5jYAUpwQnI0f3q0MPnKB9mNh044M7lXXMbiPC/y5FzZ5iRx3xEUYpAzohVPTBwIVYw0HemaI3oyvf6Der3iR2cFmEFurTru+QU0QmuYXB8/bWyYNzJlIyL7r//6EpRuUF1sYysIU43O4o5hm34ZZe4+M7ndPCq6QUQuO9LAHxJyufHss/AULYvpAW8Upy+veQuvG/eaV9fmtXFPSUQsCOXGxqXWZd5kGaapnRs0g4Ee14bTCNYk2LUDxJt8Hdm4TdU4XpMNTySex8VpV1mzhfuqmLKwRd+zrMEYOAqcOhsiOzL/M6ctvLMOXUF2aGAnmdi0wHnyBw1PXh3O7LW10K4sM0y43OqR1X9/rCo2ewl8CKO6JwrHabc2RvdnojC4X0hNoZA7pvrCRq1kgyZ1II55HgF+O/3ELX+1nZjm7GbW+8p+bdRheeS05UFXD+k+J7PI4bgK5Uyllw6Nept7g+d+h67U3eH/PvWTfwebQvdUn
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:35.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04be3bc5-fc8b-43cf-8589-08dcb566c439
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7182
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

Updates the AFAlg hash driver to support the new accumulative
hashing changes as part of the patch series.

Implements opening/closing of contexts, updating hash data
and finalizing the hash digest.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-afalg.c | 154 +++++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 51 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 3ebea39292..6cf222fb3b 100644
--- a/crypto/hash-afalg.c
+++ b/crypto/hash-afalg.c
@@ -1,6 +1,7 @@
 /*
  * QEMU Crypto af_alg-backend hash/hmac support
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (c) 2017 HUAWEI TECHNOLOGIES CO., LTD.
  *
  * Authors:
@@ -113,74 +114,116 @@ qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
     return qcrypto_afalg_hash_hmac_ctx_new(alg, key, nkey, true, errp);
 }
 
-static int
-qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlg *hmac,
-                               QCryptoHashAlgorithm alg,
-                               const struct iovec *iov,
-                               size_t niov, uint8_t **result,
-                               size_t *resultlen,
-                               Error **errp)
+static
+QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgorithm alg, Error **errp)
 {
-    QCryptoAFAlg *afalg;
-    struct iovec outv;
-    int ret = 0;
-    bool is_hmac = (hmac != NULL) ? true : false;
-    const int expect_len = qcrypto_hash_digest_len(alg);
+    /* Check if hash algorithm is supported */
+    char *alg_name = qcrypto_afalg_hash_format_name(alg, false, NULL);
+    QCryptoHash *hash = NULL;
 
-    if (*resultlen == 0) {
-        *resultlen = expect_len;
-        *result = g_new0(uint8_t, *resultlen);
-    } else if (*resultlen != expect_len) {
+    if (alg_name == NULL) {
         error_setg(errp,
-                   "Result buffer size %zu is not match hash %d",
-                   *resultlen, expect_len);
-        return -1;
+                   "Unknown hash algorithm %d",
+                   alg);
+    } else {
+        hash = g_new(QCryptoHash, 1);
+        hash->alg = alg;
+        hash->opaque = qcrypto_afalg_hash_ctx_new(alg, errp);
     }
 
-    if (is_hmac) {
-        afalg = hmac;
-    } else {
-        afalg = qcrypto_afalg_hash_ctx_new(alg, errp);
-        if (!afalg) {
-            return -1;
-        }
+    return hash;
+}
+
+static
+int qcrypto_afalg_hash_free(QCryptoHash *hash)
+{
+    QCryptoAFAlg *ctx = hash->opaque;
+
+    if (ctx) {
+        qcrypto_afalg_comm_free(ctx);
     }
 
+    g_free(hash);
+
+    return 0;
+}
+
+static
+int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
+                                 const struct iovec *iov,
+                                 size_t niov,
+                                 Error **errp)
+{
+    int ret = 0;
+
     /* send data to kernel's crypto core */
     ret = iov_send_recv(afalg->opfd, iov, niov,
                         0, iov_size(iov, niov), true);
     if (ret < 0) {
         error_setg_errno(errp, errno, "Send data to afalg-core failed");
-        goto out;
-    }
-
-    /* hash && get result */
-    outv.iov_base = *result;
-    outv.iov_len = *resultlen;
-    ret = iov_send_recv(afalg->opfd, &outv, 1,
-                        0, iov_size(&outv, 1), false);
-    if (ret < 0) {
-        error_setg_errno(errp, errno, "Recv result from afalg-core failed");
     } else {
+        /* No error, so return 0 */
         ret = 0;
     }
 
-out:
-    if (!is_hmac) {
-        qcrypto_afalg_comm_free(afalg);
+    return ret;
+}
+
+static
+int qcrypto_afalg_recv_from_kernel(QCryptoAFAlg *afalg,
+                                   QCryptoHashAlgorithm alg,
+                                   uint8_t **result,
+                                   size_t *result_len,
+                                   Error **errp)
+{
+    struct iovec outv;
+    int ret = 0;
+    const int expected_len = qcrypto_hash_digest_len(alg);
+
+    if (*result_len == 0) {
+        *result_len = expected_len;
+        *result = g_new0(uint8_t, *result_len);
+    } else if (*result_len != expected_len) {
+        error_setg(errp,
+                   "Result buffer size %zu is not match hash %d",
+                   *result_len, expected_len);
+        ret = -1;
+    }
+
+    if (ret == 0) {
+        /* hash && get result */
+        outv.iov_base = *result;
+        outv.iov_len = *result_len;
+        ret = iov_send_recv(afalg->opfd, &outv, 1,
+                            0, iov_size(&outv, 1), false);
+        if (ret < 0) {
+            error_setg_errno(errp, errno, "Recv result from afalg-core failed");
+        } else {
+            ret = 0;
+        }
     }
+
     return ret;
 }
 
-static int
-qcrypto_afalg_hash_bytesv(QCryptoHashAlgorithm alg,
-                          const struct iovec *iov,
-                          size_t niov, uint8_t **result,
-                          size_t *resultlen,
-                          Error **errp)
+static
+int qcrypto_afalg_hash_update(QCryptoHash *hash,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp)
+{
+    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
+                                        iov, niov, errp);
+}
+
+static
+int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
 {
-    return qcrypto_afalg_hash_hmac_bytesv(NULL, alg, iov, niov, result,
-                                          resultlen, errp);
+    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
+                                          hash->alg, result, result_len, errp);
 }
 
 static int
@@ -190,9 +233,16 @@ qcrypto_afalg_hmac_bytesv(QCryptoHmac *hmac,
                           size_t *resultlen,
                           Error **errp)
 {
-    return qcrypto_afalg_hash_hmac_bytesv(hmac->opaque, hmac->alg,
-                                          iov, niov, result, resultlen,
-                                          errp);
+    int ret;
+
+    ret = qcrypto_afalg_send_to_kernel(hmac->opaque, iov, niov, errp);
+
+    if (ret == 0) {
+        ret = qcrypto_afalg_recv_from_kernel(hmac->opaque, hmac->alg, result,
+                                             resultlen, errp);
+    }
+
+    return ret;
 }
 
 static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
@@ -204,7 +253,10 @@ static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
 }
 
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
-    .hash_bytesv = qcrypto_afalg_hash_bytesv,
+    .hash_new      = qcrypto_afalg_hash_new,
+    .hash_free     = qcrypto_afalg_hash_free,
+    .hash_update   = qcrypto_afalg_hash_update,
+    .hash_finalize = qcrypto_afalg_hash_finalize
 };
 
 QCryptoHmacDriver qcrypto_hmac_afalg_driver = {
-- 
2.34.1


