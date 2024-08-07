Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B88C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjg-0006aK-7y; Wed, 07 Aug 2024 15:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjR-00069M-Lc; Wed, 07 Aug 2024 15:54:02 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjP-00020B-Dw; Wed, 07 Aug 2024 15:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060439; x=1754596439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TuMPf6/LLf4Mzv5FzQ3tLLQAiSRSY4I0dNxCq32DUQA=;
 b=KmK8zWFcVQXvMC9A3jvELfXjnMI2HCyX4Q8QVegZiq2WEfVNlgED11Uo
 vRsKi1rO0MVVfKLUH4heSQLNzpJPzJoQd7H1Jr7WQv8bFcfalYAbuEHxa
 m9PFMJyBrHK5pGg6cWghBT7gWITCQanBvyydUGVP+/k38O5/QsAgsNVMS I=;
X-CSE-ConnectionGUID: LRYR6gWnTYyvaZ0eUFr46A==
X-CSE-MsgGUID: 4JlBm6a7RCa1kNL90O27yQ==
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9pn0YMGgSpRtwpB84JjzXPcOnT/MJpyPWNweZCu/jO0SvXhdaKQr58FNvMZxiQTZH1FUIrhhZaK3kYK66YzOrIxL2ktmws/kY/erNqqgdZoTf5c0yqL+sBm0FiEzKNm2WuaoAd+0vVpm/3cm6KYTgGpzg058H8UMsAncEBkYK6HyBVX/C6FB0jcmDd58V6LL1kmKfYuUsH6zlub9dpiwvwC+luYT5aoftcNpv0+IyIOMa35F3w+i1PD6Sn1o3hUB7LfN6P4IOoJomhQV1cevsQ19OG6e2H0zxd8La0ywU8V9lCHw/1L6qkDbHMusIrIxotJchAtXR7q+v3vjTmgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO1IU54H8vQK0dXuyDOjclGCiyTYYeFW2YISuKH4O9E=;
 b=vgu2ztNWnXmHyXR48UAmnbqR2/aplvHTU6qk9eJbU5bZ4na7u37ERKeodPr0c0FSrWVIIMpWhNWHsG0owWDaY/HwBjlZmYcqwkLU7FfY5Rk0X6A/c4JeddvhGDtgHk/AMG9IPzmgJYq2IexkWtwYI0OYA9AD1Rk3sVRuF4h/gyXNiH8093pvKy3+mDxiT2JNk6qO2CSD3Xco2C0O2rPCZtfwnj77R7DsBWkC3rjfRc72UO+e2w8Ywf0RK9/tCHMf4k4pZDH68AWVAAKmLmQLbvtiEHOl3RmHvz78wRyipOV4aXU94xnRJmhXYo0PIIBF3/jbaucHULOWJ50y+2+PEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO1IU54H8vQK0dXuyDOjclGCiyTYYeFW2YISuKH4O9E=;
 b=EZ/y588fC1BZ8HGoJFaKKZ4hn1xlkzWdwkZK+0XDN9fkrSdYFY2XcrdA5fGk/a59MBEN60nCbOvk21hcd0HgwVG5wJx0PIP8/eHSYunVcz0xJmBcamQhVRGyU6pwxYE29+qmjDuPBHcoCbPXsvwl+Or4SLXPpAnF6G9+lzWQKAc=
Received: from CYZPR20CA0006.namprd20.prod.outlook.com (2603:10b6:930:a2::28)
 by IA1PR20MB4876.namprd20.prod.outlook.com (2603:10b6:208:3e4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 19:53:52 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::51) by CYZPR20CA0006.outlook.office365.com
 (2603:10b6:930:a2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 7 Aug 2024 19:53:50 +0000
X-CSE-ConnectionGUID: GPdMGsk/S7Gc+zbwzy7UsA==
X-CSE-MsgGUID: xd9NqDviQUeb3Q9Jc3J91A==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:41 -0700
X-CSE-ConnectionGUID: UBrA4w9rR+qqzdh3R1dPOg==
X-CSE-MsgGUID: tHnGkgjmT+WlpI/c5WYodA==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235464"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:34 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 06/15] crypto/hash-afalg: Implement new hash API
Date: Wed,  7 Aug 2024 19:51:13 +0000
Message-Id: <20240807195122.2827364-7-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
References: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|IA1PR20MB4876:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 87b21e79-7d5d-48e0-c863-08dcb71aa94e
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kk/P4q6zrSu80C8wFKL3s18kX1CntKIzaTOEAbT5eqzlmknbXd/FQLNnmUKf?=
 =?us-ascii?Q?ZpOV5F88XKGt6A5En2LkuNToUF9aKa+ynhUpJXoASJ+8rv42zj5VJA6VnOJK?=
 =?us-ascii?Q?LKMKxjeaQxNvuJ22YI7jZXEB6X6bZX3imuOEJe2IdRDx/3VhPHaJG/v1doKs?=
 =?us-ascii?Q?Ir2ONu5Tj753lgCx6HYIsBl30PH/6ifIroDQrWXYam5sxGgEfIn28WRrd8oY?=
 =?us-ascii?Q?gU37iMVXcaG2frDk1vD++kQa9dN0EZYx+cew2b5goii/q1QXic/juE0wyfTo?=
 =?us-ascii?Q?nIuiZS1POyrPAYnZEpqchZ7/MzKUwNoQNyJslWiR/OOddnmokRVWbBwbu7vG?=
 =?us-ascii?Q?Fq7JmJLBxHBUN5OLEGyye/y7bmkxY1NlfhBgGVCSq08z3z1c5MhYBhPrSTh5?=
 =?us-ascii?Q?brFoMyipfoqi8aT0VtzSHych9eM3QXo/j6jcGda/0pZxdEMl4QIWCg0MWpPL?=
 =?us-ascii?Q?uYDEiV+eJ1cvhGo37/zyKyWagvmrCi3BAnomIIKt0ckUg7s4zMP5SXdOyM8E?=
 =?us-ascii?Q?+y5MrxvQb9zLTajEsdmXIZI3gwyNCSHElFIzt1Rwm81+o+u93XY2QflPF+uF?=
 =?us-ascii?Q?WcFAcS2YNII4KxtRw3TdkzADuRdrva78/4690bJBzllLpwtqlFjZys3EI7yS?=
 =?us-ascii?Q?N8UXRklnHWigehDpkVVPX7a36URmZ17OieIV1xIam2EYFd2TcNIqFBOmmmee?=
 =?us-ascii?Q?unTyhWrOMwjRrUrYO+lzmjm62lfsPA0QVfSpaAeEqeYk71I87bPHUCo32ESg?=
 =?us-ascii?Q?ZxezX54ThsFEqt9lb1XtJAdkVTGorceikzjX70QfReUQBqQWsoH/xurwirI5?=
 =?us-ascii?Q?aCPF8O/JZ58jpLyYshCLvh9AGgmtyQgIbpsl7/ZStrNTf2dhdWn1brwt86Et?=
 =?us-ascii?Q?SFOqB916dDIj8VrfdC+8slZ8P1be02k4fCcuARLsCGrf5Bh6rTbRBmmJMbZs?=
 =?us-ascii?Q?mQeZS829UEA+hitGkf0EbQjWXOVz9RViTjij0IULsiuDhx1LO7N7saUiUZbd?=
 =?us-ascii?Q?GwWZTG3mCBF77dK9F6pj+s3uk86n/ZDlOWV47OzrPm3wOomxyN1H2e1dG7XR?=
 =?us-ascii?Q?uf5j/+Qf/oj2aQ0Bu3M9DESwbwRbfKuaWDAd2DD02V3+f33lIveRGLYCCD0X?=
 =?us-ascii?Q?ADftEvgxomPWKrmXZ010Jb4JV91tINrzjCLMMp+UppZsGHGcTgAzZBdWIyPl?=
 =?us-ascii?Q?N/If34g4quqis0huI6/oWmw5Hxvr8FN3F6Zhznrkt27VshC4XIL5HZEbyzuh?=
 =?us-ascii?Q?ELRatC/wb3ozzG39ZefNk+fu7l3W3Cmj/5iIZawnTWLKPB9WZxxk/QU0i3sW?=
 =?us-ascii?Q?6vKkjuHyQRG5yqk9UAILdwf9EPOgtS8K9wDxeSPWaO/nmR0lopthn8skjDME?=
 =?us-ascii?Q?eej4EDsPxPjiO8F8y/f4R3c42XAOQhqaqovTkefP6JIltA+6OmeFu6jgcQIo?=
 =?us-ascii?Q?58koLjTRxZEd/QNq+aTpbEnf2WOjjv88?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sbSBDt5A2A1SUYkct7fh4k/tauDfFKieDEqLYavSb8VKZfXk0hSZyN5CL86q0ZL8ChcHx1/pSHDefPx10kn24GfAKmQbIprqoJj1RetdrNeip1dePAFMwe9Cyo44vdTJU3woSNfoU4PhDm6ab3SUrTEtDU/awqL8qhshZpHsetdqxWdsQ/eLq1BlkzzY2YTOoDa2wRl+EpaErJQq88DpMs27J750CZp51BOIE2HOBrWkB329Pwgz0u4Vxg9XQIlOJPFjJpp12DA4FlRIpske9liXyE3XOI8viG8qdvPk6C7YJRzx1olqc+JDgsrMsuTA2XXEYZoPlSPIkFgEECtagNT0f+KbYm4DtVkFJqlnuZRTHjJW3wb/UWIaVDuj6ywpw04K+XEcnCXb2C9uS5rIkXVgbYj0SrAdudsq9cZPAL6hbrLm7QJxF1eaifL5kl7PfhobNjE3S/U1AcopN3VQjVL0q3Wncl/8O+ZruLnjoNd8RmfZfLIxCWifUMDaBnU4klMAZpL4oNnVuTMjWFOOyfkz+GdVdmyyT507t2u07dEODxST496CphOEzRTZcHd6FQ7zlBz6GpGoWUphB0bhKHPupA4uH2agA6SJvnrLqJlGqj+6jOC/F6HYqrMNUZYo
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:50.9813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b21e79-7d5d-48e0-c863-08dcb71aa94e
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB4876
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

Updates the afalg hash driver to support the new accumulative
hashing changes as part of the patch series.

Implements opening/closing of contexts, updating hash data
and finalizing the hash digest.

In order to support the update function, a flag needs to be passed
to the kernel via the socket send call (MSG_MORE) to notify it that more
data is to be expected to calculate the hash correctly.
As a result, a new function was added to the iov helper utils to allow
passing a flag to the socket send call.

Signed-off-by: Alejandro Zeise <alejandro.zeise@seagate.com>
---
 crypto/hash-afalg.c | 126 ++++++++++++++++++++++++++++++++++++++++++++
 include/qemu/iov.h  |  26 +++++++++
 util/iov.c          |  22 +++++---
 3 files changed, 167 insertions(+), 7 deletions(-)

diff --git a/crypto/hash-afalg.c b/crypto/hash-afalg.c
index 3ebea39292..9548c04933 100644
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
@@ -113,6 +114,127 @@ qcrypto_afalg_hmac_ctx_new(QCryptoHashAlgorithm alg,
     return qcrypto_afalg_hash_hmac_ctx_new(alg, key, nkey, true, errp);
 }
 
+static
+QCryptoHash *qcrypto_afalg_hash_new(QCryptoHashAlgorithm alg, Error **errp)
+{
+    /* Check if hash algorithm is supported */
+    char *alg_name = qcrypto_afalg_hash_format_name(alg, false, NULL);
+    QCryptoHash *hash = NULL;
+
+    if (alg_name == NULL) {
+        error_setg(errp,
+                   "Unknown hash algorithm %d",
+                   alg);
+    } else {
+        hash = g_new(QCryptoHash, 1);
+        hash->alg = alg;
+        hash->opaque = qcrypto_afalg_hash_ctx_new(alg, errp);
+    }
+
+    return hash;
+}
+
+static
+void qcrypto_afalg_hash_free(QCryptoHash *hash)
+{
+    QCryptoAFAlg *ctx = hash->opaque;
+
+    if (ctx) {
+        qcrypto_afalg_comm_free(ctx);
+    }
+
+    g_free(hash);
+}
+
+/**
+ * Send data to the kernel's crypto core.
+ *
+ * The more_data parameter is used to notify the crypto engine
+ * that this is an "update" operation, and that more data will
+ * be provided to calculate the final hash.
+ */
+static
+int qcrypto_afalg_send_to_kernel(QCryptoAFAlg *afalg,
+                                 const struct iovec *iov,
+                                 size_t niov,
+                                 bool more_data,
+                                 Error **errp)
+{
+    int ret = 0;
+    int flags = (more_data ? MSG_MORE : 0);
+
+    /* send data to kernel's crypto core */
+    ret = iov_send_recv_with_flags(afalg->opfd, flags, iov, niov,
+                                   0, iov_size(iov, niov), true);
+    if (ret < 0) {
+        error_setg_errno(errp, errno, "Send data to afalg-core failed");
+        ret = -1;
+    } else {
+        /* No error, so return 0 */
+        ret = 0;
+    }
+
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
+            ret = -1;
+        } else {
+            ret = 0;
+        }
+    }
+
+    return ret;
+}
+
+static
+int qcrypto_afalg_hash_update(QCryptoHash *hash,
+                              const struct iovec *iov,
+                              size_t niov,
+                              Error **errp)
+{
+    return qcrypto_afalg_send_to_kernel((QCryptoAFAlg *) hash->opaque,
+                                        iov, niov, true, errp);
+}
+
+static
+int qcrypto_afalg_hash_finalize(QCryptoHash *hash,
+                                 uint8_t **result,
+                                 size_t *result_len,
+                                 Error **errp)
+{
+    return qcrypto_afalg_recv_from_kernel((QCryptoAFAlg *) hash->opaque,
+                                          hash->alg, result, result_len, errp);
+}
+
 static int
 qcrypto_afalg_hash_hmac_bytesv(QCryptoAFAlg *hmac,
                                QCryptoHashAlgorithm alg,
@@ -205,6 +327,10 @@ static void qcrypto_afalg_hmac_ctx_free(QCryptoHmac *hmac)
 
 QCryptoHashDriver qcrypto_hash_afalg_driver = {
     .hash_bytesv = qcrypto_afalg_hash_bytesv,
+    .hash_new      = qcrypto_afalg_hash_new,
+    .hash_free     = qcrypto_afalg_hash_free,
+    .hash_update   = qcrypto_afalg_hash_update,
+    .hash_finalize = qcrypto_afalg_hash_finalize
 };
 
 QCryptoHmacDriver qcrypto_hmac_afalg_driver = {
diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index 63a1c01965..43884cdd64 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -1,6 +1,7 @@
 /*
  * Helpers for using (partial) iovecs.
  *
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  * Copyright (C) 2010 Red Hat, Inc.
  *
  * Author(s):
@@ -75,6 +76,31 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
 size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
                   size_t offset, int fillc, size_t bytes);
 
+/*
+ * Send/recv data from/to iovec buffers directly, with the provided
+ * socket flags.
+ *
+ * `offset' bytes in the beginning of iovec buffer are skipped and
+ * next `bytes' bytes are used, which must be within data of iovec.
+ *
+ *   r = iov_send_recv_with_flags(sockfd, sockflags, iov, iovcnt, offset, bytes, true);
+ *
+ * is logically equivalent to
+ *
+ *   char *buf = malloc(bytes);
+ *   iov_to_buf(iov, iovcnt, offset, buf, bytes);
+ *   r = send(sockfd, buf, bytes, sockflags);
+ *   free(buf);
+ *
+ * For iov_send_recv_with_flags() _whole_ area being sent or received
+ * should be within the iovec, not only beginning of it.
+ */
+ssize_t iov_send_recv_with_flags(int sockfd, int sockflags,
+                                 const struct iovec *iov,
+                                 unsigned iov_cnt, size_t offset,
+                                 size_t bytes,
+                                 bool do_send);
+
 /*
  * Send/recv data from/to iovec buffers directly
  *
diff --git a/util/iov.c b/util/iov.c
index 7e73948f5e..5644e0b73c 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -3,6 +3,7 @@
  *
  * Copyright IBM, Corp. 2007, 2008
  * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2024 Seagate Technology LLC and/or its Affiliates
  *
  * Author(s):
  *  Anthony Liguori <aliguori@us.ibm.com>
@@ -92,7 +93,7 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt)
 
 /* helper function for iov_send_recv() */
 static ssize_t
-do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
+do_send_recv(int sockfd, int flags, struct iovec *iov, unsigned iov_cnt, bool do_send)
 {
 #ifdef CONFIG_POSIX
     ssize_t ret;
@@ -102,8 +103,8 @@ do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
     msg.msg_iovlen = iov_cnt;
     do {
         ret = do_send
-            ? sendmsg(sockfd, &msg, 0)
-            : recvmsg(sockfd, &msg, 0);
+            ? sendmsg(sockfd, &msg, flags)
+            : recvmsg(sockfd, &msg, flags);
     } while (ret < 0 && errno == EINTR);
     return ret;
 #else
@@ -114,8 +115,8 @@ do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
     ssize_t off = 0;
     while (i < iov_cnt) {
         ssize_t r = do_send
-            ? send(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, 0)
-            : recv(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, 0);
+            ? send(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, flags)
+            : recv(sockfd, iov[i].iov_base + off, iov[i].iov_len - off, flags);
         if (r > 0) {
             ret += r;
             off += r;
@@ -144,6 +145,13 @@ do_send_recv(int sockfd, struct iovec *iov, unsigned iov_cnt, bool do_send)
 ssize_t iov_send_recv(int sockfd, const struct iovec *_iov, unsigned iov_cnt,
                       size_t offset, size_t bytes,
                       bool do_send)
+{
+    return iov_send_recv_with_flags(sockfd, 0, _iov, iov_cnt, offset, bytes, do_send);
+}
+
+ssize_t iov_send_recv_with_flags(int sockfd, int sockflags, const struct iovec *_iov,
+                                 unsigned iov_cnt, size_t offset, size_t bytes,
+                                 bool do_send)
 {
     ssize_t total = 0;
     ssize_t ret;
@@ -192,11 +200,11 @@ ssize_t iov_send_recv(int sockfd, const struct iovec *_iov, unsigned iov_cnt,
             assert(iov[niov].iov_len > tail);
             orig_len = iov[niov].iov_len;
             iov[niov++].iov_len = tail;
-            ret = do_send_recv(sockfd, iov, niov, do_send);
+            ret = do_send_recv(sockfd, sockflags, iov, niov, do_send);
             /* Undo the changes above before checking for errors */
             iov[niov-1].iov_len = orig_len;
         } else {
-            ret = do_send_recv(sockfd, iov, niov, do_send);
+            ret = do_send_recv(sockfd, sockflags, iov, niov, do_send);
         }
         if (offset) {
             iov[0].iov_base -= offset;
-- 
2.34.1


