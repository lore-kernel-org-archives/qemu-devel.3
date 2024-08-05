Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb020-0002RG-MW; Mon, 05 Aug 2024 11:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01o-0001bS-Sq; Mon, 05 Aug 2024 11:53:45 -0400
Received: from esa.hc4959-67.iphmx.com ([216.71.153.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb01g-0003vb-JN; Mon, 05 Aug 2024 11:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873216; x=1754409216;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YAcpsHbRyjafddjdwq3SOJPAqP0qhBsQDpIJXGUFrD4=;
 b=Tu0w2jHJGFCqcACucp2luhuWkoA6X3pbHVkl26+ehmeWyGe40iJmMx4V
 xNFzAyGVbzpLd6cQ000voQjOP/Bc6HbzJIJ2C0dWjAi2d9RmxMwtVpMV+
 u9QFZ5tmbqhE3fTatiVAyrVfv6cm83YrTBrvyVZTPI1DL+1wQ9j7TF4mm E=;
X-CSE-ConnectionGUID: sknDlHmBTW6kTuLTTW//ZQ==
X-CSE-MsgGUID: BHuKFwi5TV+EmaqQjzPpMw==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:53:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukcXA4w2wGbZJu8HxwombSBwOVfRNi6zU+GtL7UL466SxO8EEyjE31zY9gvCxUxB2hDEh9foON5XXLVUFK2biwHN7pydWL4pAJHcsKQAQyRGi2g0wtAd7X9nOUk6arJph6b6A2zBi73Gr/NIHutWR71fuHpElQxoEc2mZZy/DQ/oJRuiO1kipRCd9/rKdCQWf7SxBxBCs0/0WSsDSNqeUcXdJabbF1HR+798aZDp3X8jrBHdEMxVZM4OEeIZvrJUZyDIqcectiapNlEKQPa3DCpZ83pgeESamSqW99yT9mtOI3sWkTtKcIP12QkbvQEe3OVb19NNX82HcZPvd2gqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkkETshu4Tahurh9Otyue1OjYmjFHx7HywzpAfsFfvA=;
 b=kR8Gl7gi7Op9zp71cdVHe7/FZF1CFc6gwedTeoT0vryQRRzWpljnrXVPvnWYjih2ocDyr0b1TPvicPg+UbXfG2sQiCXZtmiB3tVhl9Fa6qSYDwmUqqz/kZyfR2TfuF12YUhdgDXGr6tzxxScY1aCjbqkmZag4fsFmVCGu5p030ZbCVuXFYc2hf+M6Q+djqIOSbU+zMdx+HQUGCF2ybI6I/gjgue/3pdL6fRbR3vinWsA+1vvZoGx5qSvUA3HlyBkW86CRLqx9eFbY8mvn7wBbBNV1BsTHbRQe8qwAuyi/9vuKxb4ccAUgg/DTid0Os9ssZQQxJ3GI5PFVH5YhuGpIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkkETshu4Tahurh9Otyue1OjYmjFHx7HywzpAfsFfvA=;
 b=HSdMpYmozYCtNNFhmToiTn9+toFrX5Mh/CXpEMek2ggI3sK4Alo7CapKKKVZLdlBwLMvsd2+7MMtLSQwoqWsjJufWMFebI6VWS4VazmxzfCdVc5QZNhzuzPTIyGTHEFlx/Zefy20QRAH65STma7zIALUpe7OAF6q6mYPsnjDqEc=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by MN0PR20MB7295.namprd20.prod.outlook.com (2603:10b6:208:4c6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Mon, 5 Aug
 2024 15:53:31 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::18) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:53:30 +0000
X-CSE-ConnectionGUID: q97XCLWNRPmrSLawGTm+TQ==
X-CSE-MsgGUID: 2hQxtgTRRdGFu85gIoALKg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:58:22 -0700
X-CSE-ConnectionGUID: jehKeLENROKMeNOsFpFrbw==
X-CSE-MsgGUID: 1w1V3s5ZT8yvlgGAFyHBdg==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920703"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:53:22 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 09/12] crypto/hash-nettle: Implement new hash API
Date: Mon,  5 Aug 2024 15:50:44 +0000
Message-Id: <20240805155047.3151540-10-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
References: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN0PR20MB7295:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c5c9f7a-1a58-4cdf-9772-08dcb566c100
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A7pAufSjiE//STcc2lV2iQ0+sU+k9gCzMd6BIiwI38lkE4koRmbCzeS6nHqT?=
 =?us-ascii?Q?xRZyDS5W8JXQjnFSETE0piaqD9n1QZyNCFOQ0GfbDi6AF6WaKNS428AyRjBG?=
 =?us-ascii?Q?GGMApUaRf0GGVAhqvdt46iMrfrXCdGnPBE/0fu8lH4C1gRWtc1gDjVeGOS3q?=
 =?us-ascii?Q?utkatxIMUcjff/J2bpGcnhnYJEQ2nQaMXKl08lVO4p0Sg3/xHlWdvgzAVScg?=
 =?us-ascii?Q?YHJvQzrefkQswY3xzLZQDZ4FoQFYzqHCnl/WNlEb65AXuuuizelk+Rlv3klz?=
 =?us-ascii?Q?hSuAdg9L9enJSOWKFNdigk3gC+hbSDXuSrwEZIHZpdaN02wX/IYFjcOjSRQX?=
 =?us-ascii?Q?dtapuNTzz/w0DZnY4tl8wJq7FISvhjpN+Bn2ymWfDfGJN6PVioeFZZU0BruW?=
 =?us-ascii?Q?6bKtA5N2TNgbn8dRU6y/5hNliUOcYq4cwVEv40C1b38AUnZ8Q/sOdT4e45iB?=
 =?us-ascii?Q?YfhI8KiBHrUO+NgID44yxwb71yhRW/0kDpbHuqdWqXc3rhxs5A6YoFFEVhFz?=
 =?us-ascii?Q?5ReQu3ree+fMpdV2Y7fOEp4LF1yfw/Qs1w1AGRi4mfc2NWr0HPQeBKzEd7fD?=
 =?us-ascii?Q?bTQzUSW6eGQpIkD7a4IDukKeF+lC1FO7jCN2UwbZGZk6WkLbHUDhWnxfuR5A?=
 =?us-ascii?Q?IGmkfTAwHOnpHMQcT7wNhPT/PqiEprYRO6MdPUBbr8sUeHxCwCAdsef6Q/9B?=
 =?us-ascii?Q?RRjel21sAqq1ykezSYmHrIuEsUT3x0g3BruzoCgFnbdAq7PaypRP/2kH0wx4?=
 =?us-ascii?Q?0hpXw5QFQzdg1TR0hvICoAWaU6acsRfCLBl7BV3jyiVddqc+dceAThtScnmX?=
 =?us-ascii?Q?PwpjRF1dQjMRZ2EhCegbVB3+vrI/q+UK2atf5D+M7yqiTgQNMyrVCzuJb7Qp?=
 =?us-ascii?Q?vpDhlaxapCKAGxY4Ct18PxtTlV23OkLH05EAs8NqddpwqYsHaq4P0Pabvbpu?=
 =?us-ascii?Q?+EAegXOd8bA3rjqE3eHcxXnaYHeGanevkJ8T1gZTEJN4IqfwrKP5JFpFabv1?=
 =?us-ascii?Q?WgoRwdqWDj5z6Y38Fzx/khFSz0LiNQj+5dzfa8OXSTpYraFi4cljWaepDyno?=
 =?us-ascii?Q?DoBIYuJNH8kSxnhXH0eRRCeho1pkot9ueDbxm1FWsSHnL6R1VIbQdE2I24KQ?=
 =?us-ascii?Q?7w5K2+pEZunezkXvWc6eBVcnyqjJ7EdjCdQVM/REpYrrzrB3z/goURqtgVvr?=
 =?us-ascii?Q?mfs40FFnTzGC5Mtw6kZ1sAV9G8JPGB55XWpZnU21yBoFPUu1aGsMGEDjFOGB?=
 =?us-ascii?Q?6df8sLyA5IWEm8osqEzTj35dF7MUs23X87MgzUJr5RUQU4J8HBCnCmvsmTA/?=
 =?us-ascii?Q?TjH1FZqDfHXFBpASnXMC9GEVrim97pi1dC9ouO6iguzI/7usMktElPZz8M0V?=
 =?us-ascii?Q?ejOnMb9Jb2lvC0V5+kfB2j5pZnx9k64GQbO53whlwEHa5XBtky/kqoyouNbC?=
 =?us-ascii?Q?8h0fj0DLpo5YnzkNvY6qJLjROTzaakEY?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0qAbv+Qch0JsTy/jxjDzjiRlgsXwUUonx8LJDeG3Vbl3Th9uwsz2qR0h/aHTUo0ijgAL+CSIfw/oWzCYlsRzvhWwv6ZU2pxis9X7krW5EvfTTnXuqXQspTNXR18uOrANWmZzgqx1SkePiscw1gJy9tSwPfMRCu0SaotWZ9fALTpqmQWQeD6+2M7ZmoDZRBXVj4CcbxueTbqp0daB49Wq0wC+sphYN2vLt2cwPDcUuEOZRw7cNXFfTqFkhjfxjkb5v5xu1sHgXdlD3Ng1P4QHCvbgigpacvqVdvMJQUn7jAEdq5EjlH9w+h8vYAvdPJCG9N0m8cpnqc3QS+cP7Ckr5zmouvB1jM/GButruHvdvlKtjbKRwsJ5yArtUe7Bgtw4A7z+nSs3N18FqtgfWB1nM3EWNfqCugN+wIDP1cpW6v3vLwPRa7wklCia6PP5IZaYPeVq8przcMunD6p60UZoJ3wn6HH7WxiraaOXRK/jM6BII21j6mE3WMeNqmezG4+nUWUP1Jv5mphrB4AV3Mof8NVYTfgDPXNSyX/4b68zqmk99j0e8fAODXhyj8Z+6d6ZeUl3NO6KAznsR2dNNIh+3P7ZKzka2/o/njLW7dtPihX019rum5RkEZqwd5daAsJd
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:53:30.5038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5c9f7a-1a58-4cdf-9772-08dcb566c100
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7295
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

Implements the new hashing API in the nettle hash driver.
Supports creating/destroying a context, updating the context
with input data and obtaining an output hash.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-nettle.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index dbf1d96dfe..643f3d68b8 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "crypto/hash.h"
 #include "hashpriv.h"
+#include <gnutls/crypto.h>
 #include <nettle/md5.h>
 #include <nettle/sha.h>
 #include <nettle/ripemd160.h>
@@ -105,7 +106,85 @@ gboolean qcrypto_hash_supports(QCryptoHashAlgorithm alg)
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
+int qcrypto_nettle_hash_free(QCryptoHash *hash)
+{
+    union qcrypto_hash_ctx *ctx = hash->opaque;
+
+    g_free(ctx);
+    g_free(hash);
+
+    return 0;
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
+    .hash_new      = qcrypto_nettle_hash_new,
+    .hash_free     = qcrypto_nettle_hash_free,
+    .hash_update   = qcrypto_nettle_hash_update,
+    .hash_finalize = qcrypto_nettle_hash_finalize
 };
-- 
2.34.1


